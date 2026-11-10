# TTC-VERBUM(7)

## NAME

**ttc-verbum**: the cause in the thing and the premise resting on it, both
in the Word, the one as the idea before the thing, the other as judged in
the Word's light; Thomas's participated light and Bonaventure's eternal
reason contuited, as two alleles at a locus, computed both ways; the
intellect's light typed as God, and a thing seen in the Word as in an
object known in this life, refused on both; the Holy Office's censure of
ontologism at its own tier. Predictions, committed before encoding.

## DESCRIPTION

Read as the rules stand at `2e436b9` (`encode-rerum`: TTC-RERUM encoded
and scored, not yet merged, on `fcb4acd`, stacked on a docs-only branch
that changes no rule):

- **The form in three ways, two of them joined.** The case's text puts the
  form of soap "in the Word, before the thing, as its idea. In the soap, as
  its form. In our minds, after the thing, as its concept" (D1). TTC-RERUM
  joins the last two: a chain runs from `cause_of/3`, through the word, to
  an argument's premise, and is grounded where knowing ends in the thing
  (`grounded/3`). The first is reached only by an argument from the
  exemplar (`grounded_in_the_word/3`, `a_logos`). On `thomist`, `soap`
  says that `a_nature` rests on soap's end and its form through the words,
  and that soap's exemplar is the Son, through whom it was made; nothing
  says that the end and the form it argues from are the ones in the Word.
- **No light.** Nothing types by what light a premise is judged, or how
  that light stands to the Word. `knower` types powers; the agent
  intellect has no slot.
- **Two readings and no locus.** Thomas: the light in us is "quaedam
  participata similitudo luminis increati", and we know in the eternal
  reasons "sicut in cognitionis principio", not "sicut in obiecto
  cognito", which is how the blessed know (I q. 84 a. 5). Bonaventure:
  certain knowledge requires "ratio aeterna ut regulans et ratio motiva,
  non quidem ut sola et in sua omnimoda claritate, sed cum ratione creata,
  et ut ex parte a nobis contuita secundum statum viae" (*De scientia
  Christi* q. 4), and the second way, the eternal reason's influence alone,
  "insufficiens". Neither is entered.
- **Nothing refuses the ontologist's two claims.** A created intellect's
  light typed as God, and a thing seen in God as in an object known in this
  life, have no slot and no refusal, though both schools refuse them; the
  censure of 1861 is not on the authority graph.
- **The Word is named by no rule.** The Son is the one begotten
  (`gen(begetting, father, son)`, the part `trinity`); `made_through/2`
  names the person through whom a thing is made. Nothing says which person
  is the Word.

The discussion that found this: the essay on soap (D1), whose chair is
Bonaventure and whose Thomas puts the form in three ways, with the word we
say standing between the soap and our arguments; and the thought, after it,
that the cause in the thing and the cause in the argument are both in the
Word.

The proposal:

- **The Word** is the person begotten (I q. 34 a. 2).
- **Before the thing.** A formal or final cause of a natural thing, not an
  end of use, is in the Word before the thing, as its idea, where the
  thing's exemplar is the Word through whom it was made and the horizon
  holds the ideas in God (TTC-RERUM's `ideas_in_the_word` or
  `ideas_as_energies`).
- **The light,** at a new locus `lumen`, with two alleles. `participated`
  (Thomas): every grounded premise is judged in a light participated from
  the Word, its principle and not its object. `contuited` (Bonaventure):
  every grounded premise is judged under the eternal reason, as rule and
  motive, with the created reason; and where the cause it rests on is in
  the Word, that cause's idea is contuited in the judgment. On either,
  where the cause is in the Word before the thing, the cause and the
  premise are reported both in the Word.
- **Two refusals on both.** A created intellect's light typed as God (I
  q. 12 a. 2; I q. 84 a. 5; *Christus unus* n. 10); a thing seen in God as
  in an object known, by a created intellect, in this life (I q. 84 a. 5;
  *De scientia Christi* q. 4, which takes the eternal reason as contuited
  and never as seen).
