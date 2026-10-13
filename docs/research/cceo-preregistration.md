# TTC-CCEO(7)

## NAME

**ttc-cceo** — the Eastern Code: a second canon layer chosen by
ascription; the strata of the law; links stated and links *ex natura rei*;
*De concordia inter Codices*; penalties imposed, never incurred; two
repairs, who is bound and the minister of confirmation; predictions,
committed before encoding

## DESCRIPTION

Read as the rules stand, before any run:

- **One code for every Catholic.** Every norm in `canon_law.lp` binds
  every person c. 11 does not exclude (`not outside(P)`). There is no
  ascription and no Church *sui iuris*, so an Eastern Catholic falls under
  the Latin Code's latae sententiae penalties.
- **Norms without strata.** The library types a law by kind (`law_kind/2`:
  eternal, natural, divine positive, ecclesiastical, civil). No canon under
  `@norm` is typed: c. 1141 (indissolubility) and c. 1108 (the form) are
  alike to the layer.
- **The form as of 1983.** c. 1108 §1 and c. 1111 are encoded without
  *De concordia inter Codices*: no c. 1108 §3, no c. 1127 §1. The layer
  does not tell a deacon's assistance from a priest's.
- **A bishop alone confirms.** `sacrament.lp` gives the power of confirming
  to a bishop only (`has_power(P,confirmation) :- bishop(P)`). A
  presbyter's confirmation fails for want of a minister in every code,
  though the Latin Code allows it with a faculty and the Eastern Code by
  law.
- **Two libraries disagree on who is bound.** The moral library's
  `binds_for/3` consults c. 11's exemptions (one outside, one under seven);
  the law library's `binds_on/2` does not. A merely ecclesiastical law
  that reaches an unbaptized person, a six-year-old, or an act placed by a
  six-year-old reports each of them `obliged`. Found by a run elsewhere
  and reproduced here. A trial of part of the repair (the agent's
  exemptions for acts), made in a scratch copy before this file, changed
  none of 67 law and canon scenarios. It is disclosed here, not scored.
- ***Ad tuendam fidem* on the Latin side only** (TTC-COMMUNION CN4).

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited.

## THE NORMS

Fixed here. Texts from vatican.va (the Latin Code; the Eastern Code in
Latin; *Sacri canones*; *De concordia inter Codices*) and, where noted,
read at encoding.

- **CIC c. 1**: the canons of the Latin Code regard only the Latin Church.
  **CCEO c. 1**: "Canones huius Codicis omnes et solas Ecclesias
  orientales catholicas respiciunt", unless, with regard to relations with
  the Latin Church, it is expressly established otherwise.
- **The Eastern Code's force**: given 18 October 1990 (*Sacri canones*), in
  force "a die prima mensis Octobris anni MCMXCI".
- **Ascription**: a child under fourteen is ascribed by baptism to a
  Church *sui iuris* (CCEO c. 29 §1, "Filius, qui decimum quartum aetatis
  annum nondum explevit, per baptismum ascribitur Ecclesiae sui iuris");
  to the Latin Church, the child of parents who belong to it, or, if one
  does not, of parents who agree that the child be baptized in it; failing
  agreement, the father's Church (CIC c. 111 §1, as amended in 2016).
- **Who is bound**: c. 11 for the Latin Code; for the Eastern, its own
  canon (c. 1490, read at encoding). Each binds only to merely
  ecclesiastical laws.
- **Chrismation**: "All presbyters of the Eastern Churches" can validly
  administer it to the faithful of any Church *sui iuris*, the Latin
  included (CCEO c. 696 §1); Eastern faithful receive it validly "also from
  presbyters of the Latin Church", according to their faculties (§2). In
  the Latin Code the bishop is the ordinary minister, and a presbyter with
  the faculty by universal law or special grant confers it validly
  (c. 882). Refused at Trent: that the ordinary minister "is not the bishop
  alone, but any simple priest" (sess. VII, on confirmation, can. 3,
  DH 1630).
