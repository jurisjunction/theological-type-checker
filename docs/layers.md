# TTC-LAYERS(7)

## NAME

**ttc-layers** — what each rule is: deposit, kernel, school, or the
*Grammar of the Icon*

## DESCRIPTION

The rule base grew around one theory, *The Grammar of the Icon*. To state
that theory exactly, it had to build machinery that every school needs.
The theory and the machinery sat in the same files. This page sorted
them, rule by rule; the sort then moved the theory into a file of its own
(`icon_theory.lp`), and this page measures the result.

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

For every statement of `kernel_core.lp`, `kernel_analogy.lp` and
`icon_theory.lp` (`tools/layer_evidence.py`):

- **cites**: the source in its comment.
- **sorts**: whether it names divine-sorted or creature-sorted predicates.
- **icon predicates**: whether it names a predicate only the theory uses
  (`nupt`, `consent`, `bond`, `total`, ...).
- **blast radius**: delete it, run every scenario (234), and list what turns
  red, split by whether the red scenario loads any of the theory's parts.
  A part is the theory's when it declares `uses(icon)`: its models
  (`family`, `souls`, `friendship`, `bonds`, `polygamy`, `separate_act`,
  `asexual`), its candidates and stress switches, the treatise's two
  sentences, and the authority cases written in its vocabulary
  (`disparity`, `limbo`, `refusal`, `a9_universal`). AN13, the static
  check of the theory's sorts, counts as the theory's.

A rule whose deletion reddens a scenario that loads none of the theory's
parts is needed outside the theory. A rule whose deletion reddens only
the theory's scenarios is the theory's, or untested elsewhere. A rule
whose deletion reddens nothing is a mutation gap.

A **borderline** case is one where the evidence and the label disagree.

## SUMMARY

187 statements in `kernel_core.lp`, `kernel_analogy.lp` and
`icon_theory.lp`, after the split:

| Layer | Statements | Needed outside the theory | Exercised only through the theory | Untested |
| --- | --- | --- | --- | --- |
| deposit | 17 | 13 | 4 | 0 |
| kernel | 106 | 95 | 8 | 3 |
| school | 4 | 4 | 0 | 0 |
| icon | 60 | 0 | 50 | 10 |

The files now match the layers. The kernel files hold the deposit, the
kernel and four school statements; the theory's file holds the theory and
nothing else. No statement of the theory is needed outside it.

Before the split (183 statements, in `icon_core.lp` and `icon_analogy.lp`):
deposit 18 / 14 / 4 / 0, kernel 112 / 98 / 8 / 6, school 4 / 4 / 0 / 0,
icon 49 / 4 / 38 / 7. Before the kernel's world: 177 statements, 46
untested.

## INVENTORY

By section. Per statement, with reasons and the red tests: `docs/layers.csv`.

| File | Section | Statements | Layers | Evidence |
| --- | --- | --- | --- | --- |
| `kernel_core` | sorts | 10 | deposit 2, kernel 8 | out 6, icon-only 2, untested 2 |
| `kernel_core` | A0 inventory | 10 | kernel | out 9, icon-only 1 |
| `kernel_core` | A1 creation | 3 | deposit 2, school 1 | out 3 |
| `kernel_core` | A2 poles | 14 | kernel | out 13, icon-only 1 |
| `kernel_core` | A3, A4 origin and grain | 26 | deposit 3, kernel 20, school 3 | out 26 |
| `kernel_core` | distinction of persons | 7 | kernel | out 6, icon-only 1 |
| `kernel_core` | finitude | 1 | kernel | out 1 |
| `kernel_core` | A10 image and dignity | 7 | deposit | out 4, icon-only 3 |
| `kernel_core` | A11, communicatio | 7 | kernel | out 6, icon-only 1 |
| `kernel_analogy` | sorts | 3 | kernel | out 3 |
| `kernel_analogy` | bridges | 3 | kernel | out 3 |
| `kernel_analogy` | modes | 6 | deposit 3, kernel 3 | out 6 |
| `kernel_analogy` | univocity | 4 | kernel | out 2, icon-only 2 |
| `kernel_analogy` | licensing | 5 | kernel | out 4, icon-only 1 |
| `kernel_analogy` | crossing guards | 5 | kernel | out 5 |
| `kernel_analogy` | sort table | 16 | kernel | out 15, untested 1 |
| `icon_theory` | switches | 4 | icon | icon-only 2, untested 2 |
| `icon_theory` | A0 relation N | 2 | icon | icon-only 2 |
| `icon_theory` | A2 poles | 3 | icon | icon-only 3 |
| `icon_theory` | A9 | 3 | icon | icon-only 3 |
| `icon_theory` | A5 | 8 | icon | icon-only 7, untested 1 |
| `icon_theory` | A6 | 5 | icon | icon-only 5 |
| `icon_theory` | A7 | 4 | icon | icon-only 2, untested 2 |
| `icon_theory` | A4 circuit | 6 | icon | icon-only 6 |
| `icon_theory` | bridges, A3 grain | 9 | icon | icon-only 9 |
| `icon_theory` | A4, A11 guards | 2 | icon | icon-only 1, untested 1 |
| `icon_theory` | dropped clause | 4 | icon | icon-only 3, untested 1 |
| `icon_theory` | A8 | 1 | icon | icon-only 1 |
| `icon_theory` | A10 states of life | 1 | icon | icon-only 1 |
| `icon_theory` | A11 | 4 | icon | icon-only 2, untested 2 |
| `icon_theory` | sort table | 4 | icon | icon-only 3, untested 1 |

