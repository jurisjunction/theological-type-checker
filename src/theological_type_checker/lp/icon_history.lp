% ===================================================================
%  Authority data: historical backtests and worked cases.
%  Tiers are assigned as of the evaluation date (promoted/3 records
%  when a theologian was declared a Doctor), so a backtest "as of 1600"
%  sees only what existed then, with the standing it had then.
% ===================================================================

% @input attends/2 | attends(P, X): P attends X, an outward fact (never adherence)
% @input bond_kind/1 | bond_kind(B): a bond of communion (LG 14; UR 3)
% @input community/1 | community(C): a community whose bonds of communion are compared
% @input condition_in_question/2 | condition_in_question(K, C): asked whether condition C is of the substance of sacrament K
% @input confessed/1 | confessed(P): P has confessed, an outward fact
% @input continent/1 | continent(P): P lives in continence (FC 84)
% @input declared_by_authority/1 | declared_by_authority(P): P's adherence declared by competent authority
% @input figure/1 | figure(F): the runtime is the node of the figure F (TTC-MODERNITY), for the hearers' tongues
% @input internal_forum_actor/1 | internal_forum_actor(A): one who acts in the internal forum (a confessor)
% @input irregular_union/1 | irregular_union(P): P lives in an irregular union, an outward fact
% @input refuses/2 | refuses(X, T): X publicly refuses the teaching T
% @input schism_basis/1 | schism_basis(B): a ground c. 751 gives for schism
% @input separated_body/1 | separated_body(C): a community separated from full communion
% @input silent/3 | silent(Person, Act, Q): an outward silence on the question
% @input teaching_tier/2 | teaching_tier(T, K): the tier of the teaching T
% @input theses_directive/0 | the 24 Theses read as directive norms, 1916 (a switch)

% ---------- Immaculate Conception ------------------------------------
#program ic.
question(q(ic)). value(q(ic),yes). value(q(ic),no). question_kind(q(ic),doctrinal).
source(bernard,5,truth,1140).     promoted(bernard,4,1830).     supports(bernard,q(ic),no).     % Ep. 174
source(bonaventure,5,truth,1250). promoted(bonaventure,4,1588). supports(bonaventure,q(ic),no). % In III Sent. d.3
source(aquinas,5,truth,1273).     promoted(aquinas,4,1567).     supports(aquinas,q(ic),no).     % ST III q.27 a.2
source(scotus,5,truth,1300).                                    supports(scotus,q(ic),yes).     % Ord. III d.3 q.1
source(grave_nimis,3,protective,1483).  protects(grave_nimis,q(ic)).    % Sixtus IV
source(trent_1546,1,protective,1546).   protects(trent_1546,q(ic)).     % Sess. V, DH 1516
conciliar_act(trent_1546,scope).        % the council declares its decree does not include Mary
source(sollicitudo_1661,3,truth,1661).  supports(sollicitudo_1661,q(ic),yes).   % Alexander VII
character(sollicitudo_1661,constitution).
source(ineffabilis_1854,1,truth,1854).  supports(ineffabilis_1854,q(ic),yes).   % Pius IX
papal_form(grave_nimis,legislative). papal_form(sollicitudo_1661,ordinary).
papal_form(ineffabilis_1854,ex_cathedra). object_of(ineffabilis_1854,revealed).   % "revealed by God" (DH 2803)
condition_shown(ineffabilis_1854,(pastor_of_all;apostolic_authority;defines;faith_or_morals;whole_church)).
% "declaramus, pronuntiamus et definimus ... ab omnibus fidelibus firmiter constanterque credendam" (DH 2803)
preserved_from_os(mary) :- holds(q(ic),yes).    % the dogma in the economy (kernel_core.lp; TTC-CREED EC1)

#program ic_unprotected.          % ablation: remove both protective acts
relaxed(grave_nimis). relaxed(trent_1546).

#program asof_1400. asof(1400). custom_asof.
#program asof_1100. asof(1100). custom_asof.
#program asof_1250. asof(1250). custom_asof.
#program asof_1550. asof(1550). custom_asof.
#program asof_1600. asof(1600). custom_asof.
#program asof_1850. asof(1850). custom_asof.
#program asof_1860. asof(1860). custom_asof.
#program asof_440.  asof(440).  custom_asof.
#program asof_1260. asof(1260). custom_asof.
#program asof_1890. asof(1890). custom_asof.
#program asof_1950. asof(1950). custom_asof.
#program asof_900.  asof(900).  custom_asof.
#program asof_1500. asof(1500). custom_asof.
#program asof_1000. asof(1000). custom_asof.
#program asof_1200. asof(1200). custom_asof.
#program asof_1300. asof(1300). custom_asof.
#program asof_1332. asof(1332). custom_asof.
#program asof_1335. asof(1335). custom_asof.
#program asof_1337. asof(1337). custom_asof.
#program asof_1440. asof(1440). custom_asof.
#program asof_1968. asof(1968). custom_asof.
#program asof_1970. asof(1970). custom_asof.
#program asof_2014. asof(2014). custom_asof.
#program asof_1616. asof(1616). custom_asof.
#program asof_1633. asof(1633). custom_asof.
#program asof_1700. asof(1700). custom_asof.
#program asof_1730. asof(1730). custom_asof.
#program asof_1800. asof(1800). custom_asof.
#program asof_1830. asof(1830). custom_asof.
#program asof_1925. asof(1925). custom_asof.
#program asof_2000. asof(2000). custom_asof.

% ---------- De auxiliis: a branch protected and never cleaved ---------
#program auxiliis.
question(q(efficacious_grace)). question_kind(q(efficacious_grace),doctrinal).
value(q(efficacious_grace),physical_premotion). value(q(efficacious_grace),middle_knowledge).
source(banez,5,truth,1584).  supports(banez,q(efficacious_grace),physical_premotion).
source(molina,5,truth,1588). supports(molina,q(efficacious_grace),middle_knowledge).
source(paul_v_1607,3,protective,1607). protects(paul_v_1607,q(efficacious_grace)).
papal_form(paul_v_1607,ordinary).

% ---------- Disparity of cult: a juridical cleave and its dispensation -
#program disparity.
uses(icon).                             % the Grammar of the Icon
god(god).
created_person(m). created_person(w). created_person(c).
question(q(disparity(m,w))). question_kind(q(disparity(m,w)),juridical).
value(q(disparity(m,w)),impeded). value(q(disparity(m,w)),not_impeded).
default(q(disparity(m,w)),not_impeded).                     % c. 1058
source(c1086,3,juridical,1983). papal_form(c1086,legislative). supports(c1086,q(disparity(m,w)),impeded).
impeded(m,w) :- holds(q(disparity(m,w)),impeded).          % into the core grammar
proposed_bond(m,w). consent(m,w). consent(w,m). capable_closing(m,w).
gen(conception,m,c). gen(conception,w,c). closed_in_act(conception,m,w).

#program dispensed. relaxed(c1086).

% ---------- Tier 2: whose word fixes its force? -----------------------
#program tier2.                   % HYPOTHETICAL in part: the warrant of definitive_d1 is supposed (synthetic)
question(q(d1)). value(q(d1),yes). value(q(d1),no).
source(definitive_d1,2,truth,2000). supports(definitive_d1,q(d1),yes).
hypothetical_warrant(definitive_d1).   % synthetic
source(lg25,3,truth,1964).  meta_supports(lg25,t2_truth).  interpretive(lg25,t2_truth).  % extent left open (Gasser)
character(lg25,conciliar_constitution).   % Vatican II defines "only when the Council itself openly declares so" (notification, 16 Nov. 1964)
source(cdf_1998,3,truth,1998). meta_supports(cdf_1998,t2_truth).
character(cdf_1998,commentary).
question_kind(q(d1),doctrinal).
% governance binding to teaching by reference
source(c750_1,3,juridical,1983). papal_form(c750_1,legislative). binds(c750_1,1,divine_and_catholic_faith).
source(c752,3,juridical,1983).   papal_form(c752,legislative).   binds(c752,3,religious_submission).
source(atf_1998,3,juridical,1998). papal_form(atf_1998,legislative).  % Ad Tuendam Fidem: inserts c. 750 §2
binds(atf_1998,2,firm_assent).

#program cdf_fixes_tier2.         % the CDF 1998 commentary treated as fixing the force of tier 2
treated_as_fixing(cdf_1998,t2_truth).

#program atf_fixes_tier2.         % the legislator's act read as teaching, and as settling tier 2
meta_supports(atf_1998,t2_truth). treated_as_fixing(atf_1998,t2_truth).

#program atf_as_tier1.            % a legislative act entered at tier 1
source(atf_misread,1,juridical,1998). papal_form(atf_misread,legislative).

% ---------- Infants who die without baptism ---------------------------
#program limbo.
uses(icon).                             % the Grammar of the Icon
god(god). bridegroom(son). incarnate(son). created_person(infant).   % the incarnate is the Son (TTC-CREED CR2)
question(q(infant_state)).  question_kind(q(infant_state),doctrinal).
value(q(infant_state),original_sin_alone). value(q(infant_state),held_in_trust).
question(q(infant_fate)).   question_kind(q(infant_fate),doctrinal).
value(q(infant_fate),poena_sensus). value(q(infant_fate),limbo). value(q(infant_fate),beatific).
% modelling link: a welcome held in trust (as at baptism) admits the infant to the bond
held_for(god_supplies,infant,son) :- holds(q(infant_state),held_in_trust).
:- holds(q(infant_state),held_in_trust), not holds(q(infant_fate),beatific).
% Florence, Laetentur caeli (DH 1306), tier 1: those who die in original sin
% alone do not attain the beatific vision. Its content, as a hard constraint:
source(florence_1439,1,truth,1439). conciliar_act(florence_1439,definition).   % "diffinimus" (DH 1300)
:- holds(q(infant_state),original_sin_alone), holds(q(infant_fate),beatific).
source(augustine,5,truth,421). promoted(augustine,4,1298).                 % Enchiridion 93
supports(augustine,q(infant_fate),poena_sensus). supports(augustine,q(infant_state),original_sin_alone).
source(aquinas_l,5,truth,1270). promoted(aquinas_l,4,1567).                % De malo q.5 a.3
supports(aquinas_l,q(infant_fate),limbo). supports(aquinas_l,q(infant_state),original_sin_alone).
source(auctorem_fidei_1794,3,protective,1794). protects(auctorem_fidei_1794,q(infant_fate)). % prop. 26, DH 2626
source(ccc_1261,3,truth,1992). supports(ccc_1261,q(infant_fate),beatific).  % "allow us to hope"
character(ccc_1261,catechism).
source(itc_2007,4,truth,2007). supports(itc_2007,q(infant_fate),beatific). supports(itc_2007,q(infant_state),held_in_trust).

#program refusal.                 % "his own received him not" (Jn 1:11)
uses(icon).                             % the Grammar of the Icon
god(god). bridegroom(son). incarnate(son).
created_person(receiver). created_person(refuser).
consent(receiver,son).

% ---------- The death penalty ------------------------------------------
#program deathpenalty.
question(q(dp_principle)).   question_kind(q(dp_principle),doctrinal).
value(q(dp_principle),permitted). value(q(dp_principle),intrinsically_wrong).
question(q(necessity_today)). question_kind(q(necessity_today),doctrinal).
value(q(necessity_today),sometimes). value(q(necessity_today),none).
:- holds(q(dp_principle),intrinsically_wrong), holds(q(necessity_today),sometimes).
source(dh795,3,truth,1208). papal_form(dh795,ordinary).          % Innocent III, profession for the Waldensians
supports(dh795,q(dp_principle),permitted).
oum_claim(dh795,2).                                              % claimed by critics; no tier-1 act says so
oum_claimant(dh795,critics).
source(roman_catechism,3,truth,1566). supports(roman_catechism,q(dp_principle),permitted).
source(ev56,3,truth,1995). papal_form(ev56,ordinary). supports(ev56,q(dp_principle),permitted).
source(ccc1997,3,truth,1997). cites(ccc1997,ev56). supports(ccc1997,q(dp_principle),permitted).
withdrawn(ccc1997,2018).                                         % text replaced by the 2018 rescript
source(ccc2018,3,truth,2018). papal_form(ccc2018,ordinary).      % "inadmissible because it is an attack on ... dignity"
ambiguous(ccc2018). reading(ccc2018,circumstantial). reading(ccc2018,intrinsic).
reads(ccc2018,circumstantial,q(necessity_today),none). reads(ccc2018,intrinsic,q(dp_principle),intrinsically_wrong).
source(cdf2018,3,truth,2018).                                    % "authentic development ... not in contradiction"
supports(cdf2018,q(necessity_today),none). interprets(cdf2018,ccc2018,circumstantial).
source(ft2020,3,truth,2020). papal_form(ft2020,ordinary). supports(ft2020,q(necessity_today),none).
source(di2024,3,truth,2024).                                     % "regardless of the circumstances"
character(dh795,profession). character(roman_catechism,catechism). character(ev56,encyclical).
character(ccc1997,catechism). character(ccc2018,catechism). character(cdf2018,letter).
character(ft2020,encyclical). character(di2024,declaration).
ambiguous(di2024). reading(di2024,intrinsic). reading(di2024,circumstantial).
reads(di2024,intrinsic,q(dp_principle),intrinsically_wrong). reads(di2024,circumstantial,q(necessity_today),none).

#program asof_2017. asof(2017). custom_asof.
#program asof_2019. asof(2019). custom_asof.
#program ccc_circumstantial. :- read_as(ccc2018,intrinsic).
#program ccc_intrinsic.      :- read_as(ccc2018,circumstantial).
#program di_circumstantial.  :- read_as(di2024,intrinsic).
#program di_intrinsic.       :- read_as(di2024,circumstantial).
#program no_oum.             :- oum_holds(_).
#program oum_dh795.          :- not oum_holds(dh795).

% ---------- Communion for the divorced and remarried ------------------
#program remarriage.
question(q(first_bond)). question_kind(q(first_bond),doctrinal).
value(q(first_bond),indissoluble). value(q(first_bond),dissolved).
source(trent_1563,1,truth,1563). supports(trent_1563,q(first_bond),indissoluble).   % Sess. XXIV c. 7, DH 1807
conciliar_act(trent_1563,canon).
% internal forum: is the norm on admission teaching or governance? Left open.
question(q(admission_internal)).
value(q(admission_internal),only_if_continent). value(q(admission_internal),possible_in_some_cases).
1 { question_kind(q(admission_internal),doctrinal) ; question_kind(q(admission_internal),governance) } 1.
source(fc84,3,truth,1981). papal_form(fc84,ordinary).
supports(fc84,q(admission_internal),only_if_continent). oum_claim(fc84,2).   % claimed by critics
oum_claimant(fc84,critics).
source(cdf1994,3,truth,1994). cites(cdf1994,fc84). supports(cdf1994,q(admission_internal),only_if_continent).
source(sc29,3,truth,2007). papal_form(sc29,ordinary). reaffirms(sc29,fc84). supports(sc29,q(admission_internal),only_if_continent).
source(al2016,3,truth,2016). papal_form(al2016,ordinary). supports(al2016,q(admission_internal),possible_in_some_cases).
character(fc84,exhortation). character(cdf1994,letter). character(sc29,exhortation).
character(al2016,exhortation). character(ba2016,letter). dicastery(pclt2000).
source(ba2016,3,truth,2016). reaffirms(ba2016,al2016). supports(ba2016,q(admission_internal),possible_in_some_cases). % AAS, "authentic Magisterium"
% external forum: c. 915 and the 2000 PCLT declaration
question(q(admission_external)). question_kind(q(admission_external),juridical).
value(q(admission_external),barred_if_obstinate_and_manifest). value(q(admission_external),admitted).
source(c915,3,juridical,1983). papal_form(c915,legislative). supports(c915,q(admission_external),barred_if_obstinate_and_manifest).
source(pclt2000,3,juridical,2000). cites(pclt2000,c915). supports(pclt2000,q(admission_external),barred_if_obstinate_and_manifest).
% persons: imputability is an input from the internal forum, never computed (rule of non-diagnosis)
internal_forum_actor(confessor).
irregular_union(p1). irregular_union(p2).
discerned(p1,diminished,confessor). discerned(p2,full,confessor).
grave_matter(P) :- irregular_union(P).                                  % objective; both schools agree
mortal_sin(P)   :- grave_matter(P), discerned(P,full,_).                % CCC 1857
communion(P) :- holds(q(admission_internal),possible_in_some_cases), irregular_union(P),
                discerned(P,diminished,A), internal_forum_actor(A).
communion(P) :- continent(P), irregular_union(P).
% Trent, Sess. XIII c. 11 (DH 1661), tier 1: no one conscious of mortal sin without confession
source(trent_1551,1,truth,1551). conciliar_act(trent_1551,canon).
violation(trent_1661(P)) :- communion(P), mortal_sin(P), not confessed(P).
violation(diagnosis(P,A)) :- discerned(P,_,A), not internal_forum_actor(A).

#program external_barred.  :- not holds(q(admission_external),barred_if_obstinate_and_manifest).
#program count_all.        count_all.        % ablation: every source counts, citing or not
#program typed_governance. :- question_kind(q(admission_internal),doctrinal).
#program typed_doctrinal.  :- question_kind(q(admission_internal),governance).
#program oum_fc84.         :- not oum_holds(fc84).
#program cand_diagnose.                    % the checker assigning an interior
discerned(P,diminished,system) :- irregular_union(P).
#program cand_full_imputability_admitted.  % admit someone discerned as fully culpable
communion(p2).

% ---------- The communion lattice (shared by ecumenism and SSPX) -------
#program lattice.
% communion as a SET of bonds (LG 14; UR 3; CCC 815), not a number; the
% Petrine bond is split into the parts canon law actually distinguishes
bond_kind(baptism;scripture;nicene_creed;chalcedon;orders;eucharist;later_dogmas).
bond_kind(primacy_recognized;canonical_mission;faculties_confession;faculties_marriage).
lacks_vs(C1,C2) :- has(C1,B), community(C2), not has(C2,B).
geq(C2,C1)      :- community(C1), community(C2), C1 != C2, not lacks_vs(C1,C2).
info(degree(C2,above,C1)) :- geq(C2,C1), not geq(C1,C2).
info(incomparable(C1,C2)) :- community(C1), community(C2), C1 < C2, not geq(C1,C2), not geq(C2,C1).
missing(C) :- community(C), bond_kind(B), not has(C,B).
info(full_communion(C))       :- community(C), not missing(C).
info(imperfect_communion(C))  :- has(C,baptism), missing(C).                 % UR 3
% Dominus Iesus 17 classifies separated bodies only; an internal society is another sort
church_proper(C) :- has(C,orders), has(C,eucharist), separated_body(C).
info(church_proper(C)) :- church_proper(C), missing(C).
info(di_ranks_above(C1,C2)) :- church_proper(C1), separated_body(C2), not church_proper(C2), missing(C1), missing(C2).

% ---------- Ecumenism: degrees of communion ---------------------------
#program ecumenism.
community(catholic;eastern_catholic;orthodox;oriental_orthodox;anglican;lutheran).
separated_body(orthodox;oriental_orthodox;anglican;lutheran).
has(catholic,B) :- bond_kind(B).
has(eastern_catholic,B) :- bond_kind(B).
has(orthodox,(baptism;scripture;nicene_creed;chalcedon;orders;eucharist)).
has(oriental_orthodox,(baptism;scripture;nicene_creed;orders;eucharist)).   % Chalcedon not received (cf. 1973 common declaration)
has(lutheran,(baptism;scripture;nicene_creed;chalcedon)).
has(anglican,(baptism;scripture;nicene_creed;chalcedon)).
has(anglican,orders)    :- holds(q(anglican_orders),valid).
has(anglican,eucharist) :- holds(q(anglican_orders),valid).

% Anglican orders: Apostolicae Curae; its tier-2 status is a tier-3 classification (CDF 1998)
question(q(anglican_orders)). question_kind(q(anglican_orders),doctrinal).
value(q(anglican_orders),valid). value(q(anglican_orders),invalid).
source(ac1896,3,truth,1896). supports(ac1896,q(anglican_orders),invalid). oum_claim(ac1896,2).
oum_claimant(ac1896,cdf_1998). claims_tier(cdf_1998,ac1896,2).   % CDF, commentary on the Professio fidei (1998) n. 11
source(cdf_1998,3,truth,1998). character(cdf_1998,commentary).
source(dutch_touch,5,truth,1932). supports(dutch_touch,q(anglican_orders),valid).

% membership: binary or graded?
question(q(membership)). question_kind(q(membership),doctrinal).
value(q(membership),binary). value(q(membership),graded).
source(mc1943,3,truth,1943). papal_form(mc1943,ordinary). supports(mc1943,q(membership),binary).      % MC 22
source(lg14,3,truth,1964).                                                                            % "fully incorporated"
ambiguous(lg14). reading(lg14,graded_incorporation). reading(lg14,members_and_joined).
reads(lg14,graded_incorporation,q(membership),graded). reads(lg14,members_and_joined,q(membership),binary).

