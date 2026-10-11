# TTC-SCHOOLS(7)

## NAME

**ttc-schools** — the schools as runtimes on the kernel: predictions,
committed before encoding

## DESCRIPTION

Package four schools as runtimes: named bundles of parts, loaded whole.
Boot each alone on the deposit and the kernel, then in pairs, and record
where each fails and on which instruction. Run Florence's axiom of
opposition (DH 1330) two ways: as deposit, and as a Thomist reading.

The kernel files still hold four school statements, and the deposit model
of the Trinity one more. They move first, into the runtimes.

This file was committed and stamped (`tools/stamp`) before any of it was
encoded. The stamp is the evidence. RESULTS will be appended below;
nothing above RESULTS will be edited.

## THE RUNTIMES

Fixed here. Nothing was chosen to suit the kernel. A part in `code` exists;
a part in *italics* is new.

| Runtime | Parts |
| --- | --- |
| **classical** (shared base, not a school) | *agere sequitur esse*: creatures act (moved from the kernel) |
| **one power** (shared by the three Latin runtimes) | *one spirative power of Father and Son* (moved from the kernel and from M1) |
| **Thomist** | classical; one power; `th01`, `th03`, `th04`, `th05`, `th06`, `th21`, `th22`, `th24` (minimal readings; Th. 2, 15, 23 add nothing to the kernel; Th. 7–14, 16–20 share no vocabulary with it); `simplicity_thomist`; `attributes_by_reason`; `mixed_relations`; `transcendentals`; Th. 24's last clause read as physical premotion |
| **Scotist** | classical; one power; `simplicity_scotist` (persons distinct by mode of production); `attributes_formal`; *univocity of the concept of being*, its intrinsic modes infinite and finite; *essence and existence not really distinct*; `mixed_relations`; `transcendentals` |
| **Suárezian** | classical; one power; simplicity as Thomas reads it (`simplicity_thomist`; the formal distinction refused); `attributes_by_reason`; `suarez_esse`; `mixed_relations`; `transcendentals`; Th. 24's last clause read as simultaneous concurrence. Analogy of intrinsic attribution needs no part: the kernel's bridges admit it |
| **Palamite** | classical; `simplicity_palamite` (persons distinct by their properties); `palamite_energies`; `monopatrism` (as to existence); `no_divine_contraction` (no spirative power common to Father and Son) |

The runtime that the existing scenarios run on is **default**: classical
and one power, exactly the statements moved. No existing expectation
moves.

## METHOD

**Runtime.** A named list of parts, loaded whole. A scenario names at most
one runtime, or two for a pair. With none named it runs on default.
*Bare* runs the kernel and the deposit with no runtime at all.

**Boot set.** The 173 scenarios that load no school part: no part of
`icon_metaphysics.lp`, and none of `monopatrism`, `palamite_energies`,
`cand_energies_unwarranted`, `no_divine_contraction`,
`distinction_opposition`, `distinction_mode`, `theses_1914`,
`theses_directive`.

**Boot.** Run the boot set with the runtime in place of default. A
scenario **changes** when its violations change, in any branch. It is
**red** when its checks fail.

**Pair.** Load two runtimes. A **clash** is a violation present under the
pair and under neither runtime alone, in the same scenario. A clash is
reported by its **instruction**: the name of the violation.

**DH 1330.** Two encodings. **A**, deposit: persons are distinct only by
opposed relations of origin, always. **B**, a Thomist reading: opposition
follows from simplicity as Thomas reads it (as now). The whole suite and
the boots run under each.

## PREDICTIONS

### R: relocation

- **R1.** Moving the five school statements into default changes no
  scenario.
- **R2.** The defined attributes (`defined_attributes`) moved into the
  deposit, always on, change no scenario.
- **R3.** Bare, the defined Filioque is incoherent. In every boot-set
  scenario that loads the Trinity and withholds neither the divine
  license nor divine origination, the Spirit gains two principles
  (`incoherent(grain(o,spirit,father,son))`, DH 850). The theorem that
  *donative* is vacuous over persons fails wherever it was derived.
  Nothing else changes. Changed: M1, M5, X1, AN1, AN6, FQ2, FQ18, FQ19,
  K7, T1, K1. Red: M1, M5, AN1, FQ18, FQ19, T1, K1.

### B: each runtime alone

- **B1. Thomist.** Changed: UN1, UN2, AN4, FQ13, FQ19, K7, K9. Red: FQ19
  only.
- **B2. Scotist.** Changes nothing. Scotus's univocity of concept, with
  distinct modes, raises nothing in the kernel.
- **B3. Suárezian.** Changed: AN4, FQ19. Red: FQ19 only. The denial of
  the real distinction raises nothing without Th. 5.
- **B4. Palamite.** Changes fall only among the 14 boot-set scenarios that
  load the Trinity; reds only among the 22 that load the Trinity,
  Augustine's map or the Lateran fixture. No violation comes from the
  Palamite parts themselves. Every red is a check that states the
  Filioque's shape.
