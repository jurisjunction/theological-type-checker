# TTC-MANNER(7)

## NAME

**ttc-manner** — the manner of speaking: an act that says it settles nothing,
and the hierarchy of truths used as a grade; predictions, committed before
encoding

## DESCRIPTION

Read as the rules stand at `4183446` (`main`):

- **Rule 14 guards one direction.** Any statement about a tier is a claim
  (`claims_tier/3`). It is noted when a lower tier speaks of a higher, and
  refused when treated as fixing (`self_elevation/2`). A claim that lowers is
  read and does nothing: `claims_tier(S,S,5)` on a tier-3 act fires no rule.
- **The form is the only measure.** LG 25 knows the mind of the one who
  teaches from three signs: the character of the documents, frequent
  repetition, and the manner of speaking. The base reads the first
  (`character/2`, `char_points/2`) and the second (`reaffirms/2`). It reads
  the third for a council only: no definition unless openly declared (rule
  14; the notification of 16 November 1964). For any other act it is not
  read.
- **So an act that says it settles nothing settles.** A tier-3 act that
  supports a value on a doctrinal question cleaves the contrary value
  (`cleave_raw/2`), notes its own value (`note_by/3`), and is owed religious
  submission (`owed/2`, c. 752 by reference), whatever its text says of
  itself.
- **The hierarchy of truths is not modelled.** Nothing reads a truth's
  place in it, so nothing can lower an assent by it. The move is not named
  either: a fact that claims it is an unknown slot and computes nothing.

The discussion that found this: *Venite ad me* (DDF, 22 October 2026), nn. 8
and 84, checked against `4183446`. A tier-3 act supporting a synthetic value
against a tier-5 work, with its own lowering entered, gave the value settled,
the contrary a live shadow cleaved by the act, and `owed(…,religious_submission)`
in every branch.

The proposal is asymmetric. The form sets the ceiling. The author's manner of
speaking, in the act itself, may lower how the act uses its tier, and never
raise it. Raising still needs its conditions shown (c. 749 §3). The hierarchy
of truths grades nothing: its use as a grade is refused, and it feeds no rule.

## THE TEXTS

| Text | What it says |
| --- | --- |
| LG 25 | The mind and will of the Roman Pontiff is made known "chiefly either by the character of the documents, or by his frequent repetition of the same doctrine, or by his manner of speaking". |
| Notification, 16 November 1964 (Declaration of the Theological Commission, 6 March 1964) | The Council defines as binding only what it openly declares; for the rest, its mind "becomes known either from the matter treated or from its manner of speaking". |
| c. 749 §3 | "No doctrine is understood as defined infallibly unless this is manifestly evident." |
| c. 752 | A religious submission of the intellect and will is owed to a doctrine that the Supreme Pontiff or the college of bishops declares on faith or morals, even if they do not intend to proclaim it by a definitive act. |
| UR 11 | In Catholic doctrine there is an order or "hierarchy" of truths, since they vary in their relation to the foundation of the Christian faith. |
| *Mysterium Ecclesiae* 4 (CDF, 1973) | The hierarchy means that some dogmas rest on the principal ones and are illuminated by them; "all dogmas, since they are revealed, must be believed with the same divine faith". The same number refuses the inference from saving faith, which turns to God, to dogmas belittled. |
| *Venite ad me* 8 (DDF, 2026) | The text is a set of Considerations, not a Doctrinal Note; it examines points of view without claiming to settle the matter, which stays open. |

The texts are quoted from vatican.va.

## PREDICTIONS

### MN: the manner of speaking

- **MN1.** Two slots: `self_limited(S)`, where S's own text says it settles
  nothing, and `self_limits(S,Q)`, where it says it settles nothing on Q.
  Each is a text's word about itself. Another text's lowering of S stays a
  claim (`claims_tier/3`), inert as now.
- **MN2.** At tier 3, a limited source never cleaves on the question it
  limits (`cleave_raw/2`). It weighs at its tier, as a particular council
  or a liturgical witness does: `disagrees/3` and `weight/2` count it.
- **MN3.** The value it holds takes no note from it, since `note_by/3` at
  tiers 2 and 3 needs `can_cleave/2`. A contrary profession is censured
  neither erroneous nor rash on its account.
- **MN4.** A limit on the whole act removes `owed/2`: c. 752 attaches
  nothing to it. A limit on one question removes `owed_as/3` for that
  question only, and `owed/2` is still noted. So `rejects(P,E,c752)` does
  not fire from a limited proposition, and the penal canon for obstinate
  rejection after a warning (c. 1371 n. 1, 1983; c. 1365, 2021) is not
  reached from it.
- **MN5.** It is not transitive. A source the limited act cites or
  reaffirms keeps its tier, its cleaving, its note, and what is owed to it.
- **MN6.** A limit entered on a source at tier 1 or 2 is refused
  (`limit_on_a_definition/1`). The form says it settles, and the limit
  changes nothing there: deletion, the de fide or definitive note, and
  cleaving are as before.
- **MN7.** The question's kind is unchanged. A limited act that supports a
  value on a doctrinal question is still teaching, and the checks of
  teaching against governance read it as before.

### HT: the hierarchy of truths as a grade

- **HT1.** One slot, `ranks_lower(C,Q)`: C treats Q as owed less assent
  for its place in the hierarchy of truths. While C is in force it is
  refused (`hierarchy_as_grade/2`; UR 11 read by *Mysterium Ecclesiae* 4).
- **HT2.** It feeds nothing. No note, tier, weight, branch, or obligation
  changes; the refusal is the only rule that reads it.
