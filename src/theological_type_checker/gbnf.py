"""The slots and sorts of L as a GBNF grammar, for constrained decoding
(llama.cpp's grammars; xgrammar and outlines read the same form). An
encoder held to it can emit only facts of declared slots, each argument of
its sort: a closed sort's values, a range's numbers, a date's eight digits.

What it guarantees is form, not fidelity. An open sort (`law`, `act`,
`entity`, most of them) admits any well-formed term, and a well-typed fact
can still be the wrong fact: the wrong date, the wrong reading. That is for
the tests with answers people gave; the gate (`conclusion`) still stands
behind it. Read off L, never edited by hand; nothing in the rule base reads it.
"""
from __future__ import annotations

from . import lang

# Open sorts whose shape is known though their values are not.
SHAPED = {"date": "date", "year": "int", "number": "int", "string": "string"}
RANGE_LIMIT = 100          # a range wider than this is any integer

COMMON = [
    ("ws", r"[ \t\n]*"),
    ("ident", r"[a-z] [a-zA-Z0-9_]*"),
    ("int", r'"-"? [0-9]+'),
    ("string", r'"\"" ( [^"\\\n] | "\\" ["\\nt] )* "\""'),
    ("date", r"[0-9] [0-9] [0-9] [0-9] [0-1] [0-9] [0-3] [0-9]"),
    ("term", r'ident ( "(" term ( "," term )* ")" )? | int | string'),
]


def _name(kind: str, n: str, arity: int | None = None) -> str:
    """A rule name: GBNF allows letters, digits and hyphens. A slot's carries
    its arity, since two slots may share a name."""
    return f"{kind}-" + n.replace("_", "-") + (f"-{arity}" if arity is not None else "")


def _lit(s: str) -> str:
    return '"' + s.replace("\\", "\\\\").replace('"', '\\"') + '"'


def _sort_rule(s) -> str:
    if s.values is not None:
        return " | ".join(_lit(v) for v in s.values)
    if s.range is not None:
        lo, hi = s.range
        if hi - lo <= RANGE_LIMIT:
            return " | ".join(_lit(str(v)) for v in range(lo, hi + 1))
        return "int"
    return SHAPED.get(s.name, "term")


def grammar(side: str | None = None, only: set[str] | None = None, srcs=None) -> str:
    """The grammar: `root` is any number of facts, one per line. `side`
    (theology, canon) keeps the slots a case of that side may enter, with
    those of either side; `only` keeps the named slots (`name/arity`), so a
    question about one slot is answered in that slot alone."""
    srcs = srcs if srcs is not None else lang.sources()
    slots = lang.slots(srcs)
    sorts = lang.all_sorts(srcs)
    keep = []
    for (n, a), d in sorted(slots.items()):
        if side and d.side not in (side, "either"):
            continue
        if only is not None and f"{n}/{a}" not in only:
            continue
        keep.append(d)
    if only is not None:
        missing = only - {f"{d.name}/{d.arity}" for d in keep}
        if missing:
            raise ValueError(f"no such slot here: {', '.join(sorted(missing))}")
    if not keep:
        raise ValueError("no slot is left to enter")
    lines = [f"# GBNF read off L: {len(keep)} slots" + (f", side {side}" if side else "")
             + ". Form, not fidelity (ttc-l(1)).",
             "root ::= ws ( fact ws )*",
             "fact ::= " + " | ".join(_name("slot", d.name, d.arity) for d in keep)]
    used = set()
    for d in keep:
        if not d.arity:
            lines.append(f"{_name('slot', d.name, 0)} ::= {_lit(d.name + '.')}")
            continue
        args = []
        for _, sort in d.args:
            used.add(sort)
            args.append(_name("sort", sort))
        body = f' "," '.join(args)
        lines.append(f"{_name('slot', d.name, d.arity)} ::= {_lit(d.name + '(')} {body} {_lit(').')}")
    for name in sorted(used):
        lines.append(f"{_name('sort', name)} ::= {_sort_rule(sorts[name])}")
    lines += [f"{n} ::= {body}" for n, body in COMMON]
    return "\n".join(lines) + "\n"

