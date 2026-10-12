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
| canon | the canon-law step | to predict |
| cceo | the Eastern Code: a second canon layer, chosen by ascription | to predict |
| liturgy | the liturgy as witness, rite and development | to predict |
| last things | soteriology and eschatology | to predict |
| empirical | science | to predict |
| churches | other Churches and ecclesial communities: succession, sacraments, *subsistit in* | to predict, after empirical |
| L | a language for libraries, compiled to clingo | after the libraries |
| integration | the checker as a verification step for agent frameworks | a doc page, later |

## NEXT STEPS IN DETAIL

### canon

c. 1399; c. 1752; the DDF clause on error about a minor's age, with
TTC-ACT's N1–N5, now on `moral.lp`'s object and circumstance. (The
generic delict input came with the christ step.)

- **Abortion, c. 1397 §2** (c. 1398 before 2021): latae sententiae
  excommunication for one who procures a completed abortion, and
  notoriously tricky. What "abortion" is: the 1988 interpretation is
  authentic (c. 16 §1), unlike the 2000 declaration on c. 915;
  "completed"; necessary accomplices (c. 1329 §2);
  and the exemptions and mitigations that keep the latae sententiae from
  binding: age (cc. 1323 n. 1, 1324 §1 n. 4), ignorance of the penalty
  (c. 1324 §1 n. 9), grave fear (c. 1324 §1 n. 5, §3). The act layer has
  them; the case tests them together. The moral side is in place:
  direct abortion is "must not" in every main branch (TTC-PRECEPT DI3),
  so c. 1397 §2 can take the act's kind from the library, as c. 1386 took
  the seal's ground.

### cceo

A second canon layer beside the Latin one, under the same discipline:
binary, dated, each rule under `@norm` (iuscangreg's `cceo.php`; the
official text, AAS 82 (1990) 1033–1364). The teaching above is shared;
only the law differs (rule 1).

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

### liturgy

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

### empirical

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

### L (after the libraries)

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
- **Reception has no date.** A creed typed tier 1 by reception needs a
  date the checker can use; the *Quicumque*'s decides the Filioque's
  history (CR1b).
- **Attribution is a claim too.** The *Supplementum* of the *Summa* was
  compiled after Thomas's death, traditionally by Reginald of Piperno,
  from his early commentary on Book IV of the Sentences (c. 1252–56).
  Cite and date it by the commentary, as the seal's source already is
  (In IV Sent. d. 21 q. 3 a. 1); a citation of the Supplement alone is a
  frontier item. The article numbers of d. 48 behind Suppl. q. 91 are to
  be checked against the text.
- **Trent's protection outlives the definition** in the Immaculate
  Conception's data (CM1c).
- **EV 56's judgment of today's circumstances** ("very rare, if not
  practically non-existent") is not on `q(necessity_today)`, so as of 2017
  the question is open (TTC-PRECEPT SD1c). Entering it needs a value
  between "sometimes" and "none", or a typed directive.
- **What "extraction" names.** Salpingostomy is typed as the extraction of
  an immature ectopic fetus and so meets the Holy Office's response of
  1902 (TTC-PRECEPT DI5). Whether the response reaches it is disputed
  among moralists; the typing could become a disputed fact.
- **Social justice** (CCC 1928-1948) is still on the frontier: respect for
  the person, equality, solidarity (TTC-PRECEPT M3).
- **The conditions of a claim.** Rule 14 leaves every claim of the
  ordinary universal magisterium unshown: no evidence of LG 25's
  conditions apart from the claimants. The 1991 consultation behind EV 57
  and 62 (EV 5) is the first to look for.
- **Form and object.** A papal act's form says whether it defines; its
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
- **Sources the amendment left out:** *Veritatis splendor* 80, CCC 2258,
  Pius XII on the gravid cancerous uterus, HV 12.

## CANDIDATE THEORIES

To run on the system. None enters the kernel.

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
