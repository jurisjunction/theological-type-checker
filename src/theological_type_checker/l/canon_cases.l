layer canon

```clingo
% ===================================================================
%  Cases for the canon-law layer: facts only. The norms are in
%  canon_law.lp. Every fact here is public record unless marked
%  HYPOTHETICAL, and hypothetical facts live only in switch programs.
% ===================================================================

```

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot c751_state_reading/0
  means "c. 751 read as a lasting state, not an act (a switch)"
  say "c. 751 is read as a lasting state, not an act"

```clingo

% ---------- The SSPX, 1988-2026 (same program as the authority side) -------
```

part case

```clingo
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
promulgated(ed1988,19880702).                                      % AAS 80 (1988) 1495-1498
aas_volume(ed1988,1988,19880702).   % names no date (c. 8 §1); the issue's date unread: force from 2 October 1988 to 31 March 1989
% In the form of law, does it only declare words of c. 751 certain in themselves
% (retroactive, c. 16 §2)? Disputed with its form: computed both ways (TTC-PENAL AB9).
disputed(declaratory(ed1988)).
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
```

part switch of sspx

```clingo
#program recourse_decided_2026.  recourse_decided(ddf_decree_2026,20260901).                  % HYPOTHETICAL
```

part switch

```clingo
#program recourse_upheld_2026.   recourse_decided(ddf_decree_2026,20260901). recourse_upheld(ddf_decree_2026).   % HYPOTHETICAL
```

part switch of sspx

```clingo
#program decree_papally_approved. issuer(ddf_decree_2026,leo_xiv). authority(leo_xiv,4).       % HYPOTHETICAL
```

part switch

```clingo
#program c1321_dolus_read.       :- not read_for(c1321_4,presumes_dolus,all).   % c. 1321 §4 read one way, for one-model checks (TTC-REPAIRS2)
```

part switch of sspx

```clingo
#program decree_in_specific_form. approved_in_specific_form(ddf_decree_2026).                  % HYPOTHETICAL
```

part switch of sspx

```clingo
#program ddf_recourse_final.     % HYPOTHETICAL: the Dicastery decides the recourse against its own decree; a further recourse is taken
decree(ddf_ruling_2026,ddf,20260901). issuer(ddf_ruling_2026,ddf).
decides_recourse(ddf_ruling_2026,ddf_decree_2026). declares(ddf_ruling_2026,fellay,n1364).
recourse(ddf_ruling_2026,fellay,20260915).
```

part switch of sspx

```clingo
#program notified_later.         % HYPOTHETICAL: the decree made known to one it names after the clock, to another before it
notified(ddf_decree_2026,fellay,20261015). notified(ddf_decree_2026,galarreta,20261005).
```

part switch of sspx

```clingo
#program note_as_revocation.     revocation(ddf_note_2026,mm12,20260702). revocation(ddf_note_2026,pced2017,20260702).
```

part switch of sspx

```clingo
#program note_papally_approved.  issuer(ddf_note_2026,leo_xiv). authority(leo_xiv,4).          % HYPOTHETICAL
```

part switch of sspx

```clingo
#program c751_state_reading.     c751_state_reading.     % c. 751 read as a lasting state, not an act
```

part switch of sspx

```clingo
#program hyp_delegation.                                          % HYPOTHETICAL: an ordinary delegates for one marriage
ordinary(bishop_y). marriage(m_2026_delegated,sspx_priest_x,20260816).
delegation(del1,bishop_y,sspx_priest_x,m_2026_delegated,20260810).
```

part switch of sspx

```clingo
#program edge_acts.                                               % absolutions at the edges of the law
absolution(abs_dying,sspx_priest_x,penitent_e,20260803). danger_of_death(penitent_e,20260803).   % c. 976
absolution(abs_common_error,sspx_priest_x,penitent_f,20260804). disputed(common_error(abs_common_error)).   % c. 144 §2
```

part candidate of sspx

```clingo
#program cand_note_as_declaration.   % the note's class statement read as declaring every priest excommunicated
treated_as_declaring(ddf_note_2026,sspx_clergy).
declared_at(P,n1364,T) :- in_class(P,sspx_clergy), instant(T), T >= 20260702.
```

part candidate of sspx

```clingo
#program cand_uncoupled.             % the law applied without regard to the theological branch
uncoupled.
```

part candidate of ecumenism

```clingo
#program cand_law_answers_teaching.  % a canon-law result used to settle a doctrinal question
law_answers(q(church_identity)).
```

part candidate of sspx

```clingo
#program cand_notoriety_dispenses.   % "the act was public, so no hearing was needed"
notoriety_substitutes(D,P) :- declares(D,P,N), delict(P,N,E), public_act(P,E).

% ---------- The human act (TTC-ACT): constructed cases, all HYPOTHETICAL ----------
% Persons are placeholders. Each attempts absolution without being able to
% absolve validly (c. 1379), so that one delict is read under each claim the
% library types. Every claim is a case's input; none is derived.
```

part switch

```clingo
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

```

part switch

```clingo
#program culpa_punished.            % HYPOTHETICAL: a law that punishes culpability too (c. 1321 §3)
punishes_culpa(n1379).

```

part case

```clingo
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
```

part case

```clingo
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

```

part switch of law_cases

```clingo
#program law_penal_lacuna.          % HYPOTHETICAL: a penalty supplied by analogy in a penal lacuna
lacuna(m_pen). penal_matter(m_pen). equity_rule(m_pen,punish_by_analogy).

```

part switch of law_cases

```clingo
#program law_bad_dispensations.     % HYPOTHETICAL: dispensations no human authority can give
law_kind(d1,natural). law_kind(d2,divine_positive). law_kind(l_form,ecclesiastical). defines_essentials(l_form).
dispensation(dsp2,d1,person_t). dispensation(dsp3,d2,person_t). dispensation(dsp4,l_form,person_t).

```

part candidate of law_cases

```clingo
#program cand_validity_settles_doctrine.   % a law's failing to bind used to settle that it contradicts divine law
law_answers(q(broad_bish)) :- does_not_bind(l_bish).

% ---------- The morality of acts, sin, grace (TTC-MORAL), all HYPOTHETICAL -------
```

part case

```clingo
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

```

part candidate of moral_cases

```clingo
#program cand_proportionalism.      % a good end and a proportion make any act licit
licit_on_the_claims(P,A) :- act_of(P,A), interior(P,A,proportionate_reason).

```

part case

```clingo
#program c915_case.                 % HYPOTHETICAL: c. 915 and c. 916
situation(q915,s915). situation_kind(s915,k915). manifest(s915). persisting(s915).
question(q(k915_grave)). question_kind(q(k915_grave),doctrinal). value(q(k915_grave),(yes;no)).
default(q(k915_grave),yes). classification(q(k915_grave),k915,grave_matter).
communion(c_r916,r916,20261004).    % c. 916: one who comes to receive

```

part switch

```clingo
#program grace_cases.               % HYPOTHETICAL: a justification, moved by efficacious grace
act_of(pj,consent_j). justification(pj,consent_j). moved_by(pj,consent_j,g1). efficacious(g1).

```

part switch

```clingo
#program grace_claimed.             % HYPOTHETICAL: being in grace, as a claim computed both ways
disputed(interior(pj,state,in_grace)).

```

part candidate

```clingo
#program cand_pelagian.             % a salutary act, and justification, without grace (Pelagius; Carthage, Trent can. 1)
act_of(pp,good_work). salutary(pp,good_work).
act_of(pp,assent_pp). justification(pp,assent_pp).
```

part candidate

```clingo
#program cand_semipelagian.         % the beginning of faith without grace (Orange II, can. 5, DH 375)
act_of(ps,first_assent). beginning_of_faith(ps,first_assent).
```

part candidate

```clingo
#program cand_grace_from_sacraments.   % the state of grace read off outward signs (Trent, DH 1534)
received(pj,baptism).
in_grace(P) :- received(P,baptism).
```

part candidate

```clingo
#program cand_dissent_composite.    % Trent's "can dissent" read in the composite sense
violation(dissent_impossible(P,A)) :- justification(P,A), moved_infallibly(P,A).
```

part candidate

```clingo
#program cand_osiander.             % just by the justice by which God is just (Osiander)
formal_cause_essence.
```

part candidate of jansenism

```clingo
#program cand_jansenist.            % every interior grace efficacious, none resisted (Jansen)
every_grace_efficacious.
```

part switch of c915_case

```clingo
#program pclt_confirmed.            % HYPOTHETICAL: the 2000 declaration confirmed by pontifical authority and promulgated
authority(pclt,4). interpretation_form(pclt2000,law). promulgated(pclt2000,20000624). vacatio_set(pclt2000,20000624).

% ---------- Christ and the sacraments (TTC-CHRIST), all HYPOTHETICAL -------------
```

part switch

```clingo
#program christ_acts.               % HYPOTHETICAL: a human act of the incarnate, the divinity's instrument (load with creed)
act_of(son,healing). in_nature(healing,hum).
act_of(son,healing_power). in_nature(healing_power,div). instrument_of(healing,healing_power).
```

part candidate

```clingo
#program cand_one_theandric_operation.   % one act of both natures (Severus of Antioch)
act_of(son,walking_on_water). in_nature(walking_on_water,(div;hum)).
```

part candidate

```clingo
#program cand_father_acts_humanly.  % a human act placed by the Father (Patripassian)
act_of(father,healing_f). in_nature(healing_f,hum).
```

part candidate

```clingo
#program cand_sin_of_christ.        % claims composing a sin of the incarnate
act_of(son,act_s). in_nature(act_s,hum). kind_of_act(act_s,k_grave_c).
question(q(k_grave_c)). question_kind(q(k_grave_c),doctrinal). value(q(k_grave_c),(yes;no)). default(q(k_grave_c),yes).
classification(q(k_grave_c),k_grave_c,grave_matter). classification(q(k_grave_c),k_grave_c,evil_by_object).
interior(son,act_s,full_knowledge). interior(son,act_s,deliberate_consent).
```

