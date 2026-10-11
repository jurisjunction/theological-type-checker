% ===================================================================
%  Canon law as rules: binary, dated, and graphed.
%
%  Given the facts and the norm in force, a juridical effect follows or
%  it does not. Nothing here is weighed. Uncertainty enters only in
%  three ways:
%    1. a disputed fact      disputed(F): the checker computes F and not-F
%    2. a disputed reading   canon_reading/2, used only where no authentic
%                            interpretation exists (c. 16 §1)
%    3. the internal forum   imputability, intention, belief: never
%                            computed, only supplied as input
%  Doctrine (the opinion of canonists) is not weight here. It may fill a
%  lacuna (c. 19), and never in a penal case.
%
%  Conventions (read by norms.py, the norm graph):
%    % @norm <id> | <citation> | <source URL>   rules below belong to <id>
%    % @input <name>/<arity> | <meaning>        a fact a case supplies
%  Dates are integers YYYYMMDD. Texts: Code of Canon Law, Book VI as
%  revised by Pascite gregem Dei (in force 8 December 2021); earlier
%  canons where an event predates the revision.
% ===================================================================

% ---------- Inputs ---------------------------------------------------------
% @input priest/1 | a priest
% @input bishop/1 | a bishop
% @input in_class/2 | in_class(Person, Class): e.g. the clergy of a society
% @input consecration/4 | consecration(Event, PrincipalConsecrator, Consecrated, Date)
% @input co_consecrator/2 | co_consecrator(Event, Bishop)
% @input pontifical_mandate/1 | the consecration had a pontifical mandate
% @input against_explicit_papal_will/1 | the act was done against the pope's expressed will
% @input decree/3 | decree(Decree, Issuer, Date)
% @input declares/3 | declares(Decree, Person, Norm): names a person and declares a penalty
% @input heard/2 | c. 1720 n. 1: accused informed of accusation and proofs, able to defend
% @input summoned_absent/2 | duly summoned and failed to appear
% @input recourse/3 | recourse(Decree, Person, Date)
% @input recourse_decided/2 | recourse_decided(Decree, Date)
% @input recourse_upheld/1 | the decree was annulled on recourse
% @input remission/4 | remission(Act, Person, Norm, Date): a censure remitted
% @input issuer/2 | issuer(Act, Authority)
% @input authority/2 | authority(A, Rank): 4 pope (or by papal mandate/approval), 3 dicastery, 1 ordinary
% @input grant/5 | grant(G, Issuer, Faculty, Class, Date)
% @input permission/4 | permission(P, Issuer, Class, Date): ordinaries may delegate for this class
% @input revocation/3 | revocation(Act, Grant, Date): an act purporting to revoke a grant
% @input absolution/4 | absolution(A, Priest, Penitent, Date)
% @input marriage/3 | marriage(M, AssistingPriest, Date)
% @input delegation/5 | delegation(D, Ordinary, Priest, MarriageOrGeneral, Date)
% @input ordinary/1 | a local ordinary
% @input danger_of_death/2 | danger_of_death(Penitent, Date)
% @input just_cause_request/3 | just_cause_request(Penitent, Priest, Date)
% @input common_error/1 | c. 144: common error or positive and probable doubt about this act
% @input appears_otherwise/2 | the external presumption of imputability is rebutted on the facts
% @input promulgated/2 | promulgated(Act, Date): a law, or an authentic interpretation in the form of law, published (cc. 7-8, 16 §2)
% @input vacatio_until/2 | vacatio_until(Law, Date): the law takes force on this date (c. 8 §1)
% @input enacted_by/2 | enacted_by(Body, Law): a body of norms enacted by this law
% @input part_of/2 | part_of(Norm, Body)
% @input interpretation_form/2 | interpretation_form(Act, law | particular): an authentic interpretation's form (c. 16 §§2-3)
% @input particular_matter/2 | particular_matter(Act, Event): the matter an act in a particular matter concerns (c. 16 §3)
% @input applies_reading/3 | applies_reading(Act, Canon, Reading): an act that applies this reading of a canon
% @input needs_reading/2 | needs_reading(Law, Context): the law's reading decides something here
% @input legislator/2 | legislator(Law, Authority)
% @input contrary_to_law/2 | contrary_to_law(L, H): a juridical finding that human law L contradicts human law H
% @input invalidating/1 | an invalidating or disqualifying law (c. 10)
% @input obliging/1 | a law that imposes an obligation
% @input permits/1 | a law that grants a permission
% @input fact_for/3 | fact_for(Law, X, Fact): whether the law reaches X turns on this fact
% @input lacuna/1 | lacuna(Matter): no custom and no express prescript (c. 19)
% @input penal_matter/1 | the matter is penal
% @input equity_rule/2 | equity_rule(Matter, Rule): a rule drawn by c. 19's means; supplied, never computed
% @input dispensation/3 | dispensation(Act, Law, X): a dispensation from Law for X
% @input defines_essentials/1 | the law defines what essentially constitutes an institute or juridic act (c. 86)
% @input doubtful_revocation/2 | doubtful_revocation(Later, Earlier): whether the later revokes the earlier is in doubt
% @input age_at/3 | age_at(Person, Act, Years): the agent's age when the act was placed
% @input juridic_act/2 | juridic_act(Act, Person): a juridic act placed by the person (c. 124)
% @input spouse/2 | spouse(Marriage, Person): one who gave consent to the marriage
% @input claims_necessity/2 | the agent publicly claims a state of necessity for the act
% @input asserts/3 | asserts(Text, Claim, Date): a text's claim about the juridical situation
% @input disputed/1 | a fact whose truth is disputed
% @input today/1 | the evaluation date when no asof is given
% @input authentic_reading/3 | authentic_reading(Canon, Reading, Act): the legislator's own reading (c. 16 §1)
% @input of_kind/2 | from the theological side (pair.lp): in this branch the event is classified as of this kind
% @input punishes_culpa/1 | c. 1321 §3: the law punishes this delict also when committed by culpability
% @input not_of_kind/2 | from the theological side (pair.lp): in this branch the event is classified as not of this kind
% @input notoriety_substitutes/2 | candidate only: notoriety treated as the hearing
% @input treated_as_declaring/2 | candidate only: a text's class statement treated as a declaration

