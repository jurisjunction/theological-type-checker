"""L: the language of the libraries, compiled to clingo (TTC-L).

An ``.l`` file is a sequence of declarations and fenced clingo, one per
rule file in ``l/``. ``ttc-l build`` compiles them to ``lp/``; the compiled
files stay checked in and are what the solver reads. ``ttc-l check`` fails
on any byte of difference between the sources and the compiled base. It
guards against hand edits; it is not evidence that the base is right.

Each kind of declaration is a class with a parse, a check and a render:
the compiler's metaclasses, registered by keyword. A fence is copied byte
for byte. L reads it only to check that a ``part`` annotation stands
before a fence opening with ``#program``, and, through clingo's own
parser, to check the slots against the rules (``validate``).
"""
from __future__ import annotations

import argparse
import json
import pathlib
import re
import sys

HERE = pathlib.Path(__file__).resolve().parent
L_DIR = HERE / "l"
LP_DIR = HERE / "lp"
RUNTIMES_JSON = HERE / "runtimes.json"

FENCE_OPEN = "```clingo"
FENCE_CLOSE = "```"
DOMAINS_HEADER = "% ---------- domains (L) " + "-" * 45

# What L itself writes into the base, never a case: the closed sorts'
# values, read only by the domain rules (SR1).
GENERATED = {("in_sort", 2)}

# Layers, lowest first (TTC-L, THE LANGUAGE). A slot is declared in the
# lowest layer whose rules read it; sides for a case follow the layer. The
# libraries serve both sides: the guide enters their slots on either
# (interior/3, act_of/2, law_kind/2 ...), and the canon cases do (SO, LY).
LAYERS = ["kernel", "theory", "schools", "authority", "libraries", "canon", "pair", "library"]
SIDE = {"kernel": "theology", "theory": "theology", "schools": "theology", "authority": "theology",
        "libraries": "either", "canon": "canon", "pair": "canon", "library": "either"}

NAME = r"[a-z_][a-z0-9_]*"
SIG = re.compile(rf"^({NAME})/(\d+)$")


class LError(ValueError):
    """A source L refuses: the file and line, and why."""

    def __init__(self, where: str, line: int | None, message: str):
        super().__init__(f"{where}:{line}: {message}" if line else f"{where}: {message}")
        self.where, self.line, self.message = where, line, message


def _string(text: str, where: str, line: int) -> str:
    """A quoted string, with JSON's escapes."""
    try:
        value = json.loads(text)
    except ValueError:
        value = None
    if not isinstance(value, str):
        raise LError(where, line, f"expected a quoted string, got {text!r}")
    return value


def _quote(text: str) -> str:
    return json.dumps(text, ensure_ascii=False)


# ---------- the kinds of declaration ---------------------------------------
KINDS: dict[str, type[Decl]] = {}


class Decl:
    """A declaration: a keyword, its head (the rest of the line), and
    indented attribute lines. Subclasses parse, check and render."""
    keyword = ""
    attributes: tuple[str, ...] = ()

    def __init_subclass__(cls, **kw):
        super().__init_subclass__(**kw)
        if cls.keyword:
            KINDS[cls.keyword] = cls

    def __init__(self, head: str, where: str, line: int):
        self.head, self.where, self.line = head, where, line
        self.attrs: dict[str, str] = {}
        self.parse(head)

    def parse(self, head: str) -> None:
        if head:
            raise LError(self.where, self.line, f"`{self.keyword}` takes nothing after it")

    def attribute(self, key: str, value: str, line: int) -> None:
        if key not in self.attributes:
            raise LError(self.where, line, f"`{self.keyword}` has no attribute `{key}`")
        if key in self.attrs:
            raise LError(self.where, line, f"`{key}` given twice")
        self.attrs[key] = _string(value, self.where, line)

    def render(self) -> list[str]:
        return []

    def source(self) -> list[str]:
        """The declaration as L writes it (the converter's output)."""
        lines = [f"{self.keyword} {self.head}".rstrip()]
        lines += [f"  {k} {_quote(v)}" for k, v in self.attrs.items()]
        return lines


class Layer(Decl):
    """The file's layer, and so its slots' layer and side."""
    keyword = "layer"

    def parse(self, head):
        if head not in LAYERS:
            raise LError(self.where, self.line, f"unknown layer {head!r}; layers are {', '.join(LAYERS)}")
        self.name = head


