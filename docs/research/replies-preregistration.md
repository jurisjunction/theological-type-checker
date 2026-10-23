# TTC-REPLIES(7)

## NAME

**ttc-replies** — a particular reply weighs and never cleaves; predictions,
committed before encoding on `main`

## DESCRIPTION

Read as the rules stand at `4f2ddf6` (`main`), whose rules are those of
`808a001`:

- **Every juridical source cleaves.** A source of force `juridical` that
  supports a value cleaves the contrary (`cleave_raw/2`, its second rule),
  whatever it is: a law, a general decree, or a letter answering one bishop.
  A juridical source at tier 3 cleaves by the first rule as well.
- **Between such sources, the later prevails.** Two at the same tier on a
  juridical or governance question are contrary (`contrary/3`), and the
  earlier is superseded (`superseded/2`, c. 20) unless the later's legislator
  is lower.
- **A juridical source never weighs.** `disagrees/3` counts a source that
  supports a value only if its force is `truth`; `interprets/3` is the other
  way in.

So three replies of one office settle a question against one reply of
another office by their dates alone, and none of the four is counted in any
weight.

The discussion that found this: a canonists' thread on c. 1165 §2, whether a
diocesan bishop may sanate a marriage of two Catholics invalid for lack of
form. One canonist argued from three replies of the Dicastery for
Legislative Texts (2019, 2023, 2025) against one reply of the Congregation
for Divine Worship (2018, as reported). Entered with `supports/3` at tier 3,
the base gave yes settled and no a live shadow cleaved by the three later
replies, the earlier superseded. Entered with `interprets/3` against c. 1165
§2 typed ambiguous, both readings stayed open and yes was preferred by
weight. The argument's conclusion followed from the encoding, not from the
law.

The proposal: a particular reply weighs and never cleaves. Even an authentic
interpretation given as an administrative act in a particular matter binds
only the persons and matters for which it was given (c. 16 §3); a reply that
is not an authentic interpretation binds no further. Lex posterior is a rule
of laws (c. 20). The practice of the Roman Curia is named among the means of
supplying a lacuna (c. 19): it informs; it does not legislate.

TTC-MANNER left out "a juridical act that says it binds no one". This is a
different thing: not the act's own word about itself (`limited/2`), but the
law's word about a reply's reach.

A first version was written on 22 October 2026 in a scratch copy of
`05246c9` and run there: its test passed, and `pytest -q` gave 820 passed,
13 skipped. These predictions follow that run and are not blind to it. What
they stake is the encoding on `main`, beside TTC-MANNER's guard in the same
rule and TTC-WITNESS.

## THE TEXTS

