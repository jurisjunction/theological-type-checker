% ===================================================================
%  School runtimes: the parts the four runtimes share or add. A runtime
%  is a named list of parts loaded whole (engine.RUNTIMES); its readings
%  of simplicity and the Theses are in icon_metaphysics.lp. Predictions
%  were committed and stamped first: docs/research/schools-preregistration.md.
%  The kernel holds none of this; with no runtime it runs bare.
% ===================================================================

% @input foreseen/2 | foreseen(E, C): E caused by C as foreseen (merits foreseen)
% @input justification/2 | justification(P, A): the act in which P, moved by grace, assents to justification
% @input univocal_concept/1 | univocal_concept(F): F a concept said univocally of God and creatures (Scotus)
% @input virginally_conceived/1 | virginally_conceived(X): X conceived by the Holy Spirit, not by propagation
#program classical.               % agere sequitur esse: creatures act (ST I q.105 a.5; SCG III.69-70).
acts(X) :- creature(X).           % Common to the four runtimes; denied by occasionalism.
operates(X,hum) :- incarnate(X).  % Said of Christ's humanity too: two natural operations (DH 557).

#program christs_humanity_operates.   % a runtime that grants one created operation only: that of
operates(X,hum) :- incarnate(X).      % Christ's humanity, which the deposit defines (TTC-CREED CR6)

#program one_power.               % Lyons II defines one principle of the Spirit (DH 850); the Latin
                                  % account of it: one spirative power of Father and Son (ST I q.36 a.4).
one_power(X,Y) :- gen(spiration,X,Z), gen(spiration,Y,Z), divine(Z), X != Y.
divine_contraction(identity_of_power) :- not no_divine_contraction.
contractible(A,X,Y) :- divine_contraction(identity_of_power), gen(A,X,_), gen(A,Y,_), X != Y,
                       one_power(X,Y).

#program univocity_of_concept.    % Scotus, Ord. I d.3 p.1 qq.1-3; d.8 p.1 q.3: one concept of being,
univocal_concept(being).          % said of God and creatures in quid; its intrinsic modes differ
bridge(being,div,cr).
mode(being,div,infinite).         mode(being,cr,finite).

#program scotus_esse.             % Scotus, Ord. IV d.11 q.3: essence and existence not really distinct
esse_not_really_distinct.

#program th04_predication.        % Th. 4 as worded: being is SAID analogically, not univocally
violation(univocity_against_th4(F)) :- univocal_concept(F), bridge(F,div,cr).   % a rule on predication

#program holds_premotion.         % Th. 24's last clause read as physical premotion (Banez)
holds_reading(theses_1914,premotion).

#program holds_concurrence.       % read as simultaneous concurrence (Molina; Suarez, DM 22)
holds_reading(theses_1914,concurrence).

#program dh1330_deposit.          % Florence, Cantate Domino (DH 1330): "omnia sunt unum, ubi non obviat
distinction(opposition).          % relationis oppositio", read as deposit (TTC-SCHOOLS, encoding A).
                                  % As a Thomist reading it follows from simplicity_thomist (encoding B).

% Why Christ does not contract original sin (TTC-CREED EC1): the deposit says
% that he does not (DH 301), not why. Each reading supplies a slot.
#program os_virginal.             % by the virginal conception: no propagation (ST I-II q.81 a.4)
not_by_propagation(X) :- virginally_conceived(X).
#program os_union.                % by the union itself: the nature assumed is holy
preserved_from_os(X) :- incarnate(X).
#program cand_os_by_immaculate_mother.   % a candidate reading: free because his mother was (TTC-CREED CE1d)
not_by_propagation(X) :- incarnate(X), orig_hum(M,X), preserved_from_os(M).

% A theory of time, not the deposit (moved out of the kernel after TTC-CREED):
% an efficient cause does not come after its effect in time, save as merits
% foreseen, as Mary is preserved "in view of the merits of Jesus Christ"
% (DH 2803). A theory that roots creation in the passion, or lets history
% branch, runs without it.
#program causes_precede.
violation(effect_before_cause(E,C)) :- caused_by(E,C), happens_at(E,T), before(T,C), not foreseen(E,C).

