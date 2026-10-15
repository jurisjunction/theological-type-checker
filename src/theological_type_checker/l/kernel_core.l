layer kernel

-- Sorts first used in this layer (TTC-L, TY): closed, then open

sort presence_mode {natural, sacramental, immensity, circumscriptive, definitive}
  means "a mode of presence: the deposit's and Thomas's"

sort nature {hum, div}
  means "a nature in which an act or a change is said"

sort act
  means "an act or event a case records: a celebration, a decree, a marriage, a delict"

sort category
  means "a constant from a short list, the guide's or the rules'"

sort claim
  means "a claim or argument, by its name"

sort entity
  means "an individual or thing a fact names: a person, a creature, an event"

sort event
  means "an event in the order of time"

sort place
  means "a place"

sort predicate
  means "a predicate of the kernel's predication"

sort relation
  means "a kind of relation"

sort school
  means "a school, or its reading of a divine attribute"

sort sentence
  means "a sentence of the kernel's predication"

sort term
  means "a term of a sentence"

```clingo
% ===================================================================
%  The kernel: what every school needs to state its disagreements, and
%  the deposit's own rules. Datalog with stratified negation; clingo 5.x.
%  The Grammar of the Icon, one theory among others, is in icon_theory.lp;
%  nothing here names its predicates (tests/test_suite.py checks this).
%
%  Facts in, verdicts out. Every check emits one of:
%    violation/1  the facts break an axiom
%    theorem/1    a result the axioms force
%    verdict/2    a classification (bond validity, predication typing)
%    info/1       noted, not an error
%  Axiom labels (A0-A11) match the Core Edition doc. See docs/layers.md.
% ===================================================================

```

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot absorbed(X: entity)
  means "absorbed(X): X's humanity said absorbed into the divinity (Eutyches)"
  say "the humanity of {X} is said absorbed into the divinity"

slot acton(X: entity, Y: entity)
  means "acton(X, Y): X acts on the thing Y (relation d)"
  say "{X} acts on {Y}"

slot allowed(R: school, K: category)
  means "allowed(R, K): the reading R of simplicity admits distinctions of kind K in God"
  say "on the reading {R}, simplicity admits distinctions of the kind {K} in God"

slot angel(X: entity)
  means "angel(X): X is an angel, a spiritual created person (DH 800)"
  say "{X} is an angel"

slot being(P: entity, X: entity)
  means "being(P, X): a claim that P gives X its being; the kernel derives it from God for every creature (A1)"
  say "{P} gives {X} its being"

slot bodily(M: presence_mode)
  means "bodily(M): a mode of presence that is bodily (natural, sacramental)"
  say "presence in the mode {M} is bodily"

slot changes_in(X: entity, K: nature)
  means "changes_in(X, K): a change said of X in nature K (hum or div)"
  say "{X} changes in the {K} nature"

slot claims(C: claim, P: predicate, X: entity, Y: entity, R: relation)
  means "claims(C, P, X, Y, R): claim C that X is P (receptive or donative) toward Y in relation R"
  say "{C} claims {X} is {P} toward {Y} in the relation {R}"

slot conjoined(Y: entity, X: entity)
  means "conjoined(Y, X): Y joined to X as another subject (Nestorius)"
  say "{Y} is joined to {X} as another subject"

slot created_person(X: entity)
  means "created_person(X): X is a created person, human or angelic"
  say "{X} is a created person"

slot denies(X: entity, P: category)
  means "denies(X, P): a claim that X lacks P (a human will, a human operation)"
  say "{X} is claimed to lack {P}"

slot denies_image(X: entity, R: category)
  means "denies_image(X, R): a claim denying X the image of God, for the reason R"
  say "{X} is denied the image of God, for {R}"

slot descends_from(P: entity, Adam: entity)
  means "descends_from(P, adam): P descends from Adam by generation"
  say "{P} descends from {Adam} by generation"

