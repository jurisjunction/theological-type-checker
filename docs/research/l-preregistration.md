# TTC-L(7)

## NAME

**ttc-l** — L, a language for the checker's libraries, compiled to clingo:
kinds of declaration as metaclasses, runtimes by inheritance with three
combinators, slots declared once with sorts, layers and sentences, parts
that name their case; premises kept apart from conclusions, and nothing
read from the checker's word about itself; predictions, committed before
encoding

## DESCRIPTION

The base as committed. Its rule files are those the empirical step was
scored on (94d7d8d), unchanged since; the counts are of them.

- **Written by hand.** 27 rule files, 442,337 bytes, 6,183 lines; 480
  `#program` parts. `server._kind` sorts them by name and file: 251
  switches, 128 candidates, 49 cases, 39 dates, 9 models, 3 searches. The
  cases of `canon_cases.lp` are sorted as switches.
- **Slots by comment.** 350 `% @input` tags (and one more inside a comment,
  showing the form) name 292 predicates. 33 are tagged in more than one
  file, with different texts; 75 tags name a predicate some rule derives,
  a cross-reference rather than a slot. Of the 386 predicates the base
  reads and never derives, 169 carry no tag, 50 of them read first in
  `icon_authority.lp` (`source/4`, `supports/3`, `character/2`, ...).
- **Norms by comment.** 87 `% @norm` tags (86 with a URL; `checking`, a
  display norm, has `-`), 17 `@end`, one `@temporal`, one `@recursive`,
  five `@stratum`; 12 files marked `@library`.
- **Runtimes in Python.** Six named lists in `engine.RUNTIMES`. Three
  repeat `default` and add to it; the Palamite list repeats `classical`
  and leaves out `one_power`. Nothing says which it inherits or drops.
- **No sorts.** No argument of any slot has a type. A fact outside its
  intended values (a character the rules do not know, a force misspelled)
  passes in silence; the one typed check is `untyped_presence` (kernel).
- **Layers by hand.** `server.THEOLOGY_ONLY` (15 names) and `CANON_ONLY`
  (14) decide which side of a case a fact may go on.
- **No case.** A switch or candidate does not say which case it belongs
  to; a held-out set lists parts by name.
- **Interiors unmarked.** An `interior/3` entered, supplied or disputed,
  leaves no atom saying so (rule 3); the reminder is the reader's.
- **Conclusions writable.** A snippet may write any predicate, premise or
  conclusion. With an encyclical (tier 3, 1990) for `yes` on a doctrinal
  question and a blog post (tier 5, 2026) for `no`: `yes` settled, `no` a
  shadow. Add the fact `eff_tier(blog,1).` and `no` is settled, `yes`
  excluded, with no warning: a tier taken on the writer's word (rule 14).
  `theorem(anything_i_like).` comes back in every branch;
  `:- holds(q(x),yes).` excludes `yes` by fiat. The `unknown_slot` gate
  passes all three, since the base knows those predicates. One slot is a
  conclusion in a premise's clothes: `hypothetical_warrant/1` makes a
  source warranted (`icon_authority.lp`), and a snippet may write it. Rule
  6 keeps hypothetical facts in switches marked `HYPOTHETICAL`; of the four
  parts that write it, two are so marked (`empirical_kind_hyp`,
  `reception_fixed_hyp`); `tier2` calls its warrant "synthetic", and
  `hypothetical_definition` says so only in its name.
- **The checker's word about itself.** `ttc://grammar` describes the base;
  no rule reads it. The test that compared the gate with the grammar's
  vocabulary computed both from one function and could not fail for the
  reason that mattered; it was replaced (before this file) by a test
  against the guide, which a person wrote. That test found the guide
  naming `verdict/3` and `obligation/2` where the base writes
  `info(verdict(...))` and `info(obligation(...))`.

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited.

## THE LANGUAGE

Fixed here. An `.l` file is a sequence of declarations and fenced clingo,
in `src/theological_type_checker/l/`, one per rule file. `ttc-l build`
compiles them to `lp/`; the compiled files stay checked in, and are what
the solver reads and every stamp points at. `ttc-l check` fails on any
byte of difference between the sources and the compiled base.

