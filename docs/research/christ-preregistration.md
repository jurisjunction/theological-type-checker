# TTC-CHRIST(7)

## NAME

**ttc-christ** — Christ and the sacraments as standard libraries:
predictions, committed before encoding

## DESCRIPTION

The *Tertia Pars* treats the Saviour (qq. 1–59), then the sacraments
(qq. 60–90), which have their power from his passion through his humanity
(q. 62 a. 5). The base holds little of either. Read as the rules stand,
before any run:

- **The incarnate is a sort, not a person named.** `incarnate(X)` makes X
  a person, of human nature, and an image (`kernel_core.lp`). It does not
  make X divine, nor consubstantial with the Father, and nothing says which
  divine person X is. The Trinity's model names the Son `son`; the
  *Grammar of the Icon*'s models name the incarnate `christ`. Chalcedon's
  "one and the same Son" (DH 301–302) is not encoded.
- **The human act has no place for him.** `act.lp` makes whoever places
  an act a creature, unless divine. As now typed, an act of the incarnate
  would make him a creature. Typed divine, he would place no act the
  library knows: only creatures act (the classical runtime).
- **The sacraments are canons without a theory.** The canon layer derives
  the validity of absolution and of the form of marriage, and presupposes
  valid consecrations. It does not say what a sacrament is, which of its
  conditions are divine law, or why.

Write the defined Christology into the kernel, as deposit (TTC-LAYERS:
a tier-1 source defines it), and two libraries: `christ.lp` and
`sacrament.lp`. Then run the cases the base holds, and three more: a
change of the form of baptism, the seal of confession, and the
heresies the councils refused.

This file was committed and stamped before any of it was encoded,
together with TTC-MORAL, which is encoded first. SCORING will be appended
below; nothing above it will be edited.

## THE LIBRARIES

Fixed here.

### Christ (deposit in the kernel; `christ.lp`)

- **Deposit** (tier 1). One person, the eternal Son, in two natures,
  without confusion, change, division or separation; consubstantial with
  the Father in his divinity and with us in his humanity; of a rational
  soul and a body; like us in all things but sin (Chalcedon, DH 301–302).
  Mary is Mother of God (Ephesus, DH 250–251). One of the Trinity suffered
  in the flesh (Constantinople II, can. 10, DH 432). Two natural wills and
  two natural operations, the human following the divine and subject to it
  (Constantinople III, DH 556–557). God is "incommutabilis" (Lateran IV,
  DH 800). In God there is a Trinity, not a quaternity (DH 804); the Son,
  not the Father or the Spirit, became flesh (DH 801).
- **The union is in the person** (III q. 2 aa. 2–3, 6). The incarnate is a
  divine person, given as input: which person assumed the nature.
- **Acts belong to the person, by a nature.** The person acts; each
  nature is the principle by which (III q. 19 a. 1). The human operation
  is the instrument of the divinity, and is not one operation with it:
  the "theandric" operation (Dionysius, *Ep.* 4) read as the councils read
  it (III q. 19 a. 1 ad 1).
- **Schools.** Why the Word became flesh: for sin (III q. 1 a. 3) or by
  the absolute primacy of Christ (Scotus, *Ord.* III d. 7 q. 3). Christ's
  esse: one (III q. 17 a. 2) or a secondary esse of the humanity (*De
  unione Verbi incarnati* a. 4). No tier-1 source decides either.

### The sacraments (`sacrament.lp`)

- **What a sacrament is.** Seven (Trent, sess. VII, can. 1, DH 1601),
  instituted by Christ. God is the principal cause, Christ's humanity the
  conjoined instrument, the sacrament and its minister separated
  instruments (III q. 62 a. 5; q. 64 a. 1). The sacrament acts *ex opere
  operato* (can. 8, DH 1608); the minister's sin does not hinder it
  (can. 12, DH 1612; Augustine, *In Ioh.* 6.7: "it is Christ who
  baptizes").
- **Validity.** Matter, form, and a minister with the power and "the
  intention at least of doing what the Church does" (Florence, DH 1312;
  can. 11, DH 1611); for all but baptism, a baptized subject (c. 842 §1).
- **Two laws in one sacrament.** The Church has power over the sacraments
  "saving their substance" (Trent, sess. XXI, ch. 2, DH 1728). What belongs
  to the substance is divine law; the supreme authority alone defines
  further requirements for validity, and other competent authority those
  for liceity (c. 841). Each condition is typed by its law: the power of
  orders to absolve is divine (Trent, sess. XIV, can. 10, DH 1710), the
  faculty is ecclesiastical (c. 966 §1); consent makes marriage and no
  human power supplies it (c. 1057 §1), the canonical form is
  ecclesiastical (c. 1108). Which conditions belong to the substance is
  teaching, given by the theological side (`classification/3`; rule 1).
