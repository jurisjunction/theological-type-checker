layer canon

```clingo
% ===================================================================
%  The Eastern Code as rules: a second canon layer (TTC-CCEO)
%
%  The Code of Canons of the Eastern Churches, given 18 October 1990
%  (Sacri canones), in force from 1 October 1991; its penal title revised by
%  Vocare peccatores (20 March 2023), in force from 29 June 2023. The same
%  discipline as canon_law.lp: binary, dated, each canon under @norm. The
%  teaching above is shared; only the law differs (rule 1). The Churches of
%  East and West are "of equal dignity" (OE 3): siblings, not a patch. The
%  Churches sui iuris keep their rites (CCC 1203); ascription selects the
%  code (canon_law.lp: c. 111 with CCEO c. 29 §1), and the Eastern canons
%  bind only the Eastern faithful (c. 1), save where a canon reaches the
%  Latin Church by name (c. 696 §1). Who is bound to merely ecclesiastical
%  law is c. 11's rule in both codes (CCEO c. 1490).
%
%  Penalties are imposed by penal trial or decree (c. 1402), never incurred
%  by the deed: an Eastern delict is never "presumed incurred".
%
%  Texts: the Latin of vatican.va where read (c. 1; c. 29 §1; c. 1436 §1 of
%  2023; Sacri canones); the English of Ad tuendam fidem for c. 1436 §§1-2 as
%  of 1998; cc. 696, 828, 834 §2 in English translation. Not read here:
%  c. 1450 §2's text and grade, c. 1459 §1's wording (its penalty,
%  deposition, from secondary sources), c. 1490, c. 1413 (TTC-CCEO SCORING).
% ===================================================================

```

slot competent_mandate(E: act)
  means "the episcopal ordination had the mandate of the competent authority (c. 1459 §1)"
  say "the ordination {E} had the competent authority's mandate"

```clingo

% The Code and the texts that changed it.
promulgated(cceo1990,19901018). vacatio_set(cceo1990,19911001).    % Sacri canones
enacted_by(cceo_text_1990,cceo1990).
part_of((cceo1459_1;cceo1436_1;cceo1450_2;cceo828;cceo834),cceo_text_1990).
enacted_by(cceo1436_2_text_1998,atf1998). part_of(cceo1436_2,cceo1436_2_text_1998).
part_of((cceo818;cceo819;cceo820;cceo821;cceo824;cceo825;cceo826),cceo_text_1990).   % consent (TTC-ROTA)

% ---------- Sacraments -------------------------------------------------------
```

norm cceo:696 | c. 696 §1: all presbyters of the Eastern Churches can validly administer this sacrament, either together with baptism or separately, to all the Christian faithful of any Church sui iuris, the Latin Church included; §2: the Eastern faithful receive it validly also from presbyters of the Latin Church, according to the faculties with which they are endowed (canon_law.lp, c. 882) | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf

```clingo
confirms_by_law_or_faculty(E) :- celebration(E,confirmation,P,_), priest(P), eastern_faithful(P).

```

norm cceo:818 | c. 818: "Sunt incapaces matrimonii celebrandi: 1° qui sufficienti usu rationis carent; 2° qui laborant gravi defectu discretionis iudicii circa iura et obligationes matrimoniales essentiales mutuo tradenda et acceptanda; 3° qui ob causas naturae psychicae obligationes matrimonii essentiales assumere non possunt" | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_codex-can-eccl-orient-2.html

