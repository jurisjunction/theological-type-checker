layer libraries

```clingo
% ===================================================================
%  Christ: a standard library (TTC-CHRIST(7)).
%  Predictions were committed and stamped first, with an amendment:
%  docs/research/christ-preregistration.md.
%
%  What the Church defines of Christ is in the kernel (TTC-CREED): one
%  person in two natures, two wills and operations, without sin; and the
%  deposit's modes of his presence. This library writes what the canons and
%  the moral libraries call on: his acts, and presence on Thomas's account.
%  Why the Word became flesh, and Christ's esse, are the schools'
%  (icon_history.lp, part incarnation_schools).
%
```

library

```clingo
% ===================================================================

```

use act_of/2 "who placed the act"

use in_nature/2 "in_nature(Act, Nature): the nature by which the person places the act"

slot instrument_of(HumanAct: act, DivineAct: act)
  means "instrument_of(HumanAct, DivineAct): the human act as the divinity's instrument"
  say "the human act {HumanAct} is the instrument of {DivineAct}"

use incarnate/1 "the kernel"

use actus_humanus/2 "act.lp"

use without_sin/1 "the kernel: \"like us in all things but sin\" (DH 301)"

use of_kind/2 "from the theological side (pair.lp): in this branch the thing is classified so"

use sin_on_the_claims/2 "moral.lp: sin composed on the claims"

use present/3 "present(X, Place, Mode): a presence, typed by mode (the kernel)"

```clingo

% ---------- Acts belong to the person, by a nature (III q. 19 a. 1) -----
% act.lp makes the incarnate the agent of a human act by the nature assumed
% (CH1). An act said in a nature the person lacks is ill typed, as a birth
% or a passion is (T5).
said_in(P,K) :- act_of(P,A), in_nature(A,K).
info(human_act_of_a_divine_person(P,A)) :- actus_humanus(P,A), incarnate(P).
% The human operation is the instrument of the divinity and is not one
% operation with it: the "theandric" operation (Dionysius, Ep. 4) as the
% councils read it (III q. 19 a. 1 ad 1). One act typed in both natures
% confuses the operations (Constantinople III, DH 557: "without confusion").
violation(operations_confused(P,A)) :- act_of(P,A), in_nature(A,div), in_nature(A,hum).
info(instrument_of_the_divinity(A,D)) :- instrument_of(A,D), act_of(P,A), act_of(P,D),
                                         in_nature(A,hum), in_nature(D,div).

% ---------- Without sin (DH 301) ----------------------------------------
% The deposit states his interior. A case whose claims compose a sin of his
% is refused, and nothing is computed (CH2). The theological side may say
% the same of another person (of_kind(P, without_actual_sin)).
without_sin(P) :- of_kind(P,without_actual_sin).
violation(sin_claimed_of_the_sinless(P,A)) :- without_sin(P), sin_on_the_claims(P,A).

% ---------- Presence, on Thomas's account (I q. 52 a. 2; q. 8 a. 3) -------
% A body is in a place circumscriptively, "measured by the place"; an angel
% definitively, "in such a manner that he is not in another"; God neither
% way, "because He is everywhere". Christ's body is "in no way locally" in
% the sacrament (III q. 76 a. 5): no rule maps the sacramental mode to a
% place's measure. An account, not a definition. Whether one body can be
% circumscriptively in two places is a runtime's (schools.lp).
presence_mode(circumscriptive). presence_mode(definitive).
bodily(circumscriptive).
```
