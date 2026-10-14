layer libraries

```clingo
% ===================================================================
%  The morality of acts and sin: a standard library (TTC-MORAL(7)).
%  Predictions were committed and stamped first:
%  docs/research/moral-preregistration.md.
%
%  The checker judges kinds of act, and what follows from the claims a case
%  supplies; never a soul. "Although we can judge that an act is in itself
%  a grave offense, we must entrust judgment of persons to the justice and
%  mercy of God" (CCC 1861). Whether a kind is evil by its object, or grave
%  by its matter, is teaching, given by the theological side (of_kind/2,
%  through classification/3); what the agent knew, willed or intended is
%  act.lp's interior/3, supplied or computed both ways, never derived.
%
```

library

```clingo
% ===================================================================

```

use kind_of_act/2 "kind_of_act(Act, Kind): the kind of act a case says its act is (an outward fact)"

use of_kind/2 "from the theological side (pair.lp): in this branch the kind is classified so"

use interior/3 "act.lp: a claim about the agent's knowledge, will or end; supplied, never derived"

use act_of/2 "who placed the act"

use actus_humanus/2 "act.lp: an act from knowledge and deliberate will"

use due_defence/2 "act.lp: the claim of legitimate defence with due moderation"

slot forbids/2
  means "forbids(Law, Kind): a law forbids acts of this kind"

use does_not_bind/1 "law.lp: a law contrary to a higher law does not bind"

slot effect/3
  means "effect(Act, Effect, good | evil): an effect of the act (outward)"

slot means/3
  means "means(Act, E1, E2): the effect E1 is the means to E2 (outward)"

use holds/2 "from the authority graph: the value a branch holds (q(direct_by))"

slot object_is/2
  means "object_is(Act, E): the act consists in bringing about E (outward)"

slot evil_kind_of/2
  means "evil_kind_of(E, K): an evil effect of this kind (e.g. killing_of_innocent)"

slot prudential/2
  means "prudential(Act, Condition): the judgment of those responsible that a condition is met (CCC 2309); supplied, never computed"

slot permitted_only_if/2
  means "permitted_only_if(Kind, Condition): acts of the kind are permitted only where the condition is met"

use denied/1 "denied(Condition): the theological side holds that the condition is not met today"

slot commands/3
  means "commands(Law, Kind, Occasion): an affirmative precept commands acts of the kind on the occasion"

slot occasion/2
  means "occasion(Person, Occasion): the occasion holds for the person"

slot teaching_type/2
  means "teaching_type(Source, principle | criterion | directive) (CCC 2423)"

use supports/3 "from the authority graph"

use classification/3 "from the authority graph"

use unbound/2 "canon_law.lp (c. 11): an ecclesiastical law does not bind the person"

use unbound_at/3 "canon_law.lp (c. 11): an ecclesiastical law does not bind the person in the act (under seven)"

