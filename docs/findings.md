# Things we found along the way

The checker was built to test one paper, *The Grammar of the Icon*. Running
it on cases the paper never considered turned up things nobody set out to
find, most of them about the paper's own axioms. They are collected here
because they are the best evidence for the method. Each one is
machine-checked, and the test IDs point into the suite.

Some of these findings correct the theory, some confirm a magisterial text
the checker was not built to fit, and some are about the method itself. None
is a verdict on a disputed question. Where a finding touches a contested
matter, what is reported is the *structure* of the dispute, not who is right.

---

## 1. Univocity of mode, and what it costs

*Tests S3, S4, AN2, AN3, UN1–UN3.*

The analogy layer (A11) lets a form be shared by God and creatures only
through a declared **bridge**. A bridge takes God as the primary analogate
(*per prius et posterius*, ST I q.13 a.6) and states a **mode** on each side.
The grain of origination (A3: a term has at most one principle) is one such
form. Its mode is *necessity* in God and *norm* in creatures.

Collapse the two modes into one, which is *univocity of mode*, and the checker
shows the price at once:

- **Univocal necessity (UN1).** An existing child conceived outside a valid
  marriage is reported as *incoherent*, a metaphysical impossibility. The
  theory now contradicts a plain fact.
- **Univocal norm (UN2).** Where the Trinity's grain is tested, the unity of
  the Spirit's principle becomes something God *ought* to keep. The checker
  flags a deontic mode landing on God (`deontic_in_god`).
- **Univocal principle-licensing (S3, S4).** If "two as one principle" must
  mean the same thing in God and creatures (a closed circuit), the Spirit has
  two principles. The only rescue puts a nuptial circuit between Father and
  Son. This is the over-sexualized Trinity that the original paper itself
  names as a failure mode, and it can no longer be reached silently.

Under analogy (UN3) the same facts give a *norm breach* in creatures and
nothing impossible anywhere.

**What this does and does not say about Scotus.** Two theses should be kept
apart:

- *Univocity of concept.* One concept of being is said of God and creatures
  in the same sense, and is contracted by intrinsic modes, infinite and
  finite. This is Scotus's thesis (*Ordinatio* I d.3 p.1 qq.1–3; on intrinsic
  modes, I d.8 p.1 q.3).
- *Univocity of mode.* A shared form applies on both sides *in the same mode*.

The switches above implement the second, and the costs fall on it. The
checker's own bridge, one shared form with a mode on each side and God
primary, is formally compatible with the first. A Scotist can read it as a
common concept with intrinsic modes; a Thomist, as an analogical name. So
these results cannot be cited against Scotus himself. They count against the
step, often attributed to him in the Radical Orthodoxy literature (Milbank,
Pickstock), from univocity of *concept* to univocity of *mode*, a step Scotist
scholars (Cross 2001; Horan 2014) deny he took. The checker cannot tell
analogy and Scotist univocity apart. It *can* tell both apart from univocity
of mode, and that is exactly the distinction the polemic tends to blur.

**The original error, found the other way round.** The paper's P3 said that
filiation "cannot have two" principles. Run on the disparity-of-cult case
(B7), the main branch showed a grain violation at a real child. Read
descriptively, P3 is falsified by every child conceived outside a valid
marriage. It holds as a norm on acts and as a necessity only in God. The
univocity switches restore exactly that error, which is how we know the
modes are doing real work.

## 2. Scotus and the Immaculate Conception: weight is not prediction

*Tests B1–B5.*

The Immaculate Conception backtest enters Bernard, Bonaventure and Aquinas
(each later a Doctor) against, and Scotus (never a Doctor) in favour. It adds
Sixtus IV's *Grave nimis* (1483) and Trent's decree on original sin (1546,
DH 1516) as protective acts, Alexander VII's *Sollicitudo* (1661), and
*Ineffabilis Deus* (1854, tier 1).