event_date(E,T) :- consecration(E,_,_,T).
event_date(A,T) :- absolution(A,_,_,T).
event_date(M,T) :- marriage(M,_,T).
eval_date(T) :- today(T), not custom_asof.
eval_date(T) :- custom_asof, asof(Y), T = Y*10000 + 1231.
past(E) :- event_date(E,TE), eval_date(T), TE <= T.
% the instants at which status is computed: each act's date, and the evaluation date
instant(T) :- event_date(_,T).
instant(T) :- eval_date(T).
issued(D) :- decree(D,_,TD), eval_date(T), TD <= T.
asserted(S,X) :- asserts(S,X,TS), eval_date(T), TS <= T.
% c. 965: only a priest absolves; a bishop has the priesthood
priest(P) :- bishop(P).

% Disputed facts: each is computed both ways, and the branch says which.
{ heard(D,P) } :- disputed(heard(D,P)), issued(D).
{ common_error(A) } :- disputed(common_error(A)).
{ appears_otherwise(P,E) } :- disputed(appears_otherwise(P,E)).
{ interpretation_form(A,law) } :- disputed(interpretation_form(A,law)).
{ equity_rule(M,R) } :- disputed(equity_rule(M,R)).
assumed_fact(F)      :- disputed(F), F = interpretation_form(A,law), interpretation_form(A,law).
assumed_fact(false(F)) :- disputed(F), F = interpretation_form(A,law), not interpretation_form(A,law).
assumed_fact(F)      :- disputed(F), F = heard(D,P), issued(D), heard(D,P).
assumed_fact(false(F)) :- disputed(F), F = heard(D,P), issued(D), not heard(D,P).
assumed_fact(F)      :- disputed(F), F = common_error(A), common_error(A).
assumed_fact(false(F)) :- disputed(F), F = common_error(A), not common_error(A).
assumed_fact(F)      :- disputed(F), F = appears_otherwise(P,E), appears_otherwise(P,E).
assumed_fact(false(F)) :- disputed(F), F = appears_otherwise(P,E), not appears_otherwise(P,E).

