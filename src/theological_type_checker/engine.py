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
import hashlib
import json
import os
import pathlib
import re
from typing import Iterable

import clingo
from clingo import ast as _ast

LP_DIR = pathlib.Path(__file__).resolve().parent / "lp"
FILES = ["kernel_core.lp", "kernel_analogy.lp", "icon_theory.lp", "icon_models.lp", "icon_tests.lp", "icon_metaphysics.lp", "schools.lp", "kernel_world.lp",
         "icon_authority.lp", "icon_history.lp", "act.lp", "law.lp", "moral.lp", "grace.lp", "christ.lp", "sacrament.lp", "faith.lp", "canon_law.lp", "canon_cceo.lp", "canon_cases.lp", "pair.lp", "library.lp", "saeculum.lp", "sources.lp", "liturgy.lp", "novissima.lp", "empirica.lp", "linguae.lp"]

# School runtimes (docs/research/schools-preregistration.md): named lists of
# parts, loaded whole. A scenario names one as the part "rt_<name>", or two for
# a pair; naming none runs it on "default". "rt_bare" loads no runtime at all.
# Declared in L (l/schools.l: `runtime`, by inheritance; TTC-L, RU) and
# compiled to runtimes.json, which is read here.
RUNTIMES: dict[str, list[str]] = json.loads(
    (pathlib.Path(__file__).resolve().parent / "runtimes.json").read_text())["runtimes"]


def is_runtime(part: str) -> bool:
    return part.startswith("rt_") and part[3:] in RUNTIMES


def expand_runtimes(parts) -> list[str]:
    """The parts to ground: the named runtimes' parts (default if none), then the rest."""
    named = [p[3:] for p in parts if is_runtime(p)] or ["default"]
    rest = [p for p in parts if not is_runtime(p)]
    return list(dict.fromkeys([q for r in named for q in RUNTIMES[r]] + rest))


# Rule-base overrides for the "fix method": text added to the base, and
# lines (exact substrings) commented out. Scoped with rule_change().
_ADD: contextvars.ContextVar[str] = contextvars.ContextVar("ttc_add", default="")
_REMOVE: contextvars.ContextVar[tuple] = contextvars.ContextVar("ttc_remove", default=())


SCHEMA = 2     # the shape of check's summary; raised whenever the shape changes (2: premises)

REFUSAL_FIELDS = ("refused", "gate", "where", "line", "column", "predicate", "text", "message")
REFUSAL_GATES = {
    "parts": "a part or runtime the base does not have",
    "snippet": "a directive a snippet may not use, or a snippet too long",
    "removal": "a line to remove that matches no line, or more than one",
    "parse": "clingo cannot parse the text",
    "ground": "clingo cannot ground the text (most often an unsafe variable)",
    "layer": "a fact on the wrong side of a case (house rule 1)",
    "conclusion": "a head, or a constraint, on what the base concludes: premises only (TTC-L CG)",
    "input": "an argument the tool cannot take",
}


class SnippetError(ValueError):
    """A run refused before it is solved. The fields say where: the gate (one
    of REFUSAL_GATES); the text refused (facts, add_rules, remove_lines,
    parts, or a side of a case); the line and column in it; the predicate
    of the statement there, when it can be read; the line itself; and the
    message."""

    def __init__(self, message, gate="snippet", where=None, line=None, column=None, predicate=None, text=None):
        super().__init__(message)
        self.message, self.gate, self.where = message, gate, where
        self.line, self.column, self.predicate, self.text = line, column, predicate, text

    def as_dict(self) -> dict:
        return {"refused": True, "gate": self.gate, "where": self.where, "line": self.line,
                "column": self.column, "predicate": self.predicate, "text": self.text, "message": self.message}


def stable(obj):
    """The same object with every mapping's keys in sorted order, so that it
    serialises the same way on every path (the stdio server, in process)."""
    if isinstance(obj, dict):
        return {k: stable(obj[k]) for k in sorted(obj, key=str)}
    if isinstance(obj, (list, tuple)):
        return [stable(x) for x in obj]
    return obj


