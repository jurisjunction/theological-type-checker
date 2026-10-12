# TTC-PENAL(7)

## NAME

**ttc-penal** — the canon step: abortion and the limits of a latae
sententiae penalty, the general penal norm, the supreme law, the
Dicastery's clause on age; two repairs, form and object and fictions of
law; predictions, committed before encoding

## DESCRIPTION

Read as the rules stand, before any run:

- **No delict of abortion.** The moral library says direct abortion "must
  not" in every main branch (TTC-PRECEPT DI3). The canon layer has
  neither c. 1398 (1983) nor c. 1397 §2 (2021).
- **Two vocabularies of intrinsic evil.** c. 1323 n. 4's exception reads a
  classification of the event (`of_kind(E,intrinsically_evil)`), entered
  case by case; the moral library composes an act's kind and its object
  (`evil_by_object/1`). Nothing joins them.
- **c. 16 ignores the dates it has.** Every authentic interpretation is
  recorded with its date (`promulgated/2`), but the rule that applies one
  in the form of law never compares that date with the act's
  (`promulgated(A,_)`): it binds every act that needs its reading, before
  its force as after. c. 16 §2's rule on retroactivity, and c. 9's, are
  not encoded.
- **No general penal norm.** Neither c. 1399 nor c. 1752 is encoded.
- **The Dicastery's clause** on a minor's age is not encoded; TTC-ACT's
  N1–N5, stamped, wait for this step.
- **Tier by form alone.** An ex cathedra act is tier 1 whatever it
  defines; `definitive_declaration` is a form of tier 2 with no warrant,
  so any source of that form is refused (roadmap, "Form and object").
- **Whoever acts is a creature.** `act.lp` makes anything with `act_of/2`
  a creature that acts: a state entered as an actor would get human acts,
  interiors and sin on the claims (roadmap, "Fictions of law"). The SSPX
  part says an offence of a body:
  `info(offense(sspx,dissent_c752,dignitatis_humanae))`.

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited. (First committed
in d7792b3 and amended before the stamp: c. 16's dates, cc. 8 §1 and 9,
AB8, AB9, CAVEATS. The response of 1988 is extensive on the canonists'
common reading, so it does not branch.)

## THE NORMS

Fixed here. Texts from vatican.va (Book VI as revised in 2021; Books I
and VII) and iuscangreg.

- **c. 1397 §2** (2021): "A person who actually procures an abortion
  incurs a *latae sententiae* excommunication." Before 8 December 2021,
  **c. 1398** (1983): one who procures an abortion, *effectu secuto*.
- **The authentic interpretation** (Pontifical Commission for the
  Authentic Interpretation of the Code, 19 January 1988, approved by
  John Paul II on 23 May 1988; AAS 80 (1988) 1818–1819): abortion in
  c. 1398 is not only "eiectio fetus immaturi" but also "eiusdem fetus
  occisio quocumque modo et quocumque tempore a momento conceptionis"
  ("Negative ad primam partem; affirmative ad secundam").
- **c. 16 §2**: an authentic interpretation in the form of law "has the
  same force as the law itself and must be promulgated. If it only
  declares the words of the law which are certain in themselves, it is
  retroactive; if it restricts or extends the law, or if it explains a
  doubtful law, it is not retroactive."
- **c. 9**: "Laws regard the future, not the past, unless they expressly
  provide for the past." **c. 8 §1**: universal laws are promulgated in
  the *Acta Apostolicae Sedis* and take force three months from the date
  of that issue, unless they bind at once from the nature of the matter
  or set another *vacatio*.
- **cc. 1323–1325**: under sixteen, no penalty (c. 1323 n. 1); grave
  fear exempts "unless the act is intrinsically evil or tends to the harm
  of souls" (n. 4), and then mitigates (c. 1324 §1 n. 5); sixteen to
  eighteen mitigates (n. 4); the penalty unknown without fault mitigates
  (n. 9); in every circumstance of c. 1324 §1, "the offender is not bound
  by a *latae sententiae* penalty" (§3); crass, supine or affected
  ignorance never counts (c. 1325).
