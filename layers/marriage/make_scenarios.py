"""Build marriage_scenarios.json: one scenario per rule, in the shape
save_scenario takes, and verify each passes with the layer and fails without it
(CLAUDE.md rule 5). Run from the checker's checkout:

    python3 layers/marriage/make_scenarios.py
"""
import json, sys
from theological_type_checker import engine, suite

# usage: make_scenarios.py  (reads the three layers and their cases from this directory)
import os
HERE = os.path.dirname(os.path.abspath(__file__))
LAYERS = ["marriage_consent.lp", "marriage_impediments.lp", "marriage_form.lp"]
CASEFILES = ["marriage_consent_cases.lp", "marriage_impediments_cases.lp", "marriage_form_cases.lp"]
PARTS = ["sacrament_conditions"]   # the form's dispensability is the theology side's
RULES = "\n".join(open(os.path.join(HERE, f)).read() for f in LAYERS)
CASES = "\n".join(open(os.path.join(HERE, f)).read() for f in CASEFILES)

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
  ("PMC23", "CCEO c. 826 against c. 1102 §2: a fulfilled present condition, Latin party valid, Eastern party invalid",
            [every("info(ground(me_cond_lat,n1102_2,not_engaged))"), every("info(ground(me_cond_east,n1102_2,engaged_by(cceo826)))")]),
  ("PMC24", "CCEO c. 825: an Eastern party's fear engages the ground formulated as c. 1103, by the Eastern canon",
            [every("info(ground(me_fear,n1103,engaged_by(cceo825)))"), none("info(ground(me_fear,n1103,engaged_by(n1103)))")]),
  ("PMC25", "CCEO c. 824 §2 and c. 818 2°: exclusion and defect of discretion, Eastern party",
            [every("info(ground(me_prolis,n1101_prolis,engaged_by(cceo824_prolis)))"), every("info(ground(me_disc,n1095_2,engaged_by(cceo818_2)))")]),
  ("PMC26", "CCEO c. 821 after 1991: settled; before 1991: one reading for both codes, branches",
            [every("info(ground(me_dolus,n1098,engaged_by(cceo821)))"), some("info(ground(me_dolus_old,n1098,engaged))"), some("info(ground(me_dolus_old,n1098,not_engaged))"), none("info(ground(me_dolus_old,n1098,engaged_by(n1098)))")]),
  ("PMC27", "an Eastern party before 1991: no Eastern code encoded, the ground not engaged, the frontier raised",
            [every("info(ground(me_old,n1095_2,not_engaged))"), every("info(no_eastern_code_in_force(e44,me_old))")]),
  ("PMC28", "c. 1 across the layer: no Latin consent id is said of an Eastern party",
            [none("info(ground(me_disc,n1095_2,engaged_by(n1095_2)))"), none("info(ground(me_prolis,n1101_prolis,engaged_by(n1101_prolis)))"), none("info(ground(me_dolus,n1098,engaged_by(n1098)))")]),
  # ---------- impediments ----------
  ("PMC29", "c. 1083 with c. 203: fifteen impeded; sixteen and fourteen, the day after the birthday, not",
            [every("info(ground(mi_age,impediment(age),engaged_by(n1083)))"), every("info(ground(mi_age_ok,impediment(age),not_engaged))")]),
  ("PMC30", "c. 1084: certain impotence impedes; doubtful impotence impedes nothing (§2); sterility nothing (§3); its dispensation a violation",
            [every("info(ground(mi_imp,impediment(impotence),engaged))"), every("info(ground(mi_imp_d,impediment(impotence),not_engaged))"), every("info(doubtful_impotence_does_not_impede(i7,mi_imp_d))"), every("info(ground(mi_ster,impediment(impotence),not_engaged))"), every("violation(dispensing_divine_law(dsp_imp,cond(matrimony,impediment(impotence))))")]),
  ("PMC31", "c. 1085: a standing bond impedes; a bond ended by death does not; a prior marriage null for form does not, but is not yet established (§2)",
            [every("info(ground(mi_second,impediment(prior_bond),engaged))"), every("info(ground(mi_second_w,impediment(prior_bond),not_engaged))"), every("info(ground(mi_second_n,impediment(prior_bond),not_engaged))"), every("info(prior_marriage_not_yet_established_null(mi_second_n,mi_first_n))")]),
  ("PMC32", "c. 1086: disparity of cult impedes unless the ordinary dispenses",
            [every("info(ground(mi_disp,impediment(disparity_of_cult),engaged))"), every("info(ground(mi_disp_ok,impediment(disparity_of_cult),not_engaged))"), every("info(marriage(mi_disp_ok,impediment_dispensed,disparity_of_cult))")]),
  ("PMC33", "c. 1078 §2: orders are reserved, an ordinary's dispensation a violation and the impediment stands; a dicastery dispenses a pontifical vow",
            [every("info(ground(mi_ord,impediment(sacred_orders),engaged))"), every("violation(dispensation_of_reserved_impediment(dsp_ord,sacred_orders))"), every("info(ground(mi_vow,impediment(public_vow),not_engaged))")]),
  ("PMC34", "c. 1089: abduction impedes unless the woman was released before consenting",
            [every("info(ground(mi_abd,impediment(abduction),engaged))"), every("info(ground(mi_abd_ok,impediment(abduction),not_engaged))")]),
  ("PMC35", "c. 1090 §§1-2: conjugicide with the purpose claimed; mutual cooperation",
            [every("info(ground(mi_crime,impediment(crime),engaged))"), every("info(ground(mi_crime2,impediment(crime),engaged))")]),
  ("PMC36", "c. 1091 with c. 1078 §3: cousins dispensed; siblings never given (a violation of the rule, not a finding of divine law); uncle and niece; the direct line",
            [every("info(ground(mi_cous,impediment(consanguinity(collateral,4)),not_engaged))"), every("info(ground(mi_sib,impediment(consanguinity(collateral,2)),engaged))"), every("violation(dispensation_never_given_c1078_3(dsp_sib,consanguinity(collateral,2)))"), none("violation(dispensing_divine_law(dsp_sib,cond(matrimony,impediment(consanguinity(collateral,2)))))"), every("info(ground(mi_unc,impediment(consanguinity(collateral,3)),engaged))"), every("info(ground(mi_far,impediment(consanguinity(direct,4)),engaged))")]),
  ("PMC37", "c. 1092 against CCEO c. 809: affinity in the collateral line, Latin not impeded, Eastern impeded",
            [every("info(ground(mi_aff_dir,impediment(affinity(direct,1)),engaged_by(n1092)))"), every("info(ground(mi_aff_col,impediment(affinity(collateral,2)),not_engaged))"), every("info(ground(mi_aff_col_e,impediment(affinity(collateral,2)),engaged_by(cceo809)))")]),
  ("PMC38", "c. 1093: public propriety from concubinage and from an invalid marriage with common life",
            [every("info(ground(mi_prop,impediment(public_propriety),engaged))"), every("info(ground(mi_prop2,impediment(public_propriety),engaged))")]),
  ("PMC39", "c. 1094: adoption, direct line and second collateral",
            [every("info(ground(mi_adop,impediment(adoption(collateral,2)),engaged))"), every("info(ground(mi_adop_d,impediment(adoption(direct,1)),engaged))")]),
  ("PMC40", "CCEO c. 811: spiritual relationship impedes an Eastern party; the Latin Code knows none",
            [every("info(ground(mi_spir_e,impediment(spiritual_relationship),engaged_by(cceo811)))"), every("info(ground(mi_spir_lat,impediment(spiritual_relationship),not_engaged))")]),
  # ---------- form ----------
  ("PMC41", "lack of form: a Latin before a layman; a Latin before a delegated deacon is valid; an Eastern before a deacon lacks the priest (CCEO c. 828)",
            [every("info(ground(mf_lay,lack_of_form,engaged_by(n1108)))"), every("info(ground(mf_dcn,lack_of_form,not_engaged))"), every("info(ground(mf_dcn_e,lack_of_form,engaged_by(cceo828)))")]),
  ("PMC42", "Latin and Eastern Catholic before a deacon: the Eastern code in 2010, the Latin too from 2016 (c. 1108 §3)",
            [every("info(ground(mf_mix_2010,lack_of_form,engaged_by(cceo828)))"), every("info(ground(mf_mix_2017,lack_of_form,engaged_by(n1108_3)))")]),
  ("PMC43", "c. 1127 §1: a Catholic marrying an Assyrian before an Orthodox priest: valid, form for liceity only, illicit twice over",
            [every("info(marriage(mf_assyr,eastern_noncatholic_party,assyrian_church_of_the_east))"), every("info(marriage(mf_assyr,valid_form))"), every("info(ground(mf_assyr,lack_of_form,not_engaged))"), every("info(marriage(mf_assyr,valid_form_but_illicit,catholic_form_not_observed))"), every("info(marriage(mf_assyr,valid_form_but_illicit,no_permission_for_mixed_marriage))")]),
  ("PMC44", "with permission and the Catholic form: licit; CCEO c. 834 §2 for an Eastern Catholic and a Copt: valid, illicit",
            [none("info(marriage(mf_greek_ok,valid_form_but_illicit,catholic_form_not_observed))"), none("info(marriage(mf_greek_ok,valid_form_but_illicit,no_permission_for_mixed_marriage))"), every("info(marriage(mf_copt_e,valid_form))"), every("info(marriage(mf_copt_e,valid_form_but_illicit,no_permission_for_mixed_marriage))")]),
  ("PMC45", "a Lutheran party: the form binds for validity; dispensed by the ordinary (c. 1127 §2), the marriage stands",
            [every("info(ground(mf_luth,lack_of_form,engaged))"), every("info(marriage(mf_luth,illicit,no_permission_for_mixed_marriage))"), every("info(ground(mf_luth_d,lack_of_form,not_engaged))"), every("info(marriage(mf_luth_d,form_dispensed))")]),
  ("PMC46", "c. 1116 and CCEO c. 832: the extraordinary form before two witnesses, Latin and Eastern; one witness fails",
            [every("info(ground(mf_extra,lack_of_form,not_engaged))"), every("info(marriage(mf_extra,extraordinary_form))"), every("info(ground(mf_extra_e,lack_of_form,not_engaged))"), every("info(ground(mf_extra_1w,lack_of_form,engaged))")]),
  ("PMC47", "whether the near degrees are of divine law is open on the theology side; the law's 'never given' does not answer it",
            [{"kind": "status", "of": "q(sibling_impediment_divine_law)=yes", "is": "open"}, {"kind": "status", "of": "q(sibling_impediment_divine_law)=no", "is": "open"}]),
]

def run(facts):
    return engine.solve(PARTS, "branches", facts=facts, max_models=8000)

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
    out.append({"id": sid, "name": name, "parts": PARTS, "facts": "%INCLUDE " + " ".join(CASEFILES), "expect": expect, "expected": name})

json.dump(out, open(os.path.join(HERE, "marriage_scenarios.json"), "w"), indent=2, ensure_ascii=False)
print("all pass with layer:", ok_all)
