"""The usury case sketched for TTC-MODERNITY's PH3: a proposal, not a prediction.

Typing as the record proposes it; run by the plain model (plain.py), which
reproduces TTC-MENDACIUM's MH1-MH2 and MJ1 exactly.
"""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import plain

P = "q(profit_from_loan_as_such)"
ARGS = {
    # yes: profit from the loan as such is evil by its object
    "pol_end":         ("aristotle_pol", P, "yes", {("final", "will")}),     # money's end, exchange (the maker's end, as soap's a_maker)
    "pol_nature":      ("aristotle_pol", P, "yes", {("final", "nature")}),   # "most against nature": acquisition from what nature supplies
    "th78_object":     ("th78", P, "yes", {("formal", "will")}),             # "venditur id quod non est"
    "th78_end":        ("th78", P, "yes", {("final", "will")}),              # "principaliter est inventa ad commutationes faciendas"
    "vp_equality":     ("vix_pervenit", P, "yes", {("formal", "will")}),     # "the law governing loans ... equality"
    "vp_scripture":    ("vix_pervenit", P, "yes", {("final", "god_ethics")}),# "condemned in the Sacred Scriptures"
    "lat5_def":        ("lateran_v", P, "yes", {("formal", "will"), ("formal", "nature")}),  # "a thing which produces nothing"
    # no: not evil as such
    "calvin_charity":  ("calvin_1545", P, "no", {("final", "god_ethics")}),  # forbidden only "repugnant both to Justice and to Charity"
    "calvin_fruit":    ("calvin_1545", P, "no", {("efficient", "human"), ("material", "nature")}),  # the farm bought with money
    "hobbes_l15":      ("hobbes_lev15", P, "no", {("final", "will"), ("efficient", "will")}),  # the just value, what they are content to give
    "locke_rent":      ("locke_1691", P, "no", {("efficient", "will"), ("efficient", "human")}),  # as lawful as rent; "by Compact"
    "smith_use":       ("smith_wn", P, "no", {("efficient", "human")}),      # "something can everywhere be made by the use of money"
    "bentham_liberty": ("bentham_1787", P, "no", {("final", "will"), ("efficient", "will")}),  # bargain "as he thinks fit"
    "bentham_ewes":    ("bentham_1787", P, "no", {("efficient", "human"), ("material", "nature")}),  # a ram and a couple of ewes
}


def make(args, readings=None):
    c = {"args": {a: (s, q, v) for a, (s, q, v, _) in args.items()},
         "af": {a: set(cd) for a, (_, _, _, cd) in args.items()},
         "rd": {}, "sup": {(q, v) for (_, q, v, _) in args.values()}}
    for r, (a, cd) in (readings or {}).items():
        c["rd"].setdefault(a, set()).add(r)
        c["af"][r] = set(cd)
    return c


AB = {"ends_in_nature": "EN", "forms_in_nature": "FN", "ends_by_god_physics": "GP", "ends_by_god_ethics": "GE",
      "ends_of_human_nature": "HU", "soul_as_form": "SF", "ends_desired": "ED", "self_preservation": "SP",
      "object_as_form": "OF", "form_of_law": "FL", "ends_of_art": "EA", "forms_of_art": "FA"}


def show(label, d, detail=True):
    print(f"== {label}: order parameters {[AB[o] for o in d['order_parameters']]}; "
          f"{d['phases']} phases; {d['holding_runtime']} holding a runtime")
    if detail:
        for s, ks in sorted(d["rt_phase"].items(), key=lambda kv: -len(kv[1])):
            rep = sorted(r for case in s for r in case)
            short = [("sole " + r[2]) if r[0] == "sole_reason" else (r[0] + " " + r[2]) for r in rep]
            print(f"   {d['phase_sizes'][s]:4d} h | {', '.join(short) or 'nothing'} | {' '.join(sorted(ks))}")


if __name__ == "__main__":
    usury = make(ARGS)
    show("usury alone, as proposed", plain.diagram([usury]))
    # a reading: money's end as an end of human nature (natural wealth for the household)
    hu = make(ARGS, {"pol_end_hu": ("pol_end", {("final", "human")}), "th78_end_hu": ("th78_end", {("final", "human")})})
    show("usury, money's end read as human", plain.diagram([hu]), detail=False)
    # the alternative typing: money's end as human, not as the maker's
    alt = dict(ARGS); alt["pol_end"] = ("aristotle_pol", P, "yes", {("final", "human")})
    alt["th78_end"] = ("th78", P, "yes", {("final", "human")})
    show("usury, money's end typed human instead", plain.diagram([make(alt)]))
    # joint with the four cases
    bl = plain.blocks()
    four = [plain.case_from_block(n, bl) for n in ("modernity_property", "pendet", "soap", "mendacium")]
    d4 = plain.diagram(four)
    d5 = plain.diagram(four + [usury])
    print(f"four: {d4['phases']} phases, {d4['holding_runtime']} holding; with usury: {d5['phases']} phases, {d5['holding_runtime']} holding")
    # which runtimes the four leave together and usury parts
    for s, ks in d4["rt_phase"].items():
        if len(ks) > 1:
            sub = {}
            rts = plain.runtime_horizons()
            for k in ks:
                sub.setdefault(plain.reports(usury, rts[k]), []).append(k)
            print("  together under the four:", " ".join(sorted(ks)), "| usury parts them:" if len(sub) > 1 else "| usury keeps them", [sorted(v) for v in sub.values()] if len(sub) > 1 else "")
    d5a = plain.diagram(four + [make(alt)])
    print(f"with usury (money's end human): {d5a['phases']} phases, {d5a['holding_runtime']} holding")
    # an art domain: two parts more, money's end and its sterility typed there
    plain.EXTRA = [("ends_of_art", ("final", "art")), ("forms_of_art", ("formal", "art"))]
    art = dict(ARGS)
    art["pol_end"] = ("aristotle_pol", P, "yes", {("final", "art")})
    art["th78_end"] = ("th78", P, "yes", {("final", "art")})
    art["lat5_def"] = ("lateran_v", P, "yes", {("formal", "will"), ("formal", "art")})
    d = plain.diagram([make(art)], rts={})
    print(f"== with an art domain (4,096 horizons): order parameters {[AB[o] for o in d['order_parameters']]}; {d['phases']} phases")