- **c. 1328 §1**: one who attempts "is not bound by the penalty prescribed
  for the completed offence", unless the law provides otherwise.
- **c. 1329 §2**: accomplices not named in the law incur a latae
  sententiae penalty if without their assistance the delict would not
  have been committed and the penalty can affect them; otherwise they can
  be punished by ferendae sententiae penalties.
- **c. 1399**: "Besides the cases prescribed in this or in other laws,
  the external violation of divine or canon law can be punished, and with
  a just penalty, only when the special gravity of the violation requires
  it and necessity demands that scandals be prevented or repaired."
- **c. 1752**, the last canon, closing the procedure for the transfer of
  pastors (cc. 1748–1752): "canonical equity is to be observed, and the
  salvation of souls, which must always be the supreme law in the Church,
  is to be kept before one's eyes."
- **The Dicastery's norms** (11 October 2021), art. 6 n. 1, with c. 1398
  §1 n. 1 (2021); art. 29: the canons on delicts and penalties "of each
  Code" apply with the norms.
- **cc. 113–120**: the Catholic Church and the Apostolic See "have the
  character of a moral person by divine ordinance itself" (c. 113 §1);
  juridic persons are "subjects in canon law of obligations and rights
  which correspond to their nature" (§2), constituted by law or by decree
  (c. 114 §1), represented by those competent (c. 118), "perpetual by
  nature" (c. 120 §1). Innocent IV, *Romana ecclesia*: "In universitatem
  vel collegium proferri excommunicationis sententiam penitus prohibemus"
  (VI 5.11.5).

## THE REPAIRS

Fixed here.

### Form and object

- **The form says whether an act defines; the object gives the grade.**
  A definition of a truth proposed as revealed is tier 1; of a truth
  connected with revelation (a secondary object, a dogmatic fact), tier 2
  (*tenendam*, DH 3074). The object is shown by the act's text, or
  claimed and computed both ways.
- **A declaration of grade is a definition or a claim.** A papal act that
  declares a teaching to be held definitively without defining it keeps
  its own tier, 3, and carries a claim of the ordinary universal
  magisterium whose claimant is its author ("not a new dogmatic
  definition", CDF 1998, n. 9).
- **Only the force of tier 2 waits on tier 1** (`t2_truth`), unchanged.

### Fictions of law

- **Four sorts of subject.** A physical person; a juridic person, by law
  or by decree (cc. 113 §2, 114); a moral person by divine ordinance
  (c. 113 §1); a group without status, a name for persons. Only a
  physical person places a human act.
- **A juridic person acts through those who represent it** (c. 118): an
  act recorded in its name is placed by them. A unity of order, not a
  substance (*In I Ethic.* lect. 1); a people, "a multitude of rational
  beings united by common agreement on the objects of their love" (*De
  civ. Dei* XIX.24); a society, "a group of persons bound together
  organically by a principle of unity that goes beyond each one of them"
  (CCC 1880).
- **No interior, no sin on the claims, no delict, no penalty** of
  anything but a physical person (*Romana ecclesia*).
- **Verdicts are of acts and stand.** Structures of sin are "the
  expression and effect of personal sins" (CCC 1869; RP 16; SRS 36):
  said across an analogy bridge with that mode, never of the collective
  as such.
- **The Church is another sort.** c. 113 §1's two moral persons are not
  fictions. Predicates of holiness reach the Church by relation to her
  Head; not encoded in this step.

## METHOD

