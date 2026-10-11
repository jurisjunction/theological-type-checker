"""The regression suite: every model, theorem, prohibition, stress test,
historical backtest and case, with what each is expected to show.

    ttc-suite                 # run everything, exit 1 if any test fails
    ttc-suite --md FILE       # also write the report as a markdown table
    ttc-suite --show ID       # print every derived atom for one scenario
    ttc-suite --with PART     # add a part to every scenario (e.g. a9_universal)
"""
import pathlib
import re
import sys

from .engine import classify, lint, preferred_value, solve

# ---------- expectation helpers: each returns (ok, short description) ----
def clean(r):
    return (not r["violations"], "no violations" if not r["violations"] else "; ".join(r["violations"]))

def has(*subs):
    def chk(r):
        ok = all(any(s in v for v in r["violations"]) for s in subs)
        return ok, "; ".join(r["violations"]) or "no violations"
    return chk

def none_of(*subs):
    def chk(r):
        hit = [v for v in r["violations"] if any(s in v for s in subs)]
        return not hit, "; ".join(hit) or f"no {'/'.join(subs)} violation"
    return chk

def count(sub, n):
    def chk(r):
        k = sum(sub in v for v in r["violations"])
        return k == n, f"{k} x {sub}"
    return chk

def theorems(*ts):
    def chk(r):
        return all(t in r["theorems"] for t in ts), ", ".join(r["theorems"]) or "no theorems"
    return chk

def only_theorem(prefix, *ts):
    def chk(r):
        got = sorted(t for t in r["theorems"] if t.startswith(prefix))
        return got == sorted(ts), ", ".join(got) or "none"
    return chk

def principles_of(term, *expected):
    def chk(r):
        got = sorted(i[len("principle_of("):-1].split(",", 1)[1]
                     for i in r["info"] if i.startswith(f"principle_of({term},"))
        return got == sorted(expected), f"principle of {term}: {', '.join(got) or 'none'}"
    return chk

def verdicts(expected):
    def chk(r):
        ok = all(r["verdicts"].get(k) == v for k, v in expected.items())
        return ok, ", ".join(f"{k}: {r['verdicts'].get(k)}" for k in expected)
    return chk

def sat(n=None):
    def chk(r):
        ok = r["sat"] and (n is None or r["models"] == n)
        return ok, f"{r['models']} mapping(s)" if r["sat"] else "no mapping exists"
    return chk

def unsat(r):
    return (not r["sat"], "no mapping exists" if not r["sat"] else f"{r['models']} mapping(s)")

def cost(n):
    def chk(r):
        got = r["cost"][0] if r["cost"] else 0
        return got == n, f"minimum violations = {got}"
    return chk


def cls(qv, expected):
    def chk(r):
        got = classify(r, qv)
        return got == expected, f"{qv}: {got}"
    return chk

def prefers(question, expected):
    def chk(r):
        got = preferred_value(r, question)
        return got == expected, f"preferred: {got}"
    return chk

def branch_of(qv, status, t2=None, reint=None):
    def chk(r):
        bs = [b for b in r["branches"] if qv in b["values"] and (t2 is None or b["t2"] == t2)]
        sts = sorted({b["status"] for b in bs})
        ok = sts == [status]
        desc = f"{qv}{'' if t2 is None else (' with t2_truth' if t2 else ' without t2_truth')}: {', '.join(sts) or 'none'}"
        if reint is not None:
            got = sorted({s for b in bs for s in b["reint"]})
            ok = ok and got == sorted(reint)
            desc += f"; reintegrates if relaxed: {', '.join(got) or 'nothing'}"
        return ok, desc
    return chk

def downstream(qv, sub, present=True):
    def chk(r):
        bs = [b for b in r["branches"] if qv in b["values"]]
        hit = bool(bs) and all(any(sub in f for f in b["facts"]) for b in bs)
        miss = bool(bs) and all(not any(sub in f for f in b["facts"]) for b in bs)
        ok = hit if present else miss
        return ok, f"{qv}: {sub} {'present' if hit else 'absent'}"
    return chk

def any_branch_violation(sub):
    def chk(r):
        hit = sorted({f for b in r["branches"] for f in b["facts"] if f.startswith("violation(") and sub in f})
        return bool(hit), "; ".join(hit) or f"no {sub}"
    return chk


# ---------- scenarios ----------------------------------------------------
S = []
def scen(sid, group, name, parts, checks, expected, mode="one"):
    S.append(dict(id=sid, group=group, name=name, parts=parts, checks=checks,
                  expected=expected, mode=mode))

ALL_CLEAN = ["trinity", "family", "souls", "friendship", "communicatio"]

# Models must be consistent with the axioms
scen("M1", "model", "Trinity (P2)", ["trinity"],
     [clean, only_theorem("both_positions", "both_positions(son)"),
      principles_of("son", "father"), principles_of("spirit", "pair(father,son)")],
     "consistent; Son from Father, Spirit from Father-and-Son as one; only the Son holds both positions")
scen("M2", "model", "Marriage, conception, infant baptism", ["family"],
     [clean], "consistent")
scen("M3", "model", "Christ and many souls", ["souls"], [clean], "consistent")
scen("M4", "model", "Co-phase friendship", ["friendship"], [clean], "consistent")
scen("M5", "model", "All models together", ALL_CLEAN, [clean], "consistent")

# Theorems
scen("T1", "theorem", "Unary poles are vacuous", ["family"],
     [theorems("vacuous_over_persons(receptive)", "vacuous_over_persons(donative)",
               "vacuous_over_persons(bridal)")],
     "receptive, donative and bridal each hold of every person")
scen("T1b", "theorem", "A unary pole cannot distinguish man from woman", ["family", "cand_diagram"],
     [has("unary_pole(d1", "fails_to_distinguish(d1", "fails_to_distinguish(d2")],
     "both claimed distinctions fail")
scen("T2", "theorem", "Contraction yields one principle of the child", ["family"],
     [none_of("grain"), principles_of("child", "pair(man,woman)")],
     "no grain violation; exactly one principle, the pair")
scen("T3a", "theorem", "Finite totality is unique: polygamy", ["polygamy"],
     [has("rivalrous_total(h,w1,w2)")], "violation")
scen("T3b", "theorem", "Finite totality is unique: a soul given twice", ["souls", "soul_two_spouses"],
     [has("rivalrous_total(soul1,christ,rival)")], "violation")
scen("T3c", "theorem", "Divine gift to many souls is non-rivalrous", ["souls"],
     [none_of("rivalrous")], "no violation")
scen("T5", "theorem", "Communicatio idiomatum as typing (ST III q.16)", ["communicatio"],
     [verdicts({"god_died": "well_typed", "this_man_is_god": "well_typed",
                "god_born_of_mary": "well_typed", "divinity_died": "ill_typed",
                "humanity_is_eternal": "ill_typed",
                "christ_is_a_creature": "needs_qualification",
                "christ_as_man_is_a_creature": "well_typed"})],
     "4 well-typed, 2 ill-typed, 1 needs qualification")
scen("T6a", "theorem", "Augustine: family as image of the Trinity, all edges", ["augustine", "aug_full"],
     [unsat], "no mapping exists", mode="all")
scen("T6b", "theorem", "Augustine: spiration sub-pattern only, kinds respected", ["augustine", "aug_spiration"],
     [unsat], "no mapping exists", mode="all")
scen("T6c", "theorem", "Augustine: spiration sub-pattern, kinds ignored", ["augustine", "aug_spiration", "aug_ignore_kinds"],
     [sat(2)], "2 mappings (Spirit to child)", mode="all")

# Retrodictions (shape of the canon derived from axioms that do not cite it)
scen("R1", "retrodiction", "c. 1084: sterile but capable / incapable", ["bonds"],
     [verdicts({"bond(a1,b1)": "valid", "bond(a2,b2)": "invalid"})],
     "sterile couple valid; incapable couple invalid")
scen("R2", "retrodiction", "c. 1057 §1: consent supplied by a third party", ["bonds"],
     [verdicts({"bond(a3,b3)": "invalid"}), has("consent_supplied(parent,b3,a3)")],
     "bond invalid; violation")

# Prohibitions: each forbidden position must produce a violation
scen("X1", "prohibition", "Receiver-as-lesser (Trinity)", ["trinity", "cand_receiver_lesser"],
     [count("receiver_ranked_lower", 3)], "3 violations (Son, Spirit x2)")
scen("X2", "prohibition", "Receiver-as-lesser (spouses)", ["family", "cand_receiver_lesser_nuptial"],
     [count("receiver_ranked_lower", 2)], "2 violations")
scen("X3", "prohibition", "Functionalist personhood", ["souls", "cand_functionalism"],
     [has("image_denied(christ,no_exercised_reason(embryo))")], "violation at the embryonic Christ")
scen("X4", "prohibition", "Couple-completion imago", ["souls", "cand_couple_completion"],
     [has("image_denied(christ,unmarried)")], "violation at the unmarried Christ")
scen("X5", "prohibition", "The gift of self measured by state of life", ["family", "cand_magnitude"],
     [has("self_gift_ranked_by_state")], "violation")
scen("X5b", "prohibition", "Trent on virginity (DH 1810) beside the prohibition", ["family", "virginity"],
     [cls("q(state_excellence)=virginity_more_excellent", "settled"), cls("q(state_excellence)=equal", "excluded"),
      lambda r: (not any(f.startswith("violation(") for b in r["branches"] for f in b["facts"]), "no violations")],
     "the excellence of the state is settled at tier 1 and violates nothing: it is not a measure of anyone's gift", mode="branches")
scen("X6", "prohibition", "Male-as-God / female-as-creature", ["family", "cand_diagram"],
     [has("fails_to_distinguish")], "violation")
scen("X7", "prohibition", "The weld (intensity read as eros)", ["friendship", "cand_weld"],
     [has("ungrounded_counter_phase(david,jonathan)")], "violation")
scen("X8", "prohibition", "God as apex of the fractal", ["family", "cand_apex"],
     [has("god_inside_level_order(god)")], "violation")
scen("X9", "prohibition", "Grace as stuff", ["family", "cand_grace_stuff"],
     [has("sort_clash(grace")], "violation (relative to context)")
scen("X10", "prohibition", "Passivity as a category of personhood", ["family", "cand_passivity"],
     [has("reception_typed_as_non_act")], "violation")

# Stress tests
scen("S1", "stress", "Generation without closing act; closure in the act (A4a)", ["separate_act"],
     [has("grain(o,child2")], "grain violation")
scen("S2", "stress", "Same facts; closure in the standing bond", ["separate_act", "mode_bond"],
     [clean], "consistent")
scen("S3", "stress", "One contraction license only (circuit) on the Trinity", ["trinity", "circuit_only"],
     [has("grain(o,spirit")], "grain violation at the Spirit")