% The penal norms, the bodies they belong to, and the laws that enacted them.
promulgated(code1983,19830125). vacatio_until(code1983,19831127).   % Sacrae disciplinae leges
promulgated(pgd2021,20210601).  vacatio_until(pgd2021,20211208).    % Pascite gregem Dei: Book VI revised
enacted_by(book6_1983,code1983). enacted_by(book6_2021,pgd2021).
part_of(n1382_1983,book6_1983). part_of(n1364_1983,book6_1983).
part_of(n1387,book6_2021). part_of(n1364,book6_2021). part_of(n1379,book6_2021).
norm_in_force(N,T) :- norm(N,F,U), event_date(_,T), F <= T, T < U.
% c. 751: one act, or a lasting state? Its reading decides schism.
reading_option(c751,act_suffices). reading_option(c751,lasting_state).
narrower(lasting_state,act_suffices).
needs_reading(c751,E) :- consecration(E,_,_,_), against_explicit_papal_will(E).

% ---------- Book I: general norms ------------------------------------------
% @norm cic:7 | c. 7: a law is established when it is promulgated; c. 8 §1: it takes force when its vacatio ends | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html
in_force_from(L,T) :- promulgated(L,_), vacatio_until(L,T).
norm(N,F,U)        :- part_of(N,B), enacted_by(B,L), in_force_from(L,F), reorders(L2,B), in_force_from(L2,U).
norm(N,F,99991231) :- part_of(N,B), enacted_by(B,L), in_force_from(L,F), not reordered(B).
reordered(B) :- reorders(_,B).

% @norm cic:20 | c. 20: a later law abrogates or derogates from an earlier one if it says so, is directly contrary to it, or completely reorders its matter | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html
reorders(pgd2021,book6_1983).

% @norm cic:21 | c. 21: in doubt the revocation of a pre-existing law is not presumed; later laws are harmonized with earlier ones | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html
info(revocation_not_presumed(L2,L)) :- doubtful_revocation(L2,L).

% @norm cic:16 | c. 16 §§1-3: the legislator interprets authentically; in the form of law the interpretation has the force of law and must be promulgated; in a sentence or an administrative act in a particular matter it binds only the persons and matters for which it was given | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html
authentic_reading(N,R,D) :- applies_reading(D,N,R), issuer(D,A), authority(A,4).
interpretation_form(A,particular) :- authentic_reading(_,_,A), not interpretation_form(A,law).
reading_binds(N,R,E) :- authentic_reading(N,R,A), interpretation_form(A,law), promulgated(A,_), needs_reading(N,E).
reading_binds(N,R,E) :- authentic_reading(N,R,A), interpretation_form(A,particular), particular_matter(A,E), needs_reading(N,E).
authentically_read(N,E) :- reading_binds(N,_,E).
read_for(N,R,E) :- reading_binds(N,R,E).

% @norm cic:17 | c. 17: laws are understood by the proper meaning of their words in text and context; if the meaning remains doubtful, by parallel places, purpose and circumstances, and the mind of the legislator | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html
% A disputed reading with no authentic interpretation branches (rule 2). The
% mind of the supreme legislator is presumed in harmony with the higher law:
% a reading on which his law contradicts it is excluded. A lower legislator's
% law keeps that reading, and on it does not bind (c. 135 §2; ST I-II q. 96 a. 4).
supreme_law(L) :- legislator(L,A), authority(A,4).
excluded_reading(L,R) :- reading_contrary(L,R,H), higher(H,L), supreme_law(L).
1 { read_for(L,R,E) : admissible(L,R) } 1 :- needs_reading(L,E), not authentically_read(L,E).

% @norm cic:18 | c. 18: laws which establish a penalty, restrict the free exercise of rights, or contain an exception are subject to strict interpretation | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html
% @input penal_use/1 | the law's terms set a penalty (or restrict rights, or make an exception)
:- read_for(L,R,E), penal_use(L), not authentically_read(L,E), admissible(L,R2), narrower(R2,R).
penal_use(c751).                                   % c. 1364 punishes the schismatic

