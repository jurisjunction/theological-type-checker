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
% The Latin canons bind the Latin faithful (c. 1); silence ascribes to the
% Latin Church (c. 111). An Eastern party's consent is read below.
% 1° is act.lp's actus hominis: no human act, no consent (c. 1057 §2). 2° and
% 3° are claims about the person at consent; the law reads them, nothing
% derives them (rule 3). Conduct before and after the wedding is the case's
% evidence for the claim, never a rule's premise.
latin_consent_read(M,P) :- spouse(M,P), not eastern_faithful(P).
consent_vitiated_by(M,n1095_1) :- latin_consent_read(M,P), removes_voluntary(P,M,no_reason).
consent_vitiated_by(M,n1095_2) :- latin_consent_read(M,P), interior(P,M,discretion(grave_defect)).
consent_vitiated_by(M,n1095_3) :- latin_consent_read(M,P), interior(P,M,incapacity(assume_obligations,psychic)).

% @norm cic:1096 | c. 1096 §1: for consent to exist, the contracting parties must be at least not ignorant that marriage is a permanent partnership between a man and a woman ordered to the procreation of offspring by means of some sexual cooperation; §2: this ignorance is not presumed after puberty | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1095-1107_en.html
consent_vitiated_by(M,n1096) :- latin_consent_read(M,P), ignorance(P,M,fact(nature_of_marriage),_).

% @norm cic:1097 | c. 1097 §1: error concerning the person renders a marriage invalid; §2: error concerning a quality of the person does not render a marriage invalid even if it is the cause for the contract, unless this quality is directly and principally intended | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1095-1107_en.html
% §2 composes two claims: the error, and that the quality was intended
% directly and principally. An error that was merely the cause of the
% contract (causam dans) engages nothing.
consent_vitiated_by(M,n1097_1) :- latin_consent_read(M,P), interior(P,M,error_of(person)).
consent_vitiated_by(M,n1097_2) :- latin_consent_read(M,P), interior(P,M,error_of(quality(Q))), intended(P,M,quality(Q)).

% @norm cic:1098 | c. 1098: a person contracts invalidly who enters into a marriage deceived by malice, perpetrated to obtain consent, concerning some quality of the other partner which by its very nature can gravely disturb the partnership of conjugal life | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1095-1107_en.html
% Four outward and read elements: the deceit, its purpose (the deceiver's
% claim), the quality's gravity (a reading), and that the deceived party
% consented. Whether the canon reaches marriages before 27 November 1983 is
% disputed: the Rota has read it as declarative of natural law and as merely
% positive law, and no authentic interpretation decides (c. 17; rule 2). For
% such a marriage the case branches on the reading; neither is preferred.
reading_option(c1098,declarative_of_natural_law). reading_option(c1098,merely_positive).
needs_reading(c1098,M) :- deceit(_,_,P,M,_), latin_consent_read(M,P), marriage(M,_,T), not norm_in_force(n1098,T).
deceived_to_consent(M,P,Q) :- deceit(D,O,P,M,quality(Q)), spouse(M,P), spouse(M,O), P != O, interior(O,D,to_obtain_consent).
c1098_reaches(M,P) :- latin_consent_read(M,P), marriage(M,_,T), norm_in_force(n1098,T).
c1098_reaches(M,P) :- latin_consent_read(M,P), read_for(c1098,declarative_of_natural_law,M).
consent_vitiated_by(M,n1098) :- deceived_to_consent(M,P,Q), quality_gravely_disturbs(Q), c1098_reaches(M,P).
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
consent_vitiated_by(M,n1101_total)     :- latin_consent_read(M,P), excludes(P,M,matrimony).
consent_vitiated_by(M,n1101_prolis)    :- latin_consent_read(M,P), excludes(P,M,bonum_prolis).
consent_vitiated_by(M,n1101_fidei)     :- latin_consent_read(M,P), excludes(P,M,bonum_fidei).
consent_vitiated_by(M,n1101_sacramenti):- latin_consent_read(M,P), excludes(P,M,bonum_sacramenti).
consent_vitiated_by(M,n1101_coniugum)  :- latin_consent_read(M,P), excludes(P,M,bonum_coniugum).
consent_vitiated_by(M,n1101_element)   :- latin_consent_read(M,P), excludes(P,M,essential_element(_)).
consent_vitiated_by(M,n1101_property)  :- latin_consent_read(M,P), excludes(P,M,essential_property(_)).