- **The form of marriage, East**: "Only those marriages are valid which
  are celebrated with a sacred rite, in the presence of the local
  hierarch, local parish priest, or a priest who has been given the
  faculty of blessing the marriage" (CCEO c. 828 §1); "the very
  intervention of a priest who assists and blesses" is the sacred rite
  (§2). With an Eastern non-Catholic, the form for liceity only, "for
  validity, however, the blessing of a priest is required" (c. 834 §2).
- ***De concordia inter Codices*** (31 May 2016): "Solus sacerdos valide
  assistit matrimonio inter partes orientales vel inter partem latinam et
  partem orientalem sive catholicam sive non catholicam" (c. 1108 §3);
  delegation to priests and deacons "firmo tamen eo quod praescribit
  can. 1108 §3" (c. 1111 §1); with a non-Catholic of Eastern rite, the
  form for liceity only, "ad validitatem autem requiritur interventus
  sacerdotis" (c. 1127 §1; until then, the presence of a sacred minister).
  To be promulgated "per editionem in actis diurnis L'Osservatore Romano
  ... et deinde in Actis Apostolicae Sedis"; it names no date of force.
  One canonist dates the edition 16 September 2016 and the force, three
  months on, 16 December 2016, "Ritengo": his own reading.
- **Penalties imposed**: in the Eastern Code a canonical penalty is
  imposed by penal trial (c. 1402 §2, as revised) or, for grave causes, by
  decree (§3). No penalty is incurred by the deed.
- ***Vocare peccatores*** (20 March 2023, published 5 April) revised the
  Eastern penal title, in force 29 June 2023. Heresy and apostasy: "Qui
  aliquam veritatem fide divina et catholica credendam denegat vel eam in
  dubium ponit aut fidem christianam ex toto repudiat et legitime monitus
  non resipiscit, ut haereticus aut apostata excommunicatione maiore
  puniatur" (c. 1436 §1). The canon on episcopal ordination without a
  mandate, c. 1459 §§1–2, unchanged: deposition. Procured abortion,
  c. 1450 §2, and the age below which no one is subject to penalties,
  c. 1413, read at encoding.
- ***Ad tuendam fidem*** (1998) amended CCEO c. 598 §2 and c. 1436 §2.

## THE LAYER

Fixed here.

- **A file of its own**: `canon_cceo.lp`, under the same discipline,
  binary and dated, each canon under `% @norm cceo:N`, each text in its
  years (1991–2023, and from 29 June 2023). The teaching above is shared;
  only the law differs (rule 1).
- **Three strata.** Each canon is typed: *divine* (it states divine law,
  natural or positive: c. 1057, c. 1141, c. 842 §1, c. 845 §1); *supreme*
  (the supreme authority as such: c. 333 §3); *common* (one code's
  merely ecclesiastical law). Divine law binds whom it reaches, and c. 11
  does not confine it; the supreme stratum binds every Catholic; the
  common stratum binds the faithful of its own code. Particular law stays
  frontier.
- **Ascription selects the code**: `ascribed(P,C)`, a fact; disputed, it
  branches. A case's silence ascribes a Catholic to the Latin Church: a
  convention, stated, as c. 11 already reads silence as binding. Every
  case in the base is Latin.
- **Links stated, and links *ex natura rei*.** A canon that reaches the
  other code's faithful by name carries a stated link (CCEO c. 696 §1;
  CIC cc. 1108 §3, 1127 §1). The divine and supreme strata reach both
  codes from the nature of the matter: computed from the typing, not
  listed. Whether a canon states divine law is a reading; where no
  authentic interpretation settles it and canonists differ, it branches
  (rule 2).
- **One layer test**: no common rule of one code fires for a person of the
  other, except by a stated link.
- **Repair: who is bound.** `binds_on/2` consults c. 11 (and the Eastern
  canon) as `binds_for/3` does: for a person, the person's exemptions; for
  an act, its agent's. A person's age with no act is taken at the
  evaluation date from a birth date (TTC-SAECULUM).
