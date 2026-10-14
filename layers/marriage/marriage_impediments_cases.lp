% HYPOTHETICAL: one marriage per impediment, Latin and Eastern, invented
% persons. Loaded with marriage_consent_cases.lp (today, the priests).
% Ora pro me, peccatore.

% ---------- age (c. 1083; CCEO c. 800) ----------
marriage(mi_age,pr_x,20100601). spouse(mi_age,(i1;i2)). sex(i1,male). sex(i2,female). born(i1,19950601). born(i2,19900101).
ground_at_issue(mi_age,impediment(age)).                       % the man is 15 on the day (c. 203: not yet 16)
marriage(mi_age_ok,pr_x,20100601). spouse(mi_age_ok,(i3;i4)). sex(i3,male). sex(i4,female). born(i3,19940531). born(i4,19960531).
ground_at_issue(mi_age_ok,impediment(age)).                    % 16 and 14 on the day: not impeded

% ---------- impotence (c. 1084): certain, disputed, sterility ----------
marriage(mi_imp,pr_x,20110601). spouse(mi_imp,(i5;i6)). impotence(i5,antecedent_perpetual). ground_at_issue(mi_imp,impediment(impotence)).
marriage(mi_imp_d,pr_x,20120601). spouse(mi_imp_d,(i7;i8)). disputed(impotence(i7,antecedent_perpetual)). ground_at_issue(mi_imp_d,impediment(impotence)).
marriage(mi_ster,pr_x,20130601). spouse(mi_ster,(i9;i10)). sterility(i9). ground_at_issue(mi_ster,impediment(impotence)).
% a dispensation from impotence is a violation (divine law)
dispensation(dsp_imp,cond(matrimony,impediment(impotence)),mi_imp). issuer(dsp_imp,ord_x). authority(ord_x,1).

% ---------- prior bond (c. 1085) ----------
marriage(mi_first,pr_x,19950601). spouse(mi_first,(i11;i12)).                                  % valid, standing
marriage(mi_second,pr_x,20050601). spouse(mi_second,(i11;i13)). ground_at_issue(mi_second,impediment(prior_bond)).
marriage(mi_first_w,pr_x,19950602). spouse(mi_first_w,(i14;i15)). death(i15,20000101).         % widowed before
marriage(mi_second_w,pr_x,20050602). spouse(mi_second_w,(i14;i16)). ground_at_issue(mi_second_w,impediment(prior_bond)).
marriage(mi_first_n,pr_u,19950603). spouse(mi_first_n,(i17;i18)).                              % no delegation: null for form
marriage(mi_second_n,pr_x,20050603). spouse(mi_second_n,(i17;i19)). ground_at_issue(mi_second_n,impediment(prior_bond)).  % §2: not yet established

% ---------- disparity of cult (c. 1086), dispensed and not ----------
marriage(mi_disp,pr_x,20140601). spouse(mi_disp,(i20;i21)). baptized_in(i20,catholic). unbaptized(i21). ground_at_issue(mi_disp,impediment(disparity_of_cult)).
marriage(mi_disp_ok,pr_x,20140602). spouse(mi_disp_ok,(i22;i23)). baptized_in(i22,catholic). unbaptized(i23). ground_at_issue(mi_disp_ok,impediment(disparity_of_cult)).
dispensation(dsp_disp,cond(matrimony,impediment(disparity_of_cult)),mi_disp_ok). issuer(dsp_disp,ord_x).

% ---------- orders and vow (cc. 1087, 1088): reserved; an ordinary cannot ----------
marriage(mi_ord,pr_x,20150601). spouse(mi_ord,(i24;i25)). cleric(i24). ground_at_issue(mi_ord,impediment(sacred_orders)).
dispensation(dsp_ord,cond(matrimony,impediment(sacred_orders)),mi_ord). issuer(dsp_ord,ord_x).
marriage(mi_vow,pr_x,20150602). spouse(mi_vow,(i26;i27)). vow(i26,public,perpetual,inst_p,20000101). pontifical(inst_p). ground_at_issue(mi_vow,impediment(public_vow)).
dispensation(dsp_vow,cond(matrimony,impediment(public_vow)),mi_vow). issuer(dsp_vow,dicastery_d). authority(dicastery_d,3).

