% ===================================================================
%  Stress tests. Each #program is either a candidate rule (a position
%  the paper claims to forbid, written as Datalog) or a policy switch.
%  A forbidden position "fails" when adding it produces a violation.
% ===================================================================

% ---------- Prohibitions, written as candidate rules ----------------
#program cand_receiver_lesser.          % "whoever receives is less than the giver"
less(X,Y) :- from(X,Y).

#program cand_receiver_lesser_nuptial.  % "receptivity ranks the receiver lower"
uses(icon).                             % the Grammar of the Icon
less(X,Y) :- rec(n,X,Y), created_person(X), created_person(Y).

#program cand_functionalism.            % image indexed to exercised reason
uses(icon).                             % the Grammar of the Icon
denies_image(X,no_exercised_reason(S)) :- stage(X,S), not exercises_reason(X,S).

#program cand_couple_completion.        % the unmarried as half an icon
uses(icon).                             % the Grammar of the Icon
denies_image(X,unmarried) :- human_nature(X), not married(X).

#program cand_magnitude.                % the gift of self measured by state of life
uses(icon).                             % the Grammar of the Icon
self_gift_measure(consecrated,2). self_gift_measure(married,1).

#program cand_diagram.                  % male-as-God / female-as-creature
uses(icon).                             % the Grammar of the Icon
says_unary(d1,receptive,woman).
distinguishes(d1,receptive,woman,man).
distinguishes(d2,donative,man,woman).

#program cand_weld.                     % intensity read as eros
uses(icon).                             % the Grammar of the Icon
claimed_counter_phase(X,Y) :- intense(X,Y).

#program cand_apex.                     % God as the top of the fractal
uses(icon).                             % the Grammar of the Icon
level(god,top).

#program cand_grace_stuff.              % grace typed as a quantity
uses(icon).                             % the Grammar of the Icon
sort(grace,quantity).

#program cand_passivity.                % personal reception typed as non-act
uses(icon).                             % the Grammar of the Icon
nonact_reception(X,Y) :- rec(n,X,Y), created_person(X).

#program soul_two_spouses.              % a finite soul given totally twice
uses(icon).                             % the Grammar of the Icon
total(soul1,rival).

% ---------- Policy switches -----------------------------------------
#program mode_bond.        closure_mode(bond). uses(icon).
#program circuit_only.     license_policy(circuit_only). uses(icon).
#program trinity_as_couple.             % rescue the Trinity with a nuptial circuit
uses(icon).                             % the Grammar of the Icon
nupt(father,son). nupt(son,father). closed_in_act(spiration,father,son).
#program gen_unbanded.     gen_policy(unbanded). uses(icon).
#program gen_by_level.     gen_policy(by_level). uses(icon).
#program gen_by_kind.      gen_policy(by_kind). uses(icon).

% ---------- Rescue device: can type-splitting always save the grain? -
% Answer-set (not pure Datalog): the solver may move any O-edge to a new
% relation type, and minimizes violations.
#program rescue_closed.
{ retype(P,Z) : o_edge(P,Z,_) }.
#minimize { 1,V : violation(V) }.

#program rescue_open.
reltype(fresh).
{ retype(P,Z) : o_edge(P,Z,_) }.
#minimize { 1,V : violation(V) }.