"out": deleting it reddens a scenario that loads none of the theory's
parts. "icon-only": only the theory's scenarios. "untested": nothing.

Other files, by program:

| File | Deposit | Kernel | School | Icon |
| --- | --- | --- | --- | --- |
| `icon_models.lp` | `trinity` (with one school line, below) | `communicatio` (fixture) | — | `family`, `souls`, `friendship`, `bonds`, `polygamy`, `separate_act`, `asexual` |
| `icon_tests.lp` | `cand_receiver_lesser` | 17 fixtures (rescue, Augustine, Lateran, analogy stress, `two_sons`) | 9 (the minds of Augustine and Palamas, Nazianzen's Adam, monopatrism, Photius's denial of one power, energies, the two distinction principles) | 18 candidates and stress switches |
| `icon_metaphysics.lp` | `defined_attributes` | the simplicity whitelist | the 24 Theses and every reading | the treatise's two sentences |
| `kernel_world.lp` | — | `world`, its claims, and ten refused positions | — | — |
| `icon_history.lp` | tier-1 sources | — | tier 4–5 sources | `disparity`, `limbo`, `refusal`, `a9_universal` (written in the theory's vocabulary) |

Every program in the Icon column declares `uses(icon)`.
`icon_authority.lp`, `canon_law.lp`, `pair.lp` and `library.lp` are
machinery: none names a predicate of the theory.

## BORDERLINE

Where the evidence and the label disagree, or where one rule straddles two
layers.

**The kernel's creaturely half was tested only through the theory.** Every
creature in the suite was one of the theory's: man, woman, child, soul,
bacterium. 28 kernel statements, and creation itself (A1), were exercised
only by the theory's models. The kernel now has a world of its own, from
stones to angels; 8 remain. Giving it one exposed two kernel errors
(created person read as human; two givers of being typed as a norm
breach) and two overreaches of the theory (its norm of origin reached
lions; its call to be bridal reached angels), all four since fixed. See
[ttc-findings(7)](findings.md) §15.

**The theory's bridges loaded in every run.** The principle and grain
bridges exist for the theory's analogy of contraction (one principle of the
Spirit, one principle of the child). They were always on, so deleting one
reddened every scenario, authority and canon included. They now load only
when a part declares `uses(icon)`. The Spirit's one principle (DH 850) is
checked by the deposit directly, through no analogy.

**The theory's principle bridge did nothing.** Its circuit made two
parents one principle without passing through it: deleting the bridge
reddened one scenario, by a count of projections (TH8). The circuit now
goes through the bridge, and AN14 drops the bridge: the child has two
principles and the norm is breached. No other output changed.

**Two findings ran through the theory's machinery.** The Photius row of
the Filioque table (FQ4) and FQ3 used the theory's circuit-only license to
mean "no license". They now use the kernel's own switch,
`no_divine_contraction`. The univocity stress tests (UN1, UN2, S3, AN3:
finding §1) still use the theory: they test its analogy under univocity, and
K9 shows the kernel's half without it.

**One power is the Latin account, not the dogma.** Lyons II teaches one
principle (DH 850). That the one principle is one *power* is Thomas's
explanation (ST I q.36 a.4). The deposit model M1 carries one school line,
and the kernel turns the license on by default
(`divine_contraction(identity_of_power)`). These, and *agere sequitur
esse*, are the four school statements in the kernel files; they move when
the schools get runtimes of their own.

**The deposit's prohibitions on persons are tested only through the
theory.** Equal dignity (GS 29) and the image not denied are enforced only
on the theory's models. Consubstantiality (Nicaea) is enforced on the
Trinity (X1).

**Agere sequitur esse** is labelled school: common to the four schools,
denied by occasionalism, defined nowhere. The theory uses it once (T1).

**"God is not a level"** is the theory's vocabulary for a deposit truth:
God really and essentially distinct from the world (DH 3001), not in a
genus (ST I q.3 a.5).

**The kernel named the theory.** The vacuity list named the theory's
poles (`bridal`, `called_bridal`); two crossing guards and four entries of
the sort table named its predicates (`needs_welcome`, `level`, `lone`,
`bridegroom`). They now live in the theory's file, and each layer registers
its own sorts (AN13, K14).

## ENFORCEMENT

The theory now has a file of its own, `icon_theory.lp`. The kernel files
(`kernel_core.lp`, `kernel_analogy.lp`, `kernel_world.lp`) may not name a
predicate of the theory; a test fails if one does
(`test_kernel_names_nothing_of_the_theory`). Dependencies point downward:
the theory uses the kernel, never the reverse.

## DIAGNOSTICS

13 statements turn nothing red when deleted (46 before the kernel's
world):

- **10 in the theory's file**: two switch defaults that nothing reads,
  the motif check (two statements), a pending ratification, the licenses
  interchanged, lone generation by kind, the crossing guards for `level`
  and `welcome_owed`, and the `hypostatic` entry for `bridegroom`. The
  theory's to close.
- **3 in the kernel**: two definitional (the incarnate Word is a person;
  human persons have human nature; nothing yet asks), and the `hypostatic`
  entry for `incarnate` (the static check ignores that sort).

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

The full run predates AN14. The three statements changed with it (the
principle bridge and the two circuit rules) were measured again with it;
AN14 can only add to the others' theory-only reds.

## BUGS

The theory built the platform and then lived in it. The platform was
always going to look like the theory from the inside.