scen("S4", "stress", "Circuit license only, Trinity rescued with a nuptial circuit", ["trinity", "circuit_only", "trinity_as_couple"],
     [none_of("grain"), has("nuptial_within_god")], "grain holds; nuptial relation inside God")
scen("S5", "stress", "'Cannot generate alone', unrestricted", ["asexual", "gen_unbanded"],
     [count("lone_generation", 2), none_of("grain")], "2 violations (fission, parthenogenesis); grain holds")
scen("S6", "stress", "'Cannot generate alone', restricted by level band", ["asexual", "gen_by_level"],
     [count("lone_generation", 2), none_of("grain")], "2 violations; grain holds")
scen("S7", "stress", "'Cannot generate alone', restricted to obligately sexual kinds", ["asexual", "gen_by_kind"],
     [clean], "consistent, but true by definition")
scen("S8", "stress", "Rescue by type-splitting, inventory fixed (A0)", ["separate_act", "rescue_closed"],
     [cost(1)], "minimum violations = 1", mode="opt")
scen("S9", "stress", "Rescue by type-splitting, inventory open", ["separate_act", "rescue_open"],
     [cost(0)], "minimum violations = 0", mode="opt")

# Authority graph, branches and shadows
B = "branches"
scen("B1", "authority", "Immaculate Conception as of 1400", ["ic", "asof_1400"],
     [cls("q(ic)=yes", "open"), cls("q(ic)=no", "open"), prefers("q(ic)", "no")],
     "both schools open; theologians' weight prefers 'no'", mode=B)
scen("B2", "authority", "Immaculate Conception as of 1600", ["ic", "asof_1600"],
     [cls("q(ic)=yes", "open"), cls("q(ic)=no", "open"), prefers("q(ic)", "no")],
     "both open, protected; Doctors' weight prefers 'no'", mode=B)
scen("B3", "authority", "Immaculate Conception as of 1850", ["ic", "asof_1850"],
     [cls("q(ic)=yes", "open"), cls("q(ic)=no", "open"), prefers("q(ic)", "yes")],
     "both open, protected; Alexander VII (tier 3) tips preference to 'yes'", mode=B)
scen("B4", "authority", "Same, with the protective acts removed", ["ic", "ic_unprotected", "asof_1850"],
     [cls("q(ic)=yes", "settled"), branch_of("q(ic)=no", "live_shadow", reint=["sollicitudo_1661"])],
     "'no' becomes a live shadow of Alexander VII", mode=B)
scen("B5", "authority", "Immaculate Conception as of 1860", ["ic", "asof_1860"],
     [cls("q(ic)=yes", "settled"), cls("q(ic)=no", "excluded")],
     "Ineffabilis Deus (tier 1) deletes 'no'", mode=B)
scen("B6", "authority", "De auxiliis, 1607 to now", ["auxiliis"],
     [cls("q(efficacious_grace)=physical_premotion", "open"),
      cls("q(efficacious_grace)=middle_knowledge", "open"), prefers("q(efficacious_grace)", "tie")],
     "two legitimate schools, no preference", mode=B)
scen("B7", "authority", "Disparity of cult, law in force", ["disparity"],
     [cls("q(disparity(m,w))=impeded", "settled"),
      branch_of("q(disparity(m,w))=not_impeded", "live_shadow", reint=["c1086"]),
      downstream("q(disparity(m,w))=not_impeded", "principle_of(c,pair(m,w))"),
      downstream("q(disparity(m,w))=impeded", "grain(o,c,m,w)")],
     "valid bond survives as a live shadow of c. 1086; downstream: one principle there, grain violation in main", mode=B)
scen("B8", "authority", "Disparity of cult, dispensed", ["disparity", "dispensed"],
     [cls("q(disparity(m,w))=not_impeded", "settled"), cls("q(disparity(m,w))=impeded", "excluded"),
      downstream("q(disparity(m,w))=not_impeded", "principle_of(c,pair(m,w))")],
     "shadow reintegrates with its downstream consequences", mode=B)
scen("B9", "authority", "Tier-2 cleave, force of tier 2 unsettled", ["tier2"],
     [branch_of("q(d1)=no", "counterfactual_shadow", t2=True),
      branch_of("q(d1)=no", "live_shadow", t2=False, reint=["definitive_d1"])],
     "counterfactual if tier 2 is truth-force, live if not; the system keeps both readings", mode=B)
scen("B10", "authority", "A tier-3 source treated as fixing tier 2's force", ["tier2", "cdf_fixes_tier2"],
     [any_branch_violation("self_elevation(cdf_1998,t2_truth)")], "self-elevation violation", mode=B)
scen("B11", "authority", "A hypothetical tier-1 act fixes tier 2's force", ["tier2", "hypothetical_definition"],
     [branch_of("q(d1)=no", "counterfactual_shadow")],
     "only the counterfactual reading remains", mode=B)
scen("B12", "authority", "Ad Tuendam Fidem read as teaching that settles tier 2", ["tier2", "atf_fixes_tier2"],
     [any_branch_violation("governance_read_as_teaching(atf_1998,t2_truth)"),
      any_branch_violation("self_elevation(atf_1998,t2_truth)"),
      branch_of("q(d1)=no", "live_shadow", t2=False, reint=["definitive_d1"])],
     "two violations (type and tier); both readings of tier 2 remain", mode=B)
scen("B13", "authority", "A legislative papal act entered at tier 1", ["tier2", "atf_as_tier1"],
     [any_branch_violation("tier_inconsistent_with_form(atf_misread,1,legislative)")],
     "violation: legislation is tier 3", mode=B)
scen("B14", "authority", "Every papal act in the data is tiered by its form", ["ic", "auxiliis", "tier2"],
     [lambda r: (not any("tier_inconsistent" in f for b in r["branches"] for f in b["facts"]),
                 "no form mismatches")],
     "no mismatches", mode=B)

def owed_everywhere(*items):
    def chk(r):
        ok = all(all(f"info(owed({i}))" in b["facts"] for b in r["branches"]) for i in items)
        got = sorted({f[len('info(owed('):-2] for b in r["branches"] for f in b["facts"] if f.startswith("info(owed(")})
        return ok, "; ".join(got) or "nothing owed"
    return chk

def clean_branches(r):
    v = sorted({f for b in r["branches"] for f in b["facts"] if f.startswith("violation(")})
    return not v, "; ".join(v) or "no violations"

def branch_violation(qv, sub, present=True):
    def chk(r):
        bs = [b for b in r["branches"] if qv in b["values"]]
        hits = [any(f.startswith("violation(") and sub in f for f in b["facts"]) for b in bs]
        ok = bool(bs) and (all(hits) if present else not any(hits))
        return ok, f"{qv}: {sub} {'in every branch' if bs and all(hits) else 'absent' if not any(hits) else 'in some branches'}"
    return chk

scen("L1", "case", "Unbaptized infants, old universal A9", ["limbo", "a9_universal"],
     [cls("q(infant_fate)=limbo", "open"),
      branch_violation("q(infant_fate)=limbo", "reception_without_act(infant,christ)"),
      branch_violation("q(infant_fate)=poena_sensus", "reception_without_act(infant,christ)"),
      branch_violation("q(infant_fate)=beatific", "reception_without_act", present=False)],
     "the grammar flags the protected limbo school as ill-formed", mode=B)
scen("L2", "case", "Unbaptized infants, A9 as MD 25 words it (default)", ["limbo"],
     [cls("q(infant_fate)=limbo", "open"), cls("q(infant_fate)=beatific", "open"),
      clean_branches, prefers("q(infant_fate)", "beatific")],
     "neutral: all three open, CCC 1261 tips preference to hope", mode=B)
scen("L3", "case", "A refusal, old universal A9", ["refusal", "a9_universal"],
     [has("reception_without_act(refuser,christ)")], "refusal is ill-formed")
scen("L4", "case", "A refusal, A9 as MD 25 words it (default)", ["refusal"],
     [clean, theorems("vacuous_over_persons(called_bridal)"),
      lambda r: ("vacuous_over_persons(bridal)" not in r["theorems"], "'bridal' now distinguishes persons")],
     "refusal representable; 'called' is vacuous, 'bridal' is not")

def tension(q, present=True):
    def chk(r):
        hit = any(any(f.startswith(f"info(open_tension({q},") for f in b["facts"]) for b in r["branches"])
        return hit == present, f"open tension on {q}: {'yes' if hit else 'no'}"
    return chk

def prefers_atom(atom):
    def chk(r):
        mains = [b for b in r["branches"] if b["status"] == "main"]
        if not mains:
            return False, "no main branch"
        key = lambda b: (b["w"][3], b["w"][4], b["w"][5])
        best = min(key(b) for b in mains)
        top = [b for b in mains if key(b) == best]
        ok = all(atom in b["assume"] for b in top)
        common = set.intersection(*(set(b["assume"]) for b in top))
        return ok, f"all best-weighted branches assume: {', '.join(sorted(common)) or 'nothing in common'}"
    return chk

DP = ["deathpenalty"]
scen("DP1", "case", "Death penalty, as of 2017", DP + ["asof_2017", "no_oum"],
     [cls("q(dp_principle)=permitted", "settled"),
      branch_of("q(dp_principle)=intrinsically_wrong", "live_shadow")],
     "permitted in principle settled; 'intrinsically wrong' a live shadow", mode=B)
scen("DP2", "case", "As of 2019, CCC 2267 read as the CDF reads it", DP + ["asof_2019", "ccc_circumstantial", "no_oum"],
     [cls("q(dp_principle)=permitted", "settled"), cls("q(necessity_today)=none", "settled"),
      tension("q(dp_principle)", False),
      branch_of("q(dp_principle)=intrinsically_wrong", "live_shadow", reint=["dh795", "ev56", "roman_catechism"])],
     "consistent with all prior teaching; no tension; the withdrawn 1997 text no longer counts", mode=B)
scen("DP3", "case", "As of 2019, CCC 2267 read as intrinsic", DP + ["asof_2019", "ccc_intrinsic", "no_oum"],
     [cls("q(dp_principle)=permitted", "open"), cls("q(dp_principle)=intrinsically_wrong", "open"),
      tension("q(dp_principle)")],
     "same-tier tension in teaching, which the system cannot resolve", mode=B)
scen("DP4", "case", "As of 2019, reading left open", DP + ["asof_2019", "no_oum"],
     [prefers_atom("read_as(ccc2018,circumstantial)")],
     "weight prefers the CDF's reading", mode=B)
scen("DP5", "case", "As of 2025, Dignitas Infinita read on its face", DP + ["ccc_circumstantial", "di_intrinsic", "no_oum"],
     [cls("q(dp_principle)=permitted", "open"), cls("q(dp_principle)=intrinsically_wrong", "open"),
      tension("q(dp_principle)")],
     "open tension; no same-tier interpreter offers another reading", mode=B)