def dumps(obj) -> str:
    """Compact, key-sorted JSON: the canonical form of a result."""
    return json.dumps(obj, sort_keys=True, separators=(",", ":"), ensure_ascii=False)


def _line_of(text: str, n: int | None) -> str | None:
    lines = (text or "").splitlines()
    return lines[n - 1] if n and 0 < n <= len(lines) else None


# clingo can embed Python (#script) and read files (#include); a snippet
# from an MCP client must be data and rules only.
_FORBIDDEN = re.compile(r"#\s*(script|include|program|end)\b|@[A-Za-z_]", re.I)
MAX_SNIPPET = 100_000


def check_snippet(text: str, where: str = "facts") -> str:
    text = text or ""
    if len(text) > MAX_SNIPPET:
        raise SnippetError(f"snippet longer than {MAX_SNIPPET} characters", "snippet", where)
    code = re.sub(r"%.*", "", text)
    m = _FORBIDDEN.search(code)
    if m:
        line = code.count("\n", 0, m.start()) + 1
        raise SnippetError(f"directive not allowed in a snippet: {m.group(0)!r}", "snippet", where, line,
                           m.start() - (code.rfind("\n", 0, m.start()) + 1) + 1, None, _line_of(text, line))
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
            raise SnippetError(f"removal must match exactly one line, matched {len(hits)}: {needle!r}",
                               "removal", "remove_lines", text=needle)
        f, i = hits[0]
        lines = texts[f].splitlines()
        lines[i] = "% removed by rule_change: " + lines[i]
        texts[f] = "\n".join(lines) + "\n"
    return texts


@contextlib.contextmanager
def rule_change(add: str = "", remove: Iterable[str] = ()):
    """Temporarily add rules to, or comment lines out of, the rule base."""
    t1 = _ADD.set(check_snippet(add, "add_rules"))
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


# ---------- the grammar: predicates as clingo's own parser reads them ---------
_LOC = re.compile(r"<(?:block|string)>:(\d+):(\d+)(?:-[\d:]+)?: (?:error|info|warning): (.*)", re.S)
_HEAD_TEXT = re.compile(r"^\s*(?:not\s+)?([a-z_]\w*)\s*(?:\(([^()]*(?:\([^()]*\)[^()]*)*)\))?\s*(?:[.:]|$)")


def _sig(term):
    t = term.ast_type
    if t == _ast.ASTType.Function:
        return (term.name, len(term.arguments)) if term.name else None
    if t == _ast.ASTType.SymbolicTerm and term.symbol.type == clingo.SymbolType.Function:
        return (term.symbol.name, len(term.symbol.arguments))
    if t == _ast.ASTType.UnaryOperation:
        return _sig(term.argument)
    if t == _ast.ASTType.Pool and len(term.arguments):
        return _sig(term.arguments[0])
    return None


def _walk(node, mode, out, order):
    if not isinstance(node, _ast.AST):
        if isinstance(node, (str, int)) or node is None:
            return
        for n in node:                      # a sequence of nodes
            _walk(n, mode, out, order)
        return
    t = node.ast_type
    if t == _ast.ASTType.SymbolicAtom:
        s = _sig(node.symbol)
        if s:
            out[mode].add(s)
            order.append(s)
        return
    if t == _ast.ASTType.ConditionalLiteral and mode == "heads":
        _walk(node.literal, "heads", out, order)
        _walk(node.condition, "reads", out, order)
        return
    for k in node.child_keys:
        _walk(getattr(node, k), mode, out, order)


def _parse_error(text, where, logs):
    """A SnippetError at the parse gate from clingo's messages."""
    msgs = [m for m in logs if "error" in m]
    m = _LOC.match(msgs[0].strip()) if msgs else None
    line, col = (int(m.group(1)), int(m.group(2))) if m else (None, None)
    src = _line_of(text, line)
    h = _HEAD_TEXT.match(src or "")
    pred = None
    if h:
        args = h.group(2)
        pred = f"{h.group(1)}/{len(_split_args_top(args)) if args is not None else 0}"
    detail = " | ".join(x.strip() for x in msgs[:5]) or "syntax error"
    return SnippetError(f"clingo could not parse the {where}: {detail}", "parse", where, line, col, pred, src)


