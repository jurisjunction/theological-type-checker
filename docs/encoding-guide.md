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

Facts and snippets are clingo. The base itself is written in L and
compiled to clingo (ttc-l(1)); `read_part` shows the
compiled text.

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
   `rt_suarezian`, `rt_palamite`; `rt_saussure`, `rt_vocal`, `rt_lingual`;
   `rt_bare` for none; two for a pair). Name a runtime when the answer
   depends on a school. A runtime of the person's own is saved to the
   personal layer with `save_runtime` and run as any other (THE LAYER'S
   RUNTIMES).
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
| `source(S,T,F,Y)` | Tier 0–5; force `truth`, `juridical` or `protective`; year. Tier 0 is a text of Scripture: give it readings, never `supports`. |
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
| `particular_reply(S)` | A juridical answer given in a particular matter (c. 16 §3): weighs at its tier; never cleaves, so no lex posterior between replies; in forma specifica too. On a source of force `truth`, nothing. |
| `oum_claim(S,T)` | Claimed as ordinary universal magisterium at tier T; computed both ways. |
| `consent_claim(S,R)`, `faith_morals(S)`, `records_diverse_readings(F,S)` | The Fathers' unanimous consent for reading R of text S: computed both ways; binds in faith and morals; refused where F records diverse readings. |
| `binds(L,T,O)` | Law L attaches obligation O to tier T. |
| `custom_practice/4` and companions | Custom, cc. 23–28. |
| `salience(S,high)`, `relies_on(A,S)` | Warnings only. |

### Persons and origin

| Fact | Meaning |
| --- | --- |
| `god(G)`, `divine(X)`, `created_person(X)` | God; a divine person; a created person, human or angelic. The kernel also derives some (the incarnate is divine; an angel is a created person). |
| `gen(A,Source,Term)` | Source contributes to the origin of Term in the act A: a begetting, a spiration, a conception. |
| `being(P,X)`, `less(X,Y)`, `denies_image(X,R)` | Claims: that P gives X its being (the kernel derives it from God for every creature), that X ranks below Y, that X lacks the image of God for the reason R. Refused where the kernel forbids them (`being_from_non_god`, `receiver_ranked_lower`, `image_denied`). |
| `held_for(P,X,Y)` | P holds X's consent to Y in trust (an infant's, at baptism). |
| `free_of_original_sin(X)` | A claim that X contracted no original sin. Of a human being, refused (`original_sin_denied`): the sin is "into the whole human race", "in each one as his own" (DH 1512-1513); not of the incarnate, nor of Mary, whom the decree does not include (DH 1516). Of a group or a juridic person, refused (`original_sin_of_fiction`): a people is entered by its members. |
| `denies_descent(X,R)` | A claim that X, a human being, does not descend from Adam, for the reason R (`many_first_parents`, `before_adam`, `separate_creation`). With the part `one_root` (*Humani generis* 37, tier 3), refused in the main branch only (`descent_denied`); its contrary a live shadow. Without it, silent. |

### The incarnate

| Fact | Meaning |
| --- | --- |
| `incarnate(X)` | X is the Son incarnate: divine, of a human nature. With the Trinity loaded, X must be its begotten person. |
| `in_nature(A,K)`, `changes_in(X,K)` | An act (a birth) or a change said of a person in nature `hum` or `div`. Say the nature: said of the person alone, a birth gives the Son a second principle and a change is change in God. |
| `term_sort(T,suppositum)`, `pred_nature(P,K)`, `sentence(S,T,P)` | Predication (T5). A person's name takes only predicates of a nature the person has. |
| `descends_from(P,adam)`, `caused_by(E,C)`, `happens_at(E,T)`, `next(E1,E2)`, `foreseen(E,C)` | The economy: descent, causes, the order of events (no cycle; not necessarily a line), merits foreseen. Causes ordered in time only with the part `causes_precede`. |

### Morality, sin, grace

| Fact | Meaning |
| --- | --- |
| `kind_of_act(A,K)` | The kind of act a case says its act is: an outward fact. |
| `classification(Q,K,evil_by_object)`, `classification(Q,K,grave_matter)` | What a kind is, morally: teaching, from the authority graph. Never of a person. |
| `interior(P,A,X)` with X = `full_knowledge`, `deliberate_consent`, `evil_unintended`, `proportionate_reason` | Claims about the agent (act.lp). Mortal sin and double effect are composed "on the claims"; proportion is never computed. |
| `interior(P,state,in_grace)` | Being in grace: a claim, computed both ways if disputed; never derived (Trent, DH 1534). |
| `effect(A,E,V)` (V good or evil), `means(A,E1,E2)`, `forbids(L,K)` | Double effect's outward conditions; a law forbidding a kind (a law that does not bind makes nothing sinful). |
| `salutary(P,A)`, `beginning_of_faith(P,A)`, `justification(P,A)`, `moved_by(P,A,G)`, `efficacious(G)` | Grace: no salutary act without it; in justification the will acts. |
| `object_is(A,E)`, `evil_kind_of(E,K)`, `interior(P,A,chooses(E))` | An act that consists in an evil effect; the kind of that effect (`killing_of_innocent`); the claim that it is chosen. With `q(direct_by)` (part `direct_reading`), an evil means is direct by the order of causes, or where it is claimed chosen. The direct act takes the kind `direct(K)`: composed, never typed by hand. |
| `permitted_only_if(K,C)`, `prudential(A,C)`, `denied(C)` | A kind permitted only where conditions hold (the death penalty, just war). Each condition is the judgment of those responsible (CCC 2309): supplied, never computed. The theological side may deny one today. |
| `commands(L,K,O)`, `occasion(P,O)` | An affirmative precept: "must" only where its occasion is supplied. One that commands what is evil by its object is refused. |
| `teaching_type(S,T)` (`principle`, `criterion`, `directive`) | Social teaching typed (CCC 2423). A directive cited as fixing what is evil by its object is refused. |
| *output* `info(verdict(A,may,G))`, `info(verdict(A,must_not,G))`, `info(obligation(P,K))` | Verdicts are said of acts. Must not: by its object, or by a denied circumstance. May: by double effect on the claims, or on the judgment. An act lacking a claim gets no verdict. |

### Tiers, faith, communion

