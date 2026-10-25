% Personal layer: juridic persons (cc. 114-117, 1257 §2) and two duties of
% clerics (cc. 285 §4, 286). Written 25 Oct 2026 for one case; not the base.
% @input aggregate/2 | aggregate(E, persons | things): an aggregate seeking juridic personality (c. 115)
% @input end_of/2 | end_of(E, End): the end its statutes or articles give it
% @input end_kind/2 | end_kind(End, K): piety, apostolate, charity, or gain_of_members (an interpretation, entered)
% @input distributes_gain/1 | distributes_gain(E): E distributes its surplus to its members or holders
% @input judged_useful_and_sufficient/2 | judged_useful_and_sufficient(A, E): c. 114 §3, the authority's judgment, supplied and never computed
% @input statutes_approved/2 | statutes_approved(E, A): c. 117
% @input decree_of_personality/4 | decree_of_personality(D, A, E, express): c. 116 §2
% @input competent_for/2 | competent_for(A, E): the authority competent to erect E
% @input civil_corporation/1 | civil_corporation(E): a corporation of a civil order
% @input civil_twin_of/2 | civil_twin_of(E, J): E is the civil corporation whose by-laws mirror the statutes of J
% @input office/3 | office(P, E, K): P holds the office K in E
% @input entails_accounts/2 | entails_accounts(E, K): the office K in E involves the obligation to render an account
% @input trades_for_gain/1 | trades_for_gain(E): E practises commerce or trade for gain
% @input holds_shares/2 | holds_shares(P, E)
% @input licence/3 | licence(P, N, A): the permission norm N asks for, given by A

% Where a reading decides. As in canon_law.lp, these stand outside any norm,
% so the choice of reading (c. 17) and the canon that reads it make no loop
% in the norm graph (CL1).
needs_reading(c285_4,office(P,E,K)) :- cleric(P), office(P,E,K), entails_accounts(E,K), canonical_twin(E).
needs_reading(c286,office(P,E,K)) :- cleric(P), office(P,E,K), trades_for_gain(E).

% @norm cic:114 | c. 114 §1: juridic persons are constituted by law or by special grant of competent authority given through a decree, aggregates of persons or things ordered for a purpose congruent with the mission of the Church which transcends the purpose of the individuals; §2: works of piety, of the apostolate, or of charity, spiritual or temporal; §3: conferred only on aggregates with a truly useful purpose and means foreseen to be sufficient | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann96-123_en.html
c114_2_kind(piety). c114_2_kind(apostolate). c114_2_kind(charity).
end_c114_2(E) :- end_of(E,End), end_kind(End,K), c114_2_kind(K).
% "finem qui singulorum finem transcendit", by the proper meaning of the words
% (c. 17): an aggregate whose surplus goes to its members has their end,
% whatever end its articles state.
not_transcending(E) :- distributes_gain(E).
not_transcending(E) :- end_of(E,End), end_kind(End,gain_of_members).
capable_114(E) :- aggregate(E,_), end_c114_2(E), not not_transcending(E).
info(personality_barred(E,c114_1)) :- aggregate(E,_), not_transcending(E).
info(personality_barred(E,c114_2)) :- aggregate(E,_), not end_c114_2(E).
info(awaits(E,judgment_c114_3))    :- capable_114(E), not judged_useful_and_sufficient(_,E).

% @norm cic:117 | c. 117: no aggregate of persons or things intending to obtain juridic personality can acquire it unless competent authority has approved its statutes | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann96-123_en.html
info(awaits(E,statutes_c117)) :- capable_114(E), not statutes_approved(E,_).

% @norm cic:116 | c. 116 §2: private juridic persons obtain this personality only through a special decree of competent authority expressly granting it | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann96-123_en.html
private_juridic_person(E) :- capable_114(E), competent_for(A,E), judged_useful_and_sufficient(A,E),
                             statutes_approved(E,A), decree_of_personality(_,A,E,express).
info(awaits(E,decree_c116_2)) :- capable_114(E), not private_juridic_person(E).
juridic_person(E) :- private_juridic_person(E).
juridic_person(E) :- civil_corporation(E).
violation(personality_without_capacity(E,D)) :- decree_of_personality(D,_,E,_), not capable_114(E).

% @norm cic:1257 | c. 1257 §2: the temporal goods of a private juridic person are governed by its own statutes, and not by these canons unless expressly provided otherwise | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib5-cann1254-1310_en.html
info(goods_governed_by_statutes(E)) :- private_juridic_person(E).

% @norm cic:285_4 | c. 285 §4: without the permission of their Ordinary, clerics may not undertake the administration of goods belonging to lay people or secular offices which involve the obligation to render an account | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib2-cann273-289_en.html
% Whether an office in the civil twin of a canonical juridic person is
% "saecular" is read two ways: by its civil form (it is), or by its substance
% (it is the canonical person's own administration, and is not).
restricts_rights(c285_4).
reading_option(c285_4,civil_form). reading_option(c285_4,by_substance).
narrower(by_substance,civil_form).
canonical_twin(E) :- civil_twin_of(E,J), private_juridic_person(J).
secular_office(P,E,K) :- office(P,E,K), civil_corporation(E), not canonical_twin(E).
secular_office(P,E,K) :- office(P,E,K), canonical_twin(E), read_for(c285_4,civil_form,office(P,E,K)).
needs_permission(P,c285_4,E) :- cleric(P), secular_office(P,E,K), entails_accounts(E,K).
info(permission_needed(P,c285_4,E)) :- needs_permission(P,c285_4,E), not licence(P,c285_4,_).
info(permission_held(P,c285_4,E))   :- needs_permission(P,c285_4,E), licence(P,c285_4,_).
info(not_reached(P,c285_4,E))       :- cleric(P), office(P,E,K), entails_accounts(E,K), not needs_permission(P,c285_4,E).

% @norm cic:286 | c. 286: clerics are forbidden to practise commerce or trade, either personally or through another, for their own or another's benefit, except with the permission of the lawful ecclesiastical authority | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib2-cann273-289_en.html
% Whether one who governs a corporation that trades practises its trade
% "per alios" is read two ways: he does (governs_trade), or the trade is the
% corporation's own and reaches him only where he trades himself (own_trade).
% Holding its shares is practising trade on neither reading.
restricts_rights(c286).
reading_option(c286,governs_trade). reading_option(c286,own_trade).
narrower(own_trade,governs_trade).
practises_trade(P,E) :- cleric(P), office(P,E,K), trades_for_gain(E), read_for(c286,governs_trade,office(P,E,K)).
info(permission_needed(P,c286,E)) :- practises_trade(P,E), not licence(P,c286,_).
info(permission_held(P,c286,E))   :- practises_trade(P,E), licence(P,c286,_).
info(not_reached(P,c286,office(E,K))) :- cleric(P), office(P,E,K), trades_for_gain(E), not practises_trade(P,E).
info(not_reached(P,c286,shares(E)))   :- cleric(P), holds_shares(P,E).
info(not_reached(P,c286,office(E,K))) :- cleric(P), office(P,E,K), not trades_for_gain(E).