- Weight, which counts disagreeing sources by tier, favoured "no" from 1400
  until 1661, Doctors included (B1, B2).
- Nothing below tier 1 could cleave the question once it was protected, so
  Scotus's school survived as an open branch for three and a half centuries
  (B2, B3). Without the protective acts, Alexander VII would have turned "no"
  into a shadow in 1661 (B4).
- In 1854 a tier-1 act deleted "no" (B5).

The design therefore *would have kept the defined doctrine alive* through
centuries in which the weight of authority ran against it. Weight states a
preference; it never deletes a branch. This is the empirical case for the
paper's "Joachim clause" (the framework must not be used to schedule
history), and the reason weight is reported but never used to settle an open
question.

## 3. Two axioms overstated their modality

*Tests L1–L4, B7.*

- **P3: "cannot" for "ought not".** See §1.
- **A9: "is" for "is called to be".** The paper's A9 said every human person
  stands in the receptive position toward Christ. On the question of infants
  who die without baptism, this made any person without a welcome to Christ
  an error state. It silently ruled out limbo, a school *Auctorem fidei*
  (1794, DH 2626) protects (L1). The fix came from the axiom's own warrant.
  *Mulieris dignitatem* 25 says each person is the Bride "in that he or she
  accepts" the gift, and that all are *called* to be. Read as MD 25 words it,
  A9 is neutral on the infants question. Every earlier test was unchanged, so
  the fix cost nothing (L2). It also made refusal representable (Jn 1:11;
  CCC 1864), which the universal reading had made ill-formed (L3, L4).

Lesson: every axiom should carry a modal type (*is*, *ought*, *called*,
*held in trust*), and the checker should flag one used outside its type.

## 4. The two trinitarian images fail in opposite ways

*Tests AN9–AN11, T6a–c.*

Lateran IV (DH 806) is encoded as a two-sided test. Any image of the Trinity
must show *licensed* similarity, meaning some specific relation carried over
by a kind bridge. It must also show a *remainder*, meaning something never
carried over.

- **The family** (man, woman, child) keeps the persons and loses both
  processions. It resembles the Trinity only at the supertype "two as one
  principle of a third" (AN9). No bijection preserves origination (T6a,
  Augustine's objection in *De Trinitate* XII, as a theorem).
- **The mind** (*mens, verbum, amor*) keeps both processions under Thomas's
  bridges (ST I q.27 aa.2, 4) and loses all three persons, since word and
  love in us are acts, not subsistents (AN10).
- **The mind's acts treated as persons** give a complete map, which is a
  Lateran IV violation (AN11).

So the images are complementary, not rival. Augustine's psychological image
carries the processions; the *communio personarum* image of *Mulieris
dignitatem* 7 carries persons in communion. Neither is complete, as Lateran IV
requires.

## 5. The force of tier 2 is an assumption, and who may fix it

*Tests B9–B14.*

What kind of force does "definitive" teaching (c. 750 §2) have: truth-force,
like tier 1, or something closer to juridical? The checker refuses to treat
any answer as a premise unless a *strictly higher* tier states it
non-interpretively. LG 25 is tier 1 but is entered as interpretive here,
because Gasser's *relatio* says Vatican I left the extent open. The CDF's 1998
doctrinal commentary is tier 3. Ad Tuendam Fidem is legislation. Treating
either as fixing tier 2's force is a **self-elevation** violation: a source
settling the authority of the tier above it. The checker therefore computes
both readings. A tier-2 cleave produces a *counterfactual shadow* if tier 2
has truth-force and a *live shadow* if it does not.

## 6. Papal acts are tiered by form, and governance is not teaching

*Tests B12–B15, LT5, LT8.*

