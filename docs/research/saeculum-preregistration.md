# TTC-SAECULUM(7)

## NAME

**ttc-saeculum** — one library for time: the Church's computation (cc. 8
§1, 97 §1, 200–203), one calendar for both layers, reception dated, the
order of events first and the measures laid on it; predictions, committed
before encoding

## DESCRIPTION

Read as the rules stand, before any run:

- **Two clocks.** The canon layer counts days (`YYYYMMDD`, `today/1`), the
  authority layer years (`asof/1`), joined by one bridge: an `asof` year is
  read at its last day (`Y*10000+1231`). With no `asof` the authority layer
  evaluates as of 9999, even in a case that gives `today`.
- **c. 8 §1 by hand.** Seven laws carry `vacatio_until/2`, typed by hand.
  Two name their own date (the Code of 1983; *Pascite gregem Dei*). Four
  take force on the day they were signed or approved, not three months
  from their issue of the *Acta Apostolicae Sedis*: *Ecclesia Dei*, the
  response of 1988, *Ad tuendam fidem*, *Omnium in mentem*. The declaration
  of 2000, in the form of law only in a HYPOTHETICAL part, binds at once.
  The cases are dated clear of each law's first months.
- **Ages by hand.** `age_at/3` is entered act by act. No birth date, no
  computation (c. 97 §1, c. 203).
- **Reception has no date.** `received_creed/1` warrants the Apostles'
  Creed and the *Quicumque* at tier 1 from their composition (700, 500).
  The claim has no claimant and is not computed both ways (TTC-COMMUNION
  left it to this step). As of 1100 the *Quicumque* alone excludes "from
  the Father alone" (CR1b).
- **An order without measures.** The kernel orders the economy (`next/2`,
  `before/2`: no cycle, not a line) and dates nothing; the creeds' one date
  is "under Pontius Pilate". Nothing refuses a date for the return, an
  event before creation, a divine procession placed in the order, or
  eternity said of a creature. `cand_arian` makes the Son a creature; no
  rule reads time in it.
- **Relations and years apart.** A source may interpret, cite or make a
  claim about a later act; nothing compares the dates. None in the base
  does.

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited.

## THE NORMS

Fixed here. Texts from vatican.va (Book I, in English and Latin).

- **c. 8 §1**: universal laws are promulgated in the *Acta Apostolicae
  Sedis* and take force only after three months have elapsed from the date
  of that issue, unless they bind at once from the nature of the matter or
  the law sets a shorter or longer *vacatio*.
- **c. 97 §1**: "Persona quae duodevigesimum aetatis annum explevit, maior
  est; infra hanc aetatem, minor."
- **c. 200**: time is computed by the canons that follow, unless the law
  expressly provides otherwise.
- **c. 201**: continuous time undergoes no interruption (§1); useful time
  does not run for one who is unaware or unable to act (§2).
- **c. 202**: a day is 24 continuous hours from midnight; a week, seven
  days; a month, thirty days and a year 365, unless they are to be taken
  as in the calendar (§1); continuous time always as in the calendar (§2).
- **c. 203**: "Dies a quo non computatur in termino, nisi huius initium
  coincidat cum initio diei aut aliud expresse in iure caveatur" (§1);
  "dies ad quem computatur in termino", and a term of months or years
  "finitur expleto ultimo die eiusdem numeri aut, si mensis die eiusdem
  numeri careat, expleto ultimo die mensis" (§2).
- **c. 26**: a custom has the force of law if lawfully kept "for thirty
  continuous and complete years". Unchanged here.
- **cc. 1323 n. 1, 1324 §1 n. 4, §3** (TTC-PENAL): under sixteen completed,
  no penalty; from sixteen to eighteen, tempered, and no latae sententiae
  penalty binds.
