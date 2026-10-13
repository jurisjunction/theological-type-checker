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
% @input vacatio_set/2 | vacatio_set(Law, Date): the law names its own date of force (c. 8 §1, another vacatio)
% @input aas_issue/2 | aas_issue(Law, Date): the date the issue of the Acta Apostolicae Sedis carrying the law bears (c. 8 §1)
% @input aas_volume/3 | aas_volume(Law, Year, Given): the issue unread; its volume's year and the date the act was given
% @input born/2 | born(Person, Date): a birth date (c. 97, with c. 203)
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
% @input age_at/3 | age_at(Person, Act, Years): the agent's age when the act was placed, where no birth date is given
% @input juridic_act/2 | juridic_act(Act, Person): a juridic act placed by the person (c. 124)
% @input spouse/2 | spouse(Marriage, Person): one who gave consent to the marriage
% @input claims_necessity/2 | the agent publicly claims a state of necessity for the act
% @input asserts/3 | asserts(Text, Claim, Date): a text's claim about the juridical situation
% @input disputed/1 | a fact whose truth is disputed
% @input today/1 | the evaluation date when no asof is given
% @input authentic_reading/3 | authentic_reading(Canon, Reading, Act): the legislator's own reading (c. 16 §1)
% @input of_kind/2 | from the theological side (pair.lp): in this branch the event is classified as of this kind
% @input punishes_culpa/1 | c. 1321 §3: the law punishes this delict also when committed by culpability
% @input communion/3 | communion(C, Person, Date): holy communion received, or sought
% @input situation/2 | situation(Person, S): an outward situation of the person
% @input situation_kind/2 | situation_kind(S, Kind): the kind of act or state the situation is
% @input manifest/1 | manifest(S): the situation is publicly known
% @input persisting/1 | persisting(S): the situation endures and is not ended
% @input confession_impossible/2 | confession_impossible(P, C): a grave reason, and no opportunity to confess (c. 916)
% @input grave_by_matter/1 | moral.lp: a kind grave by its matter, from the theological side
% @input not_of_kind/2 | from the theological side (pair.lp): in this branch the event is classified as not of this kind
% @input notoriety_substitutes/2 | candidate only: notoriety treated as the hearing
% @input treated_as_declaring/2 | candidate only: a text's class statement treated as a declaration
% @input unbaptized/1 | the person is recorded as not baptized (c. 842 §1)
% @input dissolution/4 | dissolution(D, Marriage, non_consummation | favour_of_faith | Other, Date): an act that dissolves a bond
% @input consummated/1 | the marriage was consummated (c. 1061 §1)
% @input nullity_sentence/3 | nullity_sentence(S, Marriage, Date): a sentence declaring a marriage null
% @input sentence_effective/1 | the sentence has become effective (c. 1679)
% @input prohibited_to_marry/1 | a prohibition attached to the sentence or set by the local ordinary (c. 1682 §1)
% @input delict_act/3 | delict_act(Person, Norm, Act): an external violation of the norm, as a case records it (a delict that need not be a consecration, absolution or marriage)
% @input act_date/2 | act_date(Act, Date): the date of an act a case records
% @input seal_lifted/2 | seal_lifted(Act, Why): a candidate's claim that something released the confessor
% @input baptized_in/2 | baptized_in(Person, catholic | Community): a baptism the case records, its validity presumed
% @input received_into/1 | the person was received into the Catholic Church
% @input formal_defection/2 | formal_defection(Person, Date): a formal act of defection (cc. 1086 §1, 1117, 1124, 1983-2009)
% @input communion_at_issue/1 | the case asks after the person's communion
% @input professes/4 | professes(Person, Act, Q, V): in the act the person publicly holds V on Q (faith.lp)
% @input doubts/3 | doubts(Person, Act, Q): in the act the person publicly doubts the question
% @input repudiates/3 | repudiates(Person, Act, christian_faith): an outward repudiation of the faith as a whole
% @input warned/3 | warned(Person, Act, apostolic_see | ordinary): a warning given about the act
% @input retracted/2 | retracted(Person, Act)
% @input owed/2 | from the authority graph: the assent a canon attaches to a teaching act by reference (cc. 750, 752)
% @input supports/3 | from the authority graph
% @input law_kind/2 | law.lp: the kind of a law
% @input interior/3 | act.lp: a claim about the agent (here, pertinacious)

event_date(E,T) :- consecration(E,_,_,T).
event_date(A,T) :- absolution(A,_,_,T).
event_date(M,T) :- marriage(M,_,T).
event_date(E,T) :- act_date(E,T).
eval_date(T) :- now(T).                         % the one clock (saeculum.lp)
past(E) :- event_date(E,TE), eval_date(T), TE <= T.
% the instants at which status is computed: each act's date, and the evaluation date
instant(T) :- event_date(_,T).
instant(T) :- eval_date(T).
% what the law asks of the calendar (c. 203): c. 8 §1's three months from
% an issue, or from each end of an unread issue's span; and completed years
months_asked(D,3)             :- aas_issue(_,D).
months_asked(G,3)             :- aas_volume(_,_,G).
months_asked(Y*10000+1231,3)  :- aas_volume(_,Y,_).
years_asked(B,T)              :- born(_,B), event_date(_,T), B <= T.
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
{ excluded_reading(L,R) } :- disputed(excluded_reading(L,R)).
{ declaratory(A) } :- disputed(declaratory(A)), interpretation_form(A,law).
{ necessary_assistance(P,A) } :- disputed(necessary_assistance(P,A)).
{ issuer(D,A) } :- disputed(issuer(D,A)).
assumed_fact(F)      :- disputed(F), F = declaratory(A), interpretation_form(A,law), declaratory(A).
assumed_fact(false(F)) :- disputed(F), F = declaratory(A), interpretation_form(A,law), not declaratory(A).
assumed_fact(F)      :- disputed(F), F = necessary_assistance(P,A), necessary_assistance(P,A).
assumed_fact(false(F)) :- disputed(F), F = necessary_assistance(P,A), not necessary_assistance(P,A).
assumed_fact(F)      :- disputed(F), F = issuer(D,A), issuer(D,A).
assumed_fact(false(F)) :- disputed(F), F = issuer(D,A), not issuer(D,A).
assumed_fact(F)      :- disputed(F), F = interpretation_form(A,law), interpretation_form(A,law).
assumed_fact(false(F)) :- disputed(F), F = interpretation_form(A,law), not interpretation_form(A,law).
assumed_fact(F)      :- disputed(F), F = excluded_reading(L,R), excluded_reading(L,R).
assumed_fact(false(F)) :- disputed(F), F = excluded_reading(L,R), not excluded_reading(L,R).
assumed_fact(F)      :- disputed(F), F = heard(D,P), issued(D), heard(D,P).
assumed_fact(false(F)) :- disputed(F), F = heard(D,P), issued(D), not heard(D,P).
assumed_fact(F)      :- disputed(F), F = common_error(A), common_error(A).
assumed_fact(false(F)) :- disputed(F), F = common_error(A), not common_error(A).
assumed_fact(F)      :- disputed(F), F = appears_otherwise(P,E), appears_otherwise(P,E).
assumed_fact(false(F)) :- disputed(F), F = appears_otherwise(P,E), not appears_otherwise(P,E).