- **Intention is interior**, so input. The Church "does not judge about
  the mind and intention, in so far as it is something by its nature
  internal", but one who has correctly and seriously used the due matter
  and form is presumed to intend what the Church does (Leo XIII,
  *Apostolicae curae* 33). The presumption yields only to a contrary
  intention manifested outwardly. Typed as a presumption, as c. 1321 §4
  is; never computed.
- **Character.** Baptism, confirmation and orders imprint a character and
  are not repeated (can. 9, DH 1609; III q. 63; c. 845 §1); in a prudent
  doubt they are conferred conditionally (c. 845 §2).
- **The seal.** "The sacramental seal is inviolable" (c. 983 §1). Its
  secrecy "comes directly from the revealed divine right", "is rooted in
  the very nature of the Sacrament", and admits no exception "in the
  ecclesial sphere, nor, least of all, in the civil one"; it lies "beyond
  the reach of the volition of the penitent" (Apostolic Penitentiary,
  *Note on the importance of the internal forum and the inviolability of
  the sacramental seal*, 29 June 2019, approved by the Pope). A confessor
  who directly violates it incurs latae sententiae excommunication
  reserved to the Apostolic See (c. 1386 §1).

## METHOD

Encode the deposit in `kernel_core.lp` and the two libraries; route the
canon layer's absolution, marriage and consecration rules through
`sacrament.lp`. Add the canons named above under `% @norm`, with their
texts from vatican.va. Add to the canon layer a generic delict input, so
that a delict need not be a consecration, an absolution or a marriage;
and to `law.lp` the kind of civil law. New cases: the responsum on "We
baptize" (Congregation for the Doctrine of the Faith, 24 June 2020,
approved by the Pope on 8 June 2020); a confessor coerced, under a civil
law, to disclose a confession (HYPOTHETICAL); candidates for each heresy
and each refusal below. Run the whole suite and the runtimes' boots.

## PREDICTIONS

### CH: Christ

- **CH1. One and the same.** With the union encoded, the incarnate is
  divine, consubstantial with the Father, and of a human nature. No
  existing scenario changes, except the seven that load the Trinity with
  one of the *Grammar of the Icon*'s models (M5, AN1, AN4, TH0, TH20,
  TH20b, TH20c). There `christ` is named apart from the Son, and the
  kernel finds a fourth divine person (DH 804) until the models say that
  the incarnate is the Son. The fault is the models', and the fix goes
  there.
- **CH2. His acts, and his change.** `act.lp` is changed to read the
  nature, not the sort: the person acts, by the nature. A human act of the
  incarnate is then an *actus humanus* of a divine person, and `act.lp` no
  longer makes him a creature. No TTC-ACT scenario changes. The same holds
  of change. The incarnate grows (Lk 2:52) and suffers in the flesh;
  stated of the person without a nature, that is change in God, against
  the definition (DH 800, "incommutabilis"), and on the Thomist runtime
  potency in pure act (Th. 1). Typed by nature, neither fires: the person
  changes in the human nature, and the divine does not.
- **CH3. Bare is monoenergist.** On bare, no created nature operates, so
  the incarnate has no human operation: one operation, against
  Constantinople III (DH 557). The deposit defines one more instance of
  *agere sequitur esse* (with TTC-MORAL GR3): the humanity of Christ
  operates. Not the general thesis: a runtime that grants that one
  operation alone would boot.
- **CH4. The heresies.** The Arian candidate stays refused; Apollinarian
  (no rational soul), Nestorian (two subjects), Eutychian (one nature
  after the union), monothelite (one will) and monoenergist (one
  operation) candidates are refused, each with its council. The kernel's
  typing of predication (T5) covers the predications of Ephesus and
  Constantinople II without change: "God was born", "one of the Trinity
  suffered in the flesh" are well typed; "the divinity suffered" is not. A
  case that supplies claims composing a sin of the incarnate is refused
  (DH 301): he is the one person of whom the deposit states the interior,
  and the checker reads it there, never computes it.
- **CH5. Schools.** The motive of the Incarnation and Christ's esse each
  branch, both values main: no source of tier 1 to 3 decides either. The
  library boots on every runtime but bare, and the TTC-SCHOOLS tables do
  not change.

### SA: the sacraments

- **SA1.** Routing the canon layer's absolution, marriage and
  consecration rules through the library changes no scenario.
- **SA2. c. 841 by law.** Once each condition is typed by its law, the
  law library's existing checks do the rest; no new dispensation rule is
  needed. A dispensation from an ecclesiastical condition by the competent
  authority stands (c. 1127 §2, from the canonical form, for a mixed
  marriage); one from a condition of the substance (the water of baptism)
  is refused as dispensing divine law.
- **SA3. One presumption.** The presumption of intention (*Apostolicae
  curae* 33) and the presumption of imputability (c. 1321 §4) have one
  shape: an outward fact, an interior claim presumed, rebutted only by
  outward facts. One rule of `act.lp` serves both, and c. 1321 §4 is
  routed through it unchanged. The test of rule 3 passes.
