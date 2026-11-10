layer libraries

-- Sorts first used in this layer (TTC-L, TY): closed, then open

sort finding
  means "a finding of the sciences"

sort scheme
  means "a scheme of decomposition, by its name: a way of splitting a computed total into terms (TTC-RERUM)"

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

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot twin_reading_kind(R: reading)
  means "twin_reading_kind(R): a reading of a twinning (budding, fission, delayed, one soul)"
  say "{R} is a reading of a twinning"

slot finding(F: finding, Q: question, V: value, Year: year)
  means "finding(F, Q, V, Year): a finding of the sciences on a question, by its year"
  say "from {Year}, the finding {F} holds {V} on {Q}"

slot method(F: finding, M: category)
  means "method(F, division): how a finding was reached, where a claim rests on it"
  say "the finding {F} was reached by {M}"

slot censures_as_heresy(S: source, Q: question, V: value)
  means "censures_as_heresy(S, Q, V): the source censures value V of Q as heretical"
  say "{S} censures {V} on {Q} as heretical"

slot censures_in_faith(S: source, Q: question, V: value)
  means "censures_in_faith(S, Q, V): the source censures value V of Q as erroneous in faith"
  say "{S} censures {V} on {Q} as erroneous in faith"

slot rests_on_finding(S: source, Q: question, F: finding)
  means "rests_on_finding(S, Q, F): a source rests its value on Q on the finding F"
  say "{S} rests its value on {Q} on the finding {F}"

slot consent_claimant(Text: source, C: claimant)
  means "consent_claimant(Text, C): who claims the Fathers' unanimous consent on the text"
  say "{C} claims the Fathers' unanimous consent on {Text}"

slot nothing_but(Claim: claim, Whole: entity, F: finding)
  means "nothing_but(Claim, Whole, F): a claim that the whole is nothing but its parts, resting on F"
  say "{Claim} says {Whole} is nothing but its parts, resting on {F}"

slot about_the_parts(Claim: claim, Whole: entity, F: finding)
  means "about_the_parts(Claim, Whole, F): a claim about the parts, resting on F"
  say "{Claim} is a claim about the parts of {Whole}, resting on {F}"

slot form_of_the_body_given(S: source)
  means "the source defines the rational soul the form of the human body (Vienne, DH 902)"
  say "{S} defines the rational soul the form of the body"

slot twinning(E: event, A: person, B: person)
  means "twinning(E, A, B): an embryo E becomes the twins A and B"
  say "the embryo {E} becomes the twins {A} and {B}"

slot contrary_acts_at_once(A: person, B: person)
  means "contrary_acts_at_once(A, B): the twins do contrary things at once, outwardly"
  say "{A} and {B} do contrary things at once"

slot died_while_other_lived(A: person, B: person)
  means "died_while_other_lived(A, B): A died and B lived on"
  say "{A} died and {B} lived on"

slot baptized_each(A: person, B: person)
  means "baptized_each(A, B): the Church baptized each of them absolutely"
  say "the Church baptized each of {A} and {B}"

slot married_each(A: person, B: person)
  means "married_each(A, B): each married, admitted by the Church"
  say "the Church admitted each of {A} and {B} to marriage"

slot divides_the_soul(E: event)
  means "candidate only: the soul of E divided between the twins"
  say "the soul of {E} is said divided between the twins"

slot doubt_one_or_more(E: event, Date: date)
  means "canon_law.lp: a birth at which it is doubted whether one human being or several"
  say "at the birth {E}, on {Date}, it is doubted whether one human being was born or several"

slot denies_descent(X: entity, R: category)
  means "denies_descent(X, R): a claim that X, a human being, does not descend from Adam by generation, for the reason R (many_first_parents, before_adam, separate_creation)"
  say "{X} is claimed not to descend from Adam, for {R}"

slot question_part(Q1: question, Q: question)
  means "question_part(Q1, Q): Q1 is a part of the joint whole Q, a natural question composed of parts each of its own kind (TTC-RERUM)"
  say "{Q1} is a part of the joint whole {Q}"

slot claims_conflict(C: claimant, F: finding, Q1: question, V: value)
  means "claims_conflict(C, F, Q1, V): C says the finding F conflicts with the value V on Q1"
  say "{C} says the finding {F} conflicts with {V} on {Q1}"

