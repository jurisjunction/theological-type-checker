% ===================================================================
%  The form of marriage: what the base leaves to a layer (TTC-SOURCES TX,
%  TTC-CCEO). The base computes validity: c. 1108 with c. 1111, c. 1117,
%  c. 1127 §1, c. 1108 §3 (2016), CIC 1917 cc. 1094 and 1099, CCEO cc. 828
%  and 834 §2. This layer adds (1) the Eastern non-Catholic Churches the
%  base's list leaves out, (2) the extraordinary form of c. 1116 (CCEO c. 832),
%  and (3) liceity: a marriage valid in its form may still have been
%  celebrated illicitly, and the sheet says which.
%
%  "Lack of form" is the base's `invalid_form`: a Latin Catholic before no
%  one delegated, an Eastern Catholic before a deacon or with no priest's
%  blessing (c. 1108 §3; CCEO c. 828). "Form for liceity only" is c. 1127 §1
%  and CCEO c. 834 §2: a Catholic, Latin or Eastern, marrying one baptized in
%  an Eastern non-Catholic Church; valid before any sacred minister (a
%  priest, from 2016), but illicit without the Catholic form or without the
%  permission of c. 1124 (CCEO c. 813).
%
%  Personal layer, drafted for review. Ora pro me, peccatore.
% ===================================================================

% @input witnesses_present/2 | witnesses_present(M, N): the witnesses present at the celebration (two are required, c. 1108 §1; CCEO c. 828 §1)
% @input assistant_unavailable/2 | assistant_unavailable(M, danger_of_death | foreseen_month): one competent to assist could not be had or approached without grave inconvenience, in danger of death or for a month foreseen (c. 1116 §1; CCEO c. 832 §1)
% @input catholic_form_observed/1 | catholic_form_observed(M): the Catholic form was in fact kept in a marriage where it bound for liceity only (c. 1127 §1)

% ---------- The Eastern non-Catholic Churches ---------------------------------------
% The base names the Eastern Orthodox and the Oriental Orthodox. The Church
% of the East is neither and is Eastern and non-Catholic: a Catholic marrying
% one of its faithful falls under c. 1127 §1 and CCEO c. 834 §2 as much as one
% marrying a Greek or a Copt. Named Churches are given for the record a
% tribunal keeps; the two families are kept for a record that names only them.
eastern_noncatholic_church((assyrian_church_of_the_east;ancient_church_of_the_east)).
eastern_noncatholic_church((greek_orthodox;russian_orthodox;serbian_orthodox;romanian_orthodox;bulgarian_orthodox;ukrainian_orthodox;antiochian_orthodox;georgian_orthodox)).
eastern_noncatholic_church((coptic_orthodox;armenian_apostolic;syriac_orthodox;ethiopian_orthodox;eritrean_orthodox;malankara_orthodox)).

% ---------- The extraordinary form (c. 1116; CCEO c. 832) ----------------------------
% @norm cic:1116 | c. 1116 §1: if one competent to assist according to the norm of law cannot be present or approached without grave inconvenience, those intending to enter into a true marriage can contract it validly and licitly before witnesses only, in danger of death, or outside it if it is prudently foreseen that the situation will continue for a month; §2: if another priest or deacon who can be present is available, he must be called and be present together with the witnesses | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1108-1123_en.html
extraordinary_form(M) :- marriage(M,_,_), assistant_unavailable(M,_), witnesses_present(M,N), N >= 2.
valid_form(M) :- form_1983(M), extraordinary_form(M), not eastern_party(M).
% @norm cceo:832 | CCEO c. 832 §1: if one cannot have or approach without grave inconvenience a priest competent according to the norm of law, those intending to celebrate a true marriage can validly and licitly celebrate it before witnesses alone, in danger of death, or outside it if it is prudently foreseen that the situation will last a month; §3: if a priest, even a non-Catholic one, can be present, he is to be called, that he may bless the marriage, the validity of the marriage before witnesses alone remaining | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
valid_form(M) :- extraordinary_form(M), eastern_party(M), marriage(M,_,T), norm_in_force(cceo832,T).
part_of((cceo832;cceo813),cceo_text_1990).
info(marriage(M,extraordinary_form)) :- extraordinary_form(M), valid_form(M), past(M).

% ---------- Liceity ---------------------------------------------------------------
% @norm cic:1124 | c. 1124: without the express permission of the competent authority, a marriage is prohibited between two baptized persons of whom one was baptized in the Catholic Church or received into it after baptism and the other is enrolled in a Church or ecclesial community not in full communion with the Catholic Church | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1124-1129_en.html
% @norm cceo:813 | CCEO c. 813: marriage between two baptized persons, one of whom is Catholic and the other non-Catholic, is prohibited without the prior permission of the competent authority | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
mixed(M) :- spouse(M,P), in_catholic_church(P), spouse(M,Q), outside(Q), not unbaptized(Q).
permitted_mixed(M) :- permission_for_mixed_marriage(M,_,TP), marriage(M,_,T), TP <= T.
illicit(M,no_permission_for_mixed_marriage) :- mixed(M), not permitted_mixed(M), marriage(M,_,T), norm_in_force(n1124,T), not eastern_party(M).
illicit(M,no_permission_for_mixed_marriage) :- mixed(M), not permitted_mixed(M), marriage(M,_,T), norm_in_force(cceo813,T), eastern_party(M).
enacted_by(mixed_text_1983,code1983). part_of(n1124,mixed_text_1983).
% @norm cic:1127 | c. 1127 §1 (the liceity half): where the form binds for liceity only, its omission is illicit, not invalidating | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1124-1129_en.html
illicit(M,catholic_form_not_observed) :- liceity_only(M), valid_form(M), not catholic_form_observed(M), not dispensed(cond(matrimony,canonical_form),M).
% Eastern Catholic marrying an Eastern non-Catholic: the base's cceo834 names it liceity_only too.
% @end
info(marriage(M,valid_form_but_illicit,Why)) :- illicit(M,Why), valid_form(M), past(M).
info(marriage(M,illicit,Why)) :- illicit(M,Why), not valid_form(M), past(M).
info(marriage(M,eastern_noncatholic_party,C)) :- spouse(M,Q), baptized_in(Q,C), eastern_noncatholic_church(C), not received_into(Q), past(M).

% ---------- For the coverage sheet ---------------------------------------------------
% "Lack of form" formulated as a ground: engaged where the base finds the
% form binding and not kept and not dispensed.
ground_engaged(M,lack_of_form) :- ground_at_issue(M,lack_of_form), form_binds(M), not valid_form(M), not dispensed(cond(matrimony,canonical_form),M).
ground_engaged_by(M,lack_of_form,n1108)   :- ground_engaged(M,lack_of_form), form_1983(M), not priest_required(M).
ground_engaged_by(M,lack_of_form,n1108_3) :- ground_engaged(M,lack_of_form), lacks_priest(M), priest_required_by(M,n1108_3).
ground_engaged_by(M,lack_of_form,cceo828) :- ground_engaged(M,lack_of_form), lacks_priest(M), priest_required_by(M,cceo828).
ground_engaged_by(M,lack_of_form,n1094_1917) :- ground_engaged(M,lack_of_form), form_1917(M).
