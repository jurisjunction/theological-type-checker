# A guide for theologians and canonists

This guide explains what the theological type checker is, how it reasons, and
how to read what it says. It assumes theology and canon law, not
programming. The formal statement, with every axiom, warrant and test table,
is the [Core Edition](core-edition.md). What went wrong and what was learned
is in [Findings](findings.md).

---

## 1. What this is, and what it is not

A **type checker** does not decide whether a program does what its author
wanted. It decides whether the program is *well-formed*: whether each
operation is applied to things of the kind it can apply to. In practice that
catches a surprising share of real errors, because many errors are not false
statements but category mistakes.

Theology and canon law have category mistakes of their own, and most of them
are old and well known. Some examples:

- predicating of the divine nature what belongs to the Person through the
  human nature ("the Godhead died")
- treating a disciplinary law as if it were a doctrinal definition
- reading a "cannot" where the text means "ought not"
- answering "is this person excommunicated?" with evidence about a group
- ranking persons by a property every person has

The checker makes such distinctions explicit and mechanical. Each claim is
entered as typed facts, and the rules report whether the claims fit together.

It does three things:

1. **It types relations.** A small theory, the *Grammar of the Icon*, says
   what kinds of relation there are (giving being, originating, acting on,
   nuptial self-gift, being ordered side by side to a common end) and what
   holds of each. That theory produces consequences that can be checked
   against defined teaching and against the canons on marriage.
2. **It types authority.** Every source has a tier (de fide credenda,
   definitive tenenda, the authentic ordinary magisterium and ecclesiastical
   law, the Doctors, individual theologians), a force (truth, juridical,
   protective), a form, a character and a date. Disputed questions split into
   **branches**. A branch is deleted only by a tier-1 act. Lower acts can
   only cleave a branch into a recoverable **shadow**.
3. **It keeps score honestly.** Every rule is tested on dated historical
   cases and on positions the theory claims to forbid. Every rule is also
   deleted in turn to show that some test depends on it.

What it is **not**:

- **Not an oracle.** It cannot show that a well-formed claim is true. That
  judgment belongs to Scripture, Tradition and the magisterium (*Dei Verbum*
  10). Everything in the theory is argument from fittingness, submitted to the
  judgment of the Church.
- **Not a court.** It never computes anyone's culpability or interior state.
  That is the internal forum, and the checker treats it as an input it may
  not fill (the *rule of non-diagnosis*).
- **Not neutral about its own encoding.** Deciding that a text answers a
  question, at a given tier, read a given way, is interpretation done by a
  person. What the checker adds is that each such decision becomes a visible
  fact someone else can dispute.

## 2. Why a type system for theology

Theological writing already has a type discipline. It is scattered through
the tradition, never written down in one place, and so it is often broken
without anyone noticing. Four of its rules carry most of the weight here:

- **The communicatio idiomatum** (ST III q.16) is a type system for
  predication about Christ. A concrete term ("God", "this man") takes
  predicates of either nature. An abstract nature-term ("the divinity")
  takes only its own. Some sentences ("Christ is a creature") are well-typed
  but need a qualifier. The checker reproduces Thomas's classification of
  seven test sentences (T5).
- **Analogy** (Lateran IV, DH 806; ST I q.13 aa.5–6) forbids crossing the
  Creator–creature line except under rules. The checker makes this a sort
  discipline: nothing crosses except through a declared bridge (§4).
- **The grades of assent** (cc. 750–752; LG 25; *Ad tuendam fidem*;
  *Donum veritatis* 23–24) type what a text can demand of the reader.
- **The distinction of forums** (cc. 130, 1082; the internal forum in the
  sacrament of penance) types which facts belong to whom.

Once these are explicit, a disagreement between the checker and an author
becomes a *question*: is the checker wrong, or is the text? That question is
the method (§7).

## 3. The core grammar

The theory has five relations:

| Relation | Reads | Example |
| --- | --- | --- |
| E(g, x) | *g* gives being to *x* | creation |
| O(p, x) | principle *p* originates *x* | the Son from the Father; a child from the spouses |
| D(x, y) | *x* acts on *y* | ordinary causation |
| N(x, y) | *x* gives itself to *y* face to face | marriage; Christ and the soul |
| S(x, y, t) | *x* and *y* are ordered together to a common end *t* | friendship |

