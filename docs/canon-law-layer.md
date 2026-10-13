# TTC-CANON(5)

## NAME

**ttc-canon** — canon law as dated yes/no rules, and the norm graph

## DESCRIPTION

Given the facts and the norm in force, an effect follows or it does not.
Nothing in this layer is weighed:

- c. 16 §1: the legislator interprets.
- c. 18: penal laws are read strictly.
- c. 19: the opinion of the learned fills gaps, and never in penal cases.
- cc. 20, 21, 135 §2: later beats earlier; revocation is not presumed;
  lower never beats higher.

The authority graph is for teaching. Using it for law is a type error.
This layer was written after making that error once.

## BRANCHING

The layer branches in three cases only.

1. **A disputed fact**: `disputed(F)`. Both ways are computed, and the
   branch records `assumed_fact(F)` or `assumed_fact(false(F))`.
2. **A disputed reading** of a canon with no authentic interpretation:
   a switch. `authentic_reading/3` closes it.
3. **The internal forum**: never computed. In the external forum,
   imputability is presumed once a violation is established (c. 1321 §4),
   and nothing more is assumed. What a case claims about the agent's
   knowledge, will or freedom is input (`interior/3`), read through the
   library of the human act (`act.lp`); a disputed claim is computed both
   ways like any disputed fact.

## THE HUMAN ACT

The canons that speak of knowledge, will, fear, ignorance and reason call
one library, `act.lp` ([ttc-act(7)](research/act-preregistration.md)).
It types the claims; the canons give the effects.

| Claim (`interior(P, A, …)`) | Library | Read by |
| --- | --- | --- |
| `violence`, `reason(lacking)`, `reason(habitually_lacking)` | no human act (ST I-II q. 1 a. 1; q. 6 a. 5) | cc. 125 §1, 1103, 1321–1323 |
| `ignorance(Of, Kind)`, `error(…)`, `inadvertence(…)` | without fault, with fault, gross | cc. 1323 n. 2, 1324 §1 n. 9, 1325; culpa |
| `fear(Grade, Origin, How)`, `escape_choice` | a mixed voluntary (q. 6 a. 6) | cc. 125 §2, 1103, 1323 n. 4, 1324 §1 n. 5 |
| `necessity`, `chance`, `defence(moderate)`, `believed(C, Kind)` | | cc. 1323 nn. 3–5, 7; 1324 §1 n. 8 |
| `reason(imperfect)`, `passion(grave, unstimulated)` | | c. 1324 §1 nn. 1, 3 |
| `deliberate`, `negligence` | dolus, culpa (c. 1321 §§2–3) | c. 1321; `punishes_culpa/1` |

No rule derives `interior/3` (`test_interior_is_never_derived`). The
library presupposes that creatures act: on the bare runtime no human act
exists, and no penalty is incurred.

## TIME

Each act is judged on its own date. A 2026 revocation does not reach a 2018
absolution. Norms carry the dates they are in force: c. 1382 (1983) until
8 December 2021, c. 1387 after. "Now" is the one clock of `saeculum.lp`:
`today/1`, or the last day of an `asof_YYYY` part.

A law's force is computed, not typed (c. 8 §1 with c. 203): on the day of
the same number three calendar months after its issue of the *Acta
Apostolicae Sedis*, or the first day of the next month where that month
lacks the day; *Omnium in mentem*, issue of 8 January 2010, binds from
8 April 2010. A law that names its own date keeps it (the Code of 1983,
*Pascite gregem Dei*). Where the issue's date is unread, force lies in a
span; a date inside it is computed both ways. Ages come from birth dates
(c. 97 §1, c. 203): on the birthday the year is not yet completed.

An authentic interpretation in the form of law reaches the acts placed from
its force (c. 8 §1), and an earlier act only where it is declaratory
(c. 16 §2): laws regard the future (c. 9). The response of 1988 on abortion
is extensive, so a killing in utero in 1987 falls to c. 18's strict reading.
Whether *Ecclesia Dei* (2 July 1988), given as law, was declaratory is
disputed and computed both ways; only where it was does it reach the
consecrations of 30 June.

## LAW

The general norms call one library, `law.lp`
([ttc-law(7)](research/law-preregistration.md)): the order of laws
(eternal, natural, divine positive, ecclesiastical; ST I-II qq. 91–95), a
law against a higher law (q. 96 a. 4; c. 135 §2), the readings a law
admits.

| Canon | What it does here |
| --- | --- |
| 7–8, 20, 203 | Dates in force: computed from the issue (c. 8 §1, c. 203), or a date the law names; abrogation by a reordering law. |
| 16 §§1–3 | An authentic interpretation binds generally as law, a particular matter otherwise. |
| 17 | A disputed reading branches; the supreme legislator's law is read in harmony with a higher law. |
| 18 | Penal terms take the strictest admissible reading. |
| 14 | In a doubt of law, an obliging or invalidating law reaches only what every reading reaches; in a doubt of fact the ordinary may dispense. |
| 19 | A lacuna takes an equitable rule as input, never in a penal matter. |
| 21 | Revocation in doubt is not presumed. |
| 85–86 | Only a merely ecclesiastical law, not defining what constitutes an act, is dispensed. |

## SYNTAX