Encode c. 1397 §2 and c. 1398 (1983) with the interpretation of 1988;
give c. 16 §2 its dates, with cc. 8 §1 and 9; join c. 1323 n. 4 to the library's kinds; encode
cc. 1328 §1, 1329 §2, 1399 and 1752; art. 6 n. 1 with c. 1398 §1 n. 1
(2021), and score TTC-ACT's N1–N5. Repair form and object in
`icon_authority.lp`; add the Jansenist dogmatic fact and *Ordinatio
sacerdotalis* to the history. Add the sorts of subject to `act.lp`. Each
canon under `% @norm` with its text. Cases, all HYPOTHETICAL: TTC-PRECEPT's
acts with mothers and accomplices; ages fifteen, seventeen and adult;
fear; the penalty unknown, without fault and by affected ignorance; an
attempt; a killing in utero in 1987 and in 1990; a mother baptized
outside the Church; c. 1399 on an act no canon names; a transfer of a
pastor; an act in a juridic person's name. Run the whole suite, the
runtimes' boots and the coverage index.

## PREDICTIONS

### AB: abortion

- **AB1. The matter from the library.** c. 1397 §2 (c. 1398 before
  8 December 2021) reaches a completed act whose kind is the direct
  killing of an innocent and whose victim is unborn; the canon layer
  gains no kind of its own. On TTC-PRECEPT's acts: the direct abortion
  is the delict; the craniotomy is the delict where it is direct (on
  each reading of `q(direct_by)`, and the disputed choice), the fetus
  being killed before birth "at whatever time"; the salpingectomy,
  licit by double effect on the claims, is not; the salpingostomy and
  methotrexate are the delict exactly where they are direct. The canon
  follows the verdicts act by act.
- **AB2. The attempt.** An abortion attempted and not completed is not
  the delict (c. 1328 §1); the act is still "must not".
- **AB3. Two texts, one content.** Each act is judged by the text in
  force on its date; no act is reached by both.