class Library(Decl):
    """Marks the file for norms.py: its predicates count as defined."""
    keyword = "library"

    def render(self):
        return ["%  @library  (read by norms.py: its predicates count as defined)"]


def _typed_head(d: Decl, head: str) -> None:
    """`name/n`, or typed: `name(A: sort, B: sort)` (TY), for a slot or a
    result: sets name, arity and args (None when untyped)."""
    d.args = None
    m = SIG.match(head)
    if m:
        d.name, d.arity = m.group(1), int(m.group(2))
        return
    m = re.match(rf"^({NAME})\((.+)\)$", head)
    if not m:
        raise LError(d.where, d.line, f"expected name/arity or name(Arg: sort, ...), got {head!r}")
    d.name, args = m.group(1), []
    for part in m.group(2).split(","):
        a = re.match(rf"^\s*([A-Z][A-Za-z0-9_]*)\s*:\s*({NAME})\s*$", part)
        if not a:
            raise LError(d.where, d.line, f"expected `Arg: sort`, got {part.strip()!r}")
        args.append((a.group(1), a.group(2)))
    d.args, d.arity = args, len(args)


class Slot(Decl):
    """A predicate a case enters, declared once: one the base reads and no
    rule derives, or one the guide gives to enter though a rule also derives
    it (`source/4`, `interior/3`). Declared in the lowest layer whose rules
    read it, save what is routed from the canon layer. Renders its `@input`
    tag."""
    keyword = "slot"
    attributes = ("means", "say", "hypothetical")

    def parse(self, head):
        """`name/n`, or typed: `name(A: sort, B: sort)` (TY). A typed slot's
        arguments are clingo variables, each with a sort."""
        _typed_head(self, head)

    @property
    def sig(self):
        return (self.name, self.arity)

    def render(self):
        if "means" not in self.attrs:
            raise LError(self.where, self.line, f"slot {self.name}/{self.arity} has no `means`")
        return [f"% @input {self.name}/{self.arity} | {self.attrs['means']}"]

    def source(self):
        lines = super().source()
        if self.args:
            lines[0] = f"slot {self.name}(" + ", ".join(f"{a}: {s}" for a, s in self.args) + ")"
        return lines


class Sort(Decl):
    """A sort of slot argument (TY): open (`sort source`, named and served,
    not enforced), or closed, by values (`sort force {truth, juridical}`) or
    by a range (`sort tier 0..5`). A closed sort compiles to `in_sort/2`
    facts, and each slot argument of it to one rule, in the domains section
    at the end of the file (`Source.compile`). Declared once, in the lowest
    layer whose slots use it."""
    keyword = "sort"
    attributes = ("means",)

    def parse(self, head):
        m = re.match(rf"^({NAME})(?:\s+(.*))?$", head)
        if not m:
            raise LError(self.where, self.line, "expected `sort name`, `sort name {a, b}` or `sort name 0..5`")
        self.name, rest = m.group(1), (m.group(2) or "").strip()
        self.values: list[str] | None = None
        self.range: tuple[int, int] | None = None
        if not rest:
            return
        r = re.match(r"^(-?\d+)\.\.(-?\d+)$", rest)
        if r:
            self.range = (int(r.group(1)), int(r.group(2)))
            return
        if not (rest.startswith("{") and rest.endswith("}")):
            raise LError(self.where, self.line, f"sort {self.name}: expected {{values}} or a range, got {rest!r}")
        values = [v.strip() for v in _split_top(rest[1:-1])]
        term = re.compile(rf"^(?:-?\d+|{NAME}(?:\((?:{NAME}|-?\d+)(?:,\s*(?:{NAME}|-?\d+))*\))?)$")
        bad = [v for v in values if not term.match(v)]
        if not values or bad:
            raise LError(self.where, self.line, f"sort {self.name}: not a value: {', '.join(bad) or '(none)'}")
        if len(set(values)) != len(values):
            raise LError(self.where, self.line, f"sort {self.name}: a value given twice")
        self.values = values

    @property
    def closed(self):
        return self.values is not None or self.range is not None

    def in_sort(self) -> str:
        if self.range:
            return f"in_sort({self.name},{self.range[0]}..{self.range[1]})."
        if len(self.values) == 1:
            return f"in_sort({self.name},{self.values[0]})."
        return f"in_sort({self.name},({';'.join(self.values)}))."

    def source(self):
        lines = [f"sort {self.name}"]
        if self.range:
            lines[0] += f" {self.range[0]}..{self.range[1]}"
        elif self.values:
            lines[0] += " {" + ", ".join(self.values) + "}"
        return lines + [f"  {k} {_quote(v)}" for k, v in self.attrs.items()]


