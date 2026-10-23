# TTC-LINGUAE(7)

## NAME

**ttc-linguae**: the tongues, "variis linguis" (Acts 2:4): one word, many encodings, written and signed. A text in its tongue
at its date; a rendering's mode computed, never entered; a hearing as a
horizon with a lexicon; three regimes of translation, none preferred.
Predictions, committed before encoding.

## DESCRIPTION

Read as the rules stand at `3982c7d` (`main`):

- **A form is an atom.** `form_used(E,F)` names a rite part
  (`we_baptize`), and `q(valid_form(baptism,we_baptize))` is answered by
  the CDF's response of 2020. Nothing says in which tongue a form is
  written, at what date, or what it expresses.
- **Translation is only governance.** The part `translation` types who
  approves a version (`q(translation_approval)`: detailed *recognitio*
  or *confirmatio*; *Liturgiam authenticam*, *Magnum principium*, the
  prefect's commentary, the Pope's letter). Whether a version carries
  what its source says is not asked.
- **A source has no text.** A source is one atom with a tier, a year and
  a form. Its editions and its tongues are not entered, so a revised
  edition and a translation cannot be told apart.
- **Analogy is only between Creator and creature.** `bridge/3`,
  `mode/3` and `licensed/2` (`kernel_analogy.l`) license a form said of
  God and of creatures, and the lint refuses a crossing without them.
  Nothing licenses a crossing between two tongues.

The roadmap puts this step after the senses. It comes first, scoped to
forms entered as given, because TTC-MODERNITY waits on it: a guest horizon
there keeps the host's typing and loses what it cannot hold, where a
hearer hears in a tongue that divides the word its own way. A written form
is entered as given, and so is a signed one, through a notation that is
its claimant. Perceiving a form (hearing it, or reading a sign from a
recording) is the senses step's.

The proposal:

- The word is outside time and owned by no tongue. An encoding is a
  tongue in a script, or a signed language, over a span of years; a text is one encoding of one
  edition of a source; a form is a span of a text.
- A rendering's mode (univocal, analogical, equivocal, gap) is computed
  from the pair, against the host's readings and the lexicons, which are
  claims. A rendering can also close or open the host's readings.
- A hearing is a horizon with a declared lexicon, never a person. A mode
  is indexed by hearing, because the same pair is faithful for one hearer
  and not for another.
- An authority's statement of a mode is a claim with its unit, which
  weighs and never fixes.
- *Liturgiam authenticam*, *Comme le prévoit* and *Magnum principium*
  run as three regimes of what counts as faithful, and none is preferred.
  Which governed a book's approval is c. 838's, at its date.

## THE TEXTS

