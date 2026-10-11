# TTC-THOMISM(7)

## NAME

**ttc-thomism** — how much classical metaphysics of God the core admits:
predictions, committed before encoding

## DESCRIPTION

Add the metaphysics of God to the checker one item at a time, from a list
fixed by others, and run the whole suite after each. Record where things
conflict. Then ask what is wrong: the item, the core, or a reading.

This file was committed before any of it was encoded. The commit date is
the evidence. RESULTS will be appended below; nothing above RESULTS will be
edited.

## THE LIST

In this order. Nothing was chosen to suit the core.

0. **The attributes as defined.** Lateran IV (DH 800, 804); Vatican I,
   *Dei Filius* (DH 3001–3002, 3025): simple, immutable, eternal,
   infinite in every perfection, creating by a most free decision.
1. **The 24 Thomistic Theses** (Sacred Congregation of Studies, 27 July
   1914; AAS 6 (1914) 383–386; DH 3601–3624), each in its minimal
   reading. Proposed in 1916 as *tutae normae directivae*.
2. **Thomas's readings** (the "OS" proper): simplicity as ST I q.3 a.7
   and q.28 a.3 (only opposed relations distinguish anything in God;
   attributes distinct by reason, q.13 a.4); mixed relations (q.13 a.7);
   freedom of creation (q.19 a.3); the transcendentals as pure
   perfections (qq.5, 11, 16; q.13 a.3).
3. **Rival readings**, to locate each conflict: Scotus (formal
   distinction, *Ord.* I d.8 p.1 q.4; distinction of Son and Spirit
   without procession, I d.11 q.2), Suárez (*DM* 31), Palamas (essence
   and energies), Clarke (receptivity; God really related in intentional
   consciousness), Long (receiving indicates potency), and the modern
   modal-collapse critics (Mullins).

## METHOD

Every item is a switch, off by default. Default results do not move.

Each step runs all 170 scenarios with every item so far switched on and
diffs the output against the baseline. A conflict is a scenario whose
violations change, or a new violation in a scenario built for the item.

## PREDICTIONS

### Step 0: the attributes as defined

- **P0.** No conflict. *Eternal* and *infinite* are already enforced by
  the crossing guards (temporal generation, finitude; AN6). *Simple*, read
  minimally (no real composition of parts), is idle: nothing in the data
  asserts one.

### Step 1: the theses

- **P1 (Th. 1, pure act).** No conflict if receiving implies potency only
  in creatures. If receiving is taken in one mode on both sides, the Son
  and the Spirit are in potency, and (with Th. 5) the Son is really
  distinct from the essence he receives: the quaternity Lateran IV
  excludes (DH 804).
- **P2 (Th. 2).** Already in the core: pure act is unlimited (the
  finitude guard).
- **P3 (Th. 3).** Simplicity, minimal: idle. The real distinction of
  essence and *esse* in creatures: the core is neutral. Suárez's denial is
  consistent with the core and inconsistent with Th. 5.
- **P4 (Th. 4, analogy).** Flags the two univocity stress switches (UN1,
  UN2) and nothing else. Scotus's univocity of *concept* stays invisible:
  finding §1 stands.
- **P5 (Th. 5).** As P1 and P3.
- **P6 (Th. 6, relation an accident).** The grammar is untouched. The
  treatise's §2 sentence, that dependence is "not an accident added to a
  creature already constituted", conflicts with ST I q.45 a.3 ad 3 (the
  creature is prior to the relation of creation "as the subject is to the
  accident"). The fix is the distinction of transcendental and
  predicamental relation.
- **P7 (Th. 7–14, 16–20).** No shared vocabulary. Silent; not encoded.
- **P8 (Th. 15, the soul created).** Already in the core: A1 keeps being
  (from God) apart from origin (from the parents); traducianism is
  already a violation.
- **P9 (Th. 21, will follows intellect).** Read as Thomas reads it (love
  proceeds from a word, ST I q.36 a.2), it refuses Palamas's image of the
  mind. Read weakly (love presupposes its known object), it admits it. The
  Trinity is untouched either way.
