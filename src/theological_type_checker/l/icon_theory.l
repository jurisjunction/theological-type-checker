layer theory

-- Sorts first used in this layer (TTC-L, TY): closed, then open

sort number
  means "a count"

```clingo
% ===================================================================
%  The Grammar of the Icon: one theory, running on the kernel.
%  A research programme, not the platform: everything here is the
%  theory's own claim and may be refused without touching the kernel
%  (kernel_core.lp, kernel_analogy.lp). See docs/layers.md.
%
%  Its always-on facts (bridges) load only when a part declares
%  uses(icon): every model, candidate and switch of the theory does.
%  Axiom labels (A0-A11) match the Core Edition.
% ===================================================================

```

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot a9_universal/0
  means "the old reading of A9: every person is bridal, welcomed or not (a switch)"
  say "every person is bridal, welcomed or not (the old reading of A9)"

slot band(L: category)
  means "band(L): a level at which a finite nature cannot generate alone"
  say "at the level {L} a finite nature cannot generate alone"

slot bridegroom(C: entity)
  means "bridegroom(C): C is the bridegroom"
  say "{C} is the bridegroom"

slot capable_closing(X: entity, Y: entity)
  means "capable_closing(X, Y): X and Y capable of the closing act (c. 1084)"
  say "{X} and {Y} are capable of the closing act"

slot closed_in_act(A: act, X: entity, Y: entity)
  means "closed_in_act(A, X, Y): X and Y closed in the act A"
  say "{X} and {Y} are closed in the act {A}"

slot consent(X: entity, Y: entity)
  means "consent(X, Y): X consents to Y"
  say "{X} consents to {Y}"

slot held_for(P: entity, X: entity, Y: entity)
  means "held_for(P, X, Y): P holds X's consent to Y in trust (an infant's, at baptism)"
  say "{P} holds the consent of {X} to {Y} in trust"

slot level(X: entity, L: category)
  means "level(X, L): X's level in the order of natures"
  say "{X} is at the level {L}"

slot obligate_sexual(K: category)
  means "obligate_sexual(K): a kind that generates only by two"
  say "{K} generates only by two"

slot performs(A: act, X: entity, Y: entity, M: category)
  means "performs(A, X, Y, M): in act A, X and Y perform the motif M"
  say "in {A}, {X} and {Y} perform the motif {M}"

slot proposed_bond(X: entity, Y: entity)
  means "proposed_bond(X, Y): a bond between X and Y put forward"
  say "a bond between {X} and {Y} is put forward"

slot self_gift_measure(V: category, M: number)
  means "self_gift_measure(V, M): a measure M laid on the gift of self in state V"
  say "the gift of self in the state {V} is measured {M}"

slot total(X: entity, Y: entity)
  means "total(X, Y): X gives himself wholly to Y"
  say "{X} gives himself wholly to {Y}"

slot uses(T: category)
  means "uses(T): the theory T is loaded (the Grammar of the Icon)"
  say "the theory {T} is loaded"

slot side_by_side(X: entity, Y: entity, T: entity)
  means "side_by_side(X, Y, T): X and Y ordered together to the common term T (relation S)"
  say "{X} and {Y} are ordered together to {T}"

