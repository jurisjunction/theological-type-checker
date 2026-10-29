# TTC-RERUM(7)

## NAME

**ttc-rerum**: things by their causes, of which no part is a cause and
no cause a thing; God no cause among the four; the word between the thing
and the argument, and the direction of the measure; a natural question
as a joint work, its conflicts reserved; the schools' readings of the
ideas, of prime matter, of where knowing ends and of who measures whom,
as alleles; Plato and Aristotle merged, and Ockham heard. Predictions,
committed before encoding.

> *Felix qui potuit rerum cognoscere causas* (Virgil, *Georgics* II.490).

## DESCRIPTION

Read as the rules stand at `e739a5b` (`main`, TTC-PENDET merged):

- **Causes are typed on arguments, never on things.** `causae.l` types
  an argument by the causes it rests on (`argues_from/3`) and a horizon
  by the causes it holds. Nothing says what the material, formal,
  efficient or final cause of a thing is. So the base can compute which
  horizons follow "soap is for cleaning" from soap's own end, but not that
  the end is in the soap whether or not a horizon holds it: that a trace
  changes the description and not the world has no slot.
- **God as the origin of a creature passes.** `gen(A, god, peter)` gives
  `principle_of(peter, god)` and nothing faults. That is the emanation
  *Dei Filius* anathematizes (can. 1.4, DH 3024). Its cann. 1.2 and 1.3
  (DH 3022–3023), "praeter materiam nihil esse" and "unam eandemque esse
  Dei et rerum omnium substantiam", are not in the base either, nor is
  the creed's "per quem omnia facta sunt" (DH 150) as a relation.
- **No slot holds a cause in the intellect.** The domain `reason` is
  practical reason (the form of the law). A cause in the thing (*in re*)
  and the same cause known (*post rem*) cannot be told apart, nor the
  concept typed as that by which a thing is known (*quo*) rather than
  what is known (*quod*, I q. 85 a. 2).
- **A question of natural philosophy has no kind.** Whether a thing acts
  for an end is answered by no tier and by no finding. The property case
  enters such questions as doctrinal at tier 5. Mixed cases are split by
  question already (`galileo`: empirical and governance; `beginning`:
  doctrinal and empirical), but nothing joins the parts, and a claimed
  conflict between a definition and a finding has no form.
- **Division is the only method.** A finding that splits one total by a
  scheme (an energy decomposition) cannot be entered, nor a simulation as
  a finding's method. A measure that names an end with a word for force
  is refused (TTC-MODERNITY CV5) even where the word only renders the end.
- **The ideas, prime matter, the terminus and the measure of knowing are
  no loci.** Plato and Aristotle are no runtimes; the nominalist reading
  has no allele (TTC-LOCI: "no allele yet").

The discussion that found this: an essay on soap that begins from its
end, to clean, and divides it into causes, not parts; the four causes as
explanations that are in the intellect as divided and in the thing as
principles; God's causing of another kind than the four; the logoi in
the Word, received according to the mode of the receiver; the
reconciliation of Plato, Aristotle and the nominalists by level; and
two magisteria, the pastoral chair and the masters' (Thomas,
*Quodl.* III q. 4 a. 1 ad 3), with the sciences as a third line.

The proposal:

- **The deposit.** No origin from God of a creature (DH 3024). God no
  cause among the four of a thing (DH 3023–3024; I q. 3 a. 8). Nothing but
  matter refused (DH 3022). Made through the Word, never through a
  creature (DH 150). Nothing subsists apart, neither God nor creature
  (DH 800).
- **Things by their causes.** `cause_of/3` in the kernel; a form typed as
  a thing refused (I q. 45 a. 4); becoming, not being, from a creature
  (I q. 104 a. 1); art through nature (III q. 75 a. 6 ad 1); the
  direction of the measure (*De veritate* q. 1 a. 2); the exemplar.
- **The edge from thing to argument**, directed, through the word: a
  cause in the thing, conceived under a word, signified by a form, on
  which an argument's premise rests. Where a horizon cannot hold the
  cause, the thing keeps it.
- **The intellect.** Knower kinds, never persons (rule 3). Where knowing
  ends. Praise through a knower (GS 14), with no rule that creation's
  praise needs one (CCC 2416).
- **Four loci** in `schools.l`, and three runtimes: `plato`, `aristotle`,
  and `concordia`, their merge.
- **The natural kind and the joint question.** A natural question is
  answered by availability in a horizon, never by a tier or a finding; it
  may be composed of parts, each with its own kind, and *Dei Filius* ch. 4
  is the policy of the composition. A claimed conflict between a finding
  and a definition branches on DH 3017's two diagnoses and is reported as
  reserved, never resolved. A definition's sense is not re-read by a
  finding (can. 4.3).
- **Decomposition and the oracle.** Terms of a scheme, never parts and
  never causes. A simulation as a finding's method.
- **A rendering is not a conversion.** A word for force that carries an
  end by analogy renders it.

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited.

## THE TEXTS

The evidence record is `docs/research/rerum-sources.md`. [V] verified
against a fetched text in this pass; [S] through a named secondary
source; [M] from memory or a standard citation, owed in print. The loci
that decide the encoding:

| Text | Holds | Locus |
| --- | --- | --- |
| *Dei Filius*, canons on God the creator | "praeter materiam nihil esse"; "unam eandemque esse Dei et rerum omnium substantiam vel essentiam"; "e divina substantia emanasse"; "Deum esse ens universale seu indefinitum, quod sese determinando constituat rerum universitatem" | cann. 1.2–1.4, DH 3022–3024 [V] |
| *Dei Filius*, ch. 4 | "duplicem esse ordinem cognitionis"; "nulla tamen umquam inter fidem et rationem vera dissensio esse potest"; "Inanis autem huius contradictionis species inde potissimum oritur, quod vel fidei dogmata ad mentem Ecclesiae intellecta et exposita non fuerint, vel opinionum commenta pro rationis effatis habeantur"; the disciplines "in suo quaeque ambitu propriis utantur principiis et propria methodo" | DH 3015–3019 [V text; DH numbers M] |
| *Dei Filius*, canons on faith and reason | the sciences' assertions contrary to revealed doctrine not to be held true; no dogma given another sense "secundum progressum scientiae" | cann. 4.2–4.3 [V] |
| The creed | "genitum, non factum ... per quem omnia facta sunt" | DH 150 [V; the clause beside the DH number M] |
| Lateran IV | "unum universorum principium; Creator omnium visibilium et invisibilium" | DH 800 [V, through Thomas's lemma; the council's word order M] |
| Florence | "Pater et Filius et Spiritus Sanctus non tria principia [sunt] creaturae, sed unum principium" | DH 1331 [V] |
| Thomas, God and the world | "Deus esset anima mundi"; "Deum esse principium formale omnium rerum ... opinio Almarianorum"; David of Dinant "stultissime posuit Deum esse materiam primam" | I q. 3 a. 8 [V] |
| Thomas, the causes from God | "Deus est prima causa exemplaris omnium rerum"; "divina bonitas est finis rerum omnium" | I q. 44 aa. 3–4 [V] |
| Thomas, forms | forms and accidents "non dicuntur entia quasi ipsa sint, sed quia eis aliquid est"; "forms have not being, but composites have being through forms" | I q. 45 a. 4 [V]; I q. 65 a. 4 [V, English] |
| Thomas, matter | "more repugnant that matter should be in act without form, than for accident to be without subject" | I q. 66 a. 1 ad 3 [V, English] |
| Thomas, becoming | "Aedificator enim est causa domus quantum ad eius fieri, non autem directe quantum ad esse eius" | I q. 104 a. 1 [V] |
| Thomas, art | art produces substantial forms "not by its own power, but by the power of natural energies", the forms of bread "by the power of fire baking the matter" | III q. 75 a. 6 ad 1 [V, English] |
| Thomas, the measure | "Res ergo naturalis, inter duos intellectus constituta, secundum adaequationem ad utrumque vera dicitur" | *De veritate* q. 1 a. 2 [V] |
| Thomas, the ideas | Aristotle "improbat opinionem Platonis de ideis, secundum quod ponebat eas per se existentes, non in intellectu"; "plures ideae sunt in mente divina ut intellectae ab ipso", their relations "respectus intellecti a Deo", not real | I q. 15 a. 1 ad 1; a. 2 and ad 4 [V] |
| Thomas, knowing | "species intelligibilis se habet ad intellectum ut quo intelligit intellectus"; "intentio universalitatis, est in intellectu", the nature "non est nisi in singularibus" | I q. 85 a. 2 and ad 2 [V] |
| Thomas, two chairs | "pericula magisterii cathedrae pastoralis", "pericula autem magisterii cathedrae magistralis" | *Quodl.* III q. 4 a. 1 ad 3 [V] |
| Aristotle, causes | "Sed tres in unam veniunt multoties. Quod quidem enim quid est, et quod cuius causa, una est" | *Physics* II.7, 198a24 [V, Moerbeke] |
| Aristotle, parts | "plurimae potestate sunt, ut ipsae partes animalium"; separated, "like matter" | *Metaphysics* VII.16, 1040b5 [V] |
| Aristotle, the god | "its thinking is a thinking on thinking" | *Metaphysics* XII.9 [V, Ross; Bekker M] |
| Gaudium et spes | "elementa mundi materialis in se colligit, ita ut, per ipsum, fastigium suum attingant et ad liberam Creatoris laudem vocem attollant" | GS 14 [V] |
| The Catechism | "by their mere existence they bless him and give him glory" | CCC 2416 [V] |
| Scotus | matter "would have its own proper existence"; God "could create matter existing without form" | *Opus Oxoniense* II d. 12 q. 1 (Vivès 12), through Wolter and Gordon [S] |
| Suárez | matter "habet in se et per se entitatem seu actualitatem existentiae distinctam ab existentia formae"; not naturally without form | *DM* 13 s. 4 nn. 13–14 [V]; by divine power, owed |
| Ockham | the divine ideas are the creatures themselves as known | *Ord.* I d. 35 q. 5 [M, owed: OTh IV] |
| Ockham, signs | "universale est intentio animae nata praedicari de multis"; "nullum universale sit aliqua substantia extra animam exsistens" | *Summa logicae* I cc. 14–15 [V] |
| Bonaventure | "Platoni sermo sapientiae, Aristoteli vero sermo scientiae"; "Uterque autem sermo ... datus est Augustino" | *Christus unus omnium magister* nn. 18–19 [V] |
| Locke | "hath no other immediate object but its own ideas"; the nominal essence "nothing but that abstract idea" a sortal name stands for | *Essay* IV.1; III.3.15 [V] |
| Descartes | "The nature of body consists just in extension" | *Principles* II.4 [V, English] |
| Bacon | "Eam autem legem, ejusque paragraphos, formarum nomine intelligimus" | *Novum Organum* II.2 [V]; II.17 [V, English] |
| Kant | "The understanding doesn't draw its laws from nature, but prescribes them to nature" | *Prolegomena* §36 [V, English] |
| Boethius | Plato's and Aristotle's opinions "in unam quodammodo revocare concordiam" | *In Peri hermeneias*, ed. sec., II [M, owed] |
| Gould | science and religion as non-overlapping magisteria | *Natural History* 106 (2) (1997) 16–22 [V] |
| Chandler | "Interfaces and the driving force of hydrophobic assembly" | *Nature* 437 (2005) 640–647 [V] |
| Energy decomposition | "there is not a unique way to compute quantities related with such intuitive chemical concepts"; "the energy components, which are not uniquely defined" | Andrés et al., *J. Comput. Chem.* 40 (2019); Phipps et al., *Chem. Soc. Rev.* 44 (2015) [V] |
| The law of soap | soap's nonvolatile matter "an alkali salt of fatty acids", "the detergent properties ... due to the alkali-fatty acid compounds" | 21 CFR 701.20(a) [V] |