def _split_top(s: str) -> list[str]:
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


class Use(Decl):
    """A predicate read here and declared or derived elsewhere. Renders the
    `@input` tag the file has always carried, its note kept."""
    keyword = "use"

    def parse(self, head):
        sig, _, note = head.partition(" ")
        m = SIG.match(sig)
        if not m:
            raise LError(self.where, self.line, f"expected name/arity, got {sig!r}")
        self.name, self.arity = m.group(1), int(m.group(2))
        self.note = _string(note.strip(), self.where, self.line)

    @property
    def sig(self):
        return (self.name, self.arity)

    def render(self):
        return [f"% @input {self.name}/{self.arity} | {self.note}"]


class Result(Decl):
    """A predicate the base computes, as a result shows it: the inner term of
    an `info` or `violation` atom, or a derived predicate (SY, for results).
    Typed like a slot; its `say` is the sentence ttc-say(1) prints above the
    atom. Renders nothing: the rule files are unchanged by it."""
    keyword = "result"
    attributes = ("say",)

    def parse(self, head):
        _typed_head(self, head)

    @property
    def sig(self):
        return (self.name, self.arity)

    def source(self):
        lines = super().source()
        if self.args:
            lines[0] = f"result {self.name}(" + ", ".join(f"{a}: {s}" for a, s in self.args) + ")"
        return lines


LABEL_TERM = re.compile(rf"^(?:-?\d+|{NAME}(?:\([a-z0-9_(),]*\))?)$")


class Label(Decl):
    """A display name for a constant of the base (`label c135_2 "c. 135 §2"`),
    used when a result is said. A case gives its own as `% @label term | text`
    (ttc-say(1)). Renders nothing."""
    keyword = "label"

    def parse(self, head):
        term, _, text = head.partition(" ")
        if not LABEL_TERM.match(term):
            raise LError(self.where, self.line, f"label: not a term: {term!r}")
        self.term, self.text = term, _string(text.strip(), self.where, self.line)


class Norm(Decl):
    """A canon (or a display norm): its id, its citation, its source."""
    keyword = "norm"

    def parse(self, head):
        parts = head.split(" | ")
        if len(parts) != 3 or not all(p.strip() == p and p for p in parts):
            raise LError(self.where, self.line, "expected `norm id | citation | url`")
        self.id, self.citation, self.url = parts

    def render(self):
        return [f"% @norm {self.id} | {self.citation} | {self.url}"]


class End(Decl):
    """Closes the current norm (for display rules)."""
    keyword = "end"

    def render(self):
        return ["% @end"]


class _NormFlag(Decl):
    def parse(self, head):
        if not re.match(r"^\S+$", head):
            raise LError(self.where, self.line, f"`{self.keyword}` takes a norm id")
        self.id = head

    def render(self):
        return [f"% @{self.keyword} {self.id}"]


class Temporal(_NormFlag):
    """A norm whose effects fall only on later acts."""
    keyword = "temporal"


class Recursive(_NormFlag):
    """A norm that defines one person's delict by another's."""
    keyword = "recursive"


class Stratum(Decl):
    """A norm of divine law or of the supreme authority."""
    keyword = "stratum"

    def parse(self, head):
        m = re.match(r"^(\S+) (divine|supreme|common)$", head)
        if not m:
            raise LError(self.where, self.line, "expected `stratum id divine|supreme|common`")
        self.id, self.stratum = m.groups()

    def render(self):
        return [f"% @stratum {self.id} {self.stratum}"]


PART_KINDS = ("model", "case", "switch", "candidate", "date", "search")


class Part(Decl):
    """Annotates the fence below, which opens with `#program name.`: its
    kind, and (OF) the case it belongs to. Renders nothing."""
    keyword = "part"

    def parse(self, head):
        m = re.match(rf"^({'|'.join(PART_KINDS)})(?: of ({NAME}))?$", head)
        if not m:
            raise LError(self.where, self.line, f"expected `part {'|'.join(PART_KINDS)} [of case]`")
        self.kind, self.of = m.group(1), m.group(2)
        self.name = None                  # read from the fence


