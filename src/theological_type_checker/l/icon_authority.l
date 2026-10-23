layer authority

-- Sorts first used in this layer (TTC-L, TY): closed, then open

sort tier 0..5
  means "a tier: 0 the word of God, 1 de fide, 2 definitive, 3 authentic, 4 Doctors, 5 theologians"

sort force {truth, juridical, protective}
  means "a source's force"

sort question_kind {doctrinal, governance, juridical, empirical}
  means "a question's type; it decides lex posterior"

sort papal_form {ex_cathedra, definitive_declaration, legislative, ordinary}
  means "the form of a papal act"

sort character {constitution, encyclical, conciliar_constitution, conciliar_decree, exhortation, declaration, instruction, catechism, apostolic_letter, profession, letter, address, homily, notification, responses, commentary, interview, liturgy}
  means "a document's character, its weight under LG 25"

sort conciliar_act {canon, definition, creed, scope, chapter}
  means "the kind of a council's act"

sort shown_condition {pastor_of_all, apostolic_authority, defines, faith_or_morals, whole_church, dispersed_in_communion, authentic_teaching, one_position_definitive}
  means "a condition of Pastor aeternus (DH 3074) or of LG 25"

sort object {revealed, connected}
  means "what a definition defines"

sort authority
  means "one who holds authority, or the office"

sort claimant
  means "who makes a claim: a source or a person"

sort custom
  means "a custom (cc. 23-28)"

sort meta_question
  means "a question about tiers"

sort question
  means "a question, q(...)"

sort rank
  means "a legislative rank, 1 to 4"

sort reading
  means "a reading of a text or of a law"

sort source
  means "a source on the authority graph: a text or act, by its name"

sort value
  means "an answer to a question"

sort year
  means "a year"

```clingo
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

```

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot ambiguous(S: source)
  means "ambiguous(S): the text S admits more than one reading; one branch per reading"
  say "{S} admits more than one reading"

slot asof(Y: year)
  means "asof(Year): the year the authority graph is read as of, entered with custom_asof (or by an asof part)"
  say "the graph is read as of {Y}"

slot approved_custom(C: custom)
  means "approved_custom(C): the custom C has the legislator's approval (c. 23)"
  say "the custom {C} has the legislator's approval"

slot approver(C: custom, A: authority)
  means "approver(C, A): A approved the custom C"
  say "{A} approved the custom {C}"

slot approver_rank(A: authority, R: rank)
  means "approver_rank(A, R): the legislative rank R of an approver of customs"
  say "{A} approves customs at rank {R}"

slot binds(L: source, T: tier, O: category)
  means "binds(L, T, O): law L attaches obligation O to teaching at tier T (cc. 750, 752)"
  say "{L} attaches {O} to teaching at tier {T}"

slot by_papal_mandate(S: source)
  means "by_papal_mandate(S): a curial act the pope made his own (rank 4)"
  say "the pope made {S} his own"

slot char_points(K: character, P: number)
  means "char_points(K, P): the weight P of a document of character K (LG 25)"
  say "a document of the character {K} weighs {P}"

slot character(S: source, K: character)
  means "character(S, K): the kind of document S is: its weight under LG 25"
  say "{S} is of the character {K}"

slot cites(S: source, S2: source)
  means "cites(S, S2): S repeats S2, with no weight of its own"
  say "{S} cites {S2}"

slot claims_tier(C: source, S: source, K: tier)
  means "claims_tier(C, S, K): C says S teaches at tier K (a claim, rule 14)"
  say "{C} says {S} teaches at tier {K}"

slot claim_stated(S: source, C: claimant)
  means "claim_stated(S, C): the claimant C states the claim on S as ordinary universal magisterium in its own words (TTC-WITNESS WR1)"
  say "{C} states in its own words the claim on {S}"

slot communion_judged_by(W: source, Q: question)
  means "communion_judged_by(W, Q): the witness W counts the bishops in communion by their answer on Q (TTC-WITNESS WC1)"
  say "{W} counts the bishops in communion by their answer on {Q}"

slot community_capable(C: custom)
  means "community_capable(C): a community able to receive a law (c. 25)"
  say "the community of the custom {C} can receive a law"

slot conciliar(S: source)
  means "conciliar(S): a council's act (legislator rank 4, c. 135 §2)"
  say "{S} is a council's act"

slot conciliar_act(S: source, K: conciliar_act)
  means "conciliar_act(S, K): a council's act of kind K: canon, definition, creed, scope, chapter"
  say "{S} is a council's {K}"