% @norm cic:14 | c. 14: laws, even invalidating and disqualifying ones, do not oblige when there is a doubt about the law; in a doubt of fact ordinaries can dispense | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html
:- read_for(L,R,E), doubt_binds_strictly(L), not authentically_read(L,E), admissible(L,R2), narrower(R2,R).
doubt_binds_strictly(L) :- invalidating(L).
doubt_binds_strictly(L) :- obliging(L).
doubt_of_fact(L,X) :- fact_for(L,X,F), disputed(F).
info(ordinary_may_dispense(L,X)) :- doubt_of_fact(L,X), dispensable(L).

% @norm cic:19 | c. 19: where custom and express law are lacking, a case, unless it is penal, is resolved by laws in similar matters, general principles applied with canonical equity, the jurisprudence and practice of the Roman Curia, and the common opinion of the learned | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html
resolved_by(M,R) :- lacuna(M), equity_rule(M,R), not penal_matter(M).
violation(penalty_without_law(M)) :- lacuna(M), penal_matter(M), equity_rule(M,_).

% @norm cic:85 | c. 85: dispensation relaxes a merely ecclesiastical law in a particular case; c. 86: laws defining what essentially constitutes an institute or juridic act are not subject to dispensation | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann85-93_en.html
dispensable(L) :- law_kind(L,ecclesiastical), not defines_essentials(L).
dispensed(L,X) :- dispensation(_,L,X), dispensable(L).
violation(dispensing_divine_law(D,L))  :- dispensation(D,L,_), divine_law(L).
violation(dispensing_essentials(D,L))  :- dispensation(D,L,_), defines_essentials(L).
% @end
info(reading_excluded(L,R))  :- excluded_reading(L,R).
info(does_not_bind(L))       :- does_not_bind(L).
info(permitted(X,L))         :- permits(L), binds_on(L,X).
info(obliged(X,L))           :- obliging(L), binds_on(L,X).
info(invalid(X,L))           :- invalidating(L), binds_on(L,X).
info(resolved_by(M,R))       :- resolved_by(M,R).
info(dispensed(L,X))         :- dispensed(L,X).

% @norm cic:135 | c. 135 §2: a lower authority cannot validly act contrary to a higher one | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann129-144_en.html
higher(H,L) :- law_kind(H,ecclesiastical), law_kind(L,ecclesiastical), legislator(H,AH), legislator(L,AL),
               authority(AH,KH), authority(AL,KL), KH > KL.
contrary(L,H) :- contrary_to_law(L,H).
competent_revocation(R,G) :- revocation(R,G,_), issuer(R,A1), issuer(G,A2), authority(A1,K1), authority(A2,K2), K1 >= K2.
violation(ineffective_revocation(R,G)) :- revocation(R,G,_), not competent_revocation(R,G).

% @norm cic:333 | c. 333 §3: no appeal or recourse against a decision of the Roman Pontiff | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib2-cann330-367_en.html
papal_act(D) :- issuer(D,A), authority(A,4).

% @norm cic:125 | c. 125: an act placed out of force from without which could not be resisted is considered never to have taken place; one placed out of grave fear unjustly inflicted is valid unless the law provides otherwise, but can be rescinded by a judge | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann124-128_en.html
act_of(P,J) :- juridic_act(J,P).
never_placed(J) :- juridic_act(J,P), removes_voluntary(P,J,violence).
info(juridic_act(J,never_placed)) :- never_placed(J).
info(juridic_act(J,rescindable))  :- juridic_act(J,P), actus_humanus(P,J), grave_fear(P,J), fear_unjust(P,J).

% ---------- Book VI: delicts -----------------------------------------------
% Co-consecrators truly consecrate (Pius XII, Episcopalis consecrationis, 1944),
% so "a Bishop who consecrates" includes them on the plain meaning.
consecrates(E,B) :- consecration(E,B,_,_).
consecrates(E,B) :- co_consecrator(E,B).

