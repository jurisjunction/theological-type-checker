layer schools

-- The runtimes (TTC-SCHOOLS; TTC-L, RU). Each is a school's parts loaded
-- whole; compiled to runtimes.json, which the engine reads.
runtime bare

runtime default
  add classical, one_power

runtime thomist extends default
  add th01, th03, th04, th05, th06, th21, th22, th24
  add simplicity_thomist, attributes_by_reason, mixed_relations, transcendentals
  add holds_premotion, one_place_circumscribed

runtime scotist extends default
  add simplicity_scotist, attributes_formal, univocity_of_concept, scotus_esse
  add mixed_relations, transcendentals

runtime suarezian extends default
  add simplicity_thomist, attributes_by_reason, suarez_esse, mixed_relations
  add transcendentals, holds_concurrence

runtime palamite extends default
  exclude one_power
  add simplicity_palamite, palamite_energies, monopatrism, no_divine_contraction
  add grace_uncreated

```clingo
% ===================================================================
%  School runtimes: the parts the four runtimes share or add. A runtime
%  is a named list of parts loaded whole (engine.RUNTIMES); its readings
%  of simplicity and the Theses are in icon_metaphysics.lp. Predictions
%  were committed and stamped first: docs/research/schools-preregistration.md.
%  The kernel holds none of this; with no runtime it runs bare.
% ===================================================================

```

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot foreseen/2
  means "foreseen(E, C): E caused by C as foreseen (merits foreseen)"

slot justification/2
  means "justification(P, A): the act in which P, moved by grace, assents to justification"

slot univocal_concept/1
  means "univocal_concept(F): F a concept said univocally of God and creatures (Scotus)"

slot virginally_conceived/1
  means "virginally_conceived(X): X conceived by the Holy Spirit, not by propagation"

part switch

```clingo
#program classical.               % agere sequitur esse: creatures act (ST I q.105 a.5; SCG III.69-70).
acts(X) :- creature(X).           % Common to the four runtimes; denied by occasionalism.
operates(X,hum) :- incarnate(X).  % Said of Christ's humanity too: two natural operations (DH 557).

```

part switch

```clingo
#program christs_humanity_operates.   % a runtime that grants one created operation only: that of
operates(X,hum) :- incarnate(X).      % Christ's humanity, which the deposit defines (TTC-CREED CR6)

```

part switch

```clingo
#program one_power.               % Lyons II defines one principle of the Spirit (DH 850); the Latin
                                  % account of it: one spirative power of Father and Son (ST I q.36 a.4).
one_power(X,Y) :- gen(spiration,X,Z), gen(spiration,Y,Z), divine(Z), X != Y.
divine_contraction(identity_of_power) :- not no_divine_contraction.
contractible(A,X,Y) :- divine_contraction(identity_of_power), gen(A,X,_), gen(A,Y,_), X != Y,
                       one_power(X,Y).

```

part switch

```clingo
#program univocity_of_concept.    % Scotus, Ord. I d.3 p.1 qq.1-3; d.8 p.1 q.3: one concept of being,
univocal_concept(being).          % said of God and creatures in quid; its intrinsic modes differ
bridge(being,div,cr).
mode(being,div,infinite).         mode(being,cr,finite).

```

part switch

```clingo
#program scotus_esse.             % Scotus, Ord. IV d.11 q.3: essence and existence not really distinct
esse_not_really_distinct.

```

part switch

```clingo
#program th04_predication.        % Th. 4 as worded: being is SAID analogically, not univocally
violation(univocity_against_th4(F)) :- univocal_concept(F), bridge(F,div,cr).   % a rule on predication

```

part switch

```clingo
#program holds_premotion.         % Th. 24's last clause read as physical premotion (Banez)
holds_reading(theses_1914,premotion).

```

part switch

```clingo
#program holds_concurrence.       % read as simultaneous concurrence (Molina; Suarez, DM 22)
holds_reading(theses_1914,concurrence).

```

part switch

```clingo
#program dh1330_deposit.          % Florence, Cantate Domino (DH 1330): "omnia sunt unum, ubi non obviat
distinction(opposition).          % relationis oppositio", read as deposit (TTC-SCHOOLS, encoding A).
                                  % As a Thomist reading it follows from simplicity_thomist (encoding B).

% Why Christ does not contract original sin (TTC-CREED EC1): the deposit says
% that he does not (DH 301), not why. Each reading supplies a slot.
```

part switch

```clingo
#program os_virginal.             % by the virginal conception: no propagation (ST I-II q.81 a.4)
not_by_propagation(X) :- virginally_conceived(X).
```

part switch

```clingo
#program os_union.                % by the union itself: the nature assumed is holy
preserved_from_os(X) :- incarnate(X).
```

part candidate

```clingo
#program cand_os_by_immaculate_mother.   % a candidate reading: free because his mother was (TTC-CREED CE1d)
not_by_propagation(X) :- incarnate(X), orig_hum(M,X), preserved_from_os(M).

% A theory of time, not the deposit (moved out of the kernel after TTC-CREED):
% an efficient cause does not come after its effect in time, save as merits
% foreseen, as Mary is preserved "in view of the merits of Jesus Christ"
% (DH 2803). A theory that roots creation in the passion, or lets history
% branch, runs without it.
```

part switch

```clingo
#program causes_precede.
violation(effect_before_cause(E,C)) :- caused_by(E,C), happens_at(E,T), before(T,C), not foreseen(E,C).

% Grace (TTC-MORAL)
```

part switch

```clingo
#program grace_uncreated.         % Palamas: deifying grace is an uncreated energy (Triads III.1)
grace_uncreated.
```

part switch

```clingo
#program justified_will_operates. % a runtime that grants one more created operation: the will moved by
acts(P) :- justification(P,_).    % grace, which Trent defines (DH 1554; TTC-MORAL GR3)

% Presence (TTC-CHRIST PM3): whether God can make one body circumscriptively
% present in two places is the schools'. Thomas: no, being contained by one
% place excludes another (Quodl. III q. 1 a. 2); Scotus, Bellarmine, Suarez:
% yes, by divine power. The Thomist runtime holds the first.
```

part switch

```clingo
#program one_place_circumscribed.
violation(two_circumscribed_places(X,L1,L2)) :- present(X,L1,circumscriptive), present(X,L2,circumscriptive), L1 < L2.
```
