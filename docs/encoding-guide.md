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
| `oum_claim(S,K)`, `oum_claimant(S,C)` | A claim of the ordinary universal magisterium. The consensus is a source of its own, `oum(S)`, at grade K (both, where the claimant states none); S keeps its tier. Without LG 25's conditions shown (`condition_shown/2`), never preferred (c. 749 §3). |
| `claims_tier(C,S,K)`, `treated_as_fixing(C,S)` | A statement about a tier: flagged when a lower tier speaks of a higher; refused when treated as fixing. |
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
| `law_answers(Q)` | A claim that a canon-law result fixes Q: refused where Q is doctrinal. |

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