scen("DP6", "case", "As of 2025, Dignitas Infinita read circumstantially", DP + ["ccc_circumstantial", "di_circumstantial", "no_oum"],
     [cls("q(dp_principle)=permitted", "settled"), tension("q(dp_principle)", False)],
     "consistent; no tension", mode=B)
scen("DP7", "case", "As of 2025, DI on its face, Innocent III taken as definitive", DP + ["ccc_circumstantial", "di_intrinsic", "oum_dh795"],
     [cls("q(dp_principle)=permitted", "settled"), tension("q(dp_principle)", False),
      branch_of("q(dp_principle)=intrinsically_wrong", "counterfactual_shadow", t2=True),
      branch_of("q(dp_principle)=intrinsically_wrong", "live_shadow", t2=False, reint=["dh795"])],
     "tier 2 settles it; DI's reading becomes a shadow", mode=B)

RM = ["remarriage"]
scen("DR1", "case", "Remarriage: what every branch shares", RM,
     [cls("q(first_bond)=indissoluble", "settled"), cls("q(first_bond)=dissolved", "excluded"),
      cls("q(admission_external)=barred_if_obstinate_and_manifest", "settled"), clean_branches],
     "indissolubility and c. 915 settled; Trent DH 1661 satisfied in every branch", mode=B)
scen("DR2", "case", "Admission norm typed as governance", RM + ["typed_governance", "external_barred"],
     [cls("q(admission_internal)=possible_in_some_cases", "settled"),
      branch_of("q(admission_internal)=only_if_continent", "live_shadow", reint=["al2016", "ba2016"])],
     "Amoris governs (c. 20); FC 84 a live shadow", mode=B)
scen("DR3", "case", "Admission norm typed as teaching (flat weight)", RM + ["typed_doctrinal", "no_oum", "flat_weight"],
     [cls("q(admission_internal)=only_if_continent", "open"),
      cls("q(admission_internal)=possible_in_some_cases", "open"),
      tension("q(admission_internal)"), prefers("q(admission_internal)", "tie")],
     "open tension; independent lineages tie 1 to 1", mode=B)
scen("DR3b", "case", "Admission norm typed as teaching (LG 25 weight)", RM + ["typed_doctrinal", "no_oum"],
     [tension("q(admission_internal)"), prefers("q(admission_internal)", "only_if_continent")],
     "still open; repetition across popes (SC 29 reaffirming FC 84) tips the preference 3 to 4", mode=B)
scen("DR4", "case", "Same, counting every source", RM + ["typed_doctrinal", "no_oum", "count_all"],
     [prefers("q(admission_internal)", "only_if_continent")],
     "repetition decides it: 3 documents to 2", mode=B)
scen("DR5", "case", "FC 84 taken as definitive (OUM)", RM + ["oum_fc84", "external_barred"],
     [cls("q(admission_internal)=only_if_continent", "settled"),
      branch_of("q(admission_internal)=possible_in_some_cases", "counterfactual_shadow", t2=True),
      branch_of("q(admission_internal)=possible_in_some_cases", "live_shadow", t2=False, reint=["fc84"])],
     "FC 84 settles it; Amoris a shadow", mode=B)
scen("DR6", "case", "The checker assigning an interior", RM + ["cand_diagnose"],
     [any_branch_violation("diagnosis(p1,system)")], "non-diagnosis violation", mode=B)
scen("DR7", "case", "Admitting someone discerned as fully culpable", RM + ["cand_full_imputability_admitted"],
     [any_branch_violation("trent_1661(p2)")], "tier-1 violation (Trent DH 1661)", mode=B)

scen("B16", "authority", "A tier-3 source contradicting a tier-2 one", ["tier2", "cand_tier3_contrary", "assume_t2"],
     [cls("q(d1)=yes", "settled"), branch_of("q(d1)=no", "counterfactual_shadow")],
     "the higher tier holds; the lower cannot cleave against it", mode=B)
scen("B17", "authority", "Interpretation breaks a tie between equally fitting readings", ["readings_tie"],
     [prefers_atom("read_as(s_amb,r1)")], "the interpreted reading is preferred", mode=B)

scen("B15", "authority", "Canon law binds to teaching by reference", ["tier2"],
     [owed_everywhere("lg25,divine_and_catholic_faith", "definitive_d1,firm_assent",
                      "cdf_1998,religious_submission"), clean_branches],
     "each teaching act owed the assent its tier's canon attaches; no violations", mode=B)


def lint_check(expect_clean, extra=""):
    def chk(_r):
        f = lint(extra)
        ok = (not f) if expect_clean else bool(f)
        return ok, "no unbridged crossings" if not f else "; ".join(f)
    return chk


def lateran(expected):
    def chk(r):
        nums = {}
        for a in r["atoms"]:
            m = re.match(r"(n_\w+)\((\d+)\)", a)
            if m:
                nums[m.group(1)] = int(m.group(2))
        lost = sorted(a[5:-1] for a in r["atoms"] if a.startswith("lost("))
        ok = all(nums.get(k) == v for k, v in expected.items())
        desc = ", ".join(f"{k[2:]}={nums.get(k)}" for k in ("n_super", "n_licensed", "n_kept", "n_feat"))
        return ok, desc + (f"; lost: {', '.join(lost)}" if lost else "; nothing lost")
    return chk


AN = "analogy"
scen("AN1", AN, "Bridges and modes are well-formed; nothing crosses", ALL_CLEAN,
     [clean, lambda r: (not any("projection" in v or "crossing" in v for v in r["violations"]),
                        "no projection, no unlicensed crossing")], "clean")
scen("AN2", AN, "Grain typed by mode", ["separate_act"],
     [has("norm_breach(grain(o,child2"), none_of("incoherent")], "creatures: norm breach")
scen("AN3", AN, "Grain typed by mode, in God", ["trinity", "circuit_only"],
     [has("incoherent(grain(o,spirit"), none_of("norm_breach")], "God: incoherent")
scen("AN4", AN, "Deny by default: divine origination unlicensed", ["trinity", "family", "unlicense_origination_div"],
     [principles_of("son"), principles_of("child", "pair(man,woman)"),
      lambda r: ("both_positions(son)" not in r["theorems"], "P2 theorem no longer derivable")],
     "nothing transfers to God without the bridge; creatures unaffected")
scen("AN5", AN, "Projection: the creature as primary analogate", ["family", "cand_projection"],
     [has("projection(origination)")], "violation")
scen("AN6", AN, "A creaturely predicate landing on God", ["trinity", "cand_finite_god"],
     [has("unlicensed_crossing(finite,father)")], "violation")
scen("AN12", AN, "A bridge with no mode on one side", ["cand_bridge_no_mode"],
     [has("bridge_without_mode(beauty,cr)"), none_of("bridge_without_mode(beauty,div)")],
     "violation on the creaturely side only")
scen("AN7", AN, "Static check: current rules", [],
     [lint_check(True)], "no rule crosses without a bridge")
scen("AN8", AN, "Static check: an injected univocal rule", [],
     [lint_check(False, "needs_welcome(X,Y) :- divine(X), nupt(Y,X), created_person(Y).")],
     "flagged")
scen("UN1", AN, "Univocity of mode (necessity): a child of an impeded union", ["disparity", "univocal_necessity"],
     [downstream("q(disparity(m,w))=impeded", "incoherent(grain(o,c,m,w))"),
      downstream("q(disparity(m,w))=impeded", "norm_breach(grain(o,c", present=False)],
     "an existing child reported as impossible: the P3 error, restored by univocity", mode=B)
scen("UN2", AN, "Univocity of mode (norm): the Trinity under one license", ["trinity", "circuit_only", "univocal_norm"],
     [has("norm_breach(grain(o,spirit", "deontic_in_god(grain)", "incoherent(grain(o,spirit")],
     "the unity of the Spirit's principle becomes something God ought to keep: flagged; the deposit's necessity (DH 850) stands")
scen("UN3", AN, "Analogical modes (the default) on the same two settings", ["disparity"],
     [downstream("q(disparity(m,w))=impeded", "norm_breach(grain(o,c,m,w))"),
      downstream("q(disparity(m,w))=impeded", "incoherent", present=False)],
     "a norm breach in creatures, nothing impossible", mode=B)
scen("AN9", AN, "Lateran IV: the family", ["lateran", "lateran_family"],
     [lateran({"n_super": 1, "n_licensed": 0}), clean],
     "a supertype resemblance only; no licensed similarity", mode="opt")
scen("AN10", AN, "Lateran IV: the mind (word and love)", ["lateran", "lateran_mind"],
     [lateran({"n_super": 2, "n_licensed": 2, "n_kept": 2, "n_feat": 5}), clean],
     "both processions licensed; subsistence is the remainder", mode="opt")
scen("AN11", AN, "Lateran IV: the mind as a resident trinity", ["lateran", "lateran_mind", "lateran_resident"],
     [lateran({"n_kept": 5, "n_feat": 5}), has("lateran_iv(no_dissimilarity)")],
     "complete map: violation", mode="opt")


def info_all(*subs):
    def chk(r):
        ok = all(all(any(s in f for f in b["facts"]) for b in r["branches"]) for s in subs)
        return ok, f"every branch: {', '.join(subs)}" if ok else "missing in some branch"
    return chk

def info_any(*subs):
    def chk(r):
        ok = all(any(any(s in f for f in b["facts"]) for b in r["branches"]) for s in subs)
        return ok, f"present: {', '.join(subs)}" if ok else "absent"
    return chk

def info_none(*subs):
    def chk(r):
        hit = sorted({f for b in r["branches"] for f in b["facts"] for s in subs if s in f})
        return not hit, "; ".join(hit) or f"none of: {', '.join(subs)}"
    return chk

def reint_includes(qv, src):
    def chk(r):
        bs = [b for b in r["branches"] if qv in b["values"]]
        ok = bool(bs) and all(src in b["reint"] and b["status"] == "live_shadow" for b in bs)
        return ok, f"{qv}: live shadow of {src}" if ok else f"{qv}: not a live shadow of {src}"
    return chk

EC = ["ecumenism", "lattice"]
scen("EC1", "case", "Degrees of communion: the lattice", EC + ["orders_fixed", "no_oum", "lg14_binary", "lg8_identity", "florence_no_bond"],
     [info_all("degree(orthodox,above,anglican)", "degree(catholic,above,orthodox)",
               "incomparable(lutheran,oriental_orthodox)", "di_ranks_above(oriental_orthodox,lutheran)",
               "full_communion(catholic)", "full_communion(eastern_catholic)", "imperfect_communion(lutheran)"),
      info_none("full_communion(orthodox)")],
     "a partial order; Dominus Iesus imposes a ranking the bond list does not", mode=B)
