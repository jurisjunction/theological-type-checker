# TTC-ROADMAP(7)

## NAME

**ttc-roadmap** — what is done, what comes next, and the ideas waiting
their turn

## DESCRIPTION

The foundation is built in the order of the *Summa* and of what each step
needs. Each step's predictions are committed and stamped before it is
encoded (rule 12), then scored. Ideas from conversation are kept here
until their step comes, and enter the kernel only if the deposit needs
them; otherwise they run on top, as the *Grammar of the Icon* did.

## STEPS

| Step | Contents | State |
| --- | --- | --- |
| schools | the runtimes | done ([ttc-schools(7)](research/schools-preregistration.md)) |
| act | the human act | done ([ttc-act(7)](research/act-preregistration.md)) |
| law | law | done ([ttc-law(7)](research/law-preregistration.md)) |
| creed | Scripture as tier 0; the creeds; the Incarnation; Mary; the economy | done ([ttc-creed(7)](research/creed-preregistration.md)) |
| moral | the morality of acts, sin, grace | done ([ttc-moral(7)](research/moral-preregistration.md)) |
| christ | Christ's acts; the sacraments; the seal; presence by mode | done ([ttc-christ(7)](research/christ-preregistration.md)) |
| moral amendment | verdicts and obligation: may, must, must not; social doctrine as tests | done ([ttc-precept(7)](research/precept-preregistration.md)) |
| communion | rule 14; faith and communion: notes, denials, bonds | done ([ttc-communion(7)](research/communion-preregistration.md)) |
| canon | abortion, c. 1399, c. 1752, the Dicastery's clause; form and object; fictions of law | done ([ttc-penal(7)](research/penal-preregistration.md)) |
| saeculum | one library for time: the Church's computation (cc. 8 §1, 97, 200–203), one calendar, reception dated, the order and the measures | done ([ttc-saeculum(7)](research/saeculum-preregistration.md)) |
| cceo | the Eastern Code: a second canon layer, chosen by ascription; who is bound; the minister of confirmation | done ([ttc-cceo(7)](research/cceo-preregistration.md)) |
| sources | documents as layers in time: the codes (1917, 1983, 1990) and every act that changed them; law outside the codes; acts of executive power; the general norms as the edges; authorship, an attribution a claim; the Filioque's Latin witnesses | done ([ttc-sources(7)](research/sources-preregistration.md)) |
| liturgy | the liturgy as witness, rite and development; one book, two sources; the substance kept, the rest law; rites in time | done ([ttc-liturgy(7)](research/liturgy-preregistration.md)) |
| last things | the order after death given by definitions, never measured by the calendar; the vision deferred and defined; the end early; no one's state computed; what lasts; one sacrifice in many times | done ([ttc-novissima(7)](research/novissima-preregistration.md)) |
| empirical | the empirical kind: no tier settles it, a finding does, and a finding settles no doctrine; Galileo and the Big Bang; method and being; how many human beings | done ([ttc-empirica(7)](research/empirica-preregistration.md)) |
| L | a language for libraries, compiled to clingo: declarations as metaclasses; runtimes by inheritance, three combinators, clashes refused; slots declared once, with sorts, domains, layers and sentences; parts naming their case; premises kept apart from conclusions | done ([ttc-l(7)](research/l-preregistration.md)) |
| churches | other Churches and ecclesial communities: succession, sacraments, *subsistit in* | to predict, after L |
| senses | the senses and the routes to words: sensibles typed, schemes by culture, the interior senses; words by hearing, sight, hand and touch; perception's claims as premises | to predict, after L |
| language | one word, many encodings: a form type-checked under its encoding at its date, by any route (heard, signed, written, touched), as a sign of the word; the encodings in time as a DAG, etymology a partial trace of forms through it; the word itself outside time; each encoding encodable, none required | to predict, after the senses |
| integration | the checker as a verification step for agent frameworks | a doc page, later |

## NEXT STEPS IN DETAIL

### saeculum

One library for time: Augustine's *saeculum*, the time of the two cities
before the end. It comes before the cceo step, whose dates need c. 8
§1's months (*De concordia inter Codices*), and before the last things,
which type duration by measure. Done
([ttc-saeculum(7)](research/saeculum-preregistration.md)): `saeculum.lp`
holds the calendar, one clock, the measures and the bounds; c. 8 §1,
c. 97 §1 and c. 203 are computed in the canon layer; reception is a dated
claim. Left:

- The issues of AAS 80 (1988) and 90 (1998), to replace three spans with
  dates.
- Useful time (c. 201 §2) and the month of thirty days (c. 202 §1), when a
  canon needs them; Julian dates before 1582.
- The "now" as an antichain, causal sets (CANDIDATE THEORIES).

### cceo

Done ([ttc-cceo(7)](research/cceo-preregistration.md)), with two repairs:
`binds_on/2` consults c. 11 as `binds_for/3` does (a run's finding), and a
presbyter confirms validly by law or faculty. Left: the Eastern canons on
jurisdiction for marriage (cc. 829–830), faculties (c. 722), the penal age
(c. 1413) and the Latin of cc. 1450 §2, 1459 §1 and 1490; until then the
Latin rules stand in for the Eastern faithful there. Change of ascription
and particular law. A disagreement in the literature before 2016 on
whether c. 828 invalidated an Eastern Catholic's marriage blessed by a
deacon (a doubt of law argued, and disputed), not encoded; as a disputed
reading it would branch (rule 2). The texts in their years from
iuscangreg's table of the Code's changes (`cceo_modifiche.php`), through
*Mutua concordia* (29 August 2026).

A second canon layer beside the Latin one, under the same discipline:
binary, dated, each rule under `@norm` (iuscangreg's `cceo.php`; the
official text, AAS 82 (1990) 1033–1364). The teaching above is shared;
only the law differs (rule 1).

- **Siblings, not a patch.** The Latin Church is one Church *sui iuris*
  among the Catholic Churches, not the church the others derive from; the
  Churches of East and West are "of equal dignity" (OE 3). Its Code is
  its own common law, not the Catholic Church's, so the Eastern layer is
  not written as amendments to the Latin. Three strata: what binds every
  Catholic by the nature of the matter (divine law; the supreme authority
  as such, CIC cc. 330–341, CCEO cc. 42–54); the common law of each code;
  the particular law of each Church. Today every norm in `canon_law.lp`
  binds every Catholic; this step sorts them.
- **Links stated and links *ex natura rei*.** The Eastern Code links into
  the Latin at many points by name: ascription and its change (CCEO
  cc. 29–38); chrismation by any Eastern presbyter, valid for the faithful
  of any Church *sui iuris*, the Latin included (c. 696 §1); the canons
  the Latin Code answers since 2016 (below). Other links are stated
  nowhere and hold from the nature of the matter: a canon that states
  divine law, or a relation between Churches neither code settles alone.
  These are computed, not listed. `law.lp` already types a law as divine
  or ecclesiastical, and c. 11 already confines merely ecclesiastical
  laws; each code's c. 1 limits only its merely ecclesiastical canons. A
  layer test: no merely ecclesiastical rule of one code fires for a
  person of the other, except by a stated link or by the nature of the
  matter. Which links hold *ex natura rei* is itself a reading where no
  authentic interpretation settles it (rule 2).
- **Which code binds is a fact.** The Latin Code concerns only the Latin
  Church (CIC c. 1), the Eastern Code only the Eastern Catholic Churches
  unless a canon says otherwise (CCEO c. 1). Ascription to a Church *sui
  iuris* (CIC cc. 111–112; CCEO cc. 29–38) selects the layer for each
  person; the interritual canons of each code reach the other.
- ***De concordia inter Codices*** (31 May 2016, published 15 September
  2016) brought the Latin Code toward the Eastern: cc. 111, 112, 535 §2,
  868 §§1, 3, 1108 §3, 1109, 1111 §1, 1112 §1, 1116 §3, 1127 §1. The base
  encodes c. 1108 §1 and c. 1111 without it. From 2016 "only a priest
  validly assists" at a marriage with an Eastern party (c. 1108 §3), as
  the Eastern Code asks a priest's blessing (CCEO c. 828). Its date in
  force is to be fixed from its promulgation (c. 8 §1). A test of dates
  in the layer already built; c. 1127 §1 (AMENDMENTS AND REPAIRS) comes
  with it.
- **Penalties imposed, never incurred.** The Eastern Code has no latae
  sententiae penalties, so one act runs two ways by ascription. A
  consecration without mandate is c. 1387's excommunication incurred in
  the Latin layer, deposition to be imposed in the Eastern (CCEO c. 1459
  §1). Heresy and apostasy are c. 1364 in the one, a major
  excommunication to be imposed in the other (CCEO c. 1436 §1).
  `to_be_imposed/3`, from the communion step, carries it. The penal title
  as later revised, each text in its own years.
- ***Ad tuendam fidem*** amended both codes (CCEO c. 598 §2, c. 1436 §2):
  TTC-COMMUNION's CN4 runs again on the Eastern side.
- **Particular law** of each Church *sui iuris* sits below the common
  code and stays on the frontier until a case needs it.

### sources

Done ([ttc-sources(7)](research/sources-preregistration.md)): the Code of
1917's form of marriage beside 1983's, read off at a date; c. 6 §1 n. 1,
c. 20 typed, c. 21 computed, cc. 29–30 and 33–34; collections private and
authentic; authorship in a new library, `sources.lp`; the Filioque's Latin
witnesses before 1100. Left: every other matter of the canon layer still
fires at any date (its events are 1983 or later); a particular council's
teaching owed by its own faithful (c. 753), not computed; the rest below.

Each document its own layer, as the two codes are, and the layers joined
by the general norms. Today the canon layer holds a few bodies and texts
(`enacted_by/2`, `part_of/2`, `reorders/2`: Book VI of 1983 and of 2021;
c. 1371 n. 1 in its three texts), c. 135 §2, and the rank of the
Dicastery's clause disputed (TTC-PENAL N5). This step generalizes it.

- **A code at a date is a view, not a copy.** Each canon is a sequence of
  texts, each entered by the act that gave it, with its force from the
  saeculum (c. 8 §1); the Code of 1917, of 1983, of 1990, as each became
  with every act, is read off at the date asked. As git: each act a
  commit, a code at a date a checkout, an abrogation a deletion, a
  harmonizing reading (c. 21) a merge without conflict, a contrary later
  law a conflict that c. 20 resolves. The texts come from iuscangreg's
  tables of changes, cited, as identifiers are resolved at fetch time
  (rule 8).
- ***Ius*, not only *lex*.** Every act typed by power (legislative,
  executive, judicial: c. 135 §1), author and authority, form (a
  dicastery's act approved *in forma specifica* or *communi*), and kind:
  laws (c. 7), customs (cc. 23–28), general decrees, which are laws
  (cc. 29–30), general executory decrees (cc. 31–33), instructions (c. 34),
  statutes and rules of order (cc. 94–95), privileges and dispensations.
- **The edges are the general norms.** The Code and other law (cc. 2–6;
  CCEO cc. 2–6): the liturgical books stand unless contrary to the Code
  (c. 2), concordats (c. 3), acquired rights (c. 4), customs (c. 5), the
  former law abrogated and its canons read in its tradition (c. 6).
  Later and earlier (cc. 20–21); executive acts never derogate laws and
  cease with them (c. 33, c. 34 §§2–3); lower against higher (c. 135 §2);
  the Eastern parallels (CCEO cc. 1488–1539). Each edge a rule, each
  conflict a violation or, where the reading is disputed, a branch.
- **Law outside the codes:** the norms on delicts reserved to the
  Dicastery (2001, 2010, 2021), the liturgical books' law (the bridge to
  the liturgy step), the Roman Curia's constitutions (*Pastor bonus*,
  *Praedicate evangelium*), particular law.
