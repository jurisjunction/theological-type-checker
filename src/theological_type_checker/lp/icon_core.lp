% ===================================================================
%  The Grammar of the Icon: core theory
%  Datalog with stratified negation; runs on clingo 5.x.
%
%  Facts in, verdicts out. Every check emits one of:
%    violation/1  the facts break an axiom
%    theorem/1    a result the axioms force
%    verdict/2    a classification (bond validity, predication typing)
%    info/1       noted, not an error
%  Axiom labels (A0-A11) match the Core Edition doc.
% ===================================================================

% ---------- Policy switches (scenarios may override) --------------
closure_mode(act)   :- not closure_mode(bond).            % A4a
license_policy(two) :- not license_policy(circuit_only).  % A4
gen_policy(none)    :- not gen_policy(unbanded), not gen_policy(by_level),
                       not gen_policy(by_kind).           % dropped clause, for testing

% ---------- Sorts --------------------------------------------------
person(X)       :- divine(X).
person(X)       :- created_person(X).
person(X)       :- incarnate(X).
creature(X)     :- created_person(X).
creature(X)     :- organism(X).
human_nature(X) :- created_person(X).
human_nature(X) :- incarnate(X).

% ---------- A0  Fixed relation inventory ---------------------------
% Base relations: being/2 (E), orig_cr/2 (O), orig_div/2 (O in God, the
% primary analogate), acton/2 (D), nupt/2 (N), side_by_side/3 (S).
% rel/3 is their typed union. orig/2 is the shared FORM of origination,
% fed by each sort only through an analogy bridge (icon_analogy.lp).
reltype(e). reltype(o). reltype(o_div). reltype(d). reltype(n).
rel(e,X,Y)     :- being(X,Y).
rel(o,X,Y)     :- orig_cr(X,Y), licensed(origination,cr).
rel(o_div,X,Y) :- orig_div(X,Y), licensed(origination,div).
rel(d,X,Y)     :- acton(X,Y).
rel(n,X,Y)     :- nupt(X,Y).
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
unary(bridal,X)    :- nupt(_,X).
unary(called_bridal,X) :- called_bridal(X).
unary_name(receptive;donative;bridal;called_bridal).
persons_n(N) :- N = #count{ X : created_person(X) }.
holds_n(P,N) :- unary_name(P), N = #count{ X : unary(P,X), created_person(X) }.
theorem(vacuous_over_persons(P)) :- holds_n(P,N), persons_n(N), N > 0.
violation(unary_pole(C,P)) :- says_unary(C,P,_).
violation(fails_to_distinguish(C,P,A,B)) :- distinguishes(C,P,A,B), unary(P,A), unary(P,B).
true_claim(C) :- claims(C,receptive,X,Y,R), rec(R,X,Y).
true_claim(C) :- claims(C,donative,X,Y,R),  don(R,X,Y).
violation(false_claim(C)) :- claims(C,_,_,_,_), not true_claim(C).