- **Repair: the minister of confirmation.** The bishop is the ordinary
  minister (DH 1630). A presbyter confirms validly by law or faculty: in
  the East by law (c. 696 §1), in the Latin Church with the faculty
  (c. 882). The faculty is ecclesiastical; the power, orders.

## METHOD

Write `canon_cceo.lp` with CCEO cc. 1, 29 §1, the Eastern canon on who is
bound, 696, 828, 834 §2, 1402, 1436 §1 (2023) and its earlier text, 1450
§2, 1459 §1, 1413, and *Ad tuendam fidem*'s amendments; type every Latin
canon's stratum; ascription in both codes; *De concordia*'s canons with
its date of force; repair `binds_on/2` and the minister of confirmation.
Cases, all HYPOTHETICAL: an Eastern bishop consecrating without a mandate
in 2026; an Eastern mother procuring an abortion; an Eastern Catholic
denying a defined truth, warned and not; a child of a Latin father and an
Eastern mother, with and without agreement; a Latin infant chrismated by
an Eastern presbyter, an Eastern infant by a Latin presbyter with and
without the faculty; deacons assisting at a Latin–Eastern marriage in
2015, in late 2016 and in 2018; a Latin Catholic marrying an Orthodox
before a deacon in 2015 and 2018; two Eastern Catholics before a deacon;
the unbaptized person and the six-year-old under a merely ecclesiastical
law. Run the whole suite, the runtimes' boots and the coverage index.

## PREDICTIONS

### AS: ascription

- **AS1.** Silence ascribes to the Latin Church: no canon scenario
  changes, the SSPX's included.
- **AS2.** A child's ascription is computed. Latin father, Eastern mother,
  agreeing that the child be baptized in the Latin Church: Latin. Without
  agreement: the father's Church, Latin. Eastern father, Latin mother,
  without agreement: Eastern.
- **AS3.** An Eastern Catholic is not bound by the Latin Code's common
  canons. An Eastern bishop who consecrates without a mandate in 2026
  commits no c. 1387 delict and incurs nothing; CCEO c. 1459 §1 gives
  deposition, to be imposed (`to_be_imposed/3`).

### EP: Eastern penalties

- **EP1.** No penalty in the Eastern layer is incurred. An Eastern
  mother's procured abortion: c. 1450 §2's penalty to be imposed, never
  `presumed_incurred`; the act stays "must not" as a direct killing
  (TTC-PRECEPT), the verdict the library's.
- **EP2.** One act, two codes. A public denial of a truth of divine and
  catholic faith: for a Latin Catholic, c. 1364 §1, incurred; for an
  Eastern Catholic, c. 1436 §1, a major excommunication to be imposed, and
  only after a legitimate warning not heeded (the revised text; the text of
  1990 read at encoding). Without the warning, no Eastern delict.
- **EP3.** Each text in its years. The Eastern Code from 1 October 1991;
  the revised penal canons from 29 June 2023. An Eastern act before 1991
  falls under no encoded code: reported, never computed under the Latin.
- **EP4.** *Ad tuendam fidem* on the Eastern side: TTC-COMMUNION CN4 runs
  for an Eastern Catholic under CCEO c. 1436 §2 (1998), with the same
  dates as c. 1371 n. 1.

### IM: interritual marriage

- **IM1.** c. 1108 §3 from *De concordia*'s force. A deacon delegated to
  assist at the marriage of a Latin and an Eastern Catholic: valid in
  2015, invalid in 2018. Its date of force is a disputed reading of c. 8
  §1 for a law promulgated otherwise than in the *Acta*: three months from
  *L'Osservatore Romano* (16 December 2016), or from the issue of the
  *Acta* (unread: a span). No authentic interpretation settles it, so a
  marriage between the two dates branches (rule 2; TTC-SAECULUM).
- **IM2.** Two Eastern Catholics before a deacon: invalid in every year
  from 1991 (CCEO c. 828). Before a priest who assists and blesses: valid.