part candidate of mary_actual_sin

```clingo
#program cand_sin_of_mary.          % claims composing a venial sin of Mary (load with creed and mary_actual_sin)
act_of(mary,act_v). kind_of_act(act_v,k_idle_word). law_kind(eternal_law,eternal). forbids(eternal_law,k_idle_word).
interior(mary,act_v,deliberate_consent).

```

part switch

```clingo
#program eucharist_case.            % HYPOTHETICAL: two Masses, one by a layman; a host reserved, a fragment
priest(priest_e).
celebrated(mass_1,eucharist,priest_e,assembly). celebration_date(mass_1,20261004).
matter_used(mass_1,wheat_bread). form_used(mass_1,words_of_institution).
host_of(mass_1,(host_a;host_b)). reserved(host_b). fragment_of(host_a_part,host_a).
celebrated(mass_2,eucharist,layman_l,assembly). celebration_date(mass_2,20261004).
matter_used(mass_2,wheat_bread). form_used(mass_2,words_of_institution). host_of(mass_2,host_c).
celebrated(mass_3,eucharist,priest_e,assembly). celebration_date(mass_3,20261004).      % not wheat bread (c. 924 §2)
matter_used(mass_3,rice_cake). host_of(mass_3,host_d).
```

part candidate

```clingo
#program cand_untyped_presence.     % presence with no mode, and a body in one place at a time
located(X,L) :- present(X,L,_).
violation(in_two_places(X,L1,L2)) :- located(X,L1), located(X,L2), L1 < L2, has_nature(X,hum).
```

part candidate

```clingo
#program cand_bilocation.           % HYPOTHETICAL: one person circumscribed in two places at once
created_person(saint_b). present(saint_b,(place_a;place_b),circumscriptive).
```

part candidate

```clingo
#program cand_god_located.          % God in heaven as in a place, definitively
god(deus). present(deus,heaven,definitive).
```

part candidate

```clingo
#program cand_father_in_the_host.   % the Father present under the species, and in heaven as a spirit is (load with trinity)
present(father,host_f,sacramental). present(father,heaven,definitive).
```

part candidate

```clingo
#program cand_angel_circumscribed.  % an angel measured by a place, as a body is
angel(angel_g). present(angel_g,place_c,circumscriptive).
```

part candidate

```clingo
#program cand_mode_unknown.         % a presence with no mode the kernel or a library knows
present(son,place_d,located).
```

part candidate

```clingo
#program cand_presence_in_use.      % Christ present only in the use, while received (DH 1654)
presence_requires(use).
```

part candidate

```clingo
#program cand_presence_sign.        % only as in a sign or figure (DH 1651)
presence_as(sign).

```

part switch of sacrament_conditions

```clingo
#program sacrament_cases.           % HYPOTHETICAL
priest(priest_p). bishop(bishop_b).
celebrated(bap_1,baptism,layman_d,infant_i). celebration_date(bap_1,20260105). age_at(infant_i,bap_1,0).
matter_used(bap_1,true_water). form_used(bap_1,i_baptize).
celebrated(bap_2,baptism,priest_p,adult_a). celebration_date(bap_2,20260404).            % SA8: the obstacle a claim
disputed(interior(adult_a,bap_2,no_obstacle)).
celebrated(bap_3,baptism,priest_p,adult_a). celebration_date(bap_3,20260601).            % repeated absolutely (c. 845 §1)
celebrated(bap_4,baptism,priest_p,adult_m). celebration_date(bap_4,20260602).            % a contrary intention manifested
contrary_intention_manifested(bap_4).
celebrated(bap_4b,baptism,priest_p,adult_m). celebration_date(bap_4b,20260702).          % then baptized validly
celebrated(bap_6,baptism,priest_p,adult_h). celebration_date(bap_6,20260703).            % habitually without reason (c. 99)
interior(adult_h,bap_6,reason(habitually_lacking)).
celebrated(conf_2,confirmation,bishop_b,adult_a). celebration_date(conf_2,20260704).
celebrated(anoint_1,anointing,priest_p,adult_a). celebration_date(anoint_1,20260705).
celebrated(anoint_2,anointing,layman_d,adult_a). celebration_date(anoint_2,20260706).
celebrated(conf_1,confirmation,bishop_b,adult_u). celebration_date(conf_1,20260603). unbaptized(adult_u).   % c. 842 §1
celebrated(abs_1,penance,layman_d,adult_a). celebration_date(abs_1,20260604).           % no power of orders
```

part switch

```clingo
#program doubt_of_matter.           % HYPOTHETICAL: was true water used?
celebrated(bap_dw,baptism,priest_p,child_z). celebration_date(bap_dw,20260801).
disputed(matter_used(bap_dw,rose_water)).
```

part switch

```clingo
#program orders_cases.              % HYPOTHETICAL: one ordained twice; a defective form
bishop(bishop_o).
consecration(e_o1,bishop_o,cand_o,20200101). pontifical_mandate(e_o1).
matter_used(e_o1,imposition_of_hands). form_used(e_o1,consecratory_prayer).
consecration(e_o2,bishop_o,cand_o,20210101). pontifical_mandate(e_o2).
consecration(e_o3,bishop_o,cand_p,20210102). pontifical_mandate(e_o3). form_used(e_o3,prayer_of_blessing).
```

part switch

```clingo
#program act_rebutted.              % HYPOTHETICAL: c. 1321 §4, the presumption rebutted on the facts
today(20261010).
absolution(a_reb,x25,pen,20260901). appears_otherwise(x25,a_reb).
```

part candidate

```clingo
#program cand_donatist.             % validity resting on the minister's grace (the Donatists; DH 1612)
requires_of_minister(K,in_grace) :- celebration(_,K,_,_).
disputed(interior(P,state,in_grace)) :- celebration(_,_,P,_).
defect(E,minister_grace) :- celebration(E,_,P,_), not interior(P,state,in_grace).
```

part candidate

```clingo
#program cand_fruit_from_validity.  % the fruit read off validity (against DH 1606)
in_grace(R) :- valid(E), celebration(E,_,_,R).
```

part candidate

```clingo
#program cand_infant_state.         % the infant's rebirth entered as a state of grace
in_grace(R) :- reborn_on_the_deposit(R,_).

```

part switch of sacrament_conditions

```clingo
#program sacrament_dispensations.   % HYPOTHETICAL: load with sacrament_conditions
today(20261010). priest(priest_p).
marriage(m_mixed,minister_m,20260502). spouse(m_mixed,(spouse_c;spouse_n)).              % c. 1127 §2
dispensation(dsp_form,cond(matrimony,canonical_form),m_mixed).
celebrated(bap_w,baptism,priest_p,child_w). celebration_date(bap_w,20260503). matter_used(bap_w,rose_water).
dispensation(dsp_water,cond(baptism,matter),bap_w).
absolution(abs_lay,layman_q,penitent_q,20260505).                                        % no power of orders
dispensation(dsp_ord,cond(penance,minister),abs_lay).
marriage(m_vit,priest_p,20260506). spouse(m_vit,(spouse_v;spouse_w)).                      % consent vitiated (c. 1103)
ordinary(ordinary_v). delegation(dl_v,ordinary_v,priest_p,m_vit,20260501).
interior(spouse_v,m_vit,fear(grave,extrinsic,unjust)). interior(spouse_v,m_vit,escape_choice).
dispensation(dsp_consent,cond(matrimony,consent),m_vit).
```

part candidate of sacrament_conditions

```clingo
#program cand_law_types_the_substance.   % the Code's c. 1108 cited as settling that the form is not of the substance
source(c1108_text,3,juridical,1983). supports(c1108_text,q(substance(matrimony,canonical_form)),no).

```

part switch of we_baptize

```clingo
#program we_baptize_case.           % HYPOTHETICAL: load with we_baptize
celebrated(bap_we,baptism,deacon_w,child_x). celebration_date(bap_we,20200101).
matter_used(bap_we,true_water). form_used(bap_we,we_baptize).
celebrated(bap_doubt,baptism,deacon_w,child_y). celebration_date(bap_doubt,20200102). matter_used(bap_doubt,true_water).
disputed(form_used(bap_doubt,we_baptize)).                                                % was "we" said?

```

part switch

```clingo
#program marriage_cases.            % HYPOTHETICAL: nullity and dissolution (SA10)
today(20261010). authority(pope_m,4).
marriage(m_rc,priest_m,20200601). spouse(m_rc,(sp_a;sp_b)). delegation(dl_m,ordinary_m,priest_m,general,20200101). ordinary(ordinary_m).
consummated(m_rc).                                                                       % ratified and consummated
marriage(m_nc,priest_m,20200602). spouse(m_nc,(sp_c;sp_d)).                               % not consummated
dissolution(dis_nc,m_nc,non_consummation,20230101). issuer(dis_nc,pope_m).
marriage(m_doubt,priest_m,20200603). spouse(m_doubt,(sp_e;sp_f)). consummated(m_doubt).   % consent disputed
disputed(interior(sp_e,m_doubt,fear(grave,extrinsic,unjust))). interior(sp_e,m_doubt,escape_choice).
nullity_sentence(ns_doubt,m_doubt,20240101). sentence_effective(ns_doubt).
marriage(m_noform,priest_u,20200604). spouse(m_noform,(sp_i;sp_j)).                       % no delegation: the form fails
marriage(m_pauline,priest_m,20200605). spouse(m_pauline,(sp_g;sp_h)). unbaptized((sp_g;sp_h)). consummated(m_pauline).
dissolution(dis_pf,m_pauline,favour_of_faith,20250101).                                   % c. 1143
```

part switch

```clingo
#program dissolve_ratum_consummatum.   % HYPOTHETICAL: a dissolution attempted of a ratified, consummated marriage
dissolution(dis_rc,m_rc,non_consummation,20230102). issuer(dis_rc,pope_m).
```

part candidate

