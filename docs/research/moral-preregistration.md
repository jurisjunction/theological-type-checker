# TTC-MORAL(7)

## NAME

**ttc-moral** — the morality of acts, sin and grace as standard
libraries: predictions, committed before encoding

## DESCRIPTION

The *Prima Secundae* runs from the end of man (qq. 1–5) through the human
act (qq. 6–21), the passions, habits and virtues (qq. 22–70), sin
(qq. 71–89) and law (qq. 90–108), to grace (qq. 109–114). The human act
and law are encoded (`act.lp`, `law.lp`). This step closes the treatise
with two libraries: the morality of acts and sin (`moral.lp`), and grace
(`grace.lp`). The passions, habits and virtues stay on the frontier; the
canons that touch them read `act.lp`'s claims.

The libraries that remain, in Thomas's order and in the order each needs
the others:

| Step | Libraries | Needs |
| --- | --- | --- |
| this | morality and sin; grace | act, law, the runtimes |
| next | Christ; the sacraments ([ttc-christ(7)](christ-preregistration.md)) | act, law, grace |
| then | faith and communion (II-II qq. 1–16, 39; cc. 11, 205, 751) | the sacraments, law |

When these are written, the patterns they repeat become a small language
for writing libraries, compiled to clingo.

One rule runs through both libraries: the checker judges kinds of act,
and what follows from the claims a case supplies, never a soul. The
Church states the rule for herself. "Although we can judge that an act is
in itself a grave offense, we must entrust judgment of persons to the
justice and mercy of God" (CCC 1861). No one can know "with a certainty
of faith, which cannot be subject to error, that he has obtained the
grace of God" (Trent, sess. VI, ch. 9; DH 1534). Rule 3 is the checker's
discipline; these are its warrant.

This file was committed and stamped before any of it was encoded,
together with TTC-CHRIST. SCORING will be appended below; nothing above
it will be edited.

## THE LIBRARIES

Fixed here.

### Morality and sin (`moral.lp`)

- **The sources of morality** (I-II q. 18 aa. 2–4; CCC 1750–1756):
  object, end, circumstances. The moral kind of an object is teaching, on
  the authority graph, about kinds of act (TTC-ACT). A case supplies which
  kind its act is, an outward fact, and the agent's end, which is
  interior and so input. A circumstance may give the act a new species
  (q. 18 a. 10).
- **Integrity.** An act is good only if good in object, end and
  circumstances, and evil from any defect (q. 18 a. 4 ad 3, after
  Dionysius). An act evil by its object is not made good by its end or its
  circumstances (Rom 3:8; *Veritatis splendor* 79–81; CCC 1753, 1756).
  Whether a kind is evil by its object is teaching, with its tier; the
  library applies the graph's branches and adds none.
- **Double effect** (II-II q. 64 a. 7; CCC 2263–2265). Two conditions are
  outward and computed: the object is not evil, and the evil effect is not
  the means to the good. Two are input: the evil is not intended, and the
  reason is proportionate. Proportion is weighed by the agent, never by
  the checker, as equity is (TTC-LAW).
- **Sin** is "a word, deed or desire contrary to the eternal law"
  (Augustine, *Contra Faustum* 22.27; I-II q. 71 a. 6): an act of a kind
  contrary to a law that binds (`law.lp`). Mortal sin: grave matter, full
  knowledge, deliberate consent (q. 72 a. 5; q. 88 aa. 1–2;
  *Reconciliatio et paenitentia* 17; CCC 1857–1859). Grave matter is
  teaching about kinds; knowledge and consent are `act.lp`'s interior
  claims. The library composes "mortal, if the claims supplied are true";
  it never says that a person sinned.
- **Sin and delict** keep their forums. A delict is an external violation
  imputable by dolus or culpa (c. 1321 §2), which `act.lp` composes. The
  canon layer computes no sin.
- **Two canons read sin.** c. 916, one "conscious of grave sin": the
  internal forum. c. 915, those "obstinately persevering in manifest grave
  sin": the external forum.

### Grace (`grace.lp`)

- **Necessity** (q. 109): no salutary act, not even the beginning of
  faith, without grace (Carthage, 418; Orange II, can. 5, DH 375; Trent,
  sess. VI, cann. 1–3, DH 1551–1553).
