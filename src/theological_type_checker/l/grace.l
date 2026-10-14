layer libraries

```clingo
% ===================================================================
%  Grace: a standard library (TTC-MORAL(7)).
%  Predictions were committed and stamped first:
%  docs/research/moral-preregistration.md.
%
%  I-II qq. 109-114, with what the deposit fixes: Carthage (418); Orange II
%  (529); Trent, sess. VI (1547); Innocent X, Cum occasione (1653). How
%  efficacious grace is efficacious is de auxiliis, protected (Paul V,
%  1607): the library states the interface, and the runtimes their readings.
%  No one can know "with a certainty of faith" that he is in grace (Trent,
%  sess. VI, ch. 9, DH 1534): the state of grace is a claim, never derived.
%
```

library

```clingo
% ===================================================================

```

use act_of/2 "who placed the act"

use agent/2 "act.lp: the person acts (on a runtime where creatures act)"

use interior/3 "act.lp: a claim, supplied or computed both ways; here also of a state, interior(P,state,in_grace)"

use holds/2 "from the authority graph: the value a branch holds"

use read_as/2 "from the authority graph: the reading a branch takes of an ambiguous text"

use holds_reading/2 "a runtime's reading (schools.lp)"

slot salutary/2
  means "salutary(P, A): an act ordered to salvation (faith, hope, love, repentance)"

slot beginning_of_faith/2
  means "beginning_of_faith(P, A): the first assent of faith"

use justification/2 "justification(P, A): the act in which P, moved by grace, assents to justification"

slot moved_by/3
  means "moved_by(P, A, G): grace G moves P in the act A"

slot efficacious/1
  means "efficacious(G): grace that in fact achieves its effect"

slot grace_uncreated/0
  means "a runtime's reading: deifying grace an uncreated energy (Palamas)"

slot every_grace_efficacious/0
  means "a theory's claim: every interior grace is efficacious, none resisted (Jansen)"

slot formal_cause_essence/0
  means "a theory's claim: the justified are just by the justice by which God is just (Osiander)"

```clingo

% ---------- Necessity (q. 109; Carthage; Orange II, can. 5, DH 375) ----------
% No salutary act, not even the beginning of faith, without grace (Trent,
% sess. VI, cann. 1-3, DH 1551-1553). Only an act a person places is judged:
% where no creature acts, there is nothing to move.
salutary(P,A) :- beginning_of_faith(P,A).
salutary(P,A) :- justification(P,A).
salutary_act(P,A) :- salutary(P,A), agent(P,A).
violation(salutary_without_grace(P,A)) :- salutary_act(P,A), not moved_by(P,A,_).

% ---------- Cooperation (Trent, sess. VI, cann. 4-5, DH 1554-1555) -----------
% The will, moved and aroused by God, cooperates by assenting and can
% dissent if it wishes; it is not "like something inanimate" that does
% nothing and is merely passive. "Can dissent" is the power, which the will
% keeps under any motion of grace (the divided sense): the will acts.
violation(will_merely_passive(P,A)) :- justification(P,A), not agent(P,A).

% ---------- Efficacy: de auxiliis, protected (Paul V, 1607) ------------------
% Efficacious grace achieves its effect. Whether by physical premotion
% (Banez) or as foreseen by middle knowledge (Molina) is the runtimes':
% holds_premotion (Thomist), holds_concurrence (Suarezian).
premotion_held :- holds_reading(_,premotion).
moved_infallibly(P,A) :- moved_by(P,A,G), efficacious(G), premotion_held.

% ---------- Resisted grace (Innocent X, Cum occasione, prop. 2, DH 2002) -------
% "In the state of fallen nature no one ever resists interior grace" was
% condemned as heretical: some interior grace is resisted. The library
% keeps a kind of grace that can be, and is, resisted: sufficient grace.
resistible_kind(sufficient) :- not every_grace_efficacious.
violation(resisted_grace_unrepresented) :- holds(q(grace_always_efficacious),no), not resistible_kind(_).

% ---------- Inherence and the formal cause (sess. VI, ch. 7, can. 11) ---------
% Justifying grace inheres in the justified (DH 1561); its formal cause is
% "the justice of God, not that by which he himself is just, but that by
% which he makes us just" (DH 1529). Against Osiander on any reading; against
% every uncreated formal cause on one. That grace is a created quality is
% Thomas's account (q. 110 a. 2), not a definition.
violation(formal_cause_the_divine_essence(P,A)) :- justification(P,A), formal_cause_essence.
violation(formal_cause_uncreated(P,A)) :- justification(P,A), grace_uncreated,
                                          read_as(trent_vi_ch7,against_every_uncreated_cause).

% ---------- Not known (ch. 9, DH 1533-1534; cann. 13-16; I-II q. 112 a. 5) -----
% That a person is in grace is a claim (interior/3, of a state), supplied or
% computed both ways; a rule that derives it from outward facts claims the
% certainty Trent denies.
in_grace(P) :- interior(P,state,in_grace).
violation(grace_known_by_outward_signs(P)) :- in_grace(P), not interior(P,state,in_grace).
info(in_grace_on_the_claim(P)) :- in_grace(P), interior(P,state,in_grace).
```
