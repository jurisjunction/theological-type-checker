% ===================================================================
%  Things by their causes (TTC-RERUM): "Res ergo naturalis, inter duos
%  intellectus constituta, secundum adaequationem ad utrumque vera
%  dicitur" (De veritate q. 1 a. 2).
%
%  A cause in a thing (cause_of/3, the kernel's) and the same cause in an
%  argument (argues_from/3, causae.lp) are joined by the word: a premise
%  rests on a form, the form signifies a word, and the principle is
%  conceived under it. Where knowing ends in the thing, the chain grounds
%  the premise in the thing; where a horizon cannot hold the cause, the
%  trace is reported in the thing, which keeps it. Adequation is never
%  computed: a chain says that typed facts run from a thing to a premise,
%  never that the concept fits.
%
%  The maker of the becoming: "Aedificator enim est causa domus quantum ad
%  eius fieri, non autem directe quantum ad esse eius" (I q. 104 a. 1).
%  Art gives accidental forms; a substance it makes only through nature's
%  powers, as bread "by the power of fire baking the matter" (III q. 75 a.
%  6 ad 1). The measure runs one way for natural things: they measure our
%  intellect and are measured by God's; an artifact is measured by its
%  maker's. An end of use is the maker's, and measures nothing in the
%  thing. The exemplar is in God: "Deus est prima causa exemplaris omnium
%  rerum" (I q. 44 a. 3).
%
%  The schools' readings are alleles at four loci (schools.lp): where the
%  ideas are (in the Word, as energies, the creatures themselves as known,
%  subsisting apart, or none); whether prime matter can be without form;
%  where knowing ends (intellectus.lp); and who measures whom.
% ===================================================================

%  @library  (read by norms.py: its predicates count as defined)
% @input makes/3 | makes(M, X, K): M makes X, in the way K
% @input end_of_use/2 | end_of_use(X, P): P is an end the maker or user gives X, not one it has by its form
% @input intellect_measures/3 | intellect_measures(I, X, P): an intellect of kind I is said to measure the principle P of X
% @input exemplar_of/2 | exemplar_of(E, X): E is the exemplar of X, the idea after which it is made
% @input about/2 | about(Q, X): the question Q is about the thing X
% @input exists_without_form/1 | exists_without_form(P): prime matter P is said to exist in act without any form
% @input knowing_ends_in_things/0 | a part at the locus terminus: the word is that by which a thing is known, and knowing ends in the thing (I q. 85 a. 2)
% @input things_measure_us/0 | a part at the locus adaequatio: a natural thing measures our intellect and is measured by God's (De veritate q. 1 a. 2)
% @input mind_prescribes/0 | a part at the locus adaequatio: the understanding prescribes its laws to nature (Kant, Prolegomena §36)
% @input ideas_in_the_word/0 | a part at the locus ideas: the ideas in the divine mind, many as understood by it, their relations of reason (I q. 15 a. 2 and ad 4)
% @input ideas_as_energies/0 | a part at the locus ideas: the logoi of things as God's uncreated energies
% @input ideas_creatures_known/0 | a part at the locus ideas: the divine ideas are the creatures themselves as known (Ockham, Ord. I d. 35 q. 5)
% @input ideas_subsisting/0 | a part at the locus ideas: the Forms subsist apart
% @input ideas_no_exemplar/0 | a part at the locus ideas: a god who thinks only himself (Metaphysics XII.9, one reading), and no exemplar of things
% @input matter_never_without_form/0 | a part at the locus prime_matter: matter is never in act without form (I q. 66 a. 1 ad 3)
% @input matter_can_be_without_form/0 | a part at the locus prime_matter: God could create matter existing without form (Scotus, Opus Oxoniense II d. 12 q. 1)
% @input creature/1 | the kernel
% @input cause_of/3 | kernel_core.lp
% @input ind_sort/2 | kernel_analogy.lp
% @input argument/4 | causae.lp
% @input argues_from/3 | causae.lp
% @input horizon_run/1 | causae.lp: the run's own horizon, or the VM's guest
% @input held/3 | causae.lp: the causes a horizon holds
% @input rests_on_form/3 | linguae.lp
% @input signifies/3 | linguae.lp
% @input conceived_as/3 | intellectus.lp
% @input question_kind/2 | icon_authority.lp

% ---------- The maker of the becoming; art through nature --------------------
artifact(X) :- makes(_,X,accidental).
natural(X)  :- creature(X), not artifact(X).
info(maker_of_becoming(M,X)) :- makes(M,X,_), cause_of(X,efficient,M).
violation(substance_by_art_alone(M,X)) :- makes(M,X,by_art_alone), natural(X).

% ---------- The direction of the measure --------------------------------------
% A formal or final principle of a natural thing said to be measured by our
% intellect; an end of use is the maker's, and measures nothing in the thing.
measured_by_us(X,P) :- intellect_measures(human,X,P), natural(X), cause_of(X,C,P), C = (formal;final),
                       not end_of_use(X,P).
violation(natural_form_measured_by_us(X,P)) :- things_measure_us, measured_by_us(X,P).
info(prescribed(X,P))                       :- mind_prescribes, measured_by_us(X,P).

% ---------- The edge: a cause in a thing, through the word, to a premise -------
% An argument on a natural question; a premise of the nature's or the will's,
% resting on a form; the form signifying a word; a principle conceived under
% the word; that principle the cause, of that kind, of a thing. It does not
% read about/2.
chain(A,X,P,C,D) :- argument(A,_,Q,_), question_kind(Q,natural), rests_on_form(A,cd(C,D),F), D = (nature;will),
                    signifies(F,W,_), conceived_as(P,W,human), cause_of(X,C,P).
grounded(A,X,P) :- chain(A,X,P,_,_), knowing_ends_in_things.
info(traced_in_thing(G,X,C,D)) :- chain(_,X,_,C,D), horizon_run(G), not held(G,C,D).
chained(A,C,D) :- chain(A,_,_,C,D).
info(premise_without_thing(A,cd(C,D))) :- argument(A,_,Q,_), question_kind(Q,natural), argues_from(A,C,D),
                                          D = (nature;will), not chained(A,C,D).

% ---------- The exemplar --------------------------------------------------------
% An argument from the exemplar, God's intention for nature as form, where
% the ideas are in God.
exemplar_in_god :- ideas_in_the_word.
exemplar_in_god :- ideas_as_energies.
info(grounded_in_the_word(A,X,E)) :- argument(A,_,Q,_), question_kind(Q,natural), about(Q,X),
                                     argues_from(A,formal,god_physics), exemplar_of(E,X), ind_sort(E,div),
                                     exemplar_in_god.
asked_of(X) :- about(_,X), natural(X).
violation(exemplar_not_divine(E,X)) :- exemplar_in_god, asked_of(X), exemplar_of(E,X), not ind_sort(E,div).
info(exemplar_as_energy(E,X))       :- ideas_as_energies, asked_of(X), exemplar_of(E,X), ind_sort(E,div).
info(idea_is_the_creature(X))       :- ideas_creatures_known, asked_of(X).
% The Form of X subsisting apart, where the kernel's deposit refuses it (DH 800).
subsists_apart(idea(X))             :- ideas_subsisting, asked_of(X).
info(no_exemplar(X))                :- ideas_no_exemplar, asked_of(X).

% ---------- Prime matter --------------------------------------------------------
% "Magis repugnat quod materia sit in actu sine forma, quam quod accidens sit
% sine subiecto" (I q. 66 a. 1 ad 3), against God's power to "create matter
% existing without form" (Scotus, Opus Oxoniense II d. 12 q. 1).
violation(matter_in_act_without_form(P)) :- matter_never_without_form, exists_without_form(P).
info(matter_without_form_by_power(P))    :- matter_can_be_without_form, exists_without_form(P).
#program things_measure_us.       % the locus adaequatio: things measure our intellect (De veritate q. 1 a. 2)
things_measure_us.
#program mind_prescribes.         % the locus adaequatio: the understanding prescribes to nature (Prolegomena §36)
mind_prescribes.
#program ideas_in_the_word.       % the locus ideas: in the divine mind, "ut intellectae" (I q. 15 a. 2); the exemplar
ideas_in_the_word.                % a cause in God's intention for nature, as form
holds_cause(formal,god_physics).
#program ideas_as_energies.       % the locus ideas: the logoi as uncreated energies
ideas_as_energies.
holds_cause(formal,god_physics).
#program ideas_creatures_known.   % the locus ideas: the creatures themselves as known (Ockham, Ord. I d. 35 q. 5)
ideas_creatures_known.
holds_cause(formal,god_physics).
#program ideas_subsisting.        % the locus ideas: the Forms subsisting apart (Plato)
ideas_subsisting.
holds_cause(formal,god_physics).
#program ideas_no_exemplar.       % the locus ideas: a god who thinks only himself (Metaphysics XII.9, one reading)
ideas_no_exemplar.
#program matter_never_without_form. % the locus prime_matter (I q. 66 a. 1 ad 3)
matter_never_without_form.
#program matter_can_be_without_form. % the locus prime_matter (Opus Oxoniense II d. 12 q. 1)
matter_can_be_without_form.

% ---------- domains (L) ---------------------------------------------
#program base.
in_sort(making,(accidental;by_nature;by_art_alone)).
violation(outside_domain(makes,3,K)) :- makes(_,_,K), not in_sort(making,K).
violation(outside_domain(intellect_measures,1,I)) :- intellect_measures(I,_,_), not in_sort(knower,I).
