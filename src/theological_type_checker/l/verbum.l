layer libraries

```clingo
% ===================================================================
%  The Word and the light (TTC-VERBUM): "So the form of soap is in three
%  ways. In the Word, before the thing, as its idea. In the soap, as its
%  form. In our minds, after the thing, as its concept" (the case's text).
%
%  The Word is the person begotten (ST I q. 34 a. 2): nothing else names
%  it. A formal or final cause of a natural thing, not an end of use, is
%  in the Word before the thing, as its idea, where the thing's exemplar
%  is the Word through whom it was made (DH 150; I q. 44 a. 3) and the
%  horizon holds the ideas in God (rerum.lp). The maker's end is in her.
%
%  How the light by which a premise is judged stands to the Word is a
%  school's reading, at the locus lumen. Thomas: "Ipsum enim lumen
%  intellectuale quod est in nobis, nihil est aliud quam quaedam
%  participata similitudo luminis increati"; the soul knows in the
%  eternal reasons "sicut in cognitionis principio", not "sicut in
%  obiecto cognito", which is how the blessed know (I q. 84 a. 5). The
%  light, God's work and common to the three, is said of the Word by
%  appropriation (I q. 39 a. 8). Bonaventure: certain knowledge requires
%  "ratio aeterna ut regulans et ratio motiva, non quidem ut sola et in
%  sua omnimoda claritate, sed cum ratione creata, et ut ex parte a nobis
%  contuita secundum statum viae" (De scientia Christi q. 4); "Lux ergo
%  intellectus creati sibi non sufficit ad certam comprehensionem rei
%  cuiuscumque absque luce Verbi aeterni" (Christus unus omnium magister
%  n. 10). On either, a premise grounded in a thing (rerum.lp) whose cause
%  is in the Word before the thing is reported with that cause, both in
%  the Word; on the second only, the cause's idea is contuited in the
%  judgment. The motive reason is typed as a rule of the judgment, never
%  as a cause among its causes: no rule here writes cause_of/3.
%
%  Refused on both, and on every runtime: a created intellect's own light
%  typed as God, "cum ipsa intellectiva virtus creaturae non sit Dei
%  essentia" (I q. 12 a. 2); and a created intellect seeing a thing in God
%  as in an object known by its natural power, "virtus naturalis
%  intellectus creati non sufficiat ad Dei essentiam videndam" (I q. 12
%  a. 5; a. 4, of angels and men). The Holy Office censured ontologism in
%  1861, "tuto tradi non possunt" (icon_history.lp, ontologism_1861). A
%  vision by grace (the blessed, by the light of glory, DH 895, 1000;
%  Christ's soul; Paul in rapture, II-II q. 175 a. 3) has no slot, and
%  nothing refuses it.
%
%  Knower kinds, never persons: no one's knowing or certainty is computed
%  (rule 3).
% ===================================================================

```

library

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot light_of(K: knower, L: entity)
  means "light_of(K, L): the created intellect's own light, its power, in an intellect of kind K, is said to be L (I q. 12 a. 2)"
  say "the light of a {K} intellect, its own power, is said to be {L}"

slot seen_in(K: knower, X: entity, E: entity)
  means "seen_in(K, X, E): an intellect of kind K is said to see X in E as in an object known, by its natural power"
  say "a {K} intellect is said to see {X} in {E} as in an object known, by its natural power"

slot light_participated/0
  means "a part at the locus lumen: the light in us a participated likeness of the uncreated light, the principle of knowing and not its object (I q. 84 a. 5)"
  say "the light is participated"

slot light_contuited/0
  means "a part at the locus lumen: the eternal reason rule and motive of certain knowledge, with the created reason, contuited in part (De scientia Christi q. 4)"
  say "the eternal reason is contuited"

result before_the_thing(P: entity, X: entity, W: entity)
  say "{P}, a cause of {X}, is in {W} before the thing, as its idea"

result both_in_the_word(A: claim, X: entity, P: entity, W: entity, L: entity)
  say "{P}, a cause in {X}, and the premise of {A} resting on it are both in {W}: the cause as the idea before the thing, the premise as judged in its light ({L})"

result in_participated_light(A: claim, W: entity)
  say "the premise of {A} is judged in a light participated from the uncreated light, said of {W}: its principle, not its object (I q. 84 a. 5)"

result under_eternal_reason(A: claim, W: entity)
  say "the premise of {A} is judged under the eternal reason in {W}, as rule and motive, with the created reason (De scientia Christi q. 4)"

result idea_contuited(A: claim, P: entity, W: entity)
  say "the idea of {P} in {W} is contuited in judging the premise of {A}: in part, not in its full clarity (De scientia Christi q. 4)"

result light_typed_uncreated(K: knower, L: entity)
  say "the light of a {K} intellect is typed as {L}, which is God: refused; it is a participated likeness (I q. 12 a. 2)"

result seen_by_nature(K: knower, X: entity, E: entity)
  say "a {K} intellect is said to see {X} in {E}, God, as in an object known by its natural power: refused (I q. 12 aa. 4-5)"

use gen/3 "kernel_core.lp: the processions"

use ind_sort/2 "kernel_analogy.lp: the side of the line"

use cause_of/3 "kernel_core.lp"

use made_through/2 "kernel_core.lp"

use exemplar_of/2 "rerum.lp"

use end_of_use/2 "rerum.lp"

use natural/1 "rerum.lp"

use grounded/3 "rerum.lp"

use exemplar_in_god/0 "rerum.lp"

```clingo

% ---------- The Word ------------------------------------------------------------
the_word(W) :- gen(begetting,_,W), ind_sort(W,div).

% ---------- Before the thing, in the Word ----------------------------------------
info(before_the_thing(P,X,W)) :- cause_of(X,C,P), C = (formal;final), natural(X), not end_of_use(X,P),
                                 exemplar_of(W,X), made_through(W,X), the_word(W), exemplar_in_god.

% ---------- The participated light (Thomas) --------------------------------------
info(in_participated_light(A,W)) :- light_participated, grounded(A,_,_), the_word(W).
info(both_in_the_word(A,X,P,W,participated)) :- light_participated, grounded(A,X,P),
                                 cause_of(X,C,P), C = (formal;final), natural(X), not end_of_use(X,P),
                                 exemplar_of(W,X), made_through(W,X), the_word(W), exemplar_in_god.

% ---------- The eternal reason contuited (Bonaventure) ---------------------------
info(under_eternal_reason(A,W)) :- light_contuited, grounded(A,_,_), the_word(W).
info(idea_contuited(A,P,W)) :- light_contuited, grounded(A,X,P),
                                 cause_of(X,C,P), C = (formal;final), natural(X), not end_of_use(X,P),
                                 exemplar_of(W,X), made_through(W,X), the_word(W), exemplar_in_god.
info(both_in_the_word(A,X,P,W,contuited)) :- light_contuited, grounded(A,X,P),
                                 cause_of(X,C,P), C = (formal;final), natural(X), not end_of_use(X,P),
                                 exemplar_of(W,X), made_through(W,X), the_word(W), exemplar_in_god.

% ---------- Refused on both ------------------------------------------------------
violation(light_typed_uncreated(K,L)) :- light_of(K,L), K != divine, ind_sort(L,div).
violation(seen_by_nature(K,X,E))      :- seen_in(K,X,E), K != divine, ind_sort(E,div).
```

part switch

```clingo
#program light_participated.      % the locus lumen: a participated likeness of the uncreated light (I q. 84 a. 5)
light_participated.
```

part switch

```clingo
#program light_contuited.         % the locus lumen: the eternal reason contuited (De scientia Christi q. 4)
light_contuited.
```