Thirteen axioms (A0–A11 with A4a) govern them, each with a warrant chosen to be
independent of what the axioms are later claimed to explain. Among them:

- **A3 (the grain).** A term has at most one principle of origin. The Son is
  from the Father alone. The Spirit is from the Father and the Son *as from one
  principle* (Lyons II, DH 850; Florence, DH 1300–1302).
- **A4.** Two sources form one principle only under a license: identity of
  power in God (ST I q.36 a.4), a closed nuptial circuit in creatures. The two
  licenses are analogous and never interchanged.
- **A4a.** In creatures the circuit closes in the spouses' conjugal act, not
  merely in the standing bond. The bond gives a right to the act, not to the
  child (Pius XII, 1951 and 1956; HV 14).
- **A5.** A person receives a nuptial gift only by their own consent, though at
  origin it may be held in trust and ratified later, as in infant baptism.
- **A10.** Image and dignity are not graded: every person is a full image at
  every stage and in every state.

From these the checker derives, among other things, the following:

- the line c. 1084 draws between impotence (invalidating) and sterility (not
  invalidating), because fertility appears in no rule
- c. 1057 §1's rule that no human power can supply consent
- the uniqueness of a total self-gift between finite persons (c. 1056; FC 19),
  together with the non-rivalrous gift of the whole Christ to each
  communicant (Trent, DH 1641)
- *Donum vitae*'s child's-right formulation

It also shows that several positions real people hold are ill-formed. One is
the diagram in which the man images God and the woman the creature: a
"receptive" or "donative" pole read as a property holds of every person, so it
cannot distinguish one person from another (T1). Others are functionalist
personhood and the ranking of states of life by magnitude of self-gift.

Prior work matters here. The gift-and-acceptance reading of consent and bond
is settled in the Navarra school (Hervada, Viladrich, Errázuriz) and in Burke,
and a trinitarian ground for the bond appears in Viladrich, Pastwa and
Ouellet. What is claimed is narrower: those pieces stated as one typed theory
with an executable checker. See
[research/warrants-and-prior-art.md](research/warrants-and-prior-art.md).

## 4. Analogy as a type discipline

Every individual has a sort, divine or creaturely. Rules apply to a sort only
if a **bridge** licenses them there. Each bridge has three features:

- it names a shared form (being, origination, principle, grain, acyclicity)
- it takes God as the primary analogate, said *per prius et posterius* (ST I q.13 a.6)
- it states the form's **mode** on each side

| Form | In God | In creatures |
| --- | --- | --- |
| Being | unreceived | received (the *analogia entis* itself) |
| Origination | eternal procession | temporal generation |
| Principle | two as one by identity of power | two as one by a closed circuit |
| Grain | one principle, as a *necessity* | one principle, as a *norm* |

Consequences:

- **Deny by default.** Withdraw the divine side of a bridge and the Trinity
  model loses what that bridge carried, while creatures are untouched (AN4).
- **Projection is flagged.** A bridge with the creature as primary analogate
  is a violation (AN5).
- **A static check** rejects any rule that mixes divine and creaturely
  predicates without going through a bridge (AN7, AN8). The one exception is
  by construction: the incarnate Word, in whom the communicatio idiomatum *is*
  the bridge.
- **Lateran IV is a two-sided test.** Any image of the Trinity must show
  licensed similarity *and* a remainder. A complete map is a violation (AN11).

