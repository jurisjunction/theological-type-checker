layer libraries

```clingo
% ===================================================================
%  The sacraments: a standard library (TTC-CHRIST(7)).
%  Predictions were committed and stamped first, with an amendment:
%  docs/research/christ-preregistration.md.
%
%  What the canons presupposed and never said: what a sacrament is, which
%  of its conditions are divine law, and what it yields. God is the
%  principal cause, Christ's humanity the conjoined instrument, the
%  sacrament and its minister separated instruments (III q. 62 a. 5; q. 64
%  a. 1). Three outputs are kept apart: valid (the act took place), the
%  character (DH 1609), and the fruit, which depends on the recipient's
%  disposition and so is input, never computed (TTC-MORAL GR1). The canons
%  that read this library are in canon_law.lp (cc. 842, 845, 966, 983,
%  1057-1143, 1386, 1643, 1682).
%
```

library

```clingo
% ===================================================================

```

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot due_form/2
  means "due_form(K, F): the form due to sacrament K"

slot grade/1
  means "grade(G): a grade of orders"

slot celebrated/4
  means "celebrated(E, Sacrament, Minister, Recipient): a celebration a case records (outward)"

slot celebration_date/2
  means "celebration_date(E, Date)"

use absolution/4 "the canon layer's input"

use consecration/4 "the canon layer's input"

slot matter_used/2
  means "matter_used(E, M): the matter, where a case records it"

slot form_used/2
  means "form_used(E, F): the form, where a case records it"

slot simulated/1
  means "the rite was performed in jest or on a stage: an outward fact"

slot contrary_intention_manifested/1
  means "a contrary intention manifested outwardly (Apostolicae curae 33)"

slot conditional/1
  means "the celebration was conferred conditionally (c. 845 §2)"

use priest/1 "the canon layer's input"

slot bishop/1
  means "the canon layer's input"

use faculty_met/1 "canon_law.lp (c. 966 §1, c. 976, c. 144): the faculty to absolve, or the Church's supply"

use confirms_by_law_or_faculty/1 "the canon layers (c. 882; CCEO c. 696): a presbyter confirms validly in this celebration"

slot typed_ordinary_minister/2
  means "typed_ordinary_minister(P, Sacrament): a claim that P is the ordinary minister"

use of_kind/2 "from the theological side (pair.lp): in this branch the thing is classified so"

use not_of_kind/2 "from the theological side (pair.lp)"

use dispensed/2 "canon_law.lp (c. 85): dispensed(Law, X)"

use interior/3 "act.lp: a claim, supplied or computed both ways"

slot age_at/3
  means "age_at(Person, Act, Years)"

use incarnate/1 "the kernel"

slot host_of/2
  means "host_of(E, H): a host consecrated in the celebration E"

slot fragment_of/2
  means "fragment_of(H2, H): a part of the species, separated"

slot reserved/1
  means "the host is kept after the celebration"

slot species_ceased/1
  means "the species no longer remain"

use disputed/1 "a fact whose truth is disputed"

slot presence_requires/1
  means "a theory's claim: Christ is present only in this (candidate: use)"

slot presence_as/1
  means "a theory's claim: Christ is present only as this (candidate: sign)"

use requires_of_minister/2 "a theory's claim: validity requires this of the minister (candidate: grace)"

slot same_sacrifice/2
  means "same_sacrifice(Offering, passion): an offering joined to the one sacrifice of the cross"

slot repeats/2
  means "candidate only: repeats(Offering, passion), the offering typed as a second immolation"

slot commemoration_only/1
  means "candidate only: the offering typed as a bare commemoration"

slot sacrifice_canons/1
  means "sacrifice_canons(Source): the canons on the sacrifice of the Mass"

use in_force/1 "icon_authority.lp"

use eff_tier/2 "icon_authority.lp"

