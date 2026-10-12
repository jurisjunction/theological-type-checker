% ===================================================================
%  The human act: a standard library for canon law (TTC-ACT(7)).
%  Predictions were committed and stamped first:
%  docs/research/act-preregistration.md.
%
%  Thomas treats the human act (ST I-II qq. 1, 6-21) before law (q. 90),
%  "a rule and measure of acts" (q. 90 a. 1). The canons that speak of
%  knowledge, will, fear, ignorance and reason call this library; none
%  keeps an interior slot of its own.
%
%  Rule 3: the interior is input. interior/3 is supplied by a case, or
%  computed both ways when disputed; no rule derives it from outward facts
%  (tests/test_suite.py checks this). What follows is juridical: what the
%  law makes of the claims supplied, branch by branch, never a finding
%  about a soul.
%
%  @library  (read by norms.py: its predicates count as defined)
% ===================================================================

% @input acts/1 | from the runtime (schools.lp, classical): creatures act
% @input operates/2 | from the runtime (schools.lp, classical): operates(X, hum), the incarnate's human operation
% @input in_nature/2 | in_nature(Act, Nature): the nature by which the person places the act (the kernel's T5 natures)
% @input divine/1 | from the kernel's sorts
% @input god/1 | from the kernel's sorts
% @input interior/3 | interior(Person, Act, Element): a claim about the agent's knowledge, will or freedom in the act; supplied, never derived
{ interior(P,A,X) } :- disputed(interior(P,A,X)).
assumed_fact(interior(P,A,X))        :- disputed(interior(P,A,X)), interior(P,A,X).
assumed_fact(false(interior(P,A,X))) :- disputed(interior(P,A,X)), not interior(P,A,X).

% ---------- Agents -----------------------------------------------------
% The person acts; the nature is that by which (ST III q. 19 a. 1). A
% creature acts by its own nature, if creatures act at all (agere sequitur
% esse: the classical runtime); the incarnate places a human act by the
% nature assumed, where the runtime grants it an operation (DH 557). A
% divine person is never made a creature by acting (TTC-CHRIST CH1).
creature(P)  :- act_of(P,_), not divine(P), not god(P).
agent(P,A)   :- act_of(P,A), acts(P).
agent(P,A)   :- act_of(P,A), in_nature(A,hum), operates(P,hum).

% ---------- Kinds of act (ST I-II q. 1 a. 1; q. 6 a. 5) ------------------
% An actus humanus proceeds from knowledge and deliberate will; force from
% without, and the lack of reason, leave only an actus hominis.
removes_voluntary(P,A,violence)    :- interior(P,A,violence).
removes_voluntary(P,A,no_reason)   :- interior(P,A,reason(lacking)).
removes_voluntary(P,A,no_reason)   :- interior(P,A,reason(habitually_lacking)).
actus_humanus(P,A) :- agent(P,A), not removes_voluntary(P,A,_).

% ---------- Ignorance (ST I-II q. 6 a. 8; q. 76 aa. 2-3) -----------------
% Of: law, penalty, or fact(C), a circumstance. Kind: invincible (without
% fault), vincible (with fault), crass, supine, affected. Error and
% inadvertence count as ignorance (c. 1323 n. 2).
ignorance(P,A,Of,K) :- interior(P,A,ignorance(Of,K)).
ignorance(P,A,Of,K) :- interior(P,A,error(Of,K)).
ignorance(P,A,Of,K) :- interior(P,A,inadvertence(Of,K)).
ignorant_without_fault(P,A,Of) :- ignorance(P,A,Of,invincible).
ignorant_with_fault(P,A,Of)    :- ignorance(P,A,Of,vincible).
gross(crass). gross(supine). gross(affected).
gross_ignorance(P,A,Of)        :- ignorance(P,A,Of,K), gross(K).

% ---------- Fear: a mixed voluntary (ST I-II q. 6 a. 6) -------------------
% fear(Grade, Origin, How): grave | relatively_grave | light;
% extrinsic | intrinsic; unjust | just | unintended.
grave_fear(P,A)        :- interior(P,A,fear(grave,_,_)).
grave_fear(P,A)        :- interior(P,A,fear(relatively_grave,_,_)).
fear_from_without(P,A) :- interior(P,A,fear(_,extrinsic,_)).
fear_unjust(P,A)       :- interior(P,A,fear(_,_,unjust)).
chosen_to_escape(P,A)  :- interior(P,A,escape_choice).

% ---------- Other causes that lessen the voluntary (CCC 1735) ------------
imperfect_reason(P,A)    :- interior(P,A,reason(imperfect)).
undeliberate_passion(P,A) :- interior(P,A,passion(grave,unstimulated)).
necessity(P,A)           :- interior(P,A,necessity).
chance(P,A)              :- interior(P,A,chance).
due_defence(P,A)         :- interior(P,A,defence(moderate)).
believed(P,A,C,K)        :- interior(P,A,believed(C,K)).

% ---------- Presumptions (c. 1321 §4; Apostolicae curae 33) ---------------
% One shape (TTC-CHRIST SA3): an outward fact raises a presumption about the
% interior, and only an outward fact rebuts it. What is presumed is what the
% external forum holds, never a finding about the soul: the Church "does not
% judge about the mind and intention, in so far as it is something by its
% nature internal" (Apostolicae curae 33).
% @input raises/1 | raises(X): an outward fact raises the presumption X (from a canon or a library)
% @input rebutted/1 | rebutted(X): an outward fact rebuts the presumption X
presumed(X) :- raises(X), not rebutted(X).

% ---------- Dolus and culpa (c. 1321 §§2-3) -------------------------------
% Compositions of the elements. Dolus: the violation known and willed.
% Culpa: the omission of due diligence; its ignorance is vincible.
culpa(P,A) :- actus_humanus(P,A), ignorant_with_fault(P,A,_).
culpa(P,A) :- actus_humanus(P,A), interior(P,A,negligence).
dolus(P,A) :- actus_humanus(P,A), interior(P,A,deliberate), not culpa(P,A).