slot condition_shown(S: source, C: shown_condition)
  means "condition_shown(S, C): a condition of a definition (DH 3074), shown for S by its form; one of LG 25's, derived only from a witness apart (witnessed_by/3; rule 14)"
  say "for {S}, the condition {C} is shown"

slot conference(S: source)
  means "conference(S): a conference of bishops' act (legislator rank 2)"
  say "{S} is a conference of bishops' act"

slot consent_claim(S: source, R: reading)
  means "consent_claim(S, R): the Fathers' unanimous consent claimed for reading R of text S"
  say "the Fathers' unanimous consent is claimed for the reading {R} of {S}"

slot contra_divine(C: custom)
  means "contra_divine(C): the custom C is against divine law (c. 24 §1)"
  say "the custom {C} is against divine law"

slot count_all/0
  means "every source counts, citing or not (an ablation)"
  say "every source counts, citing or not"

slot custom_practice(C: custom, Q: question, V: value, Y: year)
  means "custom_practice(C, Q, V, Y): a community's practice of V on Q since year Y (cc. 23-28)"
  say "the community of the custom {C} has practised {V} on {Q} since {Y}"

slot default(Q: question, V: value)
  means "default(Q, V): V holds on Q unless a source in force says otherwise (c. 1058)"
  say "{V} holds on {Q} unless a source in force says otherwise"

slot defining_act(K: conciliar_act)
  means "defining_act(K): a conciliar act that defines (canon, definition, creed, scope)"
  say "a council's {K} defines"

slot defining_form(F: papal_form)
  means "defining_form(F): a papal form that defines (ex cathedra)"
  say "the papal form {F} defines"

slot dicastery(S: source)
  means "dicastery(S): a dicastery's act (legislator rank 3)"
  say "{S} is a dicastery's act"

slot diocesan(S: source)
  means "diocesan(S): a diocesan act (legislator rank 1)"
  say "{S} is a diocesan act"

slot ec_condition(C: shown_condition)
  means "ec_condition(C): a condition of Pastor aeternus (DH 3074)"
  say "{C} is a condition of Pastor aeternus"

slot expressly_revokes(L: source, C: custom)
  means "expressly_revokes(L, C): law L expressly revokes the custom C (c. 28)"
  say "{L} expressly revokes the custom {C}"

slot faith_morals(S: source)
  means "faith_morals(S): the text S bears on faith or morals"
  say "{S} bears on faith or morals"

slot flat_weight/0
  means "every source weighs one point (an ablation)"
  say "every source weighs one point"

slot form_tier(F: papal_form, T: tier)
  means "form_tier(F, T): the tier a papal form gives"
  say "the papal form {F} gives tier {T}"

slot holds_reading(S: source, R: reading)
  means "holds_reading(S, R): a runtime's reading of S: only the branches it holds"
  say "the runtime reads {S} as {R}"

slot hypothetical_warrant(S: source)
  means "hypothetical_warrant(S): a warrant supposed for S (HYPOTHETICAL parts only, rule 6)"
  say "a warrant is supposed for {S}"
  hypothetical "a warrant supposed, not shown: written only in parts marked HYPOTHETICAL"

slot in_forma_specifica(S: source)
  means "in_forma_specifica(S): a curial act approved in specific form (rank 4)"
  say "{S} is approved in specific form"

slot in_name_of(A: source, P: claimant)
  means "in_name_of(A, P): the act A issued in P's name, by vicarious power or approved by P in common form (c. 131 §2; c. 360; TTC-WITNESS WR3)"
  say "{A} is issued in the name of {P}"

slot interpretive(S: source, M: meta_question)
  means "interpretive(S, M): S speaks to M interpretively, leaving its extent open"
  say "{S} speaks to {M} interpretively"

slot interprets(S: source, S1: source, R: reading)
  means "interprets(S, S1, R): S weighs for reading R of S1; never fixes it"
  say "{S} weighs for the reading {R} of {S1}"

slot law_forbids_customs(L: source)
  means "law_forbids_customs(L): law L forbids future customs (c. 28)"
  say "{L} forbids future customs"

slot lex_posterior_kind(K: question_kind)
  means "lex_posterior_kind(K): a kind of question the later law decides"
  say "the later law decides a {K} question"

slot meta_supports(S: source, M: meta_question)
  means "meta_supports(S, M): S speaks to the question about tiers M"
  say "{S} speaks to {M}"

slot meta_target(M: meta_question, T: tier)
  means "meta_target(M, T): the tier the question M is about"
  say "{M} is about tier {T}"