```
layer authority                       -- the file's layer; its slots' layer

sort tier 0..5                        -- closed: a range
sort force {truth, juridical, protective}   -- closed: values
sort source                           -- open: named, not enforced

slot source(S: source, T: tier, F: force, Y: year)
  means "a source at tier T, of force F, from year Y"
  say "{S} is a source at tier {T}, of force {F}, from {Y}"

use in_force/1 "icon_authority.lp"    -- read here, declared or derived elsewhere

norm cic1917:748 | Codex Iuris Canonici (1917), c. 748 | https://www.iuscangreg.it/cic1917.php
stratum cic:842 divine
temporal cic2021:1379

part case                             -- annotates the fence below
part switch of sspx
part candidate of galileo

runtime palamite extends default
  exclude one_power
  add simplicity_palamite, palamite_energies, monopatrism,
      no_divine_contraction, grace_uncreated
runtime thomist_variant extends thomist
  alter simplicity_thomist -> simplicity_scotist

library                               -- read by norms.py as @library
```

Raw clingo sits between fence lines (```` ```clingo ```` and ```` ``` ````)
and is copied byte for byte. L never reads inside a fence except to check
that a `part` annotation stands before a fence opening with `#program`; a
part's name is read from that line, never written twice. Lines beginning
`--` are L's comments and are not compiled.

**Rendering.** `slot` and `use` render as `% @input` lines, the text
given (`means`, or the `use` note) after the bar; `norm`, `stratum`,
`temporal`, `recursive`, `end` and `library` render as their tags. A tag
rendered from an existing line keeps its text exactly. Runtimes compile to
`runtimes.json`, which `engine` reads. Sorts, sides, sentences, parts'
kinds and cases compile into `ttc://grammar`, not into the rule files.

**Metaclasses.** Each kind of declaration (layer, sort, slot, use, norm,
part, runtime, library, fence) is a class in the compiler with a parse, a
check and a render; a new kind is a new class. They are not exposed to
the author.

**Runtimes.** A runtime is a set of parts, kept in the order of first
mention. `extends` takes one or more parents; `add` appends, `exclude`
removes, `alter X -> Y` puts Y where X was. A runtime records what it
excludes, and inherits that record. Two parents **clash** on a part that
one has and the other excludes (`alter` excludes what it replaces). A
clash fails to compile, naming the part, until the child says `add`,
`exclude` or `alter` for it. No order is chosen between parents.

**Slots, declared once.** A predicate the base reads and never derives is
a slot, declared by one `slot` in the lowest layer whose rules read it;
every other file that tags it says `use`. Layers, lowest first: kernel
(`kernel_core`, `kernel_analogy`, `kernel_world`); theory (`icon_theory`,
`icon_models`, `icon_tests`); schools (`schools`, `icon_metaphysics`);
authority (`icon_authority`, `icon_history`); libraries (`act` …
`empirica`); canon (`canon_law`, `canon_cceo`, `canon_cases`); pair;
library. Sides for a case: theology (kernel to libraries), canon (canon,
pair), either (library).

