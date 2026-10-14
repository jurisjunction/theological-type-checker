% ===================================================================
%  Authority graph, branches and shadows (answer-set layer)
%
%  source(S, Tier, Force, Year)
%     Tier  0  the word of God, Scripture with Tradition (DV 10): read, never raw
%           1  de fide credenda (c. 750 §1)
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

% @input ambiguous/1 | ambiguous(S): the text S admits more than one reading; one branch per reading
% @input approved_custom/1 | approved_custom(C): the custom C has the legislator's approval (c. 23)
% @input approver/2 | approver(C, A): A approved the custom C
% @input approver_rank/2 | approver_rank(A, R): the legislative rank R of an approver of customs
% @input binds/3 | binds(L, T, O): law L attaches obligation O to teaching at tier T (cc. 750, 752)
% @input by_papal_mandate/1 | by_papal_mandate(S): a curial act the pope made his own (rank 4)
% @input char_points/2 | char_points(K, P): the weight P of a document of character K (LG 25)
% @input character/2 | character(S, K): the kind of document S is: its weight under LG 25
% @input cites/2 | cites(S, S2): S repeats S2, with no weight of its own
% @input claims_tier/3 | claims_tier(C, S, K): C says S teaches at tier K (a claim, rule 14)
% @input community_capable/1 | community_capable(C): a community able to receive a law (c. 25)
% @input conciliar/1 | conciliar(S): a council's act (legislator rank 4, c. 135 §2)
% @input conciliar_act/2 | conciliar_act(S, K): a council's act of kind K: canon, definition, creed, scope, chapter
% @input condition_shown/2 | condition_shown(S, C): a condition of a definition (DH 3074) or of LG 25, shown for S by evidence apart from its claimant (rule 14)
% @input conference/1 | conference(S): a conference of bishops' act (legislator rank 2)
% @input consent_claim/2 | consent_claim(S, R): the Fathers' unanimous consent claimed for reading R of text S
% @input contra_divine/1 | contra_divine(C): the custom C is against divine law (c. 24 §1)
% @input count_all/0 | every source counts, citing or not (an ablation)
% @input custom_practice/4 | custom_practice(C, Q, V, Y): a community's practice of V on Q since year Y (cc. 23-28)
% @input default/2 | default(Q, V): V holds on Q unless a source in force says otherwise (c. 1058)
% @input defining_act/1 | defining_act(K): a conciliar act that defines (canon, definition, creed, scope)
% @input defining_form/1 | defining_form(F): a papal form that defines (ex cathedra)
% @input dicastery/1 | dicastery(S): a dicastery's act (legislator rank 3)
% @input diocesan/1 | diocesan(S): a diocesan act (legislator rank 1)
% @input ec_condition/1 | ec_condition(C): a condition of Pastor aeternus (DH 3074)
% @input expressly_revokes/2 | expressly_revokes(L, C): law L expressly revokes the custom C (c. 28)
% @input faith_morals/1 | faith_morals(S): the text S bears on faith or morals
% @input flat_weight/0 | every source weighs one point (an ablation)
% @input form_tier/2 | form_tier(F, T): the tier a papal form gives
% @input holds_reading/2 | holds_reading(S, R): a runtime's reading of S: only the branches it holds
% @input hypothetical_warrant/1 | hypothetical_warrant(S): a warrant supposed for S (HYPOTHETICAL parts only, rule 6)
% @input in_forma_specifica/1 | in_forma_specifica(S): a curial act approved in specific form (rank 4)
% @input interpretive/2 | interpretive(S, M): S speaks to M interpretively, leaving its extent open
% @input interprets/3 | interprets(S, S1, R): S weighs for reading R of S1; never fixes it
% @input law_forbids_customs/1 | law_forbids_customs(L): law L forbids future customs (c. 28)
% @input lex_posterior_kind/1 | lex_posterior_kind(K): a kind of question the later law decides
% @input meta_supports/2 | meta_supports(S, M): S speaks to the question about tiers M
% @input meta_target/2 | meta_target(M, T): the tier the question M is about
% @input object_tier/2 | object_tier(O, T): the tier a definition's object gives (revealed 1, connected 2)
% @input oum_claim/2 | oum_claim(S, K): S claimed as ordinary universal magisterium at grade K; computed both ways (rule 14)
% @input oum_claimant/2 | oum_claimant(S, C): who claims S as ordinary universal magisterium
% @input oum_condition/1 | oum_condition(C): a condition of LG 25
% @input oum_fixed_by/2 | oum_fixed_by(S, F): an act F said to fix the claim on S
% @input papal_form/2 | papal_form(S, F): the form of a papal act: ex_cathedra, definitive_declaration, legislative, ordinary
% @input promoted/3 | promoted(S, T, Y): S raised to tier T from year Y (declared a Doctor)
% @input protects/2 | protects(S, Q): S, of protective force, blocks cleaving Q at or below its tier
% @input question/1 | question(Q): a question a run answers
% @input question_kind/2 | question_kind(Q, K): the type of Q: doctrinal, governance, juridical, empirical
% @input reading/2 | reading(S, R): R is a reading of S
% @input reads/4 | reads(S, R, Q, V): read as R, S holds V on Q
% @input reaffirms/2 | reaffirms(S, S2): S re-teaches S2, with weight
% @input received_creed/1 | received_creed(S): S typed received with no claim and no date (refused)
% @input reception_claim/3 | reception_claim(S, C, Y): C claims the creed S received from year Y
% @input reception_fixed_by/2 | reception_fixed_by(S, F): the act F hands the creed S on
% @input records_diverse_readings/2 | records_diverse_readings(F, S): F records diverse readings of S
% @input relaxed/1 | relaxed(S): S dispensed, abrogated or changed: out of force
% @input relies_on/2 | relies_on(A, S): the argument A relies on S
% @input reprobated/1 | reprobated(C): the custom C reprobated by law (c. 24 §2)
% @input salience/2 | salience(S, high): S is prominent (warnings only)
% @input session_defines/1 | session_defines(S): the session binds the chapter S (rule 14)
% @input source/4 | source(S, T, F, Y): S at tier T (0-5), of force F (truth, juridical, protective), from year Y
% @input supports/3 | supports(S, Q, V): S holds V on Q
% @input treated_as_binding_successors/1 | treated_as_binding_successors(S): S read as binding the legislator's successors
% @input treated_as_fixing/2 | treated_as_fixing(C, S): C's statement about S treated as fixing its tier (refused)
% @input value/2 | value(Q, V): V is an answer to Q
% @input weight_tier/1 | weight_tier(T): a tier at which disagreement is weighed (3 to 5)
% @input withdrawn/2 | withdrawn(S, Y): the text S replaced from year Y