An act's tier follows its form, not its author: ex cathedra with every
formality is tier 1, a formal definitive declaration tier 2, and every other
papal act tier 3. The Code is governance: the pope as ruler, not as teacher.
It binds to teaching only *by reference*. Cc. 750 and 752 attach divine and
Catholic faith, firm assent or religious submission to whatever is taught at
each tier, without teaching anything themselves (B15). Reading a governance
act as a truth source on a doctrinal question is a type error (B12, LT5). In
the liturgy case the typing of a question even *follows from* the type of its
sources. Only legislation speaks to the lex orandi status of the 1962
Missal, so typing that question as teaching makes both motu proprios
ill-typed (LT5).

## 7. The teaching/governance hinge reverses which way recency points

*Tests DR2, DR3, DR3b, G1–G4.*

On Communion after remarriage, the whole public dispute reduces to one typing:
is the internal-forum norm teaching or governance? As governance, the later act
governs (c. 20), and *Amoris laetitia* prevails (DR2). As teaching, there is
no lex posterior. Repetition across popes counts under LG 25, and
*Sacramentum caritatis* 29's re-teaching of *Familiaris consortio* 84 tips the
preference the other way (DR3b). The tension stays open either way. The
structural fact: **in governance recency wins; in teaching it does not.** The
latest pope does not prevail by being latest; character and repetition do.

## 8. Degree of communion is a partial order, not a scale

*Tests EC1–EC10.*

Entered as sets of bonds (LG 14; UR 3), communities form a lattice. The
Oriental Orthodox (orders and Eucharist, without Chalcedon) and the Lutherans
(Chalcedon, without orders) are incomparable. *Dominus Iesus* 17 nevertheless
ranks the first above the second. Its Church/ecclesial-community line is a
threshold on two bonds, not a measure of overall communion. "Degree of
*membership*" is the type error: membership is binary (*Mystici corporis*),
and communion is graded. Read that way, every text from Florence to the 2007
*Responses* is consistent, including *extra ecclesiam nulla salus* (EC10).
Read Florence's "outside" as non-membership instead, and Vatican II, Pius XII
and the 1949 Holy Office letter all stand against a tier-1 text: the Feeney
position, mechanically (EC7).

## 9. Tier 3 is not flat, and only one result moved

*Tests G1–G4, CU1–CU8, SA1–SA2, DR3b.*

Giving tier 3 internal structure, with legislator rank for governance
(c. 135 §2), document character for teaching (LG 25), custom (cc. 23–28) and
salience (warnings only), changed exactly one earlier result (DR3b). In
governance a papal act outranks every non-papal tier-3 act. A curial act
approved *in forma specifica* or issued by papal mandate is the pope's own,
which is why the 1984 indult held against *Quo primum* (LT1). An interview is
not a magisterial act: it weighs nothing and cannot cleave.

## 10. Schism, the SSPX and the 2026 decree

*Tests SX1–SX23. See [cases/sspx-2026.md](cases/sspx-2026.md).*

"Is the SSPX in schism?" splits into questions of different types:

- The 2026 classification rests on an act of refusal of subjection, a
  schism-type basis. Rejecting *Dignitatis humanae* would have been a
  category error (c. 752 / c. 1365, not c. 751 / c. 1364).
- *Incurred*, *presumed incurred*, *declared* and *suspended* are different
  states. A recourse suspends the declaration, not the penalty.
- **Notoriety proves the act; the hearing exists for the agent.** "The
  process was superfluous" is c. 1717 §1. It dispenses the investigation,
  never the hearing.
- On the facts of record, the 2016 papal grant stands until a competent
  revocation, so absolutions are valid. The note's "invalid" holds for later
  absolutions only if the pope revokes the grant. It holds for marriages
  without delegation, and fails for marriages with it.
- The non-diagnosis rule, derived earlier from the remarriage case, matches
  the Dicastery's own instruction that lay imputability "must be assessed
  case by case".

## 11. Canon law is binary: a correction