- **The *vacatio*'s count.** A canonist computes *Omnium in mentem*
  (AAS 102 (2010) 8–10, issue of 8 January 2010): the *vacatio* ran from
  8 January to 7 April, and the law took force on 8 April 2010. The issue's
  date counts as a whole day (c. 203 §1, its beginning the day's), so the
  three months end at the close of the day before the day of the same
  number, and the law binds from that day. Encoded so.

## THE TEACHING

Fixed here.

- **Eternity** is "the simultaneously-whole and perfect possession of
  interminable life" (Boethius; ST I q. 10 a. 1), "truly and properly so
  called" in God alone (a. 3). God is eternal and unchangeable (Lateran IV,
  DH 800; Vatican I, DH 3001).
- **Every creature began.** God "from the beginning of time" made both
  orders of creatures from nothing (DH 800; DH 3002). The world was made
  not in time but with time (Augustine, *De civ. Dei* XI.6). That it did
  not always exist, "by faith alone do we hold" (ST I q. 46 a. 2).
- **Time** is "the numbering of movement by before and after" (ST I q. 10
  a. 1), the measure of what changes. Between eternity and time, the
  *aevum* measures spiritual creatures (a. 5): Thomas's, not the deposit's.
- **The Son is co-eternal** with the Father (ST I q. 42 a. 2). Nicaea
  anathematizes "there was when he was not" (DH 126).
- **God's act is not in time.** "To God, all moments of time are present
  in their immediacy" (CCC 600; ST I q. 14 a. 13); his effects are in
  time.
- **The end is neither dated nor past.** "Of that day and hour no one
  knows" (Mt 24:36); "it is not for you to know times or seasons which the
  Father has fixed" (Acts 1:7; CCC 673); "only the Father knows the day and
  the hour" (CCC 1040). Refused: "holding that the resurrection is past
  already" (2 Tim 2:18).

## THE LIBRARY

Fixed here. A new file, `saeculum.lp`, among the libraries.

- **The order first.** Time is an order of events, partial and without
  cycle (the kernel's `before/2`); calendars are measures laid on it. A
  distributed system's architecture: no global clock, a happens-before
  order (Lamport, 1978), each event dated by whoever records it, as a
  commit's date is typed by whoever commits (rule 12).
- **The calendar.** Gregorian. A date is a day (`YYYYMMDD`). Month lengths
  and leap years are data, not norms.
- **One clock.** `now/1`, from `today/1`, or from the last day of an
  `asof` year. Both layers read it.
- **Precision.** A date not fixed to the day is an interval. A comparison
  the interval does not settle is computed both ways, as a disputed fact
  is (rule 2), and the branch says which.
- **The measures.** Eternity for God; for every creature a beginning;
  Thomas's *aevum* for spiritual creatures, carried as his. No refusal
  rests on the *aevum*.
- **The bounds.** The *saeculum* runs from creation to the return. Nothing
  is ordered before the beginning; the end is neither dated nor past.
- **The Church's computation is law** (rule 1): c. 8 §1, c. 97 §1 and
  cc. 202–203 sit in `canon_law.lp` under `@norm`, computed with the
  library's calendar.
- **Reception is the authority layer's**: a dated claim with its claimant,
  in `icon_authority.lp`.

## METHOD

Write `saeculum.lp`: the calendar, the clock, the measures, the bounds and
the agreement of measures with the order. In `canon_law.lp`, compute force
from the issue's date (`aas_issue/2`) under c. 8 §1 and c. 203, and ages
from birth dates (`born/2`) under c. 97 §1 and c. 203; replace the hand
entries; give intervals where the issue's date is unread, and put AAS 80
(1988) and 90 (1998) on the fetch list. In `icon_authority.lp`, reception
as a dated claim with its claimant, computed both ways. Cases, all
HYPOTHETICAL: laws issued on 29 and 30 November before a leap year and a
common one; marriages on 7 and 8 April 2010 after a formal defection; a
rejection dated inside an unread interval; a mother on her sixteenth
birthday and the day after; one born on 29 February; an interpretation
dated before its text; the return dated, and placed before a dated event;
an event before creation; the Son's generation placed in the order; the
world without beginning; light measured by eternity; God's decree dated.
Run the whole suite, the runtimes' boots and the coverage index.

## PREDICTIONS

### CT: the computation of time

- **CT1.** c. 8 §1 is computed from the issue's date: in force on the day
  of the same number three calendar months later. A law that names its own
  date keeps it: the Code of 1983 (27 November 1983), *Pascite gregem Dei*
  (8 December 2021), and the HYPOTHETICAL declaration of 2000.
  *Omnium in mentem* (issue of 8 January 2010) takes force on 8 April
  2010: a marriage on 7 April 2010 after a formal defection is free of the
  form (c. 1117 as it then stood); one on 8 April is bound.
- **CT2.** The month that lacks the day, and leap years. An issue of
  29 November 2023 binds from 29 February 2024; of 30 November 2023, from
  1 March 2024; of 29 November 2022, from 1 March 2023.
- **CT3.** Unread issues. Where the issue's date is not read (AAS 80
  (1988), for *Ecclesia Dei* and the response of 1988; AAS 90 (1998), for
  *Ad tuendam fidem*), the issue lies between the act's own date and the
  last day of the volume's year, and force between three months after
  each. No case in the base falls inside: no output changes, no branch
  appears. A HYPOTHETICAL obstinate rejection of a definitive teaching
  (c. 750 §2) on 1 December 1998 branches on the fact: a delict under
  c. 1371 n. 1 as amended in one branch, none in the other.
