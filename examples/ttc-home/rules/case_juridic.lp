% A case: the tribunal software held by a trading company or by a pious
% foundation; a priest on the board of each. Neutral names (rule 13).
#program case_juridic.
today(20261025).

% The trading company: a civil corporation with share capital. Its articles
% state an end of the apostolate; its surplus goes to its shareholders.
aggregate(company_l,persons). civil_corporation(company_l).
end_of(company_l,serve_tribunals). end_kind(serve_tribunals,apostolate).
distributes_gain(company_l). trades_for_gain(company_l).

% The foundation: an aggregate of things (the code, and what it earns),
% licensing to tribunals at cost; nothing distributed. Its civil carrier is a
% non-share corporation.
aggregate(foundation_f,things).
end_of(foundation_f,serve_tribunals_f). end_kind(serve_tribunals_f,apostolate).
competent_for(bishop_b,foundation_f).
civil_corporation(carrier_f).

% A priest, a director of both, and a shareholder of the company. No
% permission entered.
cleric(cleric_c). priest(cleric_c).
office(cleric_c,company_l,director).  entails_accounts(company_l,director).
holds_shares(cleric_c,company_l).
office(cleric_c,carrier_f,director).  entails_accounts(carrier_f,director).

#program foundation_erected.   % HYPOTHETICAL: the bishop judges, approves and decrees
judged_useful_and_sufficient(bishop_b,foundation_f).
statutes_approved(foundation_f,bishop_b).
decree_of_personality(decree_f,bishop_b,foundation_f,express).
civil_twin_of(carrier_f,foundation_f).

#program company_decreed.      % HYPOTHETICAL: a decree of personality for the company
decree_of_personality(decree_l,bishop_b,company_l,express).
