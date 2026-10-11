# TTC-CREED(7)

## NAME

**ttc-creed** — the deposit as the creeds profess it, with Scripture
above them: predictions, committed before encoding

## DESCRIPTION

The kernel holds the deposit only where the *Grammar of the Icon* needed
it: creation, the Trinity's processions, the attributes, the image. Read
as the rules stand, before any run:

- **The incarnate is a sort, not a person named.** `incarnate(X)` makes X
  a person, of human nature, and an image (`kernel_core.lp`). It does not
  make X divine, nor consubstantial with the Father, and nothing says which
  divine person X is. The Trinity's model names the Son `son`; the
  theory's models name the incarnate `christ`. Chalcedon's "one and the
  same Son" (DH 301–302) is not encoded.
- **Origin and change are typed by person only.** The grain (A3) gives a
  divine person one principle of origin; immutability forbids change in
  God. Neither knows that the Son is born in time of Mary, or suffers, in
  his humanity.
- **There is no Scripture, no creed as such, no Mary, no economy.** The
  authority layer's highest tier is 1; the base cites councils but no
  creed and no text of Scripture.

Write the deposit as the Church professes it: the word of God as tier 0,
the creeds as tier 1, the Incarnation, Mary, and the economy of salvation
as the creeds tell it. This step comes first; the libraries follow
([ttc-moral(7)](moral-preregistration.md),
[ttc-christ(7)](christ-preregistration.md)).

This file was committed and stamped before any of it was encoded,
together with TTC-MORAL and TTC-CHRIST. SCORING will be appended below;
nothing above it will be edited.

## THE DEPOSIT

Fixed here.

### Tier 0: the word of God

- **One deposit.** "Sacred Tradition and Sacred Scripture form one sacred
  deposit of the word of God" (DV 10). The teaching office "is not above
  the word of God, but serves it"; the task of authentically interpreting
  it belongs to that office alone (DV 10). Tier 0 is therefore above
  tier 1 in authority and below it in determinacy.
- **Never raw.** A text of Scripture is not a proposition until it is
  read. It enters with readings, each a value on a question, and branches
  on them as an ambiguous source does.
- **Inerrancy** (DV 11): no branch holds a value contrary to the reading
  it takes.
- **The analogy of faith** (DV 12; CCC 114): a reading contrary to tier 1
  is excluded.
- **Defined senses.** Where the Church has defined the sense of a text,
  the reading is fixed: Jn 3:5 (Trent, sess. VII, *On baptism*, can. 2,
  DH 1615); Jn 20:22–23 (sess. XIV, *On penance*, can. 3, DH 1703);
  Rom 5:12 (sess. V, DH 1514).
- **The Fathers.** No one may interpret Scripture against the unanimous
  consent of the Fathers (Trent, sess. IV, DH 1507; Vatican I, DH 3007).
  That a consent is unanimous is a claim, computed both ways unless a
  tier-1 act fixes it, as the claim that a teaching is of the ordinary and
  universal magisterium is.

### Tier 1: the creeds

- The Apostles' Creed (DH 30); the Nicene-Constantinopolitan Creed
  (DH 150); the *Quicumque* (DH 75–76), tier 1 by the Church's reception;
  and the councils' definitions: Nicaea (DH 125–126), Ephesus
  (DH 250–251), Chalcedon (DH 301–302), Constantinople II (DH 421–438),
  Constantinople III (DH 556–557), Lateran IV (DH 800–802).
- Paul VI's *Credo of the People of God* (1968) is tier 3: by its own
  words it is "without being strictly speaking a dogmatic definition"
  (n. 3).

### The Incarnation

- One person, the eternal Son, in two natures, without confusion,
  change, division or separation; consubstantial with the Father in his
  divinity and with us in his humanity; of a rational soul and a body;
  like us in all things but sin (Chalcedon, DH 301–302).
- The only-begotten Son was made incarnate by the whole Trinity in common
  (Lateran IV, DH 801): the incarnate is the Son. In God there is a
  Trinity, not a quaternity (DH 804).
- Two births of God the Word: one from the Father before the ages, the
  other in the last days of the holy and glorious Mother of God and
  ever-virgin Mary (Constantinople II, can. 2, DH 422).
- He who was crucified in the flesh is true God and one of the Holy
  Trinity (can. 10, DH 432). God is "incommutabilis" (DH 800).
- Two natural wills and two natural operations, the human will following
  the divine and subject to it (Constantinople III, DH 556–557). The
  council's words only; Maximus's own account of the will is not encoded.