% ---------- Time and force -----------------------------------------
% asof/1 comes from the one clock (saeculum.lp): an asof part, today's
% year, or 9999 (every source entered) with no clock (TTC-SAECULUM CA1).
promoted_now(S) :- promoted(S,_,Y), asof(A), Y <= A.
eff_tier(S,T)   :- promoted(S,T,Y), asof(A), Y <= A.
eff_tier(S,T)   :- source(S,T,_,_), not promoted_now(S).
withdrawn_now(S) :- withdrawn(S,Y), asof(A), Y <= A.        % a later act replaced the text
in_force(S)     :- source(S,_,_,Y), asof(A), Y <= A, not relaxed(S), not withdrawn_now(S), not awaiting_reception(S).

% ---------- The empirical kind (TTC-EMPIRICA) --------------------------
% A question the sciences answer: no tier deletes, cleaves or weighs on it.
% Findings fix it from their year (empirica.lp).
empirical_q(Q) :- question_kind(Q,empirical).

% ---------- Ambiguous texts: one branch per reading -------------------
% a source marked ambiguous but given no readings is a frontier item, not a contradiction
readable(S) :- reading(S,_).
1 { read_as(S,R) : reading(S,R) } 1 :- ambiguous(S), in_force(S), readable(S).
% a runtime that holds a reading keeps only the branches it holds (TTC-SCHOOLS P8)
:- holds_reading(S,_), read_as(S,R), not holds_reading(S,R).
supports(S,Q,V) :- read_as(S,R), reads(S,R,Q,V).

