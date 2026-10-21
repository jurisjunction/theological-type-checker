# TTC-REPAIRS2(7)

## NAME

**ttc-repairs2** — the Pontiff's own act, the last recourse, the decree made
known, and what c. 1321 §4 presumes; predictions, committed before encoding

## DESCRIPTION

Read as the rules stand (the base at `4f4f575`, committed just before these
predictions):

- **RF1, c. 333 §3.** `papal_act/1` reads only the issuer's rank. A curial
  decree approved in specific form is rank 4 on the authority side
  (`in_forma_specifica/1`, `icon_authority.lp`), but on the canon side it is
  not the Pontiff's act: a recourse against it is admitted and suspends the
  declaration it makes (c. 1353).
- **RF2, SST art. 24 §1.** Nothing excludes a recourse against the
  Dicastery's own decision on a recourse in a delict reserved to it. Such a
  recourse is admitted and suspends like any other.
- **RF3, c. 54 §1.** A declaration takes effect from the decree's date
  (`issued_at/2` reads `decree/3`), not from its notification. Between the
  two, `declared/2` and what reads it (c. 1331 §2, c. 915) hold before the
  person has been told.
- **RF4, c. 1321 §§2-4.** `imputed/3` follows from the presumption of
  imputability unless culpa is shown, and a *latae sententiae* penalty is
  incurred with no source of imputability (dolus or culpa) entered. The
  base thus reads §4 as reaching dolus, the rule of CIC/17 c. 2200 §2,
  which the Code of 1983 did not keep. Gravity is not represented. Whether
  §4's presumption reaches dolus, or mere imputability, is a disputed
  reading with no authentic interpretation: by rule 2 it branches.

The case that found this: a cleric's declared excommunication, confirmed on
recourse by a Dicastery decree that holds the declaring decree's only stated
ground insufficient (scratch case, neutral names).

## THE TEXTS

| Text | What it says |
| --- | --- |
| c. 333 §3 | "There is neither appeal nor recourse against a sentence or decree of the Roman Pontiff." |
| c. 54 §1 | "A singular decree whose application is entrusted to an executor takes effect from the moment of execution; otherwise, from the moment it is made known to the person by the authority of the one who issued it." |
| c. 1353 | Recourse against a decree that declares a penalty has suspensive effect. |
| SST (2021) art. 2 §1 | The delicts against the faith are heresy, apostasy and schism, "according to the norm of cann. 751 and 1364 CIC". |
| SST (2021) art. 24 §1 | "Against singular administrative acts of the Congregation for the Doctrine of the Faith in cases of reserved delicts, the Promoter of Justice of the Dicastery and the accused have the right to present recourse within the peremptory term of sixty useful days to the same Congregation, which judges the merits and legitimacy of the recourse, excluding any further recourse whatsoever." |
| c. 1321 §2 | No one is punished unless the external violation "is gravely imputable by reason of malice or of culpability". |
| c. 1321 §3 | One who deliberately violated a law is bound by its penalty; a violation by omission of due diligence is not punished "unless the law or precept provides otherwise". |
| c. 1321 §4 | "Where there has been an external violation, imputability is presumed, unless it appears otherwise." |
| CIC/17 c. 2200 §2 | "Posita externa legis violatione, dolus in foro externo praesumitur, donec contrarium probetur." |
| c. 1342 §1 | A penalty can be imposed or declared by extra-judicial decree, "observing canon 1720, especially in what concerns the right of defence and the moral certainty in the mind of the one issuing the decree, in accordance with the provision of can. 1608". |

The canons are quoted from vatican.va; SST from vatican.va (11 October
2021); CIC/17 from iuscangreg.

## PREDICTIONS

### PA: the Pontiff's own act (c. 333 §3)

- **PA1.** A decree approved in specific form is the Pontiff's own act. A
  recourse against it is not admitted, so it suspends nothing. On `sspx`
  with `ddf_decree_2026` so approved (HYPOTHETICAL) and the recourse
  pending, `declared(fellay,n1364)` holds and `declaration_suspended` does
  not appear.
- **PA2.** A decree whose issuer is the Pontiff (LW2) is unchanged.

### SR: the last recourse (SST art. 24 §1)

- **SR1.** A decision of the Dicastery on a recourse against its own act,
  in a delict reserved to it (c. 1364; SST art. 2 §1), admits no further
  recourse. A recourse against that decision is not admitted and suspends
  nothing, and a note says so.
- **SR2.** The first recourse, against the Dicastery's own decree
  (`ddf_decree_2026`), is still admitted and suspends (SX11 unchanged on
  this point).
- **SR3.** Only c. 1364's delicts are entered as reserved; the other
  reserved delicts (SST arts. 3-6) are left to a later repair.

### NK: the decree made known (c. 54 §1)

- **NK1.** A declaration takes effect for a person when it is made known to
  him. With `ddf_decree_2026` notified to Fellay on 15 October 2026 and
  the clock at 10 October 2026, the recourse decided, `declared(fellay,n1364)`
  does not hold; the others' declarations, whose notification is not
  entered, hold.
- **NK2.** Where no notification is entered, the effect is dated from the
  decree, as now, and a note says so. Nothing else in the suite changes.
- **NK3.** The executor clause of c. 54 §1 is not encoded.

### CI: what c. 1321 §4 presumes

- **CI1.** The presumption's reach becomes a reading of c. 1321 §4 with two
  options: `presumes_imputability` (narrower) and `presumes_dolus`. It is
  asked once per run, and only where it decides something: a delict
  carrying a *latae sententiae* penalty, imputable on the presumption, with
  no source (dolus or culpa) entered. c. 18 is not applied to §4 in this
  repair, so both branches are computed; whether c. 18 reaches §4 is left
  open.
- **CI2.** On `presumes_dolus`, every result stands as now. On
  `presumes_imputability`, such a penalty is not incurred, and a note says
  the source is not established.
- **CI3.** With dolus entered, the penalty is incurred on both readings
  (AC6, x18). With culpa entered it is not punished unless the law
  provides (AC6, AC6b), as now.
- **CI4.** Penalties *ferendae sententiae* (`to_be_imposed`) are unchanged:
  the process imposing them must itself establish the source (c. 1342 §1;
  c. 1608).
- **CI5.** Suite. Expected to go red, each to be restated with its reason
  (rule 7): **AC1, SX11, SX22, PR1, LW1, LW2, AB4, CT4, EP2**, wherever they
  require a *latae sententiae* penalty incurred, with no source entered, in
  every branch they select. Expected unchanged: AC2-AC8, AC6, AC6b, AC10,
  AC11, SM3b, SM7, CN4, GP1, N1, EP1, EP4, SX1, SX3, SX12, SX14, MS4b, AB6,
  SL2, AS3, FC3, and every scenario without a *latae sententiae* delict.
- **CI6.** In the scratch case that found this, on the readings least
  favourable to the cleric (one act suffices; the act classed as schism;
  nothing appearing otherwise; no c. 1324 circumstance), the penalty is
  incurred only on `presumes_dolus`.

### CL: the norm graph

- **CL1.** No vicious cycle; no undefined predicate. PR4 stays clean.

## NOT IN THIS REPAIR

Gravity as a separate element; c. 1324 §1 nn. 7 and 10; c. 1341 for
declarations; the reserved delicts of SST arts. 3-6; the executor clause of
c. 54 §1; a rule classing a formal reception into another communion as
schism (a theological classification first, by rule 1). Moral certainty
(c. 1608) is never computed (rule 3); the checker shows only on what a
finding rests.

## SEE ALSO

docs/research/calendar-preregistration.md, the TTC-REPAIRS commit
`f90f176`.