The modes do real work. Make them univocal and the theory either declares
existing children impossible or puts God under a norm (UN1, UN2). The
consequences for the debate over Scotus are in [Findings §1](findings.md#1-univocity-of-mode-and-what-it-costs).

## 5. The authority graph

### Tiers, forces, dates

| Tier | Assent owed | Typical sources |
| --- | --- | --- |
| 1 | divine and Catholic faith (c. 750 §1) | conciliar definitions; ex cathedra definitions |
| 2 | firm assent (c. 750 §2) | definitive teaching |
| 3 | religious submission (c. 752); obedience to law | encyclicals, exhortations, the Code, curial acts |
| 4 | — | Doctors of the Church, from the date of declaration |
| 5 | — | individual theologians and canonists |

Each source also has a **force**:

- *truth*: it asserts something
- *juridical*: it imposes or declares something
- *protective*: it forbids treating either side of a question as excluded,
  as Sixtus IV did for the Immaculate Conception and Paul V did *de auxiliis*

Each source also has a **date**. Every result is computed *as of* a year, so a
backtest as of 1600 sees only what existed in 1600, with the standing it had
then.

### Branches and shadows

Each disputed question splits into one branch per answer. The sources in
force decide each branch's status:

- **Tier 1 truth deletes** contrary branches.
- **Tier 2 and tier 3, and juridical acts, cleave.** The contrary branch
  becomes a **shadow**. A *live* shadow is labelled with the sources whose
  relaxation would bring it back. If that happens, it returns with all its
  downstream consequences recomputed. A *counterfactual* shadow, made by a
  tier-2 truth source under the assumption that tier 2 has truth-force, can be
  inspected but never returns.
- **Everything else only weighs.** Main branches are ranked by how much
  authority disagrees with them, tier 3 first, then 4, then 5. Weight states a
  preference, never a resolution (see [Findings §2](findings.md#2-scotus-and-the-immaculate-conception-weight-is-not-prediction)).
- **Protection** stops sources at or below the protecting tier from cleaving.

A value is **settled** if every main branch has it, **open** if some do, a
**shadow** if only shadows do, and **excluded** if none do.

### Form, not author

A papal act's tier follows its form: ex cathedra with all formalities is
tier 1, a formal definitive declaration tier 2, everything else tier 3. The
same is true of curial acts. Approval *in forma specifica*, or a papal mandate,
makes a curial act the pope's own, and that changes its rank in governance.

### Teaching is not governance

A teaching act yields a truth-claim with a grade of assent. A governance act
(legislation, a penalty, a dispensation) yields an obligation or a juridical
effect. **The Code is governance.** It binds to teaching only by reference:
cc. 750 and 752 attach the appropriate assent to whatever is taught at each
tier without teaching anything themselves. Reading a governance act as a truth
source on a doctrinal question is a type error.

This typing has a large consequence. **Lex posterior** (c. 20: the later law
prevails) applies to governance and juridical questions only. Between
equal-tier *teachings* there is no lex posterior. A conflict is an **open
tension** that the system reports and cannot resolve. In more than one case
the whole public dispute turns out to rest on this single typing.

### Tier 3 has internal structure

- **In governance**, legislators are ranked: pope (or council with pope),
  dicastery, conference, diocesan bishop (c. 135 §2). A later act prevails
  only if its author is not lower, and a lower act against a higher one is
  invalid.
- **In teaching**, LG 25's criteria apply: the character of the document,
  frequent repetition, and the manner of speaking. Constitutions and
  encyclicals weigh more than letters and addresses. An interview is not a
  magisterial act at all: it weighs nothing and cannot cleave. A citation adds
  no independent weight, but a re-teaching by a later pope does.
- **Custom** (cc. 23–28) is its own juridical channel, with its 30- and
  100-year rules and its limits against divine law.
- **Salience**, meaning what people actually cite, is tracked only to raise
  warnings. It never changes a verdict, and the suite checks that it does not.

### Things the checker refuses to assume

- **That a teaching is "taught by the ordinary and universal magisterium."**
  Unless a tier-1 act says so, this is an assumption, and the checker computes
  both ways.
- **That a text has one reading.** An ambiguous text is entered with its
  readings, and each becomes a branch. Interpretations by other sources add
  weight to a reading but never fix it.
- **That a source can fix the force of the tier above it.** That is a
  self-elevation violation.

## 6. How to read a result

A result is a set of branches, each with its assumptions, what cleaves it, and
what would bring it back. Read it in this order:

1. **What is settled?** These values hold in every main branch, given the
   sources in force on the evaluation date.
2. **What is open, and on what does it turn?** Usually one or two
   assumptions: the reading of a text, the kind of a question, the force of a
   tier. The result says which.
3. **What is in shadow, and what would bring it back?** A live shadow names
   the acts whose relaxation would restore it.
4. **What violations appear, and in which branches?** A violation in every
   branch is a problem with the facts. A violation in only some branches is a
   reason to prefer the others.
5. **What does weight prefer?** Report it as a preference only.

## 7. The fix method

When the checker disagrees with a text, there are two possibilities. Either
the checker is wrong, or the text is. The method for deciding, in the spirit
of Lakatos's research programmes, is this:

1. Write the change to the theory that would make the checker agree with
   the text.
2. Rerun the whole suite with that change. It contains dozens of historical
   and contemporary cases.
3. If the change explains the disputed case **and turns nothing else red**,
   it is a candidate improvement. If it buys the case at the price of others,
   the burden shifts to the text.
4. A change made only to silence a failing test, with no warrant independent of
   that test, is a *degenerating shift* and is not adopted.

The best result so far came from this method. The universal reading of A9
silently excluded a school the magisterium protects (limbo). The fix came from
rereading the axiom's own warrant (MD 25: "called to be"), and it changed
nothing else in the suite ([Findings §3](findings.md#3-two-axioms-overstated-their-modality)).

## 8. Worked cases

Each case is a set of dated sources and a list of tests. The full tables
are in the Core Edition.

| Case | What the checker shows | Where |
| --- | --- | --- |
| Immaculate Conception, 1400–1860 | Protection kept a minority school alive; weight pointed the wrong way for centuries | Core §9; Findings §2 |
| *De auxiliis* | Two legitimate schools, protected, never cleaved | Core §9 |
| Disparity of cult | A juridical cleave, its dispensation, and the modal error in P3 | Core §9 |
| Infants who die without baptism | The grammar had silently excluded a protected school; the fix came from MD 25 | Core §10 |
| The death penalty | The dispute reduces to two typings: the modal type of *Dignitas infinita* and the tier of DH 795 | Core §11 |
| Communion after remarriage | The dispute reduces to one typing: is the internal-forum norm teaching or governance? | Core §11 |
| Degrees of communion; *extra ecclesiam* | A partial order, not a scale; membership binary, communion graded | Core §13 |
| The 1962 Missal | Governance almost all the way down; what survives *Traditionis custodes* | Core §13 |
| Translation, custom, salience | Tier 3's internal structure | Core §14 |
| Schism and the SSPX, 1988–2026 | Incurred, declared and suspended kept apart; a hidden premise in "confessions invalid" | [cases/sspx-2026.md](cases/sspx-2026.md) |

## 9. Limits

- **The checker enforces context; it does not discover it.** Where a
  violation depends on a fact entered as context (that grace is
  participation, CCC 1997), the result is only as good as that entry.
- **Weight is a vote count, and votes are cheap.** Adding or dropping one
  document can flip a preference. That is why preference is never resolution.
- **Some things are kept as prose and not encoded,** such as the banded
  differentiation of the sexes and the liturgy as nuptial. Others are not
  yet encoded: consent by fraud (c. 1098); supplied jurisdiction (c. 144).
- **The reservation of orders** enters as a given (OS 4), with its nuptial
  meaning as fittingness (*Inter insigniores* 5). Deriving it from the axioms
  would put a fittingness argument in place of the ground the magisterium
  actually gives. See the research report.
- **The framework must not be used to schedule history** (the "Joachim
  clause"). That rule sits outside what any checker can see.

## 10. Taking part

This is an evolving research programme, and it needs people who know the
sources better than its authors do: canonists, dogmatic and moral
theologians, historians, logicians. See [CONTRIBUTING](../CONTRIBUTING.md).
The most useful contributions are a **case** (dated sources and the
questions they answer), a **challenge to an encoding** (this text is
mis-tiered, mis-read or mis-typed), and a **proposed rule change** tested with
the fix method.

## Abbreviations

AAS *Acta Apostolicae Sedis*. CCC *Catechism of the Catholic Church*. DH
Denzinger–Hünermann. DI *Dominus Iesus*. DV *Donum vitae*. ED *Ecclesia
Dei adflicta*. FC *Familiaris consortio*. HV *Humanae vitae*. LG *Lumen
gentium*. MD *Mulieris dignitatem*. OS *Ordinatio sacerdotalis*. ST
*Summa theologiae*. UR *Unitatis redintegratio*.
