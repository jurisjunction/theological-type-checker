# TTC-ACT(7)

## NAME

**ttc-act** — the human act as a standard library for canon law:
predictions, committed before encoding

## DESCRIPTION

Canon law presupposes a theory of the human act it never states:
imputability (cc. 1321–1325), force and fear (cc. 125, 1103), ignorance and
error (cc. 15, 126, 1096–1099, 1323–1325), consent as an act of the will
(c. 1057), use of reason (cc. 97–99, 1095). Thomas treats the human act
(ST I-II qq. 6–21) before law (q. 90), which he defines as "a rule and
measure of acts" (q. 90 a. 1). The canon layer handles each of these ad
hoc.

Write the theory once, as a library (`act.lp`) between the kernel and the
canon layer. The canons call it; none keeps an interior slot of its own.
Then test one recent norm against it: the clause of the Dicastery's norms
on reserved delicts that ignorance or error about a minor's age neither
excuses nor mitigates.

This file was committed and stamped before any of it was encoded. RESULTS
will be appended below; nothing above RESULTS will be edited.

## THE LIBRARY

Fixed here.

- **Kinds of act.** An *actus humanus* proceeds from knowledge and
  deliberate will; an *actus hominis* does not (ST I-II q. 1 a. 1). Only a
  person's act can be either; it presupposes that creatures act (the
  classical runtime).
- **What removes or lessens the voluntary** (ST I-II q. 6 aa. 4–8; CCC
  1735): violence; fear, grave or light, from without or within, just or
  unjust; passion; habit; ignorance, of law or of fact, antecedent,
  concomitant or consequent (vincible, crass, supine, affected); lack or
  imperfect use of reason.
- **The interior is input.** Every one of these is a claim about a
  person, supplied by a case and branched on (disputed fact, or the
  internal forum). No rule derives one from outward facts (rule 3).
  Presumptions are typed as presumptions (c. 1321 §4).
- **Morality of act-types is teaching.** Object, end and circumstances
  (CCC 1750–1756); acts intrinsically evil by their object (*Veritatis
  splendor* 79–80). These go on the authority graph, with sources and
  tiers, about kinds of act, never about a person.
- **The canons call it.** cc. 1321–1325 (penal), c. 125 (juridic acts),
  c. 1103 (marriage), each reading the same typed claims with its own
  juridical effect.

## THE NORM

Norms on delicts reserved to the Dicastery for the Doctrine of the Faith
(11 October 2021; issued by papal rescript), art. 6 n. 1: the delict
against the sixth commandment committed by a cleric with a minor under
eighteen; "ignorance or error on the part of the cleric regarding the age
of the minor does not constitute an extenuating or exonerating
circumstance". Art. 29: the Code's canons on delicts and penalties apply
together with the norms. Compare c. 1323 n. 2 (one who without fault was
unaware of violating a law is not punished; inadvertence and error are
equivalent to ignorance) and c. 1324.

## METHOD

Encode the library; route the existing penal rules (c. 1321 §4, c. 1323
n. 4) through it; add cc. 1323–1325, c. 125 §2, c. 1103 and art. 6 n. 1,
each under `% @norm` with its text from vatican.va. New cases: a cleric's
delict with an error about the age, claimed vincible and claimed
invincible; one grave, unjust fear read by the four canons that speak of
fear. Run the whole suite and the runtimes' boots.

## PREDICTIONS

### L: the library

- **L1.** Routing c. 1321 §4 and c. 1323 n. 4 through the library changes
  no existing scenario.
- **L2.** A scan of the base finds no rule that derives an interior state
  from outward facts. The one place the base presumes one is c. 1321 §4,
  typed as a presumption. After encoding, a test enforces this.
- **L3. One fear, four canons.** A grave fear, unjustly inflicted from
  without, typed once: c. 125 §2, the juridic act stands but may be
  rescinded; c. 1103, a marriage is invalid (there the fear need not be
  unjust, nor even intended); c. 1323 n. 4, no penalty, unless the act is
  intrinsically evil or tends to the harm of souls, and then c. 1324 §1
  n. 5, a lesser one. No canon needs a fear predicate of its own.
- **L4.** On the bare runtime no creature acts, so no human act exists and
  no penalty is incurred anywhere: canon law presupposes *agere sequitur
  esse*. On each of the four runtimes the library boots unchanged.

