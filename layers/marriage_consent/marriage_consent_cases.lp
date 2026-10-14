% HYPOTHETICAL: one marriage per ground, each claim supplied, none derived.
% All parties and places are invented. Dates after 27 November 1983 unless the
% test is about the date. Ora pro me, peccatore.
today(20261014).
% one assisting priest, delegated generally since 1960, so the form holds and only consent is at issue
priest(pr_x). ordinary(ord_x). delegation(dl_x,ord_x,pr_x,general,19600101).

% c. 1095 1°-3°
marriage(mc_1095_1,pr_x,20010601). spouse(mc_1095_1,(a1;b1)). interior(a1,mc_1095_1,reason(lacking)).
ground_at_issue(mc_1095_1,n1095_1).
marriage(mc_1095_2,pr_x,20020601). spouse(mc_1095_2,(a2;b2)). interior(a2,mc_1095_2,discretion(grave_defect)).
ground_at_issue(mc_1095_2,n1095_2).
marriage(mc_1095_3,pr_x,20030601). spouse(mc_1095_3,(a3;b3)). interior(b3,mc_1095_3,incapacity(assume_obligations,psychic)).
ground_at_issue(mc_1095_3,n1095_3). ground_at_issue(mc_1095_3,n1095_2).     % 2° formulated too, with nothing under it: bare

% c. 1096
marriage(mc_1096,pr_x,20040601). spouse(mc_1096,(a4;b4)). interior(a4,mc_1096,ignorance(fact(nature_of_marriage),invincible)).
ground_at_issue(mc_1096,n1096).

% c. 1097 §1, §2 (intended), §2 (merely causam dans: nothing)
marriage(mc_1097_1,pr_x,20050601). spouse(mc_1097_1,(a5;b5)). interior(a5,mc_1097_1,error_of(person)).
ground_at_issue(mc_1097_1,n1097_1).
marriage(mc_1097_2,pr_x,20060601). spouse(mc_1097_2,(a6;b6)). interior(a6,mc_1097_2,error_of(quality(fertility))). intended(a6,mc_1097_2,quality(fertility)).
ground_at_issue(mc_1097_2,n1097_2).
marriage(mc_1097_cd,pr_x,20070601). spouse(mc_1097_cd,(a7;b7)). interior(a7,mc_1097_cd,error_of(quality(wealth))).
ground_at_issue(mc_1097_cd,n1097_2).

% c. 1098: after 1983, settled; before 1983, the reading branches; gravity disputed
marriage(mc_1098,pr_x,20080601). spouse(mc_1098,(a8;b8)).
deceit(d8,b8,a8,mc_1098,quality(prior_marriage)). interior(b8,d8,to_obtain_consent). quality_gravely_disturbs(prior_marriage).
ground_at_issue(mc_1098,n1098).
marriage(mc_1098_old,pr_x,19790601). spouse(mc_1098_old,(a9;b9)).
deceit(d9,b9,a9,mc_1098_old,quality(sterility)). interior(b9,d9,to_obtain_consent). quality_gravely_disturbs(sterility).
ground_at_issue(mc_1098_old,n1098).
marriage(mc_1098_q,pr_x,20090601). spouse(mc_1098_q,(a10;b10)).
deceit(d10,b10,a10,mc_1098_q,quality(debts)). interior(b10,d10,to_obtain_consent). disputed(quality_gravely_disturbs(debts)).
ground_at_issue(mc_1098_q,n1098).

% c. 1101 §2, five species; and a marriage with no exclusion: consent presumed
marriage(mc_1101_t,pr_x,20100601). spouse(mc_1101_t,(a11;b11)). interior(a11,mc_1101_t,positive_will(excludes(matrimony))).
ground_at_issue(mc_1101_t,n1101_total).
marriage(mc_1101_p,pr_x,20110601). spouse(mc_1101_p,(a12;b12)). interior(b12,mc_1101_p,positive_will(excludes(bonum_prolis))).
ground_at_issue(mc_1101_p,n1101_prolis).
marriage(mc_1101_f,pr_x,20120601). spouse(mc_1101_f,(a13;b13)). interior(a13,mc_1101_f,positive_will(excludes(bonum_fidei))).
ground_at_issue(mc_1101_f,n1101_fidei).
marriage(mc_1101_s,pr_x,20130601). spouse(mc_1101_s,(a14;b14)). interior(a14,mc_1101_s,positive_will(excludes(bonum_sacramenti))).
ground_at_issue(mc_1101_s,n1101_sacramenti).
marriage(mc_1101_c,pr_x,20140601). spouse(mc_1101_c,(a15;b15)). interior(b15,mc_1101_c,positive_will(excludes(bonum_coniugum))).
ground_at_issue(mc_1101_c,n1101_coniugum).
marriage(mc_plain,pr_x,20150601). spouse(mc_plain,(a16;b16)).
ground_at_issue(mc_plain,n1101_total).                                      % formulated, bare

% c. 1102: future (1983 law), past unfulfilled, present fulfilled, present disputed
marriage(mc_1102_fut,pr_x,20160601). spouse(mc_1102_fut,(a17;b17)). condition(c17,mc_1102_fut,a17,future).
ground_at_issue(mc_1102_fut,n1102_1).
marriage(mc_1102_fut_old,pr_x,19700601). spouse(mc_1102_fut_old,(a18;b18)). condition(c18,mc_1102_fut_old,a18,future).
ground_at_issue(mc_1102_fut_old,n1102_1).                                  % before 1983: the 1983 rule is silent
marriage(mc_1102_past,pr_x,20170601). spouse(mc_1102_past,(a19;b19)). condition(c19,mc_1102_past,a19,past).
ground_at_issue(mc_1102_past,n1102_2).                                     % not fulfilled: nothing entered
marriage(mc_1102_pres,pr_x,20180601). spouse(mc_1102_pres,(a20;b20)). condition(c20,mc_1102_pres,a20,present). fulfilled(c20).
ground_at_issue(mc_1102_pres,n1102_2).
marriage(mc_1102_disp,pr_x,20190601). spouse(mc_1102_disp,(a21;b21)). condition(c21,mc_1102_disp,a21,present). disputed(fulfilled(c21)).
ground_at_issue(mc_1102_disp,n1102_2).

% c. 1103, with the claim disputed by the other party's deposition
marriage(mc_1103,pr_x,20200601). spouse(mc_1103,(a22;b22)).
disputed(interior(a22,mc_1103,fear(grave,extrinsic,unjust))). interior(a22,mc_1103,escape_choice).
ground_at_issue(mc_1103,n1103).