slot distinguishes(C: claim, P: predicate, A: entity, B: entity)
  means "distinguishes(C, P, A, B): claim C that the predicate P distinguishes A from B"
  say "{C} claims {P} distinguishes {A} from {B}"

slot divine(X: entity)
  means "divine(X): X is a divine person"
  say "{X} is a divine person"

slot gen(A: act, Source: entity, Term: entity)
  means "gen(A, Source, Term): Source contributes to the origin of Term in the act A"
  say "in {A}, {Source} contributes to the origin of {Term}"

slot god(G: entity)
  means "god(G): G is God"
  say "{G} is God"

slot immutability(R: school)
  means "immutability(R): God's immutability, as R reads it"
  say "God's immutability, as {R} reads it"

slot in_nature(A: act, K: nature)
  means "in_nature(A, K): the nature K (hum or div) in which the act A is placed"
  say "the act {A} is placed in the {K} nature"

slot inanimate(X: entity)
  means "inanimate(X): a creature that merely is"
  say "{X} merely is"

slot incarnate(X: entity)
  means "incarnate(X): X is the Son incarnate: divine, of a human nature"
  say "{X} is the Son incarnate"

slot lacks(X: entity, P: category)
  means "lacks(X, P): a claim that X lacks P (a rational soul)"
  say "{X} is claimed to lack {P}"

slot less(X: entity, Y: entity)
  means "less(X, Y): a claim that X ranks below Y"
  say "{X} is claimed to rank below {Y}"

slot next(E1: event, E2: event)
  means "next(E1, E2): E2 follows E1 in the order of events"
  say "{E2} follows {E1}"

slot organism(X: entity)
  means "organism(X): a living creature"
  say "{X} is a living creature"

slot pred_nature(P: predicate, K: nature)
  means "pred_nature(P, K): the predicate P belongs to nature K"
  say "{P} is said of the {K} nature"

slot presence_mode(M: presence_mode)
  means "presence_mode(M): a mode of presence known (the kernel's, a library's)"
  say "{M} is a mode of presence"

slot present(X: entity, Place: place, Mode: presence_mode)
  means "present(X, Place, Mode): a presence, typed by mode"
  say "{X} is present in {Place}, in the mode {Mode}"

slot qualified(S: sentence)
  means "qualified(S): the sentence S carries its qualification (as man)"
  say "the sentence {S} carries its qualification"

slot reltype(R: relation)
  means "reltype(R): a kind of relation the kernel knows"
  say "{R} is a kind of relation the kernel knows"

slot retype(X: entity, Y: entity)
  means "retype(X, Y): the edge from X to Y retyped (the rescue stress test)"
  say "the edge from {X} to {Y} is retyped"

slot says_unary(C: claim, P: predicate, X: entity)
  means "says_unary(C, P, X): claim C says P of X alone"
  say "{C} says {P} of {X} alone"

slot sentence(S: sentence, T: term, P: predicate)
  means "sentence(S, T, P): the sentence S predicates P of the term T"
  say "the sentence {S} says {P} of {T}"

slot simplicity(R: school)
  means "simplicity(R): God's simplicity, as R reads it"
  say "God's simplicity, as {R} reads it"

slot sort(X: entity, S: category)
  means "sort(X, S): X typed of sort S"
  say "{X} is typed of the sort {S}"

slot term_sort(T: term, K: category)
  means "term_sort(T, S): the term T names a suppositum or a nature"
  say "the term {T} names {K}"

slot unary_name(P: predicate)
  means "unary_name(P): a predicate said of persons one at a time"
  say "{P} is said of persons one at a time"

slot unsafe_unqualified(P: predicate)
  means "unsafe_unqualified(P): the predicate P needs a qualification when said of Christ"
  say "{P} needs a qualification when said of Christ"

