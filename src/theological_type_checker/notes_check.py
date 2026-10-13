"""TTC-COMMUNION NT1: the note of a value and the status of its question's
other values agree, in every main branch of a run.

A branch is compared only with branches of the same world: the same claims of
the ordinary universal magisterium and their grades, the same readings, the
same force of tier 2, and the same values on every other question. Juridical
questions carry no note. A value fixed by a default (default/2), with no
source, carries none and has no main contrary: reported apart, as `defaults`.
"""
from __future__ import annotations

import collections

from .engine import solve, split_args

GRADES = {"de_fide", "definitive", "authentic"}


# a creed's reception, claimed and computed both ways, is a claim of the same
# kind as the ordinary universal magisterium's (TTC-SAECULUM RC1)
RECEPTION = ("assumed_fact(received(", "assumed_fact(false(received(")
ATTRIBUTION = ("assumed_fact(attributed(", "assumed_fact(false(attributed(")   # TTC-SOURCES: a claim, like reception


def _world(b):
    return (tuple(sorted(a for a in b["assume"] if a.startswith(("oum_holds(", "graded(", "read_as(") + RECEPTION + ATTRIBUTION))), b["t2"])


def _rest(b, q):
    return tuple(sorted(v for v in b["values"] if not v.startswith(q + "=")))


def facts(parts):
    """values, question kinds and defaults of a run"""
    vals, kind, default = collections.defaultdict(set), collections.defaultdict(set), set()
    for a in {x for m in solve(parts, "all", show=("value/2", "question_kind/2", "default/2"))["all_models"] for x in m}:
        name, args = split_args(a)
        if name == "value":
            vals[args[0]].add(args[1])
        elif name == "question_kind":
            kind[args[0]].add(args[1])
        elif name == "default":
            default.add(args[0])
    return vals, kind, default


def _plain(b):
    return (tuple(sorted(a for a in b["assume"] if a.startswith(("oum_holds(", "graded(") + RECEPTION + ATTRIBUTION))), b["t2"])


def check(parts, with_defaults=False, categories=False):
    """the failures of NT1 in a run. With categories, every disagreement is returned
    as (kind, ...): "fail"; "refused" (a branch carrying a violation, not compared);
    "default" (a value fixed by default/2, with no source);
    "excluded" (the other value has no branch in this world at all: a constraint
    between questions or a switch excludes it, not a note)."""
    r = solve(list(parts) + ["report_notes"], "branches")
    bs = r["branches"]
    vals, kind, default = facts(list(parts))
    out = []
    for b in bs:
        if b["status"] != "main":
            continue
        if any(f.startswith("violation(") for f in b["facts"]):
            out.append(("refused", tuple(sorted(f for f in b["facts"] if f.startswith("violation(")))[:1]))
            continue
        noted = {}
        for f in b["facts"]:
            if f.startswith("info(note("):
                q, v, g = split_args(f[len("info("):-1])[1]
                noted[q] = (v, g)
        for val in b["values"]:
            q, v = val.split("=", 1)
            if kind.get(q) != {"doctrinal"} or len(vals[q]) < 2:   # a kind left open is not compared
                continue
            if q in noted:
                g = noted[q][1]
                for w in vals[q] - {v}:
                    same = [c for c in bs if _world(c) == _world(b) and _rest(c, q) == _rest(b, q) and f"{q}={w}" in c["values"]]
                    anyrest = [c for c in bs if _world(c) == _world(b) and f"{q}={w}" in c["values"]]
                    sts = {c["status"] for c in same}
                    if g == "de_fide":
                        ok = not sts
                    elif not same:
                        out.append(("excluded", q, v, g, w))
                        continue
                    elif g == "definitive":
                        ok = sts == {"counterfactual_shadow" if b["t2"] else "live_shadow"}
                    else:
                        ok = sts == {"live_shadow"}
                    if not ok:
                        out.append(("fail", q, v, g, w, tuple(sorted(sts))))
            else:
                others = [c for c in bs if _plain(c) == _plain(b) and any(x.startswith(q + "=") and x != val for x in c["values"])]
                if any(c["status"] == "main" for c in others):
                    continue
                if q in default:
                    out.append(("default", q, v))
                elif not others:
                    out.append(("excluded", q, v, "none"))
                else:
                    out.append(("fail", q, v, "none", tuple(sorted({c["status"] for c in others}))))
    out = sorted(set(out))
    if categories:
        return out
    return [o for o in out if o[0] == "fail" or (with_defaults and o[0] == "default")]
