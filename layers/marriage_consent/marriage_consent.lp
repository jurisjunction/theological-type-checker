% ===================================================================
%  Consent to marriage, cc. 1095-1103: the grounds a tribunal formulates,
%  read from supplied claims (TTC-ACT, rule 3). A ground is engaged on the
%  claims a case supplies; the law makes of them what it makes, branch by
%  branch, and finds nothing about a soul. Where a claim is contradicted
%  in the acts, the case enters it `disputed`, and the ground is computed
%  both ways.
%
%  Personal layer (TTC_HOME/rules), drafted for review; not in the public
%  base. Each norm needs a test that fails without it (rule 5): see
%  marriage_consent_cases.lp (HYPOTHETICAL) and marriage_consent_scenarios.json.
%  The dating of these canons is left as the base leaves c. 1103's: the
%  consent canons state what consent is, and the Rota reads them of
%  marriages before 1983; only c. 1098 is read two ways (below).
%
%  Ora pro me, peccatore.
% ===================================================================

% ---------- Slots ----------------------------------------------------------
% @input ground_at_issue/2 | ground_at_issue(M, G): the tribunal has formulated ground G on marriage M (the dubium); G is a norm id below (n1095_2, n1101_prolis, ...)
% @input intended/3 | intended(P, M, quality(Q)): a claim that P directly and principally intended quality Q of the other party in consenting to M (c. 1097 §2); supplied, never derived
% @input deceit/5 | deceit(D, Deceiver, Deceived, M, quality(Q)): an outward act D of deceit about quality Q, perpetrated to obtain the other's consent to M (c. 1098)
% @input quality_gravely_disturbs/1 | quality_gravely_disturbs(Q): that Q "of its very nature can gravely disturb the partnership of conjugal life" (c. 1098): a reading of the quality, entered by the case; computed both ways where disputed
% @input condition/4 | condition(C, M, P, past | present | future): P's consent to M was made to depend on condition C (c. 1102)
% @input fulfilled/1 | fulfilled(C): the condition was fulfilled: an outward fact, computed both ways where disputed