```clingo
#program cand_nullity_as_divorce.   % a declaration of nullity read as ending a bond
dissolution(S,M,by_sentence,T) :- nullity_sentence(S,M,T).

```

part case

```clingo
#program seal_case.                 % HYPOTHETICAL: a confessor coerced, under a civil law, to disclose a confession
today(20261010). priest(conf_k).
delict_act(conf_k,n1386,disclosure_k). act_date(disclosure_k,20260915).
interior(conf_k,disclosure_k,fear(grave,extrinsic,unjust)).
priest(conf_j). delict_act(conf_j,n1386,disclosure_j). act_date(disclosure_j,20260916).   % disclosed, uncoerced
law_kind(civil_disclosure_law,civil).
question(q(civil_law_against_seal)). question_kind(q(civil_law_against_seal),doctrinal).
value(q(civil_law_against_seal),(yes;no)). default(q(civil_law_against_seal),yes).
classification(q(civil_law_against_seal),civil_disclosure_law,contrary_to(seal)).
question(q(disclosure_harms_souls)). question_kind(q(disclosure_harms_souls),doctrinal).
value(q(disclosure_harms_souls),(yes;no)). default(q(disclosure_harms_souls),yes).
classification(q(disclosure_harms_souls),disclosure_k,harm_of_souls).
```

part switch of seal_case

```clingo
#program seal_dispensed.            % HYPOTHETICAL: the supreme authority dispenses the confessor from the seal
dispensation(dsp_seal,seal,conf_k).
```

part candidate of seal_case

```clingo
#program cand_penitent_releases.    % the penitent's permission lifts the seal
seal_lifted(disclosure_k,penitent_release).

% ---------- Verdicts and obligation (TTC-PRECEPT), all HYPOTHETICAL -------------
% Load with direct_reading and life_sources: the kind of a direct killing is
% composed from the effect and typed by the sources, never by hand.
```

part switch of life_sources

```clingo
#program trolley.                   % HYPOTHETICAL: the lever, the push, the loop
act_of(bystander_b,lever). kind_of_act(lever,divert).                           % the one dies as a side effect
effect(lever,five_saved,good). effect(lever,death_of_one,evil). evil_kind_of(death_of_one,killing_of_innocent).
interior(bystander_b,lever,evil_unintended). interior(bystander_b,lever,proportionate_reason).
act_of(bystander_c,lever_c). kind_of_act(lever_c,divert).                       % proportion not claimed
effect(lever_c,five_saved,good). effect(lever_c,death_of_one_c,evil). evil_kind_of(death_of_one_c,killing_of_innocent).
interior(bystander_c,lever_c,evil_unintended).
act_of(agent_p,push). kind_of_act(push,push_man).                               % the man's death stops the trolley
effect(push,five_saved,good). effect(push,death_of_man,evil). means(push,death_of_man,five_saved).
evil_kind_of(death_of_man,killing_of_innocent).
interior(agent_p,push,evil_unintended). interior(agent_p,push,proportionate_reason).
disputed(interior(agent_p,push,chooses(death_of_man))).
act_of(agent_l,loop). kind_of_act(loop,divert).                                 % the track loops back: the one's body stops it
effect(loop,five_saved,good). effect(loop,death_of_one_l,evil). means(loop,death_of_one_l,five_saved).
evil_kind_of(death_of_one_l,killing_of_innocent).
interior(agent_l,loop,evil_unintended). interior(agent_l,loop,proportionate_reason).
disputed(interior(agent_l,loop,chooses(death_of_one_l))).
act_of(surgeon_h,harvest). kind_of_act(harvest,transplant).                     % one killed for five transplants; nothing claimed
object_is(harvest,death_of_patient). effect(harvest,death_of_patient,evil). effect(harvest,five_saved,good).
evil_kind_of(death_of_patient,killing_of_innocent).

```

part switch of life_sources

```clingo
#program trolley_duty.              % HYPOTHETICAL: one responsible for others, attacked (CCC 2265)
commands(nat_law,defend(charges),charges_attacked).
occasion(guard_g,charges_attacked).

```

part candidate of life_sources

```clingo
#program cand_must_push.            % "you must push the man to save five" (load with life_sources)
commands(greater_number_rule,direct(killing_of_innocent),more_at_stake).
occasion(agent_p,more_at_stake).

```

part switch of life_sources

```clingo
#program abortion.                  % HYPOTHETICAL: load with direct_reading, life_sources, craniotomy_sources; ectopic likewise
act_of(doctor_a,abort_1).                                                       % direct abortion: the act is the death; its kind composed
object_is(abort_1,death_of_unborn). effect(abort_1,death_of_unborn,evil). evil_kind_of(death_of_unborn,killing_of_innocent).
act_of(doctor_c,cranio). kind_of_act(cranio,craniotomy).                        % to save the mother in obstructed labour
effect(cranio,mother_saved,good). effect(cranio,death_of_child,evil). means(cranio,death_of_child,mother_saved).
evil_kind_of(death_of_child,killing_of_innocent).
interior(doctor_c,cranio,evil_unintended). interior(doctor_c,cranio,proportionate_reason).
disputed(interior(doctor_c,cranio,chooses(death_of_child))).
```

part switch of life_sources

```clingo
#program ectopic.                   % HYPOTHETICAL: the damaged tube removed; the embryo removed; its growth stopped by a drug
act_of(doctor_e,tube_out). kind_of_act(tube_out,salpingectomy).
effect(tube_out,mother_saved,good). means(tube_out,tube_removed,mother_saved).   % the means: no valence entered, so not evil (TTC-L TY3)
effect(tube_out,death_of_embryo_s,evil). evil_kind_of(death_of_embryo_s,killing_of_innocent).
interior(doctor_e,tube_out,evil_unintended). interior(doctor_e,tube_out,proportionate_reason).
act_of(doctor_t,embryo_out). kind_of_act(embryo_out,extraction_of_ectopic_fetus).   % salpingostomy
effect(embryo_out,mother_saved,good). effect(embryo_out,death_of_embryo_t,evil). means(embryo_out,death_of_embryo_t,mother_saved).
evil_kind_of(death_of_embryo_t,killing_of_innocent).
interior(doctor_t,embryo_out,evil_unintended). interior(doctor_t,embryo_out,proportionate_reason).
disputed(interior(doctor_t,embryo_out,chooses(death_of_embryo_t))).
act_of(doctor_m,mtx). kind_of_act(mtx,drug_treatment).                           % methotrexate
effect(mtx,mother_saved,good). effect(mtx,death_of_embryo_m,evil). means(mtx,death_of_embryo_m,mother_saved).
evil_kind_of(death_of_embryo_m,killing_of_innocent).
interior(doctor_m,mtx,evil_unintended). interior(doctor_m,mtx,proportionate_reason).
disputed(interior(doctor_m,mtx,chooses(death_of_embryo_m))).

```

part switch of ivf_sources

```clingo
#program ivf.                       % HYPOTHETICAL: load with ivf_sources and life_sources
act_of(clinic_i,ivf_1). kind_of_act(ivf_1,ivf).
act_of(clinic_i,discard_1).                                                     % the embryos destroyed; its kind composed
object_is(discard_1,death_of_embryo_i). effect(discard_1,death_of_embryo_i,evil). evil_kind_of(death_of_embryo_i,killing_of_innocent).

```

part switch of deathpenalty

```clingo
#program dp_verdict.                % HYPOTHETICAL: an execution; load with deathpenalty and a date or reading
act_of(state_s,exec_1). kind_of_act(exec_1,execution).
permitted_only_if(execution,absolute_necessity).                                  % EV 56; CCC 2267 (1997)
prudential(exec_1,absolute_necessity).                                            % the judgment of those responsible
% q(dp_principle) and q(necessity_today) are not yes/no questions: the case states the bridge.
of_kind(execution,evil_by_object) :- holds(q(dp_principle),intrinsically_wrong).
denied(absolute_necessity)        :- holds(q(necessity_today),none).

```

part switch

```clingo
#program just_war.                  % HYPOTHETICAL: the conditions of CCC 2309, claimed by those responsible
act_of(authority_w,force_1). kind_of_act(force_1,use_of_force).
act_of(authority_v,force_2). kind_of_act(force_2,use_of_force).
permitted_only_if(use_of_force,(lasting_grave_damage;other_means_ineffective;prospects_of_success;no_graver_evils)).
prudential(force_1,(lasting_grave_damage;other_means_ineffective;prospects_of_success;no_graver_evils)).
prudential(force_2,(lasting_grave_damage;other_means_ineffective;prospects_of_success)).   % the comparison of evils not claimed

```

part switch of usury_two_questions

```clingo
#program usury_case.                % HYPOTHETICAL: load with usury_two_questions
act_of(lender_u,loan_u). kind_of_act(loan_u,profit_from_loan_as_such).            % gain from the loan itself

% ---------- Faith and communion (TTC-COMMUNION), all HYPOTHETICAL ---------------
```

part switch of ic

```clingo
#program professions_ic.            % HYPOTHETICAL: the Immaculate Conception denied; load with ic and a date
professes(theo_d,prof_ic,q(ic),no).

```

part switch of filioque

```clingo
#program professions_filioque.      % HYPOTHETICAL: load with filioque and assent
today(20261010).
baptized_in(theo_o,orthodox_church). communion_at_issue(theo_o).                  % baptized and living outside
professes(theo_o,prof_o,q(spirit_origin),father_alone). act_date(prof_o,20200301).
baptized_in(theo_c,catholic). communion_at_issue(theo_c).
professes(theo_c,prof_c,q(spirit_origin),father_alone). act_date(prof_c,20200302).
disputed(interior(theo_c,prof_c,pertinacious)).
baptized_in(theo_n,catholic). communion_at_issue(theo_n).                          % the Creed without the Filioque
professes(theo_n,prof_n,q(monarchy),father_principle_without_principle). act_date(prof_n,20200303).
baptized_in(theo_rc,orthodox_church). received_into(theo_rc). communion_at_issue(theo_rc).   % received into the Catholic Church
baptized_in(theo_q,catholic). doubts(theo_q,doubt_q,q(spirit_origin)). act_date(doubt_q,20200304).
interior(theo_q,doubt_q,pertinacious).

```

