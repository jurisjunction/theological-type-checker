# TTC-COMMUNION(7)

## NAME

**ttc-communion** — faith and communion: the notes of teaching, the
denials of faith, the bonds of communion; predictions, committed before
encoding

## DESCRIPTION

Read as the rules stand, before any run:

- **The graph grades values but names no note.** The contrary of a value
  is excluded, a counterfactual shadow or a live shadow. The checker never
  says that a value is *de fide*, definitive or authentic, nor what a
  profession of its contrary is.
- **c. 751 has one offence of three.** Schism is encoded, through the
  consecrations; heresy and apostasy are not.
- **Every canon binds everyone.** Nothing says who is subject to merely
  ecclesiastical law (c. 11) or who is in full communion (c. 205). The
  canonical form binds every marriage (TTC-CHRIST, "Not predicted").
- **Dissent is typed by hand.** The SSPX case types its refusal of
  *Dignitatis humanae* as dissent of c. 752 with a tier entered for it.
- **Tiers rest on the encoder's word.** A source's tier is entered by
  hand; only papal acts are checked against their form (B14). LG 25 sits
  at tier 1, though Vatican II defined nothing. A claim of the ordinary
  universal magisterium raises the tier of the document that makes it:
  where the claim holds, EV 57 counts at tier 2.