- **B5.** No runtime fails to boot on a kernel rule.

### P: pairs

| Pair | Predicted clashes |
| --- | --- |
| **P1.** Thomist + Scotist | `composition_in_god`; `received_esse_without_real_distinction` |
| **P2.** Thomist + Suárezian | `received_esse_without_real_distinction` |
| **P3.** Thomist + Palamite | `composition_in_god`; `persons_not_distinguished` |
| **P4.** Scotist + Suárezian | `composition_in_god` |
| **P5.** Scotist + Palamite | `composition_in_god` |
| **P6.** Suárezian + Palamite | `composition_in_god`; `persons_not_distinguished` |

- **P7. Univocity.** No pair clashes on univocity while Th. 4 is read
  minimally (univocity of *mode*). Read as worded (being is *said*
  analogically: a rule on predication), Th. 4 refuses Scotus, and
  Thomist + Scotist clashes on it too.
- **P8. De auxiliis.** Thomist + Suárezian on the *auxiliis* fixture with
  the 1914 decree: both readings kept, as branches; no violation;
  `q(efficacious_grace)` open (Paul V, 1607).
- **P9.** Every clash falls on one of three instructions: the simplicity
  whitelist, the principle of distinction, Th. 5. None falls on a kernel
  rule that no runtime parameterizes.
- **P10. The leak.** In a pair with Palamite, the Latin runtime's Filioque
  is retracted, not refused: `monopatrism` removes a fact of the
  deposit's own model (M1). The Scotist and the Palamite disagree on the
  Filioque, and the grammar does not register it. The refusal comes only
  through the authority layer (FQ18), by rule 1. This is the only place a
  runtime edits the deposit.

### D: DH 1330, two ways

- **D1. A, under default.** Changed: FQ1, FQ3, FQ4, FQ7, FQ8, FQ19, AN4,
  TH14, TH15, TH15c, TH20b. Red: FQ1, FQ3, FQ4, FQ7, FQ19, TH14, TH15,
  TH15c, TH20b. FQ4's two "mode" rows collapse into its "opposition"
  rows. Nazianzen's properties no longer rescue the persons when the
  analogy of procession is withheld (TH20b).
- **D2. A, Scotist.** Boots as in B2. Scotus's counterfactual (Son and
  Spirit distinct were the Spirit not from the Son; *Ord.* I d.11 q.2),
  run with `monopatrism` marked HYPOTHETICAL, is refused. Under B it
  stands.
- **D3. A, Palamite.** Every Trinity scenario in the boot set gains
  `persons_not_distinguished(son,spirit)`. Under B none does.
- **D4. B.** B1–B4 as predicted.
- **D5.** Under A the Filioque follows inside the grammar, from three
  persons and the axiom; under B only inside the Thomist and Suárezian
  runtimes. The checker does not say which encoding is right. It prices
  each.

### M: meta

- **M1.** Every boot failure and every clash lies between a runtime and
  the deposit, or between two runtimes. None lies between a runtime and
  the kernel.
- **M2.** After R1, the kernel files hold no school statement, and a
  layering test can enforce it as it enforces the theory's absence.

## CAVEATS

The predictions concern encodings the same hand will write. B2, P7 and the
first half of P9 are close to true by construction: the kernel types
modes, not concepts (TTC-FINDINGS §1). R3, B1, B4 and D1 have teeth: they
name scenarios written for other purposes.

A runtime is a school as the checker can state it: a few dozen lines, not
a metaphysics. Each bundle omits most of its school. The Scotist bundle
has no haecceity; the Suárezian no modal distinction in creatures; the
Palamite no hesychasm.

The deposit is the Catholic one. That the Palamite runtime is refused
somewhere is fixed by that choice, not found.

Scotus wrote before Florence. Under A his opinion becomes contrary to a
later decree; whether that makes it more than superseded is a question of
dates, for the authority layer.

Some citations below are fixed from memory. Any found wrong at encoding
are corrected in RESULTS, not above.

## STANDARDS

- Lyons II, DH 850; Florence, *Laetentur caeli*, DH 1300–1302; *Cantate
  Domino*, DH 1330–1331
- Lateran IV, DH 800, 804; Vatican I, DH 3001–3002, 3025
- Sacred Congregation of Studies, theses of 27 July 1914, DH 3601–3624;
  *tutae normae directivae*, 1916
- Paul V, decree on *De auxiliis*, 1607
- Aquinas, ST I q.3 a.7; q.13 aa.4, 7; q.28 a.3; q.36 aa.2, 4; q.105 a.5;
  SCG III.69–70
- Báñez (1584); R. Garrigou-Lagrange, *God: His Existence and His
  Nature*; Molina, *Concordia* (1588)
- Scotus, *Ordinatio* I d.3 p.1 qq.1–3; d.8 p.1 qq.3–4; d.11 q.2; d.12;
  d.30 q.2; IV d.11 q.3