% ---------- abduction (c. 1089) ----------
marriage(mi_abd,pr_x,20160601). spouse(mi_abd,(i28;i29)). abducted(i29,mi_abd). ground_at_issue(mi_abd,impediment(abduction)).
marriage(mi_abd_ok,pr_x,20160602). spouse(mi_abd_ok,(i30;i31)). abducted(i31,mi_abd_ok). released_before_consent(i31,mi_abd_ok). ground_at_issue(mi_abd_ok,impediment(abduction)).

% ---------- crime (c. 1090 §1): the purpose claimed ----------
marriage(mi_v,pr_x,19900601). spouse(mi_v,(i32;i33)).
killing(k1,i34,i33,20000101). interior(i34,k1,to_marry(i32)).
marriage(mi_crime,pr_x,20010601). spouse(mi_crime,(i32;i34)). ground_at_issue(mi_crime,impediment(crime)).

% ---------- consanguinity (c. 1091): first cousins (collateral 4), siblings (2), uncle-niece (3) ----------
father(c_a,c_g). father(c_b,c_g). father(c_x,c_a). father(c_y,c_b).         % c_x and c_y: first cousins
marriage(mi_cous,pr_x,20170601). spouse(mi_cous,(c_x;c_y)). ground_at_issue(mi_cous,impediment(consanguinity(collateral,4))).
dispensation(dsp_cous,cond(matrimony,impediment(consanguinity(collateral,4))),mi_cous). issuer(dsp_cous,ord_x).
marriage(mi_sib,pr_x,20170602). spouse(mi_sib,(c_a;c_b)). ground_at_issue(mi_sib,impediment(consanguinity(collateral,2))).
dispensation(dsp_sib,cond(matrimony,impediment(consanguinity(collateral,2))),mi_sib). issuer(dsp_sib,dicastery_d).   % never
father(c_x2,c_a).
marriage(mi_unc,pr_x,20170603). spouse(mi_unc,(c_b;c_x2)). ground_at_issue(mi_unc,impediment(consanguinity(collateral,3))).
father(c_z,c_w). father(c_w2,c_z). father(c_w3,c_w2). father(c_w4,c_w3).     % c_w and c_w4: fifth cousins? no: direct line, 4 generations
marriage(mi_far,pr_x,20170604). spouse(mi_far,(c_w;c_w4)). ground_at_issue(mi_far,impediment(consanguinity(direct,4))).

% ---------- affinity (c. 1092 vs CCEO c. 809) ----------
marriage(mi_aff0,pr_x,19900601). spouse(mi_aff0,(f_h;f_w)). father(f_w,f_wf). father(f_ws,f_wf).   % f_h married f_w; f_w's father f_wf and sister f_ws
death(f_w,20000101).
marriage(mi_aff_dir,pr_x,20050601). spouse(mi_aff_dir,(f_h;f_wf)). ground_at_issue(mi_aff_dir,impediment(affinity(direct,1))).          % widower and father-in-law: direct, both codes
marriage(mi_aff0b,pr_x,19900602). spouse(mi_aff0b,(f_h2;f_w2)). father(f_w2,f_wf2). father(f_ws2,f_wf2). death(f_w2,20000101).
marriage(mi_aff_col,pr_x,20050602). spouse(mi_aff_col,(f_h2;f_ws2)). ground_at_issue(mi_aff_col,impediment(affinity(collateral,2))).    % widower and sister-in-law: Latin no, Eastern yes
marriage(mi_aff0_e,pr_e,19950601). spouse(mi_aff0_e,(g_h;g_w)). baptized_in((g_h;g_w;g_ws),catholic). ascribed(g_h,ukrainian). father(g_w,g_wf). father(g_ws,g_wf).
death(g_w,20000101).
marriage(mi_aff_col_e,pr_e,20050603). spouse(mi_aff_col_e,(g_h;g_ws)). ground_at_issue(mi_aff_col_e,impediment(affinity(collateral,2))).

