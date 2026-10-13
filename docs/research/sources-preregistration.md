# TTC-SOURCES(7)

## NAME

**ttc-sources** — documents as layers in time: a code at a date, the
general norms as the edges, executive acts below the law, collections
private and authentic; authorship typed, an attribution a claim, the
anonymous left without a name; the Filioque's Latin witnesses before 1100;
predictions, committed before encoding

## DESCRIPTION

Read as the rules stand (the base run as committed, d451ea0, only for the
outputs quoted here):

- **One text per canon, dated only in Book VI.** The canon layer reads a
  text's dates where `part_of/2` and `enacted_by/2` give them: the penal
  canons (Book VI of 1983 and of 2021; c. 1371 n. 1 in three texts) and
  c. 1108 §3 (2016). The form of marriage (cc. 1108 §1, 1111, 1117), the
  faculties, the sacraments and the bond fire at any date: a marriage of
  1950 would be judged by the Code of 1983, and a formal defection of 1945
  would exempt from the form. No case has an event before 27 November
  1983.
- **No Code of 1917.** Nothing before 1983 is encoded; c. 6 is not.
- **c. 20 in one shape.** `reorders/2` stands for every revocation, and
  c. 20's three ways are not told apart. c. 21 is an info line
  (`revocation_not_presumed/2`, LW9) that changes nothing.
- **No executive act.** cc. 29–34 are not encoded: no general decree,
  general executory decree or instruction. The Dicastery's clause
  (TTC-PENAL N5) reasons from c. 33 §1 in a comment.
- **Authorship untyped.** A source has a tier, a force and a year
  (`source/4`), no author. The *Quicumque*'s name is in comments, and in
  Florence's words to the Armenians ("composed by most blessed
  Athanasius"). Signed, anonymous and pseudonymous texts are alike.
- **The Filioque before 1100.** As of 1100 the record's only weight is
  Photius (886): "from the Father alone" is open and preferred (CR1b). The
  monarchy has no source before Lateran IV (1215): open as of 1100, no
  value preferred.
- **Tier 3 is one rank in teaching.** No particular council is in the
  record. Every source at tier 3 can cleave a question of the whole Church.

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited.

## THE DOCUMENTS

Fixed here. Each document is its own layer, as the two codes are; the
layers are joined by the general norms. Texts from vatican.va (the Code of
1983, Book I) and the Latin of the Code of 1917 that iuscangreg's
`cic1917.php` lists, read at encoding.

- **A document is typed** by kind, power, issuer and dates: a law (c. 7), a
  general decree, which is a law (c. 29), a general executory decree
  (c. 31), an instruction (c. 34), an authentic interpretation (c. 16), a
  collection; legislative or executive power (c. 135 §1); its issuer
  (`issuer/2`, `authority/2`); its force from the *saeculum* (c. 8 §1). It
  gives a body of texts (`enacted_by/2`, `part_of/2`) and may execute a law
  (`executes/2`).
- **A code at a date is a view.** A canon is a sequence of texts, each
  entered by the act that gave it. At a date the view holds the text in
  force; a rule of the layer fires for an event only under the text in
  force at its date. As git: each act a commit, a code at a date a
  checkout.
- **The edges are the general norms.**
  - c. 6 §1 n. 1: the Code of 1983 abrogates the Code of 1917.
  - c. 20: a later law abrogates or derogates from an earlier one
    expressly, by being directly contrary to it, or by completely
    reordering its matter. Typed, one fact per way.
  - c. 21: "In dubio revocatio legis praeexistentis non praesumitur". The
    law settles its own doubt, so a doubtful revocation leaves the earlier
    text in force and nothing branches (rule 2).
  - cc. 29–30: general decrees are laws; one who has executive power alone
    cannot give one unless the legislator expressly grants it.
  - c. 33 §§1–2, c. 34 §§2–3: an executive act derogates from no law; a
    provision contrary to a law lacks all force; it ceases with the law it
    executes.
  - c. 135 §2, as encoded.