The evidence records are `docs/research/linguae-sources.md` (the word,
analogy, the four cases), `docs/research/linguae-norms.md` (the Church's
norms of translation), `docs/research/linguae-signs.md` (forms in sign),
`docs/research/linguae-asl.md` (the findings, the two runtimes, ASL in
time, notation, the canons) and `docs/research/linguae-peters.md` (a
canonist's articles and the sources they cite). Status as there: [V] checked against the text,
[S] through a named secondary source, [M] not re-checked.

| Text | Holds | Locus |
| --- | --- | --- |
| Augustine | The word in the heart belongs to no tongue; spoken sounds are its signs. | *De Trinitate* XV.10.19–11.20 [V] |
| Aristotle, Thomas | Spoken sounds are signs of the soul's affections, which are the same for all. | *De interpretatione* 1; *Peryermenias* I lect. 2 [V] |
| Thomas | The sense of a sacramental form "est idem apud omnes, licet non eaedem voces"; a form corrupted at its end is read "ex accommodatione usus". | ST III q. 60 a. 7 ad 1, ad 3 [V] |
| Thomas | *Hypostasis* and *substantia* are the same "secundum proprietatem vocabuli", yet "three substances" "non recte sonat" in Latin; the translator "servet sententiam, mutet autem modum loquendi". | *Contra errores Graecorum*, prooemium [V] |
| Thomas | Names said of God and creatures are said "secundum analogiam, idest proportionem", the ratio neither one nor wholly diverse. | ST I q. 13 a. 5 [V] |
| Jerome | "non verbum e verbo, sed sensum exprimere de sensu", save in Scripture, "ubi et verborum ordo mysterium est". | *Ep.* 57.5 [V] |
| Saussure | *Mouton* may mean what *sheep* means, but has not its value; before a tongue, thought is a shapeless mass. | *Cours*, Part II ch. IV [S] |
| *Comme le prévoit* (1969) | "A faithful translation, therefore, cannot be judged on the basis of individual words"; the unit of meaning is "the whole passage"; the hearer is "some actual community, assembled here and now"; readings and anaphoras rendered "without variations, omissions, or insertions". | CLP 6, 12, 20, 31, 33 [V] |
| CDF (1974) | An approved version expresses "exactly the sense intended by the Church", and is to be understood by the Latin. | Declaration of 25 January 1974 [V] |
| *Liturgiam authenticam* (2001) | The text "must be translated integrally and in the most exact manner"; the Latin typical edition is the text translated. | LA 20, 23 [V] |
| *Magnum principium* (2017) | "fidelitas non semper iudicari potest ex singulis verbis", but "ex toto communicationis actu"; c. 838 §§2–3 amended, in force 1 October 2017. | MP preamble; c. 838 [V] |
| Arinze, CDW (2006) | "For many is a faithful translation of pro multis"; "for all" is "rather an explanation of the sort that belongs properly to catechesis", and corresponds to "a correct interpretation of the Lord's intention". | Prot. 467/05/L [V] |
| Benedict XVI (2012) | "für alle" was "keine reine Übersetzung, sondern eine Interpretation". | Letter to Zollitsch, 14 April 2012 [V] |
| RN 9 | Latin "velut formam quamdam personae suae impressam"; English "the impress of his personality"; French "une certaine empreinte de sa personne"; Spanish "su persona dejó impresa una a modo de huella"; Italian "una impronta della sua personalità". | vatican.va [V] |
| "personality", in English | "That which constitutes an individual a distinct person" (Webster, 1828); "Person is a forensic term" (Locke). | Webster 1828 [V]; *Essay* II.xxvii.26 [V, modernised] |
| "well-being", in Locke's lexicon | Happiness "in its full extent, is the utmost pleasure we are capable of". | *Essay* II.xxi.42 [M] |
| CCC 2483 | French 1992 and English 1994: to lead into error one "who has the right to know the truth"; Latin 1997 and the revised French: without it. vatican.va's English and German keep the 1992 clause. | vatican.va; the 1992 French [V] |
| Florence | "I baptize thee in the name of the Father …"; the Greek form "The servant of Christ, N., is baptized …" also valid, the minister's act expressed. | DH 1314 [V] |
| CDF (2020) | "We baptize" is invalid; the assembly "agisce ministerialmente – non collegialmente". | *Responsa*, 24 June 2020; the Note [V] |
| c. 849 | Baptism is valid only "per lavacrum aquae verae cum debita verborum forma". | CIC 1983 [V] |
| c. 1104 §2 | "Sponsi consensum matrimonialem verbis exprimant; si vero loqui non possunt, signis aequipollentibus." No clause of validity (c. 10). Its 1917 form: "nec aequipollentia signa adhibere ipsis licet, si loqui possint". | CIC 1983 [V]; CIC 1917 c. 1088 §2 [V] |
| cc. 990, 983 §2, 1106, 1471 | Confession through an interpreter, bound to secrecy; marriage through an interpreter; an interpreter for the deaf or mute in a trial. | CIC 1983 [V] |
| *Notitiae* 2 (1966) | Sign language may be used "in omnibus partibus quae lingua vernacula dicuntur"; the celebrant "eodem tempore verba profert et simul illa gestibus significat". | n. 95 [V, transcription] |
| England and Wales (1992) | A Eucharistic Prayer for the Deaf, "to be signed by the celebrant himself"; "The celebrant must always pronounce all the words." | liturgyoffice.org [V] |
| USCCB (2017) | The deaf may confess and consent "in sign language, if sign language is their primary means of communication". | *Guidelines*, nn. 30, 45 [V] |
| *Gestis verbisque* (2024) | "The form of the Sacrament is constituted by the word"; doubts on a changed form go to the DDF. | n. 14; n. 31 note [V] |
| Aristotle | "By a noun we mean a sound significant by convention"; nothing is "by nature a noun". | *De int.* 2, 16a19–29 [V] |
| Augustine | "what is to nod or beckon, except to speak in some way to the sight?" | *De Trinitate* XV.10.19 [V] |
| Thomas | Words, because they "can be formed in various ways" to signify; the nods of the mute "pro verbis computantur". | ST III q. 60 a. 6 [V]; Suppl. q. 45 a. 2 [V] |
| Pius XII; the Holy Office | Concelebrants "must say" the words; "only he who pronounces the words of consecration validly celebrates". | Address, 22 September 1956 [V]; response of 1957 [S] |
| c. 1108 §2 | The assistant "exquirit manifestationem contrahentium consensus eamque nomine Ecclesiae recipit". | CIC 1983 [V] |
| The findings | Stokoe (1960); Frishberg (1975); Klima and Bellugi (1979); Petitto and Marentette (1991); Nicaraguan Sign Language, made by deaf children whose schools taught Spanish (Senghas and Coppola, 2001); al-Sayyid Bedouin Sign Language (Sandler et al., 2005). | the record [V/S] |
| Peters | Sacraments celebrated "solely in sign is valid and licit"; "what is necessary for sophisticated human communication is not speech, but language". | *Studia Canonica* 42 (2008) 336; *Josephinum* 15 (2008) 433 [V] |
| ASL | Not English: its own grammar and lexicon, descended from French Sign Language (Clerc, 1817) and local signing; not intelligible with BSL. Signing Exact English (1972) is a manual code of English, not a language. | Stokoe 1960 [S]; the record [S] |

## THE DESIGN

### The library (`linguae.l`)

- **Sorts.**
  - `encoding` (open): a tongue in a script, or a signed language, over a
    span of years (`la_1891`, `en_1891`, `en_2026`, `fr_1992`,
    `ase_2026`), with a BCP 47 or ISO 639-3 tag and its route
    (`encoding_route(E, written|manual)`).
  - `text` (open): one encoding of one edition of a source.
  - `form` (open): a span of a text, as given.
  - `word` (open): a node of the order of reason. No slot dates it or
    places it in time.
  - `tmode` {univocal, analogical, equivocal, gap}; `akind`
    {attribution, proportionality, metaphor}; `extent` {same, wider,
    narrower}; `unit` {word, passage, act, sense, recipients}.
- **Texts in time.**
  - `encoding(E,Tag,From,To)`; `text_of(T,S,E,Y)`: T encodes the source
    S in E, dated Y.
  - `made_from(T2,T1)`: a translation's parent. A text may have several,
    as a rite may (`derives_from/2`).
  - `revises(T2,T1)`: a new edition. It changes the word, and is never a
    rendering.
  - `form_in(F,T,Locus)`.
  - A signed form comes through a notation, which is a scheme with a
    claimant, never an encoding: `notated(F,N,C)` with N a gloss,
    HamNoSys, SignWriting or Stokoe notation, and `token(F,I,T)` from it.
    Two notations of one performance may disagree, and both run.
  - `code_of(E2,E1)`: E2 is a manual code of the tongue E1 (Signing Exact
    English of English). A form in E2 is a transliteration: no mode is
    computed between it and E1, as none is between editions.
- **Words, readings, lexicons.** Every one is a claim with its claimant.
  - `means(F,W,C)`: under its encoding, the form F signifies the word W,
    by the claimant C (a dictionary at its date, a grammar, a
    commentary). Rival claims are computed both ways.
  - `form_reading(F,R,C)`: a reading of a host form (exegesis).
  - `admits(F,R,C)`: under C's lexicon, F admits the reading R.
  - `analogous(W2,W1,K,C)`: in the order of reason, W2 is said of W1's
    ratio by analogy of kind K, by C. `broader(W2,W1,C)` for extent.
  - `carries(F2,F1,P)`: an analogical rendering carries the premise P
    (a cause and domain of TTC-MODERNITY, or a feature of a form).
- **Renderings.** `renders(F2,F1)`: F2 is given for F1, in a text made
  from F1's. A rendering of a rendering declares its host
  (`host_declared(F2,F1,C)`); where two are declared, both run.
- **The mode, computed.**
  - univocal: both forms mean one word;
  - analogical: they mean two words, and one is declared analogous to the
    other;
  - equivocal: two words, with no analogy declared;
  - gap: a form of the host with no rendering in a text made from it.
  - Extent from `broader/3`. A univocal or analogical rendering carries
    the premises of its host form; an analogical one only those `carries/3`
    names.
  - Univocal is convergence on one word: in the Grammar of the Icon's
    terms, two forms co-phase (S, ordered together to a common term), not
    one form facing another. *Liturgiam authenticam* makes a rendering
    face its source and *Comme le prévoit* its hearer; the computed mode
    faces neither, but the term. That the many renderings are no loss has
    A8's reason: a finite total gift is unique, and a gift that is not
    finite is non-rivalrous, so the word, being no encoding, is carried by
    many at once. A reading, by fittingness; no rule rests on it.
  - `closes(F2,F1,R)`: R is a reading of F1, and F2 does not admit it.
    `opens(F2,F1,R)`: F2 admits a reading F1 lacks.
    `interpretation(F2,F1,R)`: F2 keeps R and closes another reading of
    F1.
- **Hearings.** `hears_in(G,E,C)`: the horizon G hears in E by the
  lexicon C. G is a runtime or a VM guest, never a person (rule 3). Every
  derived relation has a per-hearing twin (`mode_for/4`, `closes_for/4`,
  `interpretation_for/4`), computed through G's lexicon. `hearing_rule(C,
  F2,F1)` (CDF 1974; the decree of 2021, n. 21): F2 is to be heard by
  F1, so a hearer under it (`hears_under(G,C)`) admits for F2 exactly
  F1's readings, and `heard_by_rule/3` reports it.
- **Claims of a mode.** `mode_claim(C,F2,F1,M,U)`: C states the mode M in
  the unit U. It weighs at C's tier and never fixes. `catechesis_rule(C,
  F2,R)`: C sends the reading R to catechesis (LA 29; CLP 31; Arinze).
  `message(F1,R,C)`: a reading named as the message (CLP 6, 9).
- **Sacramental forms.** `form_feature(F,Feature,Value,C)`, with the
  features of Florence and Thomas: `minister_act` (`expressed`,
  `unexpressed`, `other_agent`) and `trinity_invoked` (`yes`, `no`).
  `corruption_at(F,start|end)` for a form ill-formed in its encoding.
  Which features belong to the substance stays teaching
  (`classification/3`); the step only reads them.
- **The reports.**
  - `carried_in(A,E,P)` and `lost_in(A,E,P,Why)`, `Why` one of `gap`,
    `equivocal`, `no_carry`: TTC-MODERNITY's argument A, heard in E, keeps
    or loses its premise P.
  - `superseded_encoding(T,T2)`: T encodes an edition that T2 revises.
  - `info(notation_gap(F,N,nonmanual))`: a notation with no tier for what
    the face and body carry (Stokoe; most glosses) leaves it unentered.
  - `info(iconic_manner_differs(F,E))`: a sign depicting a manner (BAPTIZE
    as immersion) beside the matter used (infusion). Never a refusal: the
    sign's likeness is not the matter.
  - `read_by_accommodation(F)`: a corrupt form read by use, where the
    corruption falls at its end.
  - `info(mode_claim_differs(C,F2,F1))`: a claim differs from the mode
    computed in its unit. `info(units_differ(C1,C2,F2,F1))`: two claims on
    one pair in different units.
- **The refusals.**
  - `equivocation_carried(F2,F1)`: a case enters `carries/3` on a pair
    whose mode is equivocal.
  - `analogy_without_kind(W2,W1)`.
  - `word_dated(W)`: a word given a date or a parent in time, as
    `procession_in_time` is refused.
  - `made_before_parent(T2,T1)` and `translation_cycle(T)`, as
    `rite_from_later` and `rite_descends_from_itself`.
  - `mode_fixed_by_claim(C,F2,F1)`: a mode claim treated as fixing.
  - `hearing_without_lexicon(G)`; `hearing_of_a_person(G)`.
  - `gloss_as_word(F)`: a gloss's English label entered as the sign's word,
    or read as an English form. A gloss names a sign; it is not the sign.
  - `rendering_answers(S,Q,F2)`: a doctrinal value on Q rested on what a
    rendering closes. The question is answered by its own sources.
  - The pair: an approval of a version is governance (c. 838); entered as
    answering whether the version carries its source, it is refused
    (`teaching_from_law`). By the CDF's declaration of 1974 an approval
    also judges the sense: that judgement enters as a mode claim at the
    approver's tier, and weighs.

### The regimes (switches)

- `regime_la`: `faithful(F2,F1)` where nothing is closed, every host word
  is rendered, and order is kept where the tongue allows (LA 20, 32, 57).
  An opened reading goes to catechesis (`for_catechesis/2`), not to the
  text's fault.
- `regime_clp`: `faithful_for(G,F2,F1)` where G admits the message and no
  reading admitted for G answers a doctrinal question against its
  sources (CLP 6, 16). Insertion in a biblical or anaphoral text fails
  (CLP 31, 33).
- `regime_mp`: `faithful_for(G,F2,F1)` where three hold: the text (nothing
  closed, the Latin deciding in doubt); the tongue (`idiomatic/3`, a
  claim); the addressees, as under CLP (the decree of 2021). A
  sacramental formula also needs a version word for word, which is
  governance.
- The canon layer says which regime governed an approval: c. 838 as it
  read before 1 October 2017, and after.

### The schools

- `default` holds the part `word_of_no_tongue`: words are the order of
  reason's, and two encodings can mean one word.
- `saussure` excludes it and adds `word_by_division`: a word is a value in
  one encoding at its date. So no rendering between two encodings is
  univocal, and a word may be dated.
- The runtime `vocal` (run as `rt_vocal`) adds `verbum_vocal`: a word of a form or of consent is a
  *vox*, a significant sound (Aristotle, *De int.* 2; Isidore; Thomas's
  definitions). The runtime `lingual` (`rt_lingual`) adds `verbum_lingual`: a word is a
  conventional sign of the inner word in a human language, by any route
  (Augustine, *De Trinitate* XV.10.19; Thomas's reason, III q. 60 a. 6).
  `default` and `thomist` load neither, so both run there.

### The cases

Real texts; every `means`, `admits` and `analogous` fact is a claim with
its claimant.

- **`linguae_rn9`.** Texts: the Latin (promulgated, 1891); the English,
  Italian, French and Spanish of vatican.va (dates unknown; their parents
  undeclared). Forms: *formam … impressam* and *personae*; "impress",
  "impronta", "empreinte", "huella"; "personality", "personalità",
  "personne", "persona"; *perficiendam* and "well-being". Two readings of
  the host form: literal (the person's form) and metaphor (*velut*: as a
  seal in wax). Two English lexicons of 1891 for "personality":
  scholastic (*personalitas*, subsisting by itself) and Lockean (the
  forensic self). The seal-words are analogous to *forma* by
  proportionality, or a gap: both run.
- **`linguae_ccc2483`.** Texts: French 1992; English 1994, made from it;
  Latin 1997, revising it; French and English revised, made from the
  Latin; vatican.va's English and German, which encode 1992.
- **`linguae_pro_multis`.** Texts: the Latin of the Missal; English 1973
  ("for all") and 2011 ("for many"); German 1975 ("für alle"); Italian
  2020 ("per tutti"); French ("pour la multitude"). Host readings: open;
  all (Isaiah 53, Arinze); the Gentiles and those for whom it is offered
  (III q. 78 a. 3 ad 8). Claims: Arinze, Benedict XVI, the Italian
  approval of 2020.
- **`linguae_we_baptize`.** Forms: *Ego te baptizo …*; "I baptize you
  …"; the Greek passive and its Byzantine English; "We baptize you …";
  Zachary's "patria et filia" (c. 746), corrupt at the end; "in nomine
  matris", corrupt at the start. The existing part `we_baptize` stays as
  it is.
- **`linguae_signed`** (a switch, HYPOTHETICAL, rule 6: no approved signed
  form exists). In danger of death a deaf lay person baptizes by pouring,
  signing the form in ASL, later given by two transcribers (a gloss and
  HamNoSys); the parish must decide whether the baptism stands (c. 869
  §1). A deaf priest absolves in ASL, without voice; a variant through an
  interpreter (c. 990). Two deaf parties consent in ASL, one of whom can
  also speak; a variant through an interpreter (c. 1106). Whether a
  manual form is a "verborum forma" (c. 849), and whether the signs of a
  signed language are *verba* or *signa aequipollentia* (c. 1104 §2), are
  readings with their claimants. No source of tier 1 to 3 answers the
  first (c. 841; *Gestis verbisque* sends such doubts to the DDF), and no
  authentic interpretation answers the second. Variants: a deaf priest
  consecrates in ASL without voice; the assistant at the wedding is a
  deaf priest, or knows no ASL and has no interpreter; the witnesses know
  no ASL. The empirical questions of SG0 enter with their findings, dated.

## METHOD

Write `linguae.l` and its slots. In `schools.l`: the part
`word_of_no_tongue` in `default`, and the runtime `saussure`. The regimes
as switches. In `pair.l`: the refusal of an approval answering carriage.
Cases in `icon_history.l`, as parts loaded beside the records they speak
to: `linguae_pro_multis` with `translation`, `linguae_we_baptize` with
`we_baptize`, and `linguae_signed` (HYPOTHETICAL) beside both. Every slot with a test that fails without it. Run the whole
suite, the runtimes' boots and the coverage index. Then TTC-MODERNITY's
predictions are revised to use `hears_in/3`, committed and stamped.

## PREDICTIONS

### LW: the word

- **LW1.** On `default`, a word given a date (`date_claim/2` or
  `text_year/2` on a `word`) is refused (`word_dated`). On `saussure` it
  is not.
- **LW2.** On `default`, "personne" and "persona" render *personae*
  univocally. On `saussure` no rendering between two encodings is
  univocal: every pair is analogical where an analogy is declared, and
  otherwise equivocal.
- **LW3.** A text made before its parent (`made_from/2` with the dates
  reversed) is refused, and so is a cycle of translations.
- **LW4.** A word entered as an encoding's parent (an Adamic tongue, a
  perfect language, or a reconstructed proto-language taken as the word)
  is refused (`word_as_root`), on every runtime, as the Grammar of the
  Icon refuses God as the apex of the fractal (`cand_apex`; A11, God is
  not a level). A proto-language enters as an encoding with its
  claimant, never as the word.

### RN: RN 9 (`linguae_rn9`)

- **RN1.** French and Spanish carry the person univocally. English and
  Italian carry it by attribution, under the scholastic lexicon. Under
  the Lockean lexicon only (efficient, human) is carried, as "appropriating
  actions".
- **RN2.** The seal-words carry (formal, human) only on the
  proportionality branch; on the gap branch it is `lost_in` with `gap`,
  in every vernacular.
- **RN3.** "Well-being" renders *perficiendam* univocally and wider under
  the scholastic lexicon, carrying (final, human). Under the Lockean
  lexicon it carries (final, self) only.
- **RN4.** Heard in English of 1891 under the Lockean lexicon, rn9
  carries exactly (efficient, human), (material, nature) and (final,
  self): the typing of TTC-MODERNITY's switch `rn9_in_english`. That
  switch retires, and every result of TTC-MODERNITY that used it is
  unchanged (a test compares them).
- **RN5.** Heard in English of 2026 with no lexicon declared for
  "personality", the pair is equivocal, and rn9 loses (formal, human) by
  encoding alone, in a Thomist guest. A Lockean guest hearing the Latin
  loses it by horizon alone. The two losses are reported apart.
- **RN6.** The host's metaphor reading (*velut*) types rn9's form premise
  as a proportion. On that reading every seal-word renders it univocally:
  the vernaculars lose nothing that the Latin itself does not hedge.

### CC: CCC 2483 (`linguae_ccc2483`)

- **CC1.** English 1994 renders French 1992 univocally, clause by clause.
  No mode is computed between French 1992 and Latin 1997: a revision is
  not a rendering.
- **CC2.** `superseded_encoding` fires for vatican.va's English and
  German, against the Latin of 1997.
- **CC3.** *Laetamur magnopere* making the Latin "the definitive text" is
  governance. Entered as answering whether a lie needs a hearer with a
  right to the truth, it is refused (`teaching_from_law`).

### PM: *pro multis* (`linguae_pro_multis`)

- **PM1.** At the pair: "for many" and "pour la multitude" close nothing.
  "For all", "für alle" and "per tutti" close the open reading and the
  reading of those for whom it is offered, and keep "all":
  `interpretation(…, r_all)`.
- **PM2.** Under `regime_la`: "for many" faithful; "for all", "für alle",
  "per tutti" not.
- **PM3.** Under `regime_clp`: "for all" is faithful for an English
  hearing where the message is "all", and not where "for all" is an
  explanation (CLP 31): two branches. "For many" is faithful, save for a
  hearing whose lexicon hears "many" as "not all", where it is contrary to
  "Christ died for all" and not faithful: two branches.
- **PM4.** Under `regime_mp`: the text fails for "for all" in doubt; the
  tongue and the addressees branch as under CLP.
- **PM5.** Arinze's claim (univocal, word) agrees with the mode computed.
  Benedict's (interpretation, word) agrees with PM1. The Italian
  confirmation of 2020, a claim in the unit of the act, differs in unit
  from Benedict's: `units_differ`.
- **PM6.** A source resting "Christ died for all" on "for all", or "not
  for all" on "for many", is refused (`rendering_answers`). The question
  keeps the value its own sources give.
- **PM7.** The existing part `translation` gives the same
  `q(translation_approval)` as before. The canon layer places the English
  of 2011 under the law before 1 October 2017, and the Italian of 2020
  under the law after.

### BF: the form of baptism (`linguae_we_baptize`)

- **BF1.** "I baptize you …" renders *Ego te baptizo …* univocally on
  both features.
- **BF2.** The Greek passive: univocal on the Trinity; the minister's act
  `unexpressed`. "We baptize you …": the minister's act `other_agent`.
  The step computes the features and leaves `q(valid_form(…))` as the
  CDF's response gives it.
- **BF3.** "you" opens a plural reading that *te* closes:
  `opens(…, r_plural)`.
- **BF4.** Zachary's form, corrupt at the end, is `read_by_accommodation`.
  A corruption at the start is not: its sense is lost.
- **BF5.** With the Grammar of the Icon loaded (`uses(icon)`), the
  minister's act is D (`acton/2`, the minister acting on the one
  baptized, as instrument of the principal cause, III q. 66 a. 5) and the
  assembly is S (`side_by_side/3`, ordered together to the baptism). A
  form whose agent is the assembly ("We baptize", "a nome della
  comunità") puts S in D's place, and is refused (`cophase_as_agent`), as
  `motif_mismatch` refuses a closing motif without counter-phase. It
  types the CDF's "ministerialmente – non collegialmente". It stands
  beside the response and does not replace it: the validity stays the
  response's (BF2). Without the theory loaded, nothing changes.

### SG: forms in sign (`linguae_signed`)

- **SG0. The empirical questions.** `q(human_language(ase))` is fixed
  `yes` by a finding from 1960 (Stokoe), and `q(signifies_by_convention(
  ase))` from 1975 (Frishberg), each confirmed by later findings (Klima
  and Bellugi 1979; Hickok, Bellugi and Klima 1996; Petitto 1991). Run as
  of 1950, neither is fixed, and the claims of earlier centuries weigh
  nothing on them. A finding entered on `q(valid_form(…))` or on how
  c. 1104 §2 reads is refused (`finding_on_a_doctrine`). Homesign has no
  finding, so its gestures are never *verba* on any runtime.
- **SG-R. Two runtimes for *verbum*.** On `rt_vocal`, a manual form is not
  a "verborum forma" whatever any finding says, and c. 1104 §2 reads the
  signs of a signed language as *signa aequipollentia*. On `rt_lingual`,
  a manual form of a signed language is one from the year SG0 fixes its
  questions, and §2 reads its signs as *verba*. On `default` and
  `thomist` both branches run, with Thomas entered as two sibling
  readings (his definition of *vox*; his reason, III q. 60 a. 6). Every
  branch the runtime decides names its part in `read_as`. A runtime that
  reads *verba* one way in c. 849 and another in c. 1104 §2 is refused
  (`verba_read_two_ways`).
- **SG1.** `IX-1 BAPTIZE IX-2 …` under the religious lexicon: the
  minister's act `expressed`, the Trinity `yes`, and number closed. ASL's
  pointing YOU renders *te* univocally on number, where English "you"
  opens it (BF3). The addressee is a point's target, `deictic`; a gloss
  `IX-2` presumes a category of person and reports
  `gloss_presumes_category`.
- **SG2.** The same form in Signing Exact English opens the plural reading
  as English does, and no mode is computed between it and English
  (`code_of`). A claimant's reading of manual forms as words reaches only
  the encodings that claimant names: on a manual code of English with no
  claimant of its own, `info(no_claimant(…))`.
- **SG3.** With no subject token (ASL drops arguments), the minister's act
  is `disputed`, both values run, and the validity of the form keeps every
  branch. FATHER under an everyday lexicon is a human father, and the
  Trinity is `no`; under the religious register it is `yes`. Each lexicon
  is dated, with its claimant.
- **SG4.** A gloss token entered as a word is refused (`gloss_as_word`).
  `notation_gap(…, nonmanual)` is reported for Stokoe notation and for a
  gloss without a non-manual tier, partly for HamNoSys, and not for
  SignWriting or an annotation with a non-manual tier. Two performances
  with one gloss and different non-manuals (a statement, a yes/no
  question) give one report from the gloss and two from a tiered
  annotation: the gloss keeps the signs and loses what the face carries.
  Two transcriptions of one performance that disagree report
  `transcriptions_differ`, and both run. A lexicon's token number never
  supplies a meaning.
- **SG5. Baptism.** `q(valid_form(baptism, …))` has no value from a source.
  c. 869 §1 gives baptism under condition on `rt_vocal`, and not on
  `rt_lingual` where SG0 is fixed and the minister's act is `expressed`;
  on `default` both. The England and Wales rubric, the response of 1966,
  or an approval of simultaneous signing and speech, entered as answering
  validity, is refused (`teaching_from_law`); entered as practice, each
  weighs at its tier. A claim that the Church's practice teaches the
  doctrine ("Ecclesiae praxis aliquando docet") weighs with its claimant
  and has no tier; a validity resting on it alone is refused. For the lay
  baptism no question of an unapproved text arises (c. 850).
- **SG5a. Consecration (a variant).** `q(valid_form(eucharist, ase_
  institution))` takes a value from the Holy Office's response of 1957
  ("only he who pronounces the words of consecration validly
  celebrates") only on `rt_vocal`, where *pronuntiat* is read as spoken;
  on `rt_lingual`, where it is read as expressed against the merely
  mental, both branches stay. The response's two reported dates enter as
  date claims.
- **SG6. Consent.** c. 1104 §2 never invalidates (c. 10), on any reading.
  On `rt_lingual` the signs of ASL are *verba*, so consent in ASL is licit
  for a party who can speak; on `rt_vocal`, illicit for that party, where
  the fact is not disputed. Validity is decided at c. 1108: whether the
  assistant received the consent is a fact entered (yes, no, disputed),
  never derived.
  - The assistant signs, or is a deaf priest who signs: received.
  - Through an interpreter: received; licit only where the interpreter's
    fidelity is entered as established (c. 1106).
  - The assistant knows no ASL and there is no interpreter: two branches,
    on the reading of *recipit* (the celebration, or the consent itself),
    with `info(assistant_outside_encoding)`; no authentic interpretation
    answers it.
  - The witnesses know no ASL: valid where they perceive the celebration.
  - Liceity beyond §2: c. 1106; a signed rendering of the approved
    formula read as the rite kept or as changed (c. 1119 with c. 846 §1),
    two readings; the USCCB's *Guidelines* weigh as practice, never as a
    rite (c. 1120).
- **SG7. Penance.** The penitent's signed confession carries no dispute:
  the vocal side grants that a vocal confession is not required for
  validity. The absolution signed without voice carries SG-R's branches.
  Through an interpreter it computes cleanly (cc. 990, 983 §2, 1386 §2);
  the interpreter is permitted, never required, and a case that enters an
  obligation to confess through one is refused. The internal forum is
  never computed.
- **SG8.** BAPTIZE signed as immersion beside poured water gives
  `iconic_manner_differs`, never a refusal.
- **SG9. ASL in time.** Every meaning cites a lexicon with its year and
  kind; a lexicon outside its encoding's span is refused
  (`lexicon_out_of_span`). Black ASL is a variety of ASL, not an encoding
  made from it. No ecclesiastical approval of any Catholic ASL lexicon or
  translation is entered, because none was found.
- **SG10. Symmetry.** A deaf assistant receiving spoken consent through an
  interpreter computes exactly as a hearing assistant receiving signed
  consent through one. The route never enters c. 1108.

### LM: modes and regimes

- **LM1.** A `mode_claim` treated as fixing is refused. A `hearing_rule`
  makes a hearer admit exactly the host's readings, and `heard_by_rule`
  reports it.
- **LM2.** "Et cum spiritu tuo" (a test case): the same pair gives
  opposite verdicts under `regime_la` and `regime_clp`, where only the
  declared message and hearing differ.
- **LM3.** A hearing with no lexicon, or entered for a person, is
  refused.

### M: meta

- **M1.** No earlier output changes: every scenario's atoms compared
  before and after. The TTC-SCHOOLS tables gain the part
  `word_of_no_tongue` in `default` and the runtimes `saussure`, `vocal`
  and `lingual`, and do not otherwise change.
- **M2.** Every new rule has a test that fails without it; CL1 and PR4
  stay clean.

## CAVEATS

- **Readings are the hidden premise.** Every mode, LA's included, rests on
  the host's readings, which are exegesis with claimants. The checker
  types them; it does not choose them.
- **A hearing is not a mind.** CLP's "actual community" invites computing
  what people understood, which rule 3 forbids. Only a horizon's public
  lexicon is entered; a survey is a claim about a lexicon.
- **The order of reason is itself encoded.** Every `word` the case names,
  and every `analogous` fact, is some encoding's claim, entered with its
  claimant, never taken as the order itself. The interlinguas (EuroWordNet's
  index, UNL, Wierzbicka's primes) are kept flat for that reason.
- **Saussure runs as a school.** His value gives the lexicon its
  division; his shapeless thought before a tongue is the runtime
  `saussure`, beside the Augustinian default. Neither is preferred.
- **Both sides claim the same fathers.** Jerome, Thomas and Paul VI are
  cited by LA's defenders and by CLP's. Each citation is entered as a
  reading of its source, not as the source's verdict.
- **CLP's dependence on Nida is asserted, not documented.** No fetched
  source shows it, and CLP uses none of his terms.
- **The Italian drafts of RN are unread.** If a draft said "impronta della
  sua personalità", then *forma personae* is the Latin translator's
  rendering, and the vernacular follows the draft. Antonazzi (1957)
  settles it.
- **Given, not perceived.** A form heard, a sign read from a recording, a
  form touched: perceiving them waits for the senses step, and so does a
  doubt whether "I" or "we" was said or signed. Here a signed form is only
  some notation's claim.
- **No approved signed form exists.** The signed case is hypothetical. The
  approved practice it leans on (the response of 1966; England and Wales;
  the USCCB) has the celebrant voice the words. Unvoiced practice is
  reported (deaf clergy celebrating without vocalization since the 1970s;
  hearing priests who sign absolution without voicing it), and Peters
  holds it valid and licit, resting on practice. No act of the Holy See
  rules on it.
- **A finding's year is an entry.** That Stokoe's work fixes the question
  from 1960, and not from its acceptance later, is itself a choice the
  case makes, open to dispute.
- **Thomas falls on both sides.** His definition makes a *vox* a sound;
  his reason for words in the sacraments is that they can signify many
  concepts. The two runtimes divide over which is essential, and he enters
  twice. Whether a sign language is a
  *lingua vernacula* under c. 838 §3 is not decided by any text read.

## STANDARDS

- Augustine, *De Trinitate* XV.10.19–11.20; Aristotle, *De
  interpretatione* 1, *Categories* 1; Thomas, *Expositio Peryermenias* I
  lect. 2, ST I q. 13 a. 5, III q. 60 aa. 7–8, III q. 66 a. 5, III q. 67
  a. 6, III q. 78 a. 3 ad 8, *Contra errores Graecorum*, prooemium
- Jerome, *Ep.* 57; Lateran IV, c. 2 (DH 806); Florence, *Exultate Deo*
  (1439, DH 1314)
- SC 22, 36; DV 22; Pius XII, *Divino afflante Spiritu* (1943)
- Consilium, *Comme le prévoit* (25 January 1969); CDF, Declaration on
  the approval of translations of sacramental formulas (25 January 1974);
  CDWDS, *Varietates legitimae* (1994), *Liturgiam authenticam* (2001);
  CDW, letter on *pro multis* (17 October 2006); Benedict XVI to
  Zollitsch (14 April 2012); Francis, *Magnum principium* (2017) and the
  letter to Sarah (15 October 2017); CDWDS decree on c. 838 (22 October
  2021)
- CIC 1983 c. 838 (1983; 2017)
- John Paul II, *Laetamur magnopere* (15 August 1997); CCC 2482–2489
- CDF, *Responsa ad dubia* on the form of baptism (24 June 2020), and its
  Note; DDF, *Gestis verbisque* (2 February 2024)
- CIC 1983 cc. 10, 16–17, 841, 849, 869 §1, 983 §2, 990, 1104 §2, 1106,
  1108 §2, 1386 §2, 1471; CIC 1917 c. 1088 §2; CCEO cc. 733, 1130
- Consilium, response on sign language, *Notitiae* 2 (1966) n. 95;
  Bishops' Conference of England and Wales, Eucharistic Prayer for the
  Deaf (1992); USCCB, *Guidelines for the Celebration of the Sacraments
  with Persons with Disabilities* (2017)
- W. Stokoe, *Sign Language Structure* (1960); L. Frishberg, *Language*
  51 (1975); E. Klima and U. Bellugi, *The Signs of Language* (1979); L.
  Petitto and P. Marentette, *Science* 251 (1991); A. Senghas and M.
  Coppola, *Psychological Science* 12 (2001); W. Sandler et al., *PNAS*
  102 (2005); S. Prillwitz et al., HamNoSys (1987); V. Sutton, SignWriting
  (1974)
- E. Peters, *Studia Canonica* 42 (2008); *Josephinum Journal of
  Theology* 15 (2008); *The Jurist* 73 (2013)
- Pius XII, address of 22 September 1956; Holy Office, response of 1957
- CIC 1983 cc. 850, 1108, 1119–1120
- Leo XIII, *Rerum novarum* (1891) n. 9, in its encodings on vatican.va
- F. de Saussure, *Cours de linguistique générale* (1916); E. Nida,
  *Toward a Science of Translating* (1964); P. Vossen, EuroWordNet (1998);
  S. Bird and M. Liberman, "A formal framework for linguistic annotation"
  (2001)

## SEE ALSO

[ttc-liturgy(7)](liturgy-preregistration.md), [ttc-sources(7)](sources-preregistration.md),
[ttc-saeculum(7)](saeculum-preregistration.md), [ttc-schools(7)](schools-preregistration.md),
[ttc-core(5)](../core-edition.md),
ttc-modernity(7), [ttc-roadmap(7)](../roadmap.md)