def _split_args_top(s):
    out, depth, cur = [], 0, ""
    for ch in s:
        depth += ch in "({["
        depth -= ch in ")}]"
        if ch == "," and depth == 0:
            out.append(cur)
            cur = ""
        else:
            cur += ch
    out.append(cur)
    return [x for x in out if x.strip()]


def signatures(text: str, where: str = "facts") -> dict:
    """The predicates a program text writes (heads), reads (bodies and
    conditions) and shows, as (name, arity), read by clingo's own parser;
    those written by a rule with a body (derived); and, for each line on
    which a statement begins, the first predicate of that statement. A text
    clingo cannot parse is refused at the parse gate."""
    out = {"heads": set(), "reads": set(), "shown": set(), "derived": set(), "at_line": {}}
    logs = []

    def on_statement(st):
        t = st.ast_type
        order = []
        if t == _ast.ASTType.Rule:
            local = {"heads": set(), "reads": set()}
            _walk(st.head, "heads", local, order)
            _walk(st.body, "reads", local, order)
            out["heads"] |= local["heads"]
            out["reads"] |= local["reads"]
            if len(st.body):
                out["derived"] |= local["heads"]
        elif t == _ast.ASTType.ShowSignature:
            out["shown"].add((st.name, st.arity))
        elif t == _ast.ASTType.External:
            _walk(st.atom, "heads", out, order)
            _walk(st.body, "reads", out, order)
        elif t in (_ast.ASTType.Program, _ast.ASTType.Definition, _ast.ASTType.Comment):
            return
        else:
            _walk(st, "reads", out, order)
        if order:
            out["at_line"].setdefault(st.location.begin.line, "%s/%d" % order[0])

    try:
        _ast.parse_string(text or "", on_statement, logger=lambda code, msg: logs.append(msg))
    except RuntimeError:
        raise _parse_error(text, where, logs) from None
    return out


_VOCAB: dict[str, dict] = {}
_TAG_INPUT = re.compile(r"^%\s*@input\s+(\w+)/(\d+)\s*\|\s*(.*)$", re.M)


def vocabulary(texts: dict[str, str] | None = None) -> dict:
    """Every predicate of the base (with the fix method's added rules): what
    it writes, reads, derives and shows, and the slots its @input tags
    declare. A snippet predicate outside it is an unknown slot."""
    texts = dict(texts if texts is not None else base_texts())
    if _ADD.get():
        texts["add_rules"] = _ADD.get()
    key = hashlib.sha256(json.dumps(sorted(texts.items())).encode()).hexdigest()
    if key not in _VOCAB:
        v = {"heads": set(), "reads": set(), "shown": set(), "derived": set(), "tagged": set()}
        for f, t in texts.items():
            s = signatures(t, f)
            for k in ("heads", "reads", "shown", "derived"):
                v[k] |= s[k]
            v["tagged"] |= {(m.group(1), int(m.group(2))) for m in _TAG_INPUT.finditer(t)}
        if len(_VOCAB) > 8:
            _VOCAB.clear()
        _VOCAB[key] = v
    return _VOCAB[key]


def unknown_slots(facts: str, sigs: dict | None = None) -> list[str]:
    """unknown_slot(name/arity) for each predicate of a snippet that the base
    neither writes, reads, shows nor declares, unless the snippet both writes
    and reads it (a helper of its own). Usually a misspelling or a wrong
    arity: the run goes on, and the fact does nothing."""
    s = sigs if sigs is not None else signatures(facts)
    v = vocabulary()
    # what L itself writes (the closed sorts' values) is no slot of a case's
    from .lang import GENERATED
    known = (v["heads"] | v["reads"] | v["shown"] | v["tagged"]) - GENERATED
    own = s["heads"] & (s["reads"] | s["shown"])
    found = (s["heads"] | s["reads"] | s["shown"]) - known - own
    return [f"unknown_slot({n}/{a})" for n, a in sorted(found)]


_CONCLUSIONS: dict[str, tuple] = {}