scen("EC2", "case", "Anglican orders, Apostolicae Curae at tier 3", EC + ["no_oum"],
     [cls("q(anglican_orders)=invalid", "settled"), reint_includes("q(anglican_orders)=valid", "ac1896")],
     "invalid settled; validity a live shadow", mode=B)
scen("EC3", "case", "Anglican orders, Apostolicae Curae taken as definitive", EC + ["oum_ac"],
     [cls("q(anglican_orders)=invalid", "settled"),
      branch_of("q(anglican_orders)=valid", "counterfactual_shadow", t2=True)],
     "same verdict; only the kind of shadow changes", mode=B)
scen("EC4", "case", "Membership: LG 14 read as graded incorporation", EC + ["lg14_graded"],
     [tension("q(membership)")], "open tension with Mystici Corporis", mode=B)
scen("EC5", "case", "Membership: reading left open", EC,
     [prefers_atom("read_as(lg14,members_and_joined)")], "binary membership, graded communion preferred", mode=B)
scen("EC6", "case", "Subsistit in: reading left open", EC,
     [prefers_atom("read_as(lg8,identity_with_elements)")], "the CDF's identity reading preferred", mode=B)
scen("EC7", "case", "Florence, 'outside' read as non-membership", EC + ["florence_nonmember"],
     [cls("q(salvation_nonmembers)=impossible", "settled"), cls("q(salvation_nonmembers)=possible", "excluded"),
      info_any("against_tier1(lg16", "against_tier1(ur3", "against_tier1(ho1949", "against_tier1(mc1943")],
     "Vatican II, Pius XII and the 1949 letter all stand against tier 1", mode=B)
scen("EC8", "case", "Florence, 'outside' read as having no bond", EC + ["florence_no_bond"],
     [cls("q(salvation_nonmembers)=possible", "settled"), info_none("against_tier1")],
     "consistent with all later teaching", mode=B)
scen("EC9", "case", "Florence: reading left open", EC,
     [prefers_atom("read_as(florence1442,outside_as_no_bond)")], "the 1949 letter's reading preferred", mode=B)
scen("EC10", "case", "The coherent typing: membership binary, communion graded", EC + ["lg14_binary", "lg8_identity", "florence_no_bond"],
     [info_none("open_tension", "against_tier1"), clean_branches], "no tension anywhere", mode=B)

LT = ["liturgy"]
scen("LT1", "case", "Old Missal, as of 1990", LT + ["asof_1990"],
     [cls("q(old_missal_use)=needs_bishop", "settled"), reint_includes("q(old_missal_use)=unrestricted", "quattuor_1984")],
     "the 1984 indult governs Quo Primum (c. 20)", mode=B)
scen("LT2", "case", "Old Missal, as of 2010", LT + ["asof_2010"],
     [cls("q(old_missal_use)=unrestricted", "settled"), reint_includes("q(old_missal_use)=needs_bishop", "sp2007")],
     "Summorum Pontificum governs", mode=B)
scen("LT3", "case", "Old Missal, now", LT,
     [cls("q(old_missal_use)=needs_bishop", "settled"), reint_includes("q(old_missal_use)=unrestricted", "tc2021")],
     "Traditionis Custodes governs; SP a live shadow", mode=B)
scen("LT4", "case", "Was the 1962 Missal abrogated in 1970?", LT,
     [cls("q(abrogated_1970)=never_abrogated", "settled")],
     "SP's reading stands; a personal letter cannot cleave it, and TC is silent", mode=B)
scen("LT5", "case", "Lex orandi status typed as teaching", LT + ["lit_doctrinal"],
     [any_branch_violation("governance_read_as_teaching(sp2007,q(lex_orandi))"),
      any_branch_violation("governance_read_as_teaching(tc2021,q(lex_orandi))")],
     "ill-typed: both texts are legislation", mode=B)
scen("LT6", "case", "Lex orandi status typed as governance", LT + ["lit_governance"],
     [cls("q(lex_orandi)=not_an_expression", "settled"), cls("q(may_be_entirely_forbidden)=no", "settled"),
      clean_branches],
     "TC governs; Benedict's teaching-form claim untouched", mode=B)
scen("LT7", "case", "Quo Primum's perpetuity read as binding successors", LT + ["cand_perpetuity_binds"],
     [any_branch_violation("successor_bound(quo_primum)")], "violation", mode=B)
scen("LT8", "case", "A hypothetical total ban", LT + ["cand_total_ban"],
     [any_branch_violation("governance_read_as_teaching(total_ban")],
     "governance cannot answer a teaching-form question", mode=B)


def same_verdicts_without(extra_part):
    """the verdicts must be identical with and without a descriptive layer"""
    def chk(r):
        r2 = solve([p for p in r["_parts"] if p != extra_part], "branches")
        key = lambda bs: sorted((b["status"], tuple(sorted(b["values"])), tuple(sorted(b["w"].items()))) for b in bs)
        ok = key(r["branches"]) == key(r2["branches"])
        return ok, "identical verdicts and weights with and without the salience layer" if ok else "verdicts differ"
    return chk

T3 = "tier3"
scen("G1", T3, "Magnum Principium against Liturgiam Authenticam", ["translation"],
     [cls("q(translation_approval)=confirmatio", "settled"),
      reint_includes("q(translation_approval)=detailed_recognitio", "mp2017"), clean_branches],
     "the papal law governs; a prefect's commentary cannot cleave it", mode=B)
scen("G2", T3, "A later curial instruction contrary to the papal law", ["translation", "cand_later_instruction"],
     [cls("q(translation_approval)=confirmatio", "settled"), any_branch_violation("invalid_lower_act(instr_2019,mp2017)")],
     "lex superior beats lex posterior: invalid (c. 135 §2)", mode=B)
scen("G3", T3, "Same instruction, approved in forma specifica", ["translation", "cand_later_instruction", "instr_in_forma_specifica"],
     [cls("q(translation_approval)=detailed_recognitio", "settled"), clean_branches],
     "now the pope's own act: the later act governs", mode=B)
scen("G4", T3, "A conference decree contrary to universal law", ["translation", "cand_conference"],
     [any_branch_violation("invalid_lower_act(conf_2018,mp2017)"), cls("q(translation_approval)=confirmatio", "settled")],
     "invalid", mode=B)
CU = ["custom_demo"]
scen("CU1", T3, "Custom at 29 years", CU + ["cu_young", "asof_1979"],
     [cls("q(practice_x)=forbidden", "settled"), info_any("custom_without_force(cy)")], "no force yet", mode=B)
scen("CU2", T3, "Custom at 30 years", CU + ["cu_young", "asof_1980"],
     [cls("q(practice_x)=permitted", "settled"), reint_includes("q(practice_x)=forbidden", "custom(cy)")],
     "force of law; the custom governs (c. 26)", mode=B)
scen("CU3", T3, "Custom against divine law", CU + ["cu_young", "cu_divine", "asof_2001"],
     [any_branch_violation("custom_contra_divine_law(cy)"), cls("q(practice_x)=forbidden", "settled")],
     "never acquires force (c. 24 §1)", mode=B)
scen("CU4", T3, "Reprobated custom", CU + ["cu_young", "cu_reprobated", "asof_2001"],
     [cls("q(practice_x)=forbidden", "settled"), info_any("custom_without_force(cy)")], "not reasonable (c. 24 §2)", mode=B)
scen("CU5", T3, "Law forbidding future customs", CU + ["cu_young", "cu_forbids", "asof_2001"],
     [cls("q(practice_x)=forbidden", "settled"), info_any("custom_without_force(cy)")],
     "51 years is not enough; 100 needed (c. 26)", mode=B)
scen("CU5b", T3, "Same law, a custom reaching 100 years", CU + ["cu_old", "cu_forbids", "asof_2001"],
     [cls("q(practice_x)=permitted", "settled")], "force of law at 100 years (c. 26)", mode=B)
scen("CU6", T3, "A later contrary law against a 50-year custom", CU + ["cu_young", "cu_later_law", "asof_2001"],
     [cls("q(practice_x)=forbidden", "settled")], "revoked (c. 28)", mode=B)
scen("CU7", T3, "A later law against a centenary custom", CU + ["cu_centenary", "cu_later_law", "asof_2001"],
     [cls("q(practice_x)=permitted", "settled")], "not revoked without express mention (c. 28)", mode=B)
scen("CU8", T3, "Same law, mentioning the custom expressly", CU + ["cu_centenary", "cu_later_law", "cu_express", "asof_2001"],
     [cls("q(practice_x)=forbidden", "settled")], "revoked", mode=B)
SA = ["salience_demo"]
scen("SA1", T3, "An interview against an encyclical", SA,
     [cls("q(topic_s)=a", "settled"),
      lambda r: (all(b["w"][3] == 0 for b in r["branches"] if "q(topic_s)=a" in b["values"]),
                 "the interview adds no weight and cannot cleave")],
     "the encyclical settles it", mode=B)
scen("SA2", T3, "Salience warning", SA + ["salience_marks"],
     [info_any("salience_warning(arg1,interview_s)"), same_verdicts_without("salience_marks")],
     "warned; verdicts unchanged", mode=B)


def main_with(qv, sub, present=True):
    """among main branches holding qv, sub is in every one (or in none)"""
    def chk(r):
        bs = [b for b in r["branches"] if b["status"] == "main" and qv in b["values"]]
        hits = [any(sub in f for f in b["facts"]) for b in bs]
        ok = bool(bs) and (all(hits) if present else not any(hits))
        return ok, f"{qv}: {sub} {'present' if bs and all(hits) else 'absent' if bs and not any(hits) else 'mixed'}"
    return chk

def assumed_with(qv, atom):
    """every main branch holding qv rests on the assumption atom"""
    def chk(r):
        bs = [b for b in r["branches"] if b["status"] == "main" and qv in b["values"]]
        ok = bool(bs) and all(atom in b["assume"] for b in bs)
        return ok, f"{qv} rests on {atom}" if ok else f"{qv} does not rest on {atom} alone"
    return chk

SX = ["sspx", "lattice"]
SXE = SX + ["ecumenism", "orders_fixed", "no_oum", "lg14_binary", "lg8_identity", "florence_no_bond"]
SC = "schism"
# authority side: how the acts are classified
scen("SX1", SC, "1988: the consecrations", SX,
     [cls("q(act1988_schismatic)=yes", "settled"), reint_includes("q(act1988_schismatic)=no", "ed1988"),
      cls("q(excomm_1988)=incurred", "settled"), info_all("external_forum_only(q(excomm_1988))")],
     "schismatic act and excommunication settled in the external forum; necessity a tier-5 school", mode=B)
scen("SX2", SC, "The 1988 excommunication over time", SX + ["asof_1990"],
     [cls("q(excomm_in_force)=in_force", "settled")], "in force in 1990", mode=B)
