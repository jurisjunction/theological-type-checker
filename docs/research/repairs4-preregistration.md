# TTC-REPAIRS4(7)

## NAME

**ttc-repairs4** — the deed imputed in its cause: culpable drunkenness
(c. 1324 §1 n. 2) and the disturbance deliberately sought (c. 1326 §1 n. 4);
predictions, committed before encoding

## DESCRIPTION

Read as the rules stand at `ea33b20` (TTC-REPAIRS3, branch `repairs3`, PR #8,
not yet merged; the encoding is stacked on it):

- **c. 1323 n. 6.** A deed done without the use of reason
  (`interior(P,E,reason(lacking))`) is no human act (`removes_voluntary/3`),
  so nothing is imputed, and the exemption is improper. The canon reserves
  "the provisions of cann. 1324 § 1 n. 2 and 1326 § 1 n. 4", and nothing in
  the base reads the reservation: a lack of reason the agent brought on
  himself, culpably or by design, exempts like any other.
- **c. 1324 §1 n. 2.** Culpable drunkenness or a similar disturbance, which
  takes away the use of reason, is not encoded. The canon does not exempt; it
  tempers the penalty, and by §3 no *latae sententiae* penalty binds.
- **c. 1326 §1 n. 4, first limb.** The offence committed in drunkenness or
  another disturbance "deliberately sought so as to commit the offence or to
  excuse it" is not encoded (TTC-REPAIRS3 AG3).
- **The library.** `act.lp` has no way to say that a deed done without reason
  is voluntary in its cause. Thomas: where the drunkenness was without sin,
  the sin that follows is wholly excused; where it was with sin, the sin that
  follows is not wholly excused, being voluntary through the act before it,
  but it is lessened (ST II-II q. 150 a. 4). This is *actio libera in causa*.
  It bears on imputability only. An act that needs actual reason to be placed
  (consent, c. 1095 n. 1; a juridic act, c. 124 §1) is not placed by a
  will that went before it, so `actus_humanus/2` must not change.

The discussion that found this: TTC-REPAIRS3, and a paper on who is guilty.

## THE TEXTS

| Text | What it says |
| --- | --- |
| c. 1322 | "Those who habitually lack the use of reason, even though they appeared sane when they violated a law or precept, are deemed incapable of committing an offence." |
| c. 1323 n. 6 | No one is liable to a penalty who, when violating a law or precept, "lacked the use of reason, without prejudice to the provisions of cann. 1324 § 1 n. 2 and 1326 § 1 n. 4". |
| c. 1324 §1 n. 2 | The penalty must be diminished if the offence was committed by "one who was lacking the use of reason because of culpable drunkenness or other mental disturbance of a similar kind, without prejudice to the provision of can. 1326 § 1 n. 4". |
| c. 1324 §3 | "In the circumstances mentioned in § 1, the offender is not bound by a latae sententiae penalty." |
| c. 1326 §1 n. 4 | A judge must inflict a more serious punishment on "a person who committed an offence in a state of drunkenness or other mental disturbance, if these were deliberately sought so as to commit the offence or to excuse it, or through passion which was deliberately stimulated or nourished". |
| ST II-II q. 150 a. 4 | Drunkenness without fault excuses the sin that follows wholly; drunkenness with fault does not excuse it wholly, the act being voluntary through the will of the act before it, but lessens it. |

The canons are quoted from vatican.va (Book VI as revised in 2021).

## PREDICTIONS

### IC: the library

- **IC1.** Two claims are added, supplied by a case and never computed (rule
  3): `interior(P,E,disturbance(culpable))` and
  `interior(P,E,disturbance(sought))`. With `interior(P,E,reason(lacking))`,
  either makes the deed `voluntary_in_cause/2`. The deed stays no human act;
  the penal canons read a new `imputable_act/2` (a human act, or a deed
  voluntary in its cause) where they read `actus_humanus/2` now.
- **IC2.** `actus_humanus/2` is unchanged, so nothing that reads it changes:
  c. 125 (rescindable acts), c. 1103 (consent), sin on the claims
  (`moral.lp`), `christ.lp`.
- **IC3.** Habitual lack of reason (c. 1322) is not reached: with a culpable
  disturbance entered as well, the person remains incapable.

### DR: culpable drunkenness (c. 1324 §1 n. 2)

- **DR1.** The lack of reason, culpably brought on, gives no exemption
  (c. 1323 n. 6, reserved), and the deed is no longer noted as no delict in the
  formal sense. It is still noted as not a human act, for the deed itself is
  not, and a note says it is voluntary in its cause.
- **DR2.** It is imputed and mitigated (`culpable_disturbance`); by §3 no *latae
  sententiae* penalty binds, on any reading.
- **DR3.** No source of imputability is composed from it. On the reading of
  c. 1321 §4 that presumes mere imputability, a note says the source is not
  established; nothing turns on it, since no *latae sententiae* penalty binds.

### DS: the disturbance deliberately sought (c. 1326 §1 n. 4)

- **DS1.** The lack of reason, sought so as to commit the offence or excuse it,
  gives no exemption and no mitigation (c. 1324 §1 n. 2 reserves c. 1326 §1
  n. 4).