- **IM3.** c. 1127 §1. A Latin Catholic and an Orthodox: the form binds
  for liceity only. Before a deacon, valid in 2015 (a sacred minister),
  invalid in 2018 (a priest required). An Eastern Catholic and an
  Orthodox: a priest's blessing for validity in every year (CCEO c. 834
  §2).

### CF: the minister of confirmation

- **CF1.** A Latin infant chrismated by an Eastern presbyter: valid, by
  the stated link of c. 696 §1, and the character imprinted.
- **CF2.** An Eastern infant chrismated by a Latin presbyter: valid with
  the faculty, invalid for want of a minister without it (c. 696 §2).
- **CF3.** A Latin adult confirmed by a Latin presbyter: valid with the
  faculty (c. 882), invalid without it. Typing a presbyter as the ordinary
  minister is refused (DH 1630). SM6b unchanged.

### WB: who is bound

- **WB1.** `binds_on/2` consults c. 11: an unbaptized person, one baptized
  outside the Catholic Church, one under seven at the evaluation date, and
  an act placed under seven are not reported obliged by a merely
  ecclesiastical law. A divine law still reaches each of them.
- **WB2.** The two libraries agree: for every person and act a case
  records, a merely ecclesiastical law reaches it under `binds_on/2`
  exactly where it can bind under `binds_for/3`.
- **WB3.** No existing check changes.

### LK: links and strata

- **LK1.** The layer test holds: no common rule of either code fires for
  the other's faithful except by a stated link; the divine and supreme
  strata fire for both.
- **LK2.** The typing of the Latin canons: c. 1057, c. 1141, c. 842 §1 and
  c. 845 §1 divine; c. 333 §3 supreme; the delicts, the form, the
  faculties and the general norms common. No typing branches in the base.
- **LK3.** An Eastern Catholic's marriage is indissoluble and needs
  consent, by c. 1141 and c. 1057 as divine law, though no Latin common
  canon binds the parties.

### M: meta

- **M1.** No earlier check changes. The canon scenarios keep their
  outputs: every person in them is ascribed to the Latin Church by
  silence. The TTC-SCHOOLS tables do not change.
- **M2.** Every new rule has a test that fails without it; CL1 and PR4
  stay clean, the norm graph now spanning two files.
- **M3.** In the coverage index, "Liturgical diversity and the unity of
  the mystery" (CCC 1200–1209) leaves the cases for the rules (the Churches
  *sui iuris* and their rites, CCC 1203); the rule files cite CCC 1203,
  1312, 1313 and 1623.

## CAVEATS