- **P10 (Th. 22).** Creatures contingent: no conflict. If the direction
  of a bridge is read as the order of *knowing* (we know God from
  effects), every bridge becomes a projection; ST I q.13 a.6 (order of
  being) removes the conflict.
- **P11 (Th. 23).** Already in the core (infinity); the identity of
  essence and *esse* is silent.
- **P12 (Th. 24).** Creation by God alone and its incommunicability:
  already in the core (A1). The last clause (no created agent acts on
  being without a motion from the First Cause) touches only the
  authority layer. *De auxiliis* stays open under every typing (Paul V's
  protection). Typed as governance (directive norms) and read as
  premotion, it is governance answering teaching.

### Step 2: Thomas's readings

- **P13 (simplicity, Thomist).** Decides the Filioque: it entails
  distinction by opposition. It changes exactly the scenarios that switch
  on monopatrism or Palamas's energies, refuses the energies and Scotus's
  formal distinction, and changes nothing outside the processions.
- **P14 (Scotus, Palamas).** Scotus's reading of simplicity does not
  decide the Filioque (d.11 q.2). Palamas's admits his energies.
- **P15 (modal collapse).** The critics' inference (identity of act and
  essence carries necessity to what is created) conflicts with contingency
  (Th. 22) and with free creation (DH 3025). Mixed relations (q.13 a.7;
  q.19 a.3) remove the conflict.
- **P16 (Clarke on immutability).** God really related to creatures in
  consciousness, "different" but not changing, passes immutability as
  defined and fails q.13 a.7. The core passes both.
- **P17 (Clarke and Long on receptivity).** The grammar is neutral. Typed:
  a reception bridge with God as primary analogate (Clarke) or no bridge
  (Long). The treatise's §3 sentence takes Clarke's side.
- **P18 (transcendentals).** Consistent. One new prohibition: a being
  graded less good by its origin (agrees with *Donum vitae* II.B.5).

### Meta-predictions

- **M1.** No conflict comes from a defined attribute or a thesis as
  stated. Every conflict comes from a reading.
- **M2.** Every conflict between the Thomistic stack and the core is a
  univocity of mode: a principle stated for one side of the
  Creator–creature line, applied to the other without a bridge.