% @norm cic1983:1382 | c. 1382 (1983): consecration without pontifical mandate | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
delict(B,n1382_1983,E) :- consecrates(E,B), event_date(E,T), not pontifical_mandate(E), norm_in_force(n1382_1983,T).
delict(R,n1382_1983,E) :- consecration(E,_,R,T), not pontifical_mandate(E), norm_in_force(n1382_1983,T).
penalty(n1382_1983,excommunication).

% @norm cic2021:1387 | c. 1387: consecrator and consecrated without pontifical mandate incur latae sententiae excommunication reserved to the Apostolic See | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
delict(B,n1387,E) :- consecrates(E,B), event_date(E,T), not pontifical_mandate(E), norm_in_force(n1387,T).
delict(R,n1387,E) :- consecration(E,_,R,T), not pontifical_mandate(E), norm_in_force(n1387,T).
penalty(n1387,excommunication).

% @norm cic:751 | c. 751: schism is the refusal of submission to the Supreme Pontiff | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib3-cann747-755_en.html
% Whether one act can constitute schism, or only a lasting state, is a
% reading of c. 751. Ecclesia Dei adflicta 3 (papal) applies it to the act.
schismatic_act(P,E) :- consecrates(E,P), against_explicit_papal_will(E), read_for(c751,act_suffices,E), not not_of_kind(E,schism).
schismatic_act(P,E) :- consecration(E,_,P,_), against_explicit_papal_will(E), read_for(c751,act_suffices,E), not not_of_kind(E,schism).

% @norm cic2021:1364 | c. 1364 §1: the schismatic incurs latae sententiae excommunication | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
delict(P,n1364,E) :- schismatic_act(P,E), event_date(E,T), norm_in_force(n1364,T).
delict(P,n1364_1983,E) :- schismatic_act(P,E), event_date(E,T), norm_in_force(n1364_1983,T).
penalty(n1364,excommunication). penalty(n1364_1983,excommunication).

% @temporal cic2021:1379
% @norm cic2021:1379 | c. 1379 §1 n. 2: one who cannot validly absolve and attempts absolution incurs latae sententiae interdict (a cleric also suspension) | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
delict(P,n1379,A) :- absolution(A,P,_,T), not valid_absolution(A), norm_in_force(n1379,T).
penalty(n1379,interdict).
element_of(n1379,cannot_absolve).                 % the delict's matter: one who cannot validly absolve

% ---------- Book VI: imputability, through the human act (act.lp) ---------
% Status is computed at each instant: an act is judged by the law and the
% juridical situation on its own date, not on the evaluation date. What the
% agent knew, willed or feared is never computed here: the library reads the
% claims a case supplies (interior/3), and the canons read the library.
% @norm cic2021:1321 | c. 1321 §§2-4 and c. 1322: no one is punished unless the external violation is gravely imputable by malice or culpability; culpability is punished only where the law provides; once the violation is established imputability is presumed unless it appears otherwise; the habitually insane are incapable | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html
act_of(P,E) :- delict(P,_,E).
imputed(P,N,E) :- delict(P,N,E), not appears_otherwise(P,E), actus_humanus(P,E),
                  not exempt(P,E), not unpunished_culpa(P,N,E).
unpunished_culpa(P,N,E) :- delict(P,N,E), culpa(P,E), not punishes_culpa(N).
incurred_at(P,N,E,T) :- imputed(P,N,E), event_date(E,TE), instant(T), TE <= T,
                        not remitted_at(P,N,E,T), not latae_excused(P,N,E).
presumed_incurred(P,N,E) :- incurred_at(P,N,E,T), eval_date(T).
info(not_a_human_act(P,E)) :- delict(P,_,E), not actus_humanus(P,E).
info(dolus(P,E))           :- delict(P,_,E), dolus(P,E).
info(culpa_not_punished(P,N,E)) :- unpunished_culpa(P,N,E).