scen("SX3", SC, "After the 2009 remission", SX + ["asof_2010"],
     [cls("q(excomm_in_force)=remitted", "settled"), info_none("class_faculty(", "presumed_incurred(fellay", "presumed_incurred(galarreta")],
     "remitted; no faculties yet", mode=B)
scen("SX4", SC, "The juridical situation in 2018", SX + ["asof_2018"],
     [info_all("class_faculty(sspx_clergy,confession)", "class_may_receive_delegation(sspx_clergy,marriage)",
               "absolution(abs_2018,valid,licit)"),
      cls("q(canonical_status)=none", "settled")],
     "faculty to absolve by papal grant; ordinaries may delegate for marriages; no canonical status", mode=B)
scen("SX5", SC, "The lattice in 2018", SXE + ["asof_2018"],
     [info_all("degree(sspx,above,orthodox)", "imperfect_communion(sspx)"),
      info_none("church_proper(sspx)", "full_communion(sspx)")],
     "above the Orthodox in bonds, a different sort, not full communion", mode=B)
scen("SX6", SC, "'Is the Society in schism?' in 2018", SX + ["asof_2018"],
     [cls("q(society_schism_now)=yes", "open"), cls("q(society_schism_now)=no", "open"),
      prefers("q(society_schism_now)", "yes")],
     "open; the 'no' statements are interviews, so a lone tier-5 thesis tips the preference", mode=B)
scen("SX7", SC, "Salience in 2018", SX + ["asof_2018", "sspx_salience"],
     [info_any("salience_warning(arg_not_schismatic,francis_2016)"), same_verdicts_without("sspx_salience")],
     "warned; verdicts unchanged", mode=B)
scen("SX8", SC, "Schism classified on the basis of doctrinal dissent", SX + ["cand_dissent_as_schism"],
     [any_branch_violation("category_error(sspx,dissent_from(dignitatis_humanae))")],
     "category error: dissent from tier-3 teaching is c. 752 / c. 1365, not c. 751 / c. 1364", mode=B)
scen("SX9", SC, "Adherence inferred from attendance", SX + ["cand_infer_adherence"],
     [any_branch_violation("diagnosis_of_adherence(fidelis1,system)"),
      info_all("rule_endorsed(non_diagnosis,ddf_return_2026)")],
     "violation; the Dicastery's own return procedure states the same rule", mode=B)
scen("SX10", SC, "2026: the consecrations", SX,
     [cls("q(act2026_schismatic)=yes", "settled"),
      reint_includes("q(act2026_schismatic)=no", "ed1988"), reint_includes("q(act2026_schismatic)=no", "ddf_decree_2026"),
      cls("q(society_schism_now)=yes", "settled"), info_none("category_error")],
     "schismatic act settled; the Society's schism settled; the basis is the act, so no category error", mode=B)
# canon-law side: binary, from the facts and the norms in force
scen("SX11", SC, "Incurred and declared, recourse pending", SX,
     [info_all("presumed_incurred(fellay,n1387)", "presumed_incurred(schreiber,n1387)",
               "declaration_suspended(ddf_decree_2026,fellay)", "investigation_dispensable(ddf_decree_2026,galarreta)"),
      # changed with the ordered pair (and the investigation check moved from
      # Fellay, whose declared title is c. 1364, to de Galarreta, c. 1387): c. 1364 now applies only in the branches
      # that classify the act as schismatic (all main branches), not in the shadow
      main_with("q(act2026_schismatic)=yes", "presumed_incurred(fellay,n1364)"),
      info_none("declared(")],
     "presumed incurred (c. 1321 §4) under c. 1387 even as co-consecrator, and under c. 1364 where the act is classified as schismatic; declaration suspended (c. 1353)", mode=B)
scen("SX12", SC, "Recourse decided", SX + ["recourse_decided_2026"],
     [info_all("declared(fellay,n1364)", "declared(galarreta,n1387)"),
      lambda r: (0 < sum(any("ground_for_recourse(ddf_decree_2026,fellay" in f for f in b["facts"]) for b in r["branches"]) < len(r["branches"]),
                 "missing hearing is a ground for recourse only in the branches where it is assumed missing")],
     "the declaration takes effect; whether the hearing was given is a disputed fact, a ground for recourse, not a void", mode=B)
scen("SX13", SC, "Decree approved in forma specifica (hypothetical)", SX + ["decree_papally_approved"],
     [info_none("declaration_suspended("), info_all("declared(fellay,n1364)")],
     "no recourse against the pope's own act (c. 333 §3)", mode=B)
scen("SX14", SC, "The 2009 remission does not reach 2026", SX + ["asof_2018"],
     [info_none("presumed_incurred(fellay", "presumed_incurred(galarreta"), cls("q(act2026_schismatic)=yes", "excluded")],
     "nothing incurred, and no 2026 question, before the act", mode=B)
scen("SX15", SC, "Absolution after 2026, on the facts of record", SX,
     [info_all("class_faculty(sspx_clergy,confession)", "absolution(abs_2026,valid,licit)",
               "absolution(abs_2026_bishop,valid,illicit)", "absolution(abs_2026_bishop_jc,valid,licit)",
               "claim_contradicted(ddf_note_2026,invalid_absolution(sspx_clergy),abs_2026)")],
     "the papal grant stands until a competent revocation; undeclared, the prohibition yields to a just-cause request (c. 1335 §2)", mode=B)
scen("SX16", SC, "A competent revocation (hypothetical papal approval of the note)", SX + ["note_as_revocation", "note_papally_approved", "edge_acts"],
     [info_all("absolution(abs_2026,invalid)", "delict(sspx_priest_x,n1379,abs_2026)", "absolution(abs_2018,valid,licit)",
               "claim_confirmed(ddf_note_2026,invalid_absolution(sspx_clergy),abs_2026)", "absolution(abs_dying,valid,licit)"),
      info_none("delict(sspx_priest_x,n1379,abs_dying)"),
      lambda r: (0 < sum(any("absolution(abs_common_error,valid" in f for f in b["facts"]) for b in r["branches"]) < len(r["branches"]),
                 "common error (c. 144 §2) supplies the faculty only in the branches where it is assumed")],
     "then the note is right, every later attempt is a c. 1379 delict, nothing earlier is touched, the dying are always absolved (c. 976), and common error supplies (c. 144)", mode=B)
scen("SX17", SC, "The note read as revoking the grants", SX + ["note_as_revocation"],
     [any_branch_violation("ineffective_revocation(ddf_note_2026,mm12)"), info_all("absolution(abs_2026,valid,licit)")],
     "a dicastery cannot revoke a papal grant (c. 135 §2): ineffective", mode=B)
scen("SX18", SC, "The note read as declaring the clergy excommunicated", SX + ["cand_note_as_declaration"],
     [any_branch_violation("collective_declaration(ddf_note_2026,sspx_clergy)"),
      info_all("absolution(abs_2026,invalid)", "delict(sspx_priest_x,n1379,abs_2026)")],
     "the censure route to 'invalid' runs only through a collective declaration: violation", mode=B)
scen("SX19", SC, "Notoriety in place of a hearing", SX + ["cand_notoriety_dispenses"],
     [any_branch_violation("notoriety_for_hearing(ddf_decree_2026,fellay)")],
     "violation: c. 1717 §1 may dispense the investigation, never the hearing of c. 1720 n. 1", mode=B)
scen("SX20", SC, "A declared bishop absolving after the decree takes effect", SX + ["recourse_decided_2026"],
     [info_all("absolution(abs_2026_bishop,invalid)", "delict(schreiber,n1379,abs_2026_bishop)",
               "claim_confirmed(ddf_note_2026,invalid_absolution(sspx_clergy),abs_2026_bishop)")],
     "once declared, his acts of governance are invalid (c. 1331 §2 n. 2), and the attempt is itself a delict", mode=B)
scen("SX21", SC, "Marriages", SX + ["hyp_delegation"],
     [info_all("marriage(m_2026,invalid_form)", "claim_confirmed(ddf_note_2026,invalid_marriage(sspx_clergy),m_2026)",
               "marriage(m_2026_delegated,valid_form)",
               "claim_contradicted(ddf_note_2026,invalid_marriage(sspx_clergy),m_2026_delegated)")],
     "invalid without delegation, valid with it: the note is right in the usual case, wrong where an ordinary delegated", mode=B)
scen("SX22", SC, "c. 751 read as a state, not an act", SX + ["c751_state_reading", "recourse_decided_2026"],
     [info_none("delict(fellay,n1364"), info_all("presumed_incurred(fellay,n1387)", "title_not_derived(ddf_decree_2026,fellay,n1364)")],
     "the decree's title for Fellay fails on that reading, but c. 1387 reaches him anyway as co-consecrator", mode=B)
scen("SX23", SC, "The lattice now", SXE,
     [info_all("degree(sspx,above,orthodox)"), info_none("church_proper(sspx)", "missing_bond(sspx,faculties_confession)")],
     "the faculties stand on the record; the Society's sort is unchanged", mode=B)


# the ordered pair: teaching first, law ordered to it
def _by_value(qv, sub, present):
    def chk(r):
        bs = [b for b in r["branches"] if qv in b["values"]]
        hits = [any(sub in f for f in b["facts"]) for b in bs]
        ok = bool(bs) and (all(hits) if present else not any(hits))
        return ok, f"{qv}: {sub} {'in every such branch' if bs and all(hits) else 'in none' if not any(hits) else 'in some'}"
    return chk

PR = "pair"
scen("PR1", PR, "The law follows the theological branch", SX,
     [_by_value("q(act2026_schismatic)=yes", "delict(fellay,n1364,", True),
      _by_value("q(act2026_schismatic)=no", "delict(fellay,n1364,", False),
      _by_value("q(act2026_schismatic)=no", "presumed_incurred(fellay,n1387)", True),
      info_none("law_without_premise")],
     "where the act is classified as schismatic, c. 1364 applies; where not, only c. 1387; no mismatch", mode=B)
scen("PR2", PR, "The law applied without regard to the theological branch", SX + ["cand_uncoupled"],
     [_by_value("q(act2026_schismatic)=no", "law_without_premise(n1364,", True)],
     "violation: a canon applied where its theological premise fails", mode=B)
scen("PR3", PR, "A canon-law result used to settle a doctrinal question", ["ecumenism", "lattice", "cand_law_answers_teaching"],
     [any_branch_violation("teaching_from_law(q(church_identity))")],
     "violation: law never answers a doctrinal question", mode=B)


def _theology_frontier(r):
    found = set()
    from .engine import known_parts
    for p, f in known_parts().items():
        if f in ("icon_history.lp",):
            for a in solve([p], "one")["atoms"]:
                if a.startswith("frontier(theology,"):
                    found.add(a)
    return not found, "; ".join(sorted(found)) or "nothing cited and unencoded, no question without sources"