- **CT4.** Ages. From a birth date, the completed years at the act's date
  (c. 97 §1, *explevit*; c. 203: the day of birth not counted, the year
  completed at the close of the day of the same number). On the sixteenth
  birthday sixteen is not yet completed: c. 1323 n. 1 exempts. The day
  after, c. 1324 §1 n. 4 tempers, and §3 lifts the latae sententiae
  penalty. One born on 29 February 2008 completes eighteen at the close of
  28 February 2026: an act on 28 February 2026 is a minor's, tempered; on
  1 March, an adult's. `age_at/3` stays an input; AB1–AB9 unchanged.

### CA: one calendar

- **CA1.** One clock. With `today/1` and no `asof`, the authority layer
  evaluates as of today's year, not 9999. No output changes: no part that
  sets `today` is run with a source dated after 2026.
- **CA2.** One act, one date. An act dated in both layers must agree on
  its year (`violation(dates_disagree/3)`). *Ecclesia Dei* (1988; 2 July
  1988) and the declaration of 2000 agree: none refused.
- **CA3.** Customs (c. 26) are computed at the last day of the `asof`
  year, as now: CU1–CU8 unchanged.

### RC: reception dated

- **RC1.** A creed received is a claim: `reception_claim/3` (the creed,
  its claimant, the year). From the year claimed it is computed both ways
  (rule 14), and the branch resting on it is never preferred unless an act
  at tier 1 in force hands the creed on as a rule of faith
  (`reception_fixed_by/2`). Not received, the text is not in force as the
  Church's. A claim without its claimant is refused.
- **RC2.** CR1b changes. As of 1100 the *Quicumque*'s reception is
  claimed and no act at tier 1 hands it on: two main branches; "from the
  Father alone" is excluded only where the claim holds, a branch not
  preferred. Open as of 1100, not excluded; Lateran IV settles it from
  1215. The expectation changes, stated (rule 7). Were the claim dated
  after 1100: one branch, open, and RC2 false in its second sentence.
- **RC3.** No other value changes: CR1, CR1d, CR1e, CM1b, CM1c and CR1c's
  tiers stand. The scenarios that load the creeds gain the reception
  branches.

### OR: the order first

- **OR1.** What interprets, cites or makes a claim about an act comes
  after it. A source dated before the act it so depends on is refused
  (`violation(measure_against_order/2)`). None in the base; a HYPOTHETICAL
  interpretation dated before its text is refused.