% @norm cic2021:1323 | c. 1323: not subject to a penalty: one under sixteen; one ignorant without fault of violating the law (inadvertence and error equivalent); physical force or unforeseeable chance; grave fear, necessity or grave inconvenience unless the act is intrinsically evil or tends to the harm of souls; due self-defence; lack of reason; one who thought without fault that the circumstances of nn. 4-5 existed | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html
exempt(P,E) :- delict(P,_,E), age_at(P,E,Y), Y < 16.                                   % n. 1
exempt(P,E) :- delict(P,_,E), ignorant_without_fault(P,E,law).                          % n. 2
exempt(P,E) :- delict(P,N,E), ignorant_without_fault(P,E,fact(C)), element_of(N,C).     % n. 2: unaware he violated it
exempt(P,E) :- delict(P,_,E), chance(P,E).                                               % n. 3 (force: no human act)
exempt(P,E) :- delict(P,_,E), fear_or_necessity(P,E), not grave_matter(E).               % n. 4
exempt(P,E) :- delict(P,_,E), due_defence(P,E).                                          % n. 5
exempt(P,E) :- delict(P,_,E), believed(P,E,C,invincible), excusing(C).                   % n. 7
fear_or_necessity(P,E) :- grave_fear(P,E).
fear_or_necessity(P,E) :- necessity(P,E).
excusing(fear). excusing(necessity). excusing(defence).
grave_matter(E) :- of_kind(E,intrinsically_evil).
grave_matter(E) :- of_kind(E,harm_of_souls).
info(exempt(P,E)) :- exempt(P,E).

% @norm cic2021:1324 | c. 1324 §1 nn. 1, 3, 4, 5, 8, 9 and §3: imperfect use of reason; undeliberate grave passion; a minor over sixteen; grave fear or necessity where the act is intrinsically evil or harmful to souls; culpably mistaken circumstances of c. 1323 nn. 4-5; ignorance without fault of the penalty: the penalty is tempered, and no latae sententiae penalty binds | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html
mitigated(P,E,imperfect_reason) :- delict(P,_,E), imperfect_reason(P,E).                % n. 1
mitigated(P,E,passion)          :- delict(P,_,E), undeliberate_passion(P,E).            % n. 3
mitigated(P,E,minor)            :- delict(P,_,E), age_at(P,E,Y), 16 <= Y, Y < 18.       % n. 4
mitigated(P,E,fear)             :- delict(P,_,E), fear_or_necessity(P,E), grave_matter(E). % n. 5
mitigated(P,E,mistaken)         :- delict(P,_,E), believed(P,E,C,vincible), excusing(C). % n. 8
mitigated(P,E,penalty_unknown)  :- delict(P,_,E), ignorant_without_fault(P,E,penalty).  % n. 9
latae_excused(P,N,E) :- delict(P,N,E), mitigated(P,E,_), latae_sententiae(N).           % §3
% each of these canons says "latae sententiae": 1983 cc. 1382, 1364 §1; 2021 cc. 1387, 1364 §1, 1379 §1
latae_sententiae(n1382_1983;n1364_1983;n1387;n1364;n1379).

% @norm cic2021:1325 | c. 1325: crass, supine or affected ignorance is never taken into account in applying cc. 1323 and 1324 | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html
info(ignorance_disregarded(P,E,Of)) :- delict(P,_,E), gross_ignorance(P,E,Of).
% @end
info(mitigated(P,E,W)) :- mitigated(P,E,W), imputed(P,_,E).
% Whether necessity existed, or was believed in, is about the agent. A public
% claim of necessity is recorded; the checker never decides it.
info(defence_claimed(P)) :- claims_necessity(P,E), presumed_incurred(P,_,E).

% @norm cic:1355 | remission of a censure | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html
remitted_at(P,N,E,T) :- remission(_,P,N,TR), delict(P,N,E), event_date(E,TE), TE <= TR, instant(T), TR <= T.

% ---------- Book VI and VII: declaring a penalty ------------------------------
% @norm cic:1717 | c. 1717 §1: the preliminary investigation may be omitted if it seems entirely superfluous | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib7-cann1717-1731_en.html
info(investigation_dispensable(D,P)) :- declares(D,P,N), issued(D), delict(P,N,E), public_act(P,E).
public_act(P,E) :- delict(P,_,E), consecration(E,_,_,_).          % a public liturgical act