- **Typed by nature.** What is said of the person is said by a nature:
  his birth of Mary, his growth (Lk 2:52), his passion and his human
  operation are his in the human nature; his eternal birth, immutability
  and divine operation in the divine.

### Mary

- Mother of God (Ephesus, DH 251); ever-virgin (DH 422; the Lateran synod
  of 649, can. 3, DH 503; Paul IV, *Cum quorundam*, 1555, DH 1880);
  preserved from every stain of original sin from the first instant of
  her conception, "in view of the merits of Christ Jesus" (Pius IX,
  *Ineffabilis Deus*, 1854, DH 2803); taken up body and soul into heavenly
  glory, "having completed the course of her earthly life" (Pius XII,
  *Munificentissimus Deus*, 1950, DH 3903). A creature throughout.

### The economy

- The second article of the creeds as one order of events: conceived,
  born, suffered under Pontius Pilate, crucified, died, buried, descended,
  rose, ascended, seated, coming to judge. Before it, creation (DH 800,
  3002) and the fall; after it, the sending of the Spirit, the Church,
  the resurrection of the body and life everlasting. One event is dated:
  the passion, "under Pontius Pilate". The rest are ordered, not dated.
- Original sin is transmitted to all by propagation, not by imitation
  (Trent, sess. V, can. 3, DH 1513). The decree does not include Mary
  (DH 1516).

## METHOD

Add tier 0 to the authority layer: a text's readings, inerrancy and the
analogy of faith as constraints, defined senses as fixed readings, the
Fathers' consent as a claim computed both ways. Add the creeds and the
definitions as tier-1 sources. Write the Incarnation into the kernel as
deposit, with origin, change and operation typed by nature. Put the
creed's persons and events (the Son incarnate, Mary, the economy) in a
part of their own. New cases: the brothers of the Lord; the history of
the Immaculate Conception; candidates for every refusal below. Run the
whole suite and the runtimes' boots.

## PREDICTIONS

### SC: Scripture

- **SC1.** Adding tier 0 changes no existing branch: no source in the base
  is a text of Scripture, and the new rules only constrain readings.
- **SC2. Defined senses.** A reading of Jn 3:5 that makes the water a
  metaphor (DH 1615), or of Jn 20:22–23 that denies the power to forgive
  sins in the sacrament (DH 1703), is excluded with no branch.
- **SC3. The brothers of the Lord** (Mk 6:3; with Mt 1:25). Three
  readings: Mary's later sons (Helvidius), Joseph's sons by an earlier
  marriage (Epiphanius), kinsmen (Jerome). The analogy of faith excludes
  the first (ever-virgin, DH 422, 503, 1880); the other two stay as two
  branches, both main.
- **SC4. The Fathers.** A claim of unanimous patristic consent is computed
  both ways. On Jn 6:53 the claim is refused where Trent itself records
  the Fathers' differing readings (sess. XXI, ch. 1, DH 1727).

### CR: the creeds and the Incarnation

- **CR1.** Typing the creeds as tier 1 changes no existing branch: what
  the base takes from them was already tier 1 by its council.
- **CR2. One and the same.** With the union encoded, the incarnate is
  divine, consubstantial with the Father, and of a human nature. No
  existing scenario changes, except the seven that load the Trinity with
  one of the theory's models (M5, AN1, AN4, TH0, TH20, TH20b, TH20c).
  There `christ` is named apart from the Son, and the kernel finds a
  fourth divine person (DH 804) until the models say that the incarnate is
  the Son. The fault is the models', and the fix goes there.
- **CR3. Mother of God is the test of the union.** "Mary is the Mother of
  God" is well typed when the one born of her is the divine person (T5,
  unchanged). The Nestorian candidate, in which the one born of her is a
  human person joined to the Word, makes it ill typed and gives two
  persons in Christ; it is refused (Ephesus, DH 251).
- **CR4. Two births, one principle.** Typed by person only, the birth of
  Mary gives the Son a second principle of origin, and the kernel's grain
  (A3; DH 850) fires on the two births that Constantinople II defines
  (DH 422). Typed by nature, it does not: the Son has one principle in his
  divinity, and is born of Mary in his humanity.
- **CR5. Change.** Typed by person only, his growth and his passion are
  change in God (DH 800), and on the Thomist runtime potency in pure act
  (Th. 1). Typed by nature, neither fires.
- **CR6. Bare is monoenergist.** On bare no created nature operates, so
  the incarnate has no human operation: one operation, against
  Constantinople III (DH 557). The deposit defines one instance of *agere
  sequitur esse*, the operation of Christ's humanity, and not the general
  thesis: a runtime that grants that one operation alone would boot.
