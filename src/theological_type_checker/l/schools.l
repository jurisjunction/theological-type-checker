layer schools

-- Sorts first used in this layer (TTC-L, TY): closed, then open

sort person
  means "a person a case names, physical or juridic, or a group"

-- The loci (TTC-LOCI): a school's reading of one question is an allele, its
-- parts travelling together. A child whose parents express two alleles at a
-- locus carries both and expresses neither, unless it says which; silent, it
-- runs on the deposit's simplicity (allowed(defined, ...)) and the deposit's
-- silence on esse. Compiled to runtimes.json with the runtimes.
locus simplicity
  allele by_reason = simplicity_thomist, attributes_by_reason
  allele formal = simplicity_scotist, attributes_formal
  allele energetic = simplicity_palamite
  allele synonymous = simplicity_synonymous

locus esse
  allele real = th03, th05
  allele by_reason = suarez_esse
  allele scotus = scotus_esse

-- The runtimes (TTC-SCHOOLS; TTC-L, RU). Each is a school's parts loaded
-- whole; compiled to runtimes.json, which the engine reads.
runtime bare

runtime default
  add classical, one_power, word_of_no_tongue
  add ends_in_nature, forms_in_nature, ends_by_god_physics, ends_by_god_ethics, ends_of_human_nature
  add soul_as_form, ends_desired, self_preservation, object_as_form

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

-- The tongues (TTC-LINGUAE). Saussure divides the word by tongue; the vocal
-- and lingual runtimes read verba as a sound, or as a sign of a language.
runtime saussure extends default
  exclude word_of_no_tongue
  add word_by_division

runtime vocal extends default
  add verbum_vocal

runtime lingual extends default
  add verbum_lingual

-- Modernities (TTC-MODERNITY). A horizon is the set of causes a runtime holds:
-- ten parts below, one holds_cause/2 fact each. default adds the first nine,
-- so every school inherits them unchanged; form_of_law is held only where a
-- runtime adds it. The DAG is the record's (docs/research/modernity-sources.md):
-- each node a figure's horizon with the parents the record documents. A
-- contested edge is entered and marked `-- contested edge: child <- parent`;
-- an edge with no documented reading, `-- undocumented edge: child <- parent`.
runtime scotus_dpp extends scotist
  -- De primo principio 4, Theorem 4.4: a natural agent would act as it does "acting for the sake of no end"
  exclude ends_in_nature

runtime ockham extends scotus_dpp
  -- Quodl. II q. 2: that natural agents' ends are directed by anyone cannot be shown; exterior acts neutral [S]
  exclude ends_by_god_physics, object_as_form
  -- Ord. I d. 2 q. 1 (OTh II 17-18): no formal distinction between the essence and the wisdom, "and I deny
  -- it universally" [S: Kilcullen]; his own reading, the attributes as terms, is no allele yet (TTC-LOCI)
  carry formal at simplicity

runtime suarez_dm23 extends suarezian, scotus_dpp, ockham
  -- DM 23.10 nn. 5-7: "non sit propria causalitas finalis" in natural agents; DM 24.2 n. 14;
  -- De bonitate disp. 7 s. 1 n. 6: the moral object specifies the act
  exclude ends_in_nature
  add ends_by_god_physics, object_as_form
  -- DM 7.1.4-5: the attributes distinct by a distinction of reason "quae habet fundamentum in re"; DM 30.3.4-5,
  -- against "distinctionem formalem seu ex natura rei inter divinas perfectiones"; DM 31.1.12-13: essence and
  -- esse distinct by reason, "solam distinctionem rationis" (TTC-LOCI), as the suarezian runtime reads him
  express by_reason at simplicity, esse

runtime bacon extends default
  -- NO II.2, II.17: final causes corrupt the sciences "nisi in hominis actionibus"; forms are laws
  exclude ends_in_nature, forms_in_nature

runtime descartes extends default, bacon, suarez_dm23
  -- contested edge: descartes <- suarez_dm23 (Ariew against Courtine and Marion)
  -- Med. IV, AT VII 55: ends useless "in rebus Physicis"; AT III 505: no forms but the soul
  exclude ends_in_nature, forms_in_nature, ends_by_god_physics