### N: the norm

- **N1. It fits, as *versari in re illicita*.** One engaged in an unlawful
  act is not excused for what follows from it (ST II-II q. 64 a. 8). A
  cleric's sexual act is unlawful in its object whatever the other's age
  (c. 277 §1: perfect and perpetual continence). The error about the age
  concerns a circumstance of an act already illicit; the clause raises no
  violation in the pair.
- **N2.** Its effect is exactly one branch fewer in the external forum:
  the branch in which the age, unknown without fault, exempts (c. 1323
  n. 2) or mitigates (c. 1324) is gone. The internal-forum branch stays,
  and is never computed.
- **N3. Read as a moral judgment, it does not fit.** That the cleric is
  guilty of the species "abuse of a minor" though he erred without fault
  about the age contradicts the library: a circumstance unknown without
  fault does not give the act its moral species (ST I-II q. 6 a. 8; q. 18
  a. 10). The checker refuses that reading as law answering a doctrinal
  question (`teaching_from_law`, rule 1). The clause is coherent as a
  rule of the external forum only.
- **N4. HYPOTHETICAL.** Transposed to an agent whose act is lawful apart
  from the circumstance, the same clause punishes without *dolus* or
  *culpa* (against c. 1321 §2), and the checker flags it. No case under
  art. 6 reaches this: the subject, a cleric bound to continence, is what
  makes the clause coherent.
- **N5. Rank.** Entered as papal law, the clause derogates, for the age of
  the minor only, from cc. 1323–1324 as special law (c. 20). Entered as a
  dicastery's general decree, it could not (cc. 33 §1, 135 §2), and the
  checker refuses the derogation. It branches on rank only if the rank is
  entered as disputed.

### M: meta

- **M1.** No prediction of TTC-SCHOOLS changes, except as L4 on bare.
- **M2.** Every new rule has a test that fails without it.

## CAVEATS

The library is Thomas's account, which the Code's canons on imputability
follow without naming it. Where the schools differ (on the freedom of the
will, on probabilism) the library states the interface, not a school.

N1 and N3 are a reading of a recent norm by the same hand that will encode
it. Canonists may read the clause otherwise: as a presumption of vincible
ignorance, or as a rule that makes the age an objective condition of the
delict. Each reading becomes a branch, not a verdict.

## STANDARDS

- Aquinas, ST I-II q. 1 a. 1; q. 6 aa. 1–8; q. 18 a. 10; q. 76 a. 3;
  q. 90 a. 1; II-II q. 64 a. 8
- CCC 1734–1737, 1750–1756, 1790–1794; John Paul II, *Veritatis splendor*
  (1993) 79–80
- CIC cc. 15, 20, 33 §1, 97–99, 125–126, 135 §2, 277 §1, 1057, 1095–1103,
  1321–1326, 1398 §1 (as revised 2021)
- Congregation (now Dicastery) for the Doctrine of the Faith, *Norms
  regarding delicts reserved to the Congregation for the Doctrine of the
  Faith*, 11 October 2021, artt. 6, 29
  (https://www.vatican.va/roman_curia/congregations/cfaith/documents/rc_con_cfaith_doc_20211011_norme-delittiriservati-cfaith_en.html)

## SEE ALSO

[ttc-schools(7)](schools-preregistration.md),
[ttc-canon(5)](../canon-law-layer.md), [ttc-layers(7)](../layers.md)

## RESULTS

Appended after the runs.

## AMENDMENT

Committed after the first stamp (of 893dc32) and before any encoding;
stamped on its own. Nothing above is changed.

- **Dolus and culpa belong to the library.** The two forms of
  imputability the Code names (c. 1321 §§2–3): *dolus*, the deliberate
  violation of a law, with knowledge of the law and of the act and a will
  set on it; *culpa*, the omission of due diligence, whose ignorance is
  vincible (ST I-II q. 6 a. 8; q. 76 aa. 2–3). Each is composed from the
  library's elements; culpa is punished only where the law provides
  (c. 1321 §3).
- **L5.** *Dolus* and *culpa* are compositions of the library's elements;
  no canon needs a predicate of its own for either. c. 1321 §3 becomes one
  switch per norm: whether that norm punishes culpa.
- **N1–N5** stand as written. They are scored in the canon-law step, which
  encodes art. 6 n. 1 on the library's *dolus* and *culpa*.
