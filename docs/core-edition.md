# The Grammar of the Icon — Core Edition

Ora pro me, peccatore · a living document, last revised October 2026. Licensed CC BY 4.0.

*This is the formal statement. For an introduction, start with the [guide for theologians and canonists](guide-for-theologians-and-canonists.md). References below to "the long version" are to the original programmatic statement, “The Grammar of the Icon: A Programmatic Statement”, which this edition condenses and which is not included in this repository.*

## 1. Claim

The grammar is a small typed relational theory: five relations, a dozen axioms, one invariant. It is stated so that its consequences can be computed, and it makes three claims. The doctrine of God, theological anthropology and the Code's marriage law share this one structure. The structure forbids positions real people hold, with warrants from defined teaching. And it derives juridical results it was not built to fit.

It is judged as a research program is judged (Lakatos), with one sharpening: a hit counts as novel only if it was derived before the target was consulted. Everything here is argument from fittingness, not demonstration, and is submitted without reservation to the judgment of the Church. What the long version adds beyond this core is application or rhetoric, and is set aside.

**Prior work.** The gift-and-acceptance reading of consent and bond is settled in the Navarra school (Hervada, Viladrich, Franceschi) and in Burke. A gift rationale for c. 1084 appears in Burke and in the Rota (coram Defilippi, 2003), and a trinitarian ground for the bond in Viladrich, Pastwa and Ouellet. What is claimed here is narrower: those pieces stated as one typed relational theory, with an executable checker.

## 2. Signature

**Sorts.** God (the one source ad extra, outside the order of levels); divine persons; created persons; other creatures, stratified by level; principles, which are single beings or contracted pairs written \[x, y\].

**Relations.** The inventory is fixed in advance (A0). A pole is never a property: it is a position in one of these relations.

| Relation | Reads | Carries the grain? | Encoded as |
| --- | --- | --- | --- |
| E(g, x) | g gives being to x | Yes | being/2 |
| O(p, x) | principle p originates x | Yes | orig/2 |
| D(x, y) | x acts on y | No | acton/2 |
| N(x, y) | x gives itself to y face to face | Only through finite totality (A7) | nupt/2 |
| S(x, y, t) | x and y are jointly ordered to a common term t | No | side\_by\_side/3 |

**Poles.** Rec\_R(x, y) holds iff R(y, x); Don\_R(x, y) holds iff R(x, y). The vocabulary contains no unary pole predicate.

## 3. Axioms

Thirteen axioms carry the whole program. Each warrant is chosen to be independent of the results the axioms are later claimed to retrodict, so that section 6 is not circular.

| # | Axiom | Warrant | Long version |
| --- | --- | --- | --- |
| A0 | The relation types are exactly E, O, D, N, S. A new type needs a warrant independent of the case it would rescue | Stress test: open inventory (section 7) | New |
| A1 | Every creature receives being from God alone, and every creature acts | Esse ab alio; agere sequitur esse; for persons, CCC 366 | P1 |
| A2 | Poles are positions in typed binary relations; there is no unary pole predicate | Definitional | P5 |
| A3 | E and O each give a term at most one source; out-degree is unbounded | Lateran IV, DH 800; the Son from the Father alone | P3 |
| A4 | Two sources form one principle only under a license: identity of power (divine persons) or a closed nuptial circuit (creatures). The licenses are analogous and never interchanged | Lyons II, DH 850; Florence, DH 1300–1302; ST I q.36 a.4 | P7 |
| A4a | Closure belongs to the generating act, the spouses' personal conjugal act, and not merely to the standing bond. The bond is necessary but not sufficient: it confers a right to the act, not to the child | Pius XII, 29 Oct 1951 (AAS 43, 850) and 19 May 1956 (AAS 48, 470–473); HV 14 | P7, made explicit |
| A5 | A person receives a nuptial gift only by their own consent. At origin, consent may be held in trust and ratified later; otherwise no one else can give it | Lk 1:38; ST III q.30 a.1; LG 56; the practice of infant baptism | P6 with correction 3 |
| A6 | A bond is two consents plus capacity for its closing act | Definition of the counter-phase motif | P9 |
| A7 | A counter-phase pair is a closed N-cycle grounded in a bond; a co-phase pair converges on a common term; an act is well-typed only on its own motif | Definitional | P9 |
| A8 | A finite giver gives itself totally to at most one; a divine gift is non-rivalrous | Conceptual: a finite whole given entirely is unavailable to another | New |
| A9 | Every human person stands in the receptive position toward Christ in N | MD 25 | P8, upper bound |
| A10 | Image and dignity are not graded: every person is a full image at every stage and state, and neither origin nor vocation ranks persons | Nicaea (homoousios); the hypostatic union from conception; Col 1:15; LG ch. 5 | P2–P4, P10 |
| A11 | God is not a level. Nothing crosses the Creator–creature line except through a declared bridge, which takes God as the primary analogate and gives a mode on each side. N never holds between divine persons | Lateran IV, DH 806; ST I q.13 a.6; divine simplicity | P12 |

The Trinity (P2) enters as model M1, not as an axiom. Kept as prose and not encoded: P8's banded sexual differentiation and P11 on the liturgy. Dropped: the clause that finite natures cannot generate alone (section 7).

## 4. Theorems

Six results follow from the axioms, and each is machine-checked. Test IDs refer to section 7.

**T1. Unary poles are vacuous.** Under A1 and A9, "receptive," "donative" and "bridal," read as properties, hold of every human person. None can distinguish one person from another. The rule of terms is therefore forced, not stylistic, and the male-as-God / female-as-creature diagram fails as a matter of logic. *Tests T1, T1b.*

**T2. Only a closed circuit can be a principle.** Two creaturely sources of one term satisfy the grain (A3) only if they contract to one principle, and A4 licenses that only for a closed circuit. In the family model the child has exactly one principle: the pair. *Test T2.*