```clingo
% Consent, cc. 818-826 (TTC-ROTA): the claims of canon_law.lp's consent canons,
% read by the Eastern faithful's own code (c. 1) from 1 October 1991. Where the
% codes say the same, the Eastern canon is the Latin ground's twin
% (same_ground/2, below); where they differ (conditions), only the party's code
% reads. Before 1991 an Eastern party's consent fell under Crebrae allatae
% (1949), not encoded: no_eastern_code_in_force is raised (below).
eastern_consent_read(M,P) :- spouse(M,P), eastern_faithful(P), marriage(M,_,T), norm_in_force(cceo818,T).
consent_vitiated_by(M,cceo818_1) :- eastern_consent_read(M,P), removes_voluntary(P,M,no_reason).
consent_vitiated_by(M,cceo818_2) :- eastern_consent_read(M,P), interior(P,M,discretion(grave_defect)).
consent_vitiated_by(M,cceo818_3) :- eastern_consent_read(M,P), interior(P,M,incapacity(assume_obligations,psychic)).
```

norm cceo:819 | c. 819: "Ut consensus matrimonialis haberi possit, necesse est, ut matrimonium celebrantes saltem non ignorent matrimonium esse consortium permanens inter virum et mulierem ordinatum ad filios cooperatione aliqua sexuali procreandos" | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_codex-can-eccl-orient-2.html

```clingo
consent_vitiated_by(M,cceo819) :- eastern_consent_read(M,P), ignorance(P,M,fact(nature_of_marriage),_).
```

norm cceo:820 | c. 820 §1: "Error in persona invalidum reddit matrimonium"; §2: "Error in qualitate personae, etsi dat causam matrimonio, matrimonium non dirimit, nisi haec qualitas directe et principaliter intenditur" | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_codex-can-eccl-orient-2.html

```clingo
consent_vitiated_by(M,cceo820_1) :- eastern_consent_read(M,P), interior(P,M,error_of(person)).
consent_vitiated_by(M,cceo820_2) :- eastern_consent_read(M,P), interior(P,M,error_of(quality(Q))), intended(P,M,quality(Q)).
```

norm cceo:821 | c. 821: "Qui matrimonium celebrat deceptus dolo ad obtinendum consensum patrato circa aliquam alterius partis qualitatem, quae sua natura consortium vitae coniugalis graviter perturbare potest, invalide celebrat" | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_codex-can-eccl-orient-2.html

```clingo
% One question of law for both codes: whether deceit vitiates consent by its
% nature. For an Eastern marriage before 1991 the same reading branches (the
% question is put below, outside both canons).
cceo821_reaches(M,P) :- eastern_consent_read(M,P), marriage(M,_,T), norm_in_force(cceo821,T).
cceo821_reaches(M,P) :- spouse(M,P), eastern_faithful(P), read_for(c1098,declarative_of_natural_law,M).
consent_vitiated_by(M,cceo821) :- deceived_to_consent(M,P,Q), quality_gravely_disturbs(Q), cceo821_reaches(M,P).
```

norm cceo:824 | c. 824 §1: "Internus animi consensus praesumitur conformis verbis vel signis in celebrando matrimonio adhibitis"; §2: "Sed si alterutra vel utraque pars positivo voluntatis actu excludit matrimonium ipsum vel matrimonii essentiale aliquod elementum vel essentialem aliquam proprietatem, invalide matrimonium celebrat" | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_codex-can-eccl-orient-2.html

```clingo
consent_vitiated_by(M,cceo824_total)      :- eastern_consent_read(M,P), excludes(P,M,matrimony).
consent_vitiated_by(M,cceo824_prolis)     :- eastern_consent_read(M,P), excludes(P,M,bonum_prolis).
consent_vitiated_by(M,cceo824_fidei)      :- eastern_consent_read(M,P), excludes(P,M,bonum_fidei).
consent_vitiated_by(M,cceo824_sacramenti) :- eastern_consent_read(M,P), excludes(P,M,bonum_sacramenti).
consent_vitiated_by(M,cceo824_coniugum)   :- eastern_consent_read(M,P), excludes(P,M,bonum_coniugum).
consent_vitiated_by(M,cceo824_element)    :- eastern_consent_read(M,P), excludes(P,M,essential_element(_)).
consent_vitiated_by(M,cceo824_property)   :- eastern_consent_read(M,P), excludes(P,M,essential_property(_)).
```

