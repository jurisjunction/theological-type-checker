layer libraries

```clingo
% ===================================================================
%  The last things (TTC-NOVISSIMA)
%
%  "Memorare novissima tua" (Sir 7:36). What follows death is an order of
%  stages, kinds and not persons: dying; purification; the vision; hell;
%  rising; and, from the kernel's economy, the return and the judgment. An
%  order between two stages is given by a source at tier 1 in force
%  (gives_order/3), so the order is dated: Lateran IV (1215, DH 801),
%  Benedictus Deus (1336, DH 1000-1002; CCC 1023), Florence (1439,
%  DH 1304-1306), Lateran V (1513, DH 1440). Two judgments: each soul's
%  destiny at death (CCC 1022), all at the end (CCC 1059). A theory of
%  what follows death is entered as the order it claims, and refused by
%  what is in force at the evaluation date.
%
%  One soul, one body: all rise "cum suis propriis ... corporibus, quae
%  nunc gestant" (DH 801); "there is no 'reincarnation' after death"
%  (CCC 1013). The end arrives early in Christ, the firstfruits (1 Cor
%  15:20), and in Mary, "exempted from this general rule" (Munificentissimus
%  Deus 5; CCC 966).
%
%  Nothing after death is measured by the calendar: "we cannot calculate
%  the 'duration' of this transforming burning in terms of the chronological
%  measurements of this world" (Spe salvi 47; CCC 1031). A soul after death
%  carries Thomas's measures (ST I q. 10 a. 5 ad 1), as the angels do: the
%  aevum for its being, a share in eternity for the vision of glory.
%
%  No one's state is computed (rule 3). Hell and its eternity are taught
%  (CCC 1035); "God predestines no one to go to hell" (CCC 1037), and no
%  rule places anyone there. The Church's act of canonization says that a
%  person is in glory: the act is recorded, its tier computed from its form.
%
%  What lasts. "The visible universe, then, is itself destined to be
%  transformed" (CCC 1047). Christ's flesh, taken from Mary, and Mary's body
%  are in glory already: "nothing of this world carried over" is refused.
%  Which things charity carries to the end (GS 39, "manente caritate eiusque
%  opere") is a claim, computed both ways and never derived.
%
```

library

```clingo
% ===================================================================

```

slot gives_order/3
  means "gives_order(Source, A, B): the source gives stage A before stage B"

slot without_end/2
  means "without_end(Stage, Source): the source gives the stage without end"

use places/3 "places(Theory, A, B): a theory of what follows death places stage A before stage B"

slot ends_in/3
  means "ends_in(Theory, A, B): a theory ends stage A in stage B"

slot denies_subsistence/1
  means "a theory: no soul subsists after death"

slot gives_subsistence/1
  means "gives_subsistence(Source): the source defines the intellective soul immortal"

slot body_of/2
  means "body_of(Person, Body): a body the person's soul informs, as a case records it"

slot one_body_given/1
  means "one_body_given(Source): the source gives each soul its own body, the one it now bears"

slot raised/1
  means "a person raised to earthly life, a raising (Jn 11)"

slot rises_early/1
  means "a bodily rising before the return, claimed of a person"

slot general_rule_given/1
  means "general_rule_given(Source): the source gives the rising of bodies at the return"

use duration_claim/3 "duration_claim(Stage, N, Unit): a duration laid on a stage after death"

slot in_days/2
  means "canon_law.lp: in_days(Grant, N), an indulgence designated in days"

slot days_read_as/2
  means "days_read_as(Grant, time_after_death): a grant's days read as a duration after death"

slot separated_soul/1
  means "a human soul after death, entered as such"

slot placed_in/2
  means "placed_in(Person, hell | purification | glory): a case places a named person in a state after death"

slot nothing_carried_over/0
  means "candidate only: nothing of this world carried over to the end"

slot lasts_claim/2
  means "lasts_claim(Element, charity): a claim that charity carries the element to the end"

use in_force/1 "icon_authority.lp"

use eff_tier/2 "icon_authority.lp"

use supports/3 "icon_authority.lp"

use holds/2 "icon_authority.lp"

use incarnate/1 "the kernel"

use before/2 "the kernel's order"

use gen/3 "the kernel"

use in_nature/2 "the kernel"

