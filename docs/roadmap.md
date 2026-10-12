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
| christ | Christ's acts; the sacraments; the seal; presence by mode | stamped; amendment committed, to stamp; **next** ([ttc-christ(7)](research/christ-preregistration.md)) |
| communion | faith and communion | to predict |
| canon | the canon-law step | to predict |
| last things | soteriology and eschatology | to predict |
| empirical | science | to predict |
| L | a language for libraries, compiled to clingo | after the libraries |
| integration | the checker as a verification step for agent frameworks | a doc page, later |

## NEXT STEPS IN DETAIL

### christ (amendment to stamp, then encode)

The amendment is committed (presence typed by mode; the three outputs of
a sacrament; nullity and dissolution). Stamp it, then encode. What to
watch:

- Trent's "no repugnance" (DH 1636) as the warrant for typing presence
  by mode (PM2); one body in two places as the schools' question (PM3);
  Berengar's profession of 1059 read two ways (PM4).
- The fruit of a sacrament as input (SA8); infants, where the deposit
  states the fruit, composed and never entered as a state (SA9); a
  declaration of nullity read as a divorce (SA10).
- The seal (SA7): a generic delict; coercion (c. 1324 §1 n. 5, §3);
  "the nature of the sacrament" checked as a ground.
- The minister acts as Christ's instrument: why "We baptize" fails (SA5).

### communion

c. 11 (who is bound by merely ecclesiastical law); c. 205 (the three
bonds: faith, sacraments, governance); c. 751 (heresy, apostasy, schism)
as offences against the bonds; II-II qq. 1–16 and 39; LG 14.

### canon

A delict that need not be a consecration, absolution or marriage;
c. 1399; c. 1752; the DDF clause on error about a minor's age, with
TTC-ACT's N1–N5, now on `moral.lp`'s object and circumstance.

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

## AMENDMENTS AND REPAIRS

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

[ttc-findings(7)](findings.md), [ttc-layers(7)](layers.md),
[ttc-flywheel(7)](flywheel.md)