norm cceo:825 | c. 825: "Invalidum est matrimonium celebratum ob vim vel metum gravem ab extrinseco etiam inconsulto incussum, a quo ut quis se liberet, eligere cogatur matrimonium" | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_codex-can-eccl-orient-2.html

```clingo
consent_vitiated_by(M,cceo825) :- eastern_consent_read(M,P), removes_voluntary(P,M,violence).
consent_vitiated_by(M,cceo825) :- eastern_consent_read(M,P), actus_humanus(P,M), grave_fear(P,M), fear_from_without(P,M), chosen_to_escape(P,M).
```

norm cceo:826 | c. 826: "Matrimonium sub condicione valide celebrari non potest" | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_codex-can-eccl-orient-2.html

```clingo
% The Eastern tradition admits no condition, past, present or future, and
% fulfilment is not read. This is where the codes part.
consent_vitiated_by(M,cceo826) :- eastern_consent_read(M,P), condition(_,M,P,_).
```

norm cceo:828 | c. 828 §1: only those marriages are valid which are celebrated with a sacred rite, in the presence of the local hierarch, local parish priest, or a priest given the faculty of blessing the marriage by either, and at least two witnesses; §2: the intervention of a priest who assists and blesses is the sacred rite. In the Eastern tradition the priests are witnesses to the consent, and their blessing is necessary for validity (CCC 1623) | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf

```clingo
priest_required_by(M,cceo828) :- marriage(M,_,T), spouse(M,P), eastern_faithful(P), norm_in_force(cceo828,T).

```

norm cceo:834 | c. 834 §2: if a Catholic party ascribed to an Eastern Church marries one who belongs to an Eastern non-Catholic Church, the form is to be observed only for liceity; for validity the blessing of a priest is required, other requirements of law observed | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf

```clingo
liceity_only(M) :- spouse(M,P), eastern_faithful(P), spouse(M,Q), eastern_noncatholic(Q), marriage(M,_,T), norm_in_force(cceo834,T).

% ---------- Penal sanctions (Title XXVII) -----------------------------------
```

norm cceo:1459 | c. 1459 §1: bishops who without a mandate of the competent authority ordained someone a bishop, and the one who received the ordination from them, are to be punished with deposition (unchanged by Vocare peccatores, 2023) | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf

```clingo
eastern_delict(B,cceo1459_1,E) :- consecrates(E,B), event_date(E,T), not pontifical_mandate(E), not competent_mandate(E),
                                  eastern_faithful(B), norm_in_force(cceo1459_1,T).
eastern_delict(R,cceo1459_1,E) :- consecration(E,_,R,T), not pontifical_mandate(E), not competent_mandate(E),
                                  eastern_faithful(R), norm_in_force(cceo1459_1,T).
penalty(cceo1459_1,deposition).

```

norm cceo:1436 | c. 1436 §1: whoever denies a truth which must be believed with divine and catholic faith, or calls it into doubt, or totally repudiates the Christian faith, and does not retract after having been legitimately warned, is to be punished as a heretic or an apostate with a major excommunication (the text of 1998 and of 2023) | https://www.vatican.va/content/john-paul-ii/en/motu_proprio/documents/hf_jp-ii_motu-proprio_30061998_ad-tuendam-fidem.html

```clingo
% The obstinacy is outward here: warned, and not retracting. No claim of
% pertinacity is read (rule 3).
eastern_delict(P,cceo1436_1,E) :- professes(P,E,_,_), heresy_matter(E), warned(P,E,_), not retracted(P,E),
                                  eastern_faithful(P), event_date(E,T), norm_in_force(cceo1436_1,T).
eastern_delict(P,cceo1436_1,E) :- doubts(P,E,_), heresy_matter(E), warned(P,E,_), not retracted(P,E),
                                  eastern_faithful(P), event_date(E,T), norm_in_force(cceo1436_1,T).
eastern_delict(P,cceo1436_1,E) :- repudiates(P,E,christian_faith), warned(P,E,_), not retracted(P,E),
                                  eastern_faithful(P), event_date(E,T), norm_in_force(cceo1436_1,T).
penalty(cceo1436_1,major_excommunication).

```

