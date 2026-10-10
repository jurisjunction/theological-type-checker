# The canon-law layer

Theology branches; canon law mostly does not. Given the facts and the norm
in force, a juridical effect follows or it does not. This layer computes
those effects as plain rules (Datalog, in practice), keeps the canons
connected as a graph, and is built to grow one canon at a time.

## Why binary

The Code says how it is to be read, and that reading leaves little room for
weight:

- **c. 16 §1.** The legislator interprets authentically. An authentic
  interpretation is an input, not a vote.
- **c. 18.** Laws that establish a penalty, restrict rights or contain an
  exception are interpreted strictly.
- **c. 19.** Where the law is silent, a case is resolved from similar laws,
  general principles, the jurisprudence and practice of the Curia, and "the
  common and constant opinion of learned persons", *unless it is penal*.
  Canonists' opinion fills a gap; it never weighs against the law, and in
  penal matters it does not even fill gaps.
- **cc. 20, 21, 135 §2.** A later law prevails over an earlier one,
  revocation is never presumed, and a lower authority cannot act validly
  against a higher one. These settle conflicts mechanically.

The theological authority graph (tiers, weights, shadows) remains the right
tool for *teaching*. Using it for *law* was a type error, and the first
version of the SSPX case made it (see [the case](cases/sspx-2026.md)).

## Where branches still come from

Only three places, and the checker says which one a branch comes from:

1. **A disputed fact.** For example, was the accused heard (c. 1720 n. 1)?
   Write `disputed(heard(D,named))` and the checker computes both ways. The
   result lists `assumed_fact(...)` in each branch.
2. **A disputed reading of a canon,** where no authentic interpretation
   exists. For example, does c. 751 reach a single act, or only a lasting
   state? Readings are switches. An authentic interpretation
   (`authentic_reading/3`) fixes the reading.
3. **The internal forum.** Imputability, intention and belief are never
   computed. In the external forum, imputability is presumed once an
   external violation is established (c. 1321 §4), and that presumption is
   all the checker uses.

## Time

Every act is judged by the law and the juridical situation **on its own
date**. A revocation in 2026 does not touch an absolution given in 2018. A
declaration suspended by recourse in August does not invalidate an act done
in August. Each norm carries the dates it is in force (for example c. 1382
of 1983 until 8 December 2021, c. 1387 after), and an evaluation date
(`today/1`, or an `asof_YYYY` part) fixes "now".

## Writing a canon

Rules for one canon go under one tag:

```prolog
% @norm cic2021:1387 | c. 1387: consecrator and consecrated without pontifical mandate incur latae sententiae excommunication reserved to the Apostolic See | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html
delict(B,n1387,E) :- consecrates(E,B), event_date(E,T), not pontifical_mandate(E), norm_in_force(n1387,T).
delict(R,n1387,E) :- consecration(E,_,R,T), not pontifical_mandate(E), norm_in_force(n1387,T).
penalty(n1387,excommunication).
```

The conventions are:

- **`% @norm <id> | <citation> | <source>`** starts a norm. Every rule below
  it belongs to it until the next tag or `% @end`.
- **`% @input <name>/<arity> | <meaning>`** declares a fact a case supplies:
  an event, a decree, a grant.
- **`% @temporal <id>`** marks a norm whose effects fall only on later acts.
  A loop through it is recursion over time, not circularity.
- **Cite the primary text** (see below), and paraphrase the canon's
  conditions and effects closely in the citation field.
- **Facts about a real case go in a case file,** never in the norms.
  Hypothetical facts go only in switch programs, marked `HYPOTHETICAL`.

### Where to find the texts: iuscangreg

[iuscangreg](https://www.iuscangreg.it/) ("Risorse canonistiche") is
maintained by the Faculty of Canon Law of the Pontifical Gregorian
University. Its sections map onto the layer's slots:

| iuscangreg section | Use it for |
| --- | --- |
| [CIC 1983](https://www.iuscangreg.it/cic1983.php) ([index](https://www.iuscangreg.it/cic_indice.php)) and [CCEO](https://www.iuscangreg.it/cceo.php) | `@norm` rules |
| [Extra-codal norms](https://www.iuscangreg.it/diritto_tutto.php) | papal and curial legislation: `@norm` rules, and grants or decrees as case facts |
| [Responses of the Apostolic See](https://www.iuscangreg.it/risposte.php) | authentic interpretations: `authentic_reading/3` facts (c. 16) |
| [Particular law](https://www.iuscangreg.it/diritto_particolare.php) | conference and diocesan norms, which rank below universal law (c. 135 §2) |
| [Historical sources](https://www.iuscangreg.it/diritto_anteriore.php): [CIC 1917](https://www.iuscangreg.it/cic1917.php), Gasparri's *Fontes* | earlier versions of a canon, with their dates |
| [Apostolic Signatura jurisprudence](https://www.iuscangreg.it/stsa_contadmin.php) | filling a gap under c. 19, never in penal cases |
| [Bibliography](https://www.iuscangreg.it/biblio_ricerca.php) and [*Periodica*](https://periodica.iuscangreg.it/) | commentators: tier-5 sources that name readings |

For the current English text of the Code, vatican.va remains convenient
(the Book VI pages carry the 2021 revision).

## The norm graph

Norm A *feeds* norm B when something A derives is used by B: definitions feed
delicts, delicts feed penalties, penalties feed effects and their
exceptions. Two tools read the graph:

- **`norm_graph`** draws it (Mermaid) or returns it as JSON. It can focus
  on one norm and its neighbours.
- **`norm_check`** reports four things:
  - *vicious cycles*: norms that depend on each other in a loop; these must
    be fixed
  - *temporal loops*: recursion over later acts through a `@temporal` norm;
    these are allowed
  - *undefined predicates*: something a rule uses that no rule derives and
    no `@input` declares, usually a canon not yet encoded
  - *unused inputs*

The undefined predicates are **the frontier**: the list of what to encode
next. Test CL1 keeps the graph free of vicious cycles and undefined
predicates.

## Checking a text against the law

A text's claims about the juridical situation are entered as
`asserts(Text, Claim, Date)`. The checker compares each claim with what the
norms derive for each concrete act and reports `claim_confirmed` or
`claim_contradicted`. A contradiction is a question, not a verdict: either the
text knows a fact or norm the encoding lacks, or the text is wrong. In the
SSPX case this showed that the note's "confessions are invalid" holds for
some acts and not others, and exactly which fact would change that.

## What is encoded

| Area | Canons |
| --- | --- |
| General norms | cc. 16 §1, 135 §2, 333 §3; grants until revoked by a competent authority |
| Delicts | cc. 751 with 1364 §1 (and the 1983 text); 1382 (1983) and 1387; 1379 §1 n. 2 |
| Imputability and remission | cc. 1321 §4; 1323 n. 4 and 1324 §1 n. 8, §3 (recorded, never decided); 1355 |
| Declaring a penalty | cc. 1717 §1; 1342 §1 with 1720 n. 1; 124 §2; 1353 |
| Effects | cc. 1331 §1 n. 1 and §2 n. 2; 1335 §2 |
| Sacraments | cc. 966, 976, 144 §2 (penance); 1108 §1, 1111 (form of marriage) |

That is enough for one case. The rest of the Code is the frontier, and it is
meant to be filled in as the tool is used: see [the flywheel](flywheel.md).
