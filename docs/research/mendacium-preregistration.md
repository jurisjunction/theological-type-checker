# TTC-MENDACIUM(7)

## NAME

**ttc-mendacium**: lying, the first case whose report depends on the form
of the law; Augustine, Thomas, Kant's three works, the Catechism, Grotius,
Constant and Hobbes, each argument typed by the causes it rests on, over
every runtime and every horizon; two readings, Augustine's words as given
signs and Kant's humanity as an end; the bridge, and the runtime that can
carry Kant's Doctrine of Virtue both ways. Predictions, committed before
encoding.

## DESCRIPTION

Read as the rules stand at `66b90e6` (`main`, TTC-VERBUM encoded and
scored). If `main`'s rules differ from these when encoding begins, the
difference is stated in SCORING.

- **The form of the law has decided nothing.** `form_of_law`, (formal,
  reason), is the one part modernity adds rather than traces
  (TTC-MODERNITY). `kant`, `kant_humanity` and `kant_mm` hold it, and no
  argument of any case rests on it. On the property case the two forms are
  idle (PR8), and `kant` falls in Hobbes's group; on `pendet` it hangs the
  law on nothing, as Hobbes does. Over `horizons_all`, the three cases that
  type arguments by the causes (`modernity_property`, `pendet`, `soap`)
  have eight order parameters between them, never `form_of_law` or
  `self_preservation`, and put `kant` and `kant_mm` in one phase with
  `hobbes`, `hobbes_wl`, `spinoza` and `spinoza_wl`.
- **PH3 is owed.** TTC-MODERNITY committed every case added to its study,
  lying among them, to a phase diagram predicted in its own preregistration,
  "once its typing is settled and before stamping", and named Kant's
  arguments on lying as the place the form of the law enters.
- **Lying has no case.** CCC 2483's clause on the hearer's right is in
  `linguae_ccc2483` as encodings and a question,
  `q(lie_needs_right_hearer)`, with no argument. The record for lying that
  `linguae-sources.md` cites, `cases-usury-lying.md`, was never committed.
- **`kant_mm` is a reading no case reads.** Its warrant is the Doctrine of
  Virtue's appeal to an end of nature. Its article on lying makes that
  appeal in the passage that calls the lie the throwing away of human
  dignity (TL §9, 6:429): an end of nature and the humanity in one's
  person, side by side.

The discussion that found this: what a phase diagram of modernity over
the ten cause parts would need. A case for the form of the law came first.

The proposal:

- **A case, `mendacium`.** One question, whether every lie is wrong;
  nine sources at their tiers; sixteen arguments, each typed by the causes
  it rests on (TTC-MODERNITY, CV).
- **Two readings,** as switches of the case: `ench22_as_given`, Augustine's
  instituted words read by his own account of the given sign;
  `humanity_as_end`, Kant's humanity read as a final end, the reading
  `kant_humanity` makes of the runtime, here made of the arguments.
- **No rule, slot, runtime or part is added.**

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited.

## THE TEXTS

The evidence record is `docs/research/mendacium-sources.md`. The loci
that decide the encoding:

