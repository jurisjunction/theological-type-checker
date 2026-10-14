layer schools

```clingo
% ===================================================================
%  Classical metaphysics of God, as switches: the accretion experiment.
%  Predictions were committed first: docs/research/thomism-preregistration.md.
%  Every part here is off by default. The list, in order:
%    0. the attributes as defined (Lateran IV, DH 800, 804;
%       Vatican I, DH 3001-3002, 3025)
%    1. the 24 Thomistic Theses (DH 3601-3624), minimal readings
%    2. Thomas's readings      3. rival readings and candidates
% ===================================================================

```

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot attribute(A: perfection)
  means "attribute(A): a divine attribute (wisdom, goodness, power)"
  say "{A} is a divine attribute"

slot constitutive(R: relation)
  means "constitutive(R): the relation R constitutes its subject"
  say "the relation {R} constitutes its subject"

slot creaturely_only(P: perfection)
  means "creaturely_only(P): a predicate said of creatures only"
  say "{P} is said of creatures only"

slot esse_not_really_distinct/0
  means "esse not really distinct from essence (a school's)"
  say "esse is not really distinct from essence"

slot known_from_effects/0
  means "God known from his effects: every bridge read back (a school's)"
  say "God is known from his effects"

slot love_object_reading/0
  means "love read by its object, the Word (a school's)"
  say "love is read by its object, the Word"

slot mixed_relations/0
  means "God's relations to creatures are of reason only (a school's)"
  say "God's relations to creatures are of reason only"

slot predicamental(R: relation)
  means "predicamental(R): the relation R is predicamental"
  say "the relation {R} is predicamental"

slot rests_in(C: node, W: node)
  means "rests_in(C, W): love C rests in W"
  say "{C} rests in {W}"

slot said_of_god(P: perfection)
  means "said_of_god(P): the perfection P said of God"
  say "{P} is said of God"

slot transcendental(T: perfection)
  means "transcendental(T): a transcendental (goodness, truth, unity)"
  say "{T} is a transcendental"

slot transcendental_relation/0
  means "the creature's being-from as a transcendental relation (a school's)"
  say "the creature's being-from is a transcendental relation"

slot transcendentals/0
  means "the transcendentals: pure perfections said first of God (a school's)"
  say "the transcendentals are pure perfections, said first of God"

```clingo

% ---------- Simplicity: which distinctions in God a reading allows ----
% god_distinction(X,Y,Kind): the data assert a distinction in God of this
% kind, other than between the persons. The persons are distinct by
% relations of origin; a reading of simplicity fixes which (kernel_core.lp).
% allowed(Reading,Kind): the kinds a reading admits besides those relations.
% The definition's reading and the check are the deposit's (kernel_core.lp).
% The synonym reading (the objectors in ST I q.13 a.4) admits none.
allowed(thomist,rational).                      % ST I q.3 a.7; q.28 a.3; q.13 a.4
allowed(scotist,(rational;formal)).             % Scotus, Ord. I d.8 p.1 q.4
allowed(palamite,(rational;energetic)).         % Basil, Ep. 234; Palamas, Capita 150
distinction(opposition) :- simplicity(thomist).                 % ST I q.36 a.2
distinction(mode)       :- simplicity(scotist).                 % Scotus, Ord. I d.11 q.2
distinction(mode)       :- simplicity(palamite).                % Nazianzen, Or. 31.9
god_distinction(essence,energies,energetic) :- rel(m,_,_), reltype(m).   % distinct, not divided

% ---------- Immutability, contingency, perfections -------------------
violation(real_relation_in_god(G,X)) :- really_related(G,X), mixed_relations.
violation(potency_in_pure_act(X))    :- pure_act(X), potency(X).
violation(unlicensed_perfection(P))  :- said_of_god(P), not licensed(P,div).
violation(bridge_for_creaturely_predicate(P)) :- creaturely_only(P), bridge(P,_,_).
violation(being_graded_less_good(X,R)) :- graded_less_good(X,R), creature(X), transcendentals.

% ===================================================================
%  0. The attributes as defined
% ===================================================================
```

part switch