part switch of ecumenism

```clingo
#program professions_anglican.      % HYPOTHETICAL: Anglican orders professed valid, warned, not retracted; load with ecumenism and assent
today(20261010).
baptized_in(theo_a,catholic). communion_at_issue(theo_a).
professes(theo_a,(prof_a97;prof_a00;prof_a22),q(anglican_orders),valid).
act_date(prof_a97,19970601). act_date(prof_a00,20000601). act_date(prof_a22,20220601).
warned(theo_a,(prof_a97;prof_a00;prof_a22),ordinary).
interior(theo_a,(prof_a97;prof_a00;prof_a22),pertinacious).                         % obstinacy claimed
baptized_in(theo_r,catholic). doubts(theo_r,doubt_r,q(anglican_orders)). act_date(doubt_r,20200101).
interior(theo_r,doubt_r,pertinacious). warned(theo_r,doubt_r,ordinary).

```

part switch

```clingo
#program apostasy_case.             % HYPOTHETICAL
today(20261010).
baptized_in(apost_x,catholic). communion_at_issue(apost_x).
repudiates(apost_x,rep_x,christian_faith). act_date(rep_x,20200101).
baptized_in(apost_y,catholic). repudiates(apost_y,rep_y,christian_faith). act_date(rep_y,20220601).   % under the Code of 2021

```

part switch of tier2

```clingo
#program professions_definitive.    % HYPOTHETICAL: teaching held only at tier 2 (load with tier2 and assent)
today(20261010).
baptized_in(theo_t,catholic).
professes(theo_t,(prof_t97;prof_t00),q(d1),no). act_date(prof_t97,19970601). act_date(prof_t00,20000601).
warned(theo_t,(prof_t97;prof_t00),ordinary). interior(theo_t,(prof_t97;prof_t00),pertinacious).

```

part candidate

```clingo
#program cand_apostasy_by_count.    % heresies counted as apostasy (load with filioque, assent, professions_filioque)
apostasy_act(E) :- professes(_,E,_,_), censure(E,heretical).

```

part switch of moral_cases

```clingo
#program outside_moral.             % HYPOTHETICAL: c. 11 and the moral library (load with moral_cases)
baptized_in(m_out,lutheran).
act_of(m_out,act_out). kind_of_act(act_out,k_bound).                               % forbidden by an ecclesiastical law
act_of(m_out,act_out2). kind_of_act(act_out2,k_grave).                             % evil by its object
interior(m_out,(act_out;act_out2),(full_knowledge;deliberate_consent)).
act_of(child_s,act_s7). kind_of_act(act_s7,k_bound). age_at(child_s,act_s7,6).
interior(child_s,act_s7,(full_knowledge;deliberate_consent)).

```

part case

```clingo
#program prudential_case.           % HYPOTHETICAL: authentic teaching of the prudential order, and of principle
question(q(pq)). question_kind(q(pq),doctrinal). value(q(pq),(yes;no)).
source(dir_s,3,truth,2000). character(dir_s,letter). teaching_type(dir_s,directive). supports(dir_s,q(pq),yes).
question(q(eq)). question_kind(q(eq),doctrinal). value(q(eq),(yes;no)).
source(prin_s,3,truth,2000). character(prin_s,letter). supports(prin_s,q(eq),yes).
professes(theo_p,prof_pq,q(pq),no). professes(theo_p,prof_eq,q(eq),no).

```

part switch

```clingo
#program marriages_c1117.           % HYPOTHETICAL: who is bound to the form (c. 1117)
today(20261010).
marriage(m_lu,minister_l,20200610). spouse(m_lu,(lu_a;lu_b)). baptized_in((lu_a;lu_b),lutheran).   % two baptized non-Catholics
marriage(m_mix,minister_l,20200611). spouse(m_mix,(cat_m;lu_c)). baptized_in(cat_m,catholic). baptized_in(lu_c,lutheran).
marriage(m_def08,minister_l,20080612). spouse(m_def08,(def_p;lu_d)). baptized_in(lu_d,lutheran).
baptized_in(def_p,catholic). formal_defection(def_p,20050101).                    % left by a formal act, 2005
marriage(m_def11,minister_l,20110612). spouse(m_def11,(def_q;lu_e)). baptized_in(lu_e,lutheran).
baptized_in(def_q,catholic). formal_defection(def_q,20050101).

```

part switch

```clingo
#program communion_asked.           % HYPOTHETICAL: who is in full communion (load with sspx, lattice, or with seal, seal_case)
communion_at_issue((lefebvre;fellay;galarreta;conf_j;conf_k)).
baptized_in((lefebvre;fellay;galarreta;conf_j;conf_k),catholic).

```

part switch

```clingo
#program lg14_case.                 % HYPOTHETICAL: full communion, and grace claimed both ways
baptized_in(fid_l,catholic). communion_at_issue(fid_l).
disputed(interior(fid_l,state,in_grace)).

% ---------- Abortion, c. 1399, c. 1752, the Dicastery's clause, fictions (TTC-PENAL), all HYPOTHETICAL ----
```

part switch of life_sources

```clingo
#program abortion_canon.            % HYPOTHETICAL: direct abortions, one mother each (load with life_sources and abortion)
today(20261010).
unborn(death_of_unborn).
procures(doctor_b,(ab_15;ab_17;ab_fear;ab_pen;ab_aff;ab_out;ab_try;ab_19;ab_87;ab_87x;ab_90)).   % the one who performs it
object_is((ab_15;ab_17;ab_fear;ab_pen;ab_aff;ab_out;ab_try;ab_19;ab_87;ab_87x;ab_90),death_of_unborn).
effect((ab_15;ab_17;ab_fear;ab_pen;ab_aff;ab_out;ab_try;ab_19;ab_87;ab_87x;ab_90),death_of_unborn,evil).
act_date((ab_15;ab_17;ab_fear;ab_pen;ab_aff;ab_out;ab_try),20230401).
procures(m_15,ab_15).     age_at(m_15,ab_15,15).                                  % c. 1323 n. 1
procures(m_17,ab_17).     age_at(m_17,ab_17,17).                                  % c. 1324 §1 n. 4, §3
procures(m_fear,ab_fear). interior(m_fear,ab_fear,fear(grave,extrinsic,unjust)).  % c. 1323 n. 4's exception; c. 1324 §1 n. 5
procures(m_pen,ab_pen).   interior(m_pen,ab_pen,ignorance(penalty,invincible)).   % c. 1324 §1 n. 9
procures(m_aff,ab_aff).   interior(m_aff,ab_aff,ignorance(penalty,affected)).     % c. 1325
procures(m_out,ab_out).   baptized_in(m_out,lutheran).                           % c. 11
procures(m_try,ab_try).   attempted_only(ab_try).                                % c. 1328 §1
assists(nurse_n,ab_15).   disputed(necessary_assistance(nurse_n,ab_15)).          % c. 1329 §2
assists(nurse_u,ab_17).                                                          % assistance not necessary
act_date(ab_19,20190401).                                                        % under c. 1398 (1983)
act_date(ab_87,19870301). act_date(ab_90,19900301).                               % killed in utero, not by expulsion
act_date(ab_87x,19870302). by_expulsion(ab_87x).                                  % the expulsion of the immature fetus

```

part switch of life_sources

```clingo
#program abortion_canon_di.         % HYPOTHETICAL: TTC-PRECEPT's acts, dated (load with abortion or ectopic and their sources)
today(20261010).
unborn((death_of_unborn;death_of_child;death_of_embryo_s;death_of_embryo_t;death_of_embryo_m)).
act_date((abort_1;cranio;tube_out;embryo_out;mtx),20230301).
procures(mother_a,abort_1).                                                      % the mother who seeks it
procures(doctor_a,abort_1). procures(doctor_c,cranio). procures(doctor_e,tube_out).   % those who perform them
procures(doctor_t,embryo_out). procures(doctor_m,mtx).

```

part candidate of life_sources

```clingo
#program cand_salus_animarum.       % "salus animarum suprema lex" read as a power to set a penalty aside (load with abortion_canon)
sets_aside(text_s,n1397,salus_animarum).
latae_excused(P,N,E) :- delict(P,N,E), sets_aside(_,N,salus_animarum).

```

part switch

```clingo
#program transfer_case.             % HYPOTHETICAL: a pastor transferred (cc. 1748-1752)
transfer(dec_t,pastor_t,20230601).

```

part case

```clingo
#program c1399_case.                % HYPOTHETICAL: violations no canon names
today(20261010).
question(q(k_v_evil)). question_kind(q(k_v_evil),doctrinal). value(q(k_v_evil),(yes;no)). default(q(k_v_evil),yes).
classification(q(k_v_evil),k_v,evil_by_object).
act_of(cat_v,act_v). kind_of_act(act_v,k_v). act_date(act_v,20230501).
special_gravity(ordinary_v,act_v). scandal_necessity(ordinary_v,act_v).          % the authority's judgments, supplied
act_of(cat_w,act_w). kind_of_act(act_w,k_v). act_date(act_w,20230502).            % no judgment
act_of(cat_f,act_f). kind_of_act(act_f,k_f). act_date(act_f,20230503).            % forbidden by an ecclesiastical law
forbids(l_f,k_f). law_kind(l_f,ecclesiastical).
special_gravity(ordinary_v,act_f). scandal_necessity(ordinary_v,act_f).
act_of(out_v,act_o). kind_of_act(act_o,k_v). act_date(act_o,20230504). baptized_in(out_v,lutheran).   % c. 11
special_gravity(ordinary_v,act_o). scandal_necessity(ordinary_v,act_o).
act_of(conf_v,act_x). kind_of_act(act_x,k_v). act_date(act_x,20230505).           % a specific canon reaches it
delict_act(conf_v,n1386,act_x). special_gravity(ordinary_v,act_x). scandal_necessity(ordinary_v,act_x).

```

