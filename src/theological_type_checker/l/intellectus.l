layer libraries

-- Sorts first used in this layer (TTC-L, TY): closed, then open

sort knower {divine, angelic, human}
  means "a kind of intellect: God's, an angel's, a human being's; a power, never a person (rule 3)"

```clingo
% ===================================================================
%  The intellect (TTC-RERUM): "species intelligibilis se habet ad
%  intellectum ut quo intelligit intellectus" (ST I q. 85 a. 2).
%
%  Knower kinds, never persons: the library types powers, and what anyone
%  knows is never computed (rule 3). A principle of a thing is conceived
%  by a kind of intellect under a word (conceived_as/3).
%
%  Where knowing ends is a school's reading, at the locus terminus. On
%  the one, the word is that by which a thing is known, and knowing ends in
%  the thing (knowing_ends_in_things): under it a chain from a cause in a
%  thing, through the word, to an argument's premise is grounded
%  (rerum.lp). On the other, the idea is what is known: the mind "hath no
%  other immediate object but its own ideas" (Locke, Essay IV.1), and
%  knowing ends in the word (ideas_as_objects).
%
%  Praise through a knower: the elements of the material world "per ipsum,
%  fastigium suum attingant et ad liberam Creatoris laudem vocem
%  attollant" (GS 14). A mediator has a rational nature: a created person,
%  an angel, or the incarnate. Praise that ends in what is not God is
%  reported, and not typed as latria (Nicaea II, DH 601, distinguishes
%  honour). Creatures "by their mere existence ... bless him and give him
%  glory" (CCC 2416): no rule reads the absence of voiced_through/3.
% ===================================================================

```

library

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot conceived_as(P: entity, W: word, K: knower)
  means "conceived_as(P, W, K): an intellect of kind K conceives the principle P under the word W"
  say "a {K} intellect conceives {P} under the word {W}"

slot voiced_through(X: entity, M: entity, T: entity)
  means "voiced_through(X, M, T): the praise of X reaches T through M"
  say "the praise of {X} reaches {T} through {M}"

slot ideas_as_objects/0
  means "a part at the locus terminus: the idea is what is known, and knowing ends in the word (Locke, Essay IV.1)"
  say "the idea is what is known"

result ends_in_the_word(W: word, P: entity)
  say "knowing {P} ends in the word {W}, taken as what is known"

result praise_through(X: entity, M: entity, T: entity)
  say "the praise of {X} reaches {T} through {M}, who has a rational nature (GS 14)"

result mediator_without_intellect(M: entity)
  say "{M} is said to voice another's praise, and has no rational nature: refused"

result praise_ends_in_creature(X: entity, M: entity, T: entity)
  say "the praise of {X} through {M} ends in {T}, which is not God: reported, and not typed as latria"

use ind_sort/2 "kernel_analogy.lp: the side of the line"

use created_person/1 "the kernel"

use incarnate/1 "the kernel"

```clingo

% ---------- Where knowing ends ------------------------------------------------
info(ends_in_the_word(W,P)) :- ideas_as_objects, conceived_as(P,W,human).

% ---------- Praise through a knower ---------------------------------------------
% A created person (an angel is one, kernel_core.lp) or the incarnate.
mediator(M) :- created_person(M).
mediator(M) :- incarnate(M).
info(praise_through(X,M,T))          :- voiced_through(X,M,T), mediator(M), ind_sort(T,div).
violation(mediator_without_intellect(M)) :- voiced_through(_,M,_), not mediator(M).
info(praise_ends_in_creature(X,M,T)) :- voiced_through(X,M,T), mediator(M), not ind_sort(T,div).
```

part switch

```clingo
#program knowing_ends_in_things.  % the word that by which a thing is known (I q. 85 a. 2): the locus terminus
knowing_ends_in_things.
```

part switch

```clingo
#program ideas_as_objects.        % the idea what is known (Locke, Essay IV.1): the locus terminus
ideas_as_objects.
```
