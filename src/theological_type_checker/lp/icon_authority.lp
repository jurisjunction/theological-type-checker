% ===================================================================
%  Authority graph, branches and shadows (answer-set layer)
%
%  source(S, Tier, Force, Year)
%     Tier  1  de fide credenda (c. 750 §1)
%           2  definitive tenenda (c. 750 §2)
%           3  authentic ordinary magisterium; ecclesiastical law (c. 752)
%           4  Doctors of the Church; common theological teaching
%           5  individual theologians
%     Force truth | juridical | protective
%  promoted(S, NewTier, Year)   e.g. declared a Doctor of the Church
%  supports(S, Q, V)            source S holds value V on question Q
%  protects(S, Q)               S forbids treating either school as excluded
%  relaxed(S)                   S dispensed, abrogated or changed
%  asof(Year), custom_asof      evaluate the graph as of a date
%
%  Every question Q with values value(Q,V) splits into branches, one
%  stable model per branch. Each branch is labelled:
%     main                  nothing in force cleaves it
%     live_shadow           cleaved only by reformable sources; it
%                           reintegrates if every labelled source is relaxed
%     counterfactual_shadow cleaved by a tier-2 truth source under the
%                           assumption t2_truth; inspectable, never reintegrates
%  A branch contradicted by a tier-1 truth source does not exist.
% ===================================================================

% ---------- Time and force -----------------------------------------
asof(9999) :- not custom_asof.
promoted_now(S) :- promoted(S,_,Y), asof(A), Y <= A.
eff_tier(S,T)   :- promoted(S,T,Y), asof(A), Y <= A, not oum_holds(S).
eff_tier(S,T)   :- source(S,T,_,_), not promoted_now(S), not oum_holds(S).
eff_tier(S,K)   :- oum_holds(S), oum_claim(S,K).
withdrawn_now(S) :- withdrawn(S,Y), asof(A), Y <= A.        % a later act replaced the text
in_force(S)     :- source(S,_,_,Y), asof(A), Y <= A, not relaxed(S), not withdrawn_now(S).

% ---------- Ambiguous texts: one branch per reading -------------------
% a source marked ambiguous but given no readings is a frontier item, not a contradiction
readable(S) :- reading(S,_).
1 { read_as(S,R) : reading(S,R) } 1 :- ambiguous(S), in_force(S), readable(S).
supports(S,Q,V) :- read_as(S,R), reads(S,R,Q,V).

% ---------- "Taught by the ordinary and universal magisterium" ---------
% The OUM has no formal act, so the claim that a teaching meets its
% conditions always comes from someone. Unless a strictly higher-tier act
% fixes it, it is an assumption the checker computes both ways.
oum_fixed(S) :- oum_fixed_by(S,F), in_force(F), eff_tier(F,1).
{ oum_holds(S) } :- oum_claim(S,_), in_force(S), not oum_fixed(S).
oum_holds(S) :- oum_fixed(S).
:- oum_holds(S), supports(S,Q,_), question_kind(Q,governance).   % definitive teaching is not discipline

% ---------- Branches -------------------------------------------------
1 { holds(Q,V) : value(Q,V) } 1 :- question(Q).

% a non-default value needs a source in force (c. 1058: what no law
% prohibits is open; an impediment exists only while a law imposes it)
supported(Q,V) :- in_force(S), supports(S,Q,V).
:- holds(Q,V), default(Q,D), V != D, not supported(Q,V).

% tier 1 truth deletes contrary branches
:- holds(Q,V), in_force(S), eff_tier(S,1), source(S,_,truth,_), supports(S,Q,W), W != V.

% ---------- Protection -----------------------------------------------
protected(Q,T) :- in_force(P), source(P,_,protective,_), eff_tier(P,T), protects(P,Q).
blocked(S,Q)   :- supports(S,Q,_), eff_tier(S,TS), protected(Q,TP), TS >= TP, TS > 1.

% ---------- Cleaving ---------------------------------------------------
cleave_raw(S,Q) :- in_force(S), supports(S,Q,_), eff_tier(S,T), T >= 2, T <= 3,
                   not source(S,_,protective,_), not blocked(S,Q), not nonmagisterial(S).
cleave_raw(S,Q) :- in_force(S), supports(S,Q,_), source(S,_,juridical,_), not blocked(S,Q).

% conflicts among sources that could cleave
contrary(S1,S2,Q) :- cleave_raw(S1,Q), cleave_raw(S2,Q), supports(S1,Q,V1), supports(S2,Q,V2), V1 != V2.
outranked(S,Q)    :- contrary(S,S2,Q), eff_tier(S,T), eff_tier(S2,T2), T2 < T.
% nothing below tier 1 can cleave the branch a tier-1 text requires
outranked(S,Q)    :- cleave_raw(S,Q), supports(S,Q,V), in_force(T1), eff_tier(T1,1),
                     source(T1,_,truth,_), supports(T1,Q,W), W != V.
