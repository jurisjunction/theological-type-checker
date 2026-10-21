# TTC-REPAIRS(7)

## NAME

**ttc-repairs** — three repairs to the narrowing rule found by real cases:
whose choice it is, a right whose exercise is regulated, and how far a
decision on recourse reaches; predictions, committed before encoding

## DESCRIPTION

Read as the rules stand (the base at `a1f18a6`, committed just before these
predictions):

- **Whose choice.** `contrary_by/3` (rs2004:21) asks whether a higher law
  leaves a choice open, never to whom. `option_of/3` records the holder and
  no rule reads it. A diocesan bishop limiting intinction, a choice the
  GIRM leaves to his own norms, is computed contrary: run on a diocese's
  norms of 17 December 2025, the intinction norm does not bind.
- **A right regulated.** No rule reads c. 223 §2. A bishop's provisional
  suspension of Communion on the tongue (a right of the faithful, RS 92),
  confirmed by the competent dicastery on recourse, is computed contrary in
  every branch.
- **The reach of a decision.** c. 16 §3 is encoded for an authentic
  interpretation in a particular matter (`interpretation_form/2`,
  `particular_matter/2`), not for a superior's decision on recourse
  (c. 1739). A decision has no slot.

## THE TEXTS

| Text | What it says |
| --- | --- |
| GIRM 283; 387 | The diocesan bishop may establish norms for Communion under both kinds for his diocese; it is his to issue norms on its distribution. |
| GIRM 285, 287 | Intinction is one of the modes of distributing Communion under both kinds. |
| Huels, *Liturgy and Law* (2006) 48 | GIRM 387's list adds to the bishop's power only Communion under both kinds. |
| c. 223 §2 | "In view of the common good, ecclesiastical authority can direct the exercise of rights which are proper to the Christian faithful." |
| RS 91; 92 | Communion is not denied for kneeling or standing; each of the faithful always has the right to receive on the tongue. |
| CDW, letter to the presidents of the conferences, 15 August 2020 | In times of difficulty (wars, pandemics) bishops and conferences can give provisional norms, which must be obeyed and expire when the situation returns to normal; the faithful's right to receive is not limited beyond the norms of hygiene. |
| c. 1739 | The superior who deals with the recourse may confirm the decree, declare it invalid, rescind or revoke it, or emend, replace or modify it. |
| c. 16 §3 | An interpretation in the form of a judicial sentence or of an administrative act in a particular matter does not have the force of law and binds only the persons for whom, and affects the matters for which, it was given. |

The texts are checked against vatican.va and the published letters when the
rules are written, and quoted in their comments. The cases that found the
repairs stay outside the base (house rule 13); the tests use neutral names.

## PREDICTIONS

### RH: whose choice

- **RH1.** A new slot, `holds_as/2`: the authority holds the choice as one
  of the holders `option_of/3` names (a diocesan bishop as `diocesan_bishop`).
  A law narrowing a choice the higher law leaves to its own legislator is
  not contrary: it binds, and `narrows_own_choice/2` says so.
- **RH2.** A narrowing of a choice left to someone else (the celebrant) is
  unchanged: LW11 and the dated narrowing give the same results.

### RR: a right regulated (c. 223 §2)

- **RR1.** Two new slots: `right_of_the_faithful/1` (the choice in a matter
  is a right of the faithful) and `regulates_exercise/2` (the law directs
  the exercise of that right in view of the common good). The second is a
  prudential judgment the checker never makes: entered, or disputed and
  computed both ways. Where it holds, the narrowing is not contrary and
  `regulates_right/2` says so; where it is disputed, the law binds in one
  branch and not in the other.
- **RR2.** Silence is kept. Without the claim, nothing changes: no rule
  infers a regulation from a narrowing.
- **RR3.** The claim rescues only a right of the faithful. A choice that is
  not one (the celebrant's) stays contrary with the claim entered.

### RD: the reach of a decision (cc. 1739, 16 §3)

- **RD1.** A new slot, `decision_on_recourse/3`. A decision of an authority
  higher than the law's legislator, confirming the law, settles a disputed
  regulation for that law: it binds in every branch.
- **RD2.** The decision reaches no other law. Another law narrowing the
  same matter keeps both branches, and `not_reached_by/2` says so.
- **RD3.** A decision by an authority not higher than the legislator
  settles nothing.

No other expectation of the suite changes, and CL1 stays clean.

## BUGS

The stamp lands when this commit reaches main, after the encoding on its
branch; until then the order rests on the commit dates.