scen("PR4", PR, "The theological frontier of the public base is empty", [], [_theology_frontier],
     "every cited source encoded; every question sourced; every teaching source has a character")


def _norm_check(r):
    from .norms import check
    c = check()
    ok = not c["vicious_cycles"] and not c["undefined_predicates"]
    return ok, f"{c['norms']} norms, {c['edges']} edges; vicious cycles: {len(c['vicious_cycles'])}; undefined: {', '.join(c['undefined_predicates']) or 'none'}"

scen("CL1", "canon", "The norm graph is well founded", [], [_norm_check],
     "no vicious cycles; every predicate derived or declared as input")


# ---------- the origin of the Spirit -------------------------------------
# Is the Filioque decided by the grammar? Run the Trinity both ways, then add
# each premise that has been offered to decide it.
FQ = "filioque"

FILIOQUE_TABLE = {("one_power", "mode"): (True, True), ("one_power", "opposition"): (True, False),
                  ("none", "mode"): (False, True), ("none", "opposition"): (False, False)}


def filioque_table_with(want, extra=()):
    """divine license (one power | none) x distinction (mode | opposition) x model (filioque | monopatrism)"""
    def chk(r):
        got, cells = {}, []
        for (lic, dist) in want:
            base = ["trinity", f"distinction_{dist}"] + (["no_divine_contraction"] if lic == "none" else []) + list(extra)
            got[(lic, dist)] = tuple(not solve(base + m, "one")["violations"] for m in ([], ["monopatrism"]))
            f, m = got[(lic, dist)]
            cells.append(f"{lic}/{dist}: F {'ok' if f else 'X'}, M {'ok' if m else 'X'}")
        return got == want, "; ".join(cells)
    return chk


filioque_table = filioque_table_with(FILIOQUE_TABLE)

scen("FQ1", FQ, "The Trinity, the Spirit from the Father alone", ["trinity", "monopatrism"],
     [clean, principles_of("spirit", "father"), only_theorem("both_positions"),
      only_theorem("principle_without_principle", "principle_without_principle(father)")],
     "consistent; the Spirit's principle is the Father; no person holds both positions; the monarchy holds")
scen("FQ2", FQ, "The monarchy in the Filioque model", ["trinity"],
     [only_theorem("principle_without_principle", "principle_without_principle(father)")],
     "the Father alone is principle without principle in both models (DH 1331; PCPCU 1995)")
scen("FQ3", FQ, "Monopatrism without a divine license", ["trinity", "monopatrism", "no_divine_contraction"],
     [clean], "consistent: nothing in God is from two, so the divine license is idle (compare S3)")
scen("FQ4", FQ, "Which premises decide it", [], [filioque_table],
     "license and mode: both; license and opposition: Filioque; no license and mode: monopatrism; neither: neither")
scen("FQ5", FQ, "Distinction by opposition only (ST I q.36 a.2)", ["trinity", "monopatrism", "distinction_opposition"],
     [has("persons_not_distinguished(son,spirit)")], "Son and Spirit not distinguished: Thomas's argument")
scen("FQ6", FQ, "Distinction by mode: a second Son", ["two_sons", "distinction_mode"],
     [has("persons_not_distinguished(a_son,b_son)"), count("persons_not_distinguished", 1)], "one source, one mode: not distinguished")
scen("FQ6b", FQ, "Distinction by opposition: a second Son", ["two_sons", "distinction_opposition"],
     [has("persons_not_distinguished(a_son,b_son)"), count("persons_not_distinguished", 1)],
     "the sons are not opposed: not distinguished; each is opposed to the begetter")
scen("FQ7", FQ, "Palamas: manifestation through the Son, typed", ["trinity", "monopatrism", "palamite_energies"],
     [clean, lambda r: ("manifested_through(spirit,son)" in r["info"], "manifested through the Son"),
      only_theorem("both_positions")],
     "consistent; mediation is not origin, so no person holds both positions")
scen("FQ8", FQ, "The same relation, undeclared", ["trinity", "monopatrism", "cand_energies_unwarranted"],
     [has("unknown_reltype(m)")], "A0 refuses it")
scen("FQ9", FQ, "Augustine on the spiration, kinds ignored, monopatrism",
     ["augustine", "aug_spiration", "aug_ignore_kinds", "monopatrism"],
     [unsat], "no mapping exists (T6c: 2)", mode="all")
scen("FQ10", FQ, "Lateran IV: the family, monopatrism", ["lateran", "lateran_family", "monopatrism"],
     [lateran({"n_super": 0, "n_licensed": 0}), clean], "not even a supertype resemblance (AN9: 1)", mode="opt")
scen("FQ11", FQ, "Lateran IV: Augustine's mind, monopatrism", ["lateran", "lateran_mind", "monopatrism"],
     [lateran({"n_licensed": 1, "n_kept": 1})], "only begetting licensed (AN10: 2)", mode="opt")
scen("FQ12", FQ, "Lateran IV: Palamas's mind, monopatrism", ["lateran", "lateran_mind_palamas", "monopatrism"],
     [lateran({"n_licensed": 2, "n_kept": 2})], "both processions licensed", mode="opt")
scen("FQ13", FQ, "Lateran IV: Palamas's mind, Filioque", ["lateran", "lateran_mind_palamas"],
     [lateran({"n_licensed": 1, "n_kept": 1})], "only begetting licensed", mode="opt")
scen("FQ14", FQ, "Lateran IV: Augustine's resident trinity, monopatrism",
     ["lateran", "lateran_mind", "lateran_resident", "monopatrism"],
     [lateran({"n_kept": 4}), none_of("lateran_iv")], "incomplete, so no violation (AN11: violation)", mode="opt")
scen("FQ15", FQ, "Lateran IV: Palamas's resident trinity, monopatrism",
     ["lateran", "lateran_mind_palamas", "lateran_resident", "monopatrism"],
     [lateran({"n_kept": 5}), has("lateran_iv(no_dissimilarity)")], "complete map: violation", mode="opt")
scen("FQ16", FQ, "Lateran IV: Adam, Eve, Seth (Or. 31.11), Filioque", ["lateran", "lateran_adam"],
     [lateran({"n_super": 2, "n_licensed": 0})], "the whole shape, no licensed likeness", mode="opt")
scen("FQ17", FQ, "Lateran IV: Adam, Eve, Seth, monopatrism", ["lateran", "lateran_adam", "monopatrism"],
     [lateran({"n_super": 1, "n_licensed": 0})], "half the shape, no licensed likeness", mode="opt")
scen("FQ18", FQ, "Authority: Lyons II and Florence", ["trinity", "filioque"],
     [cls("q(spirit_origin)=father_and_son", "settled"), cls("q(spirit_origin)=father_alone", "excluded"),
      cls("q(monarchy)=father_principle_without_principle", "settled"), cls("q(monarchy)=denied", "excluded"),
      clean_branches],
     "settled at tier 1; the monarchy settled with it", mode=B)
scen("FQ19", FQ, "Authority: the two councils removed", ["trinity", "filioque", "councils_relaxed"],
     [cls("q(spirit_origin)=father_and_son", "open"), cls("q(spirit_origin)=father_alone", "open"),
      main_with("q(spirit_origin)=father_alone", "principle_of(spirit,father)"), clean_branches],
     "open; both branches typecheck", mode=B)
scen("FQ20", FQ, "Authority: councils removed, distinction by opposition",
     ["trinity", "filioque", "councils_relaxed", "distinction_opposition"],
     [main_with("q(spirit_origin)=father_alone", "persons_not_distinguished(son,spirit)"),
      main_with("q(spirit_origin)=father_and_son", "violation(", present=False)],
     "the father-alone branch fails to distinguish Son and Spirit", mode=B)



# ---------- classical metaphysics of God: the accretion experiment -------
# Predictions committed first: docs/research/thomism-preregistration.md.
TH = "thomism"
DEF = ["defined_attributes"]
THESES = DEF + ["th01", "th02", "th03", "th04", "th05", "th06", "th15", "th21", "th22", "th23", "th24"]
THOMIST = THESES + ["simplicity_thomist", "attributes_by_reason", "mixed_relations", "transcendentals"]

scen("TH0", TH, "The attributes as defined (DH 800, 804, 3001-3002, 3025)", ALL_CLEAN + DEF,
     [clean], "no conflict; eternal and infinite were already the crossing guards")
scen("TH1", TH, "Th. 1: pure act, receiving as Thomas reads it", ["trinity", "th01", "th03", "th05"] + DEF,
     [clean], "no potency in the Son: he receives the whole, unlimited act")
scen("TH1b", TH, "Th. 1: something uncreated in the soul (DH 977)", ["family", "th01", "cand_uncreated_in_soul"],
     [has("potency_in_pure_act(man)")], "a creature typed as pure act: refused")
scen("TH2", TH, "Th. 1 and 5 with receiving in one mode", ["trinity", "th01", "th05", "univocal_reception"] + DEF,
     [has("potency_in_pure_act(son)", "potency_in_pure_act(spirit)", "composition_in_god(son,essence,real,defined)")],
     "potency in the Son and Spirit, each really distinct from the essence: the quaternity (DH 804)")
scen("TH2b", TH, "The same, simplicity from Th. 3 alone", ["trinity", "th03", "th05", "univocal_reception"],
     [has("composition_in_god(son,essence,real,defined)")], "Th. 3's simplicity refuses it too")
scen("TH3", TH, "Th. 3 and 5 against Suarez", ["family", "th03", "th05", "suarez_esse"],
     [has("received_esse_without_real_distinction(child)")], "the thesis refutes Suarez in its own words")
scen("TH3b", TH, "Suarez against the core alone", ["family", "suarez_esse"],
     [clean], "the core is neutral on the real distinction")
scen("TH3c", TH, "Th. 3 and 5 with the core", ["family", "th03", "th05"],
     [clean], "consistent")
scen("TH4", TH, "Th. 4: analogy, against univocity of mode", ["trinity", "circuit_only", "univocal_norm", "th04"],
     [has("univocity_against_th4(grain)")], "the univocity stress switches are refused; nothing else")
scen("TH5", TH, "Th. 6 and ST I q.45 a.3 ad 3 against the treatise (section 2)",
     ["family", "th06", "treatise_dependence_constitutive"],
     [has("constitutive_and_accidental(e)")], "the treatise calls the relation of creation constitutive; Thomas, an accident")
scen("TH5b", TH, "The same, with transcendental and predicamental relation",
     ["family", "th06", "treatise_dependence_constitutive", "transcendental_relation"],
     [clean], "being-from is constitutive; the relation that follows it is an accident")