% identity: is the Church of Christ the Catholic Church?
question(q(church_identity)). question_kind(q(church_identity),doctrinal).
value(q(church_identity),identical). value(q(church_identity),broader).
supports(mc1943,q(church_identity),identical).                                                        % MC 13
source(hg1950,3,truth,1950). papal_form(hg1950,ordinary). supports(hg1950,q(church_identity),identical).
source(lg8,3,truth,1964).                                                                             % "subsistit in"
ambiguous(lg8). reading(lg8,identity_with_elements). reading(lg8,broader).
reads(lg8,identity_with_elements,q(church_identity),identical). reads(lg8,broader,q(church_identity),broader).
source(cdf1985,3,truth,1985). interprets(cdf1985,lg8,identity_with_elements).                         % Boff notification
source(di2000,3,truth,2000).  interprets(di2000,lg8,identity_with_elements).
source(cdf2007,3,truth,2007). interprets(cdf2007,lg8,identity_with_elements).

% extra ecclesiam nulla salus
question(q(salvation_nonmembers)). question_kind(q(salvation_nonmembers),doctrinal).
value(q(salvation_nonmembers),possible). value(q(salvation_nonmembers),impossible).
question(q(salvation_knowing_refusers)). question_kind(q(salvation_knowing_refusers),doctrinal).
value(q(salvation_knowing_refusers),possible). value(q(salvation_knowing_refusers),impossible).
source(florence1442,1,truth,1442).                                                                    % Cantate Domino, DH 1351
conciliar_act(florence1442,creed).
ambiguous(florence1442). reading(florence1442,outside_as_nonmember). reading(florence1442,outside_as_no_bond).
reads(florence1442,outside_as_nonmember,q(salvation_nonmembers),impossible).
reads(florence1442,outside_as_no_bond,q(salvation_knowing_refusers),impossible).
supports(lg14,q(salvation_knowing_refusers),impossible).                                              % LG 14
supports(mc1943,q(salvation_nonmembers),possible).                                                    % MC 103, votum
source(ho1949,3,truth,1949). supports(ho1949,q(salvation_nonmembers),possible).                       % letter to Cushing
interprets(ho1949,florence1442,outside_as_no_bond).
source(lg16,3,truth,1964). cites(lg16,ho1949). supports(lg16,q(salvation_nonmembers),possible).
source(ur3,3,truth,1964). supports(ur3,q(salvation_nonmembers),possible).                             % "means of salvation"
source(ccc847,3,truth,1992). cites(ccc847,lg16). supports(ccc847,q(salvation_nonmembers),possible).
source(feeney,5,truth,1949). supports(feeney,q(salvation_nonmembers),impossible).
character(mc1943,encyclical). character(hg1950,encyclical). character(lg8,conciliar_constitution).
character(lg14,conciliar_constitution). character(lg16,conciliar_constitution). character(ur3,conciliar_decree).
character(cdf1985,notification). character(di2000,declaration). character(cdf2007,responses).
character(ho1949,letter). character(ccc847,catechism). character(ac1896,apostolic_letter).

#program lg14_graded.        :- not read_as(lg14,graded_incorporation).
#program lg14_binary.        :- not read_as(lg14,members_and_joined).
#program lg8_identity.       :- not read_as(lg8,identity_with_elements).
#program lg8_broader.        :- not read_as(lg8,broader).
#program florence_nonmember. :- not read_as(florence1442,outside_as_nonmember).
#program florence_no_bond.   :- not read_as(florence1442,outside_as_no_bond).
#program orders_fixed.       :- not holds(q(anglican_orders),invalid).
#program oum_ac.             :- not oum_holds(ac1896).

% ---------- Liturgy: Summorum Pontificum and Traditionis Custodes -----
#program liturgy.
question(q(old_missal_use)). question_kind(q(old_missal_use),governance).
value(q(old_missal_use),unrestricted). value(q(old_missal_use),needs_bishop).
source(quo_primum,3,juridical,1570). papal_form(quo_primum,legislative).
supports(quo_primum,q(old_missal_use),unrestricted).                       % with a perpetuity clause
source(quattuor_1984,3,juridical,1984). supports(quattuor_1984,q(old_missal_use),needs_bishop).      % CDW indult
dicastery(quattuor_1984). by_papal_mandate(quattuor_1984). character(bxvi_letter,letter).
source(sp2007,3,juridical,2007). papal_form(sp2007,legislative). supports(sp2007,q(old_missal_use),unrestricted).
source(tc2021,3,juridical,2021). papal_form(tc2021,legislative). supports(tc2021,q(old_missal_use),needs_bishop).
% was the 1962 Missal abrogated in 1970? a juridical fact
question(q(abrogated_1970)). question_kind(q(abrogated_1970),juridical).
value(q(abrogated_1970),never_abrogated). value(q(abrogated_1970),abrogated).
supports(sp2007,q(abrogated_1970),never_abrogated).                         % SP art. 1; the legislator's own reading (c. 16)
source(roche_2021,5,truth,2021). supports(roche_2021,q(abrogated_1970),abrogated).   % a letter "of a personal nature"
% lex orandi status: teaching or governance? left open
question(q(lex_orandi)). value(q(lex_orandi),extraordinary_expression). value(q(lex_orandi),not_an_expression).
1 { question_kind(q(lex_orandi),doctrinal) ; question_kind(q(lex_orandi),governance) } 1.
supports(sp2007,q(lex_orandi),extraordinary_expression). supports(tc2021,q(lex_orandi),not_an_expression).
% Benedict's covering letter, in teaching form
question(q(may_be_entirely_forbidden)). question_kind(q(may_be_entirely_forbidden),doctrinal).
value(q(may_be_entirely_forbidden),no). value(q(may_be_entirely_forbidden),yes).
source(bxvi_letter,3,truth,2007). papal_form(bxvi_letter,ordinary). supports(bxvi_letter,q(may_be_entirely_forbidden),no).

#program asof_1990. asof(1990). custom_asof.
#program asof_2010. asof(2010). custom_asof.
#program lit_doctrinal.  :- question_kind(q(lex_orandi),governance).
#program lit_governance. :- question_kind(q(lex_orandi),doctrinal).
#program cand_perpetuity_binds. treated_as_binding_successors(quo_primum).
#program cand_total_ban.          % a hypothetical future act
source(total_ban,3,juridical,2030). papal_form(total_ban,legislative). supports(total_ban,q(may_be_entirely_forbidden),yes).

% ---------- Tier 3, governance: Magnum Principium and Liturgiam Authenticam
#program translation.
question(q(translation_approval)). question_kind(q(translation_approval),governance).
value(q(translation_approval),detailed_recognitio). value(q(translation_approval),confirmatio).
source(la2001,3,juridical,2001). dicastery(la2001). character(la2001,instruction).
supports(la2001,q(translation_approval),detailed_recognitio).
source(mp2017,3,juridical,2017). papal_form(mp2017,legislative).          % Magnum Principium, amending c. 838
supports(mp2017,q(translation_approval),confirmatio).
source(sarah_2017,5,truth,2017). supports(sarah_2017,q(translation_approval),detailed_recognitio).  % prefect's commentary: "nothing had changed"
source(francis_sarah_2017,3,juridical,2017). papal_form(francis_sarah_2017,legislative).           % the legislator's own reading (c. 16)
supports(francis_sarah_2017,q(translation_approval),confirmatio).
#program cand_later_instruction.  % a hypothetical 2019 curial instruction restoring the old practice
source(instr_2019,3,juridical,2019). dicastery(instr_2019). supports(instr_2019,q(translation_approval),detailed_recognitio).
#program instr_in_forma_specifica. in_forma_specifica(instr_2019).
#program cand_conference.           % a conference decree contrary to universal law
source(conf_2018,3,juridical,2018). conference(conf_2018). supports(conf_2018,q(translation_approval),detailed_recognitio).