runtime hobbes extends default, bacon, descartes, ockham
  -- contested edge: hobbes <- ockham (no documented reading; Gillespie, Villey)
  -- Lev. 6, 11, 14, 15, 46; De corpore X.7: "no such finis ultimus"; the right of nature, for preservation
  exclude ends_in_nature, forms_in_nature, ends_by_god_physics, ends_by_god_ethics, ends_of_human_nature
  exclude soul_as_form, object_as_form
  -- Lev. 31: in the attributes "we are not to consider the signification of Philosophicall Truth; but the
  -- signification of Pious Intention"; his own reading, the attributes as honours, is no allele yet (TTC-LOCI)
  carry by_reason at simplicity

runtime spinoza extends descartes, hobbes
  -- E I App.: final causes "humana ... figmenta"; IV Praef.; III p7: conatus; IV p59
  exclude ends_in_nature, forms_in_nature, ends_by_god_physics, ends_by_god_ethics, ends_of_human_nature
  exclude soul_as_form, object_as_form

runtime hooker extends thomist
  -- 2T §5: "the judicious Hooker"

runtime grotius extends suarez_dm23
  -- DIBP II.2.2; I.1.10: acts obligatory or illicit "in themselves"

runtime locke extends hooker, descartes, grotius, hobbes
  -- contested edge: locke <- hobbes (Strauss against Dunn and Tully)
  -- Essay III.iii.15-17, II.xxi.55, II.xxviii.5-16, IV.x; 2T §§6, 25: the workmanship of God, the world
  -- given to mankind in common; moral good the conformity of an action to a law
  add ends_by_god_physics, ends_by_god_ethics
  exclude ends_in_nature, forms_in_nature, ends_of_human_nature, soul_as_form, object_as_form

runtime leibniz extends suarez_dm23, descartes
  -- DM §§2, 10, 19, 22: forms necessary in metaphysics; final causes useful in physics
  add forms_in_nature, ends_by_god_physics, ends_in_nature

runtime kant extends leibniz
  -- KU §75: ends in nature "regulative (not constitutive)"; G 4:402, 4:421, 4:443; KpV §§3-4: the will
  -- determined by the law's form, "not by their matter"; the Paralogisms; the Doctrine of Virtue
  exclude ends_in_nature, forms_in_nature, ends_by_god_physics, ends_by_god_ethics, ends_of_human_nature
  exclude soul_as_form, self_preservation, object_as_form
  add form_of_law

-- The readings, each a sibling of the record's node: a hypothesis about a figure, run so
-- that the difference is computed, not settled.
runtime scotus_will extends scotus_dpp
  -- Ord. III d. 37; Ord. I d. 44 [S]: the second table natural law only in a looser sense
  exclude ends_of_human_nature, object_as_form

runtime ockham_will extends ockham
  -- OTh V 352-353 [S]: right reason binds "given the ordination that is now in force"
  exclude ends_of_human_nature

runtime ockham_nominal extends ockham
  -- Summa logicae I c. 15; Quodl. I q. 10: the soul the form of the body held by faith, not shown
  exclude soul_as_form

runtime descartes_will extends descartes
  -- Sixth Replies; AT I 145: the eternal truths created
  exclude ends_of_human_nature, object_as_form

runtime grotius_etiamsi extends grotius
  -- DIBP Prol. §11; De legibus II.6 n. 3: natural law "even if God did not exist"; against its author
  exclude ends_by_god_ethics

runtime kant_humanity extends kant
  -- G 4:429, the end in itself read as a final end; against its author ("not as an end to be effected")
  add ends_of_human_nature

runtime kant_mm extends kant
  -- the Doctrine of Virtue: "contrary to an end of nature" [V]
  add ends_in_nature, self_preservation

-- The will line: the DAG again below the will readings, so that their effect on later
-- figures is computed and not assumed.
runtime suarez_wl extends suarezian, scotus_will, ockham_will
  -- De legibus II.6 nn. 5, 13; De bonitate disp. 7
  exclude ends_in_nature
  add ends_by_god_physics, object_as_form, ends_of_human_nature
  -- DM 7.1.4-5, 30.3.4-5, 31.1.12-13, as suarez_dm23 (TTC-LOCI)
  express by_reason at simplicity, esse