% ---------- public propriety (c. 1093) ----------
concubinage(p_m,p_w). father(p_wd,p_w).
marriage(mi_prop,pr_x,20180601). spouse(mi_prop,(p_m;p_wd)). ground_at_issue(mi_prop,impediment(public_propriety)).

% ---------- adoption (c. 1094) ----------
adopted(a_c,a_p). father(a_s,a_p).                                         % a_c adopted by a_p; a_s is a_p's natural child
marriage(mi_adop,pr_x,20190601). spouse(mi_adop,(a_c;a_s)). ground_at_issue(mi_adop,impediment(adoption(collateral,2))).
adopted(a_c2,a_p2).
marriage(mi_adop_d,pr_x,20190602). spouse(mi_adop_d,(a_c2;a_p2)). ground_at_issue(mi_adop_d,impediment(adoption(direct,1))).

% ---------- spiritual relationship (CCEO c. 811; none in the Latin Code) ----------
sponsor_at_baptism(s_g,s_c). father(s_c,s_f).
marriage(mi_spir_lat,pr_x,20200601). spouse(mi_spir_lat,(s_g;s_f)). ground_at_issue(mi_spir_lat,impediment(spiritual_relationship)).
sponsor_at_baptism(t_g,t_c). father(t_c,t_f). baptized_in((t_g;t_f),catholic). ascribed(t_g,ukrainian).
marriage(mi_spir_e,pr_e,20200602). spouse(mi_spir_e,(t_g;t_f)). ground_at_issue(mi_spir_e,impediment(spiritual_relationship)).

% ---------- crime §2 (cooperation) and public propriety from an invalid marriage with common life ----------
marriage(mi_v2,pr_x,19900603). spouse(mi_v2,(i40;i41)).
killing(k2,i42,i41,20000102). cooperated_in(i40,k2). cooperated_in(i42,k2).
marriage(mi_crime2,pr_x,20010602). spouse(mi_crime2,(i40;i42)). ground_at_issue(mi_crime2,impediment(crime)).
marriage(mi_inv,pr_u,20000601). spouse(mi_inv,(q_m;q_w)). common_life(mi_inv). father(q_wd,q_w).     % no delegation: invalid, lived together
marriage(mi_prop2,pr_x,20180602). spouse(mi_prop2,(q_m;q_wd)). ground_at_issue(mi_prop2,impediment(public_propriety)).

% ---------- the theology side: are the near degrees of consanguinity of divine law? ----------
% Left open on purpose. Thomas (Suppl. q. 54 a. 3) reads the first degree of the
% direct line as against natural law and the other degrees as of positive law,
% which the Church determines; the common opinion since holds the second
% collateral degree also of natural law. No act of tier 1 to 3 decides it; the
% Church's practice of never dispensing (c. 1078 §3) is law, and law never
% answers a doctrinal question (rule 1). A reported dispensation of siblings,
% if ever given, would be a juridical act at its own tier and would not settle
% it either way.
question(q(sibling_impediment_divine_law)). question_kind(q(sibling_impediment_divine_law),doctrinal).
value(q(sibling_impediment_divine_law),(yes;no)).
source(thomas_suppl_54_3,5,truth,1272). promoted(thomas_suppl_54_3,4,1567).
ambiguous(thomas_suppl_54_3).
reading(thomas_suppl_54_3,first_degree_only). reads(thomas_suppl_54_3,first_degree_only,q(sibling_impediment_divine_law),no).
reading(thomas_suppl_54_3,near_degrees_too).  reads(thomas_suppl_54_3,near_degrees_too,q(sibling_impediment_divine_law),yes).
