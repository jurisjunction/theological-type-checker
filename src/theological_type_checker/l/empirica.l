layer libraries

```clingo
% ===================================================================
%  The empirical kind; how many human beings (TTC-EMPIRICA)
%
%  "Nulla tamen umquam inter fidem et rationem vera dissensio esse potest"
%  (Dei Filius 4, DH 3017; CCC 159): "there can never be any real
%  discrepancy between the theologian and the physicist, as long as each
%  confines himself within his own lines" (Providentissimus Deus 18).
%
%  The empirical kind. A question the sciences answer is typed so
%  (question_kind(Q,empirical)). No tier settles it: no source deletes,
%  cleaves or weighs on it (icon_authority.lp). A finding fixes it from its
%  year, a later finding superseding an earlier, and a reading of Scripture
%  that reads the contrary is then on no branch, by inerrancy as it stands
%  (DV 11). A finding settles no doctrine: laid on a doctrinal question it
%  is refused, and a doctrine rested on a finding is refused, its value
%  unchanged. Creation from nothing concerns being, not a date (DH 800).
%  The two directions of one error: the theologians of 1616 "unduly ...
%  transpose[d] into the realm of the doctrine of the faith a question
%  which in fact pertained to scientific investigation" (John Paul II,
%  1992); in 1951 a pope rested "creation, therefore, in time" on the
%  expansion of the universe.
%
%  The Fathers' consent binds "in rebus fidei et morum" (DH 1507): claimed
%  on a text outside them it fixes nothing, and is reported so.
%
%  Method never answers being. A finding reached by division supports
%  claims about the parts, never that a whole is "nothing but" them. The
%  unity of the human being is defined (Vienne, DH 902); that of other
%  organisms is a school's.
%
%  How many human beings there are is a fact about souls. "No experimental
%  datum can be in itself sufficient to bring us to the recognition of a
%  spiritual soul" (Donum vitae I.1): never computed (rule 3), never
%  derived from an outward fact, it enters as a disputed fact, both ways.
%  Each soul is created immediately by God (Humani generis 36, DH 3896;
%  CCC 366) and is not divided (DH 1440); the embryo is to be treated as a
%  person from conception (CCC 2274) on every reading.
%
```

library

```clingo
% ===================================================================

```

slot finding/4
  means "finding(F, Q, V, Year): a finding of the sciences on a question, by its year"

slot method/2
  means "method(F, division): how a finding was reached, where a claim rests on it"

slot censures_as_heresy/3
  means "censures_as_heresy(S, Q, V): the source censures value V of Q as heretical"

slot censures_in_faith/3
  means "censures_in_faith(S, Q, V): the source censures value V of Q as erroneous in faith"

slot rests_on_finding/3
  means "rests_on_finding(S, Q, F): a source rests its value on Q on the finding F"

slot consent_claimant/2
  means "consent_claimant(Text, C): who claims the Fathers' unanimous consent on the text"

slot nothing_but/3
  means "nothing_but(Claim, Whole, F): a claim that the whole is nothing but its parts, resting on F"

slot about_the_parts/3
  means "about_the_parts(Claim, Whole, F): a claim about the parts, resting on F"

slot form_of_the_body_given/1
  means "the source defines the rational soul the form of the human body (Vienne, DH 902)"

slot twinning/3
  means "twinning(E, A, B): an embryo E becomes the twins A and B"

slot contrary_acts_at_once/2
  means "contrary_acts_at_once(A, B): the twins do contrary things at once, outwardly"

slot died_while_other_lived/2
  means "died_while_other_lived(A, B): A died and B lived on"

slot baptized_each/2
  means "baptized_each(A, B): the Church baptized each of them absolutely"

slot married_each/2
  means "married_each(A, B): each married, admitted by the Church"

slot divides_the_soul/1
  means "candidate only: the soul of E divided between the twins"

slot doubt_one_or_more/2
  means "canon_law.lp: a birth at which it is doubted whether one human being or several"

use question_kind/2 "icon_authority.lp"

use holds/2 "icon_authority.lp"

use supports/3 "icon_authority.lp"

use source/4 "icon_authority.lp"

use in_force/1 "icon_authority.lp"

use eff_tier/2 "icon_authority.lp"

use consent_claim/2 "icon_authority.lp"

use faith_morals/1 "icon_authority.lp"

use human/1 "the kernel"