## THE DESIGN

### The deposit (`kernel_core.l`, a section "Creation and its causes (deposit; TTC-RERUM)")

Each rule reads what the libraries enter or lower, as the last end and
latria do (TTC-LOCI).

- **QD-a. No origin from God of a creature.** `violation(origin_from_god(P,
  X))` where `orig_cr(P, X)` and P is God or a divine person
  (`ind_sort(P, div)`). The Son's begetting and the Spirit's procession
  are `orig_div` and untouched; the nativity's source is Mary (`in_nature`
  hum). DH 3024; the creed's "genitum, non factum" (DH 150).
- **QD-b. God no cause among the four.** `violation(god_among_the_causes(X,
  C, P))` where `cause_of(X, C, P)` and `ind_sort(P, div)`, for every C.
  `cause_of/3` is the four causes of a creature in the order of
  creatures; God's relations to creatures are typed by `being/2` (A1),
  `exemplar_of/2` and `last_end/1`, never by it (DH 3023–3024; I q. 3
  a. 8; I q. 44 aa. 1–4 say God efficient, exemplar and final cause, by
  analogy, through those relations).
- **QD-c. Nothing but matter.** Slot `nothing_but_matter(C)`: the claim C
  that nothing is but matter. `violation(only_matter(C))`, DH 3022. No
  finding is needed; with a finding by division the method rule fires as
  well.
- **QD-d. Per quem.** Slot `made_through(W, X)`: X made through W (Jn 1:3;
  DH 150). `violation(made_through_a_creature(W, X))` where W is no God
  and no divine person. It gives no `being/2`: being has one giver (A1,
  A3), and creation is the one principle's (DH 800).
- **QD-e. Nothing subsists apart.** Slot `subsists(E)`: E claimed to
  subsist of itself. `violation(uncreated_beside_god(E))` where E is
  neither God, a divine person nor a creature: Lateran IV's "creator
  omnium invisibilium et visibilium" (DH 800).

### Causes in things (`kernel_world.l` slots; `kernel_core.l` rules, "Causes in things (kernel; TTC-RERUM)")

- **The slot.** `cause_of(X, C, P)`: P is the C cause of the creature X.
  The sort `cause` moves from `causae.l` to `kernel_world.l`, the lowest
  layer that now uses it; `causae.l` reads it.
- **QT-a. A form is no thing.** `violation(quo_as_quod(X, P))` where
  `cause_of(X, formal, P)` and P is typed a creature (`inanimate`,
  `organism`, `created_person`, `angel`). A form is that by which, never
  that which (I q. 45 a. 4). A material cause typed a creature stands:
  the bronze of the statue is a substance (*Physics* II.3). Whether
  elements remain in act in a compound is a school question and is not
  touched.
- **QT-b. Becoming, not being.** `info(cause_of_becoming(P, X))` where
  `cause_of(X, efficient, P)` and P is a creature. No `being/2` follows;
  a creature entered as giver of being still faults (A1).

### Things by their causes (`rerum.l`, a library)

- **Art through nature.** Sort `making` {accidental, through_nature,
  by_art_alone}. Slot `makes(M, X, K)`. An artifact is what is made
  accidentally (`artifact(X)`); a natural thing is a creature that is no
  artifact (`natural(X)`), soap included, which is made through nature.
  `violation(substance_by_art_alone(M, X))` where `makes(M, X,
  by_art_alone)` and X is natural (III q. 75 a. 6 ad 1).
- **Ends of use.** Slot `end_of_use(X, P)`: P is the end its maker gives
  X.
- **The measure** (*De veritate* q. 1 a. 2). Slot `measures(I, X, P)`: an
  intellect of kind I measures the principle P of X. Under the part
  `things_measure_us`: `violation(projection(X, P))` where I is human,
  X natural, `cause_of(X, C, P)` with C formal or final, and P no end of
  use. Under `mind_prescribes`: `info(prescribed(X, P))` and no violation.
- **The exemplar.** Slot `exemplar_of(E, X)` (I q. 44 a. 3). Read by the
  alleles of the locus `ideas` (below). Slot `exists_without_form(P)`: the
  material principle P claimed in act with no form; read by the locus
  `prime_matter`.
