# TTC-REPAIRS3(7)

## NAME

**ttc-repairs3** — strict interpretation and c. 1321 §4; what gross ignorance
supplies; the missing mitigating and aggravating circumstances; proper and
improper exemptions; predictions, committed before encoding

## DESCRIPTION

Read as the rules stand (the base at `79bcd5e`, TTC-REPAIRS2 merged,
committed just before these predictions):

- **c. 18 and c. 1321 §4.** The reading of §4 (`presumes_imputability`,
  `presumes_dolus`) is computed both ways, and c. 18 is not applied to it.
  Since 2021, §4 stands as an exception to §1's presumption of innocence,
  and it is odious to the accused; whether c. 18 reaches it is itself
  disputed. The base computes only the side on which it does not.
- **c. 1325.** Crass, supine and affected ignorance bar cc. 1323-1324 and
  supply nothing. Whether they count as dolus ("punished as though dolus"),
  or whether affected ignorance, directly willed, supplies dolus while crass
  and supine, indirectly willed, supply culpa (ST I-II q. 6 a. 8), is not
  read at all.
- **c. 1324 §1.** Only nn. 1, 3, 4, 5, 8 and 9 are encoded. Missing: n. 6
  (defence without due moderation), n. 7 (grave and unjust provocation),
  n. 10 (imputability not full, yet grave), and n. 2 (culpable drunkenness).
  Gravity is not represented: c. 1321 §2's "gravely imputable" has no claim
  to read.
- **c. 1326 §1.** No aggravating circumstance is encoded. Of the four, n. 3
  (culpa with the event foreseen) and n. 4 (a disturbance deliberately
  sought, or passion deliberately stimulated or nourished) bear on the
  source and degree of imputability.
- **c. 1323.** Every exemption yields `exempt/2` alike. Some leave the
  delict standing and only exempt from the penalty (n. 1 age; n. 4 fear,
  necessity, grave inconvenience; n. 5 moderate defence); others remove the
  subjective element, so that there is no delict in the formal sense (n. 2
  ignorance, error or inadvertence without fault; n. 3 chance; n. 7 a
  blameless belief; and force or the lack of reason, where there is no human
  act). The output does not tell them apart.

The case that found this: a recourse case on a declared excommunication, and
a discussion of it.

## THE TEXTS

| Text | What it says |
| --- | --- |
| c. 18 | "Laws which establish a penalty, restrict the free exercise of rights, or contain an exception are subject to strict interpretation." |
| c. 1321 §1 | "Anyone is considered innocent until the contrary is proved." |
| c. 1321 §2 | No one is punished unless the external violation "is gravely imputable by reason of malice or of culpability". |
| c. 1321 §4 | "Where there has been an external violation, imputability is presumed, unless it appears otherwise." |
| c. 1323 | Exemptions: nn. 1-7. |
| c. 1324 §1 | Mitigation: n. 6 "one who acted in lawful self-defence or defence of another against an unjust aggressor, but did not observe due moderation"; n. 7 "one who acted against another person who was gravely and unjustly provocative"; n. 10 "one who acted without full imputability, provided it remained grave". |
| c. 1324 §3 | "In the circumstances mentioned in § 1, the offender is not bound by a latae sententiae penalty." |
| c. 1325 | "Ignorance which is crass or supine or affected can never be taken into account when applying the provisions of cann. 1323 and 1324." |
| c. 1326 §1 | "A judge must inflict a more serious punishment": n. 3 one who, a penalty for a culpable offence being constituted, "foresaw the event but nevertheless omitted to take the precautions to avoid it which any careful person would have taken"; n. 4 one who offended in drunkenness or other mental disturbance "deliberately sought so as to commit the offence or to excuse it, or through passion which was deliberately stimulated or nourished". |
| ST I-II q. 6 a. 8 | Ignorance consequent to the will is voluntary directly ("cum aliquis ex industria vult ignorare, ut habeat excusationem peccati, vel ut non retrahatur a peccando"), or indirectly, by negligence of what one is bound to know. |

