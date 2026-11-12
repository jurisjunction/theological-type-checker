"""The prover: why an atom holds, or why a value is excluded, read back from
one model as a well-founded proof (TTC-REPAIRS6 PV; ttc-say(1), PROOFS).

The program grounded is the one engine.solve grounds, with each rule
`H :- B` given a twin that records the rule instance when it fires,

    _why(Id, H, (positive body), (negated body)) :- B.

and each integrity constraint on holds/2 given a twin that records which
value it would remove,

    _kill(Id, holds(Q,V), (rest of the positive body), (negated body)) :- value(Q,V), rest of B.

The twins' atoms are hidden; nothing else is added, so the models are the
same (PV2). A proof explains each atom by a rule instance whose positive
body was proved at a lower level; a fact entered is a leaf, and so is a
negated literal: nothing derives it. Each step names where its rule stands
(file and line, and the norm or section it sits under) and is said through
its template where it has one.
"""
from __future__ import annotations

import re

import clingo
from clingo import ast

from . import engine, norms

SECTION = re.compile(r"^%\s*-{3,}\s*(.*?)\s*-*\s*$")
CHOSEN = "chosen: this branch"


def _line_labels(text: str) -> list[str]:
    """Per line of a rule file: the norm it sits under (citation [id]), else
    the section it sits in."""
    out, norm, section = [], None, None
    for line in text.splitlines():
        if m := norms.TAG_NORM.match(line):
            norm = f"{m.group(2).split(':', 1)[0]} [{m.group(1)}]"
        elif norms.TAG_END.match(line):
            norm = None
        elif (m := SECTION.match(line)) and m.group(1):
            section = m.group(1)
        out.append(norm or section or "")
    return out


class _Anon(ast.Transformer):
    """Name each anonymous variable (positive body), or make it the string "_" (negated)."""

    def __init__(self, as_string: bool = False):
        self.n, self.as_string = 0, as_string

    def visit_Variable(self, v):
        if v.name != "_":
            return v
        if self.as_string:
            return ast.SymbolicTerm(v.location, clingo.String("_"))
        self.n += 1
        return ast.Variable(v.location, f"Anon__{self.n}")


class _Twins:
    def __init__(self):
        self.where: dict[int, tuple[str, int, str]] = {}
        self.chosen: set[tuple[str, int]] = set()
        self.n = 0

    def _body(self, body):
        pos, neg, holds = [], [], None
        for i, lit in enumerate(body):
            if lit.ast_type != ast.ASTType.Literal or lit.atom.ast_type != ast.ASTType.SymbolicAtom:
                continue
            term = lit.atom.symbol
            if lit.sign == ast.Sign.NoSign:
                if holds is None and term.ast_type == ast.ASTType.Function and term.name == "holds" \
                        and len(term.arguments) == 2:
                    holds = (i, len(pos), term)
                pos.append(term)
            elif lit.sign == ast.Sign.Negation:
                neg.append(_Anon(as_string=True)(term))
        return pos, neg, holds

    def add(self, stm, bld, fname: str, labels: list[str]):
        bld.add(stm)
        if stm.ast_type != ast.ASTType.Rule:
            return
        loc, head = stm.location, stm.head
        line = loc.begin.line - 1                       # one #program line is prepended
        where = (fname, line, labels[line - 1] if 0 < line <= len(labels) else "")
        if head.ast_type == ast.ASTType.Aggregate:      # a choice: what it chooses is a leaf
            for el in head.elements:
                a = el.literal.atom
                if a.ast_type == ast.ASTType.SymbolicAtom and a.symbol.ast_type == ast.ASTType.Function:
                    self.chosen.add((a.symbol.name, len(a.symbol.arguments)))
            return
        stm = stm.update(body=[_Anon()(b) if b.ast_type == ast.ASTType.Literal and b.sign == ast.Sign.NoSign
                               else b for b in stm.body])
        pos, neg, holds = self._body(stm.body)
        tup = lambda xs: ast.Function(loc, "", list(xs), 0)          # noqa: E731
        num = lambda i: ast.SymbolicTerm(loc, clingo.Number(i))      # noqa: E731
        lit = lambda f: ast.Literal(loc, ast.Sign.NoSign, ast.SymbolicAtom(f))  # noqa: E731
        if head.ast_type == ast.ASTType.Literal and head.sign == ast.Sign.NoSign \
                and head.atom.ast_type == ast.ASTType.SymbolicAtom:
            self.n += 1
            self.where[self.n] = where
            why = ast.Function(loc, "_why", [num(self.n), head.atom.symbol, tup(pos), tup(neg)], 0)
            bld.add(ast.Rule(loc, lit(why), stm.body))
        elif head.ast_type == ast.ASTType.Literal and head.atom.ast_type == ast.ASTType.BooleanConstant \
                and holds is not None:
            bi, pi, term = holds
            self.n += 1
            self.where[self.n] = where
            value = lit(ast.Function(loc, "value", list(term.arguments), 0))
            body = [value] + [b for i, b in enumerate(stm.body) if i != bi]
            rest = [p for i, p in enumerate(pos) if i != pi]
            kill = ast.Function(loc, "_kill", [num(self.n), term, tup(rest), tup(neg)], 0)
            bld.add(ast.Rule(loc, lit(kill), body))