- **OR2.** The end is neither dated nor past. A date laid on the return
  or the judgment is refused (Mt 24:36; Acts 1:7), and so is a dated event
  ordered after the return (2 Tim 2:18). The economy's order stands: the
  CE and K scenarios unchanged.
- **OR3.** Nothing before the beginning. An event ordered before creation
  is refused (DH 800, "ab initio temporis"). The age of the world is the
  empirical step's.
- **OR4.** The order stays partial. No rule makes it a line; a second path
  (`cand_grace_unforeseen`, the call of Abraham) stays well formed.

### MD: the measures

- **MD1.** The measures typed: eternity for God, a beginning for every
  creature, the *aevum* for angels as Thomas's. No subject gets two; the K
  scenarios unchanged.
- **MD2.** A divine procession (the kernel's `orig_div/2`) placed in the
  order, or dated, is refused: "there was when he was not" (DH 126). The
  Son's birth of Mary is in time, in his humanity (the kernel's modes):
  CR2 unchanged.
- **MD3.** Eternity said of a creature is refused on DH 800: a world
  without beginning (`cand_world_eternal`), and light given eternity's mode
  for its zero proper time (`cand_light_eternal`), both HYPOTHETICAL. The
  first is refused by faith, not demonstration (ST I q. 46 a. 2); the
  refusal cites the council.
- **MD4.** God's act is not dated; its effects are. A divine decree placed
  at a time (`cand_decree_dated`) is refused (DH 3001; CCC 600). Creation's
  first instant, the nativity and the passion stay in the order.

### M: meta

- **M1.** No earlier check changes but CR1b (RC2). The canon scenarios
  keep their outputs under computed dates (CT1, CT3); the TTC-SCHOOLS
  tables do not change.
- **M2.** Every new rule has a test that fails without it; CL1 and PR4
  stay clean; the calendar's data draws no edge in the norm graph.
- **M3.** In the coverage index, "Jesus died crucified" (CCC 595–623) and
  "He will come again" (668–682) leave the cases for the rules; the rule
  files cite CCC 600, 673 and 1040.

## CAVEATS

