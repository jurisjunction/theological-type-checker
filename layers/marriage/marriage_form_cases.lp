% HYPOTHETICAL: the form, Latin and Eastern, valid and invalid, licit and not.
% Loaded with marriage_consent_cases.lp (today, pr_x delegated, pr_e Eastern).
% Ora pro me, peccatore.
priest(pr_orth). baptized_in(pr_orth,greek_orthodox).            % an Orthodox priest, no Catholic delegation
deacon(dcn_x). baptized_in(dcn_x,catholic). delegation(dl_dcn,ord_x,dcn_x,general,20000101).

% lack of form, Latin: before a layman; before a delegated deacon (valid for Latins)
marriage(mf_lay,layman_l,20100601). spouse(mf_lay,(u1;u2)). baptized_in((u1;u2),catholic). ground_at_issue(mf_lay,lack_of_form).
marriage(mf_dcn,dcn_x,20100602). spouse(mf_dcn,(u3;u4)). baptized_in((u3;u4),catholic). witnesses_present(mf_dcn,2). ground_at_issue(mf_dcn,lack_of_form).
% lack of form, Eastern Catholic before a delegated deacon: no priest, no blessing (CCEO c. 828; c. 1108 §3)
marriage(mf_dcn_e,dcn_x,20100603). spouse(mf_dcn_e,(u5;u6)). baptized_in((u5;u6),catholic). ascribed(u5,ukrainian). ground_at_issue(mf_dcn_e,lack_of_form).
% Latin marrying Eastern Catholic before a delegated deacon: in 2010 the Eastern party's code already required a priest (CCEO c. 828); from 2016 the Latin code says so too (c. 1108 §3)
marriage(mf_mix_2010,dcn_x,20100604). spouse(mf_mix_2010,(u7;u8)). baptized_in((u7;u8),catholic). ascribed(u8,ukrainian). ground_at_issue(mf_mix_2010,lack_of_form).
marriage(mf_mix_2017,dcn_x,20170604). spouse(mf_mix_2017,(u9;u10)). baptized_in((u9;u10),catholic). ascribed(u10,ukrainian). ground_at_issue(mf_mix_2017,lack_of_form).

% form for liceity only: a Latin Catholic marries an Assyrian before an Orthodox priest, no permission
marriage(mf_assyr,pr_orth,20150601). spouse(mf_assyr,(u11;u12)). baptized_in(u11,catholic). baptized_in(u12,assyrian_church_of_the_east).
ground_at_issue(mf_assyr,lack_of_form).
% the same with the permission of c. 1124 and the Catholic form kept (a delegated priest): licit
marriage(mf_greek_ok,pr_x,20150602). spouse(mf_greek_ok,(u13;u14)). baptized_in(u13,catholic). baptized_in(u14,greek_orthodox).
permission_for_mixed_marriage(mf_greek_ok,ord_x,20150501). catholic_form_observed(mf_greek_ok). ground_at_issue(mf_greek_ok,lack_of_form).
% an Eastern Catholic marries a Copt before a Coptic priest, 2015, no permission: valid, illicit (CCEO c. 834 §2; c. 813)
priest(pr_copt). baptized_in(pr_copt,coptic_orthodox).
marriage(mf_copt_e,pr_copt,20150603). spouse(mf_copt_e,(u15;u16)). baptized_in(u15,catholic). ascribed(u15,ukrainian). baptized_in(u16,coptic_orthodox).
ground_at_issue(mf_copt_e,lack_of_form).
% a Latin Catholic marries a Lutheran before a Lutheran pastor, no dispensation from form: invalid (c. 1127 §1 reaches Eastern non-Catholics only)
marriage(mf_luth,pastor_l,20150604). spouse(mf_luth,(u17;u18)). baptized_in(u17,catholic). baptized_in(u18,lutheran). ground_at_issue(mf_luth,lack_of_form).
% the same, with the form dispensed by the ordinary (c. 1127 §2): valid
marriage(mf_luth_d,pastor_l,20150605). spouse(mf_luth_d,(u19;u20)). baptized_in(u19,catholic). baptized_in(u20,lutheran).
dispensation(dsp_lf,cond(matrimony,canonical_form),mf_luth_d). issuer(dsp_lf,ord_x). permission_for_mixed_marriage(mf_luth_d,ord_x,20150501). ground_at_issue(mf_luth_d,lack_of_form).

% the extraordinary form: witnesses only, a month foreseen, Latin and Eastern
marriage(mf_extra,nobody,20200601). spouse(mf_extra,(u21;u22)). baptized_in((u21;u22),catholic). assistant_unavailable(mf_extra,foreseen_month). witnesses_present(mf_extra,2).
ground_at_issue(mf_extra,lack_of_form).
marriage(mf_extra_e,nobody,20200602). spouse(mf_extra_e,(u23;u24)). baptized_in((u23;u24),catholic). ascribed(u23,ukrainian). assistant_unavailable(mf_extra_e,danger_of_death). witnesses_present(mf_extra_e,2).
ground_at_issue(mf_extra_e,lack_of_form).
marriage(mf_extra_1w,nobody,20200603). spouse(mf_extra_1w,(u25;u26)). baptized_in((u25;u26),catholic). assistant_unavailable(mf_extra_1w,foreseen_month). witnesses_present(mf_extra_1w,1).
ground_at_issue(mf_extra_1w,lack_of_form).