- **Collections.** An authentic collection's texts have force from its
  promulgation, whatever their origin: Gregory IX willed "ut hac tantum
  compilatione universi utantur in iudiciis et in scholis" (*Rex
  pacificus*, 5 September 1234). A private collection's texts have their
  sources' authority and no more: Gratian's *Decretum* "has never been
  recognized by the Church as an official collection"; "custom has even
  given to several apocryphal canons" of it "the force of law" (*Catholic
  Encyclopedia*, "Corpus Juris Canonici"). Custom is its own route
  (cc. 23–28), not the attribution's.
- **The Code of 1917**: given on Pentecost, 27 May 1917 (*Providentissima
  Mater Ecclesia*), binding "a die decima nona mensis Maii anni millesimi
  nongentesimi duodevicesimi" (AAS 9/II). The form of marriage: "Ea tantum
  matrimonia valida sunt quae contrahuntur coram parocho, vel loci
  Ordinario, vel sacerdote ab alterutro delegato et duobus saltem
  testibus" (c. 1094). Bound to the form: all baptized in the Catholic
  Church or converted to it from heresy or schism, "licet sive hi sive
  illi ab eadem postea defecerint" (c. 1099 §1 n. 1); not bound, "item ab
  acatholicis nati, etsi in Ecclesia catholica baptizati, qui ab infantili
  aetate in haeresi vel schismate aut infidelitate vel sine ulla religione
  adoleverunt, quoties cum parte acatholica contraxerint" (c. 1099 §2).
  Pius XII struck that clause (motu proprio *Decretum Ne temere*, 1 August
  1948, AAS 40 (1948) 305–306) from 1 January 1949. The 1983 Code binds
  "from the first day of Advent" (*Sacrae disciplinae leges*): 27 November
  1983.

## AUTHORSHIP

Fixed here. A new library, `sources.lp`.

- **Three kinds.** *Signed*: the text bears its author's name and nothing
  disputes it. *Anonymous*: no author. *Attributed*: an author claimed,
  with the claimant, who may be the text itself. A source with none of
  these is not at issue (every source in the base).
- **An attribution is a claim** (rule 14): entered with its claimant,
  computed both ways, and the branch resting on it never preferred unless
  evidence apart from the claimant shows it.
- **The order refuses it** (TTC-SAECULUM). A text is not older than what
  it draws on, and no one writes after his death. A dependence is entered
  with its witness and counts from the witness's year: before it, the
  attribution is computed both ways; from it, the attributed branch is
  refused. No refusal rests on style, or on the language a text is
  written in.
- **A name never raises a tier.** A text's tier is its form's. A name
  changes the form only where the claimed author's office gives the text
  one (a pope's letter), and then only on the branch of the claim.
- **The anonymous are left without a name.** An anonymous text has no
  office behind it: tier 5, unless received (the *Quicumque*, by a dated
  claim). It is shown as such, and an author entered for it without a
  claim is refused. "Non quaeras quis hoc dixerit, sed quid dicatur
  attende" (*Imitatio Christi* I.5).
- **No motive.** A refused attribution is a fact about dates, never a
  forgery, a fraud or a deceit: why a text bears another's name is
  interior (rule 3).
- **Scripture.** God is the author of Sacred Scripture, and the human
  writers "true authors" (CCC 105–106, DV 11); the Church discerned the
  canon by the apostolic Tradition (CCC 120), not by attribution.

## THE FILIOQUE BEFORE 1100

Fixed here. The witnesses entered, with their tiers by form:

- **Augustine**, *De Trinitate* XV (c. 420): "spiritus sanctus de patre
  principaliter, et ipso sine ullo intervallo temporis dante, communiter
  de utroque procedit" (XV.26.47; "Ideo autem addidi, principaliter",
  XV.17.29). Tier 5, a Doctor (tier 4) from 1298, as the base types
  Augustine. It supports the monarchy too.
- **Photius** on the monarchy: the Spirit "proceeds from the Father, Who
  is the first cause" (*Mystagogia* 43). Both sides affirm it, as the
  base's comment already says.
- **Leo I**, *Quam laudabiliter* (21 July 447, DH 284): a pope's letter,
  tier 3. "Pope St. Leo I ... had already confessed it dogmatically in
  447" (CCC 247), read as a doctrinal act, not a claim of tier.