| Text | Holds | Locus |
| --- | --- | --- |
| Augustine | "uerba propterea sunt instituta non per quae inuicem se homines fallant sed per quae in alterius quisque notitiam cogitationes suas perferat"; theft to give to the poor; Mt 5:37 to "the heirs of the new covenant" | *Enchiridion* 7.22 (c. 421), CCSL 46 [V]; NPNF [V] |
| Augustine | of the given sign, "Nec ulla causa est nobis significandi … nisi ad … traiciendum in alterius animum id quod animo gerit qui signum dat" | *De doctrina christiana* II.2.3 [V, through the SEP] |
| Thomas | "Mendacium autem est malum ex genere. Est enim actus cadens super indebitam materiam: cum enim voces sint signa naturaliter intellectuum, innaturale est et indebitum" | ST II-II q. 110 a. 3 [V, through Casey, whose copy reads "intellectum"] |
| Thomas | "it is not lawful to tell a lie in order to deliver another from any danger whatever" | a. 3 ad 4 [V] |
| Kant | the universal law of false promising "würde das Versprechen und den Zweck … selbst unmöglich machen" | G 4:422 [V] |
| Kant | the one deceived "cannot possibly agree to my way of behaving toward him" | G 4:429–430 [V, English] |
| Kant | "Wegwerfung und gleichsam Vernichtung seiner Menschenwürde"; "ein der natürlichen Zweckmäßigkeit seines Vermögens der Mitteilung seiner Gedanken gerade entgegengesetzter Zweck" | TL §9, 6:429 [V] |
| Kant | "formale Pflicht des Menschen gegen Jeden"; the lie harms "der Menschheit überhaupt, indem sie die Rechtsquelle unbrauchbar macht" | VRML (1797), 8:426 [V; the second's line M] |
| Catechism | "The Lord denounces lying as the work of the devil"; "the purpose of speech is to communicate known truth to others"; "Lying is destructive of society" | CCC 2482, 2485, 2486, both editions [V] |
| Grotius | the form of the illicit lie, none "praeter repugnantiam cum iure existente ac manente eius ad quem sermo aut nota dirigitur"; the right, "iudicandi libertas", owed "quasi pacto quodam tacito" | DIBP III.1.11 (1625) [V] |
| Constant | the duty to tell the truth, taken absolutely, "rendrait toute société impossible"; "Là où il n'y a pas de droits, il n'y a pas de devoirs" | *Des réactions politiques* VIII (1797) [V] |
| Hobbes | "Force, and Fraud, are in warre the two Cardinall vertues"; the end, "principally their owne conservation" | *Leviathan* 13 (1651) [V] |

## THE DESIGN

### The case (`icon_history.l`, `mendacium`)

Real texts; every typing is an interpretive fact, entered and open to
dispute.

- **The question.** `q(lie_always_wrong)`, doctrinal, yes or no: every
  lie, as CCC 2482 defines it in both editions ("speaking a falsehood with
  the intention of deceiving"), is wrong.
- **The sources,** each at the tier its form gives:

  | Source | Tier | Year | Supports |
  | --- | --- | --- | --- |
  | `aug_ench`, *Enchiridion* 22 | 5, promoted to 4 in 1298 (as `aug_qe`) | 421 | yes |
  | `th110`, ST II-II q. 110 a. 3 | 5, promoted to 4 in 1567 (as `th_99_1`) | 1271 | yes |
  | `kant_g`, *Groundwork* | 5 | 1785 | yes |
  | `kant_tl`, *Tugendlehre* §9 | 5 | 1797 | yes |
  | `kant_vrml`, "Über ein vermeintes Recht" | 5 | 1797 | yes |
  | `ccc2482`, CCC 2482–2486, `character` catechism | 3 | 1992 (as `ccc2403`) | yes |
  | `grotius_iii1`, DIBP III.1.11–16 | 5 | 1625 | no |
  | `constant_1797`, *Des réactions politiques* VIII | 5 | 1797 | no |
  | `hobbes_l13`, *Leviathan* 13 | 5 | 1651 | no |

- **The arguments:**

  | Argument | Source | Value | Argues from |
  | --- | --- | --- | --- |
  | `ench22_words`: words instituted to make thoughts known | `aug_ench` | yes | (final, nature) |
  | `ench22_parity`: as theft for the poor, the deceit not praised | `aug_ench` | yes | (formal, will) |
  | `ench22_yea`: "Yea, yea; Nay, nay", to the new covenant | `aug_ench` | yes | (final, god_ethics) |
  | `th110_genus`: evil by its genus; words naturally signs | `th110` | yes | (formal, will), (final, nature) |
  | `th110_ad4`: not even to deliver another from death | `th110` | yes | (formal, will) |
  | `g422`: the universal law makes the promise impossible | `kant_g` | yes | (formal, reason) |
  | `g429`: the other cannot agree; never merely as a means | `kant_g` | yes | (formal, reason) |
  | `tl_dignity`: humanity in one's person thrown away | `kant_tl` | yes | (formal, reason) |
  | `tl_purpose`: against the natural end of communicating thought | `kant_tl` | yes | (final, nature) |
  | `vrml`: a formal duty; the source of right made useless | `kant_vrml` | yes | (formal, reason) |
  | `ccc2482_lord`: the work of the devil (Jn 8:44) | `ccc2482` | yes | (final, god_ethics) |
  | `ccc2485_speech`: the purpose of speech | `ccc2482` | yes | (final, nature) |
  | `ccc2486_society`: destructive of society | `ccc2482` | yes | (final, human) |
  | `grotius_iii1_11`: no lie without a right of the one addressed, owed by tacit pact | `grotius_iii1` | no | (efficient, will) |
  | `constant_viii`: taken absolutely, the duty makes society impossible | `constant_1797` | no | (final, human) |
  | `hobbes_l13`: fraud a virtue in war, whose end is conservation | `hobbes_l13` | no | (final, self) |

- **The typings follow the base.** The end of a natural power is (final,
  nature), as `kant_mm`'s warrant reads the Doctrine of Virtue; the act's
  species from its object is (formal, will), as `object_as_form` is
  defined (VS 78); a right by agreement is the will's act, as Grotius's
  property is in `modernity_property`; humanity as an end in itself is the
  form of the law, as `kant` reads Kant, against the reading
  `kant_humanity` makes.
- **The works are the sources.** Kant's three works are three sources, as
  Thomas's articles are in the property case. `th110_genus` rests on two
  causes, the object and the end of nature, as Thomas joins them in one
  sentence; `th110_ad4` on the object alone, its comparison with theft.

### The readings (switches of `mendacium`)

- **`ench22_as_given`.** *De doctrina christiana* II.2.3: there is no cause
  of giving a sign but to bring what is in the giver's mind into another's.
  So read, the end for which words were instituted is the end of the
  sign-giver's will: `reading_of(ench22_given, ench22_words)`,
  (final, will).
- **`humanity_as_end`.** G 4:429 and TL 6:429 read with humanity a final
  end of human nature, against their author: `reading_of(g429_end, g429)`,
  `reading_of(tl_dignity_end, tl_dignity)`, (final, human).

A further reading only adds availability (TTC-MODERNITY, CV4).

## PREDICTIONS

The reports below were computed from the case as designed above by a
plain model of `causae.l`'s availability and report rules, which gives the
encoded `pendet` on all 1,024 horizons and its VM on eight guests. The
model is not the encoding.

### MN: the case

- **MN1. Authority reads no argument.** On every runtime, alone and beside
  either reading or both: `q(lie_always_wrong)` yes is settled and no is a
  shadow (as CV1 classifies them). No `holds/2`, cleaving, note or
  obligation changes between runtimes or readings, and the case adds no
  violation on any runtime.
- **MN2. By report, the case alone.** Every report is about yes; the
  sources named are those of the argument left alone:

  | Runtimes | Reports |
  | --- | --- |
  | the four schools, `default`, `saussure`, `vocal`, `lingual`, `hooker`, `leibniz`, `leibniz_wl`, `episcopate_1891`, `social_catholic`, `angers`, `plato`, `aristotle`, `lassalle`, `concordia`, `bonaventure` | `sole_reason(kant_tl, tl_purpose, …)` |
  | `bacon`, `descartes`, `grotius`, `scotus_dpp`, `suarez_dm23`, `suarez_wl` | `th110_ad4` alone (`th110`) |
  | `locke`, `locke_wl`, `smith`, `george`, `scotus_will`, `ockham_will`, `descartes_will` | `ench22_yea` (`aug_ench`), `ccc2482_lord` (`ccc2482`) |
  | `ockham`, `ockham_nominal`, `george_hn` | `ench22_yea` |
  | `marx`, `grotius_etiamsi` | `ench22_parity`, `ccc2486_society`, `th110_ad4` |
  | `marx_social` | `ench22_parity`, `th110_ad4` |
  | `kant` | `tl_dignity` (`kant_tl`) |
  | `kant_humanity` | `tl_dignity`, `ccc2486_society` |
  | `kant_mm` | `ench22_words`, `ccc2485_speech` |
  | `hobbes`, `hobbes_wl`, `spinoza`, `spinoza_wl`, `bare` | `without_reason(q(lie_always_wrong), yes)`; `contrary_reasoned(q(lie_always_wrong), yes, no)` |

- **MN3. One passage, two arguments.** Of TL §9's two arguments, the
  Thomists hear the end of nature alone and `kant` the dignity alone;
  `kant_mm` alone among the runtimes hears both, and so reports nothing of
  `kant_tl`. Of the Groundwork and the essay of 1797, the Thomists hear
  nothing.
- **MN4. Kant leaves Hobbes.** For the first time `kant` and `kant_mm`
  report otherwise than `hobbes`: on the three Kantian runtimes yes has a
  reason, and on Hobbes's four and `bare` it has none.
- **MN5. No is never without reason.** `grotius_iii1_11` rests on no end
  and no form, so it is available on every runtime and every horizon,
  `bare` included, and no is never without reason. No report names
  `constant_viii` or `hobbes_l13`.

### MH: the phases

Over `horizons_all`, the case alone:

- **MH1.** The order parameters are exactly `ends_by_god_ethics`,
  `ends_of_human_nature`, `ends_in_nature`, `object_as_form` and
  `form_of_law`. `form_of_law` is an order parameter for the first time;
  `self_preservation`, `ends_desired`, `ends_by_god_physics`,
  `forms_in_nature` and `soul_as_form` are not.
- **MH2.** There are 24 phases, and 10 hold a runtime (MN2's rows, `bare`
  with Hobbes's four). Two phases have 160 horizons each, every other 32:
  the Thomists' (`tl_purpose` alone), and the phase that reports nothing.
- **MH3. The phase that reports nothing holds no runtime.** It is exactly
  the horizons that hold `ends_in_nature` and `form_of_law`, and
  `object_as_form` or `ends_by_god_ethics`, and `ends_by_god_ethics` or
  `ends_of_human_nature`. No runtime holds the form of the law with the
  end of nature and the classical ends besides: the Thomists lack the
  form, the Kantians the ends, and `kant_mm` the object and God's ends.
- **MH4.** Yes is without reason on 32 horizons, exactly those holding
  none of the five order parameters.

### MW: the readings

- **MW1. `ench22_as_given`.** The order parameters gain `ends_desired`;
  31 phases, 10 holding a runtime; yes is without reason on 16 horizons,
  and on `bare` alone among the runtimes. Changed rows: Hobbes's four,
  `ench22_words` alone; `ockham`, `ockham_nominal`, `george_hn`, nothing
  (the phase that reports nothing, now 176 horizons, holds them); the
  Lockeans, `ccc2482_lord` alone; `marx_social` joins the second row
  (`th110_ad4`); `marx` and `grotius_etiamsi`, `ccc2486_society` and
  `th110_ad4`; `kant`, `ench22_words` and `tl_dignity`; `kant_humanity`,
  those two and `ccc2486_society`. The Thomists, the second row, `kant_mm`
  and `bare` as MN2.
- **MW2. `humanity_as_end`.** The same five order parameters; 25 phases,
  10 holding a runtime; the phase that reports nothing again 160 horizons
  and empty. Changed rows: the Thomists, `sole_reason(kant_g, g429, …)`
  in place of `tl_purpose`, the Tugendlehre heard whole; the second row,
  `g429`, `tl_dignity` and `th110_ad4`; Ockham's three, `ench22_yea`,
  `g429` and `tl_dignity`; `marx` and `grotius_etiamsi`, `ench22_parity`,
  `ccc2486_society`, `g429`, `tl_dignity` and `th110_ad4`. The rest as
  MN2.
- **MW3. Both.** Six order parameters; 34 phases, 11 holding a runtime;
  the phase that reports nothing (160) empty, Ockham's three reporting
  `g429` and `tl_dignity`. Every other row is what MW1 and MW2 give it
  together: the Thomists `g429`; Hobbes's four `ench22_words`; the second
  row `g429`, `tl_dignity`, `th110_ad4`; the Lockeans `ccc2482_lord`;
  `marx` and `grotius_etiamsi` `ccc2486_society`, `g429`, `tl_dignity`,
  `th110_ad4`; `marx_social` `th110_ad4`; `kant` and `kant_humanity` as
  MW1; `kant_mm` as MN2; `bare` without reason.
- **MW4.** With either reading or both, every argument available without
  them stays available.

### MV: the VM

- **MV1. The Thomist cannot carry Kant.** With `thomist` as host and the
  case alone, `guest_sole_reason(S, A, …)` fires with a guest `vm_R`
  exactly where `sole_reason(S, A, …)` fires on R and both A and another
  argument of S are available on `thomist`. So it never names `kant_tl`,
  since `thomist` cannot follow `tl_dignity`: `vm_kant`
  gives no guest report at all; `vm_kant_humanity` gives `ccc2486_society`
  alone; the Thomists' guests give nothing. The Lockeans' guests give
  `ench22_yea` and `ccc2482_lord`; Ockham's three `ench22_yea`; the second
  row `th110_ad4`; `vm_marx` and `vm_grotius_etiamsi` `ench22_parity`,
  `ccc2486_society`, `th110_ad4`; `vm_marx_social` `ench22_parity`,
  `th110_ad4`; `vm_kant_mm` `ench22_words`, `ccc2485_speech`.
  `guest_without_reason(q(lie_always_wrong), yes)` fires with `vm_bare`
  and Hobbes's four.
- **MV2. `kant_mm` carries the Tugendlehre both ways.** With `kant_mm` as
  host: `guest_sole_reason(kant_tl, tl_purpose, …)` with the Thomists'
  guests, `guest_sole_reason(kant_tl, tl_dignity, …)` with `vm_kant` and
  `vm_kant_humanity`, `guest_without_reason` with `vm_bare` and Hobbes's
  four, and nothing else. It is the only runtime that holds both of
  `kant_tl`'s arguments, and so the only host that bridges either.

### MJ: the four cases

- **MJ1.** Over `horizons_all`, `modernity_property`, `pendet`, `soap` and
  `mendacium`, each run alone, taken together: nine order parameters, the
  eight of the three cases and `form_of_law`, still never
  `self_preservation`; 180 phases where there were 50; 16 holding a
  runtime where there were 12. The lying case parts three phases of the
  three cases: the 22 of the largest lose `bacon`, `grotius`,
  `scotus_dpp`, `suarez_dm23` and `suarez_wl` to a phase of their own
  (`th110_ad4`); Hobbes's six lose `kant` and `kant_mm`, each to a phase
  alone; `aristotle` and `lassalle` part from `grotius_etiamsi`.

### MC: with CCC 2483

- **MC1.** `mendacium` beside `linguae_ccc2483` gives what each gives
  alone, together: the two share no question, and the case enters no
  argument on `q(lie_needs_right_hearer)`.

### SU: the suite

- **SU1. No other change.** Every scenario before the encoding gives the
  same atoms in every model, main against the branch, compared as
  TTC-VERBUM's VS1 was. Save what follows, each restated with its reason
  (rule 7):
  - TTC-MODERNITY's SU1, the parts that write `argument/4`,
    `argues_from/3`, `reading_of/2` and `measures_as/3`, admits
    `mendacium`, `ench22_as_given` and `humanity_as_end`.
  - The stamped boot set does not grow: the group is kept out of it
    (`schools.py`).
  - `docs/coverage.md` is regenerated: the eighth commandment (2464–2513)
    cites 4 paragraphs where it cited 1, the rule files 60 of the 2,865
    where they cited 57, and the unit names the case's scenarios
    (`coverage.py`).
  - CL1 and PR4 stay clean; `test_l`'s count of the parts of a case stays
    within its bounds.
- **SU2.** The step adds data and no rule: no rule, slot, runtime or part
  of `schools.lp`, and so no mutation run. Both copies of the guide are
  unchanged.

### Mechanics

- **MQ1.** On `bare`, only `grotius_iii1_11` is available, under every
  reading.
- **MQ2.** `g422` and `vrml` are available on exactly `kant`,
  `kant_humanity` and `kant_mm`; under `humanity_as_end`, `g429` and
  `tl_dignity` also wherever `ends_of_human_nature` is held.
- **MQ3.** Under `ench22_as_given`, `ench22_words` is available on every
  runtime but `bare`.

## CAVEATS

- **The typings are the interpretation.** Augustine's *instituta* is read
  as the end of speech by nature, as Thomas, Kant and the Catechism read
  it; his own account of the given sign is the reading. Thomas's
  "naturaliter" stands against his own "ex institutione humana" (*In Peri
  herm.* I lect. 4): the same dispute, not entered for him. The
  Catechism's "purpose of speech" is typed by nature, not by human
  nature. Constant's correlation of duty and right is typed by nothing:
  his argument rests on the society it would make impossible.
- **The unit of a source decides `sole_reason`.** Were Kant's three works
  one source, `kant` would report nothing; the Thomists would still hear
  `tl_purpose` alone. The record's sources are works.
- **Nothing reported is not everything followed.** No is never reported:
  Grotius's pact reasons for it everywhere, and every other argument for
  it stands alone in its source. So `constant_viii` and `hobbes_l13`
  change no report, and self-preservation is no order parameter of any of
  the four cases run alone. Where both values have a reason, the checker
  says nothing.
- **A horizon is not a conclusion.** Under `ench22_as_given` Hobbes's
  horizon follows Augustine's argument; Hobbes counts the lie an abuse of
  speech (*Leviathan* 4) and fraud a virtue in war (*Leviathan* 13). What
  a horizon can follow is computed; what a figure concludes is not.
- **Kant's scope is disputed.** Whether Kant forbids every false
  statement (Akimoto: the lie against duty, the untruth not), whether the
  essay of 1797 is a doctrine of right (Varden), and how §9 is ordered
  (Bacin and Schönecker) are not computed. The case types his arguments,
  not the reach of his conclusion. His argument in the essay that whoever
  lies answers for what follows from it [M] is about imputation and is not
  entered (rule 3). "Menschheit überhaupt" in the essay is
  mankind, not the formula of humanity, so `humanity_as_end` does not read
  `vrml`.
- **Lying, not concealment.** Thomas allows the truth to be hidden
  prudently (ad 4); mental reservation, wide and strict, is not typed.
- **Grotius's "forte".** He allows the falsehood to save an innocent life
  only perhaps (XVI); infants, madmen, the one not deceived, the one
  content to be, and a superior right (XII–XV) are no lie for him without
  it. He supports no on those.
- **Scripture is not entered.** The midwives, Abraham, Jacob and Judith
  (II-II q. 110 a. 3 obj. 2–3, ad 2) are read both ways, and the case
  enters no tier 0. Jn 8:44 enters through CCC 2482.
- **The hearer's right is not joined.** `grotius_iii1_11` and
  `constant_viii` rest on the right of the one addressed; the 1992 text of
  CCC 2483 gave that right a place in the definition, and the Latin of
  1997 leaves it to the norms on communicating the truth, as TTC-LINGUAE
  reads the change ("Ius ad communicationem veritatis absolutum non est",
  2488). Joining
  `q(lie_needs_right_hearer)` to this question is a later step.
- **Tiers.** Augustine and Thomas enter at 4 by promotion, as in
  `pendet`; the Catechism at 3, dated 1992, as `ccc2403` is: its 2482 and
  2485 are the same in both editions, and 2486 as far as the second is
  reached.
- **Expected and risky.** MN1 and MC1 are expected to hold. MN2, MH, MW,
  MV and MJ rest on the plain model; a difference between it and
  `causae.lp` would show there first. SU1's restated counts are the
  likeliest to be wrong.

## BUGS

- The report vocabulary is blind to a value reasoned on both sides and to
  a source with one argument. A report that names the arguments a horizon
  can follow on each side would make self-preservation an order parameter;
  it is not proposed here.

## SEE ALSO

[ttc-modernity(7)](modernity-preregistration.md),
[ttc-pendet(7)](pendet-preregistration.md),
[ttc-linguae(7)](linguae-preregistration.md),
[ttc-rerum(7)](rerum-preregistration.md),
[ttc-verbum(7)](verbum-preregistration.md)
