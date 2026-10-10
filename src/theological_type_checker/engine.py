"""Solve the rule base and summarise what came out.

The rule base is six answer-set programs in ``lp/``. A *part* is a
``#program`` block (a model, a historical case, a policy switch or a
candidate rule); a run grounds the base plus the parts it names, and,
optionally, a snippet of extra facts written by the caller.

Everything here is deterministic: the same files, parts and snippet always
give the same answer.
"""
from __future__ import annotations

import contextlib
import contextvars
import json
import os
import pathlib
import re
from typing import Iterable

import clingo

LP_DIR = pathlib.Path(__file__).resolve().parent / "lp"
FILES = ["icon_core.lp", "icon_analogy.lp", "icon_models.lp", "icon_tests.lp",
         "icon_authority.lp", "icon_history.lp", "canon_law.lp", "canon_cases.lp", "pair.lp", "library.lp"]

# Rule-base overrides for the "fix method": text added to the base, and
# lines (exact substrings) commented out. Scoped with rule_change().
_ADD: contextvars.ContextVar[str] = contextvars.ContextVar("ttc_add", default="")
_REMOVE: contextvars.ContextVar[tuple] = contextvars.ContextVar("ttc_remove", default=())


class SnippetError(ValueError):
    """A caller-supplied snippet uses a directive that is not allowed."""


# clingo can embed Python (#script) and read files (#include); a snippet
# from an MCP client must be data and rules only.
_FORBIDDEN = re.compile(r"#\s*(script|include|program|end)\b|@[A-Za-z_]", re.I)
MAX_SNIPPET = 100_000


def check_snippet(text: str) -> str:
    text = text or ""
    if len(text) > MAX_SNIPPET:
        raise SnippetError(f"snippet longer than {MAX_SNIPPET} characters")
    m = _FORBIDDEN.search(re.sub(r"%.*", "", text))
    if m:
        raise SnippetError(f"directive not allowed in a snippet: {m.group(0)!r}")
    return text


def ttc_home() -> pathlib.Path | None:
    """The personal layer: rules, cases and tests that grow with use.

    TTC_HOME set to a path uses that folder; set but empty disables the
    layer; unset uses ~/.ttc if that folder exists.
    """
    v = os.environ.get("TTC_HOME")
    if v is not None:
        return pathlib.Path(v).expanduser() if v.strip() else None
    d = pathlib.Path("~/.ttc").expanduser()
    return d if d.is_dir() else None


def personal_rule_files() -> list[pathlib.Path]:
    home = ttc_home()
    if not home or not (home / "rules").is_dir():
        return []
    return sorted((home / "rules").glob("*.lp"))


def personal_scenarios_raw() -> list[dict]:
    home = ttc_home()
    f = home / "scenarios.json" if home else None
    if not f or not f.is_file():
        return []
    return json.loads(f.read_text())


def base_texts() -> dict[str, str]:
    """The rule files as they will be grounded, with any removals applied."""
    texts = {f: (LP_DIR / f).read_text() for f in FILES}
    for f in personal_rule_files():
        texts[f"personal/{f.name}"] = f.read_text()
    for needle in _REMOVE.get():
        hits = [(f, i) for f, t in texts.items() for i, line in enumerate(t.splitlines()) if needle in line]
        if len(hits) != 1:
            raise SnippetError(f"removal must match exactly one line, matched {len(hits)}: {needle!r}")
        f, i = hits[0]
        lines = texts[f].splitlines()
        lines[i] = "% removed by rule_change: " + lines[i]
        texts[f] = "\n".join(lines) + "\n"
    return texts


@contextlib.contextmanager
def rule_change(add: str = "", remove: Iterable[str] = ()):
    """Temporarily add rules to, or comment lines out of, the rule base."""
    t1 = _ADD.set(check_snippet(add))
    t2 = _REMOVE.set(tuple(remove))
    try:
        base_texts()                       # validate removals up front
        yield
    finally:
        _ADD.reset(t1)
        _REMOVE.reset(t2)


def known_parts() -> dict[str, str]:
    """Every #program name in the rule base, with the file it lives in."""
    out = {}
    for f, t in base_texts().items():
        for m in re.finditer(r"^#program\s+(\w+)\s*\.", t, re.M):
            out.setdefault(m.group(1), f)
    return out