part switch

```clingo
#program art6_case.                 % HYPOTHETICAL: a cleric's delict with a minor, the error about the age claimed (TTC-ACT N1-N5)
today(20261010).
priest((cl_a;cl_b)).
delict_act(cl_a,n1398_1,act_a). act_date(act_a,20230301). disputed(interior(cl_a,act_a,error(fact(minor),invincible))).
delict_act(cl_b,n1398_1,act_b). act_date(act_b,20230302). interior(cl_b,act_b,error(fact(minor),vincible)).
% unlawful apart from the age: c. 277 §1, perfect and perpetual continence
kind_of_act((act_a;act_b),unchaste_act_of_cleric). forbids(c277_1,unchaste_act_of_cleric). law_kind(c277_1,ecclesiastical).
```

part switch

```clingo
#program art6_papal.                % the norms of 2021, promulgated by papal rescript (11 October 2021)
issuer(sst2021,francis). authority(francis,4).
```

part switch

```clingo
#program art6_decree.               % HYPOTHETICAL: the clause entered as a dicastery's general decree
issuer(sst2021,ddf). authority(ddf,3).
```

part switch

```clingo
#program art6_rank_disputed.        % HYPOTHETICAL: whether papal approval was given, disputed
disputed(issuer(sst2021,francis)). authority(francis,4).
```

part switch

```clingo
#program art6_transposed.           % HYPOTHETICAL (TTC-ACT N4): the clause on an act lawful apart from the circumstance
element_of(n_hyp,minor). age_clause(sst_hyp,n_hyp). issuer(sst_hyp,pope_h). authority(pope_h,4).
delict(P,n_hyp,E) :- delict_act(P,n_hyp,E).
delict_act(lay_t,n_hyp,act_t). act_date(act_t,20230303). interior(lay_t,act_t,error(fact(minor),invincible)).
kind_of_act(act_t,k_lawful).
```

part candidate

```clingo
#program cand_art6_moral.           % the clause read as a moral judgment: the species of the act though the age was unknown without fault (TTC-ACT N3)
question(q(species_with_age_unknown)). question_kind(q(species_with_age_unknown),doctrinal).
value(q(species_with_age_unknown),(yes;no)). default(q(species_with_age_unknown),yes).
law_answers(q(species_with_age_unknown)).

```

part case

```clingo
#program fiction_acts.              % HYPOTHETICAL: acts in the name of a juridic person, and of the Apostolic See (c. 118)
question(q(k_s_evil)). question_kind(q(k_s_evil),doctrinal). value(q(k_s_evil),(yes;no)). default(q(k_s_evil),yes).
classification(q(k_s_evil),k_s,evil_by_object).
juridic_person(diocese_d). represents(bishop_d,diocese_d).
act_of(diocese_d,act_d). kind_of_act(act_d,k_s). interior(bishop_d,act_d,deliberate_consent).
represents(pope_r,apostolic_see). act_of(apostolic_see,act_as). kind_of_act(act_as,k_neutral).
```

part candidate of fiction_acts

```clingo
#program cand_state_is_evil.        % "the state is evil": the state as the agent of an act evil by its object, with consent claimed
question(q(k_s_evil)). question_kind(q(k_s_evil),doctrinal). value(q(k_s_evil),(yes;no)). default(q(k_s_evil),yes).
classification(q(k_s_evil),k_s,evil_by_object).
juridic_person(state_x).            % a fiction of civil law
act_of(state_x,act_x_s). kind_of_act(act_x_s,k_s). interior(state_x,act_x_s,deliberate_consent).
```

part candidate

```clingo
#program cand_fiction_delict.       % a delict and its excommunication imputed to a juridic person (Romana ecclesia)
today(20261010). juridic_person(college_c).
delict_act(college_c,n1386,act_c). act_date(act_c,20230701).

% ---------- The computation of time (TTC-SAECULUM), all HYPOTHETICAL ------
```

part switch

```clingo
#program defection_2010.            % HYPOTHETICAL: a Catholic who defected by a formal act marries a Lutheran (CT1; load with on_0407 or on_0408)
today(20261010).
baptized_in(def_r,catholic). formal_defection(def_r,20050101). baptized_in(lu_f,lutheran).
```

part switch

```clingo
#program on_0407.                   % the day before Omnium in mentem's force
marriage(m_r,minister_l,20100407). spouse(m_r,(def_r;lu_f)).
```

part switch

```clingo
#program on_0408.                   % the day of it
marriage(m_r,minister_l,20100408). spouse(m_r,(def_r;lu_f)).
```

part switch

```clingo
#program issues_november.           % HYPOTHETICAL: laws in issues of 29 and 30 November, before a leap year and a common one (CT2)
aas_issue(law_a,20231129). aas_issue(law_b,20231130). aas_issue(law_c,20221129). aas_issue(law_d,20230831).
```

part switch

```clingo
#program particular_laws.           % HYPOTHETICAL: particular laws promulgated in the manner the legislator determined (CT5)
particular_law(pl_a). particular_law(pl_b). particular_law(pl_c). particular_law(pl_d).
promulgated(pl_a,20260901).                                  % a month: 1 October
promulgated(pl_b,20260131).                                  % February lacks the 31st: 1 March (c. 203 §2)
promulgated(pl_c,20261201).                                  % across the year: 1 January
promulgated(pl_d,20260901). vacatio_set(pl_d,20260901).      % the law sets its own time: at once
promulgated(ul_e,20260901). aas_issue(ul_e,20260901).       % not particular: c. 8 §1's three months, not c. 8 §2's one
```

part switch of tier2

```clingo
#program rejection_1998.            % HYPOTHETICAL: a definitive teaching rejected twice inside Ad tuendam fidem's unread span (CT3; load with tier2, assent, professions_definitive)
professes(theo_t,(prof_t98;prof_t99),q(d1),no). act_date(prof_t98,19981201). act_date(prof_t99,19990201).
warned(theo_t,(prof_t98;prof_t99),ordinary). interior(theo_t,(prof_t98;prof_t99),pertinacious).
```

part switch of life_sources

```clingo
#program ages_c97.                  % HYPOTHETICAL: ages from birth dates (CT4; load with life_sources, abortion, abortion_canon)
procures(m_b16,ab_b16). born(m_b16,20070401). act_date(ab_b16,20230401).    % her sixteenth birthday
procures(m_a16,ab_a16). born(m_a16,20070401). act_date(ab_a16,20230402).    % the day after
procures(m_f28,ab_f28). born(m_f28,20080229). act_date(ab_f28,20260228).    % born on 29 February: eighteen not yet completed
procures(m_f01,ab_f01). born(m_f01,20080229). act_date(ab_f01,20260301).    % an adult
object_is((ab_b16;ab_a16;ab_f28;ab_f01),death_of_unborn).
effect((ab_b16;ab_a16;ab_f28;ab_f01),death_of_unborn,evil).

% ---------- The Eastern Code (TTC-CCEO), all HYPOTHETICAL --------------------
```

part switch

```clingo
#program eastern_consecration.      % HYPOTHETICAL: an Eastern bishop consecrates without a mandate; a Latin one likewise (AS3)
today(20261010).
bishop((bp_e;bp_f;bp_l;bp_m)). baptized_in((bp_e;bp_f;bp_l;bp_m),catholic). ascribed((bp_e;bp_f),ukrainian).
consecration(e_east,bp_e,bp_f,20260801).
consecration(e_lat,bp_l,bp_m,20260802).
bishop(bp_g). baptized_in(bp_g,catholic). ascribed(bp_g,ukrainian).
consecration(e_1990,bp_e,bp_g,19900801).                           % before the Eastern Code
```

part switch of life_sources

```clingo
#program eastern_abortion.          % HYPOTHETICAL: an Eastern mother procures an abortion (EP1; load with life_sources, abortion, abortion_canon)
procures(m_east,ab_east). baptized_in(m_east,catholic). ascribed(m_east,maronite). act_date(ab_east,20230501).
object_is(ab_east,death_of_unborn). effect(ab_east,death_of_unborn,evil).
procures(m_east,ab_east90). act_date(ab_east90,19900501).            % before the Eastern Code
object_is(ab_east90,death_of_unborn). effect(ab_east90,death_of_unborn,evil).
```

part switch of ic

```clingo
#program eastern_faith.             % HYPOTHETICAL: a defined truth denied by a Latin and by two Eastern Catholics (EP2; load with ic, assent)
today(20261010).
baptized_in((theo_l;theo_e;theo_w;theo_x),catholic). ascribed((theo_e;theo_w;theo_x),melkite).
professes(theo_l,den_l,q(ic),no). act_date(den_l,20250301). interior(theo_l,den_l,pertinacious).
professes(theo_e,den_e,q(ic),no). act_date(den_e,20250302). warned(theo_e,den_e,ordinary).
professes(theo_w,den_w,q(ic),no). act_date(den_w,20250303).                                  % not warned
professes(theo_x,den_x,q(ic),no). act_date(den_x,19900303). warned(theo_x,den_x,ordinary).   % before the Eastern Code
doubts(theo_y,dub_y,q(ic)). act_date(dub_y,20250304). warned(theo_y,dub_y,ordinary).          % a doubt, warned
repudiates(theo_z,rep_z,christian_faith). act_date(rep_z,20250305). warned(theo_z,rep_z,ordinary).   % apostasy, warned
baptized_in((theo_y;theo_z),catholic). ascribed((theo_y;theo_z),melkite).
repudiates(theo_z,rep_z90,christian_faith). act_date(rep_z90,19900306). warned(theo_z,rep_z90,ordinary).   % before the Eastern Code
```

part switch

