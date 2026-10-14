% ===================================================================
%  The diriment impediments, cc. 1083-1094 and CCEO cc. 800-812, as a
%  personal layer. An impediment is an outward fact about a person or a
%  pair (age, a prior bond, kinship, orders, a vow), read from the record;
%  the one that names a purpose (crime, c. 1090) reads a supplied claim.
%  Each stands as `defect_of_marriage(M, impediment(K))` and so reaches the
%  bond through the base's c. 1057, and a dispensation reaches it through
%  the base's c. 85: the layer only says which impediments the law treats
%  as never dispensed (c. 1078 §3; cc. 1084, 1085), and which are reserved
%  to the Apostolic See (c. 1078 §2).
%
%  Each code reads its own faithful (c. 1): a Latin canon where a party is
%  Latin, an Eastern canon where a party is Eastern, both in a mixed
%  Latin-Eastern marriage. They agree except on affinity in the collateral
%  line (CCEO c. 809) and spiritual relationship (CCEO c. 811), which the
%  Latin Code dropped in 1983.
%
%  Personal layer, drafted for review. Ora pro me, peccatore.
% ===================================================================

% ---------- Slots ----------------------------------------------------------
% @input sex/2 | sex(Person, male | female): for the ages of c. 1083 and the woman of c. 1089
% @input impotence/2 | impotence(Person, antecedent_perpetual): the fact of c. 1084 §1, as recorded; `disputed` where a doubt of fact remains
% @input sterility/1 | sterility(Person): recorded, and no impediment (c. 1084 §3)
% @input death/2 | death(Person, Date): a death that ends a bond
% @input vow/5 | vow(Person, public, perpetual, Institute, Date): a public perpetual vow of chastity in a religious institute (c. 1088)
% @input pontifical/1 | pontifical(Institute): an institute of pontifical right (c. 1078 §2 n. 1)
% @input abducted/2 | abducted(Woman, Marriage): abducted or detained with a view to this marriage (c. 1089)
% @input released_before_consent/2 | released_before_consent(Woman, Marriage): separated from the abductor and placed in a safe and free place before consenting (c. 1089)
% @input killing/4 | killing(K, Killer, Victim, Date): an outward act, for c. 1090
% @input cooperated_in/2 | cooperated_in(Person, K): physical or moral cooperation in the killing (c. 1090 §2)
% @input adopted/2 | adopted(Child, Parent): a legal relationship from adoption (c. 1094)
% @input common_life/1 | common_life(M0): common life was established after the (invalid) marriage M0 (c. 1093)
% @input concubinage/2 | concubinage(X, Y): notorious or public concubinage (c. 1093)
% @input sponsor_at_baptism/2 | sponsor_at_baptism(Godparent, Child): CCEO c. 811 §1
% @input permission_for_mixed_marriage/3 | permission_for_mixed_marriage(M, Issuer, Date): the express permission of c. 1124 (CCEO c. 813), for liceity

% ---------- Kinship, computed by the Roman reckoning (c. 108; CCEO c. 918) ------
parent(C,P) :- father(C,P).
parent(C,P) :- mother(C,P).
ancestor(X,A,1)   :- parent(X,A).
ancestor(X,A,N+1) :- ancestor(X,B,N), parent(B,A), N < 8.
% the direct line: as many degrees as generations
consanguine(X,Y,direct,N) :- ancestor(X,Y,N).
consanguine(X,Y,direct,N) :- ancestor(Y,X,N).
% the collateral line: the generations on both sides to the nearest common stock
common_stock(X,Y,A,N1+N2) :- ancestor(X,A,N1), ancestor(Y,A,N2), X != Y, not ancestor(X,Y,_), not ancestor(Y,X,_).
consanguine(X,Y,collateral,D) :- common_stock(X,Y,_,_), D = #min { N : common_stock(X,Y,_,N) }.
% legal relationship by adoption: the same lines, through adoptive parents (c. 1094; CCEO c. 812)
lparent(C,P) :- adopted(C,P).
lparent(C,P) :- parent(C,P).
lancestor(X,A,1)   :- lparent(X,A).
lancestor(X,A,N+1) :- lancestor(X,B,N), lparent(B,A), N < 8.
legal_relation(X,Y,direct,N) :- lancestor(X,Y,N), adoptive_line(X,Y).
legal_relation(X,Y,direct,N) :- lancestor(Y,X,N), adoptive_line(Y,X).
adoptive_line(X,Y) :- lancestor(X,Y,_), not ancestor(X,Y,_).
lcommon(X,Y,A,N1+N2) :- lancestor(X,A,N1), lancestor(Y,A,N2), X != Y, not lancestor(X,Y,_), not lancestor(Y,X,_), not common_stock(X,Y,A,_).
legal_relation(X,Y,collateral,D) :- lcommon(X,Y,_,_), D = #min { N : lcommon(X,Y,_,N) }.
% affinity: between a spouse and the blood relatives of the other (c. 109; CCEO c. 919), from a valid marriage
affine_at(X,Y,Line,N,T) :- spouse(M0,X), spouse(M0,Y0), X != Y0, bond(M0), marriage(M0,_,T0), instant_asked(T), T0 < T, consanguine(Y0,Y,Line,N), Y != X.

