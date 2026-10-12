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
% Given in the form of law (c. 16 §2), or as an act in a particular matter
% (c. 16 §3)? Its form is disputed, and the checker computes both.
disputed(interpretation_form(ed1988,law)).
promulgated(ed1988,19880702).                                      % AAS 80 (1988)
particular_matter(ed1988,(e1988_fellay;e1988_galarreta)).
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
% The decree applies c. 751's act reading to the 2026 consecrations: its particular matter.
applies_reading(ddf_decree_2026,c751,act_suffices).
particular_matter(ddf_decree_2026,(e2026_schreiber;e2026_goldade;e2026_poinsinet;e2026_hanappier)).
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

% ---------- Law (TTC-LAW): constructed laws, all HYPOTHETICAL ----------------
#program law_cases.                 % HYPOTHETICAL
today(20261010).
authority(pope_x,4). authority(bishop_x,1).
law_kind(e1,eternal). law_kind(d1,natural). law_kind(d2,divine_positive).
% G3: the same permission, given by the supreme legislator and by a bishop. Its
% broad reading would permit what the natural law forbids (the theology side).
law_kind(l_sup,ecclesiastical).  legislator(l_sup,pope_x).    permits(l_sup).
law_kind(l_bish,ecclesiastical). legislator(l_bish,bishop_x). permits(l_bish).
reading_option((l_sup;l_bish),(narrow;broad)). narrower(narrow,broad).
needs_reading((l_sup;l_bish),all).
reaches((l_sup;l_bish),broad,(act_n;act_b)). reaches((l_sup;l_bish),narrow,act_n).
question(q(broad_sup)).  question_kind(q(broad_sup),doctrinal).  value(q(broad_sup),(yes;no)).  default(q(broad_sup),yes).
question(q(broad_bish)). question_kind(q(broad_bish),doctrinal). value(q(broad_bish),(yes;no)). default(q(broad_bish),yes).
classification(q(broad_sup),reading(l_sup,broad),contrary_to(d1)).
classification(q(broad_bish),reading(l_bish,broad),contrary_to(d1)).
% G4: a doubt of law, in an invalidating law and in an obliging one; a doubt of fact
law_kind(l_inv,ecclesiastical). legislator(l_inv,bishop_x). invalidating(l_inv).
reading_option(l_inv,(narrow;broad)). needs_reading(l_inv,all). reaches(l_inv,broad,contract_c).
reaches(l_inv,(narrow;broad),contract_d).                            % reached on every reading
law_kind(l_obl,ecclesiastical). legislator(l_obl,bishop_x). obliging(l_obl).
reading_option(l_obl,(narrow;broad)). needs_reading(l_obl,all).
reaches(l_obl,broad,(person_q;person_r)). reaches(l_obl,narrow,person_r).
law_kind(l_fact,ecclesiastical). legislator(l_fact,bishop_x). obliging(l_fact).
reading_option(l_fact,plain). needs_reading(l_fact,all). reaches(l_fact,plain,person_s).
fact_for(l_fact,person_s,resident(person_s)). disputed(resident(person_s)).
% c. 135 §2 and q. 96 a. 4: laws against a higher law
law_kind(l_low,ecclesiastical). legislator(l_low,bishop_x). obliging(l_low).
law_kind(l_high,ecclesiastical). legislator(l_high,pope_x).
reading_option(l_low,plain). needs_reading(l_low,all). reaches(l_low,plain,person_u).
contrary_to_law(l_low,l_high).                                       % a juridical finding
law_kind((l_nat;l_pos;l_ete),ecclesiastical). legislator((l_nat;l_pos;l_ete),bishop_x). obliging((l_nat;l_pos;l_ete)).
reading_option((l_nat;l_pos;l_ete),plain). needs_reading((l_nat;l_pos;l_ete),all).
reaches(l_nat,plain,person_v). reaches(l_pos,plain,person_w). reaches(l_ete,plain,person_x).
question(q(against(L))) :- law_kind(L,ecclesiastical), L = (l_nat;l_pos;l_ete).
question_kind(q(against(L)),doctrinal) :- question(q(against(L))).
value(q(against(L)),(yes;no)) :- question(q(against(L))).
default(q(against(L)),yes) :- question(q(against(L))).
classification(q(against(l_nat)),l_nat,contrary_to(d1)).
classification(q(against(l_pos)),l_pos,contrary_to(d2)).
classification(q(against(l_ete)),l_ete,contrary_to(e1)).
% G5: lacunae
lacuna(m_civil). equity_rule(m_civil,analogy_of_similar_laws).
lacuna(m_disp).  disputed(equity_rule(m_disp,common_opinion)).
% G6: dispensation; c. 21
law_kind(l_disp,ecclesiastical). dispensation(dsp1,l_disp,person_t).
doubtful_revocation(l_new,l_old).

#program law_penal_lacuna.          % HYPOTHETICAL: a penalty supplied by analogy in a penal lacuna
lacuna(m_pen). penal_matter(m_pen). equity_rule(m_pen,punish_by_analogy).

#program law_bad_dispensations.     % HYPOTHETICAL: dispensations no human authority can give
law_kind(d1,natural). law_kind(d2,divine_positive). law_kind(l_form,ecclesiastical). defines_essentials(l_form).
dispensation(dsp2,d1,person_t). dispensation(dsp3,d2,person_t). dispensation(dsp4,l_form,person_t).

#program cand_validity_settles_doctrine.   % a law's failing to bind used to settle that it contradicts divine law
law_answers(q(broad_bish)) :- does_not_bind(l_bish).