| Fact | Meaning |
| --- | --- |
| `conciliar_act(S,K)` (`canon`, `definition`, `creed`, `scope`, `chapter`), `session_defines(S)` | Rule 14: a source at tier 1 or 2 needs a warrant: a council's own defining act, a chapter its session binds, or a creed received (below). Otherwise `tier_without_warrant`. |
| `reception_claim(S,C,Year)`, `reception_fixed_by(S,F)` | A creed received: a claim, with its claimant C and the year from which it claims reception. From that year computed both ways, never preferred, unless an act F at tier 1 in force hands the creed on. Not received, not in force. The undated `received_creed(S)` is refused. |
| `papal_form(S,ex_cathedra)`, `condition_shown(S,C)`, `object_of(S,O)` | A papal definition, with the conditions of Pastor aeternus shown: `pastor_of_all`, `apostolic_authority`, `defines`, `faith_or_morals`, `whole_church`. The form says that it defines; the object gives the grade: `revealed`, tier 1; `connected` (a dogmatic fact), tier 2. |
| `papal_form(S,definitive_declaration)` | A declaration that a teaching is to be held definitively, defining nothing: its own tier, 3, with an `oum_claim` whose claimant is its author, or `declaration_without_claim`. |
| `silent(P,E,Q)` | An outward silence: no censure, and no assent. Assent is interior and never computed (Vineam Domini). |
| `oum_claim(S,K)`, `oum_claimant(S,C)` | A claim of the ordinary universal magisterium. The consensus is a source of its own, `oum(S)`, at grade K (both, where the claimant states none); S keeps its tier. Without LG 25's conditions shown by a witness apart (`witnessed_by/3`), never preferred (c. 749 §3). |
| `witnessed_by(S,C,W)` | LG 25's condition C (`dispersed_in_communion`, `authentic_teaching`, `faith_or_morals`, `one_position_definitive`) shown for the claim on S by the witness W. A witness that is the claim, its consensus `oum(S)`, a claimant, one who grades or states it, or an act in a claimant's name: `witness_is_claimant`, and the condition unmet. `condition_shown/2` entered alone for these: `condition_without_witness`, unmet. A snippet may not draw a witness from a conclusion (`oum_holds/1` and the like): refused at the gate. |
| `communion_judged_by(W,Q)` | The witness W counts the bishops in communion by their answer on Q. On the very question the claim supports: `communion_from_the_teaching`, the condition unmet. |
| `claim_stated(S,C)`, `in_name_of(A,P)` | Who states the claim on S in its own words (`first_stated`, `never_stated`; a claimant entered without it, `claim_unstated`); an act issued in P's name, by vicarious power or approved in common form (c. 131 §2; c. 360): its claims stay its own (`claim_attributed`), and no tier changes. |
| `claims_tier(C,S,K)`, `treated_as_fixing(C,S)` | A statement about a tier: flagged when a lower tier speaks of a higher; refused when treated as fixing. |
| `self_limited(S)`, `self_limits(S,Q)` | S's own text says it settles nothing, or nothing on Q: its manner of speaking (LG 25). At tier 3 it weighs and cleaves nothing there, no note is read from it, and c. 752 attaches nothing to it (or nothing on Q). It reaches only S: what S cites or reaffirms keeps its tier. Another text's lowering of S is `claims_tier`. On a definition, refused (`limit_on_a_definition`). |
| `ranks_lower(C,Q)` | C treats Q as owed less assent for its place in the hierarchy of truths (UR 11): refused, whoever says it (`hierarchy_as_grade`; *Mysterium Ecclesiae* 4). The hierarchy is not modelled and grades nothing. |
| `professes(P,E,Q,V)`, `doubts(P,E,Q)`, `repudiates(P,E,christian_faith)` | Outward professions. The censure follows the note contradicted: heretical, contrary to definitive doctrine, erroneous, or rash (against a directive). A doubt is censured only against de fide teaching. Omission is not denial. |
| `interior(P,E,pertinacious)` | Pertinacity, which is c. 751's obstinacy: a claim. Formal heresy, and faith held in no article, are composed on it. |
| `baptized_in(P,C)`, `received_into(P)`, `formal_defection(P,D)`, `communion_at_issue(P)` | cc. 11, 96, 205, 1117: who is bound by ecclesiastical law, incorporated, in full communion, bound to the form. A case's silence binds. |
| `warned(P,E,By)`, `retracted(P,E)` | c. 1371 n. 1 (1983; 1998) and c. 1365 (2021): obstinate rejection after a warning; a penalty to be imposed, never incurred. |
| parts `assent`, `report_notes` | cc. 750 §§1–2 and 752, by reference; every note, reported. |

### Christ, presence, the sacraments

| Fact | Meaning |
| --- | --- |
| `act_of(P,A)`, `in_nature(A,K)`, `instrument_of(A,D)` | An act of a person, by a nature. The incarnate places a human act by the nature assumed, on a runtime that grants it an operation; one act in both natures is refused (DH 557). |
| `classification(Q,P,without_actual_sin)` | The theological side says a person is without sin; claims composing a sin of that person are refused. Christ's is the kernel's (DH 301). |
| `present(X,Place,Mode)` | Presence, typed by mode. The deposit's: `natural`, `sacramental`, `immensity`; Thomas's: `circumscriptive`, `definitive`. No rule compares two modes. Whether one body is circumscribed in two places is a runtime's. |
| `celebrated(E,K,Minister,Recipient)`, `celebration_date(E,D)` | A sacrament celebrated: K is `baptism`, `confirmation`, `eucharist`, `penance`, `anointing`, `orders(G)`; `matrimony` names the sacrament where a condition of it is at issue (a marriage is `marriage/3`, canon). Absolutions and consecrations are routed from the canon layer. |
| `matter_used(E,M)`, `form_used(E,F)`, `contrary_intention_manifested(E)`, `simulated(E)`, `conditional(E)` | A recorded defect fails a condition; the intention is presumed from the rite rightly used (Apostolicae curae 33). |
| `classification(Q,cond(K,C),of_substance)`, `classification(Q,form(K,F),valid_form)`, `classification(Q,L,of_divine_law)` | Which conditions are of the substance, which forms are valid, which laws are divine: teaching. A condition's law then decides whether it can be dispensed. |
| `interior(R,E,no_obstacle)`, `age_at(R,E,Y)` | The fruit is composed on the claim; for an infant, "reborn" on the deposit (DH 1514). Neither is a state of grace. |
| `host_of(E,H)`, `reserved(H)`, `fragment_of(H2,H)`, `species_ceased(H)` | The Eucharist: Christ present under each host and each fragment while the species remain (DH 1651-1654). |

## CANON