```clingo
#program defined_attributes.      % Lateran IV, DH 800, 804; Vatican I, DH 3001-3002, 3025
% Now always on, as deposit (kernel_core.lp, TTC-SCHOOLS R2); kept so that
% scenarios naming it still load. "aeternus", "infinitus": the crossing guards (AN6).

% ===================================================================
%  1. The 24 Theses (DH 3601-3624), minimal readings
%  Th. 7-14 and 16-20 share no vocabulary with the core: not encoded.
% ===================================================================
```

part switch

```clingo
#program th01.                    % potency and act divide being: pure act, or composed
pure_act(X) :- divine(X).
pure_act(G) :- god(G).
potency(X)  :- creature(X).
potency(X)  :- changes(X).        % to change is to pass from potency to act

```

part switch

```clingo
#program th02.                    % act limited only by potency: already the finitude guard (AN6)

```

part switch

```clingo
#program th03.                    % God alone most simple; in creatures essence and esse really distinct
esse_distinct(X,real) :- creature(X), not esse_not_really_distinct.

```

part switch

```clingo
#program th04.                    % being said analogically, neither univocally nor equivocally
violation(univocity_against_th4(F)) :- univocal(F).

```

part switch

```clingo
#program th05.                    % composition of subject and accidents requires esse received into a distinct essence
receiver_distinct(X) :- rec(e,X,_), creature(X).
violation(received_esse_without_real_distinction(X)) :- receiver_distinct(X), creature(X), not esse_distinct(X,real).
god_distinction(X,essence,real) :- receiver_distinct(X), divine(X).

```

part switch

```clingo
#program th06.                    % relation in creatures: an accident, a real entity distinct from its subject.
predicamental(e).                 % ST I q.45 a.3 ad 3: the creature is prior to its relation of creation
violation(constitutive_and_accidental(R)) :-   % "as the subject is to the accident"
    predicamental(R), constitutive(R), not transcendental_relation.

```

part switch

```clingo
#program th15.                    % the human soul created by God: already A1 (E from God, O from the parents)

```

part switch

```clingo
#program th21.                    % the will follows the intellect; read with ST I q.36 a.2: love proceeds from a word
cmem(A,pair(A,B)) :- c_edge(pair(A,B),_,_).
cmem(B,pair(A,B)) :- c_edge(pair(A,B),_,_).
word(W) :- c_edge(_,W,word_conception).
from_word(C)   :- c_edge(P,C,love_procession), cmem(W,P), word(W).
toward_word(C) :- rests_in(C,W), word(W).
toward_word_ok(C) :- love_object_reading, toward_word(C).
violation(will_before_intellect(C)) :- c_edge(_,C,love_procession), not from_word(C), not toward_word_ok(C).

```

part switch

```clingo
#program th22.                    % God known a posteriori, from effects; creatures indifferent to being and not-being
contingent(X) :- creature(X).
known_from_effects.

```

part switch

```clingo
#program th23.                    % essence identical with esse; infinite: already the finitude guard

```

part switch

```clingo
#program th24.                    % creation by God alone, its power incommunicable: already A1.
                                  % The last clause (premotion) is in the authority part theses_1914.

% ===================================================================
%  2. Thomas's readings
% ===================================================================
```

part switch

```clingo
#program simplicity_thomist.      % ST I q.3 a.7; q.28 a.3: only opposed relations distinguish in God
simplicity(thomist).

```

part switch

```clingo
#program attributes_by_reason.    % ST I q.13 a.4: the names of God differ by reason, with a foundation in God
attribute(wisdom;goodness;power).
god_distinction(A,B,rational) :- attribute(A), attribute(B), A < B.

```

part switch

```clingo
#program mixed_relations.         % ST I q.13 a.7; q.19 a.3: God's relations to creatures are of reason only
mixed_relations.
relation_of_reason(G,X) :- being(G,X), god(G).

```

part switch

```clingo
#program transcendentals.         % ST I qq.5, 11, 16; De veritate q.1 a.1: pure perfections, said first of God (q.13 a.3, 6)
transcendentals.
transcendental(goodness_t;truth_t;unity_t).
bridge(T,div,cr) :- transcendental(T).
mode(T,div,subsistent) :- transcendental(T).
mode(T,cr,participated) :- transcendental(T).

% ===================================================================
%  3. Rival readings and candidates
% ===================================================================
```

part switch

```clingo
#program univocal_reception.      % receiving in one mode on both sides: whoever receives is in potency to
potency(X) :- rec(_,X,_).         % what it receives, and really distinct from it (contrast Hilary, in
receiver_distinct(X) :- rec(_,X,_).   % ST I q.42 a.4 ad 1: "He is not less to Whom the same being is given")

```

