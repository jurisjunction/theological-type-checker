layer pair

```clingo
% ===================================================================
%  The ordered pair: (teaching, law).
%
%  Every case has a theological side (the authority graph) and a
%  canonical side (the canon-law layer). The pair is ordered: teaching
%  comes first, and law is ordered to it. The Code binds to teaching by
%  reference (cc. 750, 752) and never answers a doctrinal question itself.
%  Concretely:
%
%  Downward (teaching -> law): a canon may presuppose a theological value.
%    premise(Norm, Q, V)   applying Norm presupposes value V on question Q
%  If a branch holds another value on Q while the law still applies Norm,
%  the pair is inconsistent in that branch. A case can also let a
%  theological branch select a canonical reading (see the SSPX case:
%  the school that denies the act was schismatic is the school that
%  reads c. 751 as a lasting state).
%
%  Upward (law -> teaching): only juridical facts (bonds, status) may feed
%  the theological side. Law never settles a doctrinal question.
%    law_answers(Q)        a rule lets a canon-law result fix question Q
% ===================================================================

```

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot premise(N: norm, Q: question, V: value)
  means "premise(N, Q, V): norm N presupposes V on Q"
  say "{N} presupposes {V} on {Q}"

slot law_answers(Q: question)
  means "law_answers(Q): a claim that a canon-law result fixes the question Q"
  say "a canon-law result is claimed to fix {Q}"

slot uncoupled/0
  means "the law applied apart from the theological branch (a candidate)"
  say "the law is applied apart from the theological branch"

```clingo

violation(law_without_premise(N,E,Q)) :- delict(_,N,E), premise(N,Q,V), holds(Q,W), W != V.
% A theological question may classify a canonical event; in each branch the
% law follows that branch's classification (unless deliberately uncoupled).
not_of_kind(E,K) :- classification(Q,E,K), holds(Q,no), not uncoupled.
of_kind(E,K)     :- classification(Q,E,K), holds(Q,yes), not uncoupled.
violation(teaching_from_law(Q)) :- law_answers(Q), question_kind(Q,doctrinal).
% An approval of a version is governance (c. 838). Whether the version
% carries its source is computed (linguae.lp), never law's: entered as
% answering it, it is refused (TTC-LINGUAE). By the CDF's declaration of 1974
% an approval also judges the sense; that judgement enters as a mode claim
% at the approver's tier, and weighs.
carriage(q(carries(X2,X1))) :- given_for(X2,X1).
carriage(q(carries(T2,T1))) :- made_from(T2,T1).
violation(teaching_from_law(Q)) :- law_answers(Q), carriage(Q).

% ---------- The flywheel's frontier, theological side ---------------
% What the theological encoding still lacks. Each item is something to
% encode or to read; none is an error in the facts.
frontier(theology,cited_not_encoded(S2,S)) :- cites(S,S2), not source(S2,_,_,_).
frontier(theology,cited_not_encoded(S2,S)) :- reaffirms(S,S2), not source(S2,_,_,_).
frontier(theology,cited_not_encoded(S1,S)) :- interprets(S,S1,_), not source(S1,_,_,_).
has_support(Q) :- supports(_,Q,_).
has_support(Q) :- reads(_,_,Q,_).
has_support(Q) :- finding(_,Q,_,_).        % an empirical question answered by the sciences (TTC-EMPIRICA)
frontier(theology,question_without_sources(Q)) :- question(Q), not has_support(Q), not default(Q,_),
                                                  not practice_spoken(Q).
% A question no source answers, which a claim of practice speaks to, is no
% lack of the encoding: no source answers it, and the claim weighs with no
% tier. It is shown apart, as unanswered (TTC-REPAIRS5).
practice_spoken(Q) :- practice_teaches(_,_,Q).
frontier(unanswered,by_practice_only(Q)) :- question(Q), not has_support(Q), not default(Q,_),
                                            practice_spoken(Q).
has_reading(S) :- reading(S,_).
frontier(theology,ambiguous_without_readings(S)) :- ambiguous(S), not has_reading(S).
has_form(S) :- character(S,_).
has_form(S) :- papal_form(S,_).
frontier(theology,teaching_without_character(S)) :- source(S,3,truth,_), not has_form(S).

#show frontier/2.
```
