# TTC-SIMILITUDE(7)

## NAME

**ttc-similitude** — law said by analogy and by similitude: the eternal law
as a bridge, two modes of providence at tier 3, and the word for law in
things without reason; predictions, committed before encoding

## DESCRIPTION

Read as the rules stand (the base at `2fd33bc`, committed just before these
predictions):

- **No bridge for law.** The kernel lets a perfection cross the
  Creator-creature line only through a declared bridge (`bridge/3`,
  `mode/3`; ST I q. 13 a. 6), and refuses a deontic mode on the divine
  side (`deontic_in_god`). The bridges are the kernel's three (creation,
  origination, acyclicity) and, where the Grammar of the Icon is loaded,
  its two (principle, grain). Law is not one of them. The eternal law is
  only a kind of law in the law library, ranked 4 (`kind_rank/2`).
- **A reach is read the same of anything.** `binds_on/2` reads a law's
  reach (`reaches/3`) whether it reaches a person, an act or a thing. The
  base reports a church "bound by" a diocesan law (LW11). No slot says
  that a law lays an obligation on X, and no rule reads the grades of
  `kernel_world.l` (what merely is, what lives, the created person, the
  angel) against a law.
- **No mode of providence.** No slot says that a human being is moved only
  through the laws of physical nature, or that a thing without reason is
  provided for through reason. *Veritatis splendor* 43 is not on the
  authority graph.
- **No word for law in things.** A "law of nature" said of a stone has no
  slot, and the runtimes say nothing of it.

This file was committed and stamped before any of it was encoded. SCORING
will be appended below; nothing above it will be edited.

## THE TEXTS

| Text | What it says |
| --- | --- |
| ST I q. 13 a. 6 | Names said of God and of creatures are said first of God in the order of being, first of creatures in the order of knowing. |
| ST I q. 22 a. 2 | All things are subject to divine providence. |
| ST I-II q. 90 a. 1 | Law is "regula et mensura actuum", a rule and measure of acts. |
| ST I-II q. 91 aa. 1-2 | The whole community of the universe is governed by the divine reason: the eternal law. All things share in it, deriving their inclinations from its impression; the rational creature "in the most excellent way", and its share is the natural law. Ad 3: the irrational creature does not share in it rationally, "unde non potest dici lex nisi per similitudinem". |
| ST I-II q. 93 a. 1 | The eternal law is "the type of Divine Wisdom, as directing all actions and movements". |
| ST I-II q. 93 a. 4 | What pertains to the divine nature is not subject to the eternal law but is "the eternal law itself". |
| ST I-II q. 93 a. 5 | Irrational creatures are subject to the eternal law "through being moved by Divine providence", not by understanding a precept. |
| Second Vatican Council, *Dignitatis humanae* 3 (7 December 1965), declaration | The highest norm of human life is the divine law, eternal, objective and universal, by which God orders, directs and governs the universe; man is made to share in it. |
| John Paul II, *Veritatis splendor* 43 (6 August 1993), encyclical | Quoting *Dignitatis humanae* 3: the law "by which God out of his wisdom and love arranges, directs and governs the whole world". "God provides for man differently from the way in which he provides for beings which are not persons": not "from without", through the laws of physical nature, but "from within", through reason. Then ST I-II q. 91 a. 2 on the rational creature. |
| Suárez, *De legibus* (1612) I.1 | Thomas's definition (q. 90 a. 1) is too broad: it reaches creatures without reason (n. 1). Law is said of them only by metaphor (n. 2). Law properly is a measure of the moral acts of rational creatures, and is said univocally (n. 6). |
| Laplace, *Essai philosophique sur les probabilités* (1814) | The present state of the universe is the effect of its prior state and the cause of the next; an intelligence knowing every force and position would hold the motions of the greatest bodies and of the lightest atom in one formula. |

The texts are checked against vatican.va and the published editions when
the rules are written, and quoted in their comments.

## PREDICTIONS

### SB: law said by analogy (the kernel)

- **SB1.** A new kernel bridge, `bridge(law,div,cr)`, withdrawn by
  `drop_bridge(law)` as the others are. Its divine mode is
  `ratio_of_governance` (q. 93 a. 1; what is divine is the eternal law, not
  under it, q. 93 a. 4); its creaturely mode is `participated` (q. 91
  a. 2). It is never `norm` on the divine side. On the base,
  `licensed(law,div)` and `licensed(law,cr)`, and no violation in any
  model.
- **SB2.** A candidate typing the eternal law a norm over God
  (`cand_law_over_god`, HYPOTHETICAL; the objections of q. 93 a. 4):
  `mode(law,div,norm)` is refused as `deontic_in_god(law)` in every branch,
  with no source loaded. The kernel's rule does it already; the step adds
  the candidate and its test.
- **SB3.** TH8 (Th. 22, bridges read in the order of knowing) stays green,
  and its output reads "6 projections, 6 bridges" for "5 projections, 5
  bridges". Observed before these predictions were written (CAVEATS).

