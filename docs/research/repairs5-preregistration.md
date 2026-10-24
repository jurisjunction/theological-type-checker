# TTC-REPAIRS5(7)

## NAME

**ttc-repairs5**: a question no source answers, shown as unanswered and
not hidden; predictions, committed before encoding

## DESCRIPTION

Read as the rules stand at `f42420b` (TTC-LINGUAE merged, PR #13):

- **The frontier counts a claim of practice as support.** To keep PR4
  clean, TTC-LINGUAE added `has_support(Q) :- practice_teaches(_,_,Q)` to
  `pair.l` (its SCORING, M1). The signed form's validity,
  `q(valid_form(baptism,sg_g1))`, has no source of any tier: no act of the
  Holy See rules on a sacramental form signed alone, and a canonist's claim
  that the Church's practice teaches it has no tier (SG5). With the rule,
  the question no longer shows on the frontier, so the base no longer says
  what it lacks.
- **The theological frontier names what the encoding lacks.** A cited
  source not encoded, a question with no source, an ambiguous source with
  no readings (`pair.l`). PR4 holds that it is empty for the public base.
  It has no place for a question the encoding has done all it can for,
  and that no source answers.

The discussion that found this: the review of PR #13, which chose to show
the gap instead of counting practice as support.

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited.

## THE DESIGN

- The rule `has_support(Q) :- practice_teaches(_,_,Q)` is withdrawn.
- A question with no support and no default, which a claim of practice
  speaks to, leaves the theological frontier and enters a frontier of its
  own: `frontier(unanswered, by_practice_only(Q))`. It is not something the
  encoding lacks. It is something no source answers, with a claim beside it.
- A question with no support and no claim of practice stays where it was,
  on the theological frontier (`question_without_sources`).
- `flywheel_status` reports the unanswered frontier beside theology, canon
  and library.

## PREDICTIONS

- **RF1.** With `linguae_signed` loaded, `frontier(unanswered,
  by_practice_only(q(valid_form(baptism,sg_g1))))` holds, and
  `frontier(theology, question_without_sources(…))` does not hold for that
  question.
- **RF2.** A question with no source, no default and no claim of practice
  still reports `question_without_sources` (a test case).
- **RF3.** PR4 holds, its expectation unchanged: the theological frontier
  of the public base is empty. `flywheel_status` lists the signed form's
  validity under `unanswered`.
- **RF4.** No other output changes: every scenario's atoms are compared
  before and after. The runs that load `linguae_signed` gain the one atom
  of RF1, and nothing else.
- **RF5.** Every new rule has a test that fails without it; CL1 and PR4
  stay clean.

## CAVEATS

A claim of practice is entered only where a case enters one. A question
answered by no source, and spoken to by no claim, stays on the theological
frontier, where it may mean that the sources are not yet read. The two
cannot be told apart by the checker: the frontier says what the base holds,
not what the Church has said.

## SEE ALSO

[ttc-linguae(7)](linguae-preregistration.md), [ttc-repairs4(7)](repairs4-preregistration.md)

## SCORING

Appended after the runs. Predictions committed in `aa6565c`, stamped in
`91c136b`. Encoded in `pair.l` (the support rule withdrawn; `practice_spoken/1`;
the unanswered frontier; one literal added to the theological frontier's
rule), `server.py` (`unanswered_frontier`, reported by `flywheel_status`),
the suite (RF1, RF2), `tests/test_suite.py` (RF3), the guide in both copies,
`docs/flywheel.md` and `docs/mcp.md`. All five held; the full suite: 894 passed, 16 skipped.

| | Result |
| --- | --- |
| RF1 | Held (RF1). |
| RF2 | Held (RF2). Added for RF5: a default beside a claim of practice puts the question on neither frontier. |
| RF3 | Held. PR4 green, its expectation unchanged. `unanswered_frontier()` lists `by_practice_only(q(valid_form(baptism,sg_g1)))`, and the theological frontier names nothing of `sg_g1` (`test_unanswered_frontier_lists_what_no_source_answers`). |
| RF4 | Held. Every scenario's atoms compared, main against the branch (666). The 13 runs that load `linguae_signed` (SG0–SG10, SGR, SG5a) gain exactly the atom of RF1, in every model; nothing else differs. |
| RF5 | Held. Each removed in turn turns RF1, RF2 or PR4 red: the unanswered rule; each of its three body literals (`not has_support`, `not default`, `practice_spoken`); the theological rule's new literal; the `practice_spoken` rule; and the withdrawn support rule, restored. CL1 and PR4 clean. |