class Runtime(Decl):
    """A school's parts, loaded whole: a set, kept in the order of first
    mention. `extends` takes one or more parents; `add` appends, `exclude`
    removes, `alter X -> Y` puts Y where X was. A runtime records what it
    excludes, and inherits the record. Compiles to runtimes.json, not to a
    rule file."""
    keyword = "runtime"
    attributes = ("add", "exclude", "alter")

    def parse(self, head):
        m = re.match(rf"^({NAME})(?: extends ({NAME}(?:, {NAME})*))?$", head)
        if not m:
            raise LError(self.where, self.line, "expected `runtime name [extends parent, ...]`")
        self.name = m.group(1)
        self.parents = m.group(2).split(", ") if m.group(2) else []
        self.ops: list[tuple] = []

    def attribute(self, key, value, line):
        if key not in self.attributes:
            raise LError(self.where, line, f"`runtime` has no attribute `{key}`")
        if key == "alter":
            m = re.match(rf"^({NAME}) -> ({NAME})$", value.strip())
            if not m:
                raise LError(self.where, line, "expected `alter part -> part`")
            self.ops.append(("alter", m.group(1), m.group(2), line))
            return
        names = [n.strip() for n in value.split(",")]
        if not names or not all(re.match(rf"^{NAME}$", n) for n in names):
            raise LError(self.where, line, f"expected `{key} part, part, ...`")
        self.ops += [(key, n, None, line) for n in names]

    def source(self):
        lines = [f"runtime {self.name}" + (f" extends {', '.join(self.parents)}" if self.parents else "")]
        group: list[str] = []

        def flush(kind):
            if group:
                lines.append(f"  {kind} {', '.join(group)}")
                group.clear()
        last = None
        for kind, a, b, _ in self.ops:
            if kind == "alter":
                flush(last)
                lines.append(f"  alter {a} -> {b}")
                last = None
                continue
            if kind != last:
                flush(last)
            group.append(a)
            last = kind
        flush(last)
        return lines


class Fence:
    """Raw clingo, copied byte for byte."""

    def __init__(self, lines: list[str], where: str, line: int):
        self.lines, self.where, self.line = lines, where, line

    def render(self):
        return list(self.lines)

    def source(self):
        return [FENCE_OPEN, *self.lines, FENCE_CLOSE]


# ---------- parsing and compiling ------------------------------------------
class Source:
    """One parsed .l file."""

    def __init__(self, name: str, items: list):
        self.name, self.items = name, items
        layers = [d for d in items if isinstance(d, Layer)]
        if len(layers) != 1 or items[0] is not layers[0]:
            raise LError(name, None, "a source opens with exactly one `layer`")
        self.layer = layers[0].name
        self._check_parts()

    def _check_parts(self):
        for i, d in enumerate(self.items):
            if isinstance(d, Part):
                nxt = self.items[i + 1] if i + 1 < len(self.items) else None
                m = re.match(r"^#program\s+(\w+)\s*\.", nxt.lines[0]) if isinstance(nxt, Fence) and nxt.lines else None
                if not m:
                    raise LError(self.name, d.line, "`part` must stand before a fence opening with `#program`")
                d.name = m.group(1)
            elif isinstance(d, Fence) and d.lines and re.match(r"^#program\s+\w+\s*\.", d.lines[0]):
                prev = self.items[i - 1] if i else None
                if not isinstance(prev, Part):
                    raise LError(self.name, d.line, "a fence opening with `#program` needs a `part` before it")

    def decls(self, kind):
        return [d for d in self.items if isinstance(d, kind)]

    def compile(self, sorts: dict[str, Sort] | None = None, domains: bool = True) -> str:
        """The rule file. With `sorts` (every sort of the base, by name), a
        typed slot's arguments of a closed sort are checked against it in the
        domains section; without, only this file's sorts are known."""
        lines = [line for item in self.items for line in item.render()]
        if domains:
            lines += self.domains(sorts if sorts is not None else {s.name: s for s in self.decls(Sort)})
        return "\n".join(lines) + "\n"

    def domains(self, sorts: dict[str, Sort]) -> list[str]:
        """The domains section (TY): `in_sort/2` for each closed sort declared
        here, and for each argument of a closed sort, one rule naming the
        slot, the argument's position and the value. Under `#program base`
        where the file has parts."""
        body = [s.in_sort() for s in self.decls(Sort) if s.closed]
        for d in self.decls(Slot):
            for i, (var, sort) in enumerate(d.args or []):
                if sort not in sorts:
                    raise LError(self.name, d.line, f"slot {d.name}/{d.arity}: no sort named {sort}")
                if sorts[sort].closed:
                    pattern = ",".join(var if j == i else "_" for j in range(d.arity))
                    body.append(f"violation(outside_domain({d.name},{i + 1},{var})) :- "
                                f"{d.name}({pattern}), not in_sort({sort},{var}).")
        if not body:
            return []
        head = ["", DOMAINS_HEADER] + (["#program base."] if self.decls(Part) else [])
        return head + body

    def text(self) -> str:
        """The source as L writes it."""
        out = []
        for item in self.items:
            out += item.source() + [""]
        return "\n".join(out).rstrip("\n") + "\n"


