% ===================================================================
%  Lifted (TTC-PENDET): "per respectum ad unum" (ST I q. 13 a. 6).
%
%  What is said of many by analogy is said by reference to one, and that
%  one "oportet quod ponatur in definitione omnium" (I q. 13 a. 6); the
%  precepts of the law "sunt unum secundum ordinem ad unum finem, sunt
%  tamen multa" (I-II q. 99 a. 1). A term is lifted above an order where
%  every node of the order is referred to it and it is no node of it: the
%  word above the tongues, which no tongue owns (TTC-LINGUAE); God above
%  the levels of natures (A11) and above the ends (Benedictus Deus, DH
%  1000-1001, as TTC-LOCI enters it: God or a divine person). Lifted is no
%  rank. A term at the top of an order is in it, and A11 refuses that of
%  God; Thomas has two measures, the first of a genus, a member of what it
%  measures (I-II q. 90 a. 1), and God, "not a measure proportionate to
%  anything" (I q. 3 a. 5 ad 2). The lifted term is the second.
%
%  The relation is derived, never entered. The base's refusals of a lifted
%  term entered as a node of its order (word_dated, word_as_root,
%  god_inside_level_order) stay as they are, and each is reported beside
%  the relation it protects (lifted_filed). An order has room for one: a
%  substitution (substitutio.lp) that puts a creature in the lifted place
%  of an order puts a second term there (two_lifted). The role says the
%  order. Nothing is lifted above God (SCG I.34), and no rule says so: it
%  touches a school question, and this step enters no refusal for it.
% ===================================================================

%  @library  (read by norms.py: its predicates count as defined)
% @input role_order/2 | role_order(R, O): the library's table, the order whose lifted place a substitution's role is: giver_of_being the levels, last_end the ends
% @input word/1 | linguae.lp: a node of the order of reason
% @input substitutes/5 | substitutio.lp: a substitution, as a claimant reads a text or an order
% @input god/1 | the kernel
% @input divine/1 | the kernel
% @input person/1 | the kernel
% @input violation/1 | kernel_core.lp, icon_theory.lp, linguae.lp: the refusals the reports stand beside

% ---------- The relation, derived (LF1) -------------------------------------
lifted(W,tongues) :- word(W).
lifted(G,levels)  :- god(G).
lifted(G,ends)    :- god(G).
lifted(D,ends)    :- divine(D).

% ---------- Never filed (LF2) ------------------------------------------------
% Each reads the base's own refusal, so that it stands where that refusal
% fires, and only there.
info(lifted_filed(W,tongues,word_dated))   :- violation(word_dated(W)).
info(lifted_filed(W,tongues,word_as_root)) :- violation(word_as_root(W)).
info(lifted_filed(G,levels,god_inside_level_order)) :- violation(god_inside_level_order(G)).

% ---------- Room for one (LF3) -----------------------------------------------
% A substitution read of a text or an order, never of a person (rule 3), that
% puts X in the place of Y, where Y is lifted above the role's order and X
% is not.
role_order(giver_of_being,levels).
role_order(last_end,ends).
violation(two_lifted(O,Y,X)) :- substitutes(_,T,X,Y,R), not person(T), role_order(R,O), lifted(Y,O),
                                not lifted(X,O).

% ---------- domains (L) ---------------------------------------------
in_sort(order,(tongues;levels;ends)).
violation(outside_domain(role_order,1,R)) :- role_order(R,_), not in_sort(role,R).
violation(outside_domain(role_order,2,O)) :- role_order(_,O), not in_sort(order,O).
