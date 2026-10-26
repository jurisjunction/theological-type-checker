# TTC-PROFESSIO(7)

## NAME

**ttc-professio**: a runtime declared in the personal layer, compiled by
the base's rules, run as a profession and never heard through.
Predictions, committed before encoding.

## DESCRIPTION

Read as the rules stand at `10b4d4e` (`main`, TTC-LOCI merged):

- **The personal layer holds rules, cases and tests, not runtimes.**
  `$TTC_HOME/rules/*.lp` are loaded beside the base (`personal_rule_files`).
  A runtime is declared only in the base's `l/*.l`, compiled to
  `runtimes.json` by `compile_runtimes`, and read by `engine.RUNTIMES`. A
  person cannot say which parts he holds without changing the public base,
  where rule 13 forbids his name.
- **A runtime is read as a horizon.** TTC-MODERNITY's hearing parts hear
  for the run's own horizon (`here`), and a `vm_R` part loads R as the VM's
  guest. TTC-LINGUAE refuses a hearing of a person (`hearing_of_a_person`).
  A runtime that is a person's own profession would be a way round that
  refusal.

The discussion that found this: a runtime of one's own, extending the
Thomist and the Palamite schools, "a profession, part by part", never a
model of a mind. The person chose a declaration in L, in his own layer,
and a guard against its use as a hearer.

The proposal:

- A personal layer may declare runtimes in L. They are compiled with the
  base's sources and refused by the base's rules: an unknown part, an
  unresolved clash, part of an allele, a cycle.
- A personal runtime is a profession. It can be run, booted and compared,
  but it is never a hearer and never a guest in the VM.
- The connector saves a runtime as it saves rules: compiled first,
  written only if it compiles.

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited.

## THE DESIGN

### Declared in the layer (`lang.py`, `engine.py`)

- **Where.** `$TTC_HOME/runtimes/*.l`: L files that declare runtimes
  only (and comments). A file declaring anything else does not compile.
- **Compiled with the base.** `compile_runtimes` reads the base's sources
  and the layer's together. A personal runtime may extend base runtimes
  and other personal ones, and name the base's parts and the parts of the
  layer's own rule files (`$TTC_HOME/rules/*.lp`, by their `#program`
  lines). Every refusal of the base applies, naming the file and line. A
  personal runtime whose name a base runtime has does not compile.
- **Written beside it.** The compiled table goes to
  `$TTC_HOME/runtimes.json`, in the base's form, with each runtime's loci
  (expressed and carried). `engine.RUNTIMES` adds it when the layer is on.
  A table older than its sources is refused at load, as `ttc-l check`
  refuses the base's.
- **Off in the tests.** The suite runs with the layer disabled, as now, so
  nothing personal reaches a base test.

### A profession (`causae.l`, the engine)

- **Marked.** Expanding a personal runtime adds the fact `profession(R)`
  to the solve.
- **Never a hearer.** `violation(profession_heard(R))`: a hearing declared
  for the run's own horizon (`hears_in(here, …)`) on a run of a
  profession.
- **Never a guest.** No `vm_R` part is made for a personal runtime, and
  `vm_guest(R)` for one is refused (`profession_as_guest(R)`).
- **Run, booted, compared.** It runs as any runtime does (`rt_R`), and
  TTC-SCHOOLS's boot runs on it.

### The connector (`server.py`)

- **`save_runtime(name, source)`**: compiles the source with the base and
  the layer; on a refusal, returns it and writes nothing; otherwise writes
  `$TTC_HOME/runtimes/<name>.l` and the compiled table, and returns the
  runtime's parts and its loci. With `boot=True` it also returns its boot
  on TTC-SCHOOLS's boot set.
- **`list_parts`** names the layer's runtimes beside the base's, marked
  personal.

## PREDICTIONS

### PF: the layer

- **PF1.** With the layer disabled nothing changes: every scenario's
  atoms in every model, `runtimes.json`, and the TTC-SCHOOLS tables.
- **PF2.** On toy layers (tests), each refused, naming the file and line:
  an unknown part; two parents clashing on a part, unresolved; a runtime
  holding part of an allele; a cycle; a name the base has; a file that
  declares a slot.
- **PF3.** A toy personal runtime extending `thomist` compiles, runs as
  `rt_R`, and gives exactly what `thomist` gives on the property case of
  TTC-MODERNITY, save `profession(R)`.