```clingo
#program eastern_ascription.        % HYPOTHETICAL: children of a Latin and an Eastern parent (AS2)
baptized_in((fa_1;mo_1;fa_2;mo_2;fa_3;mo_3;ch_1;ch_2;ch_3),catholic).
ascribed((mo_1;mo_2;fa_3),ukrainian).
father(ch_1,fa_1). mother(ch_1,mo_1). agreed(ch_1,latin).
father(ch_2,fa_2). mother(ch_2,mo_2).
father(ch_3,fa_3). mother(ch_3,mo_3).
baptized_in((fa_4;mo_4;ch_4;fa_5;mo_5;ch_5),catholic). ascribed((mo_4;fa_5;mo_5),ukrainian).
father(ch_4,fa_4). mother(ch_4,mo_4). agreed(ch_4,ukrainian).       % agreeing on the mother's Church
father(ch_5,fa_5). mother(ch_5,mo_5).                               % both Eastern
```

part switch

```clingo
#program eastern_chrismation.       % HYPOTHETICAL: presbyters confirming across the codes (CF1-CF3)
priest((pr_e;pr_l;pr_n)). baptized_in((pr_e;pr_l;pr_n),catholic). ascribed(pr_e,ukrainian). faculty_to_confirm(pr_l).
baptized_in((inf_l;inf_e;inf_e2;ad_l;ad_l2),catholic). ascribed((inf_e;inf_e2),ukrainian).
celebrated(chr_1,confirmation,pr_e,inf_l). celebration_date(chr_1,20260105).    % an Eastern presbyter, a Latin infant
celebrated(chr_2,confirmation,pr_l,inf_e). celebration_date(chr_2,20260106).    % a Latin presbyter with the faculty, an Eastern infant
celebrated(chr_3,confirmation,pr_n,inf_e2). celebration_date(chr_3,20260107).   % a Latin presbyter without it
celebrated(chr_4,confirmation,pr_l,ad_l). celebration_date(chr_4,20260108).     % a Latin adult, with the faculty
celebrated(chr_5,confirmation,pr_n,ad_l2). celebration_date(chr_5,20260109).    % without it
```

part candidate

```clingo
#program cand_presbyter_ordinary.   % a presbyter typed as the ordinary minister of confirmation (DH 1630)
typed_ordinary_minister(pr_l,confirmation).
```

part switch

```clingo
#program interritual_marriages.     % HYPOTHETICAL: marriages across the codes before a deacon and a priest (IM1-IM3)
today(20261010). ordinary(ord_x). deacon(dcn_d). priest(pr_m).
delegation(dl_d,ord_x,dcn_d,general,20100101). delegation(dl_p,ord_x,pr_m,general,20100101).
baptized_in((l_1;e_1;l_2;e_2;l_3;e_3;l_4;l_5;e_4;e_5;e_6;e_7;e_8),catholic).
ascribed((e_1;e_2;e_3;e_4;e_5;e_6;e_7;e_8),ukrainian). baptized_in((o_1;o_2;o_3),orthodox_church).
marriage(im_15,dcn_d,20150601). spouse(im_15,(l_1;e_1)).     % a Latin and an Eastern Catholic, before a deacon
marriage(im_16,dcn_d,20161220). spouse(im_16,(l_2;e_2)).
marriage(im_18,dcn_d,20180601). spouse(im_18,(l_3;e_3)).
marriage(lo_15,dcn_d,20150602). spouse(lo_15,(l_4;o_1)).     % a Latin Catholic and an Orthodox, before a deacon
marriage(lo_18,dcn_d,20180602). spouse(lo_18,(l_5;o_2)).
marriage(lo_16a,dcn_d,20161001). spouse(lo_16a,(l_6;o_4)).    % between the readings' dates: 1 October and 20 December 2016
marriage(lo_16b,dcn_d,20161220). spouse(lo_16b,(l_7;o_5)).
baptized_in((l_6;l_7),catholic). baptized_in((o_4;o_5),orthodox_church).
priest(pr_o). deacon(dc_o). baptized_in((pr_o;dc_o;o_6;o_7),orthodox_church). baptized_in((l_8;l_9),catholic).
marriage(lo_op,pr_o,20180607). spouse(lo_op,(l_8;o_6)).      % before an Orthodox priest, not delegated: valid (c. 1127 §1)
marriage(lo_od,dc_o,20150607). spouse(lo_od,(l_9;o_7)).      % before an Orthodox deacon in 2015: a sacred minister
priest(pr_u). deacon(dcn_u). baptized_in((l_10;l_11;l_12;e_12),catholic). ascribed(e_12,ukrainian).
marriage(ce_p,pr_u,20180608). spouse(ce_p,(l_10;l_11)). disputed(common_error(ce_p)).   % c. 144 supplies the faculty
marriage(ce_d,dcn_u,20180609). spouse(ce_d,(l_12;e_12)). disputed(common_error(ce_d)).  % but not the priesthood
marriage(ee_d,dcn_d,20180603). spouse(ee_d,(e_4;e_5)).       % two Eastern Catholics, before a deacon
marriage(ee_p,pr_m,20180604). spouse(ee_p,(e_6;e_7)).        % before a priest who assists and blesses
marriage(eo_d,dcn_d,20180605). spouse(eo_d,(e_8;o_3)).       % an Eastern Catholic and an Orthodox, before a deacon
```

part switch

```clingo
#program law_in_force.              % HYPOTHETICAL: a law binds the acts placed in its force (c. 9; cc. 7-8, 20) (WB3)
today(20261010).
% A law in force from 1 July 2026: an act placed before, and one after.
law_kind(l_dated,ecclesiastical). obliging(l_dated). promulgated(l_dated,20260601). vacatio_set(l_dated,20260701).
reading_option(l_dated,plain). needs_reading(l_dated,all). reaches(l_dated,plain,(act_before;act_after)).
act_date(act_before,20260615). act_date(act_after,20260715).
% A body of texts in force since 2020, expressly revoked from 1 July 2026.
law_kind(b_old_f,ecclesiastical). obliging(b_old_f). enacted_by(b_old_f,l_src_f).
promulgated(l_src_f,20200101). vacatio_set(l_src_f,20200101).
promulgated(l_rev_f,20260601). vacatio_set(l_rev_f,20260701). revokes(l_rev_f,b_old_f,expressly).
reading_option(b_old_f,plain). needs_reading(b_old_f,all). reaches(b_old_f,plain,(act_old;act_late)).
act_date(act_old,20260615). act_date(act_late,20260715).
% A body of texts enacted by a law in force from 1 July 2026: an act before, and one after.
law_kind(b_new_f,ecclesiastical). obliging(b_new_f). enacted_by(b_new_f,l_src_new).
promulgated(l_src_new,20260601). vacatio_set(l_src_new,20260701).
reading_option(b_new_f,plain). needs_reading(b_new_f,all). reaches(b_new_f,plain,(act_early;act_later)).
act_date(act_early,20260615). act_date(act_later,20260715).
% A law with no date of force entered: it binds as before.
law_kind(l_undated,ecclesiastical). obliging(l_undated).
reading_option(l_undated,plain). needs_reading(l_undated,all). reaches(l_undated,plain,act_any). act_date(act_any,20260615).
```

part switch

```clingo
#program option_held.               % HYPOTHETICAL: whose choice, a right regulated, a decision's reach (LW13)
today(20270601).
authority(pope_r,4). authority(dicastery_r,3). authority(bishop_r,1). authority(vicar_r,1).
holds_as(bishop_r,diocesan_bishop).
law_kind(book_r,ecclesiastical). legislator(book_r,pope_r). permits(book_r).
promulgated(book_r,20000420). vacatio_set(book_r,20000420).
option_of(book_r,mode_r,diocesan_bishop).                    % the bishop's own (RH1)
option_of(book_r,posture_r,celebrant).                       % someone else's (RH2, RR3)
option_of(book_r,tongue_r,communicant). right_of_the_faithful(tongue_r).
law_kind((l_mode;l_post;l_reg;l_bare;l_cele_reg;l_conf;l_low),ecclesiastical).
legislator((l_mode;l_post;l_reg;l_bare;l_cele_reg;l_conf;l_low),bishop_r).
obliging((l_mode;l_post;l_reg;l_bare;l_cele_reg;l_conf;l_low)).
promulgated((l_mode;l_post;l_reg;l_bare;l_cele_reg;l_conf;l_low),20260101).
vacatio_set((l_mode;l_post;l_reg;l_bare;l_cele_reg;l_conf;l_low),20260101).
reading_option((l_mode;l_post;l_reg;l_bare;l_cele_reg;l_conf;l_low),plain).
needs_reading((l_mode;l_post;l_reg;l_bare;l_cele_reg;l_conf;l_low),all).
reaches(l_mode,plain,mass_m). reaches(l_post,plain,mass_p). reaches(l_reg,plain,mass_r). reaches(l_bare,plain,mass_b).
reaches(l_cele_reg,plain,mass_e). reaches(l_conf,plain,mass_c). reaches(l_low,plain,mass_l).
act_date((mass_m;mass_p;mass_r;mass_b;mass_e;mass_c;mass_l),20260801).
narrows(l_mode,mode_r).                                      % RH1: binds
narrows(l_post,posture_r).                                   % RH2: contrary, as before
narrows(l_reg,tongue_r). disputed(regulates_exercise(l_reg,tongue_r)).      % RR1: both ways
narrows(l_bare,tongue_r).                                    % RR2: no claim, contrary
narrows(l_cele_reg,posture_r). regulates_exercise(l_cele_reg,posture_r).    % RR3: not a right of the faithful
narrows(l_conf,tongue_r). disputed(regulates_exercise(l_conf,tongue_r)).
decision_on_recourse(dec_r,l_conf,confirmed). issuer(dec_r,dicastery_r).   % RD1: settled for l_conf alone
narrows(l_low,tongue_r). disputed(regulates_exercise(l_low,tongue_r)).
decision_on_recourse(dec_low,l_low,confirmed). issuer(dec_low,vicar_r).    % RD3: not higher, settles nothing
% Before 1983: the bishop's own choice is no frontier; another's is (as in LW11).
law_kind((book_q;l_own_old;l_post_old),ecclesiastical). legislator(book_q,pope_r). legislator((l_own_old;l_post_old),bishop_r).
promulgated(book_q,19700101). vacatio_set(book_q,19700101).
option_of(book_q,mode_q,diocesan_bishop). option_of(book_q,posture_q,celebrant).
promulgated((l_own_old;l_post_old),19800101). vacatio_set((l_own_old;l_post_old),19800101).
narrows(l_own_old,mode_q). narrows(l_post_old,posture_q).
```