**Premises, not conclusions.** A snippet, and a case saved with
`save_case`, writes premises: declared slots, helpers of its own (written
and read in the snippet), and constraints that read only those and
`read_as/2` (the guide's way to fix a reading). A head, or a constraint,
on a predicate the base derives or shows and no `slot` declares is
refused at a new gate, `conclusion`, naming the predicate. A slot declared
`hypothetical` (`hypothetical_warrant/1`) may be written only in a part
whose `#program` line is marked `HYPOTHETICAL` (rule 6); the compiler
refuses any other part that writes it, and the gate refuses it in a
snippet or a case. `fix_method`
and `save_rules` are not gated: they change the theory, and answer to the
suite. The predicates rule 14 computes (`eff_tier/2`, `in_force/1`, the
warrants) are derived, never slots.

**The checker's word about itself.** Nothing in the rule base reads what
the checker or L says about the checker: not the grammar, not a part's
kind or case, not a runtime's parents, not a sentence. `in_sort/2` is read
only by the generated domain rules, which check input against a declared
sort as `untyped_presence` checks a presence against its modes;
`outside_domain` names a slot as the label of that check and no rule
reads it. After RG1, `ttc-l check` guards against hand edits and is not
evidence: the evidence stays the suite's expectations, written by hand,
and the stamp. The grammar carries its caveat: a claim, never evidence
that the checker is right.

**Domains.** A closed sort compiles to `in_sort(Sort,Value)` facts, and
each slot argument of a closed sort to one rule, in a section headed
`% ---------- domains (L)` at the end of the slot's file:

```
violation(outside_domain(source,3,F)) :- source(_,_,F,_), not in_sort(force,F).
```

Closed sorts are taken from the guide's tables: tier, force, question
kind, papal form, character, conciliar act, condition shown, object,
presence mode, nature, sacrament kind, teaching type, valence. Open sorts
(sources, questions, persons, acts, years, dates, …) are named and served,
not enforced.

## METHOD

In stages, each its own commit, each with the whole suite, the schools'
boots and a snapshot of every scenario's atoms against the one before:

1. A converter (`tools/lp2l`, used once) writes each rule file as an `.l`
   file, one fence per `#program` block, every tag lifted; the compiler;
   `ttc-l build` and `check`. RG.
2. Runtimes in `schools.l`, compiled to `runtimes.json`; `engine.RUNTIMES`
   read from it. RU.
3. Slots declared once: a `slot` for each untagged input, `use` for the
   rest; parts' kinds checked by hand against `_kind`. SO, LY.
4. Sorts and domains. TY.
5. Cases and sentences: `of` on switches and candidates, `say` on every
   slot. OF, SY.
6. `info(interior_supplied(P,A,X))` in `act.l`. IS.
7. `ttc://grammar` and `save_case` read L; the hand lists removed. M5.
8. The `conclusion` gate, on snippets and on cases. CG, SR.

From stage 1 on, rule files are edited in `.l` and compiled; CLAUDE.md,
the guide and the encoding guide say so.

## PREDICTIONS

### RG: regeneration

- **RG1.** From the converted sources, `ttc-l build` writes all 27 rule
  files byte for byte as committed; a test compares every byte.
- **RG2.** With every tag lifted (350 `@input`, 87 `@norm`, 17 `@end`, one
  `@temporal`, one `@recursive`, five `@stratum`, 12 `@library`) and every
  part annotated, the 27 files stay byte-identical. The one `@input`
  inside a comment stays in its fence.
- **RG3.** An edit to a compiled file by hand fails `ttc-l check`, and the
  test with it.

### RU: runtimes

- **RU1.** The six runtimes written by inheritance: `bare` empty;
  `default` adds `classical`, `one_power`; `thomist`, `scotist` and
  `suarezian` extend `default` with `add`; `palamite` extends `default`,
  excludes `one_power`, adds its five. Compiled, they equal
  `engine.RUNTIMES` as committed, order included; the schools' boot and
  pair tables do not change.
- **RU2.** `alter` puts its part in place of the one replaced (a test).
- **RU3.** A clash between two parents fails to compile, naming the part;
  the child's combinator compiles it (tests for `add`, `exclude`,
  `alter`). No parent order decides.
- **RU4.** A runtime naming a part the base lacks fails to compile; today
  it fails only when run.

### SO: slots, declared once

- **SO1.** Each of the 386 predicates read and never derived (counted at
  94d7d8d) has exactly one `slot`, in its declaring file, which gains a
  `% @input` line where it has none: at least the 169 untagged, comments
  only. Every other tag of a slot, and every tag of a derived predicate,
  becomes `use`, its text kept. No output changes.
- **SO2.** The kinds L declares for parts differ from `_kind` for the
  cases of `canon_cases.lp` and for fewer than 40 parts besides; each
  difference listed in SCORING.
- **SO3.** Every `use` names a predicate some file declares or derives; a
  `use` of one nothing does fails to compile. None does today.

### LY: layers

- **LY1.** The side read off the file that declares or derives each of
  the 29 names in `THEOLOGY_ONLY` and `CANON_ONLY` agrees with the list
  that holds it. A
  disagreement is a finding: the hand list or the layer order is wrong,
  and SCORING says which.
- **LY2.** `save_case` refuses a fact of any slot on the wrong side, not
  only the 29; a test with a slot outside the old lists. The hand lists
  are removed.

### TY: sorts and domains

- **TY1.** Every slot argument has a sort; every closed sort is declared
  once, in the lowest layer that uses it.
- **TY2.** A fact with an argument outside its closed sort, entered in a
  snippet: `violation(outside_domain(Name,Position,Value))`; inside: none.
  A test per closed sort.