% ---------- The tongues: one word, many encodings (TTC-LINGUAE) ------------
% Texts by encoding and date; what each form means, by its lexicon; what the
% host's readings are, by their exegetes. Every meaning, reading and analogy
% is a claim with its claimant (docs/research/linguae-sources.md).
#program linguae_rn9.             % Rerum novarum 9 (Leo XIII, 15 May 1891) in five encodings (RN)
% The Latin, promulgated: "ad conservandam vitam maximeque ad perficiendam"; "hoc ipso applicat ad
% sese eam naturae corporeae partem, quam ipse percoluit, in qua velut formam quamdam personae suae
% impressam reliquit". vatican.va's English, Italian, French and Spanish: their dates unknown, entered
% as served (23 October 2026); their parents undeclared. The English is not Hedley's of 1891.
encoding(la_1891,lat,1878,1903). encoding(en_1891,eng,1828,1913). encoding(en_2026,eng,2000,2026).
encoding(it_2026,ita,2000,2026). encoding(fr_2026,fra,2000,2026). encoding(es_2026,spa,2000,2026).
encoding_route((la_1891;en_1891;en_2026;it_2026;fr_2026;es_2026),written).
text_of(rn_la,rn1891,la_1891,1891).
text_of(rn_en,rn1891,en_2026,2026). text_of(rn_it,rn1891,it_2026,2026).
text_of(rn_fr,rn1891,fr_2026,2026). text_of(rn_es,rn1891,es_2026,2026).
form_in((rn_la_natura;rn_la_forma;rn_la_persona;rn_la_perficiendam),rn_la,n(9)).
form_in((rn_en_nature;rn_en_impress;rn_en_personality;rn_en_wellbeing),rn_en,n(9)).
form_in((rn_it_natura;rn_it_impronta;rn_it_personalita;rn_it_perfezionamento),rn_it,n(7)).
form_in((rn_fr_nature;rn_fr_empreinte;rn_fr_personne;rn_fr_perfectionnement),rn_fr,n(9)).
form_in((rn_es_naturaleza;rn_es_huella;rn_es_persona;rn_es_perfeccionamiento),rn_es,n(7)).
% rn9's premises, as TTC-MODERNITY types it: a cause and a domain each, on the forms that bear them.
rests_on_form(rn9,cd(formal,human),(rn_la_forma;rn_la_persona)).
rests_on_form(rn9,cd(efficient,human),rn_la_persona).
rests_on_form(rn9,cd(material,nature),rn_la_natura).
rests_on_form(rn9,cd(final,human),rn_la_perficiendam).
% "nature's field", "natura corporea", "nature materielle", "naturaleza corporea"; "life's well-being",
% "perfezionamento", "perfectionnement", "perfeccionamiento": given for their Latin.
renders(rn_en_nature,rn_la_natura). renders(rn_it_natura,rn_la_natura).
renders(rn_fr_nature,rn_la_natura). renders(rn_es_naturaleza,rn_la_natura).
renders(rn_en_personality,rn_la_persona). renders(rn_it_personalita,rn_la_persona).
renders(rn_fr_personne,rn_la_persona). renders(rn_es_persona,rn_la_persona).
renders(rn_en_wellbeing,rn_la_perficiendam). renders(rn_it_perfezionamento,rn_la_perficiendam).
renders(rn_fr_perfectionnement,rn_la_perficiendam). renders(rn_es_perfeccionamiento,rn_la_perficiendam).
% "impress", "impronta", "empreinte", "huella": the image of form (De anima II.12: wax takes "the
% impress of a signet-ring"), or a gap where the form was: both run.
disputed(renders(rn_en_impress,rn_la_forma)). disputed(renders(rn_it_impronta,rn_la_forma)).
disputed(renders(rn_fr_empreinte,rn_la_forma)). disputed(renders(rn_es_huella,rn_la_forma)).
% The lexicons. The Latin's own "velut ... quamdam" read as a metaphor is a reading of the host;
% "personality" in the English of 1891, two lexicons: the scholastic (personalitas, "the dignity
% and perfection of that thing to exist by itself", ST III q. 2 a. 2 ad 2; Webster 1828, "that which
% constitutes an individual a distinct person") and the Lockean ("Person is a forensic term,
% appropriating actions", Essay II.xxvii.26; happiness "the utmost pleasure", II.xxi.42).
lexicon(lex_la_1891,la_1891,1891,dictionary). lexicon(lex_la_velut,la_1891,1891,commentary).
lexicon(lex_en_schol_1891,en_1891,1891,dictionary). lexicon(lex_en_locke_1891,en_1891,1891,usage).
lexicon(lex_en_2026,en_2026,2026,dictionary).
lexicon(lex_it_2026,it_2026,2026,dictionary). lexicon(lex_fr_2026,fr_2026,2026,dictionary).
lexicon(lex_es_2026,es_2026,2026,dictionary).
signifies(rn_la_natura,w_natura_corporea,lex_la_1891). signifies(rn_la_persona,w_persona,lex_la_1891).
signifies(rn_la_forma,w_forma,lex_la_1891). signifies(rn_la_forma,w_impressio,lex_la_velut).
signifies(rn_la_perficiendam,w_perfectio,lex_la_1891).
signifies(rn_en_nature,w_natura_corporea,(lex_en_schol_1891;lex_en_locke_1891;lex_en_2026)).
signifies(rn_en_impress,w_impressio,(lex_en_schol_1891;lex_en_2026)).
signifies(rn_en_personality,w_personalitas,lex_en_schol_1891).
signifies(rn_en_personality,w_forensic_self,lex_en_locke_1891).
signifies(rn_en_wellbeing,(w_perfectio;w_bene_esse),(lex_en_schol_1891;lex_en_2026)).
signifies(rn_en_wellbeing,w_happiness,lex_en_locke_1891).
signifies(rn_it_natura,w_natura_corporea,lex_it_2026). signifies(rn_it_impronta,w_impressio,lex_it_2026).
signifies(rn_it_personalita,w_personalitas,lex_it_2026). signifies(rn_it_perfezionamento,w_perfectio,lex_it_2026).
signifies(rn_fr_nature,w_natura_corporea,lex_fr_2026). signifies(rn_fr_empreinte,w_impressio,lex_fr_2026).
signifies(rn_fr_personne,w_persona,lex_fr_2026). signifies(rn_fr_perfectionnement,w_perfectio,lex_fr_2026).
signifies(rn_es_naturaleza,w_natura_corporea,lex_es_2026). signifies(rn_es_huella,w_impressio,lex_es_2026).
signifies(rn_es_persona,w_persona,lex_es_2026). signifies(rn_es_perfeccionamiento,w_perfectio,lex_es_2026).
% In the order of reason, each analogy with its claimant, and what it carries.
analogous(w_impressio,w_forma,proportionality,aristotle_de_anima).
analogous(w_personalitas,w_persona,attribution,aquinas_iii_2_2).
analogous(w_forensic_self,w_persona,attribution,locke_essay).
analogous(w_happiness,w_perfectio,attribution,locke_essay).
broader(w_bene_esse,w_perfectio,lex_en_schol_1891).
carries(w_impressio,w_forma,cd(formal,human)).
carries(w_personalitas,w_persona,(cd(formal,human);cd(efficient,human))).
carries(w_forensic_self,w_persona,cd(efficient,human)).
carries(w_happiness,w_perfectio,cd(final,self)).
% Hearings: horizons with a lexicon, never persons. The English of 1891 under Locke (TTC-MODERNITY's
% switch rn9_in_english); a Thomist guest hearing the English of 2026, which declares no lexicon for
% "personality"; a Lockean guest hearing the Latin.
hears_in(g_en_1891_locke,en_1891,lex_en_locke_1891).
hears_in(g_thomist_2026,en_2026,lex_en_2026).
hears_in(g_locke_la,la_1891,lex_la_1891).
% A Lockean horizon cannot hold the person's form: the person is "a forensic term".
horizon_lacks((g_locke_la;g_en_1891_locke),cd(formal,human),locke_essay).
#program cand_word_dated.         % HYPOTHETICAL: words given a date, a year of a text, a place in the order (LW1)
date_claim(w_persona,1891). text_year(w_forma,1891). happens_at(w_perfectio,leo_signs).
#program cand_word_as_root.       % HYPOTHETICAL: a perfect language taken as the word, the parent of a tongue (LW4)
% Dante, De vulgari eloquentia I.6: a "certam formam locutionis" made with the first soul. Entered
% as the word, it is refused; a proto-language entered as an encoding with its claimant is not.
encoding(heb_biblical,hbo,-1000,-200). encoding(proto_ie,ine,-4500,-2500). encoding(la_classical,lat,-100,200).
lexicon(lex_dve,la_1305,1305,commentary). encoding(la_1305,lat,1300,1310).
text_of(dve,de_vulgari_eloquentia,la_1305,1305). form_in(dve_forma_locutionis,dve,n(1,6)).
signifies(dve_forma_locutionis,w_forma_locutionis,lex_dve).
encoding_from(heb_biblical,w_forma_locutionis,dante_dve).
encoding_from(la_classical,proto_ie,handbook_ie).
#program cand_translation_order.  % HYPOTHETICAL: a translation dated before its parent; a cycle of translations (LW3)
encoding(xx_lat,lat,1900,2000). encoding(xx_eng,eng,1900,2000).
text_of(tx_early,src_x,xx_eng,1950). text_of(tx_parent,src_x,xx_lat,1960). made_from(tx_early,tx_parent).
text_of(tx_a,src_y,xx_eng,1970). text_of(tx_b,src_y,xx_lat,1970). made_from(tx_a,tx_b). made_from(tx_b,tx_a).
#program linguae_ccc2483.         % CCC 2483, the right to know: two editions, five encodings (CC)
question(q(lie_needs_right_hearer)). question_kind(q(lie_needs_right_hearer),doctrinal).
value(q(lie_needs_right_hearer),(yes;no)).
question(q(ccc_definitive_text)). question_kind(q(ccc_definitive_text),governance).
value(q(ccc_definitive_text),(latin_typical;french_1992)).
% The first edition (Fidei depositum, 1992): to lie is to lead into error "celui qui a le droit de la
% connaitre". The Latin typical edition (Laetamur magnopere, 15 August 1997) drops the clause, and
% "thus becomes the definitive text": a new edition, which changes the word. Its deletion defines
% nothing; the question has no source in force once the first edition is withdrawn.
source(ccc_ed1992,3,truth,1992). character(ccc_ed1992,catechism). withdrawn(ccc_ed1992,1997).
supports(ccc_ed1992,q(lie_needs_right_hearer),yes).
source(laetamur_1997,3,juridical,1997). character(laetamur_1997,apostolic_letter).
supports(laetamur_1997,q(ccc_definitive_text),latin_typical).
encoding(fr_1992,fra,1992,1997). encoding(en_1994,eng,1994,1997). encoding(la_1997,lat,1997,2026).
encoding(fr_1997,fra,1997,2026). encoding(en_2000,eng,1997,2026). encoding(de_2026,deu,2000,2026).
encoding_route((fr_1992;en_1994;la_1997;fr_1997;en_2000;de_2026),written).
text_of(ccc_fr_1992,ccc_ed1992,fr_1992,1992).
text_of(ccc_en_1994,ccc_ed1992,en_1994,1994). made_from(ccc_en_1994,ccc_fr_1992).     % vatican.va's English
text_of(ccc_de_vatican,ccc_ed1992,de_2026,2026).                                       % vatican.va's German, its parent undocumented
text_of(ccc_la_1997,ccc_ed1997,la_1997,1997). revises(ccc_la_1997,ccc_fr_1992).
text_of(ccc_fr_1997,ccc_ed1997,fr_1997,1997). made_from(ccc_fr_1997,ccc_la_1997).
text_of(ccc_en_2000,ccc_ed1997,en_2000,2000). made_from(ccc_en_2000,ccc_la_1997).      % the second edition, 1997-2000 [M]
% Clause by clause: "Mentir, c'est parler ou agir contre la verite" / "to speak or act against the
% truth"; "pour induire en erreur" / "in order to lead into error"; "celui qui a le droit de la
% connaitre" / "someone who has the right to know the truth".
form_in((ccc92_fr_contra;ccc92_fr_erreur;ccc92_fr_droit),ccc_fr_1992,n(2483)).
form_in((ccc94_en_against;ccc94_en_error;ccc94_en_right),ccc_en_1994,n(2483)).
form_in((ccc97_la_contra;ccc97_la_errorem),ccc_la_1997,n(2483)).
renders(ccc94_en_against,ccc92_fr_contra). renders(ccc94_en_error,ccc92_fr_erreur).
renders(ccc94_en_right,ccc92_fr_droit).
lexicon(lex_fr_1992,fr_1992,1992,dictionary). lexicon(lex_en_1994,en_1994,1994,dictionary).
lexicon(lex_la_1997,la_1997,1997,dictionary).
signifies(ccc92_fr_contra,w_against_truth,lex_fr_1992). signifies(ccc94_en_against,w_against_truth,lex_en_1994).
signifies(ccc92_fr_erreur,w_lead_into_error,lex_fr_1992). signifies(ccc94_en_error,w_lead_into_error,lex_en_1994).
signifies(ccc92_fr_droit,w_right_to_truth,lex_fr_1992). signifies(ccc94_en_right,w_right_to_truth,lex_en_1994).
signifies(ccc97_la_contra,w_against_truth,lex_la_1997). signifies(ccc97_la_errorem,w_lead_into_error,lex_la_1997).
#program cand_revision_rendered.  % HYPOTHETICAL: the Latin of 1997 entered as given for the French of 1992, and back (CC1)
renders(ccc97_la_contra,ccc92_fr_contra). renders(ccc92_fr_erreur,ccc97_la_errorem).
#program linguae_pro_multis.      % "pro multis": the words over the chalice in six encodings (PM)
% Christ died for all: "there is not, never has been, and never will be a single human being for
% whom Christ did not suffer" (CCC 605; Quiersy, DH 624). The renderings answer nothing of it.
question(q(died_for_all)). question_kind(q(died_for_all),doctrinal). value(q(died_for_all),(yes;no)).
source(ccc_605,3,truth,1992). character(ccc_605,catechism). supports(ccc_605,q(died_for_all),yes).
encoding(la_1970,lat,1965,2001). encoding(la_2002,lat,2002,2026). encoding(en_1973,eng,1965,2010).
encoding(en_2011,eng,2011,2026). encoding(de_1975,deu,1965,2026). encoding(it_2020,ita,2000,2026).
encoding(fr_2021,fra,2000,2026).
encoding_route((la_1970;la_2002;en_1973;en_2011;de_1975;it_2020;fr_2021),written).
text_of(missal_la_1970,missale_romanum_1970,la_1970,1970).
text_of(missal_la_2002,missale_romanum_2002,la_2002,2002). revises(missal_la_2002,missal_la_1970).
text_of(missal_en_1973,missale_romanum_1970,en_1973,1973). made_from(missal_en_1973,missal_la_1970).
text_of(missal_de_1975,missale_romanum_1970,de_1975,1975). made_from(missal_de_1975,missal_la_1970).
text_of(missal_en_2011,missale_romanum_2002,en_2011,2011). made_from(missal_en_2011,missal_la_2002).
text_of(missal_it_2020,missale_romanum_2002,it_2020,2020). made_from(missal_it_2020,missal_la_2002).
text_of(missal_fr_2021,missale_romanum_2002,fr_2021,2021). made_from(missal_fr_2021,missal_la_2002).  % [M]
% "qui pro vobis et pro multis effundetur"; "for all" (1973); "for many" (2011); "fur alle" (1975);
% "per tutti" (2020); "pour la multitude".
form_in(pm_la70,missal_la_1970,consecratio(calix)). form_in(pm_la02,missal_la_2002,consecratio(calix)).
form_in(pm_en73_all,missal_en_1973,consecratio(calix)). form_in(pm_en11_many,missal_en_2011,consecratio(calix)).
form_in(pm_de75_alle,missal_de_1975,consecratio(calix)). form_in(pm_it20_tutti,missal_it_2020,consecratio(calix)).
form_in(pm_fr21_multitude,missal_fr_2021,consecratio(calix)).
renders(pm_en73_all,pm_la70). renders(pm_de75_alle,pm_la70). renders(pm_en11_many,pm_la02).
renders(pm_it20_tutti,pm_la02). renders(pm_fr21_multitude,pm_la02).
formula_of((pm_la70;pm_la02),eucharist).
span_kind((pm_la70;pm_la02),anaphoral).
lexicon(lex_la_missal,la_2002,2002,dictionary). lexicon(lex_en_1973,en_1973,1973,dictionary).
lexicon(lex_en_2011,en_2011,2011,dictionary). lexicon(lex_de_1975,de_1975,1975,dictionary).
lexicon(lex_it_2020,it_2020,2020,dictionary). lexicon(lex_fr_2021,fr_2021,2021,dictionary).
% A survey of English hearers is a claim about a lexicon: "many" heard as "not all".
lexicon(lex_en_not_all,en_2011,2011,usage).
signifies((pm_la70;pm_la02),w_pro_multis,lex_la_missal).
signifies(pm_en73_all,w_pro_multis,(lex_en_1973;lex_en_2011;lex_en_not_all)).
signifies(pm_en11_many,w_pro_multis,(lex_en_2011;lex_en_not_all)).
signifies(pm_de75_alle,w_pro_multis,lex_de_1975). signifies(pm_it20_tutti,w_pro_multis,lex_it_2020).
signifies(pm_fr21_multitude,w_pro_multis,lex_fr_2021).
% The host's readings, each with its exegete: many, how many unsaid; the Semitic "many" as all
% (Isaiah 53; Arinze (a)); the Gentiles, and those for whom it avails (III q. 78 a. 3 ad 8).
form_reading((pm_la70;pm_la02),r_open,vulgate_mk_14_24).
form_reading((pm_la70;pm_la02),r_all,arinze_2006).
form_reading((pm_la70;pm_la02),(r_gentiles;r_offered),aquinas_iii_78_3).
admits(pm_en73_all,(r_all;r_gentiles),(lex_en_1973;lex_en_2011;lex_en_not_all)).
admits(pm_de75_alle,(r_all;r_gentiles),lex_de_1975). admits(pm_it20_tutti,(r_all;r_gentiles),lex_it_2020).
admits(pm_en11_many,(r_open;r_all;r_gentiles;r_offered),lex_en_2011).
admits(pm_en11_many,r_not_all,lex_en_not_all).
admits(pm_fr21_multitude,(r_open;r_all;r_gentiles;r_offered),lex_fr_2021).
reading_holds(r_not_all,q(died_for_all),no).
idiomatic(pm_en73_all,en_1973,lex_en_1973). idiomatic(pm_en11_many,en_2011,lex_en_2011).
% The message, for Comme le prevoit: ICEL's exegesis of 1973.
message((pm_la70;pm_la02),r_all,icel_1973).
% An English hearing of 2011, by two lexicons.
hears_in(g_en_2011,en_2011,(lex_en_2011;lex_en_not_all)).
% The claims of a mode. Arinze, CDW, 17 October 2006 (Prot. 467/05/L): "For many is a faithful
% translation of pro multis"; "for all" is "rather an explanation of the sort that belongs properly to
% catechesis". Benedict XVI to Zollitsch, 14 April 2012: "keine reine Ubersetzung, sondern eine
% Interpretation". The approvals judge the sense too (CDF, 1974): the recognitio of the English of
% 2011 (communicated 23 June 2010) and the Italian Missal's approval by the Congregation (16 July
% 2019 [S: La Civilta Cattolica]), each in the unit of the whole act.
source(arinze_2006,3,juridical,2006). dicastery(arinze_2006). character(arinze_2006,letter).
source(benedict_2012,3,truth,2012). papal_form(benedict_2012,ordinary). character(benedict_2012,letter).
source(recognitio_en_2010,3,juridical,2010). dicastery(recognitio_en_2010).
source(confirmatio_it_2019,3,juridical,2019). dicastery(confirmatio_it_2019).
mode_claim(arinze_2006,pm_en11_many,pm_la02,univocal,word).
mode_claim(benedict_2012,pm_de75_alle,pm_la70,interpretation,word).
mode_claim(recognitio_en_2010,pm_en11_many,pm_la02,univocal,act).
mode_claim(confirmatio_it_2019,pm_it20_tutti,pm_la02,univocal,act).
catechesis_rule(arinze_2006,(pm_en73_all;pm_de75_alle;pm_it20_tutti),r_all).
#program cand_rendering_answers.  % HYPOTHETICAL: "Christ died for all" rested on "for all", and "not for all" on "for many" (PM6)
source(s_for_all,5,truth,2010). supports(s_for_all,q(died_for_all),yes).
rests_on_rendering(s_for_all,q(died_for_all),pm_en73_all).
source(s_not_all,5,truth,2012). supports(s_not_all,q(died_for_all),no).
rests_on_rendering(s_not_all,q(died_for_all),pm_en11_many).
#program cand_mode_fixed.         % HYPOTHETICAL: Arinze's claim treated as fixing the mode (LM1)
fixes_mode(arinze_2006,pm_en11_many,pm_la02).
#program linguae_heard_by_rule.   % CDF, Declaration of 25 January 1974: an approved version expresses "exactly the
                                  % sense intended by the Church", and is to be understood by the Latin (LM1)
source(cdf_1974,3,truth,1974). dicastery(cdf_1974). character(cdf_1974,declaration).
hearing_rule(cdf_1974,pm_en73_all,pm_la70). hears_under(g_en_2011,cdf_1974).
#program cand_hearings.           % HYPOTHETICAL: a hearing entered for a person, and one by no lexicon (LM3)
created_person(reader_x). hears_in(reader_x,en_2011,lex_en_2011).
hears_in(g_nolex,en_2011,lex_unknown).
#program linguae_ecst.            % "Et cum spiritu tuo": a test case, the same pair under two regimes (LM2)
% "And also with you" (1973), "And with your spirit" (2011). Readings: the whole person, "It is also
% possible to translate spirit here as denoting the whole person", and "a person's inner being or
% self" (Arichea and Hatton, 1995); "they do not refer to his soul, but to the grace of the Holy
% Spirit" (Theodore of Mopsuestia, through Davoren 2011). The message of a returned greeting: "just
% that: a greeting" (Cones).
encoding(la_1970,lat,1965,2001). encoding(la_2002,lat,2002,2026). encoding(en_1973,eng,1965,2010).
encoding(en_2011,eng,2011,2026).
encoding_route((la_1970;la_2002;en_1973;en_2011),written).
text_of(missal_la_1970,missale_romanum_1970,la_1970,1970).
text_of(missal_la_2002,missale_romanum_2002,la_2002,2002). revises(missal_la_2002,missal_la_1970).
text_of(missal_en_1973,missale_romanum_1970,en_1973,1973). made_from(missal_en_1973,missal_la_1970).
text_of(missal_en_2011,missale_romanum_2002,en_2011,2011). made_from(missal_en_2011,missal_la_2002).
form_in(ecst_la70,missal_la_1970,ordo(salutatio)). form_in(ecst_la02,missal_la_2002,ordo(salutatio)).
form_in(ecst_en73,missal_en_1973,ordo(salutatio)). form_in(ecst_en11,missal_en_2011,ordo(salutatio)).
renders(ecst_en73,ecst_la70). renders(ecst_en11,ecst_la02).
lexicon(lex_en_1973,en_1973,1973,dictionary). lexicon(lex_en_2011,en_2011,2011,dictionary).
form_reading((ecst_la70;ecst_la02),(r_person;r_inner),arichea_hatton_1995).
form_reading((ecst_la70;ecst_la02),r_charism,theodore_mopsuestia).
admits(ecst_en73,r_person,lex_en_1973).
admits(ecst_en11,(r_person;r_inner;r_charism),lex_en_2011).
message((ecst_la70;ecst_la02),r_person,cones).
hears_in(g_en_1973,en_1973,lex_en_1973).

% ---------- Custom (cc. 23-28): a mechanism demo -----------------------
#program custom_demo.
question(q(practice_x)). question_kind(q(practice_x),juridical).
value(q(practice_x),forbidden). value(q(practice_x),permitted).
source(law_1900,3,juridical,1900). papal_form(law_1900,legislative). supports(law_1900,q(practice_x),forbidden).
#program cu_young.      custom_practice(cy,q(practice_x),permitted,1950). community_capable(cy). approved_custom(cy). approver(cy,pope).
#program cu_divine.     contra_divine(cy).
#program cu_reprobated. reprobated(cy).
#program cu_forbids.    law_forbids_customs(law_1900).
#program cu_later_law.  source(law_2000,3,juridical,2000). papal_form(law_2000,legislative). supports(law_2000,q(practice_x),forbidden).
#program cu_centenary.  custom_practice(cc,q(practice_x),permitted,1780). community_capable(cc). approved_custom(cc). approver(cc,pope).
#program cu_express.    expressly_revokes(law_2000,cc).
#program cu_old.        custom_practice(co,q(practice_x),permitted,1890). community_capable(co). approved_custom(co). approver(co,pope).
#program asof_1979. asof(1979). custom_asof.
#program asof_1980. asof(1980). custom_asof.
#program asof_2001. asof(2001). custom_asof.

% ---------- Salience: a mechanism demo ---------------------------------
#program salience_demo.
question(q(topic_s)). question_kind(q(topic_s),doctrinal). value(q(topic_s),a). value(q(topic_s),b).
source(enc_s,3,truth,1990). character(enc_s,encyclical). supports(enc_s,q(topic_s),a).
source(interview_s,3,truth,2015). character(interview_s,interview). supports(interview_s,q(topic_s),b).
#program salience_marks.  salience(interview_s,high). relies_on(arg1,interview_s).

% ---------- Schism and the SSPX -----------------------------------------
% The authority side of the case: how the acts are classified, and where
% the Society stands in the communion lattice. The juridical side (who has
% incurred what, what is declared, what faculties exist, which sacraments
% are valid) is computed by the binary canon-law layer (canon_law.lp), from
% the facts in canon_cases.lp, which are part of this same program.
#program sspx.
community(catholic). has(catholic,B) :- bond_kind(B).
community(sspx). internal_society(sspx).
has(sspx,(baptism;scripture;nicene_creed;chalcedon;orders;eucharist;later_dogmas;primacy_recognized)).
has(sspx,faculties_confession) :- class_faculty(sspx_clergy,confession).
has(sspx,faculties_marriage)   :- class_permission(sspx_clergy,marriage).
has(sspx,canonical_mission)    :- holds(q(canonical_status),recognized).
% the 1988 consecrations
question(q(act1988_schismatic)). question_kind(q(act1988_schismatic),juridical).
value(q(act1988_schismatic),yes). value(q(act1988_schismatic),no).
source(ed1988,3,juridical,1988). papal_form(ed1988,legislative). character(ed1988,apostolic_letter).
supports(ed1988,q(act1988_schismatic),yes).                                  % Ecclesia Dei adflicta 3 (c. 751)
source(sspx_necessity,5,truth,1988).                                         % "state of necessity" (cc. 1323-1324)
supports(sspx_necessity,q(act1988_schismatic),no).
question(q(excomm_1988)). question_kind(q(excomm_1988),juridical).
value(q(excomm_1988),incurred). value(q(excomm_1988),not_incurred).
source(cb_1988,3,juridical,1988). dicastery(cb_1988).                         % Congregation for Bishops, 1 July 1988 (c. 1382)
supports(cb_1988,q(excomm_1988),incurred). supports(ed1988,q(excomm_1988),incurred).
supports(sspx_necessity,q(excomm_1988),not_incurred).
info(external_forum_only(q(excomm_1988))).                                   % imputability is presumed externally (c. 1321); the internal forum is not computed
question(q(excomm_in_force)). question_kind(q(excomm_in_force),juridical).
value(q(excomm_in_force),in_force). value(q(excomm_in_force),remitted).
supports(cb_1988,q(excomm_in_force),in_force).
source(cb_2009,3,juridical,2009). dicastery(cb_2009). by_papal_mandate(cb_2009).
supports(cb_2009,q(excomm_in_force),remitted).
% canonical status: nothing is granted without a grant
question(q(canonical_status)). question_kind(q(canonical_status),juridical).
value(q(canonical_status),none). value(q(canonical_status),recognized). default(q(canonical_status),none).
source(bxvi_2009,3,truth,2009). papal_form(bxvi_2009,ordinary). character(bxvi_2009,letter).
supports(bxvi_2009,q(canonical_status),none).
source(secst_2009,3,juridical,2009). dicastery(secst_2009). supports(secst_2009,q(canonical_status),none).
after_2026_act :- asof(A), A >= 2026.

% is the Society, as such, in schism now?
question(q(society_schism_now)). question_kind(q(society_schism_now),juridical).
value(q(society_schism_now),yes). value(q(society_schism_now),no).
source(castrillon_2005,5,truth,2005). character(castrillon_2005,interview). supports(castrillon_2005,q(society_schism_now),no).
source(francis_2016,3,truth,2016). character(francis_2016,interview).            % "Catholics on the way to full communion"
supports(francis_2016,q(society_schism_now),no).
source(schism_thesis,5,truth,2010). supports(schism_thesis,q(society_schism_now),yes).

% schism and dissent are different offences: c. 751 / c. 1364 against
% c. 752 / c. 1365 (obstinate rejection of teaching after a warning).
% A classification as schism must rest on a schism-type basis.
refuses(sspx,dignitatis_humanae). teaching_tier(dignitatis_humanae,3).
% An offence is said of a person, never of a body (TTC-PENAL FL4): without
% canonical status the Society is a name for persons; its refusal is a public
% position, a text's matter. No person who professes it is recorded here.
group(sspx)          :- holds(q(canonical_status),none).
juridic_person(sspx) :- holds(q(canonical_status),recognized).
info(offense(X,dissent_c752,T)) :- refuses(X,T), teaching_tier(T,3), not non_physical(X).
info(public_position(X,refuses(T))) :- refuses(X,T), non_physical(X).
schism_basis(refusal_of_subjection).            % c. 751: refusal of submission to the Supreme Pontiff
violation(category_error(X,B)) :- classified_on(X,schism_c751,B), not schism_basis(B).
% formal adherence is declared externally or discerned internally, never inferred
internal_forum_actor(confessor). attends(fidelis1,sspx_mass).
violation(diagnosis_of_adherence(P,A)) :- formal_adherence(P,A), not internal_forum_actor(A), not declared_by_authority(P).

% ---------- 2026: the Econe consecrations and the DDF decree ----------------
% 1 July 2026: Bp de Galarreta consecrates four priests, Bp Fellay co-consecrating.
% Decree, 2 July 2026 (DDF, Prot. 99/2009; no papal approval formula): the five
% have incurred the excommunication of c. 1387, Fellay that of c. 1364 §1; clerics
% and faithful are warned not to adhere to "the schism of the Fraternity".
% Explanatory note, same day: the act is the crime of schism (ED 3; c. 751).
source(ddf_decree_2026,3,juridical,2026). dicastery(ddf_decree_2026).
source(ddf_note_2026,3,truth,2026).       dicastery(ddf_note_2026). character(ddf_note_2026,commentary).
source(sspx_2026,5,truth,2026).           % "Neither schismatic nor disobedient"; state of necessity
source(canonist_2026,5,truth,2026).       % published canonical critiques of the decree
question(q(act2026_schismatic)) :- after_2026_act. question_kind(q(act2026_schismatic),juridical).
value(q(act2026_schismatic),yes). value(q(act2026_schismatic),no).
supports(ed1988,q(act2026_schismatic),yes).            % ED 3 types the act, not only the 1988 token
supports(ddf_decree_2026,q(act2026_schismatic),yes). supports(ddf_note_2026,q(act2026_schismatic),yes).
supports(sspx_2026,q(act2026_schismatic),no).
supports(canonist_2026,q(act2026_schismatic),no).      % c. 751 read as a state of total repudiation, not an act
classified_on(sspx,schism_c751,refusal_of_subjection) :- holds(q(act2026_schismatic),yes).
supports(ddf_decree_2026,q(society_schism_now),yes). supports(ddf_note_2026,q(society_schism_now),yes).
% the Dicastery's return procedure (via the nunciatures): lay imputability
% "cannot be presumed automatically, but must be assessed case by case"
source(ddf_return_2026,3,juridical,2026). dicastery(ddf_return_2026).
info(rule_endorsed(non_diagnosis,ddf_return_2026)) :- in_force(ddf_return_2026).
info(missing_bond(sspx,B)) :- bond_kind(B), not has(sspx,B).

#program asof_2018. asof(2018). custom_asof.
#program sspx_salience. salience(francis_2016,high). relies_on(arg_not_schismatic,francis_2016).
#program cand_dissent_as_schism. classified_on(sspx,schism_c751,dissent_from(dignitatis_humanae)).
#program cand_infer_adherence.   formal_adherence(P,system) :- attends(P,sspx_mass).

% ---------- Virginity and marriage ------------------------------------
#program virginity.            % Trent, Sess. XXIV can. 10 (DH 1810); FC 16
question(q(state_excellence)). question_kind(q(state_excellence),doctrinal).
value(q(state_excellence),virginity_more_excellent). value(q(state_excellence),equal).
source(trent_1563_c10,1,truth,1563). supports(trent_1563_c10,q(state_excellence),virginity_more_excellent).
conciliar_act(trent_1563_c10,canon).
source(fc16,3,truth,1981). papal_form(fc16,ordinary). character(fc16,exhortation).
supports(fc16,q(state_excellence),virginity_more_excellent).

#program filioque.               % the origin of the Spirit
question(q(spirit_origin)). question_kind(q(spirit_origin),doctrinal).
value(q(spirit_origin),father_and_son). value(q(spirit_origin),father_alone).
source(lyons_ii_1274,1,truth,1274). supports(lyons_ii_1274,q(spirit_origin),father_and_son).   % DH 850
conciliar_act(lyons_ii_1274,definition).   % "damnamus et reprobamus" those who deny it
source(florence_1439,1,truth,1439). supports(florence_1439,q(spirit_origin),father_and_son).   % DH 1300-1302
conciliar_act(florence_1439,definition).   % "diffinimus" (DH 1300)
source(anselm,5,truth,1102).  promoted(anselm,4,1720).  supports(anselm,q(spirit_origin),father_and_son).   % De processione
source(aquinas_q36,5,truth,1268). promoted(aquinas_q36,4,1567). supports(aquinas_q36,q(spirit_origin),father_and_son).  % ST I q.36 a.2
source(photius,5,truth,886).  supports(photius,q(spirit_origin),father_alone).          % Mystagogia
source(gregory_cyprus,5,truth,1285). supports(gregory_cyprus,q(spirit_origin),father_alone).   % Tomus
source(palamas,5,truth,1350). supports(palamas,q(spirit_origin),father_alone).          % Capita 150, 36
% The Latin witnesses before 1100 (TTC-SOURCES FQ), each at its tier by form.
% Augustine, De Trinitate XV.26.47: "spiritus sanctus de patre principaliter,
% et ipso sine ullo intervallo temporis dante, communiter de utroque procedit"
% (and XV.17.29, "Ideo autem addidi, principaliter"): the Filioque, and the
% monarchy with it.
source(augustine_dt15,5,truth,420). promoted(augustine_dt15,4,1298).
supports(augustine_dt15,q(spirit_origin),father_and_son).
% Leo I, Quam laudabiliter (21 July 447, DH 284), a pope's letter: "Pope St.
% Leo I ... had already confessed it dogmatically in 447" (CCC 247), read as a
% doctrinal act, not a claim of tier.
source(leo_i_447,3,truth,447). papal_form(leo_i_447,ordinary). character(leo_i_447,letter).
supports(leo_i_447,q(spirit_origin),father_and_son).
% Particular councils (c. 753): Toledo III (589, DH 470), Reccared's profession,
% "Spiritusque sanctus confitendus a nobis et praedicandus est a patre et filio
% procedere", and its anathema (the creed's own text reads "ex patre
% procedentem"); Toledo XI (675), "proceeding from both" (DH 527).
source(toledo_iii_589,3,truth,589). character(toledo_iii_589,conciliar_decree). particular_council(toledo_iii_589).
supports(toledo_iii_589,q(spirit_origin),father_and_son).
source(toledo_xi_675,3,truth,675). character(toledo_xi_675,conciliar_decree). particular_council(toledo_xi_675).
supports(toledo_xi_675,q(spirit_origin),father_and_son).
% The monarchy is a separate question; both sides affirm it.
question(q(monarchy)). question_kind(q(monarchy),doctrinal).
value(q(monarchy),father_principle_without_principle). value(q(monarchy),denied).
source(florence_1442,1,truth,1442). supports(florence_1442,q(monarchy),father_principle_without_principle).  % DH 1331
conciliar_act(florence_1442,creed).   % Cantate Domino: "firmiter credit, profitetur et praedicat"
source(pcpcu_1995,3,truth,1995). character(pcpcu_1995,commentary).
supports(pcpcu_1995,q(monarchy),father_principle_without_principle).   % L'Osservatore Romano, 20 Sept 1995
% Both sides before 1100: Augustine's "principaliter"; Photius, the Spirit
% "proceeds from the Father, Who is the first cause" (Mystagogia 43); Toledo XI,
% the Father "the source and origin of the whole Godhead" (DH 525). The East
% "expresses the Father's character as first origin of the Spirit" (CCC 248).
supports(augustine_dt15,q(monarchy),father_principle_without_principle).
supports(photius,q(monarchy),father_principle_without_principle).
supports(toledo_xi_675,q(monarchy),father_principle_without_principle).
monopatrism :- holds(q(spirit_origin),father_alone).             % into the core grammar

#program councils_relaxed.        % ablation: the two councils removed from the graph
relaxed(lyons_ii_1274). relaxed(florence_1439).

#program theses_1914.             % Sacred Congregation of Studies, 27 July 1914 (AAS 6, 383-386; DH 3601-3624)
source(theses_1914,3,F,1914) :- theses_force(F).
theses_force(truth)     :- not theses_directive.
theses_force(juridical) :- theses_directive.
character(theses_1914,declaration).
% Th. 24, last clause: no created agent acts on being without a motion from the First Cause.
ambiguous(theses_1914). reading(theses_1914,premotion). reading(theses_1914,concurrence).
reads(theses_1914,premotion,q(efficacious_grace),physical_premotion).     % read with Banez (and Garrigou-Lagrange)
% the concurrence reading (simultaneous concurrence, Molina) supports neither school

#program theses_directive.        % 1916: "proponantur veluti tutae normae directivae"
theses_directive.

#program a9_universal.            % the old reading of A9, for comparison
uses(icon).                             % the Grammar of the Icon
a9_universal.

#program cand_tier3_contrary.     % a tier-3 teaching against the tier-2 one
source(t3_against,3,truth,2010). supports(t3_against,q(d1),no). character(t3_against,letter).
#program assume_t2. :- not t2_truth.

#program readings_tie.            % synthetic: two readings that fit equally well
question(q(x)). question_kind(q(x),doctrinal). value(q(x),a). value(q(x),b).
question(q(y)). question_kind(q(y),doctrinal). value(q(y),c). value(q(y),d).
source(s_amb,3,truth,2000). ambiguous(s_amb). reading(s_amb,r1). reading(s_amb,r2).
reads(s_amb,r1,q(x),a). reads(s_amb,r2,q(y),c).
source(s_int,3,truth,2001). interprets(s_int,s_amb,r1).
character(s_amb,letter). character(s_int,letter).

#program hypothetical_definition. % HYPOTHETICAL: what a tier-1 act would settle
source(def_t2,1,truth,2030). meta_supports(def_t2,t2_truth). hypothetical_warrant(def_t2).

% ---------- The creeds and the word of God (TTC-CREED) ------------------
#program creeds.                  % tier 1, as the Church professes them
source(apostles_creed,1,truth,700).   % textus receptus (DH 30); the Old Roman Creed is older
source(nicene_creed,1,truth,381).     % Constantinople I (DH 150): "proceeds from the Father"
source(quicumque,1,truth,500).        % DH 75-76, 5th-6th c.; tier 1 by the Church's reception
source(lateran_iv_1215,1,truth,1215). % Firmiter (DH 800-802)
% Reception, dated, with its claimant (TTC-SAECULUM RC1). The Quicumque:
% "from the Carolingian period ... began to be sung at prime every day
% throughout the Western Church" (New Schaff-Herzog Encyclopedia, 1908,
% "Athanasian Creed"; earlier, the synod of Autun, c. 670, bade the clergy
% receive "the creed of bishop St. Athanasius"). The Apostles' Creed: "the
% ancient baptismal symbol of the Church of Rome" (CCC 194), which gives no
% year: the year entered is the textus receptus's (DH 30).
reception_claim(quicumque,schaff_herzog_1908,800).
reception_claim(apostles_creed,ccc_194,700).
% Florence hands the Quicumque on to the Armenians, "that compendious rule
% of the faith composed by most blessed Athanasius" (22 November 1439,
% sixthly), in "a summary of the truth of the orthodox faith that the
% Roman church professes": an instruction, no definition. A witness at
% tier 3, so the reception stays a claim.
source(florence_armenians_1439,3,truth,1439). character(florence_armenians_1439,conciliar_decree).
reception_fixed_by(quicumque,florence_armenians_1439).
conciliar_act(nicene_creed,creed). conciliar_act(lateran_iv_1215,creed).   % "Firmiter credimus et simpliciter confitemur"
supports(quicumque,q(spirit_origin),father_and_son).         % "a Patre et Filio"
supports(lateran_iv_1215,q(spirit_origin),father_and_son).   % "ab utroque pariter" (DH 800)
supports(lateran_iv_1215,q(monarchy),father_principle_without_principle).   % "Pater a nullo" (DH 800)
% Paul VI's Credo (1968) is "without being strictly speaking a dogmatic definition" (n. 3)
source(credo_1968,3,truth,1968). papal_form(credo_1968,ordinary). character(credo_1968,profession).
supports(credo_1968,q(spirit_origin),father_and_son).        % n. 10
supports(credo_1968,q(ic),yes).                              % n. 14
supports(credo_1968,q(ever_virgin),yes).                     % n. 14

