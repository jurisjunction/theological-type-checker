layer libraries

-- Sorts first used in this layer (TTC-L, TY): closed, then open

sort cause {material, formal, efficient, final}
  means "one of the four causes (Physics II.3; Metaphysics V.2)"

sort domain {nature, god_physics, god_ethics, human, will, self, reason}
  means "where a cause is held: nature; God's ends in nature, or for human use and action; human nature; the will; the self; practical reason"

sort measure
  means "a measure, by its name: a ruler that takes one cause as another"

```clingo
% ===================================================================
%  The four causes (TTC-MODERNITY): "omne agens agit propter finem"
%  (ST I-II q. 1 a. 2).
%
%  An argument is typed by the causes it rests on, each in a domain, and
%  every typing is an interpretive fact, entered and open to dispute. A
%  horizon is the set of causes a runtime holds (holds_cause/2, set by the
%  parts of schools.lp and never by a case). Efficient and material causes
%  are held in every domain by the library itself: no horizon traces them.
%
%  Authority is by form and reads no argument (rule 14): a trace leaves the
%  authority graph untouched and changes only which reasons are available.
%  A reading is available where every cause it argues from is held; an
%  argument where any of its readings is. Reported: a value supported in
%  force with arguments entered, none available (without_reason/2); of a
%  source's two or more arguments for a value, one alone available
%  (sole_reason/4); a value without reason against an available contrary
%  (contrary_reasoned/3).
%
%  The VM: a guest horizon runs inside the host in the same solve
%  (guest_holds/2, set by a part vm_R), and availability is computed twice.
%  An argument idle in the host and sole in the guest is reported
%  (guest_sole_reason/4): that it is an accommodation to a hearer is an
%  interpretation, never computed.
%
%  Hearing (TTC-LINGUAE): the run's own horizon (here), or the VM's guest
%  where one is loaded (guest), hears in a tongue. For it an argument on
%  forms is heard as its hearing carries the premises, with every premise
%  that rests on no form as typed; the heard typing replaces the host's.
%  An argument that loses a premise is short there, and reaches the hearer
%  only where a claim says it still concludes (concludes_heard/3). What the
%  hearer cannot hold is computed from his horizon, apart from what the
%  encoding loses.
%
%  A measure that takes a final cause as an efficient one is refused, save
%  in a horizon where final causality survives only as desire: "finis
%  autem non habet locum nisi in iis rebus quae sensum et voluntatem
%  habent" (Hobbes, De corpore X.7).
%
```

library

```clingo
% ===================================================================

```

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot argument(A: claim, S: source, Q: question, V: value)
  means "argument(A, S, Q, V): an argument A, in the source S, for the value V on Q"
  say "{A} is an argument of {S} for {V} on {Q}"

slot argues_from(R: claim, C: cause, D: domain)
  means "argues_from(R, C, D): the reading R rests on the cause C in the domain D; an argument is its own first reading"
  say "{R} rests on the {C} cause in {D}"

slot reading_of(R: claim, A: claim)
  means "reading_of(R, A): R is a further reading of the argument A"
  say "{R} is a further reading of {A}"

slot measures_as(M: measure, C1: cause, C2: cause)
  means "measures_as(M, C1, C2): the measure M takes a cause C1 as a cause C2"
  say "{M} measures the {C1} cause as an {C2} one"

slot concludes_heard(A: claim, L: claimant, C: claimant)
  means "concludes_heard(A, L, C): C claims that A, heard under the lexicon L and shorter there, still concludes"
  say "{C} claims that {A}, heard under {L}, still concludes"

slot cause_domain(D: domain)
  means "cause_domain(D): the library's, a domain in which it holds the efficient and the material cause"
  say "the efficient and the material cause are held in {D}"

slot vm_guest(R: horizon)
  means "vm_guest(R): the part vm_R loads R's horizon as the VM's guest"
  say "the guest of the VM has the horizon of {R}"

result holds_cause(C: cause, D: domain)
  say "the horizon holds the {C} cause in {D}"

