% ===================================================================
%  Cases for the canon-law layer: facts only. The norms are in
%  canon_law.lp. Every fact here is public record unless marked
%  HYPOTHETICAL, and hypothetical facts live only in switch programs.
% ===================================================================

% ---------- The SSPX, 1988-2026 (same program as the authority side) -------
#program sspx.
today(20261010).
authority(john_paul_ii,4). authority(benedict_xvi,4). authority(francis,4).
authority(congregation_bishops,3). authority(ddf,3). authority(pced_with_papal_approval,4).
bishop((lefebvre;castro_mayer;fellay;galarreta;schreiber;goldade;poinsinet;hanappier)).
priest(sspx_priest_x).
in_class((fellay;galarreta;schreiber;goldade;poinsinet;hanappier;sspx_priest_x),sspx_clergy).

% 30 June 1988: Abp Lefebvre consecrates four bishops, Bp de Castro Mayer
% co-consecrating, against John Paul II's expressed will (two of the four shown).
consecration(e1988_fellay,lefebvre,fellay,19880630).
consecration(e1988_galarreta,lefebvre,galarreta,19880630).
co_consecrator((e1988_fellay;e1988_galarreta),castro_mayer).
against_explicit_papal_will((e1988_fellay;e1988_galarreta)).
% Ecclesia Dei adflicta 3: such disobedience "constitutes a schismatic act".
% The supreme legislator's own application of c. 751 (c. 16 §1).
authentic_reading(c751,act_suffices,ed1988) :- not c751_state_reading.
% 21 January 2009: the Congregation for Bishops, by papal mandate, remits the
% excommunication of the four bishops consecrated in 1988.
remission(cb2009,(fellay;galarreta),(n1382_1983;n1364_1983),20090121).

% 20 November 2016: Misericordia et misera 12. The faithful may validly and
% licitly receive absolution from the Society's priests, "until further
% provisions are made".
grant(mm12,francis,confession,sspx_clergy,20161120). issuer(mm12,francis).
% 27 March 2017: Ecclesia Dei letter, approved by the Pope. Ordinaries may
% delegate for the marriages of the Society's faithful, if need be to the
% Society's priest himself.
permission(pced2017,pced_with_papal_approval,sspx_clergy,20170327). issuer(pced2017,pced_with_papal_approval).

% 1 July 2026: Bp de Galarreta consecrates four bishops at Econe, Bp Fellay
% co-consecrating, without pontifical mandate and against Leo XIV's appeal.
consecration(e2026_schreiber,galarreta,schreiber,20260701).
consecration(e2026_goldade,galarreta,goldade,20260701).
consecration(e2026_poinsinet,galarreta,poinsinet,20260701).
consecration(e2026_hanappier,galarreta,hanappier,20260701).
co_consecrator((e2026_schreiber;e2026_goldade;e2026_poinsinet;e2026_hanappier),fellay).
against_explicit_papal_will((e2026_schreiber;e2026_goldade;e2026_poinsinet;e2026_hanappier)).
claims_necessity(P,E) :- delict(P,_,E), consecration(E,_,_,T), T >= 20260101.

% The ordered pair: the theological classification of each act comes first,
% and the law follows it branch by branch.
classification(q(act1988_schismatic),(e1988_fellay;e1988_galarreta),schism).
classification(q(act2026_schismatic),(e2026_schreiber;e2026_goldade;e2026_poinsinet;e2026_hanappier),schism).
premise(n1364_1983,q(act1988_schismatic),yes).
premise(n1364,q(act2026_schismatic),yes).

% 2 July 2026: the DDF decree names six and declares the penalties.
decree(ddf_decree_2026,ddf,20260702). issuer(ddf_decree_2026,ddf).
declares(ddf_decree_2026,(galarreta;schreiber;goldade;poinsinet;hanappier),n1387).
declares(ddf_decree_2026,fellay,n1364).
% Did the warnings recited in the decree give the hearing of c. 1720 n. 1?
% The published text does not say. A disputed fact, computed both ways.
disputed(heard(ddf_decree_2026,named)).
heard(ddf_decree_2026,P) :- heard(ddf_decree_2026,named), declares(ddf_decree_2026,P,_).
% 2 July 2026: the explanatory note. Its claims, checked against the derivation.
issuer(ddf_note_2026,ddf).
asserts(ddf_note_2026,status(sspx_clergy,in_schism),20260702).
asserts(ddf_note_2026,status(formal_adherents,excommunicated),20260702).
asserts(ddf_note_2026,invalid_absolution(sspx_clergy),20260702).
asserts(ddf_note_2026,invalid_marriage(sspx_clergy),20260702).
% 11 July 2026: the Society files a preliminary recourse (cc. 1734 ff.).
recourse(ddf_decree_2026,sspx,20260711).

