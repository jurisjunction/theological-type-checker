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

% @input absorbed/1 | absorbed(X): X's humanity said absorbed into the divinity (Eutyches)
% @input acton/2 | acton(X, Y): X acts on the thing Y (relation d)
% @input allowed/2 | allowed(R, K): the reading R of simplicity admits distinctions of kind K in God
% @input angel/1 | angel(X): X is an angel, a spiritual created person (DH 800)
% @input being/2 | being(P, X): a claim that P gives X its being; the kernel derives it from God for every creature (A1)
% @input bodily/1 | bodily(M): a mode of presence that is bodily (natural, sacramental)
% @input changes_in/2 | changes_in(X, K): a change said of X in nature K (hum or div)
% @input claims/5 | claims(C, P, X, Y, R): claim C that X is P (receptive or donative) toward Y in relation R
% @input conjoined/2 | conjoined(Y, X): Y joined to X as another subject (Nestorius)
% @input created_person/1 | created_person(X): X is a created person, human or angelic
% @input denies/2 | denies(X, P): a claim that X lacks P (a human will, a human operation)
% @input denies_image/2 | denies_image(X, R): a claim denying X the image of God, for the reason R
% @input descends_from/2 | descends_from(P, adam): P descends from Adam by generation
% @input distinguishes/4 | distinguishes(C, P, A, B): claim C that the predicate P distinguishes A from B
% @input divine/1 | divine(X): X is a divine person
% @input free_of_original_sin/1 | free_of_original_sin(X): a claim that X contracted no original sin
% @input gen/3 | gen(A, Source, Term): Source contributes to the origin of Term in the act A
% @input god/1 | god(G): G is God
% @input immutability/1 | immutability(R): God's immutability, as R reads it
% @input in_nature/2 | in_nature(A, K): the nature K (hum or div) in which the act A is placed
% @input inanimate/1 | inanimate(X): a creature that merely is
% @input incarnate/1 | incarnate(X): X is the Son incarnate: divine, of a human nature
% @input lacks/2 | lacks(X, P): a claim that X lacks P (a rational soul)
% @input less/2 | less(X, Y): a claim that X ranks below Y
% @input next/2 | next(E1, E2): E2 follows E1 in the order of events
% @input os_reserved/1 | os_reserved(X): X is not included in Trent's decree on original sin (sess. V, DH 1516)
% @input organism/1 | organism(X): a living creature
% @input pred_nature/2 | pred_nature(P, K): the predicate P belongs to nature K
% @input presence_mode/1 | presence_mode(M): a mode of presence known (the kernel's, a library's)
% @input present/3 | present(X, Place, Mode): a presence, typed by mode
% @input qualified/1 | qualified(S): the sentence S carries its qualification (as man)
% @input reltype/1 | reltype(R): a kind of relation the kernel knows
% @input retype/2 | retype(X, Y): the edge from X to Y retyped (the rescue stress test)
% @input says_unary/3 | says_unary(C, P, X): claim C says P of X alone
% @input sentence/3 | sentence(S, T, P): the sentence S predicates P of the term T
% @input simplicity/1 | simplicity(R): God's simplicity, as R reads it
% @input sort/2 | sort(X, S): X typed of sort S
% @input term_sort/2 | term_sort(T, S): the term T names a suppositum or a nature
% @input unary_name/1 | unary_name(P): a predicate said of persons one at a time
% @input unsafe_unqualified/1 | unsafe_unqualified(P): the predicate P needs a qualification when said of Christ

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
% The scope (TTC-DESCENT DS1): Adam "transfused ... into the whole human
% race" sin (can. 2, DH 1512), "into all by propagation", "in each one as
% his own" (can. 3, DH 1513). A claim that a human being contracted none is
% refused, save the incarnate (DH 301) and one the decree does not include
% (DH 1516: os_reserved/1, kernel_world.lp). A human being typed without
% descent, of whom nothing is claimed, stays silent (DS3).
violation(original_sin_denied(P)) :- free_of_original_sin(P), human(P), not incarnate(P),
                                     not preserved_from_os(P), not os_reserved(P).

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

% ---------- The last end and latria (deposit; TTC-LOCI) ----------------
% The blessed "vident divinam essentiam visione intuitiva et etiam faciali,
% nulla mediante creatura", and "ex tali visione et fruitione ... sunt vere
% beatae" (Benedictus Deus, DH 1000-1001); the world is made "ad Dei
% gloriam" (Dei Filius, can. 1.5, DH 3025). What is taken as the last end
% of the rational creature, and is not God, is refused.
violation(last_end_not_god(X)) :- last_end(X), not god(X), not divine(X).
% Images are given "honoratoriam ... adorationem", "non tamen ... ueram
% latrian, quae ... solam diuinam naturam decet", and "imaginis enim honor
% ad primitiuum transit" (Nicaea II, the horos, ACO II.3 p. 827; DH 601).
% Latria that terminates in what is not God is refused; honour that
% terminates in God, through an image or not, faults nothing. Both rules
% read what a library lowers (substitutio.lp), and neither decides a
% school question.
violation(latria_to_creature(P)) :- latria_to(P), not god(P), not divine(P).

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

% ---------- domains (L) ---------------------------------------------
in_sort(presence_mode,(natural;sacramental;immensity;circumscriptive;definitive)).
in_sort(nature,(hum;div)).
violation(outside_domain(bodily,1,M)) :- bodily(M), not in_sort(presence_mode,M).
violation(outside_domain(changes_in,2,K)) :- changes_in(_,K), not in_sort(nature,K).
violation(outside_domain(in_nature,2,K)) :- in_nature(_,K), not in_sort(nature,K).
violation(outside_domain(pred_nature,2,K)) :- pred_nature(_,K), not in_sort(nature,K).
violation(outside_domain(presence_mode,1,M)) :- presence_mode(M), not in_sort(presence_mode,M).
violation(outside_domain(present,3,Mode)) :- present(_,_,Mode), not in_sort(presence_mode,Mode).
