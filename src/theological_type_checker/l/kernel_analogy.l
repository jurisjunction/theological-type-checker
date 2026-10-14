layer kernel

-- Sorts first used in this layer (TTC-L, TY): closed, then open

sort perfection
  means "a perfection or predicate said by analogy"

```clingo
% ===================================================================
%  Analogy (A11): nothing crosses the Creator-creature line except
%  through a declared bridge. Lateran IV (DH 806): between Creator and
%  creature no similarity can be noted without a greater dissimilarity.
%
%  bridge(Form, Primary, Secondary)
%     Form is said first of the primary analogate and of the secondary by
%     participation (per prius et posterius, ST I q.13 a.6). The primary
%     is always God; a bridge with the creature as primary is projection.
%  mode(Form, Sort, Mode)
%     what the shared form is on each side. A bridge with no mode on a
%     side licenses nothing on that side.
% ===================================================================

```

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot drop_bridge(F: perfection)
  means "drop_bridge(F): the bridge F withdrawn (an ablation)"
  say "the bridge {F} is withdrawn"

slot univocal_mode(F: perfection, M: category)
  means "univocal_mode(F, M): F said in one mode M of God and of creatures"
  say "{F} is said in the one mode {M} of God and of creatures"

slot unlicensed(F: perfection, S: category)
  means "unlicensed(F, S): the predicate F denied its license in domain S"
  say "{F} is denied its license in the domain {S}"

```clingo

ind_sort(X,div) :- divine(X).
ind_sort(X,div) :- god(X).
ind_sort(X,cr)  :- creature(X).

bridge(creation,    div, cr) :- not drop_bridge(creation).
bridge(origination, div, cr) :- not drop_bridge(origination).
bridge(acyclicity,  div, cr) :- not drop_bridge(acyclicity).

mode(creation,div,unreceived).            mode(creation,cr,received).          % A1: the analogia entis itself
mode(origination,div,eternal_procession). mode(origination,cr,temporal_generation).
% The principle and grain bridges belong to the Grammar of the Icon
% (icon_theory.lp): they carry its analogy of one principle into creatures.
% univocity of mode: one mode on both sides (a stress test)
univocal(F) :- univocal_mode(F,_).
mode(F,div,M) :- univocal_mode(F,M).
mode(F,cr,M)  :- univocal_mode(F,M).
% God is under no norm: a deontic mode never lands on the divine side
violation(deontic_in_god(F)) :- mode(F,div,norm).
mode(acyclicity,div,necessity).           mode(acyclicity,cr,necessity).

licensed(F,S) :- bridge(F,S,_), mode(F,S,_), not unlicensed(F,S).
licensed(F,S) :- bridge(F,_,S), mode(F,S,_), not unlicensed(F,S).

violation(projection(F))            :- bridge(F,cr,div).
violation(bridge_without_mode(F,S)) :- bridge(F,S,_), not mode(F,S,_).
violation(bridge_without_mode(F,S)) :- bridge(F,_,S), not mode(F,S,_).

% ---------- Crossing guards: creaturely predicates never land on God ----
crosses(received_being,X) :- being(_,X), ind_sort(X,div).
crosses(finite,X)         :- finite(X), ind_sort(X,div).
crosses(temporal_generation,Z) :- orig_cr(_,Z), ind_sort(Z,div).
crosses(eternal_procession,Z)  :- orig_div(_,Z), ind_sort(Z,cr).
violation(unlicensed_crossing(R,X)) :- crosses(R,X).

% ---------- Sort table for the static crossing check (engine.lint) -----
% Each layer registers the sorts of its own predicates; the theory's are in
% icon_theory.lp.
% A rule whose body uses a divine-sorted and a creature-sorted predicate
% must go through licensed/2, mode/3 or bridge/3, unless it is a check
% (violation, crosses, info, theorem). Hypostatic predicates (the
% incarnate Word) may meet both sides: the communicatio idiomatum (T5)
% is the bridge in person.
sort_of(god,div). sort_of(divine,div). sort_of(one_power,div). sort_of(orig_div,div).
sort_of(consubstantial,div).
sort_of(creature,cr). sort_of(created_person,cr). sort_of(organism,cr). sort_of(orig_cr,cr).
sort_of(acts,cr). sort_of(finite,cr). sort_of(equal_dignity,cr).
sort_of(inanimate,cr). sort_of(angel,cr). sort_of(human,cr).
sort_of(incarnate,hypostatic).
```
