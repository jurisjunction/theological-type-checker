<!-- Copy of src/theological_type_checker/guide.md (the MCP server serves that file). Edit it there, then copy it here; a test checks they match. -->

# Encoding guide

This is the working manual for anyone, human or model, who wants to put a
new text, case or rule in front of the checker. Read the theory first
(`docs/guide-for-theologians-and-canonists.md`) if you have not.

## The one rule that matters

**Encoding is interpretation; checking is mechanical.** Every choice you make
when you turn a text into facts (what question it answers, at what tier,
in what form, read which way) must be written down as a fact someone else
can dispute. If a choice is genuinely open, do not make it. Declare the text
`ambiguous` and let the checker compute every reading.

## Workflow

1. **Find the nearest existing case.** `list_parts` shows the models, cases,
   switches and candidate rules, and `read_part` shows one block's source. The
   SSPX case (`sspx`) and the remarriage case (`remarriage`) are the most
   complete worked examples.
2. **State the questions.** Each disputed point becomes `question(Q)` with
   its `value(Q,V)` options and a `question_kind`: `doctrinal` (teaching),
   `governance` (law, discipline) or `juridical` (a juridical fact or effect).
   The kind is the most consequential choice you will make: lex posterior
   (c. 20) applies to governance and juridical questions, never to teaching.
   If the kind is itself disputed, make it a choice (see `remarriage`).
3. **Enter the sources.** One `source/4` per act, with its tier, force and
   year. Then add its form, character, legislator rank and what it supports.
4. **Run `check`.** Read the result as branches, not verdicts (see below).
5. **When the checker disagrees with an author,** you have a question, not
   an answer: either the checker is wrong or the literature is. Test the
   checker's side with `fix_method`. Change the rule, and see whether the
   whole suite's explanatory power improves or degrades.

## Inputs: the authority layer

| Fact | Meaning |
| --- | --- |
| `question(Q)`, `value(Q,V)` | A disputed point and its possible answers. One branch per value. |
| `question_kind(Q,K)` | `doctrinal`, `governance` or `juridical`. |
| `default(Q,V)` | The value that holds unless a source in force supports another (c. 1058: what no law forbids is open). |
| `source(S,T,F,Y)` | Act `S`, tier `T` (1–5), force `F` (`truth`, `juridical`, `protective`), year `Y`. |
| `supports(S,Q,V)` | `S` holds value `V` on `Q`. |
| `papal_form(S,F)` | `ex_cathedra` (tier 1), `definitive_declaration` (2), `legislative` or `ordinary` (3). A mismatch with the entered tier is a violation. |
| `character(S,K)` | Document character for LG 25 weight. 3: `constitution`, `encyclical`, `conciliar_constitution`. 2: `conciliar_decree`, `exhortation`, `declaration`, `instruction`, `catechism`, `apostolic_letter`, `profession`. 1: `letter`, `address`, `homily`, `notification`, `responses`, `commentary`. 0: `interview` (not magisterial; cannot cleave). |
| `dicastery(S)`, `conference(S)`, `diocesan(S)`, `conciliar(S)` | Legislator rank for governance (c. 135 §2). Papal legislative acts rank highest. |
| `by_papal_mandate(S)`, `in_forma_specifica(S)` | A curial act the pope has made his own; it takes papal rank. |
| `protects(S,Q)` | With force `protective`: sources at or below `S`'s tier cannot cleave `Q`. |
| `promoted(S,T,Y)` | `S` moves to tier `T` in year `Y` (a theologian declared Doctor). |
| `withdrawn(S,Y)` | `S`'s text was replaced in year `Y`. |
| `relaxed(S)` | `S` dispensed, abrogated or changed. Use it to ask what returns. |
| `cites(S,S2)` | `S` repeats `S2`: no independent weight. |
| `reaffirms(S,S2)` | `S` re-teaches `S2` as a new act: adds weight. |
| `ambiguous(S)`, `reading(S,R)`, `reads(S,R,Q,V)` | `S` can be read more than one way. One branch per reading. |
| `interprets(S,S1,R)` | `S` reads `S1` as `R`: weighs against other readings, never fixes one. |
| `oum_claim(S,T)` | Someone claims `S` is taught at tier `T` by the ordinary universal magisterium. Computed both ways unless a tier-1 act fixes it. |
| `binds(L,T,O)` | Law `L` attaches obligation `O` to whatever is taught at tier `T` (incorporation by reference, e.g. c. 752). |
| `custom_practice(C,Q,V,Y)` and `community_capable/1`, `approved_custom/1`, `approver/2`, `reprobated/1`, `contra_divine/1`, `law_forbids_customs/1`, `expressly_revokes/2` | Custom, cc. 23–28. |
| `salience(S,high)`, `relies_on(A,S)` | What people actually cite. It produces warnings only, never verdicts. |
| `asof(Y). custom_asof.` | Evaluate the graph as of year `Y` (parts `asof_1400` … `asof_2018` do the same). |

**Persons and forums.** Imputability is an *input* from the internal forum,
never computed. `internal_forum_actor(A)` names who may supply it,
`discerned(P,diminished|full,A)` supplies it, and any other actor is a
`diagnosis` violation. In the SSPX case, a *declaration* about a person
needs a named person and a hearing; a statement about a class is not one.

## Inputs: the core grammar