- **AB4. The exemptions, through the library.** With no claim, the
  penalty is incurred in the external forum (c. 1321 §4). A mother under
  sixteen is exempt; at seventeen, mitigated and not bound by the latae
  sententiae penalty. The penalty unknown without fault: not bound;
  unknown by affected ignorance: the ignorance disregarded, bound. Grave
  fear: not exempt, the act being intrinsically evil (c. 1323 n. 4's
  exception, read from the library's kind); mitigated, so not bound. In
  every one of these branches the act is "must not": the penalty falls
  away, the verdict does not.
- **AB5. One kind, two canons.** c. 1323 n. 4's "intrinsically evil"
  reads the library (an act whose kind is evil by its object) as well as
  a classification of the event; TTC-ACT's AC scenarios do not change.
- **AB6. Accomplices.** A necessary accomplice (a disputed fact, computed
  both ways) incurs the excommunication (c. 1329 §2); one not necessary
  does not, and may be punished by a penalty to be imposed. Each
  accomplice is exempted or mitigated by his own claims, never by
  another's.
- **AB7. c. 11.** A mother baptized outside the Church and not received
  incurs nothing; her act is still "must not" (divine law binds all).
- **AB8. The interpretation and its date.** An interpretation in the form
  of law reaches the acts placed from its force on (c. 8 §1), and an
  earlier act only where it is entered as declaring words certain in
  themselves (c. 16 §2): the past is the exception (c. 9). The response
  of 1988 is entered as extensive, the canonists' common reading, with
  its ground in its own text: asked whether abortion means only the
  expulsion of the immature fetus, it answers "Negative". It does not
  branch. A killing in utero without expulsion in 1987 is not the delict
  (c. 18 reads c. 1398 strictly: the expulsion of the immature fetus); in
  1990 it is.
- **AB9. The same rule for *Ecclesia Dei*.** In the branch where its
  reading of c. 751 is given in the form of law, whether it declares
  words certain in themselves is disputed with its form and computed both
  ways. It reaches the consecrations of 30 June 1988, two days before it,
  only where declaratory. Where it is not, c. 18 reads c. 751 strictly
  and there is no c. 1364 (1983) delict for 1988 in that branch; c. 1382
  (1983) reaches consecrator and consecrated as before. No existing check
  changes: LW1 tests 1988 in the particular-matter branch.

### GP: the general penal norm

- **GP1.** c. 1399's penalty is to be imposed, never incurred. Its two
  conditions, special gravity and the need to prevent or repair scandal,
  are judgments of the competent authority, supplied, never computed.
  Without them, nothing.
- **GP2.** Its matter is an external violation of divine or canon law,
  read from the library (an act "must not", or forbidden by a law that
  binds the person). It reaches only those c. 11 binds, even where the
  law violated is divine.
- **GP3.** Where a specific canon reaches the act, c. 1399 adds no title
  ("besides the cases prescribed").

### SA: the supreme law

- **SA1.** c. 1752 has no effect to encode. It binds the authority
  deciding a transfer to observe equity and keep the salvation of souls
  in view: a judgment, supplied. In the norm graph it feeds nothing.
- **SA2.** A candidate that reads "salus animarum suprema lex" as a power
  to set aside a penalty the law attaches (an excommunication treated as
  not incurred because souls would be better served) is refused:
  canonists never weigh against the law (rule 2). The law's own remedies
  (exemption, mitigation, remission) are the routes. In a non-penal
  lacuna it may enter through c. 19's equity, supplied.

### N: the Dicastery's clause

- **N1–N5** of TTC-ACT, stamped with that step, are scored here as
  written. The clause is encoded with c. 1398 §1 n. 1 (2021).
- **N6.** Art. 29 applies the canons "of each Code"; the Eastern Code's
  are not encoded (roadmap, cceo).

### FO: form and object

- **FO1.** The ex cathedra acts in the base keep tier 1: *Ineffabilis
  Deus* and *Munificentissimus Deus* define truths as revealed (DH 2803,
  3903); *Cum occasione* condemns propositions as heretical
  (DH 2001–2007). A synthetic ex cathedra definition of a connected truth
  (HYPOTHETICAL) is tier 2 and raises no violation; entered at tier 1,
  it is refused.
- **FO2. Jansen's sense.** The condemnation of the five propositions
  (*Cum occasione*, 1653) and the fact that they are in the *Augustinus*
  in its author's sense (*Ad sanctam beati Petri sedem*, 1656,
  DH 2010–2012) are two questions with two objects: Arnauld's right and
  fact (1655). On its text, *Ad sanctam* shows *Pastor aeternus*'s
  conditions and defines a dogmatic fact: tier 2. The attribution is held
  definitively where `t2_truth` holds and is a counterfactual shadow
  without it; Arnauld's denial (tier 5) is its contrary. The question of
  right does not change. If the text fails a condition, FO2 is false and
  the attribution is authentic.
- **FO3. Respectful silence.** *Vineam Domini* (1705) refused silence as
  the assent owed. The checker agrees by construction: silence takes no
  censure (omission is not denial), and assent, being interior, is never
  computed. A candidate that takes silence, or an outward profession, as
  inward assent is refused (rule 3).
- **FO4. A declaration that defines nothing.** *Ordinatio sacerdotalis* 4
  (1994) enters at tier 3 with a claim of the ordinary universal
  magisterium whose claimant is its author. The CDF's responsum (1995:
  "belonging to the deposit of the faith") and commentary (1998, n. 11:
  c. 750 §2) are further claimants, so the grade is computed both ways.
  Where grade 1 holds, de fide; grade 2, definitive; neither, authentic.
  No branch resting on the claim is preferred by weight (c. 749 §3). The
  letter and both documents are flagged as tier 3 speaking of a higher
  tier. `definitive_declaration` no longer gives tier 2, and no source of
  that form is refused for want of a warrant.
- **FO5.** No source added in this step fixes `t2_truth`.

### FL: fictions of law

- **FL1.** An act recorded in a juridic person's name is placed by its
  representatives: they are the library's agents, the juridic person
  never. The act's verdict stands.
- **FL2.** An interior, a sin on the claims, a delict or a penalty of a
  juridic person, or of a group without status, is a violation. "The
  state is evil", entered as a candidate (the state as agent of an act
  evil by its object, with a claim of consent), is refused, not answered.