```clingo

% ---------- What a sacrament is (Trent, sess. VII, cann. 1, 8, DH 1601, 1608) --
% Seven, instituted by Christ, acting ex opere operato. A celebration is
% recorded by a case, or routed from the canon layer's own acts.
grade(episcopate). grade(presbyterate). grade(diaconate).
celebration(E,K,M,R) :- celebrated(E,K,M,R).
celebration(A,penance,P,Pen) :- absolution(A,P,Pen,_).
celebration(E,orders(episcopate),B,R) :- consecration(E,B,R,_).
celebrated_on(E,T) :- celebration_date(E,T).
celebrated_on(E,T) :- consecration(E,_,_,T).

% ---------- Validity: matter, form, minister, intention (Florence, DH 1312) --
% "At least" the intention of doing what the Church does (Trent, sess. VII,
% can. 11, DH 1611). A condition fails on a recorded defect: a case that
% records a celebration and no defect records the rite performed.
due_matter(baptism,true_water).                       % Trent, sess. VII, on baptism, can. 2 (DH 1615)
due_matter(eucharist,wheat_bread). due_matter(eucharist,grape_wine).   % c. 924 §§2-3
due_matter(orders(G),imposition_of_hands) :- grade(G). % Pius XII, Sacramentum ordinis (1947), DH 3859
due_form(baptism,i_baptize).                          % the minister's "I baptize you in the name of..." (DH 1314)
due_form(eucharist,words_of_institution).
due_form(orders(episcopate),consecratory_prayer).     % DH 3860
matter_ok(K,M) :- due_matter(K,M).
form_ok(K,F)   :- due_form(K,F).
form_ok(K,F)   :- of_kind(form(K,F),valid_form).      % where a form is in question, the theological side (SA5)
defect(E,matter) :- matter_used(E,M), celebration(E,K,_,_), not matter_ok(K,M).
defect(E,form)   :- form_used(E,F), celebration(E,K,_,_), not form_ok(K,F).
{ form_used(E,F) }   :- disputed(form_used(E,F)).
{ matter_used(E,M) } :- disputed(matter_used(E,M)).
assumed_fact(form_used(E,F))          :- disputed(form_used(E,F)), form_used(E,F).
assumed_fact(false(form_used(E,F)))   :- disputed(form_used(E,F)), not form_used(E,F).
assumed_fact(matter_used(E,M))        :- disputed(matter_used(E,M)), matter_used(E,M).
assumed_fact(false(matter_used(E,M))) :- disputed(matter_used(E,M)), not matter_used(E,M).
% The minister's power. Baptism: anyone (Florence, DH 1315). The Eucharist
% and absolution: a priest (Lateran IV, DH 802; Trent, sess. XIV, can. 10,
% DH 1710); anointing, a priest (sess. XIV, can. 4 on extreme unction,
% DH 1719). Confirmation: a bishop, the ordinary minister (DH 1318), and a
% presbyter by law or faculty (TTC-CCEO CF): "a simple priest" has confirmed
% "by dispensation of the Apostolic See" (DH 1318); in the East the priest
% who baptizes ordinarily confers it at once (CCC 1312); in the Latin Rite
% the bishop may concede the faculty to priests (CCC 1313). The faculty is
% the canon layers' (c. 882; CCEO c. 696). Orders: a bishop (c. 1012).
has_power(P,baptism)      :- celebration(_,baptism,P,_).
has_power(P,eucharist)    :- priest(P).
has_power(P,penance)      :- priest(P).
has_power(P,anointing)    :- priest(P).
has_power(P,confirmation) :- bishop(P).
has_power(P,orders(G))    :- bishop(P), grade(G).
has_power_in(E) :- celebration(E,K,P,_), has_power(P,K).
has_power_in(E) :- celebration(E,confirmation,P,_), priest(P), confirms_by_law_or_faculty(E).
defect(E,minister) :- celebration(E,_,_,_), not has_power_in(E).
% Refused at Trent: that "the ordinary minister of holy confirmation is not
% the bishop alone, but any simple priest" (sess. VII, on confirmation,
% can. 3, DH 1630).
violation(presbyter_as_ordinary_minister(P)) :- typed_ordinary_minister(P,confirmation), priest(P), not bishop(P).
% Intention is interior, so input. One who has "correctly and seriously"
% used the due matter and form is presumed to intend what the Church does;
% the presumption yields only to a contrary intention manifested outwardly
% (Leo XIII, Apostolicae curae 33): act.lp's one shape (SA3). "Seriously" is
% outward (not simulated); where the rite is not "correctly" used, it fails
% as a rite, and the intention adds nothing.
raises(intention(E))   :- celebration(E,_,_,_), not simulated(E).
rebutted(intention(E)) :- contrary_intention_manifested(E).
defect(E,intention)    :- celebration(E,_,_,_), not presumed(intention(E)).
% The minister's sin does not hinder the sacrament (Trent, sess. VII,
% can. 12, DH 1612): "Peter may baptize, but this is He that baptizes"
% (Augustine, In Ioh. 6.7). Validity resting on the minister's grace would
% rest on a claim no one can know (TTC-MORAL GR1).
violation(validity_from_the_ministers_holiness(K,X)) :- requires_of_minister(K,X).

% ---------- Two laws in one sacrament (Trent, sess. XXI, ch. 2, DH 1728) ------
% The Church has power over the sacraments "saving their substance". Which
% conditions belong to the substance is teaching, from the theological side
% (classification/3; rule 1); each condition is then typed by its law, and
% law.lp and c. 85 do the rest (SA2).
law_kind(cond(K,C),divine_positive) :- of_kind(cond(K,C),of_substance).
law_kind(cond(K,C),ecclesiastical)  :- not_of_kind(cond(K,C),of_substance).
law_kind(L,divine_positive) :- of_kind(L,of_divine_law).
law_kind(L,ecclesiastical)  :- not_of_kind(L,of_divine_law).
unmet(E,C) :- defect(E,C), celebration(E,K,_,_), not dispensed(cond(K,C),E).
sound(E)   :- celebration(E,_,_,_), not unmet(E,_).

% ---------- The character (Trent, sess. VII, can. 9, DH 1609; III q. 63) -------
% Baptism, confirmation and orders imprint a character and are not
% repeated: a second absolute celebration confers nothing.
imprints(baptism). imprints(confirmation). imprints(orders(G)) :- grade(G).
repeated(E2) :- celebration(E1,K,_,R), celebration(E2,K,_,R), imprints(K), sound(E1), E1 != E2,
                celebrated_on(E1,T1), celebrated_on(E2,T2), T1 < T2, not conditional(E2).
valid(E) :- sound(E), not repeated(E).
sacramental_character(R,K,E) :- valid(E), celebration(E,K,_,R), imprints(K).

% ---------- The fruit (Trent, sess. VII, can. 6, DH 1606) ----------------------
% Grace is given to those who "place no obstacle". The obstacle is interior:
% the fruit is composed on a claim, never on validity (SA8). For one who
% cannot place an obstacle the deposit states the fruit: infants are
% baptized for the remission of sins (Trent, sess. V, can. 4, DH 1514). The
% library composes "reborn, if validly baptized", resting on the presumption
% of intention; it never enters a state of grace (SA9). Infancy: under seven
% (c. 97 §2), or habitually without reason (c. 99).
fruit_on_the_claims(R,E) :- valid(E), celebration(E,_,_,R), interior(R,E,no_obstacle).
infant_at(R,E) :- celebration(E,baptism,_,R), age_at(R,E,Y), Y < 7.
infant_at(R,E) :- celebration(E,baptism,_,R), interior(R,E,reason(habitually_lacking)).
reborn_on_the_deposit(R,E) :- valid(E), celebration(E,baptism,_,R), infant_at(R,E).

% ---------- Christ's presence (Trent, sess. XIII, DH 1636-1654) ----------------
% A valid consecration makes Christ present under the species, the whole
% Christ, truly, really and substantially (can. 1, DH 1651), under every
% part when separated (can. 3, DH 1653), and he remains in the hosts kept
% after the celebration (can. 4, DH 1654). The presence is computed from the
% consecration, never from the receiver.
consecrated(H)  :- host_of(E,H), valid(E), celebration(E,eucharist,_,_).
consecrated(H2) :- fragment_of(H2,H), consecrated(H).
present(X,H,sacramental) :- consecrated(H), incarnate(X), not species_ceased(H).
violation(presence_only_in_use(H)) :- presence_requires(use), consecrated(H), reserved(H).
violation(presence_only_as_sign(H)) :- presence_as(sign), consecrated(H).

% ---------- One sacrifice in many times (Trent, sess. XXII, DH 1740-1754) -------
% "Una enim eademque est hostia, idem nunc offerens sacerdotum ministerio, qui
% se ipsum tunc in cruce obtulit, sola offerendi ratione diversa" (ch. 2,
% DH 1743). A Mass is an event of the order with its own date, joined to the
% one passion; the Last Supper is joined to it before it (ch. 1, DH 1740). A
% join, not an order edge: no second passion. Refused from the canons' date:
% a second immolation (can. 4, DH 1754) and a bare commemoration (can. 3,
% DH 1753) (TTC-NOVISSIMA OS).
canons_on_the_sacrifice :- sacrifice_canons(S), in_force(S), eff_tier(S,1).
info(one_sacrifice(M))   :- same_sacrifice(M,passion).
violation(second_immolation(M))  :- repeats(M,passion), canons_on_the_sacrifice.
violation(bare_commemoration(M)) :- commemoration_only(M), canons_on_the_sacrifice.

% ---------- Reports, for the celebrations a case records ------------------------
% The canons report their own acts (absolution, the form of marriage).
info(sacrament(E,K,valid))      :- celebrated(E,K,_,_), valid(E).
info(sacrament(E,K,invalid(C))) :- celebrated(E,K,_,_), unmet(E,C).
info(sacrament(E,K,null_repetition)) :- celebrated(E,K,_,_), repeated(E).
info(character_imprinted(R,K))  :- sacramental_character(R,K,E), celebrated(E,_,_,_).
info(fruit_on_the_claims(R,E))  :- fruit_on_the_claims(R,E).
info(reborn_on_the_deposit(R,E)) :- reborn_on_the_deposit(R,E).
info(present(X,H,sacramental))  :- present(X,H,sacramental), consecrated(H).
```
