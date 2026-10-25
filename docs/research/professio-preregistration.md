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