part switch

```clingo
#program suarez_esse.             % Suarez, DM 31: essence and existence distinct by reason, not really
esse_not_really_distinct.

```

part switch

```clingo
#program treatise_dependence_constitutive.   % the treatise, section 2: dependence "not an accident
constitutive(e).                              % added to a creature already constituted"
uses(icon).                                   % the Grammar of the Icon

```

part switch

```clingo
#program transcendental_relation. % later scholastic: the creature's being-from (transcendental relation)
transcendental_relation.          % is not the predicamental relation that follows on it

```

part switch

```clingo
#program th21_object.             % weaker reading of Th. 21: love presupposes its known object
love_object_reading.

```

part switch

```clingo
#program bridges_as_order_of_knowing.   % a reading: a bridge runs in the order in which we know (Th. 22)
bridge(F,cr,div) :- bridge(F,div,cr), known_from_effects.

```

part candidate

```clingo
#program cand_traducianism.       % the parents give the soul its being
being(P,Z) :- orig_cr(pair(P,_),Z), created_person(Z).
being(P,Z) :- orig_cr(pair(_,P),Z), created_person(Z).

```

part candidate

```clingo
#program cand_instrumental_creation.   % Peter Lombard, Sent. IV d.5: creative power given to a minister
being(minister,Z) :- being(G,Z), god(G), created_person(Z).   % (rejected, ST I q.45 a.5)

```

part switch

```clingo
#program simplicity_scotist.      % formal distinction a parte rei; Son and Spirit distinct without procession
simplicity(scotist).

```

part switch

```clingo
#program attributes_formal.       % Scotus, Ord. I d.8 p.1 q.4
attribute(wisdom;goodness;power).
god_distinction(A,B,formal) :- attribute(A), attribute(B), A < B.

```

part switch

```clingo
#program simplicity_palamite.     % essence simple, energies many (Basil, Ep. 234); distinct, not divided
simplicity(palamite).

```

part switch

```clingo
#program simplicity_synonymous.   % no distinction in God but of opposed relations, not even of reason
simplicity(synonymous).           % (the objectors in ST I q.13 a.4)

```

part candidate

```clingo
#program cand_process_god.        % God changes with the world (process theism: Whitehead, Hartshorne)
changes(G) :- god(G).

```

part candidate

```clingo
#program cand_uncreated_in_soul.  % "something in the soul uncreated and uncreatable" (Eckhart; DH 977)
pure_act(X) :- created_person(X).

```

part switch

```clingo
#program say_goodness_of_god.     % goodness said of God formally (ST I q.6 a.2; q.13 a.3)
said_of_god(goodness_t).

```

part switch

```clingo
#program clarke_relational.       % Clarke, "A New Look at the Immutability of God" (Explorations in
really_related(G,X) :- god(G), created_person(X).   % Metaphysics, 1994, ch. 9): really related in
                                                     % consciousness; "different", not changing

```

part switch

```clingo
#program modal_collapse_inference.   % Mullins (2013): the identity of God's act with his essence
necessary(X) :- being(G,X), god(G), simplicity(_), not relation_of_reason(G,X).   % carries necessity to its term

```

part switch

```clingo
#program reception_pure_perfection.  % Clarke, The Thomist 61 (1997) 617-24: receptivity a pure perfection,
bridge(reception,div,cr).            % found first in the Son
mode(reception,div,without_potency). mode(reception,cr,with_potency).

```

part switch

```clingo
#program reception_creaturely.       % Long, The Thomist 61 (1997) 1-31: "receiving indicates potency"
creaturely_only(reception).

```

part switch

```clingo
#program treatise_receptivity.       % the treatise, section 3: to receive "can be a perfection" (said of the Son)
said_of_god(reception).
uses(icon).                          % the Grammar of the Icon

```

part candidate

```clingo
#program cand_child_less_good.       % the child of an illicit act graded a lesser good by its origin
graded_less_good(Z,origin) :- gen(separate,_,Z).

```

part switch

```clingo
#program opposition_from_names.      % opposition read off the revealed relative names (the acts),
opposed(X,Y) :- gen(_,Y,X), divine(X).   % not off the relation of origin as analogically licensed
```