def parse(text: str, name: str = "<l>") -> Source:
    items: list = []
    fence: list[str] | None = None
    fence_line = 0
    current: Decl | None = None
    for n, line in enumerate(text.split("\n")[:-1] if text.endswith("\n") else text.split("\n"), 1):
        if fence is not None:
            if line == FENCE_CLOSE:
                items.append(Fence(fence, name, fence_line))
                fence = None
            else:
                fence.append(line)
            continue
        if line == FENCE_OPEN:
            fence, fence_line, current = [], n, None
            continue
        if not line.strip() or line.lstrip().startswith("--"):
            continue
        if line.startswith("  "):
            if current is None:
                raise LError(name, n, "an attribute with no declaration above it")
            key, _, value = line.strip().partition(" ")
            current.attribute(key, value, n)
            continue
        keyword, _, head = line.partition(" ")
        if keyword not in KINDS:
            raise LError(name, n, f"unknown declaration {keyword!r}")
        current = KINDS[keyword](head.strip(), name, n)
        items.append(current)
    if fence is not None:
        raise LError(name, fence_line, "a fence is never closed")
    return Source(name, items)


def compile_runtimes(srcs: dict[str, Source]) -> dict:
    """The runtimes, each a list of parts, with what each declares. A part a
    runtime names must exist; a parent must be declared, with no cycle; two
    parents that disagree on a part (one has it, the other excludes it) are
    a clash, refused until the child says `add`, `exclude` or `alter` for
    it. No order between parents decides."""
    decls = [d for src in srcs.values() for d in src.decls(Runtime)]
    by_name: dict[str, Runtime] = {}
    for d in decls:
        if d.name in by_name:
            raise LError(d.where, d.line, f"runtime {d.name} declared twice")
        by_name[d.name] = d
    parts = {d.name for src in srcs.values() for d in src.decls(Part)}
    done: dict[str, tuple[list, set]] = {}

    def resolve(name, trail=()):
        if name in done:
            return done[name]
        d = by_name.get(name)
        if d is None:
            raise LError(trail[-1].where if trail else "runtimes", trail[-1].line if trail else None,
                         f"no runtime named {name}")
        if d in trail:
            raise LError(d.where, d.line, "runtimes extend each other in a cycle: "
                         + " -> ".join(t.name for t in trail + (d,)))
        inherited = [resolve(p, trail + (d,)) for p in d.parents]
        mentioned = {a for _, a, _, _ in d.ops} | {b for k, _, b, _ in d.ops if k == "alter"}
        for i, (has_i, _) in enumerate(inherited):
            for j, (_, excl_j) in enumerate(inherited):
                for part in sorted(set(has_i) & excl_j):
                    if i != j and part not in mentioned:
                        raise LError(d.where, d.line, f"runtime {d.name}: its parents {d.parents[i]} and "
                                     f"{d.parents[j]} clash on {part} (one has it, the other excludes it); "
                                     f"say `add {part}`, `exclude {part}` or `alter {part} -> ...`")
        have = list(dict.fromkeys(p for has, _ in inherited for p in has))
        excluded = set().union(*(e for _, e in inherited)) if inherited else set()
        for kind, a, b, line in d.ops:
            for name_ in (a, b):
                if name_ and name_ not in parts:
                    raise LError(d.where, line, f"runtime {d.name}: no part named {name_}")
            if kind == "add":
                if a not in have:
                    have.append(a)
                excluded.discard(a)
            elif kind == "exclude":
                if a in have:
                    have.remove(a)
                excluded.add(a)
            else:
                if a not in have:
                    raise LError(d.where, line, f"runtime {d.name}: cannot alter {a}, which it does not have")
                if b in have:
                    raise LError(d.where, line, f"runtime {d.name}: cannot alter {a} -> {b}, it already has {b}")
                have[have.index(a)] = b
                excluded.add(a)
                excluded.discard(b)
        done[name] = (have, excluded)
        return done[name]

    out = {"runtimes": {}, "declared": {}}
    for d in decls:
        out["runtimes"][d.name] = resolve(d.name)[0]
        out["declared"][d.name] = {"extends": d.parents, "file": d.where,
                                   "ops": [[k, a] if k != "alter" else [k, a, b] for k, a, b, _ in d.ops]}
    return out