- **L** may compile a document as a module: its imports the acts it
  presupposes, its exports the texts it gives.
- **Collections, private and authentic.** An authentic collection's texts
  have force from its promulgation (*Rex pacificus*, 1234); a private
  collection's have their sources' authority (Gratian), unless custom
  gives them force (cc. 23–28). The Code itself is authentic: its canons
  have force from *Sacrae disciplinae leges*, not from their *fontes*,
  which read them (c. 6 §2).
- **Authorship.** Signed, anonymous, attributed. An attribution is a claim
  with its claimant, computed both ways, never preferred unless shown
  apart from the claimant, and refused by the order where a text draws on
  what came after its claimed author. A name never raises a tier; an
  anonymous text is never given a name. The pseudonymous left their mark
  on both layers: the *Corpus Dionysiacum* and the *Liber de causis* in
  theology, the Pseudo-Isidorian decretals and the Donation of
  Constantine in law. The anonymous are a type of their own, the checker's own
  (rule 13): *The Cloud of Unknowing*, the *Theologia Deutsch*, the
  *Imitation*'s "non quaeras quis hoc dixerit". Rule 3 holds: no motive is
  read, so no text is called forged.
- **Left for later.** The norms on reserved delicts in their three texts;
  *Ne temere* and the law before 1918; the Eastern general norms
  (CCEO cc. 1488–1539); concordats, acquired rights and customs as edges
  (cc. 3–5); Hebrews in Trent's list. Interpolations, injections into a
  text rather than onto a name: a variant is a reading of the text (the
  *Fides Damasi*'s "et Filio"; the Johannine Comma, with the Holy
  Office's responses).

### liturgy

Done ([ttc-liturgy(7)](research/liturgy-preregistration.md)). Left: the
Byzantine Dormition as a witness on Mary's death; the porrection for the
diaconate and the episcopate; liturgical laws and books as documents
beside the Code (c. 2); c. 838's competences beyond translations; the
Office of the Conception's later history (the Tridentine breviary before
1863); the reform's "irreversibility" and other claims of grade about
liturgical acts (rule 14). Predicted: the
prayer a witness that weighs and never fixes (*Mediator Dei* 48), the act
that gives the book governance; a change to the substance refused, the
porrection of the instruments dated (*Sacramentum ordinis*); c. 846 §1;
the Roman Missal's editions as documents descending in an order, not a
line; the Indiculus's two attributions. The liturgy as evidence for the
ordinary universal magisterium, showing three of LG 25's conditions and
never the fourth; Vincent's "ubique, semper, ab omnibus" as a measure,
never a verdict; what binds kept apart from what lasts.

The liturgy is "more than" a rite plus positive law, and the Church says
how: "made up of immutable elements divinely instituted, and of elements
subject to change" (SC 21); new forms "should in some way grow organically
from forms already existing" (SC 23). Three faces:

- **A witness** on the authority graph: Tradition is handed on "in her
  teaching, life and worship" (DV 8); *lex orandi, lex credendi* (the
  Indiculus, DH 246), with Pius XII's caution that belief also rules prayer
  (*Mediator Dei*). The Immaculate Conception and the Assumption were
  argued in part from the liturgies.
- **A rite**: its essential core is `sacrament.lp`'s substance (SC 21 is
  the sacraments' two laws again); the rest is law (cc. 834-846; c. 838 on
  the competent authorities).
- **A development**: rites descend from rites, an ordered history that need
  not be a line. SC 23's "organically" is a disputed reading with no
  authentic interpretation (rule 2). A theory of organic development runs
  on top, as the Grammar of the Icon does; the reform of 1970 as organic,
  as *ressourcement* or as rupture are its readings, and the checker
  settles none.
- Already in the base: the old Missal (LT1-LT8), lex orandi typed as
  teaching or governance (left open), translations (G1-G4).
- The bridge to the last things: in the earthly liturgy "we take part in a
  foretaste of that heavenly liturgy" (SC 8); the Mass is the one
  sacrifice offered in a different manner (DH 1743).

### last things

Done ([ttc-novissima(7)](research/novissima-preregistration.md)):
the stages after death an order of kinds, given by tier-1 sources in
force (Lateran IV, *Benedictus Deus*, Florence, Lateran V), theories
placed on it and refused by date; John XXII's deferral of the vision on
the authority graph, 1332 to 1336; one soul, one body; the Assumption as
the end arriving early; nothing after death measured by the calendar
(*Spe salvi* 47; *Indulgentiarum doctrina*); no one's state computed, a
canonization's tier from its formula; what lasts ("nothing of this world
carried over" refused for Christ's flesh and Mary's body; plants and
animals between Thomas and *Laudato si'*); the Mass joined to the one
passion. Left: Lyons II's profession (DH 856–859); the fifteen anathemas
of 553 and their ascription; the particular judgment as a stage; the
glorified body's mode (CCC 645, or Thomas's place); Mt 27:52–53 and 2 Pet
3:10–12 with their readings; the identity of the risen body by its matter
or by the soul (Durandus); the descent to the dead of every earlier time
(1 Pet 3:19); the theories of what love carries, to run on top. The ideas
below remain the notes they were.

- **Duration typed by measure**: time for bodies, *aevum* for angels and
  separated souls, eternity for God (ST I q. 10 a. 5).
- **One event joined to many times.** The Mass is the same sacrifice as
  the cross, offered in a different manner (DH 1743): an edge to the one
  cross, not a second passion. The descent reaches the dead of every
  earlier time (1 Pet 3:19).
- **Two judgments**: each soul at death (DH 1000), all at the end.
- **The end arriving early**: the Assumption (DH 3903); Christ's
  resurrection as firstfruits (1 Cor 15:20).
- **The glorified body's mode**, left open by the christ amendment: "not
  limited by space and time" (CCC 645), or in a bodily place (Thomas's
  empyrean heaven).
- Indulgences without "days and years" (Paul VI, *Indulgentiarum
  doctrina*, 1967, norm 4): purgation not measured by earthly time.
- The kernel already allows this: its order of events has no cycles but
  need not be a line, and it holds no theory of time
  (`causes_precede` is a part).
