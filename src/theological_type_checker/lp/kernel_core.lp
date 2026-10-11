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

% ---------- Sorts --------------------------------------------------
person(X)       :- divine(X).
person(X)       :- created_person(X).
person(X)       :- incarnate(X).
created_person(X) :- angel(X).          % angels: spiritual creatures (DH 800), personal (CCC 330)
human(X)        :- created_person(X), not angel(X).
creature(X)     :- created_person(X).
creature(X)     :- organism(X).
creature(X)     :- inanimate(X).
human_nature(X) :- human(X).
human_nature(X) :- incarnate(X).

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

% ---------- A1  Being is received from God alone; creatures act -----
being(G,X) :- god(G), creature(X), licensed(creation,cr).   % received being: the root of analogy
acts(X)    :- creature(X).
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
one_power(Y,X) :- one_power(X,Y).

% Two sources are one principle only by a license. In God the license is one
% power of Father and Son (the Latin account of Lyons II's "one principle":
% ST I q.36 a.4); the switch no_divine_contraction withholds it (Photius).
% A theory may add licenses of its own for creatures.
divine_contraction(identity_of_power) :- not no_divine_contraction.
contractible(A,X,Y) :- divine_contraction(identity_of_power), gen(A,X,_), gen(A,Y,_), X != Y,
                       one_power(X,Y).

o_edge(X,Z,A)         :- gen(A,X,Z), contributors(A,1).
o_edge(pair(X,Y),Z,A) :- gen(A,X,Z), gen(A,Y,Z), X < Y, contractible(A,X,Y).
o_edge(X,Z,A)         :- gen(A,X,Z), gen(A,Y,Z), X != Y, not contractible(A,X,Y).
% sorted relations: eternal procession in God, temporal generation in creatures
orig_div(P,Z) :- o_edge(P,Z,_), not retype(P,Z), divine(Z).
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
origin_mode(X,A) :- gen(A,_,X), divine(X).
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

% ---------- A11  Sorted predicates ------------------------------------
violation(sort_clash(X,S1,S2)) :- sort(X,S1), sort(X,S2), S1 < S2.

% communicatio idiomatum as typing (T5; ST III q.16)
welltyped(S) :- sentence(S,T,_), term_sort(T,suppositum).
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