The *vacatio*'s count follows one canonist's computation, which the text
supports ("a die qui Actorum numero appositus est"). Counting the issue's
day out (c. 203 §1's ordinary rule) would give the day after. Were
canonists divided, the boundary day would branch (rule 2).

The count of ages is the encoder's reading of c. 203: birth does not begin
with the day, so the day of birth is not counted, and a year of age is
completed at the close of the birthday. Civil reckonings often count the
day of birth, completing the year at its start. To check against a
commentary on c. 97 at encoding; if canonists divide, the birthday
branches.

The issues of AAS 80 (1988) and 90 (1998) are not read here. Their dates
replace the intervals when read.

The calendar is Gregorian. Dates before 15 October 1582 are Julian in the
record; the library does not convert them. The base dates no day before
1983.

The reception's year and claimant are read at encoding from a historian's
account. Whether the Council of Florence's decree for the Armenians (1439)
hands on the *Quicumque* is read too: if it does, the reception is fixed
from 1439, and no scenario before 1439 changes.

Useful time (c. 201 §2) and the month of thirty days (c. 202 §1) are not
computed: no canon in the base sets such a term.

The *aevum* is Thomas's, and nothing is refused on it. Light's zero proper
time is a statement within relativity about a creature's path; MD3 refuses
the typing, not the physics.

Not in this step: the "now" as an antichain, causal sets, the cogitative
power and git thought (roadmap, CANDIDATE THEORIES). The separated soul's
measure, purgation without days, and one event joined to many times are
the last things'.

## STANDARDS

- CIC 1983 cc. 8 §1, 9, 26, 97 §1, 200–203, 1117, 1323 n. 1, 1324 §1 n. 4,
  §3 (https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html;
  https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann96-123_en.html;
  https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann200-203_en.html;
  https://www.vatican.va/archive/cod-iuris-canonici/latin/documents/cic_liberI_la.html)
- Benedict XVI, *Omnium in mentem* (26 October 2009), AAS 102 (2010) 8–10
- Universität Würzburg, Kirchenrecht, KdM 44: c. 8 § 1, *vacatio legis*
  (2021)
  (https://www.theologie.uni-wuerzburg.de/fileadmin/01040800/2021/KdM_44__8_1__vacatio_legis__Gesetzesschwebe__.pdf)
- Nicaea I (DH 126); Lateran IV, *Firmiter* (DH 800); Vatican I, *Dei
  Filius* ch. 1 (DH 3001–3002)
- Mt 24:36; Acts 1:7; 2 Tim 2:18
- Boethius, *De consolatione philosophiae* V, pr. 6; Augustine, *De
  civitate Dei* XI.6
- Aquinas, ST I q. 10 aa. 1, 3, 5; q. 14 a. 13; q. 42 a. 2; q. 46 a. 2
- CCC 600, 673, 1040
- L. Lamport, "Time, Clocks, and the Ordering of Events in a Distributed
  System", *Communications of the ACM* 21 (1978) 558–565

## SEE ALSO

[ttc-penal(7)](penal-preregistration.md), [ttc-creed(7)](creed-preregistration.md),
[ttc-communion(7)](communion-preregistration.md), [ttc-canon(5)](../canon-law-layer.md),
[ttc-roadmap(7)](../roadmap.md)

## SCORING

Appended after the runs. Predictions committed in bc23021, stamped in
4b8d31a. Encoded in `saeculum.lp` (new: the calendar, the clock, one act
one date, the order, the bounds, the measures, the candidates),
`canon_law.lp` (c. 8 §1 from the issue, spans, `force_at/2`; c. 203's
counts; c. 97 §1), `icon_authority.lp` (reception), `icon_history.lp` (the
claims; Florence's decree for the Armenians), `canon_cases.lp`,
`library.lp`, `engine.py`, `schools.py`. Scenarios CT, CA, RC, OR, MD (16;
478 in all).

| | Result |
| --- | --- |
| CT1 | Held (CT1). *Omnium in mentem* binds from 8 April 2010: the same defector's marriage on 7 April is free of the form; on 8 April it is bound and, with no delegation, invalid in form. The Code of 1983, *Pascite gregem Dei* and the HYPOTHETICAL declaration of 2000 keep their own dates. |
| CT2 | Held (CT2), and a test adds the centuries: an issue of 29 November 1899 binds from 1 March 1900 (a common year), of 29 November 1999 from 29 February 2000. |
| CT3 | Held (CT3). The spans: *Ecclesia Dei*, 2 October 1988 to 31 March 1989; the response of 1988, 23 August 1988 to 31 March 1989; *Ad tuendam fidem*, 18 August 1998 to 31 March 1999. The rejection of 1 December 1998 is a delict under the amended canon in one branch, none in the other; no case of the base falls inside a span, and no canon output changed. |
| CT4 | Held (CT4). |
| CA1 | Held (CA1). With `today` the graph is read as of 2026; no output changed. |
| CA2 | Held (CA2). |
| CA3 | Held: CU1–CU8 unchanged. |
| RC1 | Held (RC1). The *Quicumque*'s claim is the New Schaff-Herzog Encyclopedia's (1908): sung at Prime "throughout the Western Church" from the Carolingian period, entered as 800. The Apostles' Creed's claimant is CCC 194, which gives no year; the year entered is its text's (700), the encoder's, noted in the history. With an act at tier 1 handing the creed on (HYPOTHETICAL), no branch; before it, both ways; as of 600, the *Quicumque* is not in force. |
| RC2 | Held (CR1b, changed and stated). As of 1100 both creeds' receptions are computed both ways (12 branches); "from the Father alone" is open, and absent from every branch where the *Quicumque* is received. |
| RC3 | Held. No value changed. Models: CR1 1 to 4, CR1b 2 to 12, CR1d 1 to 2, CR1e 2 to 4, CM1b 4 to 16, CM1c 2 to 8; CR1c's one model records the claims. |
| OR1 | Held (OR1). |
| OR2 | Held (OR2, OR2b). |
| OR3 | Held (OR3). |
| OR4 | Held (OR4). |
| MD1 | Held (MD1). |
| MD2 | Held (MD2). |
| MD3 | Held (MD3). |
| MD4 | Held (MD4). |
| M1 | Held. No earlier check changed but CR1b; one test's scope widened to leave out the new scenarios that load the creed (below). K7 and RT4 gained `eternal_with_beginning(son)` (their checks unchanged); the scenarios loading the creeds gained the reception branches; every output gained the New Schaff-Herzog in the library's display. The TTC-SCHOOLS tables did not change. |
| M2 | Held after closing gaps. Each new statement was deleted in turn (50 in `saeculum.lp`, 41 in `canon_law.lp`, 16 in `canon_cases.lp`, 12 in `icon_authority.lp`, 6 in `icon_history.lp`, and the library's). Closed on the way: glosses dated before the texts they interpret, grade or claim for the ordinary universal magisterium (only *cites* had a case); a day laid on the judgment, and a dated source after the return; the spiration dated; God's decrees before an event and at a year; the preferred branch never resting on a reception, and a received creed warranted; two acts inside one span, so that force once begun lasts; one defector in two alternative marriages, where two defectors had made one premise idle. Unit tests kill two more: the leap rule for years divisible by 400 (2000), and a work cited but undeclared (a new test of the library). What survives: the laws' citations of the *Acta* (`cites_work/3` for acts that are not sources), records no rule reads, as *Ecclesia Dei*'s already was. CL1 and PR4 clean. |
| M3 | Held: "Jesus died crucified" and "He will come again" move to rules (44 units under rules, 7 under cases, 36 frontier); the rule files cite CCC 600, 673, 1040, and 194 besides (30 paragraphs). |

### Caveats, read

- **Florence's decree for the Armenians** (22 November 1439) hands the
  *Quicumque* on, "that compendious rule of the faith composed by most
  blessed Athanasius", in "a summary of the truth of the orthodox faith
  that the Roman church professes": no definition. The caveat's "if it
  does, the reception is fixed from 1439" assumed an act at tier 1; RC1
  asks one, and this is a witness at tier 3 (`handed_on_below_tier_1`).
  The reception stays a claim in every year.
- **The age's count** was not checked against a commentary on c. 97: still
  the encoder's reading of c. 203, with the birthday tested.
- **The *vacatio*'s count** is the canonist's, and agrees with *Omnium in
  mentem*'s published date.

### Not predicted

- **The preferred branch as of 1100 is "from the Father alone"**, by
  Photius's weight (886): the record has no Latin witness to the Filioque
  before Anselm (1102). A gap in the record, now on the roadmap.
- **Arius's Son is refused on time as well** (K7, RT4):
  `eternal_with_beginning(son)`. DESCRIPTION's "no rule reads time in it"
  no longer holds; K7's check did not change.
- **December lacks no day.** The clause for a month after the last that
  lacks the day could never fire; it was removed.
- **A council's decree at tier 3 needs its character** (PR4).
- **The order's cases load the creed**, so monopatrism changes their
  processions: the test that monopatrism changes only the processions now
  excludes the saeculum group, as it excludes the creed's and Christ's
  (stated in the test).
- **The library reads the kernel and the authority graph** through ten
  declared slots, so the norm graph stays closed.
- **The notes check compares like with like.** NT1's check groups branches
  by the claims computed both ways; a creed's reception is now one of them,
  so a branch where the *Quicumque* is received is compared only with
  branches where it is too (`notes_check.py`).