- **What lasts.** Law and teaching say what binds; what is carried to the
  end is another axis (TTC-LITURGY). "We will find them again, but freed
  of stain, burnished and transfigured" (GS 39); the nations bring their
  glory and honour into the city (Rev 21:24–26); "the visible universe,
  then, is itself destined to be transformed" (CCC 1047). Two candidates to
  refuse: the world annihilated, nothing of it carried over; and the world
  kept without transfiguration, stains and all. Which things love carries
  is interior and never computed (rule 3): the saints' love of a chant, a
  hymn, a window gives it no authority now and is not the checker's to
  weigh. The human being as priest of creation, offering it back ("fruit
  of the earth and work of human hands"), may run on top as a theory, as
  the Grammar of the Icon does.

### empirical

Done ([ttc-empirica(7)](research/empirica-preregistration.md)):
the empirical kind of question, kept out of deletion, cleaving and weight,
fixed by findings from their year; Galileo (the censure and the Index
decree of 1616, the sentence of 1633, Bradley's finding of 1729) and
Pius XII's address of 1951 as the two directions of one error; method
never answers being; a twinning read four ways, the one-soul reading
refused by four outward tests; CIC 1917 c. 748. Thomas's annulose
animals are in *Summa contra Gentiles* II c. 86, not ST I q. 76 a. 8.
Left: the readings of quantum mechanics as runtimes; one intellect and two
brains; whose matter a shared organ is; the generative power and marriage
in conjoined twins; the ordinary universal magisterium as a claim about
witnesses (window, threshold, mode, evidence); "nothing but" in the other
direction; the sun's own motion; a claimant required of every consent. The
notes below remain.

- An empirical kind of question. No tier of teaching settles one (the
  test case: Galileo, 1616).
- Empirical findings never delete a doctrine; they can exclude a reading
  of Scripture (DV 11; Leo XIII, *Providentissimus Deus*). Creation from
  nothing concerns being, not a date; Pius XII's 1951 address on the Big
  Bang is the overreach the other way.
- **Method never answers being.** A finding reached by division supports
  claims about the parts, never "nothing but" claims about the whole, in
  either direction. The unity of the human being is defined (Vienne,
  DH 902); the unity of other organisms is a school's.
- Interpretations of quantum mechanics as runtimes, tested against one
  soul as the form of one body and one judgment (DH 902, 1000).
- **What counts as one human being: twins.** How many persons there are
  is a fact about souls that no observation settles. It is never computed
  (rule 3): it enters as a disputed fact, both ways.
  - *Monozygotic twinning* (up to about day 14), the classic objection to
    ensoulment at conception. Three readings as runtimes: the first human
    being continues and a second begins (budding); the first ceases and
    two begin (fission); no person before twinning ends (delayed
    hominization, a school's reading). A fourth: one soul, its body the
    union of two organisms apart in space. The kernel world already has
    both shapes (`gen(budding, …)`, `gen(fission, …)`). Refused on every
    reading: one soul divided, since the soul is simple; a second soul
    from anything but God, since each is created immediately (*Humani
    generis* 36, DH 3896). The embryo is to be treated as a person from
    conception (*Donum vitae* I.1), and the moment of ensoulment is not
    defined. The fourth reading meets four tests, each a fact about the
    twins' outward acts and the Church's practice, none about an interior:
    the twins choose contrary things at once, and one soul has one will
    (wills follow natures, Constantinople III, DH 556; ST III q. 18 a. 1);
    one twin dies and the other lives, and a person dies once (Heb 9:27)
    and is judged at death (DH 1000); the Church baptizes each, and baptism
    is not repeated (Trent, DH 1609); each marries, and a prior bond
    invalidates (c. 1085). Thomas's annulose animals, one soul actually
    and many potentially, live on in each piece because their souls are
    material; the human soul is not divided with matter (ST I q. 76 a. 2;
    the locus on annulose animals to verify).
  - *Conjoined twins* (dicephalic parapagus, two heads on one trunk;
    craniopagus, joined at the head): one person or two. The law already
    computed both ways: the Code of 1917, c. 748, in doubt whether one or
    several, baptized one absolutely and the others conditionally (to
    verify). The Code of 1983 drops the canon; c. 869 remains.
  - *One intellect, two brains*: not ill-typed on its face, since the
    intellect is the soul's power and the brain serves the bodily powers
    (the cogitative power, CANDIDATE THEORIES). Two intellects in one soul
    are ill-typed. Two persons whose bodies are intermingled is the other
    reading of the same facts. One soul is the form of one body (Vienne,
    DH 902).
  - *Whose matter.* A body, strictly, is matter informed by one soul (one
    substantial form, ST I q. 76 a. 4). Two persons are two bodies however
    intermingled; a shared organ is informed by one soul or divided, never
    by both, and which is not observable. It enters as a disputed fact.
  - *The generative power and marriage.* The generative power is a power
    of each soul (ST I q. 78 a. 2). Where generative organs are shared,
    marriage meets it: consent (c. 1057), unity (c. 1056), impotence
    (c. 1084), consummation "in a human manner" (c. 1061 §1), and the
    other twin's body in the conjugal act. To compute on the disputed fact
    of whose the organs are, both ways, never on anyone's interior.
- **The ordinary universal magisterium is a claim about witnesses.**
  *Dei Filius* 3 names it (DH 3011) without conditions; its conditions are
  stated only at tier 3 (LG 25). It has no act, no date, no roll and no
  threshold, so whoever claims it supplies them: the loosest route to a
  tier, and rule 14's chief case. Its conditions are facts about a body of
  witnesses over time, as the Fathers' unanimous consent is (Trent,
  DH 1507; `consent_claim/2`). Galileo's case joins the two: in 1616 a
  claimed consent of the Fathers fixed a reading on a question of fact.
  Inputs to make explicit, each a reading computed both ways where no
  authentic interpretation fixes it:
  - the window: synchronic (LG 25, "dispersed through the world") or
    diachronic (Vincent of Lérins, *quod ubique, quod semper, quod ab
    omnibus*);
  - the threshold: moral unanimity, and of whom;
  - the mode: taught as to be held definitively, not only taught commonly
    or long;
  - the evidence: documents, catechisms, consultations (EV 5's of 1991),
    each with its provenance. The claimant's own document never shows a
    condition (c. 749 §3). Records counted by independence on the graph
    of who cites whom, not by number (CANDIDATE THEORIES, the whole seen
    at the end).

  Here the usual direction reverses. An empirical finding settles no
  doctrine, but it can leave a condition unshown, and with it the claimed
  tier. `consent_claim/2` computes the Fathers' consent both ways but
  records neither claimant nor conditions; it takes rule 14's shape too.

### L (after empirical, before the churches)

Predicted in [ttc-l(7)](research/l-preregistration.md): `.l` sources in
their own syntax compiled to the rule files, byte for byte, the rules
themselves left in clingo fences; the runtimes by inheritance with `add`,
`exclude` and `alter`, a clash refused at compile time; every slot
declared once in the lowest layer that reads it, with sorts, closed
domains enforced, a side and a sentence; parts naming their case; an
info atom for every interior supplied; premises kept apart from
conclusions (a snippet may not write a tier, a warrant or a theorem); and
nothing read from the checker's word about itself. The suite is now 563,
not 393.
The notes below remain.

Done: the base regenerated from L byte for byte; the runtimes by
inheritance; 425 slots declared once, each with its side, which
`save_case` reads (the hand lists are gone); every argument sorted, the
guide's 13 closed sorts enforced (`outside_domain`); 115 switches and
candidates naming their case; a sentence for every slot; an atom naming
every interior supplied; the grammar read off L; premises kept apart
from conclusions at the gate `conclusion`. Found on the way (SCORING):
a slot is what a case enters, so the guide's inputs that a rule also
derives (`source/4`, `interior/3`) are slots; the libraries' slots go on
either side; and 22 parts of `canon_cases.l` enter theology (hypothetical
cases with their own questions, and misfiled parts on Christ, grace and
presence). Left after L: split those 22 into their two halves (house
rule 1), the theology half to the authority files.

Between steps, never in one: the base L regenerates is the one the last
stamp's scoring ran on. Before the churches, because one runtime per
confessional family, inherited with switches, is what L's combinators are
for; after empirical, the last new kind of declaration in view (findings
with provenance, witnesses citing witnesses), so its metaclasses are
designed against the whole set. If the churches must come sooner, a thin
L first: runtime inheritance and the three combinators only.

- **A metaobject protocol for L** (Lethen, "Computational Theology: A
  Metaobject-Based Implementation of Models of Generalised Trinitarian
  Logic", *TheoLogica* 6/2, 2022). Keep answer-set programming as the
  engine: its stable models are the branches, negation as failure is the
  presumption "until rebutted", constraints delete branches, choice rules
  compute a disputed fact both ways. Take from the MOP the shape of L
  itself: kinds of declaration (norm, reading, claim, presumption, runtime)
  as metaclasses, each compiling itself to clingo; a runtime defined by
  inheritance from another, with an explicit combiner where definitions
  clash.
- **Clashes refuse; they are not linearized.** CLOS's class precedence list
  silently picks an order when two parents disagree: a partial order made
  a line, which this checker refuses elsewhere. A runtime inheriting a
  clash fails to compile until its author writes the combinator: the pair
  test, moved from run time to compile time.
- **Three combinators**, as Lethen's generalisations are three: add
  (union), alter (override), exclude. The Palamite runtime already
  excludes (it drops `one_power` and adds `no_divine_contraction`).
- **The compiled base stays checked in.** Every stamp points at a commit
  whose rule files are what the solver read. The compiler's first test is
  byte-identical regeneration of the present base, comments and citations
  included (they are slots in L); its second is the suite, 393 of 393.
  Only then a new construct.
- **What a rule needs, as slots.** Modal type (may, must, is), layer,
  tier, date and declared input slots keep being found after the fact.
  As slots on the metaclass, the layer test (a higher layer writes into a
  lower one only through declared slots) becomes a compile error.
- **The checker never vouches for itself.** A test that computes both
  sides from one function cannot fail for the reason that matters; one
  did (TTC-LLM-REQUESTS), until a second interpreter (Python 3.10 in CI)
  and a text a person wrote (the guide) did what it could not. A system
  that takes its own word as warrant proves anything (Löb, 1955; Curry,
  1942). The shape is old: the sin against the Holy Spirit is called
  unforgivable not because God cannot forgive it but because it shuts out
  the means by which forgiveness comes (ST II-II q. 14 a. 3; CCC 1864),
  and the Spirit convicts of sin from outside (Jn 16:8). So the checker's
  word about itself is a claim, read by no rule; its evidence is the
  suite's expectations, written by hand, the stamp, and every reader
  outside it. A red test is a finding (rule 7): the capacity to be
  convicted, kept. The form of the act is named; no one is said to have
  committed it (rule 3).
- **What a reader of the checker needs** (TTC-LLM-REQUESTS, from the
  tool that trains on the checker's output). Done before L: unknown slots
  as warnings, refusals as data, the summary's `schema`, key-sorted
  results, `ttc://grammar` from today's tags. Designed into L's
  predictions:
  - **Typed slots.** Each argument's sort and domain on the declaration
    (`S:source T:tier(0..5) F:{truth,juridical,protective}`), enforced:
    an argument outside its domain is a violation, as `untyped_presence`
    is now. Done (L, TY).
  - **One declaration per slot,** in the file of its layer. Done (L, SO
    and LY): the side read off the declaring file replaced
    `server.THEOLOGY_ONLY` and `CANON_ONLY`.
  - **Switches name their case** (`% @of sspx`), so a held-out set
    survives a rename. Done (L, OF): `part switch of sspx`.
  - **A `say` template per slot,** so the English beside a fact is the
    checker's. Done (L, SY).
  - **An info atom for every interior supplied**
    (`info(interior_supplied(P,A,X))`), so the non-diagnosis reminder
    comes from the oracle (rule 3). Done (L, IS).
  - **Scenarios as data** (status, present, preferred), converted as each
    is touched; the Python helpers stay for the rest.
  - **Ground once, solve many,** if generation needs the speed.

### churches

The `ecumenism` part enters the elements by hand: `has(orthodox,orders)`
is a fact, not a finding. This step computes them from history, so it
follows the empirical step. Succession, rites and dates are facts of the
world of sense, and every element holds of a body over time.

- **The frame.** The checker judges from the Catholic Church's stance:
  tiers by *Pastor aeternus* and LG 25, the Latin Code for law. There is
  no view from nowhere; the stance is declared, and every other communion
  runs inside it. The magisterium is the whole Catholic Church's, the
  Eastern Catholic Churches included; their law (CCEO, 1990) is not yet
  encoded (the cceo step), so the canon layer is Latin, not Catholic. An Orthodox frame
  would change the authority layer, not the kernel: seven councils, on
  one account a council's ecumenicity by its reception, no definition ex
  cathedra. Reception by the whole is the candidate theory of the whole
  seen at the end, so the two frames could be run on the same cases.
- ***Subsistit in*** (LG 8) stays a disputed reading (`lg8_identity`,
  `lg8_broader`); the CDF's readings (1985, DI 2000, 2007) are tier-3
  claims for one of them. The responses of 2007 make the reading
  temporal: "'subsistence' means this perduring, historical continuity and
  the permanence of all the elements instituted by Christ". Which
  elements, held when, by whom, is what this step checks.
- **Elements computed, not listed** (LG 8, 15; UR 3, 15, 22). Baptism from
  the rite's form and matter (`sacrament.lp`); orders from a graph of
  ordinations through time, each with its rite; the Eucharist from orders
  and the anaphora; the creeds and councils received, each with its date.
  A Church in the proper sense, or an ecclesial community (DI 17; the
  responses of 2007, qq. 4–5), is then derived by `church_proper/1` from
  the elements shown, never taken from anyone's list.
- **The graph of celebrations.** Every sacrament celebrated is an event
  in the order with persons on it, and the rites are joined through those
  who celebrate and receive in them: an Eastern Catholic in a Latin
  parish, a priest of two rites, the Ordinariate. Apostolic succession is
  that graph restricted to ordinations. It is also where LG 12's agreement
  "ab Episcopis usque ad extremos laicos fideles" would be counted, which
  the liturgy step only measures by extent (TTC-LITURGY LW9).
- **Intention is never computed** (rule 3). *Apostolicae curae* judges
  intention only "in so far as it is manifested externally" (n. 33): the
  rite is the outward sign. The CDF's response on the baptism of the
  Latter-day Saints (5 June 2001) reads the words of the form by the
  body's own doctrine, not the minister's mind; a test of that line.
- **Tests.**
  - Anglican orders: the Edwardine Ordinal (1550, 1552) and its amendment
    of 1662, which *Apostolicae curae* holds came too late, the line
    already broken. The Dutch touch becomes a
    path in the ordination graph (Old Catholic co-consecrators after the
    Bonn agreement, 1931), not a tier-5 opinion (`dutch_touch`); and what
    later changes in a co-consecrating church do to the path.
  - The Anaphora of Addai and Mari, judged valid without the words of
    institution (CDF, 17 January 2001, approved by the pope; PCPCU
    guidelines, 20 July 2001), against `sacrament.lp`'s form of the
    Eucharist.
  - Chalcedon not received: the common Christological declarations (with
    the Coptic Church, 1973; with the Assyrian Church of the East, 1994).
    Does a formula without Chalcedon's terms run on the kernel's
    Incarnation?
  - Justification: the Joint Declaration (1999) against the canons of
    Trent's sixth session; JDDJ 41 says the condemnations do not reach
    the teaching it presents. Also the Church of Sweden's claimed
    succession.
  - Baptism's form (DH 1314): "in Jesus' name" alone; "Creator, Redeemer
    and Sanctifier" (CDF, 1 February 2008).
  - Dates: the union of Florence (1439) and its rejection; Brest (1596);
    Utrecht (1724).
- **Which communions run.** One runtime per confessional family, not per
  body: Eastern Orthodox; Oriental Orthodox; the Assyrian Church of the
  East; Old Catholic (Utrecht); Anglican (the Thirty-nine Articles, 1571,
  and the Ordinal); Lutheran (the Book of Concord, 1580); Reformed
  (Heidelberg, 1563; Westminster, 1646); Methodist (the Articles of
  Religion, 1784); Baptist; Pentecostal, trinitarian and oneness; and two
  bodies that deny the Trinity (Latter-day Saints, Jehovah's Witnesses).
  A family enters when it has a confessional standard of its own and is
  large or tests a rule no other family tests. Bodies within a family
  inherit its runtime with switches (the L step's inheritance). Each run
  reports where it stops: the kernel (the Trinity, the Incarnation), a
  library (baptism, orders, the Eucharist, justification) or the
  authority layer (the councils received, the papacy). A stop is at a
  rule, never a verdict on persons (UR 3; rule 3).

### knowledge and other subjects (with L)

Subsidiarity: "a community of a higher order should not interfere in the
internal life of a community of a lower order" (*Quadragesimo anno* 79;
CCC 1883). The checker need not hold everything.

- **The checker stays small and deterministic:** the engine, the kernel,
  the libraries and the canons as rules, which are what is checked against.
- **Knowledge is another server.** Records, not conclusions: sources with
  dates, authors and form; canons with dated texts; claims with their
  claimants; the graph of who cites whom (the independence measure). A
  language model links the servers: it finds the records, puts them into
  the checker's slots, and asks.
- **The contract is the `@input` slots.** A record crosses only as a
  declared input, with its provenance (source, date, where read); never a
  tier or a verdict (rule 14). The checker lints what crosses: an undefined
  predicate is frontier. A run names the snapshot of records it read, as a
  stamp names a commit, so it stays deterministic. Writing stays gated, as
  the flywheel's save tools already are.
- **Other subjects as domain packs:** each its tier theory as a runtime on
  the same engine. History weighs by provenance and independence; science
  by method (replication, observation, model), revisable in time; in
  mathematics tier 1 is proof. The limit is the same everywhere: a claim
  shown ill-formed, never a well-formed claim shown true. No pack borrows
  another's tiers on its word.
- **Mathematics is not a pack but a warrant.** A proof assistant (Lean: a
  small trusted kernel, a library that grows, every theorem checked down
  to the kernel) is another server. "X is a theorem" is tier 1 exactly
  when its proof checks there: shown, not asserted (rule 14). It needs no
  empirical library: it abstracts from sensible matter and motion (*Super
  Boetium De Trinitate* q. 5 a. 1). Its record is in the saeculum: who
  proved what and when, conjectures with their claimants.

### the flywheel shared (with the remote server)

`ttc-mcp --http` serves hosted clients behind one secret URL each, and by
default only the tools that read: every client shares one personal layer,
so a save by one would change the answers of all. The writers come back
when a save can wait for the person.

- **Saves are commits, main is the person's.** The personal layer is a git
  repository; each client writes on its own branch (`flywheel/<record>`),
  a save one commit, its author the client's record and its message the
  model's stated source. The gates stay (the suite, the layer lint, L's
  `conclusion` gate). A client's runs read main and its own branch; only
  the person merges into main, after reading the diff. Revert, branch and
  merge are git's; a commit history is a DAG. Other people's servers are
  peers: their branches arrive as Radicle patches, and the delegate
  decides. The merge is the witness from outside that a passing suite
  cannot be (the checker never vouches for itself); the DAG shows the
  self-vouching case, one author saving a rule and the scenario it makes
  pass.
- **A register, not an account.** Each person who joins gets a record, as
  in a baptismal register (cc. 535, 877): an id, a pseudonym, the records
  of those who admitted them (minister and sponsors, cc. 872-874), the
  date, the hash of their token, and for those who send patches a public
  key. Sponsors are recorded before those they sponsor, so the register is
  a DAG with the person keeping it at the root. Nothing is erased: a
  revocation is a note in the margin of the record (c. 535 §2), and a
  sponsor's later trouble flags those they admitted for review, never
  revokes them. A certificate is a signed extract anyone can verify. The
  checker can check the register (order, no cycles, notes not deletions,
  sponsors' conditions); it is data about people, not the checker's word
  about itself.
- **Caution.** A register of who takes part in a theology project is
  information about religious life, a special category of personal data
  (GDPR Art. 9). Records are pseudonymous: no names, no addresses (rule
  13).

### the senses (after L)

A library of the senses: what a perceiver may claim, typed by the
classical account, so that a model reading images, sound or signing
writes well-formed premises and never a conclusion. It needs L's sorts,
schemes and `conclusion` gate.

- **Three kinds of sensible** (*De anima* II.6; ST I q. 78 a. 3): proper
  (colour to sight, sound to hearing), common (figure, number, motion,
  rest, magnitude), incidental ("the son of Diares"). Sense is not
  deceived about its proper object, only about the others (*De anima*
  III.3; ST I q. 17 a. 2): a claim's kind is its type, and its strength.
  Some things are no sensible at all: the species of the Eucharist are
  seen, Christ's body by no bodily eye (ST III q. 76 a. 7). A model may
  report `species_ceased/1`; never a presence.
- **Three layers per sense.** Measurement (pixels, spectra, audio):
  continuous, kept in another server, never in clingo. The sensible: a
  typed fact on integer coordinates (CIELAB; cents, 1200 to the octave).
  The name: a scheme's reading of a sensible ("blue", Japanese *ao*, the
  rubrics' violet, a maqam's quarter tone, an Indian *śruti*), entered
  with its scheme as claimant. A value on a boundary is read both ways.
- **Schemes by culture, closed per scheme.** Colour lexicons differ by
  language (Berlin and Kay, 1969; the World Color Survey); tuning systems
  by tradition. A scheme is declared in L, with its source, and may
  inherit as a runtime does; a culture is added as a scheme, not as code.
  No world list of colours or notes.
- **The interior senses** (ST I q. 78 a. 4): the common sense, which binds
  what the senses deliver to one thing and perceives that we perceive
  (*De anima* III.2); imagination, which keeps the forms in their order;
  the cogitative power, which grasps this individual (where incidental
  sensibles, and most error, live); memory, the past as past. Where sight
  and hearing disagree (McGurk and MacDonald, 1976), the common sense
  branches; it does not fuse in silence.
- **Words through the scheme of each sense, never end to end.** Spoken
  sounds are signs of the soul's affections, written marks of spoken
  sounds; the signs differ between peoples, what they signify does not
  (*De interpretatione* 1; Thomas, *Expositio Peryermenias* I lect. 2).
  Four routes converge on a lexicon: the audible (sound, a phonology,
  word forms); the graphic (marks, a script, word forms; through the
  spoken word in an alphabet, directly in a logography, one character
  read as different words in Chinese and Japanese); the manual (a sign
  language's own phonology and lexicon); and touch (tactile signing,
  Braille). A model writes the slots of its own rung only: a model of
  the sense may not write words. Each scheme reads two ways where it can
  ("I" or "we", a homophone, a homoglyph, a scribal abbreviation).
- **Manual languages are primary, not secondary.** A sign language is a
  language carried by sight, not a script. It is built of the visible's
  common sensibles (Stokoe, 1960: handshape, location, movement; palm
  orientation added later); colour carries nothing. Two hands and the
  face articulate at once, and referents are placed in space and pointed
  back to: tiers and loci, not a string. The face is grammar (raised brows
  mark a yes/no question in ASL): read as an emotion it is both a breach of
  rule 3 and a misreading. Not English through the hands: ASL descends
  from French Sign Language, and ASL and BSL are not mutually
  intelligible; translation is a reading between schemes. Manual
  alphabets, notations (Stokoe, HamNoSys, SignWriting) and the monastic
  sign lists kept under the rule of silence are schemes with claimants.
- **Data structures.** The scheme graph: schemes as nodes, an edge from
  the layer a scheme reads to the layer it writes, declared in L like
  slots (`scheme phonology_en reads audible writes phoneme`) and checked
  for cycles as the norm graph is. The annotation graph of each signal
  (Bird and Liberman, 2001): nodes are times, arcs are units labelled by
  layer, scheme and value, arcs spanning tiers where a sign ties both
  hands and the face; paths are readings, and readings are branches.
  Bindings across senses and pointing back are relations, not
  derivations. Influence from above (the Ganong effect, McGurk) is never
  an edge downward: the lower layer generates its readings, the higher
  tests them, deleting paths without rewriting a fact, as a tier-1 source
  deletes branches without touching the texts. The full graph stays in
  the perception server; only alternatives that bear on a slot reach the
  checker, as `disputed` where they are close.
- **Rule 3 throughout.** What is seen and heard is outward; a passion is
  interior, and c. 1324 §1 3° (grave heat of passion) takes it only as a
  claim supplied. No model writes an emotion from a face, nor what a
  speaker meant: the intention is presumed from the rite rightly used
  (*Apostolicae curae* 33), never read from a recording.
- **Where it meets the base.** Liturgical colours (GIRM 346) and chant (SC
  116) as sensibles. Sacramental form: the CDF's response of 2020 held "We
  baptize" invalid; a recording where "I" and "we" cannot be told apart
  computes the doubt both ways, and conditional baptism follows. Consent
  "in words or, if they cannot speak, through equivalent signs" (c. 1104
  §2); confession through an interpreter (c. 990), who is bound to
  secrecy (c. 983 §2); the imposition of hands as the matter of orders
  (*Sacramentum ordinis*, 1947), a manual sensible feeding `matter_used/2`.
  Manuscripts: letter forms read by a hand's script, abbreviations
  expanded both ways, variants as the sources library's readings.
- **Training.** Labels come from outside the checker (people,
  instruments), never from its outputs: a model trained on the checker
  and then feeding it agrees with it by construction (L, "the checker
  never vouches for itself").
- **To read.** Whether a sacramental form signed by the minister
  suffices: no text known here settles it; to be entered disputed until
  the sources are read.

### language (after the senses)

The rung above the senses: not all of human language, but the ability to
type-check a word in any encoding someone enters, whatever the route it
came by.

- **One word, many encodings.** What has a history is the encoding: a
  tongue, a script, a signed language, a Braille code. The word it
  carries has none. The word in the heart is neither Greek nor Latin nor
  of any tongue (Augustine, *De Trinitate* XV.10.19); spoken sounds are
  signs of it, and the signs differ between peoples while what they
  signify does not (*De interpretatione* 1; ST I q. 34 a. 1, the inner
  word and the spoken). The mind's word is an image of the Word that is
  outside time (Jn 1:1; *De Trinitate* XV.11.20). So the word is no node of
  the DAG in time: it takes no date, no parent there and no place in the
  order, as the base already refuses a procession or God's act placed in
  time (TTC-SAECULUM). Dates, descent and drift belong to forms.
- **The word is articulated, not one token.** One Word, "full of the
  living reasons" of all things (Augustine, *De Trinitate* VI.10.11), by
  which the Father speaks himself and every creature (ST I q. 34 a. 3);
  many ideas in one mind, distinct by reason (ST I q. 15 a. 2). Its
  articulation is a DAG of its own, ordered by reason and not by time:
  what is defined after what defines it, the composed after the simple,
  never a cycle (a definition through what it defines), and a concept of
  more than one parent where it has more than one genus of sense. So two
  DAGs: the order of reason, which definition traces and the checker's
  sorts, slots and rules approximate; and the order of time, in which
  encodings descend, which etymology traces. A lexicon maps the second
  onto the first. The checker is itself an encoding: made, partial, with
  a history in time (its commits), aiming at an order it does not
  constitute.
- **A part is no whole.** Division is an operation on a whole, and it
  makes no whole: a substance is not composed of substances present in it
  in act (*Metaphysics* VII.13, 1039a3-7); the parts of animals are
  potencies (VII.16, 1040b5-10); an eye that cannot see is an eye only in
  name (*De anima* II.1, 412b20-22). So `part` is never a sort: it is a
  relation to a whole, typed by that whole. A segment of a form (a
  phoneme, a morpheme, a stroke, a span) is read only within the reading
  of its whole, which is why the lines' solver chooses whole call trees
  and never scores a span alone; a finding by division says nothing of
  what the whole is (the base refuses "nothing but" from division,
  TTC-EMPIRICA). The checker's own `#program` parts are never run alone:
  every run is the base with them.

- **A form, typed.** A form (a phoneme string, a sign's handshape,
  location and movement, a written string, a Braille cell) under its
  encoding at a date; the word it is read as, from that encoding's
  lexicon; its lineage. It is ill-formed where the form is not one the
  encoding admits at that date, where the reading is one the lexicon does
  not give, or where the lineage breaks the order of time. A well-formed
  form is not thereby the right word: the checker refuses, it does not
  affirm.
- **Each encoding encodable, none required.** An encoding is declared
  in L as the senses step declares a scheme: its forms, its lexicon,
  their sources (a dictionary, a grammar, a corpus) as claimants, closed
  per encoding where its sources close it. An encoding not entered is not
  wrong; it is absent, and a form of it is an unknown slot, not a
  violation.
- **Encodings as a DAG.** Varieties are nodes in time, edges are
  descent: Latin to Old French to French; Old English and Norman French
  both to Middle English; LSF and local signing to ASL; a creole with two
  parents. A tree is refused for the reason the rites are an order, not a
  line (`derives_from/2`, `rite_of_many_parents`). An encoding inherits as
  a runtime does: `add` a borrowing, `exclude` a loss, `alter` a sound
  change (Grimm's law alters *p* to *f*). Two parents that disagree
  clash, and the child says which it took: contact is declared, never
  linearized.
- **Etymology is a partial trace.** A form's lineage is a path through
  the DAG, each step attested (a dated text) or reconstructed: a history
  of the sign, never of the word signified. A
  reconstruction is a claim with its claimant (a handbook), computed
  both ways where scholars differ, never preferred to an attested form,
  as an attribution is never preferred to evidence apart from its
  claimant. A lineage that dates a form before its parent, or derives
  it from a form attested only later, is refused, as an attribution is
  refused by its dates (TTC-SOURCES). Gaps stay gaps: nothing is filled
  in to make a path whole.
- **Where it meets the base.** Sacramental forms are forms of an
  encoding at a date ("ego te baptizo", "we baptize"); a translation is
  the one word read in another encoding, checked against the form's
  substance (TTC-LITURGY). The Latin of a canon read against its
  vernacular. The senses deliver the form; this step types it.
- **Wiring: recursive lines, composed by a solver.** Reading a text into
  facts is split into small models, one per line of the target: each
  reads every span of the input (a tree of regions built by rule:
  sentence, clause, "that …", "if …", "to …") and returns a reading: how
  strongly its line is present (an amplitude, learned), the arguments it
  fills itself (who, when, polarity: by rule, where rules hold), and
  calls to other lines for the arguments it cannot fill, each call typed
  by the argument's sort. The calls carry the nesting that a bank of
  detectors loses ("he said he would never leave" against "he never said
  he would leave"), and recurse to atoms. A solver chooses, among the
  well-typed call trees, the one with the most evidence; the tree is
  lowered to facts, the facts are a snippet the checker runs, and its
  refusal is a compile error. Each line's `say` decompiles the result to
  plain statements, for the round trip.
- **L is the type system.** The lines are L's slots, their calls its
  argument sorts (TY), the round trip its sentences (SY). The solver can
  be clingo itself: a choice over candidate readings, the sorts as
  constraints, `#maximize` over the amplitudes. What the lines write
  passes the gate only as premises (CG), so a line for a conclusion
  cannot exist, and an argument outside its closed sort is a violation.
- **Rule 3 in the lines.** A line may find that a text claims an interior
  ("she said she knew"); it enters that claim with its claimant, never an
  interior read from the words, and the checker names each one (IS).
- **Training, line by line.** Each line is trained on its own, the
  solver supplying span labels by explaining answers people encoded (hard
  EM). The answers come from people, never from the checker's verdicts.
- **Typed checks, not rewards.** A reward is a number on an output: it
  says how much, not where or why, and a model trained toward it learns
  the number. A check returns where (the gate, the slot, the line), why
  (the rule), and which readings stand (the branches). Training on the
  checker's verdicts makes the checker's word the warrant, which it never
  is (L); the labels a model learns from come from people and
  instruments, and the checker refuses what fails.

## AMENDMENTS AND REPAIRS

- **Lethen's models as test cases.** His seven dogmas (Ott's D1–D7) and
  "generalised trinitarian logics" (a dogma dropped, altered or added) are
  this checker's candidates and runtimes. To check: whether the kernel
  refuses a fourth divine person outside the incarnate's case (his D1);
  his models (a)–(d) and the six-person godhead; his D5 formula, which
  drops "as from a single principle" (the grain, A3, keeps it); and his
  definition of subordination as precedence in every topological order,
  which makes the order of origin a rank: refused by A10 and by the
  *Quicumque*, "nothing before or after, nothing greater or less"
  (DH 75; ST I q. 42 a. 3).

- **The kernel's world** treats an oak or a lion as one creature. What
  counts as one creature should become input.
- **A layer test.** Higher layers write into lower ones only through
  declared slots (the useful part of the friend's "ABI" idea). Known
  exceptions to declare or remove: `creature/1` from `act.lp`,
  `allowed/2` from a school. The kernel declares no `@input` slots yet.
- **The layer inventory** (`docs/layers.md`) predates the creed step;
  rerun `tools/layer_evidence.py`.
- **Reception is a claim about witnesses** (TTC-SAECULUM, done in part).
  It is dated and claimed, and never preferred unless an act at tier 1
  hands the creed on. Its conditions (whose use, how widespread, from when)
  are the ordinary universal magisterium's question, for the empirical
  step. The Apostles' Creed's claimed year is its text's (CCC 194 gives
  none).
- **The Filioque's Latin witnesses before 1100.** As of 1100 the record's
  only weight is Photius (886), so the preferred branch is "from the
  Father alone" (CR1b). Augustine (*De Trinitate* XV), the councils of
  Toledo, and the Western liturgy's creed are not entered. Done in
  TTC-SOURCES (FQ): Leo I's letter cleaves as of 1100; the liturgy's creed
  left for the liturgy step, Leo IX's profession (1053) and Toledo IV
  until their texts are read.
- **Attribution is a claim too.** The *Supplementum* of the *Summa* was
  compiled after Thomas's death, traditionally by Reginald of Piperno,
  from his early commentary on Book IV of the Sentences (c. 1252–56).
  Cite and date it by the commentary, as the seal's source already is
  (In IV Sent. d. 21 q. 3 a. 1); a citation of the Supplement alone is a
  frontier item. The article numbers of d. 48 behind Suppl. q. 91 are to
  be checked against the text. The mechanism is built (TTC-SOURCES AU):
  authorship typed, an attribution a claim; the Supplement not yet
  entered.
- **Trent's protection outlives the definition** in the Immaculate
  Conception's data (CM1c).
- **EV 56's judgment of today's circumstances** ("very rare, if not
  practically non-existent") is not on `q(necessity_today)`, so as of 2017
  the question is open (TTC-PRECEPT SD1c). Entering it needs a value
  between "sometimes" and "none", or a typed directive.
- **What "extraction" names.** Salpingostomy is typed as the extraction of
  an immature ectopic fetus and so meets the Holy Office's response of
  1902 (TTC-PRECEPT DI5). Whether the response reaches it is disputed
  among moralists; the typing could become a disputed fact. On c. 1398's
  older reading (the expulsion of the immature fetus) the extraction is an
  expulsion in the letter; the canon layer takes abortion only as the
  library's direct killing (TTC-PENAL), so where it is not direct it is
  not the delict on either reading.
- **Social justice** (CCC 1928-1948) is still on the frontier: respect for
  the person, equality, solidarity (TTC-PRECEPT M3).
- **The conditions of a claim.** Rule 14 leaves every claim of the
  ordinary universal magisterium unshown: no evidence of LG 25's
  conditions apart from the claimants. The 1991 consultation behind EV 57
  and 62 (EV 5) is the first to look for.
- **Form and object** (done, TTC-PENAL FO). Left: *Ad sanctam beati Petri
  sedem*. DH 2010–2012 shows two conditions (it defines; faith); the full
  bull (Bullarium Romanum, Turin edition) for the pastor of all, apostolic
  authority in the defining clause and the whole Church. Until then, tier
  3. The
  entry as it was: a papal act's form says whether it defines; its
  object gives the grade: revealed, tier 1; connected with revelation,
  tier 2 (*tenendam*, DH 3074). Typing the tier by form alone gives two
  bugs. `form_tier(ex_cathedra,1)` refuses an ex cathedra definition of a
  connected truth (`tier_inconsistent_with_form`).
  `form_tier(definitive_declaration,2)` has no warrant, so a source of
  that form is always refused (`tier_without_warrant`); no source has the
  form yet, so nothing showed it. The repair: the form decides whether the act defines, the object the
  grade; an act that declares a teaching definitive without defining it
  enters at its own tier, 3, with an `oum_claim` whose claimant is its
  author. *Ordinatio sacerdotalis* 4 (1994) is the case. The CDF's
  responsum of 28 October 1995 (approved and ordered published: tier 3)
  says the teaching was "set forth infallibly by the ordinary and
  universal Magisterium" and handed on by "a formal declaration ... as
  belonging to the deposit of the faith"; its commentary of 1998 (n. 11)
  lists it under c. 750 §2, to be defined as revealed perhaps later. The
  grade is claimed two ways, as EV 57's is. A declaration of grade is
  never a route of its own: if the declaring act defines, it is a
  definition; if not, a claim ("not a new dogmatic definition", n. 9).
  Only the force of tier 2 itself (`t2_truth`) waits on a tier-1 act, and
  none has fixed it (Gasser, relatio of 11 July 1870, on the fetch list).
- **A default is not a note** (TTC-COMMUNION NT1): a case's stipulated
  value excludes its contrary without teaching. And a constraint between
  questions can exclude a contrary no note excludes (DP's intrinsic
  wrongness and present necessity).
- **Within tier 3, a dicastery below the pope's own acts** unless approved
  in specific form: the weights lean so; the ranking is not yet explicit.
- **c. 1127 §1** (marriage with an Eastern non-Catholic) and the formal act
  of defection's own requirements (PCLT, 2006) are not encoded.
- **Religious liberty.** The SSPX's own question: *Dignitatis humanae* 2
  against *Quanta cura* and the Syllabus (1864), whose force is claimed
  ex cathedra by some, and against *Exsurge Domine* (1520) prop. 33,
  condemned *in globo*. An *in globo* censure fixes no note for any one
  proposition: each listed note is a reading. One question or two, as
  with usury.
- **Fictions of law** (done, TTC-PENAL FL). Left: the Church's
  predicates by relation to her Head (below); *Romana ecclesia*'s date;
  the interdict on a community (below). The entry as it was, from a
  friend's conversation: "The United States is
  evil" is ill-typed, not false. "Evil" is said of acts (`moral.lp`;
  CCC 1861), and a state is neither an act nor a will but a name for an
  order among wills: a unity of order, not a substance (*In I Ethic.*
  lect. 1); a people, "a multitude of rational beings united by common
  agreement on the objects of their love" (*De civ. Dei* XIX.24). The
  canonists made the type for this question. Innocent IV's *Romana
  ecclesia* forbids excommunicating a *universitas* or *collegium*: "In
  universitatem vel collegium proferri excommunicationis sententiam
  penitus prohibemus" (VI 5.11.5; not among the constitutions of Lyons I
  in Tanner's edition, its date to check). Innocent IV is often credited
  with the *persona ficta*; the fiction theory and
  "universitas delinquere non potest" are later readings of him
  (attribution is a claim). The Code keeps the shape: juridic persons are
  subjects of obligations and rights by law (cc. 113 §2, 114), act
  through those who represent them (c. 118), and are perpetual by nature
  (c. 120 §1). The gap is real: `act.lp` makes whatever has `act_of/2` a
  creature that acts, so a state entered as an actor would get verdicts.
  The sketch:

  ```prolog
  % @input juridic_person/1 | cc. 113 §2, 114: a subject of obligations and rights by law; a unity of order, not a substance
  % @input represents/2     | c. 118: who acts in its name
  acts_through(J,P) :- juridic_person(J), represents(P,J).
  violation(interior_of_fiction(J)) :- juridic_person(J), interior(J,_,_).
  violation(verdict_on_fiction(J))  :- juridic_person(J), sin_on_the_claims(J,_).
  ```

  Then "it has done evil acts" types as acts of its representatives in
  its name; "these laws are evil by their object" through `law.lp`;
  "structures of sin" only across an analogy bridge carrying the mode
  *Reconciliatio et paenitentia* 16 and *Sollicitudo rei socialis* 36 give
  it: social sin is said by analogy and reduces to personal sins.
  Nostra aetate 4 refuses collective guilt. Two sorts, not one: c. 113 §1
  makes the Church and the Apostolic See moral persons "by divine
  ordinance itself", and the Church bears predicates no state bears (holy,
  Bride, Mother; "at once holy and always in need of being purified",
  LG 8) by relation to her Head, a person; there the Grammar of the
  Icon's nuptial relation enters. The churches step needs the same line:
  a censure is said of a proposition or of a person's profession
  (`faith.lp`), never of a body; a body's confessional standard is a text.
  To check: interdict on a community, allowed in 1245 and in the Code of
  1917, and the Code of 1983's interdict, personal only (c. 1332).
- **Sources the amendment left out:** *Veritatis splendor* 80, CCC 2258,
  Pius XII on the gravid cancerous uterus, HV 12.

## CANDIDATE THEORIES

To run on the system. None enters the kernel.

- **The cogitative power, and git thought.** In the saeculum the intellect
  works through a bodily power of pattern: the cogitative power,
  "particular reason" (ST I q. 78 a. 4). "In the present state of life"
  it understands only by turning to images (q. 84 a. 7), the separated
  soul without them (q. 89 a. 1): abstraction one way (q. 85 a. 1), the
  turn to images the other. One soul, the form of one body (DH 902):
  Descartes fixed. The project has the shape: a language model reads, the
  checker computes. The analogy holds for the division of labour, not for
  the intellect's nature, which is immaterial and no mechanism; a
  deterministic engine is still a material computation. Git thought:
  thinking as a graph without cycles of commits, branches and merges; the
  branching history, the merge at the end, and stamps as the record never
  undone.

- **The postman.** Spacetime as a creature through which bodies act on
  one another; spirits speak without it, "local distance does not impede"
  (ST I q. 107 a. 4). Compare relational quantum mechanics; entangled
  pairs correlate without carrying a message.
- **Branching history.** The past is never undone; a new branch is made
  (ST I q. 25 aa. 4–6). The cross on the trunk redeems the whole tree;
  one return and one judgment merge it (Heb 9:27). Copying persons onto
  two branches strains one soul and one judgment (DH 1000); moving them
  into a past they never lived makes false witnesses (DH 3008). A private
  edit no one could tell from a memory slip cannot serve as a sign:
  miracles are signs "adapted to the intelligence of all" (DH 3009).
- **The Passion as the root of creation** (Behr). The cross completes the
  sixth day: "Behold the man", "It is finished" (Jn 19:5, 30). Ignatius:
  "when I arrive there, I shall be a human being" (*Romans* 6.2). "Human"
  typed by end, not by nature, so the image stays with everyone
  (Irenaeus's image and likeness). Christ first in intention, last in
  execution (Scotus).
  - In the deposit already: the passion is the meritorious cause of every
    justification (Trent, sess. VI, ch. 7, DH 1529).
  - A theory to run: the paschal shape as a bridge with three modes. In
    God, self-gift without death or change; in the incarnate Son,
    self-gift through death in the flesh; in creatures, passing through
    death into life. "God suffers in himself" is refused as change in
    God.
- **The Parousia as a merge** (a friend's sketch). Not a new repo:
  "I make all things new" (Rev 21:5), the same creation transformed
  (Rom 8:21; CCC 1047), the same bodies risen (DH 801), Christ's wounds
  kept, glorified (ST III q. 54 a. 4). The Fall as a detached HEAD, healed
  by re-heading all things in Christ (Eph 1:10, *anakephalaiōsis*). To
  check: a rebase "onto the divine nature" confuses the natures (DH 302;
  partakers, 2 Pet 1:4, not the same); evil is a privation, not an object
  to collect (ST I q. 48 a. 1); death and Hades go to the lake (Rev 20:14),
  persons are not pruned (DH 801, 1002, 1440); "uncreated light" is the
  Palamite reading, the light of glory created on the Latin (DH 895);
  whether plants and animals remain branches (no: In IV Sent. d. 48,
  Suppl. q. 91 a. 5; "each creature, resplendently transfigured":
  *Laudato si'* 243).
- **Creation taken up through love** (a participation in our
  participation). Every creature has its being from God immediately
  (ST I q. 8 a. 1); what human love mediates is its way to the end.
  Irrational creatures attain God by likeness, rational ones by knowing
  and loving him (I-II q. 1 a. 8); the beloved is in the lover (I-II
  q. 28 a. 2), so a creature known and loved stands before God in a
  spiritual creature, as Christ's humanity takes ours up (Col 1:20;
  Eph 1:10; Maximus, *Ambigua* 41). The Eucharist as its sign: "fruit of
  the earth and work of human hands". The question to run: is
  non-rational creation preserved in itself (Rom 8:19–22, tier 0, read two
  ways; *Laudato si'* 83, "with us and through us", tier 3), only in the
  knowing and loving of the blessed and in God's ideas (I q. 12 a. 8;
  q. 15), or not at all (In IV Sent. d. 48, Suppl. q. 91 a. 5)? Also
  Isaac the Syrian on the merciful heart; C. S. Lewis, *The Problem of
  Pain* ch. 9, on tame animals.
- **Measurement and minds.** Definiteness relative to a created knower
  (Wigner; compare Rovelli). Angels from the beginning of time answer the
  objection of a universe with no observers (DH 800). Refused: God
  "formed" by a creature (his knowledge causes things, ST I q. 14 a. 8);
  God changing history only with creatures' consent (ST I q. 25 a. 4; no
  norm over God). True underneath: consent in the order of grace, Mary's
  *fiat* (ST III q. 30 a. 1) and free cooperation (DH 1554).
- **Time as order, not a conductor.** A conductor beats time inside the
  music; providence is no scheduler inside time. God knows all times at
  once (ST I q. 14 a. 13), his knowledge causes things (q. 14 a. 8), and
  he governs through secondary causes, each acting by its own nature
  (q. 22 a. 3; q. 103 a. 6), some necessarily, some freely (q. 22 a. 4):
  the composer of the score, not a clock interrupting the players. Software
  has the architecture. A distributed system keeps no global clock: time
  is the happens-before order of events (Lamport, "Time, Clocks, and the
  Ordering of Events in a Distributed System", 1978), a partial order, as
  the kernel's order of events need not be a line; clocks are measures
  laid on it, as time is "the number of motion according to before and
  after" (ST I q. 10 a. 1). Each creature an actor with its own operation;
  a scheduler that does every act itself is occasionalism, which the
  classical runtime refuses. An angel's movement need not be continuous
  (q. 53 a. 1): discrete time beside continuous. Git works so already: the
  commit graph is the order, a commit's date is typed by whoever commits,
  and a stamp anchors it (rule 12). For the saeculum library: the order
  first, the calendars as measures on it.
  - **Space works the same way.** Causal set theory (Bombelli, Lee,
    Meyer and Sorkin, 1987) takes spacetime as a locally finite partial
    order of events: the causal order fixes the geometry up to a local
    scale, a conformal factor (Hawking, King and McCarthy, 1976; Malament,
    1977), and counting events gives the volume.
    The speed of light is the bound of the order, the relation by which
    one event can reach another; Lamport's happens-before is the same
    relation, drawn from special relativity. So no spacetime scheduler:
    an order of events among creatures, and measures on it.
  - **Past, now, not yet.** An event's past is what precedes it, its not
    yet what follows, and between them an "elsewhere" that neither
    reaches. A "now" is a maximal set of events no one of which precedes
    another (an antichain); there are many, and choosing one is choosing a
    frame, which is relativity's loss of a single simultaneity. In git,
    the tips of the branches are such a set. The saeculum's common now is
    then a chosen slice, not a clock everyone reads.
  - **Light has no age** in this sense only: along a light ray no proper
    time passes; there is no frame moving with light. Not the *nunc stans*
    of eternity, "the whole, simultaneous and perfect possession of
    unending life" (Boethius; ST I q. 10 a. 1): light is a creature with a
    path, and to give it eternity's mode would be the kernel's refused
    confusion of the creature with God (refused since TTC-SAECULUM, MD3).
  - **Mass as the clock.** Light gives the order; mass gives the measure.
    The causal order fixes the geometry up to its scale, and what is
    massless keeps no time: a clock needs mass (Penrose, *Cycles of Time*,
    2010), and a world of massless things has order without measure. So
    the saeculum's design, order first and measures laid on it, is the
    physics' too: time numbering motion "by before and after" (ST I q. 10
    a. 1) needs something that moves below the speed of light.
  - **Gravity in the checker: the order as dynamical.** The checker
    branches over a fixed order: models split on readings, claims and
    facts, while `before/2` is the same in every branch, as quantum
    mechanics evolves against a fixed causal background. Gravity makes the
    background itself dynamical, and quantum gravity asks how the order
    itself might branch (indefinite causal order: Oreshkov, Costa and
    Brukner, 2012). The candidate: `before/2` computed per branch among
    creaturely events, around a fixed spine the deposit gives (he died,
    then rose, once: `economy_out_of_order`).
  - **Weight as love, not fatigue.** Gravity read as tiredness, or as
    freedom inhibited, says of bodies what is said of persons: a crossing
    of sorts, licensed only through a bridge with modes. Augustine builds
    that bridge the other way: "Pondus meum amor meus; eo feror, quocumque
    feror" (*Confessions* XIII.9). A body's weight carries it to its place
    and rest; love carries the soul to its own. Weight as a desire for
    one's place, rest as an end: an analogy of proportion, and the reading
    this candidate takes.
- **The whole seen at the end** (development as unfolding). The consent
  of the whole people, "from the Bishops down to the last of the lay
  faithful" (LG 12), of every church (LG 23) and every time, the dead
  included, is seen whole only at the end (1 Cor 13:12): "the Church
  constantly moves forward toward the fullness of divine truth until the
  words of God reach their complete fulfillment in her" (DV 8). A claim
  of the ordinary universal magisterium made now is about a slice, a
  moment or a prefix, and reads an open world as closed: no dissent found
  is not consent. Indefectibility joins slice and whole: "Ecclesia
  universalis non potest errare, quia spiritu sancto gubernatur" (II-II
  q. 1 a. 9 s.c.; Augustine, *securus iudicat orbis terrarum*, *C. ep.
  Parm.* III.4.24). No truly universal slice contradicts the whole. LG 12
  also has the sense of faith exercised "under the guidance of the sacred
  teaching authority": the people's witness does not stand apart from the
  bishops'. The figure is decoherence: the global state stays pure, each
  local view sees a definite branch, and the coherence is in correlations
  no part holds.
  - Unitary evolution is the closed deposit: no new revelation (DH 3070;
    *Lamentabili* 21, DH 3421, refused).
  - Records are definitions: irreversible, "ex sese, non autem ex
    consensu Ecclesiae, irreformabiles" (DH 3074); growth "in eodem
    dogmate, eodem sensu eademque sententia" (Vincent, DH 3020).
  - Heresy is a partial trace taken as the whole (*hairesis*, a choosing).
  - The end is the whole seen, not decoherence reversed: nothing is
    undone (the branching history above).
  - **The measure: independent records.** An outcome is objective when
    recorded redundantly in many independent fragments (Zurek, "Quantum
    Darwinism", *Nature Physics* 5, 2009). Witnesses citing witnesses
    form a graph without cycles; a claim's independent records are the
    witnesses that reach it by disjoint paths (by Menger's theorem, the
    fewest sources whose removal leaves it without record), the
    claimant's own document never among them (c. 749 §3). A thousand
    catechisms quoting one catechism are one record. The empirical step's
    threshold becomes a derivation, not a head count.
  - **The test: the Arian crisis.** "Ingemuit totus orbis, et Arianum se
    esse miratus est" (Jerome, *Adv. Lucif.* 19, on Rimini, 359); "the
    body of the episcopate was unfaithful to its commission, while the
    body of the laity was faithful to its baptism" (Newman, *On Consulting
    the Faithful in Matters of Doctrine*, 1859). A slice of bishops at one
    moment (LG 25 as encoded) reads 359 wrong; the whole people, or a
    window across time, reads it right. To check: whether the measure
    alone catches Rimini, its bishops signing one formula from Sirmium
    under the emperor's pressure, one record rather than four hundred.

## SETTLED IN CONVERSATION

- Christ is not free of original sin because his mother was: encoded as a
  candidate and refused (CE1d, CE1e).
- The friend's "frozen kernel" idea: speed is not a problem (0.1–0.45 s a
  case); the kernel judges the user's claims, so it is run every time; the
  layer test above is the part worth keeping.

## SEE ALSO

[ttc-coverage(7)](coverage.md), [ttc-findings(7)](findings.md), [ttc-layers(7)](layers.md),
[ttc-flywheel(7)](flywheel.md)