% ---------- Tier 0: the word of God (DV 10-12; TTC-CREED) -------------------
% Scripture with Tradition, one deposit (DV 10): above tier 1 in authority,
% below it in determinacy, since its authentic interpretation belongs to the
% teaching office. A text enters only through its readings (ambiguous/1,
% reading/2, reads/4), never raw. Inerrancy (DV 11): no branch holds a value
% contrary to the reading it takes. The analogy of faith (DV 12) needs no
% rule of its own: a tier-1 text fixes the value, and inerrancy then
% excludes every reading against it; a defined sense is that case.
:- holds(Q,V), in_force(S), eff_tier(S,0), supports(S,Q,W), W != V.
frontier(theology,scripture_without_readings(S)) :- source(S,0,_,_), not readable(S).
% In faith and morals, no one may read a text against the unanimous consent
% of the Fathers (Trent, sess. IV, DH 1507; Vatican I, DH 3007). That a
% consent is unanimous is a claim, computed both ways, and refused where an
% act in force records that the Fathers read the text diversely.
{ unanimous(S,R) } :- consent_claim(S,R), in_force(S).
:- unanimous(S,_), records_diverse_readings(F,S), in_force(F).
:- unanimous(S,R), read_as(S,R2), R2 != R, faith_morals(S).
assumed_fact(unanimous(S,R))        :- consent_claim(S,R), unanimous(S,R).
assumed_fact(false(unanimous(S,R))) :- consent_claim(S,R), in_force(S), not unanimous(S,R).

% ---------- "Taught by the ordinary and universal magisterium" ---------
% The OUM has no formal act, so the claim that a teaching meets its
% conditions always comes from someone. Unless a strictly higher-tier act
% fixes it, it is an assumption the checker computes both ways.
% Rule 14 (TTC-COMMUNION TC2): the consensus is a source of its own,
% oum(S); the document S that reports it keeps its own tier. The claim's
% grade (oum_claim(S,K): 1, proposed as revealed; 2, to be held
% definitively) is computed both ways where more than one is claimed.
oum_fixed(S) :- oum_fixed_by(S,F), in_force(F), eff_tier(F,1).
{ oum_holds(S) } :- oum_claim(S,_), in_force(S), not oum_fixed(S).
oum_holds(S) :- oum_fixed(S).
1 { oum_grade(S,K) : oum_claim(S,K) } 1 :- oum_holds(S).
graded(S,K) :- oum_grade(S,K), oum_claim(S,K2), K2 != K.
source(oum(S),K,truth,Y) :- oum_holds(S), oum_grade(S,K), source(S,_,_,Y).
supports(oum(S),Q,V)     :- oum_holds(S), supports(S,Q,V).
:- oum_holds(S), supports(S,Q,_), question_kind(Q,governance).   % definitive teaching is not discipline
% c. 749 §3: "no doctrine is understood as defined infallibly unless this is
% manifestly evident". LG 25's conditions, each shown by evidence apart from
% the claimant's word (condition_shown/2); where any is not, the branch that
% rests on the claim is never preferred (engine.pref_key).
oum_condition(dispersed_in_communion;authentic_teaching;faith_or_morals;one_position_definitive).
oum_unmet(S)        :- oum_claim(S,_), oum_condition(C), not condition_shown(S,C).
unshown_claim(S)    :- oum_holds(S), oum_unmet(S).
violation(claim_without_claimant(S)) :- oum_claim(S,_), not oum_claimant(S,_).   % rule 14: entered with its claimant

