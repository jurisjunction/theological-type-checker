layer libraries

-- Sorts first used in this layer (TTC-L, TY): closed, then open

sort fact
  means "a fact, as a term"

sort interior
  means "a claim about an agent's knowledge, will or freedom"

```clingo
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
```

library

```clingo
% ===================================================================

```

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot act_of(P: person, A: act)
  means "act_of(P, A): P placed the act A"
  say "{P} placed the act {A}"

slot disputed(F: fact)
  means "disputed(F): the fact F is disputed: computed both ways"
  say "the fact {F} is disputed"

slot gross(K: category)
  means "gross(K): a gross kind of ignorance (crass, supine, affected)"
  say "ignorance of the kind {K} is gross"

use acts/1 "from the runtime (schools.lp, classical): creatures act"

use operates/2 "from the runtime (schools.lp, classical): operates(X, hum), the incarnate's human operation"

use in_nature/2 "in_nature(Act, Nature): the nature by which the person places the act (the kernel's T5 natures)"

use divine/1 "from the kernel's sorts"

use god/1 "from the kernel's sorts"

use free_of_original_sin/1 "the kernel: a claim that X contracted no original sin"

slot interior(Person: person, Act: act, Element: interior)
  means "interior(Person, Act, Element): a claim about the agent's knowledge, will or freedom in the act; supplied, never derived"
  say "it is claimed of {Person}, in {Act}: {Element}"

```clingo
{ interior(P,A,X) } :- disputed(interior(P,A,X)).
assumed_fact(interior(P,A,X))        :- disputed(interior(P,A,X)), interior(P,A,X).
assumed_fact(false(interior(P,A,X))) :- disputed(interior(P,A,X)), not interior(P,A,X).
% Every interior a case supplies, or disputes, is named in every branch
% (TTC-L IS): the reader sees what was claimed of the agent. A name, never a
% finding; no rule reads it (rule 3).
info(interior_supplied(P,A,X)) :- interior(P,A,X).
info(interior_supplied(P,A,X)) :- disputed(interior(P,A,X)).

% ---------- Agents -----------------------------------------------------
% The person acts; the nature is that by which (ST III q. 19 a. 1). A
% creature acts by its own nature, if creatures act at all (agere sequitur
% esse: the classical runtime); the incarnate places a human act by the
% nature assumed, where the runtime grants it an operation (DH 557). A
% divine person is never made a creature by acting (TTC-CHRIST CH1).
creature(P)  :- act_of(P,_), not divine(P), not god(P), not non_physical(P).
agent(P,A)   :- act_of(P,A), acts(P), not non_physical(P).
agent(P,A)   :- act_of(P,A), in_nature(A,hum), operates(P,hum).

% ---------- Subjects: physical persons and fictions (TTC-PENAL FL) --------
% Only a physical person places a human act. A juridic person (cc. 113 §2,
% 114), a group with no status in law, and the two moral persons by divine
% ordinance (c. 113 §1) do not: a city or an army "has only a unity of order"
% (In I Ethic. lect. 1); a people is "a multitude of rational beings united by
% common agreement on the objects of their love" (De civ. Dei XIX.24); a
% society, "a group of persons bound together organically by a principle of
% unity" (CCC 1880). An act recorded in its name is placed by those who
% represent it (c. 118). Structures of sin are "the expression and effect of
% personal sins" (CCC 1869; RP 16): said by analogy, never of the collective.
```

slot juridic_person(P: person)
  means "cc. 113 §2, 114: a subject of obligations and rights by law or decree (of the Church or of a civil order)"
  say "{P} is a juridic person"

slot moral_person(P: person)
  means "c. 113 §1: a moral person by divine ordinance (the Catholic Church, the Apostolic See)"
  say "{P} is a moral person by divine ordinance"

slot group(P: person)
  means "a name for persons with no status in law"
  say "{P} names persons with no status in law"

slot represents(Person: person, J: person)
  means "represents(Person, J): c. 118, who acts in its name"
  say "{Person} acts in the name of {J}"

```clingo
fiction(J)       :- juridic_person(J).
fiction(J)       :- group(J).
non_physical(J)  :- fiction(J).
non_physical(J)  :- moral_person(J).
act_of(P,A) :- act_of(J,A), non_physical(J), represents(P,J).
violation(interior_of_fiction(J,A)) :- fiction(J), interior(J,A,_).
% Original sin is "in each one as his own" (Trent, sess. V, can. 3, DH
% 1513): said of a fiction, the claim is ill typed. A people is entered by
% its members (TTC-DESCENT DS2).
violation(original_sin_of_fiction(J)) :- free_of_original_sin(J), fiction(J).

% ---------- Kinds of act (ST I-II q. 1 a. 1; q. 6 a. 5) ------------------
% An actus humanus proceeds from knowledge and deliberate will; force from
% without, and the lack of reason, leave only an actus hominis.
removes_voluntary(P,A,violence)    :- interior(P,A,violence).
removes_voluntary(P,A,no_reason)   :- interior(P,A,reason(lacking)).
removes_voluntary(P,A,no_reason)   :- interior(P,A,reason(habitually_lacking)).
actus_humanus(P,A) :- agent(P,A), not removes_voluntary(P,A,_).

% ---------- The voluntary in its cause (ST II-II q. 150 a. 4) -------------
% Reason lacking at the deed, its lack brought on culpably or sought for the
% deed: the deed is no human act, yet it is voluntary through the act before
% it, and so not wholly excused (actio libera in causa). For imputability
% only: what needs actual reason to be placed (consent, a juridic act) reads
% actus_humanus/2, which this leaves as it is. Claims, never computed.
culpable_disturbance(P,A) :- interior(P,A,disturbance(culpable)).
sought_disturbance(P,A)   :- interior(P,A,disturbance(sought)).
voluntary_in_cause(P,A) :- agent(P,A), interior(P,A,reason(lacking)), culpable_disturbance(P,A).
voluntary_in_cause(P,A) :- agent(P,A), interior(P,A,reason(lacking)), sought_disturbance(P,A).
imputable_act(P,A) :- actus_humanus(P,A).
imputable_act(P,A) :- voluntary_in_cause(P,A).

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
```

use raises/1 "raises(X): an outward fact raises the presumption X (from a canon or a library)"

use rebutted/1 "rebutted(X): an outward fact rebuts the presumption X"

```clingo
presumed(X) :- raises(X), not rebutted(X).

% ---------- Dolus and culpa (c. 1321 §§2-3) -------------------------------
% Compositions of the elements. Dolus: the violation known and willed.
% Culpa: the omission of due diligence; its ignorance is vincible.
culpa(P,A) :- actus_humanus(P,A), ignorant_with_fault(P,A,_).
culpa(P,A) :- actus_humanus(P,A), interior(P,A,negligence).
dolus(P,A) :- actus_humanus(P,A), interior(P,A,deliberate), not culpa(P,A).
```
