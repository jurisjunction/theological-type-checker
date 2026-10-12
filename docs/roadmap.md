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
| communion | faith and communion: notes, denials, bonds | predicted; **to stamp** ([ttc-communion(7)](research/communion-preregistration.md)) |
| canon | the canon-law step | to predict |
| liturgy | the liturgy as witness, rite and development | to predict |
| last things | soteriology and eschatology | to predict |
| empirical | science | to predict |
| L | a language for libraries, compiled to clingo | after the libraries |
| integration | the checker as a verification step for agent frameworks | a doc page, later |

## NEXT STEPS IN DETAIL

### communion (predicted, to stamp)

The notes of teaching read off the graph (c. 750 §§1–2, c. 752; the CDF's
commentary of 1998); professions and their censures; heresy, apostasy and
schism (c. 751; II-II qq. 5, 11, 12, 39); cc. 11, 96, 205; c. 1364;
c. 1371 n. 1 (1983, 1998) and c. 1365 (2021); c. 1117 (1983, 2009); LG 14.
Writing the predictions found that the commentary lists EV 57 among the
truths of the first paragraph (n. 11), where TTC-PRECEPT typed its claim
at tier 2 (NT4).

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
  whether plants and animals remain branches (no: Suppl. q. 91 a. 5; "each
  creature, resplendently transfigured": *Laudato si'* 243).
- **Measurement and minds.** Definiteness relative to a created knower
  (Wigner; compare Rovelli). Angels from the beginning of time answer the
  objection of a universe with no observers (DH 800). Refused: God
  "formed" by a creature (his knowledge causes things, ST I q. 14 a. 8);
  God changing history only with creatures' consent (ST I q. 25 a. 4; no
  norm over God). True underneath: consent in the order of grace, Mary's
  *fiat* (ST III q. 30 a. 1) and free cooperation (DH 1554).

## SETTLED IN CONVERSATION

- Christ is not free of original sin because his mother was: encoded as a
  candidate and refused (CE1d, CE1e).
- The friend's "frozen kernel" idea: speed is not a problem (0.1–0.45 s a
  case); the kernel judges the user's claims, so it is run every time; the
  layer test above is the part worth keeping.

## SEE ALSO

[ttc-coverage(7)](coverage.md), [ttc-findings(7)](findings.md), [ttc-layers(7)](layers.md),
[ttc-flywheel(7)](flywheel.md)