% ---------- A creed received: a dated claim (TTC-SAECULUM RC) ------------
% Reception, like the ordinary universal magisterium, is a claim about
% witnesses: entered with its claimant and the year from which it claims
% the creed received (reception_claim/3). From that year it is computed
% both ways, and the branch resting on it is never preferred (rule 14),
% unless an act at tier 1 in force hands the creed on as a rule of faith
% (reception_fixed_by/2). Not received, the text is not in force as the
% Church's. An act below tier 1 that hands it on is a witness, recorded.
reception_due(S)   :- reception_claim(S,_,Y), asof(A), Y <= A, source(S,_,_,_), not relaxed(S).
reception_fixed(S) :- reception_fixed_by(S,F), in_force(F), eff_tier(F,1).
{ received(S) } :- reception_due(S), not reception_fixed(S).
received(S) :- reception_due(S), reception_fixed(S).
awaiting_reception(S) :- reception_claim(S,_,_), not received(S).
unshown_claim(reception(S))      :- received(S), not reception_fixed(S).
assumed_fact(received(S))        :- received(S), not reception_fixed(S).
assumed_fact(false(received(S))) :- reception_due(S), not received(S).
info(handed_on_below_tier_1(S,F)) :- reception_fixed_by(S,F), in_force(F), not eff_tier(F,1), reception_due(S).
violation(reception_without_claimant(S)) :- received_creed(S).   % undated, unclaimed: the old form, refused

% ---------- Rule 14: a tier is a finding about form and conditions ---------
% A source at tier 1 or 2 needs a warrant: a papal definition with the
% conditions of Pastor aeternus (DH 3074), a council's canon, definition,
% creed or declaration of its own scope, a doctrinal chapter its session
% binds, a creed received (a claim of reception, recorded), or the claimed
% consensus. Synthetic test sources carry a hypothetical warrant.
ec_condition(pastor_of_all;apostolic_authority;defines;faith_or_morals;whole_church).
ec_unmet(S)  :- papal_form(S,ex_cathedra), ec_condition(C), not condition_shown(S,C).
warranted(S) :- papal_form(S,ex_cathedra), not ec_unmet(S), object_of(S,_).   % and what it defines (TTC-PENAL FO)
info(condition_unshown(S,C)) :- papal_form(S,ex_cathedra), ec_condition(C), not condition_shown(S,C).
defining_act(canon;definition;creed;scope).
warranted(S) :- conciliar_act(S,K), defining_act(K).
warranted(S) :- conciliar_act(S,chapter), session_defines(S).
warranted(S) :- received(S).
warranted(oum(S)) :- oum_holds(S).
warranted(S) :- hypothetical_warrant(S).
violation(tier_without_warrant(S,T)) :- in_force(S), source(S,T,_,_), T >= 1, T <= 2, not warranted(S).
% Any statement about the tier or grade of a teaching is a claim (claims_tier/3):
% flagged when a lower tier speaks of a higher, refused when treated as fixing.
info(lower_speaks_of_higher(C,S,K)) :- claims_tier(C,S,K), in_force(C), eff_tier(C,T), T > K.
info(lower_speaks_of_higher(S,M,K)) :- meta_supports(S,M), in_force(S), eff_tier(S,T), meta_target(M,K), T > K.
% A claim is refused from its date: before it is made it fixes nothing (TTC-EMPIRICA GL2).
violation(self_elevation(C,S)) :- treated_as_fixing(C,S), claims_tier(C,S,K), in_force(C), eff_tier(C,T), T >= K.

% ---------- Branches -------------------------------------------------
1 { holds(Q,V) : value(Q,V) } 1 :- question(Q).

% a non-default value needs a source in force (c. 1058: what no law
% prohibits is open; an impediment exists only while a law imposes it)
supported(Q,V) :- in_force(S), supports(S,Q,V).
:- holds(Q,V), default(Q,D), V != D, not supported(Q,V).

% tier 1 truth deletes contrary branches
:- holds(Q,V), in_force(S), eff_tier(S,1), source(S,_,truth,_), supports(S,Q,W), W != V, not empirical_q(Q).

% ---------- Protection -----------------------------------------------
protected(Q,T) :- in_force(P), source(P,_,protective,_), eff_tier(P,T), protects(P,Q).
blocked(S,Q)   :- supports(S,Q,_), eff_tier(S,TS), protected(Q,TP), TS >= TP, TS > 1.