slot object_tier(O: object, T: tier)
  means "object_tier(O, T): the tier a definition's object gives (revealed 1, connected 2)"
  say "a {O} truth defined is at tier {T}"

slot oum_claim(S: source, K: tier)
  means "oum_claim(S, K): S claimed as ordinary universal magisterium at grade K; computed both ways (rule 14)"
  say "{S} is claimed as ordinary universal magisterium at grade {K}"

slot oum_claimant(S: source, C: claimant)
  means "oum_claimant(S, C): who claims S as ordinary universal magisterium"
  say "{C} claims {S} as ordinary universal magisterium"

slot oum_condition(C: shown_condition)
  means "oum_condition(C): a condition of LG 25"
  say "{C} is a condition of LG 25"

slot oum_fixed_by(S: source, F: source)
  means "oum_fixed_by(S, F): an act F said to fix the claim on S"
  say "{F} is said to fix the claim on {S}"

slot papal_form(S: source, F: papal_form)
  means "papal_form(S, F): the form of a papal act: ex_cathedra, definitive_declaration, legislative, ordinary"
  say "{S} is a papal act in the form {F}"

slot promoted(S: source, T: tier, Y: year)
  means "promoted(S, T, Y): S raised to tier T from year Y (declared a Doctor)"
  say "{S} is raised to tier {T} from {Y}"

slot protects(S: source, Q: question)
  means "protects(S, Q): S, of protective force, blocks cleaving Q at or below its tier"
  say "{S} protects {Q}"

slot question(Q: question)
  means "question(Q): a question a run answers"
  say "{Q} is asked"

slot question_kind(Q: question, K: question_kind)
  means "question_kind(Q, K): the type of Q: doctrinal, governance, juridical, empirical"
  say "{Q} is a {K} question"

slot reading(S: source, R: reading)
  means "reading(S, R): R is a reading of S"
  say "{R} is a reading of {S}"

slot reads(S: source, R: reading, Q: question, V: value)
  means "reads(S, R, Q, V): read as R, S holds V on Q"
  say "read as {R}, {S} holds {V} on {Q}"

slot reaffirms(S: source, S2: source)
  means "reaffirms(S, S2): S re-teaches S2, with weight"
  say "{S} re-teaches {S2}"

slot received_creed(S: source)
  means "received_creed(S): S typed received with no claim and no date (refused)"
  say "{S} is typed received, with no claim and no date"

slot reception_claim(S: source, C: claimant, Y: year)
  means "reception_claim(S, C, Y): C claims the creed S received from year Y"
  say "{C} claims the creed {S} received from {Y}"

slot reception_fixed_by(S: source, F: source)
  means "reception_fixed_by(S, F): the act F hands the creed S on"
  say "{F} hands the creed {S} on"

slot records_diverse_readings(F: source, S: source)
  means "records_diverse_readings(F, S): F records diverse readings of S"
  say "{F} records diverse readings of {S}"

slot relaxed(S: source)
  means "relaxed(S): S dispensed, abrogated or changed: out of force"
  say "{S} is out of force: dispensed, abrogated or changed"

slot relies_on(A: claim, S: source)
  means "relies_on(A, S): the argument A relies on S"
  say "the argument {A} relies on {S}"

slot reprobated(C: custom)
  means "reprobated(C): the custom C reprobated by law (c. 24 §2)"
  say "the custom {C} is reprobated by law"

slot salience(S: source, Level: category)
  means "salience(S, high): S is prominent (warnings only)"
  say "{S} is of {Level} salience"

slot self_limited(S: source)
  means "self_limited(S): S's own text says it settles nothing, its manner of speaking (LG 25; TTC-MANNER)"
  say "{S} says of itself that it settles nothing"

slot self_limits(S: source, Q: question)
  means "self_limits(S, Q): S's own text says it settles nothing on Q (TTC-MANNER)"
  say "{S} says of itself that it settles nothing on {Q}"

slot particular_reply(S: source)
  means "particular_reply(S): S is a juridical answer given in a particular matter, to a bishop, a tribunal or a petitioner (c. 16 §3; TTC-REPLIES)"
  say "{S} is an answer given in a particular matter"

slot session_defines(S: source)
  means "session_defines(S): the session binds the chapter S (rule 14)"
  say "the session binds the chapter {S}"

slot source(S: source, T: tier, F: force, Y: year)
  means "source(S, T, F, Y): S at tier T (0-5), of force F (truth, juridical, protective), from year Y"
  say "{S} is a source at tier {T}, of force {F}, from {Y}"

slot supports(S: source, Q: question, V: value)
  means "supports(S, Q, V): S holds V on Q"
  say "{S} holds {V} on {Q}"