- **CR7. The heresies.** The Arian candidate stays refused; Apollinarian
  (no rational soul), Nestorian, Eutychian (one nature after the union),
  monothelite (one will) and monoenergist (one operation) candidates are
  refused, each with its council. T5 covers the predications of Ephesus
  and Constantinople II without change: "God was born", "one of the
  Trinity was crucified in the flesh" are well typed; "the divinity
  suffered" is not.

### MA: Mary

- **MA1.** The four dogmas concern a creature and cross no line: no rule
  makes Mary divine, and "Mother of God" is a creature's relation to a
  divine person through his human nature (CR3, CR4).
- **MA2. The Immaculate Conception in history.** As of 1600 the question
  is open, both values main: Sixtus IV forbade either side to call the
  other heretical (*Grave nimis*, 1483, DH 1425–1426). As of 1860 the
  contrary value is deleted (DH 2803). Thomas's article, that she
  contracted original sin and was cleansed before birth (III q. 27 a. 2
  ad 2), is then a Doctor's teaching against a later definition, recorded
  as such; his standing elsewhere is untouched. The shape is *de
  auxiliis*', with the end *de auxiliis* never had.
- **MA3. The Assumption** leaves open whether she died before it: the
  question branches, both main.

### EC: the economy

- **EC1. Original sin and its exceptions.** Contracted by all who descend
  from Adam by propagation (DH 1513). Christ is without sin (DH 301); Mary
  is preserved (DH 2803), as Trent left her out (DH 1516). A rule of
  descent alone contradicts both definitions. Why Christ is free, by the
  virginal conception or by the union itself, is a school question; both
  readings boot.
- **EC2. Grace before the cross, from the cross.** A rule that orders the
  effects of the passion after it in time turns DH 2803 red: Mary's
  preservation, at her conception, is "in view of the merits of Christ".
  Typed as merits foreseen, nothing fires.

### M: meta

- **M1.** The TTC-SCHOOLS tables and the TTC-ACT and TTC-LAW results do
  not change, except as CR6 on bare and CR2 in the seven.
- **M2.** Every new rule has a test that fails without it; CL1 and PR4
  stay clean.

## CAVEATS

Tier 0 is not *sola scriptura*. Scripture and Tradition are one deposit,
and the checker reads both only as the Church's acts and the readings a
case supplies; it never reads a text itself. The readings in SC3 are the
encoder's statement of three Fathers' positions.

The *Quicumque* is not the act of a council. It is typed tier 1 by the
Church's reception of it as a creed, as the Apostles' Creed is.

EC1 says what is contracted at origin, by definition, of all; it says
nothing of any person's present state (rule 3; TTC-MORAL GR1).

Whether Mary died is open in the definition. Later papal catechesis on
the dormition is not encoded.

## STANDARDS

- *Dei Verbum* (1965) 10–12; CCC 114; Trent, sess. IV (1546), DH 1507;
  Vatican I, *Dei Filius* (1870), DH 3007
- Apostles' Creed (DH 30); Nicene-Constantinopolitan Creed (DH 150);
  *Quicumque* (DH 75–76); Nicaea (325), DH 125–126; Ephesus (431),
  DH 250–251; Chalcedon (451), DH 301–302; Constantinople II (553),
  cann. 2, 10, DH 422, 432; Lateran synod (649), can. 3, DH 503;
  Constantinople III (681), DH 556–557; Lateran IV (1215), DH 800–804;
  Lyons II (1274), DH 850
- Trent, sess. V (1546), DH 1513–1516; sess. VII (1547), *On baptism*,
  can. 2, DH 1615; sess. XIV (1551), *On penance*, can. 3, DH 1703; sess.
  XXI (1562), ch. 1, DH 1727; Vatican I, DH 3002
- Sixtus IV, *Grave nimis* (1483), DH 1425–1426; Paul IV, *Cum quorundam*
  (1555), DH 1880; Pius IX, *Ineffabilis Deus* (1854), DH 2803; Pius XII,
  *Munificentissimus Deus* (1950), DH 3903; Paul VI, *Credo of the People
  of God* (1968) 3
- Aquinas, ST III q. 27 a. 2 ad 2; the 24 Theses (1914), Th. 1 (DH 3601)
- Mk 6:3; Mt 1:25; Lk 2:52; Jn 3:5; 6:53; 20:22–23; Rom 5:12
- Jerome, *Adversus Helvidium*; Epiphanius, *Panarion* 78

## SEE ALSO

[ttc-moral(7)](moral-preregistration.md),
[ttc-christ(7)](christ-preregistration.md),
[ttc-layers(7)](../layers.md), [ttc-schools(7)](schools-preregistration.md)