def solve(parts, mode="one", facts="", max_models=0, timeout=None, show=()):
    """Ground the base plus `parts` (and an optional snippet) and solve.

    mode: "one" (last model), "all"/"branches" (every stable model),
          "opt" (optimal models of a #minimize/#maximize part).
    """
    parts = list(parts)
    unknown = [p for p in parts if p not in known_parts()]
    if unknown:
        raise SnippetError(f"unknown part(s): {', '.join(unknown)}")
    facts = check_snippet(facts)
    nmodels = {"one": [], "all": [f"--models={max_models}"], "branches": [f"--models={max_models}"],
               "opt": ["--opt-mode=opt"]}[mode]
    logs = []
    ctl = clingo.Control(nmodels, logger=lambda code, msg: logs.append(msg))
    for f, text in base_texts().items():
        ctl.add("base", [], text)
    extra = _ADD.get()
    if extra:
        ctl.add("base", [], extra)
    if show:
        ctl.add("base", [], " ".join(f"#show {s}." for s in show))
    try:
        if facts:
            ctl.add("user", [], facts)
        ctl.ground([("base", [])] + [(p, []) for p in parts] + ([("user", [])] if facts else []))
    except RuntimeError as exc:
        errors = [m.strip() for m in logs if "error" in m.lower()] or [str(exc)]
        raise SnippetError("clingo could not ground the program: " + " | ".join(errors[:5])) from None
    out = {"models": 0, "atoms": [], "cost": None, "all_models": [], "truncated": False}

    def on_model(m):
        out["models"] += 1
        out["atoms"] = sorted(str(s) for s in m.symbols(shown=True))
        out["all_models"].append(out["atoms"])
        out["cost"] = list(m.cost)

    if timeout:
        with ctl.solve(on_model=on_model, async_=True) as h:
            if not h.wait(timeout):
                h.cancel()
                out["truncated"] = True
            res = h.get()
    else:
        res = ctl.solve(on_model=on_model)
    out["sat"] = bool(res.satisfiable)
    if max_models and out["models"] >= max_models and not res.exhausted:
        out["truncated"] = True
    out["_parts"] = parts
    out["_facts"] = facts
    if mode == "branches":
        out["branches"] = summarize_branches(out["all_models"])
    out["violations"] = [a[len("violation("):-1] for a in out["atoms"] if a.startswith("violation(")]
    out["theorems"] = [a[len("theorem("):-1] for a in out["atoms"] if a.startswith("theorem(")]
    out["info"] = [a[len("info("):-1] for a in out["atoms"] if a.startswith("info(")]
    out["verdicts"] = {}
    for a in out["atoms"]:
        if a.startswith("verdict("):
            subj, _, val = a[len("verdict("):-1].rpartition(",")
            out["verdicts"][subj] = val
    return out


# ---------- branches: one stable model per branch ---------------------
def split_args(atom):
    """'holds(q(ic),yes)' -> ('holds', ['q(ic)', 'yes'])"""
    if "(" not in atom:
        return atom, []
    name, body = atom.split("(", 1)
    body, args, depth, cur, in_str, prev = body[:-1], [], 0, "", False, ""
    for ch in body:
        if ch == '"' and prev != "\\":
            in_str = not in_str
        if ch == "," and depth == 0 and not in_str:
            args.append(cur)
            cur = ""
            prev = ch
            continue
        if not in_str:
            depth += ch == "("
            depth -= ch == ")"
        cur += ch
        prev = ch
    args.append(cur)
    return name, args


def summarize_branches(models):
    branches = []
    for atoms in models:
        b = {"values": [], "status": None, "cleaved": [], "reint": [], "w": {3: 0, 4: 0, 5: 0},
             "t2": False, "facts": [], "assume": []}
        for a in atoms:
            name, args = split_args(a)
            if name in ("read_as", "oum_holds", "assumed_fact"):
                b["assume"].append(a)
            if name == "holds":
                b["values"].append(f"{args[0]}={args[1]}")
            elif name == "branch":
                b["status"] = args[0]
            elif name == "cleaved_by":
                b["cleaved"].append(args[0])
            elif name == "reintegrates_if_relaxed":
                b["reint"].append(args[0])
            elif name == "weight":
                b["w"][int(args[0])] = int(args[1])
            elif name == "t2_truth":
                b["t2"] = True
            elif name in ("violation", "info", "verdict", "theorem"):
                b["facts"].append(a)
        branches.append(b)
    return branches


def classify(r, qv):
    """settled | open | shadow | excluded, for one question=value."""
    bs = r["branches"]
    mains = [b for b in bs if b["status"] == "main"]
    have = [b for b in bs if qv in b["values"]]
    if not have:
        return "excluded"
    main_have = [b for b in mains if qv in b["values"]]
    if main_have and len(main_have) == len(mains):
        return "settled"
    if main_have:
        return "open"
    return "shadow"