- **The censure at its tier.** The Holy Office's decree of 1861 as a tier-3
  source that ontologism cannot safely be taught: it weighs, and deletes
  nothing.
- **A runtime,** `bonaventure`, extending `concordia`, whose comment
  already cites *Christus unus* nn. 18–19; `thomist` takes the other
  allele.

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited.

## THE TEXTS

The evidence record is `docs/research/verbum-sources.md`. [V] verified
against a fetched text; [S] through a named secondary source; [M] from
memory or a standard citation, owed in print. The loci that decide the
encoding:

| Text | Holds | Locus |
| --- | --- | --- |
| Thomas, knowing in the eternal reasons | "Uno modo, sicut in obiecto cognito"; "Alio modo … sicut in cognitionis principio"; in this life the soul "non potest videre omnia in rationibus aeternis", "sed sic … cognoscunt omnia beati"; the light "quaedam participata similitudo luminis increati"; "praeter lumen intellectuale in nobis, exiguntur species intelligibiles a rebus acceptae" | I q. 84 a. 5 [V] |
| Thomas, the created intellect | "ipsa intellectiva virtus creaturae non sit Dei essentia, relinquitur quod sit aliqua participata similitudo ipsius, qui est primus intellectus" | I q. 12 a. 2 [V] |
| Thomas, the light of glory | "lumen gloriae non potest esse naturale creaturae, nisi creatura esset naturae divinae, quod est impossibile" | I q. 12 a. 5 ad 3 [V] |
| Thomas, this life | no one in this life sees God's essence | I q. 12 a. 11 [M] |
| Thomas, the Word | the proper name of the Son; expressive and operative of creatures | I q. 34 aa. 2–3 [M] |
| Bonaventure, the third way | "ratio aeterna ut regulans et ratio motiva, non quidem ut sola et in sua omnimoda claritate, sed cum ratione creata, et ut ex parte a nobis contuita secundum statum viae" | *De scientia Christi* q. 4 corp., V, 23b [V, secondary] |
| Bonaventure, the species too | without the likenesses abstracted from the phantasm "non sufficit sibi ad cognoscendum lumen rationis aeternae, quamdiu est in statu viae" | *ibid.*, V, 24b [V, secondary] |
| Bonaventure, the second way | the eternal reason's "influentiam ejus solum", so that the knower "non ipsam rationem aeternam attingit": "insufficiens" | *ibid.*, V, 23a [S, Bougerol] |
| Bonaventure, the sermon | "Lux ergo intellectus creati sibi non sufficit ad certam comprehensionem rei cuiuscumque"; God "cooperatur sicut obiectum et ratio motiva"; Plato's way of wisdom "destruebat tamen viam scientiae", Aristotle's the reverse | *Christus unus omnium magister* nn. 10, 17, 18 [V] |
| The Holy Office | ontologism "tuto tradi non possunt"; seven propositions | decree of 18 September 1861, DH 2841–2847 [S; the propositions M] |
| Vienne | the soul needs the light of glory to see God | *Ad nostrum* (1312), DH 895 [S, owed] |
| *Benedictus Deus* | the blessed see the divine essence by intuitive vision | DH 1000 [M; `novissima.l`] |
| The case's text | "the form of soap is in three ways. In the Word, before the thing, as its idea. In the soap, as its form. In our minds, after the thing, as its concept" | "Soap, by Its Causes" (2026) [V] |

## THE DESIGN

