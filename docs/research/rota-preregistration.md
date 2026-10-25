# TTC-ROTA(7)

## NAME

**ttc-rota** — published Rotal sentences as cases of the consent canons, the
Rota's findings as their premises, its readings as acts that weigh;
predictions, committed before encoding on `main`

## DESCRIPTION

Read as the rules stand at `f932d62` (`main`), with the consent canons as
drafted in a personal layer (`marriage_consent.lp`: cc. 1095–1103 and CCEO
cc. 818–826, not in the base):

- **The base holds c. 1103 only** of the consent canons. The draft reads the
  others element by element: each element a premise (`interior/3`,
  `deceit/5`, `quality_gravely_disturbs/1`, `intended/3`, `condition/4`,
  `fulfilled/1`), entered or entered `disputed`, never derived (rule 3).
  c. 1098 composes four: the deceit, its purpose, the quality's gravity, and
  the deceived party's consent.
- **One consent canon is dated.** Whether c. 1098 reaches a marriage before
  27 November 1983 is a disputed reading with no authentic interpretation
  (`declarative_of_natural_law`, `merely_positive`), and such a case
  branches. c. 1101 states what consent is and is not dated.
- **A sentence binds its parties.** An interpretation "in a sentence … in a
  particular matter" binds only the persons and matters for which it was
  given (c. 16 §3). Under TTC-REPLIES a particular reply weighs and never
  cleaves. The jurisprudence of the Roman Curia supplies a lacuna, never in
  a penal case (c. 19).

The work, on a branch `rota`, merged only if it holds:

1. The consent layer moved into the base, with a test per rule (rule 5).
2. Four published sentences as cases, facts only and public record (no
   HYPOTHETICAL). A sentence's facts are those it states: the marriage and
   its date, the parties, the grounds of the doubt, the decision on each.
   Its premises are what the Rota found on each element of each ground:
   *proved*, the premise entered; *not proved*, *contrary proved*, *not
   reached* or *not discussed*, nothing entered.
3. Each sentence an act applying its readings (`applies_reading/3`), cited to
   its publication.

The findings were drawn from each sentence's facts and argument by a model
(notary's `casegen --rota-findings`), per ground and per element, with the
paragraph. A person reads them against the sentence before they are encoded.

## THE SENTENCES

All *coram* Burke, in English, from the ponens' published collection
(cormacburke.me.ke):

| Case | Sentence | Wedding | Doubt | Decision | Findings |
| --- | --- | --- | --- | --- | --- |
| `rota_19901025_dolus` | 25 Oct 1990; *Studia canonica* 26 (1992) 235–243 | 11 Jul 1987 | c. 1098; c. 1095 2°, subordinately | negative; negative | deceit, its purpose, the quality's gravity not proved (§§35–36); grave defect of discretion, contrary proved (§37) |
| `rota_19951019_prolis` | 19 Oct 1995 | 1981 | c. 1101 §2, bonum prolis | affirmative | the exclusion proved (§29) |
| `rota_19910502_sacramenti` | 2 May 1991; *Forum* 2 (1991) 2: 106–124 | 22 Jul 1978 | c. 1101 §2, bonum sacramenti | negative | the exclusion not proved (§35) |
| `rota_19901025_fidei` | 25 Oct 1990; *The Jurist* 51 (1991) 216–226 | Feb 1982 | c. 1101 §2, bonum sacramenti and bonum fidei | affirmative; affirmative | both exclusions proved (§26) |

## PREDICTIONS

### RO: the Rota's decisions

- **RO1.** All six decisions reproduced: `consent_vitiated_by(M,G)` holds
  for the three grounds answered affirmatively and for none of the three
  answered negatively.
- **RO2.** No case branches. Three marriages precede 27 November 1983, but
  c. 1101 is not dated; the one c. 1098 marriage (1987) was celebrated with
  the canon in force, so `needs_reading(c1098,M)` does not fire.
- **RO3.** The c. 1098 case fails on each element alone. Entering any one or
  any two of the three premises it lacks leaves the ground unproved; only
  all three together make it.

### FI: the findings

- **FI1.** The findings outrun the premises. *Not proved* and *contrary
  proved* compute alike, and nothing in the base holds a paragraph. Keeping
  what the Rota found, for an index of its reasoning, needs one new slot
  beside the premises, a finding with its paragraph, read by no norm; no new
  rule.

### RE: the readings

- **RE1.** A Rotal reading weighs. The dolus sentence's reading of c. 1098
  (§36: the quality the canon contemplates cannot be confused with a motive
  for marrying), entered as the sentence applying a reading, changes no
  computed outcome anywhere in the suite, the four cases included.

### SU: the suite

- **SU1.** No expectation changes. Moving the consent layer in leaves every
  existing scenario's output as it was; `pytest -q` (894 passed, 16
  skipped at `f932d62`) gains only the new tests.