def _premises():
    """The slots a case may write (L), and what it may not: what the base
    derives or shows and no slot declares, a hypothetical slot, and what L
    itself writes. Cached by the vocabulary's key."""
    from . import lang
    v = vocabulary()
    key = id(v)
    if key not in _CONCLUSIONS:
        decl = lang.slots(lang.sources())
        slots = {sig for sig, d in decl.items() if "hypothetical" not in d.attrs}
        hypothetical = {sig for sig, d in decl.items() if "hypothetical" in d.attrs}
        concluded = ((v["derived"] | v["shown"]) - slots) | hypothetical | lang.GENERATED
        _CONCLUSIONS.clear()
        _CONCLUSIONS[key] = (slots, concluded, hypothetical)
    return _CONCLUSIONS[key]


_DRAWN: dict[int, dict] = {}


def drawn_from(sig, limit: int = 8) -> list[str]:
    """The slots a conclusion is drawn from: those read in the bodies of the
    rules that derive it, followed back through the predicates those rules
    derive in turn, nearest first, at most `limit`. Named in the gate's
    refusal, so that one refused knows what to write instead."""
    slots, concluded, _ = _premises()
    v = vocabulary()
    if id(v) not in _DRAWN:
        by_head: dict = {}
        for f, t in base_texts().items():
            def on(st):
                if st.ast_type == _ast.ASTType.Rule and len(st.body):
                    loc = {"heads": set(), "reads": set()}
                    _walk(st.head, "heads", loc, [])
                    _walk(st.body, "reads", loc, [])
                    for h in loc["heads"]:
                        by_head.setdefault(h, set()).update(loc["reads"])
            _ast.parse_string(t, on, logger=lambda code, msg: None)
        _DRAWN.clear()
        _DRAWN[id(v)] = by_head
    by_head = _DRAWN[id(v)]
    found, seen, frontier = [], {sig}, [sig]
    while frontier and len(found) < limit:
        nxt = []
        for p in frontier:
            for r in sorted(by_head.get(p, ())):
                if r in seen:
                    continue
                seen.add(r)
                if r in slots:
                    found.append(f"{r[0]}/{r[1]}")
                elif r in by_head:
                    nxt.append(r)
        frontier = nxt
    return found[:limit]


def premises_read(facts: str) -> dict:
    """Which of a snippet's predicates reach the base: `read`, those some
    rule of the base reads; `unread`, those neither the base nor the snippet
    itself reads. A fact under an unread predicate computes nothing."""
    if not (facts or "").strip():
        return {"read": [], "unread": []}
    s = signatures(facts)
    v = vocabulary()
    read = sorted(s["heads"] & v["reads"])
    unread = sorted(s["heads"] - v["reads"] - s["reads"])
    return {"read": [f"{n}/{a}" for n, a in read], "unread": [f"{n}/{a}" for n, a in unread]}