### SP: two modes of providence (the law library; tier 3)

God is above every norm (the kernel, in every branch: SB2); matter is below
obligation (SP3, in the main branch); law is properly in the created person
(SP4).

- **SP1.** A new case part, `two_modes`: `q(two_modes)`, doctrinal, yes and
  no; *Veritatis splendor* 43 at tier 3 (an encyclical, ordinary form,
  1993) supporting yes; the classification of `providence` as
  `persons_from_within` under it. With it loaded, yes is settled and no is
  a live shadow, reintegrated by `veritatis_splendor_43`. *Dignitatis humanae* 3
  is not entered: the encyclical quotes it for the law that governs the
  whole world, not for the two modes, and entered with `cites/2` and no
  source of its own it would be a frontier item (PR4).
- **SP2.** Three new slots. `lays_obligation(L,X)`: a claim that the law L
  lays an obligation on X. `only_from_without(X,R)`: a claim that X is
  moved only through the laws of physical nature, for the reason R
  (`determinism`; an open sort). `from_within_by_reason(X)`: a claim that X
  is provided for from within, through reason. Without `two_modes`, each is
  silent.
- **SP3.** With `two_modes`, `lays_obligation(L,X)` of a creature that is
  not a person (inanimate, or an organism) is refused in the main branch
  only (`obligation_below_reason(L,X)`), and so is
  `from_within_by_reason(X)` of one (`non_person_from_within(X)`). Neither
  is refused in the shadow.
- **SP4.** With `two_modes`, `only_from_without(X,R)` of a created person is
  refused in the main branch only (`person_only_from_without(X,R)`). Of a
  creature that is not a person it is never refused: that is the lower
  mode itself. `lays_obligation/2` and `from_within_by_reason/1` of a
  created person are never refused.
- **SP5.** Silence is kept. `lays_obligation/2` is not refused of
  something the case gives no grade, of a group or a juridic person (a
  subject of obligations, c. 113 §2), or of God (BUGS). No rule reads a
  grade from a case's silence.
- **SP6.** A reach is not an obligation. No rule derives
  `lays_obligation/2` from `reaches/3` or `binds_on/2`: reaching a thing is
  not obliging it; a law binds persons concerning things. The reaches of
  things and acts already in `canon_cases.l` and `canon_law.l` (the church
  and the Masses of LW11 and LW13, the contracts of LW4, the acts of
  WB1-WB3, the situations of c. 915) are unchanged, and
  `info(obliged(church_a,l_fixed))` stays. None of them has a grade.
- **SP7.** Candidates. `cand_obligation_on_things` (HYPOTHETICAL): a law
  laying an obligation on an inanimate thing, an organism and a human
  being: two `obligation_below_reason` in the main branch only, none of the
  human being. `cand_laplace` (HYPOTHETICAL; Laplace, 1814): a human being
  and a stone, each claimed moved only through physical law, for
  `determinism`: `person_only_from_without` of the human being in the main
  branch only; nothing of the stone.

### SW: the word for law in things (the runtimes; reported, never refused)

- **SW1.** A new slot, `law_said_of(L,X)`: X said to be under L in the
  descriptive sense, a law of nature. It is never refused, on any runtime
  or branch, with `two_modes` or without, of a human being as of a stone:
  a law of nature in the body is not "only from without".
- **SW2.** Under `rt_thomist` it is reported as law by similitude,
  `info(law_by_similitude(L,X))` (q. 91 a. 2 ad 3; q. 93 a. 5). Under
  `rt_suarezian`, as metaphor, `info(law_by_metaphor(L,X))` (*De legibus*
  I.1 nn. 1-2, 6). Under the default, bare, Scotist and Palamite runtimes,
  neither. With both runtimes loaded, both reports, and no violation.
- **SW3.** Here the two runtimes disagree, and nowhere else in this step:
  on SB, SP and SH, `rt_thomist` and `rt_suarezian` give the violations the
  default gives. The TTC-SCHOOLS tables (`tests/test_schools.py`: the
  boots, the pairs, `THEORY_RED`) do not change: a report is not a
  violation, and the new group is left out of the stamped boot set, as
  every group written after it is.

### SH: a "within" ascribed to all matter (HYPOTHETICAL, tier 5)