Persons and sorts: `god/1`, `divine/1`, `created_person/1`, `incarnate/1`,
`bridegroom/1`, `organism/1`, `one_power/2`. Origination:
`gen(Act,Source,Term)`, `closed_in_act(Act,X,Y)`. Bonds: `proposed_bond/2`,
`consent/2`, `capable_closing/2`, `impeded/2`, `held_for(Holder,X,Y)`.
Gift: `total/2`, `side_by_side/3`. Predication about Christ: `sentence/3`,
`term_sort/2`, `pred_nature/2`, `unsafe_unqualified/1`, `qualified/1`. See
`icon_models.lp` for one complete model of each kind.

Do not write a rule that mixes divine- and creature-sorted predicates
without going through `licensed/2`, `mode/3` or `bridge/3`; `lint` will flag
it. That is the analogia entis enforced as a type discipline.

## Inputs: the canon-law layer

Juridical questions do **not** go in the authority graph. Canon law is
computed as dated yes/no rules (`canon_law.lp`), and a case supplies facts
(`canon_cases.lp`, or your own case file). Dates are integers `YYYYMMDD`, and
each act is judged on its own date.

| Fact | Meaning |
| --- | --- |
| `consecration(E,P,R,D)`, `co_consecrator(E,B)`, `pontifical_mandate(E)` | Episcopal consecrations |
| `decree(D,Issuer,Date)`, `declares(D,Person,Norm)`, `issuer(Act,A)`, `authority(A,Rank)` | Penal decrees. Rank 4 is the pope (or papal approval), 3 a dicastery, 1 an ordinary. |
| `heard(D,P)`, `summoned_absent(D,P)`, `recourse(D,P,Date)`, `recourse_decided(D,Date)`, `recourse_upheld(D)` | Procedure (cc. 1720, 1353) |
| `grant(G,Issuer,Faculty,Class,Date)`, `permission(P,Issuer,Class,Date)`, `revocation(Act,G,Date)` | Faculties and their revocation (c. 135 §2) |
| `absolution(A,Priest,Penitent,Date)`, `marriage(M,Priest,Date)`, `delegation(Del,Ordinary,Priest,M,Date)` | Acts whose validity is computed |
| `danger_of_death/2`, `just_cause_request/3`, `common_error/1` | cc. 976, 1335 §2, 144 |
| `asserts(Text,Claim,Date)` | A text's claim, checked against what the norms derive for each act |
| `disputed(F)` | A fact computed both ways (supported: `heard/2`, `common_error/1`, `appears_otherwise/2`) |
| `authentic_reading(Canon,Reading,Act)` | The legislator's own reading (c. 16 §1) |

A new canon goes under a tag:
`% @norm <id> | <citation> | <primary source URL>`. New fact slots are
declared with `% @input <name>/<arity> | <meaning>`. `norm_check` must stay
clean: no vicious cycles, and no undefined predicates. Never encode
imputability: c. 1321 §4's external presumption is all the layer uses.

## Outputs

| Atom | Meaning |
| --- | --- |
| `holds(Q,V)` | In this branch, `Q` has value `V`. |
| `branch(main)` | Nothing in force cleaves this branch. |
| `branch(live_shadow)` | Cleaved only by reformable sources; `reintegrates_if_relaxed(S)` names them. |
| `branch(counterfactual_shadow)` | Cleaved by a tier-2 truth source on the assumption `t2_truth`. |
| `read_as(S,R)`, `oum_holds(S)`, `t2_truth` | The assumptions this branch rests on. |
| `weight(T,N)` | Disagreement at tier `T` (lower is better). It states a preference, never a resolution. |
| `violation(X)` | The facts break a rule. Each one is a question for you. |
| `info(X)` | Noted, not an error. |
| `theorem(X)`, `verdict(X,V)` | Results of the core grammar. |
| `info(presumed_incurred(P,N))`, `info(declared(P,N))`, `info(declaration_suspended(D,P))` | Penal status, canon-law layer |
| `info(absolution(A,valid,licit))` and similar, `info(marriage(M,valid_form))` | Validity and liceity of acts |
| `info(claim_confirmed(T,C,A))`, `info(claim_contradicted(T,C,A))` | A text's claim, act by act |
| `assumed_fact(F)` | The disputed facts this branch assumes |

**How to read a result.** A value is *settled* if every main branch has it,
*open* if some do, a *shadow* if only shadows do, *excluded* if no branch
does. Tier 1 deletes branches. Tiers 2–3 and juridical acts cleave them into
shadows. Everything else only weighs.

## A minimal new case

```
question(q(example)). question_kind(q(example),doctrinal).
value(q(example),yes). value(q(example),no).
source(enc_x,3,truth,1990). papal_form(enc_x,ordinary). character(enc_x,encyclical).
supports(enc_x,q(example),yes).
source(theol_y,5,truth,2001). supports(theol_y,q(example),no).
```

`check(parts=[], facts=<the above>)` returns `yes` settled, with `no` as a live
shadow of `enc_x`. Make `enc_x` an `interview` and `no` becomes open.

## What a snippet may not contain

`#script`, `#include`, `#program`, `#end` and `@`-terms are rejected:
snippets are data and rules only. Large open problems multiply branches
(each open question doubles them). Fix readings you are not testing with
constraints such as `:- not read_as(s,r).`