% The penal norms, the bodies they belong to, and the laws that enacted them.
promulgated(code1983,19830125). vacatio_set(code1983,19831127).     % Sacrae disciplinae leges: the First Sunday of Advent
promulgated(pgd2021,20210601).  vacatio_set(pgd2021,20211208).      % Pascite gregem Dei, art. 2: Book VI revised
enacted_by(book6_1983,code1983). enacted_by(book6_2021,pgd2021).
part_of(n1382_1983,book6_1983). part_of(n1364_1983,book6_1983).
part_of(n1387,book6_2021). part_of(n1364,book6_2021). part_of(n1379,book6_2021). part_of(n1386,book6_2021).
part_of(n1365,book6_2021).
part_of(n1398_1983,book6_1983). part_of((n1397;n1398_1;n1399),book6_2021).
% each of these canons says "latae sententiae": 1983 cc. 1382, 1364 §1, 1398;
% 2021 cc. 1387, 1364 §1, 1379 §1, 1386 §1, 1397 §2
latae_sententiae(n1382_1983;n1364_1983;n1387;n1364;n1379;n1386;n1398_1983;n1397).
% Abortion: the term's readings (c. 17), and the authentic interpretation of
% 1988 (c. 16 §2): extensive, on the canonists' common reading and on its own
% text (asked whether abortion is only the expulsion of the immature fetus, it
% answers "Negative"), so not declaratory and not retroactive (TTC-PENAL AB8).
reading_option(abortion,expulsion). reading_option(abortion,killing). narrower(expulsion,killing).
penal_use(abortion).
needs_reading(abortion,A) :- killing_of_unborn(A), event_date(A,_).
applies_reading(pclt1988,abortion,killing). issuer(pclt1988,john_paul_ii). authority(john_paul_ii,4).
interpretation_form(pclt1988,law).
promulgated(pclt1988,19880523). aas_volume(pclt1988,1988,19880523).  % AAS 80 (1988) 1818-1819, the issue's date unread (c. 8 §1)
% c. 1371 n. 1: the Code's text until Ad tuendam fidem, the amended text until Pascite gregem Dei
promulgated(atf1998,19980518). aas_volume(atf1998,1998,19980518).   % names no date; AAS 90 (1998) 457-461, the issue's date unread (c. 8 §1)
enacted_by(c1371_text_1983,code1983). enacted_by(c1371_text_1998,atf1998).
part_of(n1371_1983,c1371_text_1983). part_of(n1371_1998,c1371_text_1998).
% c. 751: one act, or a lasting state? Its reading decides schism.
reading_option(c751,act_suffices). reading_option(c751,lasting_state).
narrower(lasting_state,act_suffices).
needs_reading(c751,E) :- consecration(E,_,_,_), against_explicit_papal_will(E).
% c. 915: "manifest grave sin", objectively or subjectively? The Pontifical
% Council's declaration (24 June 2000) applies the objective reading; it is not
% an authentic interpretation (c. 16 §1; Pastor bonus art. 155). Whether the
% subjective reading is admissible at all is disputed.
reading_option(c915,objective). reading_option(c915,subjective).
narrower(subjective,objective).
applies_reading(pclt2000,c915,objective). issuer(pclt2000,pclt). authority(pclt,3).
disputed(excluded_reading(c915,subjective)) :- needs_reading(c915,_).
needs_reading(c915,S) :- situation(_,S), manifest(S), persisting(S).

% ---------- Book I: general norms ------------------------------------------
% @norm cic:7 | c. 7: a law is established when it is promulgated; c. 8 §1: universal laws are promulgated in the Acta Apostolicae Sedis and take force only after three months have elapsed from the date of that issue, unless they bind at once from the nature of the matter or the law sets a shorter or longer vacatio | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html
% The issue's date counts as a whole day (c. 203 §1, its beginning the
% day's): the months end at the close of the day before the day of the same
% number, and the law binds from that day. So a canonist computes Omnium in
% mentem, issue of 8 January 2010, in force 8 April 2010 (TTC-SAECULUM CT1).
in_force_from(L,T) :- promulgated(L,_), vacatio_set(L,T).
in_force_from(L,T) :- aas_issue(L,D), not vacatio_set(L,_), same_number_after(D,3,T).
% An issue unread lies between the act's own date and its volume's last
% day; force, between three months after each. Inside that span the date
% is a fact not fixed by the record, computed both ways (rule 2; CT3).
force_window(L,T1,T2) :- aas_volume(L,Y,G), not aas_issue(L,_), not vacatio_set(L,_),
                         same_number_after(G,3,T1), same_number_after(Y*10000+1231,3,T2).
has_force_date(L) :- in_force_from(L,_).
has_force_date(L) :- force_window(L,_,_).
force_at(L,T) :- in_force_from(L,F), instant(T), F <= T.
force_at(L,T) :- force_window(L,_,T2), instant(T), T2 <= T.
{ force_at(L,T) } :- force_window(L,T1,T2), instant(T), T1 <= T, T < T2.
:- force_at(L,T), instant(T2), T < T2, not force_at(L,T2).      % once in force, in force after
assumed_fact(force_by(L,T))        :- force_window(L,T1,T2), instant(T), T1 <= T, T < T2, force_at(L,T).
assumed_fact(false(force_by(L,T))) :- force_window(L,T1,T2), instant(T), T1 <= T, T < T2, not force_at(L,T).
norm_in_force(N,T) :- part_of(N,B), enacted_by(B,L), force_at(L,T), event_date(_,T), not abrogated_at(B,T).
abrogated_at(B,T)  :- reorders(L2,B), force_at(L2,T).

% @norm cic:203 | cc. 200-203: time is computed by these canons unless the law provides otherwise; a day is 24 hours from midnight, continuous months and years as in the calendar (c. 202); the day a quo is not counted unless its beginning coincides with the beginning of the day; a term of months or years ends at the close of the last day of the same number or, if the month lacks it, of the last day of the month (c. 203) | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann200-203_en.html
% The day of the same number N calendar months after D; where the month
% lacks it, its term closes with the month and the next day is the first.
cal_year(Y2) :- months_asked(D,N), Y2 = D/10000 + ((D/100)\100 - 1 + N)/12.
same_number_after(D,N,R) :- months_asked(D,N), M2 = (D/100)\100 - 1 + N, Y2 = D/10000 + M2/12, M3 = M2\12 + 1,
                            days_in(Y2,M3,L), D\100 <= L, R = Y2*10000 + M3*100 + D\100.