runtime hobbes_wl extends default, bacon, descartes_will, ockham_will
  -- contested edge: hobbes_wl <- ockham_will (as hobbes <- ockham)
  exclude ends_in_nature, forms_in_nature, ends_by_god_physics, ends_by_god_ethics, ends_of_human_nature
  exclude soul_as_form, object_as_form
  -- Lev. 31, as hobbes (TTC-LOCI)
  carry by_reason at simplicity

runtime spinoza_wl extends descartes_will, hobbes_wl
  exclude ends_in_nature, forms_in_nature, ends_by_god_physics, ends_by_god_ethics, ends_of_human_nature
  exclude soul_as_form, object_as_form

runtime locke_wl extends hooker, descartes_will, grotius, hobbes_wl
  -- contested edge: locke_wl <- hobbes_wl (as locke <- hobbes)
  add ends_by_god_physics, ends_by_god_ethics
  exclude ends_in_nature, forms_in_nature, ends_of_human_nature, soul_as_form, object_as_form

runtime leibniz_wl extends suarez_wl, descartes_will
  -- DM §2
  add forms_in_nature, ends_by_god_physics, ends_in_nature, ends_of_human_nature, object_as_form

-- Leo's hearers (docs/research/modernity-hearers.md): their own parents outside the DAG
-- traced over; a first approximation. A figure part names the node for the hearers' tongues.
runtime episcopate_1891 extends thomist
  -- RN's address; RN 22 quoting Thomas
  add figure_episcopate_1891

runtime social_catholic extends thomist
  -- Ketteler on property as use (Goyau)

runtime smith extends locke
  -- WN I.x; TMS II.ii.3

runtime angers extends thomist, smith
  -- undocumented edge: angers <- smith (Storck, after Aubert; for the object, no text)
  add ends_in_nature, forms_in_nature, ends_of_human_nature, soul_as_form, object_as_form

runtime george extends locke
  -- undocumented edge: george <- locke
  -- Progress and Poverty VII.1; The Condition of Labor, Part I
  add figure_george

runtime george_hn extends george
  -- The Condition of Labor, points 2 and 6
  add ends_of_human_nature

runtime marx extends default
  -- the letter of 1861; the 1844 Introduction; Capital I chs. 7, 24
  exclude ends_in_nature, forms_in_nature, ends_by_god_physics, ends_by_god_ethics, soul_as_form

runtime marx_social extends marx
  -- Theses on Feuerbach VI
  exclude ends_of_human_nature

runtime lassalle extends default
  -- the Arbeiterprogramm, by absence; weak
  exclude ends_by_god_physics, ends_by_god_ethics

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

slot foreseen(E: event, C: event)
  means "foreseen(E, C): E caused by C as foreseen (merits foreseen)"
  say "{E} is caused by {C} as foreseen"

slot justification(P: person, A: act)
  means "justification(P, A): the act in which P, moved by grace, assents to justification"
  say "in {A}, {P}, moved by grace, assents to justification"

slot univocal_concept(F: perfection)
  means "univocal_concept(F): F a concept said univocally of God and creatures (Scotus)"
  say "{F} is a concept said univocally of God and creatures"

slot virginally_conceived(X: entity)
  means "virginally_conceived(X): X conceived by the Holy Spirit, not by propagation"
  say "{X} was conceived by the Holy Spirit"

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

```clingo
% The tongues (TTC-LINGUAE). The word in the heart is "nec Graecum nec
% Latinum nec linguae alicuius alterius" (De Trinitate XV.10.19), and the
% passions of the soul "sunt eaedem omnibus" (In Peryerm. I lect. 2 n. 9):
% two encodings can mean one word, and no word is dated. Saussure: mouton
% may mean what sheep means, but has not its value; before a tongue,
% thought is a shapeless mass (Cours, Part II ch. IV).
```

part switch

```clingo
#program word_of_no_tongue.
word_of_no_tongue.
```

part switch

```clingo
#program word_by_division.        % Saussure, Cours de linguistique generale (1916), Part II ch. IV: a word is
word_by_division.                 % a value in one tongue at its date
```

part switch