- **Toledo III** (589, DH 470): Reccared's profession, "Spiritusque
  sanctus confitendus a nobis et praedicandus est a patre et filio
  procedere", and its anathema; not the creed's text, which reads "ex
  patre procedentem". **Toledo XI** (675): "proceeding from both"
  (DH 527), and the Father "the source and origin of the whole Godhead"
  (DH 525). Particular councils: bishops gathered in them teach the
  faithful entrusted to them (c. 753), not the whole Church (c. 752).
  Their teaching weighs at tier 3 and cleaves nothing.
- **The *Fides Damasi*** (DH 71–72): "de Patre et Filio procedentem",
  attributed to Pope Damasus (d. 384); "of uncertain author and time;
  in Gaul about 500 (?)" (Denzinger). On the branch of the attribution, a
  pope's letter of about 380 at tier 3; otherwise an anonymous creed of
  about 500 at tier 5.

## METHOD

Write `sources.lp`: authorship, attribution as a claim, its refusal by
the order, the anonymous shown. In `canon_law.lp`: c. 6 §1 n. 1; c. 20
typed; c. 21 computed; cc. 29–30, 33–34; collections; the Code of 1917's
form (cc. 1094–1096, 1099) with Pius XII's change; the form of 1983 read
through its texts' dates. In `icon_authority.lp`: particular councils
weigh and do not cleave. In `icon_history.lp`: the witnesses above.

Cases, all HYPOTHETICAL unless real data: marriages before a delegated
deacon in 1950 and 1990; one who left the Church marrying without the form
in 1950, 1990 and 2011; one born of non-Catholics, baptized Catholic and
raised outside, marrying without the form in 1948 and 1950; a marriage of
1915. *Universae Ecclesiae* (2011), *Summorum Pontificum* (2007) and
*Traditionis custodes* (2021), as data; an instruction contrary to a law;
a dicastery's general decree with and without a grant; a doubtful
revocation with dates. A decretal ascribed to an early pope that quotes a
later council, in a private and in an authentic collection. As data: the
*Corpus Dionysiacum* and Proclus; the *Liber de causis*; the *Quicumque*'s
attribution; the pseudo-Lullian *Testamentum* and the *Ars brevis*; the
*Imitation of Christ*; *The Cloud of Unknowing*. The Filioque as of 440
and 1100. Run the whole suite, the runtimes' boots and the coverage index.

## PREDICTIONS

### TX: a code at a date

- **TX1.** A deacon delegated to assist at a marriage of two Latin
  Catholics: the form invalid in 1950 (only a priest is delegated,
  cc. 1094–1096 of 1917); valid in 1990 (cc. 1108 §1, 1111 §1).
- **TX2.** One baptized Catholic who left the Church marries a non-Catholic
  without the form: the form invalid in 1950 (c. 1099 §1 n. 1 of 1917,
  "licet ... defecerint"); not binding in 1990 after a formal act (c. 1117
  as of 1983); invalid in 2011 (*Omnium in mentem*). One matter, three
  texts, read off at three dates.
- **TX3.** Born of non-Catholics, baptized Catholic, raised outside the
  Church from infancy, marrying a non-Catholic without the form: the form
  not binding in 1948 (c. 1099 §2); invalid in 1950 (Pius XII, from
  1 January 1949).
- **TX4.** A marriage of 1915: no encoded text governs its form. Reported,
  never computed under 1917 or 1983.
- **TX5.** One code's form at a time: no rule of 1917 fires for an event
  from 27 November 1983, and no rule of 1983 before.
- **TX6.** Every marriage case already in the base keeps its outputs (all
  dated 2010 or later).

### GN: the general norms as edges

- **GN1.** c. 6 §1 n. 1: the texts of 1917 cease when the Code of 1983
  takes force, expressly.
- **GN2.** c. 20 typed: every existing `reorders/2` fact keeps its outputs
  under its way (the Book VI and c. 1371 scenarios unchanged).
- **GN3.** c. 21: an earlier text whose revocation is doubtful stays in
  force at every date; no branch. LW9 gains the computation.
- **GN4.** c. 34 §3: *Universae Ecclesiae* (30 April 2011; "hanc
  Instructionem edit, ad normam canonis 34", n. 12) is in force in 2015
  and ceases on 16 July 2021, when *Traditionis custodes*, in force "eodem
  die", revokes the law it executes (*Summorum Pontificum*, in force
  14 September 2007). Computed from its law's cessation alone, without
  art. 8 of *Traditionis custodes*.