**T3. Total implies unique, for finite givers only.** A8 forbids a finite giver's double total gift (polygamy; a soul given twice) and permits the divine gift to many. *Tests T3a–c.*

**T4. Chastity as motif typing.** Under A7, an act that closes a circuit is well-typed only on a counter-phase pair, and counter-phase must be grounded in a bond. Intensity alone never makes a pair counter-phase. *Test X7.*

**T5. The communicatio idiomatum is a type system.** Concrete subjects take predicates of either nature; abstract nature-terms take only their own. "Christ is a creature" is well-typed but needs qualification (ST III q.16 a.8). The checker classifies seven sentences as Thomas does. *Test T5.*

**T6. Augustine's guard is a theorem.** No bijection from Father, Son, Spirit to man, woman, child preserves origination. A partial map onto the spiration pattern exists only if begetting and spiration are treated as the same act. *Tests T6a–c.*

The Trinity model also confirms P2 mechanically: only the Son is both from another and part of a principle of another (M1).

## 5. Prohibitions

Each forbidden position is written as a candidate rule and added to a clean model. All ten machine-checkable positions produce violations; the eleventh is a meta-rule.

| Forbidden position | Written as | Excluded by | Warrant | Test |
| --- | --- | --- | --- | --- |
| Receiver-as-lesser, in God | whoever originates from another ranks below them | A10 | Nicaea (homoousios) | X1: 3 violations |
| Receiver-as-lesser, in marriage | whoever receives the nuptial gift ranks below the giver | A10 | Gen 1:27 | X2: 2 violations |
| Functionalist personhood | image requires exercised reason | A10 | The hypostatic union from conception | X3: fails at the embryonic Christ |
| Couple-completion imago | the unmarried are half an image | A10 | Col 1:15 | X4: fails at the unmarried Christ |
| Magnitude-ranking of states of life | consecrated life ranks above marriage in self-gift | A10 | LG ch. 5 | X5 |
| Male-as-God / female-as-creature | a unary pole distinguishes man from woman | A2, A9 (T1) | Gen 1:27; MD 25; CCC 239 | X6 |
| The weld | intense love is counter-phase love | A7 | Aelred; David and Jonathan | X7 |
| God as apex of the fractal | God occupies a level | A11 | Divine simplicity; Lateran IV | X8 |
| Grace as stuff | grace is a quantity | A11 sort discipline | CCC 1997 | X9 |
| Passivity as a category of personhood | personal reception is a non-act | A5 | Lk 1:38 | X10 |
| Historical periodization (Joachim) | not expressible | Meta-rule | Joachim's condemnation | Not machine-checkable |

X9 shows a limit worth stating: the violation exists because CCC 1997 is entered as context. The checker enforces the context; it does not discover it. The same holds, less visibly, for X1, where consubstantiality is entered rather than derived.

## 6. Retrodiction record

Seven entries survive, down from twenty-three. None can yet be graded A, because none was derived before its target was consulted; future derivations should be dated first.

| Target | Derived from | Machine check | Grade | Note |
| --- | --- | --- | --- | --- |
| c. 1084: impotence invalidates, sterility does not | A6 | R1 | B | Fertility appears in no rule, so it cannot invalidate |
| c. 1057 §1: no human power supplies consent | A5 | R2 | B | The same rule lets baptismal consent be held in trust; one fact read from two ends |
| c. 1135: equal rights and duties | A6, A10 | Not encoded | B |  |
| FC 19 and c. 1056: total, therefore unique | A8 | T3a | B |  |
| Trent, DH 1641: the whole Christ to each | A8, non-rivalrous clause | T3c | B |  |
| CCC 1617: baptism as nuptial bath | A5 origin case, A9 | M2 | B | The model reports the child's consent as awaiting ratification |
| Donum Vitae II | A3, A4, A4a | S1, S2 | B | Follows from A4a, which is warranted before 1987; DV itself presents II.B as teaching "already stated" |

Grades: A, derived before the target was consulted; B, valid derivation, but the target was known when the axiom was framed; conditional, rests on an axiom without an independent warrant.

**Removed as interpretive:** the adelphopoiesis cup; c. 1134 as the vinculum named for the Spirit; c. 1091; Phil 2:6; the Shema; Ignatius and LG 11; the graft texts on grace; Genesis 3 as a consistency attack; the analogia fidei entry; acedia and Dante.

**Moved to warrants,** because they are inputs, not outputs: MD 25 (A9), CCC 366 (A1), Nicaea (A10), ST I q.45 and LG 56 (A5).

**Not yet encoded:** consent by fraud (c. 1098; VS 78; R. v. Hutchinson, 2014 SCC 19) and PC 5.

## 7. Stress test

All 139 tests pass (36 on the core, 17 on the authority layer, 15 on analogy, 15 on tier-3 structure, 56 on the cases in sections 10, 11, 13 and 15), and deleting any single rule turns at least one test red, so the suite is not passing vacuously. Five findings came out of the run; two of them change the theory.

1. **The Donum Vitae result rests entirely on A4a.** On identical facts, closure-in-the-act yields a grain violation and closure-in-the-bond yields a consistent model (S1, S2). Any disagreement about that result lives in one axiom. Follow-up research found that axiom a pre-1987 warrant (Pius XII, 1951 and 1956; HV 14), so the derivation is not circular.
2. **Two contraction licenses are forced.** With only the circuit license, the Trinity model breaks: the Spirit has two principles (S3). The only rescue puts a nuptial circuit between Father and Son (S4), which is the trinitarian over-sexualization the long version names as a failure mode. A4's two-license structure is not optional.
3. **"Finite natures cannot generate alone" cannot be both true and substantive.** Unrestricted, fission and parthenogenesis violate it; restricted to a band of levels, they still do; restricted to obligately sexual kinds, it holds by definition (S5–S7). The grain holds in every case. The clause is dropped; the grain stays.
4. **A fixed relation inventory is what makes the grain falsifiable.** If new relation types may be added freely, a solver can always reclassify a second source, and the minimum number of violations is zero (S9). With the inventory fixed, it is one (S8). This is why A0 exists.
5. **The suite caught its own vacuous test.** Deleting contraction first left T2 green, because the child then had no recorded origin at all. T2 now requires exactly one principle.