The canons are quoted from vatican.va.

## PREDICTIONS

### SI: c. 18 and c. 1321 §4

- **SI1.** Wherever §4's reading is asked, whether c. 18 reaches §4 is
  entered as disputed and computed both ways; `narrower(presumes_imputability,
  presumes_dolus)` is entered.
- **SI2.** Where c. 18 reaches §4, only `presumes_imputability` is read, and
  a note says `presumes_dolus` is declined by strict interpretation. Where
  it does not, both readings stand as in TTC-REPAIRS2. `presumes_dolus` thus
  survives only where c. 18 does not reach §4.
- **SI3.** A run with an unsourced *latae sententiae* penalty has three
  combinations where it had two (`sspx` with `lattice`: 384 branches become
  576).
- **SI4.** No expectation changes from SI alone: every check written under a
  reading of §4 still finds its branches.

### IG: what gross ignorance supplies (c. 1325)

- **IG1.** c. 1325 is read three ways, asked once where gross ignorance
  attends a delict: `bar_only` (it bars cc. 1323-1324 and supplies
  nothing); `as_dolus` (all three kinds count as dolus); `affected_as_dolus`
  (affected ignorance counts as dolus; crass and supine as culpa).
- **IG2.** On `act_penal` (c. 1379, culpa not punished): on `bar_only`, x6,
  x22 and x23 stand as now, turning on §4. On `as_dolus`, all three are
  incurred on every reading of §4. On `affected_as_dolus`, x23 is incurred
  on every reading of §4, and x6 and x22 are culpa, not punished (c. 1321
  §3), and incurred on none.
- **IG3.** With `culpa_punished`, on `affected_as_dolus`, x6 and x22 are
  incurred on every reading of §4.
- **IG4.** Suite: **AC5** goes red and is restated reading by reading. AB4
  (affected ignorance of the penalty, `m_aff`) is unchanged: its checks are
  written under the reading of §4 that presumes dolus, on which `m_aff` is
  incurred on every reading of c. 1325.

### MT: mitigation and gravity (c. 1324 §1 nn. 6, 7, 10; c. 1321 §2)

- **MT1.** Defence without due moderation (n. 6), grave and unjust
  provocation (n. 7), and imputability diminished yet grave (n. 10) each
  mitigate, and by c. 1324 §3 no *latae sententiae* penalty binds. Whether
  an excess was by dolus (which excludes mitigation) is not distinguished
  here.
- **MT2.** Imputability claimed not grave: no penalty (c. 1321 §2), and a
  note says the subjective element of the delict is absent.
- **MT3.** All are claims supplied by a case (`interior/3`), never computed
  (rule 3).

### AG: aggravation (c. 1326 §1 nn. 3-4)

- **AG1.** Culpa with the event foreseen as certain is noted as aggravating
  only where the law punishes culpa: with `culpa_punished`, a note; without
  it, none.
- **AG2.** Passion deliberately stimulated or nourished supplies dolus
  (*dolus praemeditatus*): the penalty is incurred on every reading of §4,
  with a note of aggravation, and with no mitigation under c. 1324 §1 n. 3
  (as now).
- **AG3.** Drunkenness or disturbance deliberately sought (n. 4, first limb)
  and culpable drunkenness (c. 1324 §1 n. 2) are not encoded: both need the
  act imputed in its cause, a change to the human-act library left to a
  later repair.

### PE: proper and improper exemptions (c. 1323)

- **PE1.** Exemptions are told apart by a note. Improper (n. 2, n. 3, n. 7,
  and no human act): no delict in the formal sense. Proper (n. 1, n. 4,
  n. 5): the delict stands, exempt from the penalty. `delict/3` keeps naming
  the external violation under a penal norm; no exemption is removed.
- **PE2.** On `act_penal`, improper: x3, x4, x7, x8, x9, x10, x13, x21,
  x24; proper: x1, x11, x12.
- **PE3.** Suite unchanged by PE (notes only).

