layer libraries

```clingo
% ===================================================================
%  Faith: the notes of teaching, professions and their denials
%  (TTC-COMMUNION(7)). Predictions were committed and stamped first:
%  docs/research/communion-preregistration.md.
%
%  The note of a value is read off the authority graph, never entered:
%  de fide where a tier-1 teaching source holds it (c. 750 §1), definitive
%  where a source that can cleave holds it at tier 2 (c. 750 §2), authentic
%  at tier 3 (c. 752). Tiers are computed, never taken on anyone's word
%  (rule 14), so a note is no stronger than the warrant under it. A
%  profession is an outward act; its censure is said of the proposition
%  professed (CDF, commentary on the Professio fidei, 1998, nn. 5, 6, 10).
%  Pertinacity is a claim (II-II q. 11 a. 2 ad 3), never derived.
%
```

library

```clingo
% ===================================================================

```

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot grade_name(T: tier, N: category)
  means "grade_name(T, N): the name of the note at tier T"

use holds/2 "from the authority graph"

use supports/3 "from the authority graph"

use in_force/1 "from the authority graph"

use source/4 "from the authority graph"

use eff_tier/2 "from the authority graph"

use can_cleave/2 "from the authority graph: the source cleaves the question's other values"

use question_kind/2 "from the authority graph"

use teaching_type/2 "teaching_type(Source, principle | criterion | directive) (CCC 2423; TTC-PRECEPT)"

slot professes(Person: person, Act: act, Q: question, V: value)
  means "professes(Person, Act, Q, V): in the act the person publicly holds V on Q (outward)"

slot doubts(Person: person, Act: act, Q: question)
  means "doubts(Person, Act, Q): in the act the person publicly doubts the question (outward)"

slot repudiates(Person: person, Act: act, Of: category)
  means "repudiates(Person, Act, christian_faith): an outward repudiation of the faith as a whole"

use interior/3 "act.lp: a claim about the agent; pertinacious is one"

use disputed/1 "a fact whose truth is disputed"

use full_communion/1 "canon_law.lp (c. 205): a juridical status, which may feed the theological side"