- **PF4.** A personal runtime may name a part of the layer's own rules,
  and does not compile when that part is absent.
- **PF5.** A stale `$TTC_HOME/runtimes.json` (older than its sources, or
  not what they compile to) is refused at load.

### PG: the guard

- **PG1.** A run of a personal runtime with a hearing part
  (`hear_en_1891_locke`, say) is refused (`profession_heard`). The same
  parts on a base runtime are not.
- **PG2.** `vm_guest(R)` entered for a personal runtime R is refused
  (`profession_as_guest`). No `vm_R` part exists for it.
- **PG3.** A personal runtime booted on TTC-SCHOOLS's boot set changes
  what its parts change; the guard adds no violation to a run with no
  hearing and no VM.

### PS: the connector

- **PS1.** `save_runtime` with a source L refuses writes nothing, and the
  reply names the refusal.
- **PS2.** `save_runtime` with a source that compiles writes the source and
  the table, and returns the parts and loci.

### PX: a test of the starting point

- **PX1.** A toy runtime extending `thomist` and `palamite`, as the
  person's will, is refused by L on exactly `one_power` (`thomist` holds it
  from `default`; `palamite` excludes it, for `monopatrism`). Nothing else
  is refused.
- **PX2.** With that clash resolved either way, at **simplicity** it
  carries `by_reason` and `energetic` and expresses neither (TTC-LOCI); at
  **esse** it expresses `real`. On the boot set no `composition_in_god`
  falls under the reading `thomist` or `palamite`: neither is set.
- **PX3.** Reported, not predicted: its boot on the boot set, under each
  resolution of `one_power`.

### SU: the suite

- **SU1.** No expectation changes. CL1 and PR4 stay clean.
- **SU2.** Every new rule, refusal and tool has a test that fails without
  it. `docs/l.md`, `docs/mcp.md` and the guide (both copies, identically)
  gain the layer's runtimes and the guard.

## CAVEATS

- **A profession is not a portrait.** A personal runtime is the parts a
  person says he holds, part by part, on his own word. It is not inferred
  from him and says nothing of his interior (rule 3). The guard keeps it
  from being used as one.
- **Its name stays in its layer.** Nothing personal enters the public base
  (rule 13). The toys in the tests have neutral names.
- **The procession is a choice the build forces, not one it makes.** L
  refuses the starting point on `one_power` and says no more. Which way
  the clash is resolved, and on what text, is the person's.

## SEE ALSO

[ttc-loci(7)](loci-preregistration.md), [ttc-schools(7)](schools-preregistration.md),
[ttc-linguae(7)](linguae-preregistration.md), [ttc-l(1)](../l.md)

## SCORING

Appended after the runs. Predictions committed in `e8b1359`, stamped in
`7a9d8a3`. Encoded in `lang.py` (a file of the layer's runtimes,
`LayerSource`, runtimes only; `compile_runtimes` taking the layer's rule
parts; `compile_layer`, `layer_parts`, `layer_stale`, `write_layer`;
`ttc-l build` and `check` with `--home`), `engine.py` (`BASE_RUNTIMES`;
`RUNTIMES`, the base's and the layer's; the layer's table, refused at load
at the new gate `runtimes`; `runtime_facts`, the marks added to a solve),
`causae.l` (the slots `personal_runtime/1` and `profession/1`; the results
`profession_heard/1` and `profession_as_guest/1`, one rule each),
`server.py` (`save_runtime`; `list_parts` and `ttc://grammar` naming the
layer's runtimes; the instructions), the suite (its runs of every runtime
read the base's, `BASE_RUNTIMES`; `mod_project` adds the marks as a solve
does), `tests/test_l.py`, `tests/test_suite.py`, `tests/test_interface.py`,
`tests/test_schools.py` (TTC_SLOW), `docs/l.md`, `docs/mcp.md`, the guide
in both copies, `docs/flywheel.md`, the README and the roadmap. Of 14
predictions, 13 held and SU1 is red in part; PX3 is reported. The full
suite: 1007 passed, 54 skipped; TTC_SLOW `test_schools`: 20 passed, the 15 of
TTC-SCHOOLS, one of EX1 and the 4 of this step (EX1's 33 boots, which run
only with TTC_SLOW_MODERNITY, not run).