result guest_holds(C: cause, D: domain)
  say "the guest's horizon holds the {C} cause in {D}"

result available_as(A: claim, R: claim)
  say "{A} is available as its reading {R}"

result guest_available_as(A: claim, R: claim)
  say "{A} is available to the guest as its reading {R}"

result without_reason(Q: question, V: value)
  say "{V} on {Q} is supported in force, and none of its arguments is available"

result sole_reason(S: source, A: claim, Q: question, V: value)
  say "of the arguments of {S} for {V} on {Q}, {A} alone is available"

result contrary_reasoned(Q: question, V: value, V2: value)
  say "{V} on {Q} is without reason, while an argument for {V2} is available"

result guest_without_reason(Q: question, V: value)
  say "{V} on {Q} is supported in force, and the guest can follow none of its arguments"

result guest_sole_reason(S: source, A: claim, Q: question, V: value)
  say "{A}, idle in the host among the arguments of {S} for {V} on {Q}, is the one the guest can follow"

result cause_converted(M: measure, C1: cause, C2: cause)
  say "{M} takes the {C1} cause as an {C2} one: refused"

result conversion_native(M: measure)
  say "{M} takes an end as a force, in a horizon where ends survive only as desire"

result premise_not_argued(A: claim, P: premise)
  say "the premise {P} rests on a form, and {A} does not argue from it: refused"

result heard_short(G: horizon, A: claim)
  say "{A} loses a premise as {G} hears it"

result heard_by_analogy(G: horizon, A: claim, P: premise, K: akind)
  say "the premise {P} of {A} reaches {G} through a rendering by analogy of {K}"

use supported/2 "icon_authority.lp: a value some source in force supports"

use hears_form/2 "linguae.lp"

use heard_argument/2 "linguae.lp"

use carried_heard/3 "linguae.lp"

use lost_heard/3 "linguae.lp"

use hear_by/3 "linguae.lp"