same_number_after(D,N,R) :- months_asked(D,N), M2 = (D/100)\100 - 1 + N, Y2 = D/10000 + M2/12, M3 = M2\12 + 1,
                            days_in(Y2,M3,L), D\100 > L, R = Y2*10000 + (M3+1)*100 + 1.   % never December, which lacks no day
% Years completed at a date: the day of birth is not counted (birth does
% not begin with the day), and a year closes with the day of the same
% number; on the birthday itself it is not yet completed. One born on 29
% February completes a year in a common year at the close of 28 February.
completed_years(B,T,N) :- years_asked(B,T), T\10000 <= B\10000, N = T/10000 - B/10000 - 1.
completed_years(B,T,N) :- years_asked(B,T), T\10000 >  B\10000, N = T/10000 - B/10000.

% @norm cic:97 | c. 97 §1: one who has completed the eighteenth year of age is an adult; below this age, a minor; ages are counted under c. 203 | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann96-123_en.html
age_at(P,A,N) :- born(P,B), event_date(A,T), completed_years(B,T,N).

% @norm cic:20 | c. 20: a later law abrogates or derogates from an earlier one if it says so, is directly contrary to it, or completely reorders its matter | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html
reorders(pgd2021,book6_1983).
reorders(atf1998,c1371_text_1983). reorders(pgd2021,c1371_text_1998).

% @norm cic:21 | c. 21: in doubt the revocation of a pre-existing law is not presumed; later laws are harmonized with earlier ones | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html
info(revocation_not_presumed(L2,L)) :- doubtful_revocation(L2,L).

% @norm cic:16 | c. 16 §§1-3: the legislator interprets authentically; in the form of law the interpretation has the force of law and must be promulgated; if it only declares words certain in themselves it is retroactive, if it restricts, extends or explains a doubtful law it is not; in a sentence or an administrative act in a particular matter it binds only the persons and matters for which it was given; with c. 9: laws regard the future, not the past, unless they expressly provide for the past | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html
% @input declaratory/1 | c. 16 §2: the interpretation only declares words of the law certain in themselves (so retroactive)
authentic_reading(N,R,D) :- applies_reading(D,N,R), issuer(D,A), authority(A,4).
interpretation_form(A,particular) :- authentic_reading(_,_,A), not interpretation_form(A,law).
% In the form of law it reaches the acts placed from its force on (c. 8 §1),
% and an earlier act only where it is declaratory: the past is the exception
% (c. 9). A lasting situation with no date of its own is judged now.
% (TTC-PENAL AB8: the dates were recorded, never compared.)
dated(E) :- event_date(E,_).
reaches_act(A,E) :- force_at(A,T), needs_reading(_,E), event_date(E,T).
reaches_act(A,E) :- force_at(A,T), needs_reading(_,E), not dated(E), eval_date(T).
reaches_act(A,E) :- has_force_date(A), needs_reading(_,E), not dated(E), not has_eval_date.   % no clock: the present
has_eval_date :- eval_date(_).
reaches_act(A,E) :- declaratory(A), needs_reading(_,E).
reading_binds(N,R,E) :- authentic_reading(N,R,A), interpretation_form(A,law), needs_reading(N,E), reaches_act(A,E).
reading_binds(N,R,E) :- authentic_reading(N,R,A), interpretation_form(A,particular), particular_matter(A,E), needs_reading(N,E).
info(not_retroactive(A,E)) :- authentic_reading(N,_,A), interpretation_form(A,law), needs_reading(N,E), not reaches_act(A,E).
violation(interpretation_without_force(A)) :- authentic_reading(_,_,A), interpretation_form(A,law), not has_force_date(A).
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
% @input penal_use/1 | the law's terms set a penalty (or make an exception)
% @input restricts_rights/1 | the law restricts the free exercise of a right
strict(L) :- penal_use(L).
strict(L) :- restricts_rights(L).
:- read_for(L,R,E), strict(L), not authentically_read(L,E), admissible(L,R2), narrower(R2,R).
penal_use(c751).                                   % c. 1364 punishes the schismatic
info(declined_by_strict_interpretation(L,R,E)) :- needs_reading(L,E), strict(L), not authentically_read(L,E),
                                                  admissible(L,R), admissible(L,R2), narrower(R2,R).

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

% @norm cic:113 | c. 113: the Catholic Church and the Apostolic See have the character of a moral person by divine ordinance itself; in the Church, besides physical persons, there are juridic persons, subjects of obligations and rights which correspond to their nature; c. 114 §1: constituted by law or by decree; c. 118: represented by those whose competence is acknowledged; c. 120 §1: perpetual by nature | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann96-123_en.html
% A juridic person is a unity of order, not a substance (In I Ethic. lect. 1;
% CCC 1880): it acts through those who represent it (act.lp), and bears no
% interior, no sin, no delict. Innocent IV, Romana ecclesia (VI 5.11.5): "In
% universitatem vel collegium proferri excommunicationis sententiam penitus
% prohibemus." (TTC-PENAL FL)
moral_person(catholic_church). moral_person(apostolic_see).
violation(delict_of_fiction(J,N,E)) :- fiction(J), delict(J,N,E).

% @norm cic:125 | c. 125: an act placed out of force from without which could not be resisted is considered never to have taken place; one placed out of grave fear unjustly inflicted is valid unless the law provides otherwise, but can be rescinded by a judge | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann124-128_en.html
act_of(P,J) :- juridic_act(J,P).
never_placed(J) :- juridic_act(J,P), removes_voluntary(P,J,violence).
info(juridic_act(J,never_placed)) :- never_placed(J).
info(juridic_act(J,rescindable))  :- juridic_act(J,P), actus_humanus(P,J), grave_fear(P,J), fear_unjust(P,J).