- **The edge.** Slot `about(Q, X)`: the natural question Q is about the
  thing X. A chain runs from a cause in the thing to an argument's
  premise, through the word:

  `cause_of(X, C, P)`, `conceived_as(P, W, human)`, `signifies(F, W, L)`,
  `rests_on_form(A, cd(C, D), F)`, with A an argument on a natural
  question and D `nature` or `will`.

  Derived: `grounded(A, X, P)` where the chain runs and knowing does not
  end in the word (below); `info(traced_in_thing(G, X, C, D))` where a
  chain runs and the horizon G (the run's own, or the VM's guest) does not
  hold (C, D); `info(premise_without_thing(A, cd(C, D)))` for an argument
  on a natural question that argues from (C, D), D `nature` or `will`, with
  no chain; `info(grounded_in_the_word(A, X, E))` where A on a natural
  question about X argues from (formal, god_physics) and an expressed
  allele of `ideas` admits `exemplar_of(E, X)`. Nothing is derived on a
  question that is not natural.

### The intellect (`intellectus.l`, a library)

- **Knower kinds.** Sort `knower` {divine, angelic, human}. Slot
  `conceived_as(P, W, K)`: the principle P is conceived under the word W
  by an intellect of kind K (I q. 84 a. 2). A person in the third place is
  outside the sort (rule 3).
- **Where knowing ends.** The part `knowing_ends_in_things` says the word
  is that by which; the part `ideas_as_objects` says the word is what is
  known: under it, `info(ends_in_the_word(W, P))` for each
  `conceived_as(P, W, human)`, and no `grounded/3` (I q. 85 a. 2; Locke,
  *Essay* IV.1.1).
- **Praise through a knower.** Slot `voiced_through(X, M, T)`: the praise
  of X reaches T through M (GS 14). `info(praise_through(X, M, T))` where
  M is a created person or an angel and T is God or a divine person;
  `violation(mediator_without_intellect(M))` where M is neither. Praise
  that terminates in what is not God is lowered onto `latria_to/1`, where
  the deposit refuses it (`latria_to_creature`, Nicaea II). No rule reads
  the absence of `voiced_through/3` (CCC 2416).

### The loci and the runtimes (`schools.l`)

| Locus | Allele = part | Says | Held by |
| --- | --- | --- | --- |
| `ideas` | `in_the_word` = `ideas_in_the_word` | the exemplars in the divine mind, many "ut intellectae", their relations of reason (I q. 15 a. 2 and ad 4) | `thomist`, `concordia` |
| | `energies` = `ideas_as_energies` | the logoi as uncreated energies | `palamite` |
| | `creatures_known` = `ideas_creatures_known` | the ideas the creatures themselves as known (*Ord.* I d. 35 q. 5) | `ockham_nominal` |
| | `subsisting` = `ideas_subsisting` | the forms subsisting apart | `plato` |
| | `no_exemplar` = `ideas_no_exemplar` | a god who thinks only himself (*Metaphysics* XII.9) | `aristotle` |
| `prime_matter` | `never_without_form` = `matter_never_without_form` | I q. 66 a. 1 ad 3 | `thomist` |
| | `can_be_without_form` = `matter_can_be_without_form` | *Opus Oxoniense* II d. 12 q. 1 | `scotist` |
| `terminus` | `in_the_thing` = `knowing_ends_in_things` | the word that by which | `default` |
| | `in_the_idea` = `ideas_as_objects` | the idea what is known | `descartes`; `locke` expresses it |
| `measure` | `by_things` = `things_measure_us` | things measure our intellect | `default` |
| | `by_the_mind` = `mind_prescribes` | the understanding prescribes to nature | `kant` |

- **What the alleles do.** `ideas_in_the_word`, `ideas_as_energies`,
  `ideas_creatures_known` and `ideas_subsisting` each hold
  `holds_cause(formal, god_physics)`, the exemplar as a cause in God's
  intention for nature. For each natural thing X a natural question is
  about:
  - `in_the_word` and `energies`: an `exemplar_of(E, X)` with E not
    divine is refused (`violation(exemplar_not_divine(E, X))`); with E
    divine, `grounded_in_the_word(A, X, E)` for each argument A on the
    question from (formal, god_physics); under `energies` also
    `info(exemplar_as_energy(E, X))`.
  - `creatures_known`: `info(idea_is_the_creature(X))`, the idea being X
    as known, whatever exemplar is entered.
  - `subsisting`: the Form of X is lowered as `subsists(idea(X))`, where
    QD-e refuses it.
  - `no_exemplar`: `info(no_exemplar(X))`, whatever exemplar is entered.
- **Prime matter.** `matter_never_without_form` gives
  `violation(matter_in_act_without_form(P))` for `exists_without_form(P)`;
  `matter_can_be_without_form` gives `info(matter_without_form_by_power(P))`.
- **New runtimes.** `plato extends default` (+ `ideas_subsisting`);
  `aristotle extends default` (+ `ideas_no_exemplar`); `concordia extends
  plato, aristotle` (+ `ideas_in_the_word`). The parents express two
  alleles at `ideas`; the child carries both and expresses its own
  (TTC-LOCI). Boethius's stated aim: their opinions "in unam quodammodo
  revocare concordiam". Plato's and Aristotle's horizons are default's
  nine cause parts, inherited and not read from the record; the step
  tests the ideas, not their horizons.
- **The VM.** `vm_plato`, `vm_aristotle`, `vm_concordia` are added. Every
  `vm_R` whose R expresses `in_the_word`, `energies`, `creatures_known` or
  `subsisting` gains `guest_holds(formal, god_physics)`. `horizons_all`
  keeps its ten parts.