def conclusion_gate(text: str, where: str = "facts") -> None:
    """Premises, not conclusions (TTC-L CG). A snippet, or a side of a case,
    writes premises: declared slots, helpers of its own, and constraints
    that read only those and read_as/2. A head on what the base concludes
    (it derives or shows the predicate and no slot declares it), a slot
    declared hypothetical, or a constraint that reads a conclusion, directly
    or through a helper of the snippet's, is refused at the gate
    `conclusion`, naming the predicate. Bodies of rules with a premise for
    their head may read anything (a source on the branch of a claim), except
    a witness's: a witness of LG 25's conditions reads no conclusion
    (TTC-WITNESS WG)."""
    if not (text or "").strip():
        return
    slots, concluded, hypothetical = _premises()
    rules = []                                     # (line, heads, reads, is_constraint)

    def on(st):
        t = st.ast_type
        if t == _ast.ASTType.Rule:
            loc = {"heads": set(), "reads": set()}
            order = []
            _walk(st.head, "heads", loc, order)
            _walk(st.body, "reads", loc, order)
            rules.append((st.location.begin.line, loc["heads"], loc["reads"], not loc["heads"]))
        elif t == _ast.ASTType.Minimize:
            loc = {"heads": set(), "reads": set()}
            _walk(st, "reads", loc, [])
            rules.append((st.location.begin.line, set(), loc["reads"], True))
        elif t == _ast.ASTType.External:
            loc = {"heads": set(), "reads": set()}
            _walk(st.atom, "heads", loc, [])
            rules.append((st.location.begin.line, loc["heads"], set(), False))
    try:
        _ast.parse_string(text, on, logger=lambda code, msg: None)
    except RuntimeError:
        return                                     # the parse gate reports it
    allowed_reads = {("read_as", 2)}

    def refuse(line, sig, how=""):
        pred = f"{sig[0]}/{sig[1]}"
        if sig in hypothetical:
            message = f"{pred} is hypothetical: written only in a part of the base marked HYPOTHETICAL (rule 6)"
        else:
            drawn = drawn_from(sig)
            message = (f"{how}{pred} is a conclusion of the base, not a premise: write the premises it is "
                       "drawn from (TTC-L CG)" + (": " + ", ".join(drawn) if drawn else ""))
        raise SnippetError(message, "conclusion", where, line, None, pred, _line_of(text, line))
    for line, heads, _, _ in rules:
        for sig in sorted(heads):
            if sig in concluded:
                refuse(line, sig)
    # helpers: the snippet's own predicates; tainted where a body reads a conclusion
    own = {sig for _, heads, _, _ in rules for sig in heads} - slots - concluded
    tainted = {}
    changed = True
    while changed:
        changed = False
        for line, heads, reads, constraint in rules:
            if constraint:
                continue
            for h in heads & own:
                if h in tainted:
                    continue
                bad = sorted(r for r in reads if (r in concluded and r not in allowed_reads) or r in tainted)
                if bad:
                    tainted[h] = tainted.get(bad[0], bad[0]) if bad[0] in tainted else bad[0]
                    changed = True
    for line, _, reads, constraint in rules:
        if not constraint:
            continue
        for sig in sorted(reads):
            if sig in allowed_reads:
                continue
            if sig in concluded:
                refuse(line, sig, "a constraint reads it: ")
            if sig in tainted:
                refuse(line, tainted[sig], f"a constraint reads it, through {sig[0]}/{sig[1]}: ")
    # TTC-WITNESS WG: a witness of LG 25's conditions is shown apart from the
    # claim, so it is never drawn from what the base concludes (oum_holds/1 and
    # the like), directly or through a helper. Other premise heads keep the
    # latitude above.
    for line, heads, reads, constraint in rules:
        if constraint or not heads & WITNESS_SLOTS:
            continue
        for sig in sorted(reads):
            if sig in allowed_reads:
                continue
            via = f", through {sig[0]}/{sig[1]}" if sig in tainted else ""
            if sig in concluded or sig in tainted:
                pred_sig = tainted.get(sig, sig)
                pred = f"{pred_sig[0]}/{pred_sig[1]}"
                raise SnippetError(f"a witness is drawn from {pred}{via}, a conclusion of the base: a witness "
                                   "is shown apart from the claim, never drawn from what the base concludes "
                                   "(rule 14; TTC-WITNESS)", "conclusion", where, line, None, pred,
                                   _line_of(text, line))


# The slots a witness of LG 25's conditions is entered by (TTC-WITNESS WG).
WITNESS_SLOTS = {("witnessed_by", 3), ("condition_shown", 2), ("communion_judged_by", 2)}


def _ground_error(logs, facts, extra, exc):
    """A SnippetError at the ground gate. The base grounds alone, so the error
    lies in the facts (program user) or in the fix method's added rules."""
    errors = [m.strip() for m in logs if "error" in m.lower()] or [str(exc)]
    first = errors[0]
    where = "facts" if "#inc_user" in first or not extra else "add_rules"
    text = facts if where == "facts" else extra
    m = _LOC.match(first)
    line, col = (int(m.group(1)), int(m.group(2))) if m else (None, None)
    pred = None
    if line:
        try:
            pred = signatures(text, where)["at_line"].get(line)
        except SnippetError:
            pass
    return SnippetError("clingo could not ground the program: " + " | ".join(errors[:5]), "ground", where,
                        line, col, pred, _line_of(text, line))