% ---------- Books I and II: who is bound; incorporation; communion (TTC-COMMUNION) ----
% @norm cic:11 | c. 11: merely ecclesiastical laws bind those baptized in the Catholic Church or received into it, who have the sufficient use of reason and, unless the law expressly provides otherwise, have completed seven years of age | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html
% Read negatively: a case's silence binds; what it records can exclude. The
% habitual lack of reason (c. 99) is act.lp's: no human act, and no law reaches it.
in_catholic_church(P) :- baptized_in(P,catholic).
in_catholic_church(P) :- received_into(P).
outside(P) :- unbaptized(P).
outside(P) :- baptized_in(P,C), C != catholic, not received_into(P).
unbound(P,L)      :- law_kind(L,ecclesiastical), outside(P).
unbound_at(P,L,A) :- law_kind(L,ecclesiastical), age_at(P,A,Y), Y < 7.
% @norm cic:96 | c. 96: by baptism one is incorporated into the Church of Christ and is constituted a person in it, with the duties and rights proper to Christians, insofar as they are in ecclesiastical communion and unless a lawfully issued sanction stands in the way | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann96-123_en.html
incorporated(P) :- baptized_in(P,_).
% @norm cic:205 | c. 205: those baptized are fully in the communion of the Catholic Church on this earth who are joined with Christ in its visible structure by the bonds of the profession of faith, the sacraments, and ecclesiastical governance | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib2-cann204-207_en.html
% c. 751's offences break the bonds (heresy and apostasy the profession,
% schism governance); no other delict does (the encoder's reading of the two).
bond_broken(P,profession) :- c751_offence(P,heresy,_).
bond_broken(P,profession) :- c751_offence(P,apostasy,_).
bond_broken(P,governance) :- schismatic_act(P,_).
full_communion(P) :- incorporated(P), in_catholic_church(P), not bond_broken(P,_).
% @end
info(incorporated(P))            :- communion_at_issue(P), incorporated(P).
info(in_full_communion(P))       :- communion_at_issue(P), full_communion(P).
info(bond_broken(P,B))           :- communion_at_issue(P), bond_broken(P,B).
info(outside_the_church(P))      :- communion_at_issue(P), incorporated(P), not in_catholic_church(P).

% ---------- Book VI: delicts -----------------------------------------------
% Co-consecrators truly consecrate (Pius XII, Episcopalis consecrationis, 1944),
% so "a Bishop who consecrates" includes them on the plain meaning.
consecrates(E,B) :- consecration(E,B,_,_).
consecrates(E,B) :- co_consecrator(E,B).

% @norm cic1983:1382 | c. 1382 (1983): consecration without pontifical mandate | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
delict(B,n1382_1983,E) :- consecrates(E,B), event_date(E,T), not pontifical_mandate(E), norm_in_force(n1382_1983,T), not outside(B).
delict(R,n1382_1983,E) :- consecration(E,_,R,T), not pontifical_mandate(E), norm_in_force(n1382_1983,T), not outside(R).
penalty(n1382_1983,excommunication).

% @norm cic2021:1387 | c. 1387: consecrator and consecrated without pontifical mandate incur latae sententiae excommunication reserved to the Apostolic See | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
delict(B,n1387,E) :- consecrates(E,B), event_date(E,T), not pontifical_mandate(E), norm_in_force(n1387,T), not outside(B).
delict(R,n1387,E) :- consecration(E,_,R,T), not pontifical_mandate(E), norm_in_force(n1387,T), not outside(R).
penalty(n1387,excommunication).

% @norm cic:751 | c. 751: schism is the refusal of submission to the Supreme Pontiff | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib3-cann747-755_en.html
% Whether one act can constitute schism, or only a lasting state, is a
% reading of c. 751. Ecclesia Dei adflicta 3 (papal) applies it to the act.
schismatic_act(P,E) :- consecrates(E,P), against_explicit_papal_will(E), read_for(c751,act_suffices,E), not not_of_kind(E,schism).
schismatic_act(P,E) :- consecration(E,_,P,_), against_explicit_papal_will(E), read_for(c751,act_suffices,E), not not_of_kind(E,schism).

% @norm cic:751h | c. 751: heresy is the obstinate denial or obstinate doubt after the reception of baptism of some truth which is to be believed by divine and catholic faith; apostasy is the total repudiation of the Christian faith | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib3-cann747-755_en.html
% "To be believed by divine and catholic faith" is c. 750 §1's object, which
% the authority graph joins to teaching by reference (binds/3, owed/2; B15):
% no new link (TTC-COMMUNION). The obstinacy is the claim faith.lp reads as
% pertinacity (II-II q. 11 a. 2 ad 3); apostasy's definition has none.
owed_as(Q,V,O) :- owed(S,O), supports(S,Q,V).
heresy_matter(E) :- professes(_,E,Q,W), owed_as(Q,V,divine_and_catholic_faith), V != W.
heresy_matter(E) :- doubts(_,E,Q), owed_as(Q,_,divine_and_catholic_faith).
c751_offence(P,heresy,E)   :- professes(P,E,_,_), heresy_matter(E), incorporated(P), interior(P,E,pertinacious).
c751_offence(P,heresy,E)   :- doubts(P,E,_), heresy_matter(E), incorporated(P), interior(P,E,pertinacious).
c751_offence(P,apostasy,E) :- repudiates(P,E,christian_faith), incorporated(P).

% @norm cic2021:1364 | c. 1364 §1: an apostate from the faith, a heretic or a schismatic incurs a latae sententiae excommunication | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
delict(P,n1364,E) :- schismatic_act(P,E), event_date(E,T), norm_in_force(n1364,T), not outside(P).
delict(P,n1364_1983,E) :- schismatic_act(P,E), event_date(E,T), norm_in_force(n1364_1983,T), not outside(P).
delict(P,n1364,E) :- c751_offence(P,_,E), event_date(E,T), norm_in_force(n1364,T), not outside(P).
delict(P,n1364_1983,E) :- c751_offence(P,_,E), event_date(E,T), norm_in_force(n1364_1983,T), not outside(P).
penalty(n1364,excommunication). penalty(n1364_1983,excommunication).

% Rejection of teaching owed firm assent (c. 750 §2, from 1998) or religious
% submission (c. 752), obstinately, warned and not retracting, apart from c. 1364.
% Ferendae sententiae: a penalty to be imposed, never incurred.
rejects(P,E,c752)   :- professes(P,E,Q,W), owed_as(Q,V,religious_submission), V != W.
rejects(P,E,c750_2) :- professes(P,E,Q,W), owed_as(Q,V,firm_assent), V != W.
obstinate_rejection(P,E,Of) :- rejects(P,E,Of), interior(P,E,pertinacious), warned(P,E,_),
                               not retracted(P,E), not heresy_matter(E).
% @norm cic1983:1371 | c. 1371 n. 1 (1983): one who, apart from the case of c. 1364 §1, teaches a doctrine condemned by the Roman Pontiff or an ecumenical council, or obstinately rejects the doctrine mentioned in c. 752, and does not retract when warned by the Apostolic See or the ordinary, is to be punished with a just penalty | https://www.iuscangreg.it/cic1983.php
delict(P,n1371_1983,E) :- obstinate_rejection(P,E,c752), event_date(E,T), norm_in_force(n1371_1983,T), not outside(P).
% @norm atf1998:1371 | c. 1371 n. 1 as amended by Ad tuendam fidem (18 May 1998): "or obstinately rejects the teachings mentioned in canon 750 § 2 or in canon 752" | https://www.vatican.va/content/john-paul-ii/en/motu_proprio/documents/hf_jp-ii_motu-proprio_30061998_ad-tuendam-fidem.html
delict(P,n1371_1998,E) :- obstinate_rejection(P,E,_), event_date(E,T), norm_in_force(n1371_1998,T), not outside(P).
% @norm cic2021:1365 | c. 1365: one who, apart from c. 1364 §1, teaches a doctrine condemned by the Roman Pontiff or an ecumenical council, or obstinately rejects the teaching of c. 750 §2 or c. 752, and does not retract when warned by the Apostolic See or the ordinary, is to be punished with a censure and deprivation of office | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
delict(P,n1365,E) :- obstinate_rejection(P,E,_), event_date(E,T), norm_in_force(n1365,T), not outside(P).
penalty(n1371_1983,just_penalty). penalty(n1371_1998,just_penalty). penalty(n1365,censure).

% @temporal cic2021:1379
% @norm cic2021:1379 | c. 1379 §1 n. 2: one who cannot validly absolve and attempts absolution incurs latae sententiae interdict (a cleric also suspension) | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
delict(P,n1379,A) :- absolution(A,P,_,T), not valid_absolution(A), norm_in_force(n1379,T), not outside(P).
penalty(n1379,interdict).
element_of(n1379,cannot_absolve).                 % the delict's matter: one who cannot validly absolve

% ---------- Book VI: abortion (TTC-PENAL AB) -----------------------------------
% The matter comes from the moral library (moral.lp): a completed act whose
% kind is the direct killing of an innocent, its victim unborn. The canon layer
% keeps no kind of its own (CCC 2272: "a crime against human life").
% @input procures/2 | procures(Person, Act): the person procures the act (one who seeks it as well as one who performs it)
% @input unborn/1 | unborn(E): the evil effect E is the death of one not yet born, from conception
% @input by_expulsion/1 | by_expulsion(A): the act kills by expelling the immature fetus (outward)
% @input attempted_only/1 | attempted_only(A): the act was attempted and its effect did not follow (c. 1328)
% @input evil_kind_of/2 | moral.lp: an evil effect of this kind
% @norm pclt1988:1398 | authentic interpretation of c. 1398 (Pontifical Commission for the Authentic Interpretation of the Code, 19 January 1988, approved by John Paul II on 23 May 1988; AAS 80 (1988) 1818-1819): abortion is not only the expulsion of the immature fetus but also its killing in whatever way and at whatever time from the moment of conception | https://www.vatican.va/roman_curia/pontifical_councils/intrptxt/documents/rc_pc_intrptxt_doc_22091998_authentic-interp_lt.html
killing_of_unborn(A) :- direct(A,E), evil_kind_of(E,killing_of_innocent), unborn(E).
abortion_matter(A) :- killing_of_unborn(A), read_for(abortion,killing,A).
abortion_matter(A) :- killing_of_unborn(A), read_for(abortion,expulsion,A), by_expulsion(A).
% @norm cic1983:1398 | c. 1398 (1983): one who procures an abortion, the effect following, incurs a latae sententiae excommunication | https://www.iuscangreg.it/cic1983.php
delict(P,n1398_1983,A) :- procures(P,A), abortion_matter(A), not attempted_only(A), event_date(A,T),
                          norm_in_force(n1398_1983,T), not outside(P).
penalty(n1398_1983,excommunication).
% @norm cic2021:1397 | c. 1397 §2: a person who actually procures an abortion incurs a latae sententiae excommunication | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
delict(P,n1397,A) :- procures(P,A), abortion_matter(A), not attempted_only(A), event_date(A,T),
                     norm_in_force(n1397,T), not outside(P).
penalty(n1397,excommunication).
% @norm cic2021:1328 | c. 1328 §1: one who in furtherance of an offence did or omitted something but did not complete it is not bound by the penalty prescribed for the completed offence, unless the law provides otherwise (the same in 1983) | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html
info(attempt_not_the_delict(P,A)) :- procures(P,A), attempted_only(A), killing_of_unborn(A).
% @recursive cic2021:1329
% @norm cic2021:1329 | c. 1329 §2: accomplices not named in the law incur a latae sententiae penalty if without their assistance the delict would not have been committed and the penalty can affect them; otherwise they can be punished by ferendae sententiae penalties (the same in 1983) | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html
% @input assists/2 | assists(Person, Act): the person gives assistance to another's delict
% @input necessary_assistance/2 | without the person's assistance the delict would not have been committed (outward; computed both ways when disputed)
delict(P,N,A) :- assists(P,A), necessary_assistance(P,A), delict(Q,N,A), Q != P, latae_sententiae(N), not outside(P).
info(accomplice_may_be_punished(P,N,A)) :- assists(P,A), not necessary_assistance(P,A), delict(Q,N,A), Q != P,
                                           latae_sententiae(N), not outside(P).
% @end
info(abortion_reading(A,R)) :- read_for(abortion,R,A).

% ---------- Book VI: imputability, through the human act (act.lp) ---------
% Status is computed at each instant: an act is judged by the law and the
% juridical situation on its own date, not on the evaluation date. What the
% agent knew, willed or feared is never computed here: the library reads the
% claims a case supplies (interior/3), and the canons read the library.
% @norm cic2021:1321 | c. 1321 §§2-4 and c. 1322: no one is punished unless the external violation is gravely imputable by malice or culpability; culpability is punished only where the law provides; once the violation is established imputability is presumed unless it appears otherwise; the habitually insane are incapable | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html
act_of(P,E) :- delict(P,_,E).
% §4 is act.lp's one shape of presumption: the violation raises it, an
% outward appearance rebuts it (TTC-CHRIST SA3).
raises(imputability(P,E))   :- delict(P,_,E).
rebutted(imputability(P,E)) :- appears_otherwise(P,E).
imputed(P,N,E) :- delict(P,N,E), presumed(imputability(P,E)), actus_humanus(P,E),
                  not exempt(P,E), not unpunished_culpa(P,N,E).
unpunished_culpa(P,N,E) :- delict(P,N,E), culpa(P,E), not punishes_culpa(N), not culpa_disregarded(P,N,E).
incurred_at(P,N,E,T) :- imputed(P,N,E), latae_sententiae(N), event_date(E,TE), instant(T), TE <= T,
                        not remitted_at(P,N,E,T), not latae_excused(P,N,E).
to_be_imposed(P,N,E) :- imputed(P,N,E), not latae_sententiae(N).
presumed_incurred(P,N,E) :- incurred_at(P,N,E,T), eval_date(T).
info(not_a_human_act(P,E)) :- delict(P,_,E), not actus_humanus(P,E).
info(dolus(P,E))           :- delict(P,_,E), dolus(P,E).
info(culpa_not_punished(P,N,E)) :- unpunished_culpa(P,N,E).
% §2: no one is punished without dolus or culpa. A law that disregards an error
% is coherent only where the act is unlawful apart from what the error concerns:
% one engaged in an unlawful act answers for what follows from it (versari in
% re illicita, II-II q. 64 a. 8; TTC-ACT N1, N4).
illicit_apart(P,E) :- binds_for(P,E,K), kind_of_act(E,K).
violation(punished_without_fault(P,N,E)) :- imputed(P,N,E), disregarded(N,Of), ignorant_without_fault(P,E,Of),
                                            not illicit_apart(P,E).

% @norm cic2021:1323 | c. 1323: not subject to a penalty: one under sixteen; one ignorant without fault of violating the law (inadvertence and error equivalent); physical force or unforeseeable chance; grave fear, necessity or grave inconvenience unless the act is intrinsically evil or tends to the harm of souls; due self-defence; lack of reason; one who thought without fault that the circumstances of nn. 4-5 existed | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html
exempt(P,E) :- delict(P,_,E), age_at(P,E,Y), Y < 16.                                   % n. 1
exempt(P,E) :- delict(P,_,E), ignorant_without_fault(P,E,law).                          % n. 2
exempt(P,E) :- delict(P,N,E), ignorant_without_fault(P,E,fact(C)), element_of(N,C), not disregarded(N,fact(C)).  % n. 2: unaware he violated it
exempt(P,E) :- delict(P,_,E), chance(P,E).                                               % n. 3 (force: no human act)
exempt(P,E) :- delict(P,_,E), fear_or_necessity(P,E), not grave_matter(E).               % n. 4
exempt(P,E) :- delict(P,_,E), due_defence(P,E).                                          % n. 5
exempt(P,E) :- delict(P,_,E), believed(P,E,C,invincible), excusing(C).                   % n. 7
fear_or_necessity(P,E) :- grave_fear(P,E).
fear_or_necessity(P,E) :- necessity(P,E).
excusing(fear). excusing(necessity). excusing(defence).
grave_matter(E) :- of_kind(E,intrinsically_evil).
grave_matter(E) :- of_kind(E,harm_of_souls).
grave_matter(E) :- kind_of_act(E,K), evil_by_object(K).          % the library's kind (TTC-PENAL AB5)
info(exempt(P,E)) :- exempt(P,E).

% @norm cic2021:1324 | c. 1324 §1 nn. 1, 3, 4, 5, 8, 9 and §3: imperfect use of reason; undeliberate grave passion; a minor over sixteen; grave fear or necessity where the act is intrinsically evil or harmful to souls; culpably mistaken circumstances of c. 1323 nn. 4-5; ignorance without fault of the penalty: the penalty is tempered, and no latae sententiae penalty binds | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html
mitigated(P,E,imperfect_reason) :- delict(P,_,E), imperfect_reason(P,E).                % n. 1
mitigated(P,E,passion)          :- delict(P,_,E), undeliberate_passion(P,E).            % n. 3
mitigated(P,E,minor)            :- delict(P,_,E), age_at(P,E,Y), 16 <= Y, Y < 18.       % n. 4
mitigated(P,E,fear)             :- delict(P,_,E), fear_or_necessity(P,E), grave_matter(E). % n. 5
mitigated(P,E,mistaken)         :- delict(P,_,E), believed(P,E,C,vincible), excusing(C). % n. 8
mitigated(P,E,penalty_unknown)  :- delict(P,_,E), ignorant_without_fault(P,E,penalty).  % n. 9
latae_excused(P,N,E) :- delict(P,N,E), mitigated(P,E,_), latae_sententiae(N).           % §3

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

% ---------- Book IV: holy communion (TTC-MORAL) ----------------------------
% @norm cic:912 | c. 912: any baptized person not prohibited by law can and must be admitted to holy communion | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann879-958_en.html
right_to_communion(P) :- communion(_,P,_).
% @norm cic:915 | c. 915: those excommunicated or interdicted after the imposition or declaration of the penalty, and others obstinately persevering in manifest grave sin, are not to be admitted to holy communion | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann879-958_en.html
% The first clause reads declared or imposed penalties only, never one
% incurred and undeclared. The second turns on the reading of "manifest grave
% sin" (above, with c. 751's): objectively, a situation grave by its matter;
% subjectively, a claim no minister can judge. Where the subjective reading is
% admissible, c. 18 takes it: the canon restricts the right of c. 912.
censure_barring(excommunication). censure_barring(interdict).
not_to_be_admitted(P,c915_censure) :- declared_effective(P,N), penalty(N,K), censure_barring(K).
restricts_rights(c915).
reaches(c915,objective,S)  :- situation_kind(S,K), grave_by_matter(K).
reaches(c915,subjective,S) :- situation(P,S), situation_kind(S,K), grave_by_matter(K), interior(P,S,subjectively_grave).
disputed(interior(P,S,subjectively_grave)) :- read_for(c915,subjective,S), situation(P,S).   % the internal forum
not_to_be_admitted(P,c915_sin) :- situation(P,S), binds_on(c915,S).
% @norm cic:916 | c. 916: one conscious of grave sin is not to celebrate Mass or receive the body of the Lord without previous sacramental confession, unless there is a grave reason and no opportunity to confess | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann879-958_en.html
% Its one element is interior: of the internal forum, computed both ways in
% every case (rule 2), never derived.
disputed(interior(P,C,conscious_of_grave_sin)) :- communion(C,P,_).
not_to_receive(P,C) :- communion(C,P,_), interior(P,C,conscious_of_grave_sin), not confession_impossible(P,C).
% @end
info(not_to_be_admitted(P,R)) :- not_to_be_admitted(P,R).
info(not_to_receive(P,C))     :- not_to_receive(P,C).
info(admitted_by_right(P,C))  :- communion(C,P,_), right_to_communion(P), not not_to_be_admitted(P,_), not not_to_receive(P,C).

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
% Routed through sacrament.lp (TTC-CHRIST SA1): orders are the minister's
% power, of divine law (DH 1710); the faculty is the condition this canon adds.
faculty_met(A) :- absolution(A,P,_,T), faculty_at(P,confession,T), not governance_invalid_at(P,T).
faculty_met(A) :- absolution(A,_,Pen,T), danger_of_death(Pen,T).
faculty_met(A) :- absolution(A,_,_,_), common_error(A).
defect(A,faculty) :- celebration(A,penance,_,_), not faculty_met(A).
valid_absolution(A) :- absolution(A,_,_,_), valid(A).
licit_absolution(A) :- valid_absolution(A), absolution(A,P,_,T), not excommunicated_at(P,T).
licit_absolution(A) :- valid_absolution(A), absolution(A,P,_,_), prohibition_lifted(P,A).
% @end
info(absolution(A,valid,licit))   :- absolution(A,_,_,_), past(A), valid_absolution(A), licit_absolution(A).
info(absolution(A,valid,illicit)) :- absolution(A,_,_,_), past(A), valid_absolution(A), not licit_absolution(A).
info(absolution(A,invalid))       :- absolution(A,_,_,_), past(A), not valid_absolution(A).
info(delict(P,N,E)) :- delict(P,N,E), past(E).
info(to_be_imposed(P,N,E,K)) :- to_be_imposed(P,N,E), penalty(N,K), past(E).

% @norm cic:1117 | c. 1117: the form must be observed if at least one of the parties was baptized in the Catholic Church or received into it (as amended by Omnium in mentem, 2009; until then, "and has not defected from it by a formal act"), without prejudice to c. 1127 §2 | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1108-1123_en.html
promulgated(oim2009,20091026). aas_issue(oim2009,20100108).   % names no date; AAS 102 (2010) 8-10, issue of 8 January 2010 (c. 8 §1)
defection_exempts(P,M) :- spouse(M,P), formal_defection(P,D), marriage(M,_,T), D <= T, has_force_date(oim2009), not force_at(oim2009,T).
bound_to_form(P,M) :- spouse(M,P), not outside(P), not defection_exempts(P,M).
% silence binds: the form is excused only where every recorded party is outside or exempt
form_excused(M) :- spouse(M,_), not some_party_bound(M).
some_party_bound(M) :- bound_to_form(_,M).
form_binds(M) :- marriage(M,_,_), not form_excused(M).

% @norm cic:1108 | c. 1108 §1 and c. 1111: the form requires assistance by the ordinary, the pastor, or a priest delegated by either; c. 144 §2 | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1108-1123_en.html
delegated(P,M) :- marriage(M,P,T), delegation(_,O,P,M,TD), ordinary(O), TD <= T.
delegated(P,M) :- marriage(M,P,T), delegation(_,O,P,general,TD), ordinary(O), TD <= T.
valid_form(M) :- marriage(M,P,T), delegated(P,M), not governance_invalid_at(P,T).
valid_form(M) :- marriage(M,_,_), common_error(M).
% @end
info(marriage(M,valid_form))   :- marriage(M,_,_), past(M), valid_form(M).
info(marriage(M,invalid_form)) :- marriage(M,_,_), past(M), form_binds(M), not valid_form(M), not dispensed(cond(matrimony,canonical_form),M).
info(marriage(M,form_dispensed)) :- marriage(M,_,_), past(M), form_binds(M), not valid_form(M), dispensed(cond(matrimony,canonical_form),M).
info(marriage(M,form_not_binding)) :- marriage(M,_,_), past(M), not form_binds(M).

% @norm cic:1103 | c. 1103: a marriage is invalid if entered into because of force or grave fear from without, even when inflicted unintentionally, so that a person is compelled to choose marriage in order to be freed from it | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1095-1107_en.html
act_of(P,M) :- spouse(M,P).
consent_vitiated(M) :- spouse(M,P), removes_voluntary(P,M,violence).
consent_vitiated(M) :- spouse(M,P), actus_humanus(P,M), grave_fear(P,M), fear_from_without(P,M), chosen_to_escape(P,M).
info(marriage(M,invalid_consent)) :- consent_vitiated(M).

% ---------- Book IV: the sacraments, through sacrament.lp (TTC-CHRIST) ---------
% @norm cic:842 | c. 842 §1: a person who has not received baptism cannot be admitted validly to the other sacraments | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann834-878_en.html
defect(E,subject) :- celebration(E,K,_,R), K != baptism, unbaptized(R).
% @norm cic:845 | c. 845 §1: baptism, confirmation and sacred ordination imprint a character and cannot be repeated; §2: if after diligent inquiry a prudent doubt remains whether they were conferred at all or validly, they are to be conferred conditionally | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann834-878_en.html
% A doubt of fact about a condition of validity is a prudent doubt (§2). Where
% the sacrament certainly failed, it is conferred absolutely.
doubt_of_validity(E) :- celebration(E,K,_,_), imprints(K), disputed(form_used(E,_)).
doubt_of_validity(E) :- celebration(E,K,_,_), imprints(K), disputed(matter_used(E,_)).
received(R,K) :- sacramental_character(R,K,_).
to_be_conferred(R,K,conditionally) :- celebration(E,K,_,R), doubt_of_validity(E).
to_be_conferred(R,K,absolutely)    :- celebration(E,K,_,R), imprints(K), not valid(E), not repeated(E),
                                      not doubt_of_validity(E), not received(R,K).
% @end
info(to_be_conferred(R,K,How)) :- to_be_conferred(R,K,How).

% ---------- Book IV: the bond of marriage (TTC-CHRIST SA10) ---------------------
% @norm cic:1057 | c. 1057 §1: the consent of the parties, legitimately manifested between persons qualified by law, makes marriage; no human power is able to supply this consent | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann998-1165_en.html
% Consent and the canonical form are conditions typed by their law
% (sacrament.lp), so a dispensation reaches only the one that is
% ecclesiastical (c. 1127 §2).
defect_of_marriage(M,consent) :- consent_vitiated(M).
defect_of_marriage(M,canonical_form) :- marriage(M,_,_), form_binds(M), not valid_form(M).
unmet_in_marriage(M,C) :- defect_of_marriage(M,C), not dispensed(cond(matrimony,C),M).
bond(M) :- marriage(M,_,_), not unmet_in_marriage(M,_).
ratified(M) :- bond(M), not spouse_unbaptized(M).
spouse_unbaptized(M) :- spouse(M,P), unbaptized(P).
% @norm cic:1141 | c. 1141: a marriage that is ratum et consummatum can be dissolved by no human power and by no cause, except death | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann998-1165_en.html
violation(ratum_et_consummatum_dissolved(D,M)) :- dissolution(D,M,_,_), ratified(M), consummated(M).
% @norm cic:1142 | c. 1142: a non-consummated marriage between baptized persons, or between a baptized and a non-baptized party, can be dissolved by the Roman Pontiff for a just cause | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann998-1165_en.html
dissolved(M,D) :- dissolution(D,M,non_consummation,_), bond(M), not consummated(M), issuer(D,A), authority(A,4).
% @norm cic:1143 | c. 1143 §1: a marriage entered into by two non-baptized persons is dissolved by the pauline privilege in favour of the faith of the party who received baptism | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann998-1165_en.html
dissolved(M,D) :- dissolution(D,M,favour_of_faith,_), bond(M), not ratified(M).
% A declaration of nullity dissolves nothing: it finds that no bond came to
% be. It changes what the external forum holds (c. 1682 §1), never the fact,
% and never becomes an adjudged matter (c. 1643).
% @norm cic:1682 | c. 1682 §1: after the sentence declaring the nullity of the marriage has become effective, the parties whose marriage has been declared null can contract a new marriage, unless a prohibition attached to the sentence or established by the local ordinary forbids it | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib7-cann1671-1716_en.html
free_to_marry(P) :- nullity_sentence(S,M,_), sentence_effective(S), spouse(M,P), not prohibited_to_marry(P).
% @norm cic:1643 | c. 1643: cases concerning the status of persons, including cases concerning the separation of spouses, never become res iudicata | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib7-cann1501-1670_en.html
never_res_iudicata(M) :- nullity_sentence(_,M,_).
% @end
at_issue(M) :- dissolution(_,M,_,_).
at_issue(M) :- nullity_sentence(_,M,_).
info(bond(M))    :- at_issue(M), bond(M).
info(no_bond(M)) :- at_issue(M), marriage(M,_,_), not bond(M).
info(dissolved(M,D)) :- dissolved(M,D).
info(free_to_marry(P)) :- free_to_marry(P).
info(never_res_iudicata(M)) :- never_res_iudicata(M).
info(forum_holds_null_where_bond_stands(M)) :- bond(M), nullity_sentence(S,M,_), sentence_effective(S).

% ---------- Book IV and VI: the seal (TTC-CHRIST SA7) ---------------------------
% @norm cic:983 | c. 983 §1: the sacramental seal is inviolable; therefore it is absolutely forbidden for a confessor to betray in any way a penitent in words or in any manner and for any reason | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann959-997_en.html
% Whether the seal is of divine law "from the nature of the sacrament" is
% the theological side's (law_kind(seal, ...), through sacrament.lp); "for
% any reason" is the canon's own: no release by anyone lifts it.
violation(seal_lifted(E,Why)) :- seal_lifted(E,Why).
% @norm cic2021:1386 | c. 1386 §1: a confessor who directly violates the sacramental seal incurs a latae sententiae excommunication reserved to the Apostolic See | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
delict(P,n1386,E) :- delict_act(P,n1386,E), event_date(E,T), norm_in_force(n1386,T), not outside(P).
penalty(n1386,excommunication).

% ---------- Book VI: the cleric and the minor; the Dicastery's clause (TTC-ACT N1-N5) ----
% @input cleric/1 | a cleric (deacon, priest or bishop)
% @norm cic2021:1398 | c. 1398 §1 n. 1: a cleric who commits an offence against the sixth commandment of the Decalogue with a minor is to be punished with deprivation of office and other just penalties, not excluding dismissal from the clerical state | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
cleric(P) :- priest(P).
delict(P,n1398_1,E) :- delict_act(P,n1398_1,E), cleric(P), event_date(E,T), norm_in_force(n1398_1,T), not outside(P).
penalty(n1398_1,deprivation).
element_of(n1398_1,minor).                        % the delict's matter: with a minor
% @norm sst2021:6 | Norms on delicts reserved to the Dicastery for the Doctrine of the Faith (11 October 2021), art. 6 n. 1: in the delict of c. 1398 §1 n. 1, ignorance or error on the part of the cleric regarding the age of the minor does not constitute an extenuating or exonerating circumstance; art. 29: the canons on delicts and penalties of each Code apply with the norms | https://www.vatican.va/roman_curia/congregations/cfaith/documents/rc_con_cfaith_doc_20211011_norme-delittiriservati-cfaith_en.html
% Papal law derogates, for the age only, from cc. 1321 §3, 1323 n. 2 and 1324
% as special law; a dicastery's general decree could not (cc. 33 §1, 135 §2).
age_clause(sst2021,n1398_1).
disregarded(N,fact(minor)) :- age_clause(D,N), issuer(D,A), authority(A,4).
info(derogation_refused(D,N)) :- age_clause(D,N), issuer(D,A), authority(A,K), K < 4.
% the error about the age disregarded, culpa resting on it alone is no ground of non-punishment
other_fault(P,N,E) :- delict(P,N,E), ignorant_with_fault(P,E,Of), not disregarded(N,Of).
culpa_disregarded(P,N,E) :- delict(P,N,E), disregarded(N,Of), ignorant_with_fault(P,E,Of),
                            not interior(P,E,negligence), not other_fault(P,N,E).
info(error_disregarded(P,N,E)) :- delict(P,N,E), disregarded(N,Of), ignorance(P,E,Of,_).

% ---------- Book VI: the general norm (TTC-PENAL GP) ----------------------------
% @input special_gravity/2 | special_gravity(Authority, Act): the competent authority's judgment that the violation's special gravity requires punishment (supplied, never computed)
% @input scandal_necessity/2 | scandal_necessity(Authority, Act): the authority's judgment that necessity demands that scandals be prevented or repaired (supplied, never computed)
% @norm cic2021:1399 | c. 1399: besides the cases prescribed in this or in other laws, the external violation of divine or canon law can be punished, and with a just penalty, only when the special gravity of the violation requires it and necessity demands that scandals be prevented or repaired | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
% The violation is read from the library: an act of a kind that binds the
% person (evil by its object, or forbidden by a law that binds). Penal law is
% ecclesiastical: it reaches only those c. 11 binds.
external_violation(P,A) :- binds_for(P,A,K), kind_of_act(A,K).
named_delict(P,A) :- delict(P,N,A), N != n1399.
delict(P,n1399,A) :- external_violation(P,A), special_gravity(_,A), scandal_necessity(_,A), event_date(A,T),
                     norm_in_force(n1399,T), not outside(P), not named_delict(P,A).
penalty(n1399,just_penalty).
% @end

% ---------- Book VII: the last canon (TTC-PENAL SA) ------------------------------
% @input transfer/3 | transfer(Decree, Pastor, Date): a decree transferring a pastor (cc. 1748-1752)
% @input sets_aside/3 | candidate only: sets_aside(Text, Norm, Ground): a text treats a penalty the law attaches as not incurred, on this ground
% @norm cic:1752 | c. 1752: in cases of transfer the prescripts of c. 1747 are to be applied, canonical equity is to be observed, and the salvation of souls, which must always be the supreme law in the Church, is to be kept before one's eyes | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib7-cann1732-1752_en.html
% It names no effect: it binds the authority deciding a transfer to keep the
% salvation of souls in view, a judgment supplied, never computed. It is not a
% power over the law: canonists never weigh against the law (rule 2); the
% law's own remedies (exemption, mitigation, remission) are the routes.
info(to_keep_in_view(D,salus_animarum)) :- transfer(D,_,_).
violation(weighing_against_law(T,N)) :- sets_aside(T,N,salus_animarum).
% @end

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