def preferred_value(r, question):
    mains = [b for b in r["branches"] if b["status"] == "main"]
    if not mains:
        return "no main branch"
    key = lambda b: (b["w"][3], b["w"][4], b["w"][5])
    best = min(key(b) for b in mains)
    winners = sorted({v for b in mains if key(b) == best for v in b["values"] if v.startswith(question + "=")})
    return winners[0].split("=", 1)[1] if len(winners) == 1 else "tie"


# ---------- static crossing check (A11) ---------------------------------
CHECK_HEADS = ("violation", "crosses", "info", "theorem", "verdict")
ROUTES = ("licensed", "mode", "bridge")
LINT_FILES = ["icon_core.lp", "icon_analogy.lp", "icon_authority.lp"]


def lint(extra=""):
    """Flag rules whose positive body mixes divine- and creature-sorted
    predicates without routing through licensed/mode/bridge."""
    texts = base_texts()
    sorts = dict(re.findall(r"sort_of\((\w+),(\w+)\)", texts["icon_analogy.lp"]))
    text = "\n".join(texts[f] for f in LINT_FILES) + "\n" + _ADD.get() + "\n" + check_snippet(extra)
    text = re.sub(r"%.*", "", text)
    findings = []
    for stmt in re.split(r"\.\s*(?=\n|$)", text):
        if ":-" not in stmt or stmt.strip().startswith("#"):
            continue
        head, body = stmt.split(":-", 1)
        head = head.strip()
        if not head or head.startswith(CHECK_HEADS):
            continue
        positive = [m.group(1) for m in re.finditer(r"(?<![\w])(?<!not )(\w+)\(", body)]
        positive = [p for p in positive if not re.search(r"not\s+" + p + r"\(", body)]
        kinds = {sorts.get(p) for p in positive}
        if "div" in kinds and "cr" in kinds and not any(p in ROUTES for p in positive):
            findings.append(" ".join(stmt.split()))
    return findings



# ---------- digest for people and models -------------------------------------
def summary(r, max_branches=30):
    """A readable digest of a branches run: per question=value status, what holds
    in every branch or only some, and the branches themselves."""
    bs = r.get("branches") or []
    out = {"satisfiable": r["sat"], "stable_models": r["models"], "truncated": r["truncated"]}
    if not r["sat"]:
        out["note"] = "No stable model: the facts are inconsistent with a hard constraint (often a tier-1 text or a fixed reading)."
        return out
    qvals = {}
    for b in bs:
        for v in b["values"]:
            q, val = v.split("=", 1)
            qvals.setdefault(q, set()).add(val)
    # every value the base declares, so excluded ones show up too
    for m in r["all_models"][:1]:
        for a in m:
            if a.startswith("value("):
                _, (q, val) = split_args(a)
                if q in qvals:
                    qvals[q].add(val)
    questions = {}
    for q, vals in sorted(qvals.items()):
        questions[q] = {"values": {v: classify(r, f"{q}={v}") for v in sorted(vals)},
                        "preferred_by_weight": preferred_value(r, q)}
    facts = [set(b["facts"]) for b in bs] or [set()]
    every = set.intersection(*facts)
    some = set.union(*facts) - every
    out["questions"] = questions
    out["in_every_branch"] = sorted(every)
    out["in_some_branches"] = sorted(some)
    order = {"main": 0, "live_shadow": 1, "counterfactual_shadow": 2, None: 3}
    shown = sorted(bs, key=lambda b: (order.get(b["status"], 3), b["w"][3], b["w"][4], b["w"][5]))[:max_branches]
    out["branches"] = [{
        "status": b["status"] or "n/a (no questions in this run)",
        "values": sorted(b["values"]),
        "assumptions": sorted(b["assume"]),
        "cleaved_by": sorted(b["cleaved"]),
        "reintegrates_if_relaxed": sorted(b["reint"]),
        "disagreement_weight": {f"tier{k}": v for k, v in b["w"].items()},
        "only_here": sorted(set(b["facts"]) - every),
    } for b in shown]
    out["branches_total"] = len(bs)
    if r.get("cost"):
        out["optimization_cost"] = r["cost"]
    return out



def run_checked(parts, facts="", max_models=20000, timeout_s=60.0, optimize=False):
    mode = "opt" if optimize else "branches"
    return solve(parts, mode, facts=facts, max_models=max_models, timeout=timeout_s, show=("value/2",))
