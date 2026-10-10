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