% ---------- Augustine's guard: is the family an image of the Trinity? -
% Search for a bijection {Father, Son, Spirit} -> {man, woman, child}
% that carries required O-edges onto O-edges of the family.
#program augustine.
god_o(father,son,begetting).
god_o(pair(father,son),spirit,spiration) :- not monopatrism.
god_o(father,spirit,spiration)           :- monopatrism.
fam_o(pair(man,woman),child,begetting).
src(father;son;spirit). tgt(man;woman;child).
1 { f(S,T) : tgt(T) } 1 :- src(S).
:- f(S1,T), f(S2,T), S1 < S2.
img(X,Y) :- f(X,Y).
img(pair(A,B),pair(C,D)) :- god_o(pair(A,B),_,_), f(A,C), f(B,D), C < D.
img(pair(A,B),pair(D,C)) :- god_o(pair(A,B),_,_), f(A,C), f(B,D), D < C.
kind_ok(K,K)   :- god_o(_,_,K).
kind_ok(K1,K2) :- ignore_kinds, god_o(_,_,K1), fam_o(_,_,K2).
preserved(P,Z) :- god_o(P,Z,K1), img(P,P2), f(Z,Z2), fam_o(P2,Z2,K2), kind_ok(K1,K2).
:- required(P,Z), not preserved(P,Z).
#show f/2.

% ---------- Lateran IV: similarity, and a greater dissimilarity -------
% Map the divine persons injectively into a creaturely model. Similarity
% at the supertype ignores kinds; licensed similarity needs a kind bridge
% between the specific relations. Features: each divine edge, and each
% divine person's subsistence. Lateran IV requires (a) some licensed
% similarity and (b) a remainder: no map keeps every feature.
#program lateran.
d_ind(father;son;spirit). d_person(father;son;spirit).
d_edge(father,son,begetting).
d_edge(pair(father,son),spirit,spiration) :- not monopatrism.
d_edge(father,spirit,spiration)           :- monopatrism.
kind_bridge(begetting,word_conception).   % ST I q.27 a.2: procession after the manner of intellect
kind_bridge(spiration,love_procession).   % ST I q.27 a.4: after the manner of will
kind_bridge(begetting,procreation).       % the name "begotten" is taken from generation
1 { f(D,C) : c_ind(C) } 1 :- d_ind(D).
:- f(D1,C), f(D2,C), D1 < D2.
img(X,Y) :- f(X,Y).
img(pair(A,B),pair(C,D)) :- d_edge(pair(A,B),_,_), f(A,C), f(B,D), C < D.
img(pair(A,B),pair(D,C)) :- d_edge(pair(A,B),_,_), f(A,C), f(B,D), D < C.
super(P,Z)         :- d_edge(P,Z,_), img(P,P2), f(Z,Z2), c_edge(P2,Z2,_).
licensed_edge(P,Z) :- d_edge(P,Z,K1), img(P,P2), f(Z,Z2), c_edge(P2,Z2,K2), kind_bridge(K1,K2).
subsists(D)        :- d_person(D), f(D,C), c_person(C).
feature(edge(P,Z)) :- d_edge(P,Z,_).
feature(person(D)) :- d_person(D).
kept(edge(P,Z))    :- licensed_edge(P,Z).
kept(person(D))    :- subsists(D).
n_super(N)    :- N = #count{ P,Z : super(P,Z) }.
n_licensed(N) :- N = #count{ P,Z : licensed_edge(P,Z) }.
n_kept(N)     :- N = #count{ X : kept(X) }.
n_feat(N)     :- N = #count{ X : feature(X) }.
lost(X)       :- feature(X), not kept(X).
violation(lateran_iv(no_dissimilarity)) :- n_kept(N), n_feat(N).
#maximize { 1@3,X : kept(X) }.
#maximize { 1@2,P,Z : licensed_edge(P,Z) }.
#maximize { 1@1,P,Z : super(P,Z) }.
#show f/2. #show n_super/1. #show n_licensed/1. #show n_kept/1. #show n_feat/1. #show lost/1.

#program lateran_family.
c_ind(man;woman;child). c_person(man;woman;child).
c_edge(pair(man,woman),child,procreation).

#program lateran_mind.            % Augustine, De Trinitate IX-X; ST I q.27
c_ind(mens;verbum;amor).
c_edge(mens,verbum,word_conception). c_edge(pair(mens,verbum),amor,love_procession).

#program lateran_resident.        % the mind's acts treated as persons: "a resident trinity"
c_person(mens;verbum;amor).