#program marian.                  % Mary's dogmas beside the Immaculate Conception (part ic)
question(q(ever_virgin)). question_kind(q(ever_virgin),doctrinal).
value(q(ever_virgin),yes). value(q(ever_virgin),no).
source(constantinople_ii_553,1,truth,553). supports(constantinople_ii_553,q(ever_virgin),yes).  % can. 2, DH 422
conciliar_act(constantinople_ii_553,canon).
source(lateran_649,3,truth,649).           supports(lateran_649,q(ever_virgin),yes).            % can. 3, DH 503: a Roman synod
character(lateran_649,conciliar_decree).
source(cum_quorundam_1555,3,truth,1555).   supports(cum_quorundam_1555,q(ever_virgin),yes).     % Paul IV, DH 1880
papal_form(cum_quorundam_1555,ordinary).
question(q(assumption)). question_kind(q(assumption),doctrinal).
value(q(assumption),yes). value(q(assumption),no).
source(munificentissimus_1950,1,truth,1950). supports(munificentissimus_1950,q(assumption),yes).   % DH 3903
papal_form(munificentissimus_1950,ex_cathedra). object_of(munificentissimus_1950,revealed).   % "a divinely revealed dogma" (DH 3903)
condition_shown(munificentissimus_1950,(pastor_of_all;apostolic_authority;defines;faith_or_morals;whole_church)).
% "pronuntiamus, declaramus et definimus esse divinitus revelatum dogma" (DH 3903)
% "having completed the course of her earthly life": whether she died first is left open
question(q(died_before_assumption)). question_kind(q(died_before_assumption),doctrinal).
value(q(died_before_assumption),yes). value(q(died_before_assumption),no).
source(damascene_dormition,5,truth,740). promoted(damascene_dormition,4,1890).   % Homilies on the Dormition
supports(damascene_dormition,q(died_before_assumption),yes).

#program brothers_of_the_lord.    % Mk 6:3 and Mt 1:25, read against "ever-virgin" (load with marian)
question(q(brothers_of_the_lord)). question_kind(q(brothers_of_the_lord),doctrinal).
value(q(brothers_of_the_lord),(sons_of_mary;sons_of_joseph;kinsmen)).
source(mk6_3,0,truth,70). ambiguous(mk6_3).
reading(mk6_3,(helvidius;epiphanius;jerome)).
reads(mk6_3,helvidius,q(brothers_of_the_lord),sons_of_mary).    % Helvidius, refuted by Jerome
reads(mk6_3,helvidius,q(ever_virgin),no).
reads(mk6_3,epiphanius,q(brothers_of_the_lord),sons_of_joseph). % by an earlier marriage (Panarion 78)
reads(mk6_3,jerome,q(brothers_of_the_lord),kinsmen).            % Adversus Helvidium
source(mt1_25,0,truth,80). ambiguous(mt1_25).
reading(mt1_25,(until_after;until_only)).
reads(mt1_25,until_after,q(ever_virgin),no).       % "until" implies what came after (Helvidius)
                                                   % until_only: "until" says nothing of after (Jerome)

#program defined_senses.          % texts whose sense the Church has defined
question(q(water_of_baptism)). question_kind(q(water_of_baptism),doctrinal).
value(q(water_of_baptism),(true_water;metaphor)).
source(jn3_5,0,truth,95). ambiguous(jn3_5). reading(jn3_5,(literal;figurative)).
reads(jn3_5,literal,q(water_of_baptism),true_water). reads(jn3_5,figurative,q(water_of_baptism),metaphor).
source(trent_vii_baptism_c2,1,truth,1547). supports(trent_vii_baptism_c2,q(water_of_baptism),true_water).   % DH 1615
conciliar_act(trent_vii_baptism_c2,canon).
question(q(jn20_23_power)). question_kind(q(jn20_23_power),doctrinal).
value(q(jn20_23_power),(forgiving_in_the_sacrament;preaching_the_gospel)).
source(jn20_23,0,truth,95). ambiguous(jn20_23). reading(jn20_23,(sacramental;kerygmatic)).
reads(jn20_23,sacramental,q(jn20_23_power),forgiving_in_the_sacrament).
reads(jn20_23,kerygmatic,q(jn20_23_power),preaching_the_gospel).
source(trent_xiv_penance_c3,1,truth,1551). supports(trent_xiv_penance_c3,q(jn20_23_power),forgiving_in_the_sacrament).   % DH 1703
conciliar_act(trent_xiv_penance_c3,canon).

#program jn6.                     % Jn 6:53: a claim of the Fathers' unanimous consent
question(q(jn6_53_sense)). question_kind(q(jn6_53_sense),doctrinal).
value(q(jn6_53_sense),(eucharistic;spiritual)).
source(jn6_53,0,truth,95). ambiguous(jn6_53). reading(jn6_53,(eucharistic;spiritual)).
reads(jn6_53,eucharistic,q(jn6_53_sense),eucharistic). reads(jn6_53,spiritual,q(jn6_53_sense),spiritual).
faith_morals(jn6_53).
consent_claim(jn6_53,eucharistic).
% Trent records "the various interpretations of the holy Fathers and Doctors" (sess. XXI, ch. 1, DH 1727)
source(trent_xxi_ch1,1,truth,1562). records_diverse_readings(trent_xxi_ch1,jn6_53).
conciliar_act(trent_xxi_ch1,chapter). session_defines(trent_xxi_ch1).   % proem: "than is in these decrees explained and defined" (DH 1725)

% ablations: which act carries which value
#program quicumque_relaxed.       relaxed(quicumque).
#program cand_reception_unclaimed. % a creed typed received with no claimant and no date (the form before TTC-SAECULUM)
received_creed(quicumque).
#program reception_fixed_hyp.      % HYPOTHETICAL: an act at tier 1 handing the Quicumque on as a rule of faith in 1300 (RC1)
source(def_r,1,truth,1300). hypothetical_warrant(def_r). reception_fixed_by(quicumque,def_r).
#program creed_parts_relaxed.     relaxed(quicumque). relaxed(lateran_iv_1215).
#program marian_council_relaxed.  relaxed(constantinople_ii_553).
#program ic_definition_relaxed.   relaxed(ineffabilis_1854).
#program senses_relaxed.          relaxed(trent_vii_baptism_c2). relaxed(trent_xiv_penance_c3).

% ---------- Grace (TTC-MORAL) ------------------------------------------------
#program jansenism.               % Cum occasione (1653) against the Augustinus (1640)
question(q(grace_always_efficacious)). question_kind(q(grace_always_efficacious),doctrinal).
value(q(grace_always_efficacious),(yes;no)).
source(cum_occasione_1653,1,truth,1653).   % prop. 2 condemned as heretical (DH 2002)
papal_form(cum_occasione_1653,ex_cathedra). object_of(cum_occasione_1653,revealed).   % condemned as heretical: against revealed truth (DH 2001-2007)
condition_shown(cum_occasione_1653,(pastor_of_all;apostolic_authority;defines;faith_or_morals;whole_church)).
% each proposition declared and condemned as heretical, by apostolic authority, for all the faithful (DH 2001-2007)
supports(cum_occasione_1653,q(grace_always_efficacious),no).
source(jansen_augustinus,5,truth,1640). supports(jansen_augustinus,q(grace_always_efficacious),yes).

#program jansen_fact.             % right and fact (Arnauld, 1655): the five propositions are in the Augustinus, in its author's sense (load with jansenism)
% A dogmatic fact: connected with revelation, not revealed (TTC-PENAL FO2).
question(q(five_in_augustinus)). question_kind(q(five_in_augustinus),doctrinal).
value(q(five_in_augustinus),(yes;no)).
source(arnauld_1655,5,truth,1655).   % Seconde lettre a un duc et pair: the condemnation granted, the fact denied
supports(arnauld_1655,q(five_in_augustinus),no).
supports(ad_sanctam_1656,q(five_in_augustinus),yes).   % "contained in the Augustinus, and condemned according to the sense of the author" (DH 2010-2012)
#program ad_sanctam_as_shown.     % Ad sanctam beati Petri sedem (Alexander VII, 16 October 1656), as far as its text is shown here
% DH 2010-2012 (read 12 October 2026), §§ 5-6: "quinque illas propositiones ex
% libro ... Cornelii Iansenii ... excerptas ac in sensu ab eodem Cornelio Iansenio
% intento damnatas fuisse, declaramus et definimus". It defines, and its object is
% a fact connected with the faith. DH's abridgment does not show the pope as
% pastor of all, apostolic authority in the defining clause (it names it for the
% congresses where the cause was discussed), or a doctrine to be held by the
% whole Church (rule 14; c. 749 §3): tier 3, its own word a claim.
source(ad_sanctam_1656,3,truth,1656). papal_form(ad_sanctam_1656,ordinary). character(ad_sanctam_1656,constitution).
claims_tier(ad_sanctam_1656,ad_sanctam_1656,2).
#program cand_ad_sanctam_on_dh.   % the bull taken at its word as a definition, on DH's text: two of the five conditions shown
source(ad_sanctam_1656,2,truth,1656). papal_form(ad_sanctam_1656,ex_cathedra). object_of(ad_sanctam_1656,connected).
condition_shown(ad_sanctam_1656,defines).          % "declaramus et definimus"
condition_shown(ad_sanctam_1656,faith_or_morals).  % the propositions' sense, condemned with the same note
#program ad_sanctam_defined.      % HYPOTHETICAL until the full bull is read: the five conditions shown; a dogmatic fact defined
source(ad_sanctam_1656,2,truth,1656). papal_form(ad_sanctam_1656,ex_cathedra). object_of(ad_sanctam_1656,connected).
condition_shown(ad_sanctam_1656,(pastor_of_all;apostolic_authority;defines;faith_or_morals;whole_church)).
#program respectful_silence.      % HYPOTHETICAL: silence kept on the fact (Vineam Domini, 1705, DH 2390)
silent(jansenist_s,sil_1,q(five_in_augustinus)).
#program cand_silence_as_assent.  % "obsequious silence" read as the assent owed
assents(P,Q) :- silent(P,_,Q).

#program connected_definition.    % HYPOTHETICAL: an ex cathedra definition of a truth connected with revelation (FO1)
question(q(fact_x)). question_kind(q(fact_x),doctrinal). value(q(fact_x),(yes;no)).
source(def_x,2,truth,1900). papal_form(def_x,ex_cathedra). object_of(def_x,connected).
condition_shown(def_x,(pastor_of_all;apostolic_authority;defines;faith_or_morals;whole_church)).
supports(def_x,q(fact_x),yes).
#program cand_connected_at_tier1. % the same kind of definition entered at tier 1
source(def_y,1,truth,1900). papal_form(def_y,ex_cathedra). object_of(def_y,connected).
condition_shown(def_y,(pastor_of_all;apostolic_authority;defines;faith_or_morals;whole_church)).

#program cand_declaration_unclaimed.   % a declaration of grade that defines nothing, entered with no claim
source(decl_z,3,truth,2000). papal_form(decl_z,definitive_declaration). character(decl_z,letter).

