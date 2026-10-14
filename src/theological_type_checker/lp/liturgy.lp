% ===================================================================
%  The liturgy: witness, rite and development (TTC-LITURGY)
%
%  "Nam Liturgia constat parte immutabili, utpote divinitus instituta, et
%  partibus mutationi obnoxiis" (SC 21; CCC 1205). Three faces:
%
%  A witness. One book, two sources: the act that gives it is governance
%  (juridical, at the tier of its form); the prayer it holds is a witness
%  (`liturgical_witness/1`, force truth, at the tier of the authority that
%  approves it, of the character `liturgy`). The prayer weighs and never
%  fixes: "Lex credendi legem statuat supplicandi" (Mediator Dei 48); the
%  liturgy "catholicam fidem absolute suaque vi non designat neque
%  constituit", but "argumenta ac testimonia suppeditare potest". Its
%  not cleaving, and its being owed nothing as a teaching act, are rules of
%  icon_authority.lp. "The Church believes as she prays" (CCC 1124): a
%  universal prayer shows three of LG 25's conditions for a claim of the
%  ordinary universal magisterium about its content, never the fourth.
%  Each witness carries Vincent of Lérins' measure, "quod ubique, quod
%  semper, quod ab omnibus" (Commonitorium 2): reported, never a verdict.
%
%  A rite. "Salva illorum substantia" (Trent, sess. XXI, ch. 2, DH 1728): a
%  change by the competent authority stands where the condition it changes
%  is the Church's, and is refused where it belongs to the substance, even
%  from the supreme authority (CCC 1125). Which conditions are of the
%  substance is the theological side's (sacrament_conditions; pair.lp).
%
%  A development. Rites descend from rites (`derives_from/2`): an order,
%  not a line. The order refuses a rite descending from a later one, or
%  from itself. "Organice quodammodo crescant" (SC 23) has no authentic
%  interpretation; the reform read as continuity or rupture is a question
%  on the authority graph, and no theory of development is encoded here.
%
%  What binds and what lasts. Law and teaching say what binds. That an
%  element is loved gives it no authority, and that law sets it aside says
%  nothing of its end (GS 39: the last things). Love is interior and never
%  read (rule 3).
%
%  @library  (read by norms.py: its predicates count as defined)
% ===================================================================

% @input liturgy_shows/1 | liturgy_shows(C): a condition of LG 25 a universal prayer shows
% @input liturgical_witness/1 | the prayer a liturgical book holds, entered as a witness (a source)
% @input fixes/2 | candidate only: fixes(Witness, Q), a liturgy treated as settling a doctrinal question
% @input rests_on_liturgy/2 | rests_on_liturgy(Claim, Witness): a claim of the ordinary universal magisterium argued from a prayer
% @input universal_witness/1 | the prayer is in the books of the universal Church, approved by bishops in communion with the Roman Pontiff
% @input prayed_in/2 | prayed_in(Witness, Church): a Church that prays it
% @input in_use_from/2 | in_use_from(Witness, Year)
% @input prayed_by/2 | prayed_by(Witness, bishops | faithful)
% @input changes/2 | changes(Act, Witness): a change by competent authority to a prayed element
% @input changes_condition/3 | changes_condition(Act, Sacrament, Condition): a liturgical book changes a condition of a sacrament
% @input derives_from/2 | derives_from(Rite, Parent): a rite descending from another
% @input binds_because/2 | candidate only: binds_because(Element, Ground), an element typed as binding on this ground
% @input oum_claim/2 | icon_authority.lp
% @input of_kind/2 | pair.lp
% @input not_of_kind/2 | pair.lp
% @input year_of/2 | sources.lp
% @input now/1 | saeculum.lp

% ---------- The witness and the ordinary universal magisterium -------------
% A universal prayer shows three of LG 25's conditions, apart from the
% claimant's word; it never shows "one position held as definitive": a
% collect proposes nothing to be held definitively (LW8).
liturgy_shows(dispersed_in_communion;authentic_teaching;faith_or_morals).
condition_shown(S,C) :- oum_claim(S,_), rests_on_liturgy(S,W), universal_witness(W), liturgical_witness(W), liturgy_shows(C).
violation(lex_orandi_as_fixing(W,Q)) :- fixes(W,Q), liturgical_witness(W).

% ---------- Vincent's measure: reported, never a verdict -------------------
churches_praying(W,N) :- liturgical_witness(W), prayed_in(W,_), N = #count{ C : prayed_in(W,C) }.
years_in_use(W,Y)     :- in_use_from(W,F), now(T), Y = T/10000 - F, Y >= 0.
prayed_by_all(W)      :- prayed_by(W,bishops), prayed_by(W,faithful).
info(measure(W,N,F,all))  :- churches_praying(W,N), in_use_from(W,F), prayed_by_all(W).
info(measure(W,N,F,some)) :- churches_praying(W,N), in_use_from(W,F), not prayed_by_all(W).
info(years_in_use(W,Y))   :- years_in_use(W,Y).
% A change by competent authority to a long-kept element stands; its
% measure is set beside it. Whether the good of the Church "genuinely and
% certainly" requires it (SC 23) is the legislator's judgment, supplied.
info(change_to_long_use(A,W,N,F)) :- changes(A,W), churches_praying(W,N), in_use_from(W,F).

% ---------- The rite: the substance kept, the rest law ---------------------
violation(change_to_substance(A,K,C)) :- changes_condition(A,K,C), of_kind(cond(K,C),of_substance).
info(change_stands(A,K,C))            :- changes_condition(A,K,C), not_of_kind(cond(K,C),of_substance).

% ---------- Development: rites in an order, not a line ---------------------
descends(R,P) :- derives_from(R,P).
descends(R,Q) :- derives_from(R,P), descends(P,Q).
violation(rite_descends_from_itself(R)) :- descends(R,R).
violation(rite_from_later(R,P)) :- derives_from(R,P), year_of(R,YR), year_of(P,YP), YR < YP.
info(rite_of_many_parents(R)) :- derives_from(R,P1), derives_from(R,P2), P1 < P2.

% ---------- What binds and what lasts --------------------------------------
violation(binding_by_love(E)) :- binds_because(E,loved).