% ---------- Which code reads the marriage ----------------------------------------
latin_party(M)   :- spouse(M,P), not eastern_faithful(P).
% eastern_party/1 is the base's (dc2016:1108)
cic_reads(M)  :- marriage(M,_,_), latin_party(M).
cceo_reads(M) :- marriage(M,_,T), eastern_party(M), norm_in_force(cceo800,T).
enacted_by(impediments_text_1983,code1983).
part_of((n1083;n1086;n1087;n1088;n1089;n1090;n1091;n1092;n1093;n1094),impediments_text_1983).
part_of((cceo800;cceo801;cceo802;cceo803;cceo804;cceo805;cceo806;cceo807;cceo808;cceo809;cceo810;cceo811;cceo812),cceo_text_1990).

% ---------- The impediments, Latin ---------------------------------------------
% @norm cic:1083 | c. 1083 §1: a man before he has completed his sixteenth year of age and a woman before she has completed her fourteenth year cannot enter into a valid marriage | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1083-1094_en.html
under_age(P,M) :- spouse(M,P), sex(P,male),   age_at(P,M,N), N < 16.
under_age(P,M) :- spouse(M,P), sex(P,female), age_at(P,M,N), N < 14.
impediment_by(M,age,n1083) :- under_age(P,M), cic_reads(M), marriage(M,_,T), norm_in_force(n1083,T).
% @norm cic:1084 | c. 1084 §1: antecedent and perpetual impotence to have intercourse, whether on the part of the man or the woman, absolute or relative, nullifies marriage by its very nature; §2: if the impediment is doubtful, by a doubt of law or of fact, the marriage must not be impeded nor, while the doubt remains, declared null; §3: sterility neither prohibits nor nullifies marriage | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1083-1094_en.html
% @stratum cic:1084 divine
% The doubt is read the canon's way: a disputed impotence impedes nothing.
impediment_by(M,impotence,n1084) :- spouse(M,P), impotence(P,antecedent_perpetual), not disputed(impotence(P,antecedent_perpetual)), cic_reads(M).
info(doubtful_impotence_does_not_impede(P,M)) :- spouse(M,P), disputed(impotence(P,antecedent_perpetual)).
info(sterility_no_impediment(P,M)) :- spouse(M,P), sterility(P).
% @norm cic:1085 | c. 1085 §1: a person bound by the bond of a prior marriage, even if it was not consummated, invalidly attempts marriage; §2: even if the prior marriage is invalid or dissolved for any reason, it is not on that account permitted to contract another before the nullity or dissolution of the prior marriage is established legitimately and certainly | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1083-1094_en.html
% @stratum cic:1085 divine
prior_marriage(M,M0,P) :- spouse(M,P), spouse(M0,P), M0 != M, marriage(M0,_,T0), marriage(M,_,T), T0 < T.
instant_asked(T) :- event_date(_,T).
instant_asked(T) :- killing(_,_,_,T).
bond_ended_before(M0,T) :- dissolved(M0,D), dissolution(D,M0,_,TD), instant_asked(T), TD < T.
death(V,T) :- killing(_,_,V,T).
bond_ended_before(M0,T) :- spouse(M0,Q), death(Q,TD), instant_asked(T), TD < T.
bound_at(P,M0,T) :- prior_marriage(M,M0,P), marriage(M,_,T), bond(M0), not bond_ended_before(M0,T).
impediment_by(M,prior_bond,n1085) :- prior_marriage(M,M0,P), marriage(M,_,T), bound_at(P,M0,T), cic_reads(M).
% §2: the earlier marriage null or dissolved, but not yet declared or established when the second was contracted
established_before(M0,T) :- nullity_sentence(S,M0,TS), sentence_effective(S), instant_asked(T), TS < T.
established_before(M0,T) :- bond_ended_before(M0,T).
info(prior_marriage_not_yet_established_null(M,M0)) :- prior_marriage(M,M0,_), marriage(M,_,T), not bound_at(_,M0,T), not established_before(M0,T).
% @norm cic:1086 | c. 1086 §1: a marriage between two persons, one of whom was baptized in the Catholic Church or received into it, and the other of whom is not baptized, is invalid (as amended by Omnium in mentem, 2009; until then, "and has not defected from it by a formal act") | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1083-1094_en.html
disparity_exempt(P,M) :- spouse(M,P), formal_defection(P,D), marriage(M,_,T), D <= T, norm_in_force(n1086_1983,T).
part_of(n1086_1983,c1117_text_1983).      % the same clause, struck by the same act (the base dates it)
impediment_by(M,disparity_of_cult,n1086) :- spouse(M,P), in_catholic_church(P), not disparity_exempt(P,M), spouse(M,Q), unbaptized(Q), cic_reads(M), marriage(M,_,T), norm_in_force(n1086,T).
% @norm cic:1087 | c. 1087: those in sacred orders invalidly attempt marriage | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1083-1094_en.html
impediment_by(M,sacred_orders,n1087) :- spouse(M,P), cleric(P), cic_reads(M), marriage(M,_,T), norm_in_force(n1087,T).
% @norm cic:1088 | c. 1088: those bound by a public perpetual vow of chastity in a religious institute invalidly attempt marriage | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1083-1094_en.html
vowed_at(P,M) :- spouse(M,P), vow(P,public,perpetual,_,TV), marriage(M,_,T), TV < T.
impediment_by(M,public_vow,n1088) :- vowed_at(P,M), cic_reads(M), marriage(M,_,T), norm_in_force(n1088,T).
% @norm cic:1089 | c. 1089: no marriage can exist between a man and a woman who has been abducted or at least detained with a view of contracting marriage with her unless the woman chooses marriage of her own accord after she has been separated from the captor and established in a safe and free place | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1083-1094_en.html
impediment_by(M,abduction,n1089) :- abducted(W,M), spouse(M,W), not released_before_consent(W,M), cic_reads(M), marriage(M,_,T), norm_in_force(n1089,T).
% @norm cic:1090 | c. 1090 §1: anyone who with a view to entering marriage with a certain person has brought about the death of that person's spouse or of one's own spouse invalidly attempts this marriage; §2: those who have brought about the death of a spouse by mutual physical or moral cooperation also invalidly attempt a marriage together | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1083-1094_en.html
% The purpose of §1 is a claim (rule 3); the cooperation of §2 is outward.
spouse_of_at(V,Q,T) :- spouse(M0,V), spouse(M0,Q), V != Q, bond(M0), marriage(M0,_,T0), killing(_,_,V,T), T0 < T, not bond_ended_before(M0,T).
conjugicide(P,Q,M) :- spouse(M,P), spouse(M,Q), P != Q, killing(K,P,V,TK), spouse_of_at(V,Q,TK), interior(P,K,to_marry(Q)).
conjugicide(P,Q,M) :- spouse(M,P), spouse(M,Q), P != Q, killing(K,P,V,TK), spouse_of_at(V,P,TK), interior(P,K,to_marry(Q)).
conjugicide(P,Q,M) :- spouse(M,P), spouse(M,Q), P != Q, killing(K,_,V,TK), cooperated_in(P,K), cooperated_in(Q,K), spouse_of_at(V,P,TK).
conjugicide(P,Q,M) :- spouse(M,P), spouse(M,Q), P != Q, killing(K,_,V,TK), cooperated_in(P,K), cooperated_in(Q,K), spouse_of_at(V,Q,TK).
impediment_by(M,crime,n1090) :- conjugicide(_,_,M), cic_reads(M), marriage(M,_,T), norm_in_force(n1090,T).
% @norm cic:1091 | c. 1091 §1: in the direct line of consanguinity marriage is invalid between all ancestors and descendants; §2: in the collateral line marriage is invalid up to and including the fourth degree; §4: a marriage is never permitted if doubt exists whether the parties are related by consanguinity in any degree of the direct line or in the second degree of the collateral line | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1083-1094_en.html
related(M,consanguinity,Line,N) :- spouse(M,X), spouse(M,Y), X != Y, consanguine(X,Y,Line,N).
impediment_by(M,consanguinity(direct,N),n1091)     :- related(M,consanguinity,direct,N), cic_reads(M).
impediment_by(M,consanguinity(collateral,N),n1091) :- related(M,consanguinity,collateral,N), N <= 4, cic_reads(M), marriage(M,_,T), norm_in_force(n1091,T).
% @norm cic:1092 | c. 1092: affinity in the direct line in any degree invalidates a marriage | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1083-1094_en.html
related(M,affinity,Line,N) :- spouse(M,X), spouse(M,Y), X != Y, marriage(M,_,T), affine_at(X,Y,Line,N,T).
impediment_by(M,affinity(direct,N),n1092) :- related(M,affinity,direct,N), cic_reads(M), marriage(M,_,T), norm_in_force(n1092,T).
% @norm cic:1093 | c. 1093: the impediment of public propriety arises from an invalid marriage after the establishment of common life or from notorious or public concubinage; it nullifies marriage in the first degree of the direct line between the man and the blood relatives of the woman, and vice versa | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1083-1094_en.html
propriety_source(X,Z) :- spouse(M0,X), spouse(M0,Z), X != Z, marriage(M0,_,_), not bond(M0), common_life(M0).
propriety_source(X,Z) :- concubinage(X,Z).
propriety_source(X,Z) :- concubinage(Z,X).
related(M,public_propriety,direct,1) :- spouse(M,X), spouse(M,Y), X != Y, propriety_source(X,Z), consanguine(Z,Y,direct,1).
impediment_by(M,public_propriety,n1093) :- related(M,public_propriety,direct,1), cic_reads(M), marriage(M,_,T), norm_in_force(n1093,T).
% @norm cic:1094 | c. 1094: those who are related in the direct line or in the second degree of the collateral line by a legal relationship arising from adoption cannot contract marriage together validly | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1083-1094_en.html
related(M,adoption,Line,N) :- spouse(M,X), spouse(M,Y), X != Y, legal_relation(X,Y,Line,N).
impediment_by(M,adoption(direct,N),n1094) :- related(M,adoption,direct,N), cic_reads(M), marriage(M,_,T), norm_in_force(n1094,T).
impediment_by(M,adoption(collateral,2),n1094) :- related(M,adoption,collateral,2), cic_reads(M), marriage(M,_,T), norm_in_force(n1094,T).