- **SH1.** `cand_within_of_matter` (HYPOTHETICAL; a constructed text
  standing for panpsychism in general): a source at tier 5, ambiguous,
  with two readings of a "within" ascribed to all matter (an inanimate
  `matter_h`). Read as `interiority`, the share in being every creature has
  (the kernel's `creation` bridge, mode `received`), it claims nothing the
  base refuses. Read as `reason_within`, providence from within, through
  reason, given to matter, it enters `from_within_by_reason(matter_h)`. The
  text holds no value on `q(two_modes)` and cleaves nothing.
- **SH2.** With `two_modes`: four branches, two values by two readings.
  `non_person_from_within(matter_h)` in exactly one, the main branch read
  as `reason_within`. `interiority` stands on every branch;
  `reason_within` stands on the live shadow.
- **SH3.** Without `two_modes`: two branches, one per reading, both clean.

### M: meta

- **M1.** No expectation of the suite changes. TH8's output changes as
  already observed (SB3). The TTC-SCHOOLS tables pass unchanged (SW3).
- **M2.** Every new rule has a test that fails without it (rule 5); CL1 and
  PR4 stay clean.
- **M3.** The guide gets the four slots beside `law_kind/2` and
  `reaches/3`; `guide.md` and `docs/encoding-guide.md` stay identical
  (rule 9).
- **M4.** Left unencoded, and named in BUGS: an obligation laid on God;
  *Dignitatis humanae* 3 on the graph; a profession against
  `q(two_modes)`.

## METHOD

Predictions committed and stamped first (rule 12). The bridge in
`l/kernel_analogy.l`, beside the others; `cand_law_over_god` in
`l/kernel_world.l`, beside `cand_univocal_acyclicity`. The three claims and
their rules in `l/law.l`, which reads `of_kind/2` as `empirica.l` does for
`one_root`. The part `two_modes` and its candidates in `l/icon_history.l`,
beside `one_root`. The two words as switches in `l/schools.l`, added to the
runtimes `thomist` and `suarezian`. Then `ttc-l build`; a group
`similitude` in `suite.py` with the ids above, left out of
`schools.boot_set`; the guide; and SCORING appended here.

## BUGS

- `lays_obligation/2` said of God is not refused (SP5). The kernel refuses
  a deontic mode on the divine side, not a claim; q. 93 a. 4 would refuse
  both.
- One creaturely mode, `participated`, covers both the rational share that
  is law properly (q. 91 a. 2) and the impressed inclination that is law
  by similitude (ad 3). The bridge does not tell them apart; the slots (SP)
  and the runtimes' words (SW) do.
- `obliged/2` says "{X} is bound by {L}" of a church and of Masses (LW11,
  LW13). Read with SP6, a law binds persons concerning things and acts.
  The wording stays; no computation turns on it.
- A profession of no on `q(two_modes)` would be noted by `faith.l` as DD4
  notes one on `q(one_root)`; no scenario tries it. *Dignitatis humanae* 3
  is not on the graph. The reasons of `only_from_without/2` are an open
  sort.

## CAVEATS

SB is not blind. The bridge was tried with the fix method on 21 October
2026, before these predictions were written. Verdict: "no loss"; 583
tests, none newly failing, none newly passing; one output changed, TH8,
from "5 projections, 5 bridges" to "6 projections, 6 bridges" (TH8 reads
every bridge in the order of knowing: `th22` with
`bridges_as_order_of_knowing`; ST I q. 13 a. 6 reads them in the order of
being). SB1 and SB3 report that run. SB2 and the rest are blind.

*Veritatis splendor* 43 speaks of man. The rules read its ground, the
person set against "beings which are not persons", and so reach the angel,
Thomas's rational creature too (q. 91 a. 2). No scenario tries an angel.

Without the part, an obligation laid on a stone is silent, though Thomas's
account (q. 91 a. 2 ad 3; q. 93 a. 5), not entered here, would refuse it. A
teaching weighs only where its source is entered (TTC-DESCENT DD3).

Laplace's text speaks of the whole state of the universe, not of man by
name. The candidate applies it to a human being; it is HYPOTHETICAL.

Thomas's "per similitudinem" and Suárez's "metaphor" may name one
judgment. Suárez's quarrel is with the breadth of q. 90 a. 1, a rule and
measure of acts, which reaches beings without reason (*De legibus* I.1
n. 1). The checker reports each school's word and weighs neither.

The text of SH is constructed. It stands for a family of positions; no
author's text is read, and none is refused.

## STANDARDS

- Aquinas, ST I q. 13 a. 6; q. 22 a. 2; I-II q. 90 a. 1; q. 91 aa. 1-2;
  q. 93 aa. 1, 4, 5
- Second Vatican Council, *Dignitatis humanae* (7 December 1965) 3
- John Paul II, *Veritatis splendor* (6 August 1993) 43
- Suárez, *De legibus ac Deo legislatore* (1612) I.1 nn. 1-2, 6
- Laplace, *Essai philosophique sur les probabilités* (1814)
- CIC c. 113 §2

## SEE ALSO

[ttc-law(7)](law-preregistration.md) (the order of laws),
[ttc-descent(7)](descent-preregistration.md) (DD2-DD3: a teaching of tier 3
entered as a question with a part),
[ttc-thomism(7)](thomism-preregistration.md) (P10, TH8),
[ttc-schools(7)](schools-preregistration.md) (the runtimes)

## SCORING

Appended after the runs.
