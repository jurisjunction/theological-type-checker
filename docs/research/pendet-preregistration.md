# TTC-PENDET(7)

## NAME

**ttc-pendet**: a term lifted above an order, reached by every node of it
and no node of it; room for one; a measure that changes where one stands
and not what one reaches; the law hanging on its end. Predictions,
committed before encoding.

## DESCRIPTION

Read as the rules stand at `72ab847` (`main`):

- **The base refuses one relation in pieces.** A word given a date
  (`word_dated`) or made a tongue's parent (`word_as_root`, TTC-LINGUAE
  LW4), and God given a level (`god_inside_level_order`, A11) or set at
  the apex of the order (`cand_apex`), are refused one by one. Each
  protects the same relation: a term that every node of an order is
  referred to, and that is no node of it. Thomas states it of analogy:
  what is said of many is said "per respectum ad unum", and that one
  "oportet quod ponatur in definitione omnium" (I q. 13 a. 6), and of the
  law: its precepts "sunt unum secundum ordinem ad unum finem, sunt tamen
  multa" (I-II q. 99 a. 1). Nothing in the base names the relation, so
  nothing can say that two terms claim it at once.
- **A substitution is refused only by its role.** TTC-LOCI lowers money
  put in God's place onto `last_end/1`, and refuses it there. It does not
  see that the place had an occupant: that the order of ends now has two
  terms above it.
- **A measure is not in the base.** TTC-LINGUAE computes a rendering's
  mode from its descent (`renders/2`, `made_from/2`). A text taken as the
  measure of an older one, as a person may take the tongue he prays in,
  can be entered only as a descent, which LW3 refuses when the dates run
  backwards. And an analogy is looked up only in the direction it was
  declared (`analogous/4`), so reversing a pair turns it equivocal.
- **"Hang" has no case.** "In his duobus mandatis universa lex pendet et
  prophetae" (Mt 22:40) is read by Augustine as reference to an end, and
  by the homily as a summary (Rom 13:9). Neither is typed, and so neither
  can be traced.

The discussion that found this: a dialogue on Matthew 22:34–40 whose map
of essays lifts one essay above its fields, filed in none and reaching
all, and a reading of Eucharistic Prayer IV with the English as the
measure.

The proposal:

- One relation, `lifted/2`: the word above the tongues, God above the
  levels and the ends. Derived, never entered. The existing refusals are
  reported as its instances.
- Room for one: a second term put in the lifted place of an order is
  refused.
- A measure, `measured_by/3`, beside descent: it changes which way loss
  and gain run, never a mode. In an analogy of attribution the prior as
  to the thing stays prior whoever measures; what changes is the prior as
  to us (ST I q. 13 a. 6).
- A case, `pendet`: Mt 22:40, "hang" read as end and as summary, run over
  TTC-MODERNITY's horizons.

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited.

## THE TEXTS

The evidence record is `docs/research/pendet-sources.md`. The loci that
decide the encoding:

| Text | Holds | Locus |
| --- | --- | --- |
| Matthew | "in his duobus mandatis universa lex pendet et prophetae"; κρέμαται; "On these two commandments hang all the law and the prophets" | Mt 22:40, Clementine, Greek, KJV [V] |
| Augustine, through the Catena | "'Hang,' that is, refer thither as their end" | *Quaest. Evang.* I.33, in the Catena on Mt 22:40, Oxford translation (1842) [V, English; Latin M] |
| Raban, through the Catena | "the commandments of the first table to the love of God, those of the second to the love of our neighbour" | Catena on Mt 22:40 [V, English] |
| Pseudo-Chrysostom, through the Catena | "who loves man is as who loves God; for man is God's image ... as a King is honoured in his statue" | Catena on Mt 22:39 [V, English] |
| Romans | "in hoc verbo instauratur" (Clementine), "recapitulatur" (Nova Vulgata); ἀνακεφαλαιοῦται; "plenitudo ergo legis est dilectio" | Rom 13:9–10 [V] |
| Thomas, the law | "omnia praecepta legis veteris sunt unum secundum ordinem ad unum finem, sunt tamen multa"; ad 2: "finis praecepti caritas est", "et ideo tota lex impletur in hoc uno mandato" | I-II q. 99 a. 1 and ad 2 [V] |
| Thomas, charity | "finis praecepti est caritas"; "omnia praecepta Decalogi ordinantur ad dilectionem Dei et proximi"; a. 3 s.c. cites Mt 22:40 | II-II q. 44 a. 1 and ad 3, a. 3 [V] |
| Thomas, analogy | "vel ex eo quod unum habet proportionem ad alterum ... et hoc modo aliqua dicuntur de Deo et creaturis analogice"; "per respectum ad unum", which "oportet quod ponatur in definitione omnium"; "quantum ad rem significatam ... per prius dicuntur de Deo", "quantum ad impositionem nominis, per prius a nobis imponuntur creaturis" | I q. 13 aa. 5–6 [V]; SCG I.34 [V] |
| Thomas, law | law "quaedam rationis ordinatio ad bonum commune" | I-II q. 90 a. 4 [M] |
| Hobbes | "Law in generall, is not Counsell, but Command" | *Leviathan* 26 (1651) [V] |

## THE DESIGN

### Lifted (`pendet.l`)

- **The relation.** `lifted(X, O)`: X is lifted above the order O. Sort
  `order` {tongues, levels, ends}. Derived only:
  - every word is lifted above the tongues (TTC-LINGUAE: the word outside
    time, owned by no tongue);
  - God is lifted above the levels (A11) and above the ends (*Benedictus
    Deus*, as TTC-LOCI enters it).
  A case that writes `lifted/2` is refused at the gate, as a derived
  result is.
- **Never filed.** `info(lifted_filed(X, O, V))`: a lifted term entered as
  a node of its order, reported beside the base's own refusal V of it
  (`word_dated`, `word_as_root`, `god_inside_level_order`). The refusals
  stay as they are; the report names the one relation they protect.
- **Room for one.** `violation(two_lifted(O, Y, X))`: a substitution
  (TTC-LOCI) puts X in the place of Y, where Y is lifted above O. The role
  says the order: `giver_of_being` the levels, `last_end` the ends.

### The measure (`linguae.l`)

- **The slot.** `measured_by(F1, F2, C)`: C takes the form F2 as the
  measure of F1. It is no descent: no `made_from/2` follows from it, and
  LW3 does not see it.
- **What it computes.** Under a measure, F1 is read as given for F2: its
  mode, its readings closed and opened, its interpretations. The
  measure's admitted readings count as its host readings, and the measured
  form's host readings as what it admits, so that a pair can be read either
  way. Carriage (`carries/3`) follows descent only, and a measure carries
  nothing.
- **An analogy either way.** Under a measure an analogy is found whichever
  of its two words the measure has (`analogous/4` read in both
  directions). The word declared prior stays prior as to the thing,
  `info(prius_rei(F1, F2, W))`; the measure's own word is prior as to us,
  `info(prius_nobis(F1, F2, W))`, for that is where the name was first
  imposed (I q. 13 a. 6).

### The case (`icon_history.l`, `pendet`)

Real texts; every typing is an interpretive fact, entered and open to
dispute.

- **Two questions.** `q(law_hangs)`: the law and the prophets hang on the
  two commandments (yes). `q(precepts_bind)`: the precepts bind (yes).
