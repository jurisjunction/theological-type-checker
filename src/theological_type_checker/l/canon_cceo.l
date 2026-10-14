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

slot competent_mandate/1
  means "the episcopal ordination had the mandate of the competent authority (c. 1459 §1)"

```clingo

% The Code and the texts that changed it.
promulgated(cceo1990,19901018). vacatio_set(cceo1990,19911001).    % Sacri canones
enacted_by(cceo_text_1990,cceo1990).
part_of((cceo1459_1;cceo1436_1;cceo1450_2;cceo828;cceo834),cceo_text_1990).
enacted_by(cceo1436_2_text_1998,atf1998). part_of(cceo1436_2,cceo1436_2_text_1998).

% ---------- Sacraments -------------------------------------------------------
```

norm cceo:696 | c. 696 §1: all presbyters of the Eastern Churches can validly administer this sacrament, either together with baptism or separately, to all the Christian faithful of any Church sui iuris, the Latin Church included; §2: the Eastern faithful receive it validly also from presbyters of the Latin Church, according to the faculties with which they are endowed (canon_law.lp, c. 882) | https://www.vatican.va/content/john-paul-ii/la/apost_constitutions/documents/hf_jp-ii_apc_19901018_index-codex-can-eccl-orient.pdf

```clingo
confirms_by_law_or_faculty(E) :- celebration(E,confirmation,P,_), priest(P), eastern_faithful(P).

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
info(no_eastern_code_in_force(P,E)) :- eastern_act(P,E), eastern_faithful(P), event_date(E,T), not force_at(cceo1990,T).
```