% ---------- Cleaving ---------------------------------------------------
% Bishops gathered in a particular council teach the faithful entrusted to
% them (c. 753), not the whole Church (c. 752): their teaching weighs at its
% tier and cleaves nothing (TTC-SOURCES FQ2).
% A prayer is a witness, not a teaching act: "Lex credendi legem statuat
% supplicandi" (Mediator Dei 48). It weighs at its tier and cleaves nothing
% (TTC-LITURGY; liturgy.lp).
% @input particular_council/1 | the source is a particular council's act (c. 753)
% @input liturgical_witness/1 | liturgy.lp: the prayer a liturgical book holds
cleave_raw(S,Q) :- in_force(S), supports(S,Q,_), eff_tier(S,T), T >= 2, T <= 3,
                   not source(S,_,protective,_), not blocked(S,Q), not nonmagisterial(S), not particular_council(S),
                   not liturgical_witness(S), not empirical_q(Q).
cleave_raw(S,Q) :- in_force(S), supports(S,Q,_), source(S,_,juridical,_), not blocked(S,Q), not empirical_q(Q).

% conflicts among sources that could cleave
contrary(S1,S2,Q) :- cleave_raw(S1,Q), cleave_raw(S2,Q), supports(S1,Q,V1), supports(S2,Q,V2), V1 != V2.
outranked(S,Q)    :- contrary(S,S2,Q), eff_tier(S,T), eff_tier(S2,T2), T2 < T.
% nothing below tier 1 can cleave the branch a tier-1 text requires
outranked(S,Q)    :- cleave_raw(S,Q), supports(S,Q,V), in_force(T1), eff_tier(T1,1),
                     source(T1,_,truth,_), supports(T1,Q,W), W != V.
info(against_tier1(S,Q)) :- in_force(S), supports(S,Q,W), holds(Q,V), W != V, S != T1,
                            in_force(T1), eff_tier(T1,1), source(T1,_,truth,_), supports(T1,Q,V), not empirical_q(Q).
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
char_points(conciliar_decree,2). char_points(exhortation,2). char_points(declaration,2). char_points(liturgy,2).
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

% ---------- A papal act's tier follows its form and its object -----------
% The form says whether the act defines; the object gives the grade (TTC-PENAL
% FO). A definition of a truth as revealed is tier 1; of a truth connected
% with revelation (a secondary object, a dogmatic fact), tier 2: the pope
% defines a doctrine "tenendam", to be held (DH 3074). An act that declares a
% teaching to be held definitively without defining it keeps its own tier, 3,
% and carries a claim of the ordinary universal magisterium, its author the
% claimant: "not a new dogmatic definition" (CDF 1998, n. 9). Legislative and
% ordinary acts are tier 3, whoever the author.
% @input object_of/2 | object_of(S, revealed | connected): what a defining act defines, as its text shows
defining_form(ex_cathedra).
object_tier(revealed,1). object_tier(connected,2).
form_tier(definitive_declaration,3). form_tier(legislative,3). form_tier(ordinary,3).
expected_tier(S,K) :- papal_form(S,F), form_tier(F,K).
expected_tier(S,K) :- papal_form(S,F), defining_form(F), object_of(S,O), object_tier(O,K).
violation(tier_inconsistent_with_form(S,T,F)) :- papal_form(S,F), source(S,T,_,_), expected_tier(S,K), T != K.
violation(declaration_without_claim(S)) :- papal_form(S,definitive_declaration), not oum_claim(S,_).

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
% A particular council's teaching is owed by the faithful entrusted to its
% bishops (c. 753), not by all: not computed here (TTC-SOURCES).
% Nor is anything owed to a prayer as a teaching act (TTC-LITURGY LW5).
owed(S,O) :- in_force(S), not governance(S), eff_tier(S,T), binds(L,T,O), in_force(L), not particular_council(S),
             not liturgical_witness(S).
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
                    supports(S,Q,W), holds(Q,V), W != V, not can_cleave(S,Q), not dependent(S,Q), not empirical_q(Q).
