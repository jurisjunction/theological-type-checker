# TTC-RERUM(7)

## NAME

**ttc-rerum**: things by their causes, no part of them a cause and no
cause a thing; God neither form nor matter of a thing, nor a second cause
among the causes; the word between the thing and the argument, and the
direction of the measure; a natural question as a joint work, its
conflicts with a definition reserved; the schools' readings of the ideas,
of prime matter, of where knowing ends and of who measures whom, as
alleles; Plato and Aristotle merged, and Ockham measured. Predictions,
committed before encoding.

## DESCRIPTION

Read as the rules stand at `e739a5b` (`main`, TTC-PENDET merged):

- **Causes are typed on arguments, never on things.** `causae.l` types an
  argument by the causes it rests on (`argues_from/3`) and a horizon by
  the causes it holds. Nothing says what the material, formal, efficient
  or final cause of a thing is. So the base can compute which horizons
  follow "soap is for cleaning" from soap's own end, but cannot say that
  the end is in the soap whether or not a horizon holds it: that a trace
  changes the description and not the world has no slot.
- **God as the origin of a creature passes.** `gen(A, god, peter)` gives
  `principle_of(peter, god)` and nothing faults: the emanation *Dei
  Filius* anathematizes (can. 1.4, DH 3024). Its cann. 1.2 and 1.3
  (DH 3022–3023) are not in the base, nor is the creed's "per quem omnia
  facta sunt" (DH 150) as a relation.
- **No slot holds a cause in the intellect.** The domain `reason` is
  practical reason (the form of the law). A cause in the thing and the
  same cause known cannot be told apart, nor the concept typed as that by
  which a thing is known rather than what is known (I q. 85 a. 2).
- **A question of natural philosophy has no kind and no case.** Whether a
  thing acts for an end is settled by no tier and no finding. The
  property case's questions are doctrinal questions of natural law, at
  tiers 3–5. Mixed cases are split by question already (`galileo`:
  empirical and governance; `beginning`: doctrinal and empirical), but
  nothing joins the parts, and a claimed conflict between a definition
  and a finding has no form.
- **Division is the only method read.** `method/2` takes any method, but
  only division is read: nothing reads a simulation, and a total split
  into terms by a scheme (an energy decomposition) cannot be entered. A
  measure that names an end with a word for force is refused (TTC-
  MODERNITY CV5) even where the word only renders the end.
- **The ideas, prime matter, the terminus and the measure of knowing are
  no loci.** Plato and Aristotle are no runtimes; the nominalist reading
  has no place (TTC-LOCI: "no allele yet").

The discussion that found this: an essay on soap that begins from its
end, to clean, and divides it into causes, not parts; the four causes as
explanations that are in the intellect as divided and in the thing as
principles; God's causing of another kind than the four; the logoi in the
Word, received according to the mode of the receiver; Plato, Aristotle
and the nominalists, each right about a level; and two magisteria, the
pastoral chair and the masters' (Thomas, *Quodl.* III q. 4 a. 1 ad 3),
with the sciences as a third line.

The proposal:

- **The deposit.** No origin from God of a creature (DH 3024). God neither
  the formal nor the material cause of a thing (DH 3023–3024; I q. 3
  a. 8). Nothing but matter refused (DH 3022). Made through a divine
  person, never through a creature (DH 150). Nothing subsists apart that
  is neither God nor creature (DH 800).
- **The kernel.** `cause_of/3`, the causes of a creature in the order of
  creatures. A form typed as a thing refused (I q. 45 a. 4), the
  subsisting soul excepted (I q. 75 a. 2; DH 902). God typed as a second
  cause, efficient or final, among the causes of a thing refused (I q. 105
  a. 5; SCG III.70): his efficiency is typed by `being/2` (A1), his end
  by the term lifted above the order of ends (TTC-PENDET).
- **Things by their causes** (`rerum.l`). The maker of the becoming (I
  q. 104 a. 1); art through nature (III q. 75 a. 6 ad 1); the direction
  of the measure (*De veritate* q. 1 a. 2); the exemplar (I q. 44 a. 3);
  and the edge from a cause in a thing, through the word, to an
  argument's premise, with the trace reported in the thing where a
  horizon cannot hold the cause.
- **The intellect** (`intellectus.l`). Knower kinds, never persons
  (rule 3); where knowing ends; praise through a rational nature (GS 14),
  with no rule that creation's praise needs one (CCC 2416).
- **Four loci** in `schools.l` and three runtimes: `plato`, `aristotle`,
  and their merge, `concordia`.
- **The natural kind and the joint work.** A natural question is answered
  by availability in a horizon, never by a tier or a finding. A joint
  whole is composed of parts, each with its own kind; *Dei Filius* ch. 4
  is the policy of the composition. A claimed conflict between a finding
  and a definition at tier 1 branches on DH 3017's two diagnoses and is
  reported as reserved, never resolved. A definition is not re-read by a
  finding (can. 4.3).
- **Decomposition and the oracle.** Terms of a scheme are never parts and
  never causes. A simulation as a finding's method.
- **A rendering is not a conversion.** A word for force that carries an
  end by analogy renders it.

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited.

## THE TEXTS

The evidence record is `docs/research/rerum-sources.md`. [V] verified
against a fetched text; [S] through a named secondary source; [M] from
memory or a standard citation, owed in print. The loci that decide the
encoding:

| Text | Holds | Locus |
| --- | --- | --- |
| *Dei Filius*, canons on God the creator | "praeter materiam nihil esse"; "unam eandemque esse Dei et rerum omnium substantiam vel essentiam"; "e divina substantia emanasse"; "Deum esse ens universale seu indefinitum, quod sese determinando constituat rerum universitatem" | cann. 1.2–1.4, DH 3022–3024 [V] |
| *Dei Filius*, ch. 2 | God "rerum omnium principium et finem" | DH 3004 [M] |
| *Dei Filius*, ch. 4 | "duplicem esse ordinem cognitionis"; "nulla tamen umquam inter fidem et rationem vera dissensio esse potest"; "Inanis autem huius contradictionis species inde potissimum oritur, quod vel fidei dogmata ad mentem Ecclesiae intellecta et exposita non fuerint, vel opinionum commenta pro rationis effatis habeantur"; the disciplines "in suo quaeque ambitu propriis utantur principiis et propria methodo" | DH 3015, 3017, 3019 [V] |
| *Dei Filius*, canons on faith and reason | the sciences' assertions contrary to revealed doctrine not to be held true; no dogma given another sense "secundum progressum scientiae" | cann. 4.2–4.3, DH 3042–3043 [V; 3042 inferred] |
| The creed | "genitum, non factum ... per quem omnia facta sunt" | DH 150 [V; the clause beside the DH number M] |
| Lateran IV | "unum universorum principium; Creator omnium visibilium et invisibilium" | DH 800 [V, through Thomas's lemma] |
| Florence | "Pater et Filius et Spiritus Sanctus non tria principia [sunt] creaturae, sed unum principium" | DH 1331 [V] |
| Thomas, God and the world | "Deus esset anima mundi"; "Deum esse principium formale omnium rerum ... opinio Almarianorum"; David of Dinant "stultissime posuit Deum esse materiam primam" | I q. 3 a. 8 [V] |
| Thomas, the first cause | "causam efficientem primam, quam omnes Deum nominant"; "Deus est prima causa exemplaris omnium rerum"; "divina bonitas est finis rerum omnium" | I q. 2 a. 3 [M]; I q. 44 aa. 3–4 [V] |
| Thomas, God in every agent | "in all things God works intimately"; not that part of the effect is God's and part the creature's | I q. 105 a. 5 [V, English]; SCG III.70 [M] |
| Thomas, forms | forms and accidents "non dicuntur entia quasi ipsa sint, sed quia eis aliquid est"; "forms have not being, but composites have being through forms" | I q. 45 a. 4 [V]; I q. 65 a. 4 [V, English] |
| Thomas, the soul | the human soul a subsisting form | I q. 75 a. 2; I q. 90 a. 2 [M]; Vienne, DH 902; Lateran V, DH 1440 [M] |
| Thomas, matter | "more repugnant that matter should be in act without form, than for accident to be without subject" | I q. 66 a. 1 ad 3 [V, English] |
| Thomas, becoming | "Aedificator enim est causa domus quantum ad eius fieri, non autem directe quantum ad esse eius" | I q. 104 a. 1 [V] |
| Thomas, art | art produces substantial forms "not by its own power, but by the power of natural energies", the forms of bread "by the power of fire baking the matter" | III q. 75 a. 6 ad 1 [V, English] |
| Thomas, the measure | "Res ergo naturalis, inter duos intellectus constituta, secundum adaequationem ad utrumque vera dicitur" | *De veritate* q. 1 a. 2 [V] |
| Thomas, the ideas | Aristotle "improbat opinionem Platonis de ideis, secundum quod ponebat eas per se existentes, non in intellectu"; "plures ideae sunt in mente divina ut intellectae ab ipso", their relations "respectus intellecti a Deo" | I q. 15 a. 1 ad 1; a. 2 and ad 4 [V] |
| Thomas, knowing | "species intelligibilis se habet ad intellectum ut quo intelligit intellectus"; "intentio universalitatis, est in intellectu", the nature "non est nisi in singularibus" | I q. 85 a. 2 and ad 2 [V] |
| Thomas, analogy | prior as to the thing signified, prior as to the imposition of the name | I q. 13 a. 6 [V, TTC-PENDET] |
| Thomas, two chairs | "pericula magisterii cathedrae pastoralis", "pericula autem magisterii cathedrae magistralis" | *Quodl.* III q. 4 a. 1 ad 3 [V] |
| Aristotle, causes | "Sed tres in unam veniunt multoties. Quod quidem enim quid est, et quod cuius causa, una est" | *Physics* II.7, 198a24 [V, Moerbeke] |
| Aristotle, parts | "plurimae potestate sunt, ut ipsae partes animalium"; separated, "like matter" | *Metaphysics* VII.16, 1040b5 [V] |
| Aristotle, the god | moves "as being loved"; "its thinking is a thinking on thinking" | *Metaphysics* XII.7, 1072b3 [M]; XII.9 [V, Ross] |
| Plato, the soul | the soul rules the body, which it uses | *Alcibiades I* 130c [M] |
| Gaudium et spes | "elementa mundi materialis in se colligit, ita ut, per ipsum, fastigium suum attingant et ad liberam Creatoris laudem vocem attollant" | GS 14 [V] |
| The Catechism | "by their mere existence they bless him and give him glory" | CCC 2416 [V] |
| Scotus | matter "would have its own proper existence"; God "could create matter existing without form" | *Opus Oxoniense* II d. 12 q. 1 (Vivès 12), through Wolter and Gordon [S] |
| Suárez | matter "habet in se et per se entitatem seu actualitatem existentiae distinctam ab existentia formae"; not naturally without form | *DM* 13 s. 4 nn. 13–14 [V]; by divine power, owed |
| Ockham | the divine ideas the creatures themselves as known | *Ord.* I d. 35 q. 5 [M, owed: OTh IV] |
| Ockham, signs | "universale est intentio animae nata praedicari de multis"; "nullum universale sit aliqua substantia extra animam exsistens" | *Summa logicae* I cc. 14–15 [V] |
| Bonaventure | "Platoni sermo sapientiae, Aristoteli vero sermo scientiae"; "Uterque autem sermo ... datus est Augustino" | *Christus unus omnium magister* nn. 18–19 [V] |
| Boethius | Plato's and Aristotle's opinions "in unam quodammodo revocare concordiam" | *In Peri hermeneias*, ed. sec., II [M, owed] |
| Locke | "hath no other immediate object but its own ideas"; the nominal essence "nothing but that abstract idea" a sortal name stands for | *Essay* IV.1; III.3.15 [V] |
| Descartes | "The nature of body consists just in extension" | *Principles* II.4 [V, English] |
| Bacon | "Eam autem legem, ejusque paragraphos, formarum nomine intelligimus" | *Novum Organum* II.2 [V]; II.17 [V, English] |
| Kant | "The understanding doesn't draw its laws from nature, but prescribes them to nature" | *Prolegomena* §36 [V, English] |
| Gould | science and religion as non-overlapping magisteria | *Natural History* 106 (2) (1997) 16–22 [V] |
| Chandler | "Interfaces and the driving force of hydrophobic assembly" | *Nature* 437 (2005) 640–647 [V] |
| Energy decomposition | "there is not a unique way to compute quantities related with such intuitive chemical concepts"; "the energy components, which are not uniquely defined" | Andrés et al., *J. Comput. Chem.* 40 (2019); Phipps et al., *Chem. Soc. Rev.* 44 (2015) [V] |
| The law of soap | soap's nonvolatile matter "an alkali salt of fatty acids", "the detergent properties ... due to the alkali-fatty acid compounds" | 21 CFR 701.20(a) [V] |

## THE DESIGN

Every slot is declared in the first file, in layer and `engine.FILES`
order, whose rules read it, and every sort in the first file whose slots
use it (`test_l`). `engine.FILES` gains `intellectus.lp` and then
`rerum.lp`, after `pendet.lp`. Every new violation and info atom is
declared as a `result`.

### The deposit (`kernel_core.l`, a section "Creation and its causes (deposit; TTC-RERUM)", after "The last end and latria")

Slots, declared in `kernel_core.l`: the sort `cause` (moved from
`causae.l`); `cause_of(X: entity, C: cause, P: entity)`, P the C cause of
the creature X in the order of creatures; `nothing_but_matter(C: claim)`;
`made_through(W: entity, X: entity)`; `subsists_apart(E: entity)`, E
claimed to subsist of itself; `subsisting_form(S: entity)`, S a form
that subsists.

- **QD-a. No origin from God of a creature.** `violation(origin_from_god(P,
  X))` where `orig_cr(P, X)` and `ind_sort(P, div)`. The Son's begetting
  and the Spirit's procession are `orig_div`; the nativity's source is
  Mary. DH 3024; "genitum, non factum" (DH 150).
- **QD-b. God neither form nor matter.** `violation(god_as_form_or_matter(X,
  C, P))` where `cause_of(X, C, P)`, C formal or material, and
  `ind_sort(P, div)`. DH 3023–3024; I q. 3 a. 8.
- **QD-c. Nothing but matter.** `violation(only_matter(C))` where
  `nothing_but_matter(C)`. DH 3022.
- **QD-d. Per quem.** `violation(made_through_a_creature(W, X))` where
  `made_through(W, X)` and not `ind_sort(W, div)`, untyped W included.
  It gives no `being/2`: being has one giver (A1, A3; DH 800, 1331).
- **QD-e. Nothing subsists apart beside God.**
  `violation(uncreated_beside_god(E))` where `subsists_apart(E)`, not
  `ind_sort(E, div)` and not `creature(E)`. DH 800.

### Causes in things (`kernel_core.l`, a section "Causes in things (kernel; TTC-RERUM)")

- **QT-a. A form is no thing.** `violation(quo_as_quod(X, P))` where
  `cause_of(X, formal, P)`, `creature(P)` and not `subsisting_form(P)`
  (I q. 45 a. 4). A subsisting form is a creature (`creature(S) :-
  subsisting_form(S)`): the soul, created immediately (DH 3896), is the
  form of the body (DH 902) and subsists (I q. 75 a. 2). A material cause
  typed a creature stands, as *materia ex qua* (*Physics* II.3).
- **QT-c. God no second cause.** `violation(god_as_second_cause(X, C, P))`
  where `cause_of(X, C, P)`, C efficient or final, and `ind_sort(P, div)`.
  Kernel, not deposit (`docs/layers.csv`): every school holds God the
  first cause, working in every agent, the effect wholly from both in
  different orders and not part from each (I q. 105 a. 5; SCG III.70).
  God is the first efficient and the last final cause (DH 3004; I q. 2
  a. 3; I q. 44 aa. 1, 4): typed by `being/2` and by `lifted(god, ends)`,
  never by `cause_of/3`. An argument may still rest on God's causality by
  analogy, in the domains `god_physics` and `god_ethics`.

### Things by their causes (`rerum.l`, a library)

Slots: sort `making` {accidental, by_nature, by_art_alone};
`makes(M: entity, X: entity, K: making)`; `end_of_use(X: entity, P:
entity)`; `intellect_measures(I: knower, X: entity, P: entity)`, an
intellect of kind I measures the principle P of X; `exemplar_of(E:
entity, X: entity)`; `about(Q: question, X: entity)`;
`exists_without_form(P: entity)`.

- **The maker of the becoming.** `artifact(X)` where `makes(_, X,
  accidental)`; `natural(X)` where `creature(X)` and not `artifact(X)`.
  `info(maker_of_becoming(M, X))` where `makes(M, X, _)` and `cause_of(X,
  efficient, M)`: the builder of I q. 104 a. 1, cause of the house's
  becoming and not directly of its being. Created causes of being in a
  respect (the same article) are not typed.
- **Art through nature.** `violation(substance_by_art_alone(M, X))` where
  `makes(M, X, by_art_alone)` and `natural(X)`.
- **The measure.** Under `things_measure_us`:
  `violation(natural_form_measured_by_us(X, P))` where
  `intellect_measures(human, X, P)`, `natural(X)`, `cause_of(X, C, P)`
  with C formal or final, and not `end_of_use(X, P)`. Under
  `mind_prescribes`, on the same condition, `info(prescribed(X, P))` and
  no violation.
- **The edge.** A chain `chain(A, X, P, C, D)`: A an argument on a
  question Q with `question_kind(Q, natural)`; `rests_on_form(A, cd(C,
  D), F)` with D `nature` or `will`; `signifies(F, W, _)`;
  `conceived_as(P, W, human)`; `cause_of(X, C, P)`. It does not read
  `about/2`.
  - `grounded(A, X, P)` where a chain runs, only under
    `knowing_ends_in_things`.
  - `info(traced_in_thing(G, X, C, D))` where a chain runs and the horizon
    G, the run's own or the VM's guest, does not hold (C, D).
  - `info(premise_without_thing(A, cd(C, D)))` where A, on a natural
    question, argues from (C, D), D `nature` or `will`, with no chain for
    (C, D).
  - `info(grounded_in_the_word(A, X, E))` where A, on a natural question
    Q with `about(Q, X)`, argues from (formal, god_physics), and
    `exemplar_of(E, X)` with `ind_sort(E, div)`, only under
    `ideas_in_the_word` or `ideas_as_energies`.
- **The allele parts** (here, named in `schools.l`'s loci):
  - `ideas_in_the_word`, `ideas_as_energies`, `ideas_creatures_known`,
    `ideas_subsisting` each hold `holds_cause(formal, god_physics)`, the
    exemplar as a cause in God's intention for nature.
  - Under `ideas_in_the_word` and `ideas_as_energies`, for each natural X
    with `about(Q, X)`: `violation(exemplar_not_divine(E, X))` where
    `exemplar_of(E, X)` and not `ind_sort(E, div)`; under
    `ideas_as_energies` also `info(exemplar_as_energy(E, X))` where
    `ind_sort(E, div)`.
  - Under `ideas_creatures_known`: `info(idea_is_the_creature(X))`.
  - Under `ideas_subsisting`: `subsists_apart(idea(X))`, the Form of X,
    where QD-e refuses it.
  - Under `ideas_no_exemplar`: `info(no_exemplar(X))`.
  - `matter_never_without_form`: `violation(matter_in_act_without_form(P))`
    where `exists_without_form(P)`. `matter_can_be_without_form`:
    `info(matter_without_form_by_power(P))`.
  - `things_measure_us`, `mind_prescribes`: as above.

### The intellect (`intellectus.l`, a library)

Slots: sort `knower` {divine, angelic, human}; `conceived_as(P: entity,
W: word, K: knower)`; `voiced_through(X: entity, M: entity, T: entity)`,
the praise of X reaches T through M.

- **Knower kinds.** A person in the third place of `conceived_as/3` is
  outside the sort (rule 3).
- **Where knowing ends.** `knowing_ends_in_things` holds the flag under
  which `grounded/3` is derived: the word that by which.
  `ideas_as_objects`: `info(ends_in_the_word(W, P))` for each
  `conceived_as(P, W, human)`, the word what is known (I q. 85 a. 2;
  Locke, *Essay* IV.1).
- **Praise through a knower.** A mediator has a rational nature: a created
  person, an angel, or the incarnate (`incarnate/1`).
  `info(praise_through(X, M, T))` where M is one and `ind_sort(T, div)`;
  `violation(mediator_without_intellect(M))` where M is none;
  `info(praise_ends_in_creature(X, M, T))` where T is not God or a divine
  person, reported and not typed as latria (Nicaea II, DH 601,
  distinguishes honour). No rule reads the absence of `voiced_through/3`
  (CCC 2416).

### The loci and the runtimes (`schools.l`)

| Locus | Allele = part | Says | Held by |
| --- | --- | --- | --- |
| `ideas` | `in_the_word` = `ideas_in_the_word` | the ideas in the divine mind, many "ut intellectae", their relations of reason (I q. 15 a. 2 and ad 4) | `thomist`, `concordia` |
| | `energies` = `ideas_as_energies` | the logoi as uncreated energies | `palamite` |
| | `creatures_known` = `ideas_creatures_known` | the ideas the creatures themselves as known | `ockham_nominal` |
| | `subsisting` = `ideas_subsisting` | the Forms subsisting apart | `plato` |
| | `no_exemplar` = `ideas_no_exemplar` | a god who thinks only himself (*Metaphysics* XII.9, one reading) | `aristotle` |
| `prime_matter` | `never_without_form` = `matter_never_without_form` | I q. 66 a. 1 ad 3 | `thomist` |
| | `can_be_without_form` = `matter_can_be_without_form` | *Opus Oxoniense* II d. 12 q. 1 | `scotist` |
| `terminus` | `in_the_thing` = `knowing_ends_in_things` | the word that by which | `default` |
| | `in_the_idea` = `ideas_as_objects` | the idea what is known | `descartes`; `locke` and `locke_wl` express it (*Essay* IV.1) |
| `adaequatio` | `by_things` = `things_measure_us` | things measure our intellect | `default` |
| | `by_the_mind` = `mind_prescribes` | the understanding prescribes to nature | `kant` |

- **New runtimes.**
  - `plato extends default`: `exclude soul_as_form` (the soul rules the
    body, *Alcibiades I* 130c), `add ideas_subsisting`.
  - `aristotle extends default`: `exclude ends_by_god_physics,
    ends_by_god_ethics` (a god who moves as loved and intends nothing,
    *Metaphysics* XII.7, 9), `add ideas_no_exemplar`.
  - `concordia extends plato, aristotle`: the parents clash on three
    parts, and the child resolves them: `add soul_as_form,
    ends_by_god_physics, ends_by_god_ethics, ideas_in_the_word`. It
    carries `subsisting` and `no_exemplar` and expresses `in_the_word`
    (TTC-LOCI). Boethius's stated aim, a concord of the two; Thomas's
    reading, the ideas in an intellect (I q. 15 a. 1 ad 1).
- **The VM.** `vm_plato`, `vm_aristotle`, `vm_concordia` are added, each
  with its runtime's horizon. Every `vm_R` whose R expresses
  `in_the_word`, `energies`, `creatures_known` or `subsisting` gains
  `guest_holds(formal, god_physics)`. `horizons_all` keeps its ten parts.
- **Ockham measured** (the switch `ockham_measure` of `soap`). No merge
  runtime for the nominalist. Two forms of *idea*, Thomas's (I q. 15;
  `lex_la_schol`, `w_idea_divina`) and Ockham's (*Ord.* I d. 35 q. 5;
  `lex_la_ockham`, `w_creatura_cognita`), each in its own encoding;
  `analogous(w_creatura_cognita, w_idea_divina, attribution,
  aquinas_i_13_6)`; and `measured_by(f_idea_th, f_idea_oc,
  ockham_ord_i_d35)`, Ockham's form taken as the measure of Thomas's.
  TTC-PENDET's measure then shows the level each holds, as the case
  declares it: the divine idea prior as to the thing, Ockham's word prior
  as to us.
