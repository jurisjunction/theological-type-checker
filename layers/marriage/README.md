# MARRIAGE(7)

## NAME

**marriage** — the grounds of nullity as a personal layer: consent (cc. 1095-1103, CCEO cc. 818-826), the diriment impediments (cc. 1083-1094, CCEO cc. 800-812), and the form's liceity (cc. 1116, 1124, 1127; CCEO cc. 813, 832, 834)

## SYNOPSIS

    save_rules("marriage_consent",     <marriage_consent.lp>)
    save_rules("marriage_impediments", <marriage_impediments.lp>)
    save_rules("marriage_form",        <marriage_form.lp>)
    save_scenario(<each entry of marriage_scenarios.json>, parts=["sacrament_conditions"], facts=<the three *_cases.lp files>)

or, by hand, `cp marriage_*.lp $TTC_HOME/rules/` and run `ttc-suite`. The
three files are one set: the impediments and the form write to predicates
the consent file declares (`ground_at_issue/2`, `ground_engaged/2`,
`ground_engaged_by/3`, and the `info(ground(...))` rules).

## DESCRIPTION

Three layers, one output. Every ground a tribunal formulates, entered as
`ground_at_issue(M, G)`, comes back per branch as `info(ground(M,G,engaged))`
or `info(ground(M,G,not_engaged))`, with `info(ground(M,G,engaged_by(N)))`
naming the canon, Latin or Eastern, that engaged it. A ground formulated with
nothing under it is `not_engaged` on every branch: bare.

**Consent.** Each canon reads supplied `interior/3` claims and derives
`consent_vitiated_by(M,G)`, feeding the base's `consent_vitiated/1` and so
the bond (c. 1057). Nothing derives a claim (rule 3). New slots:
`ground_at_issue/2`, `intended/3`, `deceit/5`, `quality_gravely_disturbs/1`,
`condition/4`, `fulfilled/1`. New elements of `interior/3`:
`discretion(grave_defect)`, `incapacity(assume_obligations,psychic)`,
`error_of(person)`, `error_of(quality(Q))`, `positive_will(excludes(X))`, and
`to_obtain_consent` said of a deceit. The Latin canons read the Latin faithful,
the Eastern canons the Eastern (c. 1); a ground formulated by its Latin canon is
engaged by the Eastern twin for an Eastern party (`same_ground/2`), and the sheet
says so. The codes part once: a condition about the past or present stands or
falls with its fulfilment under c. 1102 §2 and invalidates outright under
CCEO c. 826.

**Impediments.** Outward facts about a person or a pair, read from the
record; c. 1090's purpose is the one supplied claim. Kinship is computed by
the Roman reckoning from `father/2`, `mother/2` and `adopted/2`; affinity from a
valid marriage contracted before the one at issue. Each stands as
`defect_of_marriage(M, impediment(K))`, so the base's c. 1057 and c. 85 decide
the bond and the reach of a dispensation. The layer enters as divine law only
what the canons say of themselves (impotence "by its very nature", c. 1084;
the prior bond, c. 1141); c. 1078 §3's "never given" for the direct line and
the second collateral degree is entered as what it is, a rule about
dispensing, whose breach is a violation that relaxes nothing. Whether those
degrees are of divine law is left open on the theology side (Thomas, Suppl.
q. 54 a. 3, read two ways); the law does not answer it. Reserved impediments
(orders, a pontifical vow, crime: c. 1078 §2) dispensed by one not competent
are a violation and stand. A disputed impotence impedes nothing (c. 1084 §2).
The codes part twice: affinity in the second collateral degree (CCEO c. 809)
and spiritual relationship (CCEO c. 811), neither in the Latin Code of 1983.

**Form.** The base computes validity. This layer adds the Eastern
non-Catholic Churches its list leaves out (the Church of the East is neither
Eastern nor Oriental Orthodox; the named Churches are for a record that names
them), the extraordinary form (c. 1116; CCEO c. 832), and liceity: a marriage
valid in its form is reported `valid_form_but_illicit` where the form bound for
liceity only and was not kept (c. 1127 §1; CCEO c. 834 §2), or where the
permission of c. 1124 (CCEO c. 813) is not on record. `lack_of_form` as a
ground is engaged where the form bound, was not kept, and was not dispensed.

## FRAME

Load `sacrament_conditions`: the form's dispensability (c. 1127 §2) comes from
the theology side, which holds that the form is the Church's and not of the
substance. Without it a dispensation from the form has no effect and the
marriage reads as lacking form.

## DATES

The consent canons are not date-gated, as the base's c. 1103 is not. c. 1102 §1
is the law of 1983. c. 1098, for a marriage before 27 November 1983 (or an
Eastern party's before 1 October 1991), branches on a disputed reading,
`declarative_of_natural_law` or `merely_positive`, with no authentic
interpretation; neither is preferred, and no `narrower/2` is entered, so
c. 14 does not decide it. An Eastern party before 1991 falls under Crebrae
allatae (1949), not encoded: the base's `no_eastern_code_in_force` is raised and
nothing is engaged. The impediments of ecclesiastical law and the Eastern
canons are gated on their codes.

## FILES

| File | Holds |
| --- | --- |
| `marriage_consent.lp` | cc. 1095-1103 and CCEO cc. 818-826; the cross-code table; the output rules |
| `marriage_impediments.lp` | cc. 1083-1094, CCEO cc. 800-812, c. 1078; kinship; dispensation and reservation |
| `marriage_form.lp` | the Churches; cc. 1116, 1124, 1127 §1; CCEO cc. 813, 832; `lack_of_form` |
| `marriage_*_cases.lp` | HYPOTHETICAL: invented parties, a delegated priest so only the matter at issue is read |
| `marriage_scenarios.json` | 47 scenarios in `save_scenario`'s shape |
| `make_scenarios.py` | rebuilds the JSON; checks each scenario passes with the layers and fails without them |

## TESTS

44 scenarios are red without the layers and green with them; PMC22, PMC28
and PMC47 are guards (the layers leave the form alone; no Latin consent id is
said of an Eastern party; the divine-law question stays open) and pass both
ways by design. `fix_method` over the
base's 563 tests, with the three layers added together: `no loss`, 0 newly
failing, 0 outputs changed (run on a checkout of the base at the commit this
was drafted on; run it again on yours before saving).

## CAVEATS

Drafted after the fact, not before: rule 12 wants the predictions stamped
first. Treat the scenarios as the predictions, stamp them, and then save.
Impotence and the prior bond are typed divine on the canons' own words
(c. 1084 §1, c. 1141); the theology side's reasons are owed. The near degrees
of consanguinity are not so typed: a report that a pope once dispensed
siblings who had married unknowing was raised in review and is not entered,
being unverified here; if sourced it would be a juridical act at its own
tier and would not decide the doctrinal question either way (rule 1). The `bonum_coniugum` species is the Rota's reading of
"essential element", not the canon's word. c. 1091 §4's doubt of consanguinity
(never permitted) is not encoded. c. 1089 reads the woman's release as an
outward fact and not her free choice (rule 3). CCEO c. 810 §1 may have a third
source of public propriety (an attempted civil marriage); not entered until
read. The Latin texts quoted are from memory where the file says so and are to
be checked against iuscangreg before any of this leaves the personal layer.

Ora pro me, peccatore.
