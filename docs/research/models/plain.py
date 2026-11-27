"""A plain model of causae.lp's availability and reports, for a sketch only.

Reads the case blocks of the compiled icon_history.lp (read-only), grounds each
block's facts with clingo, and computes, over the 1,024 horizons of the ten
cause parts, the reports without_reason, sole_reason and contrary_reasoned.
Hearing, the VM and authority's withdrawals are not modelled.
"""
import itertools, json, re, sys
from pathlib import Path
import clingo

ROOT = Path(__file__).resolve().parents[3]   # docs/research/models/ -> the repository

LP = ROOT / "src/theological_type_checker/lp/icon_history.lp"
RT = ROOT / "src/theological_type_checker/runtimes.json"

PARTS = [("ends_in_nature", ("final", "nature")), ("forms_in_nature", ("formal", "nature")),
         ("ends_by_god_physics", ("final", "god_physics")), ("ends_by_god_ethics", ("final", "god_ethics")),
         ("ends_of_human_nature", ("final", "human")), ("soul_as_form", ("formal", "human")),
         ("ends_desired", ("final", "will")), ("self_preservation", ("final", "self")),
         ("object_as_form", ("formal", "will")), ("form_of_law", ("formal", "reason"))]
EXTRA = []   # extra parts (e.g. an art domain), appended by a caller


def blocks():
    text = open(LP).read()
    out, name, buf = {}, None, []
    for line in text.splitlines():
        m = re.match(r"#program (\w+)\.", line)
        if m:
            if name:
                out[name] = "\n".join(buf)
            name, buf = m.group(1), []
        else:
            buf.append(line)
    if name:
        out[name] = "\n".join(buf)
    return out


def ground_facts(text):
    ctl = clingo.Control(["--warn=none"])
    ctl.add("base", [], text)
    ctl.ground([("base", [])])
    atoms = [a.symbol for a in ctl.symbolic_atoms if a.is_fact]
    return atoms


def case_from_atoms(atoms):
    args, af, rd, sup = {}, {}, {}, set()
    for s in atoms:
        n, a = s.name, [str(x) for x in s.arguments]
        if n == "argument" and len(a) == 4:
            args[a[0]] = (a[1], a[2], a[3])
        elif n == "argues_from" and len(a) == 3:
            af.setdefault(a[0], set()).add((a[1], a[2]))
        elif n == "reading_of" and len(a) == 2:
            rd.setdefault(a[1], set()).add(a[0])
        elif n == "supports" and len(a) == 3:
            sup.add((a[1], a[2]))
        elif n == "reads" and len(a) == 4:
            sup.add((a[2], a[3]))
    return {"args": args, "af": af, "rd": rd, "sup": sup}


def case_from_block(name, bl=None):
    bl = bl or blocks()
    return case_from_atoms(ground_facts(bl[name]))


def held_set(h):
    parts = PARTS + EXTRA
    held = {cd for (p, cd), on in zip(parts, h) if on}
    return held


def reports(case, h):
    held = held_set(h)
    def ok(r):
        return all(c in ("efficient", "material") or (c, d) in held for (c, d) in case["af"].get(r, set()))
    avail = {a for a in case["args"] if any(ok(r) for r in {a} | case["rd"].get(a, set()))}
    out = set()
    byv = {}
    for a, (s, q, v) in case["args"].items():
        byv.setdefault((q, v), []).append((a, s))
    reasoned = {(q, v) for (q, v), l in byv.items() if any(a in avail for a, _ in l)}
    for (q, v), l in byv.items():
        if (q, v) in case["sup"] and (q, v) not in reasoned:
            out.add(("without_reason", q, v))
            for (q2, v2) in reasoned:
                if q2 == q and v2 != v:
                    out.add(("contrary_reasoned", q, v, v2))
        bys = {}
        for a, s in l:
            bys.setdefault(s, []).append(a)
        for s, al in bys.items():
            if len(al) >= 2:
                av = [a for a in al if a in avail]
                if len(av) == 1:
                    out.add(("sole_reason", s, av[0], q, v))
    return frozenset(out)


def runtime_horizons():
    r = json.load(open(RT))["runtimes"]
    parts = PARTS + EXTRA
    return {k: tuple(p in v for p, _ in parts) for k, v in r.items()}


def all_horizons():
    return list(itertools.product([False, True], repeat=len(PARTS) + len(EXTRA)))


def diagram(cases, horizons=None, rts=None):
    horizons = horizons or all_horizons()
    rts = rts or runtime_horizons()
    sig = {h: tuple(reports(c, h) for c in cases) for h in horizons}
    phases = {}
    for h, s in sig.items():
        phases.setdefault(s, []).append(h)
    # order parameters: parts on which flipping changes the signature somewhere
    n = len(PARTS) + len(EXTRA)
    ops = []
    for i in range(n):
        for h in horizons:
            h2 = tuple((not x) if j == i else x for j, x in enumerate(h))
            if sig[h] != sig[h2]:
                ops.append((PARTS + EXTRA)[i][0]); break
    rt_phase = {}
    for k, h in rts.items():
        rt_phase.setdefault(sig[h], []).append(k)
    return {"order_parameters": ops, "phases": len(phases), "holding_runtime": len(rt_phase),
            "rt_phase": rt_phase, "sig": sig, "phase_sizes": {s: len(v) for s, v in phases.items()}}


if __name__ == "__main__":
    bl = blocks()
    three = [case_from_block(n, bl) for n in ("modernity_property", "pendet", "soap")]
    four = three + [case_from_block("mendacium", bl)]
    for label, cs in (("three", three), ("four", four),
                      ("five", three + [case_from_block(n, bl) for n in ("pendet_thomas", "locke_essence")]),
                      ("seven", four + [case_from_block(n, bl) for n in ("pendet_thomas", "locke_essence")])):
        d = diagram(cs)
        print(label, len(d["order_parameters"]), d["phases"], d["holding_runtime"])
    d = diagram([case_from_block("mendacium", bl)])
    print("mendacium alone", d["order_parameters"], d["phases"], d["holding_runtime"])