% ---------- The impediments, Eastern (CCEO cc. 800-812) --------------------------
% @norm cceo:800 | CCEO c. 800 §1: a man before he has completed his sixteenth year of age and a woman before she has completed her fourteenth year cannot validly celebrate marriage | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
impediment_by(M,age,cceo800) :- under_age(_,M), cceo_reads(M).
% @norm cceo:801 | CCEO c. 801 §1: antecedent and perpetual impotence to have intercourse, absolute or relative, by its very nature invalidates marriage; §2: in a doubt of law or of fact the marriage is not to be impeded nor, while the doubt remains, declared null; §3: sterility neither prohibits nor invalidates marriage | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
% @stratum cceo:801 divine
impediment_by(M,impotence,cceo801) :- spouse(M,P), impotence(P,antecedent_perpetual), not disputed(impotence(P,antecedent_perpetual)), cceo_reads(M).
% @norm cceo:802 | CCEO c. 802 §1: a person bound by the bond of a prior marriage invalidly attempts marriage | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
% @stratum cceo:802 divine
impediment_by(M,prior_bond,cceo802) :- prior_marriage(M,M0,P), marriage(M,_,T), bound_at(P,M0,T), cceo_reads(M).
% @norm cceo:803 | CCEO c. 803 §1: marriage with a non-baptized person cannot be validly celebrated | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
impediment_by(M,disparity_of_cult,cceo803) :- spouse(M,P), in_catholic_church(P), spouse(M,Q), unbaptized(Q), cceo_reads(M).
% @norm cceo:804 | CCEO c. 804: a person who is in sacred orders invalidly attempts marriage | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
impediment_by(M,sacred_orders,cceo804) :- spouse(M,P), cleric(P), cceo_reads(M).
% @norm cceo:805 | CCEO c. 805: a person bound by a public perpetual vow of chastity in a religious institute invalidly attempts marriage | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
impediment_by(M,public_vow,cceo805) :- vowed_at(_,M), cceo_reads(M).
% @norm cceo:806 | CCEO c. 806: no marriage can validly be celebrated with a person who has been abducted or at least detained with a view to marriage, unless that person, separated from the abductor and placed in a safe and free place, freely chooses marriage | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
impediment_by(M,abduction,cceo806) :- abducted(W,M), spouse(M,W), not released_before_consent(W,M), cceo_reads(M).
% @norm cceo:807 | CCEO c. 807 §1: one who with a view to marrying a certain person has brought about the death of that person's spouse or of one's own spouse invalidly attempts that marriage; §2: those who brought about the death of a spouse by mutual physical or moral cooperation also invalidly attempt marriage with each other | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
impediment_by(M,crime,cceo807) :- conjugicide(_,_,M), cceo_reads(M).
% @norm cceo:808 | CCEO c. 808 §1: in the direct line of consanguinity marriage is invalid between all ancestors and descendants; §2: in the collateral line it is invalid up to the fourth degree inclusive; §4: a marriage is never to be permitted if there is a doubt whether the parties are related by consanguinity in any degree of the direct line or in the second degree of the collateral line | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
impediment_by(M,consanguinity(direct,N),cceo808)     :- related(M,consanguinity,direct,N), cceo_reads(M).
impediment_by(M,consanguinity(collateral,N),cceo808) :- related(M,consanguinity,collateral,N), N <= 4, cceo_reads(M).
% @norm cceo:809 | CCEO c. 809 §1: affinity invalidates marriage in any degree of the direct line and in the second degree of the collateral line | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
% Here the codes part: the Latin Code reads affinity in the direct line only.
impediment_by(M,affinity(direct,N),cceo809)     :- related(M,affinity,direct,N), cceo_reads(M).
impediment_by(M,affinity(collateral,2),cceo809) :- related(M,affinity,collateral,2), cceo_reads(M).
% @norm cceo:810 | CCEO c. 810 §1: the impediment of public propriety arises from an invalid marriage after common life has been established, and from notorious or public concubinage; §2: it invalidates marriage in the first degree of the direct line between the man and the blood relatives of the woman, and vice versa | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
impediment_by(M,public_propriety,cceo810) :- related(M,public_propriety,direct,1), cceo_reads(M).
% @norm cceo:811 | CCEO c. 811 §1: from baptism there arises a spiritual relationship between a sponsor and the baptized person and the parents of the same, which invalidates marriage | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
% Kept by the Eastern Code; the Latin Code of 1983 has no such impediment
% (CIC 1917 c. 1079 had). Here the codes part again.
spiritual_relation(G,C) :- sponsor_at_baptism(G,C).
spiritual_relation(G,P) :- sponsor_at_baptism(G,C), parent(C,P).
spiritual_relation(X,Y) :- spiritual_relation(Y,X).
impediment_by(M,spiritual_relationship,cceo811) :- spouse(M,X), spouse(M,Y), X != Y, spiritual_relation(X,Y), cceo_reads(M).
% @norm cceo:812 | CCEO c. 812: those who are related in the direct line or in the second degree of the collateral line by a legal relationship arising from adoption cannot validly marry each other | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf
impediment_by(M,adoption(direct,N),cceo812)   :- related(M,adoption,direct,N), cceo_reads(M).
impediment_by(M,adoption(collateral,2),cceo812) :- related(M,adoption,collateral,2), cceo_reads(M).

