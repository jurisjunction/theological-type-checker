"""ttc-say: the checker's answer as plain text, with no model between the
solver and the reader (TTC-SAY(1)).

Every sentence is the `say` template of a slot or a result (L, SY), its
arguments filled from the atom printed beneath it; a constant is shown by
its label if the base or the case gives one. An atom with no template is
printed as it is and listed under UNSAID. Nothing is weighed, summarised
or reordered beyond the summary the checker itself computes
(engine.summary): the same facts give the same text, byte for byte.
"""
from __future__ import annotations

import argparse
import pathlib
import re
import subprocess
import sys

import clingo

from . import engine, lang, norms

LABEL_TAG = re.compile(r"^%\s*@label\s+(\S+)\s*\|\s*(.+?)\s*$")
BY_TAG = re.compile(r"^%\s*@encoded-by\s+(.+?)\s*$")
CASE_TAG = re.compile(r"^%\s*@case\s+(.+?)\s*$")
FOOT = "The checker shows what is ill-formed. It does not show that what is well-formed is true."
VALUE_CLASSES = ("A value is settled if every main branch has it, open if some do, a shadow if only "
                 "shadows do, excluded if none do.")


def case_tags(facts: str) -> dict:
    """What a case file says of itself in comment tags: `% @label term |
    text`, `% @encoded-by who`, `% @case title`."""
    out = {"labels": {}, "by": None, "case": None}
    for line in facts.splitlines():
        line = line.strip()
        if m := LABEL_TAG.match(line):
            out["labels"][m.group(1)] = m.group(2)
        elif m := BY_TAG.match(line):
            out["by"] = m.group(1)
        elif m := CASE_TAG.match(line):
            out["case"] = m.group(1)
    return out


class Sayer:
    """Says atoms through the base's templates."""

    def __init__(self, labels: dict[str, str] | None = None, srcs=None):
        srcs = srcs if srcs is not None else lang.sources()
        self.templates = {**lang.slots(srcs), **lang.results(srcs)}
        self.labels = {**lang.labels(srcs), **(labels or {})}
        self.unsaid: set[str] = set()

    def name(self, sym) -> str:
        s = str(sym)
        return self.labels.get(s, s)

    def sentence(self, sym) -> str | None:
        d = self.templates.get((sym.name, len(sym.arguments)))
        if d is None or "say" not in d.attrs:
            self.unsaid.add(f"{sym.name}/{len(sym.arguments)}")
            return None
        return lang.say(d, [self.name(a) for a in sym.arguments])

    def atom(self, text: str) -> str | None:
        """The sentence for an atom as the checker prints it: `info(X)` and
        `violation(X)` say X (a violation marked so), `assumed_fact(X)` and
        `assumed_fact(false(X))` say X or its denial."""
        sym = clingo.parse_term(text)
        fn = clingo.SymbolType.Function

        def inner(s):
            return s.arguments[0] if len(s.arguments) == 1 and s.arguments[0].type == fn else None

        if sym.name == "info" and inner(sym):
            return self.sentence(inner(sym))
        if sym.name == "violation" and inner(sym):
            said = self.sentence(inner(sym))
            return f"VIOLATION: {said}" if said else None
        if sym.name == "frontier" and len(sym.arguments) == 2:
            x = sym.arguments[1]
            said = self.sentence(x) if x.type == fn else None
            return f"{said} [{sym.arguments[0]}]" if said else None
        if sym.name == "assumed_fact" and inner(sym):
            x = inner(sym)
            if x.name == "false" and inner(x):
                said = self.sentence(inner(x))
                return f"it is not so that {said}" if said else None
            return self.sentence(x)
        return self.sentence(sym)


def _base_version() -> str:
    try:
        out = subprocess.run(["git", "rev-parse", "--short", "HEAD"], cwd=engine.__file__.rsplit("/", 1)[0],
                             capture_output=True, text=True, timeout=10)
        if out.returncode == 0 and out.stdout.strip():
            return out.stdout.strip()
    except (OSError, subprocess.SubprocessError):
        pass
    try:
        from importlib.metadata import version
        return "v" + version("theological-type-checker")
    except Exception:  # noqa: BLE001
        return "unknown"