```clingo
#program verbum_vocal.            % a verbum is a vox, "a sound significant by convention" (De int. 2, 16a19);
verbum_vocal.                     % "vox est sonus ab ore animalis prolatus" (In Peryerm. I lect. 4 n. 3)
```

part switch

```clingo
#program verbum_lingual.          % a verbum signifies the inner word by any route: to nod is "to speak in some
verbum_lingual.                   % way to the sight" (De Trinitate XV.10.19); words, because they "can be
                                  % formed in various ways" to signify (ST III q. 60 a. 6)
```

```clingo
% The causes (TTC-MODERNITY): ten parts, each one cause in one domain held
% (causae.lp). Physics is the domain nature; ethics the domains human, will,
% self and reason; God's intention appears in both, so it is split. The
% efficient and material causes are the library's, held everywhere.
```

part switch

```clingo
#program ends_in_nature.          % natural necessity "a kind of impression from God, directing them to their end"
holds_cause(final,nature).        % (ST I q. 103 a. 1 ad 3): the end intrinsic to nature; every agent acts for an end (I-II q. 1 a. 2)
```

part switch

```clingo
#program forms_in_nature.         % substantial forms in natural things (DM 15.1 n. 5; Leibniz, DM §10)
holds_cause(formal,nature).
```

part switch

```clingo
#program ends_by_god_physics.     % natural things directed by God's intention, their ends extrinsic (Scotus, De primo
holds_cause(final,god_physics).   % principio 4.4; Suarez, DM 23.10 n. 7)
```

part switch

```clingo
#program ends_by_god_ethics.      % God's ends for human use and action: the earth given in common (RN 8; 2T §25)
holds_cause(final,god_ethics).
```

part switch

```clingo
#program ends_of_human_nature.    % the ends of human nature beyond self-preservation (I-II q. 94 a. 2)
holds_cause(final,human).
```

part switch

```clingo
#program soul_as_form.            % the soul as the form of the body (Vienne, DH 902)
holds_cause(formal,human).
```

part switch

```clingo
#program ends_desired.            % ends as the agent intends them: the end's causality "esse amatum et desideratum"
holds_cause(final,will).          % (Ockham, Quodl. IV q. 1 [S])
```

part switch

```clingo
#program self_preservation.       % the first and lowest inclination (I-II q. 94 a. 2); the right of nature (Lev. 14)
holds_cause(final,self).
```

part switch

```clingo
#program object_as_form.          % the chosen act's species from its object, "rationally chosen by the deliberate will"
holds_cause(formal,will).         % (VS 78; I-II q. 18 a. 2: the object "habet quodammodo rationem formae")
```

part switch

```clingo
#program form_of_law.             % the form of the law: the maxim's universality, apart from its matter (KpV §4;
holds_cause(formal,reason).       % G 4:402, 4:421); the one part modernity adds rather than traces
```

part switch

```clingo
#program figure_george.           % the node of Henry George, for the hearers' tongues (icon_history.lp)
figure(george).
```

part switch

```clingo
#program figure_episcopate_1891.  % the bishops of 1891, RN's addressees
figure(episcopate_1891).
```

part search

```clingo
#program horizons_all.            % every horizon of the ten parts, in one solve (TTC-MODERNITY PH); loaded beside
{ holds_cause(final,(nature;god_physics;god_ethics;human;will;self)) }.   % rt_bare, never by a runtime
{ holds_cause(formal,(nature;human;will;reason)) }.

% The VM (TTC-MODERNITY): a part vm_R for each runtime R loads R's horizon as
% the guest's, beside the host's, in the same solve.
```

part switch

```clingo
#program vm_bare.                 vm_guest(bare).
```

part switch

```clingo
#program vm_default.              vm_guest(default).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_thomist.              vm_guest(thomist).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_scotist.              vm_guest(scotist).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_suarezian.            vm_guest(suarezian).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_palamite.             vm_guest(palamite).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_saussure.             vm_guest(saussure).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_vocal.                vm_guest(vocal).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_lingual.              vm_guest(lingual).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_scotus_dpp.           vm_guest(scotus_dpp).
guest_holds(final,(god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_ockham.               vm_guest(ockham).
guest_holds(final,(god_ethics;human;will;self)). guest_holds(formal,(nature;human)).
```