| Fact | Meaning |
| --- | --- |
| `consecration(E,P,R,D)`, `co_consecrator(E,B)`, `pontifical_mandate(E)` | Consecrations. |
| `decree(D,I,Date)`, `declares(D,P,N)`, `issuer(X,A)`, `authority(A,R)` | Decrees. Ranks: 4 pope (or approved), 3 dicastery, 1 ordinary. |
| `heard/2`, `summoned_absent/2`, `recourse/3`, `recourse_decided/2`, `recourse_upheld/1` | Procedure (cc. 1720, 1353). |
| `notified(D,P,Date)` | The decree made known to a person it names: its effect for him runs from then (c. 54 §1). Not entered, the effect is dated from the decree, and a note says so. |
| `approved_in_specific_form(D)` | A curial decree the Pope approved in specific form: his own act, against which no recourse lies (c. 333 §3). |
| `decides_recourse(D2,D)` | D2 decides the recourse against D. The Dicastery's decision on a recourse against its own act, in a delict reserved to it, admits no further recourse (SST art. 24 §1). |
| `interior(P,E,deliberate)`, `interior(P,E,negligence)` | The source of grave imputability, dolus or culpa: a claim supplied from the acts, never computed. With neither entered, a *latae sententiae* penalty turns on the reading of c. 1321 §4 (`presumes_imputability` or `presumes_dolus`), computed both ways. Whether c. 18 reaches §4 is itself disputed (`penal_use(c1321_4)`): where it does, only `presumes_imputability` stands. |
| `interior(P,E,ignorance(Of,K))`, K = `crass`, `supine`, `affected` | c. 1325: never taken into account under cc. 1323-1324. What it supplies is read three ways: nothing (`bar_only`); dolus (`as_dolus`); affected ignorance dolus, crass and supine culpa (`affected_as_dolus`; ST I-II q. 6 a. 8). |
| `interior(P,E,defence(immoderate))`, `interior(P,E,provoked(grave,unjust))`, `interior(P,E,imputability(diminished))` | c. 1324 §1 nn. 6, 7, 10: the penalty tempered, and no *latae sententiae* penalty binds (§3). Claims, never computed. |
| `interior(P,E,imputability(not_grave))` | c. 1321 §2: not gravely imputable. No penalty, and no delict in the formal sense. A claim, never computed. |
| `interior(P,E,passion(grave,stimulated))`, `interior(P,E,foresaw(certain))` | c. 1326 §1 nn. 4, 3: passion deliberately stimulated or nourished supplies dolus, and aggravates; culpa with the event foreseen aggravates where the law punishes culpa. |
| `interior(P,E,disturbance(culpable))`, `interior(P,E,disturbance(sought))` | With `interior(P,E,reason(lacking))`: the lack of reason culpably brought on (drunkenness or a similar disturbance), or sought so as to commit the offence or to excuse it. The deed is no human act, but voluntary in its cause (II-II q. 150 a. 4): culpable, the penalty is tempered and no *latae sententiae* penalty binds (c. 1324 §1 n. 2, §3); sought, it supplies dolus and aggravates (c. 1326 §1 n. 4). For imputability only: consent and juridic acts still need actual reason. Claims, never computed. |
| `grant/5`, `permission/4`, `revocation/3` | Faculties and their revocation. |
| `absolution/4`, `marriage/3`, `delegation/5` | Acts whose validity is computed. |
| `danger_of_death/2`, `just_cause_request/3`, `common_error/1` | cc. 976, 1335 §2, 144. |
| `communion/3`, `situation/2`, `situation_kind/2`, `manifest/1`, `persisting/1`, `confession_impossible/2` | cc. 912, 915, 916: c. 916 is the internal forum, computed both ways; c. 915 branches on the reading of "manifest grave sin". |
| `asserts(T,Claim,Date)` | A text's claim, checked act by act. |
| `juridic_act(J,P)`, `spouse(M,P)`, `born(P,Date)`, `age_at(P,A,Years)` | A juridic act (c. 124); a party to a marriage; a birth date, from which ages are computed (c. 97 §1, c. 203: on the birthday the year is not yet completed); or an age given. |
| `interior(P,A,Claim)` | What a case claims of the agent's knowledge, will or freedom: `ignorance(Of,Kind)`, `error(…)`, `fear(Grade,Origin,How)`, `violence`, `reason(…)`, `passion(…)`, `necessity`, `deliberate`, `negligence`, … Never derived; read by the human-act library (`act.lp`). |
| `disputed(F)` | Computed both ways: `heard/2`, `common_error/1`, `appears_otherwise/2`, `interior/3`. |
| `authentic_reading(C,R,Act)` | The legislator's reading (c. 16 §1). Its reach: `interpretation_form(Act,F)` (F: `law` or `particular`), `particular_matter(Act,E)`, `promulgated(Act,Date)` (c. 16 §§2–3). |
| `reading_option(L,R)`, `narrower(R1,R2)`, `needs_reading(L,Context)` | The readings a law admits; a disputed one branches (c. 17), penal terms read strictly (c. 18). |
| `penal_use(L)` | c. 18: the law's terms set a penalty or make an exception, so the narrower reading stands. Entered by a case, or disputed and computed both ways (c. 1321 §4). |
| `law_kind(L,K)`, `legislator(L,A)`, `permits/1`, `obliging/1`, `invalidating/1`, `reaches(L,R,X)` | A law: kind (eternal, natural, divine_positive, ecclesiastical, civil), maker, effect, reach (library `law.lp`). |
| `lacuna(M)`, `penal_matter(M)`, `equity_rule(M,R)` | c. 19: equity is input, never computed. |
| `dispensation(D,L,X)`, `defines_essentials(L)` | cc. 85–86. |
| `unbaptized(P)` | c. 842 §1: the other sacraments need baptism. |
| `consummated(M)`, `dissolution(D,M,Kind,Date)`, `nullity_sentence(S,M,Date)`, `sentence_effective(S)`, `prohibited_to_marry(P)` | The bond: dissolved only where cc. 1142-1143 allow, never ratified and consummated (c. 1141); a sentence of nullity settles the forum, never the fact (cc. 1643, 1682 §1). |
| `delict_act(P,N,Act)`, `act_date(Act,Date)` | A delict that need not be a consecration, absolution or marriage (e.g. c. 1386 §1, the seal). |
| `aas_issue(L,Date)`, `aas_volume(L,Year,Given)`, `vacatio_set(L,Date)` | c. 8 §1: in force on the day of the same number three months after the issue's date (the first of the next month where it lacks the day); an issue unread gives a span, inside which a date is computed both ways; a law naming its own date keeps it. |
| `declaratory(Act)` | c. 16 §2: an interpretation in the form of law reaches acts from its force (c. 8 §1), earlier ones only if declaratory (c. 9). |
| `procures(P,A)`, `unborn(E)`, `by_expulsion(A)`, `attempted_only(A)` | c. 1397 §2 (c. 1398 before 2021): the matter is the library's direct killing of an innocent, unborn, completed; the reading of 1988 extends it to any killing from conception, from 1988. An attempt is not the delict (c. 1328 §1). |
| `assists(P,A)`, `necessary_assistance(P,A)` | c. 1329 §2: a necessary accomplice incurs a latae sententiae penalty; one not necessary may be punished. |
| `cleric(P)`; the clause `age_clause(D,N)` with `issuer(D,A)` | c. 1398 §1 n. 1 and the Dicastery's art. 6 n. 1: the error about the age disregarded where the clause is papal law; refused as a dicastery's decree; flagged where the act is lawful apart from the age. |
| `special_gravity(Auth,A)`, `scandal_necessity(Auth,A)` | c. 1399: the authority's two judgments, supplied, never computed; a penalty to be imposed, besides the cases prescribed, on those c. 11 binds. |
| `transfer(D,P,Date)` | c. 1752: the salvation of souls kept in view; no effect, no weight against the law. |
| `ascribed(P,C)`, `father/2`, `mother/2`, `agreed(Child,C)` | The Church *sui iuris* that selects the code: recorded, or a child's computed (c. 111 §1; CCEO c. 29 §1). Silence ascribes a Catholic to the Latin Church. The Latin delicts do not reach the Eastern faithful (c. 1); the Eastern layer (`canon_cceo.lp`) imposes its penalties, never incurs them. |
| `priest(P)`, `deacon(P)`, `baptized_in(P,orthodox_church)` | A priest (a bishop is one by derivation) or a deacon. The form across the codes: a priest for an Eastern party (CCEO c. 828; c. 1108 §3 from 2016); with an Eastern non-Catholic, the form for liceity only (c. 1127 §1; CCEO c. 834 §2). |
| `pastor_of(P,T)`, `ordinary_of(P,T)`, `held_in(M,T)`, `within(T,D)`, `witnesses(M,N)` | The form by office: the pastor and the local ordinary assist validly within their territory, one party Latin (c. 1109; CIC 1917 c. 1095 §1 n. 2, no proviso), and the pastor delegates within it (c. 1111 §1); a pastor is a priest (c. 521 §1). Fewer than two witnesses given fails the form (c. 1108 §1); silence is no defect. |
| `faculty_to_confirm(P)`, `typed_ordinary_minister(P,K)` | A presbyter confirms validly by law (an Eastern presbyter, CCEO c. 696 §1) or faculty (c. 882); the ordinary minister is the bishop alone (DH 1630). |
| `promulgated_elsewhere(L,Date)` | A law promulgated outside the *Acta*: its three months from that publication or from the *Acta*, a disputed reading where they differ. |
| `particular_law(L)` with `promulgated(L,Date)` | c. 8 §2: a particular law obliges a month after the day of promulgation, on the day of the same number (the first of the next month where it lacks the day), unless it sets its own time (`vacatio_set`). A law binds only the acts placed in its force (c. 9). |
| `option_of(L,M,Holder)`, `narrows(L,M)`, `withdraws_option(L,M)` | c. 135 §2 with c. 838 §4 and RS 21: a law narrowing a choice a higher law leaves to its holder (a liturgical book's to the celebrant) is contrary to it, and from a lower legislator does not bind. Tested on the day the narrowing law is promulgated, against a choice then open, on each ground then in force (c. 135 §2 from 27 November 1983; RS 21 from 23 April 2004); a choice the supreme authority withdraws is open no longer. RS 21 is a ground only while its provision has force (cc. 33–34). A choice left to the narrowing law's own legislator (`holds_as/2`) is his to exercise, not higher *ius* (GIRM 283, 387). |
| `holds_as(A,Holder)` | The authority holds a choice as one of the holders `option_of/3` names (a diocesan bishop as `diocesan_bishop`). |
| `right_of_the_faithful(M)`, `regulates_exercise(L,M)` | c. 223 §2: authority may direct the exercise of a right of the faithful for the common good (receiving on the tongue, RS 92; kneeling, RS 91). Whether a law does so is a prudential judgment: enter it, or dispute it (`disputed(regulates_exercise(L,M))`) and it is computed both ways. Where it holds, the narrowing binds (`regulates_right/2`). It never rescues a choice left to a minister. |
| `decision_on_recourse(D,L,Outcome)` | c. 1739: a superior's decision on recourse against L (`confirmed`). Given by an authority higher than L's legislator, a confirmation settles a disputed regulation for L alone; it reaches no other law in the same matter (`not_reached_by/2`, c. 16 §3). Enter its `issuer/2`. |
| `contrary_to_provision(L,P)` | c. 135 §2 with cc. 33–34: a finding that the law L cannot be reconciled with the provision P of an executive act. Higher *ius* includes a higher authority's executive norms, but only through a provision with force on the day L is promulgated: reconciled with the law (c. 34 §2), its law not ceased (§3). Then L does not bind. A provision of the legislator's own act, or one without force that day, leaves L standing; with no day of promulgation the finding is not tested (frontier). |
| `enacted_by(B,L)`, `part_of(N,B)`, `revokes(L2,B,Way)`, `reorders(L2,B)`, `directly_contrary(L2,B)`, `doubtful_revocation(L2,B)` | A code at a date is a view: each body of texts enacted by its act, and a rule fires only under the text in force at the event's date. c. 20's three ways (`expressly`, `contrary`, `reorders`); a doubtful revocation is not presumed (c. 21): the earlier text stays in force, and nothing branches. The Code of 1917 is abrogated by c. 6 §1 n. 1; the form of marriage is read from it until 26 November 1983, and no text governs a marriage before 19 May 1918 (`no_text_in_force`). |
| `born_of_noncatholics(P)`, `raised_outside(P)` | CIC 1917 c. 1099 §2: not bound to the form, marrying a non-Catholic, until 31 December 1948. |
| `act_kind(A,K)`, `executes(A,L)`, `effective_from(A,Date)`, `executive_power_only(D)`, `express_grant(D)`, `provision(A,P)`, `contrary_provision(P,L)`, `doc_at_issue(X)` | Executive acts (cc. 29–34). A general decree is a law (c. 29), void without legislative power or an express grant (c. 30). A general executory decree or an instruction derogates from no law; a provision contrary to one lacks all force; it ceases with the law it executes (cc. 33–34). `doc_at_issue` asks for a body's or an act's force at the evaluation date. |
| `collection(B,private)`, `collection(B,authentic)` | An authentic collection's texts have force from its promulgation, whatever their origin; a private collection's rest on their attribution (`attribution/3`, below). |
| `celebration_on(D,C,Rank)`, `solemnity(C)` | GNLY 59–60: a celebration inscribed on a date by the calendar in use (the General or a proper one), at its number in the Table of Liturgical Days. Enter the calendar, never the weekday: the weekday and the days either side are computed. The highest in the Table is the day's (`day_celebration/2`), the others omitted; an Optional Memorial (12) may be kept on a day of no. 9 or 13; an impeded Solemnity is a frontier (its transfer is not encoded). A Sunday or a Solemnity begins the evening before (GNLY 3); the evening goes to the higher rank, at equal rank to the current day (`vespers_of/2`, GNLY 61). |
| `vigil_mass(C,F)`, `mass_formulary(M,F)` | GNLY 11: a Solemnity's own Vigil Mass, owed at an evening Mass on the eve when the evening is the Solemnity's; held only at an hour that is evening on every reading (c. 14). No such rule binds a Sunday's eve. |
| `mass_at(M,D,HHMM)`, `holy_day_of_obligation(D)`, `assists_at(P,M)` | cc. 1246–1248: a Mass in a Catholic rite on a Sunday or holy day, or in the evening of the day before, meets its obligation, whatever its formulary (`meets_obligation/2`). "Evening" is read from noon or from 2 p.m.; between them c. 14 reads the obligation narrowly (`declined_in_doubt_of_law/3`), unless an authentic interpretation settles it. Enter the holy days as the conference has them (c. 1246 §2); Sundays are computed. Of a person who assists, the checker says only that the obligation is met, never that anyone failed it. |
| `juridic_person(J)`, `group(J)`, `moral_person(J)`, `represents(P,J)` | cc. 113-118: only a physical person acts; a fiction acts through those who represent it and bears no interior, sin or delict. The Church and the Apostolic See are moral persons by divine ordinance. |
| `version_approval(A,T)`, `act_date(A,D)` | c. 838 at the approval's date: as it read before 1 October 2017, or as *Magnum principium* amended it (`approved_under/2`). |
| `can_speak(P)` | c. 1104 §2, for liceity only (c. 10): consent by signs that are not verba is illicit for a party who can speak (`consent_illicit/3`); disputed, both ways. |
| `assistant_perceived(M,What,V)` | c. 1108 §2: what the assistant perceived (`celebration`, `consent`; `yes`, `no`, `disputed`), entered, never derived. The celebration perceived and not the consent: "recipit" read both ways (`recipit_read/2`). Not received, the form fails. No route enters. |
| `interpreter(E,I)`, `interpreter_fidelity(M,established)`, `knows_encoding(P,E)` | c. 1106: the pastor assists only when sure of the interpreter (`assistance_illicit/2`). cc. 990, 983 §2, 1386 §2: a confession through an interpreter binds him to secrecy, under penalty (`bound_to_secrecy/2`); permitted, never required (`obliged_through_interpreter/2`, refused). Beside the canon: `assistant_outside_encoding/1`. |
| `rite_by(M,S)`, `recognitio(S)` | c. 1120: a conference's norm taken as the rite needs the recognitio (`rite_without_recognitio`). cc. 846 §1, 1119: a rite or consent given in a signed language, read as the rite kept or changed (`rite_read/2`); c. 850: not in urgent necessity (`only_validity_required/1`). c. 869 §1: a form in doubt, its signs not *verba* or a feature of the substance given two ways (`form_in_doubt/1`), baptism conditionally (`to_be_baptized/2`). |

A new canon goes under `% @norm id | citation | source`. New slots go under
`% @input name/arity | meaning`. A norm that defines one person's delict by
another's (c. 1329) is tagged `% @recursive id`; one that states divine law
or the supreme authority's, `% @stratum id divine|supreme` (it binds both
codes; untagged, a norm is its own code's). See [ttc-canon(5)](canon-law-layer.md).

## THE PAIR

| Fact | Meaning |
| --- | --- |
| `classification(Q,E,Kind)` | Theological question Q classifies event E. Where Q holds `no`, the law treats E as not of that kind. |
| `premise(N,Q,V)` | Norm N presupposes V on Q. Applied where Q holds otherwise: violation. |
| `law_answers(Q)` | A claim that a canon-law result fixes Q: refused where Q is doctrinal, or asks whether a version carries its source (`q(carries(F2,F1))`, `q(carries(T2,T1))`): an approval is governance (c. 838). |

Law never answers a doctrinal question (`teaching_from_law`).

## TIME

| Fact | Meaning |
| --- | --- |
| `today(Date)`, `asof(Year)` with `custom_asof`, the `asof_Y` parts | The one clock (`now/1`): a day given, or the last day of an asof year. With a day, the authority graph is read as of its year; with neither, every source entered. |
| `next(E1,E2)`, `happens_at(E,Point)` | The order of events, partial; dates are measures laid on it. |
| `date_claim(E,Year)` | A year laid on an event of the order. The return and the judgment take none (`end_dated`), and nothing measured follows the return (`end_past`); nothing precedes creation (`before_the_beginning`). |
| `measured_by(X,M)`, `without_beginning(X)` | Claims about duration. Eternity is God's alone (`eternal_with_beginning`); every creature began (`creature_without_beginning`). A procession in God, or God's act, placed in the order is refused (`procession_in_time`, `divine_act_in_time`). |

What interprets, cites or claims about an act comes after it
(`measure_against_order`); an act dated in both layers carries one year
(`dates_disagree`). See [ttc-saeculum(7)](research/saeculum-preregistration.md).

## AUTHORSHIP

| Fact | Meaning |
| --- | --- |
| `signed(S,A)`, `anonymous(S)` | The text bears its author's name, or none. Both at once is refused (`signed_and_anonymous`). A source with neither is not at issue. |
| `attribution(S,A,Claimant)` | A claim that A wrote S, with its claimant (the text itself may be one). Computed both ways (`attributed/2`), never preferred, unless `shown_by(S,A,E)` gives evidence apart from every claimant. Competing claims: one author at most. |
| `died(A,Y)`, `self_dated(S,Y)`, `draws_on(S,S1,Witness)`, `text_year(X,Y)` | The order refuses an attribution where the text dates itself, or draws on a text, after the claimed author's death. A dependence counts from its witness's year. |
| `author(S,A)` | An author entered for an anonymous text without a claim: refused (`author_without_claim`). |
| `particular_council(S)` | A particular council's teaching (c. 753) weighs at its tier and cleaves nothing; it is owed by its own faithful, not computed. |

A name never raises a tier: a text's tier is its form's. Where a claimed
author's office gives the text a form (a pope's letter), enter that source
on the branch of the claim (`... :- attributed(S,A).`). No motive is read: a
refused attribution is a fact about dates. Shown: `without_a_name/1`,
`attribution_refused/3`, `attribution_by_act/3` (a claim made by an act at
tier 3 or above: it fixes nothing). See [ttc-sources(7)](research/sources-preregistration.md).