- **GN5.** c. 33 §1, c. 34 §2: an instruction's provision contrary to a
  law lacks all force (HYPOTHETICAL); the law's rule fires as if the
  provision were absent, and the want of force is reported.
- **GN6.** c. 30: a dicastery's general decree with executive power alone
  and no express grant is refused; with the grant it is a law (c. 29) and
  takes force by c. 8 §1.

### CO: collections

- **CO1.** A decretal ascribed to a second-century pope that quotes a
  fourth-century council (HYPOTHETICAL): in a private collection its
  attribution is refused by the order and it has no force of its own; in
  an authentic collection it has force from the collection's
  promulgation, and its attribution changes nothing. Custom is not
  computed here.

### AU: authorship

- **AU1.** The *Corpus Dionysiacum*, attributed to the Areopagite (Acts
  17:34; claimants: the text itself, and *The Cloud of Unknowing*, "Saint
  Denis said", ch. 70), draws on Proclus's *De malorum subsistentia* in
  *Divine Names* IV (witnesses: H. Koch, *Philologus* 54, and J.
  Stiglmayr, *Historisches Jahrbuch* 16, both 1895). As of 1890 the
  attribution is computed both ways; from 1895 the attributed branch is
  refused. Its tier is 5 on every branch.
- **AU2.** The *Liber de causis*, attributed to Aristotle (claimant: the
  Latin schools), is drawn from Proclus's *Elements of Theology* (witness:
  Thomas, *Super librum De causis*, 1272, after Moerbeke's Latin of 1268).
  As of 1260 both ways; from 1272 refused.
- **AU3.** The *Quicumque*, attributed to Athanasius (d. 373; claimants:
  the synod of Autun, c. 670, and Florence's decree for the Armenians,
  1439), uses the terms of Augustine's *De Trinitate* (witness: J. N. D.
  Kelly, 1964): refused from 1964. Its tier rests on reception: no RC or
  CR output changes. Florence's words are a claim of a tier-3 act, and fix
  nothing.
- **AU4.** The alchemical *Testamentum*, attributed to Ramon Llull, dates
  itself in its colophon (London, 1332); Llull died in 1316: refused. The
  *Ars brevis* (Pisa, 1308), signed, is not at issue.
- **AU5.** The *Imitation of Christ*, attributed to Thomas à Kempis
  (claimant: the autograph of 1441, "per manus fratris Th. Kempensis") and
  to Jean Gerson (claimant: early printed editions): at most one holds;
  three branches, and the preferred is neither, both claims unshown.
- **AU6.** *The Cloud of Unknowing* (fourteenth century) is shown as
  anonymous; an author entered for it without a claim is refused (a
  candidate part). Its citation of "Saint Denis" holds on both of AU1's
  branches: the order allows it either way.
- **AU7.** No rule names a motive: no forgery, fraud or deceit (a test).
- **AU8.** A name never raises a tier: for every source on every branch,
  the tier is the form's; only the *Fides Damasi* changes form with its
  attribution, and only on that branch (FQ3).

### FQ: the Filioque's Latin witnesses

- **FQ1.** As of 1100: "from the Father and the Son" settled in the main
  branches; "from the Father alone" a live shadow, cleaved by Leo I's
  letter and reintegrating if it is relaxed; Photius weighs at tier 5
  against the main branches. CR1b changes, stated: its "open, the Father
  alone preferred" was the record's gap.
- **FQ2.** The Toledan councils weigh at tier 3 and cleave nothing
  (c. 753).
- **FQ3.** As of 440, before Leo I: "from the Father alone" open on the
  preferred branches (Augustine weighs against it at tier 5); a live
  shadow only on the branch resting on the attribution of the *Fides
  Damasi* to Damasus, never preferred.
- **FQ4.** The monarchy as of 1100: still open, "the Father principle
  without principle" preferred by the weight of Augustine, Photius and
  Toledo XI.
- **FQ5.** FQ19 and FQ20 change, stated: without the two councils "from
  the Father alone" is a live shadow (Leo I), no longer open, and FQ20
  reads the same branch as a shadow. FQ18, CR1, CR1d, CR1e and the
  communion scenarios keep their outputs.

