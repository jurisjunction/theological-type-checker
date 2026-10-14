# MARRIAGE_CONSENT(7)

## NAME

**marriage_consent** — the grounds of nullity from defective consent, cc. 1095-1103, as a personal layer

## SYNOPSIS

    save_rules("marriage_consent", <marriage_consent.lp>)
    save_scenario(<each entry of marriage_consent_scenarios.json>, facts=<marriage_consent_cases.lp>)

or, by hand, `cp marriage_consent.lp $TTC_HOME/rules/` and run `ttc-suite`.

## DESCRIPTION

The base has c. 1103 and the form. This layer adds the other consent canons
the tribunals formulate: c. 1095 1°-3°, c. 1096, c. 1097 §§1-2, c. 1098,
c. 1101 §§1-2 (seven species), c. 1102 §§1-2. Each is a rule that reads
supplied claims and derives `consent_vitiated_by(M,G)`, which feeds the
base's `consent_vitiated/1` and so the bond (c. 1057). Nothing derives a
claim (rule 3): the interior is `interior/3`, supplied or `disputed`.

New slots: `ground_at_issue/2` (the dubium), `intended/3`, `deceit/5`,
`quality_gravely_disturbs/1`, `condition/4`, `fulfilled/1`. New elements of
`interior/3`: `discretion(grave_defect)`, `incapacity(assume_obligations,psychic)`,
`error_of(person)`, `error_of(quality(Q))`, `positive_will(excludes(X))`,
and `to_obtain_consent` said of a deceit.

Output, per formulated ground: `info(ground(M,G,engaged))` or
`info(ground(M,G,not_engaged))`, on every branch or on some. A ground
formulated with no claim under it is `not_engaged` on every branch: bare.
Also `info(marriage(M,invalid_consent,G))`, `info(presumed_consent(P,M))`
(c. 1101 §1) and `info(c1098_reading(M,R))`.

## DATES

The consent canons are not date-gated, as the base's c. 1103 is not: the
Rota reads them of marriages before 1983 as stating what consent is. Two
exceptions. c. 1102 §1 (a future condition invalidates) is the law of 1983
and gated on it. c. 1098, for a marriage before 27 November 1983, branches on
a disputed reading (`declarative_of_natural_law`, `merely_positive`) with
no authentic interpretation; neither is preferred, and no `narrower/2` is
entered, so c. 14 does not decide it. A reviewer may hold that it should.

## FILES

| File | Holds |
| --- | --- |
| `marriage_consent.lp` | the rules, under `@norm`/`@input` tags, for `save_rules` |
| `marriage_consent_cases.lp` | HYPOTHETICAL: one marriage per rule, invented parties, a delegated priest so only consent is at issue |
| `marriage_consent_scenarios.json` | 22 scenarios in `save_scenario`'s shape; `facts` is the cases file |
| `make_scenarios.py` | rebuilds the JSON and checks each scenario passes with the layer and fails without it |

## TESTS

Run against a checkout of the base at the commit this was drafted on:
`fix_method(add_rules=<layer>)` over 563 tests: `no loss`, 0 newly failing,
0 outputs changed. The 21 rule scenarios are red without the layer and green
with it; PMC22 is a guard and passes both ways by design.

## CAVEATS

Drafted after the fact, not before: rule 12 wants the predictions stamped
first. Treat the scenarios as the predictions for review, stamp them, and
only then save. The `bonum_coniugum` species is the Rota's reading of
"essential element", not the canon's word; a reviewer may fold it into
`essential_element/1`. The citations are vatican.va's English text; the
Latin of c. 1095 is quoted from memory and should be checked against
iuscangreg before the layer leaves the personal layer.

Ora pro me, peccatore.