slot treated_as_binding_successors(S: source)
  means "treated_as_binding_successors(S): S read as binding the legislator's successors"
  say "{S} is read as binding the legislator's successors"

slot treated_as_fixing(C: source, S: source)
  means "treated_as_fixing(C, S): C's statement about S treated as fixing its tier (refused)"
  say "{C} is treated as fixing the tier of {S}"

slot value(Q: question, V: value)
  means "value(Q, V): V is an answer to Q"
  say "{V} is an answer to {Q}"

slot weight_tier(T: tier)
  means "weight_tier(T): a tier at which disagreement is weighed (3 to 5)"
  say "disagreement is weighed at tier {T}"

slot withdrawn(S: source, Y: year)
  means "withdrawn(S, Y): the text S replaced from year Y"
  say "the text {S} was replaced in {Y}"

slot witnessed_by(S: source, C: shown_condition, W: source)
  means "witnessed_by(S, C, W): the condition C of LG 25 shown for the claim on S by the witness W, apart from the claim (rule 14; TTC-WITNESS WN1)"
  say "for {S}, the condition {C} is shown by {W}"

result witness_is_claimant(S: source, C: shown_condition, W: source)
  say "the witness {W} entered for the condition {C} of {S} is the claim or one of its claimants: no witness in its own cause (rule 14)"

result communion_from_the_teaching(S: source, W: source)
  say "{W} shows the bishops in communion for {S} by counting their answer on the very teaching claimed: the claim proves itself (rule 14)"

result condition_without_witness(S: source, C: shown_condition)
  say "for {S}, the condition {C} of LG 25 is entered as shown, with no witness named (rule 14)"

result claim_unstated(S: source, C: claimant)
  say "{C} is entered as claiming {S} as ordinary universal magisterium, but is not entered as stating it in its own words"

result first_stated(S: source, C: claimant, Y: year)
  say "the claim on {S} is first stated in words by {C}, in {Y}"

result never_stated(S: source)
  say "no claimant is entered as stating in its own words the claim on {S}"

result claim_attributed(A: source, P: claimant, S: source)
  say "{A} states the claim on {S} in the name of {P}, who is not entered as stating it: the claim is the act's own"

```clingo

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
oum_unmet(S)        :- oum_claim(S,_), oum_condition(C), not shown_apart(S,C).
unshown_claim(S)    :- oum_holds(S), oum_unmet(S).
% TTC-WITNESS. The OUM has no act of its own: its conditions are a fact
% about many witnesses, each named (witnessed_by/3). A witness who is the claim,
% the consensus it claims, one of its claimants, or an act in a claimant's
% name is no witness in its own cause: "If I bear witness of myself, my
% witness is not true" (John 5:31). Communion counted by the bishops'
% answer on the very teaching claimed is the claim proving itself (WC2).
own_witness(S,S)    :- witnessed_by(S,_,S).
own_witness(S,W)    :- witnessed_by(S,_,W), W = oum(S).
own_witness(S,W)    :- witnessed_by(S,_,W), oum_claimant(S,W).
own_witness(S,W)    :- witnessed_by(S,_,W), claims_tier(W,S,_).
own_witness(S,W)    :- witnessed_by(S,_,W), claim_stated(S,W).
own_witness(S,W)    :- witnessed_by(S,_,W), in_name_of(W,P), oum_claimant(S,P).
violation(witness_is_claimant(S,C,W)) :- witnessed_by(S,C,W), oum_claim(S,_), own_witness(S,W).
judged_by_teaching(S,W) :- witnessed_by(S,dispersed_in_communion,W), communion_judged_by(W,Q), supports(S,Q,_).
violation(communion_from_the_teaching(S,W)) :- judged_by_teaching(S,W), oum_claim(S,_).
witness_refused(S,C,W) :- witnessed_by(S,C,W), own_witness(S,W).
witness_refused(S,dispersed_in_communion,W) :- judged_by_teaching(S,W).
shown_apart(S,C)    :- witnessed_by(S,C,W), oum_condition(C), not witness_refused(S,C,W).
condition_shown(S,C) :- shown_apart(S,C).   % one word for "shown": LG 25's, only by a witness apart
info(condition_without_witness(S,C)) :- oum_claim(S,_), oum_condition(C), condition_shown(S,C), not witnessed_by(S,C,_).
% The root of a claim (WR). Who states the claim in words, and who first;
% an act in another's name keeps its claims as its own (c. 131 §2; c. 360).
info(claim_unstated(S,C)) :- oum_claimant(S,C), not claim_stated(S,C).
stated_in(S,C,Y)    :- claim_stated(S,C), source(C,_,_,Y).
stated_earlier(S,C) :- stated_in(S,C,Y), stated_in(S,_,Y2), Y2 < Y.
info(first_stated(S,C,Y)) :- stated_in(S,C,Y), not stated_earlier(S,C).
info(never_stated(S)) :- oum_claim(S,_), not claim_stated(S,_).
info(claim_attributed(A,P,S)) :- in_name_of(A,P), claim_stated(S,A), not claim_stated(S,P).
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
```