| ID | Setting | Result |
| --- | --- | --- |
| S1 | Married couple; generation without the closing act; closure in the act | Grain violation at the child |
| S2 | Same facts; closure in the standing bond | Consistent |
| S3 | Trinity, circuit license only | Grain violation at the Spirit |
| S4 | Same, rescued with a nuptial circuit inside God | Grain holds; nuptial relation inside God flagged |
| S5 | Fission and parthenogenesis; clause unrestricted | 2 violations; grain holds |
| S6 | Clause restricted to a band of levels | 2 violations; grain holds |
| S7 | Clause restricted to obligately sexual kinds | Consistent, by definition |
| S8 | Type-splitting allowed, inventory fixed | Minimum 1 violation |
| S9 | Type-splitting allowed, inventory open | Minimum 0 violations |

**Mutation check.** Each row deletes one axiom from the core and reruns the whole suite. The authority layer's thirty-five rules, the nine analogy rules and the case rules were mutated the same way, and each was caught.

| Axiom deleted | Tests turned red |
| --- | --- |
| A0 inventory check | S8 |
| A3 grain on O | S1, S8, B7, AN2 (the grain in God is now a separate rule; deleting it turns S3 and AN3 red) |
| A4 contraction | M1, T2, X1, B7, B8, AN4 |
| A5 origin-case trust | T1, L1 (under the default A9, a missing welcome changes who is bridal instead of raising an error) |
| A6 capacity condition | R1 |
| A8 rivalry | T3a, T3b |
| A8 with Christ's gift treated as finite | M1, M3, M5, T3c, AN1 |
| A10 consubstantiality | X1 |
| A11 no nuptial relation inside God | S4 |

## 8. Refutation conditions

The program fails if any of the following occurs. The first four can now be tested by running the suite; the fifth cannot.