- **Kinds**: habitual and actual, operating and cooperating (q. 110 a. 2;
  q. 111 a. 2); sufficient and efficacious (the later schools).
- **Cooperation** (Trent, sess. VI, can. 4, DH 1554): free will, moved and
  aroused by God, cooperates by assenting and can dissent if it wishes; it
  is not "like something inanimate" that does nothing and is merely
  passive. Free will was not lost (can. 5, DH 1555).
- **Efficacy.** How efficacious grace is efficacious is *de auxiliis*,
  already on the authority graph and protected (Paul V, 1607): physical
  premotion (Báñez) or middle knowledge (Molina). The library states the
  interface; the readings are the runtimes' (`holds_premotion` in the
  Thomist runtime, `holds_concurrence` in the Suárezian).
- **Resisted grace.** Some interior grace is resisted: "in the state of
  fallen nature no one ever resists interior grace" was condemned as
  heretical (Innocent X, *Cum occasione*, 1653, prop. 2; DH 2002).
- **Inherence.** The grace of justification inheres in the justified
  (can. 11, DH 1561); its formal cause is "the justice of God, not that by
  which he himself is just, but that by which he makes us just" (ch. 7,
  DH 1529). That it is a created quality is Thomas's account (q. 110
  a. 2), not a definition.
- **Not known.** No rule derives that a person is in grace (ch. 9,
  DH 1533–1534; cann. 13–16, DH 1563–1566; I-II q. 112 a. 5). As a claim,
  it is input.

## METHOD

Encode both libraries, and route through them what the base already
holds: the *de auxiliis* question; c. 1321's dolus and culpa stay in
`act.lp`. Add c. 915 and c. 916 under `% @norm`, with c. 912 (the right
they restrict) and c. 18 extended to its own words (laws that restrict the
free exercise of rights). Add the declaration of the Pontifical Council
for Legislative Texts on c. 915 (24 June 2000) as a source. Write a
candidate for every refusal below. Run the whole suite and the runtimes'
boots.

## PREDICTIONS

### MO: morality and sin

- **MO1. One new interior input.** Knowledge, consent, the agent's end
  and the intention in double effect are `act.lp`'s `interior/3`. The one
  new input is a claim of being in grace: the same kind of claim, about a
  state rather than an act. Every rule that speaks of a person's sin or
  grace depends on such a claim; the test of rule 3 is extended to enforce
  it.
