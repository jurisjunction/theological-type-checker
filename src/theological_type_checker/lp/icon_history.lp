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
source(sollicitudo_1661,3,truth,1661).  supports(sollicitudo_1661,q(ic),yes).   % Alexander VII
character(sollicitudo_1661,constitution).
source(ineffabilis_1854,1,truth,1854).  supports(ineffabilis_1854,q(ic),yes).   % Pius IX
papal_form(grave_nimis,legislative). papal_form(sollicitudo_1661,ordinary).
papal_form(ineffabilis_1854,ex_cathedra).

#program ic_unprotected.          % ablation: remove both protective acts
relaxed(grave_nimis). relaxed(trent_1546).

#program asof_1400. asof(1400). custom_asof.
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
source(lg25,1,truth,1964).  meta_supports(lg25,t2_truth).  interpretive(lg25,t2_truth).  % extent left open (Gasser)
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
god(god). bridegroom(christ). incarnate(christ). created_person(infant).
question(q(infant_state)).  question_kind(q(infant_state),doctrinal).
value(q(infant_state),original_sin_alone). value(q(infant_state),held_in_trust).
question(q(infant_fate)).   question_kind(q(infant_fate),doctrinal).
value(q(infant_fate),poena_sensus). value(q(infant_fate),limbo). value(q(infant_fate),beatific).
% modelling link: a welcome held in trust (as at baptism) admits the infant to the bond
held_for(god_supplies,infant,christ) :- holds(q(infant_state),held_in_trust).
:- holds(q(infant_state),held_in_trust), not holds(q(infant_fate),beatific).
% Florence, Laetentur caeli (DH 1306), tier 1: those who die in original sin
% alone do not attain the beatific vision. Its content, as a hard constraint:
source(florence_1439,1,truth,1439).
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
god(god). bridegroom(christ). incarnate(christ).
created_person(receiver). created_person(refuser).
consent(receiver,christ).

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
% internal forum: is the norm on admission teaching or governance? Left open.
question(q(admission_internal)).
value(q(admission_internal),only_if_continent). value(q(admission_internal),possible_in_some_cases).
1 { question_kind(q(admission_internal),doctrinal) ; question_kind(q(admission_internal),governance) } 1.
source(fc84,3,truth,1981). papal_form(fc84,ordinary).
supports(fc84,q(admission_internal),only_if_continent). oum_claim(fc84,2).   % claimed by critics
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
source(trent_1551,1,truth,1551).
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
info(offense(X,dissent_c752,T)) :- refuses(X,T), teaching_tier(T,3).
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

#program a9_universal.            % the old reading of A9, for comparison
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
source(def_t2,1,truth,2030). meta_supports(def_t2,t2_truth).