| | Result |
| --- | --- |
| PF1 | Held. With the layer disabled every scenario (726, 44,877 models) gives the same shown atoms in every model, main (`7a9d8a3`) against the branch; `runtimes.json` is unchanged (`ttc-l check`); TTC-SCHOOLS's boot and pair tables, and DH 1330's, are unchanged (TTC_SLOW `test_schools`). With the layer off, `engine.RUNTIMES` is the base's, and nothing is added to a solve (`test_with_the_layer_off_no_runtime_of_its_own_and_no_mark`). |
| PF2 | Held (`test_the_layers_runtimes_are_refused_by_the_bases_rules`), each refused naming `runtimes/mine.l` and its line: an unknown part; `thomist` and `palamite` clashing on `one_power`; part of the allele `by_reason` at simplicity; a cycle; a name the base has (naming `schools.l:33`); a file declaring a slot. Also refused: an unknown parent; a `layer` declaration; a fence of clingo; a runtime declared twice. |
| PF3 | Held (`test_a_profession_runs_as_its_parts_save_the_mark`). `runtime toy extends thomist` compiles and runs as `rt_toy`; on `modernity_property` its branches are `thomist`'s, and every atom of every model, shown or not, is `thomist`'s save `profession(toy)`. |
| PF4 | Held (`test_a_runtime_of_the_layer_may_name_a_part_of_its_rules`, `test_a_part_of_the_layers_rules_is_loaded_by_its_runtime`). The part grounds where the runtime is named, and only there; withdrawn from the rule file, the runtime does not compile, naming its line. |
| PF5 | Held (`test_a_stale_table_is_found_and_ttc_l_builds_and_checks_the_layer`, `test_a_stale_table_is_refused_at_load`). Older than its source, not what its sources compile to, missing beside them, or with a source L refuses: each refused at load, at the gate `runtimes`, naming why, on every run while the layer is on. `ttc-l check --home` fails on a table missing or not as its sources compile; `ttc-l build --home` writes it, and refuses a source L refuses, naming the file and line. |
| PG1 | Held (`test_a_profession_is_never_heard_through`). `modernity_property`, `linguae_rn9` and `hear_en_1891_locke` on `rt_toy`: `profession_heard(toy)` in every model; on `rt_thomist`, `rt_locke` and `rt_palamite`, none. |
| PG2 | Held (`test_a_profession_is_never_a_guest`). `vm_guest(toy)` entered as a fact is refused (`profession_as_guest(toy)`) on `rt_toy`, on `rt_thomist` and on the default; there is no part `vm_toy`. A base runtime's guest is not refused, on a run of a profession or not. |
| PG3 | Held (`test_a_profession_boots_as_its_parts`, TTC_SLOW; `test_the_guard_adds_nothing_where_there_is_no_hearing_and_no_vm`). On the boot set (210 scenarios) each toy runtime gives, scenario by scenario, what its parts give loaded on `rt_bare` with no runtime named; `toy_thomist`'s boot is `thomist`'s stamped row. No `profession_` violation on the boot set, nor on runs with no hearing and no VM. |
| PS1 | Held (`test_save_runtime_refused_writes_nothing`): an unknown part, a clash, a slot, an unknown parent, and a source that declares no runtime of the name given; each reply names the file, the line where there is one, and the refusal, and the folder stays empty. |
| PS2 | Held (`test_save_runtime_writes_the_source_and_the_table_and_lists_it`, `test_save_runtime_boots_where_asked`). The source and `runtimes.json` are written, the table as its sources compile; the parts and loci returned; `rt_mine` runs, is listed by `list_parts` with its file under `personal/`, and is in `ttc://grammar`. A refused save leaves what was written; a second runtime extends the first. With `boot=True`, its boot. |
| PX1 | Held (`test_the_starting_point_is_refused_on_exactly_one_power`). `runtime start extends thomist, palamite` is refused on `one_power` alone; with `add one_power` or `exclude one_power` it compiles. |
| PX2 | Held (the same test; `test_a_profession_boots_as_its_parts`, TTC_SLOW). Either way, at simplicity it carries `by_reason` and `energetic` and expresses neither, so `simplicity_thomist`, `attributes_by_reason` and `simplicity_palamite` are not loaded; at esse it expresses `real`. On the boot set no `composition_in_god` falls under the reading `thomist` or `palamite`. |
| PX3 | Reported (`tests/test_schools.py`, TTC_SLOW). Under either resolution the boot changes 51 scenarios: the 48 the Palamite runtime changes, and FQ13, K7 and K9, which the Thomist runtime changes; red, 24, exactly the Palamite runtime's red. FQ19, which the Thomist runtime turns red, is not changed: its simplicity is not loaded. The two resolutions give the same atoms in every model of every scenario of the boot set. `one_power` is inert under the Palamite parts: with `monopatrism` the model has one spirator (`icon_models.l`), so `one_power/2` has no instance, and `no_divine_contraction` withholds the contraction it would feed. The choice the build forces changes nothing the boot set can see. |
| SU1 | Red in part. No expectation about an earlier result changed: the earlier scenarios' atoms are as before in every model (PF1), and CL1 and PR4 are clean. Two earlier tests of `tests/test_interface.py` restate their list of the tools that write, which the prediction did not foresee: `save_runtime` writes and can replace a file, as THE DESIGN has it, so `test_every_tool_says_whether_it_writes` and `test_over_http_only_the_tools_that_read_are_served_unless_asked` name it among the writers, each stated where it stands (rule 7). |
| SU2 | Held. Each new rule, body literal, refusal and tool removed in turn (29) turned a test red: the two rules of `causae.l`, each of their body literals and the constant `here`; the engine's two marks and their addition to a solve, the layer's runtimes in `RUNTIMES`, and the refusal at load; L's refusals of a name the base has and of anything but runtimes, the layer's rule parts, the table holding the layer's runtimes only, each of the three stale conditions, and `build` and `check` with `--home`; `save_runtime` compiling first, its source declaring its runtime, writing nothing before it compiles, its boot and its declaration as a writer; `list_parts` and the grammar naming the layer's runtimes; the suite reading the base's runtimes, and its projection marked. None survives. `docs/l.md` (THE LAYER'S RUNTIMES), `docs/mcp.md` and the guide (THE LAYER'S RUNTIMES, and the gate `runtimes`), identical in both copies. |

### Readings

- **`personal_runtime(R)` on every run.** "`vm_guest(R)` for one is
  refused" names no run, so with the layer on every solve holds
  `personal_runtime(R)` for each of the layer's runtimes, and
  `profession(R)` only where the run expands R. PF3's "save
  `profession(R)`" compares the two runs with the layer on, so both hold
  `personal_runtime(toy)`.
- **The run's own horizon.** `hears_in(here, …)` on any run that expands
  a profession, a pair with a base runtime included. A base runtime's guest
  in the VM, hosted by a profession, hears for the guest: that is no
  hearing of the profession, and is not refused.
- **No `vm_R` part.** A file of the layer declares runtimes only, so none
  can be made; nothing else was needed.
- **Refused at load** reads every run with the layer on, not only runs of
  the layer's runtimes: the table is read whole. A table missing beside its
  sources is refused as stale, and so is one whose sources L refuses.
  "Older than its sources" compares the table's time with the runtime
  files'; "not what they compile to" compiles them with the base and the
  layer's rule files as they stand.
- **The file and line** of a refusal in the layer are its place there,
  `runtimes/<name>.l`. The connector marks a runtime of the layer personal
  as it marks the layer's other parts: its file under `personal/`.
- **`save_runtime(name, source)`** writes `runtimes/<name>.l`, which must
  declare the runtime `name` and may declare others; the table is written
  after the source, so it is never older. It returns the runtime's parts
  and loci, and the names its source declares.
- **The layer's rule parts** are their files' `#program` lines.
- **`ttc-l build` and `check`** take `--home`, the layer's counterpart of
  "as `ttc-l check` refuses the base's".
- **"Changes what its parts change"** (PG3): each scenario of the boot
  set gives under the profession what it gives with the profession's parts
  loaded on `rt_bare`, no runtime named.
- **PX3's two resolutions** are `add one_power` and `exclude one_power`,
  each a toy runtime of a layer in a temporary folder.

### Not predicted

- **The suite read every runtime the engine knows.** Its runs of each
  runtime (CV, VM, HE, MP, PH, AL, SB and others) iterated
  `engine.RUNTIMES`; with the layer on, a person's runtime would have run
  in the base's scenarios. They now read `BASE_RUNTIMES`, the same with
  the layer off, so no expectation changes, and a test keeps
  `engine.RUNTIMES` out of `suite.py`.
- **The suite's own solver.** `mod_project` grounds the base itself, not
  through `engine.solve`, and had to add the marks as a solve does, or a
  projected run of a profession would escape the guard.
- **`one_power` is inert under monopatrism** (PX3).