#program ordination_reserved.     % Ordinatio sacerdotalis 4 (1994) and its claimants (TTC-PENAL FO4)
% A declaration that defines nothing: its own tier, 3, and a claim of the
% ordinary universal magisterium, the grade claimed two ways.
question(q(ordination_reserved_to_men)). question_kind(q(ordination_reserved_to_men),doctrinal).
value(q(ordination_reserved_to_men),(yes;no)).
source(os1994,3,truth,1994). papal_form(os1994,definitive_declaration). character(os1994,apostolic_letter).
supports(os1994,q(ordination_reserved_to_men),yes).   % "this judgment is to be definitively held by all the Church's faithful"
oum_claim(os1994,(1;2)). oum_claimant(os1994,(os1994;cdf_1995;cdf_1998)).
claims_tier(os1994,os1994,2).
source(cdf_1995,3,truth,1995). character(cdf_1995,responses).   % responsum ad dubium, 28 October 1995, approved and ordered published
supports(cdf_1995,q(ordination_reserved_to_men),yes).
claims_tier(cdf_1995,os1994,1).    % "set forth infallibly by the ordinary and universal Magisterium ... as belonging to the deposit of the faith"
source(cdf_1998,3,truth,1998). character(cdf_1998,commentary).
claims_tier(cdf_1998,os1994,2).    % n. 11: c. 750 §2; perhaps one day defined as revealed
% TTC-WITNESS WR: the letter declares the judgment "to be definitively held" and
% never says "ordinary and universal" or "infallibly". The words enter with the
% reply of 1995 ("set forth infallibly by the ordinary and universal
% Magisterium"), which the pope "approved ... and ordered it to be published",
% and the commentary's n. 11 repeats them.
claim_stated(os1994,(cdf_1995;cdf_1998)).
in_name_of(cdf_1995,john_paul_ii).

#program trent_formal_cause.      % sess. VI, ch. 7 (DH 1529), read two ways
source(trent_vi_ch7,1,truth,1547). ambiguous(trent_vi_ch7).
conciliar_act(trent_vi_ch7,chapter). session_defines(trent_vi_ch7).   % proem: "otherwise than as by this present decree is defined" (DH 1520)
reading(trent_vi_ch7,(against_osiander;against_every_uncreated_cause)).

% ---------- Christ and the sacraments (TTC-CHRIST) ---------------------------
#program incarnation_schools.     % two questions no source of tier 1 to 3 decides (CH3)
question(q(motive_of_incarnation)). question_kind(q(motive_of_incarnation),doctrinal).
value(q(motive_of_incarnation),(for_sin;absolute_primacy)).
source(aquinas_motive,5,truth,1273). promoted(aquinas_motive,4,1567).        % ST III q. 1 a. 3: "more fittingly" for sin
supports(aquinas_motive,q(motive_of_incarnation),for_sin).
source(scotus_motive,5,truth,1300).                                           % Ord. III d. 7 q. 3: Christ predestined first
supports(scotus_motive,q(motive_of_incarnation),absolute_primacy).
question(q(esse_of_christ)). question_kind(q(esse_of_christ),doctrinal).
value(q(esse_of_christ),(one_esse;secondary_esse)).
source(aquinas_esse_st,5,truth,1273). promoted(aquinas_esse_st,4,1567).      % ST III q. 17 a. 2: one esse
supports(aquinas_esse_st,q(esse_of_christ),one_esse).
source(aquinas_de_unione,5,truth,1272). promoted(aquinas_de_unione,4,1567).  % De unione Verbi incarnati a. 4: a secondary esse
supports(aquinas_de_unione,q(esse_of_christ),secondary_esse).

#program mary_actual_sin.         % Trent, sess. VI, can. 23 (DH 1573): no one avoids all venial sin through life
                                  % "except by a special privilege of God, as the Church holds of the Blessed Virgin"
question(q(mary_without_actual_sin)). question_kind(q(mary_without_actual_sin),doctrinal).
value(q(mary_without_actual_sin),(yes;no)).
classification(q(mary_without_actual_sin),mary,without_actual_sin).
source(trent_vi_c23_clause,3,truth,1547). character(trent_vi_c23_clause,conciliar_decree).   % stated, not anathematized
supports(trent_vi_c23_clause,q(mary_without_actual_sin),yes).

#program one_root.                % Humani generis 37 (DH 3897): all from one Adam, by natural generation (TTC-DESCENT DD2)
question(q(one_root)). question_kind(q(one_root),doctrinal).
value(q(one_root),(yes;no)).
classification(q(one_root),human_race,from_one_adam).
source(humani_generis_37,3,truth,1950). papal_form(humani_generis_37,ordinary). character(humani_generis_37,encyclical).
supports(humani_generis_37,q(one_root),yes).   % "Non enim christifideles eam sententiam amplecti possunt ..."

#program cand_branch_without_os.  % HYPOTHETICAL: a people whose members are claimed free of original sin and not from Adam (DC1)
created_person(p1). created_person(p2). group(people_p).
free_of_original_sin(p1). free_of_original_sin(p2). free_of_original_sin(people_p).
denies_descent(p1,separate_creation). denies_descent(p2,separate_creation).

#program cand_pre_adamite.        % HYPOTHETICAL: human beings before Adam (La Peyrere, Prae-Adamitae, 1655; DC2)
created_person(pre_a). denies_descent(pre_a,before_adam).

#program professions_one_root.    % HYPOTHETICAL: the descent denied in an essay, and doubted in another (DD4)
professes(writer_n,essay_n,q(one_root),no).
doubts(writer_d,essay_d,q(one_root)).

#program os_free_claimed.         % HYPOTHETICAL: the incarnate and Mary claimed free of original sin (DC3; load with creed)
free_of_original_sin(son). free_of_original_sin(mary).

#program berengar.                % Berengar's profession at the Roman synod of 1059 (DH 690), read two ways (PM4)
question(q(christ_divided_with_species)). question_kind(q(christ_divided_with_species),doctrinal).
value(q(christ_divided_with_species),(yes;no)).
source(berengar_1059,3,truth,1059). character(berengar_1059,profession).
ambiguous(berengar_1059). reading(berengar_1059,(of_the_body_in_its_species;of_the_sacramental_species)).
reads(berengar_1059,of_the_body_in_its_species,q(christ_divided_with_species),yes).
reads(berengar_1059,of_the_sacramental_species,q(christ_divided_with_species),no).
source(aquinas_berengar,5,truth,1273). promoted(aquinas_berengar,4,1567).    % ST III q. 77 a. 7 ad 3
interprets(aquinas_berengar,berengar_1059,of_the_sacramental_species).
supports(aquinas_berengar,q(christ_divided_with_species),no).
source(trent_xiii_c3,1,truth,1551).                                           % sess. XIII, can. 3 (DH 1653)
conciliar_act(trent_xiii_c3,canon).
supports(trent_xiii_c3,q(christ_divided_with_species),no).

#program sacrament_conditions.    % which conditions belong to the substance (Trent, sess. XXI, ch. 2, DH 1728)
question(q(substance(K,C))) :- condition_in_question(K,C).
question_kind(q(substance(K,C)),doctrinal) :- condition_in_question(K,C).
value(q(substance(K,C)),(yes;no)) :- condition_in_question(K,C).
classification(q(substance(K,C)),cond(K,C),of_substance) :- condition_in_question(K,C).
condition_in_question(baptism,matter). condition_in_question(penance,minister).
condition_in_question(matrimony,consent). condition_in_question(matrimony,canonical_form).
source(trent_vii_baptism_c2,1,truth,1547).                                    % true and natural water necessary (DH 1615)
conciliar_act(trent_vii_baptism_c2,canon).
supports(trent_vii_baptism_c2,q(substance(baptism,matter)),yes).
source(trent_xiv_c10,1,truth,1551).                                           % priests alone ministers of absolution (DH 1710)
conciliar_act(trent_xiv_c10,canon).
supports(trent_xiv_c10,q(substance(penance,minister)),yes).
default(q(substance(matrimony,canonical_form)),no).                          % the form: the Church's, since Tametsi (DH 1813-1816)
source(ccc_1626,3,truth,1992). character(ccc_1626,catechism).                % consent "the indispensable element that 'makes the marriage'"
supports(ccc_1626,q(substance(matrimony,consent)),yes).

#program we_baptize.              % "We baptize": CDF, Responsa ad dubia (24 June 2020), approved by the Pope (8 June 2020)
question(q(valid_form(baptism,we_baptize))). question_kind(q(valid_form(baptism,we_baptize)),doctrinal).
value(q(valid_form(baptism,we_baptize)),(yes;no)).
classification(q(valid_form(baptism,we_baptize)),form(baptism,we_baptize),valid_form).
source(cdf_responsum_2020,3,truth,2020). character(cdf_responsum_2020,responses).
supports(cdf_responsum_2020,q(valid_form(baptism,we_baptize)),no).

#program linguae_we_baptize.      % The form of baptism in its encodings, beside we_baptize (BF)
% Which features belong to the substance is teaching: the sacrament is performed where "the act which
% is performed through the minister himself, is expressed with the invocation of the Holy Trinity"
% (Florence, DH 1314; III q. 66 a. 5). The step reads the features and leaves the validity of each
% form to the sources that answer it.
question(q(form_substance(baptism))). question_kind(q(form_substance(baptism)),doctrinal).
value(q(form_substance(baptism)),(yes;no)).
classification(q(form_substance(baptism)),feature(baptism,(minister_act;trinity_invoked)),of_substance).
source(florence_1439,3,truth,1439). character(florence_1439,conciliar_decree).
supports(florence_1439,q(form_substance(baptism)),yes).
encoding(la_1969,lat,1962,2026). encoding(en_1969,eng,1965,2026). encoding(la_1439,lat,1400,1500).
encoding(en_2020,eng,2000,2026). encoding(it_2020,ita,2000,2026). encoding(la_746,lat,700,800).
encoding(la_1273,lat,1250,1300).
encoding_route((la_1969;en_1969;la_1439;en_2020;it_2020;la_746;la_1273),written).
% "Ego te baptizo in nomine Patris et Filii et Spiritus Sancti"; "I baptize you in the name of the
% Father, and of the Son, and of the Holy Spirit" (the rites of 1969 [M]).
text_of(ordo_bapt_1969,ordo_baptismi_parvulorum,la_1969,1969). form_in(bf_la_ego,ordo_bapt_1969,n(60)).
text_of(rite_bapt_en_1969,ordo_baptismi_parvulorum,en_1969,1969). made_from(rite_bapt_en_1969,ordo_bapt_1969).
form_in(bf_en_i,rite_bapt_en_1969,n(60)).
% The Greek form as Florence gives it, "Baptizatur talis servus Christi in nomine Patris ..." [M,
% the Latin], and its Byzantine English, "The servant of God (name) is baptized in the name of the
% Father, and of the Son, and of the Holy Spirit" (Roman Malyj Trebnyk, 1952; served undated).
text_of(florence_armenians,florence_1439,la_1439,1439). form_in(bf_la_greek,florence_armenians,dh(1314)).
text_of(trebnyk_en,roman_malyj_trebnyk,en_2020,2026). form_in(bf_en_byz,trebnyk_en,baptism).
% "We baptize you in the name of the Father and of the Son and of the Holy Spirit" (the CDF's question,
% 24 June 2020); "a nome della comunita noi ti battezziamo" (its Note).
text_of(cdf_dubium_2020,cdf_responsa_2020,en_2020,2020). form_in(bf_en_we,cdf_dubium_2020,dubium(1)).
text_of(cdf_nota_2020,cdf_responsa_2020,it_2020,2020). form_in(bf_it_we,cdf_nota_2020,nota).
% Zachary to Boniface (c. 746): "Baptizo te in nomine patria. et filia et spiritus Sancti", corrupt at
% its end; "in nomine matris", corrupt at its start (III q. 60 a. 7 ad 3).
text_of(zachary_746,zachary_to_boniface,la_746,746). form_in(bf_la_zachary,zachary_746,ep(746)).
text_of(summa_iii_60,summa_theologiae,la_1273,1273). form_in(bf_la_matris,summa_iii_60,st(3,60,7)).
renders(bf_en_i,bf_la_ego).
formula_of(bf_la_ego,baptism).
form_for((bf_en_i;bf_la_greek;bf_en_byz;bf_en_we;bf_it_we;bf_la_zachary;bf_la_matris),baptism).
lexicon(lex_la_1969,la_1969,1969,dictionary). lexicon(lex_en_1969,en_1969,1969,dictionary).
signifies(bf_la_ego,w_forma_baptismi,lex_la_1969). signifies(bf_en_i,w_forma_baptismi,lex_en_1969).
% The features, each read from its encoding's grammar, or as the act that gives the form states it.
form_feature(bf_la_ego,minister_act,expressed,florence_1439). form_feature(bf_la_ego,trinity_invoked,yes,florence_1439).
form_feature(bf_en_i,minister_act,expressed,grammar_en). form_feature(bf_en_i,trinity_invoked,yes,grammar_en).
form_feature(bf_la_greek,minister_act,unexpressed,florence_1439). form_feature(bf_la_greek,trinity_invoked,yes,florence_1439).
form_feature(bf_en_byz,minister_act,unexpressed,grammar_en). form_feature(bf_en_byz,trinity_invoked,yes,grammar_en).
form_feature(bf_en_we,minister_act,other_agent,cdf_nota_2020). form_feature(bf_en_we,trinity_invoked,yes,grammar_en).
form_feature(bf_it_we,minister_act,other_agent,cdf_nota_2020).
% Number: te marks the one baptized singular; English "you" does not.
form_reading(bf_la_ego,r_singular,grammar_la). admits(bf_en_i,(r_singular;r_plural),grammar_en).
corruption_at(bf_la_zachary,end). corruption_at(bf_la_matris,start).
% Who each form names as the one who acts: the minister; the assembly ("ministerialmente - non
% collegialmente", the Note).
form_agent(bf_la_ego,minister,grammar_la). form_agent(bf_en_i,minister,grammar_en).
form_agent((bf_en_we;bf_it_we),assembly,cdf_nota_2020).
#program linguae_icon_baptism.    % the Grammar of the Icon loaded beside the forms of baptism (BF5)
uses(icon).
acton(minister,recipient).                    % D: the minister acts on the one baptized (III q. 66 a. 5)
side_by_side(assembly,minister,baptism).      % S: the assembly ordered with him to the baptism
#program linguae_signed.          % HYPOTHETICAL (rule 6): forms in sign; no approved signed form exists (SG)
% In danger of death a deaf lay person baptizes an infant by pouring, signing the form in ASL; two
% transcribers later give it, in a gloss and in HamNoSys. Whether the baptism stands is the parish's
% question (c. 869 §1). Load with we_baptize and linguae_we_baptize.
question(q(human_language(ase))). question_kind(q(human_language(ase)),empirical).
value(q(human_language(ase)),(yes;no)).
question(q(signifies_by_convention(ase))). question_kind(q(signifies_by_convention(ase)),empirical).
value(q(signifies_by_convention(ase)),(yes;no)).
% The findings, each from its year (Stokoe 1960; Frishberg 1975; Klima and Bellugi 1979; Petitto and
% Marentette 1991; Hickok, Bellugi and Klima 1996). A claim of an earlier century weighs nothing on
% an empirical question: Seton, Sign Talk (1918), "Its syntax is simple and primitive".
finding(stokoe_1960,q(human_language(ase)),yes,1960).
finding(klima_bellugi_1979,q(human_language(ase)),yes,1979).
finding(petitto_1991,q(human_language(ase)),yes,1991).
finding(hickok_1996,q(human_language(ase)),yes,1996).
finding(frishberg_1975,q(signifies_by_convention(ase)),yes,1975).
finding(klima_bellugi_1979t,q(signifies_by_convention(ase)),yes,1979).
source(seton_1918,5,truth,1918). supports(seton_1918,q(human_language(ase)),no).
% Whether the signed form is a "verborum forma": no source answers it. Peters (2008) holds sacraments
% celebrated "solely in sign" valid, resting on the practice of deaf clergy: a claim, with no tier.
question(q(valid_form(baptism,sg_g1))). question_kind(q(valid_form(baptism,sg_g1)),doctrinal).
value(q(valid_form(baptism,sg_g1)),(yes;no)).
practice_teaches(peters_2008,unvoiced_practice,q(valid_form(baptism,sg_g1))).
% Thomas, twice: a vox is "sonus ab ore animalis prolatus" (In Peryerm. I lect. 4 n. 3); words,
% because they "can be formed in various ways for the purpose of signifying" (III q. 60 a. 6).
source(aquinas_verbum,5,truth,1273). promoted(aquinas_verbum,4,1567). ambiguous(aquinas_verbum).
reading(aquinas_verbum,(thomas_definition;thomas_reason)).
:- read_as(aquinas_verbum,thomas_definition), read_as(verbum,verbum_lingual).
:- read_as(aquinas_verbum,thomas_reason), read_as(verbum,verbum_vocal).
% ASL from 1817 (Hartford); Black ASL a variety of it (McCaskill et al., 2011), not an encoding made
% from it; a homesign, with no finding of a community's language.
encoding(ase_2026,ase,1817,2026). encoding(ase_black,ase,1817,2026). encoding(homesign_g,homesign,1990,2026).
encoding_route((ase_2026;ase_black;homesign_g),manual).
variety_of(ase_black,ase_2026,mccaskill_2011).
% The lexicons, each dated, with its kind: Bar-Tzur's interpreter's gloss (2001, HEAVENLY-FATHER);
% the NCOD's register for interpreters (2011); Lifeprint (everyday FATHER, a 5-hand at the forehead);
% the ASL Signbank (2017), identifiers and no definitions.
lexicon(bar_tzur_2001,ase_2026,2001,gloss). lexicon(ncod_2011,ase_2026,2011,register).
lexicon(lifeprint,ase_2026,2026,dictionary). lexicon(asl_signbank,ase_2026,2017,database).
text_of(t_bap_signed,bap_signed_record,ase_2026,2026). form_in(sg_g1,t_bap_signed,perf(1)).
signifies(sg_g1,w_forma_baptismi,ncod_2011). signifies(sg_g1,signbank_baptize,asl_signbank).
% A rendering of the approved English, and through it of the Latin.
host_declared(sg_g1,bf_en_i,ncod_2011).
form_reading(bf_en_i,(r_singular;r_plural),grammar_en).
admits(sg_g1,r_singular,meier_1990).
% IX-1 BAPTIZE IX-2 NAME FATHER SON HOLY-SPIRIT, under the religious register: a point at the signer
% is first person; the addressee is a point's target, gradient (Liddell 2003).
form_feature(sg_g1,minister_act,expressed,meier_1990).
form_feature(sg_g1,trinity_invoked,yes,bar_tzur_2001).
form_feature(sg_g1,addressee,deictic,liddell_2003).
notated(sg_g1,gloss_a,transcriber_a). notation_kind(gloss_a,gloss). notation_tier(gloss_a,gloss,full).
token(sg_g1,gloss_a,1,ix_1). token(sg_g1,gloss_a,2,baptize). token(sg_g1,gloss_a,3,ix_2).
token(sg_g1,gloss_a,4,name). token(sg_g1,gloss_a,5,father). token(sg_g1,gloss_a,6,son).
token(sg_g1,gloss_a,7,holy_spirit).
presumes(ix_2,second_person,meier_1990).
notated(sg_g1,hamnosys_b,transcriber_b). notation_kind(hamnosys_b,hamnosys).
notation_tier(hamnosys_b,manual,full). notation_tier(hamnosys_b,nonmanual,partial).
notated(sg_g1,stokoe_c,transcriber_c). notation_kind(stokoe_c,stokoe). notation_tier(stokoe_c,manual,full).
notated(sg_g1,signwriting_d,transcriber_d). notation_kind(signwriting_d,signwriting).
notation_tier(signwriting_d,(manual;nonmanual),full).
notated(sg_g1,elan_e,annotator_e). notation_kind(elan_e,annotation).
notation_tier(elan_e,(manual;nonmanual;gloss),full).
% BAPTIZE signed as immersion; the water poured.
depicts(sg_g1,immersion,transcriber_a).
rite_given(bap_signed,baptism,lay_d,infant_d,sg_g1). manner_used(bap_signed,infusion).
#program linguae_signed_subject.  % HYPOTHETICAL: a third transcriber gives no subject token (ASL drops arguments) (SG3, SG4)
notated(sg_g1,gloss_h,transcriber_h). notation_kind(gloss_h,gloss). notation_tier(gloss_h,gloss,full).
token(sg_g1,gloss_h,1,baptize). token(sg_g1,gloss_h,2,ix_2). token(sg_g1,gloss_h,3,name).
token(sg_g1,gloss_h,4,father). token(sg_g1,gloss_h,5,son). token(sg_g1,gloss_h,6,holy_spirit).
form_feature(sg_g1,minister_act,unexpressed,transcriber_h).
#program linguae_signed_father.   % HYPOTHETICAL: FATHER read under the everyday lexicon, a human father (SG3)
form_feature(sg_g1,trinity_invoked,no,lifeprint).
#program linguae_signed_moods.    % HYPOTHETICAL: one gloss for two performances, a statement and a yes/no question (SG4)
text_of(t_moods,moods_record,ase_2026,2026). form_in((sg_stmt;sg_ynq),t_moods,perf(1)).
notated((sg_stmt;sg_ynq),gloss_f,transcriber_f). notation_kind(gloss_f,gloss). notation_tier(gloss_f,gloss,full).
notated((sg_stmt;sg_ynq),elan_g,annotator_g). notation_kind(elan_g,annotation).
notation_tier(elan_g,(manual;nonmanual;gloss),full).
nonmanual_mark(sg_ynq,elan_g,brows_raised).
#program linguae_signed_see.      % HYPOTHETICAL: the form in Signing Exact English (1972), a manual code of English (SG2)
encoding(see_1972,eng,1972,2026). encoding_route(see_1972,manual). code_of(see_1972,en_1969).
lexicon(gustason_1972,see_1972,1972,dictionary).
text_of(t_bap_see,bap_see_record,see_1972,2026). form_in(sg_see,t_bap_see,perf(1)).
host_declared(sg_see,bf_en_i,gustason_1972).
signifies(sg_see,w_forma_baptismi,gustason_1972).
admits(sg_see,(r_singular;r_plural),gustason_1972).
#program linguae_signed_homesign. % HYPOTHETICAL: consent given in a homesign, made without a model of a language (SG0)
text_of(t_home,homesign_record,homesign_g,2026). form_in(sg_home,t_home,perf(1)).
consent_given(m_home,party_h,sg_home).
#program linguae_signed_mass.     % HYPOTHETICAL: a deaf priest consecrates in ASL, without voice (SG5a)
% The Holy Office (1957): "ex institutione Christi, ille solus valide celebrat, qui verba consecratoria
% pronuntiat" [S]; "pronuntiat" read as spoken, or as expressed against the merely mental. Two dates
% are reported for it: 8 March 1957 (McNamara) and 23 May 1957 (Peters, AAS 49 (1957) 370).
question(q(valid_form(eucharist,ase_institution))). question_kind(q(valid_form(eucharist,ase_institution)),doctrinal).
value(q(valid_form(eucharist,ase_institution)),(yes;no)).
source(holy_office_1957,3,truth,1957). character(holy_office_1957,responses). ambiguous(holy_office_1957).
reading(holy_office_1957,(pronuntiat_spoken;pronuntiat_expressed)).
reads(holy_office_1957,pronuntiat_spoken,q(valid_form(eucharist,ase_institution)),no).
:- read_as(holy_office_1957,pronuntiat_spoken), read_as(verbum,verbum_lingual).
:- read_as(holy_office_1957,pronuntiat_expressed), read_as(verbum,verbum_vocal).
date_claimed(holy_office_1957,19570308,mcnamara_2008). date_claimed(holy_office_1957,19570523,peters_2008).
text_of(t_mass_signed,mass_record,ase_2026,2026). form_in(ase_institution,t_mass_signed,perf(1)).
rite_given(mass_signed,eucharist,deaf_priest_s,faithful_s,ase_institution).
#program linguae_signed_practice. % HYPOTHETICAL: the Church's practice, weighed at its tiers (SG5)
% Notitiae 2 (1966) n. 95: the celebrant "eodem tempore verba profert et simul illa gestibus
% significat"; England and Wales (1992): "The celebrant must always pronounce all the words"; the
% USCCB (2017): the deaf may confess and consent "in sign language, if sign language is their
% primary means of communication"; Peters (2008): sacraments celebrated "solely in sign" valid and
% licit, resting on the practice of deaf clergy.
question(q(voice_required(celebrant))). question_kind(q(voice_required(celebrant)),governance).
value(q(voice_required(celebrant)),(yes;no)).
question(q(sign_admitted(party))). question_kind(q(sign_admitted(party)),governance).
value(q(sign_admitted(party)),(yes;no)).
source(notitiae_1966,3,juridical,1966). dicastery(notitiae_1966). supports(notitiae_1966,q(voice_required(celebrant)),yes).
source(ew_1992,3,juridical,1992). conference(ew_1992). supports(ew_1992,q(voice_required(celebrant)),yes).
source(usccb_2017,3,juridical,2017). conference(usccb_2017). supports(usccb_2017,q(sign_admitted(party)),yes).
source(peters_2008,5,truth,2008). supports(peters_2008,q(voice_required(celebrant)),no).
#program cand_validity_from_practice.  % HYPOTHETICAL: the validity of the signed form rested on practice alone (SG5)
source(cand_practice_v,5,truth,2008). supports(cand_practice_v,q(valid_form(baptism,sg_g1)),yes).
rests_on_practice(cand_practice_v,q(valid_form(baptism,sg_g1)),unvoiced_practice).
#program cand_finding_on_form.    % HYPOTHETICAL: a finding entered on the validity of the form, and on how c. 1104 §2 reads (SG0)
question(q(verba_1104(ase))). question_kind(q(verba_1104(ase)),juridical). value(q(verba_1104(ase)),(yes;no)).
finding(stokoe_1960,q(valid_form(baptism,sg_g1)),yes,1960).
finding(stokoe_1960,q(verba_1104(ase)),yes,1960).
#program cand_gloss_as_word.      % HYPOTHETICAL: the gloss's English label entered as the sign's word (SG4)
signifies(sg_g1,baptize,lifeprint).
#program cand_verba_two_ways.     % HYPOTHETICAL: c. 1104 §2 read with verba as signs, beside a runtime reading c. 849's as sounds (SG-R)
canon_verbum(c1104_2,lingual).
#program cand_asl_in_time.        % HYPOTHETICAL: a lexicon dated before ASL; Black ASL entered as descended from ASL (SG9)
lexicon(epee_1776,ase_2026,1776,dictionary).
encoding_from(ase_black,ase_2026,cand_claimant).
#program seal.                    % the seal's ground: "from the nature of the sacrament" (SA7)
question(q(seal_of_divine_law)). question_kind(q(seal_of_divine_law),doctrinal).
value(q(seal_of_divine_law),(yes;no)).
classification(q(seal_of_divine_law),seal,of_divine_law).
source(penitentiary_2019,3,truth,2019). character(penitentiary_2019,notification).   % Note, 29 June 2019, approved by the Pope
supports(penitentiary_2019,q(seal_of_divine_law),yes).
source(aquinas_seal,5,truth,1256). promoted(aquinas_seal,4,1567).            % In IV Sent. d. 21 q. 3 a. 1 (Suppl. q. 11 a. 1)
supports(aquinas_seal,q(seal_of_divine_law),yes).

% ---------- Verdicts and obligation (TTC-PRECEPT) ------------------------------
#program direct_reading.          % "direct": by the order of causes or by what is chosen (DI1)
question(q(direct_by)). question_kind(q(direct_by),doctrinal).
value(q(direct_by),(causal_order;what_is_chosen)).
source(gury_1850,5,truth,1850).     supports(gury_1850,q(direct_by),causal_order).        % Compendium theologiae moralis
source(anscombe_1982,5,truth,1982). supports(anscombe_1982,q(direct_by),what_is_chosen). % "Action, Intention and 'Double Effect'"
source(fgb_2001,5,truth,2001).      supports(fgb_2001,q(direct_by),what_is_chosen).      % The Thomist 65 (2001)

#program life_sources.            % the direct killing of the innocent (DI3)
question(q(direct_killing_of_innocent)). question_kind(q(direct_killing_of_innocent),doctrinal).
value(q(direct_killing_of_innocent),(yes;no)).
classification(q(direct_killing_of_innocent),direct(killing_of_innocent),evil_by_object).
source(pius_xii_1951,3,truth,1951). papal_form(pius_xii_1951,ordinary). character(pius_xii_1951,address).   % to midwives, 29 Oct. 1951
supports(pius_xii_1951,q(direct_killing_of_innocent),yes).
source(ev57,3,truth,1995). papal_form(ev57,ordinary). character(ev57,encyclical).   % "I confirm that the direct and voluntary killing..."
supports(ev57,q(direct_killing_of_innocent),yes). oum_claim(ev57,(1;2)). oum_claimant(ev57,ev57).   % EV states no grade (rule 14)
source(cdf_1998,3,truth,1998). character(cdf_1998,commentary). claims_tier(cdf_1998,ev57,1).   % n. 11: first paragraph
source(ev62,3,truth,1995). papal_form(ev62,ordinary). character(ev62,encyclical).   % "I declare that direct abortion..."
supports(ev62,q(direct_killing_of_innocent),yes). oum_claim(ev62,(1;2)). oum_claimant(ev62,ev62).   % EV states no grade
source(ccc2271,3,truth,1997). character(ccc2271,catechism). supports(ccc2271,q(direct_killing_of_innocent),yes).

#program assent.                  % cc. 750 §§1-2 and 752: the assent a canon attaches by reference (B15; TTC-COMMUNION)
source(c750_1,3,juridical,1983). papal_form(c750_1,legislative). binds(c750_1,1,divine_and_catholic_faith).
source(c752,3,juridical,1983).   papal_form(c752,legislative).   binds(c752,3,religious_submission).
source(atf_1998,3,juridical,1998). papal_form(atf_1998,legislative). binds(atf_1998,2,firm_assent).   % inserts c. 750 §2

#program commentary_communion.    % the commentary's n. 6: whoever denies a definitive truth "would no longer be in full communion"
question(q(definitive_denial_breaks_communion)). question_kind(q(definitive_denial_breaks_communion),doctrinal).
value(q(definitive_denial_breaks_communion),(yes;no)).
source(cdf_1998,3,truth,1998). character(cdf_1998,commentary).
supports(cdf_1998,q(definitive_denial_breaks_communion),yes).

#program cand_lg25_tier1.          % LG 25 at tier 1, as the base once typed it (TTC-COMMUNION TC1)
source(lg25,1,truth,1964).

#program cand_ev57_ex_cathedra.    % EV 57 entered as a definition: "I confirm", not "we define" (TC1)
source(ev57_def,1,truth,1995). papal_form(ev57_def,ex_cathedra). object_of(ev57_def,revealed).
condition_shown(ev57_def,(pastor_of_all;apostolic_authority;faith_or_morals;whole_church)).

#program cand_claim_without_claimant.   % a claim of the ordinary universal magisterium with no one making it (rule 14)
source(anon_doc,3,truth,2000). character(anon_doc,letter). oum_claim(anon_doc,2).

#program oum_conditions_shown.     % HYPOTHETICAL: LG 25's conditions shown for Innocent III's profession by evidence apart from the claimants (TC3)
witnessed_by(dh795,(dispersed_in_communion;authentic_teaching;faith_or_morals;one_position_definitive),evidence_hyp).   % the witness named (TTC-WITNESS WN4)

#program cand_scotsman.            % HYPOTHETICAL: "I say X is OUM"; whoever denies it is out of communion; so those in communion agree (TTC-WITNESS WD1; load with commentary_communion)
question(q(x_scot)). question_kind(q(x_scot),doctrinal). value(q(x_scot),(yes;no)).
source(decl_scot,3,truth,2026). character(decl_scot,declaration). supports(decl_scot,q(x_scot),yes).
oum_claim(decl_scot,1). oum_claimant(decl_scot,decl_scot). claim_stated(decl_scot,decl_scot).
source(survey_scot,5,truth,2025). witnessed_by(decl_scot,(authentic_teaching;faith_or_morals;one_position_definitive),survey_scot).
source(count_scot,5,truth,2026). witnessed_by(decl_scot,dispersed_in_communion,count_scot). communion_judged_by(count_scot,q(x_scot)).
source(bishop_scot,3,truth,2020). character(bishop_scot,letter). supports(bishop_scot,q(x_scot),no).

#program cand_i_say.               % HYPOTHETICAL: the claimant shows LG 25's conditions by its own word (TTC-WITNESS WD2)
question(q(x_say)). question_kind(q(x_say),doctrinal). value(q(x_say),(yes;no)).
source(decl_say,3,truth,2026). character(decl_say,declaration). supports(decl_say,q(x_say),yes).
oum_claim(decl_say,1). oum_claimant(decl_say,decl_say).
witnessed_by(decl_say,(dispersed_in_communion;authentic_teaching;faith_or_morals;one_position_definitive),decl_say).

#program witness_apart_hyp.        % HYPOTHETICAL: the control: all four conditions shown by a witness apart, communion judged by another question (TTC-WITNESS WD3)
question(q(x_apart)). question_kind(q(x_apart),doctrinal). value(q(x_apart),(yes;no)).
question(q(x_other)). question_kind(q(x_other),doctrinal). value(q(x_other),(yes;no)).
source(decl_apart,3,truth,2026). character(decl_apart,declaration). supports(decl_apart,q(x_apart),yes).
oum_claim(decl_apart,1). oum_claimant(decl_apart,decl_apart). claim_stated(decl_apart,decl_apart).
source(survey_apart,5,truth,2025). supports(survey_apart,q(x_other),yes). communion_judged_by(survey_apart,q(x_other)).
witnessed_by(decl_apart,(dispersed_in_communion;authentic_teaching;faith_or_morals;one_position_definitive),survey_apart).
source(bishop_apart,3,truth,2020). character(bishop_apart,letter). supports(bishop_apart,q(x_apart),no).

#program cand_n11_fixes.          % the commentary's n. 11 treated as fixing EV 57's grade (TTC-COMMUNION TC4)
treated_as_fixing(cdf_1998,ev57).

#program craniotomy_sources.      % the Holy Office: craniotomy "cannot safely be taught" (DI4)
question(q(craniotomy_illicit)). question_kind(q(craniotomy_illicit),doctrinal).
value(q(craniotomy_illicit),(yes;no)).
classification(q(craniotomy_illicit),craniotomy,evil_by_object).
source(ho_1884,3,truth,1884). character(ho_1884,responses). supports(ho_1884,q(craniotomy_illicit),yes).   % ASS 17, 556
source(ho_1889,3,truth,1889). character(ho_1889,responses). supports(ho_1889,q(craniotomy_illicit),yes).   % ASS 22, 748
source(ho_1902,3,truth,1902). character(ho_1902,responses).                                               % ASS 35, 162
question(q(ectopic_extraction_illicit)). question_kind(q(ectopic_extraction_illicit),doctrinal).
value(q(ectopic_extraction_illicit),(yes;no)).
classification(q(ectopic_extraction_illicit),extraction_of_ectopic_fetus,evil_by_object).
supports(ho_1902,q(ectopic_extraction_illicit),yes).   % immature ectopic fetuses may not be extracted

#program ivf_sources.             % Donum vitae II.B.5 (1987); Dignitas personae (2008) (DI6)
question(q(ivf_illicit)). question_kind(q(ivf_illicit),doctrinal). value(q(ivf_illicit),(yes;no)).
classification(q(ivf_illicit),ivf,evil_by_object).
source(donum_vitae_1987,3,truth,1987). character(donum_vitae_1987,instruction). supports(donum_vitae_1987,q(ivf_illicit),yes).
source(dignitas_personae_2008,3,truth,2008). character(dignitas_personae_2008,instruction).
supports(dignitas_personae_2008,q(ivf_illicit),yes). reaffirms(dignitas_personae_2008,donum_vitae_1987).

#program usury_one_question.      % Vix pervenit and the 1917 Code entered as one question (SD2)
question(q(interest_on_loans)). question_kind(q(interest_on_loans),doctrinal).
value(q(interest_on_loans),(forbidden;permitted)).
source(vix_pervenit,3,truth,1745). papal_form(vix_pervenit,ordinary). character(vix_pervenit,encyclical).
supports(vix_pervenit,q(interest_on_loans),forbidden).
source(cic1917_c1543,3,juridical,1917). papal_form(cic1917_c1543,legislative).
supports(cic1917_c1543,q(interest_on_loans),permitted).
#program usury_two_questions.     % typed: profit from the loan as such; interest by an extrinsic title (SD2)
question(q(profit_from_loan_as_such)). question_kind(q(profit_from_loan_as_such),doctrinal).
value(q(profit_from_loan_as_such),(yes;no)).
classification(q(profit_from_loan_as_such),profit_from_loan_as_such,evil_by_object).
source(vix_pervenit,3,truth,1745). papal_form(vix_pervenit,ordinary). character(vix_pervenit,encyclical).
supports(vix_pervenit,q(profit_from_loan_as_such),yes). teaching_type(vix_pervenit,principle).
question(q(interest_by_extrinsic_title)). question_kind(q(interest_by_extrinsic_title),juridical).
value(q(interest_by_extrinsic_title),(permitted;forbidden)).
source(cic1917_c1543,3,juridical,1917). papal_form(cic1917_c1543,legislative).
supports(cic1917_c1543,q(interest_by_extrinsic_title),permitted).

#program cand_directive_as_principle.   % EV 56's judgment of today's circumstances read as fixing the kind (SD4)
question(q(execution_evil_by_object)). question_kind(q(execution_evil_by_object),doctrinal).
value(q(execution_evil_by_object),(yes;no)).
classification(q(execution_evil_by_object),execution,evil_by_object).
source(ev56_rarity,3,truth,1995). papal_form(ev56_rarity,ordinary). teaching_type(ev56_rarity,directive).   % "very rare, if not practically non-existent"
supports(ev56_rarity,q(execution_evil_by_object),yes).

% ---------- Authorship (TTC-SOURCES AU, FQ3) ----------------------------------
% Signed, anonymous, attributed (sources.lp). An attribution is a claim,
% refused where the order refutes it; a dependence counts from its witness.
#program fides_damasi.            % the Fides Damasi (DH 71-72): "de Patre et Filio procedentem"
% "Of uncertain author and time; in Gaul about 500 (?)" (Denzinger). Its title
% gives it to Pope Damasus (d. 384): on that branch a pope's letter of about
% 380, at tier 3; otherwise an anonymous creed of about 500, at tier 5.
anonymous(fides_damasi).
attribution(fides_damasi,damasus,fides_title). died(damasus,384).
source(fides_damasi,3,truth,380)   :- attributed(fides_damasi,damasus).
papal_form(fides_damasi,ordinary)  :- attributed(fides_damasi,damasus).
character(fides_damasi,letter)     :- attributed(fides_damasi,damasus).
source(fides_damasi,5,truth,500)   :- not attributed(fides_damasi,damasus).
supports(fides_damasi,q(spirit_origin),father_and_son).

#program pseudo_dionysius.        % the Corpus Dionysiacum and Proclus (AU1)
% Its author calls himself the Areopagite, Paul's convert (Acts 17:34), dead
% within the first century on any account. The Cloud of Unknowing names him:
% "Saint Denis said" (ch. 70). Divine Names IV draws on Proclus's De malorum
% subsistentia (H. Koch, Philologus 54; J. Stiglmayr, Historisches Jahrbuch 16,
% 253-273; both 1895).
source(dionysius_corpus,5,truth,500).
attribution(dionysius_corpus,dionysius_areopagite,dionysius_corpus).
attribution(dionysius_corpus,dionysius_areopagite,cloud_of_unknowing).
died(dionysius_areopagite,100).
text_year(proclus_dms,470).                     % Proclus died in 485
draws_on(dionysius_corpus,proclus_dms,koch_1895). text_year(koch_1895,1895).
draws_on(dionysius_corpus,proclus_dms,stiglmayr_1895). text_year(stiglmayr_1895,1895).

#program de_causis.               % the Liber de causis (AU2)
% Read as Aristotle's in the Latin schools; drawn from Proclus's Elements of
% Theology, as Thomas saw from Moerbeke's Latin of 1268 (Super librum De causis,
% prooemium, 1272). An Arabic work of the ninth century. Thomas's commentary
% is a source of the record, dated by its year.
attribution(liber_de_causis,aristotle,latin_schools). died(aristotle,-322).
text_year(proclus_et,470).
source(thomas_de_causis,5,truth,1272). promoted(thomas_de_causis,4,1567).
draws_on(liber_de_causis,proclus_et,thomas_de_causis).

#program quicumque_author.        % the Quicumque's name (AU3; load with creeds)
% "The creed of bishop St. Athanasius" (the synod of Autun, c. 670); "composed
% by most blessed Athanasius" (Florence to the Armenians, 1439). It uses the
% terms of Augustine's De Trinitate (J. N. D. Kelly, The Athanasian Creed, 1964).
% Its tier rests on its reception, a claim of its own, not on the name.
attribution(quicumque,athanasius,autun_670). attribution(quicumque,athanasius,florence_armenians_1439).
died(athanasius,373).
text_year(augustine_dt15,420).
draws_on(quicumque,augustine_dt15,kelly_1964). text_year(kelly_1964,1964).

#program pseudo_lull.             % the alchemical Testamentum and the Ars brevis (AU4)
% The Testamentum's colophon: written in London, 1332 (Oxford, Corpus Christi
% College MS 244); given to Ramon Llull by the century's end. Llull died early
% in 1316; the Ars brevis (Pisa, 1308) is his, signed.
self_dated(testamentum,1332).
attribution(testamentum,llull,later_manuscripts). died(llull,1316).
signed(ars_brevis,llull). text_year(ars_brevis,1308).