% @norm cic:1102 | c. 1102 §1: a marriage subject to a condition about the future cannot be contracted validly; §2: a marriage entered into subject to a condition about the past or the present is valid or not insofar as that which is subject to the condition exists or not; §3: the condition mentioned in §2 cannot be placed licitly without the written permission of the local ordinary | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1095-1107_en.html
% §1 is the law of 1983; CIC 1917 c. 1092 read a future condition otherwise,
% so §1 is dated. §2 turns on an outward fact, fulfilled or not. This is the
% one consent canon on which the codes differ (CCEO c. 826, below), so it
% reaches the Latin faithful only (c. 1); silence ascribes to the Latin Church.
consent_vitiated_by(M,n1102_1) :- condition(_,M,P,future), latin_consent_read(M,P), marriage(M,_,T), norm_in_force(n1102,T).
consent_vitiated_by(M,n1102_2) :- condition(C,M,P,past), latin_consent_read(M,P), not fulfilled(C).
consent_vitiated_by(M,n1102_2) :- condition(C,M,P,present), latin_consent_read(M,P), not fulfilled(C).

% @norm cic:1103 | c. 1103 (the base's rule; here only named as a ground) | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1095-1107_en.html
consent_vitiated_by(M,n1103) :- latin_consent_read(M,P), removes_voluntary(P,M,violence).
consent_vitiated_by(M,n1103) :- latin_consent_read(M,P), actus_humanus(P,M), grave_fear(P,M), fear_from_without(P,M), chosen_to_escape(P,M).

% ---------- The Eastern Code: consent, cc. 818-826 (TTC-CCEO) ----------------
% The same claims, read by the Eastern faithful's own code (CCEO c. 1), in
% force from 1 October 1991. Where the two codes say the same, an Eastern
% party's claim engages the Latin ground's twin, and the sheet names which
% code engaged it. Where they differ (conditions), only the party's code
% reads. Before 1991 an Eastern party's consent fell under Crebrae allatae
% (1949), not encoded here: the base's `no_eastern_code_in_force` is raised.
part_of((cceo818;cceo819;cceo820;cceo821;cceo824;cceo825;cceo826),cceo_text_1990).
eastern_consent_read(M,P) :- spouse(M,P), eastern_faithful(P), marriage(M,_,T), norm_in_force(cceo818,T).

% @norm cceo:818 | CCEO c. 818: incapable of contracting marriage are those who (1°) lack sufficient use of reason; (2°) suffer from a grave defect of discretion of judgment concerning the essential matrimonial rights and duties mutually to be handed over and accepted; (3°) are not able to assume the essential obligations of marriage for causes of a psychic nature | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
consent_vitiated_by(M,cceo818_1) :- eastern_consent_read(M,P), removes_voluntary(P,M,no_reason).
consent_vitiated_by(M,cceo818_2) :- eastern_consent_read(M,P), interior(P,M,discretion(grave_defect)).
consent_vitiated_by(M,cceo818_3) :- eastern_consent_read(M,P), interior(P,M,incapacity(assume_obligations,psychic)).
% @norm cceo:819 | CCEO c. 819: for matrimonial consent to exist it is necessary that the parties be at least not ignorant that marriage is a permanent partnership between a man and a woman ordered to the procreation of children through some sexual cooperation | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
consent_vitiated_by(M,cceo819) :- eastern_consent_read(M,P), ignorance(P,M,fact(nature_of_marriage),_).
% @norm cceo:820 | CCEO c. 820 §1: error concerning the person renders a marriage invalid; §2: error concerning a quality of the person, even if it is the cause of the contract, does not render a marriage invalid unless this quality was directly and principally intended | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
consent_vitiated_by(M,cceo820_1) :- eastern_consent_read(M,P), interior(P,M,error_of(person)).
consent_vitiated_by(M,cceo820_2) :- eastern_consent_read(M,P), interior(P,M,error_of(quality(Q))), intended(P,M,quality(Q)).
% @norm cceo:821 | CCEO c. 821: a person contracts invalidly who enters marriage deceived by fraud perpetrated to obtain consent, concerning some quality of the other party which of its very nature can seriously disturb the partnership of conjugal life | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
% One question of law for both codes: whether deceit vitiates consent by its
% nature. For an Eastern marriage before 1991 the same reading branches.
needs_reading(c1098,M) :- deceit(_,_,P,M,_), spouse(M,P), eastern_faithful(P), marriage(M,_,T), not norm_in_force(cceo821,T).
cceo821_reaches(M,P) :- eastern_consent_read(M,P), marriage(M,_,T), norm_in_force(cceo821,T).
cceo821_reaches(M,P) :- spouse(M,P), eastern_faithful(P), read_for(c1098,declarative_of_natural_law,M).
consent_vitiated_by(M,cceo821) :- deceived_to_consent(M,P,Q), quality_gravely_disturbs(Q), cceo821_reaches(M,P).
% @norm cceo:824 | CCEO c. 824 §1: the internal consent of the mind is presumed to conform to the words or signs used in celebrating the marriage; §2: if either or both parties by a positive act of the will exclude marriage itself, or some essential element or essential property of marriage, they contract invalidly | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
consent_vitiated_by(M,cceo824_total)      :- eastern_consent_read(M,P), excludes(P,M,matrimony).
consent_vitiated_by(M,cceo824_prolis)     :- eastern_consent_read(M,P), excludes(P,M,bonum_prolis).
consent_vitiated_by(M,cceo824_fidei)      :- eastern_consent_read(M,P), excludes(P,M,bonum_fidei).
consent_vitiated_by(M,cceo824_sacramenti) :- eastern_consent_read(M,P), excludes(P,M,bonum_sacramenti).
consent_vitiated_by(M,cceo824_coniugum)   :- eastern_consent_read(M,P), excludes(P,M,bonum_coniugum).
consent_vitiated_by(M,cceo824_element)    :- eastern_consent_read(M,P), excludes(P,M,essential_element(_)).
consent_vitiated_by(M,cceo824_property)   :- eastern_consent_read(M,P), excludes(P,M,essential_property(_)).
% @norm cceo:825 | CCEO c. 825: a marriage is invalid which was entered into because of force or grave fear inflicted from without, even if not deliberately, from which a person has no escape other than by choosing marriage | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
consent_vitiated_by(M,cceo825) :- eastern_consent_read(M,P), removes_voluntary(P,M,violence).
consent_vitiated_by(M,cceo825) :- eastern_consent_read(M,P), actus_humanus(P,M), grave_fear(P,M), fear_from_without(P,M), chosen_to_escape(P,M).
% @norm cceo:826 | CCEO c. 826: a marriage based on a condition cannot be validly celebrated | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
% The Eastern tradition admits no condition, past, present or future, and
% fulfilment is not read. This is where the codes part.
consent_vitiated_by(M,cceo826) :- eastern_consent_read(M,P), condition(_,M,P,_).
% @end
info(no_eastern_code_in_force(P,M)) :- spouse(M,P), eastern_faithful(P), marriage(M,_,T), not force_at(cceo1990,T).

% ---------- The grounds across the codes ---------------------------------------
% A ground the tribunal formulates by its Latin canon is engaged by the twin
% Eastern canon for an Eastern party, and the sheet says so. A ground with no
% twin (c. 1102 §2) is its own.
same_ground(G,G) :- ground_at_issue(_,G).
same_ground(n1095_1,cceo818_1). same_ground(n1095_2,cceo818_2). same_ground(n1095_3,cceo818_3).
same_ground(n1096,cceo819). same_ground(n1097_1,cceo820_1). same_ground(n1097_2,cceo820_2).
same_ground(n1098,cceo821). same_ground(n1103,cceo825).
same_ground(n1101_total,cceo824_total). same_ground(n1101_prolis,cceo824_prolis). same_ground(n1101_fidei,cceo824_fidei).
same_ground(n1101_sacramenti,cceo824_sacramenti). same_ground(n1101_coniugum,cceo824_coniugum).
same_ground(n1101_element,cceo824_element). same_ground(n1101_property,cceo824_property).
same_ground(n1102_1,cceo826). same_ground(n1102_2,cceo826).
same_ground(B,A) :- same_ground(A,B).

% ---------- Into the bond, and out to the tribunal ----------------------------
consent_vitiated(M) :- consent_vitiated_by(M,_).
info(marriage(M,invalid_consent,G)) :- consent_vitiated_by(M,G).
% The dubium, answered ground by ground: engaged on this branch's claims, or
% not. A ground formulated with no claim under it is bare: the finding the
% coverage tool exists to show.
ground_engaged(M,G)    :- ground_at_issue(M,G), consent_vitiated_by(M,G2), same_ground(G,G2).
ground_engaged_by(M,G,G2) :- ground_at_issue(M,G), consent_vitiated_by(M,G2), same_ground(G,G2).
info(ground(M,G,engaged))     :- ground_engaged(M,G).
info(ground(M,G,engaged_by(G2))) :- ground_engaged_by(M,G,G2).
info(ground(M,G,not_engaged)) :- ground_at_issue(M,G), not ground_engaged(M,G).
info(presumed_consent(P,M))   :- presumed(consent_conforms(P,M)).