The first encoding of the SSPX case put juridical questions into the
theological authority graph: faculties, hearings, declarations. Tier-5
canonists weighed against dicastery notes, and a preference picked a
reading of a papal grant. A practising canonist objected at once, and the
objection was right. Canon law has its own rules of reading. The legislator
interprets authentically (c. 16). Penal laws are read strictly (c. 18).
Canonists' opinion fills a *gap*, and never in a penal case (c. 19). A
lower act cannot defeat a higher one (c. 135 §2). Given the facts and the
norm in force, an effect follows or it does not.

The correction was structural: a separate [canon-law layer](canon-law-layer.md)
of dated yes/no rules, which branches only on disputed facts, disputed
readings without an authentic interpretation, and the internal forum. The
canons form a graph that the checker tests for loops and gaps. Several
results sharpened, and one reversed. The faculty question had been "open,
turning on a reading". Once the rule on who may revoke a papal grant is
applied, it follows. This is the fix method working on the checker itself.
The type system misplaced a whole domain, and a reader who knew the domain
caught it.

## 12. Findings about the method

- **A fixed relation inventory is what makes the grain falsifiable** (S8, S9).
  If new relation types may be added freely, a solver can always reclassify a
  second source, and the minimum number of violations falls to zero. This is
  the reason for axiom A0.
- **The Donum Vitae retrodiction rests on one axiom,** A4a. Closure belongs to
  the conjugal act, not merely to the standing bond (S1, S2). Research found
  it a warrant from before 1987: Pius XII, 29 October 1951 and 19 May 1956;
  HV 14. The derivation is therefore not circular. See
  [research/warrants-and-prior-art.md](research/warrants-and-prior-art.md).
- **Mutation testing keeps the suite honest.** Every rule is deleted in turn,
  and at least one test must turn red. This caught a vacuous test (T2 passed
  when contraction was deleted, because the child then had no origin at all)
  and several blind spots in the authority layer. In the canon-law layer it
  found four untested rules (c. 1387 for the one consecrated, c. 1335 §2,
  c. 976, c. 144), and each now has a test.
- **Non-diagnosis is a type rule.** Imputability is an input slot filled only
  by the internal forum. Any rule that fills it is flagged (DR6, SX9).

## References

- Aquinas, *Summa theologiae* I q.13 aa.5–6; I q.27 aa.2, 4; I q.36 a.4; III q.16.
- Augustine, *De Trinitate* IX–X, XII.
- Duns Scotus, *Ordinatio* I d.3 p.1 qq.1–3; I d.8 p.1 q.3; III d.3 q.1.
- Lateran IV, *Firmiter* and *Damnamus ergo*, DH 800, 806.
- Pius XII, *Mystici corporis* (1943); Holy Office, letter to Abp Cushing (1949).
- John Paul II, *Mulieris dignitatem* (1988) 7, 25; *Familiaris consortio* (1981) 84.
- Benedict XVI, *Sacramentum caritatis* (2007) 29. Francis, *Amoris laetitia* (2016) 305 and n. 351.
- Vatican II, *Lumen gentium* 8, 14–16, 25; *Unitatis redintegratio* 3.
- CDF, *Dominus Iesus* (2000) 17; *Responses to some questions* (2007); doctrinal commentary on the *Professio fidei* (1998).
- R. Cross, "Where Angels Fear to Tread: Duns Scotus and Radical Orthodoxy," *Antonianum* 76 (2001): 7–41.
- D. P. Horan, *Postmodernity and Univocity: A Critical Account of Radical Orthodoxy and John Duns Scotus* (Minneapolis: Fortress, 2014).
- J. Milbank, *Theology and Social Theory* (Oxford: Blackwell, 1990); C. Pickstock, *After Writing* (Oxford: Blackwell, 1998).
- E. Przywara, *Analogia Entis* (1932), tr. J. R. Betz and D. B. Hart (Grand Rapids: Eerdmans, 2014).
- I. Lakatos, "Falsification and the Methodology of Scientific Research Programmes," in *Criticism and the Growth of Knowledge* (Cambridge, 1970).
