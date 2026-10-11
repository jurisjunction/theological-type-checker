# TTC-CHRIST(7)

## NAME

**ttc-christ** — Christ's acts and the sacraments as standard libraries:
predictions, committed before encoding

## DESCRIPTION

The *Tertia Pars* treats the Saviour (qq. 1–59), then the sacraments
(qq. 60–90), which have their power from his passion through his humanity
(q. 62 a. 5). What the Church defines of Christ is deposit, and goes into
the kernel first ([ttc-creed(7)](creed-preregistration.md)). This step
writes what the canons and the moral libraries call on: his acts, and the
sacraments. Read as the rules stand, before any run:

- **The human act has no place for him.** `act.lp` makes whoever places
  an act a creature, unless divine. As now typed, an act of the incarnate
  would make him a creature. Typed divine, he would place no act the
  library knows: only creatures act (the classical runtime).
- **The sacraments are canons without a theory.** The canon layer derives
  the validity of absolution and of the form of marriage, and presupposes
  valid consecrations. It does not say what a sacrament is, which of its
  conditions are divine law, or why.

Write two libraries, `christ.lp` and `sacrament.lp`, on TTC-CREED's
deposit and TTC-MORAL's libraries. Then run the cases the base holds, and
two more: a change of the form of baptism, and the seal of confession.

This file was committed and stamped before any of it was encoded,
together with TTC-CREED and TTC-MORAL, which are encoded first. SCORING
will be appended below; nothing above it will be edited.

## THE LIBRARIES

Fixed here.

### Christ (`christ.lp`)

- **Acts belong to the person, by a nature.** The person acts; each
  nature is the principle by which (III q. 19 a. 1). The human operation
  is the instrument of the divinity, and is not one operation with it:
  the "theandric" operation (Dionysius, *Ep.* 4) read as the councils read
  it (III q. 19 a. 1 ad 1).
- **Without sin.** Like us in all things but sin (Chalcedon, DH 301): of
  this one person the deposit states the interior.
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
  (can. 12, DH 1612; Augustine, *In Ioh.* 6.7: "Peter may baptize, but
  this is He that baptizes").
- **Validity.** Matter, form, and a minister with the power and the
  intention of doing what the Church does (Florence, DH 1312), "at least"
  (Trent, can. 11, DH 1611); for all but baptism, a baptized subject
  (c. 842 §1).
- **Two laws in one sacrament.** The Church has power over the sacraments
  "saving their substance" (Trent, sess. XXI, ch. 2, DH 1728). What belongs
  to the substance is divine law. The supreme authority alone approves or
  defines the requirements for validity; it, or another competent
  authority (c. 838 §§3–4), what pertains to liceity (c. 841). Each
  condition is typed by its law: the power of orders to absolve is divine
  (Trent, sess. XIV, can. 10, DH 1710), the faculty is ecclesiastical
  (c. 966 §1); consent makes marriage and no human power supplies it
  (c. 1057 §1), the canonical form is ecclesiastical (c. 1108). Which
  conditions belong to the substance is teaching, given by the
  theological side (`classification/3`; rule 1).
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

Encode the two libraries and route the canon layer's absolution,
marriage and consecration rules through `sacrament.lp`. Add the canons
named above under `% @norm`, with their texts from vatican.va. Add to the
canon layer a generic delict input, so that a delict need not be a
consecration, an absolution or a marriage; and to `law.lp` the kind of
civil law. New cases: the responsum on "We baptize" (Congregation for the
Doctrine of the Faith, 24 June 2020, approved by the Pope on 8 June
2020); a confessor coerced, under a civil law, to disclose a confession
(HYPOTHETICAL); candidates for each refusal below. Run the whole suite
and the runtimes' boots.

## PREDICTIONS

### CH: Christ

- **CH1. His acts.** `act.lp` is changed to read the nature, not the
  sort: the person acts, by the nature. A human act of the incarnate is
  then an *actus humanus* of a divine person, and `act.lp` no longer makes
  him a creature. No TTC-ACT scenario changes.
- **CH2. Without sin.** A case that supplies claims composing a sin of the
  incarnate (TTC-MORAL) is refused (DH 301). He is the one person of whom
  the deposit states the interior; the checker reads it there and never
  computes it.
- **CH3. Schools.** The motive of the Incarnation and Christ's esse each
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
    the common teaching of the theologians, not on a definition. The
    branch in which the seal is of ecclesiastical law only is therefore a
    shadow, cleaved and not deleted, and it shows what the ground
    protects: in it the supreme authority could dispense.
  - In the main branch no one dispenses; a civil law that requires
    disclosure does not bind (I-II q. 96 a. 4); the penitent cannot release
    the confessor.
  - A confessor who discloses under grave fear is not exempt (c. 1323
    n. 4: the act tends to the harm of souls), his penalty is mitigated
    (c. 1324 §1 n. 5), and the latae sententiae excommunication of
    c. 1386 §1 does not bind him (c. 1324 §3). The delict stands.

### M: meta

- **M1.** The TTC-SCHOOLS tables and the TTC-ACT, TTC-LAW, TTC-CREED and
  TTC-MORAL results do not change.
- **M2.** Every new rule has a test that fails without it; CL1 and PR4
  stay clean.

## CAVEATS

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

- Aquinas, ST I-II q. 96 a. 4; III q. 1 a. 3; q. 17 a. 2; q. 19 a. 1;
  q. 60; q. 62 a. 5; q. 63; q. 64 aa. 1, 5, 8; *De unione Verbi incarnati*
  a. 4; Scotus, *Ord.* III d. 7 q. 3; Dionysius, *Ep.* 4; Augustine, *In
  Iohannis evangelium tractatus* 6.7
- Chalcedon (451), DH 301; Florence, *Exsultate Deo* (1439), DH 1312;
  Trent, sess. VII (1547), cann. 1, 8, 9, 11, 12 (DH 1601, 1608, 1609,
  1611, 1612); sess. XIV (1551), can. 10 (DH 1710); sess. XXI (1562),
  ch. 2 (DH 1728)
- Leo XIII, *Apostolicae curae* (1896) 33; CCC 1467
- CIC cc. 838 §§3–4, 841, 842 §1, 845, 966 §1, 983 §1, 1057 §1, 1108,
  1127 §2, 1321 §4, 1323 n. 4, 1324 §1 n. 5 and §3, 1386 §1
- Congregation for the Doctrine of the Faith, *Responsa ad dubia* on
  the form of baptism (24 June 2020)
  (https://www.vatican.va/roman_curia/congregations/cfaith/documents/rc_cdf_doc_20200624_responsum-nota-battesimo_en.html)
- Apostolic Penitentiary, *Note on the importance of the internal forum
  and the inviolability of the sacramental seal* (29 June 2019)
  (https://www.vatican.va/roman_curia/tribunals/apost_penit/documents/rc_trib_appen_pro_20190629_forointerno_en.html)

## SEE ALSO

[ttc-creed(7)](creed-preregistration.md),
[ttc-moral(7)](moral-preregistration.md), [ttc-act(7)](act-preregistration.md),
[ttc-law(7)](law-preregistration.md), [ttc-canon(5)](../canon-law-layer.md)