% New elements of interior/3, read by the norms below (the slot is act.lp's):
%   discretion(grave_defect)                     c. 1095 2°
%   incapacity(assume_obligations,psychic)       c. 1095 3°
%   error_of(person)                              c. 1097 §1
%   error_of(quality(Q))                          c. 1097 §2, with intended/3
%   positive_will(excludes(X))                    c. 1101 §2; X is matrimony, bonum_prolis, bonum_fidei,
%                                                 bonum_sacramenti, bonum_coniugum, essential_element(E), essential_property(P)
%   reason(lacking), ignorance(fact(nature_of_marriage),K), fear(...), escape_choice, violence: already act.lp's

{ quality_gravely_disturbs(Q) } :- disputed(quality_gravely_disturbs(Q)).
assumed_fact(quality_gravely_disturbs(Q))        :- disputed(quality_gravely_disturbs(Q)), quality_gravely_disturbs(Q).
assumed_fact(false(quality_gravely_disturbs(Q))) :- disputed(quality_gravely_disturbs(Q)), not quality_gravely_disturbs(Q).
{ fulfilled(C) } :- disputed(fulfilled(C)).
assumed_fact(fulfilled(C))        :- disputed(fulfilled(C)), fulfilled(C).
assumed_fact(false(fulfilled(C))) :- disputed(fulfilled(C)), not fulfilled(C).

% ---------- The consent canons of 1983 as one text --------------------------
enacted_by(consent_text_1983,code1983).
part_of((n1095;n1096;n1097;n1098;n1101;n1102),consent_text_1983).

% @norm cic:1095 | c. 1095: "Sunt incapaces matrimonii contrahendi: 1° qui sufficienti rationis usu carent; 2° qui laborant gravi defectu discretionis iudicii circa iura et officia matrimonialia essentialia mutuo tradenda et acceptanda; 3° qui ob causas naturae psychicae obligationes matrimonii essentiales assumere non valent" | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1095-1107_en.html
% 1° is act.lp's actus hominis: no human act, no consent (c. 1057 §2). 2° and
% 3° are claims about the person at consent; the law reads them, nothing
% derives them (rule 3). Conduct before and after the wedding is the case's
% evidence for the claim, never a rule's premise.
consent_vitiated_by(M,n1095_1) :- spouse(M,P), removes_voluntary(P,M,no_reason).
consent_vitiated_by(M,n1095_2) :- spouse(M,P), interior(P,M,discretion(grave_defect)).
consent_vitiated_by(M,n1095_3) :- spouse(M,P), interior(P,M,incapacity(assume_obligations,psychic)).

% @norm cic:1096 | c. 1096 §1: for consent to exist, the contracting parties must be at least not ignorant that marriage is a permanent partnership between a man and a woman ordered to the procreation of offspring by means of some sexual cooperation; §2: this ignorance is not presumed after puberty | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1095-1107_en.html
consent_vitiated_by(M,n1096) :- spouse(M,P), ignorance(P,M,fact(nature_of_marriage),_).

% @norm cic:1097 | c. 1097 §1: error concerning the person renders a marriage invalid; §2: error concerning a quality of the person does not render a marriage invalid even if it is the cause for the contract, unless this quality is directly and principally intended | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1095-1107_en.html
% §2 composes two claims: the error, and that the quality was intended
% directly and principally. An error that was merely the cause of the
% contract (causam dans) engages nothing.
consent_vitiated_by(M,n1097_1) :- spouse(M,P), interior(P,M,error_of(person)).
consent_vitiated_by(M,n1097_2) :- spouse(M,P), interior(P,M,error_of(quality(Q))), intended(P,M,quality(Q)).

% @norm cic:1098 | c. 1098: a person contracts invalidly who enters into a marriage deceived by malice, perpetrated to obtain consent, concerning some quality of the other partner which by its very nature can gravely disturb the partnership of conjugal life | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1095-1107_en.html
% Four outward and read elements: the deceit, its purpose (the deceiver's
% claim), the quality's gravity (a reading), and that the deceived party
% consented. Whether the canon reaches marriages before 27 November 1983 is
% disputed: the Rota has read it as declarative of natural law and as merely
% positive law, and no authentic interpretation decides (c. 17; rule 2). For
% such a marriage the case branches on the reading; neither is preferred.
reading_option(c1098,declarative_of_natural_law). reading_option(c1098,merely_positive).
needs_reading(c1098,M) :- deceit(_,_,_,M,_), marriage(M,_,T), not norm_in_force(n1098,T).
deceived_to_consent(M,P,Q) :- deceit(D,O,P,M,quality(Q)), spouse(M,P), spouse(M,O), P != O, interior(O,D,to_obtain_consent).
c1098_reaches(M) :- marriage(M,_,T), norm_in_force(n1098,T).
c1098_reaches(M) :- read_for(c1098,declarative_of_natural_law,M).
consent_vitiated_by(M,n1098) :- deceived_to_consent(M,_,Q), quality_gravely_disturbs(Q), c1098_reaches(M).
info(c1098_reading(M,R)) :- read_for(c1098,R,M).

% @norm cic:1101 | c. 1101 §1: the internal consent of the mind is presumed to conform to the words and signs used in celebrating the marriage; §2: if either or both of the parties by a positive act of the will exclude marriage itself, some essential element of marriage, or some essential property, the party contracts invalidly | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1095-1107_en.html
% §1 is a presumption of the external forum (act.lp's shape): raised by the
% celebration, standing where no exclusion is claimed. §2 reads a claim of
% a positive act of the will; what was excluded names the species the
% tribunals formulate. The bonum coniugum is the Rota's reading of
% "essential element" (c. 1055 §1), kept as its own species.
raises(consent_conforms(P,M)) :- spouse(M,P), marriage(M,_,_).
rebutted(consent_conforms(P,M)) :- spouse(M,P), interior(P,M,positive_will(excludes(_))).
excludes(P,M,X) :- spouse(M,P), interior(P,M,positive_will(excludes(X))).
consent_vitiated_by(M,n1101_total)     :- excludes(_,M,matrimony).
consent_vitiated_by(M,n1101_prolis)    :- excludes(_,M,bonum_prolis).
consent_vitiated_by(M,n1101_fidei)     :- excludes(_,M,bonum_fidei).
consent_vitiated_by(M,n1101_sacramenti):- excludes(_,M,bonum_sacramenti).
consent_vitiated_by(M,n1101_coniugum)  :- excludes(_,M,bonum_coniugum).
consent_vitiated_by(M,n1101_element)   :- excludes(_,M,essential_element(_)).
consent_vitiated_by(M,n1101_property)  :- excludes(_,M,essential_property(_)).

% @norm cic:1102 | c. 1102 §1: a marriage subject to a condition about the future cannot be contracted validly; §2: a marriage entered into subject to a condition about the past or the present is valid or not insofar as that which is subject to the condition exists or not; §3: the condition mentioned in §2 cannot be placed licitly without the written permission of the local ordinary | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1095-1107_en.html
% §1 is the law of 1983; CIC 1917 c. 1092 read a future condition otherwise,
% so §1 is dated. §2 turns on an outward fact, fulfilled or not.
consent_vitiated_by(M,n1102_1) :- condition(_,M,P,future), spouse(M,P), marriage(M,_,T), norm_in_force(n1102,T).
consent_vitiated_by(M,n1102_2) :- condition(C,M,P,past), spouse(M,P), not fulfilled(C).
consent_vitiated_by(M,n1102_2) :- condition(C,M,P,present), spouse(M,P), not fulfilled(C).

% @norm cic:1103 | c. 1103 (the base's rule; here only named as a ground) | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1095-1107_en.html
consent_vitiated_by(M,n1103) :- spouse(M,P), removes_voluntary(P,M,violence).
consent_vitiated_by(M,n1103) :- spouse(M,P), actus_humanus(P,M), grave_fear(P,M), fear_from_without(P,M), chosen_to_escape(P,M).
% @end

% ---------- Into the bond, and out to the tribunal ----------------------------
consent_vitiated(M) :- consent_vitiated_by(M,_).
info(marriage(M,invalid_consent,G)) :- consent_vitiated_by(M,G).
% The dubium, answered ground by ground: engaged on this branch's claims, or
% not. A ground formulated with no claim under it is bare: the finding the
% coverage tool exists to show.
ground_engaged(M,G) :- ground_at_issue(M,G), consent_vitiated_by(M,G).
info(ground(M,G,engaged))     :- ground_engaged(M,G).
info(ground(M,G,not_engaged)) :- ground_at_issue(M,G), not ground_engaged(M,G).
info(presumed_consent(P,M))   :- presumed(consent_conforms(P,M)).