- **FL3.** The Church and the Apostolic See are typed by c. 113 §1; none
  of FL2's violations fires for them, and no predicate of holiness
  enters.
- **FL4. The Society.** The SSPX part's
  `info(offense(sspx,dissent_c752,dignitatis_humanae))` is said of a
  group without canonical status (`q(canonical_status)`, none). It is
  re-typed: the Society's refusal is a public position, a text's matter;
  an offence is said only of a person who professes it, and none is
  recorded. SX8's category error stands. `q(society_schism_now)` is a
  body's standing in communion, read from its bonds, not an offence; SX6
  and SX10 do not change. No check reads the re-typed info.
- **FL5.** No existing case enters an act, interior or delict of a
  non-physical person; no existing check changes.
  `collective_declaration` (a class statement treated as a declaration)
  is the same rule for classes, unchanged.

### M: meta

- **M1.** No earlier check changes. The SSPX scenarios gain AB9's branch
  in the law-form world; FL4's info is re-typed. The TTC-SCHOOLS tables
  do not change.
- **M2.** Every new rule has a test that fails without it; CL1 and PR4
  stay clean.
- **M3.** In the coverage index, "The person and society" (CCC 1878–1896)
  leaves the frontier for rules; the rule files cite CCC 1869, 1880 and
  2272.

## CAVEATS

c. 1397 §2 takes its matter from the moral library. A canonist may read
"abortion" apart from moral theology: the killing of a viable fetus
during labour as homicide (c. 1397 §1), say. That reading is not entered.

The response of 1988 is entered as extensive because canonists read it
so and its text supports them (AB8); were the reading disputed, it would
branch (rule 2). *Ecclesia Dei*'s reading is disputed with its form, and
computed both ways (AB9).

Remission is not encoded: c. 1355 §2, and the faculty given to every
priest to absolve the sin of procured abortion (*Misericordia et misera*
12, 2016). Nor is c. 1328 §2.

*Ad sanctam*'s text is checked against DH 2010–2012 at encoding (FO2).

The four sorts of subject are the encoder's reading of cc. 113–114 with
Thomas. *Romana ecclesia*'s date and setting (the council of Lyons, or a
later constitution of Innocent IV) are to check: it is not among the
council's constitutions in Tanner's edition.

In AB4 the act stays "must not" while the penalty falls away. The
checker never says that a person sinned; the penalty's falling away is
the external forum's.

## STANDARDS

- CIC 1983 cc. 8 §1, 9, 11, 16 §2, 18, 113–120, 749 §3, 1321 §4, 1323 nn. 1, 4,
  1324 §1 nn. 4, 5, 9, §3, 1325, 1328 §1, 1329 §2, 1398 (1983), 1752;
  CIC 2021 cc. 1397 §2, 1398 §1 n. 1, 1399
  (https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html)