- Suárez, *Disputationes metaphysicae* 7 s.1; 22; 28 s.3; 31
- Photius, *Mystagogia*; Gregory of Cyprus, *Tomus* (1285); Gregory
  Palamas, *Triads* III.2, *Capita* 150; Gregory Nazianzen, *Or.* 31.8–9;
  John of Damascus, *De fide orthodoxa* I.8

## SEE ALSO

[ttc-thomism(7)](thomism-preregistration.md),
[ttc-layers(7)](../layers.md), [ttc-findings(7)](../findings.md)

## RESULTS

Appended after the runs. Predictions committed in 8ee05e8, stamped in
3c1d0de. Encoded in `schools.lp`, `engine.RUNTIMES`, `schools.py`; tests
RT1–RT14 (fast) and `tests/test_schools.py` (the tables; `TTC_SLOW=1`).
`ttc-schools` prints the tables.

### Boots, encoding B

| Runtime | Changed | Red |
| --- | --- | --- |
| bare | 50 | 18 |
| Thomist | UN1, UN2, AN4, FQ13, FQ19, K7, K9 | FQ19 |
| Scotist | none | none |
| Suárezian | AN4, FQ19 | FQ19 |
| Palamite | 47 | 23 |

### Pairs

| Pair | Clashes (scenarios) |
| --- | --- |
| Thomist + Scotist | `composition_in_god` (171); `received_esse_without_real_distinction` (54) |
| Thomist + Suárezian | `received_esse_without_real_distinction` (54) |
| Thomist + Palamite | `composition_in_god` (170); `persons_not_distinguished` (12) |
| Scotist + Suárezian | `composition_in_god` (171) |
| Scotist + Palamite | `composition_in_god` (170) |
| Suárezian + Palamite | `composition_in_god` (170); `persons_not_distinguished` (12) |

A pair clashes on simplicity in nearly every scenario because each
runtime carries its own data (the attributes, the energies).

### Scoring

| | Result |
| --- | --- |
| R1 | Held: no scenario changed. |
| R2 | Held. |
| R3 | Partly false. The Spirit gained two principles in the nine predicted (M1, M5, X1, AN1, AN6, FQ2, FQ18, FQ19, K7), and *donative* stopped being vacuous (T1, K1). "Nothing else changes" is false: every scenario of the theory gained `bridge_without_mode(principle,div)`, and K2 turned red. 18 red, not 7. |
| B1 | Held exactly. |
| B2 | Held. |
| B3 | Held exactly. |
| B4 | False. Outside the theory, the reds fell among the 22 (AN9, AN10, AN11, FQ13, FQ16, M1, T6c, X1), each a check on the Filioque's shape, and no violation came from the Palamite parts. But one change fell outside the 14 Trinity scenarios: AN11, the Lateran fixture, which states the processions itself. And the theory's scenarios failed (below). |
| B5 | False as worded. On Palamite and bare a kernel rule fires (`bridge_without_mode`), but on the theory's bridge, not on a part of the runtime. |
| P1–P6 | Held exactly. |
| P7 | Held (RT6, RT6b). |
| P8 | Held (RT12–RT12c). Each runtime alone keeps its own reading (two branches); the pair keeps both (four); no violation; the question stays open. |
| P9 | Held. |
| P10 | Held (RT11). M1's `not monopatrism` is the only negation, in the deposit or the kernel, on an atom a runtime sets. |
| D1 | Held. FQ4 is red but not "changed": it has no violations of its own. |
| D2 | Held (RT13, RT13b). |
| D3 | Held: all 14. |
| D4 | Held. |
| D5 | Held (RT14). |
| M1 | False. There is a third kind of failure: between a runtime and the application. |
| M2 | Held, and enforced (`test_kernel_derives_no_school_slot`, `test_bare_runs_no_school`). |

21 held, 1 partly false, 3 false. The four misses have one cause.

### Not predicted

- **The Grammar of the Icon is Latin.** Its analogy of one principle (the
  Spirit from Father and Son as one; the child from the parents as one)
  takes its divine side from the Latin license: one spirative power. On
  the Palamite runtime, or bare, the bridge has no divine side, and every
  scenario of the theory is refused (RT3, RT9). With the Filioque but no
  common power (Photius's premise), the Spirit has two principles (FQ4).
  The theory needs both the Filioque and the Latin account of it. Whether
  its claim about the child can stand on the creaturely side alone is a
  question for step 4.
- **Agere sequitur esse carries more than a theorem.** Bare, the claim
  that *donative* tells God from a stone comes true (K2): it was refused
  only because stones act.
- **The deposit's attributes are tested through the theory.** Of the
  seven statements moved into the deposit, four are exercised only by
  scenarios that load the theory's models (TH16, TH17d).

### Corrections

- Scotus, *Ord.* I d.12: the question number was not checked against the
  text. The bundle cites the distinction only.