part switch

```clingo
#program option_narrowed.           % HYPOTHETICAL: diocesan laws and a choice a liturgical book leaves to the celebrant (LW11)
today(20270601).
authority(pope_o,4). authority(bishop_o,1).
law_kind((book_o;book_p;l_wd),ecclesiastical). legislator((book_o;book_p;l_wd),pope_o). permits((book_o;book_p)).
promulgated(book_o,20000420). vacatio_set(book_o,20000420). option_of(book_o,posture_o,celebrant).
law_kind((l_res;l_fixed;l_res_late;l_old),ecclesiastical). legislator((l_res;l_fixed;l_res_late;l_old),bishop_o).
obliging((l_res;l_fixed;l_res_late;l_old)).
reading_option((l_res;l_fixed;l_res_late),plain). needs_reading((l_res;l_fixed;l_res_late),all).
% Reserving the choice, 2025: contrary on both grounds, then and after.
promulgated(l_res,20250612). vacatio_set(l_res,20250701). narrows(l_res,posture_o). reaches(l_res,plain,mass_a). act_date(mass_a,20250801).
% Requiring what the book commends narrows no choice (praeter legem).
promulgated(l_fixed,20250612). vacatio_set(l_fixed,20250701). reaches(l_fixed,plain,church_a).
% The supreme authority withdraws the choice from 2027; the same reservation issued after binds.
promulgated(l_wd,20261001). vacatio_set(l_wd,20270101). withdraws_option(l_wd,posture_o).
promulgated(l_res_late,20270301). vacatio_set(l_res_late,20270301). narrows(l_res_late,posture_o).
reaches(l_res_late,plain,mass_c). act_date(mass_c,20270515).
% Before 1983: no ground encoded.
promulgated(book_p,19700101). vacatio_set(book_p,19700101). option_of(book_p,posture_p,celebrant).
promulgated(l_old,19800101). vacatio_set(l_old,19800101). narrows(l_old,posture_p).
```

part switch

```clingo
#program ius_superius.              % HYPOTHETICAL: diocesan laws against provisions of executive acts (LW12)
today(20261010).
authority(pope_h,4). authority(dicastery_h,3). authority(bishop_h,1).
law_kind((l_univ;l_gone_h),ecclesiastical). legislator((l_univ;l_gone_h),pope_h).
promulgated(l_univ,20000101). vacatio_set(l_univ,20000101). enacted_by(b_univ,l_univ).
promulgated(l_gone_h,20000101). vacatio_set(l_gone_h,20000101). enacted_by(b_gone_h,l_gone_h).
promulgated(l_rev_h,20200101). vacatio_set(l_rev_h,20200101). revokes(l_rev_h,b_gone_h,expressly).
act_kind((instr_h;instr_g;instr_k),instruction). issuer((instr_h;instr_g),dicastery_h). issuer(instr_k,bishop_h).
effective_from((instr_h;instr_g;instr_k),20100101). executes((instr_h;instr_k),l_univ). executes(instr_g,l_gone_h).
provision(instr_h,(p_ok;p_bad)). contrary_provision(p_bad,l_univ).   % p_bad cannot be reconciled with the law (c. 34 §2)
provision(instr_g,p_g). provision(instr_k,p_k).
law_kind((l_dioc_h;l_dioc_b;l_dioc_g;l_dioc_k;l_dioc_e;l_dioc_u),ecclesiastical).
legislator((l_dioc_h;l_dioc_b;l_dioc_g;l_dioc_k;l_dioc_e;l_dioc_u),bishop_h).
obliging((l_dioc_h;l_dioc_b;l_dioc_g;l_dioc_k;l_dioc_e;l_dioc_u)).
reading_option((l_dioc_h;l_dioc_b;l_dioc_g;l_dioc_k;l_dioc_e;l_dioc_u),plain).
needs_reading((l_dioc_h;l_dioc_b;l_dioc_g;l_dioc_k;l_dioc_e;l_dioc_u),all).
reaches(l_dioc_h,plain,person_h). reaches(l_dioc_b,plain,person_b). reaches(l_dioc_g,plain,person_g).
reaches(l_dioc_k,plain,person_k). reaches(l_dioc_e,plain,person_e). reaches(l_dioc_u,plain,person_u).
promulgated(l_dioc_h,20250101). promulgated(l_dioc_b,20250101). promulgated(l_dioc_g,20250101).
promulgated(l_dioc_k,20250101). promulgated(l_dioc_e,20050101).
particular_law(l_dioc_h). particular_law(l_dioc_b). particular_law(l_dioc_g).   % diocesan: c. 8 §2's month
particular_law(l_dioc_k). particular_law(l_dioc_e). particular_law(l_dioc_u).
contrary_to_provision(l_dioc_h,p_ok).    % against a dicastery's provision in force: invalid
contrary_to_provision(l_dioc_b,p_bad).   % against a provision without force (c. 34 §2): stands
contrary_to_provision(l_dioc_g,p_g).     % against a provision whose law has ceased (c. 34 §3): stands
contrary_to_provision(l_dioc_k,p_k).     % against the bishop's own instruction: stands
contrary_to_provision(l_dioc_e,p_ok).    % given before the instruction took effect: stands
contrary_to_provision(l_dioc_u,p_ok).    % no day of promulgation entered: not tested
```

part switch

```clingo
#program liturgical_day.            % HYPOTHETICAL: the General Calendar, its evenings, the Sunday obligation (LW14)
today(20261220).
% CP: a Saturday of Advent with an Optional Memorial, before a Sunday of Advent
celebration_on(20261212,weekday_a,13). celebration_on(20261212,memorial_m,12). celebration_on(20261213,sunday_a,2).
% an obligatory memorial over an optional one; a day of no. 9; an impeded Solemnity
celebration_on(20261214,memorial_o,10). celebration_on(20261214,memorial_p,12). celebration_on(20261214,weekday_c,13).
celebration_on(20261218,weekday_d,9). celebration_on(20261218,memorial_q,12).
celebration_on(20270321,sunday_l,2). celebration_on(20270321,solemnity_t,3). solemnity(solemnity_t).
% CE1: a Feast keeps its day
celebration_on(20261209,weekday_e,13). celebration_on(20261210,feast_g,7).
% CE2: a Solemnity with its own Vigil Mass, on a holy day of obligation, after a weekday
celebration_on(20261207,weekday_b,13). celebration_on(20261208,solemnity_s,3). solemnity(solemnity_s).
vigil_mass(solemnity_s,vigil_s). holy_day_of_obligation(20261208).
mass_at(mass_v1,20261207,1830). mass_formulary(mass_v1,vigil_s).
mass_at(mass_v2,20261207,1900). mass_formulary(mass_v2,weekday_b).        % not the Vigil Mass
mass_at(mass_v3,20261207,1230). mass_formulary(mass_v3,weekday_b).        % evening on one reading only
% ... and one whose eve is a Sunday of higher rank: the evening is the Sunday's
celebration_on(20261129,sunday_c,2). celebration_on(20261130,solemnity_u,3). solemnity(solemnity_u).
vigil_mass(solemnity_u,vigil_u).
mass_at(mass_u1,20261129,1800). mass_formulary(mass_u1,sunday_c).
% CE4: equal rank, the current day's
celebration_on(20270626,solemnity_p,3). solemnity(solemnity_p).
celebration_on(20270627,solemnity_q,3). celebration_on(20270627,sunday_o,6). solemnity(solemnity_q).
% CO: Masses on the Saturday and the Sunday, and who assists at what
mass_at(mass_x1,20261212,1700). mass_formulary(mass_x1,memorial_m).       % of the Saturday's own celebration
mass_at(mass_x2,20261212,1300).
mass_at(mass_x3,20261212,900).
mass_at(mass_x4,20261213,1000).
assists_at(person_a,mass_x2). assists_at(person_b,mass_x3). assists_at(person_c,service_w).
% CD1: the month's turn (the Sunday not entered, its weekday computed), the year's, and a leap day
mass_at(mass_w,20261031,1800).
mass_at(mass_n,20261231,2300). holy_day_of_obligation(20270101).
celebration_on(20240301,weekday_z,13).
```

part switch

```clingo
#program liturgical_day_proper.     % HYPOTHETICAL: the same days on a proper calendar, the memorial a Feast (LW14, CP2)
celebration_on(20261212,weekday_a,13). celebration_on(20261212,memorial_m,8). celebration_on(20261213,sunday_a,2).
```

part switch

```clingo
#program who_is_bound.              % HYPOTHETICAL: a merely ecclesiastical law and a divine law reaching all (WB1-WB2)
today(20261010).
law_kind(l_eccl,ecclesiastical). obliging(l_eccl). reading_option(l_eccl,plain). needs_reading(l_eccl,all).
law_kind(l_div,divine_positive). obliging(l_div). reading_option(l_div,plain). needs_reading(l_div,all).
reaches((l_eccl;l_div),plain,(pagan_w;orth_w;child_w;cath_w;act_k6)).
unbaptized(pagan_w). baptized_in(orth_w,orthodox_church).
baptized_in(child_w,catholic). born(child_w,20210101).
act_of(kid_w,act_k6). baptized_in(kid_w,catholic). born(kid_w,20190101). act_date(act_k6,20250601).
act_of(pagan_w,act_pg). reaches((l_eccl;l_div),plain,act_pg).                                   % an act of the unbaptized
```