Notes read tiers, so the step begins with rule 14 (CLAUDE.md, added with
this file's amendment): tiers are computed, never taken on anyone's word.
Then write a library, `faith.lp`: the notes of teaching (c. 750 §§1–2,
c. 752; the CDF's commentary of 1998), professions and their denials, and
heresy, apostasy and schism as Thomas distinguishes them (II-II qq. 5, 11,
12, 39).
Add to the canon layer cc. 11, 96 and 205; heresy and apostasy in cc. 751
and 1364; c. 1371 n. 1 with its 1998 amendment and its successor of 2021,
c. 1365; and c. 1117 with its amendment of 2009. Run them on the graph's
own questions: the Immaculate Conception, the Filioque, Anglican orders,
the killing of the innocent.

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited. (First committed
in 4942448 and amended before the stamp: rule 14, the section TIER CLAIMS,
TC1–TC4, NT3, NT4, M1.)

## TIER CLAIMS

Fixed here (rule 14).

- **A tier is a finding about form and conditions.** Warrants: a papal
  definition with the conditions of *Pastor aeternus* (DH 3074): as pastor
  of all, by apostolic authority, defining a doctrine of faith or morals
  to be held by the whole Church; a council's canon or definition that the
  council itself declares as such ("the sacred Council defines matters of
  faith or morals as binding on the Church only when the Council itself
  openly declares so", notification of 16 November 1964); a creed
  received; the ordinary universal magisterium with the conditions of
  LG 25: the bishops, dispersed but in communion with one another and with
  Peter's successor, teaching authentically on faith or morals, agree on
  one position as to be held definitively.
- **Every statement about a tier is a claim**, its own or another's, by
  any author: entered with its claimant and grade, computed both ways.
- **The consensus is its own source.** A claim of the ordinary universal
  magisterium enters as a source of its own, the bishops' consensus, whose
  existence is the claim. The document that reports it keeps its own
  tier. Where the claimant states no grade (revealed, or to be held
  definitively), the grade is computed both ways.
- **Lower of higher.** A claim made by a lower tier about a higher is
  flagged; treated as fixing, refused (B10's self-elevation, extended from
  tier 2's force to every tier).
- **c. 749 §3.** "No doctrine is understood as defined infallibly unless
  this is manifestly evident." Where a claim's conditions are not shown by
  evidence independent of its claimant, its branch is never preferred by
  weight.

## THE LIBRARY

Fixed here.

### Notes (`faith.lp`)

- **The note is read off the graph.** In a branch, a value supported by a
  tier-1 teaching source in force is *de fide*, "to be believed by divine
  and catholic faith" (c. 750 §1). One supported by a source that can
  cleave at tier 2 is *definitive* (c. 750 §2); at tier 3, *authentic*
  (c. 752). A value held where teaching is in tension, or under a
  protection, has no note. Doctors and theologians weigh; they give no
  note.
- **Proposed, not only contained.** c. 750 §1 asks for both: contained in
  the word of God, and proposed as revealed (CCC 182). A reading of
  Scripture (tier 0) excludes its contrary within the reading, and gives
  no note by itself.
- **The censure of a contrary proposition** follows the note it
  contradicts (CDF, *Doctrinal Commentary on the Concluding Formula of the
  Professio fidei*, 1998, nn. 5, 6, 10): heretical; contrary to definitive
  doctrine (whoever denies it "would no longer be in full communion");
  erroneous, or, against teaching of the prudential order, rash ("tuto
  doceri non potest"). The prudential order is TTC-PRECEPT's directive
  (CCC 2423). The censure is said of the proposition; a person "falls
  under" it only with pertinacity, which is a claim.

### Faith and its denials (`faith.lp`)

- **A profession is outward**: an act asserting a value on a question, or
  doubting it. Omission is not denial.
- **Pertinacity is a claim** (II-II q. 11 a. 2 ad 3, with Augustine). One
  who holds a false opinion "without obstinate fervor", ready to be
  corrected, is not a heretic; one who holds it obstinately "after they
  had been defined by the authority of the universal Church" is. Computed
  both ways where disputed, never derived. c. 751's "obstinate" reads the
  same claim.
- **One article denied, none held by faith** (q. 5 a. 3), on the claims.
- **Three offences, three objects.** Heresy is against an article,
  apostasy against the faith whole (q. 12 a. 1), schism against submission
  and communion (q. 39 a. 1 ad 3). None is composed from another.

### Communion of persons (canon layer)

- **c. 96**: baptism incorporates into the Church of Christ. **c. 205**:
  full communion with the Catholic Church by the bonds of the profession
  of faith, the sacraments and governance. **c. 11**: merely
  ecclesiastical law binds those baptized in or received into the
  Catholic Church, with the use of reason, from seven. Divine and natural
  law bind all.
- **The bonds and c. 751.** Heresy and apostasy break the bond of
  profession; schism, that of governance. No other delict breaks a bond.
- **Teaching and law on communion are three outputs.** c. 205's full
  communion is juridical, from outward bonds. LG 14's full incorporation
  adds "possessing the Spirit of Christ", a claim (`grace.lp`). The
  commentary's "no longer in full communion" (n. 6) is teaching, at
  tier 3.
- **c. 751 reads c. 750.** "A truth to be believed by divine and catholic
  faith" is c. 750 §1's object, which the graph already joins to teaching
  by reference (`binds/3`, `owed/2`; B15). No new link between teaching
  and law.

## METHOD

Apply rule 14 first: write the warrants, re-enter the recorded claims as
claims, run the audit. Write `faith.lp`. Add the canons under `@norm`,
from vatican.va or iuscangreg. Enter c. 750 §§1–2 and c. 752 in a part of
their own (they sit now inside the part `tier2`). Write cases, all
HYPOTHETICAL, of professions on the graph's questions: the Immaculate
Conception, denied in 1850 and in 1860; the Filioque, denied by an
Orthodox theologian and by a Catholic, and the Creed professed without it;
Anglican orders professed valid by a Catholic, warned and not retracting,
in 1997, 2000 and 2022; a doubt; an apostasy; a mixed marriage, a marriage
of two baptized non-Catholics, and one after a formal act of defection,
before and after 2009. Run the whole suite, the runtimes' boots and the
coverage index.

## PREDICTIONS

### TC: tier claims

- **TC1. The audit.** A test fails on any source at tier 1 or 2 without a
  warrant. On the base: LG 25 has none (the notification of 1964), and is
  re-typed at tier 3, a conciliar constitution. B15's expectation changes:
  LG 25 is owed religious submission (c. 752), not divine and catholic
  faith. So re-typed, LG 25 is itself a tier-3 source speaking of tier 2's
  force, and is flagged (TC4). The chapters of Trent at tier 1 (sess. VI
  ch. 7; sess. XXI ch. 1) are warranted by their sessions' own
  declarations of what they define (sess. VI, proem, DH 1520; sess. XXI,
  proem). The Apostles' Creed and the *Quicumque* are creeds received;
  their reception is a claim without a date, recorded as a claim and not
  computed both ways in this step (the roadmap's repair dates reception).
  Every other source at tier 1 passes by its form.
- **TC2. The consensus as its own source.** The five recorded claims of
  the ordinary universal magisterium (*Apostolicae curae*; Innocent III's
  profession of 1208; EV 57; EV 62; FC 84) become sources of their own,
  each naming its claimant; every reporting document keeps its tier, and
  EV is at tier 3 in every branch. For the three with one claimed grade,
  branch statuses do not change; a check that lists the sources whose
  relaxation would reintegrate a shadow, exactly, gains the consensus
  (DP7), and its expectation changes.
- **TC3. c. 749 §3.** None of the five has LG 25's conditions shown by
  evidence independent of its claimant: EV 62 reports a consultation whose
  replies are not public. No branch resting on any of them is preferred by
  weight. The preference tests (DP4, EC5, EC6, EC9, B17) do not change.
- **TC4. Lower of higher.** The commentary's classifications (n. 11), and
  its and LG 25's statements on the force of tier 2, are flagged as tier-3
  sources speaking of higher tiers. A candidate that treats n. 11 as
  fixing EV 57's grade is refused.

### NT: notes

- **NT1. The note is the shadow, read off.** In every scenario of the
  suite, for every doctrinal question, the note of a value in a main
  branch and the status of the question's other values agree. De fide:
  every other value is excluded. Definitive: each is a shadow,
  counterfactual on `t2_truth` and live without it. Authentic: each is a
  live shadow. No note: another value is main (an open question, a
  tension as in DP3 and EC4, or a protection).
- **NT2. Scripture, proposed.** With the defining canons removed (CS2c),
  the readings of Jn 3:5 and Jn 20:23 give their values no note; with
  Trent (CS2) the values are de fide.
- **NT3. Dated notes.** The Immaculate Conception has no note in 1850,
  *Sollicitudo* (1661) being blocked by Trent's protection; with the
  protection removed (the ablation), authentic; from 1854, de fide. The
  invalidity of Anglican orders is definitive where the claim of the
  ordinary universal magisterium holds (claimed by the commentary, n. 11,
  a tier-3 witness) and authentic where it does not.
- **NT4. *Evangelium vitae* stays at tier 3.** Nn. 57 and 62 report a
  teaching of the ordinary universal magisterium; each teaching enters as
  a claimed source of its own (TC2). EV states no grade, so each grade is
  computed. The commentary's listing of EV 57 in the first paragraph
  (n. 11) is a tier-3 witness, flagged, fixing nothing (TC4). Where a
  claim holds at grade 1, the direct killing of the innocent is de fide
  and its contrary excluded; at grade 2, definitive, the contrary a
  counterfactual shadow on `t2_truth`; where neither holds, authentic. No
  check of TTC-PRECEPT changes; its scenarios gain the grade as a branch.
- **NT5. Erroneous or rash.** A profession contrary to authentic teaching
  is erroneous; contrary to teaching typed a directive, rash (on a case
  written for it).

### FD: faith and its denials

- **FD1. Censures.** Professions on the graph's questions take the censure
  of the note they contradict; one of a value that is main takes none.
  The Creed professed without the Filioque, affirming the monarchy
  (Florence, DH 1331), takes none; "from the Father alone" is heretical
  (Lyons II, DH 850; Florence, DH 1300–1302). Anglican orders professed
  valid: contrary to definitive doctrine where the claim holds, erroneous
  where it does not.
- **FD2. Before the definition.** A denial of the Immaculate Conception in
  1850 takes no censure; in 1860 it is heretical (DH 2803–2804). Thomas's
  own condition (q. 11 a. 2 ad 3).
- **FD3. Formal heresy on the claims.** Where pertinacity is claimed:
  formal heresy, and faith held in no article (q. 5 a. 3). Where it is
  disputed, both branches; never derived. The test of rule 3 is extended
  to these compositions and passes.
- **FD4. Doubt** is typed with denial against de fide teaching only
  (c. 751; n. 5). Against definitive or authentic teaching a doubt takes
  no censure and reaches no canon: n. 6 says "denies", c. 1365 "rejects".
- **FD5. Three offences.** No number of heretical professions composes
  apostasy; a candidate that composes it so is refused. A schismatic act
  carries no censure of heresy.

### CN: the canons

- **CN1. c. 11.** A person a case records as outside (baptized elsewhere
  and not received; unbaptized; under seven; habitually without the use
  of reason, c. 99) is not bound by merely ecclesiastical law; divine and
  natural law still bind. A case's silence binds (CAVEATS).
- **CN2. Heresy and apostasy, c. 1364.** Heresy needs a profession
  contrary to a value owed divine and catholic faith (c. 750 §1), after
  baptism, by one who is bound (c. 11), with obstinacy claimed. An
  Orthodox theologian's "from the Father alone" is heretical as a
  proposition: no delict, no formal heresy. A Catholic's is the delict
  where obstinacy is claimed. Apostasy needs no claim beyond c. 1321 §4's
  presumption.
- **CN3. Two computations, one answer.** The censure "heretical"
  (`faith.lp`, from the note) and c. 751's matter (the canon layer, from
  c. 750 §1) are computed apart and agree on every profession dated under
  the Code of 1983.
- **CN4. c. 1371 n. 1, 1983 and 1998; c. 1365, 2021.** Anglican orders
  professed valid by a Catholic, warned, not retracting. In 1997 no canon
  reaches it where *Apostolicae curae*'s claim holds, and c. 1371 n. 1
  (c. 752) does where it does not: the gap *Ad tuendam fidem* names
  (nn. 3–4). In 2000 it is reached either way; in 2022, by c. 1365. The
  penalty is to be imposed (ferendae sententiae), never incurred.
- **CN5. c. 1117.** Two baptized non-Catholics marry validly without the
  form, and the bond is ratified. A Catholic who marries a baptized
  non-Catholic without the form or a dispensation marries invalidly. A
  party who had left by a formal act was not bound before *Omnium in
  mentem* (2009), and is bound after it.

### FC: communion

- **FC1. c. 96 and c. 205.** The Orthodox theologian is incorporated and
  not in full communion; a Catholic with no offence is in full communion.
  The confessor excommunicated for violating the seal (SM7) remains in
  full communion. The consecrators of 1988 do not, on the reading of
  c. 751 by which the act suffices.
- **FC2. The commentary and the canon diverge.** A Catholic who denies a
  definitive doctrine (Anglican orders, where the claim holds) is "no
  longer in full communion" by the commentary (n. 6), and in full
  communion by c. 205. Two outputs; neither answers the other (rule 1).
- **FC3. LG 14.** Full incorporation is c. 205's full communion with a
  claim of grace; without the claim, "in body, not in heart", on the
  claims.

### M: meta

- **M1.** No earlier result changes, except B15 and DP7 (TC1, TC2) and
  the branches NT4 adds. The marriage cases of TTC-CHRIST keep their form
  (silence binds). SX8's typing of dissent stands beside the library's.
  The TTC-SCHOOLS tables do not change.
- **M2.** Every new rule has a test that fails without it; CL1 and PR4
  stay clean.
- **M3.** In the coverage index, "I believe" (CCC 144–165) and "We
  believe" (166–184) leave the frontier; "One, holy, catholic and
  apostolic" (811–870) and the first commandment (2084–2141; CCC 2089)
  move from cases to rules.

## CAVEATS

The censures are of propositions, as the theological notes always were.
They say nothing of a person. Those born into separated communities
"cannot be accused of the sin involved in the separation" (UR 3); the
checker composes formal heresy only on a claim, and no case makes one of
them.

c. 11 read negatively, so that silence binds, is the encoder's reading:
every earlier case keeps its parties subject. c. 205 says what full
communion is; that c. 751's offences break its bonds, and nothing else
does, is the encoder's reading of the two canons together. c. 1127 §1
(marriage with an Eastern non-Catholic) is not encoded; the mixed case is
Western.

The prudential order is recognized only where a source is typed a
directive. The Holy Office's craniotomy responses use n. 10's own formula
("tuto doceri non posse") and are not so typed (TTC-PRECEPT DI4).

Rule 14 makes every claim of the ordinary universal magisterium in the
base unshown: the encoding holds no evidence of LG 25's conditions apart
from the claimants' word. The commentary's own examples are uneven: it
lists EV 57 in the first paragraph and EV 65 in the second, though EV 65
and EV 62 rest the doctrine on the same sources in the same words.

Implicit faith, and the salvation of those who do not know the Gospel
(q. 2 aa. 5–8; LG 16), belong to the last things.

Neither *Ad tuendam fidem* nor *Omnium in mentem* names a date of entry
into force; c. 8 §1 applies, and the cases are dated clear of it.

## STANDARDS

- Vatican I, *Dei Filius* ch. 3 (DH 3011); *Pastor aeternus* ch. 4
  (DH 3074); Vatican II, notification of the Theological Commission,
  16 November 1964; LG 25; CIC 1983 c. 749 §3
- Trent, sess. VI, proem (DH 1520); sess. XXI, proem
- Aquinas, ST II-II q. 1; q. 5 a. 3; q. 11 a. 2 ad 3; q. 12 a. 1; q. 39 a. 1
- Sixtus IV, *Grave nimis* (1483); Trent, sess. V (1546); Pius IX,
  *Ineffabilis Deus* (1854), DH 2803–2804
- Lyons II, DH 850; Florence, DH 1300–1302, 1331
- Leo XIII, *Apostolicae curae* (1896)
- LG 14; UR 3
- John Paul II, *Evangelium vitae* (1995) 57; *Ad tuendam fidem* (1998)
- CDF, *Doctrinal Commentary on the Concluding Formula of the Professio
  fidei* (1998), nn. 5–11
- Benedict XVI, *Omnium in mentem* (2009)
- CIC 1983 cc. 11, 96, 99, 205, 750–752, 1117, 1364, 1371 n. 1 (1983,
  1998); CIC 2021 cc. 1364, 1365
- CCC 182, 815, 817–819, 838, 2089

## SEE ALSO

[ttc-precept(7)](precept-preregistration.md),
[ttc-christ(7)](christ-preregistration.md),
[ttc-canon(5)](../canon-law-layer.md), [ttc-roadmap(7)](../roadmap.md)