Every slot is declared in the first file, in layer and `engine.FILES`
order, whose rules read it, and every sort in the first file whose slots
use it (`test_l`). `engine.FILES` gains `verbum.lp` after `rerum.lp`.
Every new violation and info atom is declared as a `result`. A rule whose
body joins a creature and a divine person has a check as its head (the
engine's lint).

### The Word and the light (`verbum.l`, a library)

The sort `lumen {participated, contuited}`, closed: how the light by which
a premise is judged stands to the Word.

Slots, entered:

- `light_of(K: knower, L: entity)`: the intellectual light of an intellect
  of kind K is said to be L.
- `seen_in(K: knower, X: entity, E: entity)`: an intellect of kind K is
  said to see X in E as in an object known, in this life.
- `light_participated/0`, `light_contuited/0`: the parts at `lumen`.

Rules:

- **The Word.** `the_word(W)`: W is begotten (`gen(begetting,_,W)`) and on
  the divine side of the line (I q. 34 a. 2). Nothing else names it.
- **Before the thing.** `before_the_thing(P, X, W)`: `cause_of(X, C, P)`, C
  formal or final; X natural (TTC-RERUM's `natural/1`); P not an end of use
  of X (`end_of_use/2`: the maker's end is in her, D1); `exemplar_of(W, X)`
  and `made_through(W, X)`; W the Word; the horizon holds the ideas in God
  (TTC-RERUM's `exemplar_in_god`).
- **The participated light.** With `light_participated`: for every
  grounded premise, `in_participated_light(A, W)`, W the Word; and where
  `grounded(A, X, P)` and `before_the_thing(P, X, W)`,
  `both_in_the_word(A, X, P, W, participated)`.
- **The eternal reason contuited.** With `light_contuited`: for every
  grounded premise, `under_eternal_reason(A, W)`; and where
  `grounded(A, X, P)` and `before_the_thing(P, X, W)`,
  `idea_contuited(A, P, W)` and `both_in_the_word(A, X, P, W, contuited)`.
- **The refusals.** `light_typed_uncreated(K, L)`: `light_of(K, L)`, K not
  `divine`, L on the divine side. `seen_in_the_word_in_via(K, X, E)`:
  `seen_in(K, X, E)`, K not `divine`, E on the divine side. Both on every
  runtime; God's knowing all things in his Word is no fault.

No rule writes `cause_of/3`: Bonaventure's motive reason is typed as a rule
of the judgment, not as a cause among its causes, so TTC-RERUM's
`god_as_second_cause` has nothing to read from it.

Results: `before_the_thing/3`, `both_in_the_word/5`,
`in_participated_light/2`, `under_eternal_reason/2`, `idea_contuited/3`,
`light_typed_uncreated/2`, `seen_in_the_word_in_via/3`.

### The locus and the runtimes (`schools.l`)

- `locus lumen`: `allele participated = light_participated`, `allele
  contuited = light_contuited`.
- `thomist` adds `light_participated` (I q. 84 a. 5).
- `runtime bonaventure extends concordia`, adding `light_contuited`
  (*De scientia Christi* q. 4; *Christus unus* nn. 10, 17–19).
- `vm_bonaventure`, its guest part, holding what `vm_concordia` holds.

### The cases (`icon_history.l`)

- `cand_ontologism` (with `soap` and `trinity`): `light_of(human, son)`,
  the light the knowledge of God itself; `seen_in(human, soap, son)`; and
  beside them `seen_in(divine, soap, son)`, God's knowing.
- `cand_motive_as_cause` (with `soap` and `trinity`): the eternal reason
  typed as an efficient cause among the causes of a judgment,
  `cause_of(j_soap, efficient, son)` and `cause_of(j_soap, efficient,
  agent_intellect)`.
- `ontologism_1861` (a case): `holy_office_1861`, a dicastery's act at
  tier 3, `truth`, 1861, as the record enters the Holy Office's acts of
  1820 and 1957; `q(ontologism_safe_to_teach)`, yes or no; the decree
  supports no.

### Files

`verbum.l` (new), `schools.l`, `icon_history.l`, `engine.py`, the guide in
both copies (a section on the Word and the light, after THINGS BY THEIR
CAUSES), the suite, `tests/test_l.py`, `tests/test_interface.py`,
`tests/test_schools.py`, `docs/l.md`, the roadmap, and `CLAUDE.md`'s
libraries row.

## PREDICTIONS

Runtimes: the 45 at `2e436b9` and `bonaventure`, 46. "Every runtime"
means all 46, each with the parts named. `soap` runs with `trinity` and
`world`, as TTC-RERUM runs it.

Predictions can fail against the base: they say how the new rules meet the
old ones. Mechanics check that the encoding does what the design says;
they are scored apart.

### Predictions

- **VB1. The locus, as the compiler gives it.**

  | Locus | Expressed | Runtimes |
  | --- | --- | --- |
  | `lumen` | `participated` | `thomist`, `hooker`, `episcopate_1891`, `social_catholic`, `locke`, `locke_wl`, `smith`, `angers`, `george`, `george_hn` (10) |
  | | `contuited` | `bonaventure` |
  | | none | the other 35 |

  No `re_expressed`. At TTC-RERUM's four loci, `bonaventure` is as
  `concordia`: `ideas` `in_the_word`, carrying `subsisting` and
  `no_exemplar`; `terminus` `in_the_thing`; `adaequatio` `by_things`;
  nothing at `prime_matter`.
- **VB2. Before the thing.** On `soap`: `before_the_thing(P, soap, son)`
  for P `amphiphilic_form` and `interfaces_end`, on the 13 runtimes whose
  ideas are in God (the 12 of `in_the_word`, `bonaventure` among them, and
  `palamite`), and on no other. Never for `cleaning`, an end of use, nor
  for `fat`, `lye`, the soap-maker or the bar.
- **VB3. Both in the Word, both ways.** On `soap`:
  `both_in_the_word(a_nature, soap, P, son, participated)`, for the two P
  of VB2, on `thomist`, `hooker`, `episcopate_1891` and `social_catholic`,
  the four of `participated` where knowing ends in the thing;
  `both_in_the_word(a_nature, soap, P, son, contuited)` on `bonaventure`;
  on no other runtime, `concordia` and `palamite` included, though VB2
  holds there. Never of `a_maker` (its cause is an end of use) or of
  `a_god` and `a_logos` (no chain).
- **VB4. What each allele reaches.** On the four:
  `in_participated_light(a_maker, son)` and `in_participated_light(a_nature,
  son)`, and no `idea_contuited`. On `bonaventure`:
  `under_eternal_reason(a_maker, son)` and `under_eternal_reason(a_nature,
  son)`, and `idea_contuited(a_nature, P, son)` for the two P of VB2, and
  none for `a_maker`. On the six other runtimes of `participated`, where
  knowing does not end in the thing, nothing of the light.
- **VB5. The ontologist's claims, refused on both and everywhere.**
  `cand_ontologism` gives `light_typed_uncreated(human, son)` and
  `seen_in_the_word_in_via(human, soap, son)`, and nothing for
  `seen_in(divine, soap, son)`, on every runtime, `bare` included.
- **VB6. The censure at its tier.** `ontologism_1861`, run alone, gives on
  every runtime: `q(ontologism_safe_to_teach)` no in the main branch, yes
  a live shadow cleaved by `holy_office_1861`, no `t2`; nothing deleted,
  and the case adds no violation.
- **SU1. No other change.** Every scenario before the encoding gives the
  same atoms in every model, main against the branch, compared as
  TTC-RERUM's QD1 was. Save what follows, each restated with its reason
  (rule 7):
  - `test_l`: the runtime set gains `bonaventure`; `thomist`'s
    hand-written parts gain `light_participated`; the closed sorts gain
    `lumen`; the pins of a layer runtime's `loci` gain `lumen` (with
    `test_interface`'s).
  - `test_schools`: the 36 runtimes of the step before become 37.
  - TTC-LOCI AL1, the declared loci, gains `lumen`.
  - TTC-RERUM's checks that fix runtime tables or counts count
    `bonaventure` where they count `concordia`: QL1 (its rows
    `in_the_word`, 12, and `in_the_thing`, 28; `by_things` 42), QL2
    (nothing, 20), QT6 (nothing, 19), QT8 (all three; `a_logos` on 15).
    Those that read the loci from the compiled table (QT4, QT5, QL3, QV1)
    take it without a restatement.
  - The checks that table every runtime place `bonaventure` in
    `concordia`'s row: AL2 and AL3 (nothing), PE2 and PE4 (nothing). DG1
    needs no restatement: one parent, no clash.
  - CL1 and PR4 stay clean.
- **SU2.** Every new rule and slot has a test that fails without it. Both
  copies of the guide gain the vocabulary identically.

### Mechanics

- **VQ1.** Without `trinity`, nothing of VB2–VB4 on any runtime: no
  person is begotten, so none is the Word.
- **VQ2.** `cand_motive_as_cause` gives `god_as_second_cause(j_soap,
  efficient, son)` on every runtime, and nothing for the agent intellect.
  `soap` on `bonaventure` gives no `god_as_second_cause`.
- **VQ3.** `light_of(divine, son)` gives no `light_typed_uncreated`, nor
  does `light_of(human, agent_intellect)`.
- **VQ4.** `locke_essence`, with `trinity`, on `thomist`:
  `in_participated_light(a_gold, son)` and no `before_the_thing` (the case
  names no exemplar of gold).
- **VQ5.** `vm_bonaventure` holds as its host does (VM3).

## CAVEATS

- **The checker refuses; it does not affirm.** `both_in_the_word/5` says
  that typed facts run from the Word to a cause in a thing, and from the
  thing through the word to a premise, on a horizon that holds the light
  one way or the other. It never says that the premise is true, or that
  anyone knows it (rule 3). Bonaventure's "certitudo ex parte scientis"
  (*Christus unus* n. 9) is not typed.
- **Two readings, neither refused.** The Church has not decided between
  them, and neither allele refuses the other. Whether Thomas's
  participated light is what Bonaventure calls the second way, influence
  alone, is disputed; the checker does not compute it.
- **The sermon's "obiectum".** *Christus unus* n. 17 has God cooperating
  in the intellectual act "sicut obiectum et ratio motiva". The allele
  reads the sermon by the disputed question, which says "ex parte", "cum
  ratione creata", "non … in sua omnimoda claritate": contuition is not
  `seen_in/3`. Ontologism claimed descent from Plato and Augustine (A1);
  whether the censure of 1861 touches contuition is not computed.
- **Library, not deposit.** The two refusals rest on texts both schools
  hold (I q. 12 a. 2; I q. 84 a. 5; *De scientia Christi* q. 4). Vienne's
  DH 895 is reached only through a secondary report, and *Benedictus Deus*
  is the last things' library's; neither is read here. A deposit rule for
  the light of glory is a later step, once DH 895 is in print.
- **The censure's words.** The decree enters by its note, "tuto tradi non
  possunt", at tier 3, the tier the record gives the Holy Office's acts;
  its seven propositions are owed (DH 2841–2847) and are not entered. A
  note that a doctrine cannot safely be taught is not a definition (c. 749
  §3).
- **Rosmini.** *Post obitum* (1887, DH 3201–3241), and the Congregation's
  note of 1 July 2001 on that decree's force, a later act speaking of an
  earlier one's (rule 14), are owed to a later step.
- **The Word named by begetting.** On a run without `trinity`, nothing
  names the Word, and nothing of the light is reported (VQ1). The light is
  the Word's for every grounded premise (John 1:9), not only for premises
  about things made through him.
- **The end of use.** A maker's end is in her mind, as the case's text has
  it, and so not before the thing in the Word as its idea. Whether it is in
  God's providence (I q. 22 a. 2) is not typed.
- **Inherited rows.** `participated` reaches the Lockeans through Hooker,
  and `angers` through both its parents: the compiler's consequences of the
  record's DAG, not readings of the figures. Where knowing ends in the
  idea, nothing of the light is reported.
- **The figures.** `bonaventure` takes `concordia`'s parts and adds the
  light. His hylomorphism of spiritual creatures and plurality of forms
  are not encoded. Christ the medium of all the sciences (*Collationes in
  Hexaëmeron* I) is not typed: it is reached only through a secondary
  source. The palamite runtime has no allele at `lumen`: the uncreated
  light of Tabor is not the light by which natural truths are judged.
- **Expected and risky.** VB1, VB5 and VB6 are expected to hold. VB3 and
  VB4 rest on TTC-RERUM's chains being grounded on exactly the 28 of
  `in_the_thing`; SU1's restated counts are the likeliest to be wrong,
  since the step before missed nine such tables.

## SEE ALSO

ttc-rerum(7), ttc-loci(7), ttc-novissima(7), ttc-pendet(7),
ttc-schools(7).