def _date(d) -> str:
    s = str(d)
    return f"{s[:4]}-{s[4:6]}-{s[6:]}" if len(s) == 8 and s.isdigit() else s


def norms_writing(names: set[str]) -> list[tuple[str, str]]:
    """The norm blocks (id, short citation) whose rules write a result of one
    of these names, read off the rule files as norms.py reads them. Static:
    where the rule stands, not a proof that this instance came by it."""
    ns, _, rules, _ = norms.parse()
    hit = set()
    for norm, _, stmt in rules:
        if not norm:
            continue
        head = stmt.split(":-", 1)[0]
        written = {n for n, _ in lang.wrapped(head)} | {n for n, _, _ in norms._atoms(head)}
        if written & names:
            hit.add(norm)
    return sorted(((n, ns[n]["citation"].split(":", 1)[0]) for n in hit), key=lambda x: x[1])


def files_writing(names: set[str]) -> list[str]:
    """The rule files with a rule whose head writes one of these names."""
    out = []
    for f, text in engine.base_texts().items():
        heads = {n for n, _ in engine.signatures(text, f)["heads"]} | {n for n, _ in lang.wrapped(text)}
        if heads & names:
            out.append(f)
    return sorted(out)


def render(parts: list[str], facts: str = "", name: str = "case", atoms: bool = True,
           entered: bool = True, version: str | None = None) -> str:
    """The code block: header and date, questions, what holds in every
    branch, what turns on a disputed fact, the branches, the norms whose
    rules wrote the results, the frontier, what was entered, and what has no
    template yet."""
    tags = case_tags(facts)
    sayer = Sayer(tags["labels"])
    r = engine.solve(parts, "branches", facts=facts, max_models=20000, timeout=60.0,
                     show=("value/2", "eval_date/1"))
    s = engine.summary(r)
    out: list[str] = []

    def item(atom: str, indent: str = "  ", note: str = ""):
        said = sayer.atom(atom)
        if said is None:
            out.append(f"{indent}{atom}{note}")
        else:
            out.append(f"{indent}{said}{note}")
            if atoms:
                out.append(f"{indent}    = {atom}")

    dates = sorted({a[len("eval_date("):-1] for m in (r.get("all_models") or [r.get("atoms", [])])
                    for a in m if a.startswith("eval_date(")})
    out.append(f"TTC-checker {version or _base_version()} · {tags['case'] or name}"
               + (f" · parts: {', '.join(parts)}" if parts else ""))
    out.append(f"As of {', '.join(_date(d) for d in dates)}: the law is read as it stood that day."
               if dates else "As of: no date given.")
    out.append(f"Facts encoded by: {tags['by'] or 'not stated'}.")
    out.append("Computed by clingo. Each sentence is the template (`say`) of the atom under it;")
    out.append("no language model wrote it.")
    if not s.get("satisfiable", True):
        out += ["", "UNSATISFIABLE: the facts contradict the base. Nothing follows; check the facts."]
        return "\n".join(out) + "\n"
    if s.get("truncated"):
        out += ["", "TRUNCATED: not every answer set was read; what follows may be incomplete."]

    if s["questions"]:
        out += ["", "QUESTIONS"]
        for q, info in s["questions"].items():
            vals = "; ".join(f"{sayer.name(clingo.parse_term(v))} {c}" for v, c in info["values"].items())
            out.append(f"  {sayer.name(clingo.parse_term(q))}: {vals}")
        out.append(f"  ({VALUE_CLASSES})")

    if s["in_every_branch"]:
        out += ["", "IN EVERY BRANCH"]
        for a in s["in_every_branch"]:
            item(a)

    # What follows from a disputed fact is said once, under that fact; each
    # branch then shows only what is its own (a factoring, nothing weighed).
    bs = s["branches"]
    assume = {tuple(b["assumptions"]) for b in bs}
    under = {A: set.intersection(*(set(b["only_here"]) for b in bs if tuple(b["assumptions"]) == A))
             for A in assume}

    def said_assumptions(A):
        return "; ".join(sayer.atom(a) or a for a in A)

    if any(A for A in assume) and any(under.values()):
        out += ["", "DISPUTED (the branches turn on these; the checker does not decide them)"]
        keys = sorted(assume)
        for i, A in enumerate(keys):
            last = i == len(keys) - 1
            out.append(f"  {'└─' if last else '├─'} if {said_assumptions(A) if A else '(no assumption)'}:")
            bar = "     " if last else "  │  "
            for a in sorted(under[A]):
                item(a, bar)
            if not under[A]:
                out.append(f"{bar}(nothing beyond every branch)")

    groups: dict[tuple, list] = {}
    for b in bs:
        groups.setdefault((b["status"], tuple(b["values"]), tuple(b["cleaved_by"])), []).append(b)
    if len(bs) > 1 or any(b["only_here"] for b in bs):
        out += ["", f"BRANCHES ({s['branches_total']})"]
        for (status, values, cleaved), members in groups.items():
            shown = " · ".join(f"{sayer.name(clingo.parse_term(v.split('=', 1)[0]))}="
                               f"{sayer.name(clingo.parse_term(v.split('=', 1)[1]))}" for v in values)
            out.append(f"  [{status}] {shown}")
            if cleaved:
                out.append(f"    cleaved by: {', '.join(sayer.name(clingo.parse_term(c)) for c in cleaved)}")
            here = {tuple(b["assumptions"]) for b in members}
            if len(assume) > 1:
                out.append("    on every assumption" if here == assume else
                           "    only if " + " / ".join(said_assumptions(A) for A in sorted(here)))
            for b in members:
                for a in sorted(set(b["only_here"]) - under[tuple(b["assumptions"])]):
                    item(a, "    ")

    shown_atoms = set(s["in_every_branch"]) | {a for b in bs for a in b["only_here"]}
    names = set()
    for a in shown_atoms:
        sym = clingo.parse_term(a)
        x = sym.arguments[0] if sym.name in ("info", "violation") and len(sym.arguments) == 1 else sym
        names.add(x.name)
    cited = norms_writing(names)
    by_norm = {n for n in names if norms_writing({n})}
    loose = files_writing(names - by_norm) if names - by_norm else []
    if cited or loose:
        out += ["", "NORMS (whose rules wrote the results above; where a rule stands, not a proof)"]
        out += [f"  {c}  [{n}]" for n, c in cited]
        if loose:
            out.append(f"  and rules under no single norm, in {', '.join(loose)}: "
                       + ", ".join(sorted(names - by_norm)))

    models = r.get("all_models") or [r.get("atoms", [])]
    fronts = [set(a for a in m if a.startswith("frontier(")) for m in models]
    every_f = set.intersection(*fronts) if fronts else set()
    some_f = (set.union(*fronts) - every_f) if fronts else set()
    if every_f or some_f:
        out += ["", "FRONTIER (still to encode or read; nothing is decided here)"]
        for a in sorted(every_f):
            item(a)
        for a in sorted(some_f):
            item(a, note="  [in some branches]")

    if entered and facts.strip():
        ctl = clingo.Control(["--warn=none"])
        ctl.add("base", [], facts)
        ctl.ground([("base", [])])
        syms = sorted((a.symbol for a in ctl.symbolic_atoms if a.is_fact), key=str)
        out += ["", f"ENTERED ({len(syms)} facts)"]
        for sym in syms:
            item(str(sym))

    if sayer.unsaid:
        out += ["", "UNSAID (no template yet): " + ", ".join(sorted(sayer.unsaid))]
    out += ["", FOOT]
    return "\n".join(out) + "\n"


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="ttc-say", description="The checker's answer as plain text, said through "
                                 "the base's templates; no model between the solver and the reader.")
    ap.add_argument("case", nargs="?", type=pathlib.Path, help="a facts file (clingo); tags: % @label, "
                    "% @encoded-by, % @case")
    ap.add_argument("--parts", default="", help="parts of the base to load, comma-separated")
    ap.add_argument("--brief", action="store_true", help="sentences only, without the atoms under them")
    ap.add_argument("--no-entered", action="store_true", help="leave out the facts entered")
    a = ap.parse_args(argv)
    facts = a.case.read_text() if a.case else ""
    parts = [p for p in a.parts.split(",") if p]
    if not facts and not parts:
        ap.error("give a case file, or --parts")
    sys.stdout.write(render(parts, facts, a.case.name if a.case else "parts only",
                            atoms=not a.brief, entered=not a.no_entered))
    return 0


if __name__ == "__main__":
    sys.exit(main())