#program imitatio.                % the Imitation of Christ (AU5)
% Thomas à Kempis's autograph of 1441, "per manus fratris Th. Kempensis"
% (Brussels, KBR ms. 5855-61); early printed editions gave it to Jean Gerson.
anonymous(imitatio).
attribution(imitatio,thomas_a_kempis,autograph_1441). died(thomas_a_kempis,1471).
attribution(imitatio,gerson,early_editions). died(gerson,1429).

#program cloud.                   % The Cloud of Unknowing (AU6)
% English, fourteenth century; "Nothing is known of him" (Underhill). It cites
% "Saint Denis", whose name it takes as the Corpus's author: a claimant of the
% Corpus's attribution (pseudo_dionysius). It draws on nothing a date refutes.
anonymous(cloud_of_unknowing).

#program cand_author_filled.      % an author entered for an anonymous text without a claim
author(cloud_of_unknowing,author_x).
#program attribution_shown_hyp.   % HYPOTHETICAL: evidence apart from the claimants shows one attribution; a claimant's own word shows none (load with imitatio)
shown_by(imitatio,thomas_a_kempis,evidence_x). shown_by(imitatio,gerson,early_editions).

% ---------- The liturgy: witness and development (TTC-LITURGY) ---------------
% One book, two sources: the act that gives it is governance; the prayer it
% holds is a witness that weighs and never fixes (liturgy.lp). The parts load
% beside the records they speak to.
#program lex_orandi_ic.           % the prayer of the feast of the Conception (LW1, LW2; load with ic)
% Sixtus IV, Cum praeexcelsa (27 February 1477), gave "formal permission and
% encouragement to celebrate the feast"; the Office Sicut lilium, by Leonardo
% Nogarolo, he approved in 1480. Its prayer: "O God, Who by the Immaculate
% Conception of the Virgin, prepared a worthy dwelling place for thy Son".
question(q(feast_of_the_conception)). question_kind(q(feast_of_the_conception),governance).
value(q(feast_of_the_conception),(encouraged;not_encouraged)). default(q(feast_of_the_conception),not_encouraged).
source(cum_praeexcelsa_1477,3,juridical,1477). papal_form(cum_praeexcelsa_1477,legislative).
supports(cum_praeexcelsa_1477,q(feast_of_the_conception),encouraged).
source(office_conception,3,truth,1480). character(office_conception,liturgy). liturgical_witness(office_conception).
supports(office_conception,q(ic),yes).
prayed_in(office_conception,latin). in_use_from(office_conception,1480). prayed_by(office_conception,(bishops;faithful)).

#program lex_orandi_creed.        % Rome's creed (LW3; load with filioque)
% Leo III refused to add the Filioque to the creed and had it engraved
% without it on two silver shields at St Peter's (about 810); the creed was
% first sung at Mass in Rome with it in 1014, at Henry II's coronation. The
% text sung is governance; the creed prayed with the word is a witness.
question(q(creed_text_rome)). question_kind(q(creed_text_rome),governance).
value(q(creed_text_rome),(without_filioque;with_filioque)).
source(leo_iii_810,3,juridical,810). papal_form(leo_iii_810,legislative).
supports(leo_iii_810,q(creed_text_rome),without_filioque).
source(benedict_viii_1014,3,juridical,1014). papal_form(benedict_viii_1014,legislative).
supports(benedict_viii_1014,q(creed_text_rome),with_filioque).
source(creed_rome_1014,3,truth,1014). character(creed_rome_1014,liturgy). liturgical_witness(creed_rome_1014).
supports(creed_rome_1014,q(spirit_origin),father_and_son).
prayed_in(creed_rome_1014,latin). in_use_from(creed_rome_1014,1014). prayed_by(creed_rome_1014,(bishops;faithful)).

#program liturgy_oum_hyp.         % HYPOTHETICAL: a claim of the ordinary universal magisterium argued from a universal feast (LW8; load with ic)
source(feast_universal,3,truth,1708). character(feast_universal,liturgy). liturgical_witness(feast_universal).
universal_witness(feast_universal). supports(feast_universal,q(ic),yes).
source(claim_1849,5,truth,1849). supports(claim_1849,q(ic),yes).
oum_claim(claim_1849,1). oum_claimant(claim_1849,claim_1849). rests_on_liturgy(claim_1849,feast_universal).