### CL: the norm graph

- **CL1.** No vicious cycle, no undefined predicate; PR4 clean.

Only **AC5** is expected to go red.

## NOT IN THIS REPAIR

Culpable drunkenness and the deliberately sought disturbance (AG3); excess in
defence by dolus; recidivism and dignity (c. 1326 §1 nn. 1-2); whether c. 18
reaches c. 1325; c. 1324 §2.

## SEE ALSO

docs/research/repairs2-preregistration.md.

## SCORING

Scored on the encoding (branch `repairs3`, from `85b003b`), against the
predictions above as committed and stamped (`ffba066`, proof `85b003b`).

| Prediction | Result |
| --- | --- |
| SI1 | **Hit.** AC14: `penal_use(c1321_4)` is disputed wherever §4's reading is asked, one branch each way; `narrower(presumes_imputability,presumes_dolus)` entered. |
| SI2 | **Hit.** AC14: where c. 18 reaches §4, only `presumes_imputability`, with `declined_by_strict_interpretation(c1321_4,presumes_dolus,all)`; where it does not, both readings, no note. |
| SI3 | **Hit.** `sspx` with `lattice`: 384 branches become 576. |
| SI4 | **Hit.** No check changed for SI: every check written under a reading of §4 still finds its branches. |
| IG1 | **Hit.** AC15. Asked once per run, only where gross ignorance attends a delict: `act_penal_more`, which has none, keeps three branches. |
| IG2 | **Hit.** AC15: on `bar_only`, as in TTC-REPAIRS2; on `as_dolus`, x6, x22, x23 incurred on every reading of §4; on `affected_as_dolus`, x23 incurred, x6 and x22 culpa not punished. |
| IG3 | **Hit.** AC15b. |
| IG4 | **Hit.** AC5 went red on both of its reading checks and is restated under `bar_only` (rule 7); AB4 unchanged. |
| MT1 | **Hit.** AC16: y1, y2, y3 mitigated (`excess_defence`, `provocation`, `not_full`), none incurred. |
| MT2 | **Hit.** AC16: y4 not imputed, with `no_formal_delict(y4,b_slight)`. |
| MT3 | As stated: every circumstance is an `interior/3` claim of the part `act_penal_more`. |
| AG1 | **Hit.** AC17 (no note, culpa not punished), AC17b (a note, and incurred). |
| AG2 | **Hit.** AC17: y5 incurred in every branch, `aggravated(y5,b_stim,stimulated_passion)`, no mitigation, no `source_not_established`. |
| AG3 | As stated. |
| PE1 | **Hit.** AC18; `exempt/2` unchanged (AC2). |
| PE2 | **Hit**, exactly the lists predicted. x20 also shows `no_formal_delict` in the branches assuming its disputed invincible ignorance, as the claim gives. |
| PE3 | **Hit.** No check changed for PE. |
| CL1 | **Hit.** No vicious cycle, no undefined predicate (`ttc-l check`); PR4 clean. |

Only AC5 went red, as predicted. The other 574 scenarios were unchanged.

One change the predictions did not see: `penal_use/1` was a slot that no
rule derived. The disputed premise makes the base derive it, so the L
inventory no longer counted it as a slot (`test_every_slot_is_declared_once`).
A case still enters it (c. 18), so the guide now gives it as an input, as it
gives `interior/3`.

Each new rule has a test that fails without it (rule 5): each of the 36 new
lines, commented out alone, turns its scenario red (AC5, AC14-AC18, AC15b,
AC17b). AC15 gained one check for this: without `supplied_source` from
c. 1325, gross ignorance counted as dolus would still show as a source not
established.

Noted, not changed: in `act_penal_more`, on `presumes_imputability`, y1-y3
carry `source_not_established`. That is true (no source is entered), and by
c. 1324 §3 no penalty binds them on either reading.

Left open, as before: culpable drunkenness and the deliberately sought
disturbance (AG3); excess in defence by dolus; whether c. 18 reaches c. 1325.
