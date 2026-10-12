% ===================================================================
%  Authority data: historical backtests and worked cases.
%  Tiers are assigned as of the evaluation date (promoted/3 records
%  when a theologian was declared a Doctor), so a backtest "as of 1600"
%  sees only what existed then, with the standing it had then.
% ===================================================================

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
#program tier2.
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
% The monarchy is a separate question; both sides affirm it.
question(q(monarchy)). question_kind(q(monarchy),doctrinal).
value(q(monarchy),father_principle_without_principle). value(q(monarchy),denied).
source(florence_1442,1,truth,1442). supports(florence_1442,q(monarchy),father_principle_without_principle).  % DH 1331
conciliar_act(florence_1442,creed).   % Cantate Domino: "firmiter credit, profitetur et praedicat"
source(pcpcu_1995,3,truth,1995). character(pcpcu_1995,commentary).
supports(pcpcu_1995,q(monarchy),father_principle_without_principle).   % L'Osservatore Romano, 20 Sept 1995
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

#program hypothetical_definition. % what a tier-1 act would settle
source(def_t2,1,truth,2030). meta_supports(def_t2,t2_truth). hypothetical_warrant(def_t2).

% ---------- The creeds and the word of God (TTC-CREED) ------------------
#program creeds.                  % tier 1, as the Church professes them
source(apostles_creed,1,truth,700).   % textus receptus (DH 30); the Old Roman Creed is older
source(nicene_creed,1,truth,381).     % Constantinople I (DH 150): "proceeds from the Father"
source(quicumque,1,truth,500).        % DH 75-76, 5th-6th c.; tier 1 by the Church's reception
source(lateran_iv_1215,1,truth,1215). % Firmiter (DH 800-802)
received_creed(apostles_creed). received_creed(quicumque).   % reception: a claim without a date (rule 14; roadmap)
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
% "this declaration and definition"; binding all the faithful. The pastor of all
% and apostolic authority are not shown without DH 2010-2012 (rule 14): tier 3,
% its own word a claim.
source(ad_sanctam_1656,3,truth,1656). papal_form(ad_sanctam_1656,ordinary). character(ad_sanctam_1656,constitution).
claims_tier(ad_sanctam_1656,ad_sanctam_1656,2).
#program ad_sanctam_defined.      % HYPOTHETICAL until DH 2010-2012 is read: the five conditions shown; a dogmatic fact defined
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
condition_shown(dh795,(dispersed_in_communion;authentic_teaching;faith_or_morals;one_position_definitive)).

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