### CL: the norm graph

- **CL1.** No vicious cycle and nothing undefined; PR4 clean.

No test is expected to go red.

## CAVEATS

One ponens, and four sentences a person picked for their spread across
grounds, not at random. RO1 is close to wiring where a ground has one
element (the three exclusions); the dolus case is the one that tests
composition. The findings are a model's reading of each sentence, and RO1
is about the checker given them, not about that reading.

## NOT IN THIS WORK

The In iure as rules: what a sentence holds about the law (for instance
that the quality of c. 1098 is not a motive) is entered as a reading the
sentence applies, never as a norm. Several ponentes on one reading, which
is where the Rota itself would branch. Exhibits and expert reports.

## SEE ALSO

docs/research/replies-preregistration.md, docs/canon-law-layer.md,
docs/flywheel.md.

## SCORING

Scored on the encoding (branch `rota`: step 1 at `841917a`, steps 2-3 at
`22d8c1f`), against the predictions above as committed and stamped
(`8a37450`, stamp `c2cd56a`). The branch starts at `c2cd56a`, after
TTC-MODERNITY (`85e9e46`) reached `main`; the base it is compared with is
`c2cd56a`, not `f932d62`.

| Prediction | Result |
| --- | --- |
| RO1 | **Hit.** RO1: `consent_vitiated_by/2` engages the three grounds answered affirmatively (prolis; fidei, sacramenti) and none of the three answered negatively (c. 1098 and c. 1095 2° in the dolus case; sacramenti in the other). |
| RO2 | **Hit.** RO2: one model; no `c1098_reading/2`, no `assumed_fact/1`. |
| RO3 | **Hit.** RO3: with any one or any two of the three switches (`rota_dolus_act`, `rota_dolus_purpose`, `rota_dolus_gravity`), c. 1098 is not engaged; with all three, it is. |
| FI1 | **Partly.** *Not proved* and *contrary proved* compute alike: each enters nothing. One slot, `finds/5`, read by no norm. Two things the prediction did not see. The compiler refuses a slot no rule reads (SO3), so one rule reads it: `info(sentence_found/5)`, which names each finding in every branch, as `act.lp` names a supplied interior; it is not a norm, and `test_findings_are_read_by_no_norm` keeps it the only reader beside the check of the sort. And the base did hold a paragraph, as `locus` (n(9)), but in linguae's layer, above canon law's, where a canon slot may not reach; a sort `paragraph` was added. With the closed sort `sentence_finding`, the slot brings two sorts. |
| RE1 | **Hit, and emptier than stated.** RE1: the dolus sentence's reading of c. 1098 changes no computed outcome; c. 1098 before the Code still branches on the reading (k12). Run with and without `rota_readings`, the four cases and the consent parts give 128 models and the same atoms: the reading is not even named. It holds by construction (no authority rank is entered for the Rota, so `authentic_reading/3` cannot fire). The prediction's *weighs* has nothing in the base behind it: a particular reply weighs (`weighs_only/2`, TTC-REPLIES), a reading a sentence applies does not yet. |
| SU1 | **Miss.** Two expectations changed in step 1 and one was widened in step 2, each stated in its commit (rule 7): `test_one_presumption` (c. 1101 §1's presumption joins the presumptions raised), and `test_no_motive_is_read` (TTC-SOURCES AU7), which now admits `deceit/5` as a premise c. 1098 and CCEO c. 821 read, and as the name of an element in a sentence's finding. The 707 scenarios at `c2cd56a`, each run on `c2cd56a` and on the branch and the outputs compared: 686 unchanged, 21 changed. In the 21, nothing is removed and no count of models changes; 302 lines `info(presumed_consent(P,M))` are added, c. 1101 §1's presumption named for each spouse of a marriage, and 13 lines `info(marriage(M,invalid_consent,G))`, the ground (c. 1103, CCEO c. 825) beside the `info(marriage(M,invalid_consent))` the base already showed. `pytest -q`: 933 passed, 16 skipped at `c2cd56a` (894 at `f932d62`, before TTC-MODERNITY); 949 passed, 16 skipped on the branch: 933 and the 16 new tests. |
| CL1 | **Hit.** CL1: 128 norms, 418 edges, no vicious cycle, nothing undefined, no unused input; PR4 clean. |

Each new rule has a test that fails without it (rule 5). In step 1, the
condition that no one is their own deceiver (`P != O`) taken out turns MC3
red (k28). In step 2, `info(sentence_found/5)` taken out, the compiler
refuses `finds/5` (no rule reads it) and the test of its readers fails.

Two findings of method. The suite's checks are written as what must and
must not appear, so an added line passes them: SU1's 21 changed scenarios
all stayed green, and only the comparison of outputs shows them. And a test
that bars a word reads names as well as rules: AU7 caught a switch named
for the premise it enters, and the switch was renamed (`rota_dolus_act`),
not the test changed.