- **Mt 22:40** (tier 0), ambiguous, two readings, both yes on
  `q(law_hangs)`: `r_end` (Augustine: "hang", that is, "refer thither as
  their end") and `r_summary` (summed up, as Rom 13:9). Its two arguments:
  `mt_end`, (final, god_ethics); `mt_summary`, (formal, will), the
  precepts as contained in the object of love.
- **The readings are not exclusive.** In I-II q. 99 a. 1 the summary is
  the objection (Rom 13:9, "instauratur") and the reply grounds it in the
  end: "finis praecepti caritas est", "et ideo tota lex impletur in hoc uno
  mandato". So a sibling case, `pendet_thomas`, types both summary
  arguments by the object and the end together, (formal, will) and (final,
  god_ethics), as Thomas reads them. A further reading only adds
  availability (TTC-MODERNITY, CV4), so a reading that adds a premise is a
  sibling case, not a switch.
- **The other arguments for `q(law_hangs)`:**

  | Argument | Source | Argues from |
  | --- | --- | --- |
  | `aug_end` | Augustine, *Quaest. Evang.* I.33, through the Catena | (final, god_ethics) |
  | `raban_tables` | Raban, through the Catena: the two tables to the two loves | (formal, will) |
  | `pschrys_image` | Pseudo-Chrysostom, through the Catena: man God's image, "as a King is honoured in his statue" | (formal, human) |
  | `th_finis` | ST I-II q. 99 a. 1 and ad 2; II-II q. 44 aa. 1, 3: "finis praecepti caritas" | (final, god_ethics) |
  | `rom_summary` | Rom 13:9 (tier 0, with its readings) | (formal, will) |

- **For `q(precepts_bind)`:** `th_ordinatio` (I-II q. 90 a. 4: an
  ordinance of reason for the common good), (final, human); `hobbes_l26`
  (*Leviathan* 26: "Law in generall, is not Counsell, but Command"),
  (efficient, will).

## PREDICTIONS

### LF: lifted

- **LF1.** On every runtime, `lifted(W, tongues)` for every word a loaded
  case names, and `lifted(G, levels)`, `lifted(G, ends)` for God. A
  snippet writing `lifted/2` is refused at the gate.
- **LF2.** Every model in which `word_dated`, `word_as_root` or
  `god_inside_level_order` fires gains one `lifted_filed` per atom, naming
  it (WO1, WO4, X8 and the language test that dates two words among
  them). Nothing else in any earlier scenario changes (every scenario's
  atoms compared, in every model).
- **LF3.** Room for one, on every runtime: `loci_mammon` gains
  `two_lifted(ends, god, money)`; `loci_spinoza` gains
  `two_lifted(levels, god, natura)` on reading A and nothing on B;
  `loci_icon` and `loci_adams` gain nothing (latria is no order here).
- **LF4.** No runtime, alone or on the property case, gives `lifted_filed`
  or `two_lifted`.

### MS: the measure

- **MS1.** A measure implies no descent: `measured_by` with the dates
  reversed raises no `made_before_parent`.
- **MS2.** For every rendering pair of the base's language cases (RN 9,
  CCC 2483, *pro multis*, "we baptize"), in every branch, the host
  measured by its rendering gives the same mode as the rendering given
  for the host; `closes` and `opens` trade places, pair by pair; and no
  premise is carried by the measure.
- **MS3.** *Prior as to the thing.* Every analogy of attribution in those
  cases (RN 9's "personality" for *personae*, under both lexicons of 1891;
  "happiness" for *perficiendam*) stays an analogy of attribution under the
  reversed measure. `prius_rei` names the same word either way, the
  Latin's; `prius_nobis` names the measure's word. The analogy is "unius ad
  alterum", one to another, not two to a third (I q. 13 a. 5; SCG I.34),
  and "ordo nominis sequitur ordinem cognitionis".

### PE: the case

- **PE1.** Authority reads no argument: on every runtime `q(law_hangs)`
  and `q(precepts_bind)` hold yes, settled, with no `holds/2` changing
  between runtimes.