```clingo

% ---------- Notes (c. 750 §§1-2, c. 752; CCC 182) -------------------------------
% A tier-1 truth source in force fixes the note de fide; at tiers 2 and 3 the
% source must be able to cleave the other values: no note where teaching is in
% tension, under a protection, or outranked. Tiers 4 and 5 weigh; they note
% nothing. Scripture (tier 0) is read, and proposed only by tier 1.
note_by(Q,V,1) :- holds(Q,V), supports(S,Q,V), in_force(S), source(S,_,truth,_), eff_tier(S,1),
                  question_kind(Q,doctrinal).
note_by(Q,V,T) :- holds(Q,V), supports(S,Q,V), in_force(S), source(S,_,truth,_), eff_tier(S,T),
                  T >= 2, T <= 3, can_cleave(S,Q), question_kind(Q,doctrinal).
note(Q,V,T) :- note_by(Q,V,T), not stronger_note(Q,V,T).
stronger_note(Q,V,T) :- note_by(Q,V,T), note_by(Q,V,T2), T2 < T.
grade_name(1,de_fide).
grade_name(2,definitive).
grade_name(3,authentic).
% The prudential order (n. 10): authentic teaching held only by directives.
principle_support(Q,V) :- note(Q,V,3), supports(S,Q,V), in_force(S), eff_tier(S,3), can_cleave(S,Q),
                          not teaching_type(S,directive).
prudential_order(Q,V) :- note(Q,V,3), not principle_support(Q,V).

% ---------- The censure of a contrary proposition (nn. 5, 6, 10) ---------------
% Said of the profession, never of the person. A profession of a value that
% is main carries none; omission is not denial.
contrary_profession(E,Q,V,T) :- professes(_,E,Q,W), holds(Q,V), V != W, note(Q,V,T).
censure(E,heretical)              :- contrary_profession(E,_,_,1).
censure(E,contrary_to_definitive) :- contrary_profession(E,_,_,2).
censure(E,erroneous) :- contrary_profession(E,Q,V,3), not prudential_order(Q,V).
censure(E,rash)      :- contrary_profession(E,Q,V,3), prudential_order(Q,V).
% Doubt is typed with denial against de fide teaching only (c. 751; n. 5):
% n. 6 says "denies", c. 1365 "rejects".
censure(E,heretical) :- doubts(_,E,Q), holds(Q,V), note(Q,V,1).

% ---------- Pertinacity, on the claims (II-II q. 11 a. 2 ad 3; q. 5 a. 3) -------
% The same claim c. 751's "obstinate" reads (canon_law.lp).
denial_by(P,E) :- professes(P,E,_,_).
denial_by(P,E) :- doubts(P,E,_).
formal_heresy_on_the_claims(P,E) :- denial_by(P,E), censure(E,heretical), interior(P,E,pertinacious).
% One article denied with pertinacity, none held by faith: the others are held
% by one's own judgment, not on the authority of God revealing (q. 5 a. 3).
faith_in_no_article_on_the_claims(P) :- formal_heresy_on_the_claims(P,_).

% ---------- Three offences, three objects (qq. 11, 12, 39; c. 751) --------------
% Apostasy repudiates the faith whole; no number of heresies composes it.
apostasy_act(E) :- repudiates(_,E,christian_faith).
violation(apostasy_without_repudiation(E)) :- apostasy_act(E), not repudiates(_,E,christian_faith).

% ---------- "No longer in full communion": teaching, at tier 3 (n. 6) -----------
% A doctrinal question on the graph (q(definitive_denial_breaks_communion)),
% held by the commentary; c. 205's full communion is the canon layer's, and
% neither answers the other (rule 1).
no_longer_in_full_communion_by_teaching(P,E) :- holds(q(definitive_denial_breaks_communion),yes),
                                                professes(P,E,_,_), censure(E,contrary_to_definitive).

% ---------- Full incorporation, on the claims (LG 14) ---------------------------
% c. 205's full communion and "possessing the Spirit of Christ" (a claim, grace.lp);
% without it, "in body, not in heart".
fully_incorporated_on_the_claims(P) :- full_communion(P), interior(P,state,in_grace).
in_body_not_in_heart_on_the_claims(P) :- full_communion(P), disputed(interior(P,state,in_grace)),
                                         not interior(P,state,in_grace).

info(censure(E,K)) :- censure(E,K).
info(formal_heresy_on_the_claims(P,E)) :- formal_heresy_on_the_claims(P,E).
info(faith_in_no_article_on_the_claims(P)) :- faith_in_no_article_on_the_claims(P).
info(apostasy_act(E)) :- apostasy_act(E).
info(no_longer_in_full_communion_by_teaching(P,E)) :- no_longer_in_full_communion_by_teaching(P,E).
info(fully_incorporated_on_the_claims(P)) :- fully_incorporated_on_the_claims(P).
info(in_body_not_in_heart_on_the_claims(P)) :- in_body_not_in_heart_on_the_claims(P).

% ---------- Assent is never computed (TTC-PENAL FO3; rule 3) -----------------
% What a teaching is owed is read off the graph (owed/2, the notes); whether it
% is given is interior. Silence is not denial (no censure), and not assent:
% Vineam Domini (1705, DH 2390) refused "obsequious silence" as what is owed,
% and no rule may read assent off silence or off an outward profession.
```

use silent/3 "silent(Person, Act, Q): an outward silence on the question"

use assents/2 "candidate only: assents(Person, Q), inward assent read off outward facts"

```clingo
violation(assent_computed(P,Q)) :- assents(P,Q).
info(silence_without_censure(P,Q)) :- silent(P,_,Q).

```

part switch

```clingo
#program report_notes.            % every note, for the test of NT1
info(note(Q,V,G)) :- note(Q,V,T), grade_name(T,G).
```