- **SA4. Donatism.** A candidate that makes validity depend on the
  minister's grace or orthodoxy turns every validity in the base into a
  branch on the internal forum: no sacrament would be certain, since no
  rule derives a state of grace (TTC-MORAL GR1). It is refused (DH 1612).
- **SA5. "We baptize."** The responsum classifies the changed form as
  against the substance: the baptism is invalid, and the persons must be
  baptized absolutely, not conditionally. The responsum is tier 3 (a
  dicastery's act approved by the Pope in ordinary form), so the branch in
  which the form is valid is a live shadow, cleaved, not deleted. Where it
  is disputed whether "we" was said, the checker branches on the fact, and
  in the doubt c. 845 §2 gives conditional baptism.
- **SA6. Character.** A repeated baptism, confirmation or ordination is
  flagged. The 1988 and 2026 consecrations are valid on the presumption
  (SA3), with the character; the SX scenarios do not change.
- **SA7. The seal.** The case runs on the three libraries with one new
  input, the generic delict, and no new rule in `law.lp` beyond the kind
  of civil law.
  - The ground is checked, not cited. "Of divine law, from the nature of
    the sacrament" is a classification on the theological side. It rests
    on tier-3 teaching (the Penitentiary's note, approved by the Pope) and
    the common teaching of the theologians, not on a definition. The branch in which
    the seal is of ecclesiastical law only is therefore a shadow, cleaved
    and not deleted, and it shows what the ground protects: in it the
    supreme authority could dispense.
  - In the main branch no one dispenses; a civil law that requires
    disclosure does not bind (q. 96 a. 4); the penitent cannot release
    the confessor.
  - A confessor who discloses under grave fear is not exempt (c. 1323
    n. 4: the act tends to the harm of souls), his penalty is mitigated
    (c. 1324 §1 n. 5), and the latae sententiae excommunication of
    c. 1386 §1 does not bind him (c. 1324 §3). The delict stands.

### M: meta

- **M1.** The TTC-SCHOOLS tables and the TTC-ACT, TTC-LAW and TTC-MORAL
  results do not change, except as CH3 on bare and CH1 in the seven.
- **M2.** Every new rule has a test that fails without it; CL1 and PR4
  stay clean.

## CAVEATS

CH1's red is a finding against the *Grammar of the Icon*'s models, which
spoke of Christ without saying who he is.

The tiers in SA5 and SA7 are the encoder's typing of real acts. A
responsum approved by the Pope binds in practice whatever its tier; the
tier says only what a later act could reform. Neither the Anglican orders
of *Apostolicae curae* nor any civil statute is encoded; the coerced
confessor is a constructed case.

The libraries give Thomas's account where the schools differ: the
sacraments as instrumental causes (against Cano's moral causality and the
Scotists' covenant), and the character as a power (q. 63 a. 2). No canon
here asks which.

## STANDARDS

- Aquinas, ST III q. 1 a. 3; q. 2 aa. 2–3, 6; q. 16; q. 17 a. 2; q. 18;
  q. 19 a. 1; q. 60; q. 62 a. 5; q. 63; q. 64 aa. 1, 5, 8; *De unione
  Verbi incarnati* a. 4; Scotus, *Ord.* III d. 7 q. 3; Dionysius, *Ep.* 4;
  Augustine, *In Iohannis evangelium tractatus* 6.7
- Ephesus (431), DH 250–251; Chalcedon (451), DH 301–302; Constantinople
  II (553), can. 10, DH 432; Constantinople III (681), DH 556–557;
  Lateran IV (1215), DH 800, 801, 804; the 24 Theses (1914), Th. 1
  (DH 3601); Florence, *Exsultate Deo* (1439),
  DH 1312; Trent, sess. VII (1547), cann. 1, 8, 9, 11, 12 (DH 1601, 1608,
  1609, 1611, 1612); sess. XIV (1551), can. 10 (DH 1710); sess. XXI
  (1562), ch. 2 (DH 1728)
- Leo XIII, *Apostolicae curae* (1896) 33; CCC 1467; Lk 2:52
- CIC cc. 841, 842 §1, 845, 966 §1, 983 §1, 1057 §1, 1108, 1127 §2,
  1321 §4, 1323 n. 4, 1324 §1 n. 5 and §3, 1386 §1
- Congregation for the Doctrine of the Faith, *Responsa ad dubia* on
  the form of baptism (24 June 2020)
  (https://www.vatican.va/roman_curia/congregations/cfaith/documents/rc_cdf_doc_20200624_responsum-nota-battesimo_en.html)
- Apostolic Penitentiary, *Note on the importance of the internal forum
  and the inviolability of the sacramental seal* (29 June 2019)
  (https://www.vatican.va/roman_curia/tribunals/apost_penit/documents/rc_trib_appen_pro_20190629_forointerno_en.html)

## SEE ALSO

[ttc-moral(7)](moral-preregistration.md), [ttc-act(7)](act-preregistration.md),
[ttc-law(7)](law-preregistration.md), [ttc-layers(7)](../layers.md),
[ttc-canon(5)](../canon-law-layer.md)
