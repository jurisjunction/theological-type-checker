layer libraries

```clingo
% ===================================================================
%  Sources: who wrote what (TTC-SOURCES)
%
%  A text is signed (it bears its author's name, and nothing disputes it),
%  anonymous (it names none), or attributed: an author claimed, with the
%  claimant, who may be the text itself. A text with none of these is not at
%  issue. An attribution is a claim (rule 14): computed both ways, and the
%  branch resting on it never preferred unless evidence apart from every
%  claimant shows it.
%
%  The order refuses it (saeculum.lp). A text is not older than what it
%  draws on, and no one writes after his death. A dependence is entered with
%  its witness and counts from the witness's year: before it the record does
%  not know the dependence, as the Church did not. No refusal rests on style,
%  or on the language a text is written in, and no motive is read (rule 3):
%  a refused attribution is a fact about dates.
%
%  A name never raises a tier. A text's tier is its form's
%  (icon_authority.lp); a name changes the form only where the claimed
%  author's office gives the text one (a pope's letter), and only on the
%  branch of the claim. God is the author of Sacred Scripture, and its human
%  writers "true authors" (CCC 105-106; DV 11); the Church discerned the canon
%  by the apostolic Tradition (CCC 120), not by attribution.
%
%  The anonymous are left without a name, and are shown as such: "Non
%  quaeras quis hoc dixerit, sed quid dicatur attende" (Imitatio Christi I.5).
%
```

library

```clingo
% ===================================================================

```

slot signed(Text: source, Author: person)
  means "signed(Text, Author): the text bears its author's name, and nothing disputes it"

slot anonymous(S: source)
  means "the text names no author"

slot attribution(Text: source, Author: person, Claimant: claimant)
  means "attribution(Text, Author, Claimant): a claim that Author wrote the text"

slot died(Author: person, Year: year)
  means "died(Author, Year)"

slot self_dated(Text: source, Year: year)
  means "self_dated(Text, Year): the text dates itself (a colophon)"

slot draws_on(Text: source, Earlier: source, Witness: source)
  means "draws_on(Text, Earlier, Witness): the text draws on Earlier, as Witness shows"

slot text_year(X: source, Year: year)
  means "text_year(X, Year): the year of a text or witness, as the record has it"

slot author(Text: source, Author: person)
  means "author(Text, Author): an author entered for a text without a claim"

slot shown_by(Text: source, Author: person, Evidence: source)
  means "shown_by(Text, Author, Evidence): evidence that the author wrote the text"

use source/4 "icon_authority.lp"

use in_force/1 "icon_authority.lp"

```clingo

year_of(X,Y) :- text_year(X,Y).
year_of(X,Y) :- source(X,_,_,Y), not text_year(X,_).

% ---------- The order refuses an attribution -------------------------------
% A dependence is known from its witness's year (the one clock: asof/1).
known_dependence(S,S1) :- draws_on(S,S1,W), year_of(W,Y), asof(A), Y <= A.
not_before(S,Y) :- known_dependence(S,S1), year_of(S1,Y).
not_before(S,Y) :- self_dated(S,Y).
attribution_refused(S,A) :- attribution(S,A,_), died(A,D), not_before(S,Y), Y > D.

% ---------- An attribution is a claim (rule 14) -----------------------------
% Shown only by evidence apart from every claimant; otherwise computed both
% ways, and never preferred. One author at a time: competing claims branch.
attribution_shown(S,A) :- shown_by(S,A,E), not attribution(S,A,E), not attribution_refused(S,A).
{ attributed(S,A) } :- attribution(S,A,_), not attribution_refused(S,A), not attribution_shown(S,A).
attributed(S,A) :- attribution_shown(S,A).
:- attributed(S,A), attributed(S,B), A != B.
unshown_claim(attribution(S,A))      :- attributed(S,A), not attribution_shown(S,A).
assumed_fact(attributed(S,A))        :- attributed(S,A), not attribution_shown(S,A).
assumed_fact(false(attributed(S,A))) :- attribution(S,A,_), not attribution_refused(S,A), not attribution_shown(S,A),
                                        not attributed(S,A).

% ---------- The anonymous are left without a name ---------------------------
violation(author_without_claim(S,A)) :- author(S,A), anonymous(S), not attribution(S,A,_).
violation(signed_and_anonymous(S))   :- signed(S,_), anonymous(S).

info(attribution_refused(S,A,S1,W))          :- attribution(S,A,_), died(A,D), draws_on(S,S1,W), known_dependence(S,S1),
                                                year_of(W,YW), asof(Now), YW <= Now, year_of(S1,Y), Y > D.
info(attribution_refused(S,A,self_dated(Y))) :- attribution(S,A,_), died(A,D), self_dated(S,Y), Y > D.
info(attribution_claimed(S,A,C))             :- attribution(S,A,C).
info(attribution_by_act(S,A,C))              :- attribution(S,A,C), in_force(C), eff_tier(C,T), T <= 3.
info(without_a_name(S))                      :- anonymous(S), not attributed(S,_).
```