## LITURGY

| Fact | Meaning |
| --- | --- |
| `liturgical_witness(W)` with `source(W,T,truth,Y)`, `character(W,liturgy)` | The prayer a liturgical book holds: a witness at the tier of the authority that approves it. It weighs and cleaves nothing; nothing is owed to it as a teaching act. The act that gives the book is a separate source, juridical, answering governance questions. |
| `fixes(W,Q)` | A liturgy treated as settling a doctrine: refused (`lex_orandi_as_fixing`; *Mediator Dei* 48). |
| `rests_on_liturgy(Claim,W)`, `universal_witness(W)` | A claim of the ordinary universal magisterium argued from a universal prayer: it shows three of LG 25's conditions (dispersed in communion, authentic teaching, faith or morals), never "one position held as definitive". |
| `prayed_in(W,Church)`, `in_use_from(W,Year)`, `prayed_by(W,bishops\|faithful)`, `changes(Act,W)` | Vincent's measure ("ubique, semper, ab omnibus"), reported (`measure/4`, `years_in_use/2`, `change_to_long_use/4`); it feeds no verdict. A change by competent authority stands. |
| `changes_condition(Act,K,C)` | A liturgical book changing a sacrament's condition: refused where the condition is of the substance (`change_to_substance`), standing where it is the Church's (`change_stands`). |
| `derives_from(Rite,Parent)` | Rites descend in an order, not a line: refused from a later rite (`rite_from_later`) or from itself (`rite_descends_from_itself`); `rite_of_many_parents` shown. |
| `porrection(E)`, `celebration_date(E,Date)` | The porrection of the instruments at an ordination to the priesthood: not required from *Sacramentum ordinis* (28 April 1948); before it, required or not, computed both ways, the doubt referred to the Apostolic See and the order to be conferred conditionally (c. 845 §2). |
| `alters(E,Part)` | c. 846 §1: a part of the rite added, omitted or altered on one's own authority, or a form not the book's: illicit (`illicit_change`); a changed form also fails the sacrament. |
| `binds_because(E,loved)` | An element made binding because it is loved: refused (`binding_by_love`). Love is never read. |