part switch

```clingo
#program vm_suarez_dm23.          vm_guest(suarez_dm23).
guest_holds(final,(god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_bacon.                vm_guest(bacon).
guest_holds(final,(god_physics;god_ethics;human;will;self)). guest_holds(formal,(human;will)).
```

part switch

```clingo
#program vm_descartes.            vm_guest(descartes).
guest_holds(final,(god_ethics;human;will;self)). guest_holds(formal,(human;will)).
```

part switch

```clingo
#program vm_hobbes.               vm_guest(hobbes).
guest_holds(final,(will;self)).
```

part switch

```clingo
#program vm_spinoza.              vm_guest(spinoza).
guest_holds(final,(will;self)).
```

part switch

```clingo
#program vm_hooker.               vm_guest(hooker).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_grotius.              vm_guest(grotius).
guest_holds(final,(god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_locke.                vm_guest(locke).
guest_holds(final,(god_physics;god_ethics;will;self)).
```

part switch

```clingo
#program vm_leibniz.              vm_guest(leibniz).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_kant.                 vm_guest(kant).
guest_holds(final,will). guest_holds(formal,reason).
```

part switch

```clingo
#program vm_scotus_will.          vm_guest(scotus_will).
guest_holds(final,(god_physics;god_ethics;will;self)). guest_holds(formal,(nature;human)).
```

part switch

```clingo
#program vm_ockham_will.          vm_guest(ockham_will).
guest_holds(final,(god_ethics;will;self)). guest_holds(formal,(nature;human)).
```

part switch

```clingo
#program vm_ockham_nominal.       vm_guest(ockham_nominal).
guest_holds(final,(god_ethics;human;will;self)). guest_holds(formal,nature).
```

part switch

```clingo
#program vm_descartes_will.       vm_guest(descartes_will).
guest_holds(final,(god_ethics;will;self)). guest_holds(formal,human).
```

part switch

```clingo
#program vm_grotius_etiamsi.      vm_guest(grotius_etiamsi).
guest_holds(final,(god_physics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_kant_humanity.        vm_guest(kant_humanity).
guest_holds(final,(human;will)). guest_holds(formal,reason).
```

part switch

```clingo
#program vm_kant_mm.              vm_guest(kant_mm).
guest_holds(final,(nature;will;self)). guest_holds(formal,reason).
```

part switch

```clingo
#program vm_suarez_wl.            vm_guest(suarez_wl).
guest_holds(final,(god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_hobbes_wl.            vm_guest(hobbes_wl).
guest_holds(final,(will;self)).
```

part switch

```clingo
#program vm_spinoza_wl.           vm_guest(spinoza_wl).
guest_holds(final,(will;self)).
```

part switch

```clingo
#program vm_locke_wl.             vm_guest(locke_wl).
guest_holds(final,(god_physics;god_ethics;will;self)).
```

part switch

```clingo
#program vm_leibniz_wl.           vm_guest(leibniz_wl).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_episcopate_1891.      vm_guest(episcopate_1891).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_social_catholic.      vm_guest(social_catholic).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_smith.                vm_guest(smith).
guest_holds(final,(god_physics;god_ethics;will;self)).
```

part switch

```clingo
#program vm_angers.               vm_guest(angers).
guest_holds(final,(nature;god_physics;god_ethics;human;will;self)). guest_holds(formal,(nature;human;will)).
```

part switch

```clingo
#program vm_george.               vm_guest(george).
guest_holds(final,(god_physics;god_ethics;will;self)).
```

part switch

```clingo
#program vm_george_hn.            vm_guest(george_hn).
guest_holds(final,(god_physics;god_ethics;human;will;self)).
```

part switch

```clingo
#program vm_marx.                 vm_guest(marx).
guest_holds(final,(human;will;self)). guest_holds(formal,will).
```

part switch

```clingo
#program vm_marx_social.          vm_guest(marx_social).
guest_holds(final,(will;self)). guest_holds(formal,will).
```

part switch

```clingo
#program vm_lassalle.             vm_guest(lassalle).
guest_holds(final,(nature;human;will;self)). guest_holds(formal,(nature;human;will)).
```