- **M3.** Under the full stack with Thomas's readings, no default
  scenario turns red. Only scenarios that already carry another school's
  switch (monopatrism, Palamas's energies, the univocity stress tests)
  change.

## CAVEATS

Most predictions concern encodings written by the same hand that wrote
the predictions. They are partly self-fulfilling. M3 is the test with
teeth: the full stack against 170 scenarios, none written for this.

The theses are read through translations of DH 3601–3624. Where a thesis
admits more than one reading, the reading is a switch.

## STANDARDS

- Lateran IV, DH 800, 804; Vatican I, DH 3001–3002, 3025
- Sacred Congregation of Studies, theses approved 27 July 1914, AAS 6
  (1914) 383–386, DH 3601–3624; declared *tutae normae directivae*, 1916
- Aquinas, ST I q.3 a.7; q.5; q.11; q.13 aa.3–4, 6–7; q.16; q.19 a.3;
  q.28 a.3; q.36 a.2; q.42 a.4 ad 1; q.45 a.3 ad 3, a.5
- Scotus, *Ordinatio* I d.8 p.1 q.4; d.11 q.2
- Suárez, *Disputationes metaphysicae* 31
- Basil, *Letter* 234; Gregory Palamas, *Capita* 150
- W. N. Clarke, "A New Look at the Immutability of God", in
  *Explorations in Metaphysics* (Notre Dame, 1994), ch. 9; "The
  Compatibility of Receptivity and Pure Act: Reply to Steven Long",
  *The Thomist* 61 (1997) 617–24
- S. A. Long, "Personal Receptivity and Act: A Thomistic Critique",
  *The Thomist* 61 (1997) 1–31
- R. T. Mullins, "Simply Impossible: A Case against Divine Simplicity",
  *Journal of Reformed Theology* 7 (2013); C. Tomaszewski, "Collapsing
  the Modal Collapse Argument", *Analysis* 79 (2019) 275–284

## RESULTS

Appended after the runs. Tests TH0–TH20c; the full stack is pinned in
`tests/test_suite.py`.

### Accretion

Cumulative, over the 170 scenarios that existed before this experiment:

| Step | Changed | Red |
| --- | --- | --- |
| defined attributes; Th. 1, 2, 3 | 0 | 0 |
| + Th. 4 | 2 (UN1, UN2: univocity refused) | 0 |
| + Th. 5, 6, 15 | 2 | 0 |
| + Th. 21 | 5 (+ FQ12, FQ13, FQ15: Palamas's mind refused) | 0 |
| + Th. 22, 23, 24 | 5 | 0 |
| + simplicity as Thomas reads it | 11 (+ FQ1, FQ3, FQ7, FQ8, FQ19, AN4) | FQ1, FQ3, FQ7, FQ19 |
| + attributes by reason, mixed relations, transcendentals | 11 | same |

Every default scenario stays green under the whole stack. The four red
scenarios were built to show monopatrism coherent; Thomist simplicity
decides against it, as P13 said.

### Scoring

| | Result |
| --- | --- |
| P0 | Held (TH0). |
| P1 | Held (TH1, TH2, TH2b). |
| P2 | Held. |
| P3 | Held (TH3, TH3b, TH3c). |
| P4 | Held. |
| P5 | Held. |
| P6 | Held (TH5, TH5b). The treatise is corrected. |
| P7 | Not tested: silent by construction. |
| P8 | Held (TH6). |
| P9 | Held (TH7, TH7b). |
| P10 | Held (TH8). |
| P11 | Held. |
| P12 | Held (TH10, TH10b). Read as premotion and typed as teaching, the decree weighs against Molina at tier 3; it does not cleave. |
| P13 | Partly false. It decides the Filioque and refuses the energies and the formal distinction (TH12, TH13, TH15b). It does not change only monopatrism and energies scenarios: AN4 changed. |
| P14 | Held (TH14, TH15). |
| P15 | Held (TH16, TH16b). Th. 22's contingency alone suffices (TH16c). |
| P16 | Held (TH17, TH17b, TH17c). Process theism fails both (TH17d): the line is Clarke's "different, not changing". |
| P17 | Held (TH18, TH18b, TH18c). |
| P18 | Held (TH19). The core had no bridge for goodness (TH19c). |
| M1 | Held for the core: no default scenario conflicts with a defined attribute or a thesis as stated. False as worded: Th. 4 and 5 refute univocity of mode and Suárez in their own words, and Th. 6 with ST I q.45 a.3 ad 3 refutes the treatise's sentence. |
| M2 | False. Of the conflicts that touch the core, two are univocities (TH2, TH16), one an inverted bridge (TH8), one a missing bridge (TH20). Post hoc: every conflict with the core is a fault in a bridge. |
| M3 | False. AN4 changed. |

### Not predicted

- **AN4 (TH20).** Withhold the analogy of procession (deny by default)
  and Thomist simplicity distinguishes nothing: one person. The
  properties of origin (unbegotten, begotten, proceeding; Nazianzen, Or.
  31.8–9) still distinguish three (TH20b). Read opposition off the
  revealed relative names instead of the analogically licensed relation,
  and the persons return (TH20c). Thomas founds the relations on the
  processions (ST I q.28 a.4), which he states by analogy (q.27); the
  Cappadocians name the properties without explaining them.
- **The mode principle omitted the Father's property.** Running AN4 under
  distinction by mode exposed it. Unbegottenness was added (Or. 31.8–9).
  No earlier result changed.
- **Scotus.** A Latin who held the Filioque denied that simplicity
  decides it (*Ord.* I d.11 q.2). The premise that decides the Filioque
  rests on Thomas's reading of a defined attribute, not on the definition.