% Representative acts, to see what the norms derive for each (the persons
% are placeholders, the kinds of act are real).
absolution(abs_2018,sspx_priest_x,penitent_a,20180601).
absolution(abs_2026,sspx_priest_x,penitent_b,20260801). just_cause_request(penitent_b,sspx_priest_x,20260801).
absolution(abs_2026_bishop,schreiber,penitent_c,20260901).
absolution(abs_2026_bishop_jc,goldade,penitent_d,20260902). just_cause_request(penitent_d,goldade,20260902).
marriage(m_2026,sspx_priest_x,20260815).                          % no delegation recorded

% ---------- Switches (most are hypothetical) --------------------------------
#program recourse_decided_2026.  recourse_decided(ddf_decree_2026,20260901).                  % HYPOTHETICAL
#program recourse_upheld_2026.   recourse_decided(ddf_decree_2026,20260901). recourse_upheld(ddf_decree_2026).   % HYPOTHETICAL
#program decree_papally_approved. issuer(ddf_decree_2026,leo_xiv). authority(leo_xiv,4).       % HYPOTHETICAL
#program note_as_revocation.     revocation(ddf_note_2026,mm12,20260702). revocation(ddf_note_2026,pced2017,20260702).
#program note_papally_approved.  issuer(ddf_note_2026,leo_xiv). authority(leo_xiv,4).          % HYPOTHETICAL
#program c751_state_reading.     c751_state_reading.     % c. 751 read as a lasting state, not an act
#program hyp_delegation.                                          % HYPOTHETICAL: an ordinary delegates for one marriage
ordinary(bishop_y). marriage(m_2026_delegated,sspx_priest_x,20260816).
delegation(del1,bishop_y,sspx_priest_x,m_2026_delegated,20260810).
#program edge_acts.                                               % absolutions at the edges of the law
absolution(abs_dying,sspx_priest_x,penitent_e,20260803). danger_of_death(penitent_e,20260803).   % c. 976
absolution(abs_common_error,sspx_priest_x,penitent_f,20260804). disputed(common_error(abs_common_error)).   % c. 144 §2
#program cand_note_as_declaration.   % the note's class statement read as declaring every priest excommunicated
treated_as_declaring(ddf_note_2026,sspx_clergy).
declared_at(P,n1364,T) :- in_class(P,sspx_clergy), instant(T), T >= 20260702.
#program cand_uncoupled.             % the law applied without regard to the theological branch
uncoupled.
#program cand_law_answers_teaching.  % a canon-law result used to settle a doctrinal question
law_answers(q(church_identity)).
#program cand_notoriety_dispenses.   % "the act was public, so no hearing was needed"
notoriety_substitutes(D,P) :- declares(D,P,N), delict(P,N,E), public_act(P,E).