def runtimes_text(compiled: dict) -> str:
    return json.dumps(compiled, indent=1, ensure_ascii=False) + "\n"


def slots(srcs: dict[str, Source]) -> dict[tuple[str, int], Slot]:
    """Each slot by (name, arity). A predicate declared a slot twice is
    refused, naming both places."""
    out: dict[tuple[str, int], Slot] = {}
    for src in srcs.values():
        for d in src.decls(Slot):
            if d.sig in out:
                first = out[d.sig]
                raise LError(d.where, d.line, f"slot {d.name}/{d.arity} is declared already "
                             f"({first.where}:{first.line}); say `use` here")
            d.layer, d.side = src.layer, SIDE[src.layer]
            out[d.sig] = d
    return out


def results(srcs: dict[str, Source]) -> dict[tuple[str, int], Result]:
    """Each result by (name, arity). Declared once; never also a slot, since
    a slot is entered and a result computed."""
    out: dict[tuple[str, int], Result] = {}
    declared = slots(srcs)
    for src in srcs.values():
        for d in src.decls(Result):
            if d.sig in out:
                first = out[d.sig]
                raise LError(d.where, d.line, f"result {d.name}/{d.arity} is declared already ({first.where}:{first.line})")
            if d.sig in declared:
                s = declared[d.sig]
                raise LError(d.where, d.line, f"result {d.name}/{d.arity} is a slot ({s.where}:{s.line}): "
                             "a slot is entered, a result computed")
            out[d.sig] = d
    return out


def labels(srcs: dict[str, Source]) -> dict[str, str]:
    """Each label of the base by its term. A term labelled twice is refused."""
    out: dict[str, Label] = {}
    for src in srcs.values():
        for d in src.decls(Label):
            if d.term in out:
                raise LError(d.where, d.line, f"label {d.term} is given already ({out[d.term].where}:{out[d.term].line})")
            out[d.term] = d
    return {k: d.text for k, d in out.items()}


WRAPPERS = ("info", "violation")


def wrapped(text: str) -> set[tuple[str, int]]:
    """The (name, arity) of each term an `info` or `violation` atom wraps, or
    a `frontier(Layer, X)` atom as its second argument, in a program text
    (comments dropped)."""
    out = set()
    code = "\n".join(line.split("%")[0] for line in text.splitlines())
    opener = r"\b(?:(?:" + "|".join(WRAPPERS) + r")\(|frontier\(\s*" + NAME + r"\s*,)\s*(" + NAME + r")\s*(\()?"
    for m in re.finditer(opener, code):
        if not m.group(2):
            out.add((m.group(1), 0))
            continue
        depth, i = 1, m.end()
        while i < len(code) and depth:
            depth += code[i] == "("
            depth -= code[i] == ")"
            i += 1
        out.add((m.group(1), len(_split_top(code[m.end():i - 1]))))
    return out


def all_sorts(srcs: dict[str, Source]) -> dict[str, Sort]:
    """Every sort, by name. A sort declared twice is refused."""
    out: dict[str, Sort] = {}
    for src in srcs.values():
        for s in src.decls(Sort):
            if s.name in out:
                first = out[s.name]
                raise LError(s.where, s.line, f"sort {s.name} is declared already ({first.where}:{first.line})")
            s.layer = src.layer
            out[s.name] = s
    return out


def compiled(srcs: dict[str, Source], domains: bool = True) -> dict[str, str]:
    """Each rule file, compiled with every sort of the base known."""
    sorts = all_sorts(srcs)
    return {name: src.compile(sorts, domains) for name, src in srcs.items()}


