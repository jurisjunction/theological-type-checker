# TTC-WITNESS(7)

## NAME

**ttc-witness** — a witness apart from the claim: LG 25's conditions shown
by a named witness who is not the claimant, communion never judged by the
teaching in question, and the first to state a claim named; predictions,
committed before encoding

## DESCRIPTION

Read as the rules stand at `ceb89cd` (`main`). Its rules are those of
`4183446`, on which the runs below were made; it adds TTC-MANNER's
predictions, not yet encoded.

- **The witness is not recorded.** Rule 14 asks that LG 25's conditions be
  shown "by evidence independent of the claimant". `condition_shown/2`
  carries no witness. The base records that a condition is shown, never by
  whom, so it cannot check that the showing is apart from the claim.
- **The claim may show itself.** `conclusion_gate` lets the body of a rule
  with a premise for its head read anything ("a source on the branch of a
  claim"). A snippet may write
  `condition_shown(S,dispersed_in_communion) :- oum_holds(S).`
  Run on the base, with `commentary_communion`, a hypothetical declaration
  of 2026 claiming X at grade 1 with itself as claimant, three conditions
  shown, and a bishop who taught otherwise in 2020: in the claim's branch
  `unshown_claim` is gone, no violation fires, and the bishop is reported
  `info(against_tier1(bishop_b,q(x_taught)))`. The control, without the
  rule, keeps `unshown_claim`. The `check` and `say` outputs are the same
  both ways: `unshown_claim` is not surfaced.
- **The claimant may show his own claim.** The same with
  `condition_shown(S,dispersed_in_communion) :- oum_claim(S,_), oum_claimant(S,S).`
  ("I say X is OUM"): the same silence.
- **The true Scotsman has no slot.** The argument runs: (1) I say X is OUM;
  (2) whoever denies a definitive truth "would no longer be in full
  communion" (the commentary of 1998, n. 6); (3) so the bishops who taught
  otherwise were not in communion; (4) so the bishops in communion agree,
  and LG 25's condition of communion is met; (5) therefore X is OUM.
  Between (1) and (3) the claim is read as the fact (n. 6 speaks of a
  truth already definitive), and (4) then shows the condition from it. A
  count of the bishops in communion by their answer on the very question
  has no type: it is neither refused nor shown. A silent bug.
- **The root of a claim is not typed.** The case `ordination_reserved`
  enters `os1994`, `cdf_1995` and `cdf_1998` alike as claimants of the
  ordinary universal magisterium. The letter of 1994 never states that
  claim: it declares the judgment "to be definitively held", and the words
  "ordinary and universal Magisterium" and "infallibly" do not occur in
  it. They enter with the reply of 1995, which the pope "approved" at an
  audience and "ordered ... to be published". The base puts the claim in
  the letter's mouth by its own rule (`declaration_without_claim`, on the
  commentary's n. 9), so a report of the form "the pope says X is OUM" and
  the pope's own words cannot be told apart. Followed down, each report
  rests on another's authority, and the first to state the claim in words
  is never shown.

## THE TEXTS

| Text | What it says |
| --- | --- |
| LG 25 (1964) | The bishops "proclaim Christ's doctrine infallibly whenever, even though dispersed through the world, but still maintaining the bond of communion among themselves and with the successor of Peter, and authentically teaching matters of faith and morals, they are in agreement on one position as definitively to be held." |
| c. 749 §3 | "No doctrine is understood as defined infallibly unless this is manifestly evident." |
| c. 750 §1 | The ordinary and universal magisterium "is manifested by the common adherence of the Christian faithful under the leadership of the sacred magisterium." |
| CDF, *Doctrinal Commentary on the Concluding Formula of the Professio fidei* (1998), n. 6 | "Whoever denies these truths would be in a position of rejecting a truth of Catholic doctrine and would therefore no longer be in full communion with the Catholic Church." |
| John Paul II, *Ordinatio sacerdotalis* 4 (1994) | "I declare that the Church has no authority whatsoever to confer priestly ordination on women and that this judgment is to be definitively held by all the Church's faithful." The letter does not use the words "ordinary and universal" or "infallibly". |
| CDF, reply to the *dubium* on *Ordinatio sacerdotalis* (28 October 1995) | The teaching "has been set forth infallibly by the ordinary and universal Magisterium"; the Roman Pontiff "has handed on this same teaching by a formal declaration". The pope "approved this Reply" at an audience granted to the prefect, and ordered it published. |
| c. 131 §2; c. 360 | Vicarious power is exercised in the name of another; the Roman Curia performs its function in the pope's name and by his authority. |
| DV 10 | The teaching office "is not above the word of God, but serves it, teaching only what has been handed on." |
| Deut 19:15 (KJV) | "at the mouth of two witnesses, or at the mouth of three witnesses, shall the matter be established." |
| John 5:31 (KJV) | "If I bear witness of myself, my witness is not true." |
| John 7:18 (KJV) | "He that speaketh of himself seeketh his own glory: but he that seeketh his glory that sent him, the same is true, and no unrighteousness is in him." |

The texts are checked against vatican.va when the rules are written, and
quoted in their comments.

## PREDICTIONS

### WN: the witness named

- **WN1.** A new slot, `shown_by(S,C,W)`: the condition C of LG 25 shown
  for the claim on S by the witness W. A condition counts for LG 25 only
  through a witness apart from the claim (`shown_apart(S,C)`), and
  `oum_unmet/1` reads it.
- **WN2.** A witness that is the claim, the consensus it claims, or one of
  its claimants (W = S; W = `oum(S)`; `oum_claimant(S,W)`;
  `claims_tier(W,S,_)`) is refused in every branch,
  `violation(witness_is_claimant(S,C,W))`, and the condition stays unmet.
  This is "I say X is OUM".
- **WN3.** `condition_shown(S,C)` of an LG 25 condition, for a source with
  an `oum_claim` and no witness, no longer meets the condition:
  `info(condition_without_witness(S,C))`, and the claim stays unshown.
  The conditions of *Pastor aeternus* keep `condition_shown/2` unchanged: a
  definition's form is shown by its own text.
- **WN4.** The two places in the base that show LG 25's conditions carry
  their witnesses: the switch `oum_conditions_shown` (TC3), by a
  hypothetical witness; the liturgy rule (LW8), by the liturgical witness
  it already names. TC3 and LW8 do not change.

### WC: communion judged by the teaching

- **WC1.** A new slot, `communion_judged_by(W,Q)`: the witness W counts the
  bishops in communion by their answer on the question Q.
- **WC2.** `shown_by(S,dispersed_in_communion,W)` with
  `communion_judged_by(W,Q)`, where S supports Q, is refused in every
  branch, `violation(communion_from_the_teaching(S,W))`; the condition
  stays unmet, and the claim's branch is never preferred. Communion judged
  by another question is not refused.
- **WC3.** A bishop who taught otherwise is reported against tier 1 only in
  the claim's branch, as now; the preferred branch rests on no claim.

### WG: the gate

- **WG1.** A snippet rule whose head is a witness slot (`shown_by/3`,
  `condition_shown/2`, `communion_judged_by/2`) and whose body reads a
  conclusion of the base, directly or through a helper of the snippet's,
  is refused at the gate `conclusion`, naming the predicate and rule 14.
  Other premise heads keep the old latitude.
- **WG2.** The rule of the DESCRIPTION,
  `condition_shown(S,dispersed_in_communion) :- oum_holds(S).`, is refused
  at the gate, naming `oum_holds/1`.

### WR: the root of a claim

- **WR1.** A new slot, `claim_stated(S,C)`: the claimant C states the claim
  on S in its own words. A claimant entered without it is reported
  `info(claim_unstated(S,C))`: the claim is read into C's form by another.
  In `ordination_reserved`, `cdf_1995` and `cdf_1998` state it; `os1994`
  does not. `declaration_without_claim` stays: the form still carries the
  claim, now typed as unstated.
- **WR2.** The first to state a claim is reported,
  `info(first_stated(S,C,Y))`: the claimant with `claim_stated(S,C)` of the
  earliest year. For `os1994`: `cdf_1995`, 1995. Where no claimant states
  it, `info(never_stated(S))`.
- **WR3.** A new slot, `in_name_of(A,P)`: the act A issued in P's name, by
  vicarious power or approved by P in common form (c. 131 §2; c. 360). A's
  claims stay A's: P is not made to state them, A is no witness, no
  condition is shown, and no tier changes. A report in A of the form "P
  teaches S as OUM", where P does not state it, is reported
  `info(claim_attributed(A,P,S))`: the claim is A's, said in P's name.
- **WR4.** With `in_forma_specifica(A)`, the canon layer's rank of A rises
  as now (rank 4); on the authority graph A is a non-defining act, tier 3,
  and still a claimant. Approval in either form shows no condition.

### WD: candidates

- **WD1.** `cand_scotsman` (HYPOTHETICAL): the five steps with the new
  slots. A declaration of 2026 claims X at grade 1, itself its claimant;
  the commentary of 1998 is loaded (`commentary_communion`); three
  conditions are shown by a witness apart; communion is shown by a witness
  that counts the bishops by their answer on X. `communion_from_the_teaching`
  in every branch; `unshown_claim` in the claim's branch; that branch
  never preferred.
- **WD2.** `cand_i_say` (HYPOTHETICAL): the declaration shows all four
  conditions by its own word. Four `witness_is_claimant` in every branch;
  the claim unshown.
- **WD3.** `witness_apart_hyp` (HYPOTHETICAL, the control): all four
  conditions shown by a witness that is not a claimant, with communion
  judged by another question. No violation; the claim is shown; its
  branch may be preferred by weight.

### M: meta

- **M1.** No expectation of the suite changes. WN4's migrations keep TC3
  and LW8 as they are. The outputs of `ordination_reserved` gain WR1's and
  WR2's notes; no check reads them. The slots are disjoint from
  TTC-MANNER's: its encoding, merged before or after this one, changes no
  prediction here.
- **M2.** Each rule has a test that fails without it (rule 5).
- **M3.** The guide's table "Tiers, faith, communion" gets the four slots,
  and its row for `oum_claim` names `shown_by/3` instead of
  `condition_shown/2`. `guide.md` and `docs/encoding-guide.md` stay
  identical (rule 9).
- **M4.** Left unencoded, and named in BUGS: the same move made of the
  other claims about witnesses (the Fathers' unanimous consent, a creed's
  reception, an attribution); c. 750 §1's common adherence of the faithful
  as a kind of witness; the base's own rules, which the gate does not
  read; Gen 2:16-3:6 as a text of tier 0 with its readings (the command
  given to the man before the woman was formed, 2:16-22; her report of
  it, 3:3; the man "with her", 3:6), with Deut 4:2, John 5:31-32, John
  7:16-18 and John 12:49.

## METHOD

Predictions committed and stamped first (rule 12). The slots and rules go
in `l/icon_authority.l` beside rule 14's block, `in_name_of/2` beside
`in_forma_specifica/1`; WR1's facts in `ordination_reserved`; the liturgy rule in
`l/liturgy.l`; the switch and the candidates in `l/icon_history.l` beside
`oum_conditions_shown`; the gate in `engine.py` (`conclusion_gate`); then
`ttc-l build`, the tests, the guide, and SCORING appended here.

## SCORING

Scored on the rules as committed after the predictions (`e03cac8`,
stamped `05246c9`).

| Prediction | Result | Evidence |
| --- | --- | --- |
| WN1 | held, renamed | WN1: the four conditions shown apart (`shown_apart/2`), and the claim with them; with no witness, unshown. The slot is `witnessed_by/3`: `shown_by/3` is the authorship slot (`sources.l`), and the compiler refused a second declaration |
| WN2 | held | WN2, WD2: the claim, `oum(S)`, a claimant, one who grades it (`claims_tier/3`), one who states it (`claim_stated/2`), an act in a claimant's name; each refused for the four conditions, the claim unshown |
| WN3 | held | WN3: `condition_without_witness` for each condition; unshown |
| WN4 | held | TC3 and LO8 unchanged (LO8 is the suite's name for the liturgy step's LW8) |
| WC1 | held | the slot, read by `judged_by_teaching/2` |
| WC2 | held | WC2: refused on the very question, not on another; the condition unmet |
| WC3 | held | WD1: `against_tier1(bishop_scot,…)` only on the claim's branch |
| WG1 | held | `test_a_witness_drawn_from_a_conclusion_is_refused`: directly and through a helper; `source(…) :- attributed(…)` still passes |
| WG2 | held | the same test, first case: `oum_holds/1` named, with rule 14 |
| WR1 | held | WR1 |
| WR2 | held | WR2: `first_stated(os1994,cdf_1995,1995)`; `never_stated` where no one states it |
| WR3 | held | WR3: `claim_attributed(cdf_1995,john_paul_ii,os1994)`; the tiers of `cdf_1995` and `os1994` stay 3 |
| WR4 | held | WR4: `lrank(decl_w2,4)`, `eff_tier(decl_w2,3)`, the claim unshown |
| WD1 | held | WD1: refused in every branch; the claim's branch unshown and never preferred |
| WD2 | held | WD2 |
| WD3 | held | WD3: no refusal; the claim shown |
| M1 | held, with more notes | No check's expectation changed. One check went red on the way, PR4, on the control's own fixture: the other question it judges communion by had no source; the survey now answers it (rule 7: the fixture was wrong, not the expectation). Outputs gained notes beyond `ordination_reserved`: `claim_unstated` and `never_stated` wherever a claim is entered unstated (`dh795`, `fc84`, `ac1896`, `ev57`, `ev62`, `claim_1849`), and WR3's note in `ordination_reserved`; no check reads them |
| M2 | held after closing a gap | Each new rule removed in turn turns a test red. `own_witness(S,S)` was idle where the claim is its own claimant (`cand_i_say`); WN2 now enters a claim claimed by another and witnessing itself. Where the compiler refuses the removal (a result no rule computes, a slot no rule reads), the rule was disabled by an impossible literal instead, and its test went red. The gate: with `WITNESS_SLOTS` emptied, its three refusals go red |
| M3 | held | three rows in "Tiers, faith, communion", and `oum_claim`'s row names `witnessed_by/3`; `docs/encoding-guide.md` identical |
| M4 | held | named in BUGS |

### Not predicted

- **The slot's name.** `witnessed_by/3`, not `shown_by/3` (WN1).
- **`condition_shown/2` stays the one word for "shown".** It is derived
  from `shown_apart/2` for LG 25's conditions, so readers of it (LO8, the
  sentence "the condition C is shown") see the same atoms; entered alone
  for an OUM claim it shows nothing (WN3).