scen("TH6", TH, "Th. 15: traducianism, without the thesis", ["family", "cand_traducianism"],
     [has("being_from_non_god(man,child)", "being_from_non_god(woman,child)")], "already a violation of A1: the thesis adds nothing")
scen("TH7", TH, "Th. 21 read with ST I q.36 a.2: Palamas's mind", ["lateran", "lateran_mind_palamas", "th21"],
     [has("will_before_intellect(amor)")], "love not from the word: refused", mode="opt")
scen("TH7b", TH, "Th. 21 read weakly: love presupposes its known object",
     ["lateran", "lateran_mind_palamas", "th21", "th21_object"], [none_of("will_before_intellect")],
     "admitted: love rests in the word", mode="opt")
scen("TH7c", TH, "Th. 21: Augustine's mind", ["lateran", "lateran_mind", "th21"],
     [none_of("will_before_intellect")], "admitted", mode="opt")
scen("TH7d", TH, "Th. 21: memory, understanding, will (De Trin. X)", ["lateran", "lateran_mind_memory", "th21"],
     [lateran({"n_licensed": 2}), none_of("will_before_intellect")], "admitted; both processions licensed", mode="opt")
scen("TH8", TH, "Th. 22 with bridges read in the order of knowing", ["family", "th22", "bridges_as_order_of_knowing"],
     [count("projection(", 5)], "every bridge a projection; ST I q.13 a.6 reads them in the order of being")
scen("TH9", TH, "Th. 24: creative power given to a minister (Lombard)", ["family", "cand_instrumental_creation"],
     [has("being_from_non_god(minister,child)")], "already a violation of A1 (ST I q.45 a.5)")
scen("TH10", TH, "Th. 24, last clause, against De auxiliis", ["auxiliis", "theses_1914"],
     [cls("q(efficacious_grace)=physical_premotion", "open"), cls("q(efficacious_grace)=middle_knowledge", "open"),
      clean_branches,
      lambda r: (any(b["w"].get(3) == 2 and "q(efficacious_grace)=middle_knowledge" in b["values"]
                     and "read_as(theses_1914,premotion)" in b["assume"] for b in r["branches"]),
                 "read as premotion, it weighs against Molina at tier 3")],
     "both schools stay open (Paul V's protection); read as premotion, it weighs, it does not cleave", mode=B)
scen("TH10b", TH, "The same, typed as directive norms (1916)", ["auxiliis", "theses_1914", "theses_directive"],
     [cls("q(efficacious_grace)=middle_knowledge", "open"),
      any_branch_violation("governance_read_as_teaching(theses_1914,q(efficacious_grace))")],
     "governance read as teaching, where read as premotion; still open", mode=B)
scen("TH11", TH, "Simplicity as Thomas reads it, Filioque", ["trinity", "simplicity_thomist", "attributes_by_reason"],
     [clean], "consistent")
scen("TH12", TH, "Simplicity as Thomas reads it, monopatrism", ["trinity", "monopatrism", "simplicity_thomist"],
     [has("persons_not_distinguished(son,spirit)")], "decides the Filioque: opposition follows from simplicity")
scen("TH13", TH, "Thomist simplicity with Scotus's formal distinction", ["trinity", "simplicity_thomist", "attributes_formal"],
     [count("composition_in_god(", 3)], "refused")
scen("TH13b", TH, "Distinction of reason under the synonym reading (ST I q.13 a.4, objections)",
     ["trinity", "simplicity_synonymous", "attributes_by_reason"],
     [count("composition_in_god(", 3)], "refused: Thomas sits between the synonym reading and Scotus")
scen("TH14", TH, "Simplicity as Scotus reads it, monopatrism", ["trinity", "monopatrism", "simplicity_scotist", "attributes_formal"],
     [clean], "does not decide the Filioque (Ord. I d.11 q.2)")
scen("TH14b", TH, "Scotist simplicity: a second Son", ["two_sons", "simplicity_scotist"],
     [has("persons_not_distinguished(a_son,b_son)")], "still refused: same source, same production")
scen("TH15", TH, "Simplicity as Palamas reads it, with the energies",
     ["trinity", "monopatrism", "simplicity_palamite", "palamite_energies"], [clean], "consistent")
scen("TH15b", TH, "Thomist simplicity with the energies", ["trinity", "simplicity_thomist", "palamite_energies"],
     [has("composition_in_god(essence,energies,energetic,thomist)")], "refused")
scen("TH15c", TH, "Simplicity as defined, with the energies", ["trinity", "monopatrism", "palamite_energies"] + DEF,
     [clean], "the definition does not decide it")
scen("TH15d", TH, "Palamite simplicity: a second Son", ["two_sons", "simplicity_palamite"],
     [has("persons_not_distinguished(a_son,b_son)")], "refused")
scen("TH16", TH, "The modal-collapse inference", ["family", "modal_collapse_inference"] + DEF,
     [has("modal_collapse(child)")], "every creature necessary: against DH 3025")
scen("TH16b", TH, "The same, with mixed relations (ST I q.13 a.7; q.19 a.3)",
     ["family", "modal_collapse_inference", "mixed_relations"] + DEF, [clean], "removed")
scen("TH16c", TH, "The same inference against Th. 3 and 22 only", ["family", "th03", "th22", "modal_collapse_inference"],
     [has("modal_collapse(child)")], "the contingency of Th. 22 suffices")
scen("TH17", TH, "Clarke: God really related to creatures, against the defined attributes",
     ["family", "clarke_relational"] + DEF, [clean], "passes: different, not changing")
scen("TH17b", TH, "Clarke against ST I q.13 a.7", ["family", "clarke_relational", "mixed_relations"] + DEF,
     [has("real_relation_in_god(god,child)")], "fails")
scen("TH17c", TH, "The core against ST I q.13 a.7", ["souls", "mixed_relations"] + DEF,
     [clean], "passes: the Bridegroom receives in his humanity")
scen("TH17d", TH, "Process theism against the defined attributes and Th. 1", ["family", "cand_process_god", "th01"] + DEF,
     [has("change_in_god(god)", "potency_in_pure_act(god)")], "fails both: Clarke's 'different, not changing' is the line")
scen("TH18", TH, "The treatise's receptivity (section 3), with Clarke's bridge",
     ["trinity", "treatise_receptivity", "reception_pure_perfection"], [clean], "licensed")
scen("TH18b", TH, "The same, typed as Long types it", ["trinity", "treatise_receptivity", "reception_creaturely"],
     [has("unlicensed_perfection(reception)")], "unlicensed: the grammar is neutral, the treatise is Clarke's")
scen("TH18c", TH, "Clarke and Long together", ["trinity", "reception_pure_perfection", "reception_creaturely"],
     [has("bridge_for_creaturely_predicate(reception)")], "contradictory")
scen("TH19", TH, "Transcendentals: the child of an illicit act graded less good",
     ["separate_act", "cand_child_less_good", "transcendentals"],
     [has("being_graded_less_good(child2,origin)", "norm_breach(grain(o,child2"), count("being_graded", 1)],
     "refused; the norm breach stays on the act (DV II.B.5)")
scen("TH19b", TH, "Transcendentals: goodness said of God", ["family", "transcendentals", "say_goodness_of_god"],
     [clean], "licensed: a pure perfection, God first")
scen("TH19c", TH, "Goodness said of God without the transcendentals", ["family", "say_goodness_of_god"],
     [has("unlicensed_perfection(goodness_t)")], "unlicensed: the core had no bridge for it")
scen("TH20", TH, "Deny by default (AN4) under Thomist simplicity",
     ["trinity", "family", "unlicense_origination_div", "simplicity_thomist"],
     [count("persons_not_distinguished(", 3)], "without the analogy of procession, nothing distinguishes the persons")
scen("TH20b", TH, "Deny by default under distinction by the properties of origin",
     ["trinity", "family", "unlicense_origination_div", "distinction_mode"],
     [none_of("persons_not_distinguished")], "unbegotten, begotten, proceeding: the names suffice (Or. 31.8-9)")
scen("TH20c", TH, "Deny by default, Thomist, opposition read off the names",
     ["trinity", "family", "unlicense_origination_div", "simplicity_thomist", "opposition_from_names"],
     [none_of("persons_not_distinguished")], "the persons return")



# ---------- the kernel's own world ----------------------------------------
# Creatures across the range of created being, so that kernel rules are tested
# without the theory's models (docs/layers.md; lp/kernel_world.lp).
KG = "kernel"

def only_violations(*allowed):
    def chk(r):
        extra = [v for v in r["violations"] if v not in allowed]
        return not extra, "; ".join(extra) or f"nothing beyond {', '.join(allowed) or 'none'}"
    return chk

def _crossing_rules(div, cr):
    two = ("one_power", "orig_div", "consubstantial", "orig_cr", "needs_welcome", "equal_dignity", "level")
    return ([f"x_{p}(X) :- {p}(X{',Y' if p in two else ''}), created_person({'Y' if p in two else 'X'})." for p in div] +
            [f"y_{p}(X) :- {p}(X{',Y' if p in two else ''}), divine(X)." for p in cr])

LINT_BATCH = "\n".join(_crossing_rules(("god", "divine", "one_power", "orig_div", "consubstantial"),
                                       ("creature", "organism", "orig_cr", "acts", "finite", "equal_dignity",
                                        "inanimate", "angel", "human")))
LINT_BATCH_ICON = "\n".join(_crossing_rules((), ("needs_welcome", "level", "lone")))

def lint_batch(_r):
    n = len(lint(LINT_BATCH))
    return n == 14, f"{n} of 14 crossing rules flagged"

def lint_batch_icon(_r):
    n = len(lint(LINT_BATCH_ICON))
    return n == 3, f"{n} of 3 crossing rules flagged"

scen("K1", KG, "The world: things, plants, animals, humans at every stage, angels", ["world"],
     [theorems("vacuous_over_persons(receptive)", "vacuous_over_persons(donative)"), clean],
     "consistent; receiving and giving hold of every created person, angels included")
scen("K1b", KG, "The theory's norm of origin and the lions", ["world"],
     [none_of("norm_breach(grain(o,cub")], "a norm binds rational agents: none for a cub with two parents")
scen("K1c", KG, "The theory's call to be bridal and the angels", ["world", "family", "angel_called_bridal"],
     [none_of("fails_to_distinguish(d_angel")], "the call is to human beings (MD 25): it tells an angel from a man")
scen("K2", KG, "Claims about action and origin, checked against the relations", ["world", "world_claims"],
     [has("false_claim(c_false)", "fails_to_distinguish(d_god_stone,donative,god,stone)"), count("false_claim", 1)],
     "one false claim; 'giving' as a property does not tell God from a stone")
scen("K3", KG, "God the cause of himself", ["world", "cand_causa_sui"],
     [has("unlicensed_crossing(received_being,god)")], "received being on God: refused")