% ---------- The human act (TTC-ACT): constructed cases, all HYPOTHETICAL ----------
% Persons are placeholders. Each attempts absolution without being able to
% absolve validly (c. 1379), so that one delict is read under each claim the
% library types. Every claim is a case's input; none is derived.
#program act_penal.                 % HYPOTHETICAL
today(20261010).
absolution(a_plain,x0,pen,20260901).                                                % the presumption alone
absolution(a_child,x1,pen,20260901).   age_at(x1,a_child,15).                       % c. 1323 n. 1
absolution(a_teen,x2,pen,20260901).    age_at(x2,a_teen,17).                        % c. 1324 §1 n. 4
absolution(a_law,x3,pen,20260901).     interior(x3,a_law,ignorance(law,invincible)). % c. 1323 n. 2
absolution(a_fact,x4,pen,20260901).    interior(x4,a_fact,error(fact(cannot_absolve),invincible)).  % believed himself a priest
absolution(a_factv,x5,pen,20260901).   interior(x5,a_factv,error(fact(cannot_absolve),vincible)).   % culpa: c. 1321 §3
absolution(a_crass,x6,pen,20260901).   interior(x6,a_crass,ignorance(law,crass)).    % c. 1325
absolution(a_chance,x7,pen,20260901).  interior(x7,a_chance,chance).                 % c. 1323 n. 3
absolution(a_force,x8,pen,20260901).   interior(x8,a_force,violence).                % no human act
absolution(a_insane,x9,pen,20260901).  interior(x9,a_insane,reason(habitually_lacking)).  % c. 1322
absolution(a_nec,x11,pen,20260901).    interior(x11,a_nec,necessity).                % c. 1323 n. 4
absolution(a_def,x12,pen,20260901).    interior(x12,a_def,defence(moderate)).        % c. 1323 n. 5
absolution(a_bel,x13,pen,20260901).    interior(x13,a_bel,believed(fear,invincible)).    % c. 1323 n. 7
absolution(a_belv,x14,pen,20260901).   interior(x14,a_belv,believed(necessity,vincible)). % c. 1324 §1 n. 8
absolution(a_imp,x15,pen,20260901).    interior(x15,a_imp,reason(imperfect)).        % c. 1324 §1 n. 1
absolution(a_pas,x16,pen,20260901).    interior(x16,a_pas,passion(grave,unstimulated)).  % c. 1324 §1 n. 3
absolution(a_pen,x17,pen,20260901).    interior(x17,a_pen,ignorance(penalty,invincible)). % c. 1324 §1 n. 9
absolution(a_dolus,x18,pen,20260901).  interior(x18,a_dolus,deliberate).             % dolus
absolution(a_neg,x19,pen,20260901).    interior(x19,a_neg,negligence).               % culpa
absolution(a_disp,x20,pen,20260901).   disputed(interior(x20,a_disp,ignorance(law,invincible))).  % computed both ways
absolution(a_noreason,x10,pen,20260901). interior(x10,a_noreason,reason(lacking)).   % c. 1323 n. 6
absolution(a_inadv,x21,pen,20260901).  interior(x21,a_inadv,inadvertence(law,invincible)).  % c. 1323 n. 2
absolution(a_supine,x22,pen,20260901). interior(x22,a_supine,ignorance(law,supine)).   % c. 1325
absolution(a_affect,x23,pen,20260901). interior(x23,a_affect,ignorance(law,affected)). % c. 1325
absolution(a_beld,x24,pen,20260901).   interior(x24,a_beld,believed(defence,invincible)).  % c. 1323 n. 7

#program culpa_punished.            % HYPOTHETICAL: a law that punishes culpability too (c. 1321 §3)
punishes_culpa(n1379).

#program act_fear.                  % HYPOTHETICAL: one grave, unjust fear from without, four canons
today(20261010).
juridic_act(j1,p).                 interior(p,j1,fear(grave,extrinsic,unjust)).             % c. 125 §2
spouse(m1,p).                      interior(p,m1,fear(grave,extrinsic,unjust)). interior(p,m1,escape_choice).  % c. 1103
absolution(a1,p,pen,20260901).     interior(p,a1,fear(grave,extrinsic,unjust)).             % c. 1323 n. 4
absolution(a2,p,pen,20260902).     interior(p,a2,fear(grave,extrinsic,unjust)).             % c. 1324 §1 n. 5
% the theological side: the second act is of a kind that tends to the harm of souls
question(q(harm_a2)). question_kind(q(harm_a2),doctrinal). value(q(harm_a2),yes). value(q(harm_a2),no).
default(q(harm_a2),yes).
classification(q(harm_a2),a2,harm_of_souls).
juridic_act(j2,r).                 interior(r,j2,violence).                                 % c. 125 §1
spouse(m2,s).                      interior(s,m2,fear(grave,extrinsic,unintended)). interior(s,m2,escape_choice).  % c. 1103: unintended suffices
spouse(m3,u).                      interior(u,m3,fear(grave,intrinsic,unjust)). interior(u,m3,escape_choice).      % fear from within: not c. 1103
spouse(m4,v).                      interior(v,m4,violence).                                 % c. 1103: force
absolution(a3,w,pen,20260903).     interior(w,a3,fear(relatively_grave,extrinsic,unjust)).  % relatively grave suffices (c. 1323 n. 4)
absolution(a4,y,pen,20260904).     interior(y,a4,fear(grave,extrinsic,unjust)).
question(q(evil_a4)). question_kind(q(evil_a4),doctrinal). value(q(evil_a4),yes). value(q(evil_a4),no).
default(q(evil_a4),yes).
classification(q(evil_a4),a4,intrinsically_evil).