- **One who states the claim is a claimant for WN2** (`claim_stated/2`),
  as WR3's "A is no witness" needed.
- **WR3's fact entered in the case.** The reply of 1995 is `in_name_of`
  the pope in `ordination_reserved`, so FO4's outputs carry
  `claim_attributed` too.
- **The control is a case**, marked HYPOTHETICAL: it states its own
  questions (SO2).
- **`read_as/2` stays readable** by a witness's rule, as by a constraint's.
- **Coverage.** CCC 871–945 now names WN1, WN2 and WD1.
- **Found on the way, outside this step.** `outranked/2` names two things:
  a source outranked on a question (`icon_authority.l`) and a celebration
  outranked on a day (`canon_law.l`). Wherever a source is outranked, the
  calendar's rule notes `info(omitted(S,Q))`, said as "Q is omitted on S
  (GNLY 60)". It is so at `4183446` (a tier-3 letter against a claimed
  consensus, on the claim's branch). A silent bug for a repair of its own.

## BUGS

Named in M4 and left for a later step. The gate reads snippets only; a rule
of the base that drew a witness from a claim would pass it. A semantic
check would solve the witness layer once with no claim assumed (as the
part `no_oum` does) and count only what is shown there. Each claim about
witnesses (the consensus of the bishops, the consent of the Fathers, the
reception of a creed, the author of a text) admits the same move: whoever
dissents is counted out of the witnesses, and the remainder agree. Only the
first is typed here.