use created_person/1 "the kernel"

```clingo

% ---------- The order given (NV1) ------------------------------------------
stage(dying;purification;vision;hell;rising;return;judgment).
given(A,B,S)      :- gives_order(S,A,B), in_force(S), eff_tier(S,1).
stage_before(A,B) :- given(A,B,_).
stage_before(A,C) :- given(A,B,_), stage_before(B,C).
endless(X,S)      :- without_end(X,S), in_force(S), eff_tier(S,1).
info(order_given(A,B,S)) :- given(A,B,S).
info(without_end(X,S))   :- endless(X,S).

% ---------- Theories placed on the order (NV2, NV5) ------------------------
% A theory is refused only by what is in force at the evaluation date.
places(T,A,B) :- ends_in(T,A,B).
violation(stage_unknown(T,X)) :- places(T,X,_), not stage(X).
violation(stage_unknown(T,X)) :- places(T,_,X), not stage(X).
violation(order_against_definition(T,A,B)) :- places(T,A,B), stage_before(B,A).
violation(end_of_the_endless(T,X))          :- ends_in(T,X,_), endless(X,_).
violation(soul_not_subsisting(T))           :- denies_subsistence(T), gives_subsistence(S), in_force(S), eff_tier(S,1).

% ---------- One soul, one body (NV3) -----------------------------------------
% A raising returns a soul to its own body; no rule counts deaths.
one_body_in_force :- one_body_given(S), in_force(S), eff_tier(S,1).
two_bodies(P)     :- body_of(P,B1), body_of(P,B2), B1 != B2.
violation(soul_in_two_bodies(P))  :- two_bodies(P), one_body_in_force.
info(raised_to_own_body(P))       :- raised(P), body_of(P,_), not two_bodies(P).

% ---------- The end arriving early (NV4) -------------------------------------
% Bodily glorification belongs to the rising at the return, by the general
% rule; Christ rose before it, and Mary was exempted from it (DH 3903).
end_early(P)    :- incarnate(P), before(resurrection,return).
end_early(mary) :- holds(q(assumption),yes).
info(end_early(P)) :- end_early(P).
general_rule    :- general_rule_given(S), in_force(S), eff_tier(S,1).
violation(rising_before_the_return(P)) :- rises_early(P), not end_early(P), general_rule.

% ---------- Never measured by the calendar (DU) ------------------------------
% The rising is at the return: never dated (saeculum.lp). The former days
% of indulgences measured the canonical penance of the earth; read as a
% duration after death, they are refused with every such measure.
end_event(rising).
after_death(purification;vision;hell).
calendar_unit(days;years).
duration_claim(purification,N,days) :- in_days(G,N), days_read_as(G,time_after_death).
violation(after_death_measured(X,N,U)) :- duration_claim(X,N,U), after_death(X), calendar_unit(U).
info(days_of_canonical_penance(G,N))   :- in_days(G,N).
measure(X,aevum) :- separated_soul(X).            % Thomas's, carried as his (saeculum.lp)
begins(X)        :- separated_soul(X).
info(share_in_eternity(X)) :- measure(X,share_of_eternity).

% ---------- No one's state computed (NS; rule 3) -----------------------------
state_after_death(hell;purification;glory).
canonized(P,S) :- supports(S,q(in_glory(P)),yes), in_force(S), eff_tier(S,T), T <= 2.
violation(state_after_death_placed(P,X))     :- placed_in(P,X), state_after_death(X), X != glory.
violation(state_after_death_placed(P,glory)) :- placed_in(P,glory), not canonized(P,_).
info(in_glory_by_the_act(P,S))               :- placed_in(P,glory), canonized(P,S).

% ---------- What lasts (WL) --------------------------------------------------
of_this_world(P) :- created_person(P).
of_this_world(P) :- gen(G,M,P), in_nature(G,hum), created_person(M).
violation(glorified_annihilated(P)) :- nothing_carried_over, end_early(P), of_this_world(P).
{ carried(E) } :- lasts_claim(E,charity).
assumed_fact(carried(E))        :- lasts_claim(E,charity), carried(E).
assumed_fact(false(carried(E))) :- lasts_claim(E,charity), not carried(E).
info(carried_on_the_claim(E))   :- carried(E).
```
