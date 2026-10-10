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
   and nothing more is assumed.

## TIME

Each act is judged on its own date. A 2026 revocation does not reach a 2018
absolution. Norms carry the dates they are in force: c. 1382 (1983) until
8 December 2021, c. 1387 after. "Now" is `today/1`, or an `asof_YYYY` part.

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
| `% @end` | Closes the current norm, for display rules. |

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
| general | 16 §1; 135 §2; 333 §3; grants until competently revoked |
| delicts | 751 with 1364 §1 (and 1983); 1382 (1983); 1387; 1379 §1 n. 2 |
| imputability | 1321 §4; 1323 n. 4 and 1324 (recorded, never decided); 1355 |
| procedure | 1717 §1; 1342 §1 with 1720 n. 1; 124 §2; 1353 |
| effects | 1331 §1 n. 1, §2 n. 2; 1335 §2 |
| sacraments | 966, 976, 144 §2; 1108 §1, 1111 |

## SEE ALSO

[ttc(7)](guide-for-theologians-and-canonists.md), [ttc-flywheel(7)](flywheel.md),
[ttc-encoding(5)](encoding-guide.md), [cases/sspx-2026.md](cases/sspx-2026.md)

## BUGS

About two dozen canons out of 1752. The rest is the frontier.

The Dicastery for the Doctrine of the Faith's special norms (*Sacramentorum
sanctitatis tutela*) are not encoded. Neither are c. 1313 (the more
favourable law after a change), c. 1332 (interdict) and c. 1352.
