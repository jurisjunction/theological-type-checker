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

Write a library, `faith.lp`: the notes of teaching (c. 750 §§1–2, c. 752;
the CDF's commentary of 1998), professions and their denials, and heresy,
apostasy and schism as Thomas distinguishes them (II-II qq. 5, 11, 12, 39).
Add to the canon layer cc. 11, 96 and 205; heresy and apostasy in cc. 751
and 1364; c. 1371 n. 1 with its 1998 amendment and its successor of 2021,
c. 1365; and c. 1117 with its amendment of 2009. Run them on the graph's
own questions: the Immaculate Conception, the Filioque, Anglican orders,
the killing of the innocent.

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited.

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

Write `faith.lp`. Add the canons under `@norm`, from vatican.va or
iuscangreg. Enter c. 750 §§1–2 and c. 752 in a part of their own (they sit
now inside the part `tier2`). Write cases, all HYPOTHETICAL, of professions
on the graph's questions: the Immaculate Conception, denied in 1850 and in
1860; the Filioque, denied by an Orthodox theologian and by a Catholic,
and the Creed professed without it; Anglican orders professed valid by a
Catholic, warned and not retracting, in 1997, 2000 and 2022; a doubt; an
apostasy; a mixed marriage, a marriage of two baptized non-Catholics, and
one after a formal act of defection, before and after 2009. Run the whole
suite, the runtimes' boots and the coverage index.

## PREDICTIONS

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
  invalidity of Anglican orders is definitive where *Apostolicae curae*'s
  claim holds and authentic where it does not, as the commentary lists it
  (n. 11).
- **NT4. *Evangelium vitae* 57, re-typed.** The commentary lists EV 57
  among the truths of the first paragraph (n. 11); TTC-PRECEPT typed its
  claim at tier 2. Re-typed at tier 1: where the claim holds, the direct
  killing of the innocent is de fide and its contrary is excluded, no
  longer a counterfactual shadow; where it does not, authentic. The
  precept scenarios that load these sources lose those branches; of their
  checks only DI3's changes, and no verdict.
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

- **M1.** No earlier result changes, except NT4's. The marriage cases of
  TTC-CHRIST keep their form (silence binds). SX8's typing of dissent
  stands beside the library's. The TTC-SCHOOLS tables do not change.
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

Implicit faith, and the salvation of those who do not know the Gospel
(q. 2 aa. 5–8; LG 16), belong to the last things.

Neither *Ad tuendam fidem* nor *Omnium in mentem* names a date of entry
into force; c. 8 §1 applies, and the cases are dated clear of it.

## STANDARDS

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