```clingo

% ---------- The empirical kind (EM) ------------------------------------------
empirical(Q) :- question_kind(Q,empirical).
later_finding(F) :- finding(F,Q,_,Y), finding(F2,Q,_,Y2), F2 != F, Y2 > Y, asof(A), Y2 <= A.
fixed_by(Q,V,F)  :- finding(F,Q,V,Y), empirical(Q), asof(A), Y <= A, not later_finding(F).
:- holds(Q,W), fixed_by(Q,V,_), W != V.
info(fixed_by_finding(Q,V,F)) :- fixed_by(Q,V,F).
violation(act_answers_a_fact(S,Q))       :- supports(S,Q,_), empirical(Q), in_force(S), source(S,T,_,_), T >= 1, T <= 3.
violation(fact_censured_as_heresy(S,Q))  :- censures_as_heresy(S,Q,_), empirical(Q), in_force(S).
violation(fact_censured_in_faith(S,Q))   :- censures_in_faith(S,Q,_), empirical(Q), in_force(S).
violation(finding_on_a_doctrine(F,Q))    :- finding(F,Q,_,Y), question_kind(Q,doctrinal), asof(A), Y <= A.
violation(doctrine_rests_on_finding(S,Q,F)) :- rests_on_finding(S,Q,F), question_kind(Q,doctrinal), in_force(S).

% ---------- The Fathers' consent, outside faith and morals (GL) --------------
claimed_consent(S) :- consent_claimant(S,_).
info(consent_outside_faith_and_morals(S,C))         :- consent_claim(S,_), not faith_morals(S), consent_claimant(S,C).
info(consent_outside_faith_and_morals(S,unclaimed)) :- consent_claim(S,_), not faith_morals(S), not claimed_consent(S).

% ---------- Method never answers being (MB) ----------------------------------
by_division(F) :- method(F,division).
form_given :- form_of_the_body_given(S), in_force(S), eff_tier(S,1).
violation(nothing_but_from_division(C,W)) :- nothing_but(C,W,F), by_division(F).
violation(against_the_soul_as_form(C,W))  :- nothing_but(C,W,_), human(W), form_given.
info(about_the_parts(C,W))                :- about_the_parts(C,W,F), by_division(F).

% ---------- How many human beings (TW; rule 3) -------------------------------
% A twinning read four ways: the first continues and a second begins
% (budding); the first ceases and two begin (fission); no person before the
% split (delayed hominization, a school's); one soul, its body two organisms.
twin_reading_kind(budding;fission;delayed;one_soul).
{ twin_reading(E,R) } :- twinning(E,_,_), twin_reading_kind(R).
read_twinning(E) :- twin_reading(E,_).
:- twinning(E,_,_), not read_twinning(E).
:- twin_reading(E,R1), twin_reading(E,R2), R1 < R2.
assumed_fact(twin_reading(E,R)) :- twin_reading(E,R).
info(human_beings_after(E,2)) :- twin_reading(E,R), R != one_soul.
info(human_beings_after(E,1)) :- twin_reading(E,one_soul).
info(treated_as_a_person(E))  :- twinning(E,_,_).
% The one-soul reading against the outward facts and the Church's practice:
% one soul has one will (DH 556); a person dies once and is judged at death
% (Heb 9:27; DH 1000); baptism is not repeated (DH 1609; c. 845 §1); a prior
% bond invalidates (c. 1085 §1).
one_soul(E,A,B) :- twinning(E,A,B), twin_reading(E,one_soul).
violation(one_will_two_contrary_acts(E))     :- one_soul(E,A,B), contrary_acts_at_once(A,B).
violation(one_person_dead_and_alive(E))      :- one_soul(E,A,B), died_while_other_lived(A,B).
violation(baptism_repeated_by_the_church(E)) :- one_soul(E,A,B), baptized_each(A,B).
violation(two_bonds_one_person(E))           :- one_soul(E,A,B), married_each(A,B).
% Refused on every reading: the soul divided ("singulariter multiplicabilis",
% DH 1440). A soul given by a creature is refused by the kernel (A1).
violation(soul_divided(E)) :- divides_the_soul(E).
% Conjoined twins: whether one human being or several is a disputed fact.
{ one_human_being(E) } :- doubt_one_or_more(E,_).
assumed_fact(one_human_being(E))        :- doubt_one_or_more(E,_), one_human_being(E).
assumed_fact(false(one_human_being(E))) :- doubt_one_or_more(E,_), not one_human_being(E).
```