The Eastern canon on who is bound (c. 1490), the penal age (c. 1413) and
procured abortion (c. 1450 §2, and c. 728 §2's reserved sin) are not read
here. They are read in the Latin text on vatican.va at encoding. Where a
text differs from what this file assumes, the scoring says so.

*De concordia*'s date of force is entered as a disputed reading. A second
canonist, or the Council for Legislative Texts, may settle it. The issue
of the *Acta* that carries it is unread.

Silence ascribes to the Latin Church only because every case in the base
is Latin. A case of the Eastern layer records ascription.

The strata typing is the encoder's reading for four canons; c. 1103
(force and fear) is left common, though some hold it natural law. Were
that held in a case, it would branch.

The Eastern particular law of each Church *sui iuris*, change of
ascription (CIC c. 112; CCEO cc. 32–38), interritual jurisdiction of
pastors, and Eastern liturgical law are frontier.

## STANDARDS

- CIC 1983 cc. 1, 8 §1, 11, 111 §1 (2016), 333 §3, 842 §1, 845 §1, 882,
  1057, 1108 §§1, 3 (2016), 1111 §1 (2016), 1127 §1 (1983, 2016), 1141,
  1364 §1, 1387
- CCEO cc. 1, 29 §1, 696 §§1–2, 828 §§1–2, 834 §2, 835, 1402, 1436 §§1–2,
  1450 §2, 1459 §1, 1413, 1490
  (https://www.vatican.va/content/john-paul-ii/lt/apost_constitutions/documents/hf_jp-ii_apc_19901018_codex-can-eccl-orient-1.html)
- John Paul II, *Sacri canones* (18 October 1990)
  (https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_sacri-canones.html)
- Francis, *De concordia inter Codices* (31 May 2016)
  (https://www.vatican.va/content/francesco/la/motu_proprio/documents/papa-francesco-motu-proprio_20160531_de-concordia-inter-codices.html)
- Francis, *Vocare peccatores* (20 March 2023)
- John Paul II, *Ad tuendam fidem* (1998)
- Trent, sess. VII, on confirmation, can. 3 (DH 1630)
- P. Gefaell, on *De concordia inter Codices*, *Ius Ecclesiae* (2016)
- CCC 1203, 1312–1313, 1623

## SEE ALSO

[ttc-saeculum(7)](saeculum-preregistration.md), [ttc-penal(7)](penal-preregistration.md),
[ttc-communion(7)](communion-preregistration.md), [ttc-law(7)](law-preregistration.md),
[ttc-canon(5)](../canon-law-layer.md), [ttc-roadmap(7)](../roadmap.md)

## SCORING

Appended after the runs. Predictions committed in 9c9cdbe, stamped in
b887297. Encoded in `canon_cceo.lp` (new: CCEO cc. 696, 828, 834 §2, 1402,
1436 §§1–2, 1450 §2, 1459 §1), `canon_law.lp` (cc. 1 and 111 §1 with
ascription and c. 1's gate on every Latin delict; c. 1108 §3, c. 1127 §1,
c. 882; c. 8 §1 for a law promulgated elsewhere; ages at the evaluation
date; five canons tagged by stratum), `law.lp` (who is bound),
`sacrament.lp` (the minister of confirmation), `norms.py` (`@stratum`),
`canon_cases.lp`, `engine.py`, `schools.py`. Scenarios AS, EP, IM, CF, WB,
LK (13; 491 in all).

| | Result |
| --- | --- |
| AS1 | Held (AS1). No earlier output changed. |
| AS2 | Held (AS2). |
| AS3 | Held (AS3). The Latin bishop who does the same incurs c. 1387. |
| EP1 | Held (EP1). |
| EP2 | Held (EP2). The Latin denial is c. 1364 §1, incurred, on the claim of pertinacity; the Eastern one c. 1436 §1, to be imposed, on the warning not heeded, with no claim of pertinacity read: the Eastern canon makes the obstinacy outward. Unwarned, no Eastern delict. |
| EP3 | Held (EP3). |
| EP4 | Held (EP4). |
| IM1 | False in its first clause. The deacon's marriage of a Latin and an Eastern Catholic is invalid in 2015 too: the Eastern party's own law asks a priest's blessing from 1991 (CCEO c. 828), so c. 1108 §3 changed the Latin text, not the outcome. Invalid in 2018, as predicted. The disputed reading of c. 8 §1 branches for the marriage of 20 December 2016, as predicted, with the same outcome on every branch. Scored on the base's reading of c. 828; the literature disagreed on it before 2016 (below). |
| IM2 | Held (IM2). |
| IM3 | Held (IM3), and before ministers of the other Church: an Orthodox priest not delegated, in 2018, and an Orthodox deacon in 2015, both valid (the form for liceity only). |
| CF1 | Held (CF1). |
| CF2 | Held (CF1). |
| CF3 | Held (CF1). SM6b unchanged. |
| WB1 | Held (WB1). |
| WB2 | Held: a test compares the two libraries act by act. |
| WB3 | Held. |
| LK1 | False in part. The test holds for what it reads: every Latin delict carries c. 1's gate, and every Eastern rule that binds a person reads Eastern ascription. But the Latin rules on the form's jurisdiction (cc. 1108 §1, 1111), on who is bound to the form (c. 1117) and on the faculty to absolve (c. 966) still fire for Eastern faithful, standing in for Eastern canons not encoded (cc. 829–830, 834 §1, 722). |
| LK2 | Held: a test. |
| LK3 | Held (LK3). |
| M1 | Held. No earlier output changed (every scenario's atoms compared before and after); the TTC-SCHOOLS tables did not change. |
| M2 | Held after closing gaps. Each new statement was deleted in turn (26 in `canon_cceo.lp`, 61 in `canon_law.lp`, 52 in `canon_cases.lp`, 4 in `sacrament.lp`, 5 in `law.lp`) against the scenarios that read them, and each survivor against the whole suite. Closed on the way: the Eastern heresy canon's doubt and apostasy; c. 1436 §2's penalty; each kind of Eastern act before 1991; an act of the unbaptized under a merely ecclesiastical law; marriages between and before the two readings' dates of force (a unit test); a child ascribed to the mother's Church by agreement, both parents Eastern, the child's ascription with effect; which code asks the priest, the Eastern alone before 2016 and both after; deacons as clerics; an Orthodox priest and deacon as the sacred minister; common error with the priest required, a gap older than this step (no marriage had tested c. 144's supply). None survives. CL1 and PR4 clean. |
| M3 | Held: "Liturgical diversity and the unity of the mystery" moves to rules (45 units under rules, 6 under cases, 36 frontier); the rule files cite CCC 1203, 1312, 1313 and 1623 (34 paragraphs). |

### Caveats, read

- **Not read in Latin here**: CCEO c. 1490 (who is bound, the base reusing
  c. 11's rule), c. 1413 (the penal age: not encoded), c. 1450 §2 (encoded
  as "excommunication", imposed, its grade unread), c. 1459 §1 (deposition,
  from secondary sources), c. 728 §2. c. 1436 §§1–2 read in *Ad tuendam
  fidem*'s English (1998) and §1 in the Latin of 2023. cc. 696, 828 and
  834 §2 read in English translation.
- ***De concordia*'s date of force**: entered as a disputed reading; its
  edition of *L'Osservatore Romano* dated 16 September 2016 on one
  canonist's report.
- **A disagreement in the literature over c. 828.** Before 2016 canonists
  differed on whether c. 828, which speaks of the priest who assists and
  blesses and has no "solus sacerdos valide" of its own, invalidated a
  marriage of an Eastern Catholic blessed by a deacon, the common case
  being a Latin and an Eastern Catholic before a Latin deacon. A doubt of
  law was argued (so c. 1496, as c. 14, would leave the invalidating law
  unurged) and itself disputed. Not encoded: the base reads c. 828 as
  binding the Eastern party, and IM1 is scored on that reading. Encoded as
  a disputed reading, it would branch for those marriages before
  *De concordia*'s force (rule 2).
- **The texts in their years.** iuscangreg's table of the Eastern Code's
  changes records none to cc. 828–834 or 696 since 1990; c. 1450 is not
  among the canons *Vocare peccatores* renewed, so its 1990 text stands;
  c. 728 §2 (the reserved absolution of abortion) was abrogated by
  *Misericordia et misera* (2016); *Mutua concordia* (29 August 2026)
  changed cc. 106 and 126, outside this step.

### Not predicted

- **The deacon before 2016** (IM1, above).
- **The SSPX part records no baptisms**, so its bishops are neither Latin
  nor Eastern faithful; the gate reads them, by silence, as not Eastern.
  AS1 is checked where the baptisms are recorded.
- **c. 8 §1's disputed reading is its own choice**, not c. 17's: through
  c. 17 the norm graph drew a cycle between cc. 7 and 17. And the Eastern
  non-Catholic is typed with ascription, not with c. 1127, for the same
  reason.
- **Which code asks the priest** is now shown per marriage
  (`info(priest_required/2)`): for the Latin and Eastern Catholics of
  2015, the Eastern Code alone; from 2016, both.
- **Deacons are clerics** (`cleric/1`), which c. 1398 §1 n. 1 reads; no case
  changed.