#program liturgy_change_hyp.      % HYPOTHETICAL: a long-kept element and a change to it by competent authority (LW9; with a clock)
liturgical_witness(element_x). prayed_in(element_x,(latin;ukrainian;maronite)). in_use_from(element_x,800).
prayed_by(element_x,(bishops;faithful)).
liturgical_witness(element_y). prayed_in(element_y,latin). in_use_from(element_y,1975). prayed_by(element_y,bishops).
changes(chg_x,element_x).

#program cand_lex_orandi_fixes.   % a liturgy treated as settling a doctrine (LW4; load with ic, lex_orandi_ic)
fixes(office_conception,q(ic)).

#program cand_binding_by_love.    % an element typed as binding because it is loved (LW10)
binds_because(chant_x,loved).

#program indiculus.               % the axiom's source (LW7)
% "Ut legem credendi lex statuat supplicandi" (DH 246). "For centuries"
% affixed to Celestine I's letter to the bishops of Gaul; "most probably the
% work of St. Prosper of Aquitaine" (Catholic Encyclopedia); "according to
% Prosper of Aquitaine (5th cent.)" (CCC 1124). Mediator Dei 48 cites it as
% "De gratia Dei «Indiculus»", naming no author.
attribution(indiculus,celestine_i,collections). died(celestine_i,432).
attribution(indiculus,prosper,ccc_1124). died(prosper,455).
source(ccc_1124,3,truth,1992). character(ccc_1124,catechism).

#program roman_missal.            % the Roman Missal's editions in an order, not a line (RD1)
% Quo primum (1570); the typical edition of 1962 (decree of the Congregation
% of Rites, 23 June 1962); Missale Romanum (1969, in force 30 November
% 1969; the typical edition 1970), drawing also on the ancient sacramentaries;
% the third typical edition (2002).
text_year(missal_1570,1570). text_year(missal_1962,1962). text_year(missal_1970,1970). text_year(missal_2002,2002).
text_year(sacramentarium_gelasianum,750).
derives_from(missal_1962,missal_1570). derives_from(missal_1970,missal_1962).
derives_from(missal_1970,sacramentarium_gelasianum). derives_from(missal_2002,missal_1970).
#program cand_rite_from_later.    % a rite descending from a later one (RD2)
derives_from(missal_1962,missal_2002).
#program cand_rite_cycle.         % a rite descending from itself (RD2)
text_year((rite_p;rite_q),1500). derives_from(rite_p,rite_q). derives_from(rite_q,rite_p).

#program reform_1970.             % the reform read as continuity or rupture (RD3; load with liturgy)
% "There is no contradiction between the two editions of the Roman Missal. In
% the history of the liturgy there is growth and progress, but no rupture"
% (Benedict XVI, letter to the bishops, 7 July 2007). Traditionis custodes
% answers a governance question, not this one.
question(q(reform_1970)). question_kind(q(reform_1970),doctrinal). value(q(reform_1970),(continuity;rupture)).
supports(bxvi_letter,q(reform_1970),continuity).

% ---------- The last things (TTC-NOVISSIMA) ----------------------------------
% The order after death is given by tier-1 sources in force (novissima.lp);
% the parts load beside the records they speak to.
#program novissima_order.         % the order after death, given (NV1-NV5, JX3)
% Lateran IV, Firmiter (DH 801), as in creeds: "He will come at the end of
% time to judge the living and the dead"; all "will rise with their own
% bodies, which they now bear", to receive according to their deserts, "the
% latter perpetual punishment with the devil, the former eternal glory with
% Christ".
source(lateran_iv_1215,1,truth,1215). conciliar_act(lateran_iv_1215,creed).
gives_order(lateran_iv_1215,return,rising). gives_order(lateran_iv_1215,rising,judgment).
without_end(hell,lateran_iv_1215). without_end(vision,lateran_iv_1215).
general_rule_given(lateran_iv_1215). one_body_given(lateran_iv_1215).
% Benedict XII, Benedictus Deus (29 January 1336; DH 1000-1002): "hac
% imperpetuum valitura Constitutione, auctoritate apostolica diffinimus";
% the souls "mox post mortem suam et purgationem praefatam in illis qui
% purgatione huiusmodi indigebant, etiam ante resumptionem suorum corporum
% et iudicium generale ... viderunt, vident et videbunt divinam essentiam",
% "usque ad finale iudicium et extunc usque in sempiternum"; those in actual
% mortal sin "mox post mortem suam ad Inferna descendunt"; "in die iudicii
% omnes [homines] ante tribunal Christi cum suis corporibus comparebunt";
% "ab omnibus fidelibus esse tenendas".
source(benedictus_deus_1336,1,truth,1336). papal_form(benedictus_deus_1336,ex_cathedra).
object_of(benedictus_deus_1336,revealed).
condition_shown(benedictus_deus_1336,(pastor_of_all;apostolic_authority;defines;faith_or_morals;whole_church)).
gives_order(benedictus_deus_1336,dying,vision). gives_order(benedictus_deus_1336,dying,purification).
gives_order(benedictus_deus_1336,purification,vision). gives_order(benedictus_deus_1336,dying,hell).
gives_order(benedictus_deus_1336,vision,rising). gives_order(benedictus_deus_1336,rising,judgment).
without_end(vision,benedictus_deus_1336).
% Florence, Laetentur caeli (6 July 1439; DH 1304-1306), as in limbo: the
% souls "penis purgatoriis post mortem purgari"; "in celum mox recipi et
% intueri clare ipsum Deum trinum et unum, sicuti est"; "mox in infernum
% descendere".
source(florence_1439,1,truth,1439). conciliar_act(florence_1439,definition).
gives_order(florence_1439,dying,purification). gives_order(florence_1439,purification,vision).
gives_order(florence_1439,dying,vision). gives_order(florence_1439,dying,hell).
% Lateran V, Apostolici regiminis (19 December 1513; DH 1440): those who
% assert "the intellectual soul is mortal, or that it is only one among all
% human beings" are condemned; it is immortal and multiplied "for the
% enormous number of bodies into which it is infused individually".
source(lateran_v_1513,1,truth,1513). conciliar_act(lateran_v_1513,definition).
gives_subsistence(lateran_v_1513). one_body_given(lateran_v_1513).

#program novissima_theories.      % HYPOTHETICAL: theories of what follows death, placed on the order (NV2, NV5, JX3; load with novissima_order)
places(sleep_t,rising,vision).                                   % no vision before the rising
places(rising_at_death_t,rising,return).                         % each rises at death, before the return
places(total_death_t,rising,vision). denies_subsistence(total_death_t).   % nothing subsists; all re-created at the end
places(vision_unpurified_t,vision,purification).                 % the vision before the purification one needs
places(deferral_t,judgment,vision).                              % the vision only after the judgment
ends_in(restoration_t,hell,vision).                              % hell ending in the vision of all
ends_in(cycles_t,vision,purification).                           % the blessed falling again, to be purged anew
#program cand_stage_unknown.      % HYPOTHETICAL: a theory naming stages the order does not know (NV2; load with novissima_theories)
places(t_unknown,nirvana,dying). places(t_unknown,dying,limbus).

#program one_body.                % HYPOTHETICAL: a soul given a second body; a raising (NV3; load with novissima_order)
body_of(person_r,body_r1). body_of(person_r,body_r2).
raised(person_l). body_of(person_l,body_l).                      % raised to his own body, to die again (Jn 11)

#program cand_rising_early.       % HYPOTHETICAL: a bodily rising before the return, claimed of another (NV4)
rises_early(person_e).

#program punishment_ends.         % the end of punishment (NV5; load with creeds and an asof)
question(q(punishment_ends)). question_kind(q(punishment_ends),doctrinal). value(q(punishment_ends),(yes;no)).
% The synod of Constantinople (543), can. 9 against Origen (DH 411): anathema
% to one who says "the punishment of demons and of impious men is only
% temporary, and will one day have an end". A local synod under Mennas; the
% adhesion of Vigilius, reported by Liberatus, is not entered.
source(synod_543,3,truth,543). particular_council(synod_543). character(synod_543,conciliar_decree).
supports(synod_543,q(punishment_ends),no).
supports(quicumque,q(punishment_ends),no).          % "qui vero mala, in ignem aeternum" (DH 76)
supports(lateran_iv_1215,q(punishment_ends),no).    % "perpetual punishment with the devil" (DH 801)

#program vision_deferred.         % the vision before the rising: John XXII to Florence (JX; load with an asof)
question(q(vision_before_rising)). question_kind(q(vision_before_rising),doctrinal).
value(q(vision_before_rising),(yes;no)).
% Thomas, ST I-II q. 4 a. 5: "the souls of the saints, separated from their
% bodies, 'walk by sight,' seeing the Essence of God"; the contrary he calls
% false.
source(thomas_vision,5,truth,1271). promoted(thomas_vision,4,1567).
supports(thomas_vision,q(vision_before_rising),yes).
% John XXII, sermons at Avignon (1 November 1331 to 2 February 1332): the
% vision of the divine essence only after the judgment. A pope's teaching in
% homilies, at the tier of its form (rule 14). Withdrawn by his own act: in
% consistory (3 January 1334) he revoked whatever in them was contrary to
% Scripture and the faith, and Ne super his professes the contrary.
source(john_xxii_sermons,3,truth,1331). papal_form(john_xxii_sermons,ordinary). character(john_xxii_sermons,homily).
supports(john_xxii_sermons,q(vision_before_rising),no).
withdrawn(john_xxii_sermons,1334).
% Ne super his (3 December 1334; DH 990-991): "Fatemur siquidem et credimus,
% quod animae purgatae separatae a corporibus ... vident Deum ... ac divinam
% essentiam facie ad faciem clare, in quantum status et condicio compatitur
% animae separatae."
source(ne_super_his_1334,3,truth,1334). papal_form(ne_super_his_1334,ordinary). character(ne_super_his_1334,profession).
supports(ne_super_his_1334,q(vision_before_rising),yes).
source(benedictus_deus_1336,1,truth,1336). papal_form(benedictus_deus_1336,ex_cathedra).
object_of(benedictus_deus_1336,revealed).
condition_shown(benedictus_deus_1336,(pastor_of_all;apostolic_authority;defines;faith_or_morals;whole_church)).
supports(benedictus_deus_1336,q(vision_before_rising),yes).
source(florence_1439,1,truth,1439). conciliar_act(florence_1439,definition).
supports(florence_1439,q(vision_before_rising),yes).

#program benedictus_deus_relaxed. % ablation: Benedictus Deus relaxed, Florence alone (JX3)
relaxed(benedictus_deus_1336).

#program after_death_measured.    % HYPOTHETICAL: durations laid on what follows death; a year on the rising (DU1)
duration_claim(purification,300,days). duration_claim(vision,1000,years). duration_claim(hell,7,days).
date_claim(rising,2100).

#program separated_souls.         % HYPOTHETICAL: souls after death, Thomas's measures (DU4)
% ST I q. 10 a. 5 ad 1: spiritual creatures, "quantum vero ad eorum esse
% naturale, mensurantur aevo. Sed quantum ad visionem gloriae, participant
% aeternitatem"; a. 6 obj. 3 names human souls among aeviternal things.
separated_soul(soul_s). separated_soul(soul_b). measured_by(soul_b,share_of_eternity).
#program cand_blessed_eternal.    % HYPOTHETICAL: the blessed measured by eternity itself (DU4; load with separated_souls)
measured_by(soul_b,eternity).

#program canonization_hyp.        % HYPOTHETICAL: a canonization in the words of the formula (NS1, NS2)
% "Ad honorem Sanctae et Individuae Trinitatis, ad exaltationem fidei
% catholicae et vitae christianae incrementum, auctoritate Domini nostri Iesu
% Christi, beatorum Apostolorum Petri et Pauli ac Nostra ... Sanctum esse
% decernimus et definimus, ac Sanctorum Catalogo adscribimus", to be venerated
% "in universa Ecclesia": a papal definition of a fact connected with
% revelation, tier 2 by its form. The CDF's commentary on the Professio fidei
% (1998) n. 11 counts "the canonizations of saints (dogmatic facts)" among
% truths to be held definitively: a claim of a lower tier about a higher.
question(q(in_glory(saint_x))). question_kind(q(in_glory(saint_x)),doctrinal). value(q(in_glory(saint_x)),(yes;no)).
source(canonization_x,2,truth,1990). papal_form(canonization_x,ex_cathedra). object_of(canonization_x,connected).
condition_shown(canonization_x,(pastor_of_all;apostolic_authority;defines;faith_or_morals;whole_church)).
supports(canonization_x,q(in_glory(saint_x)),yes).
source(cdf_1998_commentary,3,truth,1998). character(cdf_1998_commentary,commentary).
claims_tier(cdf_1998_commentary,canonization_x,2).
#program beatification_hyp.       % HYPOTHETICAL: a beatification typed as teaching on the same question (NS3; load with canonization_hyp)
source(beatification_x,3,juridical,1985).
supports(beatification_x,q(in_glory(saint_x)),yes).
#program placed_after_death.      % HYPOTHETICAL: named persons placed in states after death by a case (NS1; load with canonization_hyp)
placed_in(person_h,hell). placed_in(person_p,purification). placed_in(person_g,glory). placed_in(saint_x,glory).

#program cand_nothing_carried_over.   % HYPOTHETICAL: nothing of this world carried over to the end (WL1; load with trinity, creed, marian)
nothing_carried_over.

#program world_at_the_end.        % the world at the end (WL2)
question(q(world_at_the_end)). question_kind(q(world_at_the_end),doctrinal).
value(q(world_at_the_end),(transformed;annihilated;unchanged)).
% Rom 8:19-22, "creation itself would be set free from slavery to
% corruption". "Creatura hic tripliciter accipi potest" (Thomas, Super Rom.
% c. 8 lect. 4): the just, human nature, or "ipsa creatura sensibili", which
% "quamdam novitatem gloriae consequetur". Augustine: "ipsa creatura, id est,
% ipse homo" (De div. quaest. 83 q. 67). Read of the human creature, the text
% says nothing of the world.
source(rom8_19,0,truth,57). ambiguous(rom8_19). reading(rom8_19,(sensible_creation;human_creature)).
reads(rom8_19,sensible_creation,q(world_at_the_end),transformed).
source(gs39,3,truth,1965). character(gs39,conciliar_constitution).
supports(gs39,q(world_at_the_end),transformed).      % "nec universi transformandi modum novimus"
source(ccc_1047,3,truth,1992). character(ccc_1047,catechism).
supports(ccc_1047,q(world_at_the_end),transformed).  % "destined to be transformed" (CCC 1047)
% In IV Sent. d. 48 (Suppl. q. 91 a. 1): the world renewed, "non tamen
% speciem variantem, sed addentem cuiusdam gloriae perfectionem".
source(thomas_renewal,5,truth,1256). promoted(thomas_renewal,4,1567).
supports(thomas_renewal,q(world_at_the_end),transformed).
% Gerhard, Loci theologici XXX: "non nudam qualitatum alterationem, sed ipsius
% substantiae abolitionem, adeoque totalem annihilationem", angels and men
% excepted; Quenstedt likewise (Hodge, Systematic Theology III, iv §3).
source(gerhard_loci,5,truth,1622). supports(gerhard_loci,q(world_at_the_end),annihilated).
source(quenstedt_1685,5,truth,1685). supports(quenstedt_1685,q(world_at_the_end),annihilated).

#program plants_and_animals.      % whether plants and animals remain (WL3; with an asof, or today)
question(q(plants_and_animals_remain)). question_kind(q(plants_and_animals_remain),doctrinal).
value(q(plants_and_animals_remain),(yes;no)).
% In IV Sent. d. 48 (Suppl. q. 91 a. 5): "they will not remain in this
% renewal". Laudato si' 243: "each creature, resplendently transfigured, will
% take its rightful place".
source(thomas_renewal,5,truth,1256). promoted(thomas_renewal,4,1567).
supports(thomas_renewal,q(plants_and_animals_remain),no).
source(laudato_si_2015,3,truth,2015). papal_form(laudato_si_2015,ordinary). character(laudato_si_2015,encyclical).
supports(laudato_si_2015,q(plants_and_animals_remain),yes).

#program lasts_by_charity.        % HYPOTHETICAL: an element claimed to last because charity carries it (WL4)
lasts_claim(chant_x,charity).

#program one_sacrifice.           % the Mass and the Last Supper joined to the one passion (OS1; load with trinity, creed)
% Trent, sess. XXII (17 September 1562): at the Last Supper he "offered up to
% God the Father His own body and blood" (ch. 1, DH 1740); "the victim is
% one and the same ... the manner alone of offering being different" (ch. 2,
% DH 1743); cann. 1, 3, 4 (DH 1751, 1753, 1754).
source(trent_xxii_1562,1,truth,1562). conciliar_act(trent_xxii_1562,canon).
sacrifice_canons(trent_xxii_1562).
next(last_supper,passion).
same_sacrifice(last_supper,passion). same_sacrifice(mass_m,passion). celebration_date(mass_m,20260405).
#program cand_second_immolation.  % HYPOTHETICAL: the Mass typed as a second immolation (OS2)
repeats(mass_m,passion).
#program cand_bare_commemoration. % HYPOTHETICAL: the Mass typed as a bare commemoration (OS2)
commemoration_only(mass_m).

% ---------- The empirical kind (TTC-EMPIRICA) ---------------------------------
% A question the sciences answer: no tier settles it, a finding does, and a
% finding settles no doctrine (empirica.lp).
#program empirical_kind_hyp.      % HYPOTHETICAL: an act at tier 1 on an empirical question (EM1)
question(q(x_fact)). question_kind(q(x_fact),empirical). value(q(x_fact),(a;b)).
source(def_e,1,truth,1700). hypothetical_warrant(def_e). supports(def_e,q(x_fact),a).
source(dec_e,3,truth,1800). character(dec_e,instruction). supports(dec_e,q(x_fact),b).   % and one at tier 3 for the other
#program cand_consent_unclaimed.  % HYPOTHETICAL: the Fathers' consent claimed on a text outside faith and morals, by no one named (EM1)
source(text_u,0,truth,100). ambiguous(text_u). reading(text_u,(r1;r2)). consent_claim(text_u,r1).
#program findings_hyp.            % HYPOTHETICAL: an earlier finding and a later one (EM2; load with empirical_kind_hyp)
finding(f_early,q(x_fact),a,1900). finding(f_late,q(x_fact),b,1950).
#program cand_finding_on_doctrine.   % HYPOTHETICAL: a finding laid on a doctrinal question (EM3; load with beginning)
finding(f_doctrine,q(world_began),no,2000).

#program galileo.                 % the earth's motion: 1616, 1633, 1729, 1820 (GL)
question(q(earth_moves)). question_kind(q(earth_moves),empirical). value(q(earth_moves),(yes;no)).
question(q(sun_at_rest)). question_kind(q(sun_at_rest),empirical). value(q(sun_at_rest),(yes;no)).
% Josh 10:12-13, "And the sun stood still": described "in popular language
% and according to external appearances" (NAB, note), or read as astronomy.
% The book's date is not at issue; it is entered before every act here.
source(josh10_12,0,truth,-600). ambiguous(josh10_12). reading(josh10_12,(by_appearances;astronomical)).
reads(josh10_12,astronomical,q(earth_moves),no).
% The censure of 24 February 1616, by the Holy Office's theologians,
% unpublished: the sun at rest at the centre "stultam et absurdam in
% Philosophia; et formaliter haereticam, quatenus contradicit expresse
% sententiis sacrae scripturae ... secundum communem expositionem, et sensum,
% Sanctorum Patrum et Theologorum doctorum"; the earth's motion "ad minus
% esse in fide erroneam" (Pagano, 2009). It claims the Fathers' consent for
% the astronomical reading, on a text not of faith or morals (DH 1507).
source(censure_1616,5,truth,1616).
supports(censure_1616,q(sun_at_rest),no). supports(censure_1616,q(earth_moves),no).
censures_as_heresy(censure_1616,q(sun_at_rest),yes). censures_in_faith(censure_1616,q(earth_moves),yes).
consent_claim(josh10_12,astronomical). consent_claimant(josh10_12,censure_1616).
% The decree of the Congregation of the Index (5 March 1616), published by
% the pope's order: "falsam illam doctrinam Pithagoricam, divinaeque
% scripturae omnino adversantem"; Copernicus "suspendendos esse donec
% corrigantur". Its form disputed: disciplinary ("this tribunal being
% absolutely incompetent to make a dogmatic decree", Catholic Encyclopedia)
% or doctrinal (Fantoli). Read both ways.
question(q(copernicus_may_be_read)). question_kind(q(copernicus_may_be_read),governance).
value(q(copernicus_may_be_read),(yes;no)).
source(index_1616,3,juridical,1616). dicastery(index_1616).
ambiguous(index_1616). reading(index_1616,(disciplinary;doctrinal)).
reads(index_1616,disciplinary,q(copernicus_may_be_read),no). reads(index_1616,doctrinal,q(copernicus_may_be_read),no).
reads(index_1616,doctrinal,q(earth_moves),no).
% The sentence of 22 June 1633 (seven cardinals, Inquisitors General): an
% opinion held "dopo esser stata dichiarata e diffinita per contraria alla
% Sacra Scrittura". Its word on the act of 1616, a claim of grade, treated
% as fixing. Nothing about the person judged is entered (rule 3).
source(sentence_1633,3,juridical,1633). dicastery(sentence_1633).
claims_tier(sentence_1633,index_1616,1). treated_as_fixing(sentence_1633,index_1616).
% The Holy Office, 16 August 1820: "no obstacles exist for those who sustain
% Copernicus' affirmation regarding the earth's movement in the manner in
% which it is affirmed today" (Brandmuller and Greipl, 1992).
source(holy_office_1820,3,juridical,1820). dicastery(holy_office_1820).
supports(holy_office_1820,q(copernicus_may_be_read),yes).
% The findings: Bradley's aberration of starlight (Phil. Trans. 406, 1729),
% Bessel's parallax (1838), Foucault's pendulum (1851).
finding(bradley_1729,q(earth_moves),yes,1729). finding(bessel_1838,q(earth_moves),yes,1838).
finding(foucault_1851,q(earth_moves),yes,1851).