- **TY3.** The base's own facts: between 1 and 30 outside the domains as
  the guide gives them, in at most three slots, most of them
  `character/2`. Each is scored: the guide's table widened (a value the
  rules read, stated in the guide), or the fact retyped (rule 7, stated).
  After scoring, none.
- **TY4.** The gate's `unknown_slot` accepts what it accepts today; the
  summary's `schema` stays 1.

### OF: parts and their cases

- **OF1.** Between 100 and 250 of the 379 switches and candidates name a
  case with `of`; the rest belong to a model, a school or nothing, and say
  nothing. Every `q(...)` term in a part `of C` is a question of C or of no
  case.
- **OF2.** `of` changes no rule file; the grammar serves it.

### SY: sentences

- **SY1.** Every slot has a `say` naming each argument once; a test
  renders every template with its arguments and finds no unknown name. No
  rule file changes.

### IS: interiors supplied

- **IS1.** `act.l` adds `info(interior_supplied(P,A,X))` for every
  `interior/3` supplied, and for every one disputed, in every branch. In
  the snapshot the only change is these atoms, in exactly the scenarios
  that enter `interior/3`. Nothing about the interior is derived (rule 3).

### CG: premises, not conclusions

- **CG1.** The three of DESCRIPTION refused at the gate `conclusion`, each
  naming its predicate (`eff_tier/2`, `theorem/1`, `holds/2`); with them
  removed, the run is as before. Accepted: `:- not read_as(s,r).`, a
  helper the snippet writes and reads, and a slot some rule also derives
  (`event_date/2`).
- **CG2.** None of the suite's snippets is refused, and no expectation
  changes.
- **CG3.** `save_case` refuses a case writing a conclusion on either side,
  with the same refusal.
- **CG4.** No predicate rule 14 computes is declared a slot; a test lists
  them (`eff_tier/2`, `in_force/1`, `warranted/1`, `received/1`,
  `oum_holds/1`) and fails if one is.
- **CG5.** `hypothetical_warrant/1` is declared `hypothetical`. `tier2` and
  `hypothetical_definition` gain the `HYPOTHETICAL` mark on their
  `#program` lines (comments only; no output changes); the compiler then
  accepts all four, and refuses a fifth part without the mark (a test). In
  a snippet, `hypothetical_warrant(blog).` is refused at `conclusion`.

### SR: the checker's word about itself

- **SR1.** No rule body in the compiled base reads `outside_domain`, and
  only the generated domain rules read `in_sort/2`; a test scans every
  rule body.
- **SR2.** No rule body reads anything compiled into the grammar alone
  (parts' kinds and cases, runtimes' parents, sentences, sides): those
  never reach a rule file (OF2, SY1), and a test checks that each
  compiled rule file is unchanged when they are removed from the sources.

### M: meta

- **M1.** Through RG, RU, SO, LY, OF and SY, no scenario's output changes.
  Through TY and IS, only the atoms predicted there are added.
- **M2.** The norm graph does not change (87 norms, 315 edges); CL1 and PR4
  stay clean.
- **M3.** Every generated domain rule and the IS rule has a test that fails
  without it; the compiler has a test per kind of declaration and per
  combinator.
- **M4.** The whole suite (563) and the schools' tables pass on the
  compiled base after every stage.
- **M5.** `ttc://grammar` reads L: slots with their sorts, side, file,
  `means` and `say`; closed sorts with their values; parts with kind and
  case; runtimes with parents and combinators; its caveat kept. It gains
  `grammar_schema`, 2 (the shape first served, 3440b0b, counts as 1).
  `check`'s summary keeps `schema` 1; the refusal's gates gain
  `conclusion`.

## CAVEATS

L declares; it does not replace the rule language. Rules stay clingo in
fences, more than nine lines in ten of the base, and are checked by
clingo, not by L. Byte identity tests the compiler, not the theology.

The `conclusion` gate is only as strong as the slot declarations: a
derived predicate declared a slot by mistake reopens the hole, which is
why CG4 lists the ones rule 14 needs closed. A person who wants a
conclusion as a premise (a hypothetical tier, say) writes it as a switch
in the base, marked `HYPOTHETICAL` (rule 6), where the suite sees it.

The layer order and "the lowest layer that reads it" are this step's
choices; LY1 tests them against the hand lists, not against a source.
Domains are as complete as the guide's tables; a value outside them may be
the guide's omission. `means` keeps each tag's text as written, which
often repeats the arguments.