### M: meta

- **M1.** No other output changes: every scenario's atoms compared before
  and after, FQ19, FQ20 and CR1b aside. The TTC-SCHOOLS tables do not
  change.
- **M2.** Every new rule has a test that fails without it; CL1 and PR4
  stay clean.
- **M3.** In the coverage index no unit changes status; the rule files
  cite CCC 105, 106, 120, 247 and 248 (39 paragraphs).

## CAVEATS

The Code of 1917 is read in the Latin iuscangreg lists, not on vatican.va.
Here c. 1094 and c. 1099 §2 are quoted from canonists' citations; c. 1095
§2, c. 1096 §1, c. 1099 §1 and Pius XII's operative words are read at
encoding. Where a text differs from what this file assumes, the scoring
says so. Only the form of marriage is dated in this step; the other
matters of the layer stay undated, and their events are 1983 or later.
*Ne temere* (1907, in force 1908) and the form before 1918 are frontier.

Art. 8 of *Traditionis custodes* abrogates "normae, dispositiones,
concessiones et consuetudines" not in conformity; the English renders
*dispositiones* "instructions". *Summorum Pontificum* is entered as
revoked by direct contrariety (c. 20): its art. 1 and that of *Traditionis
custodes* cannot both stand. Were that reading disputed with no authentic
interpretation, it would branch (rule 2).