def validate(srcs: dict[str, Source]) -> None:
    """What the declarations say against the rules the fences hold, read by
    clingo's own parser: every slot is read by some rule, and every `use`
    names a predicate some file declares or derives (SO3). Every argument
    of a slot has a sort; a sort is used, by slots of its layer or above
    (TY1)."""
    from . import engine
    declared = slots(srcs)
    sorts = all_sorts(srcs)
    reads, derived = set(), set()
    for name, text in compiled(srcs, domains=False).items():
        s = engine.signatures(text, name)
        reads |= s["reads"]
        derived |= s["derived"]
    used: set[str] = set()
    for d in declared.values():
        if d.sig not in reads:
            raise LError(d.where, d.line, f"slot {d.name}/{d.arity}: no rule reads it")
        if d.arity and d.args is None:
            raise LError(d.where, d.line, f"slot {d.name}/{d.arity}: its arguments have no sorts; "
                         f"write `slot {d.name}(Arg: sort, ...)`")
        for _, sort in d.args or []:
            if sort not in sorts:
                raise LError(d.where, d.line, f"slot {d.name}/{d.arity}: no sort named {sort}")
            if LAYERS.index(sorts[sort].layer) > LAYERS.index(d.layer):
                raise LError(d.where, d.line, f"slot {d.name}/{d.arity}: sort {sort} is declared in a higher "
                             f"layer ({sorts[sort].where})")
            used.add(sort)
    for s in sorts.values():
        if s.name not in used:
            raise LError(s.where, s.line, f"sort {s.name}: no slot uses it")
    for d in declared.values():
        check_say(d)
    computed = set(derived)
    for text in compiled(srcs, domains=False).values():
        computed |= wrapped(text)
    for d in results(srcs).values():
        if d.sig not in computed:
            raise LError(d.where, d.line, f"result {d.name}/{d.arity}: no rule computes it")
        if d.arity and d.args is None:
            raise LError(d.where, d.line, f"result {d.name}/{d.arity}: its arguments have no sorts; "
                         f"write `result {d.name}(Arg: sort, ...)`")
        for _, sort in d.args or []:
            if sort not in sorts:
                raise LError(d.where, d.line, f"result {d.name}/{d.arity}: no sort named {sort}")
        check_say(d)
    labels(srcs)
    check_hypothetical(srcs, declared)
    case_parts = {p.name for src in srcs.values() for p in src.decls(Part) if p.kind == "case"}
    for src in srcs.values():
        for p in src.decls(Part):
            if p.of and (p.kind not in ("switch", "candidate") or p.of not in case_parts):
                raise LError(p.where, p.line, f"part {p.name}: `of {p.of}` names no case"
                             if p.of not in case_parts else f"part {p.name}: only a switch or a candidate names its case")
    for src in srcs.values():
        for u in src.decls(Use):
            if u.sig not in declared and u.sig not in derived:
                raise LError(u.where, u.line, f"use {u.name}/{u.arity}: no file declares or derives it")


def check_say(d: Slot | Result) -> None:
    """SY: a slot's or a result's `say` names each of its arguments once, and
    nothing else."""
    k = d.keyword
    if "say" not in d.attrs:
        raise LError(d.where, d.line, f"{k} {d.name}/{d.arity} has no `say`")
    names = re.findall(r"\{([^{}]*)\}", d.attrs["say"])
    args = [a for a, _ in d.args or []]
    unknown = [n for n in names if n not in args]
    if unknown:
        raise LError(d.where, d.line, f"{k} {d.name}/{d.arity}: `say` names no argument {unknown[0]}")
    for a in args:
        if names.count(a) != 1:
            raise LError(d.where, d.line, f"{k} {d.name}/{d.arity}: `say` names {a} "
                         f"{'twice' if names.count(a) > 1 else 'never'}")