- **Ockham through the language library.** No merge runtime for the
  nominalist: his word is measured against the schools' (TTC-PENDET's
  `measured_by/3`), which computes the level each is right about. Two
  forms of *idea*, Thomas's (I q. 15; scholastic Latin, `lex_la_schol`,
  `w_idea_divina`) and Ockham's (*Ord.* I d. 35 q. 5; his Latin,
  `lex_la_ockham`, `w_creatura_cognita`), each in its own encoding;
  `analogous(w_creatura_cognita, w_idea_divina, attribution, C)`, the
  divine idea declared prior (I q. 13 a. 6); and Ockham's form taken as
  the measure of Thomas's. The switch `ockham_measure` of `soap`. And
  "nothing but names": slot `nothing_but_names(C, W)`,
  `violation(nothing_but_names(C, W))`, the method rule applied to the
  word divided by tongue (`linguae.l`).

### The natural kind and the joint question (`icon_authority.l`, `empirica.l`)

- **The kind.** The closed sort `question_kind` gains `natural`. No source
  deletes, cleaves or weighs on a natural question: it joins the
  empirical kind in those exemptions, and in none other (no finding fixes
  it; `act_answers_a_fact` stays empirical). A teaching act at tiers 1–3
  supporting a value on one is reported,
  `info(natural_question_taught(S, Q))`: its matter belongs in a
  doctrinal part.
- **Parts.** Slot `part_of(Q1, Q)`: Q1 is a part of the natural question
  Q. `info(joint_part(Q, Q1, K))`, K the part's kind.
  `violation(part_of_no_natural_question(Q1, Q))` where Q is not natural;
  `violation(part_cycle(Q))` where Q is its own part, through any chain.
- **A claimed conflict.** Slot `claims_conflict(C, F, Q1, V)`: the
  claimant C says the finding F conflicts with the value V on the
  doctrinal part Q1. Computed both ways, never preferred, as DH 3017
  divides it: `assumed_fact(misread_dogma(C, Q1))`, the dogma not read
  "ad mentem Ecclesiae", or `assumed_fact(opinion_for_finding(F))`, an
  opinion taken for a finding, on which branch F fixes nothing. Q1's
  values are untouched on both. `info(reserved_to_the_author(Q, F, Q1))`
  in every branch, Q the natural question Q1 is part of.
- **Can. 4.3.** Slot `resenses(F, S, R)`: the finding F claimed to give
  the source S the reading R. `violation(dogma_resensed_by_finding(F, S))`
  where S is in force at tier 1. At tier 0,
  `info(scripture_read_by_finding(F, S, R))` and no violation: a finding
  may exclude a reading of Scripture (TTC-EMPIRICA), never re-read a
  definition.

### Decomposition and the oracle (`empirica.l`)

- Sort `scheme`. Slot `term_of(T, Total, S)`: T is a term of Total under
  the scheme S. `info(scheme_relative(Total))` where two schemes split it.
  `violation(term_as_part(T))` where a term is typed a creature;
  `violation(term_as_cause(T, X))` where `cause_of(X, _, T)`.
- `method(F, simulation)`: a finding by simulation fixes its empirical
  question as any finding does; `info(fixed_by_simulation(Q, V, F))`.

### A rendering is not a conversion (`causae.l`)

- Slot `measure_word(M, W)`: the measure M names the cause by the word W.
  `rendered(M)` where W is analogous to a word and carries a final
  premise (`carries(W, W1, cd(final, D))`). CV5 gains `not rendered(M)`;
  `info(cause_rendered(M, W, W1, K))`. A measure with no `measure_word/2`
  is as before.

### The cases (`icon_history.l`)

Real texts where they exist; every typing is an interpretive fact,
entered and open to dispute. Hypothetical matter only in switches.
`soap` names the Son, so it is loaded with `trinity` in every run below.

- **`soap`.** `soap` (sodium stearate, made through nature by the
  soap-maker), `bar` (made accidentally). Causes: material `fat`, `lye`;
  formal `amphiphilic_form`; efficient `soapmaker`, `lye`; final
  `cleaning` (an end of use) and `interfaces_end` (to gather where water
  and oil meet, by similitude). `exemplar_of(son, soap)`,
  `made_through(son, soap)`. The natural question `q(soap_for_an_end)`,
  about `soap`, with four arguments of the case's text (tier 5, 2026),
  each resting on a form of it:

  | Argument | Argues from | Form, word |
  | --- | --- | --- |
  | `a_maker` | (final, will) | *use*, `w_usus` |
  | `a_nature` | (final, nature), (formal, nature) | *end*, `w_finis`; *form*, `w_forma` |
  | `a_god` | (final, god_physics) | none |
  | `a_logos` | (formal, god_physics) | *idea*, `w_idea_divina` |

  `conceived_as` gives `cleaning` under `w_usus`, `interfaces_end` under
  `w_finis`, `amphiphilic_form` under `w_forma`.
- **`micelle`.** Two empirical questions (micelles form above the
  critical concentration; micellization near room temperature is driven
  chiefly by entropy), each fixed by a finding; the natural question
  `q(stearate_gathers)` with both as parts; two measures of the end as a
  force, `m_render` (with `measure_word(m_render, w_driving_force)`, the
  word analogous to `w_finis` and carrying (final, nature), its claimant
  owed) and `m_convert` (none).
- **`eda`.** The binding of a water dimer, an empirical total fixed by a
  finding by simulation; its terms under two schemes (`sapt`, `almo`);
  the natural question `q(why_dimer_binds)` with the total as its part.
- **`locke_essence`.** Gold, its form, and a natural question about it,
  argued from (formal, nature); Locke's nominal essence as a lexicon
  entry and `horizon_lacks/3` for the real one.