```clingo

% ---------- Sorts --------------------------------------------------
person(X)       :- divine(X).
person(X)       :- created_person(X).
created_person(X) :- angel(X).          % angels: spiritual creatures (DH 800), personal (CCC 330)
human(X)        :- created_person(X), not angel(X).
creature(X)     :- created_person(X).
creature(X)     :- organism(X).
creature(X)     :- inanimate(X).
human_nature(X) :- human(X).
human_nature(X) :- incarnate(X), not absorbed(X).

% ---------- The Incarnation (deposit; TTC-CREED) -------------------------
% One and the same Son, in two natures, without confusion, change, division
% or separation (Chalcedon, DH 301-302). incarnate/1 names the person; the
% union is in the person (ST III q.2 aa.2-3), so the incarnate is divine.
divine(X) :- incarnate(X).                 % and so a person (above)
% The only-begotten Son was made incarnate (Lateran IV, DH 801), and the
% creeds confess three persons (DH 75, 800). Where a model gives the Trinity
% (its Son's generation is named begetting, as in the kernel's fixtures),
% the incarnate is one of the three, and the Son.
trinity_given :- gen(begetting,F,S), divine(F), divine(S).
in_trinity(X) :- gen(_,X,Y), divine(X), divine(Y).
in_trinity(Y) :- gen(_,X,Y), divine(X), divine(Y).
violation(fourth_divine_person(X))   :- incarnate(X), trinity_given, not in_trinity(X).
violation(incarnate_not_the_son(X))  :- incarnate(X), trinity_given, in_trinity(X), not gen(begetting,_,X).
% Typed by nature. What is said of the person is said by a nature (div or
% hum, the natures of T5): his birth of Mary, growth and passion are his in
% the human nature (DH 422, 432); none of it is said of a person without
% that nature.
has_nature(X,div) :- divine(X).
has_nature(X,hum) :- human_nature(X).
said_in(Z,K) :- gen(A,_,Z), in_nature(A,K).
said_in(X,K) :- changes_in(X,K).
violation(nature_not_had(X,K)) :- said_in(X,K), not has_nature(X,K).
changes(X) :- changes_in(X,div).                          % change in the divine nature is change in God
% Two births (Constantinople II, can. 2, DH 422): in the human nature the
% Son is born of Mary, who is Mother of God (Ephesus, DH 251); that birth
% gives him no second principle (the grain, A3, below).
orig_hum(P,Z) :- o_edge(P,Z,A), incarnate(Z), in_nature(A,hum).
info(mother_of_god(M,Z)) :- orig_hum(M,Z).
% Two natures, a rational soul, two natural wills and operations
% (Chalcedon, DH 301-302; Constantinople III, DH 556-557). That the human
% nature operates is a runtime's slot (schools.lp, classical); on a runtime
% that grants it nothing, the incarnate has one operation.
rational_soul(X) :- incarnate(X), not lacks(X,rational_soul).
wills(X,hum)     :- operates(X,hum), rational_soul(X), not denies(X,human_will).
violation(one_nature(X))      :- incarnate(X), not human_nature(X).         % Eutyches; DH 302
violation(no_rational_soul(X)) :- incarnate(X), lacks(X,rational_soul).     % Apollinaris; DH 301
violation(one_operation(X))   :- incarnate(X), not operates(X,hum).         % DH 557
violation(one_operation(X))   :- incarnate(X), denies(X,human_operation).
violation(one_will(X))        :- incarnate(X), not wills(X,hum).            % DH 556
% Not two persons joined (Ephesus, DH 250-251; Chalcedon, DH 302).
violation(two_persons_in_christ(Y,X)) :- conjoined(Y,X), person(Y), person(X), Y != X.
% "Like us in all things but sin" (Chalcedon, DH 301; Heb 4:15). Of this one
% person the deposit states the interior; the libraries read it here and
% never compute it (TTC-CHRIST CH2).
without_sin(X) :- incarnate(X).

% ---------- Presence (deposit; TTC-CHRIST) --------------------------------
% Presence is typed by mode: present(X, Place, Mode). God is immense (Lateran
% IV, DH 800; Vatican I, DH 3001): present by immensity, contained by no
% place. Christ sits at the right hand of the Father "according to the
% natural mode of existing", and is sacramentally present "in many other
% places"; Trent finds "no repugnance in this" (sess. XIII, ch. 1, DH 1636).
% So no rule here compares presences of different modes. A bodily mode is
% said of a person by the human nature (T5). A place is whatever a case
% names: the kernel holds no theory of space.
presence_mode(natural). presence_mode(sacramental). presence_mode(immensity).
bodily(natural). bodily(sacramental).
violation(untyped_presence(X,L,M)) :- present(X,L,M), not presence_mode(M).
said_in(X,hum) :- present(X,_,M), bodily(M), person(X).
violation(immensity_denied(X,L,M)) :- present(X,L,M), god(X), M != immensity.
violation(immensity_denied(X,L,M)) :- present(X,L,M), divine(X), M != immensity, not bodily(M).

% ---------- The economy (deposit; TTC-CREED) ------------------------------
% The creeds tell an order of events (next/2): he died, then rose, once for
% all. The order has no cycle; it need not be a line (a tree or a DAG is an
% order too). How causes stand to time is not the deposit's: a theory of time
% is a part (schools.lp, causes_precede).
before(E1,E2) :- next(E1,E2).
before(E1,E3) :- before(E1,E2), next(E2,E3).
violation(economy_out_of_order(E)) :- before(E,E).
% Original sin is transmitted to all by propagation, not by imitation
% (Trent, sess. V, can. 3, DH 1513). Of origin only: nothing here is a
% person's present state (rule 3). Why Christ is free is a reading's slot
% (not_by_propagation/1, preserved_from_os/1; kernel_world.lp).
propagated_from_adam(P)   :- descends_from(P,adam), not not_by_propagation(P).
contracts_original_sin(P) :- propagated_from_adam(P), not preserved_from_os(P).
violation(sin_in_christ(X))          :- incarnate(X), contracts_original_sin(X).          % DH 301
violation(stain_on_the_preserved(P)) :- contracts_original_sin(P), preserved_from_os(P).  % DH 2803

% ---------- A0  Fixed relation inventory ---------------------------
% Base relations: being/2 (E), orig_cr/2 (O), orig_div/2 (O in God, the
% primary analogate), acton/2 (D). A theory may declare more, with a warrant
% (the Icon declares N). rel/3 is their typed union. orig/2 is the
% shared FORM of origination, fed by each sort only through an analogy
% bridge (kernel_analogy.lp).
reltype(e). reltype(o). reltype(o_div). reltype(d).
rel(e,X,Y)     :- being(X,Y).
rel(o,X,Y)     :- orig_cr(X,Y), licensed(origination,cr).
rel(o_div,X,Y) :- orig_div(X,Y), licensed(origination,div).
rel(d,X,Y)     :- acton(X,Y).
rel(fresh,X,Y) :- retype(X,Y).                % only used by the rescue stress test
violation(unknown_reltype(R)) :- rel(R,_,_), not reltype(R).

% ---------- A1  Being is received from God alone -------------------
being(G,X) :- god(G), creature(X), licensed(creation,cr).   % received being: the root of analogy
% That creatures act (agere sequitur esse) is a runtime's: schools.lp, classical.
violation(being_from_non_god(P,X)) :- being(P,X), not god(P).

% ---------- A2  Poles are positions in typed binary relations -------
rec(R,X,Y) :- rel(R,Y,X).
don(R,X,Y) :- rel(R,X,Y).
% There is no unary pole predicate. unary/2 exists only to test what a
% unary reading would say, and to prove it says nothing (T1).
unary(receptive,X) :- rec(_,X,_).
unary(donative,X)  :- don(_,X,_).
unary(donative,X)  :- acts(X).
unary_name(receptive;donative).
persons_n(N) :- N = #count{ X : created_person(X) }.
holds_n(P,N) :- unary_name(P), N = #count{ X : unary(P,X), created_person(X) }.
theorem(vacuous_over_persons(P)) :- holds_n(P,N), persons_n(N), N > 0.
violation(unary_pole(C,P)) :- says_unary(C,P,_).
violation(fails_to_distinguish(C,P,A,B)) :- distinguishes(C,P,A,B), unary(P,A), unary(P,B).
true_claim(C) :- claims(C,receptive,X,Y,R), rec(R,X,Y).
true_claim(C) :- claims(C,donative,X,Y,R),  don(R,X,Y).
violation(false_claim(C)) :- claims(C,_,_,_,_), not true_claim(C).

% ---------- A4 / A4a / A3  Origination, contraction, the grain -------
% gen(Act, Source, Term): Source contributes to the origin of Term in Act.
act(A) :- gen(A,_,_).
contributors(A,N) :- act(A), N = #count{ X : gen(A,X,_) }.

% Two sources are one principle only by a license (contractible/3). The kernel
% grants none. In God a runtime grants it: the Latin runtimes by one spirative
% power (schools.lp, one_power); the switch no_divine_contraction withholds it
% (Photius). A theory may add licenses of its own for creatures.

o_edge(X,Z,A)         :- gen(A,X,Z), contributors(A,1).
o_edge(pair(X,Y),Z,A) :- gen(A,X,Z), gen(A,Y,Z), X < Y, contractible(A,X,Y).
o_edge(X,Z,A)         :- gen(A,X,Z), gen(A,Y,Z), X != Y, not contractible(A,X,Y).
% sorted relations: eternal procession in God, temporal generation in creatures
orig_div(P,Z) :- o_edge(P,Z,A), not retype(P,Z), divine(Z), not in_nature(A,hum).   % a birth in the human nature is not a procession
orig_cr(P,Z)  :- o_edge(P,Z,_), not retype(P,Z), not divine(Z).
% the shared form, admitted per sort only through the 'origination' bridge
orig(P,Z) :- orig_div(P,Z), licensed(origination,div).
orig(P,Z) :- orig_cr(P,Z),  licensed(origination,cr).
info(principle_of(Z,P)) :- orig(P,Z).

% A3  the grain. Being has one giver on both sides: only God creates (ST I
% q.45 a.5; Th. 24), so two givers are impossible, not wrong. A divine person
% has one principle of origin: Lyons II, the Spirit proceeds "not from two
% principles" (DH 850). Both are the deposit's, checked directly, through no
% analogy. What unity of principle means among creatures is a theory's claim.
violation(incoherent(grain(e,Z,P,Q)))  :- being(P,Z), being(Q,Z), P < Q.
violation(incoherent(grain(o,Z,P,Q)))  :- orig(P,Z), orig(Q,Z), P < Q, divine(Z).

% origin is acyclic; principles have members
principle(P) :- orig(P,_).
is_pair(pair(X,Y))  :- principle(pair(X,Y)).
member(X,pair(X,Y)) :- is_pair(pair(X,Y)).
member(Y,pair(X,Y)) :- is_pair(pair(X,Y)).
member(X,X)         :- principle(X), not is_pair(X).
from(Z,X) :- orig(P,Z), member(X,P).
anc(Z,X)  :- from(Z,X).
anc(Z,X)  :- anc(Z,Y), from(Y,X).
violation(origin_cycle(X)) :- anc(X,X), ind_sort(X,S), licensed(acyclicity,S).
theorem(both_positions(X)) :- from(X,_), member(X,P), orig(P,_).
% the monarchy: a divine person who originates and is from no one is the principle
% without principle (Florence, DH 1331; PCPCU 1995: "arche anarchos")
theorem(principle_without_principle(X)) :- divine(X), from(_,X), not from(X,_).

% ---------- Distinction of the persons (no default) ------------------
% The axioms do not say what makes two divine persons distinct. A switch says it:
% opposed relations of origin only, or also the distinct properties of origin
% (unbegotten, begotten, proceeding: Gregory Nazianzen, Or. 31.8-9).
opposed(X,Y) :- from(X,Y).
originated(X) :- gen(_,_,X).
origin_mode(X,A) :- gen(A,_,X), divine(X), not in_nature(A,hum).
origin_mode(X,unoriginate) :- divine(X), not originated(X).
distinct_by_mode(X,Y) :- origin_mode(X,A), origin_mode(Y,B), A != B.
violation(persons_not_distinguished(X,Y)) :- distinction(opposition), divine(X), divine(Y), X < Y,
                                             not opposed(X,Y), not opposed(Y,X).
violation(persons_not_distinguished(X,Y)) :- distinction(mode), divine(X), divine(Y), X < Y,
                                             not opposed(X,Y), not opposed(Y,X), not distinct_by_mode(X,Y).

% ---------- Finitude -------------------------------------------------
finite(X) :- creature(X).

% ---------- A10  Image and dignity are not graded --------------------
image(X) :- human(X).                   % GS 12; the deposit is silent on angels (cf. ST I q.93 a.3)
image(X) :- incarnate(X).
violation(image_denied(X,R)) :- denies_image(X,R), image(X).
consubstantial(X,Y) :- divine(X), divine(Y), X != Y.
equal_dignity(X,Y)  :- human(X), human(Y), X != Y.          % GS 29: human persons
violation(receiver_ranked_lower(X,Y)) :- less(X,Y), consubstantial(X,Y).
violation(receiver_ranked_lower(X,Y)) :- less(X,Y), equal_dignity(X,Y).

% ---------- The attributes as defined (deposit) ----------------------
% Lateran IV (DH 800, 804); Vatican I, Dei Filius (DH 3001-3002, 3025). The
% schools read simplicity more strictly (icon_metaphysics.lp); the definition
% excludes only composition of parts.
simplicity(defined).                                   % "simplex omnino"
immutability(defined).                                 % "incommutabilis"
contingent(X) :- creature(X).                          % created "liberrimo consilio" (DH 3002, 3025)
allowed(defined,(rational;formal;energetic)).
violation(composition_in_god(X,Y,K,R)) :- simplicity(R), god_distinction(X,Y,K), not allowed(R,K).
violation(change_in_god(G))  :- immutability(_), changes(G).
violation(modal_collapse(X)) :- necessary(X), contingent(X).

% ---------- A11  Sorted predicates ------------------------------------
violation(sort_clash(X,S1,S2)) :- sort(X,S1), sort(X,S2), S1 < S2.

% communicatio idiomatum as typing (T5; ST III q.16)
% A person's name takes a predicate only of a nature the person has: the
% Father was not born of Mary (TTC-CREED; ST III q.16 a.1). A term the
% kernel does not know as a person (god, or a fixture's name) is typed by
% its sort alone.
nature_known(T) :- divine(T).
nature_known(T) :- created_person(T).
nature_missing(S) :- sentence(S,T,P), term_sort(T,suppositum), pred_nature(P,K), nature_known(T),
                     not has_nature(T,K).
welltyped(S) :- sentence(S,T,_), term_sort(T,suppositum), not nature_missing(S).
welltyped(S) :- sentence(S,T,P), term_sort(T,nature(K)), pred_nature(P,K).
needs_q(S)   :- sentence(S,T,P), welltyped(S), term_sort(T,suppositum),
                unsafe_unqualified(P), not qualified(S).
verdict(S,ill_typed)           :- sentence(S,_,_), not welltyped(S).
verdict(S,needs_qualification) :- needs_q(S).
verdict(S,well_typed)          :- welltyped(S), not needs_q(S).

#show violation/1.
#show theorem/1.
#show verdict/2.
#show info/1.
```