% Grace (TTC-MORAL)
#program grace_uncreated.         % Palamas: deifying grace is an uncreated energy (Triads III.1)
grace_uncreated.
#program justified_will_operates. % a runtime that grants one more created operation: the will moved by
acts(P) :- justification(P,_).    % grace, which Trent defines (DH 1554; TTC-MORAL GR3)

% Presence (TTC-CHRIST PM3): whether God can make one body circumscriptively
% present in two places is the schools'. Thomas: no, being contained by one
% place excludes another (Quodl. III q. 1 a. 2); Scotus, Bellarmine, Suarez:
% yes, by divine power. The Thomist runtime holds the first.
#program one_place_circumscribed.
violation(two_circumscribed_places(X,L1,L2)) :- present(X,L1,circumscriptive), present(X,L2,circumscriptive), L1 < L2.
% The tongues (TTC-LINGUAE). The word in the heart is "nec Graecum nec
% Latinum nec linguae alicuius alterius" (De Trinitate XV.10.19), and the
% passions of the soul "sunt eaedem omnibus" (In Peryerm. I lect. 2 n. 9):
% two encodings can mean one word, and no word is dated. Saussure: mouton
% may mean what sheep means, but has not its value; before a tongue,
% thought is a shapeless mass (Cours, Part II ch. IV).
#program word_of_no_tongue.
word_of_no_tongue.
#program word_by_division.        % Saussure, Cours de linguistique generale (1916), Part II ch. IV: a word is
word_by_division.                 % a value in one tongue at its date
#program verbum_vocal.            % a verbum is a vox, "a sound significant by convention" (De int. 2, 16a19);
verbum_vocal.                     % "vox est sonus ab ore animalis prolatus" (In Peryerm. I lect. 4 n. 3)
#program verbum_lingual.          % a verbum signifies the inner word by any route: to nod is "to speak in some
verbum_lingual.                   % way to the sight" (De Trinitate XV.10.19); words, because they "can be
                                  % formed in various ways" to signify (ST III q. 60 a. 6)
% The causes (TTC-MODERNITY): ten parts, each one cause in one domain held
% (causae.lp). Physics is the domain nature; ethics the domains human, will,
% self and reason; God's intention appears in both, so it is split. The
% efficient and material causes are the library's, held everywhere.
#program ends_in_nature.          % natural necessity "a kind of impression from God, directing them to their end"
holds_cause(final,nature).        % (ST I q. 103 a. 1 ad 3): the end intrinsic to nature; every agent acts for an end (I-II q. 1 a. 2)
#program forms_in_nature.         % substantial forms in natural things (DM 15.1 n. 5; Leibniz, DM §10)
holds_cause(formal,nature).
#program ends_by_god_physics.     % natural things directed by God's intention, their ends extrinsic (Scotus, De primo
holds_cause(final,god_physics).   % principio 4.4; Suarez, DM 23.10 n. 7)
#program ends_by_god_ethics.      % God's ends for human use and action: the earth given in common (RN 8; 2T §25)
holds_cause(final,god_ethics).
#program ends_of_human_nature.    % the ends of human nature beyond self-preservation (I-II q. 94 a. 2)
holds_cause(final,human).
#program soul_as_form.            % the soul as the form of the body (Vienne, DH 902)
holds_cause(formal,human).
#program ends_desired.            % ends as the agent intends them: the end's causality "esse amatum et desideratum"
holds_cause(final,will).          % (Ockham, Quodl. IV q. 1 [S])
#program self_preservation.       % the first and lowest inclination (I-II q. 94 a. 2); the right of nature (Lev. 14)
holds_cause(final,self).
#program object_as_form.          % the chosen act's species from its object, "rationally chosen by the deliberate will"
holds_cause(formal,will).         % (VS 78; I-II q. 18 a. 2: the object "habet quodammodo rationem formae")
#program form_of_law.             % the form of the law: the maxim's universality, apart from its matter (KpV §4;
holds_cause(formal,reason).       % G 4:402, 4:421); the one part modernity adds rather than traces
#program figure_george.           % the node of Henry George, for the hearers' tongues (icon_history.lp)
figure(george).
#program figure_episcopate_1891.  % the bishops of 1891, RN's addressees
figure(episcopate_1891).
#program horizons_all.            % every horizon of the ten parts, in one solve (TTC-MODERNITY PH); loaded beside
{ holds_cause(final,(nature;god_physics;god_ethics;human;will;self)) }.   % rt_bare, never by a runtime
{ holds_cause(formal,(nature;human;will;reason)) }.