Not in this step: the layer test as a compile error (a rule reading a
predicate derived only in a higher layer); open sorts enforced; modal
type, tier and date as slots on a rule; the personal layer (it stays
clingo); grounding once and solving many; the suite's scenarios as data,
beyond those this step touches.

## STANDARDS

- J. Lethen, "Computational Theology: A Metaobject-Based Implementation of
  Models of Generalised Trinitarian Logic", *TheoLogica* 6/2 (2022)
- G. Kiczales, J. des Rivières, D. G. Bobrow, *The Art of the Metaobject
  Protocol* (1991)
- K. Barrett et al., "A Monotonic Superclass Linearization for Dylan",
  OOPSLA 1996: the linearization refused here
- M. Gebser et al., *Potassco User Guide*; clingo 5.8
- The requests of the tool that trains on the checker's output (typed
  slots, one layer per slot, switches naming their case, `say`, an info
  atom per interior, scenarios as data)
- M. H. Löb, "Solution of a Problem of Leon Henkin", *JSL* 20 (1955); H.
  B. Curry, "The Inconsistency of Certain Formal Logics", *JSL* 7 (1942):
  a system that takes its own word as warrant proves anything

## SEE ALSO

[ttc-roadmap(7)](../roadmap.md), [ttc-schools(7)](schools-preregistration.md),
[ttc-empirica(7)](empirica-preregistration.md), [ttc-mcp(8)](../mcp.md),
[ttc-encoding(5)](../encoding-guide.md)

## SCORING

Appended stage by stage. Predictions committed in e69e70a, stamped in
4357243. Stage 1 (RG) is 3fc3601, stage 2 (RU) 0b7ad94, stage 3 (SO, LY)
2796019, stage 4 (TY) 567c741, stage 5 (OF, SY) d2cf622; stage 6 (IS)
the commit that adds its row.

| | Result |
| --- | --- |
| RG1 | Held: the 27 rule files compile byte for byte. |
| RG2 | Held: every tag lifted (350 `@input` as 199 `slot` and 151 `use`; 87 `norm`, 17 `end`, one `temporal`, one `recursive`, five `stratum`, 12 `library`), all 480 parts annotated; 92.3% of lines stay in fences. The one `@input` inside a comment stays in its fence. |
| RG3 | Held. |
| RU1 | Held on the first compile, order included; the test's expectation is the table `engine.py` held, pasted. |
| RU2 | Held. |
| RU3 | Held, in either parent order; each combinator settles a clash. |
| RU4 | Held. A parent never declared, a cycle and a runtime declared twice are refused too. |
| SO1 | Held for the 386, with the definition amended (below). Each has one `slot` in its declaring file; 187 gained an `@input` line, the 169 untagged and 18 tagged only elsewhere; 13 slots of the amendment gained one too: 200 lines. 28 tags in the declaring file became `slot`, two `slot`s became `use` (LY1); every text kept. The rule files changed by those 200 lines and 11 blank lines; no scenario's atoms changed (563 compared). |
| SO2 | Held in form: L's kinds differ from `_kind` for nine parts, all of `canon_cases.l`, and none besides. Not as expected: most of that file's hypothetical parts are switches (below). |
| SO3 | Held: none does. The compiler also refuses a slot declared twice and a slot no rule reads (tests). |
| LY1 | 27 of 29 agree. `consecration/4` and `absolution/4` disagree, and the hand list is right (below). |
| LY2 | Held: `save_case` reads each slot's side from L; the hand lists are removed. Tests with `premise/3`, `conciliar_act/2` and `oum_claimant/2`, none on the old lists; `interior/3` and `classification/3` go on either side. |
| M1 | Held through RG, RU, SO and LY: no scenario's atoms changed. |
| M2 | Held: 87 norms, 315 edges; CL1 and PR4 clean. `custom_asof/0`, now declared in `saeculum.l`, showed as an unused input: norms.py does not read the clock's predicates (`BUILTIN`), and now counts none of them unused (a test). |
| M4 | Held after each stage: the suite and the schools' tables. |
| TY1 | Held: every argument of the 407 slots with arguments has a sort. 65 sorts, each declared once in the lowest layer whose slots use it (a test): the 13 closed, 52 open. |
| TY2 | Held: one test enters a value outside its sort for each of the 40 domain rules, through a snippet, and finds each `outside_domain`; inside, none. All 13 closed sorts. |
| TY3 | In part. Five facts outside, in the range; but in four slots, not three, and none of `character/2`. Four scored (below); one remains, a candidate's. |
| TY4 | Held: `unknown_slot` warns on `in_sort/2` as before; `schema` stays 1. |
| M1 (TY) | Held: one atom added, `violation(outside_domain(present,3,located))` in PM1b, the candidate TY3 leaves. |
| OF1 | Held: 115 of the 371 switches and candidates name a case. Of the rest, 27 are a runtime's parts, and the others a model's, a school's, the creed's, or no case's. Every `q(...)` term in a part `of C` is a question C states, or one no case states (a test). |
| OF2 | Held: no rule file changed (a test strips `of` and compiles). The grammar serves it at M5. |
| SY1 | Held: every slot has a `say` naming each argument once, written by hand (425); a test renders each with its arguments and finds no name left. No rule file changed. |
| M1 (OF, SY) | Held: no rule file changed byte for byte, so no output did. |
| IS1 | Held: `act.l` names every `interior/3` supplied, and every one disputed, in every branch (two rules, each with a test that fails without it). In the snapshot the only change is these atoms, in 83 scenarios: the 80 whose parts supply or dispute an interior, and three of `c915_case` (MS3, MS5, MS5b), where c. 916 itself disputes one. No rule reads the atom (a test); nothing about the interior is derived. |
| M1 (IS) | Held: only the atoms IS1 predicted. One test went red, FD4 (rule 7): it asked that no atom name `doubt_r`, meaning no censure and no canon, and the new atom names the pertinacity the case claims for it. The name is left aside; the check is otherwise as it was. |