norm atf1998:cceo1436 | c. 1436 §2 (as amended by Ad tuendam fidem, 1998): in addition to these cases, whoever obstinately rejects a teaching that the Roman Pontiff or the College of Bishops, exercising the authentic Magisterium, have set forth to be held definitively, or who affirms what they have condemned as erroneous, and does not retract after having been legitimately warned, is to be punished with an appropriate penalty | https://www.vatican.va/content/john-paul-ii/en/motu_proprio/documents/hf_jp-ii_motu-proprio_30061998_ad-tuendam-fidem.html

```clingo
eastern_delict(P,cceo1436_2,E) :- obstinate_rejection(P,E,c750_2), eastern_faithful(P), event_date(E,T), norm_in_force(cceo1436_2,T).
penalty(cceo1436_2,just_penalty).

```

norm cceo:1450 | c. 1450 §2: one who procured an abortion, the effect following, is to be punished with excommunication, imposed, not incurred (the grade and wording not read here) | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf

```clingo
% "Abortion" read as the Latin legislator's response of 1988 reads it, the
% killing from conception: the canonists' reading of the Eastern term too,
% not branched (as TTC-PENAL AB8).
eastern_delict(P,cceo1450_2,A) :- procures(P,A), killing_of_unborn(A), not attempted_only(A), eastern_faithful(P),
                                  event_date(A,T), norm_in_force(cceo1450_2,T).
penalty(cceo1450_2,excommunication).

```

norm cceo:1402 | c. 1402 (as revised, 2023): a canonical penalty is imposed by the penal trial of cc. 1468-1482, or, where grave causes stand in the way of a trial, by extra-judicial decree | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf

```clingo
to_be_imposed(P,N,E) :- eastern_delict(P,N,E).
```

end

```clingo
info(eastern_delict(P,N,E)) :- eastern_delict(P,N,E), past(E).
% An Eastern act before 1 October 1991 falls under no encoded code; the Latin
% delicts do not reach the Eastern faithful (c. 1).
eastern_act(P,E) :- consecrates(E,P).
eastern_act(P,E) :- consecration(E,_,P,_).
eastern_act(P,E) :- procures(P,E).
eastern_act(P,E) :- professes(P,E,_,_).
eastern_act(P,E) :- repudiates(P,E,_).
eastern_act(P,M) :- spouse(M,P).
needs_reading(c1098,M) :- deceit(_,_,P,M,_), spouse(M,P), eastern_faithful(P), marriage(M,_,T), not norm_in_force(cceo821,T).
info(no_eastern_code_in_force(P,E)) :- eastern_act(P,E), eastern_faithful(P), event_date(E,T), not force_at(cceo1990,T).
% The consent grounds across the codes: the Latin canon a tribunal formulates,
% and its Eastern twin (canon_law.lp reads same_ground/2). c. 1102 has no twin
% of its own content: CCEO c. 826 answers both its paragraphs.
same_ground(n1095_1,cceo818_1). same_ground(n1095_2,cceo818_2). same_ground(n1095_3,cceo818_3).
same_ground(n1096,cceo819). same_ground(n1097_1,cceo820_1). same_ground(n1097_2,cceo820_2).
same_ground(n1098,cceo821). same_ground(n1103,cceo825).
same_ground(n1101_total,cceo824_total). same_ground(n1101_prolis,cceo824_prolis). same_ground(n1101_fidei,cceo824_fidei).
same_ground(n1101_sacramenti,cceo824_sacramenti). same_ground(n1101_coniugum,cceo824_coniugum).
same_ground(n1101_element,cceo824_element). same_ground(n1101_property,cceo824_property).
same_ground(n1102_1,cceo826). same_ground(n1102_2,cceo826).
```