| Text | What it says (as the base's norm blocks give it, from vatican.va) |
| --- | --- |
| c. 16 §3 | An interpretation "in a sentence or an administrative act in a particular matter … binds only the persons and matters for which it was given". |
| c. 19 | Where custom and express law are lacking, a case, unless penal, is resolved by laws in similar matters, general principles applied with canonical equity, "the jurisprudence and practice of the Roman Curia", and the common opinion of the learned. |
| c. 20 | "A later law abrogates or derogates from an earlier one if it says so expressly, is directly contrary to it, or completely reorders the entire matter of the earlier law." |

## PREDICTIONS

### RP: particular replies

- **RP1.** One slot, `particular_reply(S)`: S is a juridical answer given in
  a particular matter, to a bishop, a tribunal or a petitioner (c. 16 §3).
  The encoder enters it; nothing derives it from `character/2` or
  `dicastery/1`.
- **RP2.** On a source of force `juridical`, it never cleaves, by either rule
  of `cleave_raw/2`. So it is never `contrary/3`: it is not superseded,
  supersedes nothing and outranks nothing. No lex posterior runs between
  replies, nor between a reply and a law.
- **RP3.** It weighs at its tier: `disagrees/3` counts it in each branch
  whose value it disagrees with, and `weight/2` sums it at its character's
  points. `weighs_only/2` notes it in every branch.
- **RP4.** The form does not lift it. A particular reply approved in forma
  specifica still never cleaves: c. 16 §3 is of reach, not rank.
- **RP5.** On a source of force `truth` it changes nothing. c. 16 §3 is of
  interpretations of law; such a source cleaves, notes and is owed as now.
- **RP6.** Unmarked, as now. A juridical letter entered without the slot
  cleaves, and the later supersedes the earlier.
- **RP7.** Independent of TTC-MANNER. Neither `particular_reply/1` nor
  `limited/2` reads the other.

### CA: the cases

- **CA1.** A new case, marked HYPOTHETICAL, with synthetic sources: on a
  juridical question, one reply of one office (2018) holding no and two of
  another (2019, 2023) holding yes, each a tier-3 letter; on a doctrinal
  question, a tier-3 letter of force `truth` holding yes. A switch marks all
  four as particular replies; another puts the 2023 reply in forma
  specifica.
- **CA2.** Unmarked: yes settled on the juridical question, no a live shadow
  cleaved by the two later replies.
- **CA3.** Marked: both values open on the juridical question, yes preferred
  by weight, `weighs_only/2` for each reply in every branch. On the doctrinal
  question, yes settled as before (RP5).
- **CA4.** Marked, the 2023 reply in forma specifica: as CA3 (RP4).

### SU: the suite

- **SU1.** No expectation changes. The 618 scenarios pass with no output
  changed.

### CL: the norm graph

- **CL1.** No vicious cycle and nothing undefined; PR4 clean.

No test is expected to go red.

## NOT IN THIS REPAIR

A reply deciding its own matter: in the authority graph a question is
general, and the particular matter is the canon layer's
(`particular_matter/2` with `authentic_reading/3`), which already confines an
authentic interpretation in a particular matter to it. The rank of curial
offices: *Praedicate evangelium* art. 12 §1 holds them juridically equal, and
`dicastery/1` already gives each rank 3. A private answer on a doctrinal
question: whether it reaches beyond its addressee is a question of teaching,
left as it stands.

## SEE ALSO

docs/research/manner-preregistration.md, docs/canon-law-layer.md.

## SCORING

Scored on the encoding (branch `replies`, from `a975fc9`), against the
predictions above as committed and stamped (`d775bd9`, proof `a975fc9`).

| Prediction | Result |
| --- | --- |
| RP1 | **Hit.** `particular_reply/1`, entered by the encoder; no rule derives it. |
| RP2 | **Hit.** RP2: both values open, no branch cleaved. A guard on each rule of `cleave_raw/2` (`reply_bound/1`); each guard taken out alone turns RP2 and RP3 red. |
| RP3 | **Hit.** RP2: yes preferred by weight; `weighs_only/2` for each reply in every branch. |
| RP4 | **Hit.** RP3: in forma specifica, as RP2. |
| RP5 | **Hit.** RP4: the teaching letter, marked, still cleaves; no `weighs_only/2` for it. |
| RP6 | **Hit.** RP1: unmarked, yes settled, no a live shadow of the two later replies. |
| RP7 | **Hit.** `reply_bound/1` and `limited/2` share only the guard's line; MA1-MA8 and HG1 unchanged. |
| CA1 | As stated: the case `replies_hyp` and its switches `replies_marked` and `replies_specific`. The four sources carry a character (`letter`), as PR4 asks. |
| CA2 | **Hit.** RP1. |
| CA3 | **Hit.** RP2, RP4. |
| CA4 | **Hit.** RP3. |
| SU1 | **Hit.** The 618 scenarios before the encoding pass with no output changed: each run on `a975fc9` and on the branch, and the outputs compared. The four new ones pass. `pytest -q`: 847 passed, 13 skipped. |
| CL1 | **Hit.** CL1: 103 norms, 374 edges, no vicious cycle, nothing undefined; PR4 clean. |

Each new rule has a test that fails without it (rule 5). Each taken out
alone: `reply_bound/1`, RP2 and RP3; its test of force `juridical`, RP4;
`weighs_only/2`, RP2; the guard on the first rule of `cleave_raw/2`, RP2 and
RP3; on the second, RP2 and RP3; `disagrees/3` for replies, RP2 and RP3.

One finding of method, from the first version. Run by the fix method with
only the second rule of `cleave_raw/2` guarded, the replies still cleaved: a
juridical source at tier 3 cleaves by the first rule as well. The fix method
reported no loss, because no scenario then entered the slot. A fix whose
case is not yet in the suite cannot be judged by the suite alone.