info(against_tier1(S,Q)) :- in_force(S), supports(S,Q,W), holds(Q,V), W != V, S != T1,
                            in_force(T1), eff_tier(T1,1), source(T1,_,truth,_), supports(T1,Q,V).
% a governance act cannot bind a successor of equal authority (par in parem non habet imperium)
violation(successor_bound(S)) :- treated_as_binding_successors(S), governance(S).
same_tier(S,S2,Q) :- contrary(S,S2,Q), eff_tier(S,T), eff_tier(S2,T).
% governance: the later act prevails (c. 20)
lex_posterior_kind(governance). lex_posterior_kind(juridical).
superseded(S,Q) :- same_tier(S,S2,Q), question_kind(Q,K), lex_posterior_kind(K),
                   source(S,_,_,Y1), source(S2,_,_,Y2), Y2 > Y1,
                   not lower_legislator(S2,S), not custom_shield(S,S2).

% ---------- Tier 3 is not flat (1): legislators in governance ----------
% c. 331; c. 135 §2: a lower legislator cannot validly act contrary to a
% higher one. Form, not author: in forma specifica or by papal mandate,
% a curial act is the pope's own.
lrank(S,4) :- papal_form(S,legislative).
lrank(S,4) :- by_papal_mandate(S).
lrank(S,4) :- in_forma_specifica(S).
lrank(S,4) :- conciliar(S).
lrank(S,3) :- dicastery(S).
lrank(S,2) :- conference(S).
lrank(S,1) :- diocesan(S).
erank(S,R) :- lrank(S,R), not outranks_self(S,R).          % effective rank: the highest that applies
outranks_self(S,R) :- lrank(S,R), lrank(S,R2), R2 > R.
lower_legislator(S,S2) :- erank(S,R1), erank(S2,R2), R1 < R2.
outranked(S,Q) :- same_tier(S,S2,Q), question_kind(Q,K), lex_posterior_kind(K), lower_legislator(S,S2).
violation(invalid_lower_act(S,S2)) :- same_tier(S,S2,Q), question_kind(Q,K), lex_posterior_kind(K),
                                      lower_legislator(S,S2), source(S,_,_,Y1), source(S2,_,_,Y2), Y1 > Y2.

% ---------- Tier 3 is not flat (2): character and repetition in teaching -
% LG 25: the mind of the pope is known "from the character of the
% documents, from his frequent repetition of the same doctrine, or from
% his manner of speaking". An interview is not a magisterial act.
char_points(constitution,3). char_points(encyclical,3). char_points(conciliar_constitution,3).
char_points(conciliar_decree,2). char_points(exhortation,2). char_points(declaration,2).
char_points(instruction,2). char_points(catechism,2). char_points(apostolic_letter,2). char_points(profession,2).
char_points(letter,1). char_points(address,1). char_points(homily,1). char_points(notification,1).
char_points(responses,1). char_points(commentary,1).
char_points(interview,0).
nonmagisterial(S) :- character(S,interview).
has_character(S) :- character(S,_).
pts(S,P) :- character(S,K), char_points(K,P), not flat_weight.
pts(S,1) :- source(S,_,_,_), not has_character(S), not flat_weight.
pts(S,1) :- source(S,_,_,_), flat_weight.

% ---------- Custom (cc. 23-28) -------------------------------------------
custom_age(C,A)     :- custom_practice(C,_,_,S), asof(Y), A = Y - S.
bars_customs(C)     :- custom_practice(C,Q,V,_), law_forbids_customs(L), supports(L,Q,W), W != V, in_force(L).
needed_years(C,100) :- bars_customs(C).                                   % c. 26
needed_years(C,30)  :- custom_practice(C,_,_,_), not bars_customs(C).
reasonable(C)       :- custom_practice(C,_,_,_), not reprobated(C), not contra_divine(C).   % c. 24
qualifies(C) :- reasonable(C), community_capable(C), approved_custom(C),                 % cc. 23, 25
                custom_age(C,A), needed_years(C,N), A >= N.
violation(custom_contra_divine_law(C)) :- custom_practice(C,_,_,_), contra_divine(C).
info(custom_without_force(C)) :- custom_practice(C,_,_,_), not qualifies(C).
source(custom(C),3,juridical,Y) :- qualifies(C), custom_practice(C,_,_,S), needed_years(C,N), Y = S + N.
supports(custom(C),Q,V) :- qualifies(C), custom_practice(C,Q,V,_).
approver_rank(pope,4). approver_rank(conference,2). approver_rank(bishop,1).
lrank(custom(C),R) :- qualifies(C), approver(C,A), approver_rank(A,R).
% c. 28: a law does not revoke a centenary custom unless it mentions it expressly
custom_shield(custom(C),L) :- qualifies(C), custom_practice(C,_,_,S), source(L,_,_,Y), Y - S >= 100,
                              supports(L,_,_), L != custom(C), not expressly_revokes(L,C).
superseded(L,Q) :- custom_shield(custom(C),L), supports(custom(C),Q,V), supports(L,Q,W), V != W, in_force(L).