- **PE2.** By report:

  | Runtimes | Reports |
  | --- | --- |
  | the four schools, `default`, `saussure`, `vocal`, `lingual`, `scotus_dpp`, `hooker`, `suarez_dm23`, `suarez_wl`, `descartes`, `grotius`, `leibniz`, `leibniz_wl`, `bacon`, `episcopate_1891`, `social_catholic`, `angers` | nothing |
  | `locke`, `locke_wl`, `smith`, `george`, `george_hn`, `ockham`, `ockham_will`, `ockham_nominal`, the will readings | `sole_reason(mt22_40, mt_end, …)`: the law hangs only as on an end |
  | `marx`, `marx_social`, `lassalle`, `grotius_etiamsi` | `sole_reason(mt22_40, mt_summary, …)`: only as a summary |
  | `hobbes`, `hobbes_wl`, `spinoza`, `spinoza_wl`, `kant`, `kant_humanity`, `kant_mm`, `bare` | `without_reason(q(law_hangs), yes)`, while `q(precepts_bind)` keeps a reason, the command |

  The last row is "nothing but the clock": the precepts bind, and hang on
  nothing.
- **PE3.** Over `horizons_all`, the order parameters are exactly
  `ends_by_god_ethics`, `soul_as_form` and `object_as_form`, and there are
  four phases: an eighth of the horizons hang the law on nothing, a
  quarter only as summary, a quarter only as end, and three eighths
  report nothing.
- **PE4.** On `pendet_thomas`, the summary-only row is gone. `marx`,
  `marx_social`, `lassalle` and `grotius_etiamsi` report nothing: none of
  Mt 22:40's arguments is available to them, and the law hangs there on
  Raban's two tables alone. Every other row is as PE2. The order
  parameters are the same three, and there are three phases: an eighth
  hang the law on nothing, a quarter only as end, five eighths report
  nothing.

### SU: the suite

- **SU1.** No expectation changes but LF2's. CL1 and PR4 stay clean:
  Mt 22:40 and Rom 13:9 enter with their readings.
- **SU2.** Every new rule and slot has a test that fails without it. The
  guide, both copies, gains the vocabulary identically.

## CAVEATS

- **Being reached is not computed.** A horizon that traces the ends still
  stands under them. The checker computes what a horizon can follow,
  never whether it is reached: that is not a horizon's to see, nor the
  checker's to compute.
- **Lifted is not apex.** The relation is no rank. A term at the top of an
  order is in it, and A11 refuses that of God. The lifted term is above
  the order and no part of it, so it can reach every node without a cycle.
  Thomas has two measures: the first of a genus, which is a member of what
  it measures (I-II q. 90 a. 1), and God, "not a measure proportionate to
  anything" (I q. 3 a. 5 ad 2). The lifted term is the second.
- **Nothing is lifted above God.** God and creatures are named "unius ad
  alterum", never as two referred to a third prior to both (SCG I.34).
  That is Thomas's reading, not the deposit's, and it touches a school
  question (Scotus's univocity of the concept of being), so this step
  enters no refusal for it.
- **The measure is where one stands.** It changes the order of naming,
  never the order of the thing (I q. 13 a. 6). A measure is a claim with
  its claimant, of a regime, a lexicon or a profession. It is never a
  hearing, and TTC-PROFESSIO's guard stands.
- **"Attribution" is Cajetan's word**, not Thomas's. The base's sort
  `akind` keeps it, as the school does; the texts this step rests on are
  Thomas's own (I q. 13 aa. 5–6).
- **Nothing reported is not everything followed.** Where a source loses
  all its arguments and the value keeps a reason from others, no report
  fires (PE4). The checker says what a horizon cannot follow only where a
  value or a source is left with nothing, or with one.
- **The typings of "hang" are the interpretation.** Augustine's "end" is
  typed by God's ends for action, the homily's "summary" by the object of
  love. The inherited values of the horizons on the object (TTC-MODERNITY's
  caveat) decide the summary row: Marx and Lassalle follow the summary only
  by an inheritance nobody has examined.

## SEE ALSO

[ttc-loci(7)](loci-preregistration.md), [ttc-linguae(7)](linguae-preregistration.md),
[ttc-modernity(7)](modernity-preregistration.md), [ttc-professio(7)](professio-preregistration.md)