disagrees(S,T,reading(S1)) :- interprets(S,S1,R), in_force(S), eff_tier(S,T), read_as(S1,R2), R2 != R.
weight_tier(3..5).
weight(T,N) :- weight_tier(T), question(_), N = #sum{ P,S,X : disagrees(S,T,X), pts(S,P) }.

#show holds/2.
#show read_as/2.
#show oum_holds/1.
#show graded/2.
#show unshown_claim/1.
#show branch/1.
#show cleaved_by/1.
#show reintegrates_if_relaxed/1.
#show weight/2.
#show t2_truth/0.

% ---------- domains (L) ---------------------------------------------
in_sort(tier,0..5).
in_sort(force,(truth;juridical;protective)).
in_sort(question_kind,(doctrinal;governance;juridical;empirical)).
in_sort(papal_form,(ex_cathedra;definitive_declaration;legislative;ordinary)).
in_sort(character,(constitution;encyclical;conciliar_constitution;conciliar_decree;exhortation;declaration;instruction;catechism;apostolic_letter;profession;letter;address;homily;notification;responses;commentary;interview;liturgy)).
in_sort(conciliar_act,(canon;definition;creed;scope;chapter)).
in_sort(shown_condition,(pastor_of_all;apostolic_authority;defines;faith_or_morals;whole_church;dispersed_in_communion;authentic_teaching;one_position_definitive)).
in_sort(object,(revealed;connected)).
violation(outside_domain(binds,2,T)) :- binds(_,T,_), not in_sort(tier,T).
violation(outside_domain(char_points,1,K)) :- char_points(K,_), not in_sort(character,K).
violation(outside_domain(character,2,K)) :- character(_,K), not in_sort(character,K).
violation(outside_domain(claims_tier,3,K)) :- claims_tier(_,_,K), not in_sort(tier,K).
violation(outside_domain(conciliar_act,2,K)) :- conciliar_act(_,K), not in_sort(conciliar_act,K).
violation(outside_domain(condition_shown,2,C)) :- condition_shown(_,C), not in_sort(shown_condition,C).
violation(outside_domain(defining_act,1,K)) :- defining_act(K), not in_sort(conciliar_act,K).
violation(outside_domain(defining_form,1,F)) :- defining_form(F), not in_sort(papal_form,F).
violation(outside_domain(ec_condition,1,C)) :- ec_condition(C), not in_sort(shown_condition,C).
violation(outside_domain(form_tier,1,F)) :- form_tier(F,_), not in_sort(papal_form,F).
violation(outside_domain(form_tier,2,T)) :- form_tier(_,T), not in_sort(tier,T).
violation(outside_domain(lex_posterior_kind,1,K)) :- lex_posterior_kind(K), not in_sort(question_kind,K).
violation(outside_domain(meta_target,2,T)) :- meta_target(_,T), not in_sort(tier,T).
violation(outside_domain(object_tier,1,O)) :- object_tier(O,_), not in_sort(object,O).
violation(outside_domain(object_tier,2,T)) :- object_tier(_,T), not in_sort(tier,T).
violation(outside_domain(oum_claim,2,K)) :- oum_claim(_,K), not in_sort(tier,K).
violation(outside_domain(oum_condition,1,C)) :- oum_condition(C), not in_sort(shown_condition,C).
violation(outside_domain(papal_form,2,F)) :- papal_form(_,F), not in_sort(papal_form,F).
violation(outside_domain(promoted,2,T)) :- promoted(_,T,_), not in_sort(tier,T).
violation(outside_domain(question_kind,2,K)) :- question_kind(_,K), not in_sort(question_kind,K).
violation(outside_domain(source,2,T)) :- source(_,T,_,_), not in_sort(tier,T).
violation(outside_domain(source,3,F)) :- source(_,_,F,_), not in_sort(force,F).
violation(outside_domain(weight_tier,1,T)) :- weight_tier(T), not in_sort(tier,T).
violation(outside_domain(object_of,2,O)) :- object_of(_,O), not in_sort(object,O).
