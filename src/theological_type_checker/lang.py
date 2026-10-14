"""L: the language of the libraries, compiled to clingo (TTC-L).

An ``.l`` file is a sequence of declarations and fenced clingo, one per
rule file in ``l/``. ``ttc-l build`` compiles them to ``lp/``; the compiled
files stay checked in and are what the solver reads. ``ttc-l check`` fails
on any byte of difference between the sources and the compiled base. It
guards against hand edits; it is not evidence that the base is right.

Each kind of declaration is a class with a parse, a check and a render:
the compiler's metaclasses, registered by keyword. A fence is copied byte
for byte and never read, except that a ``part`` annotation must stand
before a fence opening with ``#program``.
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

# Layers, lowest first (TTC-L, THE LANGUAGE). A slot is declared in the
# lowest layer whose rules read it; sides for a case follow the layer.
LAYERS = ["kernel", "theory", "schools", "authority", "libraries", "canon", "pair", "library"]
SIDE = {"kernel": "theology", "theory": "theology", "schools": "theology", "authority": "theology",
        "libraries": "theology", "canon": "canon", "pair": "canon", "library": "either"}

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


class Slot(Decl):
    """A predicate the base reads and never derives, declared once, in the
    lowest layer whose rules read it. Renders its `@input` tag."""
    keyword = "slot"
    attributes = ("means", "say")

    def parse(self, head):
        m = SIG.match(head)
        if not m:
            raise LError(self.where, self.line, f"expected name/arity, got {head!r}")
        self.name, self.arity = m.group(1), int(m.group(2))

    @property
    def sig(self):
        return (self.name, self.arity)

    def render(self):
        if "means" not in self.attrs:
            raise LError(self.where, self.line, f"slot {self.name}/{self.arity} has no `means`")
        return [f"% @input {self.name}/{self.arity} | {self.attrs['means']}"]


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

    def compile(self) -> str:
        lines = [line for item in self.items for line in item.render()]
        return "\n".join(lines) + "\n"

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


def sources(l_dir: pathlib.Path = L_DIR) -> dict[str, Source]:
    """Every .l file, by the name of the rule file it compiles to."""
    out = {}
    for f in sorted(l_dir.glob("*.l")):
        out[f.stem + ".lp"] = parse(f.read_text(), f.name)
    return out


def build(l_dir: pathlib.Path = L_DIR) -> dict[str, str]:
    """The compiled rule files, by name."""
    return {name: src.compile() for name, src in sources(l_dir).items()}


def check(l_dir: pathlib.Path = L_DIR, lp_dir: pathlib.Path = LP_DIR,
          runtimes_json: pathlib.Path = RUNTIMES_JSON) -> list[str]:
    """The compiled files that differ from what their sources compile to
    (the rule files and runtimes.json), and any rule file with no source."""
    srcs = sources(l_dir)
    built = {name: src.compile() for name, src in srcs.items()}
    bad = [name for name, text in built.items()
           if not (lp_dir / name).is_file() or (lp_dir / name).read_text() != text]
    bad += [f.name for f in sorted(lp_dir.glob("*.lp")) if f.name not in built]
    rt = runtimes_text(compile_runtimes(srcs))
    if not runtimes_json.is_file() or runtimes_json.read_text() != rt:
        bad.append(runtimes_json.name)
    return sorted(bad)


def main(argv=None):
    ap = argparse.ArgumentParser(prog="ttc-l", description="Compile L to the rule files, or check them.")
    ap.add_argument("command", choices=["build", "check"])
    ap.add_argument("--l", type=pathlib.Path, default=L_DIR, help="the sources (default: the package's l/)")
    ap.add_argument("--lp", type=pathlib.Path, default=LP_DIR, help="the rule files (default: the package's lp/)")
    a = ap.parse_args(argv)
    try:
        if a.command == "build":
            srcs = sources(a.l)
            outputs = {a.lp / name: src.compile() for name, src in srcs.items()}
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