- **Joint switches** of the existing cases: `joint_beginning`
  (`q(world_origin)`, parts `q(world_began)`, `q(universe_expanding)`,
  `q(age_of_universe)`), `joint_galileo` (`q(the_heavens)`, parts
  `q(earth_moves)`, `q(sun_at_rest)`, `q(copernicus_may_be_read)`),
  `joint_one_root` (`q(human_origin)`, part `q(one_root)`),
  `joint_method_being` (`q(what_a_body_is)`, part `q(bodies_of_cells)`).
- **Candidates.** `cand_emanation` (`gen(emanation, god, peter)`);
  `cand_world_soul`, `cand_almarician`, `cand_dinant` (God the form of the
  world, the formal principle of a creature, its matter); `cand_only_matter`;
  `cand_made_through_creature` (the demiurge); `cand_form_as_thing`;
  `cand_art_alone`; `cand_projection` (`measures(human, soap,
  amphiphilic_form)`); `cand_matter_alone`; `cand_design` (God an
  efficient cause among natural ones, and the end measured as a force,
  as a design argument types it); `cand_praise_to_mediator`;
  `cand_term_as_cause`, `cand_term_as_part`; `cand_nothing_but_names`;
  `cand_premise_without_thing` (an argument on a natural question with no
  causes entered); the switch `ockham_measure`; and the HYPOTHETICAL
  switches `natural_taught_hyp` (a tier-1 act supporting
  `q(soap_for_an_end)`), `conflict_hyp` (a
  finding claimed to conflict with `q(one_root)`, with `joint_one_root`)
  and `resense_hyp` (a finding claimed to re-read DH 800's "ab initio
  temporis", with `beginning`; Bradley's finding as re-reading Josh
  10:12–13 by appearances, with `galileo`).

## PREDICTIONS

Runtimes: the 42 at `e739a5b` and the three new, 45. "Every runtime"
means all 45, each alone with the parts named. `soap` runs with
`trinity`.

### QD: the deposit

- **QD1.** `cand_emanation` with `world` gives
  `violation(origin_from_god(god, peter))` on every runtime. M1, the
  creed's parts (CR group) and every boot-set scenario give the same
  atoms as before, in every model.
- **QD2.** `cand_world_soul`, `cand_almarician` and `cand_dinant` each give
  `god_among_the_causes(X, C, god)` for their one fact, on every runtime;
  `cause_of(peter, efficient, son)` with `trinity` gives it for the Son.
- **QD3.** `cand_only_matter` gives `only_matter/1` on every runtime.
- **QD4.** `soap` with `trinity` gives no violation from
  `made_through(son, soap)`, and the same `being/2` atoms as without it.
  `cand_made_through_creature` gives `made_through_a_creature(demiurge,
  peter)`; with `cand_arian` and without `trinity` (the Son typed a
  creature and not divine), `made_through(son, peter)` gives it for the
  Son.
- **QD5.** On `plato`, `soap` gives `uncreated_beside_god(idea(soap))`, and
  on no other runtime.

### QT: things by their causes

- **QT1.** `cand_form_as_thing` gives `quo_as_quod(soap, P)` on every
  runtime; `soap` alone gives no `quo_as_quod/2`, though `fat` and `lye`,
  material causes, are typed inanimate.
- **QT2.** `soap` gives `cause_of_becoming(soapmaker, soap)` and
  `cause_of_becoming(lye, soap)`, and no `being/2` from either.
- **QT3.** `cand_art_alone` gives `substance_by_art_alone/2` on every
  runtime; `soap`'s two `makes/3` facts give nothing.
- **QT4.** `cand_projection` gives `projection(soap, amphiphilic_form)` on
  the 41 runtimes that express `by_things`; `prescribed(soap,
  amphiphilic_form)` and no violation on `kant`, `kant_humanity`,
  `kant_mm`; nothing on `bare`. `soap`'s end of use measured by a human
  intellect gives nothing anywhere.
- **QT5.** On `soap`, `grounded(a_nature, soap, interfaces_end)`,
  `grounded(a_nature, soap, amphiphilic_form)` and `grounded(a_maker,
  soap, cleaning)` on 37 runtimes: the 27 that express `in_the_thing`,
  the nine that carry both alleles at `terminus` (`hobbes`, `hobbes_wl`,
  `leibniz`, `leibniz_wl`, `kant`, `kant_humanity`, `kant_mm`, `locke_wl`,
  `angers`), and `bare`. On the eight that express `in_the_idea`
  (`descartes`, `descartes_will`, `spinoza`, `spinoza_wl`, `locke`,
  `smith`, `george`, `george_hn`): no `grounded/3`, and
  `ends_in_the_word/2` for each of the three principles.
- **QT6.** `traced_in_thing(here, soap, final, nature)` exactly where
  `ends_in_nature` is not held, and `traced_in_thing(here, soap, formal,
  nature)` exactly where `forms_in_nature` is not:

  | Traced | Runtimes |
  | --- | --- |
  | final and formal | `bacon`, `bare`, `hobbes`, `hobbes_wl`, `kant`, `kant_humanity`, `locke_wl`, `marx`, `marx_social`, and the eight of `in_the_idea` (17) |
  | final only | `grotius`, `grotius_etiamsi`, `ockham`, `ockham_nominal`, `ockham_will`, `scotus_dpp`, `scotus_will`, `suarez_dm23`, `suarez_wl` (9) |
  | formal only | `kant_mm` (1) |
  | nothing | the other 18 |

  `bare`, holding no final cause in the will, also gives
  `traced_in_thing(here, soap, final, will)`, and no other runtime does.
  The thing keeps every cause on every runtime: no `cause_of/3` atom
  differs.