#program beginning.               % the world's beginning and the expanding universe (CB; EM3)
% Lateran IV (DH 800): God "simul ab initio temporis utramque de nihilo
% condidit creaturam".
question(q(world_began)). question_kind(q(world_began),doctrinal). value(q(world_began),(yes;no)).
source(lateran_iv_1215,1,truth,1215). conciliar_act(lateran_iv_1215,creed).
supports(lateran_iv_1215,q(world_began),yes).
% Pius XII, "Un'ora" (22 November 1951): science has indicated the cosmos's
% "beginning in time", "Creation, therefore, in time, and therefore, a
% Creator; and consequently, God!"; though "the facts verified up to now are
% not arguments of absolute proof of creation in time".
source(pius_xii_1951,3,truth,1951). papal_form(pius_xii_1951,ordinary). character(pius_xii_1951,address).
supports(pius_xii_1951,q(world_began),yes). rests_on_finding(pius_xii_1951,q(world_began),expansion_1929).
question(q(universe_expanding)). question_kind(q(universe_expanding),empirical). value(q(universe_expanding),(yes;no)).
finding(expansion_1929,q(universe_expanding),yes,1929).          % Lemaitre (1927), Hubble (1929)
question(q(age_of_universe)). question_kind(q(age_of_universe),empirical).
value(q(age_of_universe),(about_13_8_gyr;otherwise)).
finding(planck_2018,q(age_of_universe),about_13_8_gyr,2018).      % Planck 2018 results VI

#program method_being.            % "nothing but" from a finding by division (MB1; load with world)
question(q(bodies_of_cells)). question_kind(q(bodies_of_cells),empirical). value(q(bodies_of_cells),(yes;no)).
finding(cell_theory_1839,q(bodies_of_cells),yes,1839). method(cell_theory_1839,division).   % Schwann (1839)
% Vienne (1312, DH 902): "quod anima rationalis seu intellectiva non sit forma
% corporis humani per se et essentialiter, tamquam haereticus sit censendus".
source(vienne_1312,1,truth,1312). conciliar_act(vienne_1312,definition). form_of_the_body_given(vienne_1312).
nothing_but(claim_h,peter,cell_theory_1839). nothing_but(claim_l,lion,cell_theory_1839).
about_the_parts(claim_p,peter,cell_theory_1839).

#program twinning.                % HYPOTHETICAL: a monozygotic twinning (TW1)
twinning(e_z,tw_a,tw_b).
#program twin_tests.              % HYPOTHETICAL: the four outward tests and the Church's practice (TW2; load with twinning)
contrary_acts_at_once(tw_a,tw_b). died_while_other_lived(tw_a,tw_b). baptized_each(tw_a,tw_b). married_each(tw_a,tw_b).
#program cand_soul_divided.       % HYPOTHETICAL: the embryo's soul divided between the twins (TW3)
divides_the_soul(e_z).
#program cand_soul_from_twin.     % HYPOTHETICAL: a twin's soul given by the other twin (TW3)
created_person(tw_a;tw_b). being(tw_a,tw_b).
#program manner_hyp.              % HYPOTHETICAL: a tier-3 act on a doctrinal question, a tier-5 work against it, a contrary profession (MA; TTC-MANNER; load with assent)
question(q(mn)). question_kind(q(mn),doctrinal). value(q(mn),(yes;no)).
source(act_mn,3,truth,2026). dicastery(act_mn). character(act_mn,notification). supports(act_mn,q(mn),yes).
source(work_mn,5,truth,2020). supports(work_mn,q(mn),no).
professes(p_mn,e_mn,q(mn),no).
#program manner_whole.            % HYPOTHETICAL: the act says of itself that it settles nothing (MA2)
self_limited(act_mn).
#program manner_on_q.             % HYPOTHETICAL: the act says of itself that it settles nothing on q(mn) (MA3)
self_limits(act_mn,q(mn)).
#program manner_reaffirmed.       % HYPOTHETICAL: the act reaffirms an earlier tier-3 teaching of the same value (MA4)
source(enc_mn,3,truth,1990). character(enc_mn,encyclical). supports(enc_mn,q(mn),yes). reaffirms(act_mn,enc_mn).
#program manner_lowered_by_another. % HYPOTHETICAL: a later work says the act teaches at tier 5 (MA5)
source(gloss_mn,5,truth,2027). claims_tier(gloss_mn,act_mn,5).
#program manner_fact.             % HYPOTHETICAL: the act also holds a value on an empirical question (MA8; load with manner_hyp)
question(q(mn_fact)). question_kind(q(mn_fact),empirical). value(q(mn_fact),(yes;no)).
supports(act_mn,q(mn_fact),yes).
#program manner_def_hyp.          % HYPOTHETICAL: a defined truth, and a contrary profession (MA6, HG; TTC-MANNER)
question(q(mn_def)). question_kind(q(mn_def),doctrinal). value(q(mn_def),(yes;no)).
source(def_mn,1,truth,1900). hypothetical_warrant(def_mn). supports(def_mn,q(mn_def),yes).
professes(p_ht,e_ht,q(mn_def),no).
#program cand_limit_on_definition.   % HYPOTHETICAL: the definition entered as settling nothing (MA6)
self_limited(def_mn).
#program cand_limit_on_definition_q. % HYPOTHETICAL: the definition entered as settling nothing on its question (MA7)
self_limits(def_mn,q(mn_def)).
#program cand_hierarchy_as_grade.    % HYPOTHETICAL: a work, and the definition's own author, grading the truth by its place in the hierarchy (HG1)
source(work_ht,5,truth,2020). ranks_lower(work_ht,q(mn_def)). ranks_lower(def_mn,q(mn_def)).
#program replies_hyp.             % HYPOTHETICAL: replies of two offices, one earlier against two later, and a teaching letter (RP; TTC-REPLIES)
question(q(rp_x)). question_kind(q(rp_x),juridical). value(q(rp_x),(yes;no)).
source(rp_a,3,juridical,2018). dicastery(rp_a). character(rp_a,letter). supports(rp_a,q(rp_x),no).
source(rp_b,3,juridical,2019). dicastery(rp_b). character(rp_b,letter). supports(rp_b,q(rp_x),yes).
source(rp_c,3,juridical,2023). dicastery(rp_c). character(rp_c,letter). supports(rp_c,q(rp_x),yes).
question(q(rp_d)). question_kind(q(rp_d),doctrinal). value(q(rp_d),(yes;no)).
source(rp_t,3,truth,2020). dicastery(rp_t). character(rp_t,letter). supports(rp_t,q(rp_d),yes).
#program replies_marked.          % HYPOTHETICAL: each entered as an answer given in a particular matter (RP2-RP4)
particular_reply(rp_a). particular_reply(rp_b). particular_reply(rp_c). particular_reply(rp_t).
#program replies_specific.        % HYPOTHETICAL: the 2023 reply approved in forma specifica (RP3)
in_forma_specifica(rp_c).

% ---------- The four causes: property and its modernities (TTC-MODERNITY) -----
% Real texts. An argument is typed as what it says, which no tongue owns, and
% every typing is an interpretive fact, entered and open to dispute
% (docs/research/modernity-sources.md, modernity-hearers.md). Authority
% reads no argument: the sources hold their values by form (rule 14).
#program modernity_property.      % Rerum novarum (15 May 1891) on property, with Thomas and his readers (TTC-MODERNITY)
% Property by nature is two questions: RN's opponents granted property in products and denied it in
% land, and RN argues "non modo terrenorum fructuum, sed ipsius terrae dominatum" (RN 7).
question(q(property_in_products)). question_kind(q(property_in_products),doctrinal).
value(q(property_in_products),(natural;positive_addition)).
question(q(property_in_land)). question_kind(q(property_in_land),doctrinal).
value(q(property_in_land),(natural;positive_addition)).
question(q(use_common)). question_kind(q(use_common),doctrinal). value(q(use_common),(yes;no)).
question(q(ip_absolute)). question_kind(q(ip_absolute),doctrinal). value(q(ip_absolute),(yes;no)).
% The sources, each at its tier by form.
source(rn_1891,3,truth,1891). papal_form(rn_1891,ordinary). character(rn_1891,encyclical).
supports(rn_1891,(q(property_in_products);q(property_in_land)),natural). supports(rn_1891,q(use_common),yes).
source(th57,5,truth,1271). promoted(th57,4,1567).    % ST II-II q. 57 a. 3: the field, as to its cultivation
supports(th57,q(property_in_land),natural).
source(th66,5,truth,1271). promoted(th66,4,1567).    % ST II-II q. 66 aa. 1-2: use common, division "superadded"
supports(th66,q(use_common),yes).
source(gs69,3,truth,1965). conciliar(gs69). character(gs69,conciliar_constitution). supports(gs69,q(use_common),yes).
source(ca30,3,truth,1991). papal_form(ca30,ordinary). character(ca30,encyclical). supports(ca30,q(use_common),yes).
source(ccc2403,3,truth,1992). character(ccc2403,catechism). supports(ccc2403,q(use_common),yes).
source(civ22,3,truth,2009). papal_form(civ22,ordinary). character(civ22,encyclical). supports(civ22,q(ip_absolute),no).
source(suarez_dl,5,truth,1612).    % De legibus II.14: division by agreement, after Scotus
source(grotius_dibp,5,truth,1625). % DIBP II.2.2
source(hobbes_l24,5,truth,1651).   % Lev. 24: propriety the effect of the commonwealth
supports((suarez_dl;grotius_dibp;hobbes_l24),(q(property_in_products);q(property_in_land)),positive_addition).
source(locke27,5,truth,1689). supports(locke27,q(property_in_products),natural).   % 2T §27: labour mixed
source(locke25,5,truth,1689). supports(locke25,q(use_common),yes).                 % 2T §25: given in common
% The arguments, each typed by the causes it rests on.
% RN 7: reason links "the future with the present"; provision for needs that recur.
argument(rn7_products,rn_1891,q(property_in_products),natural). argument(rn7_land,rn_1891,q(property_in_land),natural).
argues_from((rn7_products;rn7_land),final,human). argues_from((rn7_products;rn7_land),formal,human).
% RN 9, as its Latin divides it and as Hittinger reads it: "ad conservandam vitam maximeque ad
% perficiendam"; "velut formam quamdam personae suae impressam reliquit". Its premises on forms are
% linguae_rn9's; "ad conservandam vitam" rests on no form.
argument(rn9,rn_1891,q(property_in_land),natural).
argues_from(rn9,efficient,human). argues_from(rn9,material,nature). argues_from(rn9,formal,human).
argues_from(rn9,final,self). argues_from(rn9,final,human).
% RN 10: "effectae res caussam sequuntur a qua effectae sunt"; improvements "solo inhaerent miscenturque penitus".
argument(rn10_products,rn_1891,q(property_in_products),natural). argues_from(rn10_products,efficient,human).
argument(rn10_land,rn_1891,q(property_in_land),natural).
argues_from(rn10_land,efficient,human). argues_from(rn10_land,material,nature).
% RN 13: "Sanctissima naturae lex est", that the father provide for those he begot.
argument(rn13_products,rn_1891,q(property_in_products),natural). argument(rn13_land,rn_1891,q(property_in_land),natural).
argues_from((rn13_products;rn13_land),final,human).
% RN 8: the earth given in common, "partem nullam cuique assignavit"; RN 22: II-II q. 66 a. 2, quoted.
argument(rn8,rn_1891,q(use_common),yes). argues_from(rn8,final,god_ethics).
argument(rn22,rn_1891,q(use_common),yes). argues_from(rn22,final,human).
argument(th57,th57,q(property_in_land),natural). argues_from(th57,final,human).
argument(th66,th66,q(use_common),yes). argues_from(th66,final,nature). argues_from(th66,final,human).
argument(gs69,gs69,q(use_common),yes). argument(ccc2403,ccc2403,q(use_common),yes).
argument(ca30,ca30,q(use_common),yes). argues_from((gs69;ccc2403;ca30),final,god_ethics).
argument(civ22,civ22,q(ip_absolute),no). argues_from(civ22,final,human).
% The positive addition, by the will's act: Suarez, Grotius, Hobbes.
argument(suarez_dl_products,suarez_dl,q(property_in_products),positive_addition).
argument(suarez_dl_land,suarez_dl,q(property_in_land),positive_addition).
argument(grotius_dibp_products,grotius_dibp,q(property_in_products),positive_addition).
argument(grotius_dibp_land,grotius_dibp,q(property_in_land),positive_addition).
argument(hobbes_l24_products,hobbes_l24,q(property_in_products),positive_addition).
argument(hobbes_l24_land,hobbes_l24,q(property_in_land),positive_addition).
argues_from((suarez_dl_products;suarez_dl_land;grotius_dibp_products;grotius_dibp_land;
             hobbes_l24_products;hobbes_l24_land),efficient,will).
argument(locke27,locke27,q(property_in_products),natural).
argues_from(locke27,efficient,human). argues_from(locke27,final,self). argues_from(locke27,material,nature).
argument(locke25,locke25,q(use_common),yes). argues_from(locke25,final,god_ethics).
% Fortin's reading, a claim with its claimant: heard in the English of 1891 under Locke, RN 9 still
% concludes for land, as Locke's argument "almost textually" (TS 53, 1992, p. 214).
concludes_heard(rn9,lex_en_locke_1891,fortin_1992).
#program rn7_from_form.           % RN 7 from reason alone: reason links "the future with the present"
reading_of(rn7_products_form,rn7_products). reading_of(rn7_land_form,rn7_land).
argues_from((rn7_products_form;rn7_land_form),formal,human).
#program rn7_from_self.           % RN 7 from self-preservation: "ius ille suum ad vitam corpusque tuendum"
reading_of(rn7_products_self,rn7_products). reading_of(rn7_land_self,rn7_land).
argues_from((rn7_products_self;rn7_land_self),final,self).
#program rn7_under_providence.    % RN 7 under God's government: "sub lege aeterna, sub potestate omnia
reading_of(rn7_products_providence,rn7_products). reading_of(rn7_land_providence,rn7_land).   % providentissime gubernantis Dei"
argues_from((rn7_products_providence;rn7_land_providence),final,god_ethics).
#program rn13_as_command.         % RN 13 as the Maker's command, read as Locke reads the same duty (2T §§56, 63, 66)
reading_of(rn13_products_command,rn13_products). reading_of(rn13_land_command,rn13_land).
argues_from((rn13_products_command;rn13_land_command),final,god_ethics).
#program rn8_from_sustenance.     % RN 8 from the sustenance of all: "quoniam nemo est mortalium, quin alatur eo,
reading_of(rn8_sustenance,rn8).   % quod agri efferunt"
argues_from(rn8_sustenance,final,self).
#program rn22_as_stewardship.     % RN 22, the owner as steward: "velut minister providentiae divinae"
reading_of(rn22_stewardship,rn22).
argues_from(rn22_stewardship,final,god_ethics).
#program modernity_measure.       % Henry Adams, The Education XXV: the Virgin draws, as an end does, and "both
measures_as(adams_1907,final,efficient).   % energies acted as interchangeable force on man"
% The hearings (TTC-MODERNITY HE): the run's own horizon, or the VM's guest
% where one is loaded, hears in a tongue of linguae_rn9, by its lexicon.
% vatican.va's English stands in for the English of 1891.
#program hear_la_1891.            % the Latin, promulgated
hears_in(H,la_1891,lex_la_1891) :- hearer(H).
#program hear_en_1891_locke.      % the English of 1891, "personality" the forensic self (Essay II.xxvii.26)
hears_in(H,en_1891,lex_en_locke_1891) :- hearer(H).
#program hear_en_1891_schol.      % the English of 1891, "personality" the scholastic personalitas
hears_in(H,en_1891,lex_en_schol_1891) :- hearer(H).
#program hear_en_2026.            % the English of 2026
hears_in(H,en_2026,lex_en_2026) :- hearer(H).
#program hearers_tongues.         % Leo's hearers in their tongues: George replies in English, and restates RN 9-10
hears_in(here,en_1891,lex_en_locke_1891) :- figure(george).   % as "Industry expended on land gives ownership in
hears_in(here,la_1891,lex_la_1891)       :- figure(episcopate_1891).   % the land itself"; the bishops read the Latin

% ---------- Substitution, and the icon against the idol (TTC-LOCI) -----------
% Real texts. Every substitution and every honour is a reading with its
% claimant, of a text, an order or a sign, never of a person (rule 3); the
% deposit's rules decide (docs/research/loci-sources.md, modernity-mammon.md).
#program loci_spinoza.            % Spinoza, Ethica (1677): "Praeter Deum nulla dari neque concipi potest substantia" (I p14);
% "In rerum natura nullum datur contingens" (I p29); "Res nullo alio modo, neque alio ordine a Deo produci
% potuerunt, quam productae sunt" (I p33); "God or Nature" (IV Praef.). Two readings, a disputed reading of the
% text: both run. On either, what is not God is a creature (Dei Filius, DH 3001): typed here as what merely
% is, the kernel's sorts being grades and the whole of nature none of them.
source(ethica_1677,5,truth,1677). ambiguous(ethica_1677). reading(ethica_1677,(pantheist;naturans)).
inanimate(natura).                % Nature, "Deus, seu Natura"
inanimate(natura_naturata).       % "id omne quod ex necessitate Dei naturae ... sequitur" (I p29 schol.)
% A, the pantheist (Jacobi, Ueber die Lehre des Spinoza, 1785; Borge 2025): God is Nature, naturata included.
% Nature is put in God's place as the giver of being, and held necessary.
substitutes((jacobi_1785;borge_2025),ethica_1677,natura,god,giver_of_being) :- read_as(ethica_1677,pantheist).
necessitates((jacobi_1785;borge_2025),ethica_1677,natura) :- read_as(ethica_1677,pantheist).
% B (Nadler 2002): God is natura naturans, and what follows from him, natura naturata, is held necessary
% (I p29, p33). Nothing is put in God's place; free creation is still denied.
necessitates(nadler_2002,ethica_1677,natura_naturata) :- read_as(ethica_1677,naturans).
#program loci_mammon.             % McCarraher, The Enchantments of Mammon (2019): money "occupies the ontological throne
% from which God has been evicted". Thomas makes avarice like idolatry by a likeness, the covetous man
% subjecting himself to a creature "for use, not for worship" (II-II q. 118 a. 5 ad 4; I-II q. 2 a. 1): so
% money enters as the last end, not as latria.
substitutes(mccarraher_2019,capitalist_order,money,god,last_end).
#program loci_icon.               % Nicaea II, the horos (787; ACO II.3, pp. 826-827; DH 601): to images "honoratoriam ...
% adorationem", "non tamen ... ueram latrian"; "imaginis enim honor ad primitiuum transit". Thomas, ST III q. 25
% a. 3: the image of Christ adored "adoratione latriae", since "motus qui est in imaginem inquantum est imago,
% est unus et idem cum illo qui est in rem"; as a thing, "nulla reverentia". "Relative latria" is the
% Thomists' term, not his, and their reading enters with them as claimant.
divine(christ).
honour(image_of_christ,christ,veneration,nicaea_ii).
honour(image_of_christ,christ,latria,thomists).
honour(image_of_a_saint,a_saint,dulia,aquinas).   % II-II q. 84 a. 1 ad 1: "quod pertinet ad duliam"
honour(idol,idol,latria,aquinas).                 % II-II q. 94 a. 1: divine worship to any creature, "superstitiosum est"
#program loci_adams.              % The Education of Henry Adams XXV (1907): "he began to feel the forty-foot dynamos as a
% moral force, much as the early Christians felt the Cross"; "Before the end, one began to pray to it". Adams's own
% reading is the measure (modernity_measure). McCarraher's: the dynamo "an occult mechanism, a graven image of
% capitalist modernity" (The Enchantments of Mammon, p. 179, as Nichols quotes it).
honour(dynamo,dynamo,latria,mccarraher_2019).
#program cand_substitution_person.   % HYPOTHETICAL: a substitution, a necessity and an honour entered of a person (SB5)
created_person(a_reader). inanimate(natura).
substitutes(x_claimant,a_reader,money,god,last_end).
necessitates(x_claimant,a_reader,natura).
honour(a_reader,a_reader,latria,x_claimant).

% ---------- domains (L) ---------------------------------------------
#program base.
in_sort(sacrament,(baptism;confirmation;eucharist;penance;anointing;orders(episcopate);orders(presbyterate);orders(diaconate);matrimony)).
violation(outside_domain(condition_in_question,1,K)) :- condition_in_question(K,_), not in_sort(sacrament,K).
violation(outside_domain(teaching_tier,2,K)) :- teaching_tier(_,K), not in_sort(tier,K).