```clingo

% ---------- Policy switches (scenarios may override) --------------
closure_mode(act)   :- not closure_mode(bond).            % A4a
license_policy(two) :- not license_policy(circuit_only).  % A4
gen_policy(none)    :- not gen_policy(unbanded), not gen_policy(by_level),
                       not gen_policy(by_kind).           % dropped clause, for testing
no_divine_contraction :- license_policy(circuit_only).    % one license for both sorts: the circuit

% ---------- A0  The theory's relations ------------------------------
% N, the nuptial gift face to face, and S, ordering to a common term. Warrant:
% the long version; N is the relation the theory exists to state. (S, side_by_side/3,
% is used by its motif rules, and by the form of a sacrament: A7, BF5.)
reltype(n).
rel(n,X,Y) :- nupt(X,Y).

% ---------- A2  The theory's poles ----------------------------------
unary(bridal,X)    :- nupt(_,X).
unary(called_bridal,X) :- called_bridal(X).
unary_name(bridal;called_bridal).

% ---------- A9  Bridal floor (MD 25) --------------------------------
% Default (conditional) reading: every human person is CALLED to be the
% Bride, and is the Bride "in that he or she accepts" (MD 25), or while that
% acceptance is held in trust. MD 25 speaks of "every human being", so the
% call ranges over human persons, not angels (K1c). The old universal reading
% ("every person IS bridal") is kept behind the switch a9_universal.
called_bridal(X) :- bridegroom(C), human(X).
nupt(C,X) :- bridegroom(C), human(X), a9_universal.
nupt(C,X) :- bridegroom(C), human(X), not a9_universal, welcomed(X,C).

% ---------- A5  Personal reception is act ----------------------------
needs_welcome(X,Y) :- created_person(X), nupt(Y,X).
vicarious_ok(C)    :- bridegroom(C).          % origin case: held in trust (baptism)
welcomed(X,Y) :- consent(X,Y).
welcomed(X,Y) :- held_for(_,X,Y), vicarious_ok(Y).
violation(reception_without_act(X,Y)) :- needs_welcome(X,Y), not welcomed(X,Y).
violation(consent_supplied(P,X,Y))    :- held_for(P,X,Y), not vicarious_ok(Y).
info(awaiting_ratification(X,Y))      :- held_for(_,X,Y), vicarious_ok(Y), not consent(X,Y).
violation(reception_typed_as_non_act(X,Y)) :- nonact_reception(X,Y), consent(X,Y).

% ---------- A6  A bond: two consents + capacity for its closing act --
valid_bond(X,Y) :- proposed_bond(X,Y), consent(X,Y), consent(Y,X),
                   capable_closing(X,Y), not impeded(X,Y).
nupt(X,Y) :- valid_bond(X,Y).
nupt(Y,X) :- valid_bond(X,Y).
verdict(bond(X,Y),valid)   :- valid_bond(X,Y).
verdict(bond(X,Y),invalid) :- proposed_bond(X,Y), not valid_bond(X,Y).
% Note: fertility appears in no rule above.

% ---------- A7  Motifs ----------------------------------------------
bond(X,Y) :- nupt(X,Y), nupt(Y,X).
counter_phase(X,Y) :- bond(X,Y), created_person(X), created_person(Y).
violation(motif_mismatch(A,X,Y)) :- performs(A,X,Y,close_circuit), not counter_phase(X,Y).
violation(ungrounded_counter_phase(X,Y)) :- claimed_counter_phase(X,Y), not bond(X,Y).
% The form of a sacrament (TTC-LINGUAE BF5): the minister acts on the one
% baptized (D, acton/2), as instrument of the principal cause (III q. 66 a. 5);
% the assembly is ordered with him to the baptism (S). A form that names the
% assembly as the one who acts puts S in D's place: refused, as a closing
% motif without counter-phase is. It types the CDF's "ministerialmente - non
% collegialmente" (2020), beside the response, and decides no validity.
cophase(X) :- side_by_side(X,_,_).
cophase(Y) :- side_by_side(_,Y,_).
violation(cophase_as_agent(F)) :- uses(icon), agent_named(F,X), cophase(X), not acton(X,_).

% ---------- A4 / A4a  The circuit: two creatures as one principle -----
closed(A,X,Y) :- closed_in_act(A,X,Y).
closed(A,Y,X) :- closed_in_act(A,X,Y).
circuit(A,X,Y) :- closure_mode(act),  gen(A,X,_), gen(A,Y,_), X != Y, closed(A,X,Y), bond(X,Y).
circuit(A,X,Y) :- closure_mode(bond), gen(A,X,_), gen(A,Y,_), X != Y, bond(X,Y).
% The circuit makes two one principle only through the theory's bridge (AN14).
contractible(A,X,Y) :- licensed(principle,cr),  mode(principle,cr,closed_circuit),  circuit(A,X,Y), creature(X).
contractible(A,X,Y) :- licensed(principle,div), mode(principle,div,closed_circuit), circuit(A,X,Y), divine(X).

% ---------- The theory's bridges: one principle, in God and in creatures
bridge(principle, div, cr) :- uses(icon), not drop_bridge(principle).
bridge(grain,     div, cr) :- uses(icon), not drop_bridge(grain).
mode(principle,div,identity_of_power) :- divine_contraction(identity_of_power).   % the kernel's license
mode(principle,div,closed_circuit)    :- license_policy(circuit_only).            % the univocal stress test (S3, S4)
mode(principle,cr,closed_circuit).
mode(grain,div,necessity) :- not univocal(grain).                                 % the deposit (DH 850), restated
mode(grain,cr,norm)       :- not univocal(grain).                                 % P3, typed

% A3, among creatures. A norm binds rational agents, persons: the acts of the
% parents (DV II.B.5), not the breeding of lions (K1b). Under univocity of mode
% it would bind the divine persons too (UN2): the error that stress test shows.
violation(incoherent(grain(o,Z,P,Q)))  :- orig(P,Z), orig(Q,Z), P < Q, ind_sort(Z,cr),
                                          licensed(grain,cr), mode(grain,cr,necessity).
violation(norm_breach(grain(o,Z,P,Q))) :- orig(P,Z), orig(Q,Z), P < Q, ind_sort(Z,S),
                                          licensed(grain,S), mode(grain,S,norm),
                                          person(P), person(Q).

% ---------- A4, A11  Licenses never cross the Creator-creature line ---
violation(nuptial_within_god(X,Y)) :- nupt(X,Y), divine(X), divine(Y).
violation(power_license_in_creatures(X,Y)) :- one_power(X,Y), creature(X), X < Y.

% ---------- The dropped clause -------------------------------------
% "finite natures cannot generate alone", three readings
lone(A,X) :- gen(A,X,_), contributors(A,1), creature(X).
violation(lone_generation(A,X)) :- gen_policy(unbanded), lone(A,X).
violation(lone_generation(A,X)) :- gen_policy(by_level), lone(A,X), level(X,L), band(L).
violation(lone_generation(A,X)) :- gen_policy(by_kind),  lone(A,X), of_kind(X,K), obligate_sexual(K).

% ---------- A8  Finite totality is rivalrous ------------------------
violation(rivalrous_total(X,Y1,Y2)) :- total(X,Y1), total(X,Y2), Y1 < Y2, finite(X).

% ---------- A10  States of life --------------------------------------
% The gift of self is total in each state (FC 16: two ways of living the one
% mystery of the covenant), so no state may be credited with a greater gift of
% self, and no person ranked by state. The objective excellence of virginity for
% the Kingdom (Trent, Sess. XXIV can. 10, DH 1810; FC 16) is another relation:
% the state's singular link with the Kingdom, not the measure of a person's gift.
violation(self_gift_ranked_by_state(V1,V2)) :- self_gift_measure(V1,M1), self_gift_measure(V2,M2), M1 < M2.

% ---------- A11  God outside the order (the theory's vocabulary) -----
violation(god_inside_level_order(G)) :- level(G,_), god(G).
sort(grace,participation).                    % context (CCC 1997), not derived
crosses(level,X)          :- level(X,_), divine(X).
crosses(welcome_owed,X)   :- needs_welcome(X,_), ind_sort(X,div).

% ---------- The theory's sorts, for the static crossing check -------
sort_of(needs_welcome,cr). sort_of(level,cr). sort_of(lone,cr).
sort_of(bridegroom,hypostatic).
```