- **MO2. Double effect and c. 1323 n. 5.** Legitimate defence is double
  effect's own case (CCC 2263). The library and c. 1323 n. 5 read the same
  supplied claims (`act.lp`'s `due_defence`); neither keeps a predicate of
  its own. Proportion is never computed; a test enforces it.
- **MO3. c. 916 is never computed.** Its one element is interior. In
  every case it is a branch on the internal forum.
- **MO4. c. 915, first clause.** It reads the canon layer's declared or
  imposed penalties, never one incurred and undeclared. In the SSPX case
  it reaches those the 2026 decree names, in the branches where the
  declaration stands, and no one else: not the Society's other priests,
  not the faithful. It needs no interior input.
- **MO5. c. 915, second clause.** "Manifest grave sin" admits two
  readings: objective (the Council's declaration: "grave sin, understood
  objectively", since the minister cannot judge subjective imputability)
  and subjective. The declaration is not an authentic interpretation: it
  does not say it was confirmed by pontifical authority, as *Pastor bonus*
  art. 155 required (c. 16 §1). The reading is therefore a doubt of law;
  and c. 915 restricts the right of c. 912, so c. 18 applies.
  - If the subjective reading is admissible, c. 18 takes it as the
    narrower. On it, the clause needs an interior claim the external forum
    never has: it reaches no one on outward facts, and coincides with
    c. 916.
  - If only the objective reading is admissible (the declaration's reading
    of the words, c. 17), the clause needs no interior input: an outward
    situation, its gravity by matter from the theological side
    (`classification/3`), and its manifestness and persistence as facts.
  - Whether the subjective reading is admissible is disputed, and the
    checker branches on it (rule 2). The pair raises nothing in either
    branch.
- **MO6.** Encoding the library changes no existing scenario.

### GR: grace

- **GR1. Rule 3 has a warrant in the deposit.** A candidate that derives a
  person's state of grace from outward facts (his works, or his reception
  of the sacraments) is refused as against Trent (DH 1534, 1563–1566),
  not only by the test of rule 3.
- **GR2.** Pelagian and semi-Pelagian candidates are refused on every
  runtime but bare: a salutary act, or the beginning of faith, without
  grace.
- **GR3. Bare is incoherent with Trent.** In a constructed case of
  justification, bare yields a violation: there the will does nothing and
  is merely passive, against can. 4 (DH 1554). The deposit defines one
  instance of *agere sequitur esse*, the will moved by grace acts, and not
  the general thesis: a runtime that grants that one operation alone would
  boot.
- **GR4. Resisted grace.** The library needs a sufficient grace that is
  resisted. With it, the Jansenist candidate (every interior grace
  efficacious) is refused on every runtime, at tier 1.
- **GR5. The protection reaches the library.** Trent says the will "can
  dissent if it wishes" (DH 1554). Encoded without the distinction of the
  composite and the divided sense, that clause turns the Thomist runtime
  red: the charge Paul V forbade either side to press (1607). With the
  distinction, the Thomist and the Suárezian runtimes boot with the
  library. A test enforces that no library rule makes a runtime that holds
  a protected reading incoherent.
- **GR6. Created and uncreated grace.** The Palamite runtime holds
  deifying grace an uncreated energy. Whether that is coherent with the
  deposit turns on a reading of ch. 7 (DH 1529): as excluding Osiander's
  essential justice only, or as excluding any uncreated formal cause. The
  checker reads the chapter both ways. The Palamite runtime boots in the
  first branch and is red in the second; the four Latin runtimes boot in
  both.

### M: meta

- **M1.** The TTC-SCHOOLS tables and the TTC-ACT and TTC-LAW results do
  not change, except as GR3 on bare.
- **M2.** Every new rule has a test that fails without it; CL1 and PR4
  stay clean.

## CAVEATS

MO5 concerns a contested question with pastoral weight: the admission to
Communion of the divorced and civilly remarried, and of public figures.
The checker decides neither the reading nor any person's case. It
computes both readings and shows what each needs.

GR6 types a Byzantine account in a Latin frame (formal cause). Palamas
does not speak of a formal cause of justification; the mapping is the
encoder's, and a reading of it may be disputed in turn.

Double effect in four conditions is the manualists' form (Gury, 1850);
Thomas states the principle in one article. The library encodes the
common form, with Thomas's article as its source.

TTC-ACT's N1 and N3 rest on this library's object and circumstance
(q. 18 a. 10). They remain to be scored in the canon-law step, as that
file's amendment says.

## STANDARDS

- Aquinas, ST I-II q. 18 aa. 2–4, 10; q. 71 a. 6; q. 72 a. 5; q. 88
  aa. 1–2; q. 109; q. 110 a. 2; q. 111 a. 2; q. 112 a. 5; II-II q. 64 a. 7
- Augustine, *Contra Faustum* 22.27
- Carthage (418); Orange II (529), can. 5 (DH 375); Trent, sess. VI
  (1547), chh. 7, 9, cann. 1–5, 11, 13–16 (DH 1529, 1533–1534, 1551–1555,
  1561, 1563–1566); Innocent X, *Cum occasione* (1653), prop. 2 (DH 2002)
- John Paul II, *Reconciliatio et paenitentia* (1984) 17; *Veritatis
  splendor* (1993) 79–81; CCC 1750–1756, 1857–1861, 2263–2265
- CIC cc. 16, 17, 18, 912, 915, 916, 1321, 1323
- Pontifical Council for Legislative Texts, Declaration on c. 915 (24 June
  2000)
  (https://www.vatican.va/roman_curia/pontifical_councils/intrptxt/documents/rc_pc_intrptxt_doc_20000706_declaration_en.html);
  John Paul II, *Pastor bonus* (1988) artt. 154–155

## SEE ALSO

[ttc-act(7)](act-preregistration.md), [ttc-law(7)](law-preregistration.md),
[ttc-christ(7)](christ-preregistration.md),
[ttc-schools(7)](schools-preregistration.md)
