<!-- Copy of src/theological_type_checker/guide.md (the MCP server serves that file). Edit it there, then copy it here; a test checks they match. -->

# TTC-ENCODING(5)

## NAME

**ttc-encoding** — facts and rules the checker reads

## DESCRIPTION

Encoding is interpretation. Write every interpretive choice as a fact
someone can dispute. If a choice is genuinely open, do not make it: mark the
text `ambiguous` and give its readings.

A case is an ordered pair. The **theology** side comes first; the **canon**
side is ordered to it. Never mix them: teaching facts go on the theology
side, juridical facts on the canon side.

## WORKFLOW

1. Find the nearest case with `list_parts` and `read_part`. `sspx` and
   `remarriage` are complete.
2. State the questions, and type each: `doctrinal`, `governance` or
   `juridical`. The type decides lex posterior.
3. Enter the theology side: sources with tier, force, year, form, character.
4. Enter the canon side: events, decrees, grants, acts. Link the two sides
   with `classification/3` and `premise/3`.
5. Run `check`. Read the result as branches, not verdicts. A run uses the
   default runtime unless it names one (`rt_thomist`, `rt_scotist`,
   `rt_suarezian`, `rt_palamite`; `rt_bare` for none; two for a pair).
   Name a runtime when the answer depends on a school.
6. If you disagree with the result, use `fix_method`. If you agree, use
   `save_scenario`.
7. A red test is a finding. Open each with `read_test` before deciding
   whether the change is wrong, the test is brittle, or the expectation
   should change, and say which. Never save over one unexamined.

## THEOLOGY

| Fact | Meaning |
| --- | --- |
| `question(Q)`, `value(Q,V)`, `question_kind(Q,K)` | A question, its answers, its type. |
| `default(Q,V)` | Holds unless a source in force says otherwise (c. 1058). |
| `source(S,T,F,Y)` | Tier 1–5; force `truth`, `juridical` or `protective`; year. |
| `supports(S,Q,V)` | S holds V on Q. |
| `papal_form(S,F)` | `ex_cathedra` (1), `definitive_declaration` (2), `legislative`, `ordinary` (3). |
| `character(S,K)` | Weight under LG 25. 3: `constitution`, `encyclical`, `conciliar_constitution`. 2: `conciliar_decree`, `exhortation`, `declaration`, `instruction`, `catechism`, `apostolic_letter`, `profession`. 1: `letter`, `address`, `homily`, `notification`, `responses`, `commentary`. 0: `interview` (cannot cleave). |
| `dicastery/1`, `conference/1`, `diocesan/1`, `conciliar/1` | Legislator rank (c. 135 §2). |
| `by_papal_mandate/1`, `in_forma_specifica/1` | A curial act the pope made his own. |
| `protects(S,Q)` | With force `protective`: blocks cleaving at or below S's tier. |
| `promoted(S,T,Y)`, `withdrawn(S,Y)`, `relaxed(S)` | Declared a Doctor; text replaced; dispensed or abrogated. |
| `cites(S,S2)`, `reaffirms(S,S2)` | Repeats (no weight); re-teaches (weight). |
| `ambiguous(S)`, `reading(S,R)`, `reads(S,R,Q,V)` | One branch per reading. |
| `holds_reading(S,R)` | A runtime's reading of S: only the branches it holds. |
| `interprets(S,S1,R)` | Weighs for a reading; never fixes one. |
| `oum_claim(S,T)` | Claimed as ordinary universal magisterium at tier T; computed both ways. |
| `binds(L,T,O)` | Law L attaches obligation O to tier T. |
| `custom_practice/4` and companions | Custom, cc. 23–28. |
| `salience(S,high)`, `relies_on(A,S)` | Warnings only. |

## CANON

| Fact | Meaning |
| --- | --- |
| `consecration(E,P,R,D)`, `co_consecrator(E,B)`, `pontifical_mandate(E)` | Consecrations. |
| `decree(D,I,Date)`, `declares(D,P,N)`, `issuer(X,A)`, `authority(A,R)` | Decrees. Ranks: 4 pope (or approved), 3 dicastery, 1 ordinary. |
| `heard/2`, `summoned_absent/2`, `recourse/3`, `recourse_decided/2`, `recourse_upheld/1` | Procedure (cc. 1720, 1353). |
| `grant/5`, `permission/4`, `revocation/3` | Faculties and their revocation. |
| `absolution/4`, `marriage/3`, `delegation/5` | Acts whose validity is computed. |
| `danger_of_death/2`, `just_cause_request/3`, `common_error/1` | cc. 976, 1335 §2, 144. |
| `asserts(T,Claim,Date)` | A text's claim, checked act by act. |
| `disputed(F)` | Computed both ways: `heard/2`, `common_error/1`, `appears_otherwise/2`. |
| `authentic_reading(C,R,Act)` | The legislator's reading (c. 16 §1). |

A new canon goes under `% @norm id | citation | source`. New slots go under
`% @input name/arity | meaning`. See [ttc-canon(5)](canon-law-layer.md).

## THE PAIR

| Fact | Meaning |
| --- | --- |
| `classification(Q,E,Kind)` | Theological question Q classifies event E. Where Q holds `no`, the law treats E as not of that kind. |
| `premise(N,Q,V)` | Norm N presupposes V on Q. Applied where Q holds otherwise: violation. |

Law never answers a doctrinal question (`teaching_from_law`).

## LIBRARY

| Fact | Meaning |
| --- | --- |
| `work(W,Author,Title,Imprint,Year)` | A book. Do not enter ISBNs by hand. |
| `cites_work(S,W,Locator)` | Where source S is read. |
| `online(W,URL)` | A reliable text online; no trip needed. |
| `to_read(W,Why)` | Research owed. |
| `consulted(S)` | Checked against print. Use `mark_consulted`. |

## OUTPUT

| Atom | Meaning |
| --- | --- |
| `holds(Q,V)` | This branch's answer. |
| `branch(main\|live_shadow\|counterfactual_shadow)` | Its status. |
| `cleaved_by/1`, `reintegrates_if_relaxed/1` | What cleaves it; what would restore it. |
| `read_as/2`, `oum_holds/1`, `t2_truth`, `assumed_fact/1` | What it assumes. |
| `weight(T,N)` | Disagreement at tier T. A preference, not a verdict. |
| `violation(X)` | A rule is broken. Ask whether the rule or the text is wrong. |
| `info(X)` | Noted. |
| `frontier(Layer,X)` | Still to encode or read. |

A value is *settled* if every main branch has it, *open* if some do, a
*shadow* if only shadows do, *excluded* if none do.

## EXAMPLES

```prolog
question(q(example)). question_kind(q(example),doctrinal).
value(q(example),yes). value(q(example),no).
source(enc_x,3,truth,1990). papal_form(enc_x,ordinary). character(enc_x,encyclical).
supports(enc_x,q(example),yes).
source(theol_y,5,truth,2001). supports(theol_y,q(example),no).
```

Result: `yes` settled, with `no` a live shadow of `enc_x`. Make `enc_x` an
`interview` and both are open.

## RESTRICTIONS

Snippets may not contain `#script`, `#include`, `#program`, `#end` or
`@`-terms. Each open question doubles the branches, so fix readings you are
not testing: `:- not read_as(s,r).`

## BUGS

The facts are only as honest as whoever wrote them.