- Pontifical Commission for the Authentic Interpretation of the Code,
  response on c. 1398, 1988, AAS 80 (1988) 1818–1819
  (https://www.vatican.va/roman_curia/pontifical_councils/intrptxt/documents/rc_pc_intrptxt_doc_22091998_authentic-interp_lt.html)
- Dicastery for the Doctrine of the Faith, *Norms on delicts reserved*
  (11 October 2021), artt. 6, 29
- John Paul II, *Ecclesia Dei adflicta* (1988) 3
- Vatican I, *Pastor aeternus* ch. 4 (DH 3074); Pius IX, *Ineffabilis
  Deus* (DH 2803); Pius XII, *Munificentissimus Deus* (DH 3903)
- Innocent X, *Cum occasione* (1653, DH 2001–2007); Alexander VII, *Ad
  sanctam beati Petri sedem* (1656, DH 2010–2012); Clement XI, *Vineam
  Domini* (1705); A. Arnauld, *Seconde lettre à un duc et pair* (1655)
- John Paul II, *Ordinatio sacerdotalis* (1994) 4; CDF, *Responsum ad
  dubium* (28 October 1995); CDF, *Doctrinal Commentary on the Concluding
  Formula of the Professio fidei* (1998) nn. 9, 11
- Innocent IV, *Romana ecclesia* (VI 5.11.5)
- Aquinas, *In I Ethic.* lect. 1; Augustine, *De civitate Dei* XIX.24
- John Paul II, *Reconciliatio et paenitentia* (1984) 16; *Sollicitudo
  rei socialis* (1987) 36
- CCC 1869, 1880, 2270–2275

## SEE ALSO

[ttc-act(7)](act-preregistration.md), [ttc-precept(7)](precept-preregistration.md),
[ttc-communion(7)](communion-preregistration.md), [ttc-canon(5)](../canon-law-layer.md),
[ttc-roadmap(7)](../roadmap.md)

## SCORING

Appended after the runs. Predictions committed in d7792b3, amended before
the stamp in 7433211, stamped in 60d7513. Encoded in `canon_law.lp` (c. 16
§2's dates with cc. 8 §1 and 9; cc. 1397 §2 and 1398 (1983) with the
interpretation of 1988; cc. 1328 §1, 1329 §2; c. 1398 §1 n. 1 with the
Dicastery's art. 6 n. 1; c. 1321 §2's principle; c. 1399; c. 1752;
c. 113), `act.lp` (the sorts of subject), `faith.lp` (assent never
computed), `icon_authority.lp` (form and object), `icon_history.lp`
(Jansen's sense; *Ordinatio sacerdotalis*; the Society's position),
`canon_cases.lp`, `norms.py` (`@recursive`). Scenarios AB, GP, SL, N, FO,
FL (25; SA1 and SA2 were renamed SL1 and SL2, those ids being taken).

| | Result |
| --- | --- |
| AB1 | Held. The direct abortion is the delict, for the doctor and for the mother who procures it; the craniotomy where it is direct (each reading of `q(direct_by)`, and the chosen death), not where it is not; the salpingectomy never; the salpingostomy and methotrexate exactly where they are direct. A check pins it: in every main branch the delict and the verdict "must not" as a direct killing coincide, act by act. |
| AB2 | Held (AB2). |
| AB3 | Held (AB3). |
| AB4 | Held (AB4), in the main branches. |
| AB5 | Held (AB5), and more is visible: in the shadow branch where the direct killing is not evil by its object, fear exempts. c. 1323 n. 4 reads the kind branch by branch. The AC scenarios did not change. |
| AB6 | Held (AB6). |
| AB7 | Held (AB7). |
| AB8 | Held (AB8). |
| AB9 | Held in its main clauses, false in its last. Given as law and not declaratory, *Ecclesia Dei* does not reach 30 June 1988; c. 18 reads c. 751 strictly and there is no c. 1364 (1983) delict for 1988 in that branch; c. 1382 reaches consecrator and consecrated. But two existing checks changed, not none. LW1 required that no strict reading appear in the law-form world; it now appears there for 1988 where the reading is not declaratory, and the check is narrowed to 2026. FC1 required Abp Lefebvre's bond of governance broken in every main branch; where the reading does not reach 1988 his bond stands, and he is in full communion by c. 205. Both changes are stated in the suite. |
| GP1 | Held (GP1). |
| GP2 | Held (GP2). |
| GP3 | Held (GP3). |
| SA1 | Held (SL1): no effect but a judgment kept in view; c. 1752 feeds nothing in the norm graph. |
| SA2 | Held (SL2). |
| N1 | Held (N1). TTC-ACT's prediction scored here: the act is unlawful apart from the age (c. 277 §1), and the clause raises no violation. |
| N2 | Held (N2). Without the clause, the claim of invincible error exempts and vincible error leaves culpa unpunished (c. 1321 §3); with it, the penalty is to be imposed in both branches; the claim is still computed both ways. |
| N3 | Held (N3). |
| N4 | Held (N4). The flag is c. 1321 §2's principle: a law that disregards an error is coherent only where the act is unlawful apart from what the error concerns. |
| N5 | Held (N5): refused as a decree, with the exemption back; both ways where the rank is disputed. |
| N6 | Held as a statement: art. 29 is recorded with the norm; the Eastern Code waits for the cceo step. |
| FO1 | Held (FO1). |
| FO2 | Not scored. *Ad sanctam*'s text (DH 2010–2012) could not be read here: the secondary sources show "this declaration and definition" and a decision binding all the faithful, not apostolic authority or the pastor of all. By rule 14 it stands at tier 3 as shown, its own word a claim (`ad_sanctam_as_shown`), and the attribution is authentic. With the five conditions shown (`ad_sanctam_defined`, HYPOTHETICAL) it is tier 2 and definitive, the question of right unchanged. The text is on the fetch list. The prediction's wording also slips: it is the denial, not the attribution, that is a counterfactual shadow on `t2_truth` and live without it (NT1). |
| FO3 | Held (FO3). A test pins it: `assents/2` is derived only in the candidate. |
| FO4 | Held (FO4). |
| FO5 | Held (FO5). |
| FL1 | Held (FL1). |
| FL2 | Held (FL2). |
| FL3 | Held (FL1: the pope acts for the Apostolic See, which is never an agent; no violation). |
| FL4 | Held (FL4). SX6, SX8 and SX10 unchanged. |
| FL5 | Held. |
| M1 | False in part. LW1 and FC1 changed (AB9). Otherwise as predicted: the SSPX scenarios gained AB9's branch (their model counts by half again) and FL4's re-typed info; SM6's one model changed (mode "one"; its check unaffected); every output gained *Ad sanctam* on the fetch list. The TTC-SCHOOLS tables did not change, and NT1's slow test holds over all 462 scenarios. |
| M2 | Held after closing gaps. Each new statement was deleted in turn (67 in `canon_law.lp`, 8 in `act.lp`, 2 in `faith.lp`, 8 in `icon_authority.lp`, 38 in `icon_history.lp`, 72 in `canon_cases.lp`). Closed on the way: the rank of the clause disputed, both ways; an interpretation's reach for a lasting situation, judged before its force and after; an interpretation in the form of law with no date of force, refused; each abortion canon's penalty, excommunication in its own years; the clause's error recorded; a person's dissent beside the Society's position, and the Society recognized as a juridic person; c. 1399 with a judgment given, and with the person received into the Church; the mother received, bound; the candidate of the supreme law with its own effect; a declaration entered at tier 2, refused; a connected definition at tier 1, refused though warranted; Arnauld's weight against the attribution; the letter and the responsum cleaving the denial; the state's act still "must not". Redundant fixtures removed: a duplicated `act_of`, two unused dates, an unused support. What survives: one display rule (`info(abortion_reading/2)`). CL1 and PR4 clean. |
| M3 | Held: "The person and society" leaves the frontier (42 units under rules, 9 under cases, 36 frontier); the rule files cite CCC 1869, 1880 and 2272 (26 paragraphs). |

### Not predicted

- **c. 1329 is recursion over persons.** One person's delict defined by
  another's made the norm graph draw cycles through every delict norm. It
  gained a tag beside `@temporal`: `@recursive`.
- **Data out of norms.** The list of latae sententiae canons, and the
  readings of "abortion" with the interpretation's record, moved out of
  the norms that use them, as c. 751's and c. 915's readings already were;
  otherwise the graph drew false cycles.
- **A lasting situation with no clock.** c. 915's case has no evaluation
  date; dated interpretations would have stopped reaching it. With no
  clock, the present is assumed.
- **Two scenarios shared ids** (SA1, SA2, salience): the new ones were
  renamed, and a test now keeps ids unique.
- **The extraction and the older reading.** On "the expulsion of the
  immature fetus", the 1902 extraction is an expulsion in the letter; the
  canon layer takes abortion only as the direct killing, so where the
  salpingostomy is not direct it is no delict on either reading (roadmap).