```clingo

% ---------- The sources of morality (I-II q. 18 aa. 2-4; CCC 1750-1756) -----
% The object's kind is teaching; it is said of kinds, never of a person.
evil_by_object(K)  :- of_kind(K,evil_by_object).        % VS 79-80
grave_by_matter(K) :- of_kind(K,grave_matter).          % CCC 1858
% Sin: "a word, deed or desire contrary to the eternal law" (Augustine, C.
% Faustum 22.27; I-II q. 71 a. 6): an act of a kind contrary to a law that
% binds. A law contrary to a higher law does not bind (law.lp; q. 96 a. 4).
sinful_kind(K) :- evil_by_object(K).
sinful_kind(K) :- forbids(L,K), not does_not_bind(L).
% For this person in this act: a merely ecclesiastical law binds only its
% subjects (c. 11, TTC-COMMUNION CN1); divine and natural law bind all.
binds_for(P,A,K) :- act_of(P,A), kind_of_act(A,K), evil_by_object(K).
binds_for(P,A,K) :- act_of(P,A), kind_of_act(A,K), forbids(L,K), not does_not_bind(L),
                    not unbound(P,L), not unbound_at(P,L,A).

% ---------- Mortal sin, on the claims (q. 72 a. 5; RP 17; CCC 1857-1859) -----
% Grave matter, full knowledge, deliberate consent. The first is teaching
% about the kind; the other two are claims about the agent. The library
% composes "mortal, if the claims are true"; it never says a person sinned.
full_knowledge(P,A)     :- interior(P,A,full_knowledge).
deliberate_consent(P,A) :- interior(P,A,deliberate_consent).
mortal_on_the_claims(P,A) :- actus_humanus(P,A), kind_of_act(A,K), binds_for(P,A,K), grave_by_matter(K),
                             full_knowledge(P,A), deliberate_consent(P,A).
% Sin of either gravity, on the claims: an act of a sinful kind with consent
% claimed (CCC 1862 for venial sin). TTC-CHRIST CH2 reads it.
sin_on_the_claims(P,A) :- actus_humanus(P,A), kind_of_act(A,K), binds_for(P,A,K), deliberate_consent(P,A).

% ---------- Double effect (II-II q. 64 a. 7; CCC 2263-2265) ------------------
% Two conditions are outward and computed: the object is not evil, and the
% evil effect is not the means to the good. Two are claims: the evil is not
% intended, and the reason is proportionate. Proportion is weighed by the
% agent, never by the checker. Legitimate defence is double effect's own case
% (CCC 2263): the claim of due defence (act.lp), which c. 1323 n. 5 also reads.
evil_as_means(A)       :- means(A,E,_), effect(A,E,evil).
evil_unintended(P,A)   :- interior(P,A,evil_unintended).
evil_unintended(P,A)   :- due_defence(P,A).
proportionate(P,A)     :- interior(P,A,proportionate_reason).
proportionate(P,A)     :- due_defence(P,A).
act_evil_by_object(A)  :- kind_of_act(A,K), evil_by_object(K).
double_effect(P,A) :- act_of(P,A), effect(A,_,good), effect(A,_,evil), kind_of_act(A,_),
                      not act_evil_by_object(A), not means_fails(A),
                      evil_unintended(P,A), proportionate(P,A).

% ---------- Direct and indirect: a reading (TTC-PRECEPT DI) ------------------
% Whether an evil effect that is the means makes the act direct is read by the
% order of causes (the manualists) or by what is chosen (Anscombe; Finnis,
% Grisez and Boyle): the question q(direct_by) on the authority graph. What is
% chosen is a claim. An act that consists in the evil is direct on either
% reading. The direct act takes the kind of its evil (killing an innocent):
% composed, never typed by hand. Without the question, the means condition
% keeps TTC-MORAL's outward reading.
reading_by_choice :- holds(q(direct_by),what_is_chosen).
direct(A,E) :- holds(q(direct_by),causal_order), means(A,E,_), effect(A,E,evil).
direct(A,E) :- holds(q(direct_by),what_is_chosen), act_of(P,A), interior(P,A,chooses(E)).
direct(A,E) :- object_is(A,E), effect(A,E,evil).
kind_of_act(A,direct(K)) :- direct(A,E), evil_kind_of(E,K).
means_fails(A) :- evil_as_means(A), not reading_by_choice.
means_fails(A) :- direct(A,_).
licit_on_the_claims(P,A) :- double_effect(P,A).
% An act evil by its object is not made licit by its end or circumstances
% (Rom 3:8; VS 79-81; CCC 1753, 1756).
violation(evil_object_made_licit(P,A)) :- licit_on_the_claims(P,A), kind_of_act(A,K), evil_by_object(K).

% ---------- Verdicts on acts: may, must, must not (TTC-PRECEPT VD, OB, SD) -----
% Said of acts, never of persons (CCC 1861). An act of a kind evil by its
% object is forbidden on the kind alone (CCC 1756; VS 80): negative precepts
% oblige "always and in every circumstance" (VS 52). An act that passes double
% effect on the claims is permitted; one that fails only for want of a claim
% gets no verdict.
must_not(A,by_object(K)) :- kind_of_act(A,K), evil_by_object(K).
may(A,double_effect)     :- licit_on_the_claims(_,A).
% A kind permitted only where conditions are met (the death penalty, EV 56; the
% use of force, CCC 2309): each condition is a prudential judgment, supplied.
% Where the theological side denies a condition today, the act is forbidden
% by the circumstance, not by its kind.
condition_met(A,C) :- prudential(A,C), not denied(C).
condition_unmet(A) :- kind_of_act(A,K), permitted_only_if(K,C), not condition_met(A,C).
must_not(A,by_circumstance(C)) :- kind_of_act(A,K), permitted_only_if(K,C), denied(C), not act_evil_by_object(A).
may(A,on_the_judgment) :- kind_of_act(A,K), permitted_only_if(K,_), not condition_unmet(A), not act_evil_by_object(A).
% Affirmative precepts bind always, not at every moment (II-II q. 33 a. 2):
% "must" only where the occasion is supplied. No precept commands what is
% evil by its object.
must(P,K,L) :- commands(L,K,O), occasion(P,O), not does_not_bind(L).
violation(obliged_to_evil(L,K)) :- commands(L,K,_), evil_by_object(K).
% Social teaching "proposes principles for reflection; it provides criteria
% for judgment; it gives guidelines for action" (CCC 2423). A directive does
% not fix what is evil by its object.
violation(directive_as_principle(S,K)) :- teaching_type(S,directive), supports(S,Q,yes),
                                          classification(Q,K,evil_by_object).

info(verdict(A,must_not,G)) :- must_not(A,G).
info(verdict(A,may,G))      :- may(A,G).
info(obligation(P,K))       :- must(P,K,_).
info(mortal_on_the_claims(P,A)) :- mortal_on_the_claims(P,A).
info(double_effect(P,A))        :- double_effect(P,A).
info(licit_on_the_claims(P,A))  :- licit_on_the_claims(P,A).
```