### The slot, amended (SO1; rule 7)

The stamped definition, a predicate read and never derived, leaves out
the central inputs: `source/4`, `supports/3`, `question/1`, `value/2`,
`question_kind/2`, `character/2`, `papal_form/2`, `interior/3`. Some rule
derives each (the consensus a source of its own, a case's conditional
facts, a choice where a fact is disputed). DESCRIPTION named `source/4`,
`supports/3` and `character/2` among the 386 untagged: a mistake of the
count's description, not of the count. CG1 already spoke of "a slot some
rule also derives", and CG2 needs these as slots, or every case writing a
source is refused at the gate.

Amended: a slot is a predicate the base reads that a case enters. Either
no rule derives it (386), or the guide gives it to enter though a rule
derives it: 37 from the first column of its fact tables, two named in its
prose (`appears_otherwise/2`, `interpretation_form/2`). 425 in all. The
guide is a person's word, not the checker's. Measured and refused: any
predicate a case, model, date or search writes as a fact. That would make
slots of `of_kind/2` (the pair's computed classification, which the model
`asexual` writes), and of `has/2` and `held_for/3` (derived from
`holds/2`): conclusions the gate must refuse. `event_date/2`, CG1's
example, is no slot: no case enters it, and the guide gives `act_date/2`.
CG scores it.

### Not predicted

