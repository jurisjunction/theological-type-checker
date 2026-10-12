"""The norm graph: which canons feed which, read off the rule files.

Rules in a canon-law file are grouped under tags:

    % @norm <id> | <citation> | <source URL>
    % @input <name>/<arity> | <meaning>

Every rule after a ``@norm`` tag belongs to that norm until the next tag.
Norm A *feeds* norm B when a predicate A derives appears in the body of a
rule of B. That gives a directed graph (a DAG, if the law is well founded),
plus three checks:

* cycles: norms that feed each other in a loop
* undefined: predicates used in a rule body that no rule derives and no
  ``@input`` declares (usually a canon not yet encoded: the frontier)
* inputs never used: declared slots no rule reads

``% @end`` closes the current norm (for display rules),
``% @temporal <id>`` marks a norm whose effects fall only on later acts, so
that a loop through it is recursion over time, not circularity, and
``% @recursive <id>`` marks a norm that defines one person's delict by
another's (c. 1329, complicity), so that a loop through it is recursion over
persons, not circularity.
"""
from __future__ import annotations

import re
from collections import defaultdict

from . import engine

CANON_PREFIX = "canon_"
BUILTIN = {"asof", "custom_asof", "not", "false"}
TAG_NORM = re.compile(r"^%\s*@norm\s+(\S+)\s*\|\s*([^|]*?)\s*(?:\|\s*(\S+))?\s*$")
TAG_INPUT = re.compile(r"^%\s*@input\s+(\w+)/(\d+)\s*\|\s*(.*)$")
TAG_END = re.compile(r"^%\s*@end\b")
TAG_TEMPORAL = re.compile(r"^%\s*@(?:temporal|recursive)\s+(\S+)")


def _split_top(s: str, sep: str = ","):
    out, depth, cur = [], 0, ""
    for ch in s:
        if ch in "({[":
            depth += 1
        elif ch in ")}]":
            depth -= 1
        if ch == sep and depth == 0:
            out.append(cur)
            cur = ""
        else:
            cur += ch
    out.append(cur)
    return [x.strip() for x in out if x.strip()]


def _atoms(text: str):
    """(name, arity, negated) for every atom at the top level of a rule part."""
    found = []
    for lit in _split_top(text):
        lit = lit.strip()
        neg = lit.startswith("not ")
        if neg:
            lit = lit[4:].strip()
        lit = lit.strip("{} ")
        for piece in _split_top(lit, ";"):
            m = re.match(r"([a-z_]\w*)\s*(\((.*)\))?\s*$", piece.split(":")[0].strip())
            if not m:
                continue
            name = m.group(1)
            arity = len(_split_top(m.group(3))) if m.group(3) is not None else 0
            if name in BUILTIN or name[0].isupper():
                continue
            found.append((name, arity, neg))
    return found


def parse(texts: dict[str, str] | None = None):
    """Parse every canon-law file: norms, their rules, inputs."""
    texts = texts if texts is not None else engine.base_texts()
    norms, inputs, rules, temporal = {}, {}, [], set()
    for f, text in texts.items():
        if "@norm" not in text and "@library" not in text:
            continue
        current = None
        stmt = ""
        for line in text.splitlines():
            m = TAG_NORM.match(line.strip())
            if m:
                current = m.group(1)
                norms[current] = {"id": current, "citation": m.group(2).strip(), "source": m.group(3) or "", "file": f}
                continue
            if TAG_END.match(line.strip()):
                current = None
                continue
            m = TAG_TEMPORAL.match(line.strip())
            if m:
                temporal.add(m.group(1))
                continue
            m = TAG_INPUT.match(line.strip())
            if m:
                inputs[(m.group(1), int(m.group(2)))] = m.group(3).strip()
                continue
            if line.strip().startswith("#program"):
                current = None
                stmt = ""
                continue
            code = re.sub(r"%.*", "", line)
            if not code.strip():
                continue
            stmt += " " + code
            if re.search(r"\.\s*$", code):
                rules.append((current, f, stmt.strip()))
                stmt = ""
    return norms, inputs, rules, temporal


def pathlib_name(f: str) -> str:
    return f.rsplit("/", 1)[-1]


def graph(texts=None):
    norms, inputs, rules, temporal = parse(texts)
    derives = defaultdict(set)      # predicate -> norms deriving it
    uses = defaultdict(set)         # norm -> body predicates
    produced, used = set(), set()
    for norm, f, stmt in rules:
        body = ""
        head = stmt.rstrip(".")
        if ":-" in stmt:
            head, body = stmt.rstrip(".").split(":-", 1)
        for name, ar, _ in _atoms(head):
            if name in ("violation", "info"):
                continue
            produced.add((name, ar))
            if norm:
                derives[(name, ar)].add(norm)
        for name, ar, _ in _atoms(body):
            used.add((name, ar))
            if norm:
                uses[norm].add((name, ar))
    edges = set()
    for b, preds in uses.items():
        for p in preds:
            for a in derives.get(p, ()):
                if a != b:
                    edges.add((a, b))
    undefined = sorted(f"{n}/{a}" for n, a in used if (n, a) not in produced and (n, a) not in inputs)
    unused_inputs = sorted(f"{n}/{a}" for n, a in inputs if (n, a) not in used)
    return {"norms": norms, "edges": sorted(edges), "undefined": undefined, "temporal": sorted(temporal),
            "unused_inputs": unused_inputs, "inputs": {f"{n}/{a}": d for (n, a), d in sorted(inputs.items())}}


def cycles(edges):
    adj = defaultdict(list)
    for a, b in edges:
        adj[a].append(b)
    seen, stack, found = set(), [], []

    def visit(n, path):
        if n in path:
            cyc = path[path.index(n):] + [n]
            if sorted(cyc) not in [sorted(c) for c in found]:
                found.append(cyc)
            return
        if n in seen:
            return
        seen.add(n)
        for m in adj[n]:
            visit(m, path + [n])

    for n in list(adj):
        visit(n, [])
    return found


def check(texts=None):
    """Cycles (vicious, or recursion through a @temporal or @recursive norm),
    undefined predicates (the frontier) and unused inputs."""
    g = graph(texts)
    loops = cycles(g["edges"])
    temporal = set(g["temporal"])
    return {"norms": len(g["norms"]), "edges": len(g["edges"]),
            "vicious_cycles": [c for c in loops if not temporal & set(c)],
            "temporal_loops": [c for c in loops if temporal & set(c)],
            "undefined_predicates": g["undefined"], "unused_inputs": g["unused_inputs"]}


def mermaid(texts=None, focus: str | None = None):
    g = graph(texts)
    edges = g["edges"]
    if focus:
        keep = {focus} | {a for a, b in edges if b == focus} | {b for a, b in edges if a == focus}
        edges = [(a, b) for a, b in edges if a in keep and b in keep]
    ids = {n: f"n{i}" for i, n in enumerate(sorted(g["norms"]))}
    lines = ["graph LR"]
    for n, meta in sorted(g["norms"].items()):
        if focus and n not in {x for e in edges for x in e} and n != focus:
            continue
        label = n.replace('"', "'")
        lines.append(f'  {ids[n]}["{label}"]')
    for a, b in edges:
        lines.append(f"  {ids[a]} --> {ids[b]}")
    return "\n".join(lines)