% The VM (TTC-MODERNITY): a part vm_R for each runtime R loads R's horizon as
% the guest's, beside the host's, in the same solve.
#program vm_bare.                 vm_guest(bare).
#program vm_default.              vm_guest(default).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_thomist.              vm_guest(thomist).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_scotist.              vm_guest(scotist).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_suarezian.            vm_guest(suarezian).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_palamite.             vm_guest(palamite).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_saussure.             vm_guest(saussure).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_vocal.                vm_guest(vocal).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_lingual.              vm_guest(lingual).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_scotus_dpp.           vm_guest(scotus_dpp).
guest_holds(final,(god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_ockham.               vm_guest(ockham).
guest_holds(final,(god_ethics;human;will;self)). guest_holds(formal,(nature;human)).
#program vm_suarez_dm23.          vm_guest(suarez_dm23).
guest_holds(final,(god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_bacon.                vm_guest(bacon).
guest_holds(final,(god_physics;god_ethics;human;will;self)). guest_holds(formal,(human;will)).
#program vm_descartes.            vm_guest(descartes).
guest_holds(final,(god_ethics;human;will;self)). guest_holds(formal,(human;will)).
#program vm_hobbes.               vm_guest(hobbes).
guest_holds(final,(will;self)).
#program vm_spinoza.              vm_guest(spinoza).
guest_holds(final,(will;self)).
#program vm_hooker.               vm_guest(hooker).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_grotius.              vm_guest(grotius).
guest_holds(final,(god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_locke.                vm_guest(locke).
guest_holds(final,(god_physics;god_ethics;will;self)).
#program vm_leibniz.              vm_guest(leibniz).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_kant.                 vm_guest(kant).
guest_holds(final,will). guest_holds(formal,reason).
#program vm_scotus_will.          vm_guest(scotus_will).
guest_holds(final,(god_physics;god_ethics;will;self)). guest_holds(formal,(nature;human)).
#program vm_ockham_will.          vm_guest(ockham_will).
guest_holds(final,(god_ethics;will;self)). guest_holds(formal,(nature;human)).
#program vm_ockham_nominal.       vm_guest(ockham_nominal).
guest_holds(final,(god_ethics;human;will;self)). guest_holds(formal,nature).
#program vm_descartes_will.       vm_guest(descartes_will).
guest_holds(final,(god_ethics;will;self)). guest_holds(formal,human).
#program vm_grotius_etiamsi.      vm_guest(grotius_etiamsi).
guest_holds(final,(god_physics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_kant_humanity.        vm_guest(kant_humanity).
guest_holds(final,(human;will)). guest_holds(formal,reason).
#program vm_kant_mm.              vm_guest(kant_mm).
guest_holds(final,(nature;will;self)). guest_holds(formal,reason).
#program vm_suarez_wl.            vm_guest(suarez_wl).
guest_holds(final,(god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_hobbes_wl.            vm_guest(hobbes_wl).
guest_holds(final,(will;self)).
#program vm_spinoza_wl.           vm_guest(spinoza_wl).
guest_holds(final,(will;self)).
#program vm_locke_wl.             vm_guest(locke_wl).
guest_holds(final,(god_physics;god_ethics;will;self)).
#program vm_leibniz_wl.           vm_guest(leibniz_wl).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_episcopate_1891.      vm_guest(episcopate_1891).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_social_catholic.      vm_guest(social_catholic).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_smith.                vm_guest(smith).
guest_holds(final,(god_physics;god_ethics;will;self)).
#program vm_angers.               vm_guest(angers).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
#program vm_george.               vm_guest(george).
guest_holds(final,(god_physics;god_ethics;will;self)).
#program vm_george_hn.            vm_guest(george_hn).
guest_holds(final,(god_physics;god_ethics;human;will;self)).
#program vm_marx.                 vm_guest(marx).
guest_holds(final,(human;will;self)). guest_holds(formal,will).
#program vm_marx_social.          vm_guest(marx_social).
guest_holds(final,(will;self)). guest_holds(formal,will).
#program vm_lassalle.             vm_guest(lassalle).
guest_holds(final,(nature;human;will;self)). guest_holds(formal,(nature;human;will)).