scen("K4", KG, "Theogony: the god born of chaos", ["world", "cand_theogony"],
     [has("unlicensed_crossing(temporal_generation,god)")], "temporal generation on God: refused")
scen("K5", KG, "A demiurge beside God", ["world", "cand_demiurge"],
     [has("being_from_non_god(demiurge,peter)", "incoherent(grain(e,peter,demiurge,god))"), none_of("norm_breach(grain(e")],
     "a second giver of being: impossible, not merely wrong")
scen("K6", KG, "Two creatures each the other's ancestor", ["world", "cand_time_loop"],
     [has("origin_cycle(x1)", "origin_cycle(x2)")], "refused")
scen("K7", KG, "The Son a creature (Arius)", ["trinity", "cand_arian"],
     [has("unlicensed_crossing(eternal_procession,son)", "unlicensed_crossing(finite,son)")], "refused twice")
scen("K8", KG, "A bridge with no divine mode", ["world", "cand_bridge_no_divine_mode"],
     [has("bridge_without_mode(wisdom,div)")], "refused")
scen("K9", KG, "Acyclicity typed as a norm on both sides", ["world", "cand_univocal_acyclicity"],
     [has("deontic_in_god(acyclicity)")], "God under a norm: refused")
scen("K10", KG, "Men a little less than the angels (Ps 8:5)", ["world", "cand_angels_above_men"],
     [none_of("receiver_ranked_lower")], "a ranking of natures; equal dignity is among human persons (GS 29)")
scen("K11", KG, "The image withheld until birth", ["world", "cand_image_by_birth"],
     [has("image_denied(embryo,not_yet_born)")], "refused (Donum vitae I.1)")
scen("K12", KG, "The image denied to angels", ["world", "cand_image_of_angels"],
     [none_of("image_denied")], "the deposit is silent on angels; Thomas affirms it (ST I q.93 a.3): a school's question")
scen("K13", KG, "A nature term with its own nature's predicate", ["communicatio", "communicatio_nature"],
     [verdicts({"humanity_is_created": "well_typed"})], "well typed")
scen("K14", KG, "The static crossing check, one rule per sorted predicate", [],
     [lint_batch], "every sorted predicate of the kernel, paired across the line, is flagged")
scen("AN13", AN, "The static crossing check on the theory's own sorts", [],
     [lint_batch_icon], "the theory registers its sorts in its own file; each is flagged across the line")
scen("AN14", AN, "The theory's one principle of the child, without its bridge", ["family", "drop_principle_bridge"],
     [has("norm_breach(grain(o,child,man,woman))")],
     "the parents are one principle only through the bridge; without it, two principles and the norm breached")


# ---------- School runtimes (TTC-SCHOOLS(7)) --------------------------------
# A runtime is a named list of parts (engine.RUNTIMES), named as the part
# rt_<name>; naming none runs default. The full boot and pair tables are
# tests/test_schools.py (slow: TTC_SLOW=1).
RT = "runtimes"

def branches_n(n):
    return lambda r: (r["models"] == n, f"{r['models']} branches")

def theorem_absent(t):
    return lambda r: (t not in r["theorems"], f"{t} {'present' if t in r['theorems'] else 'absent'}")

scen("RT1", RT, "Bare: the defined Filioque", ["trinity", "rt_bare"],
     [has("incoherent(grain(o,spirit,father,son))"), count("incoherent(", 1)],
     "two principles (DH 850): the deposit defines one principle, not how; only a runtime licenses it")
scen("RT2", RT, "Bare: creatures do not act", ["world", "rt_bare"],
     [theorem_absent("vacuous_over_persons(donative)"), theorems("vacuous_over_persons(receptive)")],
     "'donative' now tells persons apart: its vacuity rested on agere sequitur esse")
scen("RT3", RT, "Bare: the theory's analogy of one principle", ["family", "rt_bare"],
     [has("bridge_without_mode(principle,div)")], "no divine side: the theory presupposes the Latin license")
scen("RT4", RT, "Thomist: the Son a creature (Arius)", ["trinity", "cand_arian", "rt_thomist"],
     [has("potency_in_pure_act(son)", "unlicensed_crossing(finite,son)")], "refused again, by Th. 1")
scen("RT5", RT, "Scotist: univocity of the concept of being, modes distinct", ["world", "rt_scotist"],
     [clean], "boots: the kernel types modes, not concepts")
scen("RT6", RT, "Thomist and Scotist, Th. 4 read as worded", ["world", "rt_thomist", "rt_scotist", "th04_predication"],
     [has("univocity_against_th4(being)")], "being said univocally: refused")
scen("RT6b", RT, "Thomist and Scotist, Th. 4 read minimally", ["world", "rt_thomist", "rt_scotist"],
     [none_of("univocity_against_th4"), has("received_esse_without_real_distinction", "composition_in_god(")],
     "they clash on the formal distinction and on Th. 5, not on univocity")
scen("RT7", RT, "Thomist and Suarezian", ["world", "rt_thomist", "rt_suarezian"],
     [has("received_esse_without_real_distinction"), none_of("composition_in_god")], "Th. 5 only")
scen("RT8", RT, "Palamite: the Trinity", ["trinity", "rt_palamite"],
     [clean, principles_of("spirit", "father"),
      lambda r: ("manifested_through(spirit,son)" in r["info"], "manifested through the Son")],
     "boots; the Spirit from the Father; the energies typed")
scen("RT9", RT, "Palamite: the theory's analogy of one principle", ["family", "rt_palamite"],
     [has("bridge_without_mode(principle,div)")], "the theory does not boot on Palamas: it is Latin")
scen("RT10", RT, "Thomist and Palamite: the Trinity", ["trinity", "rt_thomist", "rt_palamite"],
     [has("composition_in_god(essence,energies,energetic,thomist)", "persons_not_distinguished(son,spirit)")],
     "simplicity and the principle of distinction")
scen("RT11", RT, "Scotist and Palamite: the Filioque", ["trinity", "rt_scotist", "rt_palamite"],
     [principles_of("spirit", "father"), none_of("persons_not_distinguished", "grain"), has("composition_in_god(")],
     "retracted, not refused: monopatrism removes a fact of the deposit's model (M1); only simplicity clashes")
scen("RT12", RT, "De auxiliis, Thomist", ["auxiliis", "theses_1914", "rt_thomist"],
     [branches_n(2), clean_branches], "premotion only", mode=B)
scen("RT12b", RT, "De auxiliis, Suarezian", ["auxiliis", "theses_1914", "rt_suarezian"],
     [branches_n(2), clean_branches], "concurrence only", mode=B)
scen("RT12c", RT, "De auxiliis, Thomist and Suarezian", ["auxiliis", "theses_1914", "rt_thomist", "rt_suarezian"],
     [branches_n(4), clean_branches, cls("q(efficacious_grace)=physical_premotion", "open"),
      cls("q(efficacious_grace)=middle_knowledge", "open")], "both readings kept; open (Paul V)", mode=B)
scen("RT13", RT, "DH 1330 as deposit: Scotus's counterfactual (HYPOTHETICAL monopatrism)",
     ["trinity", "monopatrism", "rt_scotist", "dh1330_deposit"],
     [has("persons_not_distinguished(son,spirit)")], "refused (Ord. I d.11 q.2)")
scen("RT13b", RT, "DH 1330 a Thomist reading: Scotus's counterfactual", ["trinity", "monopatrism", "rt_scotist"],
     [clean], "stands")
scen("RT14", RT, "DH 1330 as deposit: the Filioque table", [],
     [filioque_table_with({("one_power", "mode"): (True, False), ("one_power", "opposition"): (True, False),
                           ("none", "mode"): (False, False), ("none", "opposition"): (False, False)},
                          ["dh1330_deposit"])],
     "the mode rows collapse into the opposition rows: the Filioque follows inside the grammar")

# ---------- personal scenarios ($TTC_HOME/scenarios.json) -----------------
def _expect_check(e):
    kind = e.get("kind")
    if kind == "status":
        return cls(e["of"], e["is"])
    if kind == "preferred":
        return prefers(e["question"], e["value"])
    if kind == "present":
        atom, where = e["atom"], e.get("in", "every")

        def chk(r):
            bs = r.get("branches") or []
            hits = [any(atom in f for f in b["facts"]) for b in bs]
            got = "every" if hits and all(hits) else "some" if any(hits) else "none"
            return (got == where) if where != "some" else any(hits), f"{atom}: {got}"
        return chk
    raise ValueError(f"unknown expectation kind: {kind!r} (use status, preferred or present)")


def personal_scenarios():
    from .engine import personal_scenarios_raw
    return [dict(id=p["id"], group="personal", name=p["name"], parts=p.get("parts", []), facts=p.get("facts", ""),
                 checks=[_expect_check(e) for e in p["expect"]], expected=p.get("expected", "as recorded"),
                 mode="branches") for p in personal_scenarios_raw()]


def run(ids=None, extra=()):
    """Run the scenarios (all, or those whose id starts with one of `ids`)."""
    rows = []
    for s in S + personal_scenarios():
        if ids and not any(s["id"] == i or s["id"].startswith(i) for i in ids):
            continue
        r = solve(s["parts"] + list(extra), s["mode"], facts=s.get("facts", ""))
        results = [c(r) for c in s["checks"]]
        rows.append(dict(id=s["id"], group=s["group"], name=s["name"], expected=s["expected"],
                         got=" | ".join(d for _, d in results), ok=all(o for o, _ in results)))
    return rows


def main(argv=None):
    argv = sys.argv[1:] if argv is None else argv
    if "--show" in argv:
        sid = argv[argv.index("--show") + 1]
        s = next(x for x in S if x["id"] == sid)
        r = solve(s["parts"], s["mode"])
        print("\n".join(r["atoms"]) or "(no atoms)")
        return 0
    extra = [argv[argv.index("--with") + 1]] if "--with" in argv else []   # e.g. --with a9_universal
    rows = run(extra=extra)
    failed = sum(not r["ok"] for r in rows)
    for r in rows:
        print(f"[{'pass' if r['ok'] else 'FAIL'}] {r['id']:4} {r['name']}\n        expected: {r['expected']}\n        got:      {r['got']}")
    print(f"\n{len(rows) - failed}/{len(rows)} passed")
    if "--md" in argv:
        path = pathlib.Path(argv[argv.index("--md") + 1])
        lines = ["| ID | Group | Test | Expected | Got | Result |", "| --- | --- | --- | --- | --- | --- |"]
        lines += ["| " + " | ".join(str(x).replace("|", "/") for x in (r["id"], r["group"], r["name"], r["expected"], r["got"],
                                                                         "pass" if r["ok"] else "FAIL")) + " |" for r in rows]
        path.write_text("\n".join(lines) + "\n")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