The Filioque's witnesses are read in Denzinger's numbering; the Latin of
DH 284, 525 and 527 is read at encoding. Leo IX's profession to Peter of
Antioch (1053) and Toledo IV (633, DH 485) are not entered: their texts
were not read. The *Fides Damasi*'s origin is Denzinger's note, entered
as the composition date, and the attribution as the claim; one
manuscript lacks "et Filio", and others give the creed to Jerome. A
variant is a reading of the text, and interpolation a kind of injection
of its own (the *Fides Damasi*'s "et Filio"; the Johannine Comma): left
for later. So is the creed of Toledo I (400), whose Filioque is only in
the recension of 447 ascribed to Bishop Pastor, at a council some doubt
was held. The Roman liturgy's creed (1014) and Leo III's refusal to change
the creed (about 810) wait for the liturgy step. Were CCC 247's
"dogmatically" read as a claim of tier, it would be entered with its
claimant (rule 14).

A dependence's witness is a scholar or a reader inside the tradition;
before the witness the checker does not know the dependence, as the Church
did not. Earlier doubts on other grounds (the *Quicumque*'s Latin, from
1642) are not entered.

Hebrews is canonical and its author unknown ("who wrote the epistle, in
truth God knows", Origen, in Eusebius, *HE* VI.25.14). Trent lists it
among "quattuordecim epistolae Pauli Apostoli" (8 April 1546). The
Biblical Commission (24 June 1914, AAS 6 (1914) 417–418) told the two
apart: canonicity "de fide definitum est", Paul's authorship its own
answer, his giving the letter its final form not required. Whether a name
in a definition's list is part of what it defines is a reading for a
later step.

The decretal of CO1 is hypothetical: the Pseudo-Isidorian decretals and
the Donation of Constantine are not entered, nor any text of Gratian or
of the *Decretales*.

The *Testamentum*'s date is its colophon's, as a description of Oxford,
Corpus Christi College MS 244 reports it; Llull's last works date from
December 1315, his death from early 1316.

## STANDARDS

- CIC 1983 cc. 6 §1, 20, 21, 29, 30, 31, 33, 34, 753, 1108 §1, 1111, 1117
- CIC 1917 cc. 1094, 1095 §2, 1096 §1, 1099 §§1–2; Benedict XV,
  *Providentissima Mater Ecclesia* (27 May 1917), AAS 9/II (1917)
  (https://www.iuscangreg.it/cic1917.php)
- Pius XII, motu proprio *Decretum Ne temere* (1 August 1948), AAS 40
  (1948) 305–306
- John Paul II, *Sacrae disciplinae leges* (25 January 1983)
- Benedict XVI, *Summorum Pontificum* (2007); Pontifical Commission
  *Ecclesia Dei*, *Universae Ecclesiae* (2011); Francis, *Traditionis
  custodes* (2021)
- Gregory IX, *Rex pacificus* (1234)
- DH 71–72, 284, 470, 525, 527; CCC 105–106, 120, 246–248
- Augustine, *De Trinitate* XV.17.29, XV.26.47; Photius, *Mystagogia*
- H. Koch, "Proklus als Quelle des Pseudo-Dionysius Areopagita in der
  Lehre vom Bösen", *Philologus* 54 (1895); J. Stiglmayr, "Der
  Neoplatoniker Proclus als Vorlage des sog. Dionysius Areopagita in der
  Lehre vom Übel", *Historisches Jahrbuch* 16 (1895) 253–273
- Thomas Aquinas, *Super librum De causis expositio* (1272), prooemium
- J. N. D. Kelly, *The Athanasian Creed* (1964)
- *The Cloud of Unknowing*, ch. 70; *Imitatio Christi* I.5
- Pontifical Biblical Commission, *De epistola ad Hebraeos* (24 June 1914)

## SEE ALSO

[ttc-saeculum(7)](saeculum-preregistration.md), [ttc-cceo(7)](cceo-preregistration.md),
[ttc-communion(7)](communion-preregistration.md), [ttc-creed(7)](creed-preregistration.md),
[ttc-canon(5)](../canon-law-layer.md), [ttc-roadmap(7)](../roadmap.md)

## SCORING

Appended after the runs. Predictions committed in 83ebca4, stamped in
8a295cd. Encoded in `sources.lp` (new: authorship), `canon_law.lp` (the
Code of 1917's form, cc. 1094 and 1099, with Pius XII's change; the form of
1983 read through its texts; c. 6 §1 n. 1; c. 20 typed; c. 21; cc. 29–30,
33–34; collections), `canon_cceo.lp` (c. 834 §2 dated), `icon_authority.lp`
(particular councils), `icon_history.lp` (the Filioque's Latin witnesses;
the authorship parts), `canon_cases.lp`, `engine.py`. Scenarios TX, GN, CO,
AU, FW (21; 512 in all); CR1b, FQ19, FQ20 and LW9 changed, each with its
reason in `suite.py`. The predictions' FQ are scenarios FW and CR1b (the
FQ ids were taken).

| | Result |
| --- | --- |
| TX1 | Held (TX1). A priest delegated in 1950 assists validly, one not delegated invalidly. |
| TX2 | Held (TX2). |
| TX3 | Held (TX3), and each condition of the clause needed: one not raised outside, one marrying a Catholic, one born of Catholics, all bound in 1948. |
| TX4 | Held (TX4): `no_text_in_force`, and the bond, at issue, not computed. |
| TX5 | Held (TX5): over every marriage of the base, one code each, the date's. |
| TX6 | Held: no marriage case's output changed. |
| GN1 | Held (GN1). |
| GN2 | Held (GN2). |
| GN3 | Held (LW9, its expectation extended, as stated). |
| GN4 | Held (GN4): in force on 15 July 2021, ceased on the 16th. |
| GN5 | Held (GN5). The executory decree whose law was revoked ceases with it (c. 33 §2). A provision has no route by which it could change a law's reach: an exemption would be a derogation, which c. 34 §2 forbids. |
| GN6 | Held (GN6), by every route of c. 8 §1 (a unit test). |
| CO1 | Held (CO1). As of 1600, before the witness, the private collection's text rests on its attribution. |
| AU1 | Held (AU1). |
| AU2 | Held (AU2). |
| AU3 | Held (AU3): refused from 1964; as of 1950 both ways, never preferred. |
| AU4 | Held (AU4). |
| AU5 | Held (AU5). Evidence apart from every claimant would show one attribution, and a claimant's own word shows none (HYPOTHETICAL, `attribution_shown_hyp`). |
| AU6 | Held in part. The Cloud is shown without a name on both of the Corpus's branches, and an author entered for it without a claim is refused. Its citation of "Saint Denis" is entered as a claim of the Corpus's attribution, not as a dependence: no date can refute a dependence on an older text, so the fact tested nothing. |
| AU7 | Held: a test. |
| AU8 | Held (AU8). |
| FQ1 | Held (CR1b, changed as stated). |
| FQ2 | Held (FW2). |
| FQ3 | Held (FW3). Without a name exactly where Damasus is not its author; a pope's letter in form only on the branch of the claim. |
| FQ4 | Held (FW1). |
| FQ5 | False in part. FQ19 and FQ20 changed as stated; FQ18, CR1 and CR1d did not. CR1e changed: with the two councils and the creeds' parts relaxed, Leo I's letter cleaves beside Paul VI's Credo. The communion scenarios changed too (M1). |
| M1 | False in part. Beyond CR1b, FQ19, FQ20 and LW9: CR1e (FQ5), and seven communion scenarios (FD1, FD3, FD4, FD5, CN2, CN3, FC1), where Leo I's letter is now owed religious submission (c. 752, by reference). The TTC-SCHOOLS tables did not change; the step's scenarios stay out of the stamped boot set, as every later group's do. |
| M2 | Held after closing gaps. Each new statement was deleted in turn (19 in `sources.lp`, 62 in `canon_law.lp`, 47 in `canon_cases.lp`, 42 in `icon_history.lp`, 2 in `icon_authority.lp`, 2 in `canon_cceo.lp`) against the scenarios that read them, and each survivor again. Closed on the way: each witness on the monarchy, by the weights; each claimant and each witness of the Corpus, now shown (`attribution_claimed/3`; the refusal names its witness); the *Fides Damasi*'s form and its want of a name on their branches; an attribution shown by evidence apart from its claimants; a witness that is a source (Thomas's commentary); the bodies of void decrees, now reported (`text_of_void_decree/2`); the 1915 marriage's bond at issue. Removed as testing nothing: the baptisms of parties whose silence already binds, a second clock in `revocation_dated`, three years no rule read, the Cloud's dependence (AU6). None survives. CL1 and PR4 clean. |
| M3 | Held: no unit changes status; the rule files cite CCC 105, 106, 120, 247 and 248 (39 paragraphs). |

### Caveats, read

- **The Code of 1917.** c. 1094 is quoted from a canonist's citation;
  c. 1099 §1 n. 1 read in *Annales Canonici* 16 (2020) 2, n. 4 ("Omnes in
  catholica Ecclesia baptizati et ad eam ex haeresi aut schismate conversi,
  licet sive hi sive illi ab eadem postea defecerint, quoties inter se
  matrimonium ineunt"); c. 1099 §2 in a second canonist. c. 1095 §2,
  c. 1096 §1 and Pius XII's operative words were not read: TX1 rests on
  c. 1094's "sacerdote ab alterutro delegato". Not encoded: c. 1099 §1 n. 3
  (Eastern faithful marrying Latins), the supply of jurisdiction in common
  error (1917 c. 209) at a marriage, *Ne temere* (1908).
- **The Filioque's witnesses.** DH 284, 525 and 527 read in translation;
  Toledo III's profession in the critical text. Leo IX (1053) and
  Toledo IV are not entered.
- ***Universae Ecclesiae*** is dated by its own date (30 April 2011); it
  was published on 13 May. *Summorum Pontificum*'s revocation by direct
  contrariety is the encoder's reading, entered as a fact.

### Not predicted

- **Leo I's letter is owed religious submission** (c. 752) in the
  communion scenarios: a pope's authentic teaching at tier 3. The Toledan
  councils are not: a particular council's teaching is owed by the
  faithful entrusted to its bishops (c. 753), which the base does not
  compute, so the encoding keeps them out of what all owe. A rule, added
  in `icon_authority.lp`.
- **CCEO c. 834 §2 dated.** The Eastern rule on the form for liceity only
  now reads the Eastern Code's force, as TX's principle asks; no output
  changed.
- **Thomas's commentary on the *Liber de causis*** is a source of the
  record (tier 5, a Doctor's from 1567), the witness dated by its year.
- **The decretal's attribution is refused in both collections** (CO1); in
  the authentic one the refusal changes nothing, as predicted, but it is
  reported.
- **Four tests' scope.** The notes check (NT1) groups branches by
  attribution claims as it does by reception: a claim splits the worlds
  compared. FW1–FW3 change under monopatrism, the Thomistic stack and
  encoding A of DH 1330, as FQ19 does: the group is kept out of the
  monopatrism test and of encoding A's, as the creed's groups are, and the
  three are added to the Thomistic stack's list.
