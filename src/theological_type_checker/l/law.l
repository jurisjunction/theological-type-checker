layer libraries

```clingo
% ===================================================================
%  Law: a standard library for canon law (TTC-LAW(7)).
%  Predictions were committed and stamped first:
%  docs/research/law-preregistration.md.
%
%  Law is "an ordinance of reason for the common good, made by him who has
%  care of the community, and promulgated" (ST I-II q. 90 a. 4). That a law
%  so made is reasonable and for the common good is presumed, not weighed
%  (rule 2); it yields only to a higher law (q. 96 a. 4). Whether a law, or
%  a reading of it, contradicts divine law is a doctrinal question: the
%  theology side answers it (of_kind/2, through classification/3; rule 1).
%  The canons that state this theory as rules (cc. 7-8, 14, 16-21, 85-86,
%  135 §2) are in canon_law.lp and call this library.
%
```

library

```clingo
% ===================================================================

```

use law_kind/2 "law_kind(Law, Kind): eternal, natural, divine_positive, ecclesiastical, civil"

use of_kind/2 "from the theological side (pair.lp): in this branch the thing is classified as of this kind"

slot reading_option/2
  means "reading_option(Law, Reading): a reading the words admit (c. 17)"

use narrower/2 "narrower(R1, R2): reading R1 reaches less than R2"

```clingo

% ---------- The order of laws (q. 91; q. 93 a. 3; q. 95 a. 2) -----------
% Eternal law; the natural law, its participation in the rational creature;
% divine positive law; human law, ecclesiastical or civil, derived from the
% natural by conclusion or determination. Of two human laws neither is
% higher by its kind (TTC-CHRIST SA7).
kind_rank(eternal,4).
kind_rank(natural,3).
kind_rank(divine_positive,3).
kind_rank(ecclesiastical,2).
kind_rank(civil,2).
divine_law(L) :- law_kind(L,natural).
divine_law(L) :- law_kind(L,divine_positive).
higher(H,L) :- law_kind(H,KH), law_kind(L,KL), kind_rank(KH,RH), kind_rank(KL,RL), RH > RL.

% ---------- A law against a higher law (q. 96 a. 4) ----------------------
% "Not a law but a perversion of law" (q. 95 a. 2): it does not bind.
contrary(L,H)           :- of_kind(L,contrary_to(H)).
reading_contrary(L,R,H) :- of_kind(reading(L,R),contrary_to(H)).
does_not_bind(L) :- contrary(L,H), higher(H,L).
does_not_bind(L) :- read_for(L,R,_), reading_contrary(L,R,H), higher(H,L).

% ---------- Readings ------------------------------------------------------
% The readings the words admit, less those the mind of the legislator
% excludes (c. 17, in canon_law.lp).
admissible(L,R) :- reading_option(L,R), not excluded_reading(L,R).

% ---------- What a binding law reaches ------------------------------------
```

use reaches/3 "reaches(Law, Reading, X): on this reading the law reaches the act or person X"

use unbound/2 "canon_law.lp (c. 11): an ecclesiastical law does not bind the person"

use unbound_at/3 "canon_law.lp (c. 11): an ecclesiastical law does not bind the person in the act (under seven)"

use unbound_now/2 "canon_law.lp (c. 11 with c. 97): the person is under seven at the evaluation date"

```clingo
% A merely ecclesiastical law binds only whom c. 11 binds: for a person, the
% person's exemptions; for an act, its agent's, as binds_for/3 reads them in
% the moral library (TTC-CCEO WB: the two libraries had disagreed). A divine
% law has no such exemptions.
binds_on(L,X) :- read_for(L,R,_), reaches(L,R,X), not does_not_bind(L), not exempt_from(X,L).
exempt_from(X,L) :- unbound(X,L).
exempt_from(X,L) :- unbound_now(X,L).
exempt_from(A,L) :- act_of(P,A), unbound(P,L).
exempt_from(A,L) :- act_of(P,A), unbound_at(P,L,A).
```
