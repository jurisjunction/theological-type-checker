# TTC-LAYERS(7)

## NAME

**ttc-layers** — what each rule is: deposit, kernel, school, or the
*Grammar of the Icon*

## DESCRIPTION

The rule base grew around one theory, *The Grammar of the Icon*. To state
that theory exactly, it had to build machinery that every school needs.
The theory and the machinery now sit in the same files. This page sorts
them, rule by rule, before anything is moved.

| Layer | Holds | Disputed by |
| --- | --- | --- |
| **deposit** | what the Church defines | no one inside the Church |
| **kernel** | what every school needs to state its disagreements, deciding none of them | no school; only by being wrong about logic |
| **school** | a school's reading (Thomist, Scotist, Suárezian, Palamite) | the other schools |
| **icon** | what only the *Grammar of the Icon* asserts | anyone; it is a research programme |

Two more layers sit outside the grammar: the **authority** machinery
(tiers, shadows, protection; `icon_authority.lp`) and the **canon** layer
(`canon_law.lp`), joined by the **pair** (`pair.lp`). They are machinery
and are not sorted here.

## THE RULE

Ask in this order. Stop at the first yes.

1. Does a tier-1 source define it? **deposit.**
2. Does every school need it to state its disagreements, and does it
   decide none of them? **kernel.**
3. Would a school dispute it? **school.**
4. Otherwise: **icon.**

A rule that only tests another rule (a candidate, a stress switch) goes
with the rule it tests.

## METHOD

Evidence first, by script; the label is a judgment, recorded with its
reason.

For every statement of `icon_core.lp` and `icon_analogy.lp`:

- **cites**: the source in its comment.
- **sorts**: whether it names divine-sorted or creature-sorted predicates.
- **icon predicates**: whether it names a predicate only the theory uses
  (`nupt`, `consent`, `bond`, `total`, ...).
- **blast radius**: delete it, run every scenario (232), and list what turns
  red, split by whether the red scenario loads any of the theory's parts:
  its models (`family`, `souls`, `friendship`, `bonds`, `polygamy`,
  `separate_act`, `asexual`), its candidates and stress switches, and the
  authority cases written in its vocabulary (`disparity`, `limbo`,
  `refusal`).

A rule whose deletion reddens a scenario that loads none of the theory's
parts is needed outside the theory. A rule whose deletion reddens only
the theory's scenarios is the theory's, or untested elsewhere. A rule
whose deletion reddens nothing is a mutation gap.

A **borderline** case is one where the evidence and the label disagree.

## SUMMARY

183 statements in `icon_core.lp` and `icon_analogy.lp`, after the kernel
was given creatures of its own (`kernel_world.lp`; K1–K14) and the two
fixes it led to:

| Layer | Statements | Needed outside the theory | Exercised only through the theory | Untested |
| --- | --- | --- | --- | --- |
| deposit | 18 | 14 | 4 | 0 |
| kernel | 112 | 98 | 8 | 6 |
| school | 4 | 4 | 0 | 0 |
| icon | 49 | 4 | 38 | 7 |

Before the kernel's world: 177 statements; kernel 42 / 28 / 37, deposit
8 / 7 / 2; 46 untested in all.

The "core" is mostly kernel. The theory proper is 49 statements.

## INVENTORY

By section. Per statement, with reasons and the red tests: `docs/layers.csv`.

| File | Section | Statements | Layers | Evidence |
| --- | --- | --- | --- | --- |
| `icon_core` | switch defaults | 3 | icon | icon-only 1, untested 2 |
| `icon_core` | sorts | 10 | deposit 2, kernel 8 | out 6, icon-only 2, untested 2 |
| `icon_core` | A0 inventory | 12 | kernel 10, icon 2 | out 9, icon-only 3 |
| `icon_core` | A1 creation | 3 | deposit 2, school 1 | out 3 |
| `icon_core` | A2 poles | 16 | kernel 14, icon 2 | out 13, icon-only 3 |
| `icon_core` | A9, A5 | 11 | icon | icon-only 10, untested 1 |
| `icon_core` | A6, A7 | 9 | icon | icon-only 7, untested 2 |
| `icon_core` | A3, A4 origin | 28 | kernel 20, school 2, icon 6 | out 22, icon-only 6 |
| `icon_core` | A3 grain | 3 | deposit 2, icon 1 | out 2, icon-only 1 |
| `icon_core` | monarchy | 1 | deposit | out 1 |
| `icon_core` | distinction of persons | 7 | kernel | out 6, icon-only 1 |
| `icon_core` | A11 guards | 2 | icon | icon-only 1, untested 1 |
| `icon_core` | dropped clause | 4 | icon | icon-only 3, untested 1 |
| `icon_core` | A8 | 2 | kernel 1, icon 1 | out 1, icon-only 1 |
| `icon_core` | A10 | 8 | deposit 7, icon 1 | out 4, icon-only 4 |
| `icon_core` | A11 | 3 | kernel 1, icon 2 | icon-only 3 |
| `icon_core` | communicatio | 6 | kernel | out 6 |
| `icon_analogy` | analogy: sorts | 3 | kernel | out 3 |
| `icon_analogy` | analogy: bridges | 5 | kernel 3, icon 2 | out 4, icon-only 1 |
| `icon_analogy` | analogy: modes | 11 | deposit 4, kernel 3, school 1, icon 3 | out 11 |
| `icon_analogy` | analogy: univocity | 4 | kernel | out 2, icon-only 2 |
| `icon_analogy` | analogy: licensing | 5 | kernel | out 4, icon-only 1 |
| `icon_analogy` | analogy: crossing guards | 7 | kernel | out 5, untested 2 |
| `icon_analogy` | analogy: sort table | 20 | kernel | out 18, untested 2 |