% ---------- A9  Bridal floor (MD 25) --------------------------------
% Default (conditional) reading: every person is CALLED to be the Bride,
% and is the Bride "in that he or she accepts" (MD 25), or while that
% acceptance is held in trust. The old universal reading ("every person IS
% bridal") is kept behind the switch a9_universal for comparison.
called_bridal(X) :- bridegroom(C), created_person(X).
nupt(C,X) :- bridegroom(C), created_person(X), a9_universal.
nupt(C,X) :- bridegroom(C), created_person(X), not a9_universal, welcomed(X,C).

% ---------- A5  Personal reception is act ----------------------------
needs_welcome(X,Y) :- created_person(X), nupt(Y,X).
vicarious_ok(C)    :- bridegroom(C).          % origin case: held in trust (baptism)
welcomed(X,Y) :- consent(X,Y).
welcomed(X,Y) :- held_for(_,X,Y), vicarious_ok(Y).
violation(reception_without_act(X,Y)) :- needs_welcome(X,Y), not welcomed(X,Y).
violation(consent_supplied(P,X,Y))    :- held_for(P,X,Y), not vicarious_ok(Y).
info(awaiting_ratification(X,Y))      :- held_for(_,X,Y), vicarious_ok(Y), not consent(X,Y).
violation(reception_typed_as_non_act(X,Y)) :- nonact_reception(X,Y), consent(X,Y).

% ---------- A6  A bond: two consents + capacity for its closing act --
valid_bond(X,Y) :- proposed_bond(X,Y), consent(X,Y), consent(Y,X),
                   capable_closing(X,Y), not impeded(X,Y).
nupt(X,Y) :- valid_bond(X,Y).
nupt(Y,X) :- valid_bond(X,Y).
verdict(bond(X,Y),valid)   :- valid_bond(X,Y).
verdict(bond(X,Y),invalid) :- proposed_bond(X,Y), not valid_bond(X,Y).
% Note: fertility appears in no rule above.

% ---------- A7  Motifs ----------------------------------------------
bond(X,Y) :- nupt(X,Y), nupt(Y,X).
counter_phase(X,Y) :- bond(X,Y), created_person(X), created_person(Y).
violation(motif_mismatch(A,X,Y)) :- performs(A,X,Y,close_circuit), not counter_phase(X,Y).
violation(ungrounded_counter_phase(X,Y)) :- claimed_counter_phase(X,Y), not bond(X,Y).

% ---------- A4 / A4a / A3  Origination, contraction, the grain -------
% gen(Act, Source, Term): Source contributes to the origin of Term in Act.
act(A) :- gen(A,_,_).
contributors(A,N) :- act(A), N = #count{ X : gen(A,X,_) }.
closed(A,X,Y) :- closed_in_act(A,X,Y).
closed(A,Y,X) :- closed_in_act(A,X,Y).
one_power(Y,X) :- one_power(X,Y).

circuit(A,X,Y) :- closure_mode(act),  gen(A,X,_), gen(A,Y,_), X != Y, closed(A,X,Y), bond(X,Y).
circuit(A,X,Y) :- closure_mode(bond), gen(A,X,_), gen(A,Y,_), X != Y, bond(X,Y).

% the contraction license is fixed per sort by the mode of the 'principle' bridge
contractible(A,X,Y) :- mode(principle,div,identity_of_power), gen(A,X,_), gen(A,Y,_), X != Y,
                       one_power(X,Y).
contractible(A,X,Y) :- mode(principle,cr,closed_circuit), circuit(A,X,Y), creature(X).
contractible(A,X,Y) :- mode(principle,div,closed_circuit), circuit(A,X,Y), divine(X).

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

% A3  the grain, typed by mode: a necessity in God, a norm for creatures
violation(norm_breach(grain(e,Z,P,Q))) :- being(P,Z), being(Q,Z), P < Q.
violation(incoherent(grain(o,Z,P,Q)))  :- orig(P,Z), orig(Q,Z), P < Q, ind_sort(Z,S),
                                          licensed(grain,S), mode(grain,S,necessity).
violation(norm_breach(grain(o,Z,P,Q))) :- orig(P,Z), orig(Q,Z), P < Q, ind_sort(Z,S),
                                          licensed(grain,S), mode(grain,S,norm).

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

% licenses never cross the Creator-creature line (A4, A11)
violation(nuptial_within_god(X,Y)) :- nupt(X,Y), divine(X), divine(Y).
violation(power_license_in_creatures(X,Y)) :- one_power(X,Y), creature(X), X < Y.

% the dropped clause "finite natures cannot generate alone", three readings
lone(A,X) :- gen(A,X,_), contributors(A,1), creature(X).
violation(lone_generation(A,X)) :- gen_policy(unbanded), lone(A,X).
violation(lone_generation(A,X)) :- gen_policy(by_level), lone(A,X), level(X,L), band(L).
violation(lone_generation(A,X)) :- gen_policy(by_kind),  lone(A,X), of_kind(X,K), obligate_sexual(K).

% ---------- A8  Finite totality is rivalrous ------------------------
finite(X) :- creature(X).
violation(rivalrous_total(X,Y1,Y2)) :- total(X,Y1), total(X,Y2), Y1 < Y2, finite(X).

% ---------- A10  Image and dignity are not graded --------------------
image(X) :- created_person(X).
image(X) :- incarnate(X).
violation(image_denied(X,R)) :- denies_image(X,R), image(X).
consubstantial(X,Y) :- divine(X), divine(Y), X != Y.
equal_dignity(X,Y)  :- created_person(X), created_person(Y), X != Y.
violation(receiver_ranked_lower(X,Y)) :- less(X,Y), consubstantial(X,Y).
violation(receiver_ranked_lower(X,Y)) :- less(X,Y), equal_dignity(X,Y).
% States of life: the gift of self is total in each (FC 16: two ways of living the
% one mystery of the covenant), so no state may be credited with a greater gift of
% self, and no person ranked by state. The objective excellence of virginity for the
% Kingdom (Trent, Sess. XXIV can. 10, DH 1810; FC 16) is another relation: the
% state's singular link with the Kingdom, not the measure of a person's gift.
violation(self_gift_ranked_by_state(V1,V2)) :- self_gift_measure(V1,M1), self_gift_measure(V2,M2), M1 < M2.

% ---------- A11  God outside the order; sorted predicates ------------
violation(god_inside_level_order(G)) :- level(G,_), god(G).
sort(grace,participation).                    % context (CCC 1997), not derived
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