- **HT3.** It holds against the author too. An author lowering his own act
  by his manner of speaking is MN; lowering a truth by its place is refused,
  whoever does it.

### CA: the cases

- **CA1.** A new part, marked HYPOTHETICAL, with synthetic sources: a tier-3
  act supporting a value on a doctrinal question against a tier-5 work,
  entered three ways (unlimited; limited as a whole; limited on that
  question), with c. 752 attached by reference and a contrary profession; a
  tier-1 act entered as limited; and a tier-5 work entered as ranking a de
  fide value lower.
- **CA2.** Unlimited: as now. The act's value is settled, the contrary a
  live shadow cleaved by the act; `owed/2` noted; the contrary profession
  censured erroneous in the main branch, and `rejects/3` under c. 752.
  Limited as a whole: both values open, the act counted in the weight at
  tier 3; nothing owed; no censure; no rejection. Limited on the question:
  the same, except that `owed/2` is still noted for the act.
- **CA3.** The tier-1 act limited: `limit_on_a_definition`, with deletion
  unchanged. The lower ranking: `hierarchy_as_grade`, with the de fide note
  and the censure of a contrary profession unchanged.

### SU: the suite

- **SU1.** No expectation changes. No existing case enters any of the three
  slots.

### CL: the norm graph

- **CL1.** No vicious cycle and no undefined predicate; the canon layer
  declares what it reads from the authority graph. PR4 clean.

No test is expected to go red.

## NOT IN THIS REPAIR

The character `considerations`: it lies outside the sort, and the CDF's
*Considerations* of 2003 and the DDF's of 2026 share it with different
manners, so its weight is left open. A later act that lowers an earlier one,
by the same author or by a successor: a claim, as now. A juridical act that
says it binds no one. *Venite ad me* entered in the history: it supports no
contested value. The hierarchy of truths as an order of nexus to the
foundation: not modelled; only its use as a grade is refused.

## SEE ALSO

docs/research/sources-preregistration.md, docs/research/liturgy-preregistration.md.

## SCORING

Scored on the encoding (branch `manner`, from `ceb89cd`), against the
predictions above as committed and stamped (`6cce458`, proof `ceb89cd`).

| Prediction | Result |
| --- | --- |
| MN1 | **Hit.** `self_limited/1` and `self_limits/2`, each S's word about itself. MA5: a later work's `claims_tier(gloss_mn,act_mn,5)` changes nothing; the act cleaves and is owed as before. |
| MN2 | **Hit.** MA2: both values open, no branch cleaved; the act counted at tier 3 in the branch it disagrees with. |
| MN3 | **Hit.** MA2, MA3: no censure of the contrary profession. |
| MN4 | **Hit.** MA2: no `owed/2` for the act, no delict. MA3: `owed(act_mn,religious_submission)` still noted, and no delict (`owed_as/3` guarded). In MA1, unlimited, c. 1365 is reached through `rejects/3`, as before. |
| MN5 | **Hit.** MA4: the reaffirmed encyclical cleaves (the shadow is its, not the act's), is owed, and notes; nothing is owed to the act. |
| MN6 | **Hit.** MA6, MA7: `limit_on_a_definition(def_mn)`, the contrary value excluded, the censure heretical (MA6). |
| MN7 | **Hit.** MA2: no `governance_read_as_teaching`; no rule reads a limit into `question_kind/2`. |
| HT1 | **Hit.** HG1: `hierarchy_as_grade(work_ht,q(mn_def))`. |
| HT2 | **Hit.** HG1: the contrary value excluded and the censure heretical, as without it; the refusal is the only rule that reads `ranks_lower/2`. |
| HT3 | **Hit.** HG1: `hierarchy_as_grade(def_mn,q(mn_def))`, the definition's own author. |
| CA1 | As stated, in nine parts: the case `manner_hyp`, its switches `manner_whole`, `manner_on_q`, `manner_reaffirmed`, `manner_lowered_by_another` (MN1's other text) and `manner_professions` (canon: the profession warned and not retracted); the case `manner_def_hyp` and its candidates `cand_limit_on_definition`, `cand_limit_on_definition_q` (the second slot on a definition) and `cand_hierarchy_as_grade`. The act carries a character (`notification`), which PR4 asks of every teaching source. |
| CA2 | **Hit.** MA1-MA3. The delict under c. 1365 is in every branch of MA1, not the main branch only: what is owed is read off the graph, not off a branch. |
| CA3 | **Hit.** MA6, HG1. |
| SU1 | **Hit.** No expectation changed. The 598 scenarios before the encoding pass with no output changed (the fix method's run, the same rules); the eight new ones pass (MA1-MA7, HG1); `pytest -q`: 827 passed, 13 skipped. |
| CL1 | **Hit.** CL1: no vicious cycle, nothing undefined (`use limited/2` in the canon layer); PR4 clean. |

Each new rule has a test that fails without it (rule 5). Each commented out
alone: `limited_act/1`, MA2 and MA4; `limited/2` from the act, MA2 and MA4;
`limited/2` on a question, MA3; each refusal of a limit on a definition, MA6
and MA7; the guard on `cleave_raw/2`, MA2-MA4; on `owed/2`, MA2 and MA4; on
`owed_as/3`, MA3; `hierarchy_as_grade/2`, HG1.

One finding of method, on the way. The fix method, run before encoding,
turned CL1 red with `owed_as/3` undefined: it appends the rules it adds
outside every norm block, so a canon rule it replaces drops out of the norm
graph. Edited in place, with its input declared, the graph is clean.
