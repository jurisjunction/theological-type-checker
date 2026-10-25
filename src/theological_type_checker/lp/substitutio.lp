% ===================================================================
%  Substitution (TTC-LOCI): "a partial trace taken as the whole".
%
%  A trace loses reasons (causae.lp). A substitution puts what is not God
%  in God's place. It is entered as a claim, with its claimant, of a text
%  or an order, never of a person (rule 3), and read so it is lowered onto
%  the deposit's own relations, whose rules then decide. In the place of
%  the giver of being, X gives being to every other creature (being/2;
%  being_from_non_god, Lateran IV, DH 800); in the place of the last end,
%  X is taken as the last end (last_end/1; last_end_not_god, Benedictus
%  Deus, DH 1000-1001). A text read as holding a creature necessary is no
%  substitution, since it can deny free creation without putting anything
%  in God's place: it is lowered onto necessary/1, and the kernel's
%  modal_collapse decides on the deposit's contingency (DH 3002, 3025). A
%  substitution entered as disputed runs in a branch with it and a branch
%  without. A pure trace faults nowhere.
%
%  Honour is typed by where it terminates. By a claimant's reading, honour
%  of a kind given to a sign terminates in its prototype (an icon) or in
%  the sign itself (an idol): "imaginis enim honor ad primitiuum transit"
%  (Nicaea II, DH 601). Latria that terminates in what is not God is the
%  deposit's to refuse (latria_to_creature). The checker types a text, an
%  order or a sign, never a soul.
% ===================================================================

%  @library  (read by norms.py: its predicates count as defined)
% @input substitutes/5 | substitutes(C, T, X, Y, R): the claimant C reads the text or order T as putting X in the place of Y, in the role R
% @input necessitates/3 | necessitates(C, T, X): the claimant C reads the text or order T as holding the creature X necessary
% @input honour/4 | honour(S, P, K, C): by C's reading, honour of the kind K given to the sign S terminates in P
% @input person/1 | the kernel
% @input creature/1 | the kernel
% @input disputed/1 | act.lp
% @input violation/1 | kernel_core.lp: the faults of the deposit's and the kernel's rules, which the reports name

% ---------- Never of a person (SB5) ------------------------------------------
% A substitution or a necessity read of a person, or an honour given to a
% person as its sign, is refused, and lowered nowhere: as a hearing of a
% person is (linguae.lp).
violation(substitution_of_a_person(T)) :- substitutes(_,T,_,_,_), person(T).
violation(substitution_of_a_person(T)) :- necessitates(_,T,_), person(T).
violation(substitution_of_a_person(S)) :- honour(S,_,_,_), person(S).

% ---------- A claim, computed both ways --------------------------------------
{ substitutes(C,T,X,Y,R) } :- disputed(substitutes(C,T,X,Y,R)).
assumed_fact(substitutes(C,T,X,Y,R))        :- disputed(substitutes(C,T,X,Y,R)), substitutes(C,T,X,Y,R).
assumed_fact(false(substitutes(C,T,X,Y,R))) :- disputed(substitutes(C,T,X,Y,R)), not substitutes(C,T,X,Y,R).

% ---------- Lowered onto the deposit's relations (SB) ------------------------
read_in(C,T,X,R)     :- substitutes(C,T,X,_,R), not person(T).
held_necessary(C,T,X) :- necessitates(C,T,X), not person(T).
being(X,Z)   :- read_in(_,_,X,giver_of_being), creature(Z), Z != X.
last_end(X)  :- read_in(_,_,X,last_end).
necessary(X) :- held_necessary(_,_,X).
latria_to(P) :- honour(S,P,latria,_), not person(S).

% ---------- The reports: the rule faulted, and its layer (docs/layers.csv) ---
% Each reads the fault of the rule it names, so that it stands where that
% rule fires, and only there.
info(substitution_faults(C,T,X,being_from_non_god,deposit)) :- read_in(C,T,X,giver_of_being),
                                                               violation(being_from_non_god(X,_)).
info(substitution_faults(C,T,X,last_end_not_god,deposit))   :- read_in(C,T,X,last_end),
                                                               violation(last_end_not_god(X)).
info(necessity_faults(C,T,X,modal_collapse,kernel))          :- held_necessary(C,T,X), violation(modal_collapse(X)).

% ---------- domains (L) ---------------------------------------------
in_sort(role,(giver_of_being;last_end)).
in_sort(honour_kind,(latria;veneration;hyperdulia;dulia)).
violation(outside_domain(substitutes,5,R)) :- substitutes(_,_,_,_,R), not in_sort(role,R).
violation(outside_domain(honour,3,K)) :- honour(_,_,K,_), not in_sort(honour_kind,K).