def check_hypothetical(srcs: dict[str, Source], declared: dict) -> None:
    """CG5, rule 6: a slot declared `hypothetical` is written only in a part
    whose `#program` line is marked HYPOTHETICAL."""
    from . import engine
    hyp = {sig for sig, d in declared.items() if "hypothetical" in d.attrs}
    if not hyp:
        return
    for src in srcs.values():
        for item in src.items:
            if not isinstance(item, Fence):
                continue
            written = engine.signatures("\n".join(item.lines), src.name)["heads"] & hyp
            if not written:
                continue
            first = item.lines[0] if item.lines else ""
            if not (first.startswith("#program") and "HYPOTHETICAL" in first):
                n, a = sorted(written)[0]
                where = re.match(r"^#program\s+(\w+)", first)
                raise LError(src.name, item.line, f"{n}/{a} is hypothetical: written only in a part marked "
                             f"HYPOTHETICAL on its #program line, not in "
                             f"{'part ' + where.group(1) if where else 'the file outside its parts'} (rule 6)")


def say(d: Slot | Result, values: list[str]) -> str:
    """The slot's or result's sentence, its arguments filled in."""
    out = d.attrs["say"]
    for (a, _), v in zip(d.args or [], values):
        out = out.replace("{" + a + "}", v)
    return out


_SIDES: dict = {}


def sides(l_dir: pathlib.Path = L_DIR) -> dict[tuple[str, int], str]:
    """The side of a case each slot goes on: theology, canon or either, from
    the layer of the file that declares it. Read by save_case."""
    if l_dir not in _SIDES:
        _SIDES[l_dir] = {sig: d.side for sig, d in slots(sources(l_dir)).items()}
    return _SIDES[l_dir]


def sources(l_dir: pathlib.Path = L_DIR) -> dict[str, Source]:
    """Every .l file, by the name of the rule file it compiles to."""
    out = {}
    for f in sorted(l_dir.glob("*.l")):
        out[f.stem + ".lp"] = parse(f.read_text(), f.name)
    return out


def build(l_dir: pathlib.Path = L_DIR) -> dict[str, str]:
    """The compiled rule files, by name."""
    return compiled(sources(l_dir))


def check(l_dir: pathlib.Path = L_DIR, lp_dir: pathlib.Path = LP_DIR,
          runtimes_json: pathlib.Path = RUNTIMES_JSON) -> list[str]:
    """The compiled files that differ from what their sources compile to
    (the rule files and runtimes.json), and any rule file with no source."""
    srcs = sources(l_dir)
    validate(srcs)
    built = compiled(srcs)
    bad = [name for name, text in built.items()
           if not (lp_dir / name).is_file() or (lp_dir / name).read_text() != text]
    bad += [f.name for f in sorted(lp_dir.glob("*.lp")) if f.name not in built]
    rt = runtimes_text(compile_runtimes(srcs))
    if not runtimes_json.is_file() or runtimes_json.read_text() != rt:
        bad.append(runtimes_json.name)
    return sorted(bad)


def main(argv=None):
    ap = argparse.ArgumentParser(prog="ttc-l", description="Compile L to the rule files, check them, "
                                 "or write the slots and sorts as a GBNF grammar.")
    ap.add_argument("command", choices=["build", "check", "gbnf"])
    ap.add_argument("--side", choices=["theology", "canon"], help="gbnf: the slots a case of this side enters")
    ap.add_argument("--slot", action="append", default=None, metavar="NAME/N",
                    help="gbnf: only this slot (repeatable)")
    ap.add_argument("--l", type=pathlib.Path, default=L_DIR, help="the sources (default: the package's l/)")
    ap.add_argument("--lp", type=pathlib.Path, default=LP_DIR, help="the rule files (default: the package's lp/)")
    a = ap.parse_args(argv)
    try:
        if a.command == "gbnf":
            from . import gbnf
            validate(sources(a.l))
            try:
                sys.stdout.write(gbnf.grammar(a.side, set(a.slot) if a.slot else None, sources(a.l)))
            except ValueError as exc:
                print(f"refused: {exc}", file=sys.stderr)
                return 2
            return 0
        if a.command == "build":
            srcs = sources(a.l)
            validate(srcs)
            outputs = {a.lp / name: text for name, text in compiled(srcs).items()}
            outputs[RUNTIMES_JSON] = runtimes_text(compile_runtimes(srcs))
            for p, text in outputs.items():
                if not p.is_file() or p.read_text() != text:
                    p.write_text(text)
                    print(f"wrote {p.name}")
            return 0
        bad = check(a.l, a.lp)
        for name in bad:
            print(f"differs from its source: {name}")
        if not bad:
            print(f"{len(build(a.l))} rule files and the runtimes, each as its source compiles")
        return 1 if bad else 0
    except LError as exc:
        print(f"refused: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