## CAVEATS

The checker shows that a witness is named and apart from the claim. It
does not show that the witness is real or that it says what it is entered
as saying; the library can be asked to fetch it.

What is refused is an argument, not a teaching. With the five steps
refused, X is still held at its claimant's tier, and its claim is still
computed both ways. Nothing is computed of the claimant's interior (rule 3),
and n. 6 itself is not refused: it speaks of a truth already definitive.
The fault is using it to show the condition that would make the truth
definitive.

A definition shows its own form: the words "we define" are the act. The
ordinary universal magisterium has no act of its own, so its conditions
are a fact about many witnesses, and the one who reports them is not one
of them by reporting.

A pope's not defining is typed as nothing: neither a fault nor a sign.
What WR types is a report in his name that his own words do not contain.
Vicarious power is the ordinary way the Holy See works (c. 360); it is
not refused. It is the place where a claim's speaker and its principal can
come apart, and so the place where the speaker must be named.

That a party is no witness in his own cause is canon law's rule too (c.
1550 §2, 1°). Law never answers a doctrinal question (rule 1): the canon
is kin to WN2, not its norm.

## SEE ALSO

[ttc-manner(7)](manner-preregistration.md) (the other direction: a text's
own word lowers how it uses its tier and never raises it; raising needs its
conditions shown, here by a witness),
[ttc-communion(7)](communion-preregistration.md) (TC2, TC3: the consensus as
its own source; c. 749 §3),
[ttc-liturgy(7)](liturgy-preregistration.md) (LW8: a liturgical witness),
[ttc-l(7)](l-preregistration.md) (CG: premises, not conclusions)
