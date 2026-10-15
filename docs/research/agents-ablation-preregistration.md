# TTC-AGENTS-M(7)

## NAME

**agents-ablation** — the manual without the solver: an ablation of the
agent study

## DESCRIPTION

In the agent study ([ttc-agents(7)](agents-preregistration.md)) the
checker condition gave agents three things at once: the manual (three
parts), the worked cases (`list_parts`, `read_part`), and `check`. On
the dated questions the base encodes, agents with all three answered
correctly more often than unaided. The manual states several of the
dates those questions turn on (the 1917 exemption until 31 December
1948, c. 1108 §3 from 2016, the porrection before 28 April 1948). The
gain may therefore come from the documentation, not the solver.

This arm withholds `check` and keeps everything else. Committed and
stamped before any session of the arm runs. The checker is unchanged
(d9d5942).

## DESIGN

- Set D, both orders (X, Y), the same task files and codes.
- Three models, as in the study: Haiku, Sonnet, Opus 5.5.
- Condition m (manual only): the engine condition's prompt with `check`
  removed. The agent reads the manual's three parts and may read worked
  cases; it answers from them and its own knowledge, citing the manual
  in a `manual` field. A `check` call is refused (gate `withheld`) and
  logged.
- 6 sessions, run concurrently. A session that fails for the harness is
  rerun once from the start.
- Compared, paired by item, model and order, with the study's unaided
  (u) and checker (c) answers of the same morning.

## MATERIALS

SHA-256 of the files outside the repository:

| File | SHA-256 |
| --- | --- |
| harness/ttcm.py | 55155692f9a70c0b77c81b51bb2bd97a575288764b3088fc93e6c032fb49d4bc |
| harness/build_m.py | 934e9aa0f97cac8d4085018eff656aaa0392e41c6b00fbd1c39edbbb0d7a9076 |
| harness/ablation.py | cd6d05842ea3317dac220d03713d2b9e306d497d10cb295affbffb984a7e1d47 |
| runs/D-h-m-X/prompt.txt | 845eff46cf93c64f26783f0eb29aaf1dae80d9225413b054355b0286bc3f182e |
| runs/D-h-m-Y/prompt.txt | f7a68be81f2f5ddf42eb856bc257eb3a5d58f7dbace6a6b4dd244b89f4824591 |
| runs/D-o-m-X/prompt.txt | 937672ee3b9e4a59f928e6f3fb5714827a86617a03fcd4c61fae5e596090fd85 |
| runs/D-o-m-Y/prompt.txt | b6469f1e859d18c9ecfd4154ce47c654dc6beb41dbc38888733b6273cee2ba85 |
| runs/D-s-m-X/prompt.txt | 0079887b5a7f41b94cb768e97d085551311b1dd9a79c5aff4cacead16cb2e1a3 |
| runs/D-s-m-Y/prompt.txt | e5b89400bb47fec291bd2f7ff2b5ae310f9b1fabe2a0875e17bfdc8159c5451f |

Items, gold and keys are the study's (hashes in ttc-agents(7)).

## HYPOTHESES AND PREDICTIONS

- **H7.** On set D's 21 in-coverage items (126 pairs): manual-only
  against unaided, and checker against manual-only, each by exact
  McNemar, two-sided, α = 0.05, with a 95% bootstrap interval over
  items. *Prediction:* the manual alone recovers at least half of the
  checker's pooled gain over unaided (manual-only at least 6 points above
  unaided), and the checker's advantage over manual-only is under 6
  points and not significant.
- **H8.** By item: on D04, D05 and D12 (dates the manual states)
  manual-only is right as often as the checker; on D07 and D08 (the 2009
  amendment, whose date the manual does not state) manual-only is no
  better than unaided; on D18 (which the checker branches) the checker is
  right at least as often as manual-only.
- **H9.** On set D's 19 out-of-coverage items, manual-only is within ±5
  points of unaided.

## ANALYSIS

`harness/ablation.py`, as hashed. Missing answers are wrong. The main
study's rule for mistyped codes applies. Per model results are
descriptive.

## CAVEATS

The arm runs hours after the u and c arms, through the same harness and
models; a change in the models or harness between the two would be
confounded with the condition. The manual describes the base, which was
written with the items in view; what it states is the same partly
built-in advantage as the checker's.

## SEE ALSO

[ttc-agents(7)](agents-preregistration.md)