- **Only names.** Slot `nothing_but_names(C: claim, W: word)` (`linguae.l`):
  the claim C that the universal word W has no ground in the singulars.
  `violation(only_names(C, W))`: the nature understood is in the
  singulars (I q. 85 a. 2 ad 2), and the universal a natural sign
  (*Summa logicae* I c. 15).

### The natural kind and the joint work (`icon_authority.l`, `empirica.l`)

- **The kind.** The closed sort `question_kind` gains `natural`. A natural
  question joins the empirical kind in every exemption the authority
  graph grants it from deletion, cleaving and weight (`empirical_q/1`'s
  uses at `e739a5b`), and in no other rule: no finding fixes it, and
  `act_answers_a_fact` stays empirical. `info(natural_question_taught(S,
  Q))` where a source in force at tiers 1–3 supports a value on it.
- **A natural question with sources** is entered as any question
  (`question/1`, `value/2`, a supporting source): `soap`'s, `locke_
  essence`'s.
- **A joint whole** is entered only by `question_kind(Q, natural)` and its
  parts, never by `question/1`: slot `question_part(Q1: question, Q:
  question)`. `info(joint_part(Q, Q1, K))`, K the part's kind.
  `violation(part_of_no_natural_question(Q1, Q))` where Q is not natural;
  `violation(part_cycle(Q))` where Q is its own part, through any chain.
- **A claimed conflict.** Slot `claims_conflict(C: claimant, F: finding,
  Q1: question, V: value)`: C says the finding F conflicts with V on Q1.
  - Where V on Q1 is supported by a source in force at tier 1: computed
    both ways, never preferred, as DH 3017 divides it,
    `assumed_fact(misread_dogma(C, Q1))` or
    `assumed_fact(opinion_for_finding(F))`. On the second, F fixes
    nothing (`fixed_by/3` gains the condition). Q1's values are
    untouched on both. `info(reserved_to_the_author(Q, F, Q1))` in every
    branch, Q the joint whole Q1 is part of.
  - Below tier 1: `info(conflict_with_reformable(C, F, Q1))`, and nothing
    branches; the base's shadows already carry a reformable teaching.
- **Can. 4.3.** Slot `resenses(F: finding, S: source, R: reading)`.
  `violation(dogma_resensed_by_finding(F, S))` where S is in force at
  tier 1. `info(scripture_read_by_finding(F, S, R))` at tier 0, and no
  violation.

### Decomposition and the oracle (`empirica.l`)

- Sort `scheme`. Slot `scheme_term(T: entity, Q: question, S: scheme)`: T
  is a term of the total that Q asks, under S. `info(scheme_relative(Q))`
  where two schemes split it. `violation(term_as_part(T))` where
  `creature(T)`; `violation(term_as_cause(T, X))` where `cause_of(X, _,
  T)`.
- `info(fixed_by_simulation(Q, V, F))` where `fixed_by(Q, V, F)` and
  `method(F, simulation)`.

### A rendering is not a conversion (`causae.l`)

- Slot `measure_word(M: measure, W: word)`. `rendered(M)` where
  `measure_word(M, W)`, `analogous(W, W1, K, _)` and `carries(W, W1,
  cd(final, _))`. CV5's `cause_converted` and `conversion_native` gain
  `not rendered(M)`; `info(cause_rendered(M, W, W1, K))`.

### The cases (`icon_history.l`)

Real texts where they exist; every typing is an interpretive fact,
entered and open to dispute. Hypothetical matter only in HYPOTHETICAL
parts (rule 6).

- **`soap`** (case), run with `trinity` and `world`. `soap` (sodium
  stearate), `bar`, `fat`, `lye` inanimate; `soapmaker` a created
  person. `makes(soapmaker, soap, by_nature)`, `makes(soapmaker, bar,
  accidental)`. Causes of `soap`: material `fat`, `lye`; formal
  `amphiphilic_form`; efficient `soapmaker`, `lye`; final `cleaning` (an
  end of use, `end_of_use(soap, cleaning)`) and `interfaces_end` (to
  gather where water and oil meet, by similitude).
  `intellect_measures(human, soap, cleaning)`. `exemplar_of(son, soap)`,
  `made_through(son, soap)`. `conceived_as`: `cleaning` under `w_usus`,
  `interfaces_end` under `w_finis`, `amphiphilic_form` under `w_forma`.
  The question `q(soap_for_an_end)`, natural, values yes and no,
  `about(q(soap_for_an_end), soap)`; the case's text `soap_t` (tier 5,
  2026) supports yes and gives four arguments, each on a form of the
  text:

  | Argument | Argues from | Form, word |
  | --- | --- | --- |
  | `a_maker` | (final, will) | *use*, `w_usus` |
  | `a_nature` | (final, nature), (formal, nature) | *end*, `w_finis`; *form*, `w_forma` |
  | `a_god` | (final, god_physics) | none |
  | `a_logos` | (formal, god_physics) | *idea*, `w_idea_divina` |

- **`micelle`** (case). Two empirical questions, each fixed by a finding:
  micelles form above the critical concentration; micellization is
  driven chiefly by entropy. A joint whole `q(stearate_gathers)` with
  both as parts.
- **`eda`** (case). `q(dimer_binds)`, empirical, fixed by a finding by
  simulation; its terms under `sapt` and `almo`; a joint whole
  `q(why_dimer_binds)` with it as part.
- **`locke_essence`** (case). `gold` inanimate, `cause_of(gold, formal,
  gold_form)`, `conceived_as(gold_form, w_aurum, human)`; a natural
  question `q(gold_has_a_form)` with a supporting source (tier 5), about
  `gold`, and an argument from (formal, nature) on the form *aurum*.
- **Switches.** `joint_beginning` (`q(world_origin)`; parts
  `q(world_began)`, `q(universe_expanding)`, `q(age_of_universe)`);
  `joint_galileo` (`q(the_heavens)`; parts `q(earth_moves)`,
  `q(sun_at_rest)`); `joint_one_root` (`q(human_origin)`; part
  `q(one_root)`); `joint_method_being` (`q(what_a_body_is)`; part
  `q(bodies_of_cells)`); `ockham_measure`.
- **Candidates.** `cand_emanation`; `cand_world_soul`, `cand_almarician`,
  `cand_dinant` (God the form of the cosmos, the formal principle of a
  creature, its matter); `cand_god_second_cause` (God an efficient cause
  of a stone, the Son its final cause); `cand_only_matter`;
  `cand_made_through_creature` (the demiurge, untyped);
  `cand_form_as_thing`; `cand_soul_as_form` (a subsisting form as the
  formal cause of a man); `cand_art_alone`; `cand_human_measure`;
  `cand_matter_alone`; `cand_design` (God an efficient cause of a
  flagellum, and the end measured as a force, as a design argument types
  them); `cand_praise` (praise through a man to God, through the
  incarnate Son to the Father, through an oak, and through a man to a
  man); `cand_term_as_cause`, `cand_term_as_part`;
  `cand_nothing_but_names`; `cand_premise_without_thing` (a joint whole
  with an argument from (final, nature) and no causes).
- **HYPOTHETICAL parts.**
  - `natural_taught_hyp` (switch): a tier-1 source with
    `hypothetical_warrant/1`, supporting `q(soap_for_an_end)`.
  - `conflict_hyp` (case): an empirical question with a finding of 2020
    (within the base's default date, as `beginning`'s finding of 2018
    is), claimed to conflict with `q(world_began)`; with `beginning` and
    `joint_beginning`.
  - `conflict_reformable_hyp` (case): an empirical question with a
    finding, claimed to conflict with `q(one_root)`; with `one_root` and
    `joint_one_root`.
  - `resense_hyp` (switch): `resenses(f_hyp_t0, lateran_iv_1215,
    at_t_zero)`, where `f_hyp_t0` is no `finding/4`; and
    `resenses(bradley_1729, josh10_12, by_appearances)`; with `beginning`
    and `galileo`.
  - `rendering_hyp` (switch): `measures_as(m_render, final, efficient)`
    with `measure_word(m_render, w_driving_force)`,
    `analogous(w_driving_force, w_finis, proportionality, c_hyp)` and
    `carries(w_driving_force, w_finis, cd(final, nature))`; and
    `measures_as(m_convert, final, efficient)` with none.

### Files

New: `l/rerum.l`, `l/intellectus.l` and their `lp/`. Changed:
`kernel_core.l`, `causae.l` (the sort moves out; CV5), `linguae.l`,
`empirica.l`, `icon_authority.l`, `schools.l`, `icon_history.l`,
`engine.py` (`FILES`), `runtimes.json`, the suite, `docs/layers.csv`,
the guide (both copies), `docs/l.md` (the loci), `CLAUDE.md`'s table of
layers, the roadmap.

## PREDICTIONS

Runtimes: the 42 at `e739a5b` and the three new, 45. "Every runtime"
means all 45, each with the parts named. `soap` runs with `trinity` and
`world`; on `bare` the grain fault that `trinity` gives there (no
`one_power`) stands, as at `e739a5b`.

Predictions can fail against the base: they say how the new rules meet
the old ones. Mechanics check that the encoding does what the design
says, as TTC-MODERNITY's MM checks did; they are scored apart.

### Predictions

- **QD1. Emanation, and nothing else.** `cand_emanation` with `world` gives
  `origin_from_god(god, peter)` on every runtime. M1, the creed's parts
  and every boot-set scenario give the same atoms as before, in every
  model.
- **QN1. The kind's exemptions.** `q(soap_for_an_end)` is open, both
  values, on every runtime: no branch is cleaved, no weight is laid,
  though a tier-5 source supports yes. With `natural_taught_hyp`, still
  open, and `natural_question_taught(def_n, q(soap_for_an_end))`; no
  `tier_without_warrant`.
- **QN2. Joint wholes change nothing.** `joint_beginning`, `joint_galileo`,
  `joint_one_root`, `joint_method_being` each add only `joint_part/3`
  atoms: every other atom of every model of `beginning`, `galileo` (as
  of 1616, 1633, 1700, 1730, 1830), `one_root`, and `world` with
  `method_being` is as before (CB1–CB2, GL1–GL4, DD2, MB1). PR4 stays
  clean.
- **QN3. A conflict at tier 1, reserved.** `conflict_hyp` gives three
  models: one assuming `misread_dogma`, with the finding's question
  fixed; two assuming `opinion_for_finding`, with it open, yes and no.
  `q(world_began)` is settled yes in all three, and
  `reserved_to_the_author(q(world_origin), f_hyp, q(world_began))` is in
  each. `conflict_reformable_hyp` gives `conflict_with_reformable/3`, no
  new branch, and `q(one_root)` as DD2 has it.
- **QV1. CV5 kept, and a rendering.** `rendering_hyp` gives
  `cause_rendered(m_render, w_driving_force, w_finis, proportionality)`
  on every runtime, and neither `cause_converted` nor `conversion_native`
  for `m_render` anywhere. For `m_convert`, `cause_converted` on 41
  runtimes (the 38 where CV5 fires at `e739a5b`, `bare` among them, and
  the three new) and `conversion_native` on `hobbes`, `hobbes_wl`,
  `spinoza`, `spinoza_wl`.
- **QL1. The loci, as the compiler gives them.**

  | Locus | Expressed | Runtimes |
  | --- | --- | --- |
  | `ideas` | `in_the_word` | `thomist`, `hooker`, `episcopate_1891`, `social_catholic`, `locke`, `locke_wl`, `smith`, `angers`, `george`, `george_hn`, `concordia` (11; `concordia` carrying `subsisting`, `no_exemplar`) |
  | | `energies`; `creatures_known`; `subsisting`; `no_exemplar` | `palamite`; `ockham_nominal`; `plato`; `aristotle` |
  | | none | the other 30 |
  | `prime_matter` | `never_without_form` | `thomist`, `hooker`, `episcopate_1891`, `social_catholic`, `angers` (5; `angers` carrying `can_be_without_form`) |
  | | `can_be_without_form` | `scotist` and the 20 that inherit it through `scotus_dpp` (21) |
  | | none, both carried | `locke`, `locke_wl`, `smith`, `george`, `george_hn` |
  | | none | the other 14, `suarezian` among them |
  | `terminus` | `in_the_thing` | `default`, `thomist`, `scotist`, `suarezian`, `palamite`, `saussure`, `vocal`, `lingual`, `scotus_dpp`, `ockham`, `suarez_dm23`, `bacon`, `hooker`, `grotius`, `scotus_will`, `ockham_will`, `ockham_nominal`, `grotius_etiamsi`, `suarez_wl`, `episcopate_1891`, `social_catholic`, `marx`, `marx_social`, `lassalle`, `plato`, `aristotle`, `concordia` (27) |
  | | `in_the_idea` | `descartes`, `descartes_will`, `spinoza`, `spinoza_wl`, `locke`, `locke_wl`, `smith`, `george`, `george_hn` (9) |
  | | none, both carried | `hobbes`, `hobbes_wl`, `leibniz`, `leibniz_wl`, `kant`, `kant_humanity`, `kant_mm`, `angers` (8) |
  | | none | `bare` |
  | `adaequatio` | `by_things` | 41 |
  | | `by_the_mind` | `kant`, `kant_humanity`, `kant_mm`, carrying `by_things` |
  | | none | `bare` |

  No `re_expressed`.
- **SU1. No other change.** No earlier scenario's atoms change in any
  model, save what follows, each restated with its reason (rule 7):
  - `test_l`: the runtime set gains `plato`, `aristotle`, `concordia`;
    palamite's ops gain `add ideas_as_energies`; the hand-written
    runtimes gain the new parts (`default` and every school
    `knowing_ends_in_things`, `things_measure_us` after default's own;
    `thomist` `ideas_in_the_word`, `matter_never_without_form`;
    `scotist` `matter_can_be_without_form`; `palamite`
    `ideas_as_energies`); the closed sorts gain `natural`, `knower`,
    `making`; three tests pinning a layer runtime's `loci` to two loci
    (with `test_interface`'s).
  - `test_schools`: the 33 runtimes of the modernity step become 36.
  - TTC-MODERNITY SU1, the parts that write `argument/4`, `argues_from/3`
    and `measures_as/3`, admits `soap`, `locke_essence`, `cand_design`,
    `cand_premise_without_thing`, `rendering_hyp`; MM3, default's parts
    after its first three, gains the two new parts.
  - TTC-PENDET PD1, no part writes `measured_by/3`, admits
    `ockham_measure`.
  - TTC-LOCI AL1, the declared loci, gains four; LS2, `docs/layers.csv`'s
    lines for the last end and latria, moves with the new kernel slots.
  - CL1 and PR4 stay clean.
- **SU2.** Every new rule and slot has a test that fails without it. Both
  copies of the guide gain the vocabulary identically.

### Mechanics

- **QD2.** With `world`: `cand_world_soul`, `cand_almarician`,
  `cand_dinant` each give `god_as_form_or_matter/3` for their fact;
  `cand_god_second_cause` (with `trinity`) gives `god_as_second_cause/3`
  twice; on every runtime.
- **QD3.** `cand_only_matter` gives `only_matter/1` on every runtime.
- **QD4.** `soap` gives no violation from `made_through(son, soap)`.
  `cand_made_through_creature` gives `made_through_a_creature(demiurge,
  peter)`.
- **QD5.** On `plato`, `soap` gives `uncreated_beside_god(idea(soap))`,
  and on no other runtime.
- **QT1.** `cand_form_as_thing` gives `quo_as_quod/2` on every runtime;
  `soap` gives none, though `fat` and `lye` are typed inanimate;
  `cand_soul_as_form` gives none.
- **QT2.** `soap` gives `maker_of_becoming(soapmaker, soap)` and no
  `being/2` from the soap-maker; `lye`, an efficient cause and no maker,
  gives none.
- **QT3.** `cand_art_alone` gives `substance_by_art_alone/2`.
- **QT4.** `cand_human_measure` gives `natural_form_measured_by_us(soap,
  amphiphilic_form)` on the 41 of `by_things`, `prescribed/2` and no
  violation on the three of `by_the_mind`, nothing on `bare`. `soap`'s
  `intellect_measures(human, soap, cleaning)` gives nothing anywhere.
- **QT5.** On `soap`: `grounded(a_nature, soap, interfaces_end)`,
  `grounded(a_nature, soap, amphiphilic_form)`, `grounded(a_maker, soap,
  cleaning)` on the 27 of `in_the_thing`; `ends_in_the_word/2` for the
  three principles on the 9 of `in_the_idea`; neither on the 8 carriers
  and `bare`.
- **QT6.** `traced_in_thing(here, soap, final, nature)` where
  `ends_in_nature` is not held, `(formal, nature)` where `forms_in_nature`
  is not, `(final, will)` on `bare` alone:

  | Traced | Runtimes |
  | --- | --- |
  | final and formal | `bacon`, `bare`, `hobbes`, `hobbes_wl`, `kant`, `kant_humanity`, `locke_wl`, `marx`, `marx_social`, `descartes`, `descartes_will`, `spinoza`, `spinoza_wl`, `locke`, `smith`, `george`, `george_hn` (17) |
  | final only | `grotius`, `grotius_etiamsi`, `ockham`, `ockham_nominal`, `ockham_will`, `scotus_dpp`, `scotus_will`, `suarez_dm23`, `suarez_wl` (9) |
  | formal only | `kant_mm` (1) |
  | nothing | the other 18 |

- **QT7.** `cand_premise_without_thing` gives
  `premise_without_thing(A, cd(final, nature))` on every runtime.
- **QT8.** Availability on `soap`: `a_maker`, `a_god`, `a_nature` as the
  baseline at `e739a5b` with the case's arguments as a snippet (14
  runtimes all three; 12 `a_maker` and `a_god`; `lassalle` `a_maker` and
  `a_nature`; 14 `a_maker` alone, a sole reason; `bare` none); `plato`
  and `concordia` all three; `aristotle` `a_maker` and `a_nature`.
  `a_logos` on the 14 of QL1 that express `in_the_word`, `energies`,
  `creatures_known` or `subsisting`.
- **QI1.** `conceived_as(p, w, peter)` gives `outside_domain` on its third
  argument.
- **QI2.** `cand_praise` gives `praise_through/3` through the man and
  through the incarnate Son (with `creed`), `mediator_without_intellect(oak)`,
  and `praise_ends_in_creature/3` for the man to a man, with no latria.
- **QL2.** `cand_matter_alone` gives `matter_in_act_without_form` on the
  five of `never_without_form`, `matter_without_form_by_power` on the 21
  of `can_be_without_form`, nothing on the other 19.
- **QL3.** On `soap`: `grounded_in_the_word(a_logos, soap, son)` on the 11
  of `in_the_word` and on `palamite`, with `exemplar_as_energy(son, soap)`
  there; `plato` faults (QD5), no `grounded_in_the_word`;
  `ockham_nominal` `idea_is_the_creature(soap)`, no
  `grounded_in_the_word`; `aristotle` `no_exemplar(soap)`.
- **QL4.** `ockham_measure` gives `mode(f_idea_th, f_idea_oc, analogical)`,
  `analogy_kind(f_idea_th, f_idea_oc, attribution)`, `prius_rei(f_idea_th,
  f_idea_oc, w_idea_divina)`, `prius_nobis(f_idea_th, f_idea_oc,
  w_creatura_cognita)`; no `made_from/2`, nothing carried. A fit:
  TTC-PENDET's rules reading back the priority the case declares.
  `cand_nothing_but_names` gives `only_names/2` on every runtime.
- **QN4.** `resense_hyp` gives `dogma_resensed_by_finding(f_hyp_t0,
  lateran_iv_1215)` and `scripture_read_by_finding(bradley_1729,
  josh10_12, by_appearances)`, and no other violation.
- **QN5.** A part of a question not natural, and a part cycle, each give
  their violation.
- **QN6.** `soap` on `thomist` with `vm_bacon` gives no guest report; with
  `vm_descartes`, `guest_sole_reason(soap_t, a_maker, …)`.
- **QE1.** `eda` gives `scheme_relative(q(dimer_binds))` and
  `fixed_by_simulation/3`; `cand_term_as_cause` gives `term_as_cause/2`,
  `cand_term_as_part` `term_as_part/1`.
- **QC1.** `cand_design` gives `god_as_second_cause(flagellum, efficient,
  god)` on every runtime and `cause_converted` where CV5 fires.
- **QC2.** `locke_essence` on `locke`: `ends_in_the_word(w_aurum,
  gold_form)` and `traced_in_thing(here, gold, formal, nature)`; on
  `thomist`, `grounded(a_gold, gold, gold_form)` and no trace.

## CAVEATS

- **The checker refuses; it does not affirm.** `grounded/3` says a chain
  of typed facts runs from a cause in a thing to a premise; it never says
  the concept fits the thing. Adequation is not computed.
- **No determinate tier 0.** Tier 0 stays "above tier 1 in authority,
  below it in determinacy". A conflict claimed between a definition and a
  finding is reported as reserved and never resolved; DH 3017 says its
  two diagnoses are the chief ones ("potissimum"), not the only ones. An
  author's readjudication belongs to no run of the public base.
- **Knower kinds, never persons.** The intellect library types powers;
  what anyone knows is never computed (rule 3).
- **The figures.** `plato` and `aristotle` take default's nine cause parts
  save the three excluded, a reading, not the record's. `no_exemplar` is
  one reading of *Metaphysics* XII.9: Thomas reads Aristotle's god as
  knowing all things in himself (*In XII Metaph.* lect. 11).
  `ockham_nominal`, a reading node warranted by the soul, carries the
  Ockham of *Ord.* I d. 35 q. 5.
- **Inherited rows.** QL1's rows below the documented nodes are the
  compiler's consequences of the record's DAG, not readings of the
  figures: Locke and his heirs expressing the ideas in the Word through
  Hooker; the moderns inheriting Scotus's matter, Leibniz and Kant among
  them, though Leibniz's primary matter is never without its entelechy
  [M].
- **Suárez on matter.** His matter has an existence of its own, distinct
  from the form's, and cannot naturally be without form (*DM* 13 s. 4
  nn. 13–14). Whether by divine power it can is owed, so `suarezian`
  holds no allele at `prime_matter`. Scotus is reached through Wolter
  and Gordon; the Latin of Vivès 12 is owed.
- **Mixtures.** Whether elements remain in act in a compound is not
  touched: material causes typed as substances stand, as *materia ex
  qua*. Prime matter, like form, is a principle and not a thing (I q. 45
  a. 4).
- **Created causes of being.** I q. 104 a. 1 allows created causes of
  being in a respect; only the maker of a becoming is typed.
- **The rendering's claimant.** `rendering_hyp` is hypothetical because
  the analogy of "driving force" to an end has no claimant in the record
  yet.
- **Expected and risky.** QD1, QN2, QV1 and QL1 are expected to hold;
  QN1 is the likeliest to turn something red, since the exemptions it
  joins are spread through the authority graph; QN3's three models rest
  on `fixed_by/3` being the only way a finding constrains its question.
- **"Nothing but" in the other direction** (the roadmap's Left) is not in
  this step.

## SEE ALSO

ttc-modernity(7), ttc-loci(7), ttc-linguae(7), ttc-empirica(7),
ttc-pendet(7), ttc-professio(7).