% ---------- Dispensation: what the law itself puts beyond it ----------------------
% @norm cic:1078 | c. 1078 §1: the local ordinary can dispense his own subjects and all actually present in his territory from all impediments of ecclesiastical law except those reserved to the Apostolic See; §2: reserved are the impediment arising from sacred orders or from a public perpetual vow of chastity in a religious institute of pontifical right, and the impediment of crime (c. 1090); §3: a dispensation is never given from the impediment of consanguinity in the direct line or in the second degree of the collateral line (CCEO c. 795 §§1-2 likewise, the Apostolic See's reservation of orders, vows and crime, and §3: never from the direct line or the second collateral degree) | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1073-1082_en.html
% What the canons say of themselves, read juridically and no further:
% impotence invalidates "by its very nature" (c. 1084 §1), and the prior bond
% is c. 1141's (divine, as the base already types it): these two the layer
% enters as divine law. Of consanguinity c. 1078 §3 says only that a
% dispensation "is never given" in the direct line and the second collateral
% degree: a rule about dispensing, entered as such below, not a finding that
% those degrees are of divine law. Whether they are (Thomas, Suppl. q. 54 a. 3,
% holds the first degree of the direct line against natural law and the
% others of positive law) is the theology side's question, left open; a
% reviewer who wants the Church's practice weighed enters the acts and their
% tier. Every other impediment is ecclesiastical.
impediment(M,K) :- impediment_by(M,K,_).
of_natural_law(impotence).
of_divine_positive_law(prior_bond).
law_kind(cond(matrimony,impediment(K)),natural)         :- impediment(_,K), of_natural_law(K).
law_kind(cond(matrimony,impediment(K)),divine_positive) :- impediment(_,K), of_divine_positive_law(K).
law_kind(cond(matrimony,impediment(K)),ecclesiastical)  :- impediment(_,K), not of_natural_law(K), not of_divine_positive_law(K).
% c. 1078 §3 (CCEO c. 795 §3): never given. A dispensation entered for these
% degrees is a violation of that rule and relaxes nothing.
never_dispensed(consanguinity(direct,N)) :- impediment(_,consanguinity(direct,N)).
never_dispensed(consanguinity(collateral,2)).
violation(dispensation_never_given_c1078_3(D,K)) :- dispensation(D,cond(matrimony,impediment(K)),M), impediment(M,K), never_dispensed(K).
reserved(sacred_orders). reserved(crime).
reserved_vow(M) :- spouse(M,P), vow(P,public,perpetual,I,_), pontifical(I).
reserved_for(M,public_vow) :- impediment(M,public_vow), reserved_vow(M).
reserved_for(M,K) :- impediment(M,K), reserved(K).
competent_dispensation(M,K) :- dispensation(D,cond(matrimony,impediment(K)),M), issuer(D,A), authority(A,R), R >= 3.
validly_dispensed(M,K) :- dispensed(cond(matrimony,impediment(K)),M), not reserved_for(M,K), not never_dispensed(K).
validly_dispensed(M,K) :- dispensed(cond(matrimony,impediment(K)),M), reserved_for(M,K), competent_dispensation(M,K), not never_dispensed(K).
violation(dispensation_of_reserved_impediment(D,K)) :- dispensation(D,cond(matrimony,impediment(K)),M), reserved_for(M,K), not competent_dispensation(M,K).
% @end

% ---------- Into the bond ------------------------------------------------------------
% The base's c. 1057 takes it from here: unmet unless dispensed (c. 85), and a
% dispensation of divine law is a violation there. A reserved impediment
% dispensed by one not competent stands as a defect of its own, which no
% dispensation names.
defect_of_marriage(M,impediment(K)) :- impediment(M,K).
defect_of_marriage(M,reserved_impediment_undispensed(K)) :- reserved_for(M,K), not competent_dispensation(M,K).
defect_of_marriage(M,impediment_never_dispensed(K)) :- impediment(M,K), never_dispensed(K).
info(marriage(M,impeded,K,N))  :- impediment_by(M,K,N), past(M).
info(marriage(M,impediment_dispensed,K)) :- impediment(M,K), validly_dispensed(M,K), past(M).
info(marriage(M,impediment_stands,K))    :- impediment(M,K), not validly_dispensed(M,K), past(M).
% For the coverage sheet: an impediment formulated as a ground
ground_engaged(M,impediment(K)) :- ground_at_issue(M,impediment(K)), impediment(M,K), not validly_dispensed(M,K).
ground_engaged_by(M,impediment(K),N) :- ground_engaged(M,impediment(K)), impediment_by(M,K,N).