slot resenses(F: finding, S: source, R: reading)
  means "resenses(F, S, R): the finding F is said to give the text S another sense, R (Dei Filius can. 4.3, DH 3043)"
  say "the finding {F} is said to give {S} the sense {R}"

slot scheme_term(T: entity, Q: question, S: scheme)
  means "scheme_term(T, Q, S): T is a term of the total that Q asks, under the scheme S"
  say "under {S}, {T} is a term of the total that {Q} asks"

result joint_part(Q: question, Q1: question, K: question_kind)
  say "{Q1}, a {K} question, is a part of the joint whole {Q}"

result part_of_no_natural_question(Q1: question, Q: question)
  say "{Q1} is entered as a part of {Q}, which is no question of natural philosophy: refused"

result part_cycle(Q: question)
  say "{Q} is a part of itself: refused"

result misread_dogma(C: claimant, Q1: question)
  say "on this branch the conflict {C} claims on {Q1} rests on a dogma not understood as the Church understands it (DH 3017)"

result opinion_for_finding(F: finding)
  say "on this branch {F} is an opinion taken for a finding of reason (DH 3017), and fixes nothing"

result reserved_to_the_author(Q: question, F: finding, Q1: question)
  say "a conflict is claimed between the finding {F} and a definition on {Q1}, a part of {Q}: reserved, never resolved here (DH 3017)"

result conflict_with_reformable(C: claimant, F: finding, Q1: question)
  say "{C} claims the finding {F} conflicts with a teaching on {Q1} below tier 1: nothing branches"

result dogma_resensed_by_finding(F: finding, S: source)
  say "the finding {F} is said to give {S}, a definition, another sense: refused (Dei Filius can. 4.3, DH 3043)"

result scripture_read_by_finding(F: finding, S: source, R: reading)
  say "the finding {F} is said to read {S}, a text of Scripture, as {R}: reported"

result scheme_relative(Q: question)
  say "{Q} is split into terms by two schemes: its terms are relative to a scheme"

result term_as_part(T: entity)
  say "{T}, a term of a scheme, is typed as a creature: a term is no part of a thing"

result term_as_cause(T: entity, X: entity)
  say "{T}, a term of a scheme, is typed as a cause of {X}: a term is no cause"

result fixed_by_simulation(Q: question, V: value, F: finding)
  say "{Q} is fixed {V} by {F}, a finding reached by simulation"

use question_kind/2 "icon_authority.lp"

use holds/2 "icon_authority.lp"

use supports/3 "icon_authority.lp"

use source/4 "icon_authority.lp"

use in_force/1 "icon_authority.lp"

use eff_tier/2 "icon_authority.lp"

use consent_claim/2 "icon_authority.lp"

use faith_morals/1 "icon_authority.lp"

use human/1 "the kernel"

use of_kind/2 "from the theological side (pair.lp): in this branch the thing is classified so"