def _ground(parts: list[str], facts: str):
    unknown = [p for p in parts if p not in engine.known_parts() and not engine.is_runtime(p)]
    if unknown:
        raise engine.SnippetError(f"unknown part(s): {', '.join(unknown)}", "parts", "parts", text=", ".join(unknown))
    facts = engine.check_snippet(facts) if facts else ""
    if facts:
        engine.conclusion_gate(facts)
    tw = _Twins()
    ctl = clingo.Control(["--models=0"], logger=lambda code, msg: None)
    texts = dict(engine.base_texts())
    if marks := engine.runtime_facts(parts):
        texts["<runtimes>"] = marks
    if extra := engine._ADD.get():
        texts["<added>"] = extra
    with ast.ProgramBuilder(ctl) as bld:
        for fname, text in texts.items():
            labels = _line_labels(text)
            ast.parse_string("#program base.\n" + text, lambda s, f=fname, l=labels: tw.add(s, bld, f, l))
        if facts:
            ast.parse_string("#program user.\n" + facts, lambda s: tw.add(s, bld, "<case>", [""] * len(facts.splitlines())))
    ctl.ground([("base", [])] + [(p, []) for p in engine.expand_runtimes(parts)] + ([("user", [])] if facts else []))
    return tw, ctl


class Proof:
    """Proofs of atoms in one model of the base plus parts and facts."""

    def __init__(self, tw: _Twins, model: list[clingo.Symbol]):
        self.tw = tw
        self.true = {s for s in model if s.name not in ("_why", "_kill")}
        self.kills = [s for s in model if s.name == "_kill"]
        entries: dict = {}
        for s in model:
            if s.name == "_why" and len(s.arguments) == 4:
                rid, head, pos, neg = s.arguments
                entries.setdefault(head, []).append((rid.number, tuple(pos.arguments), tuple(neg.arguments)))
        level: dict = {}
        changed = True
        while changed:                                  # least fixpoint: proved at a level, from below
            changed = False
            for head, es in entries.items():
                for _, pos, _ in es:
                    if all(p in level for p in pos):
                        lv = 1 + max((level[p] for p in pos), default=0)
                        if lv < level.get(head, lv + 1):
                            level[head] = lv
                            changed = True
        self.best = {}
        for head, es in entries.items():
            cands = [(1 + max((level[p] for p in pos), default=0), rid, pos, neg)
                     for rid, pos, neg in es if all(p in level for p in pos)]
            if cands:
                self.best[head] = min(cands, key=lambda c: (c[0], c[1], str(c[2]), str(c[3])))

    def where(self, rid: int) -> str:
        f, line, label = self.tw.where[rid]
        return f"{f}:{line}" + (f" ({label})" if label else "")

    def steps(self, atom: clingo.Symbol, depth: int = 0, seen: set | None = None) -> list[tuple[int, str, str]]:
        """(depth, atom, note) per step, depth first; each atom proved once."""
        seen = set() if seen is None else seen
        if atom not in self.true:
            return [(depth, str(atom), "not in this model")]
        if atom not in self.best:
            sig = (atom.name, len(atom.arguments))
            return [(depth, str(atom), CHOSEN if sig in self.tw.chosen else "derived by a rule the prover does not trace")]
        _, rid, pos, neg = self.best[atom]
        if not pos and not neg:
            return [(depth, str(atom), f"entered: {self.where(rid)}")]
        if atom in seen:
            return [(depth, str(atom), f"proved above: {self.where(rid)}")]
        seen.add(atom)
        out = [(depth, str(atom), f"rule {self.where(rid)}")]
        for p in pos:
            out += self.steps(p, depth + 1, seen)
        for n in neg:
            out.append((depth + 1, f"not {n}", "nothing derives it"))
        return out

    def exclusion(self, q: clingo.Symbol, v: clingo.Symbol):
        """The constraint that removes Q=V, and its body's proof; None if none does."""
        target = clingo.Function("holds", [q, v])
        for k in sorted(self.kills, key=str):
            if k.arguments[1] == target:
                rid = k.arguments[0].number
                out = []
                seen: set = set()
                for p in k.arguments[2].arguments:
                    out += self.steps(p, 1, seen)
                for n in k.arguments[3].arguments:
                    out.append((1, f"not {n}", "nothing derives it"))
                return self.where(rid), out
        return None


def prove(parts: list[str], facts: str = "", atoms=(), excluded=(), max_models: int = 20000):
    """For each atom, a proof from the first model that holds it; for each
    Q=V, the constraint that removes it, from the first model where one would.
    Returns a list of (heading, where-or-None, steps)."""
    tw, ctl = _ground(list(parts), facts)
    want_atoms = [clingo.parse_term(a) for a in atoms]
    want_ex = []
    for qv in excluded:
        q, _, v = qv.partition("=")
        want_ex.append((qv, clingo.parse_term(q), clingo.parse_term(v)))
    found: dict = {}
    count = 0
    with ctl.solve(yield_=True) as handle:
        for m in handle:
            count += 1
            syms = m.symbols(atoms=True)
            pending = [a for a in want_atoms if str(a) not in found] + [e for e in want_ex if e[0] not in found]
            if not pending:
                break
            proof = None
            for a in want_atoms:
                if str(a) not in found and a in set(syms):
                    proof = proof or Proof(tw, syms)
                    found[str(a)] = (f"WHY {a}", None, proof.steps(a))
            for qv, q, v in want_ex:
                if qv not in found:
                    proof = proof or Proof(tw, syms)
                    ex = proof.exclusion(q, v)
                    if ex:
                        found[qv] = (f"WHY {qv} IS EXCLUDED", ex[0], ex[1])
            if count >= max_models:
                break
    out = []
    for a in want_atoms:
        out.append(found.get(str(a), (f"WHY {a}", None, [(0, str(a), "in no model")])))
    for qv, _, _ in want_ex:
        out.append(found.get(qv, (f"WHY {qv} IS EXCLUDED", None,
                                  [(0, qv, "no integrity constraint on a branch removes it in any model")])))
    return out
