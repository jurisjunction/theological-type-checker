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
% @input claims_necessity/2 | the agent publicly claims a state of necessity for the act
% @input asserts/3 | asserts(Text, Claim, Date): a text's claim about the juridical situation
% @input disputed/1 | a fact whose truth is disputed
% @input today/1 | the evaluation date when no asof is given
% @input authentic_reading/3 | authentic_reading(Canon, Reading, Act): the legislator's own reading (c. 16 §1)
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
assumed_fact(F)      :- disputed(F), F = heard(D,P), issued(D), heard(D,P).
assumed_fact(false(F)) :- disputed(F), F = heard(D,P), issued(D), not heard(D,P).
assumed_fact(F)      :- disputed(F), F = common_error(A), common_error(A).
assumed_fact(false(F)) :- disputed(F), F = common_error(A), not common_error(A).
assumed_fact(F)      :- disputed(F), F = appears_otherwise(P,E), appears_otherwise(P,E).
assumed_fact(false(F)) :- disputed(F), F = appears_otherwise(P,E), not appears_otherwise(P,E).

% Norms and the dates they are in force.
norm(n1382_1983, 19831127, 20211208).  norm(n1387, 20211208, 99991231).
norm(n1364_1983, 19831127, 20211208).  norm(n1364, 20211208, 99991231).
norm(n1379, 20211208, 99991231).
norm_in_force(N,T) :- norm(N,F,U), event_date(_,T), F <= T, T < U.

% ---------- Book I: general norms ------------------------------------------
% @norm cic:16 | c. 16 §1: the legislator interprets authentically | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html
canon_reading(N,R) :- authentic_reading(N,R,_).

% @norm cic:135 | c. 135 §2: a lower authority cannot validly act contrary to a higher one | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann129-144_en.html
competent_revocation(R,G) :- revocation(R,G,_), issuer(R,A1), issuer(G,A2), authority(A1,K1), authority(A2,K2), K1 >= K2.
violation(ineffective_revocation(R,G)) :- revocation(R,G,_), not competent_revocation(R,G).

% @norm cic:333 | c. 333 §3: no appeal or recourse against a decision of the Roman Pontiff | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib2-cann330-367_en.html
papal_act(D) :- issuer(D,A), authority(A,4).

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
schismatic_act(P,E) :- consecrates(E,P), against_explicit_papal_will(E), canon_reading(c751,act_suffices).
schismatic_act(P,E) :- consecration(E,_,P,_), against_explicit_papal_will(E), canon_reading(c751,act_suffices).

% @norm cic2021:1364 | c. 1364 §1: the schismatic incurs latae sententiae excommunication | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
delict(P,n1364,E) :- schismatic_act(P,E), event_date(E,T), norm_in_force(n1364,T).
delict(P,n1364_1983,E) :- schismatic_act(P,E), event_date(E,T), norm_in_force(n1364_1983,T).
penalty(n1364,excommunication). penalty(n1364_1983,excommunication).

% @temporal cic2021:1379
% @norm cic2021:1379 | c. 1379 §1 n. 2: one who cannot validly absolve and attempts absolution incurs latae sententiae interdict (a cleric also suspension) | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
delict(P,n1379,A) :- absolution(A,P,_,T), not valid_absolution(A), norm_in_force(n1379,T).
penalty(n1379,interdict).

% ---------- Book VI: imputability ------------------------------------------
% Status is computed at each instant: an act is judged by the law and the
% juridical situation on its own date, not on the evaluation date.
% @norm cic2021:1321 | c. 1321 §4: once an external violation is established, imputability is presumed unless it appears otherwise | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html
incurred_at(P,N,E,T) :- delict(P,N,E), event_date(E,TE), instant(T), TE <= T,
                        not appears_otherwise(P,E), not remitted_at(P,N,E,T).
presumed_incurred(P,N,E) :- incurred_at(P,N,E,T), eval_date(T).

% @norm cic2021:1323 | cc. 1323 n. 4, 1324 §1 n. 8 and §3: necessity, and culpably mistaken necessity | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html
% Whether necessity existed, or was believed in, is about the agent. The
% checker records the claim and never decides it.
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