% ---------- The morality of acts, sin, grace (TTC-MORAL), all HYPOTHETICAL -------
#program moral_cases.               % HYPOTHETICAL
question(q(k_grave)). question_kind(q(k_grave),doctrinal). value(q(k_grave),(yes;no)). default(q(k_grave),yes).
classification(q(k_grave),k_grave,grave_matter). classification(q(k_grave),k_grave,evil_by_object).
% mortal sin, on the claims: grave matter by teaching, knowledge and consent claimed
act_of(m1,act_m1). kind_of_act(act_m1,k_grave).
interior(m1,act_m1,full_knowledge). interior(m1,act_m1,deliberate_consent).
act_of(m2,act_m2). kind_of_act(act_m2,k_grave). interior(m2,act_m2,full_knowledge).   % consent not claimed
% a kind grave by its matter, forbidden by a law that binds, and by one that does not (q. 96 a. 4)
question(q(k_law_grave)). question_kind(q(k_law_grave),doctrinal). value(q(k_law_grave),(yes;no)). default(q(k_law_grave),yes).
classification(q(k_law_grave),(k_bound;k_unbound),grave_matter).
law_kind(l_binding,ecclesiastical). forbids(l_binding,k_bound).
law_kind(l_unjust,ecclesiastical). law_kind(nat_law,natural). forbids(l_unjust,k_unbound).
question(q(l_unjust_contrary)). question_kind(q(l_unjust_contrary),doctrinal). value(q(l_unjust_contrary),(yes;no)).
default(q(l_unjust_contrary),yes). classification(q(l_unjust_contrary),l_unjust,contrary_to(nat_law)).
act_of(m3,act_m3). kind_of_act(act_m3,k_bound).
interior(m3,act_m3,full_knowledge). interior(m3,act_m3,deliberate_consent).
act_of(m4,act_m4). kind_of_act(act_m4,k_unbound).
interior(m4,act_m4,full_knowledge). interior(m4,act_m4,deliberate_consent).
% double effect (II-II q. 64 a. 7)
act_of(d1,act_d1). kind_of_act(act_d1,k_treatment). effect(act_d1,cure,good). effect(act_d1,harm,evil).
interior(d1,act_d1,evil_unintended). interior(d1,act_d1,proportionate_reason).           % holds
act_of(d2,act_d2). kind_of_act(act_d2,k_treatment). effect(act_d2,cure,good). effect(act_d2,harm,evil).
means(act_d2,harm,cure).
interior(d2,act_d2,evil_unintended). interior(d2,act_d2,proportionate_reason).           % the evil is the means
act_of(d3,act_d3). kind_of_act(act_d3,k_grave). effect(act_d3,cure,good). effect(act_d3,harm,evil).
interior(d3,act_d3,evil_unintended). interior(d3,act_d3,proportionate_reason).           % evil by its object
act_of(d4,act_d4). kind_of_act(act_d4,k_treatment). effect(act_d4,cure,good). effect(act_d4,harm,evil).
interior(d4,act_d4,evil_unintended).                                                       % proportion not claimed
act_of(d5,def1). kind_of_act(def1,k_defence). effect(def1,safety,good). effect(def1,injury,evil).
interior(d5,def1,defence(moderate)).                                                       % legitimate defence (CCC 2263)

#program cand_proportionalism.      % a good end and a proportion make any act licit
licit_on_the_claims(P,A) :- act_of(P,A), interior(P,A,proportionate_reason).

#program c915_case.                 % HYPOTHETICAL: c. 915 and c. 916
situation(q915,s915). situation_kind(s915,k915). manifest(s915). persisting(s915).
question(q(k915_grave)). question_kind(q(k915_grave),doctrinal). value(q(k915_grave),(yes;no)).
default(q(k915_grave),yes). classification(q(k915_grave),k915,grave_matter).
communion(c_r916,r916,20261004).    % c. 916: one who comes to receive

#program grace_cases.               % HYPOTHETICAL: a justification, moved by efficacious grace
act_of(pj,consent_j). justification(pj,consent_j). moved_by(pj,consent_j,g1). efficacious(g1).

#program grace_claimed.             % HYPOTHETICAL: being in grace, as a claim computed both ways
disputed(interior(pj,state,in_grace)).

#program cand_pelagian.             % a salutary act, and justification, without grace (Pelagius; Carthage, Trent can. 1)
act_of(pp,good_work). salutary(pp,good_work).
act_of(pp,assent_pp). justification(pp,assent_pp).
#program cand_semipelagian.         % the beginning of faith without grace (Orange II, can. 5, DH 375)
act_of(ps,first_assent). beginning_of_faith(ps,first_assent).
#program cand_grace_from_sacraments.   % the state of grace read off outward signs (Trent, DH 1534)
received(pj,baptism).
in_grace(P) :- received(P,baptism).
#program cand_dissent_composite.    % Trent's "can dissent" read in the composite sense
violation(dissent_impossible(P,A)) :- justification(P,A), moved_infallibly(P,A).
#program cand_osiander.             % just by the justice by which God is just (Osiander)
formal_cause_essence.
#program cand_jansenist.            % every interior grace efficacious, none resisted (Jansen)
every_grace_efficacious.
#program pclt_confirmed.            % HYPOTHETICAL: the 2000 declaration confirmed by pontifical authority and promulgated
authority(pclt,4). interpretation_form(pclt2000,law). promulgated(pclt2000,20000624).
