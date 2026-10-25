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

from . import engine as E
from .engine import classify, lint, pref_key, preferred_value, solve

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
# TTC-CREED CR2 (rule 7): the theory's models named the incarnate `christ`, apart from the Son; they now
# name him `son`. T3b, X3, X4, L1 and L3 expect the same violations under that name (T3b's pair prints in
# name order).
scen("T3b", "theorem", "Finite totality is unique: a soul given twice", ["souls", "soul_two_spouses"],
     [has("rivalrous_total(soul1,rival,son)")], "violation")
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
     [has("image_denied(son,no_exercised_reason(embryo))")], "violation at the embryonic Christ")
scen("X4", "prohibition", "Couple-completion imago", ["souls", "cand_couple_completion"],
     [has("image_denied(son,unmarried)")], "violation at the unmarried Christ")
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
      branch_violation("q(infant_fate)=limbo", "reception_without_act(infant,son)"),
      branch_violation("q(infant_fate)=poena_sensus", "reception_without_act(infant,son)"),
      branch_violation("q(infant_fate)=beatific", "reception_without_act", present=False)],
     "the grammar flags the protected limbo school as ill-formed", mode=B)
scen("L2", "case", "Unbaptized infants, A9 as MD 25 words it (default)", ["limbo"],
     [cls("q(infant_fate)=limbo", "open"), cls("q(infant_fate)=beatific", "open"),
      clean_branches, prefers("q(infant_fate)", "beatific")],
     "neutral: all three open, CCC 1261 tips preference to hope", mode=B)
scen("L3", "case", "A refusal, old universal A9", ["refusal", "a9_universal"],
     [has("reception_without_act(refuser,son)")], "refusal is ill-formed")
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
        key = pref_key
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
      # TTC-COMMUNION TC2 (rule 14): the claimed consensus is its own source; the profession keeps tier 3
      branch_of("q(dp_principle)=intrinsically_wrong", "live_shadow", t2=False, reint=["oum(dh795)"])],
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
      # TTC-COMMUNION TC2 (rule 14): the claimed consensus is its own source; FC 84 keeps tier 3
      branch_of("q(admission_internal)=possible_in_some_cases", "live_shadow", t2=False, reint=["oum(fc84)"])],
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
     # TTC-COMMUNION TC1 (rule 14): LG 25 defines nothing (notification of 16 Nov. 1964); tier 3, c. 752
     [owed_everywhere("lg25,religious_submission", "definitive_d1,firm_assent",
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

def info_none(*subs, apart=()):
    def chk(r):
        hit = sorted({f for b in r["branches"] for f in b["facts"] for s in subs if s in f and not f.startswith(apart)})
        return not hit, "; ".join(hit) or f"none of: {', '.join(subs)}"
    return chk

def under(marker, chk):
    """the check applied only to the branches whose facts carry marker (a reading, say); none such fails"""
    def c(r):
        bs = [b for b in r["branches"] if any(marker in f for f in b["facts"])]
        if not bs:
            return False, f"no branch with {marker}"
        ok, d = chk(dict(r, branches=bs))
        return ok, f"[{marker}] {d}"
    return c

DOLUS_READ = "presumption_read(presumes_dolus)"           # c. 1321 §4 read to presume dolus (TTC-REPAIRS2)
IMPUT_READ = "presumption_read(presumes_imputability)"    # c. 1321 §4 read to presume mere imputability
# for a one-model check (shown): the reading fixed by a switch part, so the model is not chosen by chance
DOLUS_PART = ["c1321_dolus_read"]

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


def main_with(qv, sub, present=True, where=None):
    """among main branches holding qv (and resting on the assumption `where`), sub is in every one (or in none)"""
    def chk(r):
        bs = [b for b in r["branches"] if b["status"] == "main" and qv in b["values"]
              and (where is None or any(where in a for a in b["assume"]))]
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
# Ecclesia Dei adflicta's reading of c. 751: given as law (c. 16 §2), or in a
# particular matter, the 1988 consecrations (c. 16 §3)? Disputed: both are computed.
ED_LAW = "assumed_fact(interpretation_form(ed1988,law))"
ED_PARTICULAR = "assumed_fact(false(interpretation_form(ed1988,law)))"

scen("SX11", SC, "Incurred and declared, recourse pending", SX,
     # changed with TTC-REPAIRS2 (CI2): no source of imputability is entered, so the penalties are incurred
     # only where c. 1321 §4 is read to presume dolus; the declaration and its suspension do not turn on it
     [info_all("declaration_suspended(ddf_decree_2026,fellay)", "investigation_dispensable(ddf_decree_2026,galarreta)"),
      under(DOLUS_READ, info_all("presumed_incurred(fellay,n1387)", "presumed_incurred(schreiber,n1387)")),
      # changed with the ordered pair (and the investigation check moved from
      # Fellay, whose declared title is c. 1364, to de Galarreta, c. 1387): c. 1364 now applies only in the branches
      # that classify the act as schismatic (all main branches), not in the shadow
      # changed with the law library (TTC-LAW G2): c. 1364 applies in the schismatic branches where
      # Ecclesia Dei adflicta's reading binds 2026 (given as law); where it reaches 1988 only, c. 18 reads
      # c. 751 strictly for 2026 and the title of c. 1364 is not derived
      under(DOLUS_READ, main_with("q(act2026_schismatic)=yes", "presumed_incurred(fellay,n1364)", where=ED_LAW)),
      main_with("q(act2026_schismatic)=yes", "presumed_incurred(fellay,n1364)", present=False, where=ED_PARTICULAR),
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
     # changed with TTC-REPAIRS2 (not predicted): the bishop's absolution is illicit because he is excommunicated,
     # incurred and undeclared; on the reading of c. 1321 §4 that presumes mere imputability nothing is incurred
     # without a source entered, so there it is licit
     [info_all("class_faculty(sspx_clergy,confession)", "absolution(abs_2026,valid,licit)",
               "absolution(abs_2026_bishop_jc,valid,licit)",
               "claim_contradicted(ddf_note_2026,invalid_absolution(sspx_clergy),abs_2026)"),
      under(DOLUS_READ, info_all("absolution(abs_2026_bishop,valid,illicit)")),
      under(IMPUT_READ, info_all("absolution(abs_2026_bishop,valid,licit)"))],
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
     # changed with TTC-REPAIRS2 (CI2): c. 1387 reaches him, incurred where c. 1321 §4 is read to presume dolus
     [info_none("delict(fellay,n1364"), info_all("title_not_derived(ddf_decree_2026,fellay,n1364)", "delict(fellay,n1387,"),
      under(DOLUS_READ, info_all("presumed_incurred(fellay,n1387)"))],
     "the decree's title for Fellay fails on that reading, but c. 1387 reaches him anyway as co-consecrator", mode=B)
scen("SX23", SC, "The lattice now", SXE,
     [info_all("degree(sspx,above,orthodox)"), info_none("church_proper(sspx)", "missing_bond(sspx,faculties_confession)")],
     "the faculties stand on the record; the Society's sort is unchanged", mode=B)
# TTC-REPAIRS2: the Pontiff's own act, the last recourse, the decree made known
scen("SX24", SC, "A decree approved in specific form, the recourse pending (c. 333 §3)", SX + ["decree_in_specific_form"],
     [info_all("declared(fellay,n1364)", "no_recourse_against_papal_act(ddf_decree_2026)"), info_none("declaration_suspended(")],
     "the Pontiff's own act: no recourse lies, nothing is suspended", mode=B)
scen("SX25", SC, "The Dicastery's decision on the recourse is the last (SST art. 24 §1)",
     SX + ["recourse_decided_2026", "ddf_recourse_final"],
     [info_all("no_further_recourse(ddf_ruling_2026)"), info_none("declaration_suspended(ddf_ruling_2026")],
     "a further recourse in a reserved delict is not admitted and suspends nothing", mode=B)
scen("SX26", SC, "A declaration takes effect when made known (c. 54 §1)", SX + ["recourse_decided_2026", "notified_later"],
     [info_none("declared(fellay,"), info_all("declared(galarreta,n1387)", "declared(schreiber,n1387)",
                                              "effect_from_decree_date(ddf_decree_2026)")],
     "made known after the clock: not yet declared; before it: declared; not entered: dated from the decree, noted", mode=B)


# the ordered pair: teaching first, law ordered to it
def _by_value(qv, sub, present, where=None):
    def chk(r):
        bs = [b for b in r["branches"] if qv in b["values"] and (where is None or any(where in a for a in b["assume"]))]
        hits = [any(sub in f for f in b["facts"]) for b in bs]
        ok = bool(bs) and (all(hits) if present else not any(hits))
        return ok, f"{qv}: {sub} {'in every such branch' if bs and all(hits) else 'in none' if not any(hits) else 'in some'}"
    return chk

PR = "pair"
scen("PR1", PR, "The law follows the theological branch", SX,
     # changed with the law library (TTC-LAW G2): where the act is classified as schismatic, c. 1364 applies
     # when Ecclesia Dei adflicta's reading binds 2026; where it reaches 1988 only, penal law read strictly
     # declines the title, and the pair raises nothing
     [_by_value("q(act2026_schismatic)=yes", "delict(fellay,n1364,", True, where=ED_LAW),
      _by_value("q(act2026_schismatic)=yes", "delict(fellay,n1364,", False, where=ED_PARTICULAR),
      _by_value("q(act2026_schismatic)=no", "delict(fellay,n1364,", False),
      # changed with TTC-REPAIRS2 (CI2): incurred where c. 1321 §4 is read to presume dolus
      under(DOLUS_READ, _by_value("q(act2026_schismatic)=no", "presumed_incurred(fellay,n1387)", True)),
      info_none("law_without_premise")],
     "where the act is classified as schismatic, c. 1364 applies; where not, only c. 1387; no mismatch", mode=B)
scen("PR2", PR, "The law applied without regard to the theological branch", SX + ["cand_uncoupled"],
     # changed with the law library (TTC-LAW G2): only where c. 751's act reading binds 2026 is there a title to misapply
     [_by_value("q(act2026_schismatic)=no", "law_without_premise(n1364,", True, where=ED_LAW),
      _by_value("q(act2026_schismatic)=no", "law_without_premise(n1364,", False, where=ED_PARTICULAR)],
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
def shadow_with(qv, sub):
    """among live shadows holding qv, sub is in every one"""
    def chk(r):
        bs = [b for b in r["branches"] if b["status"] == "live_shadow" and qv in b["values"]]
        ok = bool(bs) and all(any(sub in f for f in b["facts"]) for b in bs)
        return ok, f"{qv} (live shadow): {sub} {'present' if ok else 'absent'}"
    return chk

# TTC-SOURCES FQ5: these two expectations changed. Without the two councils
# "from the Father alone" was open; with Leo I's letter (447) entered it is a
# live shadow that reintegrates if the letter is relaxed. The grammar's checks
# read the same branch, now a shadow.
scen("FQ19", FQ, "Authority: the two councils removed", ["trinity", "filioque", "councils_relaxed"],
     [cls("q(spirit_origin)=father_and_son", "settled"), cls("q(spirit_origin)=father_alone", "shadow"),
      reint_includes("q(spirit_origin)=father_alone", "leo_i_447"),
      shadow_with("q(spirit_origin)=father_alone", "principle_of(spirit,father)"), clean_branches],
     "a live shadow of Leo I's letter; both branches typecheck", mode=B)
scen("FQ20", FQ, "Authority: councils removed, distinction by opposition",
     ["trinity", "filioque", "councils_relaxed", "distinction_opposition"],
     [shadow_with("q(spirit_origin)=father_alone", "persons_not_distinguished(son,spirit)"),
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
def every_bridge_projected(r):
    """As many projections as bridges from God, whatever bridges the base holds."""
    bridges = [a for a in solve(r["_parts"], "one", facts=r["_facts"], show=("bridge/3",))["atoms"]
               if a.startswith("bridge(") and a.endswith(",div,cr)")]
    k = sum("projection(" in v for v in r["violations"])
    return k == len(bridges) > 0, f"{k} projections, {len(bridges)} bridges"

scen("TH8", TH, "Th. 22 with bridges read in the order of knowing", ["family", "th22", "bridges_as_order_of_knowing"],
     [every_bridge_projected], "every bridge a projection; ST I q.13 a.6 reads them in the order of being")
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

# ---------- The human act (TTC-ACT(7)) --------------------------------------
# act.lp types the agent's knowledge, will and freedom; the canons read it.
# Every interior claim is a case's input (canon_cases.lp: act_penal, act_fear).
AC = "act"

# what c. 1325 supplies, read three ways (TTC-REPAIRS3)
BAR_ONLY = "c1325_read(bar_only)"
AS_DOLUS = "c1325_read(as_dolus)"
AFF_DOLUS = "c1325_read(affected_as_dolus)"
# whether c. 18 reaches c. 1321 §4, a disputed premise
REACH = "assumed_fact(penal_use(c1321_4))"
NO_REACH = "assumed_fact(false(penal_use(c1321_4)))"

def assuming(atom, chk):
    """the check applied only to the branches resting on the assumption atom; none such fails"""
    def c(r):
        bs = [b for b in r["branches"] if atom in b["assume"]]
        if not bs:
            return False, f"no branch assuming {atom}"
        ok, d = chk(dict(r, branches=bs))
        return ok, f"[{atom}] {d}"
    return c

def branch_facts(*subs, every=True):
    def chk(r):
        hits = [all(any(s in f for f in b["facts"] + b["assume"]) for s in subs) for b in r["branches"]]
        ok = all(hits) if every else any(hits) and not all(hits)
        return ok, f"{', '.join(subs)}: {'every' if all(hits) else 'some' if any(hits) else 'no'} branch"
    return chk

scen("AC1", AC, "c. 1321 §4: the presumption alone", ["act_penal"],
     # changed with TTC-REPAIRS2 (CI2): what §4 presumes is now read both ways; with no source entered the
     # penalty is incurred only where §4 is read to presume dolus (CIC/17 c. 2200 §2's rule)
     [under(DOLUS_READ, info_all("presumed_incurred(x0,n1379)")),
      under(IMPUT_READ, info_all("source_not_established(x0,n1379")), under(IMPUT_READ, info_none("presumed_incurred(x0,"))],
     "an external violation, nothing claimed: imputability presumed; incurred where the presumption is read to reach dolus",
     mode=B)
scen("AC2", AC, "c. 1323: not subject to a penalty", ["act_penal"],
     [info_all(*[f"exempt({p})" for p in ("x1,a_child", "x3,a_law", "x4,a_fact", "x7,a_chance", "x11,a_nec",
                                         "x12,a_def", "x13,a_bel", "x21,a_inadv", "x24,a_beld")]),
      info_none(*[f"presumed_incurred({x}," for x in ("x1", "x3", "x4", "x7", "x11", "x12", "x13", "x21", "x24")])],
     "under sixteen; ignorance, error or inadvertence without fault, of the law or of the delict's matter; chance; "
     "necessity; due defence; a blameless belief in an excusing circumstance", mode=B)
scen("AC3", AC, "c. 1324: tempered, and no latae sententiae penalty binds", ["act_penal"],
     [info_all("mitigated(x2,a_teen,minor)", "mitigated(x14,a_belv,mistaken)", "mitigated(x15,a_imp,imperfect_reason)",
               "mitigated(x16,a_pas,passion)", "mitigated(x17,a_pen,penalty_unknown)"),
      info_none(*[f"presumed_incurred({x}," for x in ("x2", "x14", "x15", "x16", "x17")])],
     "§1 nn. 1, 3, 4, 8, 9; §3", mode=B)
scen("AC4", AC, "No human act: force, lack of reason, habitual insanity", ["act_penal"],
     [info_all("not_a_human_act(x8,a_force)", "not_a_human_act(x9,a_insane)", "not_a_human_act(x10,a_noreason)"),
      info_none("presumed_incurred(x8,", "presumed_incurred(x9,", "presumed_incurred(x10,")],
     "an actus hominis (ST I-II q. 1 a. 1; q. 6 a. 5); cc. 1322, 1323 nn. 3, 6", mode=B)
scen("AC5", AC, "c. 1325: crass, supine, affected ignorance", ["act_penal"],
     # changed with TTC-REPAIRS2 (not predicted): c. 1325 bars excuse and mitigation, but supplies no source;
     # whether gross ignorance counts as dolus is not encoded, so these are incurred only on the dolus reading
     # changed with TTC-REPAIRS3 (IG4): what c. 1325 supplies is now read three ways (AC15); the result above
     # is the reading on which it bars and supplies nothing (bar_only), and the checks are restated under it
     [info_all("ignorance_disregarded(x6,a_crass,law)", "ignorance_disregarded(x22,a_supine,law)",
               "ignorance_disregarded(x23,a_affect,law)"),
      under(BAR_ONLY, under(DOLUS_READ, info_all("presumed_incurred(x6,n1379)", "presumed_incurred(x22,n1379)",
                                                 "presumed_incurred(x23,n1379)"))),
      under(BAR_ONLY, under(IMPUT_READ, info_all("source_not_established(x6,", "source_not_established(x22,",
                                                 "source_not_established(x23,")))],
     "never taken into account: where c. 1325 supplies nothing, the presumption stands, and binds where it is read "
     "to reach dolus", mode=B)
scen("AC6", AC, "Dolus and culpa (c. 1321 §§2-3)", ["act_penal"],
     [info_all("dolus(x18,a_dolus)", "presumed_incurred(x18,n1379)", "culpa_not_punished(x5,n1379,a_factv)",
               "culpa_not_punished(x19,n1379,a_neg)"),
      info_none("presumed_incurred(x5,", "presumed_incurred(x19,")],
     "the violation known and willed is punished; culpability only where the law provides", mode=B)
scen("AC6b", AC, "c. 1321 §3: a law that punishes culpability (HYPOTHETICAL)", ["act_penal", "culpa_punished"],
     [info_all("presumed_incurred(x5,n1379)", "presumed_incurred(x19,n1379)"),
      info_none("culpa_not_punished", "source_not_established(x5,", "source_not_established(x19,")],
     "culpa punished; culpa entered is a source, whatever c. 1321 §4 is read to presume", mode=B)
scen("AC7", AC, "A disputed claim is computed both ways", ["act_penal"],
     [branch_facts("assumed_fact(interior(x20", every=False),
      branch_facts("assumed_fact(false(interior(x20", every=False),
      info_any("exempt(x20,a_disp)", "presumed_incurred(x20,n1379)")],
     "never decided: one branch each way", mode=B)
scen("AC8", AC, "One fear, four canons", ["act_fear"],
     [info_all("juridic_act(j1,rescindable)", "marriage(m1,invalid_consent)", "exempt(p,a1)", "mitigated(p,a2,fear)",
               "exempt(w,a3)", "mitigated(y,a4,fear)"),
      info_none("presumed_incurred(p,", "presumed_incurred(w,", "presumed_incurred(y,")],
     "c. 125 §2 rescindable; c. 1103 invalid; c. 1323 n. 4 no penalty; c. 1324 §1 n. 5 tempered where the act is "
     "intrinsically evil or harms souls", mode=B)
scen("AC9", AC, "Force, unintended fear, fear from within", ["act_fear"],
     [info_all("juridic_act(j2,never_placed)", "marriage(m2,invalid_consent)", "marriage(m4,invalid_consent)"),
      info_none("marriage(m3,invalid_consent)")],
     "c. 125 §1; c. 1103 needs fear from without, not unjust or intended", mode=B)
scen("AC13", AC, "What c. 1321 §4 presumes, read both ways (TTC-REPAIRS2)", ["act_penal"],
     [under(DOLUS_READ, info_all("presumed_incurred(x0,n1379)", "presumed_incurred(x18,n1379)")),
      under(IMPUT_READ, info_all("source_not_established(x0,n1379", "presumed_incurred(x18,n1379)")),
      under(IMPUT_READ, info_none("presumed_incurred(x0,", "source_not_established(x18,"))],
     "dolus entered: incurred on both readings; no source entered: incurred only where §4 is read to presume dolus",
     mode=B)
scen("AC14", AC, "c. 18 and c. 1321 §4: whether strict interpretation reaches the presumption (TTC-REPAIRS3)",
     ["act_penal"],
     [branch_facts(REACH, every=False), branch_facts(NO_REACH, every=False),
      assuming(REACH, info_all("declined_by_strict_interpretation(c1321_4,presumes_dolus,all)", IMPUT_READ)),
      assuming(REACH, info_none(DOLUS_READ)),
      assuming(NO_REACH, under(DOLUS_READ, info_all("presumed_incurred(x0,n1379)"))),
      assuming(NO_REACH, under(IMPUT_READ, info_all("source_not_established(x0,n1379"))),
      assuming(NO_REACH, info_none("declined_by_strict_interpretation"))],
     "disputed, computed both ways: where c. 18 reaches §4, only the narrower reading stands; where it does not, "
     "both", mode=B)
scen("AC15", AC, "c. 1325 read three ways: what gross ignorance supplies (TTC-REPAIRS3)", ["act_penal"],
     [info_any(BAR_ONLY, AS_DOLUS, AFF_DOLUS),
      under(BAR_ONLY, under(DOLUS_READ, info_all("presumed_incurred(x6,n1379)", "presumed_incurred(x22,n1379)",
                                                 "presumed_incurred(x23,n1379)"))),
      under(BAR_ONLY, under(IMPUT_READ, info_none("presumed_incurred(x6,", "presumed_incurred(x22,",
                                                  "presumed_incurred(x23,"))),
      under(AS_DOLUS, info_all("presumed_incurred(x6,n1379)", "presumed_incurred(x22,n1379)",
                               "presumed_incurred(x23,n1379)")),
      under(AS_DOLUS, info_none("source_not_established(x6,", "source_not_established(x22,",
                                "source_not_established(x23,")),
      under(AFF_DOLUS, info_all("presumed_incurred(x23,n1379)", "culpa_not_punished(x6,n1379,a_crass)",
                                "culpa_not_punished(x22,n1379,a_supine)")),
      under(AFF_DOLUS, info_none("presumed_incurred(x6,", "presumed_incurred(x22,"))],
     "bars excuse and mitigation and supplies nothing; or counts as dolus; or affected ignorance, directly willed, "
     "as dolus, and crass or supine, by negligence, as culpa (ST I-II q. 6 a. 8)", mode=B)
scen("AC15b", AC, "c. 1325 read three ways, culpa punished (HYPOTHETICAL)", ["act_penal", "culpa_punished"],
     [under(AFF_DOLUS, info_all("presumed_incurred(x6,n1379)", "presumed_incurred(x22,n1379)",
                                "presumed_incurred(x23,n1379)")),
      info_none("culpa_not_punished(x6,", "culpa_not_punished(x22,")],
     "where the law punishes culpa, and crass or supine ignorance is counted as culpa, all three bind on every reading of §4", mode=B)
scen("AC16", AC, "c. 1324 §1 nn. 6, 7, 10; c. 1321 §2: mitigated, or not grave (TTC-REPAIRS3)", ["act_penal_more"],
     [info_all("mitigated(y1,b_excess,excess_defence)", "mitigated(y2,b_prov,provocation)",
               "mitigated(y3,b_dimin,not_full)", "no_formal_delict(y4,b_slight)"),
      info_none("presumed_incurred(y1,", "presumed_incurred(y2,", "presumed_incurred(y3,", "presumed_incurred(y4,"),
      info_none("mitigated(y4,", "source_not_established(y4,")],
     "defence beyond due moderation, grave and unjust provocation, imputability not full yet grave: tempered, and no "
     "latae sententiae penalty binds (§3); imputability not grave: no delict in the formal sense", mode=B)
scen("AC17", AC, "c. 1326 §1 nn. 3-4: aggravation (TTC-REPAIRS3)", ["act_penal_more"],
     [info_all("aggravated(y5,b_stim,stimulated_passion)", "presumed_incurred(y5,n1379)",
               "culpa_not_punished(y6,n1379,b_fore)"),
      info_none("mitigated(y5,", "source_not_established(y5,", "aggravated(y6,", "presumed_incurred(y6,"),
      info_none("aggravated(y5,b_stim,sought_disturbance)")],       # each note by its ground (TTC-REPAIRS4 DS3)
     "passion deliberately stimulated supplies dolus, on every reading of §4; foreseen culpa aggravates only where "
     "culpa is punished", mode=B)
scen("AC17b", AC, "c. 1326 §1 n. 3: foreseen culpa, culpa punished (HYPOTHETICAL)", ["act_penal_more", "culpa_punished"],
     [info_all("aggravated(y6,b_fore,foreseen_event)", "presumed_incurred(y6,n1379)")],
     "the event foreseen, precautions omitted: aggravating", mode=B)
scen("AC18", AC, "c. 1323: proper and improper exemptions (TTC-REPAIRS3)", ["act_penal"],
     [info_all(*[f"no_formal_delict({p})" for p in ("x3,a_law", "x4,a_fact", "x7,a_chance", "x8,a_force",
                                                    "x9,a_insane", "x10,a_noreason", "x13,a_bel", "x21,a_inadv",
                                                    "x24,a_beld")]),
      info_all("delict_stands_exempt(x1,a_child)", "delict_stands_exempt(x11,a_nec)", "delict_stands_exempt(x12,a_def)"),
      info_none(*[f"delict_stands_exempt({x}," for x in ("x3", "x4", "x7", "x8", "x9", "x10", "x13", "x21", "x24")]),
      info_none("no_formal_delict(x1,", "no_formal_delict(x11,", "no_formal_delict(x12,")],
     "improper (nn. 2, 3, 7; no human act): no delict in the formal sense; proper (nn. 1, 4, 5): the delict stands, "
     "exempt from the penalty", mode=B)
scen("AC19", AC, "The lack of reason without fault, and habitual: as before (TTC-REPAIRS4)", ["act_in_causa"],
     [info_all("not_a_human_act(z1,c_blame)", "no_formal_delict(z1,c_blame)",
               "not_a_human_act(z4,c_habit)", "no_formal_delict(z4,c_habit)"),
      info_none("presumed_incurred(z1,", "presumed_incurred(z4,", "voluntary_in_cause(z1,", "voluntary_in_cause(z4,",
                "c1325_read"),
      lambda r: (len(r["branches"]) == 3, f"{len(r['branches'])} branches")],
     "drunkenness without fault excuses wholly (c. 1323 n. 6; II-II q. 150 a. 4); the habitually insane stay incapable "
     "(c. 1322)", mode=B)
scen("AC20", AC, "c. 1324 §1 n. 2: culpable drunkenness, voluntary in its cause (TTC-REPAIRS4)", ["act_in_causa"],
     [info_all("voluntary_in_cause(z2,c_culp)", "mitigated(z2,c_culp,culpable_disturbance)", "not_a_human_act(z2,c_culp)"),
      info_none("presumed_incurred(z2,", "no_formal_delict(z2,", "exempt(z2,"),
      under(IMPUT_READ, info_all("source_not_established(z2,n1379"))],
     "not excused, being voluntary through the act before it, but lessened: the penalty tempered, and no latae "
     "sententiae penalty binds (§3)", mode=B)
scen("AC21", AC, "c. 1326 §1 n. 4: the disturbance sought (TTC-REPAIRS4)", ["act_in_causa"],
     [info_all("voluntary_in_cause(z3,c_sought)", "aggravated(z3,c_sought,sought_disturbance)",
               "presumed_incurred(z3,n1379)"),
      info_none("mitigated(z3,", "source_not_established(z3,", "no_formal_delict(z3,", "exempt(z3,",
                "aggravated(z3,c_sought,stimulated_passion)")],
     "sought so as to commit the offence or to excuse it: neither exempt nor tempered; dolus, on every reading of "
     "c. 1321 §4, and aggravated", mode=B)
scen("AC12", AC, "A public claim of necessity: recorded, never decided", ["sspx"],
     [info_any("defence_claimed(galarreta)"), info_none("exempt(")],
     "the Society's claim is noted where a penalty is presumed; it exempts no one, since no interior claim is supplied",
     mode=B)
scen("AC10", AC, "Bare: no creature acts", ["act_penal", "rt_bare"],
     [info_all("not_a_human_act(x0,a_plain)"), info_none("presumed_incurred")],
     "no human act, no penalty: canon law presupposes agere sequitur esse", mode=B)
scen("AC11", AC, "Bare: the SSPX case", ["sspx", "rt_bare"],
     [info_none("presumed_incurred")], "the same", mode=B)

# ---------- Law (TTC-LAW(7)) -------------------------------------------------
# law.lp: the order of laws, a law against a higher law, readings. The general
# norms (cc. 7-8, 14, 16-21, 85-86, 135 §2) call it.
LW = "law"

scen("LW1", LW, "Ecclesia Dei adflicta given in a particular matter: the 2026 title", SX,
     [main_with("q(act2026_schismatic)=yes", "title_not_derived(ddf_decree_2026,fellay,n1364)", where=ED_PARTICULAR),
      # changed with TTC-REPAIRS2 (CI2): incurred where c. 1321 §4 is read to presume dolus
      under(DOLUS_READ, main_with("q(act2026_schismatic)=yes", "presumed_incurred(fellay,n1387)", where=ED_PARTICULAR)),
      main_with("q(act1988_schismatic)=yes", "delict(lefebvre,n1364_1983", where=ED_PARTICULAR),
      main_with("q(act2026_schismatic)=yes", "declined_by_strict_interpretation(c751,act_suffices,e2026_schreiber)",
                where=ED_PARTICULAR),
      # TTC-PENAL AB9 (expectation changed): given as law, Ecclesia Dei reaches 30 June 1988 only where it
      # is declaratory (c. 16 §2), so a strict reading can now appear in that world for 1988; never for 2026.
      main_with("q(act2026_schismatic)=yes", "declined_by_strict_interpretation(c751,act_suffices,e2026", present=False, where=ED_LAW),
      info_none("law_without_premise")],
     "c. 16 §3: the reading reaches 1988 only; for 2026, c. 18 reads c. 751 strictly: no title under c. 1364, "
     "c. 1387 still reaches Bp Fellay as co-consecrator; 1988 untouched", mode=B)
scen("LW2", LW, "The 2026 decree approved by the Pope (HYPOTHETICAL)", SX + ["decree_papally_approved"],
     # changed with TTC-REPAIRS2 (CI2): incurred where c. 1321 §4 is read to presume dolus
     [under(DOLUS_READ, main_with("q(act2026_schismatic)=yes", "presumed_incurred(fellay,n1364)", where=ED_PARTICULAR)),
      under(DOLUS_READ, main_with("q(act2026_schismatic)=yes", "presumed_incurred(fellay,n1364)", where=ED_LAW))],
     "the legislator's act in the particular matter binds it (c. 16 §3): the title returns", mode=B)
scen("LW3", LW, "The mind of the legislator, by rank (c. 17; q. 96 a. 4)", ["law_cases"],
     [info_all("reading_excluded(l_sup,broad)", "permitted(act_n,l_sup)"), info_none("permitted(act_b,l_sup)"),
      info_any("does_not_bind(l_bish)", "permitted(act_n,l_bish)"), info_none("reading_excluded(l_bish"),
      lambda r: (not all(any("does_not_bind(l_bish)" in f for f in b["facts"]) for b in r["branches"]),
                 "the bishop's broad reading is a branch, not the only one")],
     "the supreme legislator's law is read in harmony with the natural law; a bishop's keeps the reading, and on it "
     "does not bind", mode=B)
scen("LW4", LW, "Doubt of law, doubt of fact (c. 14)", ["law_cases"],
     [info_none("invalid(contract_c,l_inv)", "obliged(person_q,l_obl)"), info_all("invalid(contract_d,l_inv)"),
      info_all("obliged(person_r,l_obl)", "obliged(person_s,l_fact)", "ordinary_may_dispense(l_fact,person_s)")],
     "in a doubt of law an invalidating or obliging law reaches only what every reading reaches; a doubt of fact "
     "leaves the obligation, and the ordinary may dispense", mode=B)
scen("LW5", LW, "Laws against a higher law (c. 135 §2; q. 96 a. 4)", ["law_cases"],
     [info_all("does_not_bind(l_low)", "does_not_bind(l_nat)", "does_not_bind(l_pos)", "does_not_bind(l_ete)"),
      info_none("obliged(person_u,", "obliged(person_v,", "obliged(person_w,", "obliged(person_x,")],
     "against a higher human law, the natural law, divine positive law, the eternal law: no binding force", mode=B)
scen("LW6", LW, "The lacuna (c. 19)", ["law_cases"],
     [info_all("resolved_by(m_civil,analogy_of_similar_laws)"), info_any("resolved_by(m_disp,common_opinion)"),
      lambda r: (not all(any("resolved_by(m_disp" in f for f in b["facts"]) for b in r["branches"]),
                 "the disputed equitable rule holds in some branches only")],
     "equity is input: supplied, or computed both ways", mode=B)
scen("LW6b", LW, "A penalty by analogy (HYPOTHETICAL)", ["law_cases", "law_penal_lacuna"],
     [any_branch_violation("penalty_without_law(m_pen)")], "c. 19 excludes penal matters; c. 221 §3", mode=B)
scen("LW7", LW, "Dispensation (cc. 85-86)", ["law_cases"],
     [info_all("dispensed(l_disp,person_t)")], "a merely ecclesiastical law is dispensed", mode=B)
scen("LW7b", LW, "Dispensations no human authority can give (HYPOTHETICAL)", ["law_cases", "law_bad_dispensations"],
     [any_branch_violation("dispensing_divine_law(dsp2,d1)"), any_branch_violation("dispensing_divine_law(dsp3,d2)"),
      any_branch_violation("dispensing_essentials(dsp4,l_form)"), info_none("dispensed(d1", "dispensed(d2", "dispensed(l_form")],
     "the natural law, divine positive law, and what constitutes the act", mode=B)
scen("LW8", LW, "A law's failing to bind used to settle doctrine", ["law_cases", "cand_validity_settles_doctrine"],
     [any_branch_violation("teaching_from_law(q(broad_bish))")], "law answers no doctrinal question (rule 1)", mode=B)
scen("LW10", LW, "Who falls under which code", SX,
     [info_all("delict(lefebvre,n1382_1983,e1988_fellay)", "delict(fellay,n1382_1983,e1988_fellay)"),
      info_none("delict(lefebvre,n1387", "delict(galarreta,n1382_1983,e2026"),
      main_with("q(act2026_schismatic)=yes", "delict(schreiber,n1364,", where=ED_LAW)],
     "1988 under the 1983 Code (c. 1382), 2026 under Book VI as revised (c. 1387): the dates come from promulgation "
     "(cc. 7-8) and the reordering (c. 20); consecrator and consecrated alike under c. 751", mode=B)
# TTC-SOURCES GN3: this scenario gained the computation. It read c. 21 as an
# info line only; with dated texts (revocation_dated) a doubtful revocation
# leaves the earlier text in force, a certain one revokes it, and nothing
# branches.
scen("LW9", LW, "Revocation in doubt (c. 21)", ["law_cases", "revocation_dated"],
     [info_all("revocation_not_presumed(l_new,l_old)", "revocation_not_presumed(l_new_x,b_old_x)",
               "text_in_force(b_old_x)", "text_in_force(b_old_z)", "text_revoked(b_old_y,l_new_x,reorders)",
               "text_revoked(b_old_w,l_new_x,contrary)"),
      info_none("text_in_force(b_old_y)", "text_in_force(b_old_w)", "text_revoked(b_old_x", "text_revoked(b_old_z"),
      lambda r: (r["models"] == solve(["law_cases"], "branches")["models"], "no branch added by the doubt")],
     "not presumed: the earlier text stays in force, and nothing branches", mode=B)

# ---------- The deposit as the creeds profess it (TTC-CREED) ---------------
CR = "creed"
CREED = ["trinity", "creed", "os_virginal", "ic"]

def preferred_assume(parts, a):
    """every preferred main branch (c. 749 §3, then weight) carries the assumption a"""
    def chk(_r):
        mains = [b for b in solve(parts, "branches")["branches"] if b["status"] == "main"]
        best = min(pref_key(b) for b in mains)
        top = [b for b in mains if pref_key(b) == best]
        return all(a in b["assume"] for b in top), f"preferred: {[b['assume'] for b in top][:2]}"
    return chk

def assumed_none_in(parts, sub):
    def chk(_r):
        hit = sorted({a for b in solve(parts, "branches")["branches"] for a in b["assume"] if sub in a})
        return not hit, "; ".join(hit) or f"no branch assumes {sub}"
    return chk

def assumed_none(sub):
    def chk(r):
        hit = sorted({a for b in r["branches"] for a in b["assume"] if sub in a})
        return not hit, "; ".join(hit) or f"no branch assumes {sub}"
    return chk

def eff_tier_is(src, tier, parts):
    def chk(_r):
        atoms = solve(parts, "one", show=("eff_tier/2",))["atoms"]
        got = sorted(a for a in atoms if a.startswith(f"eff_tier({src},"))
        return got == [f"eff_tier({src},{tier})"], ", ".join(got) or f"no tier for {src}"
    return chk

def missing_nature(parts, *sentences):
    def chk(_r):
        atoms = solve(parts, "one", show=("nature_missing/1",))["atoms"]
        got = [x for x in sentences if f"nature_missing({x})" in atoms]
        return got == list(sentences), f"ill typed by the person's natures: {', '.join(got) or 'none'}"
    return chk

def shows(parts, *atoms_wanted, sig=()):
    def chk(_r):
        atoms = solve(parts, "one", show=sig)["atoms"]
        got = [a for a in atoms_wanted if a in atoms]
        return got == list(atoms_wanted), ", ".join(got) or "none"
    return chk

# Scripture: tier 0, read, never raw
scen("CS2", CR, "Defined senses: Jn 3:5, Jn 20:22-23", ["defined_senses"],
     [branches_n(1), branch_facts("read_as(jn3_5,literal)", "read_as(jn20_23,sacramental)"),
      cls("q(water_of_baptism)=metaphor", "excluded"), cls("q(jn20_23_power)=preaching_the_gospel", "excluded")],
     "the figurative and the kerygmatic readings excluded with no branch (DH 1615, 1703)", mode=B)
def readings_carry_values(text, pairs):
    def chk(r):
        bad = [b["values"] for b in r["branches"] for rd, qv in pairs
               if f"read_as({text},{rd})" in b["assume"] and qv not in b["values"]]
        seen = {rd for b in r["branches"] for rd, _ in pairs if f"read_as({text},{rd})" in b["assume"]}
        return not bad and seen == {rd for rd, _ in pairs}, f"{text}: each reading holds its value ({len(seen)} read)"
    return chk

scen("CS2c", CR, "The same texts with the defining canons removed", ["defined_senses", "senses_relaxed"],
     [branches_n(4), readings_carry_values("jn20_23", [("sacramental", "q(jn20_23_power)=forgiving_in_the_sacrament"),
                                                      ("kerygmatic", "q(jn20_23_power)=preaching_the_gospel")]),
      readings_carry_values("jn3_5", [("literal", "q(water_of_baptism)=true_water"),
                                      ("figurative", "q(water_of_baptism)=metaphor")])],
     "inerrancy: each branch holds what its reading says; without the definitions both readings stand", mode=B)
scen("CS2b", CR, "A text entered raw", ["defined_senses", "cand_scripture_raw"],
     [lambda r: (any("scripture_without_readings(raw_text)" in a
                     for a in solve(["defined_senses", "cand_scripture_raw"], "one", show=("frontier/2",))["atoms"]),
                 "frontier: a text with no readings")],
     "flagged on the frontier: Scripture enters through its readings", mode=B)
scen("CS3", CR, "The brothers of the Lord (Mk 6:3; Mt 1:25)", ["marian", "brothers_of_the_lord"],
     [assumed_none("read_as(mk6_3,helvidius)"), assumed_none("read_as(mt1_25,until_after)"),
      branch_facts("read_as(mt1_25,until_only)"),
      cls("q(brothers_of_the_lord)=sons_of_mary", "excluded"),
      cls("q(brothers_of_the_lord)=sons_of_joseph", "open"), cls("q(brothers_of_the_lord)=kinsmen", "open")],
     "Helvidius excluded by the analogy of faith (ever-virgin); Epiphanius and Jerome both main", mode=B)
scen("CS3b", CR, "The brothers of the Lord without the dogma", ["brothers_of_the_lord"],
     [cls("q(brothers_of_the_lord)=sons_of_mary", "open"),
      readings_carry_values("mk6_3", [("helvidius", "q(brothers_of_the_lord)=sons_of_mary"),
                                      ("epiphanius", "q(brothers_of_the_lord)=sons_of_joseph"),
                                      ("jerome", "q(brothers_of_the_lord)=kinsmen")])],
     "Helvidius's reading stands: the exclusion is the analogy of faith's, not the text's", mode=B)
scen("CS4", CR, "The Fathers' consent on Jn 6:53, as of 1550", ["jn6", "asof_1550"],
     [branches_n(3), branch_facts("assumed_fact(unanimous(jn6_53,eucharistic))", every=False),
      cls("q(jn6_53_sense)=eucharistic", "open"), cls("q(jn6_53_sense)=spiritual", "open")],
     "the claim of unanimous consent computed both ways; where it holds, it fixes the reading", mode=B)
scen("CS4b", CR, "The same as of 1600", ["jn6", "asof_1600"],
     [branches_n(2), assumed_none("assumed_fact(unanimous("),
      branch_facts("assumed_fact(false(unanimous(jn6_53,eucharistic)))")],
     "refused: Trent records the Fathers' differing readings (DH 1727)", mode=B)

# The creeds and the Incarnation
scen("CR1", CR, "The creeds with the two councils removed", ["trinity", "filioque", "councils_relaxed", "creeds"],
     [cls("q(spirit_origin)=father_alone", "excluded")],
     "finding: the Quicumque and Lateran IV settle the Filioque without Lyons II and Florence (FQ19 opens it)", mode=B)
# TTC-SAECULUM RC2: this expectation changed. It was "excluded": typed by its
# composition (c. 500), the Quicumque settled the Filioque before Lyons II,
# its reception undated and unclaimed. Reception is now a dated claim with
# its claimant (rule 14), computed both ways and never preferred, since no
# act at tier 1 hands the creed on (Florence's decree for the Armenians, 1439,
# does, at tier 3). As of 1100 "from the Father alone" is open: excluded only
# where the Quicumque is received. On the record the preferred branch is the
# Father alone, by Photius's weight (886); the record has no Latin witness
# to the Filioque before 1100 (roadmap).
QR, QNR = "assumed_fact(received(quicumque))", "assumed_fact(false(received(quicumque)))"
# TTC-SOURCES FQ1: this expectation changed again. It was "open, the Father
# alone preferred", Photius's weight the record's only. With the Latin
# witnesses before 1100 entered, Leo I's letter (447, DH 284), at tier 3,
# cleaves: "from the Father alone" is a live shadow that reintegrates if the
# letter is relaxed, and "from the Father and the Son" is settled in the main
# branches, against Photius's weight at tier 5. The gap was the record's.
scen("CR1b", CR, "The creeds as of 1100", ["trinity", "filioque", "creeds", "asof_1100"],
     [cls("q(spirit_origin)=father_alone", "shadow"), cls("q(spirit_origin)=father_and_son", "settled"),
      reint_includes("q(spirit_origin)=father_alone", "leo_i_447"),
      lambda r: (all(QNR in b["assume"] for b in r["branches"] if "q(spirit_origin)=father_alone" in b["values"])
                 and any(QR in b["assume"] for b in r["branches"])
                 and not any(QR in b["assume"] and "q(spirit_origin)=father_alone" in b["values"] for b in r["branches"]),
                 "the Father alone only where the Quicumque is not received"),
      lambda r: (all(b["w"][5] >= 1 for b in r["branches"] if b["status"] == "main"), "Photius weighs against the main branches"),
      prefers("q(spirit_origin)", "father_and_son")],
     "finding (RC2, TTC-SOURCES FQ1): a live shadow of Leo I's letter as of 1100; Photius weighs at tier 5", mode=B)
scen("CR1c", CR, "Paul VI's Credo is tier 3 by its form", ["creeds"],
     [eff_tier_is("credo_1968", 3, ["creeds"]), eff_tier_is("quicumque", 1, ["creeds"]),
      eff_tier_is("apostles_creed", 1, ["creeds"]), eff_tier_is("nicene_creed", 1, ["creeds"]),
      eff_tier_is("lateran_iv_1215", 1, ["creeds"]),
      none_of("tier_inconsistent")],
     "\"without being strictly speaking a dogmatic definition\" (n. 3)")
scen("CR1d", CR, "Lateran IV as of 1250, the Quicumque set aside", ["trinity", "filioque", "creeds", "quicumque_relaxed", "asof_1250"],
     [cls("q(spirit_origin)=father_alone", "excluded"), cls("q(monarchy)=denied", "excluded")],
     "Firmiter (DH 800): the Spirit from both, the Father from none", mode=B)
scen("CR1e", CR, "The Credo alone", ["trinity", "filioque", "creeds", "councils_relaxed", "creed_parts_relaxed"],
     [reint_includes("q(spirit_origin)=father_alone", "credo_1968")],
     "tier 3: it cleaves, it does not delete", mode=B)
scen("CR2", CR, "One and the same: the Son incarnate", CREED,
     [clean, lambda r: ("mother_of_god(mary,son)" in r["info"], "Mother of God: " + str("mother_of_god(mary,son)" in r["info"])),
      verdicts({"the_son_born_of_mary": "well_typed"})],
     "the incarnate is the Son, divine and of a human nature; Mary is Mother of God")
scen("CR2a", CR, "The incarnate is divine with no model of the Trinity", ["creed"],
     [lambda r: (all(a in solve(["creed"], "one", show=("divine/1", "person/1"))["atoms"]
                     for a in ("divine(son)", "person(son)")), "divine(son), person(son)")],
     "the union is in the person: divine, and so a person")
scen("CR2d", CR, "What may be said of whom", CREED + ["creed_predication"],
     [verdicts({"the_son_is_god": "well_typed", "mary_is_god": "ill_typed", "the_son_born_of_mary": "well_typed"}),
      missing_nature(CREED + ["creed_predication"], "mary_is_god")],
     "the Son is God and born of Mary; Mary is not God (MA1)")
scen("CR3c", CR, "The Father suffered", CREED + ["cand_father_suffered"],
     [has("nature_not_had(father,hum)")], "the Father has no human nature")
scen("CR2b", CR, "The incarnate named apart from the Son", ["trinity", "cand_incarnate_apart"],
     [has("fourth_divine_person(christ)")], "a fourth divine person: the theory's models before they named the Son")
scen("CR2c", CR, "The Father made flesh", ["trinity", "cand_incarnate_father"],
     [has("incarnate_not_the_son(father)")], "the only-begotten Son was made incarnate (DH 801)")
scen("CR3", CR, "Nestorius: the one born of Mary a man joined to the Word", ["trinity", "cand_nestorian"],
     [has("two_persons_in_christ(jesus_man,son)"), verdicts({"god_the_word_born_of_mary": "ill_typed"}),
      missing_nature(["trinity", "cand_nestorian"], "god_the_word_born_of_mary"),
      lambda r: (not any(i.startswith("mother_of_god") for i in r["info"]), "no Mother of God")],
     "two persons; 'God the Word was born of Mary' ill typed; Mary not Mother of God (DH 250-251)")
scen("CR3b", CR, "The Father born of Mary", CREED + ["cand_patripassian"],
     [has("nature_not_had(father,hum)"), verdicts({"father_born_of_mary": "ill_typed"}),
      missing_nature(CREED + ["cand_patripassian"], "father_born_of_mary")],
     "the Father has no human nature (finding: T5 typed the term, not the person's natures)")
scen("CR4", CR, "Two births, one principle", CREED,
     [none_of("grain"), principles_of("son", "father")], "born of Mary in his humanity, from the Father alone in his divinity")
scen("CR4b", CR, "The birth of Mary typed by the person only", CREED + ["cand_birth_by_person"],
     [has("incoherent(grain(o,son,father,mary))")], "a second principle of the Son (A3)")
scen("CR5", CR, "Growth and passion, typed by nature, on the Thomist runtime", CREED + ["rt_thomist"],
     [clean, shows(CREED + ["rt_thomist"], "changes_in(son,hum)", sig=("changes_in/2",))],
     "he grows and suffers in the flesh: no change in God, no potency in pure act")
scen("CR5b", CR, "The same said of the person only", CREED + ["cand_change_by_person", "rt_thomist"],
     [has("change_in_god(son)", "potency_in_pure_act(son)")], "change in God (DH 800); potency in pure act (Th. 1)")
scen("CR5c", CR, "The passion said in the divine nature", CREED + ["cand_change_in_divinity"],
     [has("change_in_god(son)")], "change in God")
scen("CR6", CR, "Bare: the incarnate on no runtime", CREED + ["rt_bare"],
     [has("one_operation(son)", "one_will(son)")], "one operation, one will: against Constantinople III (DH 556-557)")
scen("CR6b", CR, "Bare with Christ's human operation alone", CREED + ["rt_bare", "christs_humanity_operates"],
     [none_of("one_operation", "one_will")], "boots: the deposit defines this one created operation")
scen("CR7a", CR, "Apollinaris", CREED + ["cand_apollinarian"], [has("no_rational_soul(son)", "one_will(son)")], "refused (DH 301)")
scen("CR7b", CR, "Eutyches", CREED + ["cand_eutychian"], [has("one_nature(son)")], "refused (DH 302)")
scen("CR7c", CR, "One will", CREED + ["cand_monothelite"], [has("one_will(son)")], "refused (DH 556)")
scen("CR7d", CR, "One operation", CREED + ["cand_monoenergist"], [has("one_operation(son)")], "refused (DH 557)")
scen("CR7e", CR, "The creed on every runtime", CREED,
     [lambda r: (all(not solve(CREED + [rt], "one")["violations"] for rt in
                     ("rt_thomist", "rt_scotist", "rt_suarezian", "rt_palamite")), "clean on the four runtimes")],
     "clean on the four runtimes")

# Mary
scen("CM2", CR, "The Immaculate Conception as of 1860: Thomas against a later definition", ["ic", "asof_1860"],
     [info_any("against_tier1(aquinas,q(ic))")], "recorded as a Doctor's teaching against a definition (III q.27 a.2)", mode=B)
scen("CM1b", CR, "Ever-virgin without Constantinople II", ["marian", "creeds", "marian_council_relaxed"],
     [reint_includes("q(ever_virgin)=no", "lateran_649"), reint_includes("q(ever_virgin)=no", "cum_quorundam_1555"),
      reint_includes("q(ever_virgin)=no", "credo_1968")],
     "the tier-3 acts cleave the contrary; they do not delete it", mode=B)
scen("CM1c", CR, "The Immaculate Conception without its definition or the protections",
     ["ic", "creeds", "ic_definition_relaxed", "ic_unprotected"],
     [reint_includes("q(ic)=no", "credo_1968")], "the Credo cleaves; it does not define", mode=B)
scen("CM3", CR, "The Assumption and Mary's death", ["marian"],
     [cls("q(assumption)=yes", "settled"), cls("q(died_before_assumption)=yes", "open"),
      cls("q(died_before_assumption)=no", "open"), prefers("q(died_before_assumption)", "yes"),
      shows(["marian", "creeds"], "papal_form(cum_quorundam_1555,ordinary)", "papal_form(credo_1968,ordinary)",
            "papal_form(munificentissimus_1950,ex_cathedra)", sig=("papal_form/2",))],
     "the Assumption settled (DH 3903); whether she died first open, the Damascene weighing for it", mode=B)

# The economy
scen("CE1", CR, "Original sin: no reading of why Christ is free", ["trinity", "creed", "ic"],
     [has("sin_in_christ(son)")], "finding: propagation (DH 1513) reaches him unless a reading says why it does not")
scen("CE1b", CR, "Original sin: by the union", ["trinity", "creed", "os_union", "ic"],
     [clean], "boots")
scen("CE1d", CR, "Christ free because his mother was, as of 1600", ["trinity", "creed", "ic", "asof_1600",
                                                                "cand_os_by_immaculate_mother"],
     [branch_violation("q(ic)=no", "sin_in_christ(son)"), branch_violation("q(ic)=yes", "sin_in_christ", present=False),
      cls("q(ic)=no", "open")],
     "the protected maculist branch (Sixtus IV, 1483) would hold sin in Christ: the reading censures what was "
     "forbidden to censure; Thomas, Bernard, Bonaventure held Christ sinless without it", mode=B)
scen("CE1e", CR, "Thomas's own reading in the same branch", ["trinity", "creed", "ic", "asof_1600", "os_virginal"],
     [branch_violation("q(ic)=no", "sin_in_christ", present=False)],
     "no human father, no propagation (I-II q.81 a.5): Christ free whatever is held of Mary", mode=B)
scen("CE1c", CR, "Original sin by descent alone", CREED + ["cand_descent_alone"],
     [has("sin_in_christ(son)", "stain_on_the_preserved(mary)")], "against DH 301 and DH 2803")
scen("CE2", CR, "The cross's effects only after it in time", CREED + ["cand_merits_in_time"],
     [has("effect_before_cause(preservation_of_mary,passion)")], "turns DH 2803 red")
scen("CE2b", CR, "A grace before the cross, without foresight, on a theory of time", CREED + ["cand_grace_unforeseen", "causes_precede"],
     [has("effect_before_cause(grace_of_abraham,passion)")], "a cause after its effect, where causes precede in time")
scen("CE2c", CR, "The same with no theory of time", CREED + ["cand_grace_unforeseen"],
     [none_of("effect_before_cause")], "the core holds no theory of time: a tree, a DAG, the cross as root may run")
scen("CE2d", CR, "Mary preserved, on the theory of time", CREED + ["causes_precede"],
     [clean], "merits foreseen: nothing fires")
scen("CE0", CR, "The economy in one order", CREED,
     [lambda r: (all(a in solve(CREED, "one", show=("before/2",))["atoms"] for a in
                     ("before(creation,judgment)", "before(conception_of_mary,passion)",
                      "before(passion,resurrection)")), "creation ... passion ... judgment")],
     "from creation to judgment, the passion between")
scen("CE3", CR, "The economy reversed", CREED + ["cand_economy_reversed"],
     [has("economy_out_of_order(death)", "economy_out_of_order(resurrection)")], "risen before he died")

# ---------- The morality of acts, sin and grace (TTC-MORAL) ----------------
MR = "moral"

def every_branch_with(when, then, present=True):
    """in every branch whose assumptions or facts contain `when`, `then` is (or is not) among the facts"""
    def chk(r):
        bs = [b for b in r["branches"] if any(when in x for x in b["assume"] + b["facts"])]
        hits = [any(then in f for f in b["facts"]) for b in bs]
        ok = bool(bs) and (all(hits) if present else not any(hits))
        return ok, f"{len(bs)} branch(es) with {when}: {then} {'in all' if all(hits) else 'in none' if not any(hits) else 'in some'}"
    return chk

def only_with(fact, assumption):
    """`fact` appears in some branch, and only in branches that assume `assumption`"""
    def chk(r):
        bs = [b for b in r["branches"] if any(fact in f for f in b["facts"])]
        ok = bool(bs) and all(any(assumption in a for a in b["assume"]) for b in bs)
        return ok, f"{fact}: {len(bs)} branch(es), {'each on' if ok else 'not all on'} {assumption}"
    return chk

GRACE_RUNTIMES = ("rt_thomist", "rt_scotist", "rt_suarezian", "rt_palamite")

scen("MS1", MR, "Mortal, on the claims", ["moral_cases"],
     [lambda r: (sorted(i for i in r["info"] if i.startswith("mortal_on_the_claims")) ==
                 ["mortal_on_the_claims(m1,act_m1)", "mortal_on_the_claims(m3,act_m3)"],
                 ", ".join(sorted(i for i in r["info"] if i.startswith("mortal"))) or "none"),
      lambda r: ("does_not_bind(l_unjust)" in r["info"], "l_unjust does not bind")],
     "grave matter by teaching with knowledge and consent claimed (m1); consent unclaimed, nothing (m2); "
     "a law that does not bind makes nothing sinful (m4, q. 96 a. 4)")
scen("MS2", MR, "Double effect", ["moral_cases"],
     [lambda r: (sorted(i for i in r["info"] if i.startswith("double_effect")) ==
                 ["double_effect(d1,act_d1)", "double_effect(d5,def1)"],
                 ", ".join(sorted(i for i in r["info"] if i.startswith("double_effect"))) or "none"),
      lambda r: (sorted(i for i in r["info"] if i.startswith("licit_on_the_claims")) ==
                 ["licit_on_the_claims(d1,act_d1)", "licit_on_the_claims(d5,def1)"], "licit on the claims: d1, d5")],
     "holds for d1 and for defence (d5); not where the evil is the means (d2), the object evil (d3), "
     "or proportion unclaimed (d4)")
scen("MS2b", MR, "Defence: double effect and c. 1323 n. 5 read one claim", ["moral_cases", "act_penal"],
     [lambda r: (all(x in r["info"] for x in ("double_effect(d5,def1)", "exempt(x12,a_def)")), "both from defence(moderate)")],
     "the same supplied claim (act.lp's due_defence); neither keeps a predicate of its own")
def shown(parts, preds, *atoms, facts="", absent=()):
    """with only `preds` shown, every atom in `atoms` is derived and none in `absent`"""
    def chk(r):
        a = set(solve(parts, "one", facts=facts, show=preds)["atoms"])
        wrong = [x for x in atoms if x not in a] + [x for x in absent if x in a]
        return not wrong, "as stated" if not wrong else f"wrong: {wrong}"
    return chk

# The negative cases of MS1 and MS2 are near misses: each fails one condition,
# and supplying the missing claim makes it pass (so a broken fixture shows).
scen("MS1b", MR, "Mortal, on the claims: the near misses", ["moral_cases"],
     [shown(["moral_cases"], ("actus_humanus/2", "full_knowledge/2", "deliberate_consent/2", "grave_by_matter/1", "sinful_kind/1"),
            "actus_humanus(m2,act_m2)", "full_knowledge(m2,act_m2)", "grave_by_matter(k_grave)", "sinful_kind(k_grave)",
            "actus_humanus(m4,act_m4)", "full_knowledge(m4,act_m4)", "deliberate_consent(m4,act_m4)", "grave_by_matter(k_unbound)",
            absent=("deliberate_consent(m2,act_m2)", "sinful_kind(k_unbound)")),
      shown(["moral_cases"], ("info/1",), "info(mortal_on_the_claims(m2,act_m2))", facts="interior(m2,act_m2,deliberate_consent).")],
     "m2 lacks only consent, and with it claimed is mortal on the claims; m4 lacks only a law that binds")
scen("MS2d", MR, "Double effect: the near misses", ["moral_cases"],
     [shown(["moral_cases"], ("evil_as_means/1", "evil_unintended/2", "proportionate/2"),
            "evil_as_means(act_d2)", "evil_unintended(d2,act_d2)", "proportionate(d2,act_d2)", "evil_unintended(d4,act_d4)",
            absent=("proportionate(d4,act_d4)",)),
      shown(["moral_cases"], ("info/1",), "info(double_effect(d4,act_d4))", facts="interior(d4,act_d4,proportionate_reason).")],
     "d2 fails only as the evil is the means; d4 lacks only the claim of proportion, and with it claimed holds")
scen("MS2c", MR, "A good end and a proportion make any act licit", ["moral_cases", "cand_proportionalism"],
     [has("evil_object_made_licit(d3,act_d3)")], "refused (VS 79-81; CCC 1756)")
scen("MS3", MR, "c. 916: the internal forum", ["c915_case"],
     [only_with("not_to_receive(r916,c_r916)", "assumed_fact(interior(r916,c_r916,conscious_of_grave_sin))"),
      every_branch_with("assumed_fact(false(interior(r916,c_r916,conscious_of_grave_sin)))", "admitted_by_right(r916,c_r916)")],
     "never computed: a branch on the claim, in every case", mode=B)

def c915_first_clause(r):
    six = ("fellay", "galarreta", "schreiber", "goldade", "poinsinet", "hanappier")
    bad = []
    for b in r["branches"]:
        for p in six + ("sspx_priest_x",):
            barred = any(f"not_to_be_admitted({p},c915_censure)" in f for f in b["facts"])
            declared = any(f.startswith(f"info(declared({p},") for f in b["facts"])
            if barred != declared or (p == "sspx_priest_x" and barred):
                bad.append(p)
    seen = any("c915_censure" in f for b in r["branches"] for f in b["facts"])
    return seen and not bad, "barred exactly where declared" if seen and not bad else f"mismatch: {sorted(set(bad))}"

scen("MS4", MR, "c. 915, first clause, the recourse decided", SX + ["recourse_decided_2026"],
     [c915_first_clause], "those the 2026 decree names, where the declaration stands; no one else", mode=B)
scen("MS4b", MR, "c. 915, first clause, the recourse pending", SX,
     [info_none("c915_censure")], "the declaration suspended (c. 1353): no one barred by it; nothing incurred and undeclared counts", mode=B)
scen("MS5", MR, "c. 915, second clause", ["c915_case"],
     [every_branch_with("assumed_fact(excluded_reading(c915,subjective))", "not_to_be_admitted(q915,c915_sin)"),
      every_branch_with("assumed_fact(excluded_reading(c915,subjective))", "declined_by_strict", present=False),
      every_branch_with("assumed_fact(false(excluded_reading(c915,subjective)))", "declined_by_strict_interpretation(c915,objective,s915)"),
      every_branch_with("assumed_fact(false(interior(q915,s915,subjectively_grave)))", "not_to_be_admitted(q915", present=False),
      every_branch_with("assumed_fact(interior(q915,s915,subjectively_grave))", "not_to_be_admitted(q915,c915_sin)"),
      clean_branches],
     "objectively, outward facts suffice; where the subjective reading is admissible c. 18 takes it, and the "
     "clause reaches only on an interior claim, as c. 916 does; the pair raises nothing", mode=B)

scen("MS5b", MR, "c. 915 had the declaration been confirmed and promulgated", ["c915_case", "pclt_confirmed"],
     [info_none("declined_by_strict"), info_all("not_to_be_admitted(q915,c915_sin)"),
      assumed_none("subjectively_grave")],
     "then the objective reading would bind as authentic (c. 16 §2; Pastor bonus art. 155): no doubt of law", mode=B)
scen("GR1", MR, "The state of grace read off outward signs", ["grace_cases", "cand_grace_from_sacraments"],
     [has("grace_known_by_outward_signs(pj)")], "refused (Trent, DH 1534, 1563-1566)")
scen("GR1b", MR, "The state of grace as a claim", ["grace_cases", "grace_claimed"],
     [branches_n(2), clean_branches, only_with("in_grace_on_the_claim(pj)", "assumed_fact(interior(pj,state,in_grace))")],
     "computed both ways; nothing derived", mode=B)
def on_every_runtime(parts, *subs):
    """each violation in `subs` on the default runtime and on every runtime in GRACE_RUNTIMES"""
    def chk(r):
        miss = [rt for rt in GRACE_RUNTIMES if not has(*subs)(solve(list(parts) + [rt], "one"))[0]]
        return not miss, "on every runtime" if not miss else f"not on {', '.join(miss)}"
    return chk

scen("GR2", MR, "Pelagius: a salutary act without grace", ["cand_pelagian"],
     [has("salutary_without_grace(pp,good_work)", "salutary_without_grace(pp,assent_pp)"),
      on_every_runtime(["cand_pelagian"], "salutary_without_grace(pp,good_work)", "salutary_without_grace(pp,assent_pp)")],
     "refused on every runtime but bare (Carthage; Trent can. 1)")
scen("GR2b", MR, "The beginning of faith without grace", ["cand_semipelagian"],
     [has("salutary_without_grace(ps,first_assent)"), on_every_runtime(["cand_semipelagian"], "salutary_without_grace(ps,first_assent)")],
     "refused on every runtime but bare (Orange II, can. 5, DH 375)")
scen("GR2c", MR, "Pelagius on bare", ["cand_pelagian", "rt_bare"],
     [none_of("salutary_without_grace"), has("will_merely_passive(pp,assent_pp)")],
     "no creature acts: nothing to move; the Pelagian's justification is GR3's finding")
scen("GR3", MR, "A justification on bare", ["grace_cases", "rt_bare"],
     [has("will_merely_passive(pj,consent_j)")], "the will \"like something inanimate\": against Trent can. 4 (DH 1554)")
scen("GR3b", MR, "Bare with the justified will's operation alone", ["grace_cases", "rt_bare", "justified_will_operates"],
     [clean], "boots: a second created operation the deposit defines")
scen("GR4", MR, "Jansen: no interior grace is ever resisted", ["jansenism"],
     [cls("q(grace_always_efficacious)=yes", "excluded"), cls("q(grace_always_efficacious)=no", "settled"),
      info_any("against_tier1(jansen_augustinus,q(grace_always_efficacious))"), clean_branches,
      lambda r: (all(cls("q(grace_always_efficacious)=yes", "excluded")(solve(["jansenism", rt], "branches"))[0]
                     for rt in GRACE_RUNTIMES), "excluded on every runtime")],
     "refused at tier 1 (Cum occasione, prop. 2); the library keeps a grace that is resisted", mode=B)
scen("GR4b", MR, "A library with every interior grace efficacious", ["jansenism", "cand_jansenist"],
     [any_branch_violation("resisted_grace_unrepresented"),
      lambda r: (all(any(f.startswith("violation(resisted_grace_unrepresented") for b in solve(["jansenism", "cand_jansenist", rt], "branches")["branches"]
                         for f in b["facts"]) for rt in GRACE_RUNTIMES), "on every runtime")],
     "refused: the definition requires a grace that is resisted", mode=B)
scen("GR5", MR, "Trent's \"can dissent\" in the composite sense, Thomist", ["grace_cases", "cand_dissent_composite", "rt_thomist"],
     [has("dissent_impossible(pj,consent_j)")], "turns the Thomist runtime red: the charge Paul V forbade (1607)")
scen("GR5b", MR, "The same, Suarezian", ["grace_cases", "cand_dissent_composite", "rt_suarezian"],
     [clean], "middle knowledge: nothing to accuse")
scen("GR5c", MR, "The divided sense, Thomist and Suarezian", ["grace_cases", "rt_thomist"],
     [clean, lambda r: (not solve(["grace_cases", "rt_suarezian"], "one")["violations"], "Suarezian clean")],
     "the will keeps its power to dissent under any motion: both boot")
scen("GR6", MR, "Uncreated grace and Trent's formal cause, Palamite", ["grace_cases", "trent_formal_cause", "rt_palamite"],
     [only_with("formal_cause_uncreated(pj,consent_j)", "read_as(trent_vi_ch7,against_every_uncreated_cause)"),
      every_branch_with("read_as(trent_vi_ch7,against_osiander)", "violation(", present=False)],
     "boots on the reading against Osiander only; red on the reading against every uncreated formal cause", mode=B)
scen("GR6b", MR, "The same on the four Latin runtimes", ["grace_cases", "trent_formal_cause"],
     [lambda r: (all(not any(f.startswith("violation(") for b in solve(["grace_cases", "trent_formal_cause"] + rt, "branches")["branches"]
                             for f in b["facts"]) for rt in ([], ["rt_thomist"], ["rt_scotist"], ["rt_suarezian"])),
                 "clean on both readings")],
     "created grace: both readings boot", mode=B)
scen("GR6c", MR, "Osiander", ["grace_cases", "cand_osiander"],
     [has("formal_cause_the_divine_essence(pj,consent_j)")], "refused on every reading (DH 1529)")

# ---------- Christ, presence, the sacraments (TTC-CHRIST) --------------------
CX = "christ"
ALL_RUNTIMES = ("rt_thomist", "rt_scotist", "rt_suarezian", "rt_palamite")

def branch_fact(qv, sub, present=True):
    """in every branch holding qv, a fact containing sub is (or is not) present"""
    def chk(r):
        bs = [b for b in r["branches"] if qv in b["values"]]
        hits = [any(sub in f for f in b["facts"]) for b in bs]
        ok = bool(bs) and (all(hits) if present else not any(hits))
        return ok, f"{qv}: {sub} {'in all' if all(hits) else 'in none' if not any(hits) else 'in some'} of {len(bs)}"
    return chk

def all_branches_violation(sub):
    def chk(r):
        hits = [any(f.startswith("violation(") and sub in f for f in b["facts"]) for b in r["branches"]]
        return bool(hits) and all(hits), f"{sub}: in {sum(hits)} of {len(hits)} branches"
    return chk

def runtimes_clean(parts, runtimes, *subs):
    """no violation containing any of subs (or none at all, if subs is empty) on each runtime"""
    def chk(_r):
        bad = []
        for rt in runtimes:
            v = solve(list(parts) + [rt], "one")["violations"]
            if any(not subs or any(s in x for s in subs) for x in v):
                bad.append(rt)
        return not bad, "clean on " + ", ".join(runtimes) if not bad else f"red on {', '.join(bad)}"
    return chk

def weight_in(qv, tier, n, extra=None):
    """every branch holding qv (and the read_as or value in extra, if given) has weight(tier, n)"""
    def chk(r):
        bs = [b for b in r["branches"] if qv in b["values"] and (extra is None or extra in b["values"] + b["assume"])]
        ok = bool(bs) and all(b["w"].get(tier) == n for b in bs)
        return ok, f"{qv}{' ' + extra if extra else ''}: weight({tier},{n}) {'in all' if ok else 'not in all'} of {len(bs)}"
    return chk

def no_main_with(*items):
    """no main branch carries all the given values or assumptions"""
    def chk(r):
        hit = [b for b in r["branches"] if b["status"] == "main" and all(i in b["values"] + b["assume"] for i in items)]
        return not hit, f"{' & '.join(items)}: {'no main branch' if not hit else 'a main branch'}"
    return chk

def models_split(parts, qv, atom):
    """over every model, atom holds exactly where the question holds the value"""
    q, v = qv.split("=", 1)
    def chk(_r):
        ms = solve(parts, "all", show=("holds/2", atom.split("(")[0] + "/1"))["all_models"]
        bad = [m for m in ms if (f"holds({q},{v})" in m) != (atom in m)]
        return bool(ms) and not bad, f"{atom} exactly where {qv}" if not bad else f"{atom}: {len(bad)} model(s) disagree"
    return chk

def reading_in_main(src, reading):
    def chk(r):
        ok = any(f"read_as({src},{reading})" in b["assume"] for b in r["branches"] if b["status"] == "main")
        return ok, f"{reading}: {'a main branch' if ok else 'no main branch'}"
    return chk

scen("CH1", CX, "A human act of the incarnate", CREED + ["christ_acts"],
     [clean, info_any("human_act_of_a_divine_person(son,healing)", "instrument_of_the_divinity(healing,healing_power)"),
      shown(CREED + ["christ_acts"], ("actus_humanus/2", "creature/1"), "actus_humanus(son,healing)",
            absent=("creature(son)", "actus_humanus(son,healing_power)"))],
     "the person acts by the nature (III q. 19 a. 1): an actus humanus of a divine person, who is no creature", mode=B)
scen("CH1b", CX, "The same on bare", CREED + ["christ_acts", "rt_bare"],
     [has("one_operation(son)"), shown(CREED + ["christ_acts", "rt_bare"], ("actus_humanus/2",), absent=("actus_humanus(son,healing)",))],
     "no human operation, so no human act (CR6)")
scen("CH1c", CX, "One act of both natures (Severus)", CREED + ["christ_acts", "cand_one_theandric_operation"],
     [has("operations_confused(son,walking_on_water)")], "refused: \"without confusion\" (DH 557)")
scen("CH1d", CX, "A human act of the Father", CREED + ["cand_father_acts_humanly"],
     [has("nature_not_had(father,hum)")], "refused as his birth of Mary is (CR3b)")
scen("CH2", CX, "Claims that compose a sin of Christ", CREED + ["cand_sin_of_christ"],
     [has("sin_claimed_of_the_sinless(son,act_s)")], "refused (DH 301): the deposit states his interior, nothing is computed")
scen("CH2b", CX, "The same claims of Mary, with Trent's can. 23", CREED + ["cand_sin_of_mary", "mary_actual_sin"],
     [branch_violation("q(mary_without_actual_sin)=yes", "sin_claimed_of_the_sinless(mary,act_v)"),
      branch_violation("q(mary_without_actual_sin)=no", "sin_claimed_of_the_sinless", present=False),
      cls("q(mary_without_actual_sin)=yes", "settled"), cls("q(mary_without_actual_sin)=no", "shadow")],
     "refused in the main branch (\"as the Church holds\", DH 1573, typed tier 3); the shadow is clean", mode=B)
scen("CH2c", CX, "The same claims of Mary, no source loaded", CREED + ["cand_sin_of_mary"],
     [none_of("sin_claimed_of_the_sinless")], "nothing refuses what no source states")
scen("CH3", CX, "Why the Word became flesh; Christ's esse", ["incarnation_schools"],
     [branches_n(4), cls("q(motive_of_incarnation)=for_sin", "open"), cls("q(motive_of_incarnation)=absolute_primacy", "open"),
      cls("q(esse_of_christ)=one_esse", "open"), cls("q(esse_of_christ)=secondary_esse", "open"),
      prefers("q(motive_of_incarnation)", "for_sin"), prefers("q(esse_of_christ)", "tie"),
      weight_in("q(motive_of_incarnation)=for_sin", 5, 1)],
     "every value main: no source of tier 1 to 3 decides either; Thomas, a Doctor, weighs above Scotus (a preference)", mode=B)
scen("CH3b", CX, "The library on every runtime", CREED + ["christ_acts"],
     [runtimes_clean(CREED + ["christ_acts"], ALL_RUNTIMES), lambda r: (bool(solve(CREED + ["christ_acts", "rt_bare"], "one")["violations"]), "bare red")],
     "boots on every runtime but bare")

PX = CREED + ["eucharist_case"]
scen("PM1", CX, "Presence typed by mode: the deposit and a Mass", PX,
     [clean, info_any("present(son,host_a,sacramental)", "present(son,host_b,sacramental)", "present(son,host_a_part,sacramental)",
                      "sacrament(mass_2,eucharist,invalid(minister))", "sacrament(mass_3,eucharist,invalid(matter))"),
      info_none("present(son,host_c", "present(son,host_d")],
     "at the Father's right hand by the natural mode, under the species sacramentally, whole under the part (DH 1636, 1653)", mode=B)
scen("PM1b", CX, "A presence of no known mode", CREED + ["cand_mode_unknown"],
     [has("untyped_presence(son,place_d,located)")], "presence is typed: a mode the kernel or a library declares")
scen("PM2", CX, "One untyped presence, and a body in one place", PX + ["cand_untyped_presence"],
     [has("in_two_places(son,host_b,right_hand_of_the_father)")], "the deposit turns red: Trent's \"no repugnance\" (DH 1636) types it")
scen("PM2b", CX, "Typed, on every runtime", PX,
     [runtimes_clean(PX, ALL_RUNTIMES + ("rt_bare",), "in_two_places", "two_circumscribed", "immensity", "untyped_presence")],
     "no rule compares presences of different modes")
scen("PM3", CX, "One body circumscribed in two places, Thomist", CREED + ["cand_bilocation", "rt_thomist"],
     [has("two_circumscribed_places(saint_b,place_a,place_b)")], "impossible even to God (Quodl. III q. 1 a. 2)")
scen("PM3b", CX, "The same on the other runtimes", CREED + ["cand_bilocation"],
     [clean, runtimes_clean(CREED + ["cand_bilocation"], ("rt_scotist", "rt_suarezian", "rt_palamite"))],
     "possible by divine power (Scotus, Suarez): the schools', not the kernel's")
scen("PM4", CX, "Berengar's profession of 1059, read two ways", ["berengar"],
     [cls("q(christ_divided_with_species)=yes", "excluded"),
      reading_in_main("berengar_1059", "of_the_body_in_its_species"), reading_in_main("berengar_1059", "of_the_sacramental_species"),
      info_any("against_tier1(berengar_1059,q(christ_divided_with_species))")],
     "after Trent (DH 1653) the value is excluded; the literal reading stands, recorded against tier 1", mode=B)
scen("PM4b", CX, "The same as of 1550", ["berengar", "asof_1550"],
     [cls("q(christ_divided_with_species)=yes", "open"), cls("q(christ_divided_with_species)=no", "open"),
      reading_in_main("berengar_1059", "of_the_body_in_its_species"), reading_in_main("berengar_1059", "of_the_sacramental_species"),
      no_main_with("q(christ_divided_with_species)=yes", "read_as(berengar_1059,of_the_sacramental_species)"),
      no_main_with("q(christ_divided_with_species)=no", "read_as(berengar_1059,of_the_body_in_its_species)"),
      weight_in("q(christ_divided_with_species)=yes", 5, 2, "read_as(berengar_1059,of_the_body_in_its_species)")],
     "before Trent both readings stand; Thomas (not yet a Doctor in 1550) weighs against the literal one", mode=B)
scen("PM5", CX, "God in heaven as in a place", ["cand_god_located"],
     [has("immensity_denied(deus,heaven,definitive)")], "refused (DH 800, 3001)")
scen("PM5b", CX, "The Father under the species, and in heaven as a spirit is", ["trinity", "cand_father_in_the_host"],
     [has("nature_not_had(father,hum)", "immensity_denied(father,heaven,definitive)")],
     "a bodily mode is said by the human nature; a bounded spirit's mode denies immensity")
scen("PM5c", CX, "An angel circumscribed", ["cand_angel_circumscribed"],
     [has("nature_not_had(angel_g,hum)")], "an angel is in a place definitively, not measured by it (I q. 52 a. 2)")
scen("PM6", CX, "Christ present only in the use", PX + ["cand_presence_in_use"],
     [has("presence_only_in_use(host_b)")], "refused (DH 1654)")
scen("PM6b", CX, "Present only as in a sign", PX + ["cand_presence_sign"],
     [has("presence_only_as_sign(host_a)")], "refused (DH 1651)")

scen("SM2", CX, "Conditions typed by their law", ["sacrament_conditions", "sacrament_dispensations"],
     [all_branches_violation("dispensing_divine_law(dsp_water,cond(baptism,matter))"),
      all_branches_violation("dispensing_divine_law(dsp_ord,cond(penance,minister))"),
      none_of("dispensing_divine_law(dsp_form"),
      info_all("dispensed(cond(matrimony,canonical_form),m_mixed)", "marriage(m_mixed,form_dispensed)",
               "sacrament(bap_w,baptism,invalid(matter))", "absolution(abs_lay,invalid)"),
      info_none("sacrament(bap_w,baptism,invalid(intention))"),
      branch_violation("q(substance(matrimony,consent))=yes", "dispensing_divine_law(dsp_consent,cond(matrimony,consent))"),
      branch_fact("q(substance(matrimony,consent))=no", "dispensed(cond(matrimony,consent),m_vit)"),
      cls("q(substance(matrimony,consent))=no", "shadow"),
      models_split(["sacrament_conditions", "sacrament_dispensations"], "q(substance(matrimony,consent))=no", "bond(m_vit)"),
      shown(["sacrament_conditions", "sacrament_dispensations"], ("bond/1",), "bond(m_mixed)")],
     "the form dispensed (c. 1127 §2); the water and the power of orders not (DH 1615, 1710); consent not, on a tier-3 ground "
     "(CCC 1626), whose shadow could dispense it", mode=B)
scen("SM2b", CX, "The same with the substance unclassified", ["sacrament_dispensations"],
     [none_of("dispensing_divine_law"), info_none("dispensed(")],
     "without the theological side no condition is typed: nothing dispensed, nothing refused", mode=B)
scen("SM2c", CX, "The Code cited to settle the substance", ["sacrament_conditions", "sacrament_dispensations", "cand_law_types_the_substance"],
     [has("governance_read_as_teaching(c1108_text,q(substance(matrimony,canonical_form)))")],
     "law never answers a doctrinal question (rule 1)", mode=B)
scen("SM3b", CX, "c. 1321 §4: the presumption rebutted", ["act_rebutted"],
     [info_all("delict(x25,n1379,a_reb)"), info_none("presumed_incurred(x25")],
     "the same shape: an outward fact rebuts the presumption", mode=B)
scen("SM3", CX, "A contrary intention manifested", ["sacrament_cases"],
     [info_all("sacrament(bap_4,baptism,invalid(intention))", "sacrament(bap_1,baptism,valid)")],
     "presumed from the rite rightly used, rebutted only by an outward sign (Apostolicae curae 33)", mode=B)
scen("SM4", CX, "Validity resting on the minister's grace (Donatism)", ["sacrament_cases", "cand_donatist"],
     [all_branches_violation("validity_from_the_ministers_holiness(baptism,in_grace)"), branches_n(16),
      only_with("sacrament(bap_1,baptism,valid)", "assumed_fact(interior(layman_d,state,in_grace))")],
     "every validity a branch on the internal forum; refused (DH 1612)", mode=B)
scen("SM5", CX, "\"We baptize\"", ["we_baptize", "we_baptize_case"],
     [cls("q(valid_form(baptism,we_baptize))=no", "settled"), cls("q(valid_form(baptism,we_baptize))=yes", "shadow"),
      branch_fact("q(valid_form(baptism,we_baptize))=no", "to_be_conferred(child_x,baptism,absolutely)"),
      branch_fact("q(valid_form(baptism,we_baptize))=yes", "sacrament(bap_we,baptism,valid)"),
      info_all("to_be_conferred(child_y,baptism,conditionally)"), branches_n(4),
      only_with("sacrament(bap_doubt,baptism,invalid(form))", "assumed_fact(form_used(bap_doubt,we_baptize))"),
      every_branch_with("assumed_fact(false(form_used(bap_doubt,we_baptize)))", "sacrament(bap_doubt,baptism,valid)"),
      info_none("invalid(intention)")],
     "invalid, baptized absolutely; the valid branch a live shadow; where the words are in doubt, conditionally (c. 845 §2)", mode=B)
scen("SM5b", CX, "Was true water used?", ["doubt_of_matter"],
     [branches_n(2), info_all("to_be_conferred(child_z,baptism,conditionally)"),
      only_with("sacrament(bap_dw,baptism,invalid(matter))", "assumed_fact(matter_used(bap_dw,rose_water))"),
      every_branch_with("assumed_fact(false(matter_used(bap_dw,rose_water)))", "sacrament(bap_dw,baptism,valid)")],
     "a doubt of fact: conferred conditionally (c. 845 §2)", mode=B)
scen("SM6", CX, "The 1988 and 2026 consecrations", SX,
     [shown(SX, ("sacramental_character/3",), *[f"sacramental_character({p},orders(episcopate),{e})" for p, e in
             (("fellay", "e1988_fellay"), ("galarreta", "e1988_galarreta"), ("schreiber", "e2026_schreiber"),
              ("goldade", "e2026_goldade"), ("poinsinet", "e2026_poinsinet"), ("hanappier", "e2026_hanappier"))])],
     "valid on the presumption, with the character")
scen("SM6b", CX, "A baptism repeated; confirmation of the unbaptized", ["sacrament_cases"],
     [info_all("sacrament(bap_3,baptism,null_repetition)", "sacrament(conf_1,confirmation,invalid(subject))",
               "sacrament(abs_1,penance,invalid(minister))", "sacrament(conf_2,confirmation,valid)",
               "character_imprinted(adult_a,confirmation)", "sacrament(anoint_1,anointing,valid)",
               "sacrament(anoint_2,anointing,invalid(minister))", "sacrament(bap_4b,baptism,valid)"),
      info_none("to_be_conferred(adult_a", "to_be_conferred(adult_m")],
     "not repeated (DH 1609; c. 845 §1); the other sacraments need baptism (c. 842 §1)", mode=B)
scen("SM6c", CX, "Orders conferred twice; a defective form", ["orders_cases"],
     [shown(["orders_cases"], ("valid/1", "repeated/1", "sacramental_character/3", "unmet/2"),
            "valid(e_o1)", "sacramental_character(cand_o,orders(episcopate),e_o1)", "repeated(e_o2)", "unmet(e_o3,form)",
            absent=("valid(e_o2)", "valid(e_o3)"))],
     "the imposition of hands and the consecratory prayer (DH 3859-3860); a second ordination confers nothing")
scen("SM8", CX, "The fruit: the obstacle a claim", ["sacrament_cases"],
     [branches_n(2), info_all("sacrament(bap_2,baptism,valid)", "character_imprinted(adult_a,baptism)"),
      only_with("fruit_on_the_claims(adult_a,bap_2)", "assumed_fact(interior(adult_a,bap_2,no_obstacle))")],
     "valid and the character in both branches; grace only where no obstacle is claimed (DH 1606)", mode=B)
scen("SM8b", CX, "The fruit read off validity", ["sacrament_cases", "cand_fruit_from_validity"],
     [has("grace_known_by_outward_signs(adult_a)")], "refused, as TTC-MORAL GR1 is")
scen("SM9", CX, "An infant baptized", ["sacrament_cases"],
     [info_all("reborn_on_the_deposit(infant_i,bap_1)", "reborn_on_the_deposit(adult_h,bap_6)"),
      shown(["sacrament_cases"], ("in_grace/1",), absent=("in_grace(infant_i)",))],
     "reborn, if validly baptized (DH 1514): composed on the deposit, never a state of grace", mode=B)
scen("SM9b", CX, "The infant's rebirth entered as a state of grace", ["sacrament_cases", "cand_infant_state"],
     [has("grace_known_by_outward_signs(infant_i)")], "refused: infants included")
scen("SM10", CX, "Nullity and dissolution", ["marriage_cases"],
     [info_all("dissolved(m_nc,dis_nc)", "free_to_marry(sp_e)", "never_res_iudicata(m_doubt)", "info(bond(m_nc))",
               "dissolved(m_pauline,dis_pf)", "marriage(m_noform,invalid_form)"),
      only_with("info(no_bond(m_doubt))", "assumed_fact(interior(sp_e,m_doubt,fear(grave,extrinsic,unjust)))"),
      shown(["marriage_cases"], ("bond/1",), "bond(m_rc)", absent=("bond(m_noform)",)),
      only_with("info(bond(m_doubt))", "assumed_fact(false(interior(sp_e,m_doubt,fear(grave,extrinsic,unjust))))"),
      only_with("forum_holds_null_where_bond_stands(m_doubt)", "assumed_fact(false(interior(sp_e,m_doubt,fear(grave,extrinsic,unjust))))"),
      clean_branches],
     "the sentence settles the forum, never the fact (cc. 1643, 1682 §1); a non-consummated bond dissolved (c. 1142)", mode=B)
scen("SM10b", CX, "A ratified and consummated marriage dissolved", ["marriage_cases", "dissolve_ratum_consummatum"],
     [all_branches_violation("ratum_et_consummatum_dissolved(dis_rc,m_rc)")], "refused (c. 1141)", mode=B)
scen("SM10c", CX, "A declaration of nullity read as a divorce", ["marriage_cases", "cand_nullity_as_divorce"],
     [only_with("violation(ratum_et_consummatum_dissolved(ns_doubt,m_doubt))",
                "assumed_fact(false(interior(sp_e,m_doubt,fear(grave,extrinsic,unjust))))")],
     "refused where the marriage was valid; silent where it was null", mode=B)
SEAL = ["seal", "seal_case"]
scen("SM7", CX, "A confessor coerced under a civil law", SEAL,
     [cls("q(seal_of_divine_law)=yes", "settled"), cls("q(seal_of_divine_law)=no", "shadow"),
      branch_fact("q(seal_of_divine_law)=yes", "does_not_bind(civil_disclosure_law)"),
      branch_fact("q(seal_of_divine_law)=no", "does_not_bind(civil_disclosure_law)", present=False),
      info_all("delict(conf_k,n1386,disclosure_k)", "mitigated(conf_k,disclosure_k,fear)"),
      info_none("exempt(conf_k", "presumed_incurred(conf_k"), weight_in("q(seal_of_divine_law)=no", 4, 1),
      # changed with TTC-REPAIRS2 (not predicted): one model, so the reading of c. 1321 §4 is fixed to dolus
      shown(SEAL + DOLUS_PART, ("excommunicated_at/2",), "excommunicated_at(conf_j,20261010)",
            absent=("excommunicated_at(conf_k,20261010)",))],
     "the ground a classification at tier 3; not exempt (c. 1323 n. 4), mitigated (c. 1324 §1 n. 5), no latae sententiae (§3); the delict stands",
     mode=B)
scen("SM7b", CX, "The seal dispensed by the supreme authority", SEAL + ["seal_dispensed"],
     [branch_violation("q(seal_of_divine_law)=yes", "dispensing_divine_law(dsp_seal,seal)"),
      branch_fact("q(seal_of_divine_law)=no", "dispensed(seal,conf_k)")],
     "the shadow shows what the ground protects: there it could be dispensed", mode=B)
scen("SM7c", CX, "The penitent releases the confessor", SEAL + ["cand_penitent_releases"],
     [all_branches_violation("seal_lifted(disclosure_k,penitent_release)")], "\"for any reason\" (c. 983 §1)", mode=B)

# ---------- Verdicts and obligation (TTC-PRECEPT) ---------------------------
# may, must, must not: said of acts. "Direct" is a reading (q(direct_by)); what
# is chosen is a claim, computed both ways. Social teaching as the test set.
PC = "precept"
CAUSAL, CHOICE = "q(direct_by)=causal_order", "q(direct_by)=what_is_chosen"
TR = ["direct_reading", "life_sources", "trolley"]
AB = ["direct_reading", "life_sources", "craniotomy_sources", "abortion"]
EC = ["direct_reading", "life_sources", "craniotomy_sources", "ectopic"]
IV = ["ivf_sources", "life_sources", "ivf"]
DPV = ["deathpenalty", "dp_verdict"]

def chose(p, a, e, yes=True):
    x = f"interior({p},{a},chooses({e}))"
    return f"assumed_fact({x})" if yes else f"assumed_fact(false({x}))"

def in_branches(sub, status=None, values=(), assume=(), present=True):
    """in every branch with this status, these values and these assumptions, sub is (or is not) among the facts"""
    def chk(r):
        bs = [b for b in r["branches"] if (status is None or b["status"] == status)
              and all(v in b["values"] for v in values) and all(a in b["assume"] for a in assume)]
        hits = [any(sub in f for f in b["facts"]) for b in bs]
        ok = bool(bs) and (all(hits) if present else not any(hits))
        where = " & ".join([status or "every"] + list(values) + [a[len("assumed_fact("):-1] for a in assume])
        return ok, f"{where}: {sub} {'in all' if hits and all(hits) else 'in none' if not any(hits) else 'in some'} of {len(bs)}"
    return chk

scen("LW13", LW, "Whose choice, a right regulated, a decision's reach (GIRM 283; cc. 223 \u00a72, 1739, 16 \u00a73)", ["option_held"],
     [info_all("narrows_own_choice(l_mode,book_r)", "obliged(mass_m,l_mode)", "does_not_bind(l_post)",
               "does_not_bind(l_bare)", "does_not_bind(l_cele_reg)", "confirmed_on_recourse(l_conf,dec_r)",
               "regulates_right(l_conf,tongue_r)", "obliged(mass_c,l_conf)", "not_reached_by(l_reg,dec_r)",
               "not_reached_by(l_low,dec_r)"),
      info_none("does_not_bind(l_mode)", "does_not_bind(l_conf)", "regulates_right(l_cele_reg",
                "confirmed_on_recourse(l_low", "narrows_own_choice(l_post"),
      in_branches("does_not_bind(l_reg)", assume=("assumed_fact(false(regulates_exercise(l_reg,tongue_r)))",)),
      in_branches("does_not_bind(l_reg)", assume=("assumed_fact(regulates_exercise(l_reg,tongue_r))",), present=False),
      in_branches("regulates_right(l_reg,tongue_r)", assume=("assumed_fact(regulates_exercise(l_reg,tongue_r))",)),
      in_branches("does_not_bind(l_low)", assume=("assumed_fact(false(regulates_exercise(l_low,tongue_r)))",)),
      in_branches("assumed_fact(false(regulates_exercise(l_conf", present=False),
      shown(["option_held"], ("frontier/2",), "frontier(canon,narrowing_without_ground(l_post_old))",
            absent=("frontier(canon,narrowing_without_ground(l_own_old))",))],
     "the bishop's own choice is his to narrow; another's is not; a right of the faithful regulated for the common good "
     "binds where the claim holds, never where it is absent or the choice is a minister's; a higher authority's "
     "confirmation on recourse settles it for that law alone; a lower one's settles nothing", mode=B)

def shadow_by_oum(qv):
    """qv is in no main branch; a counterfactual shadow only where a claim of the OUM holds, a live one where none does"""
    def chk(r):
        bs = [b for b in r["branches"] if qv in b["values"]]
        oum = lambda b: any(a.startswith("oum_holds(") for a in b["assume"])
        main = [b for b in bs if b["status"] == "main"]
        cf = [b for b in bs if b["status"] == "counterfactual_shadow"]
        bare = [b for b in bs if not oum(b)]
        ok = not main and bool(cf) and all(oum(b) for b in cf) and bool(bare) and all(b["status"] == "live_shadow" for b in bare)
        return ok, (f"{qv}: counterfactual on the claim ({len(cf)}), live without it ({len(bare)})" if ok
                    else f"{qv}: main {len(main)}, counterfactual {len(cf)}, without the claim {[b['status'] for b in bare][:3]}")
    return chk

def cleaved_by_each(qv, *srcs):
    """every branch holding qv is cleaved by each of these sources"""
    def chk(r):
        bs = [b for b in r["branches"] if qv in b["values"]]
        miss = sorted({x for b in bs for x in srcs if x not in b["cleaved"]})
        ok = bool(bs) and not miss
        return ok, f"{qv}: cleaved by {', '.join(srcs)}" if ok else f"{qv}: not cleaved by {', '.join(miss) or '(no branch)'}"
    return chk

def on_each_claim(qv, *srcs):
    """for each source, a counterfactual shadow holding qv rests on its claim of the OUM alone"""
    def chk(r):
        oums = lambda b: [a for a in b["assume"] if a.startswith("oum_holds(")]
        miss = [s for s in srcs if not any(b["status"] == "counterfactual_shadow" and qv in b["values"]
                                           and oums(b) == [f"oum_holds({s})"] for b in r["branches"])]
        return not miss, "each claim alone suffices" if not miss else f"not alone: {miss}"
    return chk

def verdicts_on_acts(parts):
    """every verdict is said of an act (act_of/2's second place), none of a person"""
    def chk(_r):
        said = {f[len("info(verdict("):].split(",")[0] for b in solve(parts, "branches")["branches"]
                for f in b["facts"] if f.startswith("info(verdict(")}
        ao = [a[len("act_of("):-1].split(",") for a in solve(parts, "one", show=("act_of/2",))["atoms"] if a.startswith("act_of(")]
        acts, persons = {a for _, a in ao}, {p for p, _ in ao}
        ok = bool(said) and said <= acts and not said & persons
        return ok, f"{len(said)} acts with verdicts, no person" if ok else f"not acts: {sorted(said - acts)}"
    return chk

scen("VD1", PC, "Three verdicts", TR,
     [in_branches("verdict(lever,may,double_effect)"), in_branches("verdict(lever_c,", present=False),
      in_branches("verdict(harvest,must_not,by_object(direct(killing_of_innocent)))", "main"),
      shown(TR, ("info/1",), "info(verdict(lever_c,may,double_effect))", facts="interior(bystander_c,lever_c,proportionate_reason).")],
     "the lever \"may\" on the claims; the transplant \"must not\" with nothing claimed; without the claim of proportion, "
     "silence, and with it, \"may\"", mode=B)
scen("VD1b", PC, "The moral cases gain \"must not\"", ["moral_cases"],
     [shown(["moral_cases"], ("info/1",), "info(verdict(act_m1,must_not,by_object(k_grave)))",
            "info(verdict(act_m2,must_not,by_object(k_grave)))", "info(verdict(act_d3,must_not,by_object(k_grave)))",
            "info(verdict(act_d1,may,double_effect))", "info(verdict(def1,may,double_effect))",
            absent=("info(verdict(act_d2,may,double_effect))", "info(verdict(act_d4,may,double_effect))",
                    "info(verdict(act_d2,must_not,by_object(k_treatment)))"))],
     "on the kind alone, consent claimed or not (m1, m2, d3); not shown licit (d2, d4) is not forbidden")
scen("VD2", PC, "Acts, not persons", TR + ["trolley_duty"],
     [verdicts_on_acts(TR + ["trolley_duty"]), verdicts_on_acts(["life_sources", "abortion", "ivf_sources", "ivf"])],
     "no verdict names a person", mode=B)
scen("OB1", PC, "Must, with its occasion", TR + ["trolley_duty"],
     [in_branches("obligation(guard_g,defend(charges))"), in_branches("obligation(bystander_b", present=False),
      in_branches("verdict(lever,may,double_effect)")],
     "the guard, with the occasion, \"must\" (CCC 2265); the bystander \"may\"", mode=B)
scen("OB2", PC, "No duty to do evil", TR + ["cand_must_push"],
     [in_branches("violation(obliged_to_evil(greater_number_rule,direct(killing_of_innocent)))", "main"),
      in_branches("obligation(agent_p,direct(killing_of_innocent))", "main"),
      in_branches("verdict(push,must_not,by_object(direct(killing_of_innocent)))", "main", [CAUSAL])],
     "refused in every main branch; the push stays \"must not\"", mode=B)
scen("DI1", PC, "\"Direct\": a reading", ["direct_reading"],
     [cls(CAUSAL, "open"), cls(CHOICE, "open"), weight_in(CAUSAL, 5, 2), weight_in(CHOICE, 5, 1)],
     "both main: no source of tier 1 to 3 decides; tier-5 weight two to one, as entered", mode=B)
scen("DI2", PC, "The trolley, composed", TR,
     [in_branches(f"verdict({a},must_not,by_object(direct(killing_of_innocent)))", "main", [CAUSAL]) for a in ("push", "loop")] +
     [in_branches(f"verdict({a},must_not,by_object(direct(killing_of_innocent)))", "main", [CHOICE], [chose(p, a, e)])
      for p, a, e in (("agent_p", "push", "death_of_man"), ("agent_l", "loop", "death_of_one_l"))] +
     [in_branches(f"verdict({a},may,double_effect)", "main", [CHOICE], [chose(p, a, e, False)])
      for p, a, e in (("agent_p", "push", "death_of_man"), ("agent_l", "loop", "death_of_one_l"))] +
     [in_branches("verdict(lever,may,double_effect)", "main"),
      in_branches("verdict(push,may,", None, [CHOICE, "q(direct_killing_of_innocent)=no"],
                  [chose("agent_p", "push", "death_of_man")], present=False)],
     "causal: the push and the loop \"must not\"; by choice, on the claim; the lever \"may\" on both. "
     "Where the direct killing is not evil by its object (a shadow), a death chosen as the means still fails double effect",
     mode=B)
scen("DI3", PC, "Direct abortion", ["life_sources", "abortion"],
     [in_branches("verdict(abort_1,must_not,by_object(direct(killing_of_innocent)))", "main"),
      shadow_by_oum("q(direct_killing_of_innocent)=no"), on_each_claim("q(direct_killing_of_innocent)=no", "ev57", "ev62"),
      cleaved_by_each("q(direct_killing_of_innocent)=no", "ccc2271", "ev57", "ev62", "pius_xii_1951")],
     "\"must not\" in every main branch (EV 62); the contrary a counterfactual shadow on EV 57's claim, live without it",
     mode=B)
scen("DI4", PC, "Craniotomy", AB,
     [in_branches("verdict(cranio,must_not,by_object(direct(killing_of_innocent)))", "main", [CAUSAL]),
      in_branches("verdict(cranio,must_not,by_object(craniotomy))", "main", [CHOICE], [chose("doctor_c", "cranio", "death_of_child", False)]),
      in_branches("verdict(cranio,must_not,by_object(direct(", "main", [CHOICE],
                  [chose("doctor_c", "cranio", "death_of_child", False)], present=False),
      in_branches("verdict(cranio,may,double_effect)", "live_shadow", [CHOICE, "q(craniotomy_illicit)=no"],
                  [chose("doctor_c", "cranio", "death_of_child", False)]),
      cls("q(craniotomy_illicit)=no", "shadow"), cleaved_by_each("q(craniotomy_illicit)=no", "ho_1884", "ho_1889")],
     "causal: direct; by choice, not chosen: the Holy Office still forbids it (1884, 1889), and only its live shadow permits",
     mode=B)
scen("DI5", PC, "Ectopic pregnancy", EC,
     [in_branches("verdict(tube_out,may,double_effect)"),
      in_branches("verdict(mtx,must_not,by_object(direct(killing_of_innocent)))", "main", [CAUSAL]),
      in_branches("verdict(mtx,may,double_effect)", "main", [CHOICE], [chose("doctor_m", "mtx", "death_of_embryo_m", False)]),
      in_branches("verdict(mtx,must_not,by_object(direct(killing_of_innocent)))", "main", [CHOICE],
                  [chose("doctor_m", "mtx", "death_of_embryo_m")]),
      in_branches("verdict(embryo_out,must_not,by_object(extraction_of_ectopic_fetus))", "main"),
      in_branches("verdict(embryo_out,must_not,by_object(direct(killing_of_innocent)))", "main", [CAUSAL]),
      cleaved_by_each("q(ectopic_extraction_illicit)=no", "ho_1902"),
      in_branches("verdict(embryo_out,may,double_effect)", "live_shadow", [CHOICE, "q(ectopic_extraction_illicit)=no"],
                  [chose("doctor_t", "embryo_out", "death_of_embryo_t", False)])],
     "salpingectomy \"may\" on both readings; methotrexate splits by reading; salpingostomy meets the Holy Office (1902) "
     "in every main branch", mode=B)
scen("DI6", PC, "IVF", IV,
     [in_branches("verdict(ivf_1,must_not,by_object(ivf))", "main"), cls("q(ivf_illicit)=no", "shadow"),
      in_branches("verdict(ivf_1,", "live_shadow", ["q(ivf_illicit)=no"], present=False),
      cleaved_by_each("q(ivf_illicit)=no", "dignitas_personae_2008", "donum_vitae_1987"),
      in_branches("verdict(discard_1,must_not,by_object(direct(killing_of_innocent)))", "main")],
     "\"must not\" in the main branch (Donum vitae II.B.5), a live shadow; the destruction of embryos direct", mode=B)
scen("SD1", PC, "The death penalty, 2019, on the CDF's reading", DPV + ["asof_2019", "ccc_circumstantial"],
     [in_branches("verdict(exec_1,must_not,by_circumstance(absolute_necessity))", "main"),
      in_branches("by_object(execution)", "main", present=False)],
     "\"must not\" in every main branch, by circumstance, not by kind", mode=B)
scen("SD1b", PC, "The death penalty, 2019, on the intrinsic reading", DPV + ["asof_2019", "ccc_intrinsic"],
     [in_branches("verdict(exec_1,must_not,", "main"),
      in_branches("verdict(exec_1,must_not,by_object(execution))", "main", ["q(dp_principle)=intrinsically_wrong"]),
      in_branches("by_circumstance", "main", ["q(dp_principle)=intrinsically_wrong"], present=False),
      in_branches("verdict(exec_1,must_not,by_circumstance(absolute_necessity))", "main", ["q(dp_principle)=permitted"])],
     "the ground the kind; the circumstance stays main beside it (CCC 2267 against EV 56 at tier 3)", mode=B)
scen("SD1c", PC, "The death penalty, 2017", DPV + ["asof_2017"],
     [in_branches("verdict(exec_1,may,on_the_judgment)", "main", ["q(necessity_today)=sometimes"]),
      in_branches("verdict(exec_1,must_not,by_circumstance(absolute_necessity))", "main", ["q(necessity_today)=none"]),
      cls("q(necessity_today)=sometimes", "open")],
     "\"may\" where necessity is claimed, on the branch where it can be; whether it can be is open", mode=B)
scen("SD2", PC, "Usury as one question", ["usury_one_question"],
     [all_branches_violation("governance_read_as_teaching(cic1917_c1543,q(interest_on_loans))"),
      cls("q(interest_on_loans)=forbidden", "open")],
     "refused: the canon would be law answering doctrine", mode=B)
scen("SD2b", PC, "Usury as two questions", ["usury_two_questions", "usury_case"],
     [clean_branches, cls("q(profit_from_loan_as_such)=yes", "settled"),
      cls("q(interest_by_extrinsic_title)=permitted", "settled"),
      in_branches("verdict(loan_u,must_not,by_object(profit_from_loan_as_such))", "main")],
     "both stand: profit from the loan as such \"must not\"; interest by an extrinsic title a permission of law", mode=B)
scen("SD3", PC, "Just war", ["just_war"],
     [lambda r: ([i for i in r["info"] if i.startswith("verdict(")] == ["verdict(force_1,may,on_the_judgment)"],
                 ", ".join(i for i in r["info"] if i.startswith("verdict(")) or "none"),
      shown(["just_war"], ("info/1",), "info(verdict(force_2,may,on_the_judgment))", facts="prudential(force_2,no_graver_evils)."),
      shown(["just_war"], ("info/1",), "info(verdict(force_1,must_not,by_circumstance(prospects_of_success)))",
            facts="denied(prospects_of_success).", absent=("info(verdict(force_1,may,on_the_judgment))",))],
     "\"may\" on the four claims; three, silence; a condition denied, \"must not\" by circumstance")
scen("SD4", PC, "A directive cited as a principle", ["cand_directive_as_principle"],
     [all_branches_violation("directive_as_principle(ev56_rarity,execution)"), cls("q(execution_evil_by_object)=yes", "settled")],
     "refused (CCC 2423), though the directive, so cited, would settle the kind", mode=B)

# ---------- Faith and communion (TTC-COMMUNION) ------------------------------
# Rule 14 first: tiers are computed, never taken on anyone's word. Then the
# notes read off the graph, the censures of professions, and the canons.
CO = "communion"
FIL = ["filioque", "assent", "professions_filioque"]
ANG = ["ecumenism", "lattice", "assent", "professions_anglican"]

def warrant_audit(_r):
    """every part holding a source at tier 1 or 2 runs with no tier_without_warrant (candidates aside)"""
    parts = set()
    for f in sorted(E.LP_DIR.glob("*.lp")):
        part = None
        for line in f.read_text().split("\n"):
            m = re.match(r"\s*#program\s+(\w+)", line)
            if m:
                part = m.group(1)
                continue
            code = re.sub(r"%.*", "", line)
            if part and (re.search(r"\bsource\(\w+,[12],", code) or "oum_claim(" in code):
                parts.add(part)
    parts = sorted(p for p in parts if not p.startswith("cand_") and p != "atf_as_tier1")
    bad = [(p, v) for p in parts for v in solve([p], "one")["violations"]
           if v.startswith(("tier_without_warrant", "claim_without_claimant"))]
    return bool(parts) and not bad, f"{len(parts)} parts warranted" if not bad else f"unwarranted: {bad}"

def all_models_with(parts, preds, present=(), absent=(), some=()):
    """over every model: each atom in present holds, none in absent; each in some holds in at least one"""
    def chk(_r):
        ms = solve(parts, "all", show=preds)["all_models"]
        bad = ([a for a in present if not all(a in m for m in ms)] + [a for a in absent if any(a in m for m in ms)]
               + [a for a in some if not any(a in m for m in ms)])
        return bool(ms) and not bad, f"{len(ms)} models: as stated" if not bad else f"wrong: {bad}"
    return chk

def best_rest_on_no_claim(r):
    """the preferred main branches rest on no claim whose conditions are unshown (c. 749 §3)"""
    mains = [b for b in r["branches"] if b["status"] == "main"]
    best = min(pref_key(b) for b in mains)
    top = [b for b in mains if pref_key(b) == best]
    ok = all(b["unshown"] == 0 for b in top) and any(b["unshown"] > 0 for b in mains)
    return ok, f"{len(top)} preferred, none on an unshown claim; {sum(b['unshown'] > 0 for b in mains)} main on one" if ok else "a preferred branch rests on an unshown claim"

GRADE1 = ("graded(ev57,1)", "graded(ev62,1)")

def by_grade(r):
    """NT4: de fide where a claim holds at grade 1, definitive where one holds at 2 and none at 1, authentic where none"""
    bad = []
    for b in r["branches"]:
        if b["status"] != "main":
            continue
        g1 = any(a in b["assume"] for a in GRADE1)
        g2 = any(a.startswith("oum_holds(ev") for a in b["assume"]) and not g1
        want = "de_fide" if g1 else "definitive" if g2 else "authentic"
        if f"info(note(q(direct_killing_of_innocent),yes,{want}))" not in b["facts"]:
            bad.append(want)
    excl = [b for b in r["branches"] if "q(direct_killing_of_innocent)=no" in b["values"]
            and any(a in b["assume"] for a in GRADE1)]
    return not bad and not excl, "each main branch noted by its grade; no contrary under grade 1" if not bad and not excl else f"wrong: {bad[:3]} {len(excl)}"

scen("TC1", CO, "The audit: a tier needs a warrant", ["tier2", "assent"],
     [warrant_audit, info_all("owed(lg25,religious_submission)"), info_none("owed(lg25,divine_and_catholic_faith)"),
      lambda r: (all("violation(tier_without_warrant(lg25,1))" in b["facts"]
                     for b in solve(["tier2", "cand_lg25_tier1"], "branches")["branches"]), "LG 25 at tier 1: refused"),
      lambda r: ("tier_without_warrant(ev57_def,1)" in solve(["life_sources", "cand_ev57_ex_cathedra"], "one")["violations"],
                 "EV 57 entered ex cathedra, \"defines\" not shown: refused"),
      lambda r: ("claim_without_claimant(anon_doc)" in solve(["cand_claim_without_claimant"], "one")["violations"],
                 "a claim with no claimant: refused"),
      lambda r: (not any(v.startswith("tier_without_warrant") for v in solve(["life_sources", "cand_ev57_ex_cathedra"], "one",
                                                                             facts="condition_shown(ev57_def,defines).")["violations"]),
                 "with \"defines\" shown too, warranted"),
      shown(["tier2"], ("frontier/2",), absent=("frontier(theology,teaching_without_character(lg25))",))],
     "LG 25 defines nothing (1964): tier 3, owed religious submission; every other tier-1 source has its form", mode=B)
scen("TC2", CO, "The consensus as its own source", ["life_sources"],
     [all_models_with(["life_sources"], ("eff_tier/2", "graded/2", "source/4"),
                      present=("eff_tier(ev57,3)", "eff_tier(ev62,3)"),
                      absent=("eff_tier(ev57,1)", "eff_tier(ev57,2)", "eff_tier(ev62,1)", "eff_tier(ev62,2)"),
                      some=("source(oum(ev57),1,truth,1995)", "source(oum(ev57),2,truth,1995)", "graded(ev62,1)", "graded(ev62,2)")),
      cleaved_by_each("q(direct_killing_of_innocent)=no", "ev57", "ev62")],
     "EV at tier 3 in every branch; the claimed consensus, its grade computed both ways", mode=B)
scen("TC3", CO, "c. 749 §3: an unshown claim is never preferred", ["deathpenalty"],
     [best_rest_on_no_claim,
      # TTC-L CG2 (rule 7): the branch where the claim holds was chosen by a snippet, `:- not oum_holds(dh795).`;
      # a constraint on what the base concludes is refused at the gate, so the base's own switch chooses it
      shown(["deathpenalty", "oum_conditions_shown", "oum_dh795"], ("unshown_claim/1", "oum_holds/1"),
            absent=("unshown_claim(dh795)",))],
     "the claim's branch is main, and never preferred; shown by independent evidence, it would be", mode=B)
scen("TC4", CO, "A lower tier speaking of a higher", ["life_sources", "tier2"],
     [info_all("lower_speaks_of_higher(cdf_1998,ev57,1)", "lower_speaks_of_higher(cdf_1998,t2_truth,2)",
               "lower_speaks_of_higher(lg25,t2_truth,2)"),
      lambda r: (all("violation(self_elevation(cdf_1998,ev57))" in b["facts"]
                     for b in solve(["life_sources", "cand_n11_fixes"], "branches")["branches"]), "n. 11 treated as fixing: refused")],
     "flagged; treated as fixing, refused", mode=B)
scen("NT2", CO, "Scripture, proposed", ["defined_senses", "report_notes"],
     [info_all("note(q(water_of_baptism),true_water,de_fide)", "note(q(jn20_23_power),forgiving_in_the_sacrament,de_fide)"),
      lambda r: (not any(f.startswith("info(note(") for b in solve(["defined_senses", "senses_relaxed", "report_notes"], "branches")["branches"]
                         for f in b["facts"]), "the readings alone: no note")],
     "with Trent, de fide; the readings alone, no note", mode=B)
scen("NT3", CO, "Dated notes: the Immaculate Conception", ["ic", "asof_1850", "report_notes"],
     [info_none("note(q(ic)"),
      lambda r: (all("info(note(q(ic),yes,authentic))" in b["facts"] for b in solve(["ic", "asof_1850", "ic_unprotected", "report_notes"], "branches")["branches"]
                     if b["status"] == "main"), "without the protection, authentic"),
      lambda r: (all("info(note(q(ic),yes,de_fide))" in b["facts"] for b in solve(["ic", "asof_1860", "report_notes"], "branches")["branches"]),
                 "1860: de fide")],
     "1850: none (Trent's protection); without it, authentic; 1860: de fide", mode=B)
scen("NT3b", CO, "Dated notes: Anglican orders", ["ecumenism", "lattice", "report_notes"],
     [in_branches("info(note(q(anglican_orders),invalid,definitive))", "main", assume=["oum_holds(ac1896)"]),
      lambda r: (all("info(note(q(anglican_orders),invalid,authentic))" in b["facts"] for b in r["branches"]
                     if b["status"] == "main" and "oum_holds(ac1896)" not in b["assume"]), "authentic where the claim fails")],
     "definitive where the claim holds, authentic where it fails", mode=B)
scen("NT4", CO, "Evangelium vitae at tier 3", ["life_sources", "report_notes"], [by_grade],
     "de fide at grade 1, definitive at 2, authentic without the claim; EV never above tier 3", mode=B)
scen("NT5", CO, "Erroneous or rash", ["prudential_case"],
     [in_branches("info(censure(prof_pq,rash))", "main"), in_branches("info(censure(prof_eq,erroneous))", "main")],
     "against a directive, rash; against a principle, erroneous", mode=B)
scen("FD1", CO, "Censures", FIL,
     [info_all("censure(prof_o,heretical)", "censure(prof_c,heretical)"), info_none("censure(prof_n,")],
     "\"from the Father alone\" heretical; the Creed without the Filioque, nothing", mode=B)
scen("FD1b", CO, "Censures: Anglican orders", ANG,
     [in_branches("info(censure(prof_a97,contrary_to_definitive))", "main", assume=["oum_holds(ac1896)"]),
      in_branches("info(censure(prof_a97,erroneous))", "main", assume=["oum_holds(ac1896)"], present=False),
      lambda r: (all("info(censure(prof_a97,erroneous))" in b["facts"] for b in r["branches"]
                     if b["status"] == "main" and "oum_holds(ac1896)" not in b["assume"]), "erroneous where the claim fails")],
     "contrary to definitive doctrine where the claim holds, erroneous where not", mode=B)
scen("FD2", CO, "Before the definition", ["ic", "asof_1850", "professions_ic"],
     [info_none("censure(prof_ic"),
      lambda r: (all("info(censure(prof_ic,heretical))" in b["facts"] for b in solve(["ic", "asof_1860", "professions_ic"], "branches")["branches"]),
                 "1860: heretical")],
     "1850: no censure; 1860: heretical (q. 11 a. 2 ad 3)", mode=B)
scen("FD3", CO, "Formal heresy on the claims", FIL,
     [only_with("info(formal_heresy_on_the_claims(theo_c,prof_c))", "assumed_fact(interior(theo_c,prof_c,pertinacious))"),
      only_with("info(faith_in_no_article_on_the_claims(theo_c))", "assumed_fact(interior(theo_c,prof_c,pertinacious))"),
      info_none("formal_heresy_on_the_claims(theo_o"), info_all("formal_heresy_on_the_claims(theo_q,doubt_q)")],
     "where pertinacity is claimed; never of the Orthodox theologian, of whom nothing is claimed", mode=B)
# TTC-L IS1 (rule 7): the case's claim of pertinacity on doubt_r is now named in every branch,
# info(interior_supplied(theo_r,doubt_r,pertinacious)); FD4 still asks that no censure and no canon
# reach doubt_r, so that name is left aside.
scen("FD4", CO, "Doubt", FIL + ["professions_anglican", "ecumenism", "lattice"],
     [info_all("censure(doubt_q,heretical)"),
      info_none("censure(doubt_r", "doubt_r,", apart=("info(interior_supplied(",))],
     "a doubt of de fide teaching heretical; of definitive or authentic teaching, nothing, and no canon", mode=B)
scen("FD5", CO, "Three offences", FIL + ["apostasy_case"],
     [info_all("apostasy_act(rep_x)", "delict(apost_x,n1364_1983,rep_x)", "delict(apost_y,n1364,rep_y)",
               "bond_broken(apost_x,profession)"), info_none("apostasy_act(prof_"),
      lambda r: (all(any(f.startswith("violation(apostasy_without_repudiation(") for f in b["facts"])
                     for b in solve(FIL + ["cand_apostasy_by_count"], "branches")["branches"]), "apostasy by count: refused")],
     "apostasy by repudiation only; heresies counted as apostasy refused", mode=B)
scen("FD5b", CO, "A schismatic act carries no censure of heresy", ["sspx", "lattice"],
     [info_none("censure(")], "schism is against submission, not an article", mode=B)
scen("CN1", CO, "c. 11: who is bound", ["moral_cases", "outside_moral"],
     [shown(["moral_cases", "outside_moral"], ("info/1",), "info(mortal_on_the_claims(m_out,act_out2))",
            absent=("info(mortal_on_the_claims(m_out,act_out))", "info(mortal_on_the_claims(child_s,act_s7))")),
      shown(["moral_cases", "outside_moral"], ("sin_on_the_claims/2",), "sin_on_the_claims(m_out,act_out2)", "sin_on_the_claims(m3,act_m3)",
            absent=("sin_on_the_claims(m_out,act_out)", "sin_on_the_claims(child_s,act_s7)")),
      shown(["moral_cases", "outside_moral"], ("info/1",), "info(mortal_on_the_claims(m_out,act_out))", facts="received_into(m_out).")],
     "an ecclesiastical law binds neither the one outside nor the child under seven; natural law binds all")
scen("CN2", CO, "Heresy, c. 1364", FIL,
     [only_with("info(delict(theo_c,n1364_1983,prof_c))", "assumed_fact(interior(theo_c,prof_c,pertinacious))"),
      info_none("delict(theo_o,"), info_all("delict(theo_q,n1364_1983,doubt_q)")],
     "the Catholic's, where obstinacy is claimed; a pertinacious doubt likewise; the Orthodox theologian's, none (c. 11)", mode=B)
scen("CN3", CO, "Two computations, one answer", FIL,
     [lambda r: (sorted(a[len("heresy_matter("):-1] for a in solve(FIL, "one", show=("heresy_matter/1",))["atoms"] if a.startswith("heresy_matter("))
                 == sorted(f[len("info(censure("):-len(",heretical))")] for f in r["branches"][0]["facts"] if f.endswith(",heretical))")),
                 "c. 751's matter and the censure agree")],
     "the note and c. 750 §1 agree on every profession under the Code", mode=B)
scen("CN4", CO, "c. 1371 n. 1 (1983, 1998), c. 1365 (2021)", ANG,
     [in_branches("info(delict(theo_a,n1371_1983,prof_a97))"), in_branches("info(delict(theo_a,n1371_1998,prof_a00))"),
      in_branches("info(delict(theo_a,n1365,prof_a22))"), in_branches("info(to_be_imposed(theo_a,n1365,prof_a22,censure))"),
      info_none("presumed_incurred(theo_a", "delict(theo_a,n1371_1983,prof_a00)", "delict(theo_a,n1371_1998,prof_a97)",
                "delict(theo_a,n1371_1998,prof_a22)"),
      lambda r: (sorted({f for b in solve(["tier2", "assent", "professions_definitive"], "branches")["branches"] if b["status"] == "main"
                         for f in b["facts"] if f.startswith("info(delict(theo_t")}) == ["info(delict(theo_t,n1371_1998,prof_t00))"],
                 "taught only at tier 2: 1997 no canon, 2000 the amended canon (the gap Ad tuendam fidem names)")],
     "1997: c. 1371 n. 1 reaches it in every branch (the document stays tier 3); 2000 and 2022 likewise; imposed, never incurred",
     mode=B)
scen("CN5", CO, "c. 1117: who is bound to the form", ["marriages_c1117"],
     [shown(["marriages_c1117"], ("bond/1", "ratified/1", "info/1"), "bond(m_lu)", "ratified(m_lu)", "bond(m_def08)",
            "info(marriage(m_mix,invalid_form))", "info(marriage(m_def11,invalid_form))", "info(marriage(m_lu,form_not_binding))",
            absent=("bond(m_mix)", "bond(m_def11)")),
      shown(["marriage_cases"], ("info/1",), "info(marriage(m_pauline,form_not_binding))", absent=("info(marriage(m_rc,form_not_binding))",))],
     "two baptized non-Catholics: valid, ratified; a Catholic without the form: invalid; a formal act, before 2009 only")
scen("FC1", CO, "c. 96 and c. 205", FIL,
     [info_all("in_full_communion(theo_n)", "in_full_communion(theo_rc)", "incorporated(theo_o)", "outside_the_church(theo_o)"),
      info_none("in_full_communion(theo_o)"),
      only_with("info(bond_broken(theo_c,profession))", "assumed_fact(interior(theo_c,prof_c,pertinacious))"),
      lambda r: (all(f"info(in_full_communion({p}))" in b["facts"] for b in solve(["seal", "seal_case", "communion_asked"], "branches")["branches"]
                     for p in ("conf_j", "conf_k")), "the confessors, excommunicated or not, in full communion"),
      # TTC-PENAL AB9 (expectation changed): where Ecclesia Dei, given as law, is not declaratory, it does not
      # reach 30 June 1988 (c. 16 §2) and Abp Lefebvre's bond stands; the 2026 act breaks the other two.
      lambda r: (all(f"info(bond_broken({p},governance))" in b["facts"]
                     for b in solve(["sspx", "lattice", "communion_asked"], "branches")["branches"] if b["status"] == "main"
                     for p in (("fellay", "galarreta") if ED_NOT_DECL in b["assume"] else ("lefebvre", "fellay", "galarreta")))
                 and all("info(in_full_communion(lefebvre))" in b["facts"]
                         for b in solve(["sspx", "lattice", "communion_asked"], "branches")["branches"]
                         if b["status"] == "main" and ED_NOT_DECL in b["assume"]),
                 "1988: the bond broken in every main branch the reading reaches; not where Ecclesia Dei is law and not declaratory")],
     "the Orthodox theologian incorporated, not in full communion; no delict but c. 751's breaks a bond", mode=B)
scen("FC2", CO, "The commentary and the canon diverge", ANG + ["commentary_communion"],
     [in_branches("info(in_full_communion(theo_a))"), cls("q(definitive_denial_breaks_communion)=no", "shadow"),
      only_with("info(no_longer_in_full_communion_by_teaching(theo_a,prof_a97))", "oum_holds(ac1896)"),
      in_branches("no_longer_in_full_communion_by_teaching", values=["q(definitive_denial_breaks_communion)=no"], present=False)],
     "in full communion by c. 205 in every branch; no longer, by the commentary, where its teaching and the claim hold", mode=B)
scen("FC3", CO, "LG 14: in body, not in heart", ["lg14_case"],
     [only_with("info(fully_incorporated_on_the_claims(fid_l))", "assumed_fact(interior(fid_l,state,in_grace))"),
      only_with("info(in_body_not_in_heart_on_the_claims(fid_l))", "assumed_fact(false(interior(fid_l,state,in_grace)))")],
     "on the claim of grace, both ways", mode=B)

# ---------- TTC-PENAL: abortion, c. 1399, c. 1752, the Dicastery's clause; form and object; fictions ----
PN = "penal"
ABC = ["life_sources", "abortion", "abortion_canon"]
ABD = AB + ["abortion_canon_di"]
ECD = EC + ["abortion_canon_di"]
ART6 = ["art6_case"]
ED_DECL, ED_NOT_DECL = "assumed_fact(declaratory(ed1988))", "assumed_fact(false(declaratory(ed1988)))"

def follows_verdict(parts, acts):
    """in every main branch, the act is the delict of c. 1397 §2 exactly where it is "must not" as a direct killing"""
    def chk(_r):
        bad = []
        for b in solve(parts, "branches")["branches"]:
            if b["status"] != "main":
                continue
            for p, a in acts:
                v = f"info(verdict({a},must_not,by_object(direct(killing_of_innocent))))" in b["facts"]
                d = f"info(delict({p},n1397,{a}))" in b["facts"]
                if v != d:
                    bad.append((a, v, d))
        return not bad, "delict exactly where the verdict is the direct killing" if not bad else f"apart: {bad[:3]}"
    return chk

def outcomes(parts, person):
    """the set of outcomes for a person across branches: exempt, imposed, or neither"""
    out = set()
    for b in solve(parts, "branches")["branches"]:
        f = b["facts"]
        out.add("exempt" if f"info(exempt({person}," in " ".join(f) else
                "imposed" if any(x.startswith(f"info(to_be_imposed({person},") for x in f) else "neither")
    return out

def noted_by_grade(q, doc):
    """de fide where the claim holds at grade 1, definitive at 2, authentic without it; no contrary under grade 1"""
    def chk(r):
        bad = []
        for b in r["branches"]:
            if b["status"] != "main":
                continue
            g = 1 if f"graded({doc},1)" in b["assume"] else 2 if f"oum_holds({doc})" in b["assume"] else 0
            want = {1: "de_fide", 2: "definitive", 0: "authentic"}[g]
            if f"info(note({q},yes,{want}))" not in b["facts"]:
                bad.append(want)
        excl = [b for b in r["branches"] if f"{q}=no" in b["values"] and f"graded({doc},1)" in b["assume"]]
        return not bad and not excl, "noted by grade; no contrary under grade 1" if not bad and not excl else f"wrong: {bad[:3]} {len(excl)}"
    return chk

def feeds_nothing(norm):
    def chk(_r):
        from .norms import graph
        out = [e for e in graph()["edges"] if e[0] == norm]
        return not out, f"{norm} feeds nothing" if not out else f"{norm} feeds {out}"
    return chk

scen("AB1", PN, "Abortion: the matter from the library", ABD,
     [in_branches("info(delict(doctor_a,n1397,abort_1))", "main"), in_branches("info(delict(mother_a,n1397,abort_1))", "main"),
      in_branches("info(delict(doctor_c,n1397,cranio))", "main", [CAUSAL]),
      in_branches("info(delict(doctor_c,n1397,cranio))", "main", [CHOICE], [chose("doctor_c", "cranio", "death_of_child")]),
      in_branches("info(delict(doctor_c,n1397,cranio))", "main", [CHOICE], [chose("doctor_c", "cranio", "death_of_child", False)],
                  present=False),
      follows_verdict(ABD, [("doctor_a", "abort_1"), ("doctor_c", "cranio")]),
      follows_verdict(ECD, [("doctor_e", "tube_out"), ("doctor_t", "embryo_out"), ("doctor_m", "mtx")]),
      lambda r: (not any("delict(doctor_e," in f for b in solve(ECD, "branches")["branches"] for f in b["facts"]),
                 "the salpingectomy, licit on the claims: no delict")],
     "c. 1397 §2 follows the verdicts act by act: the direct killing of the unborn, and only it, is the delict", mode=B)
scen("AB2", PN, "The attempt", ABC,
     [in_branches("info(attempt_not_the_delict(m_try,ab_try))", "main"), info_none("info(delict(m_try,", "info(delict(doctor_b,n1397,ab_try)"),
      in_branches("info(verdict(ab_try,must_not,by_object(direct(killing_of_innocent))))", "main")],
     "not the delict (c. 1328 §1); the act still \"must not\"", mode=B)
scen("AB3", PN, "Two texts, one content", ABC,
     [shown(ABC, ("delict/3",), "delict(doctor_b,n1398_1983,ab_19)", "delict(doctor_b,n1397,ab_15)",
            absent=("delict(doctor_b,n1397,ab_19)", "delict(doctor_b,n1398_1983,ab_15)")),
      # changed with TTC-REPAIRS2 (not predicted): one model, so the reading of c. 1321 §4 is fixed to dolus
      shown(ABC + DOLUS_PART, ("excommunicated_at/2",), "excommunicated_at(doctor_b,19900301)")],
     "2019 under c. 1398 (1983), 2023 under c. 1397 §2; no act under both", mode=B)
scen("AB4", PN, "The exemptions, through the library", ABC,
     [in_branches("info(exempt(m_15,ab_15))", "main"), in_branches("info(mitigated(m_17,ab_17,minor))", "main"),
      in_branches("info(mitigated(m_pen,ab_pen,penalty_unknown))", "main"), in_branches("info(mitigated(m_fear,ab_fear,fear))", "main"),
      in_branches("info(exempt(m_fear,ab_fear))", "main", present=False),
      # changed with TTC-REPAIRS2 (CI2): with no source entered, incurred where c. 1321 §4 is read to presume dolus;
      # the one-model check fixes that reading
      under(DOLUS_READ, in_branches("info(presumed_incurred(m_aff,n1397))", "main")),
      in_branches("info(ignorance_disregarded(m_aff,ab_aff,penalty))", "main"),
      under(DOLUS_READ, in_branches("info(presumed_incurred(doctor_b,n1397))", "main")),
      info_none("presumed_incurred(m_15,", "presumed_incurred(m_17,", "presumed_incurred(m_pen,", "presumed_incurred(m_fear,"),
      shown(ABC + DOLUS_PART, ("excommunicated_at/2",), "excommunicated_at(doctor_b,20261010)", "excommunicated_at(m_aff,20261010)",
            absent=("excommunicated_at(m_17,20261010)",))] +
     [in_branches(f"info(verdict({a},must_not,by_object(direct(killing_of_innocent))))", "main")
      for a in ("ab_15", "ab_17", "ab_pen", "ab_fear", "ab_aff")],
     "under 16 exempt; at 17, the penalty unknown, and grave fear (the act intrinsically evil) mitigated, so not bound; "
     "affected ignorance disregarded; every act still \"must not\"", mode=B)
scen("AB5", PN, "One kind, two canons", ABC,
     [in_branches("info(exempt(m_fear,ab_fear))", None, ["q(direct_killing_of_innocent)=no"]),
      in_branches("info(mitigated(m_fear,ab_fear,fear))", None, ["q(direct_killing_of_innocent)=yes"])],
     "c. 1323 n. 4 reads the library's kind: where the kind is not evil by its object (a shadow), fear exempts", mode=B)
scen("AB6", PN, "Accomplices", ABC,
     [only_with("info(presumed_incurred(nurse_n,n1397))", "assumed_fact(necessary_assistance(nurse_n,ab_15))"),
      only_with("info(accomplice_may_be_punished(nurse_n,n1397,ab_15))", "assumed_fact(false(necessary_assistance(nurse_n,ab_15)))"),
      info_all("accomplice_may_be_punished(nurse_u,n1397,ab_17)"), info_none("presumed_incurred(nurse_u,")],
     "a necessary accomplice incurs it though the mother (15) is exempt; one not necessary may be punished (c. 1329 §2)", mode=B)
scen("AB7", PN, "c. 11", ABC,
     [info_none("delict(m_out,"), in_branches("info(delict(doctor_b,n1397,ab_out))", "main"),
      shown(ABC, ("delict/3",), "delict(m_out,n1397,ab_out)", facts="received_into(m_out)."),
      in_branches("info(verdict(ab_out,must_not,by_object(direct(killing_of_innocent))))", "main")],
     "the mother baptized outside incurs nothing; the act \"must not\" (divine law binds all)", mode=B)
scen("AB8", PN, "The interpretation of 1988 and its date", ABC,
     [info_all("not_retroactive(pclt1988,ab_87)", "declined_by_strict_interpretation(abortion,killing,ab_87)"),
      shown(ABC, ("delict/3",), "delict(doctor_b,n1398_1983,ab_90)", "delict(doctor_b,n1398_1983,ab_87x)",
            absent=("delict(doctor_b,n1398_1983,ab_87)",)),
      info_none("not_retroactive(pclt1988,ab_90)"),
      lambda r: (any("info(not_retroactive(pclt2000,s915))" in b["facts"] and
                     "info(declined_by_strict_interpretation(c915,objective,s915))" in b["facts"]
                     for b in solve(["c915_case", "pclt_confirmed"], "branches", facts="today(19991231).")["branches"]),
                 "judged in 1999, before the declaration's force: not reached, the reading open"),
      lambda r: (not any("info(declined_by_strict_interpretation(c915,objective,s915))" in b["facts"]
                         for b in solve(["c915_case", "pclt_confirmed"], "branches", facts="today(20261010).")["branches"]),
                 "judged in 2026: reached"),
      shown(["c915_case"], ("violation/1",), "violation(interpretation_without_force(x_int))",
            facts="applies_reading(x_int,c915,objective). issuer(x_int,pope_x). authority(pope_x,4). "
                  "interpretation_form(x_int,law). promulgated(x_int,20000101).")],
     "extensive, not retroactive: 1987, killed in utero, no delict (c. 18: expulsion); expelled, the delict; 1990, the delict. "
     "A lasting situation is judged on the evaluation date; a law-form interpretation without a date of force is refused", mode=B)
scen("AB9", PN, "The same rule for Ecclesia Dei", SX,
     [only_with("info(declined_by_strict_interpretation(c751,act_suffices,e1988_fellay))", ED_NOT_DECL),
      main_with("q(act1988_schismatic)=yes", "delict(lefebvre,n1364_1983,e1988_fellay)", where=ED_DECL),
      every_branch_with(ED_NOT_DECL, "delict(lefebvre,n1364_1983", present=False),
      every_branch_with(ED_NOT_DECL, "delict(lefebvre,n1382_1983,e1988_fellay)"),
      lambda r: (all(ED_LAW in b["assume"] for b in r["branches"] if ED_NOT_DECL in b["assume"]), "the split is in the law-form world only")],
     "given as law, it reaches 30 June 1988 only if declaratory; otherwise c. 18 reads c. 751 strictly; c. 1382 reaches them anyway",
     mode=B)
scen("GP1", PN, "c. 1399: imposed, on the authority's judgment", ["c1399_case"],
     [info_all("to_be_imposed(cat_v,n1399,act_v,just_penalty)"), info_none("presumed_incurred(cat_v,", "delict(cat_w,"),
      shown(["c1399_case"], ("delict/3",), "delict(cat_w,n1399,act_w)",
            facts="special_gravity(ordinary_v,act_w). scandal_necessity(ordinary_v,act_w).")],
     "to be imposed, never incurred; without the two judgments, nothing", mode=B)
scen("GP2", PN, "c. 1399: divine or canon law, and c. 11", ["c1399_case"],
     [info_all("delict(cat_f,n1399,act_f)", "verdict(act_o,must_not,by_object(k_v))"), info_none("delict(out_v,"),
      shown(["c1399_case"], ("delict/3",), "delict(out_v,n1399,act_o)", facts="received_into(out_v).")],
     "a violation of an ecclesiastical law too; not one outside, though the law violated is divine", mode=B)
scen("GP3", PN, "c. 1399: besides the cases prescribed", ["c1399_case"],
     [info_all("delict(conf_v,n1386,act_x)"), info_none("delict(conf_v,n1399")],
     "where a specific canon reaches the act, no second title", mode=B)
scen("SL1", PN, "c. 1752: the supreme law names no effect", ["transfer_case"],
     [info_all("to_keep_in_view(dec_t,salus_animarum)"), feeds_nothing("cic:1752")],
     "a judgment kept in view; in the norm graph it feeds nothing", mode=B)
scen("SL2", PN, "Salus animarum against the law", ABC + ["cand_salus_animarum"],
     [any_branch_violation("weighing_against_law(text_s,n1397)"), info_none("presumed_incurred(doctor_b,n1397)")],
     "refused: canonists never weigh against the law (rule 2)", mode=B)
scen("N1", PN, "The Dicastery's clause: versari in re illicita", ART6 + ["art6_papal"],
     [clean_branches, info_all("to_be_imposed(cl_a,n1398_1,act_a,deprivation)", "to_be_imposed(cl_b,n1398_1,act_b,deprivation)")],
     "the act unlawful apart from the age (c. 277 §1): the clause raises no violation", mode=B)
scen("N2", PN, "One branch fewer", ART6 + ["art6_papal"],
     [lambda r: (outcomes(ART6, "cl_a") == {"exempt", "imposed"} and outcomes(ART6 + ["art6_papal"], "cl_a") == {"imposed"},
                 "without the clause: exempt or imposed; with it: imposed"),
      lambda r: (any("culpa_not_punished(cl_b" in f for b in solve(ART6, "branches")["branches"] for f in b["facts"]), "without it, culpa unpunished"),
      info_none("culpa_not_punished(cl_b"), info_all("error_disregarded(cl_b,n1398_1,act_b)"),
      lambda r: ({any("assumed_fact(interior(cl_a,act_a,error(fact(minor),invincible)))" == a for a in b["assume"]) for b in r["branches"]}
                 == {True, False}, "the claim still computed both ways")],
     "the branch in which the error exempts is gone; the claim is still computed both ways", mode=B)
scen("N3", PN, "Read as a moral judgment", ART6 + ["art6_papal", "cand_art6_moral"],
     [any_branch_violation("teaching_from_law(q(species_with_age_unknown))")],
     "refused: law answering a doctrinal question (rule 1)", mode=B)
scen("N4", PN, "Transposed to a lawful act (HYPOTHETICAL)", ["art6_transposed"],
     [any_branch_violation("punished_without_fault(lay_t,n_hyp,act_t)"),
      shown(["art6_transposed"], ("violation/1",), facts="forbids(l_t,k_lawful). law_kind(l_t,ecclesiastical).",
            absent=("violation(punished_without_fault(lay_t,n_hyp,act_t))",))],
     "punished without dolus or culpa (c. 1321 §2): flagged", mode=B)
scen("N5", PN, "Rank", ART6 + ["art6_decree"],
     [info_all("derogation_refused(sst2021,n1398_1)"), info_any("exempt(cl_a,act_a)"),
      lambda r: ((bs := [b for b in solve(ART6 + ["art6_rank_disputed"], "branches")["branches"]
                         if "assumed_fact(interior(cl_a,act_a,error(fact(minor),invincible)))" in b["assume"]])
                 and all(("assumed_fact(issuer(sst2021,francis))" in b["assume"]) != any(f.startswith("info(exempt(cl_a,") for f in b["facts"])
                         for b in bs)
                 and {("assumed_fact(issuer(sst2021,francis))" in b["assume"],
                       "assumed_fact(false(issuer(sst2021,francis)))" in b["assume"]) for b in bs} == {(True, False), (False, True)},
                 "rank disputed: exempt on the claim exactly where papal approval is not assumed")],
     "as a dicastery's decree it cannot derogate (cc. 33 §1, 135 §2); it branches on rank only where the rank is disputed", mode=B)
scen("FO1", PN, "Form and object: a connected truth defined", ["connected_definition"],
     [clean_branches, cls("q(fact_x)=yes", "settled"),
      lambda r: ("tier_inconsistent_with_form(def_y,1,ex_cathedra)" in (v := solve(["connected_definition", "cand_connected_at_tier1"], "one")["violations"])
                 and not any(x.startswith("tier_without_warrant(def_y") for x in v), "entered at tier 1: refused, though warranted"),
      shown(["marian", "creeds"], ("object_of/2",), "object_of(munificentissimus_1950,revealed)")],
     "tier 2 by its object, no violation; at tier 1, refused; the base's definitions define as revealed", mode=B)
scen("FO2", PN, "Jansen's sense: a dogmatic fact", ["jansenism", "jansen_fact", "ad_sanctam_defined"],
     [cls("q(five_in_augustinus)=yes", "settled"), branch_of("q(five_in_augustinus)=no", "counterfactual_shadow", t2=True),
      branch_of("q(five_in_augustinus)=no", "live_shadow", t2=False), cls("q(grace_always_efficacious)=yes", "excluded"),
      weight_in("q(five_in_augustinus)=yes", 5, 2),   # Jansen on the right, Arnauld on the fact, both against
      lambda r: (classify(solve(["jansenism", "jansen_fact", "ad_sanctam_as_shown"], "branches"), "q(five_in_augustinus)=no") == "shadow"
                 and any("lower_speaks_of_higher(ad_sanctam_1656,ad_sanctam_1656,2)" in f
                         for b in solve(["jansenism", "jansen_fact", "ad_sanctam_as_shown"], "branches")["branches"] for f in b["facts"]),
                 "as shown: tier 3, its own word a claim"),
      lambda r: ((v := solve(["jansenism", "jansen_fact", "cand_ad_sanctam_on_dh"], "one"))["violations"] == ["tier_without_warrant(ad_sanctam_1656,2)"]
                 and sorted(a for a in v["atoms"] if a.startswith("info(condition_unshown(ad_sanctam_1656,")) ==
                 [f"info(condition_unshown(ad_sanctam_1656,{c}))" for c in ("apostolic_authority", "pastor_of_all", "whole_church")],
                 "on DH 2010-2012 as a definition: refused, three conditions unshown")],
     "DH 2010-2012 shows a definition of a dogmatic fact but not the pastor of all, apostolic authority in the defining clause, "
     "or the whole Church: at tier 3, authentic; definitive only with the five shown (HYPOTHETICAL until the full bull is read)", mode=B)
scen("FO3", PN, "Respectful silence", ["jansenism", "jansen_fact", "ad_sanctam_defined", "respectful_silence"],
     [info_all("silence_without_censure(jansenist_s,q(five_in_augustinus))"), info_none("censure(sil_1"),
      lambda r: (any("assent_computed(jansenist_s,q(five_in_augustinus))" in v for v in
                     solve(["jansenism", "jansen_fact", "ad_sanctam_defined", "respectful_silence", "cand_silence_as_assent"], "one")["violations"]),
                 "silence read as assent: refused")],
     "silence takes no censure, and assent is never computed (Vineam Domini; rule 3)", mode=B)
scen("FO4", PN, "A declaration that defines nothing", ["ordination_reserved", "report_notes"],
     [noted_by_grade("q(ordination_reserved_to_men)", "os1994"), best_rest_on_no_claim,
      info_all("lower_speaks_of_higher(os1994,os1994,2)", "lower_speaks_of_higher(cdf_1995,os1994,1)",
               "lower_speaks_of_higher(cdf_1998,os1994,2)"), clean_branches,
      cleaved_by_each("q(ordination_reserved_to_men)=no", "os1994", "cdf_1995"),
      lambda r: ("tier_inconsistent_with_form(decl_w,2,definitive_declaration)" in solve([], "one",
                 facts="source(decl_w,2,truth,2000). papal_form(decl_w,definitive_declaration). oum_claim(decl_w,2). oum_claimant(decl_w,decl_w).")["violations"],
                 "a declaration entered at tier 2: refused"),
      lambda r: ("declaration_without_claim(decl_z)" in solve(["cand_declaration_unclaimed"], "one")["violations"],
                 "a declaration of grade with no claim: refused")],
     "tier 3 with its claim; de fide, definitive or authentic by the grade; never preferred on the unshown claim", mode=B)
scen("FO5", PN, "The force of tier 2 still waits", ["ordination_reserved"],
     [lambda r: ({b["t2"] for b in r["branches"]} == {True, False}, "t2_truth computed both ways")],
     "no source of this step fixes t2_truth", mode=B)
scen("FL1", PN, "Fictions: acts through representatives", ["fiction_acts"],
     [shown(["fiction_acts"], ("sin_on_the_claims/2", "agent/2"), "sin_on_the_claims(bishop_d,act_d)", "agent(bishop_d,act_d)",
            "agent(pope_r,act_as)", absent=("agent(diocese_d,act_d)", "agent(apostolic_see,act_as)", "sin_on_the_claims(diocese_d,act_d)")),
      info_all("verdict(act_d,must_not,by_object(k_s))"), clean_branches],
     "the bishop acts for the diocese, the pope for the Apostolic See; the act's verdict stands", mode=B)
scen("FL2", PN, "\"The state is evil\"", ["cand_state_is_evil"],
     [any_branch_violation("interior_of_fiction(state_x,act_x_s)"), info_all("verdict(act_x_s,must_not,by_object(k_s))"),
      lambda r: ("delict_of_fiction(college_c,n1386,act_c)" in solve(["cand_fiction_delict"], "one")["violations"],
                 "a college excommunicated: refused (Romana ecclesia)")],
     "refused, not answered: no interior, no sin, no delict of a fiction", mode=B)
scen("FL4", PN, "The Society's refusal: a position, not an offence", SX,
     [info_all("public_position(sspx,refuses(dignitatis_humanae))"), info_none("offense(sspx,"),
      shown(SX, ("info/1",), "info(offense(fidelis_r,dissent_c752,dignitatis_humanae))", facts="refuses(fidelis_r,dignitatis_humanae)."),
      lambda r: (all(("holds(q(canonical_status),recognized)" in m) == ("juridic_person(sspx)" in m) != ("group(sspx)" in m)
                     for m in solve(SX, "all", facts="source(grant_x,3,juridical,2026). dicastery(grant_x). "
                                    "supports(grant_x,q(canonical_status),recognized).",
                                    show=("juridic_person/1", "group/1", "holds/2"))["all_models"]),
                 "recognized (HYPOTHETICAL): a juridic person; otherwise a group")],
     "a group without canonical status: an offence is said only of a person", mode=B)

# ---------- The saeculum: one library for time (TTC-SAECULUM) -----------
SAE = "saeculum"
FORCE = ("in_force_from/2",)
scen("CT1", SAE, "c. 8 §1 from the issue: Omnium in mentem", ["defection_2010", "on_0407"],
     [info_all("info(marriage(m_r,form_not_binding))"),
      shown(["defection_2010", "on_0408"], ("info/1",), "info(marriage(m_r,invalid_form))",
            absent=("info(marriage(m_r,form_not_binding))",)),
      shown(["defection_2010"], FORCE, "in_force_from(oim2009,20100408)", "in_force_from(code1983,19831127)",
            "in_force_from(pgd2021,20211208)"),
      shown(["pclt_confirmed"], FORCE, "in_force_from(pclt2000,20000624)")],
     "issue of 8 January 2010, in force 8 April 2010: the day before, the defection frees from the form; that day, not. "
     "A law that names its own date keeps it", mode=B)
scen("CT2", SAE, "The month that lacks the day", ["issues_november"],
     [shown(["issues_november"], FORCE, "in_force_from(law_a,20240229)", "in_force_from(law_b,20240301)",
            "in_force_from(law_c,20230301)", "in_force_from(law_d,20231201)")],
     "29 November 2023: 29 February 2024; 30 November 2023: 1 March 2024; 29 November 2022: 1 March 2023 (c. 203 §2)")
scen("CT5", SAE, "A particular law: a month from promulgation (c. 8 §2)", ["particular_laws"],
     [shown(["particular_laws"], FORCE, "in_force_from(pl_a,20261001)", "in_force_from(pl_b,20260301)",
            "in_force_from(pl_c,20270101)", "in_force_from(pl_d,20260901)", "in_force_from(ul_e,20261201)",
            absent=("in_force_from(pl_d,20261001)", "in_force_from(ul_e,20261001)"))],
     "1 September: 1 October; 31 January: 1 March (c. 203 §2); 1 December: 1 January; a law that sets its own time "
     "keeps it; a universal law keeps c. 8 §1's three months")
scen("CT3", SAE, "An unread issue: force inside its span both ways", ["tier2", "assent", "professions_definitive", "rejection_1998"],
     [in_branches("info(delict(theo_t,n1371_1998,prof_t98))", "main", assume=["assumed_fact(force_by(atf1998,19981201))"]),
      in_branches("info(delict(theo_t,n1371_1998,prof_t98))", "main", assume=["assumed_fact(false(force_by(atf1998,19981201)))"],
                  present=False),
      in_branches("info(delict(theo_t,n1371_1998,prof_t00))", "main"),
      lambda r: (not any("assumed_fact(force_by(atf1998,19981201))" in b["assume"]
                         and "assumed_fact(false(force_by(atf1998,19990201)))" in b["assume"] for b in r["branches"])
                 and any("assumed_fact(force_by(atf1998,19990201))" in b["assume"]
                         and "assumed_fact(false(force_by(atf1998,19981201)))" in b["assume"] for b in r["branches"]),
                 "in force from a day inside the span, then in force after it"),
      assumed_none_in(["tier2", "assent", "professions_definitive"], "force_by("),
      shown(["sspx"], ("force_window/3",), "force_window(ed1988,19881002,19890331)",
            "force_window(pclt1988,19880823,19890331)", "force_window(atf1998,19980818,19990331)")],
     "1 December 1998: the amended c. 1371 n. 1 in one branch, none in the other; the base's cases fall outside every span", mode=B)
scen("CT4", SAE, "Ages from birth dates", ABC + ["ages_c97"],
     [in_branches("info(exempt(m_b16,ab_b16))", "main"), in_branches("info(mitigated(m_a16,ab_a16,minor))", "main"),
      in_branches("info(mitigated(m_f28,ab_f28,minor))", "main"),
      # changed with TTC-REPAIRS2 (CI2): incurred where c. 1321 §4 is read to presume dolus
      under(DOLUS_READ, in_branches("info(presumed_incurred(m_f01,n1397))", "main")),
      info_none("exempt(m_a16,", "mitigated(m_f01,", "exempt(m_f01,", "presumed_incurred(m_b16,", "presumed_incurred(m_a16,",
                "presumed_incurred(m_f28,")],
     "on the sixteenth birthday not yet sixteen (c. 1323 n. 1); the day after, tempered; born 29 February, a minor "
     "on 28 February 2026, an adult on 1 March (c. 97 §1, c. 203)", mode=B)
scen("CA1", SAE, "One clock", ["cand_total_ban", "today_20261010"],
     [shown(["cand_total_ban", "today_20261010"], ("in_force/1", "asof/1", "now/1"), "asof(2026)", "now(20261010)",
            absent=("in_force(total_ban)", "asof(9999)")),
      shown(["cand_total_ban"], ("in_force/1", "asof/1"), "in_force(total_ban)", "asof(9999)"),
      shown(["today_20261010", "asof_2010"], ("now/1", "asof/1"), "now(20101231)", "asof(2010)", absent=("now(20261010)",))],
     "a day given: the graph read as of its year; an asof year: its last day; no clock: every source entered")
scen("CA2", SAE, "One act, one date", ["cand_dates_disagree"],
     [has("dates_disagree(act_d,2001,20000505)"),
      shown(["sspx"], ("violation/1", "promulgated/2"), "promulgated(ed1988,19880702)", absent=("violation(dates_disagree(ed1988,1988,19880702))",))],
     "refused: one act given two years; Ecclesia Dei agrees with itself")
scen("RC1", SAE, "Reception: a dated claim, fixed only at tier 1", ["creeds", "reception_fixed_hyp"],
     [branches_n(2), assumed_none("received(quicumque)"),
      preferred_assume(["trinity", "filioque", "councils_relaxed", "creeds"], QNR),
      lambda r: (not any(f.startswith("violation(tier_without_warrant") for b in
                         solve(["trinity", "filioque", "councils_relaxed", "creeds"], "branches")["branches"] for f in b["facts"]),
                 "received, a creed is warranted"),
      lambda r: (solve(["creeds", "reception_fixed_hyp", "asof_1250"], "branches")["models"] == 4,
                 "as of 1250, before the act at tier 1: both ways"),
      shown(["creeds"], ("in_force/1",), facts="asof(600). custom_asof.", absent=("in_force(quicumque)",)),
      shown(["creeds", "cand_reception_unclaimed"], ("violation/1",), "violation(reception_without_claimant(quicumque))"),
      info_any("handed_on_below_tier_1(quicumque,florence_armenians_1439)"),
      shown(["creeds"], ("used_work/2", "to_fetch/2"), "used_work(schaff_herzog,quicumque)",
            absent=('to_fetch(schaff_herzog,verify(quicumque,"vol. I, s.v. Athanasian Creed: its reception"))',))],
     "fixed by an act at tier 1 (HYPOTHETICAL): no branch; before it, both ways; before the year claimed, not in force; "
     "an undated, unclaimed reception refused; Florence (1439) a witness at tier 3", mode=B)
scen("OR1", SAE, "Glosses dated before their texts", ["cand_dated_before"],
     [has("measure_against_order(gloss_g,text_t)", "measure_against_order(gloss_i,text_i)",
          "measure_against_order(gloss_c,text_c)", "measure_against_order(gloss_o,text_o)")],
     "what cites, interprets, grades or claims for an act comes after it: refused")
scen("OR2", SAE, "The end dated", CREED + ["cand_end_dated"],
     [has("end_dated(return)", "end_dated(judgment)")], "\"of that day and hour no one knows\" (Mt 24:36): refused")
scen("OR2b", SAE, "The end past", CREED + ["cand_end_past"],
     [has("end_past(return,council_x)", "end_past(return,council_y)"), none_of("end_dated")], "\"the resurrection is past already\" (2 Tim 2:18): refused")
scen("OR3", SAE, "An event before the beginning", CREED + ["cand_before_creation"],
     [has("before_the_beginning(first_motion)")], "\"ab initio temporis\" (DH 800): refused")
scen("OR4", SAE, "The order stays partial", CREED + ["cand_grace_unforeseen"],
     [clean], "a second path to Mary's conception: well formed")
scen("MD1", SAE, "The measures typed", ["world"],
     [clean, shown(["world"], ("measure/2",), "measure(god,eternity)", "measure(gabriel,aevum)", "measure(peter,time)",
                   "measure(stone,time)", absent=("measure(god,time)", "measure(gabriel,time)", "measure(peter,aevum)"))],
     "eternity for God; the aevum for angels (Thomas's); time for bodily creatures")
scen("MD2", SAE, "The Son's begetting placed in the order", CREED + ["cand_generation_dated"],
     [has("procession_in_time(begetting)", "procession_in_time(spiration)"),
      shown(["trinity", "cand_arian"], ("violation/1",), "violation(eternal_with_beginning(son))")],
     "\"there was when he was not\" (DH 126): refused; Arius's Son, eternal with a beginning")
scen("MD3", SAE, "Eternity said of a creature", ["world", "cand_world_eternal"],
     [has("creature_without_beginning(world)"),
      shown(["world", "cand_light_eternal"], ("violation/1",), "violation(eternal_with_beginning(light))")],
     "a world without beginning, and light given eternity's mode: refused (DH 800)")
scen("MD4", SAE, "God's decree dated", ["world"] + CREED + ["cand_decree_dated"],
     [has("divine_act_in_time(decree_of_election)", "divine_act_in_time(decree_of_mission)",
          "divine_act_in_time(decree_of_end)")], "his act is not dated; its effects are (CCC 600): refused")

# ---------- The Eastern Code: a second canon layer (TTC-CCEO) -------------
CC = "cceo"
IMP = ["interritual_marriages"]
scen("AS1", CC, "Silence ascribes to the Latin Church", ["sspx", "communion_asked"],
     [shown(["sspx", "communion_asked"], ("latin_faithful/1", "eastern_faithful/1"), "latin_faithful(lefebvre)",
            "latin_faithful(galarreta)", absent=("eastern_faithful(lefebvre)",))],
     "a Catholic whose ascription is not recorded is Latin; the SSPX's outputs do not change")
scen("AS2", CC, "A child's ascription", ["eastern_ascription"],
     [info_all("info(ascribed_to(ch_1,latin))", "info(ascribed_to(ch_2,latin))", "info(ascribed_to(ch_3,ukrainian))",
               "info(ascribed_to(ch_4,ukrainian))", "info(ascribed_to(ch_5,ukrainian))"),
      shown(["eastern_ascription"], ("eastern_faithful/1", "latin_faithful/1"), "eastern_faithful(ch_3)", "eastern_faithful(ch_5)",
            "latin_faithful(ch_1)", absent=("eastern_faithful(ch_1)", "latin_faithful(ch_3)"))],
     "parents agreeing on the Latin Church: Latin; failing agreement, the father's Church (c. 111 §1; CCEO c. 29 §1)", mode=B)
scen("AS3", CC, "An Eastern bishop consecrates without a mandate", ["eastern_consecration"],
     [info_all("info(eastern_delict(bp_e,cceo1459_1,e_east))", "info(eastern_delict(bp_f,cceo1459_1,e_east))",
               "info(to_be_imposed(bp_e,cceo1459_1,e_east,deposition))",
               "info(no_eastern_code_in_force(bp_e,e_1990))", "info(no_eastern_code_in_force(bp_g,e_1990))"),
      # changed with TTC-REPAIRS2 (not predicted): the Latin bishop's c. 1387, incurred where c. 1321 §4 is read
      # to presume dolus
      under(DOLUS_READ, info_all("info(presumed_incurred(bp_l,n1387))")),
      info_none("info(delict(bp_e,", "info(delict(bp_f,", "presumed_incurred(bp_e,", "presumed_incurred(bp_f,",
                "eastern_delict(bp_l,", "eastern_delict(bp_m,")],
     "no c. 1387 delict and nothing incurred; deposition to be imposed (CCEO c. 1459 §1); the Latin bishop incurs c. 1387", mode=B)
scen("EP1", CC, "An Eastern mother procures an abortion", ABC + ["eastern_abortion"],
     [in_branches("info(eastern_delict(m_east,cceo1450_2,ab_east))", "main"),
      in_branches("info(to_be_imposed(m_east,cceo1450_2,ab_east,excommunication))", "main"),
      in_branches("info(verdict(ab_east,must_not,by_object(direct(killing_of_innocent))))", "main"),
      in_branches("info(no_eastern_code_in_force(m_east,ab_east90))", "main"),
      info_none("presumed_incurred(m_east,", "info(delict(m_east,")],
     "imposed, never incurred (CCEO cc. 1450 §2, 1402); the act still \"must not\"", mode=B)
scen("EP2", CC, "One denial, two codes", ["ic", "assent", "eastern_faith"],
     # changed with TTC-REPAIRS2 (CI2): the Latin heretic's c. 1364, incurred where c. 1321 §4 is read to presume dolus
     [info_all("info(eastern_delict(theo_e,cceo1436_1,den_e))",
               "info(to_be_imposed(theo_e,cceo1436_1,den_e,major_excommunication))"),
      under(DOLUS_READ, info_all("info(presumed_incurred(theo_l,n1364))")),
      info_all("info(eastern_delict(theo_y,cceo1436_1,dub_y))", "info(eastern_delict(theo_z,cceo1436_1,rep_z))"),
      shown(["ic", "assent", "eastern_faith"], ("heresy_matter/1",), "heresy_matter(den_w)"),
      info_none("delict(theo_w,", "eastern_delict(theo_w,", "info(delict(theo_e,", "presumed_incurred(theo_e",
                "presumed_incurred(theo_z", "presumed_incurred(theo_y")],
     "Latin: c. 1364 §1, incurred; Eastern: c. 1436 §1, imposed, only after a warning not heeded", mode=B)
scen("EP3", CC, "Before the Eastern Code", ["ic", "assent", "eastern_faith"],
     [info_all("info(no_eastern_code_in_force(theo_x,den_x))", "info(no_eastern_code_in_force(theo_z,rep_z90))"),
      info_none("delict(theo_x,", "eastern_delict(theo_x,", "eastern_delict(theo_z,cceo1436_1,rep_z90)")],
     "an Eastern act of 1990: reported, never computed under the Latin", mode=B)
scen("EP4", CC, "Ad tuendam fidem on the Eastern side", ["tier2", "assent", "eastern_definitive"],
     [in_branches("info(eastern_delict(theo_d,cceo1436_2,prof_d00))", "main"),
      in_branches("info(to_be_imposed(theo_d,cceo1436_2,prof_d00,just_penalty))", "main"),
      info_none("eastern_delict(theo_d,cceo1436_2,prof_d97)",
      "info(delict(theo_d,")],
     "1997 no Eastern delict; 2000 c. 1436 §2 as amended in 1998, a penalty to be imposed", mode=B)
scen("IM1", CC, "A Latin and an Eastern Catholic before a deacon", IMP,
     [info_all("info(marriage(im_15,invalid_form))", "info(marriage(im_16,invalid_form))", "info(marriage(im_18,invalid_form))",
               "info(priest_required(im_15,cceo828))", "info(priest_required(im_18,cceo828))",
               "info(priest_required(im_18,n1108_3))"),
      info_none("priest_required(im_15,n1108_3)"),
      shown(IMP, ("cleric/1",), "cleric(dcn_d)"),
      branch_facts("assumed_fact(reading(c8_elsewhere,dc2016,from_acta))", every=False),
      branch_facts("assumed_fact(reading(c8_elsewhere,dc2016,from_publication))", every=False),
      in_branches("info(marriage(lo_16a,valid_form))", assume=["assumed_fact(reading(c8_elsewhere,dc2016,from_publication))"]),
      in_branches("info(marriage(lo_16b,invalid_form))", assume=["assumed_fact(reading(c8_elsewhere,dc2016,from_publication))"]),
      in_branches("info(marriage(lo_16a,valid_form))", assume=["assumed_fact(reading(c8_elsewhere,dc2016,from_acta))",
                                                              "assumed_fact(false(force_by(dc2016,20161001)))"]),
      in_branches("info(marriage(lo_16a,invalid_form))", assume=["assumed_fact(reading(c8_elsewhere,dc2016,from_acta))",
                                                                "assumed_fact(force_by(dc2016,20161001))"])],
     "invalid in every year: the Eastern party's own law asks a priest (CCEO c. 828) from 1991; c. 1108 §3's date "
     "a disputed reading, computed both ways for late 2016", mode=B)
scen("IM2", CC, "Two Eastern Catholics", IMP,
     [info_all("info(marriage(ee_d,invalid_form))", "info(marriage(ee_p,valid_form))", "info(marriage(ce_d,invalid_form))"),
      in_branches("info(marriage(ce_p,valid_form))", assume=["assumed_fact(common_error(ce_p))"]),
      in_branches("info(marriage(ce_p,invalid_form))", assume=["assumed_fact(false(common_error(ce_p)))"])],
     "before a deacon, invalid; before a priest who assists and blesses, valid (CCEO c. 828); common error supplies "
     "the faculty (c. 144), never the priesthood", mode=B)
scen("IM3", CC, "With an Orthodox party", IMP,
     [info_all("info(marriage(lo_15,valid_form))", "info(marriage(lo_18,invalid_form))", "info(marriage(eo_d,invalid_form))",
               "info(marriage(lo_15,form_for_liceity_only))", "info(marriage(eo_d,form_for_liceity_only))",
               "info(marriage(lo_op,valid_form))", "info(marriage(lo_od,valid_form))")],
     "the form for liceity only; a sacred minister in 2015, a priest from 2016 (c. 1127 §1); a priest always (CCEO c. 834 §2)", mode=B)
scen("CF1", CC, "Confirmation across the codes", ["eastern_chrismation"],
     [info_all("info(sacrament(chr_1,confirmation,valid))", "info(character_imprinted(inf_l,confirmation))",
               "info(sacrament(chr_2,confirmation,valid))", "info(sacrament(chr_3,confirmation,invalid(minister)))",
               "info(sacrament(chr_4,confirmation,valid))", "info(sacrament(chr_5,confirmation,invalid(minister)))"),
      shown(["eastern_chrismation", "cand_presbyter_ordinary"], ("violation/1",), "violation(presbyter_as_ordinary_minister(pr_l))"),
      shown(["eastern_chrismation"], ("eastern_faithful/1", "latin_faithful/1"), "eastern_faithful(inf_e)", "latin_faithful(inf_l)")],
     "an Eastern presbyter for a Latin infant (CCEO c. 696 §1); a Latin presbyter with the faculty (c. 882; c. 696 §2), "
     "without it invalid; the ordinary minister the bishop alone (DH 1630)", mode=B)
scen("WB1", CC, "Who a merely ecclesiastical law binds", ["who_is_bound"],
     [info_all("info(obliged(cath_w,l_eccl))", "info(obliged(pagan_w,l_div))", "info(obliged(orth_w,l_div))",
               "info(obliged(child_w,l_div))", "info(obliged(act_k6,l_div))"),
      info_all("info(obliged(act_pg,l_div))"),
      info_none("obliged(pagan_w,l_eccl)", "obliged(orth_w,l_eccl)", "obliged(child_w,l_eccl)", "obliged(act_k6,l_eccl)",
                "obliged(act_pg,l_eccl)")],
     "c. 11 read by the law library: the unbaptized, one baptized outside, one under seven now, and an act placed "
     "under seven are not bound; a divine law reaches them", mode=B)
# Found on a diocesan decree (20 October 2026): a law not yet in force was
# reported as obliging an act placed before its force began. binds_on/2 read
# the reading and the reach, never the date.
scen("WB3", CC, "A law binds the acts placed in its force (c. 9)", ["law_in_force"],
     [info_all("info(obliged(act_after,l_dated))", "info(obliged(act_old,b_old_f))", "info(obliged(act_any,l_undated))",
               "info(obliged(act_later,b_new_f))"),
      info_none("obliged(act_before,l_dated)", "obliged(act_late,b_old_f)", "obliged(act_early,b_new_f)")],
     "laws regard the future (c. 9): not an act placed before the law's force, or before the force of the law that "
     "enacts a text (cc. 7-8), nor one placed after its text is revoked (c. 20); a law with no date entered binds as "
     "before", mode=B)
# Found on a diocesan decree reserving a posture the Missal leaves to the
# celebrant (20 October 2026): Huels, Liturgy and Law (2006) 47, with RS 21.
scen("LW11", LW, "A lower law narrowing a choice a higher law leaves open (c. 135 §2; RS 21)", ["option_narrowed"],
     [info_all("does_not_bind(l_res)", "narrows_higher_choice(l_res,book_o,c135_2)",
               "narrows_higher_choice(l_res,book_o,rs21)", "obliged(church_a,l_fixed)", "obliged(mass_c,l_res_late)"),
      info_none("obliged(mass_a,l_res)", "does_not_bind(l_fixed)", "does_not_bind(l_res_late)",
                "narrows_higher_choice(l_res_late", "narrows_higher_choice(l_old"),
      shown(["option_narrowed"], ("frontier/2",), "frontier(canon,narrowing_without_ground(l_old))",
            absent=("frontier(canon,narrowing_without_ground(l_res))",))],
     "tested on its own day, on each ground then in force: a reservation of 2025 is contrary (c. 135 §2; RS 21) and "
     "stays so; requiring what the book commends is not; once the supreme authority withdraws the choice, the same "
     "reservation binds; before 1983 no ground is encoded", mode=B)
scen("LW12", LW, "Higher ius through a provision in force (c. 135 §2; cc. 33-34)", ["ius_superius"],
     [info_all("does_not_bind(l_dioc_h)", "against_higher_provision(l_dioc_h,p_ok)",
               "obliged(person_b,l_dioc_b)", "obliged(person_g,l_dioc_g)", "obliged(person_k,l_dioc_k)",
               "obliged(person_e,l_dioc_e)", "obliged(person_u,l_dioc_u)",
               "provision_without_force_on_the_day(l_dioc_b,p_bad)", "provision_without_force_on_the_day(l_dioc_g,p_g)",
               "provision_without_force_on_the_day(l_dioc_e,p_ok)"),
      info_none("obliged(person_h,l_dioc_h)", "does_not_bind(l_dioc_b)", "does_not_bind(l_dioc_g)",
                "does_not_bind(l_dioc_k)", "does_not_bind(l_dioc_e)", "does_not_bind(l_dioc_u)"),
      shown(["ius_superius"], ("frontier/2",), "frontier(canon,contrary_provision_undated(l_dioc_u))")],
     "a diocesan law against a dicastery's provision in force does not bind (Huels, StC 32 (1998) 360 n. 77); against "
     "a provision without force (c. 34 §2), one whose law has ceased (§3), the bishop's own, or one not yet in force "
     "when the law was given, it binds; with no day of promulgation it is not tested", mode=B)
# Predictions committed first: docs/research/calendar-preregistration.md.
# Found on a Saturday Feast before a Sunday of Advent (December 2026).
scen("LW14", LW, "The liturgical day, its evening, and the Sunday obligation (GNLY 3, 11, 59-61; cc. 1247-1248, 14)",
     ["liturgical_day"],
     [info_all("day_celebration(20261212,weekday_a)", "may_be_kept(20261212,memorial_m)",
               "day_celebration(20261214,memorial_o)", "omitted(20261214,memorial_p)", "omitted(20261214,weekday_c)",
               "may_be_kept(20261218,memorial_q)", "day_celebration(20270627,solemnity_q)", "omitted(20270627,sunday_o)",
               "begins_evening_before(sunday_a,20261212)", "begins_evening_before(solemnity_s,20261207)",
               "vespers_of(20261212,sunday_a)", "vespers_of(20261207,solemnity_s)", "vespers_of(20261129,sunday_c)",
               "vespers_of(20270626,solemnity_p)", "vespers_of(20261209,weekday_e)",
               "violation(vigil_mass_not_used(mass_v2,solemnity_s))",
               "meets_obligation(mass_x1,20261213)", "meets_obligation(mass_x2,20261213)", "meets_obligation(mass_x4,20261213)",
               "meets_obligation(mass_v1,20261208)", "meets_obligation(mass_v2,20261208)", "meets_obligation(mass_v3,20261208)",
               "meets_obligation(mass_n,20270101)", "meets_obligation(mass_w,20261101)",
               "declined_in_doubt_of_law(c1247,evening_from_two,mass_x2)",
               "satisfies_obligation(person_a,20261213,mass_x2)"),
      info_none("day_celebration(20261212,memorial_m)", "may_be_kept(20261214", "omitted(20261212", "omitted(20261218",
                "omitted(20270321,solemnity_t)", "begins_evening_before(feast_g", "vespers_of(20261209,feast_g)",
                "vespers_of(20270626,solemnity_q)", "vespers_of(20270627", "vigil_mass_not_used(mass_v1",
                "vigil_mass_not_used(mass_v3",
                "vigil_mass_not_used(mass_u1", "vigil_mass_not_used(mass_x1", "meets_obligation(mass_x3",
                "satisfies_obligation(person_b", "satisfies_obligation(person_c", "failed"),
      shown(["liturgical_day"], ("weekday/2", "day_before/2", "day_after/2"),
            "weekday(20261212,saturday)", "weekday(20261213,sunday)", "weekday(20240301,friday)", "weekday(20270101,friday)",
            "day_before(20240301,20240229)", "day_before(20270101,20261231)", "day_after(20261231,20270101)"),
      shown(["liturgical_day"], ("frontier/2",), "frontier(canon,impeded_solemnity(20270321,solemnity_t))"),
      # An authentic interpretation for two o'clock, in that matter, settles it the other way, and c. 14 is silent.
      shown(["liturgical_day"], ("info/1",), "info(meets_obligation(mass_x1,20261213))",
            absent=("info(meets_obligation(mass_x2,20261213))", "info(declined_in_doubt_of_law(c1247,evening_from_two,mass_x2))"),
            facts="applies_reading(int_x,c1247,evening_from_two). issuer(int_x,pope_y). authority(pope_y,4). "
                  "particular_matter(int_x,mass_x2)."),
      shown(["liturgical_day_proper"], ("info/1",), "info(day_celebration(20261212,memorial_m))",
            "info(omitted(20261212,weekday_a))", "info(vespers_of(20261212,sunday_a))",
            absent=("info(may_be_kept(20261212,memorial_m))", "info(day_celebration(20261212,weekday_a))"))],
     "the weekday is computed; the highest in the Table is the day's, an Optional Memorial kept only on a day of no. 9 "
     "or 13; a Sunday or a Solemnity begins the evening before, a Feast keeps its day, and the evening goes to the higher "
     "(at equal rank, the current day); a Solemnity's Vigil Mass is owed at an evening Mass when its evening it is; any "
     "Mass on the day or in the evening before meets the obligation, from noon in a doubt of law (c. 14); the "
     "same memorial is the day's on a proper calendar that makes it a Feast", mode=B)
scen("LK3", CC, "An Eastern marriage under divine law", IMP + ["eastern_bond"],
     [info_all("info(bond(ee_p))", "info(marriage(ee_v,invalid_consent))"),
      shown(IMP + ["eastern_bond"], ("eastern_faithful/1",), "eastern_faithful(e_9)", "eastern_faithful(e_10)"),
      info_any("violation(ratum_et_consummatum_dissolved(ds_e,ee_p))")],
     "indissoluble (c. 1141) and made by consent (c. 1057): divine law, binding though no Latin common canon does", mode=B)

# ---------- Documents as layers in time (TTC-SOURCES) -------------------------
# Predictions committed first: docs/research/sources-preregistration.md. A
# code at a date is a view; the general norms are the edges; an attribution
# is a claim. Scenario ids FW are the predictions' FQ (the FQ ids are taken).
SRC = "sources"
FT = ["forms_in_time"]
DIT = ["documents_in_time"]

def one_code_at_a_time(*partsets):
    """each marriage under one code's form, the code of its date: 1917 from 19 May 1918, 1983 from 27 November 1983"""
    def chk(_r):
        bad, n = [], 0
        for ps in partsets:
            atoms = solve(ps, "one", show=("form_code/2", "event_date/2"))["atoms"]
            dates = {E.split_args(a)[1][0]: int(E.split_args(a)[1][1]) for a in atoms if a.startswith("event_date(")}
            codes = {}
            for a in atoms:
                if a.startswith("form_code("):
                    m, c = E.split_args(a)[1]
                    codes.setdefault(m, []).append(c)
            for m, cs in codes.items():
                d = dates[m]
                want = "cic1983" if d >= 19831127 else "cic1917" if d >= 19180519 else None
                n += 1
                if cs != [want]:
                    bad.append((m, cs))
        return bool(n) and not bad, f"{n} marriages, one code each, the date's" if not bad else f"wrong: {bad}"
    return chk

def claim_never_shown(parts, text, author):
    """in every model where the attribution holds, it rests on an unshown claim; and some model holds it"""
    def chk(_r):
        ms = solve(parts, "all", show=("attributed/2", "unshown_claim/1"))["all_models"]
        att, un = f"attributed({text},{author})", f"unshown_claim(attribution({text},{author}))"
        hold = [m for m in ms if att in m]
        ok = bool(hold) and all(un in m for m in hold) and len(hold) < len(ms)
        return ok, f"{len(hold)} of {len(ms)} models hold it, each on an unshown claim" if ok else "not as stated"
    return chk

def tiers_by_form(*partsets):
    """a name never raises a tier: every source's tier is the same in every model, the Fides Damasi's aside"""
    def chk(_r):
        moved = set()
        for ps in partsets:
            ms = solve(ps, "all", show=("eff_tier/2",))["all_models"]
            tiers = {}
            for m in ms:
                for a in m:
                    if a.startswith("eff_tier("):
                        s, t = E.split_args(a)[1]
                        tiers.setdefault(s, set()).add(t)
            moved |= {s for s, ts in tiers.items() if len(ts) > 1}
        return moved == {"fides_damasi"}, f"tier moves with a name: {sorted(moved) or 'none'}"
    return chk

scen("TX1", SRC, "A deacon delegated, in 1950 and 1990", FT,
     [info_all("info(marriage(tx_d50,invalid_form))", "info(marriage(tx_d90,valid_form))",
               "info(marriage(tx_p50,valid_form))", "info(marriage(tx_u50,invalid_form))")],
     "1917 (c. 1094): only a priest is delegated; 1983 (cc. 1108 §1, 1111 §1): a deacon too", mode=B)
scen("TX2", SRC, "One who left the Church, at three dates", FT,
     [info_all("info(marriage(tx_l50,invalid_form))", "info(marriage(tx_l90,form_not_binding))",
               "info(marriage(tx_l11,invalid_form))")],
     "bound in 1950 (1917 c. 1099 §1, \"licet ... defecerint\"); not after a formal act in 1990 (c. 1117 as of 1983); bound in 2011", mode=B)
scen("TX3", SRC, "Born of non-Catholics, raised outside", FT,
     [info_all("info(marriage(tx_n48,form_not_binding))", "info(marriage(tx_n50,invalid_form))",
               "info(marriage(tx_r48,invalid_form))", "info(marriage(tx_q48,invalid_form))", "info(marriage(tx_s48,invalid_form))")],
     "not bound in 1948 (c. 1099 §2), bound from 1 January 1949 (Pius XII); each condition of the clause needed", mode=B)
scen("TX4", SRC, "A marriage of 1915", FT,
     [info_all("info(no_text_in_force(tx_15,form))"), info_none("info(marriage(tx_15,", "no_bond(tx_15)"),
      shown(FT, ("bond/1", "form_code/2", "at_issue/1"), "bond(tx_p50)", "at_issue(tx_15)",
            absent=("bond(tx_15)", "form_code(tx_15,cic1917)", "form_code(tx_15,cic1983)"))],
     "no encoded text governs its form: reported, never computed, its bond at issue and not computed", mode=B)
scen("TX5", SRC, "One code's form at a time", FT,
     [one_code_at_a_time(FT, ["interritual_marriages"], ["defection_2010", "on_0407"], ["marriage_cases"], ["marriages_c1117"], ["sspx", "hyp_delegation"])],
     "the 1917 form until 26 November 1983, the 1983 form from the 27th; never both")
# TTC-OFFICE: the pastor and the ordinary by office; two witnesses
_OF = "today(20261015). baptized_in((of_a;of_b),catholic). spouse(of_m,(of_a;of_b)). "
_PASTOR = "pastor_of(of_p,par_b). "
def _form(facts, *atoms, absent=()):
    return shown([], ("info/1",), *atoms, facts=_OF + facts, absent=absent)
scen("PO1", SRC, "The pastor and the ordinary by office, 1983 (c. 1109)", [],
     [_form(_PASTOR + "marriage(of_m,of_p,20190615). held_in(of_m,par_b).", "info(marriage(of_m,valid_form))"),
      _form(_PASTOR + "marriage(of_m,of_p,20190615). held_in(of_m,par_a).", "info(marriage(of_m,invalid_form))"),
      _form("ordinary_of(of_o,dio). within(par_a,dio). marriage(of_m,of_o,20190615). held_in(of_m,par_a).",
            "info(marriage(of_m,valid_form))"),
      _form("ordinary_of(of_o,dio). marriage(of_m,of_o,20190615). held_in(of_m,dio).", "info(marriage(of_m,valid_form))"),
      _form(_PASTOR + "marriage(of_m,of_p,20190615). held_in(of_m,par_b). decree(of_d,of_x,20180101). issuer(of_d,of_x). "
            "authority(of_x,1). declares(of_d,of_p,of_n). penalty(of_n,excommunication).",
            "info(marriage(of_m,invalid_form))")],
     "valid within his parish, or the ordinary's diocese or a parish within it, without delegation; not outside it; not once declared excommunicated")
scen("PO2", SRC, "The pastor by office, 1917 (c. 1095 §1 n. 2)", [],
     [_form(_PASTOR + "marriage(of_m,of_p,19500615). held_in(of_m,par_b).", "info(marriage(of_m,valid_form))"),
      _form(_PASTOR + "marriage(of_m,of_p,19500615). held_in(of_m,par_a).", "info(marriage(of_m,invalid_form))")],
     "within his territory only")
scen("PO3", SRC, "A pastor is a priest (c. 521 §1; c. 1108 §3)", [],
     [shown([], ("info/1",), "info(marriage(of_m,valid_form))",
            facts="today(20261015). baptized_in((of_a;of_b),catholic). ascribed(of_b,ukrainian). spouse(of_m,(of_a;of_b)). "
                  + _PASTOR + "marriage(of_m,of_p,20180615). held_in(of_m,par_b).")],
     "a Latin and an Eastern party before the Latin pastor, no priest/1 entered: valid")
scen("PO5", SRC, "The pastor delegates within his territory (c. 1111 §1; not predicted)", [],
     [_form(_PASTOR + "deacon(of_d). marriage(of_m,of_d,19900615). held_in(of_m,par_b). delegation(of_g,of_p,of_d,of_m,19900601).",
            "info(marriage(of_m,valid_form))"),
      _form(_PASTOR + "deacon(of_d). marriage(of_m,of_d,19900615). held_in(of_m,par_b). delegation(of_g,of_p,of_d,general,19900101).",
            "info(marriage(of_m,valid_form))"),
      _form(_PASTOR + "deacon(of_d). marriage(of_m,of_d,19900615). held_in(of_m,par_a). delegation(of_g,of_p,of_d,of_m,19900601).",
            "info(marriage(of_m,invalid_form))"),
      _form(_PASTOR + "deacon(of_d). marriage(of_m,of_d,19500615). held_in(of_m,par_b). delegation(of_g,of_p,of_d,of_m,19500601).",
            "info(marriage(of_m,invalid_form))")],
     "a deacon the pastor delegates, for a marriage or generally, in his parish: valid in 1990; outside his parish, or in 1950, not")
scen("PW1", SRC, "Two witnesses (c. 1108 §1; CIC 1917 c. 1094)", [],
     [_form(_PASTOR + "marriage(of_m,of_p,20190615). held_in(of_m,par_b). witnesses(of_m,1).",
            "info(marriage(of_m,few_witnesses))", "info(marriage(of_m,invalid_form))"),
      _form(_PASTOR + "marriage(of_m,of_p,19500615). held_in(of_m,par_b). witnesses(of_m,1).",
            "info(marriage(of_m,invalid_form))"),
      _form(_PASTOR + "marriage(of_m,of_p,20190615). held_in(of_m,par_b). witnesses(of_m,2).",
            "info(marriage(of_m,valid_form))", absent=("info(marriage(of_m,few_witnesses))",))],
     "one witness fails the form under either code; two keep it; silence is no defect (PO1)")
scen("PW2", SRC, "The form for liceity only is untouched by the witnesses", [],
     [shown([], ("info/1",), "info(marriage(of_m,valid_form))",
            facts="today(20261015). baptized_in(of_a,catholic). baptized_in(of_b,orthodox_church). spouse(of_m,(of_a;of_b)). "
                  "priest(of_q). marriage(of_m,of_q,20190615). witnesses(of_m,1).",
            absent=("info(marriage(of_m,few_witnesses))",))],
     "with an Eastern non-Catholic before a priest (c. 1127 §1)")
scen("GN1", SRC, "The Code of 1917 abrogated (c. 6 §1 n. 1)", DIT + ["today_20261010"],
     [shown(DIT, ("info/1",), "info(text_in_force(form_text_1917))", "info(text_revoked(c1099_2_clause_1917,pxii1948,expressly))",
            facts="today(19500101).", absent=("info(text_revoked(form_text_1917,code1983,expressly))",)),
      shown(DIT, ("info/1",), "info(text_revoked(form_text_1917,code1983,expressly))", facts="today(19900101).",
            absent=("info(text_in_force(form_text_1917))",))],
     "in force in 1950, Pius XII's clause struck; abrogated expressly from 27 November 1983")
scen("GN2", SRC, "c. 20 typed: three ways", ["today_20261010"],
     [shown(["today_20261010"], ("revokes/3",), "revokes(pgd2021,book6_1983,reorders)", "revokes(pgd2021,c1371_text_1998,reorders)",
            "revokes(atf1998,c1371_text_1983,expressly)", "revokes(oim2009,c1117_text_1983,expressly)",
            "revokes(pxii1948,c1099_2_clause_1917,expressly)", "revokes(code1983,form_text_1917,expressly)",
            "revokes(tc2021,sp_text,contrary)")],
     "each revocation by its way: expressly, directly contrary, completely reordering")
scen("GN4", SRC, "An instruction ceases with its law (c. 34 §3)", DIT + ["today_20261010"],
     [shown(DIT, ("info/1",), "info(act_in_force(ue2011))", "info(text_in_force(sp_text))", facts="today(20150101).",
            absent=("info(ceased_with_law(ue2011,sp2007))",)),
      shown(DIT, ("info/1",), "info(ceased_with_law(ue2011,sp2007))", "info(text_revoked(sp_text,tc2021,contrary))",
            facts="today(20220101).", absent=("info(act_in_force(ue2011))",)),
      shown(DIT, ("info/1",), "info(act_in_force(ue2011))", facts="today(20210715).", absent=("info(ceased_with_law(ue2011,sp2007))",)),
      shown(DIT, ("info/1",), "info(ceased_with_law(ue2011,sp2007))", facts="today(20210716).")],
     "Universae Ecclesiae in force in 2015; it ceases on 16 July 2021 with Summorum Pontificum, by c. 34 §3 alone")
scen("GN5", SRC, "Executive acts below the law (cc. 33-34)", ["executive_acts"],
     [lambda r: (all(i in r["info"] for i in ("act_in_force(instr_x)", "act_in_force(ged_x)", "provision_in_force(p_ok)",
                                            "provision_without_force(p_bad,l_exec)", "text_in_force(b_exec)",
                                            "ceased_with_law(ged_y,l_gone)"))
                 and "provision_in_force(p_bad)" not in r["info"] and "act_in_force(ged_y)" not in r["info"],
                 "the contrary provision without force, the law intact; the executory decree gone with its law")],
     "a provision contrary to a law lacks all force; an executory decree ceases with its law (c. 33 §2)")
scen("GN6", SRC, "A general decree by executive power (cc. 29-30)", ["executive_acts"],
     [has("general_decree_without_power(gd_void)", "general_decree_without_power(gd_void2)", "general_decree_without_power(gd_void3)"),
      none_of("general_decree_without_power(gd_grant)", "general_decree_without_power(gd_leg)"),
      lambda r: (all(i in r["info"] for i in ("text_of_void_decree(b_gd_void,gd_void)", "text_of_void_decree(b_gd_void2,gd_void2)",
                                            "text_of_void_decree(b_gd_void3,gd_void3)"))
                 and not any(i.startswith(("text_of_void_decree(b_gd_grant", "text_of_void_decree(b_gd_leg")) for i in r["info"]),
                 "the bodies of the void decrees reported"),
      lambda r: (all(i in r["info"] for i in ("text_in_force(b_gd_grant)", "text_in_force(b_gd_leg)"))
                 and not any(i.startswith(("text_in_force(b_gd_void", "text_revoked(b_gd_void")) for i in r["info"]),
                 "void without the grant, a law with it")],
     "without an express grant, void and without force; with it, a law in force by c. 8 §1")
scen("CO1", SRC, "A decretal ascribed to a second-century pope", ["collections_hyp"],
     [lambda r: (all(i in r["info"] for i in ("attribution_refused(dec_p,pope_ii,council_iv,witness_c)", "attribution_refused(dec_a,pope_ii,council_iv,witness_c)",
                                            "without_force_of_its_own(dec_p,coll_private)", "force_from_promulgation(dec_a,prom_auth)"))
                 and not any(i.startswith("force_rests_on_attribution") for i in r["info"]),
                 "private: no force of its own; authentic: force from promulgation, the attribution refused in both"),
      shown(["collections_hyp"], ("info/1",), "info(force_rests_on_attribution(dec_p,pope_ii))", facts="asof(1600). custom_asof.",
            absent=("info(without_force_of_its_own(dec_p,coll_private))",))],
     "the order refuses the attribution; in the private collection the text has no force of its own")
scen("AU1", SRC, "The Corpus Dionysiacum", ["pseudo_dionysius", "asof_1890"],
     [all_models_with(["pseudo_dionysius"], ("attributed/2", "info/1", "eff_tier/2"),
                      present=("info(attribution_refused(dionysius_corpus,dionysius_areopagite,proclus_dms,koch_1895))",
                               "info(attribution_refused(dionysius_corpus,dionysius_areopagite,proclus_dms,stiglmayr_1895))",
                               "info(attribution_claimed(dionysius_corpus,dionysius_areopagite,dionysius_corpus))",
                               "info(attribution_claimed(dionysius_corpus,dionysius_areopagite,cloud_of_unknowing))",
                               "eff_tier(dionysius_corpus,5)"),
                      absent=("attributed(dionysius_corpus,dionysius_areopagite)",)),
      all_models_with(["pseudo_dionysius", "asof_1890"], ("attributed/2", "info/1", "eff_tier/2"),
                      present=("eff_tier(dionysius_corpus,5)",), some=("attributed(dionysius_corpus,dionysius_areopagite)",),
                      absent=("info(attribution_refused(dionysius_corpus,dionysius_areopagite,proclus_dms,koch_1895))",)),
      claim_never_shown(["pseudo_dionysius", "asof_1890"], "dionysius_corpus", "dionysius_areopagite")],
     "both ways as of 1890, refused from 1895 (Koch, Stiglmayr: Proclus); tier 5 on every branch", mode="all")
scen("AU2", SRC, "The Liber de causis", ["de_causis", "asof_1260"],
     [all_models_with(["de_causis"], ("attributed/2", "info/1"), present=("info(attribution_refused(liber_de_causis,aristotle,proclus_et,thomas_de_causis))",),
                      absent=("attributed(liber_de_causis,aristotle)",)),
      claim_never_shown(["de_causis", "asof_1260"], "liber_de_causis", "aristotle")],
     "both ways as of 1260; refused from 1272 (Thomas: Proclus's Elements)", mode="all")
scen("AU3", SRC, "The Quicumque's name", ["creeds", "quicumque_author"],
     [all_models_with(["creeds", "quicumque_author"], ("attributed/2", "info/1", "eff_tier/2"),
                      present=("info(attribution_refused(quicumque,athanasius,augustine_dt15,kelly_1964))", "eff_tier(quicumque,1)",
                               "info(attribution_by_act(quicumque,athanasius,florence_armenians_1439))"),
                      absent=("attributed(quicumque,athanasius)",)),
      lambda r: (solve(["creeds"], "branches")["models"] == r["models"] == 4, "the reception's branches alone"),
      claim_never_shown(["creeds", "quicumque_author", "asof_1950"], "quicumque", "athanasius")],
     "refused from 1964 (Kelly: Augustine's terms); its tier rests on reception; Florence's words a claim that fixes nothing", mode="all")
scen("AU4", SRC, "The pseudo-Lullian Testamentum", ["pseudo_lull"],
     [all_models_with(["pseudo_lull"], ("attributed/2", "info/1", "violation/1"),
                      present=("info(attribution_refused(testamentum,llull,self_dated(1332)))",),
                      absent=("attributed(testamentum,llull)", "violation(signed_and_anonymous(ars_brevis))")),
      shown(["pseudo_lull"], ("violation/1",), "violation(signed_and_anonymous(ars_brevis))", facts="anonymous(ars_brevis).")],
     "dated 1332 by its colophon, Llull dead in 1316: refused; the Ars brevis signed, not at issue", mode="all")
scen("AU5", SRC, "The Imitation of Christ", ["imitatio"],
     [branches_n(3),
      all_models_with(["imitatio"], ("attributed/2", "info/1"),
                      some=("attributed(imitatio,thomas_a_kempis)", "attributed(imitatio,gerson)", "info(without_a_name(imitatio))")),
      claim_never_shown(["imitatio"], "imitatio", "thomas_a_kempis"), claim_never_shown(["imitatio"], "imitatio", "gerson"),
      all_models_with(["imitatio", "attribution_shown_hyp"], ("attributed/2", "unshown_claim/1", "info/1"),
                      present=("attributed(imitatio,thomas_a_kempis)",),
                      absent=("attributed(imitatio,gerson)", "unshown_claim(attribution(imitatio,thomas_a_kempis))",
                              "info(without_a_name(imitatio))")),
      lambda r: (solve(["imitatio", "attribution_shown_hyp"], "all")["models"] == 1, "shown: one branch")],
     "at most one author; three branches, the preferred neither", mode="all")
scen("AU6", SRC, "The Cloud of Unknowing", ["cloud", "pseudo_dionysius", "asof_1890"],
     [all_models_with(["cloud", "pseudo_dionysius", "asof_1890"], ("info/1", "violation/1"), present=("info(without_a_name(cloud_of_unknowing))",),
                      absent=("violation(",)),
      shown(["cloud", "cand_author_filled"], ("violation/1",), "violation(author_without_claim(cloud_of_unknowing,author_x))")],
     "anonymous, shown as such on both of the Corpus's branches; an author entered without a claim refused", mode="all")
scen("AU8", SRC, "A name never raises a tier", ["fides_damasi"],
     [tiers_by_form(["trinity", "filioque", "fides_damasi"], ["pseudo_dionysius", "asof_1890"], ["creeds", "quicumque_author", "asof_1950"],
                    ["imitatio"], ["de_causis", "asof_1260"])],
     "every source keeps its tier on every branch; the Fides Damasi changes form with its claimed author, a pope", mode="all")
scen("FW1", SRC, "The monarchy as of 1100", ["trinity", "filioque", "creeds", "asof_1100"],
     [cls("q(monarchy)=father_principle_without_principle", "open"), prefers("q(monarchy)", "father_principle_without_principle"),
      lambda r: (all(b["w"] == ({3: 2, 4: 0, 5: 3} if "q(monarchy)=denied" in b["values"] else {3: 0, 4: 0, 5: 1})
                     for b in r["branches"] if b["status"] == "main"),
                 "against the monarchy denied: Toledo XI at tier 3 (2), Augustine and Photius at tier 5 (with Photius on the Filioque, 3)")],
     "open, the Father principle without principle preferred by Augustine's, Photius's and Toledo XI's weight", mode=B)
scen("FW2", SRC, "Particular councils weigh and do not cleave (c. 753)", ["trinity", "filioque", "councils_relaxed"],
     [lambda r: (all(not any(c.startswith("toledo") for c in b["cleaved"]) for b in r["branches"]), "no Toledan council cleaves"),
      reint_includes("q(spirit_origin)=father_alone", "leo_i_447"),
      lambda r: (all(b["w"][3] >= 4 for b in r["branches"] if "q(spirit_origin)=father_alone" in b["values"]),
                 "Toledo III and XI weigh at tier 3 against the Father alone")],
     "Toledo III and XI weigh at tier 3; only Leo I's letter cleaves", mode=B)
scen("FW3", SRC, "As of 440, the Fides Damasi", ["trinity", "filioque", "fides_damasi", "asof_440"],
     [cls("q(spirit_origin)=father_alone", "open"), prefers("q(spirit_origin)", "father_and_son"),
      lambda r: (all("assumed_fact(attributed(fides_damasi,damasus))" in b["assume"]
                     for b in r["branches"] if "q(spirit_origin)=father_alone" in b["values"] and b["status"] == "live_shadow")
                 and any(b["status"] == "live_shadow" for b in r["branches"]),
                 "a shadow only where the attribution to Damasus holds"),
      lambda r: (all("assumed_fact(false(attributed(fides_damasi,damasus)))" in b["assume"]
                     for b in r["branches"] if b["status"] == "main" and b["unshown"] == 0), "the preferred rest on no attribution"),
      lambda r: (all(any("without_a_name(fides_damasi)" in f for f in b["facts"]) ==
                     ("assumed_fact(false(attributed(fides_damasi,damasus)))" in b["assume"]) for b in r["branches"]),
                 "without a name exactly where Damasus is not its author"),
      lambda r: (all(("papal_form(fides_damasi,ordinary)" in m and "character(fides_damasi,letter)" in m) ==
                     ("attributed(fides_damasi,damasus)" in m)
                     for m in solve(["trinity", "filioque", "fides_damasi", "asof_440"], "all",
                                    show=("papal_form/2", "character/2", "attributed/2"))["all_models"]),
                 "a pope's letter in form only on the branch of the claim")],
     "open on the preferred branches; a live shadow only on the branch of the claimed Damasus, never preferred", mode=B)

# ---------- The liturgy: witness, rite, development (TTC-LITURGY) -------------
# Predictions committed first: docs/research/liturgy-preregistration.md. The
# predictions' LW are scenarios LO (the LW ids are the law group's).
LIT = "liturgy"
LOI = ["ic", "lex_orandi_ic", "asof_1500"]
LOC = ["trinity", "filioque", "lex_orandi_creed"]

def preferred_without(parts, assume_sub):
    """every preferred main branch (c. 749 §3, then weight) is free of assumptions containing assume_sub"""
    def chk(_r):
        mains = [b for b in solve(parts, "branches")["branches"] if b["status"] == "main"]
        best = min(pref_key(b) for b in mains)
        top = [b for b in mains if pref_key(b) == best]
        ok = bool(top) and not any(assume_sub in a for b in top for a in b["assume"])
        return ok, f"preferred branches rest on no {assume_sub}" if ok else "a preferred branch rests on it"
    return chk

scen("LO1", LIT, "One book, two sources: the feast of the Conception", LOI,
     [info_none("governance_read_as_teaching"),
      lambda r: (all(b["w"][3] == 2 for b in r["branches"] if "q(ic)=no" in b["values"])
                 and not any("office_conception" in b["cleaved"] for b in r["branches"]),
                 "the prayer weighs at tier 3 against \"no\" and cleaves nothing"),
      cls("q(feast_of_the_conception)=encouraged", "settled"), info_all("measure(office_conception,1,1480,all)")],
     "the bull answers a governance question; the prayer weighs on the doctrinal one", mode=B)
scen("LO2", LIT, "The Immaculate Conception as of 1500, with the prayer", LOI,
     [cls("q(ic)=yes", "open"), prefers("q(ic)", "yes"),
      lambda r: (preferred_value(solve(["ic", "asof_1500"], "branches"), "q(ic)") == "no", "without the prayer: \"no\"")],
     "open, \"yes\" preferred by the prayer's weight where \"no\" was", mode=B)
scen("LO3", LIT, "Rome's creed: the text sung and the prayer", LOC + ["asof_1100"],
     [cls("q(creed_text_rome)=with_filioque", "settled"), cls("q(spirit_origin)=father_alone", "shadow"),
      lambda r: (all(b["reint"] == ["leo_i_447"] or "benedict_viii_1014" in b["reint"]
                     for b in r["branches"] if "q(spirit_origin)=father_alone" in b["values"])
                 and all("creed_rome_1014" not in b["cleaved"] for b in r["branches"])
                 and {b["w"][3] for b in r["branches"] if "q(spirit_origin)=father_alone" in b["values"]} ==
                     {b["w"][3] + 2 for b in solve(["trinity", "filioque", "asof_1100"], "branches")["branches"]
                      if "q(spirit_origin)=father_alone" in b["values"]},
                 "a shadow of Leo I's letter alone; the creed weighs at tier 3 (2 points)"),
      lambda r: (classify(solve(LOC + ["asof_900"], "branches"), "q(creed_text_rome)=without_filioque") == "settled",
                 "as of 900: without"),
      info_none("governance_read_as_teaching"), info_all("measure(creed_rome_1014,1,1014,all)")],
     "\"without\" as of 900, \"with\" as of 1100: governance; the creed prayed weighs", mode=B)
scen("LO4", LIT, "A liturgy treated as fixing a doctrine", LOI + ["cand_lex_orandi_fixes"],
     [any_branch_violation("lex_orandi_as_fixing(office_conception,q(ic))")], "refused (Mediator Dei 48)", mode=B)
scen("LO5", LIT, "Nothing owed to a prayer as such", ["ic", "lex_orandi_ic", "assent"],
     [info_none("owed(office_conception"), info_any("owed(sollicitudo_1661,religious_submission)")],
     "religious submission owed to a pope's teaching, not to a prayer", mode=B)
scen("LO7", LIT, "The Indiculus: the axiom's source", ["indiculus"],
     [branches_n(3), info_any("attribution_by_act(indiculus,prosper,ccc_1124)"),
      claim_never_shown(["indiculus"], "indiculus", "celestine_i"), claim_never_shown(["indiculus"], "indiculus", "prosper")],
     "Celestine I or Prosper, at most one; the preferred neither; the Catechism's word a claim", mode=B)
scen("LO8", LIT, "A claim of the ordinary universal magisterium from a universal feast", ["ic", "liturgy_oum_hyp", "asof_1850"],
     [shown(["ic", "liturgy_oum_hyp", "asof_1850"], ("condition_shown/2",), "condition_shown(claim_1849,dispersed_in_communion)",
            "condition_shown(claim_1849,authentic_teaching)", "condition_shown(claim_1849,faith_or_morals)",
            absent=("condition_shown(claim_1849,one_position_definitive)",)),
      lambda r: (all(b["unshown"] >= 1 for b in r["branches"] if "oum_holds(claim_1849)" in b["assume"])
                 and any("oum_holds(claim_1849)" in b["assume"] for b in r["branches"]), "resting on it: unshown"),
      preferred_without(["ic", "liturgy_oum_hyp", "asof_1850"], "oum_holds(claim_1849)")],
     "three of LG 25's conditions shown by the liturgy, never the fourth: never preferred", mode=B)
scen("LO9", LIT, "Vincent's measure, never a verdict", ["liturgy_change_hyp", "today_20261010"],
     [lambda r: (all(i in r["info"] for i in ("measure(element_x,3,800,all)", "years_in_use(element_x,1226)",
                                            "change_to_long_use(chg_x,element_x,3,800)", "measure(element_y,1,1975,some)",
                                            "years_in_use(element_y,51)"))
                 and not r["violations"] and not any(i.startswith("change_to_long_use(chg_x,element_y") for i in r["info"]),
                 "measured and reported; the change stands")],
     "everywhere, always, by all: counted, reported, never a verdict")
scen("LO10", LIT, "An element binding because it is loved", ["cand_binding_by_love"],
     [has("binding_by_love(chant_x)")], "refused: love gives no authority")
scen("RS1", LIT, "A liturgical book changes a sacrament's condition", ["sacrament_conditions", "liturgical_books_hyp"],
     [any_branch_violation("change_to_substance(book_x,baptism,matter)"), info_all("change_stands(book_y,matrimony,canonical_form)"),
      lambda r: (not any("change_to_substance(book_y" in f for b in r["branches"] for f in b["facts"]), "the form of marriage: the Church's")],
     "the water of baptism kept, whatever the authority; the canonical form the Church's to change", mode=B)
scen("RS2", LIT, "The matter of orders in time", ["orders_in_time"],
     [branches_n(2),
      all_models_with(["orders_in_time"], ("info/1",),
                      present=("info(sacrament(ord_50,orders(presbyterate),valid))", "info(sacrament(ord_00p,orders(presbyterate),valid))",
                               "info(doubt_referred_to_apostolic_see(ord_00))", "info(to_be_conferred(cand_00,orders(presbyterate),conditionally))"),
                      some=("info(sacrament(ord_00,orders(presbyterate),valid))", "info(sacrament(ord_00,orders(presbyterate),invalid(porrection)))"),
                      absent=("info(doubt_referred_to_apostolic_see(ord_50))", "info(doubt_referred_to_apostolic_see(ord_00p))")),
      all_models_with(["orders_in_time"], ("assumed_fact/1",),
                      some=("assumed_fact(porrection_required(ord_00))", "assumed_fact(false(porrection_required(ord_00)))"))],
     "1950 valid; 1900 without the porrection both ways, the doubt referred, to be conferred conditionally", mode="all")
scen("RS3", LIT, "c. 846 §1: a changed form, a changed prayer", ["we_baptize", "rite_changes"],
     [in_branches("sacrament(bap_we,baptism,invalid(form))", "main"), info_all("illicit_change(pr_w,bap_we)", "illicit_change(pr_w,bap_alt)",
                                                                                 "sacrament(bap_alt,baptism,valid)")],
     "\"We baptize\": invalid and illicit; a changed prayer: valid and illicit", mode=B)
scen("RD1", LIT, "The Roman Missal in an order, not a line", ["roman_missal"],
     [lambda r: ([i for i in r["info"] if i.startswith("rite_of_many_parents")] == ["rite_of_many_parents(missal_1970)"]
                 and not r["violations"], "the Missal of 1970 with two parents; no refusal"),
      shown(["roman_missal"], ("year_of/2",), "year_of(sacramentarium_gelasianum,750)", "year_of(missal_1970,1970)")],
     "1570, 1962, 1970 (and the ancient sacramentaries), 2002")
scen("RD2", LIT, "A rite from a later one, a rite from itself", ["roman_missal", "cand_rite_from_later"],
     [has("rite_from_later(missal_1962,missal_2002)", "rite_descends_from_itself(missal_1962)"),
      shown(["cand_rite_cycle"], ("violation/1",), "violation(rite_descends_from_itself(rite_p))",
            absent=("violation(rite_from_later(rite_p,rite_q))",))],
     "refused by the order")
scen("RD3", LIT, "The reform read as continuity or rupture", ["liturgy", "reform_1970"],
     [cls("q(reform_1970)=rupture", "shadow"), reint_includes("q(reform_1970)=rupture", "bxvi_letter"),
      info_none("governance_read_as_teaching(tc2021,q(reform_1970))")],
     "continuity main; rupture a live shadow of Benedict XVI's letter; Traditionis custodes answers nothing on it", mode=B)

# ---------- The last things (TTC-NOVISSIMA) ---------------------------------
# Predictions committed first: docs/research/novissima-preregistration.md.
NOV = "novissima"
NVO = ["novissima_order"]
NVT = NVO + ["novissima_theories"]
ORDER_TODAY = [f"order_given({a},{b},{s})" for a, b, s in (
    ("dying", "vision", "benedictus_deus_1336"), ("dying", "purification", "benedictus_deus_1336"),
    ("purification", "vision", "benedictus_deus_1336"), ("dying", "hell", "benedictus_deus_1336"),
    ("vision", "rising", "benedictus_deus_1336"), ("rising", "judgment", "benedictus_deus_1336"),
    ("return", "rising", "lateran_iv_1215"), ("rising", "judgment", "lateran_iv_1215"),
    ("dying", "purification", "florence_1439"), ("purification", "vision", "florence_1439"),
    ("dying", "vision", "florence_1439"), ("dying", "hell", "florence_1439"))]

def order_from_tier1(r):
    srcs = {i.rsplit(",", 1)[1].rstrip(")") for i in r["info"] if i.startswith("order_given(")}
    srcs |= {i.rsplit(",", 1)[1].rstrip(")") for i in r["info"] if i.startswith("without_end(")}
    ok = srcs == {"benedictus_deus_1336", "lateran_iv_1215", "florence_1439"}
    return ok, f"sources of the order: {', '.join(sorted(srcs))}"

def viol_at(parts, present=(), absent=()):
    """with these parts (an asof among them), these violations hold and these do not"""
    def chk(_r):
        v = solve(parts, "one")["violations"]
        bad = [x for x in present if x not in v] + [x for x in absent if x in v]
        return not bad, "as stated" if not bad else f"wrong: {bad}"
    return chk

def classified(parts, *pairs):
    """classify each question=value as stated, with these parts"""
    def chk(_r):
        r = solve(parts, "branches")
        got = [(qv, classify(r, qv)) for qv, _ in pairs]
        return got == list(pairs), ", ".join(f"{qv}: {c}" for qv, c in got)
    return chk

scen("NV1", NOV, "The order after death, given", NVO,
     [clean, lambda r: (all(o in r["info"] for o in ORDER_TODAY) and all(w in r["info"] for w in (
          "without_end(hell,lateran_iv_1215)", "without_end(vision,lateran_iv_1215)", "without_end(vision,benedictus_deus_1336)")),
          "each edge with its source"), order_from_tier1],
     "dying before the vision, purification and hell; purification before the vision; the vision before rising; "
     "the return before rising; rising before the judgment; the vision and hell without end: tier 1 only")
scen("NV2", NOV, "Theories placed on the order", NVT,
     [none_of("stage_unknown"), has("order_against_definition(cycles_t,vision,purification)", "end_of_the_endless(cycles_t,vision)"),
      viol_at(NVT + ["cand_stage_unknown"], present=("stage_unknown(t_unknown,nirvana)", "stage_unknown(t_unknown,limbus)")),
      has("order_against_definition(sleep_t,rising,vision)", "order_against_definition(rising_at_death_t,rising,return)",
          "order_against_definition(total_death_t,rising,vision)", "soul_not_subsisting(total_death_t)",
          "order_against_definition(vision_unpurified_t,vision,purification)"),
      viol_at(NVT + ["asof_1300"], present=("order_against_definition(rising_at_death_t,rising,return)",),
              absent=("order_against_definition(sleep_t,rising,vision)", "order_against_definition(total_death_t,rising,vision)",
                      "soul_not_subsisting(total_death_t)", "order_against_definition(vision_unpurified_t,vision,purification)")),
      viol_at(NVT + ["asof_1200"], absent=("order_against_definition(rising_at_death_t,rising,return)",)),
      viol_at(NVT + ["asof_1500"], present=("order_against_definition(total_death_t,rising,vision)",),
              absent=("soul_not_subsisting(total_death_t)",))],
     "sleep from 1336; rising at death from 1215; total death from 1336 on the order and 1513 by Lateran V; "
     "the vision before purification from 1336")
scen("NV3", NOV, "One soul, one body", NVO + ["one_body"],
     [has("soul_in_two_bodies(person_r)"), none_of("soul_in_two_bodies(person_l)"),
      lambda r: ("raised_to_own_body(person_l)" in r["info"], "the raising reported, nothing refused")],
     "reincarnation refused (DH 801, 1440; CCC 1013); a raising to the same body not")
scen("NV4", NOV, "The end arriving early", CREED + ["marian"] + NVO + ["cand_rising_early"],
     [info_all("end_early(mary)", "end_early(son)", "violation(rising_before_the_return(person_e))"),
      info_none("end_past"),
      lambda r: (not any("rising_before_the_return" in f for b in solve(CREED + ["marian"] + NVO + ["cand_rising_early", "asof_1200"],
                                                                             "branches")["branches"] for f in b["facts"]),
                 "as of 1200: not refused")],
     "Mary's Assumption and Christ's resurrection the end early; another's rising before the return refused from 1215", mode=B)
scen("NV5", NOV, "The end of punishment", ["creeds", "punishment_ends", "asof_1000"],
     [cls("q(punishment_ends)=yes", "open"), prefers("q(punishment_ends)", "no"),
      lambda r: (not any("q(punishment_ends)=yes" in b["values"] and "assumed_fact(received(quicumque))" in b["assume"]
                         for b in r["branches"]) and not any("synod_543" in b["cleaved"] for b in r["branches"]),
                 "never where the Quicumque is received; the synod cleaves nothing"),
      classified(["creeds", "punishment_ends", "asof_1300"], ("q(punishment_ends)=yes", "excluded")),
      viol_at(NVT, present=("end_of_the_endless(restoration_t,hell)",)),
      viol_at(NVT + ["asof_1000"], absent=("end_of_the_endless(restoration_t,hell)",))],
     "as of 1000 open, \"no\" preferred by the synod of 543's weight; from 1215 \"yes\" on no branch; "
     "the restoration of all refused from 1215", mode=B)
scen("JX1", NOV, "The vision deferred, as of 1332", ["vision_deferred", "asof_1332"],
     [cls("q(vision_before_rising)=no", "settled"), reint_includes("q(vision_before_rising)=yes", "john_xxii_sermons"),
      lambda r: (all(b["w"][5] == 1 for b in r["branches"] if "q(vision_before_rising)=no" in b["values"]), "Thomas weighs at tier 5")],
     "the deferral main; the vision before the rising a live shadow of John XXII's sermons", mode=B)
scen("JX2", NOV, "The vision deferred, as of 1335", ["vision_deferred", "asof_1335"],
     [cls("q(vision_before_rising)=yes", "settled"), reint_includes("q(vision_before_rising)=no", "ne_super_his_1334"),
      lambda r: (not any("john_xxii_sermons" in b["reint"] + b["cleaved"] for b in r["branches"]), "the sermons withdrawn")],
     "the sermons withdrawn; the deferral a live shadow of Ne super his", mode=B)
scen("JX3", NOV, "The vision deferred, from 1336", ["vision_deferred", "asof_1337"],
     [cls("q(vision_before_rising)=no", "excluded"), clean_branches, info_none("condition_unshown(benedictus_deus_1336"),
      classified(["vision_deferred", "asof_1440"], ("q(vision_before_rising)=yes", "settled"), ("q(vision_before_rising)=no", "excluded")),
      classified(["vision_deferred", "asof_1440", "benedictus_deus_relaxed"], ("q(vision_before_rising)=no", "excluded")),
      classified(["vision_deferred", "asof_1337", "benedictus_deus_relaxed"], ("q(vision_before_rising)=no", "shadow")),
      viol_at(NVT + ["asof_1335"], absent=("order_against_definition(deferral_t,judgment,vision)",)),
      viol_at(NVT + ["asof_1337"], present=("order_against_definition(deferral_t,judgment,vision)",))],
     "on no branch (Benedictus Deus, tier 1, warranted by its words); Florence the same; the theory refused from 1336", mode=B)
scen("DU1", NOV, "A calendar laid on what follows death", ["after_death_measured"],
     [has("after_death_measured(purification,300,days)", "after_death_measured(vision,1000,years)",
          "after_death_measured(hell,7,days)", "end_dated(rising)")],
     "refused (Spe salvi 47); a year on the rising refused as the return's")
scen("DU2", NOV, "The former days of indulgences", ["indulgence_grants"],
     [clean, lambda r: ("days_of_canonical_penance(g_1950,300)" in r["info"], "a measure of canonical penance"),
      viol_at(["indulgence_grants", "cand_days_in_purgatory"], present=("after_death_measured(purification,300,days)",))],
     "the days a measure of canonical penance; read as days in purgatory, refused")
scen("DU3", NOV, "Indulgentiarum doctrina in the canon layer", ["indulgence_grants", "asof_1968"],
     [lambda r: ("indulgence_in_force(g_1950)" in r["info"] and "designated_in_days_against_norm_4(g_1970)" in r["info"]
                 and "designated_in_days_against_norm_4(g_1950)" not in r["info"], "1950 in force; 1970 against norm 4"),
      shown(["indulgence_grants", "asof_1970"], ("info/1",), "info(indulgence_null(g_1950))",
            absent=("info(indulgence_in_force(g_1950))",)), none_of("after_death_measured")],
     "the grant of 1950 in force as of 1968, null as of 1970; a grant in days in 1970 against norm 4")
scen("DU4", NOV, "Thomas's measures for a soul after death", ["separated_souls"],
     [clean, shown(["separated_souls"], ("measure/2",), "measure(soul_s,aevum)", "measure(soul_b,share_of_eternity)",
                   absent=("measure(soul_s,time)", "measure(soul_s,eternity)")),
      lambda r: ("share_in_eternity(soul_b)" in r["info"], "the vision a share in eternity"),
      viol_at(["separated_souls", "cand_blessed_eternal"], present=("eternal_with_beginning(soul_b)",))],
     "the aevum for its being, a share in eternity for the vision; eternity itself refused (DH 800)")
scen("NS1", NOV, "No one placed in a state after death", ["canonization_hyp", "placed_after_death"],
     [info_all("violation(state_after_death_placed(person_h,hell))", "violation(state_after_death_placed(person_p,purification))",
               "violation(state_after_death_placed(person_g,glory))", "in_glory_by_the_act(saint_x,canonization_x)"),
      info_none("state_after_death_placed(saint_x")],
     "hell, purification, glory without an act: refused (rule 3; CCC 1861); glory by a canonization: the act's", mode=B)
scen("NS2", NOV, "A canonization's tier from its formula", ["canonization_hyp"],
     [info_none("tier_without_warrant", "tier_inconsistent_with_form", "condition_unshown"),
      info_all("lower_speaks_of_higher(cdf_1998_commentary,canonization_x,2)"),
      cls("q(in_glory(saint_x))=yes", "settled"), cls("q(in_glory(saint_x))=no", "shadow")],
     "tier 2 by its form; the commentary a lower tier speaking of a higher; \"not in glory\" never main", mode=B)
scen("NS3", NOV, "A beatification read as teaching", ["canonization_hyp", "beatification_hyp"],
     [info_all("violation(governance_read_as_teaching(beatification_x,q(in_glory(saint_x))))")],
     "a permission of cult: governance", mode=B)
scen("NS4", NOV, "Hell's eternity settled, no one placed", ["creeds", "punishment_ends"],
     [cls("q(punishment_ends)=no", "settled"), info_none("state_after_death_placed")],
     "settled at tier 1; no rule derives a person's state after death (and a test)", mode=B)
scen("WL1", NOV, "Nothing of this world carried over", CREED + ["marian", "cand_nothing_carried_over"],
     [info_all("violation(glorified_annihilated(son))", "violation(glorified_annihilated(mary))")],
     "refused for Christ's flesh and Mary's body", mode=B)
scen("WL2", NOV, "The world at the end", ["world_at_the_end"],
     [lambda r: ([b["values"] for b in r["branches"] if "read_as(rom8_19,sensible_creation)" in b["assume"]] ==
                 [["q(world_at_the_end)=transformed"]], "the sensible creation: transformed alone"),
      lambda r: (all(b["status"] == "live_shadow" and sorted(b["reint"]) == ["ccc_1047", "gs39"] for b in r["branches"]
                     if any(v in b["values"] for v in ("q(world_at_the_end)=annihilated", "q(world_at_the_end)=unchanged")))
                 and {v for b in r["branches"] if "read_as(rom8_19,human_creature)" in b["assume"] for v in b["values"]} ==
                     {"q(world_at_the_end)=transformed", "q(world_at_the_end)=annihilated", "q(world_at_the_end)=unchanged"},
                 "the human creature: annihilated and unchanged live shadows of GS 39 and CCC 1047"),
      cls("q(world_at_the_end)=annihilated", "shadow"),
      lambda r: (all(b["w"][5] == 2 for b in r["branches"] if "q(world_at_the_end)=transformed" in b["values"])
                 and all(b["w"][4] == 1 for b in r["branches"] if "q(world_at_the_end)=transformed" not in b["values"]),
                 "Gerhard and Quenstedt weigh at tier 5, Thomas at tier 4")],
     "transformed; annihilation never main", mode=B)
scen("WL3", NOV, "Plants and animals", ["plants_and_animals", "asof_2014"],
     [cls("q(plants_and_animals_remain)=yes", "open"), cls("q(plants_and_animals_remain)=no", "open"),
      prefers("q(plants_and_animals_remain)", "no"),
      lambda r: (all(b["status"] == "live_shadow" and b["reint"] == ["laudato_si_2015"] for b in solve(["plants_and_animals"], "branches")["branches"]
                     if "q(plants_and_animals_remain)=no" in b["values"]), "from 2015: \"no\" a live shadow of Laudato si'")],
     "as of 2014 \"no\" preferred by Thomas; from 2015 a live shadow of Laudato si'", mode=B)
scen("WL4", NOV, "What charity carries", ["lasts_by_charity", "cand_binding_by_love"],
     [all_models_with(["lasts_by_charity", "cand_binding_by_love"], ("assumed_fact/1", "violation/1", "info/1"),
                      present=("violation(binding_by_love(chant_x))",),
                      some=("assumed_fact(carried(chant_x))", "assumed_fact(false(carried(chant_x)))",
                            "info(carried_on_the_claim(chant_x))"))],
     "a claim computed both ways, never derived; binding by love still refused", mode=B)
scen("OS1", NOV, "One sacrifice in many times", CREED + ["one_sacrifice"],
     [clean, lambda r: (all(i in r["info"] for i in ("one_sacrifice(mass_m)", "one_sacrifice(last_supper)")), "joined to the one passion"),
      shown(CREED + ["one_sacrifice"], ("before/2",), "before(last_supper,passion)", absent=("before(passion,last_supper)",))],
     "the Mass and the Last Supper joined to the passion; no second passion")
scen("OS2", NOV, "A second immolation, a bare commemoration", CREED + ["one_sacrifice", "cand_second_immolation", "cand_bare_commemoration"],
     [has("second_immolation(mass_m)", "bare_commemoration(mass_m)"),
      viol_at(CREED + ["one_sacrifice", "cand_second_immolation", "cand_bare_commemoration", "asof_1500"],
              absent=("second_immolation(mass_m)", "bare_commemoration(mass_m)"))],
     "refused from 1562 (Trent, sess. XXII, cann. 3-4)")

# ---------- The empirical kind; how many human beings (TTC-EMPIRICA) ------------
# Predictions committed first: docs/research/empirica-preregistration.md.
EMP = "empirica"
GAL = ["galileo"]

def facts_on(parts, sub):
    """the branches of these parts, split by whether sub is among their assumptions"""
    bs = solve(parts, "branches")["branches"]
    return [b for b in bs if any(sub in a for a in b["assume"])], [b for b in bs if not any(sub in a for a in b["assume"])]

scen("EM1", EMP, "An act at tier 1 on an empirical question", ["empirical_kind_hyp"],
     [cls("q(x_fact)=a", "open"), cls("q(x_fact)=b", "open"), prefers("q(x_fact)", "tie"),
      lambda r: (all(b["status"] == "main" and not b["cleaved"] and b["w"] == {3: 0, 4: 0, 5: 0} for b in r["branches"]),
                 "nothing cleaves, no weight"),
      info_all("violation(act_answers_a_fact(def_e,q(x_fact)))", "violation(act_answers_a_fact(dec_e,q(x_fact)))"),
      info_none("against_tier1"),
      shown(["cand_consent_unclaimed"], ("info/1",), "info(consent_outside_faith_and_morals(text_u,unclaimed))")],
     "both branches stand, nothing cleaves; the acts at tiers 1 and 3 refused", mode=B)
scen("EM2", EMP, "A finding fixes the question from its year", ["empirical_kind_hyp", "findings_hyp"],
     [cls("q(x_fact)=b", "settled"), cls("q(x_fact)=a", "excluded"),
      classified(["empirical_kind_hyp", "findings_hyp", "asof_1925"], ("q(x_fact)=a", "settled"), ("q(x_fact)=b", "excluded")),
      classified(["empirical_kind_hyp", "findings_hyp", "asof_1850"], ("q(x_fact)=a", "open"), ("q(x_fact)=b", "open"))],
     "not before its year; a later finding supersedes an earlier", mode=B)
scen("EM3", EMP, "A finding on a doctrinal question", ["beginning", "cand_finding_on_doctrine"],
     [info_all("violation(finding_on_a_doctrine(f_doctrine,q(world_began)))"), cls("q(world_began)=yes", "settled")],
     "refused; the doctrine unchanged", mode=B)
scen("GL1", EMP, "Galileo, as of 1616", GAL + ["asof_1616"],
     [cls("q(earth_moves)=yes", "open"), cls("q(earth_moves)=no", "open"), prefers("q(earth_moves)", "tie"),
      info_all("consent_outside_faith_and_morals(josh10_12,censure_1616)",
               "violation(fact_censured_as_heresy(censure_1616,q(sun_at_rest)))",
               "violation(fact_censured_in_faith(censure_1616,q(earth_moves)))"),
      info_none("consent_outside_faith_and_morals(josh10_12,unclaimed)"),
      lambda r: (all(b["status"] == "main" for b in r["branches"] if "q(copernicus_may_be_read)=no" in b["values"]),
                 "the decree cleaves nothing on the fact, on either reading"),
      lambda r: (all(any("act_answers_a_fact(index_1616,q(earth_moves))" in f for f in b["facts"]) ==
                     ("read_as(index_1616,doctrinal)" in b["assume"]) for b in r["branches"])
                 and any("read_as(josh10_12,astronomical)" in b["assume"] for b in r["branches"]),
                 "the Index decree refused read as doctrinal, not as disciplinary; Joshua read both ways"),
      info_none("self_elevation")],
     "open; the consent outside faith and morals; the censure refused; the decree refused on the doctrinal reading", mode=B)
scen("GL2", EMP, "The sentence of 1633", GAL + ["asof_1633"],
     [info_all("violation(self_elevation(sentence_1633,index_1616))", "lower_speaks_of_higher(sentence_1633,index_1616,1)")],
     "\"dichiarata e diffinita\": a lower tier treated as fixing, refused", mode=B)
scen("GL3", EMP, "Galileo, as of 1730", GAL + ["asof_1730"],
     [cls("q(earth_moves)=yes", "settled"), info_all("fixed_by_finding(q(earth_moves),yes,bradley_1729)"),
      lambda r: (not any("read_as(josh10_12,astronomical)" in b["assume"] for b in r["branches"]), "the astronomical reading on no branch"),
      shown(GAL, ("info/1",), "info(fixed_by_finding(q(earth_moves),yes,foucault_1851))",
            absent=("info(fixed_by_finding(q(earth_moves),yes,bradley_1729))",))],
     "settled by Bradley's finding; the astronomical reading of Josh 10:12-13 on no branch", mode=B)
scen("GL4", EMP, "Whether Copernicus may be read", GAL + ["asof_1700"],
     [cls("q(copernicus_may_be_read)=no", "settled"), reint_includes("q(copernicus_may_be_read)=yes", "index_1616"),
      classified(GAL + ["asof_1830"], ("q(copernicus_may_be_read)=yes", "settled"), ("q(copernicus_may_be_read)=no", "shadow"))],
     "governance: no as of 1700, yes as of 1830 (the act of 1820)", mode=B)
scen("CB1", EMP, "The beginning and the expansion", ["beginning"],
     [cls("q(world_began)=yes", "settled"), cls("q(world_began)=no", "excluded"),
      info_all("violation(doctrine_rests_on_finding(pius_xii_1951,q(world_began),expansion_1929))",
               "fixed_by_finding(q(universe_expanding),yes,expansion_1929)")],
     "settled at tier 1 (DH 800); the argument from the expansion refused", mode=B)
scen("CB2", EMP, "The age of the universe", ["beginning"],
     [cls("q(age_of_universe)=about_13_8_gyr", "settled"),
      classified(["beginning", "asof_2000"], ("q(age_of_universe)=about_13_8_gyr", "open")),
      lambda r: (sorted({f for b in r["branches"] for f in b["facts"] if f.startswith("violation(")}) ==
                 ["violation(doctrine_rests_on_finding(pius_xii_1951,q(world_began),expansion_1929))"], "no refusal follows from the age")],
     "settled by the finding of 2018, open as of 2000; it answers no doctrinal question", mode=B)
scen("MB1", EMP, "Method never answers being", ["world", "method_being"],
     [has("nothing_but_from_division(claim_h,peter)", "against_the_soul_as_form(claim_h,peter)", "nothing_but_from_division(claim_l,lion)"),
      none_of("against_the_soul_as_form(claim_l"), lambda r: ("about_the_parts(claim_p,peter)" in r["info"]
                 and "fixed_by_finding(q(bodies_of_cells),yes,cell_theory_1839)" in r["info"], "a claim about the parts stands")],
     "a human being nothing but cells: refused twice; a lion: once; the parts: reported")
scen("TW1", EMP, "A twinning read four ways", ["twinning"],
     [branches_n(4),
      lambda r: (sorted((a, f) for b in r["branches"] for a in b["assume"] for f in b["facts"] if f.startswith("info(human_beings_after")) ==
                 sorted([("assumed_fact(twin_reading(e_z,budding))", "info(human_beings_after(e_z,2))"),
                         ("assumed_fact(twin_reading(e_z,delayed))", "info(human_beings_after(e_z,2))"),
                         ("assumed_fact(twin_reading(e_z,fission))", "info(human_beings_after(e_z,2))"),
                         ("assumed_fact(twin_reading(e_z,one_soul))", "info(human_beings_after(e_z,1))")]),
                 "two, two, two, one; never derived"),
      info_all("treated_as_a_person(e_z)"), clean_branches],
     "budding, fission, delayed, one soul; the embryo treated as a person on each", mode=B)
scen("TW2", EMP, "The one-soul reading against four outward tests", ["twinning", "twin_tests"],
     [in_branches("one_will_two_contrary_acts(e_z)", assume=("assumed_fact(twin_reading(e_z,one_soul))",)),
      in_branches("one_person_dead_and_alive(e_z)", assume=("assumed_fact(twin_reading(e_z,one_soul))",)),
      in_branches("baptism_repeated_by_the_church(e_z)", assume=("assumed_fact(twin_reading(e_z,one_soul))",)),
      in_branches("two_bonds_one_person(e_z)", assume=("assumed_fact(twin_reading(e_z,one_soul))",)),
      lambda r: (all(not any(f.startswith("violation(") for f in b["facts"]) for b in r["branches"]
                     if "assumed_fact(twin_reading(e_z,one_soul))" not in b["assume"]), "the other readings untouched")],
     "refused four ways (DH 556; Heb 9:27; DH 1609; c. 1085)", mode=B)
scen("TW3", EMP, "Refused on every reading", ["twinning", "cand_soul_divided", "cand_soul_from_twin"],
     [info_all("violation(soul_divided(e_z))", "violation(being_from_non_god(tw_a,tw_b))")],
     "the soul divided (DH 1440); a soul from a creature (A1; Humani generis 36)", mode=B)
scen("TW4", EMP, "Conjoined twins, 1950 and 2000", ["conjoined_twins"],
     [branches_n(4), info_all("to_be_baptized(cj_a,absolutely)", "to_be_baptized(cj_b,conditionally)"),
      info_none("to_be_baptized(cj_c", "to_be_baptized(cj_d"),
      all_models_with(["conjoined_twins"], ("assumed_fact/1",),
                      some=("assumed_fact(one_human_being(cj_2000))", "assumed_fact(false(one_human_being(cj_2000)))"))],
     "c. 748 of 1917 in 1950; in 2000 no canon answers, the number both ways", mode=B)

# ---------- One root: original sin in all; the descent of all (TTC-DESCENT) -----

DES = "descent"
scen("DS1", DES, "Members claimed free of original sin, no source loaded", ["cand_branch_without_os"],
     [has("original_sin_denied(p1)", "original_sin_denied(p2)"), count("original_sin_denied", 2), none_of("descent_denied")],
     "refused on Trent's scope (DH 1512-1513); the descent silent without its source")
scen("DS2", DES, "The people itself claimed free of it", ["cand_branch_without_os"],
     [has("original_sin_of_fiction(people_p)"), none_of("original_sin_denied(people_p)")],
     "refused as said of a fiction: \"in each one as his own\" (DH 1513)")
scen("DS3", DES, "Silence kept", ["family", "one_root"], [clean_branches],
     "human beings typed without descent, of whom nothing is claimed: no refusal", mode=B)
scen("DD2", DES, "One root, at tier 3", ["one_root"],
     [cls("q(one_root)=yes", "settled"), cls("q(one_root)=no", "shadow"), reint_includes("q(one_root)=no", "humani_generis_37")],
     "yes settled; no a live shadow of the encyclical", mode=B)
scen("DD3", DES, "A denial of descent, no source loaded", ["cand_pre_adamite"], [none_of("descent_denied")],
     "silent: a teaching of tier 3 weighs only where its source is entered")
scen("DD4", DES, "Pushing against it is not heresy", ["one_root", "professions_one_root", "report_notes"],
     [in_branches("info(censure(essay_n,erroneous))", "main"), in_branches("info(censure(essay_n,", "live_shadow", present=False),
      info_none("censure(essay_n,heretical)", "censure(essay_d"), in_branches("info(note(q(one_root),yes,authentic))", "main")],
     "erroneous in the main branch only, never heretical; a doubt not censured", mode=B)
scen("DC1", DES, "A people claimed free of original sin and not from Adam", ["one_root", "cand_branch_without_os"],
     [info_all("violation(original_sin_denied(p1))", "violation(original_sin_denied(p2))",
               "violation(original_sin_of_fiction(people_p))"),
      branch_violation("q(one_root)=yes", "descent_denied(p1,separate_creation)"),
      branch_violation("q(one_root)=yes", "descent_denied(p2,separate_creation)"),
      branch_violation("q(one_root)=no", "descent_denied", present=False)],
     "two denied and one of a fiction in every branch; the denials of descent in the main branch only", mode=B)
scen("DC2", DES, "Human beings before Adam", ["one_root", "cand_pre_adamite"],
     [branch_violation("q(one_root)=yes", "descent_denied(pre_a,before_adam)"),
      branch_violation("q(one_root)=no", "descent_denied", present=False)],
     "refused in the main branch only", mode=B)
scen("DC3", DES, "The incarnate and Mary claimed free of it", CREED + ["os_free_claimed"],
     [clean_branches,
      lambda r: (not solve(["trinity", "creed", "os_virginal", "os_free_claimed"], "one")["violations"],
                 "without the dogma: reserved (DH 1516)"),
      lambda r: (not [f for b in solve(CREED + ["asof_1850", "os_free_claimed"], "branches")["branches"]
                      for f in b["facts"] if f.startswith("violation(")], "1850: reserved on every branch")],
     "not refused on any date: Christ (DH 301); Mary reserved (DH 1516), preserved from 1854 (DH 2803)", mode=B)

# ---------- TTC-WITNESS: a witness apart from the claim ----------------------
WIT = "witness"
_CLAIM_W = ("question(q(x_w)). question_kind(q(x_w),doctrinal). value(q(x_w),(yes;no)).\n"
            "source(decl_w2,3,truth,2026). character(decl_w2,declaration). supports(decl_w2,q(x_w),yes).\n"
            "oum_claim(decl_w2,1). oum_claimant(decl_w2,decl_w2).\n")
_LG25 = ("dispersed_in_communion", "authentic_teaching", "faith_or_morals", "one_position_definitive")
_ALL4 = "(" + ";".join(_LG25) + ")"


def _on_the_claim(parts, src, facts, unshown):
    """every branch resting on the claim on src is (un)shown, and some branch rests on it"""
    def chk(_r):
        bs = [b for b in solve(parts, "branches", facts=facts)["branches"] if f"oum_holds({src})" in b["assume"]]
        ok = bool(bs) and all((b["unshown"] >= 1) == unshown for b in bs)
        return ok, f"{len(bs)} branches on the claim, each {'unshown' if unshown else 'shown'}" if ok else "not as stated"
    return chk


def refused_witness(extra, witness):
    """with the snippet, the witness is refused for each of LG 25's conditions, and the claim stays unshown"""
    def chk(_r):
        facts = _CLAIM_W + extra + f"witnessed_by(decl_w2,{_ALL4},{witness}).\n"
        v = solve([], "one", facts=facts)["violations"]
        missing = [c for c in _LG25 if f"witness_is_claimant(decl_w2,{c},{witness})" not in v]
        ok = not missing and _on_the_claim([], "decl_w2", facts, True)(None)[0]
        return ok, f"{witness}: refused four times, unshown" if ok else f"{witness}: not refused for {missing}"
    return chk


scen("WN1", WIT, "A condition shown by a witness apart", ["witness_apart_hyp"],
     [shown(["witness_apart_hyp"], ("shown_apart/2", "condition_shown/2"),
            *[f"shown_apart(decl_apart,{c})" for c in _LG25], *[f"condition_shown(decl_apart,{c})" for c in _LG25]),
      _on_the_claim(["witness_apart_hyp"], "decl_apart", "", False),
      _on_the_claim([], "decl_w2", _CLAIM_W, True)],
     "the four conditions shown apart, and the claim with them; with no witness, unshown", mode=B)
scen("WN2", WIT, "No witness in its own cause", ["cand_i_say"],
     [count("witness_is_claimant(decl_say,", 4), _on_the_claim(["cand_i_say"], "decl_say", "", True),
      refused_witness("", "oum(decl_w2)"),
      refused_witness("oum_claimant(decl_w2,dicastery_w).\n", "dicastery_w"),
      refused_witness("source(gloss_w,3,truth,2026). character(gloss_w,commentary). claims_tier(gloss_w,decl_w2,1).\n", "gloss_w"),
      refused_witness("claim_stated(decl_w2,herald_w).\n", "herald_w"),
      refused_witness("oum_claimant(decl_w2,pope_w). in_name_of(curia_w,pope_w).\n", "curia_w"),
      lambda r: (f"witness_is_claimant(decl_w3,faith_or_morals,decl_w3)" in solve([], "one", facts=
                 "question(q(x_w3)). question_kind(q(x_w3),doctrinal). value(q(x_w3),(yes;no)). "
                 "source(decl_w3,3,truth,2026). character(decl_w3,declaration). supports(decl_w3,q(x_w3),yes). "
                 "oum_claim(decl_w3,1). oum_claimant(decl_w3,critic_w). "
                 f"witnessed_by(decl_w3,{_ALL4},decl_w3).")["violations"], "the claim its own witness, claimed by another: refused")],
     "the claim, its consensus, a claimant, one who grades it, one who states it, an act in a claimant's name: refused", mode=B)
scen("WN3", WIT, "A condition entered as shown, no witness named", [],
     [lambda r: (all(f"condition_without_witness(decl_w2,{c})" in solve([], "one", facts=_CLAIM_W + f"condition_shown(decl_w2,{_ALL4}).")["info"]
                     for c in _LG25), "noted for each condition"),
      _on_the_claim([], "decl_w2", _CLAIM_W + f"condition_shown(decl_w2,{_ALL4}).", True)],
     "noted, and the claim stays unshown", mode=B)
scen("WC2", WIT, "Communion judged by the teaching in question", [],
     [lambda r: ("communion_from_the_teaching(decl_w2,count_w)" in solve([], "one", facts=_CLAIM_W +
                 "source(count_w,5,truth,2026). witnessed_by(decl_w2,dispersed_in_communion,count_w). "
                 "communion_judged_by(count_w,q(x_w)).")["violations"], "on the very question: refused"),
      lambda r: (not solve([], "one", facts=_CLAIM_W + "question(q(x_o)). question_kind(q(x_o),doctrinal). value(q(x_o),(yes;no)). "
                           "source(count_o,5,truth,2026). witnessed_by(decl_w2,dispersed_in_communion,count_o). "
                           "communion_judged_by(count_o,q(x_o)).")["violations"], "on another question: not refused"),
      _on_the_claim([], "decl_w2", _CLAIM_W + "source(count_w,5,truth,2026). witnessed_by(decl_w2," + _ALL4 + ",count_w). "
                    "communion_judged_by(count_w,q(x_w)).", True)],
     "refused in every branch, the condition unmet; judged by another question, not refused", mode=B)
scen("WD1", WIT, "The true Scotsman", ["commentary_communion", "cand_scotsman"],
     [all_branches_violation("communion_from_the_teaching(decl_scot,count_scot)"),
      _on_the_claim(["commentary_communion", "cand_scotsman"], "decl_scot", "", True), best_rest_on_no_claim,
      in_branches("against_tier1(bishop_scot,q(x_scot))", assume=("oum_holds(decl_scot)",)),
      lambda r: (not any("against_tier1(bishop_scot" in f for b in r["branches"] if "oum_holds(decl_scot)" not in b["assume"]
                         for f in b["facts"]), "the dissenting bishop: against tier 1 only on the claim's branch")],
     "the claim proving itself: refused; its branch unshown and never preferred (WC3)", mode=B)
scen("WD2", WIT, "I say X is OUM", ["cand_i_say"],
     [all_branches_violation("witness_is_claimant(decl_say,dispersed_in_communion,decl_say)"),
      info_all("never_stated(decl_say)")],
     "the claimant its own witness for each condition: refused in every branch", mode=B)
scen("WD3", WIT, "The control: a witness apart", ["witness_apart_hyp"],
     [clean_branches, _on_the_claim(["witness_apart_hyp"], "decl_apart", "", False)],
     "no refusal; the claim shown, its branch free to be preferred by weight", mode=B)
scen("WR1", WIT, "Who states the claim in words", ["ordination_reserved"],
     [info_all("claim_unstated(os1994,os1994)"),
      info_none("claim_unstated(os1994,cdf_1995)", "claim_unstated(os1994,cdf_1998)")],
     "the letter is entered as claimant, never stating it; the reply and the commentary state it", mode=B)
scen("WR2", WIT, "The first to state it", ["ordination_reserved"],
     [info_all("first_stated(os1994,cdf_1995,1995)"), info_none("first_stated(os1994,cdf_1998", "never_stated(os1994)"),
      lambda r: ("never_stated(decl_w2)" in solve([], "one", facts=_CLAIM_W)["info"], "unstated by any: noted")],
     "the reply of 1995; where no one states it, noted", mode=B)
scen("WR3", WIT, "A claim in another's name", ["ordination_reserved"],
     [info_all("claim_attributed(cdf_1995,john_paul_ii,os1994)"),
      shown(["ordination_reserved"], ("eff_tier/2",), "eff_tier(cdf_1995,3)", "eff_tier(os1994,3)")],
     "the reply's claim is its own, said in the pope's name; no tier changes", mode=B)
scen("WR4", WIT, "Approval in specific form", [],
     [shown([], ("eff_tier/2", "lrank/2"), "eff_tier(decl_w2,3)", "lrank(decl_w2,4)", facts=_CLAIM_W + "in_forma_specifica(decl_w2)."),
      _on_the_claim([], "decl_w2", _CLAIM_W + "in_forma_specifica(decl_w2).", True)],
     "the rank rises; the tier stays 3, and the claim unshown", mode=B)

# ---------- The manner of speaking; the hierarchy of truths (TTC-MANNER) --------

MAN = "manner"
MNB = ["manner_hyp", "assent"]
scen("MA1", MAN, "A tier-3 act, as now", MNB + ["manner_professions"],
     [cls("q(mn)=yes", "settled"), cls("q(mn)=no", "shadow"), reint_includes("q(mn)=no", "act_mn"),
      info_all("owed(act_mn,religious_submission)", "delict(p_mn,n1365,e_mn)"),
      in_branches("info(censure(e_mn,erroneous))", "main")],
     "yes settled, no a live shadow of the act; religious submission owed; the contrary profession erroneous, c. 1365", mode=B)
scen("MA2", MAN, "An act that says it settles nothing", MNB + ["manner_whole", "manner_professions"],
     [cls("q(mn)=yes", "open"), cls("q(mn)=no", "open"),
      lambda r: (all(b["cleaved"] == [] for b in r["branches"])
                 and {b["w"][3] for b in r["branches"] if "q(mn)=no" in b["values"]} == {1}, "cleaves nothing; weighs at tier 3"),
      info_none("owed(act_mn", "censure(e_mn", "delict(p_mn", "governance_read_as_teaching")],
     "both open, the act weighing at tier 3; nothing owed, no censure, no delict; still teaching (LG 25)", mode=B)
scen("MA3", MAN, "Settling nothing on one question", MNB + ["manner_on_q", "manner_professions"],
     [cls("q(mn)=yes", "open"), cls("q(mn)=no", "open"), info_all("owed(act_mn,religious_submission)"),
      info_none("censure(e_mn", "delict(p_mn")],
     "both open; owed to the act, but nothing owed on that question: no censure, no delict", mode=B)
scen("MA4", MAN, "What the act reaffirms keeps its own tier", MNB + ["manner_whole", "manner_reaffirmed"],
     [cls("q(mn)=yes", "settled"), cls("q(mn)=no", "shadow"),
      lambda r: (all(b["cleaved"] == ["enc_mn"] for b in r["branches"] if "q(mn)=no" in b["values"]),
                 "a shadow of the earlier teaching, not of the act"),
      info_all("owed(enc_mn,religious_submission)"), info_none("owed(act_mn"),
      in_branches("info(censure(e_mn,erroneous))", "main")],
     "the limit reaches only the act: the teaching it reaffirms cleaves, is owed, and notes", mode=B)
scen("MA5", MAN, "Another text's lowering stays a claim", MNB + ["manner_lowered_by_another"],
     [cls("q(mn)=yes", "settled"), cls("q(mn)=no", "shadow"), info_all("owed(act_mn,religious_submission)")],
     "inert, as before: only the act's own text lowers it", mode=B)
scen("MA6", MAN, "A definition entered as settling nothing", ["manner_def_hyp", "cand_limit_on_definition"],
     [any_branch_violation("limit_on_a_definition(def_mn)"), cls("q(mn_def)=no", "excluded"),
      info_all("censure(e_ht,heretical)")],
     "refused: the form says it settles; deletion and the note unchanged", mode=B)
scen("MA7", MAN, "A definition entered as settling nothing on its question", ["manner_def_hyp", "cand_limit_on_definition_q"],
     [any_branch_violation("limit_on_a_definition(def_mn)"), cls("q(mn_def)=no", "excluded")],
     "refused, likewise", mode=B)
scen("MA8", MAN, "An act that settles nothing still answers no fact", ["manner_hyp", "manner_whole", "manner_fact"],
     [any_branch_violation("act_answers_a_fact(act_mn,q(mn_fact))"),
      lambda r: (any("violation(act_answers_a_fact(act_mn,q(mn_fact)))" in b["facts"]
                     for b in solve(["manner_hyp", "manner_fact"], "branches")["branches"]), "refused without the limit too"),
      cls("q(mn_fact)=yes", "open"), cls("q(mn_fact)=no", "open")],
     "refused with the limit as without it: the limit lowers what the act may do, not the shape of what it says", mode=B)
scen("HG1", MAN, "The hierarchy of truths used as a grade", ["manner_def_hyp", "cand_hierarchy_as_grade"],
     [any_branch_violation("hierarchy_as_grade(work_ht,q(mn_def))"), any_branch_violation("hierarchy_as_grade(def_mn,q(mn_def))"),
      cls("q(mn_def)=no", "excluded"), info_all("censure(e_ht,heretical)")],
     "refused, whoever makes it, the author too; the note and the censure unchanged (Mysterium Ecclesiae 4)", mode=B)

# ---------- Particular replies: they weigh and never cleave (TTC-REPLIES) -------

REP = "replies"
RPB = ["replies_hyp"]
scen("RP1", REP, "Replies entered without the slot, as now", RPB,
     [cls("q(rp_x)=yes", "settled"), cls("q(rp_x)=no", "shadow"),
      reint_includes("q(rp_x)=no", "rp_b"), reint_includes("q(rp_x)=no", "rp_c")],
     "yes settled, no a live shadow of the two later replies: lex posterior between letters", mode=B)
scen("RP2", REP, "Particular replies weigh and never cleave", RPB + ["replies_marked"],
     [cls("q(rp_x)=yes", "open"), cls("q(rp_x)=no", "open"), prefers("q(rp_x)", "yes"),
      info_all("weighs_only(rp_a,q(rp_x))", "weighs_only(rp_b,q(rp_x))", "weighs_only(rp_c,q(rp_x))")],
     "both open, yes preferred by weight; each reply noted as weighing only (c. 16 §3)", mode=B)
scen("RP3", REP, "A particular reply in forma specifica", RPB + ["replies_marked", "replies_specific"],
     [cls("q(rp_x)=yes", "open"), cls("q(rp_x)=no", "open"), prefers("q(rp_x)", "yes")],
     "as RP2: the form does not lift a particular reply; c. 16 §3 is of reach, not rank", mode=B)
scen("RP4", REP, "The slot on a teaching letter", RPB + ["replies_marked"],
     [cls("q(rp_d)=yes", "settled"), cls("q(rp_d)=no", "shadow"), reint_includes("q(rp_d)=no", "rp_t"),
      info_none("weighs_only(rp_t")],
     "unchanged: c. 16 §3 is of interpretations of law", mode=B)

# ---------- The tongues: one word, many encodings (TTC-LINGUAE) ---------------
# Predictions committed and stamped first: docs/research/linguae-preregistration.md.
# The suite names LW1-LW4 WO1-WO4 and PM1-PM7 PX1-PX7: LW and PM are the law's
# and presence's. LX and LP pin the library's and the pair's mechanics.

LIN = "linguae"
RN9 = ["linguae_rn9"]
CCC = ["linguae_ccc2483"]
PMU = ["linguae_pro_multis"]
BAP = ["we_baptize", "linguae_we_baptize"]
SGN = BAP + ["linguae_signed"]
SGC = SGN + ["linguae_signed_canon"]
LITERAL = "assumed_fact(read_by(rn_la_forma,lex_la_1891))"
VELUT = "assumed_fact(read_by(rn_la_forma,lex_la_velut))"
P_SCHOL = "assumed_fact(read_by(rn_en_personality,lex_en_schol_1891))"
P_LOCKE = "assumed_fact(read_by(rn_en_personality,lex_en_locke_1891))"
W_SCHOL = "assumed_fact(read_by(rn_en_wellbeing,lex_en_schol_1891))"
W_LOCKE = "assumed_fact(read_by(rn_en_wellbeing,lex_en_locke_1891))"
SEALS = [("rn_en_impress", "en_2026"), ("rn_it_impronta", "it_2026"), ("rn_fr_empreinte", "fr_2026"), ("rn_es_huella", "es_2026")]
VOCAL, LINGUAL = "read_as(verbum,verbum_vocal)", "read_as(verbum,verbum_lingual)"


def rendered(s, yes=True):
    return f"assumed_fact(renders({s},rn_la_forma))" if yes else f"assumed_fact(false(renders({s},rn_la_forma)))"


def lin_on(parts, *checks, facts=""):
    """the checks, on another run: other parts, a runtime, a regime, or a snippet"""
    def chk(_r):
        r = solve(parts, "branches", facts=facts)
        res = [c(r) for c in checks]
        tag = " ".join(p for p in parts if p.startswith(("rt_", "regime_", "asof_", "cand_"))) or "snippet"
        return all(o for o, _ in res), f"[{tag}] " + " | ".join(d for _, d in res)
    return chk


def lin_exact(prefix, expected):
    """in every branch, the facts beginning with prefix are exactly these"""
    def chk(r):
        got = {frozenset(f for f in b["facts"] if f.startswith(prefix)) for b in r["branches"]}
        ok = got == {frozenset(expected)}
        return ok, f"{prefix}: " + ("exactly as stated" if ok else str([sorted(g) for g in got]))
    return chk


def lin_assumed(*atoms):
    """each assumption is made in some branch, and in none with another of the list"""
    def chk(r):
        seen = [sum(a in b["assume"] for b in r["branches"]) for a in atoms]
        ok = all(seen) and all(sum(a in b["assume"] for a in atoms) <= 1 for b in r["branches"])
        return ok, f"{', '.join(atoms)}: {seen}"
    return chk


def lin_paired(a, b):
    """in every branch, the assumption a is made exactly where b is"""
    def chk(r):
        ok = bool(r["branches"]) and all((a in x["assume"]) == (b in x["assume"]) for x in r["branches"])
        return ok, f"{a} exactly where {b}" if ok else f"{a} apart from {b}"
    return chk


def lin_every(atom):
    """the assumption is made in every branch"""
    def chk(r):
        ok = bool(r["branches"]) and all(atom in b["assume"] for b in r["branches"])
        return ok, f"{atom}: every branch" if ok else f"{atom}: not every branch"
    return chk


def lin_same_classes(parts_a, parts_b, q, values):
    """a question's values classed and preferred alike with and without the new parts"""
    def chk(_r):
        out = []
        for parts in (parts_a, parts_b):
            r = solve(parts, "branches")
            out.append([classify(r, f"{q}={v}") for v in values] + [preferred_value(r, q)])
        return out[0] == out[1], f"{q}: {out[0]} / {out[1]}"
    return chk


def on_every_runtime_v(parts, sub):
    """the violation on every runtime the base declares, bare included"""
    def chk(_r):
        miss = [rt for rt in E.RUNTIMES if not any(sub in v for v in solve(list(parts) + [f"rt_{rt}"], "one")["violations"])]
        return not miss, "on every runtime" if not miss else f"not on {', '.join(miss)}"
    return chk


def lin_symmetric(m1, m2, preds):
    """c. 1108's atoms for two marriages, the one's name put for the other's, are the same in every branch"""
    def chk(r):
        ok = True
        for b in r["branches"]:
            one = {f.replace(m1, "M") for f in b["facts"] if m1 in f and any(p in f for p in preds)}
            two = {f.replace(m2, "M") for f in b["facts"] if m2 in f and any(p in f for p in preds)}
            ok = ok and one == two and bool(one)
        return ok, f"{m1} and {m2} computed alike" if ok else f"{m1} and {m2} differ"
    return chk


def lin_no_asl_approval(_r):
    """no approval of a version is entered for any text in a signed language (none was found)"""
    import re as _re
    texts = (E.LP_DIR / "canon_cases.lp").read_text() + (E.LP_DIR / "icon_history.lp").read_text()
    approved = set(_re.findall(r"version_approval\(\w+,(\w+)\)", texts))
    return approved == {"missal_en_2011", "missal_it_2020"}, f"approved: {sorted(approved)}"


scen("WO1", LIN, "A word given a date (LW1)", RN9 + ["cand_word_dated"],
     [info_all("violation(word_dated(w_persona))", "violation(word_dated(w_forma))", "violation(word_dated(w_perfectio))"),
      lin_on(RN9 + ["cand_word_dated", "rt_saussure"], info_none("word_dated"))],
     "refused on the default runtime, by a date, a text's year, a place in the order; not on rt_saussure", mode=B)
scen("WO2", LIN, "One word, or a value in each tongue (LW2)", RN9,
     [info_all("info(mode(rn_fr_personne,rn_la_persona,univocal))", "info(mode(rn_es_persona,rn_la_persona,univocal))"),
      lin_on(RN9 + ["rt_saussure"], info_none("univocal)"),
             info_all("info(mode(rn_fr_personne,rn_la_persona,equivocal))", "info(mode(rn_es_persona,rn_la_persona,equivocal))",
                      "info(mode(rn_en_personality,rn_la_persona,analogical))",
                      "info(lost_in(rn9,fr_2026,cd(efficient,human),equivocal))"))],
     "personne and persona render personae univocally; on rt_saussure no rendering between two encodings is univocal: "
     "analogical where an analogy is declared, equivocal otherwise", mode=B)
scen("WO3", LIN, "Translations in time (LW3)", ["cand_translation_order"],
     [info_all("violation(made_before_parent(tx_early,tx_parent))", "violation(translation_cycle(tx_a))"),
      info_none("made_before_parent(tx_a", "made_before_parent(tx_b")],
     "a text made before its parent refused; a cycle of translations refused", mode=B)
scen("WO4", LIN, "A word as a tongue's root (LW4)", ["cand_word_as_root"],
     [has("word_as_root(w_forma_locutionis)"), none_of("word_as_root(proto_ie)"),
      on_every_runtime_v(["cand_word_as_root"], "word_as_root(w_forma_locutionis)")],
     "a perfect language taken as the word refused on every runtime; a proto-language, an encoding with its claimant, not")

scen("RN1", LIN, "RN 9: the person in four tongues (RN1)", RN9,
     [info_all(*[f"info(carried({f},rn_la_persona,cd({c},human)))" for f in ("rn_fr_personne", "rn_es_persona")
                 for c in ("formal", "efficient")],
               "info(mode(rn_fr_personne,rn_la_persona,univocal))", "info(mode(rn_es_persona,rn_la_persona,univocal))",
               "info(analogy_kind(rn_it_personalita,rn_la_persona,attribution))",
               "info(carried(rn_it_personalita,rn_la_persona,cd(formal,human)))"),
      in_branches("info(analogy_kind(rn_en_personality,rn_la_persona,attribution))", assume=(P_SCHOL,)),
      in_branches("info(carried(rn_en_personality,rn_la_persona,cd(formal,human)))", assume=(P_SCHOL,)),
      in_branches("info(carried(rn_en_personality,rn_la_persona,cd(efficient,human)))", assume=(P_LOCKE,)),
      in_branches("info(carried(rn_en_personality,rn_la_persona,cd(formal,human)))", assume=(P_LOCKE,), present=False),
      in_branches("info(lost_in(rn9,en_2026,cd(formal,human),no_carry))", assume=(P_LOCKE,)),
      info_all("info(carried_in(rn9,fr_2026,cd(efficient,human)))", "info(carried_in(rn9,es_2026,cd(efficient,human)))"),
      clean_branches],
     "French and Spanish carry the person univocally; English and Italian by attribution under the scholastic lexicon; "
     "under the Lockean only (efficient, human)", mode=B)
scen("RN2", LIN, "RN 9: the seal-words, an analogy or a gap (RN2)", RN9,
     [*(in_branches(f"info(carried({s},rn_la_forma,cd(formal,human)))", assume=(LITERAL, rendered(s))) for s, _ in SEALS),
      *(in_branches(f"info(analogy_kind({s},rn_la_forma,proportionality))", assume=(LITERAL, rendered(s))) for s, _ in SEALS),
      *(in_branches(f"info(lost_in(rn9,{e},cd(formal,human),gap))", assume=(rendered(s, False),)) for s, e in SEALS),
      *(in_branches(f"info(carried({s},rn_la_forma,", assume=(rendered(s, False),), present=False) for s, _ in SEALS)],
     "(formal, human) carried by proportionality where the seal-word is given for the form; lost by gap where it is not, "
     "in every vernacular", mode=B)
scen("RN3", LIN, "RN 9: well-being (RN3)", RN9,
     [in_branches("info(mode(rn_en_wellbeing,rn_la_perficiendam,univocal))", assume=(W_SCHOL,)),
      in_branches("info(extent(rn_en_wellbeing,rn_la_perficiendam,wider))", assume=(W_SCHOL,)),
      in_branches("info(carried(rn_en_wellbeing,rn_la_perficiendam,cd(final,human)))", assume=(W_SCHOL,)),
      in_branches("info(carried(rn_en_wellbeing,rn_la_perficiendam,cd(final,self)))", assume=(W_LOCKE,)),
      lin_paired(W_SCHOL, "assumed_fact(read_by(rn_en_wellbeing,lex_en_2026))"), branches_n(128),
      in_branches("info(carried(rn_en_wellbeing,rn_la_perficiendam,cd(final,human)))", assume=(W_LOCKE,), present=False)],
     "univocal and wider under the scholastic lexicon, carrying (final, human); under the Lockean, (final, self) only", mode=B)
scen("RN4", LIN, "RN 9 heard in the English of 1891, under Locke (RN4)", RN9,
     [lin_exact("info(carried_for(g_en_1891_locke,", {"info(carried_for(g_en_1891_locke,rn9,cd(efficient,human)))",
                                                      "info(carried_for(g_en_1891_locke,rn9,cd(material,nature)))",
                                                      "info(carried_for(g_en_1891_locke,rn9,cd(final,self)))"}),
      info_all("info(mode_for(g_en_1891_locke,rn_en_personality,rn_la_persona,analogical))",
               "info(lost_for(g_en_1891_locke,rn9,cd(formal,human),no_carry))")],
     "exactly (efficient, human), (material, nature), (final, self), in every branch; TTC-MODERNITY, whose switch "
     "rn9_in_english was to retire, is not in the base", mode=B)
scen("RN5", LIN, "RN 9: lost by encoding, lost by horizon (RN5)", RN9,
     [info_all("info(mode_for(g_thomist_2026,rn_en_personality,rn_la_persona,equivocal))",
               "info(lost_for(g_thomist_2026,rn9,cd(formal,human),equivocal))",
               "info(lost_by_horizon(g_locke_la,rn9,cd(formal,human)))",
               "info(lost_by_horizon(g_en_1891_locke,rn9,cd(formal,human)))"),
      info_none("lost_by_horizon(g_thomist_2026", "lost_for(g_locke_la"),
      in_branches("info(lost_for(g_thomist_2026,rn9,cd(formal,human),gap))", assume=(rendered("rn_en_impress", False),))],
     "the Thomist guest in the English of 2026 loses it by encoding alone, the Lockean guest of the Latin by horizon "
     "alone; the two reported apart", mode=B)
scen("RN6", LIN, "RN 9: the Latin's own velut (RN6)", RN9,
     [*(in_branches(f"info(mode({s},rn_la_forma,univocal))", assume=(VELUT, rendered(s))) for s, _ in SEALS),
      *(in_branches(f"info(carried({s},rn_la_forma,cd(formal,human)))", assume=(VELUT, rendered(s))) for s, _ in SEALS),
      in_branches("info(premise_by_analogy(rn9,cd(formal,human),proportionality))", assume=(VELUT,)),
      in_branches("info(premise_by_analogy(", assume=(LITERAL,), present=False)],
     "on the metaphor reading the form premise is a proportion, and every seal-word renders it univocally", mode=B)

scen("CC1", LIN, "CCC 2483: clause by clause; a revision no rendering (CC1)", CCC + ["cand_revision_rendered"],
     [info_all("info(mode(ccc94_en_against,ccc92_fr_contra,univocal))", "info(mode(ccc94_en_error,ccc92_fr_erreur,univocal))",
               "info(mode(ccc94_en_right,ccc92_fr_droit,univocal))", "info(no_mode(ccc97_la_contra,ccc92_fr_contra,revision))",
               "info(no_mode(ccc92_fr_erreur,ccc97_la_errorem,revision))"),
      info_none("info(mode(ccc97_la", "info(mode(ccc92_fr_erreur")],
     "the English of 1994 renders the French of 1992 univocally; no mode between the French of 1992 and the Latin of 1997", mode=B)
scen("CC2", LIN, "CCC 2483: the encodings of a superseded edition (CC2)", CCC,
     [info_all("info(superseded_encoding(ccc_en_1994,ccc_la_1997))", "info(superseded_encoding(ccc_de_vatican,ccc_la_1997))"),
      info_none("superseded_encoding(ccc_fr_1997", "superseded_encoding(ccc_en_2000")],
     "vatican.va's English and German encode the edition the Latin of 1997 revises", mode=B)
scen("CC3", LIN, "CCC 2483: the definitive text answers no question of lying (CC3)", CCC + ["cand_definitive_answers"],
     [info_all("violation(teaching_from_law(q(lie_needs_right_hearer)))"),
      cls("q(ccc_definitive_text)=latin_typical", "settled"),
      lin_on(CCC, info_none("teaching_from_law"))],
     "the Latin definitive: governance; entered as answering the doctrinal question, refused", mode=B)

scen("PX1", LIN, "pro multis: what each rendering closes (PM1)", PMU,
     [info_none("info(closes(pm_en11_many", "info(closes(pm_fr21_multitude", "closes(pm_en73_all,pm_la70,r_all)"),
      info_all(*[f"info(closes({f},{h},{r}))" for f, h in (("pm_en73_all", "pm_la70"), ("pm_de75_alle", "pm_la70"),
                                                           ("pm_it20_tutti", "pm_la02")) for r in ("r_open", "r_offered")],
               "info(interpretation(pm_en73_all,pm_la70,r_all))", "info(interpretation(pm_de75_alle,pm_la70,r_all))",
               "info(interpretation(pm_it20_tutti,pm_la02,r_all))",
               "info(closes_for(g_en_2011,pm_en73_all,pm_la70,r_open))",
               "info(interpretation_for(g_en_2011,pm_en73_all,pm_la70,r_all))"),
      in_branches("info(opens_for(g_en_2011,pm_en11_many,pm_la02,r_not_all))",
                  assume=("assumed_fact(heard_by(g_en_2011,en_2011,lex_en_not_all))",))],
     "for many and pour la multitude close nothing; for all, fur alle, per tutti close the open reading and the "
     "offered, keeping all: an interpretation", mode=B)
scen("PX2", LIN, "pro multis under Liturgiam authenticam (PM2)", PMU + ["regime_la"],
     [info_all("info(faithful(pm_en11_many,pm_la02))", "info(not_faithful(pm_en73_all,pm_la70))",
               "info(not_faithful(pm_de75_alle,pm_la70))", "info(not_faithful(pm_it20_tutti,pm_la02))",
               "info(for_catechesis(pm_en11_many,r_not_all))", "info(for_catechesis(pm_en73_all,r_all))"),
      info_none("not_faithful(pm_en11_many")],
     "for many faithful; for all, fur alle, per tutti not; what a rendering opens goes to catechesis", mode=B)
EN11 = "assumed_fact(heard_by(g_en_2011,en_2011,lex_en_2011))"
NOTALL = "assumed_fact(heard_by(g_en_2011,en_2011,lex_en_not_all))"
INS = "assumed_fact(inserted(pm_en73_all,pm_la70))"
NOINS = "assumed_fact(false(inserted(pm_en73_all,pm_la70)))"
scen("PX3", LIN, "pro multis under Comme le prevoit (PM3)", PMU + ["regime_clp"],
     [in_branches("info(faithful_for(g_en_2011,pm_en73_all,pm_la70))", assume=(NOINS,)),
      in_branches("info(not_faithful_for(g_en_2011,pm_en73_all,pm_la70))", assume=(INS,)),
      in_branches("info(faithful_for(g_en_2011,pm_en11_many,pm_la02))", assume=(EN11,)),
      in_branches("info(not_faithful_for(g_en_2011,pm_en11_many,pm_la02))", assume=(NOTALL,)),
      in_branches("info(contrary_for(g_en_2011,pm_en11_many,r_not_all,q(died_for_all)))", status="main", assume=(NOTALL,))],
     "for all faithful where the message is all, not where it is an insertion of an explanation; for many faithful, "
     "save for a hearing of many as not all, against Christ died for all: two branches each", mode=B)
scen("PX4", LIN, "pro multis under Magnum principium (PM4)", PMU + ["regime_mp"],
     [info_all("info(not_faithful_for(g_en_2011,pm_en73_all,pm_la70))", "info(latin_decides(pm_en73_all,pm_la70))",
               "info(word_for_word_required(pm_en11_many,pm_la02))"),
      in_branches("info(faithful_for(g_en_2011,pm_en11_many,pm_la02))", assume=(EN11,)),
      in_branches("info(not_faithful_for(g_en_2011,pm_en11_many,pm_la02))", assume=(NOTALL,)),
      info_none("latin_decides(pm_en11_many")],
     "the text fails for for all, the Latin deciding; the addressees branch for for many as under CLP", mode=B)
scen("PX5", LIN, "pro multis: the claims of a mode (PM5)", PMU,
     [info_all("info(mode_claim_agrees(arinze_2006,pm_en11_many,pm_la02))",
               "info(mode_claim_agrees(benedict_2012,pm_de75_alle,pm_la70))",
               "info(units_differ(arinze_2006,recognitio_en_2010,pm_en11_many,pm_la02))",
               "info(mode_claim_weighs(confirmatio_it_2019,pm_it20_tutti,pm_la02,3))"),
      info_none("mode_claim_differs", "units_differ(benedict_2012")],
     "Arinze's and Benedict's claims agree with what is computed. Scored red: the Italian confirmation's claim is on "
     "per tutti and Benedict's on fur alle, two pairs, so no units_differ between them; it is reported where two "
     "claims share a pair (Arinze, the recognitio of 2010)", mode=B)
scen("PX6", LIN, "pro multis answers nothing of Christ's death (PM6)", PMU + ["cand_rendering_answers"],
     [info_all("violation(rendering_answers(s_for_all,q(died_for_all),pm_en73_all))",
               "violation(rendering_answers(s_not_all,q(died_for_all),pm_en11_many))"),
      cls("q(died_for_all)=yes", "settled")],
     "a value rested on what a rendering closes refused; the question keeps its own sources' value", mode=B)
scen("PX7", LIN, "pro multis: the translation case unchanged; c. 838 at its dates (PM7)", PMU + ["linguae_pro_multis_canon"],
     [lin_same_classes(["translation"], ["translation"] + PMU + ["linguae_pro_multis_canon"], "q(translation_approval)",
                       ("detailed_recognitio", "confirmatio")),
      info_all("info(approved_under(missal_en_2011,n838_1983))", "info(approved_under(missal_it_2020,n838_2017))"),
      info_none("approved_under(missal_en_2011,n838_2017)", "approved_under(missal_it_2020,n838_1983)")],
     "q(translation_approval) as before; the English of 2011 under c. 838 before 1 October 2017, the Italian after", mode=B)

scen("BF1", LIN, "The form of baptism: I baptize you (BF1)", BAP,
     [info_all("info(mode(bf_en_i,bf_la_ego,univocal))", "info(feature_mode(bf_en_i,bf_la_ego,minister_act,univocal))",
               "info(feature_mode(bf_en_i,bf_la_ego,trinity_invoked,univocal))")],
     "univocal on both features", mode=B)
scen("BF2", LIN, "The form of baptism: the Greek passive, We baptize (BF2)", BAP,
     [info_all("info(feature(bf_la_greek,minister_act,unexpressed))", "info(feature_mode(bf_la_greek,bf_la_ego,trinity_invoked,univocal))",
               "info(feature_mode(bf_la_greek,bf_la_ego,minister_act,gap))", "info(feature(bf_en_we,minister_act,other_agent))",
               "info(feature_mode(bf_en_we,bf_la_ego,minister_act,equivocal))"),
      cls("q(valid_form(baptism,we_baptize))=no", "settled"),
      lin_same_classes(["we_baptize"], BAP, "q(valid_form(baptism,we_baptize))", ("yes", "no"))],
     "the Greek passive univocal on the Trinity, the act unexpressed; We, another agent; the validity the response's", mode=B)
scen("BF3", LIN, "The form of baptism: you and te (BF3)", BAP,
     [info_all("info(opens(bf_en_i,bf_la_ego,r_plural))"), info_none("info(closes(bf_en_i")],
     "you opens a plural reading te closes", mode=B)
scen("BF4", LIN, "The form of baptism: a form corrupt (BF4)", BAP,
     [info_all("info(read_by_accommodation(bf_la_zachary))", "info(sense_lost(bf_la_matris))"),
      info_none("read_by_accommodation(bf_la_matris)", "sense_lost(bf_la_zachary)")],
     "corrupt at the end, read by accommodation; at the start, its sense lost", mode=B)
scen("BF5", LIN, "The form of baptism with the Grammar of the Icon (BF5)", BAP + ["linguae_icon_baptism"],
     [info_all("violation(cophase_as_agent(bf_en_we))", "violation(cophase_as_agent(bf_it_we))"),
      info_none("cophase_as_agent(bf_la_ego)", "cophase_as_agent(bf_en_i)", "cophase_as_agent(bf_la_greek)"),
      cls("q(valid_form(baptism,we_baptize))=no", "settled"),
      lin_on(BAP, info_none("cophase_as_agent")),
      lin_on([], info_all("violation(cophase_as_agent(f_x))", "violation(cophase_as_agent(f_y))"),
             info_none("cophase_as_agent(f_z)"),
             facts="uses(icon). side_by_side(s_a,s_b,t_x). acton(d_a,d_b). form_agent(f_x,s_a,c). "
                   "form_agent(f_y,s_b,c). form_agent(f_z,d_a,c).")],
     "the assembly named as the one who acts puts S in D's place: refused; the validity the response's; without the "
     "theory nothing changes", mode=B)

scen("SG0", LIN, "Forms in sign: the empirical questions (SG0)", SGN,
     [info_all("info(fixed_by_finding(q(human_language(ase)),yes,hickok_1996))",
               "info(fixed_by_finding(q(signifies_by_convention(ase)),yes,klima_bellugi_1979t))"),
      lin_on(SGN + ["asof_1970"], info_all("info(fixed_by_finding(q(human_language(ase)),yes,stokoe_1960))"),
             info_none("fixed_by_finding(q(signifies_by_convention")),
      lin_on(SGN, info_all("info(fixed_by_finding(q(signifies_by_convention(ase)),yes,frishberg_1975))"),
             facts="asof(1975). custom_asof."),
      lin_on(SGN, info_none("fixed_by_finding"), facts="asof(1959). custom_asof."),
      classified(SGN + ["asof_1950"], ("q(human_language(ase))=yes", "open"), ("q(human_language(ase))=no", "open"),
                 ("q(signifies_by_convention(ase))=yes", "open"), ("q(signifies_by_convention(ase))=no", "open")),
      lin_on(SGN + ["cand_finding_on_form"], info_all("violation(finding_on_a_doctrine(stokoe_1960,q(valid_form(baptism,sg_g1))))",
                                                     "violation(finding_on_a_doctrine(stokoe_1960,q(verba_1104(ase))))")),
      lin_on(SGN + ["linguae_signed_homesign", "rt_lingual"], info_all("info(read_as_signa(sg_home))")),
      lin_on(SGN + ["linguae_signed_homesign", "rt_vocal"], info_all("info(read_as_signa(sg_home))"))],
     "fixed yes from 1960 and 1975 by findings, then by later ones; as of 1950 neither, Seton weighing nothing; a "
     "finding on a doctrine or a canon's reading refused; a homesign's signs never verba", mode=B)
scen("SGR", LIN, "Forms in sign: two runtimes for verbum (SG-R)", SGC,
     [lin_assumed(VOCAL, LINGUAL), lin_paired("read_as(aquinas_verbum,thomas_definition)", VOCAL),
      lin_on(SGC + ["rt_vocal"], lin_every(VOCAL), info_all("info(read_as_signa(sg_g1))")),
      lin_on(SGC + ["rt_lingual"], lin_every(LINGUAL), info_all("info(read_as_verba(sg_g1))")),
      lin_on(SGC + ["rt_thomist"], lin_assumed(VOCAL, LINGUAL)),
      lin_on(SGC + ["cand_verba_two_ways", "rt_vocal"], info_all("violation(verba_read_two_ways(c1104_2,c849))")),
      lin_on(SGC + ["cand_verba_two_ways", "rt_lingual"], info_none("verba_read_two_ways")),
      lin_on(SGN + ["linguae_consent_signs", "rt_vocal"], info_all("violation(verba_read_two_ways(c1104_2,c849))"),
             facts="canon_verbum(c849,lingual)."),
      lin_on(SGN + ["linguae_consent_signs", "rt_vocal"], info_none("verba_read_two_ways"))],
     "vocal: signs never a verborum forma; lingual: from the findings' year; default and thomist both, Thomas twice; "
     "each branch names its part; verba read two ways refused", mode=B)
scen("SG1", LIN, "Forms in sign: IX-1 BAPTIZE IX-2 (SG1)", SGN,
     [info_all("info(feature(sg_g1,minister_act,expressed))", "info(feature(sg_g1,trinity_invoked,yes))",
               "info(mode(sg_g1,bf_la_ego,univocal))", "info(closes(sg_g1,bf_en_i,r_plural))",
               "info(feature(sg_g1,addressee,deictic))", "info(gloss_presumes_category(sg_g1,second_person))",
               "info(feature_mode(sg_g1,bf_en_i,minister_act,univocal))"),
      info_none("info(opens(sg_g1,bf_la_ego", "info(closes(sg_g1,bf_la_ego")],
     "the act expressed, the Trinity yes, number closed: the point renders te univocally on number; the addressee "
     "deictic; IX-2 presumes a category", mode=B)
scen("SG2", LIN, "Forms in sign: Signing Exact English (SG2)", SGN + ["linguae_signed_see"],
     [info_all("info(no_mode(sg_see,bf_en_i,code))", "info(opens(sg_see,bf_la_ego,r_plural))",
               "info(no_claimant(sg_see,see_1972))"),
      info_none("info(mode(sg_see,bf_en_i", "no_claimant(sg_g1")],
     "the code opens the plural as English does; no mode between it and English; no claimant of its own", mode=B)
scen("SG3", LIN, "Forms in sign: no subject token; FATHER (SG3)", SGN + ["linguae_signed_subject", "linguae_signed_father"],
     [lin_assumed("assumed_fact(feature(sg_g1,minister_act,expressed))", "assumed_fact(feature(sg_g1,minister_act,unexpressed))"),
      lin_assumed("assumed_fact(feature(sg_g1,trinity_invoked,yes))", "assumed_fact(feature(sg_g1,trinity_invoked,no))"),
      cls("q(valid_form(baptism,sg_g1))=yes", "open"), cls("q(valid_form(baptism,sg_g1))=no", "open"), clean_branches,
      lin_on(SGC + ["linguae_signed_father", "rt_lingual"], in_branches("info(to_be_baptized(infant_d,conditionally))", status="main"),
             in_branches("info(to_be_baptized(infant_d,conditionally))", values=("q(form_substance(baptism))=no",), present=False)),
      lin_on(SGC + ["linguae_signed_subject", "rt_lingual"], in_branches("info(to_be_baptized(infant_d,conditionally))", status="main"))],
     "the act disputed, both values run; FATHER a human father under the everyday lexicon, the Trinity no; the "
     "validity keeps every branch; each lexicon dated", mode=B)
scen("SG4", LIN, "Forms in sign: notations and their claimants (SG4)", SGN + ["linguae_signed_subject", "linguae_signed_moods"],
     [info_all("info(notation_gap(sg_g1,gloss_a,nonmanual))", "info(notation_gap(sg_g1,stokoe_c,nonmanual))",
               "info(notation_partial(sg_g1,hamnosys_b,nonmanual))", "info(transcriptions_differ(sg_g1,gloss_a,gloss_h))",
               "info(meaning_not_supplied(sg_g1,asl_signbank))",
               "info(clause_read(sg_stmt,gloss_f,unmarked))", "info(clause_read(sg_ynq,gloss_f,unmarked))",
               "info(clause_read(sg_stmt,elan_g,statement))", "info(clause_read(sg_ynq,elan_g,yes_no_question))"),
      info_none("notation_gap(sg_g1,signwriting_d", "notation_gap(sg_g1,elan_e", "notation_gap(sg_g1,hamnosys_b",
                "clause_read(sg_ynq,gloss_f,yes_no"),
      lin_assumed("assumed_fact(feature(sg_g1,minister_act,expressed))", "assumed_fact(feature(sg_g1,minister_act,unexpressed))"),
      lin_on(SGN + ["cand_gloss_as_word"], info_all("violation(gloss_as_word(sg_g1))"))],
     "a gloss entered as a word refused; the non-manual gap for Stokoe and a bare gloss, partial for HamNoSys, none for "
     "SignWriting or a tiered annotation; one gloss gives one reading of two performances, the annotation two; "
     "transcriptions that differ both run; a database's token gives no meaning", mode=B)
scen("SG5", LIN, "Forms in sign: the lay baptism (SG5)", SGC,
     [only_with("info(to_be_baptized(infant_d,conditionally))", VOCAL),
      lin_on(SGC + ["rt_vocal"], info_all("info(to_be_baptized(infant_d,conditionally))")),
      lin_on(SGC + ["rt_lingual"], info_none("to_be_baptized")),
      cls("q(valid_form(baptism,sg_g1))=yes", "open"), cls("q(valid_form(baptism,sg_g1))=no", "open"),
      info_all("info(only_validity_required(bap_signed))"), info_none("rite_read(bap_signed"),
      lin_on(SGC + ["cand_rubric_answers"], info_all("violation(teaching_from_law(q(valid_form(baptism,sg_g1))))")),
      classified(SGN + ["linguae_signed_practice"], ("q(voice_required(celebrant))=yes", "settled"),
                 ("q(voice_required(celebrant))=no", "shadow"), ("q(sign_admitted(party))=yes", "settled")),
      info_all("info(practice_claim(peters_2008,unvoiced_practice,q(valid_form(baptism,sg_g1))))"),
      lin_on(SGN + ["cand_validity_from_practice"],
             info_all("violation(validity_from_practice(cand_practice_v,q(valid_form(baptism,sg_g1))))"))],
     "no source answers the form; c. 869 §1 conditional on rt_vocal, not on rt_lingual, both on default; the rubric "
     "as answering refused, as practice weighing at its tier; the practice's teaching a claim of no tier; urgent "
     "necessity, no question of the text (c. 850)", mode=B)
scen("SG5a", LIN, "Forms in sign: consecration (SG5a)", SGN + ["linguae_signed_mass"],
     [classified(SGN + ["linguae_signed_mass", "rt_vocal"], ("q(valid_form(eucharist,ase_institution))=no", "settled"),
                 ("q(valid_form(eucharist,ase_institution))=yes", "shadow")),
      classified(SGN + ["linguae_signed_mass", "rt_lingual"], ("q(valid_form(eucharist,ase_institution))=no", "open"),
                 ("q(valid_form(eucharist,ase_institution))=yes", "open")),
      info_all("info(dated_two_ways(holy_office_1957,19570308,19570523))"),
      lin_paired("read_as(holy_office_1957,pronuntiat_spoken)", VOCAL),
      lin_paired("read_as(holy_office_1957,pronuntiat_expressed)", LINGUAL)],
     "the Holy Office's response gives a value only on rt_vocal; on rt_lingual both stay; its two dates claimed", mode=B)
CONSENT = ("marriage(", "consent_received(", "consent_not_received(", "assistance_illicit(", "assistant_outside_encoding(",
           "recipit_read(")
scen("SG6", LIN, "Forms in sign: consent (SG6)", SGN + ["linguae_consent_signs"],
     [info_all("info(marriage(m_sa,valid_form))", "info(consent_received(m_sa))"), info_none("assistant_outside_encoding"),
      lin_on(SGN + ["linguae_consent_signs", "rt_vocal"], info_all("info(consent_illicit(m_sa,party_2,c1104_2))",
                                                                  "info(marriage(m_sa,valid_form))"),
             info_none("consent_illicit(m_sa,party_1")),
      lin_on(SGN + ["linguae_consent_signs", "rt_lingual"], info_none("consent_illicit"), info_all("info(marriage(m_sa,valid_form))")),
      lin_on(SGN + ["linguae_consent_outside", "rt_vocal"], in_branches("consent_illicit(m_sc,party_9", assume=("assumed_fact(can_speak(party_9))",)),
             in_branches("consent_illicit(m_sc,party_9", assume=("assumed_fact(false(can_speak(party_9)))",), present=False),
             facts="disputed(can_speak(party_9))."),
      lin_on(SGN + ["linguae_consent_interpreter"], info_all("info(assistance_illicit(m_sb,c1106))", "info(consent_received(m_sb))",
                                                             "info(marriage(m_sb,valid_form))", "info(marriage(m_sb2,valid_form))"),
             info_none("assistance_illicit(m_sb2")),
      lin_on(SGN + ["linguae_consent_outside"], info_all("info(assistant_outside_encoding(m_sc))"),
             under("recipit_read(m_sc,recipit_celebration)", info_all("info(marriage(m_sc,valid_form))")),
             under("recipit_read(m_sc,recipit_consent)", info_all("info(marriage(m_sc,invalid_form))"))),
      lin_on(SGN + ["linguae_consent_witnesses"], info_all("info(marriage(m_sd,valid_form))")),
      under("rite_read(m_sa,rite_changed)", info_all("info(illicit_change(pastor_sa,m_sa))")),
      under("rite_read(m_sa,rite_kept)", info_none("illicit_change(pastor_sa")),
      lin_on(SGN + ["linguae_consent_signs", "cand_guidelines_as_rite"], info_all("violation(rite_without_recognitio(usccb_2017,m_sa))"))],
     "c. 1104 §2 never invalidates; illicit on rt_vocal for the party who can speak; received, the form valid; through "
     "an interpreter, licit where his trustworthiness is entered; no ASL and no interpreter, two readings of recipit; "
     "the witnesses' tongue enters nothing; the rite kept or changed; the Guidelines no rite", mode=B)
scen("SG7", LIN, "Forms in sign: penance (SG7)", SGN + ["linguae_signed_penance"],
     [lin_assumed(VOCAL, LINGUAL), info_all("info(confession_by_form(abs_signed,penitent_p,sg_confession))"),
      under("rite_read(abs_signed,rite_changed)", info_all("info(illicit_change(deaf_priest_p,abs_signed))")),
      lin_on([], lambda r: (not any(a.startswith("read_as(verbum") for b in r["branches"] for a in b["assume"]),
                            "a confession in sign raises no reading of verba"),
             facts="encoding(ase_x,ase,1817,2026). encoding_route(ase_x,manual). text_of(t_c,s_c,ase_x,2026). "
                   "form_in(f_c,t_c,n(1)). confession_given(a_c,p_c,f_c)."),
      lin_on(SGN + ["linguae_confession_interpreter"], clean_branches,
             info_all("info(bound_to_secrecy(interp_q,conf_i))", "info(secret_under_penalty(interp_q,conf_i))")),
      lin_on(SGN + ["linguae_confession_interpreter", "cand_interpreter_required"],
             info_all("violation(interpreter_required(penitent_q,conf_i))"))],
     "the penitent's signed confession raises no dispute; the unvoiced absolution carries both readings; through an "
     "interpreter, secrecy under penalty, cleanly; an obligation to use one refused", mode=B)
scen("SG8", LIN, "Forms in sign: the sign's likeness (SG8)", SGC,
     [info_all("info(iconic_manner_differs(sg_g1,bap_signed))"), clean_branches],
     "BAPTIZE as immersion beside poured water: reported, never a refusal", mode=B)
scen("SG9", LIN, "Forms in sign: ASL in time (SG9)", SGN,
     [clean_branches, lin_no_asl_approval,
      lin_on(SGN + ["cand_asl_in_time"], info_all("violation(lexicon_out_of_span(epee_1776,ase_2026))",
                                                 "violation(variety_entered_as_descent(ase_black,ase_2026))"))],
     "every lexicon dated and in its span; Black ASL a variety, not descended; no approval of a signed version entered", mode=B)
scen("SG10", LIN, "Forms in sign: the route never enters c. 1108 (SG10)", SGN + ["linguae_consent_symmetry"],
     [lin_symmetric("m_deaf", "m_hear", CONSENT), info_all("info(marriage(m_deaf,valid_form))"),
      info_none("read_as_signa(en_consent")],
     "a deaf assistant receiving spoken consent through an interpreter computes as a hearing one receiving signed "
     "consent through one", mode=B)

scen("LM1", LIN, "Claims of a mode, rules of hearing (LM1)", PMU + ["cand_mode_fixed", "linguae_heard_by_rule"],
     [info_all("violation(mode_fixed_by_claim(arinze_2006,pm_en11_many,pm_la02))",
               "info(heard_by_rule(g_en_2011,pm_en73_all,cdf_1974))"),
      info_none("closes_for(g_en_2011,pm_en73_all", "interpretation_for(g_en_2011,pm_en73_all"),
      lin_on(PMU + ["linguae_heard_by_rule", "regime_clp"],
             in_branches("info(faithful_for(g_en_2011,pm_en73_all,pm_la70))",
                         assume=("assumed_fact(false(inserted(pm_en73_all,pm_la70)))",)))],
     "a mode claim treated as fixing refused; under the rule of 1974 the hearer admits exactly the host's readings", mode=B)
scen("LM2", LIN, "Et cum spiritu tuo under two regimes (LM2)", ["linguae_ecst", "regime_la"],
     [info_all("info(not_faithful(ecst_en73,ecst_la70))", "info(faithful(ecst_en11,ecst_la02))",
               "info(interpretation(ecst_en73,ecst_la70,r_person))"),
      lin_on(["linguae_ecst", "regime_clp"], info_all("info(faithful_for(g_en_1973,ecst_en73,ecst_la70))"))],
     "the same pair unfaithful under LA, faithful under CLP, where only the message and the hearing are read", mode=B)
scen("LM3", LIN, "A hearing of a person, or by no lexicon (LM3)", PMU + ["cand_hearings"],
     [info_all("violation(hearing_of_a_person(reader_x))", "violation(hearing_without_lexicon(g_nolex))"),
      lin_on(PMU, info_none("hearing_of_a_person", "hearing_without_lexicon"))],
     "refused", mode=B)

_X_TEXTS = ("encoding(e_x,xxx,1900,2000). encoding(e_y,yyy,1900,2000). text_of(t_a,s_x,e_x,1950). "
            "form_in(f_a,t_a,n(1)). lexicon(lx,e_x,1950,dictionary). lexicon(ly,e_y,1950,dictionary). ")
scen("LX1", LIN, "The library's mechanics, beside the predictions", [],
     [lin_on(["rt_saussure"], info_all("info(mode(f_b,f_a,univocal))", "info(mode_for(g_x,f_b,f_a,univocal))"),
             facts=_X_TEXTS + "text_of(t_b,s_x,e_x,1960). form_in(f_b,t_b,n(1)). renders(f_b,f_a). "
                              "signifies((f_a;f_b),w_x,lx). hears_in(g_x,e_x,lx)."),
      lin_on([], info_all("info(extent(f_b,f_a,narrower))", "info(mode(f_b,f_a,analogical))"),
             facts=_X_TEXTS + "text_of(t_b,s_x,e_y,1960). form_in(f_b,t_b,n(1)). renders(f_b,f_a). signifies(f_a,w_a,lx). "
                              "signifies(f_b,w_b,ly). analogous(w_b,w_a,attribution,c). broader(w_a,w_b,c)."),
      lin_on([], info_all("info(gap(f_a,t_b))", "info(lost_in(a_x,e_y,p_x,gap))"),
             facts=_X_TEXTS + "text_of(t_b,s_x,e_y,1960). made_from(t_b,t_a). rests_on_form(a_x,p_x,f_a)."),
      lin_on([], info_all("violation(analogy_without_kind(w_a,w_b))", "violation(word_dated(w_a))", "violation(word_dated(w_b))"),
             facts="analogous(w_a,w_b,likeness,c). date_claim(w_a,1900). date_claim(w_b,1900)."),
      lin_on([], info_all("violation(equivocation_carried(f_b,f_a))"),
             facts=_X_TEXTS + "text_of(t_b,s_x,e_y,1960). form_in(f_b,t_b,n(1)). renders(f_b,f_a). signifies(f_a,w_a,lx). "
                              "signifies(f_b,w_b,ly). carries(w_b,w_a,p_x)."),
      lin_on([], info_all("violation(meaning_without_lexicon(f_a,nolex))"), facts=_X_TEXTS + "signifies(f_a,w_c,nolex)."),
      lin_on([], info_all("violation(lexicon_out_of_span(lx_late,e_x))"), info_none("lexicon_out_of_span(lx,"),
             facts=_X_TEXTS + "lexicon(lx_late,e_x,2010,dictionary)."),
      lin_on([], info_all("info(transcriptions_differ(f_t,n_a,n_b))", "info(transcriptions_differ(f_u,n_a,n_b))"),
             info_none("transcriptions_differ(f_v"),
             facts="notated((f_t;f_u;f_v),(n_a;n_b),c). token(f_t,n_a,1,x). token(f_t,n_b,1,y). "
                   "token(f_u,n_a,(1;2),x). token(f_u,n_b,1,x). token(f_v,(n_a;n_b),1,x)."),
      lin_on(["regime_la"], info_all("info(not_faithful(f_b,f_a))", "info(not_faithful(f_c,f_a))"),
             facts=_X_TEXTS + "text_of(t_b,s_x,e_y,1960). form_in((f_b;f_c),t_b,n(1)). renders((f_b;f_c),f_a). "
                              "unrendered(f_b,f_a,w_a). order_changed(f_c,f_a,c)."),
      lin_on(PMU, info_all("info(mode_claim_differs(arinze_2006,pm_en73_all,pm_la70))"),
             facts="mode_claim(arinze_2006,pm_en73_all,pm_la70,equivocal,word).")],
     "univocal within one encoding on rt_saussure; narrower; a gap where a text made from the host lacks the form; "
     "an analogy of no kind; carriage on an equivocal pair; a meaning by no lexicon; LA's words and order; a claim "
     "that differs", mode=B)
_RECV = ("today(20261023). pastor_of(pastor_x,parish_x). "
         "marriage(m_x1,priest_x1,20260601). spouse(m_x1,(p_1;p_2)). baptized_in((p_1;p_2),catholic). held_in(m_x1,parish_x). "
         "witnesses(m_x1,2). delegation(dl_1,pastor_x,priest_x1,m_x1,20260501). "
         "marriage(m_x2,priest_x2,20260601). spouse(m_x2,(p_3;p_4)). baptized_in((p_3;p_4),catholic). priest(priest_x2). "
         "witnesses(m_x2,2). common_error(m_x2). "
         "marriage(m_x3,priest_x3,20260601). spouse(m_x3,(p_5;p_6)). baptized_in(p_5,catholic). baptized_in(p_6,orthodox_x). "
         "eastern_noncatholic_church(orthodox_x). priest(priest_x3). ")
scen("LX2", LIN, "c. 1108 §2 in every variant of the form", [],
     [lin_on([], info_all("info(marriage(m_x1,valid_form))", "info(marriage(m_x2,valid_form))", "info(marriage(m_x3,valid_form))"),
             facts=_RECV),
      lin_on([], info_all("info(marriage(m_x1,invalid_form))", "info(marriage(m_x2,invalid_form))", "info(marriage(m_x3,invalid_form))",
                          "info(consent_not_received(m_x1))"), facts=_RECV + "assistant_perceived((m_x1;m_x2;m_x3),consent,no)."),
      lin_on([], in_branches("info(marriage(m_x1,valid_form))", assume=("assumed_fact(assistant_perceived(m_x1,consent))",)),
             in_branches("info(marriage(m_x1,invalid_form))", assume=("assumed_fact(false(assistant_perceived(m_x1,consent)))",)),
             facts=_RECV + "assistant_perceived(m_x1,consent,disputed).")],
     "a delegate, common error, a sacred minister in a mixed marriage: each assists validly, and none where the consent "
     "is not received (the pastor in his territory: SG6)", mode=B)
scen("LP1", LIN, "An approval answers no question of carriage (the pair)", PMU + ["linguae_pro_multis_canon", "cand_approval_answers"],
     [info_all("violation(teaching_from_law(q(carries(missal_en_2011,missal_la_2002))))",
               "violation(teaching_from_law(q(carries(pm_en11_many,pm_la02))))"),
      lin_on(PMU + ["linguae_pro_multis_canon"], info_none("teaching_from_law"))],
     "whether a version carries its source is not law's: entered as answered by an approval, refused", mode=B)

# ---------- A question no source answers, shown apart (TTC-REPAIRS5) ---------
# Predictions committed and stamped first: docs/research/repairs5-preregistration.md.
RF = "repairs"
RF_SG = "q(valid_form(baptism,sg_g1))"
scen("RF1", RF, "A question only a claim of practice speaks to is unanswered, not lacking (TTC-REPAIRS5)", SGN,
     [shown(SGN, ("frontier/2",), f"frontier(unanswered,by_practice_only({RF_SG}))",
            absent=(f"frontier(theology,question_without_sources({RF_SG}))",))],
     "the signed form's validity on the unanswered frontier, and off the theological one")
scen("RF2", RF, "A question with no source and no claim stays on the theological frontier (TTC-REPAIRS5)", [],
     [shown([], ("frontier/2",), "frontier(theology,question_without_sources(q(rf_z)))",
            facts="question(q(rf_z)). value(q(rf_z),(a;b)).",
            absent=("frontier(unanswered,by_practice_only(q(rf_z)))",)),
      shown([], ("frontier/2",), facts="question(q(rf_y)). value(q(rf_y),(a;b)). source(rf_s,5,truth,2000). "
                                       "supports(rf_s,q(rf_y),a). practice_teaches(rf_c,rf_p,q(rf_y)).",
            absent=("frontier(unanswered,by_practice_only(q(rf_y)))",
                    "frontier(theology,question_without_sources(q(rf_y)))")),
      shown([], ("frontier/2",), facts="question(q(rf_x)). value(q(rf_x),(a;b)). default(q(rf_x),a). "
                                       "practice_teaches(rf_c,rf_p,q(rf_x)).",
            absent=("frontier(unanswered,by_practice_only(q(rf_x)))",))],
     "no source and no claim: question_without_sources, as before; a source, or a default, beside a claim of "
     "practice: neither")


# ---------- The four causes: modernities as runtimes (TTC-MODERNITY) ---------
# Predictions committed and stamped first: docs/research/modernity-preregistration.md.
# The suite names PR1-PR8 MP1-MP8 (PR is the pair's), and MM pins the
# library's mechanics. A run's reports are read by a projected solve
# (mod_project): the base's own #show statements set aside, only the atoms
# asked for shown, one model per distinct projection. So a run of 2,048
# branches, or the 1,024 horizons of horizons_all, is read in one solve.

MOD = "modernity"
MPC = ["modernity_property"]
RN9C = MPC + ["linguae_rn9"]
SW6 = ("rn7_from_form", "rn7_from_self", "rn7_under_providence", "rn13_as_command", "rn8_from_sustenance",
       "rn22_as_stewardship")
CONFIGS = ((),) + tuple((s,) for s in SW6)
HEAR_LOCKE = "hear_en_1891_locke"
# The retired switch (TTC-LINGUAE RN4), kept only as a fixture: rn9 heard in the English of 1891 under Locke.
RN9_IN_ENGLISH = ("reading_of(rn9_in_english,rn9). argues_from(rn9_in_english,efficient,human). "
                  "argues_from(rn9_in_english,material,nature). argues_from(rn9_in_english,final,self).")
FORTIN = "concludes_heard(rn9,lex_en_locke_1891,fortin_1992)."
CAUSE_PARTS = {"ends_in_nature": ("final", "nature"), "forms_in_nature": ("formal", "nature"),
               "ends_by_god_physics": ("final", "god_physics"), "ends_by_god_ethics": ("final", "god_ethics"),
               "ends_of_human_nature": ("final", "human"), "soul_as_form": ("formal", "human"),
               "ends_desired": ("final", "will"), "self_preservation": ("final", "self"),
               "object_as_form": ("formal", "will"), "form_of_law": ("formal", "reason")}
PHYSICS = {"ends_in_nature", "forms_in_nature", "ends_by_god_physics"}
REPORT_TERMS = ("info(without_reason(Q,V))", "info(sole_reason(S,A,Q,V))", "info(contrary_reasoned(Q,V,W))")
GUEST_TERMS = ("info(guest_without_reason(Q,V))", "info(guest_sole_reason(S,A,Q,V))")
# The runtimes, by the groups the predictions name (PR1, PR7, PH1).
SCHOOL_RTS = ("thomist", "scotist", "suarezian", "palamite")
MIDDLE = ("scotus_dpp", "ockham", "suarez_dm23", "grotius", "bacon", "descartes")
RECORD = ("scotus_dpp", "ockham", "suarez_dm23", "bacon", "descartes", "hobbes", "spinoza", "hooker", "grotius",
          "locke", "leibniz", "kant")
READINGS = ("scotus_will", "ockham_will", "ockham_nominal", "descartes_will", "grotius_etiamsi", "kant_humanity",
            "kant_mm")
WILL_LINE = {"suarez_wl": "suarez_dm23", "hobbes_wl": "hobbes", "spinoza_wl": "spinoza", "locke_wl": "locke",
             "leibniz_wl": "leibniz"}
HEARERS = ("episcopate_1891", "social_catholic", "smith", "angers", "george", "george_hn", "marx", "marx_social",
           "lassalle")
WILL_READINGS = ("scotus_will", "ockham_will", "descartes_will")
THOMIST_GROUP = SCHOOL_RTS + ("default", "saussure", "vocal", "lingual", "hooker", "leibniz", "leibniz_wl") + MIDDLE \
    + ("ockham_nominal", "suarez_wl", "episcopate_1891", "social_catholic", "angers", "george_hn")
LOCKE_LIKE = ("locke", "locke_wl", "smith", "george")
LOCKE_GROUP = LOCKE_LIKE + WILL_READINGS
HOBBES_LIKE = ("hobbes", "spinoza", "hobbes_wl", "spinoza_wl", "marx_social", "kant_mm")
HOBBES_GROUP = HOBBES_LIKE + ("kant", "bare")
HUMAN_ENDS = ("marx", "lassalle", "grotius_etiamsi", "kant_humanity")
POSITIVE = tuple(f"{s}_{q}" for s in ("suarez_dl", "grotius_dibp", "hobbes_l24") for q in ("products", "land"))

_SHOW_STMT = re.compile(r"#show\s+[^.]*\.")
_MOD_CACHE: dict = {}


def mod_project(parts, shows, facts=""):
    """The distinct projections of a run onto `shows` (terms such as info(sole_reason(S,A,Q,V)), shown where
    derived, or name/arity), as a frozenset of frozensets: one where every branch gives the same."""
    import hashlib

    import clingo
    texts = E.base_texts()
    extra = E._ADD.get()
    key = (hashlib.sha256("\0".join(list(texts.values()) + [extra]).encode()).hexdigest(), tuple(parts),
           tuple(shows), facts)
    if key not in _MOD_CACHE:
        unknown = [p for p in parts if p not in E.known_parts() and not E.is_runtime(p)]
        if unknown:
            raise E.SnippetError(f"unknown part(s): {', '.join(unknown)}", "parts", "parts")
        E.check_snippet(facts)
        E.conclusion_gate(facts)
        ctl = clingo.Control(["0", "--project"], logger=lambda code, msg: None)
        for t in list(texts.values()) + ([extra] if extra else []):
            ctl.add("base", [], _SHOW_STMT.sub("", t))
        ctl.add("base", [], " ".join(["#show."] + [f"#show {s} : {s}." if "(" in s else f"#show {s}." for s in shows]))
        if facts:
            ctl.add("user", [], facts)
        ctl.ground([("base", [])] + [(p, []) for p in E.expand_runtimes(parts)] + ([("user", [])] if facts else []))
        out = set()
        ctl.solve(on_model=lambda m: out.add(frozenset(str(s) for s in m.symbols(shown=True))))
        if len(_MOD_CACHE) > 20000:
            _MOD_CACHE.clear()
        _MOD_CACHE[key] = frozenset(out)
    return _MOD_CACHE[key]


AUTH_SHOWS = ("holds/2", "branch/1", "cleaved_by/1", "reintegrates_if_relaxed/1", "weight/2", "verdict/2", "info/1")
# One projection per kind of run, so that the checks share their solves: a run of the case (its authority, its
# notes and reports, what is available), a hearing (what crosses, the reports, the lexicons' branches), a VM.
COMMITTED_SHOWS = AUTH_SHOWS + ("available_as/2",)
HEARING_SHOWS = REPORT_TERMS + ("info(heard_short(G,A))", "info(heard_by_analogy(G,A,P,K))",
                                "info(lost_by_horizon(here,A,P))", "info(lost_for(here,A,P,W))",
                                "info(carried_for(here,A,P))", "info(mode_for(here,F2,F1,M))", "available_as/2",
                                "assumed_fact/1")
VM_SHOWS = REPORT_TERMS + GUEST_TERMS + ("info(heard_by_analogy(G,A,P,K))", "info(lost_by_horizon(G,A,P))",
                                         "info(lost_for(G,A,P,W))", "available_as/2", "guest_available_as/2",
                                         "assumed_fact/1")
REPORT_PREFIX = ("info(without_reason(", "info(sole_reason(", "info(contrary_reasoned(")
GUEST_PREFIX = ("info(guest_without_reason(", "info(guest_sole_reason(")


def mod_run(parts, facts=""):
    """a run's projection, by its kind: a VM where a part vm_R is loaded, a hearing where linguae_rn9 is, or else
    the case's committed run"""
    parts = list(parts)
    shows = (VM_SHOWS if any(p.startswith("vm_") for p in parts) else
             HEARING_SHOWS if "linguae_rn9" in parts else COMMITTED_SHOWS)
    return mod_project(parts, shows, facts)


def mod_reports(parts, facts="", prefix=REPORT_PREFIX):
    """the reports of a run (the guest's with prefix=GUEST_PREFIX), a frozenset over its branches"""
    return frozenset(frozenset(a for a in m if a.startswith(prefix)) for m in mod_run(parts, facts))


def mod_available(parts, facts=""):
    """the arguments available in every branch of a run"""
    sets = [{E.split_args(a)[1][0] for a in m if a.startswith("available_as(")} for m in mod_run(parts, facts)]
    return set.intersection(*sets) if sets else set()


def horizon(rt):
    """the cause parts a runtime holds"""
    return frozenset(p for p in E.RUNTIMES[rt] if p in CAUSE_PARTS)


# Every runtime is run on the case alone and beside all six switches (RUN_CONFIGS); each switch alone is read off
# horizons_all, every horizon at once, and MM4 checks that each runtime gives on the case what its horizon gives
# there. A VM is run for one guest of each horizon: two parts vm_R of one horizon differ only in vm_guest's name,
# which no rule reads but for there being a guest, and VM3 checks that each guest has its runtime's horizon.
RUN_CONFIGS = ((), SW6)


def rt_report(rt, sw=()):
    """a runtime's reports on the case: its own run alone or beside all six, else its horizon's over horizons_all"""
    sw = tuple(sw)
    return mod_reports(_rt(rt, *sw)) if sw in RUN_CONFIGS else phase_map(MPC + list(sw))[horizon(rt)]


def guest_of(rt):
    """the part vm_R for the first runtime of rt's horizon"""
    return "vm_" + next(r for r in E.RUNTIMES if horizon(r) == horizon(rt))


def _rt(rt, *parts):
    return MPC + [f"rt_{rt}"] + list(parts)


def _sole(a, q, v="natural"):
    return f"info(sole_reason(rn_1891,{a},q({q}),{v}))"


def _without(q, v):
    return f"info(without_reason(q({q}),{v}))"


RN10 = {_sole("rn10_products", "property_in_products"), _sole("rn10_land", "property_in_land")}


def mp_expected(rt, sw=None, hearing=None):
    """the reports PR4, PR5 and PR6 predict for a runtime under one switch or none, and the Lockean hearing (with
    Fortin's claim); bare as CV2, the will line as its twin (DG6)"""
    out = set()
    if rt in HOBBES_LIKE + LOCKE_GROUP + ("kant", "bare"):
        rn10 = set(RN10)
        if rt in ("kant", "bare"):
            pass
        elif sw == "rn7_from_self":
            rn10 = set()
        elif rt in LOCKE_GROUP and sw in ("rn7_under_providence", "rn13_as_command"):
            rn10 = set()
        elif rt in WILL_READINGS and sw == "rn7_from_form":
            rn10 = set()
        elif hearing == HEAR_LOCKE:
            rn10 = {_sole("rn10_products", "property_in_products")}
        out |= rn10
    if rt in ("kant", "bare") or (rt in HOBBES_LIKE and sw != "rn8_from_sustenance"):
        out.add(_without("use_common", "yes"))
    if (rt in LOCKE_GROUP and sw != "rn22_as_stewardship") or (rt in HOBBES_LIKE and sw == "rn8_from_sustenance"):
        out.add(_sole("rn8", "use_common", "yes"))
    if (rt in ("marx", "lassalle", "grotius_etiamsi") and sw != "rn8_from_sustenance") or rt == "kant_humanity":
        out.add(_sole("rn22", "use_common", "yes"))
    if "ends_of_human_nature" not in E.RUNTIMES[rt]:
        out.add(_without("ip_absolute", "no"))
    return frozenset({frozenset(out)})


def _mod(test):
    """a check from a function returning the failures: none where the prediction holds"""
    def chk(_r):
        bad = list(test())
        more = f" (and {len(bad) - 4} more)" if len(bad) > 4 else ""
        return not bad, "as predicted" if not bad else "; ".join(str(b) for b in bad[:4]) + more
    return chk


def _sw(sw):
    return list(sw) if isinstance(sw, tuple) else [sw]


# ---------- CV: the library ----------
CAUSAE_INFO = ("info(without_reason(", "info(sole_reason(", "info(contrary_reasoned(", "info(guest_", "info(heard_",
               "info(lost_by_horizon(", "info(conversion_native(")


def _authority(rt, sw=()):
    """the case's authority on a runtime: each branch's values, status, cleaving, weights, verdicts and notes, the
    library's reports and the runtime's own notes (given without the case: palamite's manifested_through) aside"""
    own = set().union(*mod_project([f"rt_{rt}"], ("info/1",)))
    return frozenset(frozenset(a for a in m if not a.startswith(CAUSAE_INFO + ("available_as(",)) and a not in own)
                     for m in mod_run(_rt(rt, *sw)))


def cv1():
    r = solve(MPC, "branches")
    want = {"q(property_in_products)=natural": "settled", "q(property_in_products)=positive_addition": "shadow",
            "q(property_in_land)=natural": "settled", "q(property_in_land)=positive_addition": "shadow",
            "q(use_common)=yes": "settled", "q(ip_absolute)=no": "settled"}
    got = {qv: classify(r, qv) for qv in want}
    if got != want:
        yield got
    ref = _authority("default")
    for rt, sw in [(rt, sw) for rt in E.RUNTIMES for sw in RUN_CONFIGS] + [("default", (s,)) for s in SW6]:
        if _authority(rt, sw) != ref:
            yield (rt, sw)


UNTYPED = "argument(x_untyped,x_src,q(x_q),x_v)."


def cv2():
    want = {"rn10_products", "rn10_land"} | set(POSITIVE)
    for sw in CONFIGS:
        got = mod_available(_rt("bare", *sw))
        if got != want:
            yield ("available", sw, sorted(got ^ want))
        if mod_reports(_rt("bare", *sw)) != mp_expected("bare", sw[0] if sw else None):
            yield ("reports", sw)
    for rt in E.RUNTIMES:
        if "x_untyped" not in mod_available([f"rt_{rt}"], UNTYPED):
            yield ("untyped", rt)


def available_map(parts):
    """each horizon of horizons_all -> the arguments available in every branch"""
    pairs = {f"holds_cause({c},{d})": p for p, (c, d) in CAUSE_PARTS.items()}
    out: dict = {}
    for m in mod_project(phase_base() + list(parts), ("available_as/2", "holds_cause/2")):
        h = frozenset(pairs[a] for a in m if a in pairs)
        got = {E.split_args(a)[1][0] for a in m if a.startswith("available_as(")}
        out[h] = out[h] & got if h in out else got
    return out


def cv4():
    base = available_map(MPC)
    for s in SW6:
        now = available_map(MPC + [s])
        lost = [h for h in base if base[h] - now[h]]
        if lost:
            yield (s, len(lost))
    for rt in E.RUNTIMES:
        for sw in RUN_CONFIGS:
            if mod_available(_rt(rt, *sw)) != available_map(MPC + list(sw))[horizon(rt)]:
                yield (rt, sw, "not its horizon's")


MEASURE = ("violation(cause_converted(M,C,D))", "info(conversion_native(M))")
PHASE_BASE = ["horizons_all", "rt_bare"]


def phase_base():
    """horizons_all beside default's other parts: only the horizon varies"""
    return PHASE_BASE + [p for p in E.RUNTIMES["default"] if p not in CAUSE_PARTS]


def cv5():
    native = {"hobbes", "spinoza", "hobbes_wl", "spinoza_wl"}
    for rt in E.RUNTIMES:
        want = ({"info(conversion_native(adams_1907))"} if rt in native
                else {"violation(cause_converted(adams_1907,final,efficient))"})
        if mod_project(["modernity_measure", f"rt_{rt}"], MEASURE) != frozenset({frozenset(want)}):
            yield rt
    ms = mod_project(phase_base() + ["modernity_measure"], MEASURE + ("holds_cause/2",))
    n = sum("info(conversion_native(adams_1907))" in m for m in ms)
    if len(ms) != 1024 or n * 128 != 1024:
        yield f"native in {n} of {len(ms)} horizons"


scen("CV1", MOD, "Authority reads no argument (CV1)", MPC, [_mod(cv1)],
     "products and land natural, settled, the positive addition a shadow; use common yes, IP absolute no, settled; "
     "no holds/2, cleaving, note or obligation differs between runtimes or switches")
scen("CV2", MOD, "On bare only the efficient and the material (CV2)", MPC, [_mod(cv2)],
     "an argument typed by nothing available on every runtime; on bare rn10_products, rn10_land and the six for "
     "the positive addition; use common and IP absolute without reason, rn10 sole, under every switch")
scen("CV3", MOD, "A typing outside the sorts (CV3)", MPC,
     [shown([], ("violation/1",), "violation(outside_domain(argues_from,2,teleology))",
            "violation(outside_domain(argues_from,3,cosmos))", "violation(outside_domain(measures_as,2,impetus))",
            "violation(outside_domain(measures_as,3,impetus))",
            facts="argues_from(x_cv3,teleology,human). argues_from(x_cv3,final,cosmos). "
                  "measures_as(m_cv3,impetus,final). measures_as(m_cv3,final,impetus).")],
     "outside_domain, as L gives for every slot")
scen("CV4", MOD, "A further reading never removes availability (CV4)", MPC, [_mod(cv4)],
     "with a switch loaded, every argument available without it stays available, on every runtime")
scen("CV5", MOD, "An end measured as a force (CV5)", ["modernity_measure"], [_mod(cv5)],
     "cause_converted refused on every runtime, bare included, save hobbes, spinoza, hobbes_wl and spinoza_wl, "
     "where conversion_native fires; one horizon in 128 native")


# ---------- DG: the DAG ----------
_L_OTHERS: dict = {}


def _runtime_text_without_ops(text, name):
    """schools.l with the runtime's own add, exclude and alter taken away"""
    out, inside = [], False
    for line in text.split("\n"):
        if line.startswith("runtime "):
            inside = line.split()[1] == name
        elif inside and line.startswith("  ") and line.split()[0] in ("add", "exclude", "alter"):
            continue
        elif line and not line.startswith(" "):
            inside = False
        out.append(line)
    return "\n".join(out)


def clash_set(name, text=None):
    """the parts on which a runtime's parents clash, its own add, exclude and alter taken away: ttc-l build's
    refusals of it, collected one by one (each found is then mentioned, so that the next is reached)"""
    from . import lang
    if not _L_OTHERS:
        _L_OTHERS.update({k: v for k, v in lang.sources().items() if k != "schools.lp"})
    text = _runtime_text_without_ops(text if text is not None else (lang.L_DIR / "schools.l").read_text(), name)
    found = []
    while True:
        srcs = dict(_L_OTHERS, **{"schools.lp": lang.parse(text, "schools.l")})
        try:
            lang.compile_runtimes(srcs)
            return found
        except lang.LError as exc:
            m = re.search(rf"runtime {name}: its parents \w+ and \w+ clash on (\w+)", str(exc))
            if not m:
                return found
            found.append(m.group(1))
            text = re.sub(rf"(?m)^(runtime {name}( extends [^\n]*)?)$", rf"\1\n  add {m.group(1)}", text, count=1)


DG1_WANT = {
    "suarez_dm23": {"ends_in_nature", "ends_by_god_physics", "object_as_form"},
    "descartes": {"ends_in_nature", "forms_in_nature"},
    "hobbes": {"ends_in_nature", "forms_in_nature", "ends_by_god_physics", "object_as_form"},
    "spinoza": {"ends_by_god_ethics", "ends_of_human_nature", "soul_as_form", "object_as_form"},
    "locke": {"ends_in_nature", "forms_in_nature", "ends_by_god_physics", "ends_by_god_ethics", "ends_of_human_nature",
              "soul_as_form", "object_as_form"},
    "leibniz": {"forms_in_nature", "ends_by_god_physics"},
    "angers": {"ends_in_nature", "forms_in_nature", "ends_of_human_nature", "soul_as_form", "object_as_form"},
}
DG4_WANT = {
    "suarez_wl": {"ends_in_nature", "ends_by_god_physics", "ends_of_human_nature", "object_as_form"},
    "hobbes_wl": {"ends_in_nature", "forms_in_nature", "ends_by_god_physics", "ends_of_human_nature", "object_as_form"},
    "spinoza_wl": {"ends_by_god_ethics", "soul_as_form"},
    "locke_wl": DG1_WANT["locke"],
    "leibniz_wl": {"forms_in_nature", "ends_by_god_physics", "ends_of_human_nature", "object_as_form"},
}


def dg_clashes(names, want):
    def test():
        for n in names:
            got = set(clash_set(n))
            if got != want.get(n, set()):
                yield (n, sorted(got ^ want.get(n, set())))
    return test


def dg2():
    raised = {n for n in RECORD if clash_set(n)}
    if raised != {"suarez_dm23", "descartes", "hobbes", "spinoza", "locke", "leibniz"}:
        yield sorted(raised)
    if not clash_set("angers"):
        yield "angers raises none"


def dg3():
    lk, hb = horizon("locke"), horizon("hobbes")
    if lk & PHYSICS != {"ends_by_god_physics"}:
        yield ("physics", sorted(lk & PHYSICS))
    if lk - PHYSICS != {"ends_by_god_ethics", "ends_desired", "self_preservation"}:
        yield ("ethics", sorted(lk - PHYSICS))
    # Found (scored red in part): two adds separate him from Hobbes, God's ends in nature as well as in ethics.
    if (lk - hb, hb - lk) != ({"ends_by_god_physics", "ends_by_god_ethics"}, set()):
        yield ("from hobbes", sorted(lk ^ hb))
    if (lk - PHYSICS) - (hb - PHYSICS) != {"ends_by_god_ethics"}:
        yield ("ethics from hobbes", sorted((lk - PHYSICS) ^ (hb - PHYSICS)))


def dg6():
    for wl, twin in WILL_LINE.items():
        if horizon(wl) != horizon(twin):
            yield (wl, sorted(horizon(wl) ^ horizon(twin)))
        for sw in RUN_CONFIGS:
            if mod_reports(_rt(wl, *sw)) != mod_reports(_rt(twin, *sw)):
                yield (wl, sw)


def dg7():
    kt, hb, lz = horizon("kant"), horizon("hobbes"), horizon("leibniz")
    if kt ^ hb != {"self_preservation", "form_of_law"}:
        yield ("from hobbes", sorted(kt ^ hb))
    if len(lz) != 9 or kt & lz != {"ends_desired"}:
        yield ("from leibniz", sorted(kt & lz))
    holders = {r for r in RECORD if "form_of_law" in horizon(r)}
    if holders != {"kant"}:
        yield ("form_of_law", sorted(holders))


NOT_WILL_LINE = [r for r in E.RUNTIMES if r not in WILL_LINE]
scen("DG1", MOD, "The DAG's clashes, before they are resolved (DG1)", MPC,
     [_mod(dg_clashes(NOT_WILL_LINE, DG1_WANT))],
     "ttc-l build refuses suarez_dm23, descartes, hobbes, spinoza, locke, leibniz and angers on the parts "
     "predicted, and nothing else; none on form_of_law")
scen("DG2", MOD, "The clashes against the record's nine (DG2)", MPC, [_mod(dg2)],
     "raised at Suarez, Descartes, Hobbes, Spinoza, Locke and Leibniz; not at Grotius, Ockham or Bacon; Angers "
     "raises its own")
scen("DG3", MOD, "Locke's two horizons (DG3)", MPC, [_mod(dg3)],
     "physics without forms or intrinsic ends; ethics with God's ends and self-preservation, without human ends "
     "or the object; in ethics the add of ends_by_god_ethics alone separates him from Hobbes (found: in the whole "
     "horizon the add of ends_by_god_physics too)")
scen("DG4", MOD, "The will line's clashes (DG4)", MPC, [_mod(dg_clashes(sorted(WILL_LINE), DG4_WANT))],
     "ttc-l build refuses suarez_wl, hobbes_wl, spinoza_wl, locke_wl and leibniz_wl on the parts predicted")
scen("DG6", MOD, "The readings move the decisions, not the later horizons (DG6)", MPC, [_mod(dg6)],
     "each node of the will line resolves to its twin's horizon, and gives on the case what its twin gives")
scen("DG7", MOD, "Kant against Hobbes and Leibniz (DG7)", MPC, [_mod(dg7)],
     "Kant and Hobbes differ on self-preservation and the form of the law only; of Leibniz's nine Kant keeps "
     "ends_desired; no other node of the record holds form_of_law")


# ---------- MP: the case on each runtime (PR1-PR8) ----------
def mp_table(rts, configs=CONFIGS, hearing=None):
    def test():
        for rt in rts:
            for sw in configs:
                got = mod_reports(RN9C + [f"rt_{rt}", hearing] + list(sw)) if hearing else rt_report(rt, sw)
                want = mp_expected(rt, sw[0] if sw else None, hearing)
                if got != want:
                    yield (rt, sw, sorted(set().union(*got) ^ set().union(*want)))
    return test


def mp_lost(rts, lost):
    def test():
        everything = mod_available(_rt("thomist"))
        for rt in rts:
            got = everything - mod_available(_rt(rt))
            if got != set(lost):
                yield (rt, sorted(got ^ set(lost)))
    return test


def mp3():
    yield from mp_lost(WILL_READINGS + ("locke",), ["rn7_products", "rn7_land", "rn9", "rn13_products",
                                                    "rn13_land", "rn22", "th57", "th66", "civ22"])()
    for rt in WILL_READINGS:
        if mod_reports(_rt(rt)) != mod_reports(_rt("locke")):
            yield (rt, "not as locke")


def mp6():
    for sw in CONFIGS + (SW6,):
        for parts in (MPC + list(sw), RN9C + [HEAR_LOCKE] + list(sw)):
            hit = {a for r in phase_map(parts).values() for m in r for a in m if "contrary_reasoned" in a}
            if hit:
                yield (parts, sorted(hit)[:2])
    for rt in E.RUNTIMES:
        for parts in [_rt(rt, *sw) for sw in RUN_CONFIGS] + [RN9C + [f"rt_{rt}", HEAR_LOCKE]]:
            hit = [a for m in mod_reports(parts) for a in m if "contrary_reasoned" in a]
            if hit:
                yield (parts, hit)


def mp7():
    for hearers, of in ((("episcopate_1891", "social_catholic", "angers"), "thomist"), (("smith", "george"), "locke"),
                        (("marx", "lassalle"), "marx"), (("marx_social",), "hobbes")):
        for h in hearers:
            if mod_reports(_rt(h)) != mod_reports(_rt(of)):
                yield (h, of)


def mp8():
    pm = phase_map(MPC)
    forms = {"object_as_form", "form_of_law"}
    if any(pm[h] != pm[h - forms] for h in pm):
        yield "a form moves a report"
    for rt in E.RUNTIMES:
        if rt in ("kant", "kant_humanity", "kant_mm"):
            continue
        if mod_reports(_rt(rt)) != pm[horizon(rt) - forms]:
            yield (rt, "differs from its horizon without the forms")
    for rt, like in (("kant", "hobbes"), ("kant_mm", "hobbes"), ("kant_humanity", "marx")):
        if mod_reports(_rt(rt)) != mod_reports(_rt(like)):
            yield (rt, like)


scen("MP1", MOD, "The Thomist group (PR1)", MPC, [_mod(mp_table(THOMIST_GROUP))],
     "no without_reason and no sole_reason, under every switch")
scen("MP2", MOD, "The record's middle (PR2)", MPC,
     [_mod(mp_lost(MIDDLE, ["th66"])), _mod(mp_lost(("ockham_nominal",), ["rn7_products", "rn7_land", "rn9", "th66"])),
      _mod(mp_table(MIDDLE + ("ockham_nominal",)))],
     "th66 lost, nothing fires; ockham_nominal loses rn7, rn9 and th66, and nothing fires")
scen("MP3", MOD, "The will readings, before Hobbes (PR3)", MPC, [_mod(mp3)],
     "scotus_will, ockham_will and descartes_will lose rn7, rn9, rn13, rn22, th57, th66 and civ22, and give "
     "exactly what locke gives")
scen("MP4", MOD, "RN's sole reasons on property (PR4)", MPC,
     [_mod(mp_table(HOBBES_GROUP + LOCKE_GROUP)), _mod(mp_table(E.RUNTIMES, ((),), HEAR_LOCKE))],
     "rn10 at Hobbes's and Locke's groups as committed; rn10_products only under the Lockean hearing; none under "
     "rn7_from_self, and at Locke's under rn7_under_providence and rn13_as_command, and at the will readings "
     "under rn7_from_form; kant and bare rn10 throughout")
scen("MP5", MOD, "The common destination and IP (PR5)", MPC, [_mod(mp_table(E.RUNTIMES))],
     "use common without reason at Hobbes's group but under rn8_from_sustenance, at kant always; rn8 sole at "
     "Locke's but under rn22_as_stewardship; rn22 at marx, lassalle, grotius_etiamsi, and kant_humanity; IP "
     "without reason wherever the ends of human nature are traced")
scen("MP6", MOD, "No contrary reasoned (PR6)", MPC, [_mod(mp6)],
     "contrary_reasoned nowhere, under every switch and the Lockean hearing")
scen("MP7", MOD, "Leo's hearers (PR7)", MPC, [_mod(mp7)],
     "the Catholics in the Thomist group; Smith and George in Locke's; Marx and Lassalle in the group of human ends "
     "without God's; marx_social in Hobbes's")
scen("MP8", MOD, "The two forms idle (PR8)", MPC, [_mod(mp8)],
     "no report depends on object_as_form or form_of_law; kant and kant_mm in Hobbes's group, kant_humanity in "
     "the group of human ends without God's")


# ---------- VM: the bridge ----------
def _as_guest(reports):
    return frozenset(frozenset(a.replace("info(sole_reason(", "info(guest_sole_reason(")
                               .replace("info(without_reason(", "info(guest_without_reason(")
                               for a in m if "contrary_reasoned" not in a) for m in reports)


def vm1(hearing=None):
    def test():
        extra = ["linguae_rn9", hearing] if hearing else []
        for rt in E.RUNTIMES:
            for sw in (CONFIGS + (SW6,) if hearing is None else ((),)):
                guest = mod_reports(MPC + extra + ["rt_thomist", guest_of(rt)] + list(sw), prefix=GUEST_PREFIX)
                own = mod_reports(MPC + extra + [f"rt_{rt}"]) if hearing else rt_report(rt, sw)
                if guest != _as_guest(own):
                    yield (rt, sw, sorted(set().union(*guest) ^ set().union(*_as_guest(own))))
                if hearing is None:
                    runs = mod_run(MPC + ["rt_thomist", guest_of(rt)] + list(sw))
                    seen = set.intersection(*[{E.split_args(a)[1][0] for a in m if a.startswith("guest_available_as(")}
                                              for m in runs])
                    own_av = (mod_available(_rt(rt, *sw)) if sw in RUN_CONFIGS
                              else available_map(MPC + list(sw))[horizon(rt)])
                    if seen != own_av:
                        yield (rt, sw, "the guest follows other arguments", sorted(seen ^ own_av))
    return test


def _guest_sole(rt, hearing=None):
    extra = ["linguae_rn9", hearing] if hearing else []
    ms = mod_reports(MPC + extra + ["rt_thomist", guest_of(rt)], prefix=("info(guest_sole_reason(",))
    return {E.split_args(E.split_args(a)[1][0])[1][1] for m in ms for a in m}


def vm2():
    for rt in E.RUNTIMES:
        want = set()
        if rt in HOBBES_GROUP + LOCKE_GROUP:
            want |= {"rn10_products", "rn10_land"}
        if rt in LOCKE_GROUP:
            want.add("rn8")
        if rt in HUMAN_ENDS:
            want.add("rn22")
        if _guest_sole(rt) != want:
            yield (rt, sorted(_guest_sole(rt) ^ want))


def vm3():
    for rt in E.RUNTIMES:
        m = set().union(*mod_project([f"rt_{rt}", f"vm_{rt}"], ("holds_cause/2", "guest_holds/2")))
        own = {a[len("holds_cause("):] for a in m if a.startswith("holds_cause(")}
        guest = {a[len("guest_holds("):] for a in m if a.startswith("guest_holds(")}
        if not own or own != guest:
            yield (rt, sorted(own ^ guest))
    # no part vm_R, no guest: nothing held, followed or reported for one
    if set().union(*mod_project(MPC + ["rt_thomist"], ("guest_holds/2", "guest_available_as/2") + GUEST_TERMS)):
        yield "a guest without a part vm_R"


scen("VM1", MOD, "The bridge: idle in the host, sole in the guest (VM1)", MPC, [_mod(vm1())],
     "host thomist: guest_sole_reason with vm_R exactly where sole_reason fires on R, and guest_without_reason "
     "where without_reason does, under every switch; the guest follows exactly the arguments available on R")
scen("VM2", MOD, "What bridges (VM2)", MPC, [_mod(vm2)],
     "rn10 to the guests of Hobbes's and Locke's groups; rn8 to Locke's; rn22 to the guests of human ends "
     "without God's")
scen("VM3", MOD, "A guest's horizon is its runtime's (VM3)", MPC, [_mod(vm3)],
     "for every runtime R, the guest horizon of vm_R equals R's")


# ---------- HE: hearing ----------
# Per runtime on the case alone; beside each switch and all six over horizons_all, every horizon.
HEARD_CONFIGS = ((),)


def he1():
    for rt in E.RUNTIMES:
        for sw in HEARD_CONFIGS:
            heard = mod_reports(RN9C + [f"rt_{rt}", HEAR_LOCKE] + list(sw))
            fixture = mod_reports(_rt(rt, *sw), RN9_IN_ENGLISH)
            if heard != fixture:
                yield (rt, sw)
    for sw in CONFIGS + (SW6,):
        if phase_map(RN9C + [HEAR_LOCKE] + list(sw)) != phase_map(MPC + list(sw), RN9_IN_ENGLISH):
            yield ("horizons_all", sw)


def he2():
    with E.rule_change(remove=[FORTIN]):
        for rt in E.RUNTIMES:
            for m in mod_run(RN9C + [f"rt_{rt}", HEAR_LOCKE]):
                if "info(heard_short(here,rn9))" not in m or any(a.startswith("available_as(rn9,") for a in m):
                    yield (rt, "rn9 reaches the hearer")
            if mod_reports(RN9C + [f"rt_{rt}", HEAR_LOCKE]) != mod_reports(_rt(rt)):
                yield (rt, "a report changes")


IMPRESS = "assumed_fact(renders(rn_en_impress,rn_la_forma))"
LITERAL_M = "assumed_fact(read_by(rn_la_forma,lex_la_1891))"


def _cd(p):
    return {"fh": "cd(formal,human)", "eh": "cd(efficient,human)", "mn": "cd(material,nature)",
            "hu": "cd(final,human)", "fs": "cd(final,self)"}[p]


def _heard(hearing, rt="default"):
    return mod_run(RN9C + [f"rt_{rt}", hearing])


def _lost(m, who="here"):
    return {E.split_args(a[5:-1])[1][2] + ":" + E.split_args(a[5:-1])[1][3] for a in m
            if a.startswith(f"info(lost_for({who},rn9,")}


def _analogies(m, who="here"):
    return {E.split_args(a[5:-1])[1][2] + ":" + E.split_args(a[5:-1])[1][3] for a in m
            if a.startswith(f"info(heard_by_analogy({who},rn9,")}


def he3_locke():
    for m in _heard(HEAR_LOCKE):
        carried = {E.split_args(a[5:-1])[1][2] for a in m if a.startswith("info(carried_for(here,rn9,")}
        if carried != {_cd("eh"), _cd("fs"), _cd("mn")}:
            yield ("carried", sorted(carried))
        if _analogies(m) != {f"{_cd('eh')}:attribution", f"{_cd('fs')}:attribution"}:
            yield ("analogy", sorted(_analogies(m)))
        if "info(mode_for(here,rn_en_nature,rn_la_natura,univocal))" not in m:
            yield "nature not univocal"
        seal = "equivocal" if IMPRESS in m else "gap"
        if _lost(m) != {f"{_cd('hu')}:no_carry", f"{_cd('fh')}:no_carry", f"{_cd('fh')}:{seal}"}:
            yield ("lost", sorted(_lost(m)))


def he3_schol():
    for m in _heard("hear_en_1891_schol"):
        if IMPRESS in m:
            want = {f"{_cd('fh')}:attribution", f"{_cd('eh')}:attribution"}
            if LITERAL_M in m:
                want.add(f"{_cd('fh')}:proportionality")
            elif "info(mode_for(here,rn_en_impress,rn_la_forma,univocal))" not in m:
                yield "the metaphor reading not univocal"
            if _lost(m) or _analogies(m) != want or "info(heard_short(here,rn9))" in m:
                yield ("rendered", sorted(_lost(m)), sorted(_analogies(m)))
        elif _lost(m) != {f"{_cd('fh')}:gap"} or "info(heard_short(here,rn9))" not in m or \
                any(a.startswith("available_as(rn9,") for a in m) or \
                _analogies(m) != {f"{_cd('eh')}:attribution"}:
            yield ("gap", sorted(_lost(m)), sorted(_analogies(m)))


def he3_2026():
    for m in _heard("hear_en_2026"):
        lost = {x for x in _lost(m) if x.endswith(":equivocal")}
        if lost != {f"{_cd('fh')}:equivocal", f"{_cd('eh')}:equivocal"} or "info(heard_short(here,rn9))" not in m \
                or any(a.startswith("available_as(rn9,") for a in m):
            yield sorted(_lost(m))


def he3_la():
    for m in _heard("hear_la_1891"):
        if _lost(m) or "info(heard_short(here,rn9))" in m or "available_as(rn9,rn9)" not in m:
            yield sorted(_lost(m))


def he3_unchanged():
    for hearing in ("hear_la_1891", "hear_en_1891_schol", "hear_en_2026"):
        for rt in E.RUNTIMES:
            for sw in HEARD_CONFIGS:
                if mod_reports(RN9C + [f"rt_{rt}", hearing] + list(sw)) != mod_reports(_rt(rt, *sw)):
                    yield (hearing, rt, sw)
        for sw in CONFIGS + (SW6,):
            if phase_map(RN9C + [hearing] + list(sw)) != phase_map(MPC + list(sw)):
                yield (hearing, "horizons_all", sw)


def _by_horizon(m, who="here"):
    return {E.split_args(a[5:-1])[1][2] for a in m if a.startswith(f"info(lost_by_horizon({who},rn9,")}


def he4():
    two = {_cd("fh"), _cd("hu")}
    for rt in LOCKE_LIKE + HOBBES_LIKE + WILL_READINGS + ("kant", "bare"):
        for m in mod_run(RN9C + [f"rt_{rt}", HEAR_LOCKE]):
            enc = {x.split(":")[0] for x in _lost(m)}
            hz = _by_horizon(m)
            want_hz = two | {_cd("fs")} if rt in ("kant", "bare") else {_cd("hu")} if rt in WILL_READINGS else two
            if hz != want_hz or (rt not in ("kant", "bare") and enc != two):
                yield (rt, sorted(enc), sorted(hz))
            if any(a.startswith("info(lost_by_horizon(here,") and not a.startswith("info(lost_by_horizon(here,rn9,")
                   for a in m):
                yield (rt, "lost by horizon, an argument not heard")
        # an argument not heard loses nothing by horizon
        if any(a.startswith("info(lost_by_horizon(") for m in mod_run(_rt(rt)) for a in m):
            yield (rt, "lost by horizon with no hearing")


def he5():
    for rt in HEARERS:
        got = mod_reports(RN9C + [f"rt_{rt}", "hearers_tongues"])
        if rt == "george":
            want = frozenset({frozenset({_sole("rn10_products", "property_in_products"), _sole("rn8", "use_common", "yes"),
                                         _without("ip_absolute", "no")})})
        else:
            want = mod_reports(_rt(rt))
        if got != want:
            yield rt
    for rt in ("george_hn", "episcopate_1891"):
        if mod_reports(RN9C + [f"rt_{rt}", "hearers_tongues"]) != frozenset({frozenset()}):
            yield (rt, "reports")
    # who hears in what: George and his reading the English of 1891 by Locke's lexicon, the bishops the Latin
    want = {"george": "hears_in(here,en_1891,lex_en_locke_1891)", "george_hn": "hears_in(here,en_1891,lex_en_locke_1891)",
            "episcopate_1891": "hears_in(here,la_1891,lex_la_1891)"}
    for rt in HEARERS:
        got = {a for m in mod_project(RN9C + [f"rt_{rt}", "hearers_tongues"], ("hears_in(here,E,C)",)) for a in m}
        if got != ({want[rt]} if rt in want else set()):
            yield (rt, sorted(got))


def he6():
    yield from vm1(HEAR_LOCKE)()
    for rt in E.RUNTIMES:
        want = set()
        if rt in LOCKE_GROUP:
            want = {"rn10_products", "rn8"}
        elif rt in ("kant", "bare"):
            want = {"rn10_products", "rn10_land"}
        elif rt in HOBBES_LIKE:
            want = {"rn10_products"}
        elif rt in HUMAN_ENDS:
            want = {"rn22"}
        if _guest_sole(rt, HEAR_LOCKE) != want:
            yield (rt, sorted(_guest_sole(rt, HEAR_LOCKE)))
    for m in mod_run(RN9C + ["rt_thomist", "vm_locke", HEAR_LOCKE]):
        if _analogies(m, "guest") != {f"{_cd('eh')}:attribution", f"{_cd('fs')}:attribution"}:
            yield ("guest's analogies", sorted(_analogies(m, "guest")))
    for m in mod_run(RN9C + ["rt_thomist", "vm_locke", "hear_la_1891"]):
        if _by_horizon(m, "guest") != {_cd("fh"), _cd("hu")} or _lost(m, "guest"):
            yield ("vm_locke in the Latin", sorted(_by_horizon(m, "guest")), sorted(_lost(m, "guest")))
        if any(a.startswith(("info(lost_by_horizon(here,", "info(lost_for(here,")) for a in m):
            yield "the host hears"


scen("HE1", MOD, "The switch retires: the English of 1891 under Locke, with Fortin's claim (HE1)", RN9C,
     [_mod(he1)],
     "on every runtime, alone and beside all six switches, every report as rn9_in_english gave; so the phase "
     "diagram over horizons_all, beside each switch and all six")
scen("HE2", MOD, "Without Fortin's claim (HE2)", RN9C, [_mod(he2)],
     "heard_short(here,rn9); RN 9 does not reach the hearer; every report as committed")
scen("HE3", MOD, "What crosses (HE3)", RN9C,
     [_mod(he3_locke), _mod(he3_schol), _mod(he3_2026), _mod(he3_la), _mod(he3_unchanged)],
     "Locke: (efficient, human) and (final, self) by attribution, (material, nature) univocally; (final, human) "
     "and (formal, human) lost, the seal-word equivocal or a gap by branch. Scholastic: nothing lost where the "
     "seal-word renders the form, a gap where it does not. 2026: lost by equivocation. Latin: as typed. The last "
     "three change no report, on any runtime alone or beside all six switches, or over horizons_all beside each")
scen("HE4", MOD, "The losses coincide (HE4)", RN9C, [_mod(he4)],
     "under the Lockean hearing rn9 loses by encoding what it loses by horizon, (formal, human) and (final, "
     "human); on the will readings the English also takes (formal, human); on bare and kant the horizon also "
     "lacks (final, self)")
scen("HE5", MOD, "The hearers' tongues (HE5)", RN9C + ["hearers_tongues"], [_mod(he5)],
     "on george the sole reasons are rn10_products and rn8; george_hn and episcopate_1891 report nothing; every "
     "other hearer as PR7")
scen("HE6", MOD, "The VM, the guest hearing (HE6)", RN9C, [_mod(he6)],
     "guest_sole_reason under the Lockean hearing where sole_reason fires on R with it; rn10_products and rn8 for "
     "Locke's group, rn10_products for Hobbes's save vm_kant and vm_bare; the guest's two attributions; vm_locke "
     "in the Latin loses (formal, human) and (final, human) by horizon and nothing by encoding")
scen("HE7", MOD, "A premise on a form its argument does not argue from (HE7)", RN9C,
     [shown(RN9C, ("violation/1",), "violation(premise_not_argued(rn9,cd(final,god_ethics)))",
            facts="rests_on_form(rn9,cd(final,god_ethics),rn_la_persona)."),
      shown(RN9C, ("violation/1",), absent=("violation(premise_not_argued(rn9,cd(formal,human)))",
                                            "violation(premise_not_argued(rn9,cd(final,human)))"))],
     "refused (premise_not_argued); rn9's own premises on forms are argued")


# ---------- PH: the phases ----------
def phase_map(parts, facts=""):
    """each horizon of horizons_all (the cause parts it holds) -> its reports, a frozenset over branches"""
    pairs = {f"holds_cause({c},{d})": p for p, (c, d) in CAUSE_PARTS.items()}
    out: dict = {}
    for m in mod_project(phase_base() + list(parts), REPORT_TERMS + ("holds_cause/2",), facts):
        h = frozenset(pairs[a] for a in m if a in pairs)
        out.setdefault(h, set()).add(frozenset(a for a in m if not a.startswith("holds_cause(")))
    return {h: frozenset(v) for h, v in out.items()}


def phases(pm):
    """the order parameters (the parts a report depends on) and the phases (the classes of one report)"""
    order = {p for p in CAUSE_PARTS if any(pm[h] != pm[h ^ {p}] for h in pm)}
    classes: dict = {}
    for h, r in pm.items():
        classes.setdefault(r, set()).add(h)
    return order, classes


def _phase_of(pm):
    return {rt: pm[horizon(rt)] for rt in E.RUNTIMES}


GE_HN = {"ends_by_god_ethics", "ends_of_human_nature"}


def ph_check(parts, order, n, same=(), apart=(), empty=0, facts=""):
    """the order parameters, the number of phases, runtimes in one phase (same), runtimes alone or apart from
    others (apart: pairs of a group and the runtimes it must not share a phase with), phases holding no runtime"""
    def test():
        pm = phase_map(parts, facts)
        got_order, classes = phases(pm)
        if len(pm) != 1024:
            yield f"{len(pm)} horizons"
        if got_order != set(order):
            yield ("order", sorted(got_order))
        if len(classes) != n:
            yield ("phases", len(classes))
        at = _phase_of(pm)
        for group in same:
            if len({at[r] for r in group}) != 1:
                yield ("not one phase", group)
        for group, others in apart:
            if {at[r] for r in group} & {at[r] for r in others}:
                yield ("not apart", group)
        held = set(at.values())
        if sum(1 for r in classes if r not in held) != empty:
            yield ("phases with no runtime", sum(1 for r in classes if r not in held))
    return test


def ph1():
    pm = phase_map(MPC)
    order, classes = phases(pm)
    if order != GE_HN or len(classes) != 4 or {len(v) for v in classes.values()} != {256}:
        yield ("order", sorted(order), len(classes))
    at = _phase_of(pm)
    want = {THOMIST_GROUP: mp_expected("default"), HUMAN_ENDS: mp_expected("marx"),
            LOCKE_GROUP: mp_expected("locke"), HOBBES_GROUP: mp_expected("hobbes")}
    for group, report in want.items():
        for rt in group:
            if at[rt] != report:
                yield (rt, "misplaced")
    for report in want.values():
        if not any(at[h] == report for h in HEARERS):
            yield "a phase without a hearer of 1891"


ALL_SIX = list(SW6)
scen("PH1", MOD, "The phases as committed (PH1)", MPC, [_mod(ph1)],
     "order parameters ends_of_human_nature and ends_by_god_ethics; four phases of a quarter each, Thomist, human "
     "ends without God's, Lockean, Hobbesian, each holding a hearer of 1891; neither form an order parameter")
scen("PH2", MOD, "The phases by switch and hearing (PH2)", MPC,
     [_mod(ph_check(MPC + ["rn7_from_form"], GE_HN | {"soul_as_form"}, 6,
                    apart=((WILL_READINGS, LOCKE_LIKE),), empty=1)),
      _mod(ph_check(MPC + ["rn7_from_self"], GE_HN | {"self_preservation"}, 6,
                    apart=((("bare", "kant"), HOBBES_LIKE),), empty=1)),
      _mod(ph_check(RN9C + [HEAR_LOCKE], GE_HN | {"self_preservation"}, 6,
                    apart=((("bare", "kant"), HOBBES_LIKE),), empty=1)),
      _mod(ph_check(MPC + ["rn8_from_sustenance"], GE_HN | {"self_preservation"}, 4,
                    same=(("bare", "kant"), HOBBES_LIKE + LOCKE_GROUP),
                    apart=((("kant_humanity",), [r for r in E.RUNTIMES if r != "kant_humanity"]),))),
      *(_mod(ph_check(MPC + [s], GE_HN, 4)) for s in ("rn7_under_providence", "rn13_as_command",
                                                     "rn22_as_stewardship")),
      _mod(ph_check(RN9C + [HEAR_LOCKE] + ALL_SIX, GE_HN | {"soul_as_form", "self_preservation"}, 6,
                    same=(("bare", "kant"),),
                    apart=((("kant_humanity",), [r for r in E.RUNTIMES if r != "kant_humanity"]),), empty=1)),
      *(_mod(ph_check(RN9C + [h], GE_HN, 4)) for h in ("hear_la_1891", "hear_en_1891_schol", "hear_en_2026"))],
     "rn7_from_form: soul_as_form joins, six phases, the will readings leave Locke's, one empty; rn7_from_self and "
     "the Lockean hearing: self_preservation joins, six, bare and kant leave Hobbes's, one empty; "
     "rn8_from_sustenance: four, bare and kant one, kant_humanity alone, Hobbes's joins Locke's; the other three "
     "switches as PH1; all six with the hearing: six, one empty, bare and kant together, kant_humanity alone; "
     "the other hearings as PH1")


# ---------- SU, EX, and the mechanics ----------
def su1():
    """no part outside this step's writes argument/4, argues_from/3, reading_of/2 or measures_as/3"""
    from . import lang
    writers = set()
    for f, src in lang.sources().items():
        for i, it in enumerate(src.items):
            if isinstance(it, lang.Part):
                heads = E.signatures("\n".join(src.items[i + 1].lines), f)["heads"]
                if heads & {("argument", 4), ("argues_from", 3), ("reading_of", 2), ("measures_as", 3)}:
                    writers.add(it.name)
    if writers != {"modernity_property", "modernity_measure", *SW6}:
        yield sorted(writers)


def ex1():
    """EX1, reported: the record's DAG with its three contested edges removed, rebuilt; what changes on the case.
    Found: every node keeps its horizon, so nothing does."""
    from . import lang
    text = (lang.L_DIR / "schools.l").read_text()
    contested = re.findall(r"(?m)^  -- contested edge: (\w+) <- (\w+)", text)
    record = [(c, p) for c, p in contested if c in RECORD]
    if record != [("descartes", "suarez_dm23"), ("hobbes", "ockham"), ("locke", "hobbes")]:
        yield ("marked", record)
    for child, parent in record:
        text = re.sub(rf"(?m)^(runtime {child} extends [^\n]*?), {parent}\b", r"\1", text)
        text = re.sub(rf"(?m)^(runtime {child} extends ){parent}, ", r"\1", text)
    srcs = dict({k: v for k, v in lang.sources().items() if k != "schools.lp"}, **{"schools.lp": lang.parse(text, "schools.l")})
    rebuilt = lang.compile_runtimes(srcs)
    for child, parent in record:
        if parent in rebuilt["declared"][child]["extends"]:
            yield (child, "edge kept")
    for rt in E.RUNTIMES:
        if frozenset(p for p in rebuilt["runtimes"][rt] if p in CAUSE_PARTS) != horizon(rt):
            yield (rt, "changes")


GERMAN = ("encoding(de_1891,deu,1880,1900). lexicon(lex_de_1891,de_1891,1891,dictionary). "
          "hears_in(here,de_1891,lex_de_1891).")
SNIPPET_Q = "question(q(mx)). value(q(mx),(a;b)). "


def mm1():
    """the reports' conditions: a value with no argument entered is not without reason; an argument for a value no
    source supports reports nothing; a value without reason against an available argument is contrary_reasoned;
    a source with one argument has no sole reason"""
    def facts(s):
        return SNIPPET_Q + s
    r = mod_reports(["rt_bare"], facts("source(mx_s,3,truth,2000). supports(mx_s,q(mx),a)."))
    if r != frozenset({frozenset()}):
        yield ("no argument", r)
    r = mod_reports(["rt_bare"], facts("argument(mx_x,mx_s,q(mx),b). argues_from(mx_x,final,human)."))
    if r != frozenset({frozenset()}):
        yield ("unsupported", r)
    r = mod_reports(["rt_bare"], facts("source(mx_s,3,truth,2000). supports(mx_s,q(mx),a). "
                                       "argument(mx_x,mx_s,q(mx),a). argues_from(mx_x,final,human). "
                                       "argument(mx_y,mx_t,q(mx),b)."))
    if r != frozenset({frozenset({"info(without_reason(q(mx),a))", "info(contrary_reasoned(q(mx),a,b))"})}):
        yield ("contrary", r)


def mm2():
    """an argument on forms is heard only in a tongue its texts are in; heard in its own tongue it is heard as
    typed, a premise on no form included"""
    if "rn9" not in mod_available(RN9C + ["rt_default"]) or "rn9" not in mod_available(RN9C + ["rt_thomist", "vm_hobbes"]):
        yield "with no hearing declared, rn9 is not heard as typed"
    if "rn9" in mod_available(RN9C + ["rt_default"], GERMAN):
        yield "rn9 reaches a hearer of a tongue it has no text in"
    # the bridge is named only through the renderings of the argument's own forms
    other = ("argument(x9,mx_s,q(mx),a). argues_from(x9,efficient,human). argues_from(x9,material,nature). "
             "rests_on_form(x9,cd(material,nature),rn_la_natura).")
    for m in mod_run(RN9C + ["rt_default", HEAR_LOCKE], other):
        if "info(carried_for(here,x9,cd(material,nature)))" not in m or \
                any(a.startswith("info(heard_by_analogy(here,x9,") for a in m):
            yield ("another argument's bridge", sorted(a for a in m if "x9" in a))
    # and only by the words the hearer gives the rendering and its host, where the rendering is analogical: an
    # analogy of other words, or of a word beside one the two forms share, is no bridge
    words = ("analogous(w_x,w_persona,metaphor,c_test). carries(w_x,w_persona,cd(efficient,human)). "
             "analogous(w_forensic_self,w_y,metaphor,c_test). carries(w_forensic_self,w_y,cd(efficient,human)). "
             "analogous(w_bene_esse,w_perfectio,attribution,c_test). carries(w_bene_esse,w_perfectio,cd(final,human)).")
    for hearing, want in ((HEAR_LOCKE, {f"{_cd('eh')}:attribution", f"{_cd('fs')}:attribution"}),
                          ("hear_en_1891_schol", None)):
        for m in mod_run(RN9C + ["rt_default", hearing], words):
            got = _analogies(m)
            if (want is not None and got != want) or any(x.endswith(":metaphor") or x == f"{_cd('hu')}:attribution"
                                                          for x in got):
                yield (hearing, "a bridge by other words", sorted(got))
    lean = RN9C + ["rt_bare", "soul_as_form", "ends_of_human_nature", "hear_la_1891"]
    if "rn9" in mod_available(lean):
        yield "rn9 heard in the Latin without self-preservation"
    if "rn9" not in mod_available(lean + ["self_preservation"]):
        yield "rn9 not heard in the Latin as typed"


def mm3():
    """the parts: horizons_all is loaded by no runtime; the retired switch is no part; the contested and
    undocumented edges are marked; the ten parts hold one cause each, as horizons_all chooses them"""
    from . import lang
    if any("horizons_all" in ps for ps in E.RUNTIMES.values()):
        yield "a runtime loads horizons_all"
    if "rn9_in_english" in E.known_parts():
        yield "rn9_in_english is a part"
    text = (lang.L_DIR / "schools.l").read_text()
    marks = re.findall(r"(?m)^  -- (contested|undocumented) edge: (\w+) <- (\w+)", text)
    if marks != [("contested", "descartes", "suarez_dm23"), ("contested", "hobbes", "ockham"),
                 ("contested", "locke", "hobbes"), ("contested", "hobbes_wl", "ockham_will"),
                 ("contested", "locke_wl", "hobbes_wl"), ("undocumented", "angers", "smith"),
                 ("undocumented", "george", "locke")]:
        yield ("marks", marks)
    for p, (c, d) in CAUSE_PARTS.items():
        got = set().union(*mod_project(["rt_bare", p], ("holds_cause/2",)))
        if {a for a in got if not a.startswith(("holds_cause(efficient,", "holds_cause(material,"))} != \
                {f"holds_cause({c},{d})"}:
            yield (p, sorted(got))
    if E.RUNTIMES["default"][3:] != list(CAUSE_PARTS)[:9]:
        yield ("default", E.RUNTIMES["default"])


def su4():
    """TTC-LINGUAE's named hearers (g_en_1891_locke, g_thomist_2026, g_locke_la) are no run's horizon and no guest:
    the library computes nothing for them, and what their horizon lacks stays as entered"""
    entered = {"info(lost_by_horizon(g_en_1891_locke,rn9,cd(formal,human)))",
               "info(lost_by_horizon(g_locke_la,rn9,cd(formal,human)))"}
    for parts in (["linguae_rn9"], RN9C):
        for m in mod_project(parts, ("info(heard_short(G,A))", "info(heard_by_analogy(G,A,P,K))",
                                     "info(lost_by_horizon(G,A,P))")):
            if m != entered:
                yield (parts, sorted(m ^ entered))
    # where no argument is entered, a premise on a form is refused for nothing
    if set().union(*mod_project(["linguae_rn9"], ("violation(premise_not_argued(A,P))",))):
        yield "premise_not_argued with no argument entered"


scen("SU4", MOD, "TTC-LINGUAE's hearings unchanged (SU4)", RN9C, [_mod(su4)],
     "linguae_rn9 alone, and beside the case, declares no hearing for a run's horizon or a guest: no heard_short, "
     "no heard_by_analogy, and lost_by_horizon only as entered; alone, its premises refuse nothing")
scen("SU1", MOD, "No earlier case enters an argument (SU1)", MPC, [_mod(su1)],
     "argument/4, argues_from/3, reading_of/2 and measures_as/3 are written only by this step's case, its "
     "switches and the measure")
scen("EX1", MOD, "The record's DAG without its contested edges (EX1, reported)", MPC, [_mod(ex1)],
     "rebuilt without descartes <- suarez_dm23, hobbes <- ockham and locke <- hobbes: every node keeps its "
     "horizon, so nothing on the case changes (found)")
scen("MM1", MOD, "The reports' conditions", [], [_mod(mm1)],
     "a value with no argument entered, or an argument for a value no source supports, reports nothing; a "
     "value without reason against an available argument is contrary_reasoned")
scen("MM2", MOD, "Heard in a tongue, or not at all", RN9C, [_mod(mm2)],
     "no hearing declared, the argument is heard as typed, in the host and the VM; no text in the hearer's "
     "tongue, it does not reach him; in its own tongue as typed, the premise on no form included")
def mm4():
    """each runtime gives on the case what its horizon gives over horizons_all, alone and beside all six switches,
    and under the Lockean hearing"""
    for rt in E.RUNTIMES:
        for sw in RUN_CONFIGS:
            if mod_reports(_rt(rt, *sw)) != phase_map(MPC + list(sw))[horizon(rt)]:
                yield (rt, sw)
        if mod_reports(RN9C + [f"rt_{rt}", HEAR_LOCKE]) != phase_map(RN9C + [HEAR_LOCKE])[horizon(rt)]:
            yield (rt, HEAR_LOCKE)


IDLE = (SNIPPET_Q + "source(mx_s,3,truth,2000). supports(mx_s,q(mx),a). argument(mx_h,mx_s,q(mx),a). "
        "argues_from(mx_h,final,human). argument(mx_g,mx_s,q(mx),a). argues_from(mx_g,final,god_ethics).")


def mm5():
    """guest_sole_reason only for an argument idle in the host: sole in the guest and available in the host beside
    another; sole in the guest and lost in the host, it is not reported"""
    ms = mod_reports(["rt_locke", "vm_marx"], IDLE, prefix=REPORT_PREFIX + GUEST_PREFIX)
    want = {"info(sole_reason(mx_s,mx_g,q(mx),a))"}
    if ms != frozenset({frozenset(want)}):
        yield ("lost in the host", sorted(set().union(*ms)))
    ms = mod_reports(["rt_thomist", "vm_marx"], IDLE, prefix=GUEST_PREFIX)
    if ms != frozenset({frozenset({"info(guest_sole_reason(mx_s,mx_h,q(mx),a))"})}):
        yield ("idle in the host", sorted(set().union(*ms)))
    ms = mod_reports(["rt_marx", "vm_marx"], IDLE, prefix=REPORT_PREFIX + GUEST_PREFIX)
    if ms != frozenset({frozenset({"info(sole_reason(mx_s,mx_h,q(mx),a))"})}):
        yield ("sole in the host as well", sorted(set().union(*ms)))


scen("MM5", MOD, "Idle in the host, sole in the guest", [], [_mod(mm5)],
     "an argument sole in the guest is reported only where the host holds it beside another: not where the host "
     "lacks it, nor where it is sole there too")
scen("MM4", MOD, "Each runtime gives what its horizon gives", MPC, [_mod(mm4)],
     "on the case alone, beside all six switches, and heard in the English of 1891 under Locke, every runtime "
     "reports what its horizon reports over horizons_all")
scen("MM3", MOD, "The parts and the marks", [], [_mod(mm3)],
     "horizons_all loaded by no runtime; rn9_in_english no part; contested and undocumented edges marked; each "
     "of the ten parts one cause in one domain, default holding the first nine")


# ---------- The consent canons (TTC-ROTA) -----------------------------------
# cc. 1095-1103 and CCEO cc. 818-826, moved into the base from a personal layer.
# Each premise is entered, or entered disputed; a ground is engaged on the
# premises a branch holds, and the dubium is answered ground by ground. Each
# control differs from its case by one element.
MC = "consent"
DECL_READ = "c1098_reading(k12,declarative_of_natural_law)"
POS_READ = "c1098_reading(k12,merely_positive)"
scen("MC1", MC, "c. 1095 nn. 1-3 and c. 1096: a ground to each claim", ["consent_canons"],
     [info_all("marriage(k1,invalid_consent,n1095_1)", "marriage(k2,invalid_consent,n1095_2)",
               "marriage(k3,invalid_consent,n1095_3)", "marriage(k4,invalid_consent,n1096)",
               "marriage(k2,invalid_consent))", "marriage(k3,invalid_consent))", "marriage(k4,invalid_consent))")],
     "reason lacking, a grave defect of discretion, a psychic incapacity, ignorance of what marriage is: each engages "
     "its own ground, and the consent is vitiated", mode=B)
scen("MC2", MC, "c. 1097: the person, and a quality intended directly and principally", ["consent_canons"],
     [info_all("marriage(k5,invalid_consent,n1097_1)", "marriage(k6,invalid_consent,n1097_2)"),
      info_none("marriage(k7,invalid_consent")],
     "error about the person; error about a quality only with the claim that it was intended directly and "
     "principally; the same error as the cause of the contract engages nothing", mode=B)
scen("MC3", MC, "c. 1098: the four elements together", ["consent_canons"],
     [info_all("marriage(k8,invalid_consent,n1098)", "marriage(k11,invalid_consent,n1098)"),
      info_none("marriage(k9,invalid_consent", "marriage(k10,invalid_consent", "marriage(k28,invalid_consent",
                "c1098_reading(k8,", "c1098_reading(k11,")],
     "deceit, its purpose, the quality's gravity and the consent: engaged, whoever deceives, a party or not; with "
     "the purpose or the gravity not entered, or the deceived as their own deceiver, not; after the Code no "
     "reading is asked", mode=B)
scen("MC4", MC, "c. 1098 before the Code: the reading branches", ["consent_canons"],
     [branches_n(2), under(DECL_READ, info_all("marriage(k12,invalid_consent,n1098)")),
      under(POS_READ, info_none("marriage(k12,invalid_consent"))],
     "a marriage of 1980 with the four elements: engaged where c. 1098 declares the natural law, not where it is "
     "merely positive law; neither preferred", mode=B)
scen("MC5", MC, "c. 1101: the presumption, and each species of exclusion", ["consent_canons"],
     [info_all("presumed_consent(a13,k13)", "marriage(k14,invalid_consent,n1101_prolis)",
               "marriage(k15,invalid_consent,n1101_total)", "marriage(k16,invalid_consent,n1101_fidei)",
               "marriage(k17,invalid_consent,n1101_sacramenti)", "marriage(k18,invalid_consent,n1101_coniugum)",
               "marriage(k19,invalid_consent,n1101_element)", "marriage(k20,invalid_consent,n1101_property)"),
      info_none("presumed_consent(a14,k14)")],
     "the celebration raises the presumption of §1; a claimed positive act of the will rebuts it and engages the "
     "species excluded", mode=B)
scen("MC6", MC, "c. 1102: a future condition dated, a past or present one unfulfilled", ["consent_canons"],
     [info_all("marriage(k21,invalid_consent,n1102_1)", "marriage(k23,invalid_consent,n1102_2)",
               "marriage(k25,invalid_consent,n1102_2)"),
      info_none("marriage(k22,invalid_consent", "marriage(k24,invalid_consent")],
     "§1 from the Code only; §2 on the outward fact, unfulfilled engaged and fulfilled not", mode=B)
scen("MC7", MC, "c. 1103 named, and the dubium answered", ["consent_canons"],
     [info_all("marriage(k26,invalid_consent,n1103)", "marriage(k27,invalid_consent,n1103)",
               "ground(k2,n1095_2,engaged)", "ground(k2,n1095_2,engaged_by(n1095_2))",
               "ground(k2,cceo818_2,engaged_by(n1095_2))", "ground(k7,n1097_2,not_engaged)")],
     "fear and force named as c. 1103's ground; a ground formulated is engaged by its own canon or its twin, and a "
     "ground with no premise under it is not engaged", mode=B)
scen("MC8", MC, "An Eastern party: CCEO cc. 818-826", ["consent_eastern"],
     [info_all(*[f"marriage({m},invalid_consent,{g})" for m, g in (
          ("h1", "cceo818_1"), ("h2", "cceo818_2"), ("h3", "cceo818_3"), ("h4", "cceo819"), ("h5", "cceo820_1"),
          ("h6", "cceo820_2"), ("h7", "cceo824_total"), ("h8", "cceo821"), ("h9", "cceo824_prolis"),
          ("h10", "cceo824_fidei"), ("h11", "cceo824_sacramenti"), ("h12", "cceo824_coniugum"),
          ("h13", "cceo824_element"), ("h14", "cceo824_property"), ("h15", "cceo825"), ("h16", "cceo826"),
          ("h17", "cceo825"))],
               *[f"ground({m},{g},engaged_by({e}))" for m, g, e in (
                   ("h1", "n1095_1", "cceo818_1"), ("h2", "n1095_2", "cceo818_2"), ("h3", "n1095_3", "cceo818_3"),
                   ("h4", "n1096", "cceo819"), ("h5", "n1097_1", "cceo820_1"), ("h6", "n1097_2", "cceo820_2"),
                   ("h7", "n1101_total", "cceo824_total"), ("h8", "n1098", "cceo821"),
                   ("h9", "n1101_prolis", "cceo824_prolis"), ("h10", "n1101_fidei", "cceo824_fidei"),
                   ("h11", "n1101_sacramenti", "cceo824_sacramenti"), ("h12", "n1101_coniugum", "cceo824_coniugum"),
                   ("h13", "n1101_element", "cceo824_element"), ("h14", "n1101_property", "cceo824_property"),
                   ("h15", "n1103", "cceo825"), ("h16", "n1102_2", "cceo826"), ("h20", "n1102_1", "cceo826"))]),
      info_none("invalid_consent,n10", "invalid_consent,n11")],
     "the Eastern faithful's consent is read by their own code, never the Latin; the Latin ground a tribunal "
     "formulates is engaged by its twin; a condition, even past and fulfilled, engages c. 826", mode=B)
scen("MC9", MC, "An Eastern party before 1991", ["consent_eastern"],
     [info_all("no_eastern_code_in_force(e18,h18)"), info_none("marriage(h18,invalid_consent"),
      under("c1098_reading(h19,declarative_of_natural_law)", info_all("marriage(h19,invalid_consent,cceo821)")),
      under("c1098_reading(h19,merely_positive)", info_none("marriage(h19,invalid_consent"))],
     "no Eastern code read before 1 October 1991; deceit asks the reading of c. 1098 there too", mode=B)
scen("MC10", MC, "Each premise disputed, computed both ways", ["consent_disputed"],
     [branches_n(32)]
     + [branch_facts(f"assumed_fact({x}", every=False) for x in (
         "intended(g1,j1,", "deceit(d_j2,", "quality_gravely_disturbs(addiction)", "condition(c_j4,", "fulfilled(c_j5)")]
     + [branch_facts(f"assumed_fact(false({x}", every=False) for x in (
         "intended(g1,j1,", "deceit(d_j2,", "quality_gravely_disturbs(addiction)", "condition(c_j4,", "fulfilled(c_j5)")]
     + [branch_facts(f"marriage({m},invalid_consent,{g})", every=False) for m, g in (
         ("j1", "n1097_2"), ("j2", "n1098"), ("j3", "n1098"), ("j4", "n1102_2"), ("j5", "n1102_2"))],
     "a disputed premise is never decided: one branch each way, and the ground engaged on one", mode=B)


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