% ---------- Salience: descriptive only, never feeds a verdict ------------
info(salience_warning(A,S)) :- relies_on(A,S), salience(S,high), pts(S,P), P <= 1.
% teaching: no lex posterior, so equal-tier contrary teachings both stand
tension(S,Q) :- same_tier(S,S2,Q), question_kind(Q,doctrinal).
tension(S,Q) :- same_tier(S,S2,Q), question_kind(Q,K), lex_posterior_kind(K),
                source(S,_,_,Y), source(S2,_,_,Y).
resolved_above(Q,T) :- tension(S,Q), eff_tier(S,T), cleave_raw(S2,Q), eff_tier(S2,T2), T2 < T.
info(open_tension(Q,T)) :- tension(S,Q), eff_tier(S,T), not resolved_above(Q,T).

can_cleave(S,Q) :- cleave_raw(S,Q), not outranked(S,Q), not superseded(S,Q), not tension(S,Q).
cleaved_by(S)   :- can_cleave(S,Q), holds(Q,V), supports(S,Q,W), W != V.

% ---------- Tier-2 force is an assumption, not a premise --------------
% A meta-claim about a tier's force is fixed only by a source of a
% strictly higher tier that states it non-interpretively.
meta_target(t2_truth,2).
fixed(M) :- meta_supports(S,M), in_force(S), eff_tier(S,T), meta_target(M,K), T < K,
            not interpretive(S,M).
tier2_present :- in_force(S), eff_tier(S,2).
{ assume(t2_truth) } :- tier2_present, not fixed(t2_truth).
t2_truth :- fixed(t2_truth).
t2_truth :- assume(t2_truth).
violation(self_elevation(S,M)) :- treated_as_fixing(S,M), eff_tier(S,T), meta_target(M,K), T >= K.

% ---------- A papal act's tier follows its form ------------------------
% ex cathedra with all formalities -> 1; a formal definitive declaration
% -> 2; legislative or ordinary acts -> 3, whoever the author.
form_tier(ex_cathedra,1). form_tier(definitive_declaration,2).
form_tier(legislative,3). form_tier(ordinary,3).
violation(tier_inconsistent_with_form(S,T,F)) :- papal_form(S,F), source(S,T,_,_), form_tier(F,K), T != K.

% ---------- Teaching and governance are different output types --------
% A teaching act yields truth-claims with a grade of assent. A governance
% act (legislation, protection, juridical effects) yields obligations; it
% binds to teaching only by reference, never by asserting it.
governance(S) :- papal_form(S,legislative).
governance(S) :- source(S,_,protective,_).
governance(S) :- source(S,_,juridical,_).
violation(governance_read_as_teaching(S,Q)) :- governance(S), supports(S,Q,_), question_kind(Q,doctrinal).
violation(governance_read_as_teaching(S,M)) :- governance(S), meta_supports(S,M).
% binds(Law, Tier, Obligation): the law attaches an obligation to whatever
% is taught at that tier (incorporation by reference)
owed(S,O) :- in_force(S), not governance(S), eff_tier(S,T), binds(L,T,O), in_force(L).
info(owed(S,O)) :- owed(S,O).

% ---------- Labels -----------------------------------------------------
counterfactual_by(S) :- cleaved_by(S), eff_tier(S,2), source(S,_,truth,_), t2_truth.
live_by(S)           :- cleaved_by(S), not counterfactual_by(S).
shadowed :- cleaved_by(_).
branch(counterfactual_shadow) :- counterfactual_by(_).
branch(live_shadow)           :- shadowed, not counterfactual_by(_).
branch(main)                  :- question(_), not shadowed.
reintegrates_if_relaxed(S)    :- live_by(S), not branch(counterfactual_shadow).

% ---------- Weight: sources that disagree without cleaving ------------
% A source that cites an in-force source holding the same value adds no
% independent weight. Same-tier interpretations of an ambiguous text count
% against the readings they reject.
dependent(S,Q) :- cites(S,S2), supports(S,Q,V), supports(S2,Q,V), in_force(S2), not count_all.
% a reaffirmation is a new act of teaching and adds weight; the flat ablation treats it as a citation
dependent(S,Q) :- reaffirms(S,S2), supports(S,Q,V), supports(S2,Q,V), in_force(S2), flat_weight, not count_all.
disagrees(S,T,Q) :- in_force(S), source(S,_,truth,_), eff_tier(S,T), T >= 3,
                    supports(S,Q,W), holds(Q,V), W != V, not can_cleave(S,Q), not dependent(S,Q).
disagrees(S,T,reading(S1)) :- interprets(S,S1,R), in_force(S), eff_tier(S,T), read_as(S1,R2), R2 != R.
weight_tier(3..5).
weight(T,N) :- weight_tier(T), question(_), N = #sum{ P,S,X : disagrees(S,T,X), pts(S,P) }.

#show holds/2.
#show read_as/2.
#show oum_holds/1.
#show branch/1.
#show cleaved_by/1.
#show reintegrates_if_relaxed/1.
#show weight/2.
#show t2_truth/0.