- **QT7.** `cand_premise_without_thing` gives
  `premise_without_thing(A, cd(final, nature))` on every runtime; the
  property case (whose arguments rest on (material, nature) on doctrinal
  questions) gives none.
- **QT8.** Availability on `soap`, by runtime: `a_maker`, `a_god` and
  `a_nature` as the baseline run at `e739a5b` with the case's arguments
  as a snippet: all three on 14 runtimes (`angers`, `default`,
  `episcopate_1891`, `hooker`, `leibniz`, `leibniz_wl`, `lingual`,
  `palamite`, `saussure`, `scotist`, `social_catholic`, `suarezian`,
  `thomist`, `vocal`); `a_maker` and `a_god` on 12 (`bacon`, `george`,
  `george_hn`, `grotius`, `grotius_etiamsi`, `locke`, `locke_wl`,
  `scotus_dpp`, `scotus_will`, `smith`, `suarez_dm23`, `suarez_wl`);
  `a_maker` and `a_nature` on `lassalle`; `a_maker` alone, a sole reason,
  on 14 (`descartes`, `descartes_will`, `hobbes`, `hobbes_wl`, `kant`,
  `kant_humanity`, `kant_mm`, `marx`, `marx_social`, `ockham`,
  `ockham_nominal`, `ockham_will`, `spinoza`, `spinoza_wl`); none on
  `bare`. `plato`, `aristotle` and `concordia` as `default`. And `a_logos`
  exactly on the 14 that express an exemplar allele (QL1).

### QI: the intellect

- **QI1.** `conceived_as(p, w, peter)` gives an `outside_domain` violation
  on its third argument.
- **QI2.** `ends_in_the_word/2` on exactly the eight runtimes of QT5, on
  every case that enters `conceived_as/3`.
- **QI3.** `voiced_through(stone, peter, god)` with `world` gives
  `praise_through(stone, peter, god)` and no violation;
  `cand_praise_to_mediator` (`voiced_through(stone, peter, peter)`) gives
  `latria_to_creature(peter)`; `voiced_through(stone, oak, god)` gives
  `mediator_without_intellect(oak)`. `world` alone gives nothing new.

### QL: the loci and the concord

- **QL1.** The four loci compile, and `runtimes.json` records:

  | Locus | Expressed | Runtimes |
  | --- | --- | --- |
  | `ideas` | `in_the_word` | `thomist`, `hooker`, `episcopate_1891`, `social_catholic`, `locke`, `locke_wl`, `smith`, `angers`, `george`, `george_hn`, `concordia` (11; `concordia` carrying `subsisting` and `no_exemplar`) |
  | | `energies` | `palamite` |
  | | `creatures_known` | `ockham_nominal` |
  | | `subsisting` | `plato` |
  | | `no_exemplar` | `aristotle` |
  | | none | the other 30 |
  | `prime_matter` | `never_without_form` | `thomist`, `hooker`, `episcopate_1891`, `social_catholic`, `angers` (5; `angers` carrying `can_be_without_form`) |
  | | `can_be_without_form` | `scotist` and the 20 that inherit it through `scotus_dpp` (21: `suarez_dm23` and `suarez_wl` through their Scotist parents) |
  | | none, both carried | `locke`, `locke_wl`, `smith`, `george`, `george_hn` |
  | | none | the other 14, `suarezian` among them |
  | `terminus` | `in_the_thing` | 27 |
  | | `in_the_idea` | the eight of QT5, `locke` by `express` |
  | | none, both carried | the nine of QT5 |
  | | none | `bare` |
  | `measure` | `by_things` | 41 |
  | | `by_the_mind` | `kant`, `kant_humanity`, `kant_mm`, carrying `by_things` |
  | | none | `bare` |

  No `re_expressed`.
- **QL2.** `cand_matter_alone` gives `matter_in_act_without_form` on the
  five of `never_without_form`, `matter_without_form_by_power` on the 21
  of `can_be_without_form`, and nothing on the other 19.
- **QL3.** On `soap`:
  - `plato` faults (QD5), and `a_logos` is available there;
  - `aristotle` gives `no_exemplar(soap)`, and `a_logos` is unavailable;
  - `concordia` and the other ten of `in_the_word` give no violation,
    `a_logos` available, and `grounded_in_the_word(a_logos, soap, son)`;
  - `palamite` gives the same and `exemplar_as_energy(son, soap)`;
  - `ockham_nominal` gives `idea_is_the_creature(soap)`, and `a_logos`
    available.
- **QL4.** Ockham measured: `soap` with `ockham_measure` gives, on every
  runtime, `mode(f_idea_th, f_idea_oc, analogical)`,
  `analogy_kind(f_idea_th, f_idea_oc, attribution)`,
  `prius_rei(f_idea_th, f_idea_oc, w_idea_divina)` and
  `prius_nobis(f_idea_th, f_idea_oc, w_creatura_cognita)`: the
  nominalist's word first as to us, the divine idea first as to the
  thing. No `made_from/2` follows and nothing is carried.
  `cand_nothing_but_names` gives `nothing_but_names/2` on every runtime.

### QN: the natural kind and the joint question

- **QN1.** `q(soap_for_an_end)` is open, both values, on every runtime: no
  branch is cleaved and no weight is laid (as EM1 for the empirical kind).
  A HYPOTHETICAL tier-1 source on it gives
  `natural_question_taught/2` and cleaves nothing.
