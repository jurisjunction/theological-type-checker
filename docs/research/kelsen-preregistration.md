# TTC-KELSEN(7)

## NAME

**ttc-kelsen** — Kelsen's horizon as a node of the modernities, and the fork Benedict XVI drew
from it: predictions, committed before encoding

## DESCRIPTION

Benedict XVI, at the Bundestag (22 September 2011), reports that Kelsen held "norms can only come
from the will". On that view nature could contain norms only if a will had placed them there, which
would imply a Creator; Kelsen judged the question futile [V: bundestag.de]. That is the fork of
TTC-ART6X: law that constitutes the act's character because a will commands it, against law that
measures an act already specified. The DAG has no node for it.

Add three nodes to `schools.l`:

- **`kelsen`** extends `kant`. The Pure Theory (1934) keeps the neo-Kantian method and drops the
  moral law's form: the basic norm is a presupposition of legal cognition, not the form of the will's
  maxim [M]. Excluding `form_of_law` is contested and marked so. The legal order is a coercive order
  that motivates by its sanction [M], so `ends_desired` is kept. Imputation (*Zurechnung*) is the
  norm's connection of condition and sanction, the counterpart of causality [M].
- **`kelsen_1965`** extends `kelsen`: norms only from an act of will, as Benedict reports it. In the
  checker's typing the will's act is an efficient cause, held everywhere, so the horizon is
  `kelsen`'s. The node records the claim and gives the reading below a parent.
- **`kelsen_1965_creator`** extends `kelsen_1965`, a reading against its author: the conditional
  taken up by one who holds there is a Creator, so that norms in nature are placed by a divine will.
  `add ends_by_god_ethics`. This is Ockham's position by another road.

## PREDICTIONS

- **K1.** The DAG builds, with no clash at any of the three (one parent each). `runtimes.json` gains
  three entries, and no existing entry changes.
- **K2.** Horizons: `kelsen` and `kelsen_1965` hold only `ends_desired` among the ten cause parts;
  `kelsen_1965_creator` adds `ends_by_god_ethics`.
- **K3.** TTC-MODERNITY's phases (property case): `kelsen` and `kelsen_1965` fall in the Hobbesian
  phase with `kant`, and give on the case what `kant` gives (neither form moves a report, PR8).
  `kelsen_1965_creator` falls in the Lockean phase.
- **K4.** TTC-ART6X (adapter and versari fix, local): all three have the rule act theory, and art. 6
  is imposed by rule.
- **K5.** With AP4 typed as the soul's good (`final,god_ethics`): `kelsen` and `kelsen_1965` stay
  coherent; `kelsen_1965_creator` turns incoherent.
- **K6.** With TTC-ART6T's teaching side: `law_without_premise(art6_by_rule,…)` on all three.
- **K7.** Tests that enumerate every runtime may turn red by enumeration alone. Each is opened before
  it is judged; no expectation about an existing runtime changes.

## CAVEATS

Kelsen's own texts are cited here from memory [M]: *Reine Rechtslehre* (1934), and the late writings
on the will theory of norms. The 1965 claim is entered as Benedict reports it [V]; whether Kelsen
"abandoned" the dualism of is and ought is itself disputed. Excluding `form_of_law` is the encoding's
reading of the neo-Kantian basic norm. A reader who takes the basic norm as a form of reason would
keep it, and then the adapter gives Kelsen imputation by desert, which is surely wrong for him. That is
a sign the adapter's AP2 needs splitting: the moral law's form, and the legal order's.

## SEE ALSO

[ttc-modernity(7)](modernity-preregistration.md), [ttc-act(7)](act-preregistration.md)

## SCORING

Appended after the runs. Predictions committed in 8de4a90, not stamped (the stamp Action runs when the
commit reaches `main`). Encoded in `schools.l` (three nodes, three `vm_` parts) and compiled to
`runtimes.json` and `schools.lp`.

| | Result |
| --- | --- |
| K1 | Held. The DAG builds with no clash; `runtimes.json` gains three entries and no existing entry changes. |
| K2 | Held: `kelsen` and `kelsen_1965` hold `ends_desired` alone of the ten; `kelsen_1965_creator` adds `ends_by_god_ethics`. |
| K3 | Held, and more: `kelsen` and `kelsen_1965` give what `kant` gives under every switch, not only with none; `kelsen_1965_creator` gives what `locke` gives under every switch but `rn7_from_self`, since it holds no self-preservation. |
| K4 | Held (TTC-ART6X adapter, local): the rule act theory, art. 6 imposed by rule. |
| K5 | Held: with AP4 typed as the soul's good, `kelsen` and `kelsen_1965` stay coherent; `kelsen_1965_creator` is flagged `punished_without_fault`. |
| K6 | Held: `law_without_premise(art6_by_rule,…)` on all three (TTC-ART6T). |
| K7 | Held, wider than written. Thirteen checks enumerate the runtimes or the pages, and each turned red by enumeration alone: RU1 (`test_l.py`), the docs index, MP4, MP5, PE2, PE4, QT6, QL2, VB1, CV5, VM2, HE6 and PH2. Each was opened, and each expectation was restated by rule 7 from the rule its own docstring states (see the comments marked TTC-KELSEN K7). No expectation about an existing runtime changed. Two conditions in `mp_expected` now read the horizon (`self_preservation` held) instead of a list of names. The full suite then ran 801 of 814: thirteen more, in four other programs, enumerate the runtimes and are **not yet restated** (OPEN, below). |

### Not predicted

- **CV5: Kelsen is native to the conversion of ends into forces.** `kelsen` and `kelsen_1965` join
  Hobbes and Spinoza as the only horizons where `measures_as(adams_1907, final, efficient)` is native:
  ends survive only as desire. The legal order as a technique of motivation is that conversion.
- **PH2: a phase is filled.** Under `rn7_from_self` and under the Lockean hearing, one of the six phases held
  no runtime: God's ends in ethics without self-preservation. `kelsen_1965_creator` holds it. That is
  divine-command positivism, the 1965 conditional taken up by a believer, and no figure of the record
  occupied it.
- **The `vm_` parts are hand-written.** A new runtime needs its guest part, or every check that loads each
  runtime as the VM's guest fails at the parts gate.

## OPEN

The full suite after the thirteen restatements: 801 of 814. Every red names only the three new nodes:

| Program | Scenarios | What the red says |
| --- | --- | --- |
| TTC-LOCI, substitution | SB4, AL4 | `kelsen`, `kelsen_1965`: Adams's measure native, and latria to the dynamo refused, as at Hobbes; the allele tables lack the three rows |
| TTC-RERUM | QV1, QC1, QL1, QT8 | the conversion of ends to forces native at `kelsen` and `kelsen_1965` (as CV5); `adaequatio` by the mind, inherited from Kant; the trace counts |
| TTC-MENDACIUM | MN2, MW1–MW4, MV2, MV3 | the rows lack the three; as the VM's guest, `kelsen` and `kelsen_1965` can follow no argument that a lie is always wrong (`guest_without_reason(q(lie_always_wrong),yes)`), where `kant` can: Kant's argument rests on the law's form |

Each is to be opened and restated by rule 7 before this branch is committed.