part switch

```clingo
#program eastern_bond.              % HYPOTHETICAL: an Eastern marriage consummated and "dissolved"; one entered under violence (LK3; load with interritual_marriages)
consummated(ee_p). dissolution(ds_e,ee_p,civil_divorce,20200101).
baptized_in((e_9;e_10),catholic). ascribed((e_9;e_10),ukrainian).
marriage(ee_v,pr_m,20180606). spouse(ee_v,(e_9;e_10)). removes_voluntary(e_9,ee_v,violence).
```

part switch of tier2

```clingo
#program eastern_definitive.        % HYPOTHETICAL: an Eastern Catholic rejects a definitive teaching (EP4; load with tier2, assent)
today(20261010).
baptized_in(theo_d,catholic). ascribed(theo_d,ruthenian).
professes(theo_d,(prof_d97;prof_d00),q(d1),no). act_date(prof_d97,19970601). act_date(prof_d00,20000601).
warned(theo_d,(prof_d97;prof_d00),ordinary). interior(theo_d,(prof_d97;prof_d00),pertinacious).

% ---------- Documents as layers in time (TTC-SOURCES) ------------------------
```

part switch

```clingo
#program forms_in_time.             % HYPOTHETICAL: the form of marriage under the code of each date (TX1-TX5)
today(20261010). ordinary(ord_t). deacon(dcn_t). priest(pr_t).   % the parties' silence: Latin Catholics, bound
% TX1: a deacon delegated, in 1950 and 1990; a priest delegated, and one not, in 1950
marriage(tx_d50,dcn_t,19500610). spouse(tx_d50,(tx_a;tx_b)). delegation(dl_d50,ord_t,dcn_t,tx_d50,19500601).
marriage(tx_d90,dcn_t,19900610). spouse(tx_d90,(tx_c;tx_d)). delegation(dl_d90,ord_t,dcn_t,tx_d90,19900601).
marriage(tx_p50,pr_t,19500611). spouse(tx_p50,(tx_e;tx_f)). delegation(dl_p50,ord_t,pr_t,tx_p50,19500601).
marriage(tx_u50,pr_t,19500612). spouse(tx_u50,(tx_g;tx_h)).
% TX2: one who left the Church by a formal act marries a Lutheran before a minister
baptized_in((tx_l1;tx_l2;tx_l3),catholic). baptized_in((tx_m1;tx_m2;tx_m3),lutheran).
formal_defection(tx_l1,19450101). formal_defection(tx_l2,19850101). formal_defection(tx_l3,20050101).
marriage(tx_l50,min_t,19500613). spouse(tx_l50,(tx_l1;tx_m1)).
marriage(tx_l90,min_t,19900613). spouse(tx_l90,(tx_l2;tx_m2)).
marriage(tx_l11,min_t,20110613). spouse(tx_l11,(tx_l3;tx_m3)).
% TX3: born of non-Catholics, baptized Catholic, raised outside, marrying a Lutheran
baptized_in((tx_n1;tx_n2;tx_n3;tx_n4;tx_n5),catholic). baptized_in((tx_o1;tx_o2;tx_o3;tx_o4),lutheran).
born_of_noncatholics((tx_n1;tx_n2;tx_n3;tx_n4)). raised_outside((tx_n1;tx_n2;tx_n4;tx_n5)).
marriage(tx_n48,min_t,19480613). spouse(tx_n48,(tx_n1;tx_o1)).
marriage(tx_n50,min_t,19500614). spouse(tx_n50,(tx_n2;tx_o2)).
marriage(tx_r48,min_t,19480615). spouse(tx_r48,(tx_n3;tx_o3)).   % not raised outside: bound
marriage(tx_q48,min_t,19480616). spouse(tx_q48,(tx_n4;tx_n5)).   % marrying a Catholic: bound
marriage(tx_s48,min_t,19480617). spouse(tx_s48,(tx_n5;tx_o4)).   % raised outside, born of Catholics: bound
% TX4: a marriage of 1915, before any encoded text
marriage(tx_15,pr_t,19150615). spouse(tx_15,(tx_j;tx_k)). delegation(dl_15,ord_t,pr_t,tx_15,19150601).
dissolution(dx_15,tx_15,civil_divorce,19200101).                   % the bond at issue: not computed
```

part switch

```clingo
#program documents_in_time.         % the force of documents at a date (GN1, GN4; with today)
doc_at_issue((form_text_1917;c1099_2_clause_1917;sp_text;ue2011)).
```

part switch of law_cases

```clingo
#program revocation_dated.          % HYPOTHETICAL: c. 21 with dates (GN3; load with law_cases, whose clock it reads)
promulgated(l_old_x,19900101). vacatio_set(l_old_x,19900101). enacted_by((b_old_x;b_old_y;b_old_z;b_old_w),l_old_x).
promulgated(l_new_x,20000101). vacatio_set(l_new_x,20000101).
reorders(l_new_x,(b_old_x;b_old_y)). doubtful_revocation(l_new_x,b_old_x).
directly_contrary(l_new_x,(b_old_z;b_old_w)). doubtful_revocation(l_new_x,b_old_z).
doc_at_issue((b_old_x;b_old_y;b_old_z;b_old_w)).
```

part switch

```clingo
#program executive_acts.            % HYPOTHETICAL: instructions, executory decrees and general decrees (GN5, GN6)
today(20100101).
promulgated(l_exec,20000101). vacatio_set(l_exec,20000101). enacted_by(b_exec,l_exec).
act_kind(instr_x,instruction). executes(instr_x,l_exec). effective_from(instr_x,20050101).
provision(instr_x,(p_ok;p_bad)). contrary_provision(p_bad,l_exec).
promulgated(l_gone,20000101). vacatio_set(l_gone,20000101). enacted_by(b_gone,l_gone).
promulgated(l_rev,20080101). vacatio_set(l_rev,20080101). revokes(l_rev,b_gone,expressly).
act_kind(ged_x,general_executory_decree). executes(ged_x,l_exec). effective_from(ged_x,20050101).
act_kind(ged_y,general_executory_decree). executes(ged_y,l_gone). effective_from(ged_y,20050101).
act_kind((gd_void;gd_void2;gd_void3;gd_grant;gd_leg),general_decree).
executive_power_only((gd_void;gd_void2;gd_void3;gd_grant)). express_grant(gd_grant).
promulgated((gd_void;gd_void2;gd_void3;gd_grant;gd_leg),20050101).
vacatio_set((gd_void;gd_leg),20050101). aas_issue((gd_void2;gd_grant),20050201). aas_volume(gd_void3,2005,20050101).
enacted_by(b_gd_void,gd_void). enacted_by(b_gd_void2,gd_void2). enacted_by(b_gd_void3,gd_void3).
enacted_by(b_gd_grant,gd_grant). enacted_by(b_gd_leg,gd_leg).
doc_at_issue((b_exec;instr_x;ged_x;ged_y;b_gd_void;b_gd_void2;b_gd_void3;b_gd_grant;b_gd_leg)).
```

part switch

```clingo
#program collections_hyp.           % HYPOTHETICAL: a decretal ascribed to a second-century pope that quotes a fourth-century council (CO1)
collection(coll_private,private). collection(coll_auth,authentic).
part_of(dec_p,coll_private). part_of(dec_a,coll_auth).
promulgated(prom_auth,12340905). vacatio_set(prom_auth,12340905). enacted_by(coll_auth,prom_auth).
attribution((dec_p;dec_a),pope_ii,the_collection). died(pope_ii,160).
text_year(council_iv,325). text_year(witness_c,1628).
draws_on((dec_p;dec_a),council_iv,witness_c).

% ---------- The liturgy: the rite (TTC-LITURGY) ------------------------------
```

part switch

```clingo
#program orders_in_time.            % HYPOTHETICAL: ordinations to the priesthood with and without the porrection (RS2)
bishop(bp_o).
celebrated(ord_00,orders(presbyterate),bp_o,cand_00).   celebration_date(ord_00,19000601).
celebrated(ord_00p,orders(presbyterate),bp_o,cand_00p). celebration_date(ord_00p,19000602). porrection(ord_00p).
celebrated(ord_50,orders(presbyterate),bp_o,cand_50).   celebration_date(ord_50,19500601).
```

part switch of we_baptize

```clingo
#program rite_changes.              % HYPOTHETICAL: a changed form and a changed prayer (RS3; load with we_baptize; anyone baptizes)
celebrated(bap_we,baptism,pr_w,inf_w).  act_date(bap_we,20210601).  form_used(bap_we,we_baptize).
celebrated(bap_alt,baptism,pr_w,inf_a). act_date(bap_alt,20210602). alters(bap_alt,closing_prayer).
```

part switch of sacrament_conditions

```clingo
#program liturgical_books_hyp.      % HYPOTHETICAL: liturgical books changing a sacrament's conditions, even from the Apostolic See (RS1; load with sacrament_conditions)
changes_condition(book_x,baptism,matter). changes_condition(book_y,matrimony,canonical_form).

```

part switch

```clingo
#program indulgence_grants.       % HYPOTHETICAL: partial indulgences granted in days, before and after Indulgentiarum doctrina (DU2, DU3)
indulgence(g_1950,partial,19500601). in_days(g_1950,300).
indulgence(g_1970,partial,19700601). in_days(g_1970,300).
```

part candidate

```clingo
#program cand_days_in_purgatory.  % HYPOTHETICAL: the grant's days read as days in purgatory (DU2; load with indulgence_grants)
days_read_as(g_1950,time_after_death).

```

part switch

```clingo
#program conjoined_twins.         % HYPOTHETICAL: conjoined twins, the doubt whether one or two recorded, born in 1950 and in 2000 (TW4)
doubt_one_or_more(cj_1950,19500301). born_together(cj_1950,(cj_a;cj_b)).
doubt_one_or_more(cj_2000,20000301). born_together(cj_2000,(cj_c;cj_d)).
```
