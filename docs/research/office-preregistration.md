# TTC-OFFICE(7)

## NAME

**ttc-office** — the form of marriage by office: the pastor and the local
ordinary assisting within their territory without delegation, under the
Codes of 1917 and 1983; a pastor a priest; two witnesses; predictions,
committed before encoding

## DESCRIPTION

Read as the rules stand (the base with the gate's repair, CG7, as
committed just before these predictions):

- **Delegation only.** `valid_form/1` holds for a marriage before a
  minister an ordinary delegated (c. 1111; CIC 1917 c. 1096), in common
  error (c. 144), or, with an Eastern non-Catholic, before a sacred
  minister (c. 1127 §1). The norm's own citation names "the ordinary, the
  pastor, or a priest delegated by either" (c. 1108 §1), but no rule lets
  the pastor or the ordinary assist by office. A marriage before the
  pastor of the place, in his parish church, is reported
  `invalid_form`.
- **No witnesses.** c. 1108 §1 requires two witnesses for validity
  (CIC 1917 c. 1094, "duobus saltem testibus"). No slot records them, and
  a marriage before one witness passes.
- **A pastor is not known to be a priest.** c. 1108 §3 (2016) asks for a
  priest where one party is Eastern; `lacks_priest/1` reads `priest/1`,
  which a case must enter for the pastor too.

## THE TEXTS

| Text | What it says |
| --- | --- |
| CIC 1983 c. 1109 | The local ordinary and the pastor, unless excommunicated, interdicted or suspended from office, or declared such by sentence or decree, assist validly within their territory at the marriages of subjects and non-subjects, provided one party is of the Latin rite (from 2016: ascribed to the Latin Church). |
| CIC 1917 c. 1095 §1 | The pastor and the local ordinary assist validly from taking possession, within their territory only, at the marriages of subjects and non-subjects. |
| CIC 1983 c. 1108 §1 | Only marriages contracted before the local ordinary, the pastor, or a priest or deacon delegated by either, and before two witnesses, are valid. |
| CIC 1917 c. 1094 | "Ea tantum matrimonia valida sunt quae contrahuntur coram parocho, vel loci Ordinario, vel sacerdote ab alterutro delegato et duobus saltem testibus" (as quoted in the base, from iuscangreg). |
| CIC 1983 c. 521 §1 | Only one in the order of the presbyterate is validly appointed pastor. |

The texts are checked against vatican.va and iuscangreg when the rules are
written, and quoted in their `norm` lines.

## PREDICTIONS

### PO: the pastor and the ordinary by office

- **PO1.** Under the Code of 1983, a marriage held within the territory of
  the pastor or the local ordinary who assists, with one party of the
  Latin Church, is in valid form without delegation (c. 1109). Held
  outside it, with no delegation from the place, its form fails. One
  declared excommunicated, interdicted or suspended from office at the
  date assists invalidly.
- **PO2.** Under the Code of 1917, from 19 May 1918 to 26 November 1983,
  the same by c. 1095 §1 n. 2, without the proviso on rite.
- **PO3.** A pastor is a priest (c. 521 §1): a marriage of a Latin and an
  Eastern party before a Latin pastor in his parish passes c. 1108 §3
  without `priest/1` entered.
- **PO4.** New slots, each with its norm, sort and sentence:
  `pastor_of/2`, `ordinary_of/2`, `held_in/2`, `within/2`.

### PW: witnesses

- **PW1.** A marriage recorded with fewer than two witnesses fails the
  form, whoever assisted (c. 1108 §1; CIC 1917 c. 1094). A slot
  `witnesses/2` gives the number; silence on it is no defect.
- **PW2.** A marriage with an Eastern non-Catholic before a sacred
  minister, the form binding for liceity only (c. 1127 §1), is untouched
  by PW1.

### M: meta

- **M1.** No expectation of the suite changes: no case gives a pastor's
  territory or a number of witnesses.
- **M2.** Each rule has a test that fails without it (rule 5), and each
  sits under a `norm` with its source (rule 4).
- **M3.** Left unencoded, and named in BUGS: the personal pastor and
  ordinary (c. 1110), a lay person's assistance (c. 1112), the
  extraordinary form (c. 1116), and the date of a dispensation from the
  form (c. 1127 §2, granted after the wedding).

## METHOD

Predictions committed and stamped first (rule 12). The rules go in
`l/canon_law.l` under `norm` lines, the slots with them; then `ttc-l
build`, the tests, the guide's CANON table, and SCORING appended here.

## SEE ALSO

[ttc-sources(7)](sources-preregistration.md) (TX: a code at a date),
[ttc-cceo(7)](cceo-preregistration.md), [ttc-l(7)](l-preregistration.md)
