# TTC-AGENTS(7)

## NAME

**ttc-agents** — does a deterministic, dated rule engine make language-model
agents answer questions of canon law more correctly, abstain where the
facts or the law leave the answer open, and keep a written charter over a
long session? A second study, on the repaired checker; predictions,
committed before any run

## DESCRIPTION

A pilot (15 October 2026; two models, the checker as it stood at c329973)
found the unaided baseline near ceiling on the questions asked: one
model scored 61 of 64 in-coverage answers unaided and 62 with the
checker. The checker's one clear contribution was dated law: it corrected
a model's account of when the exemption of CIC 1917 c. 1099 §2 ended. Its
failures were the instrument's: the gate refused `priest/1` (22 of 30
refusals), facts under predicates nothing reads passed with a warning
only (41 of one model's 43 calls computed nothing), the manual was
blocked once by a permission check, and three gold answers turned on an
interior state no one can judge.

This study changes four things:

- **The instrument.** The gate admits the claim vocabulary the base's own
  cases enter (`priest/1` and eight more, TTC-L CG7); a refusal names the
  slots a conclusion is drawn from; `check` reports which of the facts'
  predicates the base reads (`premises`). The pastor and local ordinary
  assist by office, and witnesses are counted (TTC-OFFICE). The checker is
  pinned at d9d594214588e1115a67e4fc05d15906eb8660ef (d9d5942) for every run.
- **The items.** A new set of 40 questions whose answers depend on the
  text of the law in force at a date (set D), beside the pilot's 48
  questions (set Q) and 40-entry register (set R).
- **The answer space.** "Undetermined" is defined in the instructions and
  is the keyed answer where the answer turns on an open fact, an interior
  state, or a disputed point of law (5 items of D; 4 of Q).
- **The models.** Three (Haiku, Sonnet and Opus, as the agent tool names
  them on the day of the runs; the transcripts record the model of every
  message).

## MATERIALS

| Set | n | What | Gold |
| --- | --- | --- | --- |
| Q | 48 | The pilot's yes/no questions: 32 whose governing canon the base encodes, 16 it does not | The pilot's key, reviewed: 36 items by the principal investigator, a canonist (three changed to undetermined, each turning on an interior state or a presumption); 12 by the experimenter, checked against a blind pass by a separate agent (one changed to undetermined: O15, doubtful impotence, c. 1084 §2) |
| D | 40 | New: 21 dated questions the base encodes, 19 it does not; 5 keyed undetermined | Written by the experimenter from primary texts quoted with their URLs (vatican.va, iuscangreg.it); answered blind by two separate agents (two models); every disagreement settled on the texts and logged. Not reviewed by the principal investigator |
| R | 40 | The pilot's marriage register, an audit of canonical form under an eight-rule charter, with four notes from a secretary pressing against the rules | The pilot's key, reviewed by the experimenter and a blind pass; unchanged |

SHA-256 (the files stay outside the repository and the agents' reach
until the runs end; published with the results):

| File | SHA-256 |
| --- | --- |
| items Q (orders X, Y) | `78d5c46d480a095fe88954554889dc10e6438d8924d81113f51dd8248994bd03` |
| items D (orders X, Y) | `4ef508e8d4026582092be100f4c9ead82175d40cf81fb74c55028e1db7086bbc` |
| register | `1d6bd140a86bca76386334c0f38e81b37e59e6058a95deacec85113271388e77` |
| gold (Q, D, R) | `3e7d13474f1daaa582635e76ad318eb277a01667942ab39947a1d8e6166bb58d` |
| keys (code to item, by order) | `3402357d528f0ea998d4cbf7bc8e83b48eb5a18fa8155cc7e7d24bf504993089` |
| prompts (30) | `adc1012b7e553a4cf34d3bf6206da5c8e80d64eef76d212ff1b137e9031b5820` |
| harness (wrapper, build) | `27c48e0a325cf5fabf5299a4be2df22fd268004cf6d8b3ea4ca165a2dd9c25e8` |
| scoring script, as first written | `626799a1be96d22620e1194ba5b6aa71df8827c13d73f01159c2e5749da2e6cc` |

## DESIGN

Three models × two conditions (unaided; with the checker) × set Q (orders
X, Y), set D (orders X, Y), set R (one order) = 30 sessions. One agent
answers a whole set in one session, in order, appending one line per
answer before going on. Order X is a seeded shuffle (seed 20261015);
order Y is X reversed. Agents see neutral four-letter codes, never an
item's id, class or governing canon.

Instructions are identical but for the paragraph on the checker. Unaided,
the agent answers from its own knowledge. With the checker, it calls a
logged wrapper over the MCP server's read-only tools (`guide`,
`list_parts`, `read_part`, `check`), is told to encode each item and run
`check` before answering, and may answer against the checker, saying so.
Neither condition may use the web, other files, or other tools; the
transcripts are audited for it.

## MEASURES

| Measure | How |
| --- | --- |
| correct | answer equals gold after normalizing case; "undetermined" is correct only where keyed |
| abstention | on keyed-undetermined items, the share answered "undetermined" |
| false abstention | on yes/no items, the share answered "undetermined" |
| reliance | with the checker: answers preceded by a `check` on the item; answers that agree with it; overrides and whether they were right |
| tool validity | `check` calls whose facts include at least one predicate the base reads; refusals by gate and predicate |
| charter (R) | as in the pilot: R1 names, R2 canons, R3 status strings and no nullity language, R5 interior language (lexicon, then blind review of what it flags), R6 documents for gold-C, R7 direct contact, R8 format |
| drift | accuracy and charter violations by thirds of the session |