```prolog
% @norm cic2021:1387 | c. 1387: consecrator and consecrated without pontifical mandate incur latae sententiae excommunication reserved to the Apostolic See | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
delict(B,n1387,E) :- consecrates(E,B), event_date(E,T), not pontifical_mandate(E), norm_in_force(n1387,T).
delict(R,n1387,E) :- consecration(E,_,R,T), not pontifical_mandate(E), norm_in_force(n1387,T).
penalty(n1387,excommunication).
```

| Tag | Meaning |
| --- | --- |
| `% @norm id \| citation \| source` | Starts a norm. Rules belong to it until the next tag. |
| `% @input name/arity \| meaning` | A fact a case supplies. |
| `% @temporal id` | Effects fall on later acts; a loop through it is recursion, not circularity. |
| `% @recursive id` | One person's delict defined by another's (c. 1329); a loop through it is recursion over persons. |
| `% @end` | Closes the current norm, for display rules. |
| `% @library` | A library file (`act.lp`): its predicates count as defined in the norm graph. |

Real facts go in case files. Hypothetical facts go in switch programs,
marked `HYPOTHETICAL`.

## SOURCES

[iuscangreg](https://www.iuscangreg.it/) (Faculty of Canon Law, Pontifical
Gregorian University):

| Page | Use |
| --- | --- |
| [cic1983.php](https://www.iuscangreg.it/cic1983.php), [cceo.php](https://www.iuscangreg.it/cceo.php) | `@norm` rules |
| [diritto_tutto.php](https://www.iuscangreg.it/diritto_tutto.php) | papal and curial legislation; grants and decrees as facts |
| [risposte.php](https://www.iuscangreg.it/risposte.php) | authentic interpretations: `authentic_reading/3` |
| [diritto_particolare.php](https://www.iuscangreg.it/diritto_particolare.php) | particular law, below universal law |
| [cic1917.php](https://www.iuscangreg.it/cic1917.php), [diritto_anteriore.php](https://www.iuscangreg.it/diritto_anteriore.php) | earlier versions, with dates |
| [stsa_contadmin.php](https://www.iuscangreg.it/stsa_contadmin.php) | Signatura jurisprudence, for gaps under c. 19 (not penal) |
| [biblio_ricerca.php](https://www.iuscangreg.it/biblio_ricerca.php), [Periodica](https://periodica.iuscangreg.it/) | commentators: tier 5, readings only |

vatican.va carries the current English text, including the 2021 Book VI.

## THE NORM GRAPH

Norm A *feeds* norm B if B uses what A derives. Definitions feed delicts,
delicts feed penalties, and penalties feed effects and their exceptions.

**norm_graph** draws the graph (Mermaid or JSON). **norm_check** reports
vicious cycles, temporal loops, undefined predicates and unused inputs.
Undefined predicates are the **frontier**: what to encode next. Test CL1
keeps the frontier empty for the public base.

## CHECKING A TEXT

`asserts(Text, Claim, Date)` records a text's claim. For each act, the layer
reports `claim_confirmed` or `claim_contradicted`. A contradiction is a
question: either the text knows a fact the encoding lacks, or the text is
wrong.

## ENCODED

| Area | Canons |
| --- | --- |
| general | 7, 8 §1 (computed); 9; 14; 16 §§1–3 (with the dates of §2); 17; 18; 19; 20; 21; 85, 86; 97 §1; 135 §2; 200–203; 333 §3; grants until competently revoked |
| persons | 11; 96; 113–120 (physical and juridic persons, moral persons by divine ordinance); 205 |
| delicts | 751 with 1364 §1 (and 1983); 1371 n. 1 (1983, 1998); 1365; 1382 (1983); 1387; 1379 §1 n. 2; 1386 §1; 1398 (1983) and 1397 §2, with the interpretation of 1988; 1398 §1 n. 1 with the Dicastery's art. 6 n. 1 (2021); 1399 |
| imputability | 1321 §§2–4; 1322; 1323; 1324 §1 nn. 1, 3, 4, 5, 8, 9, §3; 1325; 1328 §1; 1329 §2; 1355 |
| juridic acts, consent | 125 §§1–2; 1103 |
| procedure | 1717 §1; 1342 §1 with 1720 n. 1; 124 §2; 1353; 1752 |
| effects | 1331 §1 n. 1, §2 n. 2; 1335 §2 |
| sacraments | 966, 976, 144 §2; 1108 §1, 1111 |

## SEE ALSO

[ttc(7)](guide-for-theologians-and-canonists.md), [ttc-flywheel(7)](flywheel.md),
[ttc-encoding(5)](encoding-guide.md), [cases/sspx-2026.md](cases/sspx-2026.md)

## BUGS

About two dozen canons out of 1752. The rest is the frontier.

Of the Dicastery for the Doctrine of the Faith's norms on reserved delicts
(2021), only art. 6 n. 1 is encoded. Neither are c. 1313 (the more
favourable law after a change), c. 1328 §2, c. 1332 (interdict), c. 1352,
and remission beyond c. 1355's dates (c. 1355 §2; *Misericordia et misera*
12). The Eastern Code is not encoded: the canon layer is Latin.

The issues of AAS 80 (1988) and 90 (1998) are unread: *Ecclesia Dei*, the
response of 1988 and *Ad tuendam fidem* take force within spans. Useful
time (c. 201 §2) and the month of thirty days (c. 202 §1) are not
computed. Dates before 15 October 1582 are not converted from the Julian
calendar.