% @norm cic2021:1342 | c. 1342 §1 with c. 1720 n. 1: a penalty declared by decree requires that the accused be heard, unless duly summoned and absent | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib7-cann1717-1731_en.html
hearing_ok(D,P) :- heard(D,P).
hearing_ok(D,P) :- summoned_absent(D,P).
hearing_ok(D,P) :- notoriety_substitutes(D,P).
% Notoriety proves the act; it does not hear the person (c. 1717 §1 may
% dispense the investigation, never c. 1720 n. 1).
violation(notoriety_for_hearing(D,P)) :- notoriety_substitutes(D,P).
% A decree is presumed valid (c. 124 §2) until annulled. A missing hearing
% is a ground for recourse, not a non-existent decree.
info(ground_for_recourse(D,P,c1720)) :- declares(D,P,_), issued(D), not hearing_ok(D,P).

% @norm cic2021:1353 | c. 1353: recourse against a decree declaring a penalty has suspensive effect | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html
recourse_admissible(D) :- recourse(D,_,_), not papal_act(D).
issued_at(D,T)    :- decree(D,_,TD), instant(T), TD <= T.
decided_at(D,T)   :- recourse_decided(D,TD), instant(T), TD <= T.
suspended_at(D,T) :- recourse_admissible(D), recourse(D,_,TR), instant(T), TR <= T, not decided_at(D,T).
annulled(D) :- recourse_upheld(D).
declared_at(P,N,T) :- declares(D,P,N), issued_at(D,T), not suspended_at(D,T), not annulled(D).
declared_effective(P,N) :- declared_at(P,N,T), eval_date(T).
info(declared(P,N)) :- declared_effective(P,N).
info(declaration_suspended(D,P)) :- declares(D,P,_), suspended_at(D,T), eval_date(T).
info(presumed_incurred(P,N)) :- presumed_incurred(P,N,_).
% a declared title the norms do not derive (on the readings in force) is a ground to examine
info(title_not_derived(D,P,N)) :- declares(D,P,N), issued(D), not delict_title(P,N).
delict_title(P,N) :- delict(P,N,_).

% ---------- Book VI: effects of excommunication ----------------------------
% @norm cic2021:1331 | c. 1331 §1 n. 1: an excommunicated person may not celebrate the sacraments; §2 n. 2: once declared, his acts of governance are invalid | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html
excommunicated_at(P,T) :- incurred_at(P,N,_,T), penalty(N,excommunication).
governance_invalid_at(P,T) :- declared_at(P,N,T), penalty(N,excommunication).

% @norm cic2021:1335 | c. 1335 §2: the prohibition yields for the dying, and, while the censure is undeclared, to a just-cause request | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html
declared_any_at(P,T) :- declared_at(P,_,T).
prohibition_lifted(P,A) :- absolution(A,P,Pen,T), danger_of_death(Pen,T).
prohibition_lifted(P,A) :- absolution(A,P,Pen,T), just_cause_request(Pen,P,T), not declared_any_at(P,T).

% ---------- Book IV: faculties ----------------------------------------------
% @norm grants | a grant of faculty lasts until revoked by a competent authority ("until further provisions are made") | https://www.vatican.va/content/francesco/en/apost_letters/documents/papa-francesco-lettera-ap_20161120_misericordia-et-misera.html
revoked_at(G,T) :- revocation(R,G,TR), competent_revocation(R,G), instant(T), TR <= T.
grant_in_force_at(G,T) :- grant(G,_,_,_,TG), instant(T), TG <= T, not revoked_at(G,T).
faculty_at(P,F,T) :- grant(G,_,F,C,_), in_class(P,C), grant_in_force_at(G,T).
permission_in_force_at(Perm,T) :- permission(Perm,_,_,TP), instant(T), TP <= T, not revoked_at(Perm,T).
class_faculty(C,F) :- grant(G,_,F,C,_), grant_in_force_at(G,T), eval_date(T).
class_permission(C,marriage) :- permission(Perm,_,C,_), permission_in_force_at(Perm,T), eval_date(T).
info(class_faculty(C,F)) :- class_faculty(C,F).
info(class_may_receive_delegation(C,marriage)) :- class_permission(C,marriage).

