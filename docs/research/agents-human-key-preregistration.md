# TTC-AGENTS-K(7)

## NAME

**agents-human-key** — human answer keys for the dated questions of the
agent study

## DESCRIPTION

The gold of set D in the agent study ([ttc-agents(7)](agents-preregistration.md))
was written by the experimenter, a language model, and confirmed by
blind passes of models of the family it tested. No human reviewed it.
This plan fixes, before any human key exists, how human keys of set D
will be collected and used. Committed and stamped before any keyer
starts.

## KEYERS

The author and one canonist independent of the study, each keying
alone; more keyers if they agree. A keyer is named only with consent; otherwise described by
qualification. Keyers work alone until all are done. Each keyer's
exposure to the current key, the study's results or the paper beyond
its abstract is recorded at receipt; a keyer who has seen any of them
is reported as not blind, and their key is analysed separately.

## MATERIALS

A printed sheet with the 40 items of set D in order X, each with its
neutral code, and no gold or coverage label. It asks for yes, no or
undetermined, the basis, confidence and minutes, in the words the
models were given. The keyer may use any sources: it is a key, not a
test.

| File (outside the repository) | SHA-256 |
| --- | --- |
| humankey/make_sheet.py | c2d3026d7bcfc419b51f5d60428c1e50671ccfe27f551aef909e23920db65714 |
| humankey/sheet.tex | 9ce8bee7015503756e0512f4accaf47110bd8f9fe927b70d4a4fce25f901dbde |

## ANALYSIS

- **K1.** Each human key against the current key: agreement item by
  item, and Cohen's kappa over the three answers.
- **K2.** With two or more human keys: agreement between them. Where
  the keys agree, that answer is the *adjudicated key*. Where they
  split, the keyers meet after all keys are in and settle the item
  against the primary texts, writing down the reason; the split, the
  settled answer and the reason are all reported. The experimenter
  does not break ties, and an item the keyers cannot settle is left
  out of the adjudicated key.
- **K3.** H1, H2, H3 and H7 of the study and its ablation re-scored
  under each human key and under the adjudicated key, with the same
  tests and code (exact McNemar, bootstrap over items), on the answers
  already collected. No session is re-run.
- **K4.** For each item where a human key differs from the current
  key, which conditions and models agree with the human.

## PREDICTIONS

- **K1.** Each human key agrees with the current key on at least 34 of
  the 40 items, and at least half of the disagreements fall on the five
  items keyed undetermined.
- **K3.** Under each human key and the adjudicated key, the engine
  condition's accuracy on the in-coverage items exceeds the unaided
  condition's by at least 5 points, and manual only recovers at least
  half of that gain.
- **D13.** No human key answers "no" (valid). If a human key answers
  "yes" (invalid), the engine's answer on D13 is right under that key,
  and the paper's account of D13 as the engine's error is withdrawn for
  that key.

## CAVEATS

One or a few keyers; agreement between them measures the items'
determinacy as much as the keyers. The author directed the engine and
has seen the study's design; an independent keyer has not.

## SEE ALSO

[ttc-agents(7)](agents-preregistration.md),
[ttc-agents-m(7)](agents-ablation-preregistration.md)