def solve(parts, mode="one", facts="", max_models=0, timeout=None, show=()):
    """Ground the base plus `parts` (and an optional snippet) and solve.

    mode: "one" (last model), "all"/"branches" (every stable model),
          "opt" (optimal models of a #minimize/#maximize part).
    """
    parts = list(parts)
    unknown = [p for p in parts if p not in known_parts() and not is_runtime(p)]
    if unknown:
        raise SnippetError(f"unknown part(s): {', '.join(unknown)}", "parts", "parts", text=", ".join(unknown))
    facts = check_snippet(facts)
    extra = _ADD.get()
    if extra:
        signatures(extra, "add_rules")          # refused at the parse gate, with its line
    warnings = unknown_slots(facts) if facts else []
    conclusion_gate(facts)
    nmodels = {"one": [], "all": [f"--models={max_models}"], "branches": [f"--models={max_models}"],
               "opt": ["--opt-mode=opt"]}[mode]
    logs = []
    ctl = clingo.Control(nmodels, logger=lambda code, msg: logs.append(msg))
    for f, text in base_texts().items():
        ctl.add("base", [], text)
    if extra:
        ctl.add("base", [], extra)
    if show:
        ctl.add("base", [], " ".join(f"#show {s}." for s in show))
    try:
        if facts:
            ctl.add("user", [], facts)
        ctl.ground([("base", [])] + [(p, []) for p in expand_runtimes(parts)] + ([("user", [])] if facts else []))
    except RuntimeError as exc:
        raise _ground_error(logs, facts, extra, exc) from None
    out = {"models": 0, "atoms": [], "cost": None, "all_models": [], "truncated": False, "warnings": warnings,
           "premises": premises_read(facts)}

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
             "t2": False, "facts": [], "assume": [], "unshown": 0}
        for a in atoms:
            name, args = split_args(a)
            if name in ("read_as", "oum_holds", "assumed_fact", "graded"):
                b["assume"].append(a)
            if name == "unshown_claim":
                b["unshown"] += 1
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


def pref_key(b):
    """the order of preference among main branches: first, no branch resting on
    a claim whose conditions are not shown (c. 749 §3; rule 14); then weight"""
    return (b.get("unshown", 0), b["w"][3], b["w"][4], b["w"][5])


def preferred_value(r, question):
    mains = [b for b in r["branches"] if b["status"] == "main"]
    if not mains:
        return "no main branch"
    key = pref_key
    best = min(key(b) for b in mains)
    winners = sorted({v for b in mains if key(b) == best for v in b["values"] if v.startswith(question + "=")})
    return winners[0].split("=", 1)[1] if len(winners) == 1 else "tie"


# ---------- static crossing check (A11) ---------------------------------
CHECK_HEADS = ("violation", "crosses", "info", "theorem", "verdict")
ROUTES = ("licensed", "mode", "bridge")
LINT_FILES = ["kernel_core.lp", "kernel_analogy.lp", "icon_theory.lp", "icon_authority.lp"]


def lint(extra=""):
    """Flag rules whose positive body mixes divine- and creature-sorted
    predicates without routing through licensed/mode/bridge."""
    texts = base_texts()
    sorts = {p: s for f in LINT_FILES for p, s in re.findall(r"sort_of\((\w+),(\w+)\)", texts[f])}   # each layer registers its own
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
    out = {"schema": SCHEMA, "satisfiable": r["sat"], "stable_models": r["models"], "truncated": r["truncated"],
           "warnings": list(r.get("warnings", [])), "premises": r.get("premises") or {"read": [], "unread": []}}
    if not r["sat"]:
        out["note"] = "No stable model: the facts are inconsistent with a hard constraint (often a tier-1 text or a fixed reading)."
        return stable(out)
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
    shown = sorted(bs, key=lambda b: (order.get(b["status"], 3),) + pref_key(b))[:max_branches]
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
    return stable(out)



def run_checked(parts, facts="", max_models=20000, timeout_s=60.0, optimize=False):
    mode = "opt" if optimize else "branches"
    return solve(parts, mode, facts=facts, max_models=max_models, timeout=timeout_s, show=("value/2",))
