"""Build marriage_consent_scenarios.json: one scenario per rule, in the shape
save_scenario takes, and verify each passes with the layer and fails without it
(CLAUDE.md rule 5). Run from the checker's checkout:

    python3 make_scenarios.py path/to/marriage_consent.lp path/to/marriage_consent_cases.lp
"""
import json, sys
from theological_type_checker import engine, suite

rules_path, cases_path = sys.argv[1], sys.argv[2]
RULES = open(rules_path).read()
CASES = open(cases_path).read()

def every(atom): return {"kind": "present", "atom": atom, "in": "every"}
def some(atom):  return {"kind": "present", "atom": atom, "in": "some"}
def none(atom):  return {"kind": "present", "atom": atom, "in": "none"}

SCEN = [
  ("PMC01", "c. 1095 1°: no use of reason, consent vitiated",            [every("info(ground(mc_1095_1,n1095_1,engaged))")]),
  ("PMC02", "c. 1095 2°: grave defect of discretion",                     [every("info(ground(mc_1095_2,n1095_2,engaged))")]),
  ("PMC03", "c. 1095 3°: incapacity to assume, psychic cause",            [every("info(ground(mc_1095_3,n1095_3,engaged))")]),
  ("PMC04", "a ground formulated with no claim under it is bare",         [every("info(ground(mc_1095_3,n1095_2,not_engaged))"), every("info(ground(mc_plain,n1101_total,not_engaged))")]),
  ("PMC05", "c. 1096: ignorance of the nature of marriage",               [every("info(ground(mc_1096,n1096,engaged))")]),
  ("PMC06", "c. 1097 §1: error of person",                                [every("info(ground(mc_1097_1,n1097_1,engaged))")]),
  ("PMC07", "c. 1097 §2: error of quality directly and principally intended", [every("info(ground(mc_1097_2,n1097_2,engaged))")]),
  ("PMC08", "c. 1097 §2: error merely causam dans engages nothing",       [every("info(ground(mc_1097_cd,n1097_2,not_engaged))")]),
  ("PMC09", "c. 1098: deceit to obtain consent, grave quality, after 1983", [every("info(ground(mc_1098,n1098,engaged))")]),
  ("PMC10", "c. 1098 before 1983: branches on the reading, neither preferred", [some("info(ground(mc_1098_old,n1098,engaged))"), some("info(ground(mc_1098_old,n1098,not_engaged))"), some("info(c1098_reading(mc_1098_old,merely_positive))")]),
  ("PMC11", "c. 1098: the quality's gravity disputed, both ways",         [some("info(ground(mc_1098_q,n1098,engaged))"), some("info(ground(mc_1098_q,n1098,not_engaged))")]),
  ("PMC12", "c. 1101 §2: total simulation",                               [every("info(ground(mc_1101_t,n1101_total,engaged))")]),
  ("PMC13", "c. 1101 §2: exclusion of the bonum prolis",                  [every("info(ground(mc_1101_p,n1101_prolis,engaged))")]),
  ("PMC14", "c. 1101 §2: exclusion of the bonum fidei",                   [every("info(ground(mc_1101_f,n1101_fidei,engaged))")]),
  ("PMC15", "c. 1101 §2: exclusion of the bonum sacramenti",              [every("info(ground(mc_1101_s,n1101_sacramenti,engaged))")]),
  ("PMC16", "c. 1101 §2: exclusion of the bonum coniugum",                [every("info(ground(mc_1101_c,n1101_coniugum,engaged))")]),
  ("PMC17", "c. 1101 §1: consent presumed where nothing is excluded, not where it is", [every("info(presumed_consent(a16,mc_plain))"), none("info(presumed_consent(a11,mc_1101_t))")]),
  ("PMC18", "c. 1102 §1: a future condition, 1983 law",                   [every("info(ground(mc_1102_fut,n1102_1,engaged))"), every("info(ground(mc_1102_fut_old,n1102_1,not_engaged))")]),
  ("PMC19", "c. 1102 §2: past condition unfulfilled; present fulfilled",  [every("info(ground(mc_1102_past,n1102_2,engaged))"), every("info(ground(mc_1102_pres,n1102_2,not_engaged))")]),
  ("PMC20", "c. 1102 §2: fulfilment disputed, both ways",                 [some("info(ground(mc_1102_disp,n1102_2,engaged))"), some("info(ground(mc_1102_disp,n1102_2,not_engaged))")]),
  ("PMC21", "c. 1103 named as a ground; the fear claim disputed, both ways", [some("info(ground(mc_1103,n1103,engaged))"), some("info(ground(mc_1103,n1103,not_engaged))")]),
  ("PMC22", "the consent canons leave the form alone; no violation raised", [none("info(marriage(mc_1095_2,invalid_form))"), none("violation(interior_of_fiction(a2,mc_1095_2))")]),
]

def run(facts):
    return engine.solve([], "branches", facts=facts, max_models=2000)

ok_all = True
out = []
r_with = run(RULES + "\n" + CASES)
r_without = run(CASES)
for sid, name, expect in SCEN:
    checks = [suite._expect_check(e) for e in expect]
    with_ok = all(c(r_with)[0] for c in checks)
    without_ok = all(c(r_without)[0] for c in checks)
    mark = "PASS" if with_ok else "FAIL"
    red = "red without layer" if not without_ok else "ALSO PASSES WITHOUT LAYER"
    print(f"{sid} {mark:4} {red:28} {name}")
    ok_all &= with_ok
    out.append({"id": sid, "name": name, "parts": [], "facts": "%INCLUDE marriage_consent_cases.lp", "expect": expect, "expected": name})

json.dump(out, open("marriage_consent_scenarios.json", "w"), indent=2, ensure_ascii=False)
print("all pass with layer:", ok_all)
