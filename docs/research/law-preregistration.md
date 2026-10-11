# TTC-LAW(7)

## NAME

**ttc-law** — law as a standard library: predictions, committed before
encoding

## DESCRIPTION

Thomas defines law before any code: "an ordinance of reason for the
common good, made by him who has care of the community, and promulgated"
(ST I-II q. 90 a. 4). He orders the kinds of law (q. 91), says when a
human law fails (q. 96 a. 4), when it may change or be dispensed (q. 97),
and how far one may go beyond its words (q. 96 a. 6). The Code's general
norms state the same theory as rules of the external forum: promulgation
(cc. 7–8), authentic interpretation (c. 16), the meaning of words (c. 17),
strict interpretation (c. 18), doubt of law (c. 14), the lacuna and equity
(c. 19), abrogation and harmony (cc. 20–21), dispensation (cc. 85–86),
competence (c. 135 §2).

Write the theory once, as a library (`law.lp`), and let the canons call
it. Then run it on the cases the base already holds.

This file was committed and stamped before any of it was encoded. SCORING
will be appended below; nothing above it will be edited.

## THE LIBRARY

Fixed here.

- **What a law is** (q. 90). Promulgated (c. 7), by a competent
  legislator with care of the community (q. 90 a. 3; c. 135 §2). That it
  is an ordinance of reason for the common good is presumed of every law
  so made; the presumption is not weighed (rule 2) and yields only to a
  higher law.
- **The order of laws** (q. 91; q. 93 a. 3; q. 95 a. 2; q. 96 a. 4):
  eternal, natural, divine positive, ecclesiastical. A law contrary to a
  higher law does not bind (q. 96 a. 4; c. 135 §2; c. 24 §1). Whether a law
  contradicts divine law is a doctrinal question: the theology side
  answers it, through `classification/3` (rule 1).
- **Change and dispensation** (q. 97): custom (cc. 23–28, already
  encoded); dispensation only of merely ecclesiastical law (c. 85), never
  of what constitutes an institute or act (c. 86); divine law by no human
  authority.
- **Interpretation** (q. 96 a. 6). Authentic interpretation, with its
  reach: as law it binds generally; as a sentence or an administrative act
  in a particular matter it binds only that matter (c. 16 §§2–3). Proper
  meaning, then parallel places, purpose, and the mind of the legislator
  (c. 17). Strict interpretation of penal laws, laws restricting rights,
  and exceptions (c. 18). No obligation in a doubt of law (c. 14). In a
  lacuna, never in penal matters, analogy, general principles with
  equity, jurisprudence and the common opinion of the learned (c. 19);
  equity is input, never computed. Revocation not presumed; later laws
  harmonized with earlier (c. 21).
- **The mind of the legislator, by rank.** In doubt, a reading on which a
  law of the supreme legislator would contradict a higher law is
  excluded: his law is read in harmony with it. A lower legislator's law
  keeps that reading, and on it the law does not bind (c. 135 §2). Both
  are binary.

## METHOD

Encode the library and route the existing general norms (c. 16 §1,
c. 135 §2, the dates in force) through it. Add cc. 7–8, 14, 16 §§2–3,
17–21, 85–86, each under `% @norm` with its text from vatican.va. Where
the form of an act is disputed, branch (rule 2). New constructed cases
for G3–G7. Run the whole suite and the runtimes' boots.

## PREDICTIONS

- **G1.** Deriving the dates in force from promulgation and the vacatio
  (c. 8 §1: the 1983 Code, promulgated 25 January, in force 27 November
  1983; Book VI as revised, promulgated 1 June, in force 8 December 2021)
  changes no scenario.
- **G2. The reach of *Ecclesia Dei adflicta* (c. 16 §§2–3).** Its reading
  of c. 751 (a single act of disobedience "constitutes a schismatic act")
  is the legislator's own. Whether it was given in the form of law or as
  an act in a particular matter is disputed, and the checker branches on
  it.
  - As law, it binds generally, and nothing changes.
  - As an act in a particular matter, it reaches the 1988 consecrations
    only. For 2026, c. 751 has no authentic interpretation; its reading is
    a doubt of law; c. 14 and c. 18 take the strict reading for the penal
    effect. In that branch the 2026 title of c. 1364 for Bp Fellay is not
    derived (`title_not_derived`), and c. 1387 still reaches him as
    co-consecrator: SX22's result, without its switch.
  - With the 2026 decree approved by the Pope (SX13's switch, HYPOTHETICAL),
    the legislator's act in that particular matter binds it, and the
    title returns in every branch.
  - Every SX scenario gains the branch; none turns red. The ordered pair
    raises nothing: the theological classification of the act stands, and
    the penal law, read strictly, declines a title. Law answers no
    doctrinal question.
- **G3. The mind of the legislator, by rank.** A constructed law with a
  reading that contradicts divine law. Issued by the supreme legislator,
  that reading is excluded, with no branch. Issued by a bishop, the
  reading stays as a branch, and in it the law does not bind.
- **G4. Doubt of law and doubt of fact (c. 14).** A doubt of law removes
  the obligation, of an invalidating law too. A doubt of fact does not; it
  lets the ordinary dispense.
- **G5. The lacuna (c. 19).** In a non-penal matter the case takes an
  equitable rule only as input, and branches if the input is disputed. In
  a penal matter there is no penalty without a law (c. 19; c. 221 §3).
- **G6. Dispensation (cc. 85–86).** A merely ecclesiastical law is
  dispensed; a divine law, or an element that constitutes the act, is
  not, and the attempt is flagged.
- **G7.** A candidate rule that lets a law's validity settle whether it
  contradicts divine law is refused as `teaching_from_law` (rule 1).

### M: meta

- **M1.** The TTC-SCHOOLS tables and the TTC-ACT results do not change,
  except as G2 adds branches to the SX scenarios.
- **M2.** Every new rule has a test that fails without it; CL1 and PR4
  stay clean.

## CAVEATS

G2 concerns a real case and a contested question of form. The checker
does not decide the form; it computes both and says what follows from
each. Canonists may also dispute whether c. 751 is doubtful at all once
*Ecclesia Dei adflicta* is read as applying, not interpreting, it; that
reading is the first branch.

The library is Thomas's account of law. Suárez (*De legibus* I.5) and the
voluntarists place the essence of law in the will rather than the reason;
no canon here asks which, so the library states the interface, not a
school.

## STANDARDS

- Aquinas, ST I-II q. 90 aa. 1–4; q. 91; q. 93 a. 3; q. 95 a. 2; q. 96
  aa. 4, 6; q. 97 aa. 3–4
- CIC cc. 7, 8 §1, 14, 16, 17, 18, 19, 20, 21, 24 §1, 85, 86, 135 §2,
  221 §3, 751, 1364, 1387
- John Paul II, *Ecclesia Dei adflicta* (2 July 1988), nn. 3, 5
- Suárez, *De legibus* I.5

## SEE ALSO

[ttc-act(7)](act-preregistration.md),
[ttc-canon(5)](../canon-law-layer.md), [cases/sspx-2026.md](../cases/sspx-2026.md)

## SCORING

Appended after the runs.