- **QN2.** `joint_beginning`, `joint_galileo`, `joint_one_root`,
  `joint_method_being` each add only `joint_part/3` atoms: every other
  atom of every model of `beginning`, `galileo` (as of 1616, 1633, 1700,
  1730, 1830), `one_root` and `world` with `method_being` is as before,
  CB1–CB2, GL1–GL4, DD2 and MB1 among them.
- **QN3.** `conflict_hyp` gives two branches, one assuming
  `misread_dogma`, one `opinion_for_finding`. `q(one_root)` holds as
  under `one_root` alone on both; the hypothetical finding's question is
  fixed on the first and open on the second;
  `reserved_to_the_author(q(human_origin), f_hyp, q(one_root))` in every
  branch.
- **QN4.** `resense_hyp` gives `dogma_resensed_by_finding(f_hyp_t0,
  lateran_iv_1215)` and `scripture_read_by_finding(bradley_1729,
  josh10_12, by_appearances)`, and no violation for the second.
- **QN5.** A part declared of a doctrinal question, and a part cycle,
  each give their violation.
- **QN6.** The VM reads a natural question as any other:
  `soap` with `vm_bacon` on `thomist` gives no `guest_without_reason`;
  with `vm_descartes`, `guest_sole_reason(soap_t, a_maker, …)`.

### QE: decomposition and the oracle

- **QE1.** `eda` gives `scheme_relative(binding)` and
  `fixed_by_simulation/3` for its total; `cand_term_as_cause` gives
  `term_as_cause/2`, `cand_term_as_part` `term_as_part/1`, on every
  runtime.

### QV: a rendering is not a conversion

- **QV1.** `micelle` gives `cause_rendered(m_render, w_driving_force,
  w_finis, K)` and no violation for `m_render`;
  `cause_converted(m_convert, final, efficient)` on 41 runtimes (the 38
  where CV5 fires at `e739a5b`, `bare` among them, and the three new);
  `conversion_native(m_convert)` on `hobbes`, `hobbes_wl`, `spinoza`,
  `spinoza_wl`, where final causality survives only as desire.
- **QV2.** Adams's measure in the property study is as before.

### QC: the cases

- **QC1.** `cand_design` gives `god_among_the_causes(flagellum, efficient,
  god)` on every runtime, and `cause_converted` where CV5 fires.
- **QC2.** `locke_essence` on `locke`: `ends_in_the_word/2` and
  `traced_in_thing(here, gold, formal, nature)`; on `thomist`, `grounded/3`
  and no trace.

### SU: the suite

- **SU1.** No earlier scenario's atoms change in any model, the boot set
  and every later group, save what is named: test_l's hand-written
  runtimes gain the new parts (`default` and every school
  `knowing_ends_in_things`, `things_measure_us` after default's own;
  `thomist` `ideas_in_the_word`, `matter_never_without_form`; `scotist`
  `matter_can_be_without_form`; `palamite` `ideas_as_energies`), stated
  as restated (rule 7); its closed sorts
  gain `natural` (question_kind), `knower`, `making`; TTC-MODERNITY's SU1,
  pinning the parts that write `argument/4`, admits `soap`, `micelle`,
  `locke_essence`. CL1 and PR4 stay clean.
- **SU2.** Every new rule and slot has a test that fails without it. Both
  copies of the guide gain the vocabulary identically.

### Bets

- QT6 and QT8 rest only on the existing horizons and are expected to hold.
- QL1's inherited rows (Locke expressing the ideas in the Word through
  Hooker; the moderns inheriting Scotus's matter) are the model's
  consequences of the record's DAG, not readings of the figures; they are
  predicted as the compiler will give them.
- QV1's rows are CV5's at `e739a5b` and are expected to hold; the new
  rule only adds `cause_rendered`.
- QL4 rests on `lexicon_read/2` choosing each form's own lexicon where
  its encoding has one; if it branches, the four atoms hold on every
  branch or the prediction is red.
- QN1 is the likeliest to turn something red, since the exemptions it
  joins are spread through the authority graph.

## CAVEATS

- **The checker refuses; it does not affirm.** `grounded/3` says that a
  chain of typed facts runs from a cause in a thing to a premise. It never
  says the concept fits the thing; adequation is not computed.
- **No determinate tier 0.** Tier 0 stays "above tier 1 in authority,
  below it in determinacy". A conflict claimed between a definition and a
  finding is reported as reserved and never resolved. An author's
  readjudication belongs to no run of the public base.
- **Knower kinds, never persons.** The intellect library types the
  powers; what anyone knows is never computed (rule 3).
- **The figures' horizons.** `plato` and `aristotle` take default's nine
  cause parts unread; the step tests the ideas. Leibniz's region of
  eternal truths (*Monadology* 43) and Scotus's and Suárez's ideas are no
  alleles yet.
- **Suárez on matter.** His matter has an existence of its own, distinct
  from the form's, and cannot naturally be without form (*DM* 13 s. 4
  nn. 13–14); whether by divine power it can is owed, so `suarezian`
  holds no allele at `prime_matter`. Scotus's text is reached through
  Wolter and Gordon; the Latin of Vivès 12 is owed.
- **The schools on mixtures.** Whether elements remain in act in a
  compound is not touched: material causes typed as substances stand.
- **"Nothing but" in the other direction** (the roadmap's Left) is not in
  this step.

## SEE ALSO

ttc-modernity(7), ttc-loci(7), ttc-linguae(7), ttc-empirica(7),
ttc-pendet(7), ttc-professio(7).