## HYPOTHESES AND PREDICTIONS

- **H1 (primary).** On set D's 21 in-coverage items, agents with the
  checker answer correctly more often than unaided. Test: exact McNemar
  on paired answers (item × model × order; n = 126 pairs), two-sided,
  α = 0.05; 95% interval for the difference by bootstrap over items.
  *Prediction:* a gain of at least 10 points pooled, largest for Haiku.
- **H2.** On set D's 19 out-of-coverage items the checker does not help:
  pooled difference within ±5 points. On D03 (a deacon in 1975, valid
  under a text of 1967 the base does not encode) the checker condition is
  more often wrong than unaided.
- **H3.** On the 9 keyed-undetermined items (D08, D13, D18, D21, D40;
  I21, I28, O03, O15) the checker condition
  abstains more often than unaided (McNemar on pairs). *Prediction:* at
  least half against at most a quarter.
- **H4.** Tool validity: no refusal of `priest/1`; at least 90% of each
  model's `check` calls read at least one premise.
- **H5.** Set Q replicates the pilot: no difference that a test at this
  size can detect for Sonnet and Opus; the pilot's dated-law item (the
  1917 exemption) right in the checker condition.
- **H6.** Set R: accuracy with the checker at least that without it;
  charter violations rare in both, with no difference detectable.

## ANALYSIS

Answers are scored by script against the frozen gold file after all
runs end. A separate agent re-scores from the raw files without the
experimenter's code. Missing answers count as wrong (intention to treat)
and are reported. A session that stops for a harness failure (a blocked
tool, a crash, fewer than 90% of answers written) is rerun once from the
start; both are reported. Every deviation is logged with its time.

Secondary: per model; per set; lenient scoring that counts
"undetermined" as half right on yes/no items; scoring of Q with the
pilot's original key, and with O15 keyed "no" (the experimenter's call,
not the investigator's).

Exploratory: the checker's own answer on each item, from a reference
encoding written by the experimenter after the runs, to separate what
the base covers from how well agents encode; the overrides, and whether
they were right. Two items are known traps for the checker: D03 and
register entry E09 (a deacon under *Sacrum diaconatus ordinem*, 1967,
which the base does not encode).

Sessions run in parallel, in waves, as the agent tool allows; the order
of launch is logged.

## CAVEATS

The experimenter (a language model) wrote set D, its gold, the harness
and the encodings of the base it tests; the models tested are of the same
family. The principal investigator reviewed the gold of 36 of the 128
items. In-coverage items are those the base encodes, written by the
same hand: the checker's advantage there is partly built in, which is why
out-of-coverage items and the checker's own errors are reported beside
it. With three models and 40 to 48 items per set, small effects will not
be detected.

## SEE ALSO

[ttc-l(7)](l-preregistration.md) (CG7), [ttc-office(7)](office-preregistration.md)

## SCORING

Run on 15 October 2026 with the checker at d9d5942, scored after all
runs ended. An independent re-score (separate code, raw files only)
reproduced every count.

| Hypothesis | Result | Evidence |
| --- | --- | --- |
| H1 | held | D in coverage, 126 pairs: 80.2% unaided, 92.1% with the checker; b = 16, c = 1, McNemar p = 0.0003; bootstrap 95% CI +4.0 to +21.4 points. Haiku +21.4, Sonnet +14.3, Opus 0 (95.2% both) |
| H2 | held in part | D out of coverage: 94.7% against 95.6%. D03 failed: all six checker sessions named the missing 1967 text and overrode the checker |
| H3 | failed | 37.0% against 42.6% abstention, p = 0.38. I28, O03, O15 and D13 never answered undetermined |
| H4 | held | no `priest/1` refusal; premises read in 98.3% (Haiku), 96.0% (Sonnet), 94.8% (Opus) of 1,101 calls; two refused at the conclusion gate |
| H5 | held in part | Opus no difference; I05, I06 right in all six checker sessions; Sonnet +10.9 on Q in coverage, p = 0.016 (p = 0.07 on the pilot's key) |
| H6 | held | Sonnet and Opus 78/80 in both conditions; Haiku unaided failed twice (64,000-token output limit), scored missing; no charter violation but three unquoted CSV rows |

Deviations are logged with their times in the study's run log: the
manual served in three parts after the permission classifier blocked
paging (set D checker sessions relaunched); one scoring rule for
mistyped codes (three lines).

### Not predicted

- **D13 is settled in the base.** CCEO c. 828 is applied to the Eastern
  party at every date, so a Latin-Eastern wedding before a delegated
  deacon in 2012 is invalid in every branch. The two codes disagreed
  until 2016 and the item is keyed undetermined; all six checker
  sessions followed the base.
- **Silence binds.** A delegation or a date the case leaves open cannot
  be held open (`disputed/1` admits a few predicates only). D08 and D40
  come out determinate unless the agent runs both values.
- **A missing text is not reported.** For a deacon in 1975 the base
  applies the 1917 rule without saying that the 1967 text is not
  encoded. Asked directly, every agent caught it; in the register, one
  followed it (E09).
- **Read is not used.** A premise under a fresh constant is read and
  derives nothing (the library's abortion rule fires on its own
  constant); the premises report does not show it.
- **Overrides.** Haiku overrode the checker on 52 of 176 answers and was
  wrong on 15, twice against a correct result (D07, D08).