1. **Dogmatic collision.** A defined teaching, encoded as a model, produces a violation that no axiom change can remove without breaking another model. The nearest named candidate is the reservation of orders. When encoded, it enters as a given fact (Christ's determination of the sacramental sign, OS 4), with the nuptial in persona Christi meaning as fittingness (Inter Insigniores 5) and a difference of mission, not dignity (OS 3). Deriving it from the axioms would put a fittingness argument in place of the stated ground.
2. **Terms-breakdown.** A model with fully typed relations still yields contradictory verdicts. None appears in the five models.
3. **Retrofit exposure.** A retrodiction fails when rerun without its target among the warrants. Donum Vitae was the live case; it now rests on A4a's pre-1987 warrant.
4. **Degenerating shift.** An axiom is added only to silence a failing test, with no independent warrant. A0 has its warrant from the stress test (S8, S9), and A4a from Pius XII and HV 14.
5. **Joachim event.** The framework is used to schedule history. This stays a standing rule, outside what a checker can see.

## 9. Authority, branches and shadows

Every source carries a tier, a force (truth, juridical or protective) and a date, and every open question splits into branches, one stable model each. Whether a branch is main, a live shadow, a counterfactual shadow, or absent depends only on which sources are in force on the evaluation date.

| Tier | Assent | Examples in the data |
| --- | --- | --- |
| 1 | De fide credenda (c. 750 §1) | Ineffabilis Deus; Trent |
| 2 | Definitive tenenda (c. 750 §2) | an abstract definitive teaching |
| 3 | Religious submission (c. 752); ecclesiastical law | Alexander VII, 1661; c. 1086 |
| 4 | Doctors of the Church | Aquinas, Bonaventure, Bernard, from the year each was declared |
| 5 | Individual theologians | Scotus, Báñez, Molina |

**Rules**

1. A tier-1 truth source deletes contrary branches.
2. A tier-2 truth source cleaves into a shadow whose kind depends on the force of tier 2 (rule 6).
3. A tier-3 or juridical source cleaves into a live shadow, labelled with the sources whose relaxation would bring it back. Relaxing one recomputes the branch with all its downstream consequences.
4. Sources that cannot cleave only weigh. Main branches are ranked by disagreement, tier 3 first, then 4, then 5.
5. A protective act stops sources at or below its tier from cleaving. Only a tier-1 act can cleave a question protected at tier 1.
6. The force of tier 2 is an assumption, not a premise. Only a source of a strictly higher tier, stating it non-interpretively, can fix it. LG 25 is entered as interpretive, because Gasser's relatio says Vatican I left its extent open. The CDF's 1998 commentary is tier 3. Ad Tuendam Fidem, which inserts c. 750 §2, is legislation and so juridical tier 3. Treating either as fixing tier 2 is a self-elevation violation.
7. A non-default value needs a source in force (c. 1058: what no law prohibits is open).

**Papal acts are tiered by form, not by author.** Ex cathedra with all formalities is tier 1, a formal definitive declaration tier 2, and legislative or ordinary acts tier 3. A mismatch between an act's entered tier and its form is a violation.

**Teaching and governance are different output types.** A teaching act yields a truth-claim with a grade of assent. A governance act (legislation, protection, a juridical effect) yields an obligation, and binds to teaching only by reference, never by asserting it. So c. 750 §1, c. 750 §2 and c. 752 attach divine and Catholic faith, firm assent and religious submission to whatever is taught at tiers 1, 2 and 3, without teaching anything themselves. Reading a governance act as a truth source on a doctrinal question is a type error, and the checker flags it (B12). The connection is incorporation by reference: the ruler makes assent obligatory without becoming the author of what is assented to (B15).

| ID | Case | Result |
| --- | --- | --- |
| B1 | Immaculate Conception, as of 1400 | Both schools open; weight prefers "no" |
| B2 | As of 1600 | Both open and protected; Doctors' weight prefers "no" |
| B3 | As of 1850 | Both open; Alexander VII tips the preference to "yes" |
| B4 | As of 1850, protective acts removed | "No" becomes a live shadow of Alexander VII |
| B5 | As of 1860 | Ineffabilis Deus deletes "no"; "yes" settled |
| B6 | De auxiliis, 1607 to now | Two legitimate schools, no preference |
| B7 | Disparity of cult, law in force | Valid bond survives as a live shadow of c. 1086 |
| B8 | Disparity of cult, dispensed | The shadow returns with its consequences; "impeded" disappears |
| B9 | Tier-2 cleave, force unsettled | Counterfactual shadow if tier 2 is truth-force, live shadow if not |
| B10 | Tier-3 source treated as fixing tier 2 | Self-elevation violation |
| B11 | Hypothetical tier-1 act fixes tier 2 | Only the counterfactual reading remains |

B12–B14 check the form rule. Ad Tuendam Fidem treated as fixing tier 2 fails as self-elevation, and both readings of tier 2 remain. A legislative act entered at tier 1 fails. Every papal act in the data is tiered by its form.

**Findings**

1. **The design would have kept the defined branch alive.** Weight favoured "no" until 1661, Doctors included. Nothing below tier 1 could cleave the question once Trent protected it, so "yes" survived as an open school until 1854. Weight is not prediction: here it pointed the wrong way for centuries, which is the empirical case for the Joachim clause.
2. **Protection is what mattered.** Without the protective acts, Alexander VII would have turned "no" into a live shadow in 1661 (B4).
3. **Downstream checking exposed a modal type error in P3.** In the disparity case, the main branch shows a grain violation at the child, and the reintegrated branch shows one principle. Read descriptively, "filiation cannot have two" principles is falsified by every child conceived outside a valid marriage. It holds as a norm on acts. P3 should be typed as deontic for creatures ("ought not") and ontic only in God. A10 is untouched: no child's image or dignity is graded by how they were conceived.

## 10. Case: infants who die without baptism

Run on an open question it was never built for, the grammar quietly took a side against a protected school, and the fix came from rereading its own warrant. The fix changed nothing elsewhere in the suite and made two other things representable.

Three schools are in play: poena sensus (Augustine), limbo (Aquinas) and the hope of salvation (CCC 1261; ITC 2007). Florence enters as a tier-1 constraint, and Auctorem Fidei protects limbo. One modelling link is mine: a welcome held in trust admits the infant to the bond, as at baptism.

| Source | Tier | Holds |
| --- | --- | --- |
| Florence, Laetentur caeli (1439), DH 1306 | 1 | Dying in original sin alone excludes the beatific vision (constraint) |
| Augustine, Enchiridion 93 | 4 (Doctor from 1298) | Poena sensus |
| Aquinas, De malo q.5 a.3 | 4 (from 1567) | Limbo |
| Pius VI, Auctorem Fidei prop. 26 (1794), DH 2626 | 3, protective | Limbo may not be dismissed as a Pelagian fable |
| CCC 1261 (1992) | 3 | Hope |
| ITC, The Hope of Salvation for Infants Who Die Without Being Baptised (2007) | 4 | Hope; a welcome supplied |

| ID | Run | Result |
| --- | --- | --- |
| L1 | A9 as written | The core flags the limbo and poena sensus branches (reception without act) |
| L2 | A9 as MD 25 words it | No violations; all three schools open; CCC 1261 tips the preference to hope |
| L3 | A refusal, A9 as written | Refusal is ill-formed |
| L4 | A refusal, A9 corrected | Refusal is representable; "called to be bridal" is vacuous, "bridal" is not |

**Findings**

1. **The grammar was excluding a protected school without saying so.** Universal A9 plus A5 make any person without a welcome to Christ an error state. That rules out limbo, which Auctorem Fidei protects. It is the grammarian's usurpation the long version warns against, found mechanically in a case nobody had checked.
2. **The fix came from the warrant itself.** MD 25 says each person is the Bride "in that he or she accepts" Christ's gift, and that all are called "through the Church" to be the Bride. A9 had dropped the condition. Read as MD 25 words it, A9 is neutral on the infants question, and all 51 earlier tests give identical results. That is the fix method's best outcome: a gain with no loss.
3. **Two further gains.** Refusal becomes representable: the closed hand of Jn 1:11 and CCC 1864, which the long version treats as the receptive pole of sin, was ill-formed under universal A9. And T1 shifts: "called to be bridal" is now the vacuous predicate, while actual "bridal" distinguishes persons and stays binary toward Christ.
4. **The same error as P3.** P3 confused "cannot" with "ought not"; A9 confused "is" with "is called to be." Two of the strongest-sounding axioms overstated their modality, and both surfaced only when the checker ran on cases outside the paper. Every axiom should carry a modal type (is, ought, called, held in trust), and the checker should flag one used outside its type.

**Adopted:** the conditional reading of A9 is now the default; the old reading stays available as a switch (a9\_universal).

## 11. Two more cases: the death penalty, and Communion after remarriage

The grammar settles neither question. What it does is reduce each public dispute to one or two type assignments the texts leave open, and show exactly what follows from each. Both runs use A9 as MD 25 words it, now the default, and four new engine rules: ambiguous texts branch by reading; "taught by the ordinary and universal magisterium" is an assumption unless a tier-1 act fixes it; equal-tier conflicts are an open tension for teaching but resolved by the later act for governance (c. 20); and a source that only cites another adds no independent weight.

### The death penalty

| Source | Year | Tier | Entered as |
| --- | --- | --- | --- |
| Innocent III, profession for the Waldensians (DH 795) | 1208 | 3 by form; 2 only if the OUM claim holds | Permitted in principle |
| Roman Catechism | 1566 | 3 | Permitted in principle |
| Evangelium Vitae 56 | 1995 | 3 | Permitted, in cases of absolute necessity |
| CCC 2267, 1997 text | 1997 | 3; withdrawn 2018 | Permitted in principle |
| CCC 2267, 2018 rescript | 2018 | 3 | Ambiguous: "inadmissible because it is an attack on the inviolability and dignity of the person" |
| CDF letter to the bishops | 2018 | 3 | No necessity today; reads 2267 as authentic development, not contradiction |
| Fratelli Tutti | 2020 | 3 | No necessity today (its "no stepping back" is not modelled) |
| Dignitas Infinita | 2024 | 3 | Ambiguous; on its face, a violation of dignity "regardless of the circumstances" |

| ID | Run | Result |
| --- | --- | --- |
| DP1 | As of 2017 | Permitted in principle settled; "intrinsically wrong" a live shadow |
| DP2 | 2019, CCC 2267 read as the CDF reads it | Consistent with every earlier source; no tension |
| DP3 | 2019, CCC 2267 read as intrinsic | Same-tier tension in teaching, unresolvable inside the system |
| DP4 | 2019, reading left open | Weight prefers the CDF's reading |
| DP5 | 2025, Dignitas Infinita on its face | Open tension; no same-tier text offers another reading |
| DP6 | 2025, Dignitas Infinita read circumstantially | Consistent; no tension |
| DP7 | 2025, DI on its face, DH 795 taken as definitive | Tier 2 settles it; DI's face reading becomes a shadow |

1. **The CDF's development claim checks out, on its own reading.** Read circumstantially (no necessity today, given modern detention), the 2018 text is consistent with every earlier source (DP2). Read as intrinsic, it is an equal-tier contradiction in teaching, and teaching has no lex posterior (DP3).
2. **Dignitas Infinita closes that exit.** On its face it is intrinsic, and unlike the 2018 text, no same-tier document offers it a circumstantial reading. The tension is then open (DP5); read circumstantially, it vanishes (DP6).
3. **The dispute reduces to two type assignments:** DI's modal type, and DH 795's tier. If the OUM claim for Innocent III's profession holds, tier 2 settles the question (DP7). No tier-1 act fixes either assignment, so the system keeps all four combinations open.

### Communion after remarriage

| Source | Year | Tier | Entered as |
| --- | --- | --- | --- |
| Trent, Sess. XXIV c. 7 (DH 1807) | 1563 | 1 | The first bond is indissoluble |
| Trent, Sess. XIII c. 11 (DH 1661) | 1551 | 1 | No one conscious of mortal sin to Communion without confession (a constraint on persons) |
| Familiaris Consortio 84 | 1981 | 3; 2 only if the OUM claim holds | Internal forum: only if continent |
| CDF letter (1994); Sacramentum Caritatis 29 (2007) | 1994, 2007 | 3 | Same, citing FC 84 |
| c. 915; PCLT declaration | 1983, 2000 | 3, juridical | External forum: barred if obstinate and manifest |
| Amoris Laetitia 305 and n. 351 | 2016 | 3 | Internal forum: possible in some cases |
| Buenos Aires letter, in the AAS as "authentic Magisterium" | 2016 | 3 | Same, citing AL |

Imputability enters only as an input from the internal forum, under the rule of non-diagnosis. Grave matter is objective, and both schools agree on it.

| ID | Run | Result |
| --- | --- | --- |
| DR1 | Every branch | Indissolubility and c. 915 settled; Trent DH 1661 satisfied everywhere |
| DR2 | Admission norm typed as governance | Amoris governs (c. 20); FC 84 a live shadow |
| DR3 | Typed as teaching | Open tension; independent lineages tie 1 to 1 |
| DR4 | Same, counting every document | FC 84 wins 3 to 2 |
| DR5 | FC 84 taken as definitive | FC 84 settles it; Amoris a shadow |
| DR6 | The checker assigning an interior | Non-diagnosis violation |
| DR7 | Admitting someone discerned as fully culpable | Tier-1 violation (DH 1661) |

1. **What both sides agree on is settled in every branch, Trent included.** DH 1661 binds those conscious of mortal sin, and both schools route admission through diminished imputability, so it is satisfied everywhere (DR1). It breaks only when someone discerned as fully culpable is admitted (DR7).
2. **c. 915 and Amoris never touch.** They govern different forums. The conflict is entirely in the internal forum, and entirely at tier 3.
3. **The whole controversy turns on one typing: is the internal-forum norm teaching or governance?** As governance, the later act governs (DR2). As teaching, the tension stays open (DR3). If the OUM claim for FC 84 holds, it settles the question the other way (DR5). This is the teaching/governance distinction, and it is the hinge.
4. **Counting decides it, if counting is allowed to.** With source independence the lineages tie (DR3). Counting every document, FC 84 wins three to two, though two of the three only cite it (DR4).

### What the cases teach about the engine

1. **Weight is a vote count, and votes are cheap.** Under the intrinsic readings, adding or dropping one document flips the preferred death-penalty branch. For open tensions in teaching, weight should be reported, never used to pick a winner.
2. **Lex posterior is now the most consequential switch in the engine.** Whether it applies, governance yes and teaching no, decides DR2 against DR3. That makes the teaching/governance typing of each question the main thing a user of the checker has to defend.
3. **Non-diagnosis became a type rule.** Imputability is an input slot, and any rule that fills it is flagged (DR6).

## 12. Analogy: the analogia entis as a whitelist

The base relations are now sorted into divine and creaturely, and nothing crosses between them except through a declared bridge. Each bridge takes God as the primary analogate and states the mode on each side, and Lateran IV becomes a two-sided test.

| Bridge | In God (primary analogate) | In creatures (by participation) |
| --- | --- | --- |
| Creation | Being unreceived | Being received: A1, the analogia entis itself |
| Origination | Eternal procession | Temporal generation |
| Principle | Two as one by identity of power | Two as one by a closed circuit |
| Grain | One principle, as a necessity | One principle, as a norm |
| Acyclicity | Necessity | Necessity |

**Rules**

1. **Deny by default.** A rule over a shared form applies to a sort only if a bridge licenses it there. Withdraw the divine side of the origination bridge, and the Trinity model loses its principles while creatures are untouched (AN4).
2. **Per prius et posterius** (ST I q.13 a.6). A bridge with the creature as primary is projection, and is flagged (AN5).
3. **A mode on each side.** A bridge with no mode on one side licenses nothing there (AN12).
4. **Crossing checks.** Creaturely predicates that land on God are flagged at run time (AN6). A static check rejects any rule that mixes divine and creaturely predicates without going through a bridge (AN7, AN8). The incarnate Word is the one exception by construction: the communicatio idiomatum (T5) is the bridge in person.
5. **Lateran IV.** A creaturely model is mapped into the Trinity. It must show licensed similarity, meaning some specific relation is carried over by a kind bridge. It must also show a remainder, meaning some feature is never carried over. A complete map is a violation.

| ID | Run | Result |
| --- | --- | --- |
| AN1 | All models together | No projection, no unlicensed crossing |
| AN2, AN3 | A broken grain in creatures, then in God | Norm breach in creatures; incoherent in God |
| AN4 | Divine side of origination withdrawn | God loses principles; creatures untouched |
| AN5 | Creature as primary analogate | Projection flagged |
| AN6 | Divine persons treated as finite | Crossing flagged |
| AN7, AN8 | Static check, then an injected univocal rule | Clean; then flagged |
| AN9 | Lateran IV: the family | Persons kept, both processions lost; resembles only at the supertype |
| AN10 | Lateran IV: the mind (word and love) | Both processions kept; all three persons lost |
| AN11 | The mind's acts treated as persons | Complete map: Lateran IV violation |
| AN12 | A bridge missing one mode | Flagged on that side only |
| UN1 | Univocal mode (necessity), disparity case | An existing child reported as impossible |
| UN2 | Univocal mode (norm), Trinity under one license | A norm laid on God: flagged |
| UN3 | Analogical modes, same settings | A norm breach in creatures; nothing impossible |

**Findings**

1. **The P3 error can no longer be made silently.** The grain is one shared form with two modes, so the same rule reports a broken grain as incoherent in God and as a norm breach in creatures (AN2, AN3). Make the mode univocal and four tests fail.
2. **The two classic images fail in opposite ways.** The family keeps the persons and loses both processions; it resembles the Trinity only at the supertype, two as one principle of a third (AN9). The mind keeps both processions under Thomas's licensed bridges and loses all three persons, since word and love in us are acts, not subsistents (AN10).
3. **So the images are complementary, not rival.** What one lacks, the other has, and neither is complete, as Lateran IV requires. This reconciles Augustine's psychological image with the communio personarum image of Mulieris Dignitatem 7: the communion image carries the persons in communion, and it was never a map of the processions.
4. **Univocity of mode is now a switch, and its cost is visible.** One mode on both sides either declares an existing child impossible (UN1) or lays a norm on God (UN2). The bridge itself, one form with a mode on each side and God primary, is compatible with Scotus's univocity of *concept* with intrinsic modes. What fails is univocity of *mode*. See [Findings §1](findings.md#1-univocity-of-mode-and-what-it-costs).
5. **The paper's own corollary is now a test.** Treat the mind's acts as persons, and the map becomes complete, which is a Lateran IV violation (AN11). This is the long version's "not a resident trinity," enforced.

**Next step:** give each bridge and kind bridge a source in the authority graph. Then a tier-1 text could overrule a mode, and the analogia entis would sit inside the analogia fidei by rule, not just by design.

## 13. Cases: degrees of communion, extra ecclesiam, and the old Missal

All three disputes turn on a typing the texts leave open. Ecumenism and *extra ecclesiam* turn on the same one: membership is a binary status, communion a graded relation. Read them that way and every source from Florence to the 2007 CDF Responses is consistent. The liturgical dispute is governance almost all the way down.

### Is "degree of communion" a thing?

Yes, but as a partial order, not a scale. Communion is entered as the set of bonds a community shares with the Catholic Church: baptism, Scripture, the Nicene Creed, Chalcedon, orders, Eucharist, later dogmas, and the Petrine bond (LG 14; UR 3; CCC 815). One community is "above" another only if it has every bond the other has.

| Community | Bonds entered | Result |
| --- | --- | --- |
| Catholic; Eastern Catholic | All eight | Full communion |
| Orthodox | All but later dogmas and the Petrine bond | Imperfect; a Church in DI's sense |
| Oriental Orthodox | No Chalcedon (cf. the 1973 common declaration), later dogmas or Petrine bond | Imperfect; a Church in DI's sense |
| Anglican | Baptism, Scripture, Creed, Chalcedon; orders per Apostolicae Curae | Imperfect; an ecclesial community |
| Lutheran | Baptism, Scripture, Creed, Chalcedon | Imperfect; an ecclesial community |

| ID | Run | Result |
| --- | --- | --- |
| EC1 | The lattice | Orthodox above Anglican and Lutheran; Oriental Orthodox and Lutheran incomparable, yet DI ranks the Oriental Orthodox higher |
| EC2 | Anglican orders, AC at tier 3 | Invalid settled; validity a live shadow |
| EC3 | Same, AC taken as definitive | Same verdict; only the kind of shadow changes |
| EC4 | LG 14 read as graded incorporation | Open tension with Mystici Corporis |
| EC5 | LG 14, reading left open | Binary membership plus graded communion preferred |
| EC6 | LG 8, reading left open | The CDF's identity reading of subsistit preferred |
| EC7 | Florence, "outside" as non-membership | Vatican II, Pius XII and the 1949 letter all stand against tier 1 |
| EC8 | Florence, "outside" as having no bond | Consistent with every later source |
| EC9 | Florence, reading left open | The 1949 letter's reading preferred |
| EC10 | The coherent typing | No tension anywhere |

1. **The bond list and Dominus Iesus order communities differently.** Under UR 3's list, the Oriental Orthodox (orders and Eucharist, without Chalcedon) and the Lutherans (Chalcedon, without orders) are incomparable. DI 17's "closest bonds" ranks the first above the second. So "degree of communion" in the singular hides a choice of ordering, and DI's Church/community line is a threshold on two bonds, not a measure of overall communion.
2. **"Degree of membership" is the type error.** Mystici Corporis treats membership as binary. LG 14's "fully incorporated" read as graded membership contradicts it (EC4). Read as "members" plus a separate relation of being "joined" (LG 15), it does not (EC5). Degree belongs to communion, not to membership.
3. **Extra ecclesiam turns on the same typing.** If "outside" in Florence (DH 1351) means non-membership, a tier-1 text excludes salvation for non-members, and Mystici Corporis 103, the 1949 Holy Office letter, LG 16, UR 3 and CCC 847 all stand against tier 1 (EC7). That is the Feeney position, mechanically. If "outside" means having no bond of communion or desire, everything is consistent (EC8), and the 1949 letter's reading is preferred (EC9). The 1949 letter is tier 3 interpreting tier 1, so it weighs; it cannot fix the reading.
4. **Anglican orders show what a tier assignment does and does not do.** The CDF's 1998 commentary lists AC as tier 2, but that list is tier 3, so AC's tier stays an assumption. The verdict is the same either way (EC2, EC3). What changes is whether a future reassessment could bring validity back (live shadow) or not (counterfactual shadow).

### The old Missal

| Source | Year | Type | Entered as |
| --- | --- | --- | --- |
| Quo Primum | 1570 | Legislation, with a perpetuity clause | Use unrestricted |
| Quattuor abhinc annos (CDW indult) | 1984 | Governance | Needs the bishop |
| Summorum Pontificum | 2007 | Legislation | Use unrestricted; "never abrogated"; extraordinary expression of the lex orandi |
| Benedict XVI, covering letter | 2007 | Teaching form, tier 3 | May not be entirely forbidden |
| Traditionis Custodes | 2021 | Legislation; abrogates prior norms | Needs the bishop; the new books the "unique expression" of the lex orandi |
| Archbishop Roche, letter to Cardinal Nichols | 2021 | "Of a personal nature," tier 5 | Abrogated by Paul VI |

| ID | Run | Result |
| --- | --- | --- |
| LT1–LT3 | As of 1990, 2010, now | The later act governs each time (c. 20); the earlier is a live shadow |
| LT4 | Was the Missal abrogated in 1970? | "Never abrogated" stands: the legislator's reading (c. 16), TC silent, a personal letter cannot cleave it |
| LT5 | Lex orandi status typed as teaching | Ill-typed: both texts are legislation |
| LT6 | Typed as governance | TC governs; Benedict's teaching-form claim untouched |
| LT7 | Quo Primum's perpetuity read as binding successors | Violation: par in parem non habet imperium |
| LT8 | A hypothetical total ban | Governance cannot answer a teaching-form question |

1. **The type of a question can follow from the type of its sources.** Only legislation speaks to the lex orandi status, so typing that question as teaching makes both motu proprios ill-typed (LT5). The checker settles the typing by well-formedness, which no earlier case did.
2. **On governance, the later act governs every time,** and nothing else is needed (LT1–LT3). Quo Primum's perpetuity clause cannot bind a successor (LT7).
3. **Two claims survive Traditionis Custodes untouched.** TC does not say the 1962 Missal was abrogated in 1970, so SP's "never abrogated" stands as the legislator's own reading (LT4). And Benedict's claim that the old rite may not be entirely forbidden is in teaching form, which TC does not contradict, since it requires the bishop's authorization rather than forbidding (LT6).
4. **Where the real limit sits.** A future total ban would be a governance act answering a question Benedict put in teaching form, and the checker flags it (LT8). Settling that question would take a teaching act, not a law.

## 14. Tier 3 is not flat

Tier 3 now has internal structure: a legislator ranking for governance, document character and repetition for teaching (LG 25), custom as its own juridical channel, and salience as a layer that warns but never decides. Applied to every earlier case, it changed exactly one result.

**Rules**

1. **Governance: lex superior before lex posterior.** The pope (or a council with the pope) outranks a dicastery, which outranks a conference, which outranks a diocesan bishop (c. 331; c. 135 §2). A later act prevails only if its legislator is not lower, and a lower act issued against a higher one is invalid. Form, not author: approval *in forma specifica*, or a papal mandate, makes a curial act the pope's own.
2. **Teaching: character and repetition (LG 25).** Constitutions and encyclicals weigh 3; exhortations, declarations, instructions and catechisms 2; letters, addresses and notifications 1. Interviews weigh 0 and are not magisterial acts, so they cannot cleave. A reaffirmation by a new papal act adds weight; a citation does not.
3. **Custom (cc. 23–28).** A custom gains force of law when it is reasonable, approved, and kept by a capable community for 30 years, or 100 against a law that forbids customs. It never gains force against divine law. A later law revokes a custom unless the custom is centenary and the law does not mention it expressly.
4. **Salience: what people actually cite.** It raises a warning when an argument leans on a high-salience, low-character source. The checker verifies that verdicts are identical with and without it (SA2).

| ID | Run | Result |
| --- | --- | --- |
| G1 | Magnum Principium (2017) against Liturgiam Authenticam (2001) | The papal law governs; Cardinal Sarah's commentary cannot cleave it, and Francis's letter of 15 October 2017 confirms the reading |
| G2 | A hypothetical later curial instruction contrary to the papal law | Invalid: lex superior beats lex posterior |
| G3 | The same instruction, approved *in forma specifica* | Now the pope's own act, so the later act governs |
| G4 | A conference decree contrary to universal law | Invalid |
| CU1–CU8, CU5b | Custom at 29 and 30 years; against divine law; reprobated; against a law forbidding customs at 51 and at 100 years; revoked by a later law; centenary, with and without express mention | Each follows cc. 23–28 |
| SA1 | An interview against an encyclical | The encyclical settles it; the interview adds no weight |
| SA2 | Salience marks added | Warned; verdicts identical |
| DR3b | Remarriage typed as teaching, LG 25 weight | Still open; the preference moves to FC 84, 3 to 4 |

**Findings**

1. **Only one earlier result moved.** Sacramentum Caritatis 29 is Benedict XVI re-teaching Familiaris Consortio 84, a new act that counts as repetition under LG 25. The Buenos Aires letter re-teaches Amoris Laetitia, but as a letter it weighs 1. So the side holding FC 84's line now weighs 4 against 3. The tension stays open: weight states a preference, never a resolution.
2. **The two typings now pull in opposite directions in time.** Typed as governance, the later act governs (DR2). Typed as teaching, repetition across popes favours the older line (DR3b). The teaching/governance hinge does not just change the mechanism; it reverses which side recency favours. That is a structural fact about the two kinds of authority, not a verdict on the question.
3. **The intuition that the latest pope prevails holds for governance and fails for teaching.** In governance, a papal act outranks every non-papal tier-3 act, and only a later papal act can displace it. In teaching, the latest pope does not prevail by being latest; character and repetition do.
4. **The 1984 indult held because it was the pope's concession.** Remove the papal-mandate rule and Quo Primum outranks the curial indult, flipping the 1990 result (LT1). Form, not office, decided the question again.

## 15. Case: schism and the SSPX

"Is the SSPX in schism?" is several questions of different types, and the checker separates them. The full write-up, with sources, is in [cases/sspx-2026.md](cases/sspx-2026.md).

| ID | Run | Result |
| --- | --- | --- |
| SX1–SX3 | 1988 to 2010 | The 1988 act schismatic (ED 3); excommunication incurred in the external forum, remitted in 2009 |
| SX4, SX5 | As of 2018 | Faculties for confession and marriage by papal grant; no canonical status; above the Orthodox in the lattice, but a different sort |
| SX6, SX7 | "Is the Society in schism?", 2018 | Open; every "no" is an interview, so a lone tier-5 thesis tips the preference |
| SX8 | Schism classified on the basis of rejecting *Dignitatis humanae* | Category error: c. 752, not c. 751 |
| SX9 | Adherence inferred from attendance | Non-diagnosis violation; the Dicastery's return procedure states the same rule |
| SX10 | 2026 | The act and the Society's schism settled; the basis is the act, so no category error |
| SX11–SX14 | Incurred, declared, suspended | Presumed incurred (c. 1321 §4); the declaration suspended by the recourse (c. 1353); effective once decided; no recourse if papally approved (c. 333 §3); nothing reaches back before the act |
| SX15, SX16 | Confessions and marriages | Open; "invalid" goes through only if the 2016–17 grants are read as conditioned; no priest is declared |
| SX17, SX18 | The note read as a collective declaration; notoriety in place of a hearing | Violations |
| SX19 | The lattice now | 2026 removed exactly the 2016–17 bonds; the Society's sort is unchanged |

**Findings**

1. **Incurred, presumed, declared and suspended are four states, not one.** A recourse suspends the declaration, not the penalty incurred by law.
2. **Notoriety proves the act; the hearing exists for the agent.** The defence a hearing would test (necessity, cc. 1323–1324) is about the person, not the public fact.
3. **The 2026 classification is well-typed.** It rests on an act of refusal of subjection, not on dissent from conciliar teaching.
4. **"Confessions are invalid" has a hidden premise.** No priest is declared, so the censure route is closed. The claim goes through only if the papal grants are read as conditioned on the Society's earlier standing, and only a papal act can fix that reading.

## 16. Running it, and status

The rule base is six answer-set programs in `src/theological_type_checker/lp/`: `icon_core.lp` (the axioms), `icon_analogy.lp` (the bridges), `icon_models.lp` (the domain models), `icon_tests.lp` (candidate rules and policy switches), `icon_authority.lp` (the branch layer) and `icon_history.lp` (the cases). Install with `pip install -e .`, then run `ttc-suite`. The same files always give the same report. To check a new proposal, use `ttc-check` with a file of facts, or drive the checker from a language model through the MCP server (`ttc-mcp`); to test a change to the theory against every case at once, use the server's `fix_method` tool.

The engine is fully deterministic; the encoding is not. Deciding that marriage is a nuptial circuit, or that a given act closes one, is interpretation done by a person, just as encoding a statute is. What the checker adds is that every such decision becomes a visible fact someone can dispute. The branch layer, the rescue search and the Augustine map use answer-set search rather than plain Datalog; the rest is stratified Datalog and could be ported to another engine such as Soufflé with modest changes.

Everything here remains argument from fittingness, submitted without reservation to the judgment of the Church. The checker can show that a proposal is ill-formed in this grammar. It cannot show that a well-formed proposal is true; that judgment belongs to Scripture, Tradition and the magisterium (Dei Verbum 10).