```clingo

% ---------- The empirical kind (EM) ------------------------------------------
empirical(Q) :- question_kind(Q,empirical).
later_finding(F) :- finding(F,Q,_,Y), finding(F2,Q,_,Y2), F2 != F, Y2 > Y, asof(A), Y2 <= A.
fixed_by(Q,V,F)  :- finding(F,Q,V,Y), empirical(Q), asof(A), Y <= A, not later_finding(F),
                    not opinion_for_finding(F).
:- holds(Q,W), fixed_by(Q,V,_), W != V.
info(fixed_by_finding(Q,V,F)) :- fixed_by(Q,V,F).
violation(act_answers_a_fact(S,Q))       :- supports(S,Q,_), empirical(Q), in_force(S), source(S,T,_,_), T >= 1, T <= 3.
violation(fact_censured_as_heresy(S,Q))  :- censures_as_heresy(S,Q,_), empirical(Q), in_force(S).
violation(fact_censured_in_faith(S,Q))   :- censures_in_faith(S,Q,_), empirical(Q), in_force(S).
violation(finding_on_a_doctrine(F,Q))    :- finding(F,Q,_,Y), question_kind(Q,doctrinal), asof(A), Y <= A.
violation(doctrine_rests_on_finding(S,Q,F)) :- rests_on_finding(S,Q,F), question_kind(Q,doctrinal), in_force(S).

% ---------- A joint work (TTC-RERUM) ------------------------------------------
% A question of natural philosophy may be a whole composed of parts, each of
% its own kind: "duplicem esse ordinem cognitionis", the disciplines each
% "in suo ambitu propriis ... principiis et propria methodo" (Dei Filius ch.
% 4, DH 3015, 3019). A joint whole is entered by question_kind(Q,natural)
% and its parts, never by question/1.
info(joint_part(Q,Q1,K)) :- question_part(Q1,Q), question_kind(Q1,K).
violation(part_of_no_natural_question(Q1,Q)) :- question_part(Q1,Q), not question_kind(Q,natural).
part_within(Q1,Q) :- question_part(Q1,Q).
part_within(Q1,Q) :- question_part(Q1,Q2), part_within(Q2,Q).
violation(part_cycle(Q)) :- part_within(Q,Q).
% A claimed conflict. "Nulla tamen umquam inter fidem et rationem vera
% dissensio esse potest. Inanis autem huius contradictionis species inde
% potissimum oritur, quod vel fidei dogmata ad mentem Ecclesiae intellecta
% et exposita non fuerint, vel opinionum commenta pro rationis effatis
% habeantur" (DH 3017). Against a value a tier-1 source in force supports,
% the claim is computed both ways, on the two diagnoses, and neither is
% preferred; on the second the finding fixes nothing. The value is
% untouched on both, and the question is reported reserved, never resolved.
% Below tier 1 nothing branches: the base's shadows already carry a
% reformable teaching.
defined_value(Q1,V) :- supports(S,Q1,V), in_force(S), eff_tier(S,1).
conflict_at_definition(C,F,Q1) :- claims_conflict(C,F,Q1,V), defined_value(Q1,V).
misread_dogma(C,Q1)    :- conflict_at_definition(C,F,Q1), not opinion_for_finding(F).
opinion_for_finding(F) :- conflict_at_definition(C,F,Q1), not misread_dogma(C,Q1).
assumed_fact(misread_dogma(C,Q1)) :- misread_dogma(C,Q1).
assumed_fact(opinion_for_finding(F)) :- opinion_for_finding(F).
info(reserved_to_the_author(Q,F,Q1)) :- conflict_at_definition(_,F,Q1), question_part(Q1,Q).
info(conflict_with_reformable(C,F,Q1)) :- claims_conflict(C,F,Q1,V), not defined_value(Q1,V).
% "Si quis dixerit, fieri posse, ut dogmatibus ab Ecclesia propositis aliquando
% secundum progressum scientiae sensus tribuendus sit alius" (can. 4.3, DH
% 3043): a definition is not re-read by a finding. Scripture, read and never
% raw, may be: reported.
violation(dogma_resensed_by_finding(F,S)) :- resenses(F,S,_), in_force(S), eff_tier(S,1).
info(scripture_read_by_finding(F,S,R))    :- resenses(F,S,R), eff_tier(S,0).

% ---------- Decomposition and the oracle (TTC-RERUM) ---------------------------
% "There is not a unique way to compute quantities related with such
% intuitive chemical concepts" (Andres et al., 2019): the terms of a
% scheme split a computed total, and are never parts of a thing and never
% its causes. A simulation is a method a finding may be reached by.
scheme_of(Q,S) :- scheme_term(_,Q,S).
info(scheme_relative(Q)) :- scheme_of(Q,S1), scheme_of(Q,S2), S1 < S2.
violation(term_as_part(T))    :- scheme_term(T,_,_), creature(T).
violation(term_as_cause(T,X)) :- scheme_term(T,_,_), cause_of(X,_,T).
info(fixed_by_simulation(Q,V,F)) :- fixed_by(Q,V,F), method(F,simulation).

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

% ---------- One root (TTC-DESCENT DD) ---------------------------------------
% That every human being descends "ab eodem prouti omnium protoparente,
% naturali generatione", and Adam is not "multitudinem quamdam
% protoparentum", is taught at tier 3 (Humani generis 37, DH 3897: "cum
% nequaquam appareat quomodo ... componi queat"). It weighs on the branch
% whose question holds it (part one_root): a denial is refused there, and
% stands on the live shadow. Without the part, the claim is silent.
violation(descent_denied(P,R)) :- denies_descent(P,R), human(P), of_kind(human_race,from_one_adam).
```