- **Absolutions and consecrations are the canon layer's** (LY1). The
  lowest layer that reads them is the libraries (`sacrament.l`, a library
  reading the canon layer's input, as its tag says), and the hand list
  puts them on the canon side. The guide routes them from the canon
  layer. The rule, not the list, is wrong for a predicate a library reads
  from a higher layer: the two are declared in `canon_law.l`, the only
  exceptions, listed in the test.
- **The libraries serve both sides.** THE LANGUAGE put them on the
  theology side. The guide's CANON table gives library slots to the canon
  side (`interior/3`, `age_at/3`, `juridic_person/1`, `law_kind/2`,
  `reaches/3`, `needs_reading/2`), and the parts of `canon_cases.l` write
  them in 509 statements, in 79 of 123 parts. Their slots (130, with the
  library's) go on either side.
- **A case states its questions** (SO2, checked by hand, then written as
  a test). A part, not a candidate, model, date or search, is a case where
  it writes `question/1`, or where it bears the name of one that does (the
  canon half of a case). Every other part is a switch, loaded with a case
  or model to change it. This reproduces `_kind` everywhere but nine parts
  of `canon_cases.l`: `sspx`, the canon half of the case, and eight
  hypothetical cases with their own questions (`act_fear`, `law_cases`,
  `moral_cases`, `c915_case`, `seal_case`, `prudential_case`,
  `c1399_case`, `fiction_acts`). The file's other hypothetical parts state
  no question: they add acts to questions the authority files state, and
  stay switches, `trolley`, `eucharist_case` and `marriage_cases` among
  them. Rule 6's "switch programs" are parts loaded by name; what it
  requires is the mark, and the mark is CG5's.
- **22 parts of `canon_cases.l` enter theology** (house rule 1): the
  eight cases above; four candidates (`cand_art6_moral`,
  `cand_sin_of_christ`, `cand_state_is_evil`,
  `cand_law_types_the_substance`); and ten parts of theology filed with the
  canon cases (`grace_cases`, `cand_pelagian`: `justification/2`;
  `christ_acts`, `cand_one_theandric_operation`,
  `cand_father_acts_humanly`: `in_nature/2`; `cand_god_located`,
  `cand_angel_circumscribed`, `cand_bilocation`,
  `cand_father_in_the_host`, `cand_mode_unknown`: `present/3`, `god/1`,
  `angel/1`). Not split here: a test lists them, so a new one fails. No
  part of a theology file enters a canon slot.
- **L reads fences through clingo's parser.** THE LANGUAGE says a fence
  is never read but for a part's name. SO3 needs what each file derives,
  so the compiler reads each compiled file's signatures with clingo's
  parser. It neither compiles nor changes a fence.
- **The new slots' meanings** (200) were written by hand, in the tags'
  style, from the guide's rows, the tags in other files and the rules that
  read them. A tag already in the declaring file kept its text, even where
  it only points elsewhere (`classification/3`: "from the authority
  graph").
- **A red test, stated** (rule 7): `ttc://grammar` lists `source/4`'s tags
  with `icon_authority.lp` first, its slot's new tag; the expectation was
  the three cross-references.

### Sorts (TY)

- **Five facts outside** (TY3). Matrimony as a sacrament, three times
  (`condition_in_question/2`, twice, in `sacrament_conditions`;
  `changes_condition/3` in `liturgical_books_hyp`): the guide's list was
  `celebrated/4`'s, and the rules read `cond(matrimony,…)`. The sort is
  widened, and the guide says so. `effect(tube_out,tube_removed,neutral)`
  in `ectopic`: no rule reads `neutral`. The fact is retyped (rule 7): its
  valence is dropped, so the means is not evil by the closed world, as
  before; no output changed. `present(son,place_d,located)` in
  `cand_mode_unknown`: a candidate entered to be refused
  (`untyped_presence`). It is neither widened nor retyped; it is refused
  twice, and a test lists it.
- **Open sorts are declared too.** THE LANGUAGE named open sorts and did
  not say they were declared. Each is, once, with a meaning, so a
  misspelled sort does not compile. The guide's other short lists (kinds
  of law, forms of interpretation, collections, ways of revocation,
  dissolution, indulgences) stay open, under `category`, as the
  predictions did not name them.
- **The domains of a file with parts** are compiled under `#program
  base.`, or the last part would hold them.
- **`in_sort/2` is L's.** It is read and never derived, so by SO1's rule
  it would be a slot; it is what L writes, never a case, and SO1's test
  leaves it out. The gate warns on it (TY4); CG is to refuse it.
- **SR1, for the domains, holds now**: a test reads every rule body.

### Cases and sentences (OF, SY)

- **Which case.** A part names the case whose matter it changes or
  tests: a reading of its sources, a source relaxed, a fact of its
  events decided or disputed, a claim on its questions. Read off the
  suite (the one case a part is always loaded with) and the questions it
  names: 143 proposed, then checked by hand against each part's comment.
  Thirty-nine were set aside: the candidates of the creed, of presence
  and of time, loaded with `ic` only because the creed's bundle holds it
  (`CREED`). Eleven were added by hand where the suite loads two cases or
  none (the trolley and the ectopic cases go with `life_sources`,
  `seal_dispensed` with `seal_case`), and one moved (`cand_sin_of_mary`
  to `mary_actual_sin`). The test of OF1 caught one choice of mine:
  `liturgy_oum_hyp` names `q(ic)`, so it is `of ic`, not of
  `lex_orandi_ic`.
- **A switch of a switch.** `of` names a case, and some matters live in
  switches: the four readings of art. 6 (`art6_papal`, ...) change
  `art6_case`, which states no question and so is a switch (SO2). They
  name no case.