#program lateran_mind_palamas.    % Palamas, Capita 150, 36-37: love of the mind for its word,
c_ind(mens;verbum;amor).          % from the mind, resting in the word (cf. Flogaus, SVTQ 42, 1998)
c_edge(mens,verbum,word_conception). c_edge(mens,amor,love_procession).
rests_in(amor,verbum).

#program lateran_mind_memory.     % Augustine, De Trinitate X.11.17-12.19: memory, understanding, will
c_ind(memoria;intelligentia;voluntas).
c_edge(memoria,intelligentia,word_conception). c_edge(pair(intelligentia,memoria),voluntas,love_procession).

#program lateran_adam.            % Gregory Nazianzen, Or. 31.11: Adam a creature, Eve "a fragment",
c_ind(adam;eve;seth).             % Seth "the begotten of both"; said of consubstantiality only
c_person(adam;eve;seth).
c_edge(adam,eve,formation). c_edge(pair(adam,eve),seth,procreation).

#program flat_weight. flat_weight.        % ablation: one vote per independent source, reaffirmations as citations

% ---------- Analogy stress switches -------------------------------------
#program unlicense_origination_div. unlicensed(origination,div).
#program drop_principle_bridge.     % the theory without its analogy of one principle
uses(icon). drop_bridge(principle).
#program cand_projection.           bridge(origination,cr,div).
#program cand_finite_god.           finite(X) :- person(X).
#program cand_bridge_no_mode.       bridge(beauty,div,cr). mode(beauty,div,uncreated).
#program univocal_necessity.        univocal_mode(grain,necessity).   % one principle: a necessity everywhere
#program univocal_norm.             univocal_mode(grain,norm).        % one principle: a norm everywhere

#program aug_full.          required(P,Z) :- god_o(P,Z,_).
#program aug_spiration.     required(P,spirit) :- god_o(P,spirit,_).
#program aug_ignore_kinds.  ignore_kinds.

% ---------- The origin of the Spirit ----------------------------------
% The grammar's axioms do not say whether the Son is of the Spirit's principle.
% These switches state each answer, and the further premise that decides it.
#program monopatrism.               % the Spirit from the Father alone, as to existence:
monopatrism.                        % Photius, Mystagogia; Gregory of Cyprus, Tomus (1285);
                                    % Palamas, Capita 150, 36 (kath' hyparxin)

#program palamite_energies.         % and eternally manifested through the Son
reltype(m).                         % A0: a sixth type. Warrant argued on another case: the
rel(m,son,spirit).                  % essence-energies distinction (Basil, Ep. 234; Palamas,
                                    % Triads III, on the Taboric light). Gregory of Cyprus,
                                    % Tomus (1285): ekphansis through the Son.
info(manifested_through(spirit,son)) :- rel(m,son,spirit), reltype(m).

#program cand_energies_unwarranted. % the same relation without a declared type
rel(m,son,spirit).

#program no_divine_contraction.     % no power common to Father and Son by which the Spirit
no_divine_contraction.              % proceeds as from one principle (Photius, Mystagogia)

#program distinction_opposition.    % persons are distinct only by opposed relations of origin:
distinction(opposition).            % Anselm, De processione 1; Florence, DH 1330; ST I q.36 a.2

#program distinction_mode.          % or also by distinct modes of origin from one source:
distinction(mode).                  % Gregory Nazianzen, Or. 31.8-9; John of Damascus, De fide orth. I.8

#program two_sons.                  % a second Son: one source, one mode, no opposition
divine(begetter). divine(a_son). divine(b_son).   % names sort the sons before their source
gen(begetting2,begetter,a_son). gen(begetting2,begetter,b_son).

#program angel_called_bridal.     % does "called to be bridal" (A9) tell an angel from a man?
uses(icon).                             % the Grammar of the Icon
distinguishes(d_angel, called_bridal, gabriel, peter).