% @norm cic:966 | c. 966 §1: valid absolution requires orders and the faculty; c. 976: any priest absolves the dying; c. 144 §2: the Church supplies in common error | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann959-997_en.html
valid_absolution(A) :- absolution(A,P,_,T), priest(P), faculty_at(P,confession,T), not governance_invalid_at(P,T).
valid_absolution(A) :- absolution(A,P,Pen,T), priest(P), danger_of_death(Pen,T).
valid_absolution(A) :- absolution(A,P,_,_), priest(P), common_error(A).
licit_absolution(A) :- valid_absolution(A), absolution(A,P,_,T), not excommunicated_at(P,T).
licit_absolution(A) :- valid_absolution(A), absolution(A,P,_,_), prohibition_lifted(P,A).
% @end
info(absolution(A,valid,licit))   :- absolution(A,_,_,_), past(A), valid_absolution(A), licit_absolution(A).
info(absolution(A,valid,illicit)) :- absolution(A,_,_,_), past(A), valid_absolution(A), not licit_absolution(A).
info(absolution(A,invalid))       :- absolution(A,_,_,_), past(A), not valid_absolution(A).
info(delict(P,N,E)) :- delict(P,N,E), past(E).

% @norm cic:1108 | c. 1108 §1 and c. 1111: the form requires assistance by the ordinary, the pastor, or a priest delegated by either; c. 144 §2 | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1108-1123_en.html
delegated(P,M) :- marriage(M,P,T), delegation(_,O,P,M,TD), ordinary(O), TD <= T.
delegated(P,M) :- marriage(M,P,T), delegation(_,O,P,general,TD), ordinary(O), TD <= T.
valid_form(M) :- marriage(M,P,T), delegated(P,M), not governance_invalid_at(P,T).
valid_form(M) :- marriage(M,_,_), common_error(M).
% @end
info(marriage(M,valid_form))   :- marriage(M,_,_), past(M), valid_form(M).
info(marriage(M,invalid_form)) :- marriage(M,_,_), past(M), not valid_form(M).

% @norm cic:1103 | c. 1103: a marriage is invalid if entered into because of force or grave fear from without, even when inflicted unintentionally, so that a person is compelled to choose marriage in order to be freed from it | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1095-1107_en.html
act_of(P,M) :- spouse(M,P).
consent_vitiated(M) :- spouse(M,P), removes_voluntary(P,M,violence).
consent_vitiated(M) :- spouse(M,P), actus_humanus(P,M), grave_fear(P,M), fear_from_without(P,M), chosen_to_escape(P,M).
info(marriage(M,invalid_consent)) :- consent_vitiated(M).

% ---------- Texts checked against the derivation ------------------------------
% @norm checking | a text's claims compared with what the norms derive | -
% A text's claim about the juridical situation is compared with what the
% norms derive for each concrete act. Disagreement is a question, not a
% verdict: either the text supplies a fact or norm the encoding lacks, or
% the text is wrong.
claim_target(A,invalid_absolution(C)) :- absolution(A,P,_,_), in_class(P,C).
claim_target(M,invalid_marriage(C))   :- marriage(M,P,_), in_class(P,C).
claim_holds(A,invalid_absolution(C)) :- claim_target(A,invalid_absolution(C)), not valid_absolution(A).
claim_holds(M,invalid_marriage(C))   :- claim_target(M,invalid_marriage(C)), not valid_form(M).
info(claim_confirmed(S,X,A))    :- asserted(S,X), asserts(S,X,TS), claim_target(A,X), event_date(A,T), T >= TS, past(A), claim_holds(A,X).
info(claim_contradicted(S,X,A)) :- asserted(S,X), asserts(S,X,TS), claim_target(A,X), event_date(A,T), T >= TS, past(A), not claim_holds(A,X).

% A statement about a class is not a declaration about any person in it.
info(class_statement_not_declaration(S,C)) :- asserted(S,status(C,_)), not declares(S,_,_).
violation(collective_declaration(S,C)) :- treated_as_declaring(S,C), asserts(S,status(C,_),_).

#show assumed_fact/1.
