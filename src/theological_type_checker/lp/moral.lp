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
%  @library  (read by norms.py: its predicates count as defined)
% ===================================================================

% @input kind_of_act/2 | kind_of_act(Act, Kind): the kind of act a case says its act is (an outward fact)
% @input of_kind/2 | from the theological side (pair.lp): in this branch the kind is classified so
% @input interior/3 | act.lp: a claim about the agent's knowledge, will or end; supplied, never derived
% @input act_of/2 | who placed the act
% @input actus_humanus/2 | act.lp: an act from knowledge and deliberate will
% @input due_defence/2 | act.lp: the claim of legitimate defence with due moderation
% @input forbids/2 | forbids(Law, Kind): a law forbids acts of this kind
% @input does_not_bind/1 | law.lp: a law contrary to a higher law does not bind
% @input effect/3 | effect(Act, Effect, good | evil): an effect of the act (outward)
% @input means/3 | means(Act, E1, E2): the effect E1 is the means to E2 (outward)

% ---------- The sources of morality (I-II q. 18 aa. 2-4; CCC 1750-1756) -----
% The object's kind is teaching; it is said of kinds, never of a person.
evil_by_object(K)  :- of_kind(K,evil_by_object).        % VS 79-80
grave_by_matter(K) :- of_kind(K,grave_matter).          % CCC 1858
% Sin: "a word, deed or desire contrary to the eternal law" (Augustine, C.
% Faustum 22.27; I-II q. 71 a. 6): an act of a kind contrary to a law that
% binds. A law contrary to a higher law does not bind (law.lp; q. 96 a. 4).
sinful_kind(K) :- evil_by_object(K).
sinful_kind(K) :- forbids(L,K), not does_not_bind(L).

% ---------- Mortal sin, on the claims (q. 72 a. 5; RP 17; CCC 1857-1859) -----
% Grave matter, full knowledge, deliberate consent. The first is teaching
% about the kind; the other two are claims about the agent. The library
% composes "mortal, if the claims are true"; it never says a person sinned.
full_knowledge(P,A)     :- interior(P,A,full_knowledge).
deliberate_consent(P,A) :- interior(P,A,deliberate_consent).
mortal_on_the_claims(P,A) :- actus_humanus(P,A), kind_of_act(A,K), sinful_kind(K), grave_by_matter(K),
                             full_knowledge(P,A), deliberate_consent(P,A).
% Sin of either gravity, on the claims: an act of a sinful kind with consent
% claimed (CCC 1862 for venial sin). TTC-CHRIST CH2 reads it.
sin_on_the_claims(P,A) :- actus_humanus(P,A), kind_of_act(A,K), sinful_kind(K), deliberate_consent(P,A).

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
double_effect(P,A) :- act_of(P,A), effect(A,_,good), effect(A,_,evil), kind_of_act(A,K),
                      not evil_by_object(K), not evil_as_means(A),
                      evil_unintended(P,A), proportionate(P,A).
licit_on_the_claims(P,A) :- double_effect(P,A).
% An act evil by its object is not made licit by its end or circumstances
% (Rom 3:8; VS 79-81; CCC 1753, 1756).
violation(evil_object_made_licit(P,A)) :- licit_on_the_claims(P,A), kind_of_act(A,K), evil_by_object(K).

info(mortal_on_the_claims(P,A)) :- mortal_on_the_claims(P,A).
info(double_effect(P,A))        :- double_effect(P,A).
info(licit_on_the_claims(P,A))  :- licit_on_the_claims(P,A).
