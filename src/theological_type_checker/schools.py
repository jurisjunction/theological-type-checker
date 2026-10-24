"""The school runtimes booted alone and in pairs (TTC-SCHOOLS(7)).

    python -m theological_type_checker.schools            # tables, encoding B (DH 1330 a Thomist reading)
    python -m theological_type_checker.schools --dh1330   # encoding A (DH 1330 deposit)

Boot: run the boot set with a runtime in place of default; a scenario changes
when its violations change (in any branch) and is red when its checks fail.
Pair: a clash is a violation present under two runtimes and under neither alone.
"""
import contextlib
import itertools
import re
import sys

from . import engine as E
from . import suite

SCHOOLS = ["thomist", "scotist", "suarezian", "palamite"]
TONGUES = ["saussure", "vocal", "lingual"]       # booted alone (TTC-LINGUAE M1), never paired
DH1330_DEPOSIT = "distinction(opposition)."      # encoding A, in every solve (part dh1330_deposit, everywhere)


def school_parts() -> set[str]:
    meta = set(re.findall(r"(?m)^#program\s+(\w+)", (E.LP_DIR / "icon_metaphysics.lp").read_text()))
    own = set(re.findall(r"(?m)^#program\s+(\w+)", (E.LP_DIR / "schools.lp").read_text()))
    return meta | own | {"monopatrism", "palamite_energies", "cand_energies_unwarranted", "no_divine_contraction",
                         "distinction_opposition", "distinction_mode", "theses_1914", "theses_directive"}


def boot_set() -> list[dict]:
    sp = school_parts()
    # the stamped boot set (TTC-SCHOOLS): scenarios written later (RT, AC, LW, CR, MR, CX, PC, CO, PN, SAE, CC, SRC, LIT, NOV, EMP, LIN) are not in it
    return [s for s in suite.S if s["group"] not in (suite.RT, suite.AC, suite.LW, suite.CR, suite.MR, suite.CX, suite.PC, suite.CO,
                                                       suite.PN, suite.SAE, suite.CC, suite.SRC, suite.LIT, suite.NOV, suite.EMP,
                                                       suite.LIN)
            and not (sp & set(s["parts"]))]


def encoding(deposit_opposition: bool):
    return E.rule_change(add=DH1330_DEPOSIT) if deposit_opposition else contextlib.nullcontext()


def _models(r, mode):
    if mode in ("all", "branches") and r.get("all_models"):
        return r["all_models"]
    return [r["atoms"]]


def run(s, runtimes=()):
    """(per-branch violation sets, union of violations, checks pass) for one scenario."""
    parts = list(s["parts"]) + [f"rt_{x}" for x in runtimes]
    try:
        r = E.solve(parts, s["mode"], facts=s.get("facts", ""))
        ok = all(c(r)[0] for c in s["checks"])
    except Exception as exc:                       # a check that cannot read the result is red
        return frozenset(), frozenset({f"ERROR {type(exc).__name__}"}), False
    branches = frozenset(frozenset(a for a in m if a.startswith("violation(")) for m in _models(r, s["mode"]))
    return branches, frozenset().union(*branches) if branches else frozenset(), ok


class Experiment:
    def __init__(self, deposit_opposition=False, scenarios=None):
        self.a = deposit_opposition
        self.scen = scenarios if scenarios is not None else boot_set()
        self._cache = {}

    def results(self, runtimes=()):
        key = tuple(sorted(runtimes))
        if key not in self._cache:
            with encoding(self.a):
                self._cache[key] = {s["id"]: run(s, key) for s in self.scen}
        return self._cache[key]

    def boot(self, runtime):
        base, got = self.results(), self.results((runtime,))
        changed = sorted(i for i in got if got[i][0] != base[i][0])
        red = sorted(i for i in got if not got[i][2])
        return dict(changed=changed, red=red)

    def clashes(self, r1, r2):
        one, two, both = self.results((r1,)), self.results((r2,)), self.results((r1, r2))
        out = {}
        for i in both:
            for v in both[i][1] - one[i][1] - two[i][1]:
                out.setdefault(v[len("violation("):].split("(")[0], set()).add(i)
        return {k: sorted(v) for k, v in sorted(out.items())}


def main(argv=None):
    argv = sys.argv[1:] if argv is None else argv
    x = Experiment("--dh1330" in argv)
    print(f"boot set: {len(x.scen)} scenarios; DH 1330 {'deposit (A)' if x.a else 'a Thomist reading (B)'}")
    bare = x.boot("bare")
    print(f"\nbare      changed {bare['changed']}\n          red     {bare['red']}")
    for r in SCHOOLS + TONGUES:
        b = x.boot(r)
        print(f"{r:9} changed {b['changed']}\n          red     {b['red']}")
    print()
    for r1, r2 in itertools.combinations(SCHOOLS, 2):
        c = x.clashes(r1, r2)
        print(f"{r1} + {r2}: " + ("; ".join(f"{k} ({len(v)})" for k, v in c.items()) or "no clash"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