- **DS2.** It supplies dolus, as passion deliberately stimulated does
  (TTC-REPAIRS3 AG2): the *latae sententiae* penalty is incurred on every
  reading of c. 1321 §4 and of c. 18's reach, with a note of aggravation
  (`sought_disturbance`), and no note that the source is not established.
- **DS3.** The notes of aggravation are told apart by their ground: the sought
  disturbance is not noted as stimulated passion, nor the reverse.

### CA: the cases

- **CA1.** A new part, `act_in_causa` (HYPOTHETICAL), with one absolution
  attempted (c. 1379) by each of: z1, reason lacking, no fault claimed (as
  x10); z2, reason lacking from a culpable disturbance; z3, reason lacking
  from a disturbance sought; z4, reason habitually lacking, with a culpable
  disturbance entered.
- **CA2.** z1 and z4: not a human act, no formal delict, nothing incurred, no
  note of the voluntary in its cause. z2: DR1-DR3. z3: DS1-DS3.
- **CA3.** The part gives three branches: c. 1321 §4 is read for z2, and c.
  1325 is not asked.

### SU: the suite

- **SU1.** No expectation changes. No existing case enters a disturbance; the
  outputs of `act_penal` and `act_penal_more` are unchanged, y5's note of
  stimulated passion included.

### CL: the norm graph

- **CL1.** No vicious cycle, no undefined predicate; PR4 clean.

No test is expected to go red.

## NOT IN THIS REPAIR

What source culpable drunkenness supplies (dolus indirectly willed, or
culpa): no *latae sententiae* penalty binds (c. 1324 §3), and a process
imposing a penalty must itself establish the source (c. 1342 §1; c. 1608).
Imperfect use of reason from a disturbance sought: c. 1324 §1 n. 1 carries no
reservation of c. 1326 §1 n. 4, and whether it is barred, as c. 1325 (1983)
barred it, is not read. c. 1326 §§2-3, and §1 nn. 1-2. The text of 1983
(c. 1325, second clause; c. 1323 n. 6 reserving c. 1325): the base reads Book
VI's canons on imputability as revised in 2021 at every date, as before. Sin
on the claims for a deed done in drunkenness (`moral.lp`, II-II q. 150 a. 4).
Capacity to place an act without the use of reason (c. 1095 n. 1; c. 124 §1),
unchanged.

## SEE ALSO

docs/research/repairs3-preregistration.md.

## SCORING

Scored on the encoding (branch `repairs4`, from `ea33b20` with `main` merged),
against the predictions above as committed and stamped (`35e53d5`, proof
`9fdf3cf`).

| Prediction | Result |
| --- | --- |
| IC1 | **Hit.** AC20, AC21: `voluntary_in_cause/2` for z2 and z3; `imputed/3` and `improper/2` read `imputable_act/2`. |
| IC2 | **Hit.** `actus_humanus/2` unchanged; every check that reads it (AC8, AC9, the moral and Christ libraries) unchanged. |
| IC3 | **Hit.** AC19: z4 stays incapable, with no note of the voluntary in its cause. |
| DR1 | **Hit.** AC20: z2 not exempt, not noted as no formal delict; noted as not a human act, and as voluntary in its cause. |
| DR2 | **Hit.** AC20: `mitigated(z2,c_culp,culpable_disturbance)`, and nothing incurred in any branch. |
| DR3 | **Hit.** AC20: `source_not_established(z2,…)` on the reading that presumes mere imputability, in both of its branches. |
| DS1 | **Hit.** AC21: z3 neither exempt nor mitigated. |
| DS2 | **Hit.** AC21: z3 incurred in all three branches, with `aggravated(z3,c_sought,sought_disturbance)` and no note that the source is not established. |
| DS3 | **Hit.** AC21 (z3 not noted as stimulated passion), AC17 (y5 not noted as a disturbance sought; one check added, nothing changed). |
| CA1 | As stated. |
| CA2 | **Hit.** AC19-AC21. |
| CA3 | **Hit.** Three branches; c. 1325 not asked. |
| SU1 | **Hit.** No expectation changed: AC1-AC18 and the 574 other scenarios as before. |
| CL1 | **Hit.** No vicious cycle, no undefined predicate (`ttc-l check`); PR4 clean. |

No test went red, as predicted.

Each new rule has a test that fails without it (rule 5): each new line
commented out alone, and each rule that now reads `imputable_act/2` put back
as it was, turns its scenario red (AC1, AC17, AC20, AC21); so does c. 1324
§1 n. 2 without its reservation of c. 1326 §1 n. 4 (AC21).

One slip of method, no harm to the record: the merge of `main` into
`repairs4` (the predictions and their proof only) was committed before
`pytest -q` ran on the branch (rule 11). Its tree is the tested `ea33b20`
with two files of text added, and the whole suite ran green on the encoding
before the encoding's commit.

Left open, as stated: what source culpable drunkenness supplies; imperfect
reason from a disturbance sought; c. 1326 §§2-3; the text of 1983; sin on
the claims in drunkenness.