```clingo

% ---------- Horizons: the causes held (CV) ----------------------------------
% A part of a runtime holds one cause in one domain (schools.lp). The
% efficient and the material cause are held in every domain, by the run's
% horizon and by a guest's alike.
cause_domain(nature;god_physics;god_ethics;human;will;self;reason).
holds_cause((efficient;material),D) :- cause_domain(D).
guest_holds((efficient;material),D) :- vm_guest(_), cause_domain(D).
% Two horizons in one solve: the run's own (here) and, where a part vm_R is
% loaded, the VM's guest. A hearing part declares its hearing for the guest
% where there is one, and otherwise for the run's own horizon.
horizon_run(here).
horizon_run(guest) :- vm_guest(_).
held(here,C,D)  :- holds_cause(C,D).
held(guest,C,D) :- guest_holds(C,D).
vm_on :- vm_guest(_).
hearer(guest) :- vm_on.
hearer(here)  :- not vm_on.

% ---------- The argument heard (HE) -----------------------------------------
% An argument on forms, heard: its premises on no form as typed; a premise on
% forms the hearer hears in their own tongue, kept; one carried by what he
% hears, kept where every form it rests on carries it (TTC-LINGUAE). The
% heard typing replaces the argument's own; a further reading rests on no
% form and is heard as typed.
listens(G) :- horizon_run(G), hears_in(G,_,_).
reheard(G,A) :- listens(G), rests_on_form(A,_,_).
on_form(A,P) :- rests_on_form(A,P,_).
form_unheard(G,A,P) :- reheard(G,A), rests_on_form(A,P,F), not hears_form(G,F).
kept_heard(G,A,cd(C,D)) :- reheard(G,A), argues_from(A,C,D), not on_form(A,cd(C,D)).
kept_heard(G,A,P) :- reheard(G,A), on_form(A,P), not form_unheard(G,A,P).
kept_heard(G,A,P) :- reheard(G,A), carried_heard(G,A,P), not lost_heard(G,A,P).
% A premise lost leaves a shorter argument, which reaches the hearer only
% where a claim says it still concludes under his lexicon; an argument on
% forms he does not hear at all does not reach him.
short(G,A) :- reheard(G,A), lost_heard(G,A,_).
info(heard_short(G,A)) :- short(G,A).
claimed(G,A) :- concludes_heard(A,L,_), hear_by(G,_,L).
unreached(G,A) :- short(G,A), not claimed(G,A).
unreached(G,A) :- reheard(G,A), not heard_argument(G,A).
% The bridge named: a premise kept through an analogical rendering, of its kind.
info(heard_by_analogy(G,A,P,K)) :- kept_heard(G,A,P), rests_on_form(A,_,F1), analogical_for(G,F2,F1),
                                   means_for(G,F2,W2), host_means(G,F1,W1), analogous(W2,W1,K,_),
                                   carries(W2,W1,P).
% What the hearer cannot hold, from his horizon (TTC-LINGUAE RN5, computed).
info(lost_by_horizon(G,A,cd(C,D))) :- horizon_run(G), heard_argument(G,A), argues_from(A,C,D),
                                      not held(G,C,D).
% A premise on a form that its argument, entered, does not argue from.
violation(premise_not_argued(A,cd(C,D))) :- rests_on_form(A,cd(C,D),_), argument(A,_,_,_),
                                            not argues_from(A,C,D).

% ---------- Availability (CV, VM) -------------------------------------------
reading_rec(A,A) :- argument(A,_,_,_).
reading_rec(A,R) :- reading_of(R,A).
needs(G,R,C,D) :- horizon_run(G), argues_from(R,C,D), not reheard(G,R).
needs(G,A,C,D) :- kept_heard(G,A,cd(C,D)).
unheld(G,R) :- needs(G,R,C,D), not held(G,C,D).
open_as(G,A,R) :- horizon_run(G), reading_rec(A,R), not unheld(G,R), not unreached(G,R).
avail(G,A) :- open_as(G,A,_).
available_as(A,R)       :- open_as(here,A,R).
guest_available_as(A,R) :- open_as(guest,A,R).

% ---------- The reports ------------------------------------------------------
several(S,Q,V)        :- argument(A,S,Q,V), argument(B,S,Q,V), A != B.
other_open(G,S,A,Q,V) :- argument(A,S,Q,V), argument(B,S,Q,V), B != A, avail(G,B).
sole_in(G,S,A,Q,V)    :- argument(A,S,Q,V), avail(G,A), several(S,Q,V), not other_open(G,S,A,Q,V).
reasoned(G,Q,V)       :- argument(A,_,Q,V), avail(G,A).
argued(Q,V)           :- argument(_,_,Q,V).
unreasoned(G,Q,V)     :- horizon_run(G), supported(Q,V), argued(Q,V), not reasoned(G,Q,V).
info(without_reason(Q,V))        :- unreasoned(here,Q,V).
info(sole_reason(S,A,Q,V))       :- sole_in(here,S,A,Q,V).
info(contrary_reasoned(Q,V,V2))  :- unreasoned(here,Q,V), reasoned(here,Q,V2).
% The guest: what it cannot see; what is idle in the host and sole in it.
info(guest_without_reason(Q,V))  :- unreasoned(guest,Q,V).
info(guest_sole_reason(S,A,Q,V)) :- sole_in(guest,S,A,Q,V), avail(here,A), other_open(here,S,A,Q,V).

% ---------- The conversion (CV5) ---------------------------------------------
% An end measured as a force: native only where final causality survives as
% desire alone (no end in nature, in God's intention or in human nature) and
% the will's act has no form of its own (neither its object nor the law's).
desire_only :- holds_cause(final,will), not holds_cause(final,nature), not holds_cause(final,god_physics),
               not holds_cause(final,god_ethics), not holds_cause(final,human), not holds_cause(formal,will),
               not holds_cause(formal,reason).
violation(cause_converted(M,final,efficient)) :- measures_as(M,final,efficient), not desire_only.
info(conversion_native(M)) :- measures_as(M,final,efficient), desire_only.
```
