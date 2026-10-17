# TTC-DESCENT(7)

## NAME

**ttc-descent** — one root: original sin in the whole human race, in each
as his own, and the descent of all from Adam; predictions, committed
before encoding

## DESCRIPTION

Read as the rules stand (the base at `be1b999`, committed just before these
predictions):

- **The mode without the scope.** The kernel composes
  `contracts_original_sin/1` from `descends_from(P,adam)`: "by propagation,
  not by imitation" (Trent, sess. V, can. 3, DH 1513). It does not encode
  the scope, "into the whole human race" (can. 2, DH 1512), or "in each one
  as his own" (can. 3).
- **Silence.** A human being entered without descent contracts nothing,
  and nothing says so. A claim that some human beings are free of original
  sin, or descend from no Adam, has no slot: it is neither refused nor
  shown. Run on the base: `e1` typed from Adam contracts original sin;
  `f1`, untyped, contracts none; no violation, no frontier.
- **No source for the descent.** *Humani generis* 37 (DH 3897) is not on
  the authority graph. `empirica.l` cites *Humani generis* 36 (DH 3896)
  only.

## THE TEXTS

| Text | What it says |
| --- | --- |
| Trent, sess. V, can. 2 (1546), DH 1512 | Anathema to one who asserts that Adam "has only transfused death, and pains of the body, into the whole human race, but not sin also, which is the death of the soul" (Rom 5:12). |
| Trent, sess. V, can. 3, DH 1513 | Adam's sin, "which in its origin is one, and being transfused into all by propagation, not by imitation, is in each one as his own." |
| Trent, sess. V, decree, DH 1516 | "It is not its intention to include in this decree, where original sin is treated of, the blessed and immaculate Virgin Mary." |
| Pius XII, *Humani generis* 37 (1950), DH 3897 | The faithful cannot embrace the opinion that after Adam there were true men on this earth "qui non ab eodem prouti omnium protoparente, naturali generatione originem duxerint," or that Adam signifies a number of first parents, "cum nequaquam appareat quomodo huiusmodi sententia componi queat" with the doctrine of original sin. |

The texts are checked against vatican.va and the council's published text
when the rules are written, and quoted in their comments.

## PREDICTIONS

### DS: the scope (the deposit)

- **DS1.** A new slot, `free_of_original_sin/1`: a claim that a human
  being contracted no original sin. Said of a human being, it is refused in
  every branch (`original_sin_denied/1`), on DH 1512-1513. It is not
  refused of the incarnate (DH 301), nor of Mary, whom the decree does not
  include (DH 1516); on the branch of the Immaculate Conception she is
  preserved (DH 2803).
- **DS2.** Said of a group or a juridic person, the same claim is refused
  (`original_sin_of_fiction/1`): the sin is "in each one as his own" (DH
  1513). A people is entered by its members.
- **DS3.** Silence is kept. A human being typed without descent and
  without either claim stays silent: no rule derives the descent, or its
  denial, from a case's silence. No model of the base turns red.

### DD: the descent (the authority graph)

- **DD1.** A new slot, `denies_descent/2`: a claim that a human being does
  not descend from Adam by generation, for a reason: `many_first_parents`,
  `before_adam`, `separate_creation`.
- **DD2.** A new case part, `one_root`: `q(one_root)`, doctrinal, yes and
  no; *Humani generis* at tier 3 (an encyclical, ordinary form, 1950)
  supporting yes; `classification(q(one_root),human_race,from_one_adam)`.
  With it loaded, yes is settled and no is a live shadow of the encyclical.
- **DD3.** With `one_root` loaded, `denies_descent/2` of a human being is
  refused in the main branch only (`descent_denied/2`), as Trent's clause
  on Mary's venial sin refuses claims in the main branch only (CH2b).
  Without it, the claim is silent: a tier-3 teaching weighs only where its
  source is entered.
- **DD4.** Pushing against it is not heresy. With `one_root`, a
  profession of no on `q(one_root)` carries the note `authentic` and the
  censure `erroneous` in the main branch only, never `heretical`, and none
  in the shadow (`faith.l`, nn. 5, 6, 10). A doubt of it is not censured:
  doubt is typed with denial against de fide teaching only.

### DC: candidates

- **DC1.** `cand_branch_without_os` (HYPOTHETICAL): a people of two
  members, each claimed free of original sin and not from Adam
  (`separate_creation`), the people itself claimed free of it. With
  `one_root`: two `original_sin_denied` and one `original_sin_of_fiction`
  in every branch; two `descent_denied` in the main branch only.
- **DC2.** `cand_pre_adamite` (HYPOTHETICAL; La Peyrère, *Prae-Adamitae*,
  1655): human beings before Adam, `denies_descent(_,before_adam)`: refused
  in the main branch only, with `one_root`.
- **DC3.** With `creed`: `free_of_original_sin(son)` and
  `free_of_original_sin(mary)` are not refused, on any date; with `ic` and
  a date from 1854, Mary is preserved.

### M: meta

- **M1.** No expectation of the suite changes: no case uses the new slots.
- **M2.** Each rule has a test that fails without it (rule 5).
- **M3.** The guide's table "Persons and origin" gets the two slots;
  `guide.md` and `docs/encoding-guide.md` stay identical (rule 9).
- **M4.** Left unencoded, and named in BUGS: Acts 17:26 as a text of
  tier 0 with its readings; CCC 360; the discussion after 1950 of the
  force of "nequaquam appareat", carried only as the live shadow; Rom 5:12
  and its *in quo*.

## METHOD

Predictions committed and stamped first (rule 12). The scope goes in
`l/kernel_core.l` beside the propagation rule, the reservation of DH 1516
in the part `creed` of `l/kernel_world.l`, the fiction rule in `l/act.l`
beside `interior_of_fiction`, the case and the candidates in
`l/icon_history.l` and `l/kernel_world.l`; then `ttc-l build`, the tests,
the guide, and SCORING appended here.

## CAVEATS

Two silences differ. A case that types no descent says nothing, and the
base keeps that silence (DS3). A claim the base has no slot for is a
silent bug, which this step closes. A claim it can state and weighs only
at tier 3 is a writer's liberty, shown as a live shadow (DD2-DD4).

## SEE ALSO

[ttc-creed(7)](creed-preregistration.md) (EC1: the dogma in the economy),
[ttc-christ(7)](christ-preregistration.md) (CH2b),
[ttc-empirica(7)](empirica-preregistration.md) (*Humani generis* 36)