"out": deleting it reddens a scenario that loads none of the theory's
parts. "icon-only": only the theory's scenarios. "untested": nothing.

Other files, by program:

| File | Deposit | Kernel | School | Icon |
| --- | --- | --- | --- | --- |
| `icon_models.lp` | `trinity` (with one school line, below) | `communicatio` (fixture) | — | `family`, `souls`, `friendship`, `bonds`, `polygamy`, `separate_act`, `asexual` |
| `icon_tests.lp` | `cand_receiver_lesser` | 17 fixtures (rescue, Augustine, Lateran, analogy stress, `two_sons`) | 8 (the minds of Augustine and Palamas, Nazianzen's Adam, monopatrism, energies, the two distinction principles) | 16 candidates and stress switches |
| `icon_metaphysics.lp` | `defined_attributes` | the simplicity whitelist | the 24 Theses and every reading | the treatise's two sentences |
| `kernel_world.lp` | — | `world`, its claims, and ten refused positions | — | — |
| `icon_history.lp` | tier-1 sources | — | tier 4–5 sources | `disparity`, `limbo`, `refusal`, `a9_universal`, `virginity` (written in the theory's vocabulary) |

`icon_authority.lp`, `canon_law.lp`, `pair.lp` and `library.lp` are
machinery: none names a predicate of the theory.

## BORDERLINE

Where the evidence and the label disagree, or where one rule straddles two
layers.

**The kernel's creaturely half was tested only through the theory.** Every
creature in the suite was one of the theory's: man, woman, child, soul,
bacterium. 28 kernel statements, and creation itself (A1), were exercised
only by the theory's models. The kernel now has a world of its own, from
stones to angels; 7 remain. Giving it one exposed two kernel errors
(created person read as human; two givers of being typed as a norm
breach) and two overreaches of the theory (its norm of origin reached
lions; its call to be bridal reached angels), all four since fixed. See
[ttc-findings(7)](findings.md) §15.

**The theory's bridges load in every run.** The principle and grain
bridges exist for the theory's analogy of contraction (one principle of the
Spirit, one principle of the child). Their modes are always on, so deleting
one reddens every scenario, authority and canon included. They should load
with the theory, not with the kernel.

**Two findings run through the theory's machinery.** The univocity
stress tests (UN1, UN2, S3, AN3: finding §1, Scotus) and the Photius row of
the Filioque table (FQ4) use the theory's circuit-only license to mean "no
license". The kernel needs its own switch: no divine contraction.

**One power is the Latin account, not the dogma.** Lyons II teaches one
principle (DH 850). That the one principle is one *power* is Thomas's
explanation (ST I q.36 a.4). The deposit model M1 carries one school line.

**The deposit's prohibitions on persons are tested only through the
theory.** Equal dignity (GS 29) and the image not denied are enforced only
on the theory's models. Consubstantiality (Nicaea) is enforced on the
Trinity (X1).

**Agere sequitur esse** is labelled school: common to the four schools,
denied by occasionalism, defined nowhere. The theory uses it once (T1).

**"God is not a level"** is the theory's vocabulary for a deposit truth:
God really and essentially distinct from the world (DH 3001), not in a
genus (ST I q.3 a.5).

**The kernel names the theory.** The vacuity list names the theory's
poles (`bridal`, `called_bridal`); two crossing guards and four entries of
the sort table name its predicates (`needs_welcome`, `level`, `lone`,
`bridegroom`). Dependencies must point downward. Each layer should
register its own sorts.

## DIAGNOSTICS

13 statements turn nothing red when deleted (46 before the kernel's
world):

- **7 of the theory's**: two switch defaults, the motif check, a pending
  ratification, the licenses interchanged, lone generation by kind. The
  theory's to close.
- **2 that name the theory**: the crossing guards for `level` and
  `welcome_owed`. They move with the theory.
- **2 that cannot fail**: the `hypostatic` entries of the sort table.
  The static check ignores that sort.
- **2 definitional**: the incarnate Word is a person; human persons have
  human nature. Nothing yet asks.

Earlier pages said every rule, deleted, turns a test red. That held for the
canon layer and the files added since. It did not hold for the grammar
core.

## SEE ALSO

[ttc-core(5)](core-edition.md), [ttc-findings(7)](findings.md),
[ttc-thomism(7)](research/thomism-preregistration.md)

## CAVEATS

The labels are judgments. The evidence checks them; it does not make them.

Blast radius depends on what the suite happens to test. A rule untested
today may be needed tomorrow.

## BUGS

The theory built the platform and then lived in it. The platform was
always going to look like the theory from the inside.
