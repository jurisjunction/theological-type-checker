% ===================================================================
%  School runtimes: the parts the four runtimes share or add. A runtime
%  is a named list of parts loaded whole (engine.RUNTIMES); its readings
%  of simplicity and the Theses are in icon_metaphysics.lp. Predictions
%  were committed and stamped first: docs/research/schools-preregistration.md.
%  The kernel holds none of this; with no runtime it runs bare.
% ===================================================================

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
