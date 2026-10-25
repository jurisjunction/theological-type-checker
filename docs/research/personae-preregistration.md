# TTC-PERSONAE(7)

## NAME

**ttc-personae** — juridic persons (cc. 114–117, 1257 §2) and two duties
of clerics (cc. 285 §4, 286); predictions, committed before encoding on
`main`

## DESCRIPTION

Read as the rules stand at `72ab847` (`main`):

- **A juridic person is entered, never constituted.** `juridic_person/1` is
  a slot (cc. 113 §2, 114: "by law or decree, of the Church or of a civil
  order"). A juridic person is a fiction: it acts through those who
  represent it (c. 118), and an interior entered of it is refused
  (`interior_of_fiction`). No rule says what may become one, by what act,
  or what follows for its goods.
- **Nothing of a cleric's duties but his delicts.** `cleric/1` is a slot,
  derived from `priest/1` and `deacon/1`, and read only by c. 1398 §1 n. 1.
- **The machinery a reading needs is there.** `reading_option/2`,
  `needs_reading/2` and `read_for/3` (c. 17); `restricts_rights/1` and
  `narrower/2`, so that c. 18 keeps the narrower reading and reports the one
  it declines; `authentic_reading/3` closes the choice (c. 16). The gate of
  c. 1 is `not eastern_faithful(P)`.

The question that found this: software kept for church tribunals, whether
it could be held by a private juridic person, and whether a priest could sit
on the board of what holds it.

A first version was written on 25 October 2026 as a personal layer and run
there (`examples/ttc-home`, branch `juridic-persons`, `3002827`): with it
loaded, `ttc-suite` gave 726/726 once two rules were moved out of their
norms (CL1), and `pytest -q` 975 passed, 50 skipped. These predictions
follow that run and are not blind to it. What they stake is the encoding in
the base, in L, beside c. 1's gate, c. 113's fictions and the suite.

## THE TEXTS

| Text | What it says (vatican.va) |
| --- | --- |
| c. 114 §1 | Juridic persons are constituted by law or by special grant of competent authority by decree, aggregates of persons or of things ordered to an end congruent with the mission of the Church, "qui singulorum finem transcendit". |
| c. 114 §2 | Those ends are works of piety, of the apostolate, or of charity, spiritual or temporal. |
| c. 114 §3 | Competent authority confers personality only on aggregates with a truly useful end and, all things weighed, means foreseen to be sufficient. |
| c. 116 §2 | Private juridic persons obtain personality only through a special decree of competent authority expressly granting it. |
| c. 117 | No aggregate acquires juridic personality unless competent authority has approved its statutes. |
| c. 1257 §2 | The temporal goods of a private juridic person are governed by its own statutes, not by the canons of Book V unless they expressly say so. |
| c. 285 §4 | "Without the permission of their Ordinary, they may not undertake the administration of goods belonging to lay people or secular offices which involve the obligation to render an account." |
| c. 286 | "Clerics are forbidden to practise commerce or trade, either personally or through another, for their own or another's benefit, except with the permission of the lawful ecclesiastical authority." |

## PREDICTIONS

### JP: juridic persons

- **JP1.** Slots, on the canon side, entered and never derived:
  `aggregate(E,K)` (K `persons` or `things`, c. 115), `end_of(E,End)`,
  `end_kind(End,K)` (K `piety`, `apostolate`, `charity` or
  `gain_of_members`; a typing, entered), `distributes_gain(E)`,
  `judged_useful_and_sufficient(A,E)`, `statutes_approved(E,A)`,
  `decree_of_personality(D,A,E,Mode)` (Mode `express` or `tacit`),
  `competent_for(A,E)`, `civil_corporation(E)`.
- **JP2.** c. 114 §1, by the proper meaning of its words (c. 17): an
  aggregate whose surplus goes to its members, or whose end is typed
  `gain_of_members`, has their end. It is barred
  (`personality_barred(E,c114_1)`) whatever end its statutes state.
- **JP3.** c. 114 §2: an aggregate with no end of piety, the apostolate or
  charity is barred (`personality_barred(E,c114_2)`).
- **JP4.** c. 114 §3: the authority's judgment is supplied, never computed.
  No rule derives `judged_useful_and_sufficient/2`.
- **JP5.** cc. 116 §2, 117: an aggregate not barred becomes a private
  juridic person only with the judgment, approved statutes and an express
  decree, each from one authority entered as competent for it. Each lack is
  reported (`awaits(E, judgment_c114_3 | statutes_c117 | decree_c116_2)`).
  A tacit decree gives nothing.
- **JP6.** c. 1257 §2: the goods of a private juridic person are reported as
  governed by its statutes (`goods_governed_by_statutes/1`).
- **JP7.** A decree of personality for an aggregate that is barred is a
  violation (`personality_without_capacity(E,D)`).
- **JP8.** A private juridic person and a civil corporation are
  `juridic_person/1`: an interior entered of either is refused
  (`interior_of_fiction`), by the rule already there.

### OC: the offices and trade of clerics

- **OC1.** Slots, on the canon side, entered and never derived:
  `office(P,E,K)`, `entails_accounts(E,K)`, `civil_twin_of(E,J)` (E the
  civil corporation whose by-laws mirror the statutes of J),
  `trades_for_gain(E)`, `holds_shares(P,E)`, `licence(P,N,A)`. A licence is
  never derived, and nothing computes whether it should be given.
- **OC2.** c. 285 §4: a cleric's office that involves an account, in a
  civil corporation that is not the twin of a private juridic person, needs
  his Ordinary's permission on every reading
  (`permission_needed(P,c285_4,E)`); with a licence entered,
  `permission_held/3`.
- **OC3.** c. 285 §4 with cc. 17–18: in the civil twin of a private juridic
  person, "officia saecularia" is read two ways, by the office's civil form
  (`civil_form`) or by its substance (`by_substance`), the second narrower.
  c. 285 §4 restricts the free exercise of a right, so c. 18 keeps
  `by_substance`: the office is not reached (`not_reached(P,c285_4,E)`), and
  `declined_by_strict_interpretation(c285_4,civil_form,…)` is reported. An
  authentic reading entered for `civil_form` closes the choice the other
  way.
- **OC4.** c. 286 with cc. 17–18: one who governs a corporation that trades
  for gain practises its trade "per alios" (`governs_trade`), or the trade
  is the corporation's own (`own_trade`), the second narrower. c. 286
  restricts the free exercise of a right, so c. 18 keeps `own_trade`: not
  reached, `governs_trade` declined and reported. An authentic reading
  closes it.
- **OC5.** Holding shares is practising trade on neither reading. An office
  in a corporation that does not trade for gain is not reached by c. 286.
- **OC6.** c. 1: neither canon reaches a cleric of an Eastern Church *sui
  iuris* (`eastern_faithful/1`). The Eastern code's parallels are not
  encoded, and a frontier atom says so.

### CA: the case

- **CA1.** A new case, `personae`, marked HYPOTHETICAL, with neutral names:
  a civil corporation with share capital whose statutes state an end of the
  apostolate and whose surplus goes to its shareholders, trading for gain; an
  aggregate of things whose end is of the apostolate, distributing nothing,
  with a bishop competent for it; a civil corporation without share capital
  to carry it; a priest who directs both and holds shares in the first. No
  licence. Switches: `personae_erected` (the bishop judges, approves and
  decrees expressly, and the carrier becomes the aggregate's civil twin),
  `personae_decreed` (a decree for the first), `personae_eastern` (the
  priest ascribed to an Eastern Church *sui iuris*).
- **CA2.** The case alone: the first barred by c. 114 §1; the second
  awaiting all three acts; the Ordinary's permission needed for both
  offices; c. 286 reaching neither office nor the shares, with
  `governs_trade` declined.
- **CA3.** With `personae_erected`: the second a private juridic person, its
  goods governed by its statutes; the carrier's office not reached by
  c. 285 §4, `civil_form` declined; the first's office still needing
  permission.
- **CA4.** With `personae_decreed`: `personality_without_capacity` for the
  first.
- **CA5.** With `personae_eastern`: neither canon reaches the priest; the
  frontier atom of OC6.

### SU: the suite

- **SU1.** No expectation changes. The 726 scenarios pass with no output
  changed; the new ones pass.

### CL: the norm graph

- **CL1.** No vicious cycle and nothing undefined; PR4 clean. The rules
  that state where a reading decides (`needs_reading/2`) stand outside any
  norm, as in `canon_law.lp`.

### DG: the guide

- **DG1.** The guide's CANON table gains the slots of JP1 and OC1; both
  copies stay identical (rule 9).

No test is expected to go red.

## NOT IN THIS STEP

Public juridic persons (c. 116 §1), their goods as ecclesiastical goods
(c. 1257 §1) and Book V's controls on them. Associations of the faithful
(cc. 298–329), save as aggregates of persons; which authority is competent
(c. 312, c. 322 §1) is entered, not computed. The extinction of a juridic
person (c. 120). Any civil effect of canonical personality. The rest of
c. 285 (§§1–3; surety and promissory notes in §4), religious (c. 672), and
the Eastern code.

## SEE ALSO

docs/canon-law-layer.md, docs/research/law-preregistration.md,
docs/research/replies-preregistration.md.

## BUGS

The two readings of OC3 and OC4 are the encoder's; no commentator is
entered for either. Typing cc. 285 §4 and 286 as restricting the free
exercise of rights is itself a reading: without it, each branches, and on
the wider reading the permission is needed. That an end is of the
apostolate is a typing, entered. The judgment of c. 114 §3 is never
computed, and so a capable aggregate is never more than capable.