slot particular_council(S: source)
  means "the source is a particular council's act (c. 753)"
  say "{S} is a particular council's act"

slot liturgical_witness(W: source)
  means "liturgy.lp: the prayer a liturgical book holds"
  say "{W} is the prayer of a liturgical book"

result invalid_lower_act(S: source, S2: source)
  say "{S}, a later act of a lower legislator against {S2}, is invalid (c. 135 §2)"

result limited(S: source, Q: question)
  say "{S} says of itself that it settles nothing on {Q}: it weighs and cleaves nothing there (TTC-MANNER)"

result limited_act(S: source)
  say "{S} says of itself that it settles nothing: nothing is owed to it by reference (TTC-MANNER)"

result weighs_only(S: source, Q: question)
  say "{S} answers a particular matter: on {Q} it weighs and cleaves nothing (c. 16 §3; TTC-REPLIES)"

result limit_on_a_definition(S: source)
  say "{S} is entered as settling nothing, but its form says it settles: refused (TTC-MANNER)"

```clingo
% The manner of speaking (LG 25; the notification of 16 November 1964, "from
% its manner of speaking"): the form sets the ceiling, and a text's own word
% about itself may lower how it uses its tier, never raise it (c. 749 §3).
% A tier-3 act that says it settles nothing weighs at its tier and cleaves
% nothing, as a particular council or a liturgical witness does, and c. 752
% attaches nothing to it. It reaches only the act: what the act cites or
% reaffirms keeps its own tier. Another text's lowering stays a claim
% (claims_tier/3). A definition's form says it settles: a limit on one is
% refused, and changes nothing (TTC-MANNER).
limited_act(S) :- self_limited(S), eff_tier(S,3).
limited(S,Q)   :- limited_act(S), supports(S,Q,_).
limited(S,Q)   :- self_limits(S,Q), supports(S,Q,_), eff_tier(S,3).
violation(limit_on_a_definition(S)) :- self_limited(S), in_force(S), eff_tier(S,T), T <= 2.
violation(limit_on_a_definition(S)) :- self_limits(S,_), in_force(S), eff_tier(S,T), T <= 2.

% A juridical answer given in a particular matter binds only there (c. 16 §3),
% and lex posterior is a rule of laws (c. 20): it weighs and never cleaves,
% at any rank. Not the act's own word, as limited/2 is, but the law's word on
% a reply's reach (TTC-REPLIES).
reply_bound(S) :- particular_reply(S), source(S,_,juridical,_).
info(weighs_only(S,Q)) :- reply_bound(S), supports(S,Q,_), in_force(S).

cleave_raw(S,Q) :- in_force(S), supports(S,Q,_), eff_tier(S,T), T >= 2, T <= 3,
                   not source(S,_,protective,_), not blocked(S,Q), not nonmagisterial(S), not particular_council(S),
                   not liturgical_witness(S), not empirical_q(Q), not limited(S,Q), not reply_bound(S).
cleave_raw(S,Q) :- in_force(S), supports(S,Q,_), source(S,_,juridical,_), not blocked(S,Q), not empirical_q(Q),
                   not reply_bound(S).

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
```

slot object_of(S: source, O: object)
  means "object_of(S, revealed | connected): what a defining act defines, as its text shows"
  say "{S} defines a truth {O}"

```clingo
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
% Nor is anything owed to a prayer as a teaching act (TTC-LITURGY LW5), nor to
% an act that says of itself that it settles nothing (TTC-MANNER).
owed(S,O) :- in_force(S), not governance(S), eff_tier(S,T), binds(L,T,O), in_force(L), not particular_council(S),
             not liturgical_witness(S), not limited_act(S).
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
% a particular reply weighs at its tier, though its force is juridical (TTC-REPLIES)
disagrees(S,T,Q) :- reply_bound(S), in_force(S), eff_tier(S,T), T >= 3,
                    supports(S,Q,W), holds(Q,V), W != V, not dependent(S,Q), not empirical_q(Q).
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
```