See [ttc-liturgy(7)](research/liturgy-preregistration.md).

## THE LAST THINGS

| Fact | Meaning |
| --- | --- |
| `gives_order(S,A,B)`, `without_end(X,S)` | The stages after death (`dying`, `purification`, `vision`, `hell`, `rising`, with the kernel's `return` and `judgment`) are kinds, not persons. An order between two stages holds while its source is in force at tier 1 (`order_given/3`), so the order is dated. |
| `places(T,A,B)`, `ends_in(T,A,B)`, `denies_subsistence(T)` | A theory of what follows death, entered as the order it claims: refused against the order in force (`order_against_definition`), for ending a stage given without end (`end_of_the_endless`), or for denying the soul subsists once Lateran V is in force (`soul_not_subsisting`). |
| `body_of(P,B)`, `raised(P)` | One soul, one body (DH 801, 1440): a soul given two bodies is refused (`soul_in_two_bodies`). A raising to the same body is reported, and no rule counts deaths. |
| `rises_early(P)` | A bodily rising before the return, claimed of a person: refused (`rising_before_the_return`), save Christ, the firstfruits, and Mary on the branch of the Assumption (`end_early/1`). |
| `duration_claim(X,N,Unit)`, `days_read_as(G,time_after_death)` | A duration in days or years laid on purification, the vision or hell: refused (`after_death_measured`). An indulgence's days (`in_days/2`) are reported as a measure of canonical penance. |
| `separated_soul(X)` | A soul after death: measured by the aevum in its being (Thomas's); `measured_by(X,share_of_eternity)` for the vision, never eternity itself. |
| `placed_in(P,State)` | A case placing a named person in hell, purification or glory: refused (`state_after_death_placed`; rule 3), save glory where a canonization in force says so (`in_glory_by_the_act`). A canonization is a source on `q(in_glory(P))`, its tier from its form. |
| `nothing_carried_over` | Candidate only: refused for every glorified body of this world (`glorified_annihilated`). |
| `lasts_claim(E,charity)` | That charity carries an element to the end: a claim, computed both ways, never derived. It binds nothing. |
| `same_sacrifice(M,passion)`, `repeats(M,passion)`, `commemoration_only(M)` | A Mass joined to the one passion (`one_sacrifice/1`); a second immolation or a bare commemoration refused once Trent's canons are in force. |

See [ttc-novissima(7)](research/novissima-preregistration.md).

## THE EMPIRICAL

| Fact | Meaning |
| --- | --- |
| `question_kind(Q,empirical)` | A question the sciences answer. No source deletes, cleaves or weighs on it. An act at tiers 1 to 3 supporting a value on it is refused (`act_answers_a_fact`); a censure of heresy or of error in faith laid on it is refused (`fact_censured_as_heresy`, `fact_censured_in_faith`). |
| `finding(F,Q,V,Year)` | A finding: from its year it fixes an empirical question (`fixed_by_finding/3`), a later finding superseding an earlier; a reading of Scripture reading the contrary is then on no branch. Laid on a doctrinal question it is refused (`finding_on_a_doctrine`). |
| `rests_on_finding(S,Q,F)` | A teaching act resting a doctrinal value on a finding: refused (`doctrine_rests_on_finding`), the doctrine's value unchanged. |
| `consent_claimant(Text,C)` | Who claims the Fathers' consent. A consent claimed on a text not of faith or morals fixes nothing and is reported (`consent_outside_faith_and_morals/2`). |
| `method(F,division)`, `nothing_but(C,W,F)`, `about_the_parts(C,W,F)` | Method never answers being: "nothing but" from a finding by division refused (`nothing_but_from_division`), for a human being also by the soul as form (`against_the_soul_as_form`, Vienne); a claim about the parts reported. |
| `twinning(E,A,B)` | A twinning read four ways (budding, fission, delayed, one soul), a disputed fact: `human_beings_after/2` on each branch, never derived; `treated_as_a_person/1` on all. |
| `contrary_acts_at_once/2`, `died_while_other_lived/2`, `baptized_each/2`, `married_each/2` | Outward tests and the Church's practice: each refuses the one-soul reading. `divides_the_soul(E)` is refused on every reading. |
| `doubt_one_or_more(E,Date)`, `born_together(E,C)` | Conjoined twins: under CIC 1917 c. 748 one baptized absolutely, the rest conditionally (`to_be_baptized/2`); after 1983 no canon answers. Whether one human being or several is computed both ways. |

See [ttc-empirica(7)](research/empirica-preregistration.md).

## THE TONGUES

| Fact | Meaning |
| --- | --- |
| `encoding(E,T,From,To)`, `encoding_route(E,written\|manual)`, `encoding_from(E2,E1,C)`, `variety_of(E2,E1,C)`, `code_of(E2,E1)` | A tongue in a script, or a signed language, by its ISO 639-3 code, over a span of years; its descent, a claim; a variety; a manual code of a tongue. A word as an encoding's parent is refused on every runtime (`word_as_root`); a variety entered as descended, `variety_entered_as_descent`. |
| `text_of(T,S,E,Y)`, `made_from(T2,T1)`, `revises(T2,T1)` | One encoding of one edition of a source, dated; a translation's parent; a new edition, which changes the word and is no rendering. Refused: a text made before its parent (`made_before_parent`), a cycle (`translation_cycle`). Shown: `superseded_encoding(T,T2)`, T encoding an edition T2 revises. |
| `form_in(F,T,Locus)`, `renders(F2,F1)`, `host_declared(F2,F1,C)` | A form, a span of a text, as given; F2 given for F1, both ways under `disputed(renders(F2,F1))`; a rendering of a rendering, against its declared host and that host's host. No mode between editions, or between a code and its tongue (`no_mode/3`). |
| `lexicon(C,E,Y,K)`, `signifies(F,W,C)` | A lexicon of E at its year, of a kind (a `database` gives no meanings); what a form means by it. Rival lexicons both ways (`read_by/2`). Refused: a meaning by no lexicon (`meaning_without_lexicon`), a lexicon outside its encoding's span (`lexicon_out_of_span`). |
| `analogous(W2,W1,K,C)`, `broader(W2,W1,C)`, `carries(W2,W1,P)` | In the order of reason, W2 said of W1 by `attribution`, `proportionality` or `metaphor`; W2 covering W1 and more; what an analogical rendering whose words are W2 for W1 carries. Refused: `analogy_without_kind`, `equivocation_carried`. |
| `form_reading(F,R,C)`, `admits(F,R,C)`, `reading_holds(R,Q,V)` | A host form's reading, by its exegete; a reading a lexicon admits; what a reading holds on a question. Shown: `closes/3`, `opens/3`, `interpretation/3` (a reading kept, another closed). |
| `rests_on_form(A,P,F)` | The argument A's premise P rests on the host form F. Shown: `carried/3`, `carried_in(A,E,P)`, `lost_in(A,E,P,Why)` (`gap`, `equivocal`, `no_carry`), `gap/2`, `premise_by_analogy/3`. |
| `hears_in(G,E,C)`, `hears_under(G,C)`, `hearing_rule(C,F2,F1)`, `horizon_lacks(G,P,C)` | A horizon, a runtime or a guest, hearing in E by a lexicon; rival lexicons both ways. Never a person (`hearing_of_a_person`), never by no lexicon (`hearing_without_lexicon`). Under a rule of hearing a version admits exactly its host's readings (`heard_by_rule/3`). Each relation has its twin by hearing (`mode_for/4`, `closes_for/4`, `interpretation_for/4`, `carried_for/3`, `lost_for/4`); what a horizon cannot hold, apart (`lost_by_horizon/3`). |
| *output* `info(mode(F2,F1,M))`, `info(extent(F2,F1,X))` | Computed, never entered: `univocal` where both forms mean one word (the default's part `word_of_no_tongue`; on `rt_saussure`, only within one encoding); `analogical` where an analogy is declared; `equivocal` otherwise; `wider` or `narrower` by `broader/3`. On the default runtime a word given a date or a place in time is refused (`word_dated`). |
| `mode_claim(C,F2,F1,M,U)`, `fixes_mode(C,F2,F1)` | C states a mode, or `interpretation`, in the unit U (`word`, `passage`, `act`, `sense`, `recipients`): it weighs at C's tier (`mode_claim_weighs/4`) and never fixes (`mode_fixed_by_claim`). In the unit of the word, `mode_claim_agrees/3` or `mode_claim_differs/3`; two claims on one pair, `units_differ/4`. |
| `catechesis_rule(C,F2,R)`, `message(F1,R,C)`, `span_kind(F,K)`, `idiomatic(F2,E,C)`, `unrendered(F2,F1,W)`, `order_changed(F2,F1,C)` | What the regimes read: a reading sent to catechesis; the message named (CLP 6); a host in an `anaphoral` or `biblical` text; a rendering keeping its tongue's character; a host word left without counterpart; an order changed where the tongue allows it kept. |
| parts `regime_la`, `regime_clp`, `regime_mp` | Three regimes of the faithful, none preferred. LA: nothing closed, no word unrendered, the order kept (`faithful/2`); what a rendering opens, `for_catechesis/2`. CLP: the hearing admits the message, no reading it admits answers a doctrinal question against its sources (`contrary_for/4`), and no insertion in an anaphoral or biblical text, itself disputed (`faithful_for/3`). MP: nothing closed, the Latin deciding (`latin_decides/2`); the tongue; the addressees as CLP; a sacramental form also word for word (`word_for_word_required/2`). |
| `rests_on_rendering(S,Q,F2)` | A doctrinal value rested on what a rendering closes: refused (`rendering_answers`); Q keeps its own sources. |
| `formula_of(F,K)`, `form_for(F,K)`, `form_feature(F,Ft,V,C)`, `corruption_at(F,Where)`, `form_agent(F,X,C)` | The Church's form of K; a form used for K; what a form expresses (`minister_act`: `expressed`, `unexpressed`, `other_agent`; `trinity_invoked`; `addressee`), rival claims both ways, compared by feature with the Church's form (`feature_mode/4`; an unexpressed act a gap, no defect). Corrupt at the end, `read_by_accommodation`; at the start, `sense_lost`. With the Grammar of the Icon an assembly named as the one who acts is refused (`cophase_as_agent`). Which features are of the substance is teaching (`classification(Q,feature(K,Ft),of_substance)`). |
| `rite_given(E,K,M,R,F)`, `consent_given(M,P,F)`, `confession_given(A,P,F)` | A rite, a consent, a confession given by a form. A manual form is a verbum on `rt_lingual` from the year findings fix `q(human_language(T))` and `q(signifies_by_convention(T))`, never on `rt_vocal`; the default runs both (`read_as(verbum,verbum_vocal)`, `read_as(verbum,verbum_lingual)`). A confession raises no such question. Shown: `read_as_verba/1`, `read_as_signa/1`; a manual code with no finding of its own, `no_claimant/2`. |
| `canon_verbum(L,R)` | Candidate only: a canon's reading of *verba* entered beside the runtime's. Read one way in c. 849 and another in c. 1104 §2, refused (`verba_read_two_ways`). |
| `notated(F,N,C)`, `notation_kind(N,K)`, `notation_tier(N,Tier,Extent)`, `token(F,N,I,T)`, `presumes(T,Cat,C)`, `nonmanual_mark(F,N,M)` | A performance given in a notation by its transcriber, a claim. Shown: `notation_gap/3`, `notation_partial/3`, `transcriptions_differ/3`, `gloss_presumes_category/2`, `clause_read/3`. A gloss token entered as a word is refused (`gloss_as_word`). |
| `depicts(F,M,C)`, `manner_used(E,M)` | A sign depicting a manner beside the matter used: `iconic_manner_differs/2`, never a refusal. |
| `practice_teaches(C,S,Q)`, `rests_on_practice(S2,Q,S)`, `date_claimed(S,D,C)` | That a practice teaches: a claim with its claimant and no tier (`practice_claim/3`). A doctrinal value resting on practice alone is refused (`validity_from_practice`). Two days claimed for one act: `dated_two_ways/3`. |

A finding laid on a juridical question, how a canon reads, is refused as on a
doctrinal one (`finding_on_a_doctrine`). See
[ttc-linguae(7)](research/linguae-preregistration.md).

## THE CAUSES

| Fact | Meaning |
| --- | --- |
| `argument(A,S,Q,V)`, `argues_from(R,C,D)`, `reading_of(R,A)` | An argument of the source S for V on Q; the cause a reading rests on, C one of `material`, `formal`, `efficient`, `final`, in the domain D: `nature`, `god_physics`, `god_ethics`, `human`, `will`, `self`, `reason`; a further reading. An argument is its own first reading. A typing is an interpretation, entered; authority reads none of it (rule 14). |
| parts `ends_in_nature`, `forms_in_nature`, `ends_by_god_physics`, `ends_by_god_ethics`, `ends_of_human_nature`, `soul_as_form`, `ends_desired`, `self_preservation`, `object_as_form`, `form_of_law` | A horizon: each part holds one cause in one domain (`holds_cause/2`), set by a runtime, never by a case. The efficient and material causes are held in every domain. `default` holds the first nine; `form_of_law` only `kant` and its readings. |
| parts `rt_scotus_dpp` … `rt_kant`, the readings (`rt_scotus_will`, `rt_ockham_will`, `rt_ockham_nominal`, `rt_descartes_will`, `rt_grotius_etiamsi`, `rt_kant_humanity`, `rt_kant_mm`), the will line (`rt_suarez_wl` … `rt_leibniz_wl`), Leo's hearers (`rt_episcopate_1891` … `rt_lassalle`) | Modernities, a DAG by inheritance from the schools: each node a figure's horizon with the parents the record documents. A contested edge is marked in `schools.l` (`-- contested edge:`), and so is one with no documented reading. |
| *output* `available_as(A,R)`, `info(without_reason(Q,V))`, `info(sole_reason(S,A,Q,V))`, `info(contrary_reasoned(Q,V,V2))` | A reading is available where every cause it argues from is held; one typed by nothing everywhere. Reported: a value supported in force, its arguments entered and none available; of a source's two or more arguments for a value, one alone available; a value without reason against an available argument for another. |
| parts `vm_R` | The VM: R's horizon as the guest's (`guest_holds/2`), beside the host's, in one solve. `guest_without_reason/2`; `guest_sole_reason/4`, an argument idle in the host and sole in the guest. That it is an accommodation is never computed. |
| parts `hear_la_1891`, `hear_en_1891_locke`, `hear_en_1891_schol`, `hear_en_2026`; `concludes_heard(A,L,C)` | With `linguae_rn9`: the run's own horizon (`here`), or the guest where a `vm_R` is loaded (`guest`), hears in a tongue by a lexicon. An argument on forms is heard as its hearing carries the premises, the premises on no form as typed; the heard typing replaces its own. One that loses a premise is short (`heard_short/2`) and reaches the hearer only where C claims that, heard under L, it still concludes; one with no text in his tongue, never. `heard_by_analogy/4`, the premise and the kind; `lost_by_horizon/3`, from the hearer's horizon. A premise on a form its argument does not argue from is refused (`premise_not_argued`). |
| part `hearers_tongues`; `figure(F)` | Leo's hearers in their tongues: the node `george` (and `george_hn`) hears the English of 1891 under the Lockean lexicon, `episcopate_1891` the Latin; the rest as typed. |
| `measures_as(M,C1,C2)` | A measure taking one cause as another. A final cause taken as an efficient one is refused (`cause_converted`), save where ends survive only as desire: `ends_desired`, no end in nature, in God's intention or in human nature, and neither form of the will's act (`conversion_native/1`). |
| part `horizons_all` | Search: every horizon of the ten parts in one solve, beside `rt_bare` and default's other parts, never in a runtime. A case's order parameters are the parts its reports depend on; its phases, the classes of horizons with one report. |

See [ttc-modernity(7)](research/modernity-preregistration.md).

## SUBSTITUTION

| Fact | Meaning |
| --- | --- |
| loci `simplicity`, `esse` | A school's reading of one question is an allele, its parts travelling together (`schools.l`; ttc-l(1)). At simplicity: `by_reason` (`simplicity_thomist`, `attributes_by_reason`), `formal` (`simplicity_scotist`, `attributes_formal`), `energetic`, `synonymous`. At esse: `real` (`th03`, `th05`), `by_reason` (`suarez_esse`), `scotus` (`scotus_esse`). A runtime whose parents express two alleles carries both and expresses neither, running on the deposit's simplicity and its silence on esse, unless it says `express`; `carry` silences one. `runtimes.json` records, per runtime and locus, the allele expressed and those carried. Two runtimes named in one run are no child: both load whole. |
| `substitutes(C,T,X,Y,R)`, `disputed(substitutes(C,T,X,Y,R))` | The claimant C reads the text or order T as putting X in the place of Y, in the role R: `giver_of_being` or `last_end`. Disputed, both ways. Lowered onto the deposit's relations: X gives being to every other creature (`being_from_non_god`, DH 800), or is taken as the last end (`last_end_not_god`, DH 1000-1001). Shown: `substitution_faults(C,T,X,V,L)`, the rule V and its layer L. A pure trace faults nowhere. |
| `necessitates(C,T,X)` | C reads T as holding the creature X necessary: a denial of free creation, no substitution. Lowered onto `necessary/1`; the kernel's `modal_collapse` decides, on the deposit's contingency (DH 3002, 3025). Shown: `necessity_faults(C,T,X,V,L)`. |
| `honour(S,P,K,C)` | By C's reading, honour of the kind K (`latria`, `veneration`, `hyperdulia`, `dulia`) given to the sign S terminates in P: an icon's prototype, an idol's own sign. Latria that terminates in what is not God is refused (`latria_to_creature`, Nicaea II, DH 601); honour that terminates in God, through an image or not, faults nothing. The terminus decides, not the sign. |
| `created_person(T)` with any of the three | A substitution or a necessity read of a person, or an honour given to a person as its sign, is refused (`substitution_of_a_person`) and lowered nowhere (rule 3): the checker types a text, an order or a sign, never a soul. |
| parts `loci_spinoza`, `loci_mammon`, `loci_icon`, `loci_adams` | The *Ethics*, a disputed reading: A (Jacobi, Borge), Nature in God's place as the giver of being and held necessary; B (Nadler), *natura naturata* held necessary. McCarraher's money as the last end. The image of Christ under Nicaea II's reading and the Thomists', a saint's image, an idol. McCarraher's dynamo, beside Adams's measure (`modernity_measure`). |

See [ttc-loci(7)](research/loci-preregistration.md).

## THE LAYER'S RUNTIMES

A personal layer may declare runtimes, in L, in `$TTC_HOME/runtimes/*.l`:
runtimes only. `save_runtime` compiles one with the base and the layer and
writes it only if it compiles: the base's refusals apply (an unknown part,
an unresolved clash, part of an allele, a cycle), and a name the base has
is refused. The table, `$TTC_HOME/runtimes.json`, is refused at load
when it is not as its sources compile (the gate `runtimes`). A runtime of
the layer may extend the base's and name the parts of the layer's rule
files. It is a profession: the parts a person says he holds, on his own
word, never a model of a mind (rule 3).

| Fact | Meaning |
| --- | --- |
| `profession(R)`, `personal_runtime(R)` | The engine's, never a case's: the run expands R, a runtime of the layer; R is one. A profession runs, boots and compares as any runtime does. |
| *output* `violation(profession_heard(R))` | A hearing declared for the run's own horizon (`hears_in(here,…)`) on a run of a profession: refused. A base runtime's guest of the VM, hosted by it, hears; that is no hearing of it. |
| *output* `violation(profession_as_guest(R))` | `vm_guest(R)` for a runtime of the layer, on any run: refused. No part `vm_R` is made for one. |

See [ttc-professio(7)](research/professio-preregistration.md).

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
| `violation(outside_domain(Slot,N,V))` | Argument N of a slot holds V, outside its sort: a tier, a force, a character, a nature, a mode of presence, … (ttc-l(1)). |
| `info(X)` | Noted. |
| `info(interior_supplied(P,A,X))` | An interior a case supplied or disputed, named in every branch: a claim, never a finding (rule 3). |
| `frontier(Layer,X)` | Still to encode or read. |
| `frontier(unanswered,by_practice_only(Q))` | A question no source answers, which a claim of practice speaks to: no lack of the encoding, shown apart. |

A value is *settled* if every main branch has it, *open* if some do, a
*shadow* if only shadows do, *excluded* if none do.

## WARNINGS AND REFUSALS

`check` returns `schema`, the summary's shape (raised when the shape
changes; 2 from `premises`), `premises` (which of your predicates the base
reads, `read`, and which neither it nor your facts read, `unread`: a fact
under an unread predicate computes nothing), and `warnings`:

| Warning | Meaning |
| --- | --- |
| `unknown_slot(Name/Arity)` | The base neither writes, reads, shows nor declares the predicate, and your facts do not both write and read it. A misspelling or a wrong arity, usually. The fact does nothing. |

A refused run returns one JSON object: `refused`, `gate`, `where` (`facts`,
`add_rules`, `remove_lines`, `parts`, or a side of a case), `line`,
`column`, `predicate`, `text` (the line), `message`.

| Gate | Refuses |
| --- | --- |
| `parts` | A part or runtime the base does not have. |
| `snippet` | A directive (RESTRICTIONS), or a snippet too long. |
| `parse` | Text clingo cannot parse. |
| `ground` | Text clingo cannot ground; an unsafe variable, usually. |
| `removal` | A line to remove that matches none, or several. |
| `layer` | A slot of the other side of a case (THE PAIR): each slot's side is its layer's, and a library's slots (`interior/3`, `act_of/2`) go on either (ttc-l(1)). |
| `conclusion` | A head on what the base concludes (a predicate it derives or shows that no slot declares: `eff_tier/2`, `holds/2`, `theorem/1`), a slot declared hypothetical, or a constraint that reads a conclusion, directly or through a helper of the snippet's. `read_as/2` may be read. The refusal names the slots the conclusion is drawn from. A switch's flag (`monopatrism`, `gen_policy/1`, `closure_mode/1`) is chosen by loading its part; a theory's own vocabulary (`bridge/3`, `mode/3`, `rel/3`) changes through `fix_method`. |
| `input` | An argument the tool cannot take. |
| `runtimes` | The personal layer's `runtimes.json` missing beside its sources, older than one of them, or not what they compile to (THE LAYER'S RUNTIMES); every run, until it is rebuilt. |

Results come with their keys sorted. `ttc://grammar`, read off L, holds
the slots with their sorts, sides, meanings and sentences; the sorts; the
vocabulary the warning reads; the parts with their kinds and cases; the
runtimes with their parents; the tools; `grammar_schema` (its own shape,
2) and `schema` (the summary's).

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
`@`-terms. They write premises: the slots, helpers of their own, and
constraints that read only those and `read_as/2`. A premise may be
conditioned on anything (`source(S,1,truth,Y) :- attributed(S,A).`). Each
open question doubles the branches, so fix readings you are not testing:
`:- not read_as(s,r).` Choose a branch of a claim with the base's switch
for it (`oum_dh795`), not a constraint.

## BUGS

The facts are only as honest as whoever wrote them. The gate `conclusion`
refuses a conclusion written as a fact, but a premise can still be false:
read a result with the facts that produced it. The gate is only as strong
as the slots L declares. `ttc://grammar` is the checker's
word about itself: a claim, never evidence that it is right.
