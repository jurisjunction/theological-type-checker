# TTC-MODERNITY(7)

## NAME

**ttc-modernity**: the four causes, horizons traced over them, and a DAG of
modernities as runtimes. Predictions, committed before encoding.

## DESCRIPTION

Read as the rules stand at `9545369` (`main`, TTC-LINGUAE and
TTC-REPAIRS5 merged):

- **No vocabulary for the causes.** Nothing types an argument by the cause
  it rests on: `caused_by/2` orders events, and `formal_cause_essence/0`
  belongs to grace. The base cannot say that a reason rests on an end or
  on a form.
- **Authority is by form.** A tier-3 act holds its value however it argues
  (rule 14). Its arguments are not entered at all, so nothing can say
  which of them a reader can still follow.
- **Runtimes are schools.** There are `default`, `thomist`, `scotist`,
  `suarezian` and `palamite`, all medieval or early modern scholastic,
  beside `bare` and TTC-LINGUAE's `saussure`, `vocal` and `lingual`. L
  allows several parents: two parents clash on a part one has and the
  other excludes, and the child does not compile until it says `add`,
  `exclude` or `alter` for it.
- **A hearing has no horizon.** TTC-LINGUAE computes what a hearing
  carries of an argument's premises (`carried_for`, `lost_for`), but its
  hearer is only a name, and what he cannot hold is entered by hand
  (`horizon_lacks/3`). Nothing joins a hearing to the causes a runtime
  holds, and a premise lost in translation leaves nothing behind.

The discussion that found this was the run of 23 October 2026 on property
and intellectual property. As a snippet, each argument was entered as its
own source, typed by its causes, and "modernity" was the Thomist runtime
with final and formal causality traced out. The predictions were written
first (sha256 `82b064cb…`), and all four held:

- In the full horizon, *Rerum Novarum*'s conclusion (property by nature)
  is carried by RN 7 and RN 13, and RN 9's argument from labour is idle.
- In the traced horizon, RN 9 alone carries it, and the universal
  destination of goods loses every ground.

The snippet had two defects. It gated authority on the argument, which
breaks rule 14. And it named one modernity, where the history has several.

The proposal:

- The four causes become a library.
- A horizon is the set of causes a runtime holds.
- A trace leaves the authority graph untouched and changes only which
  reasons are available: it reports a value held with no reason the
  horizon can see, and a teaching act left with a single reason.
- A guest horizon can run inside a host in the same solve (the VM), so
  the bridge between them is computed.
- A horizon hears in a tongue. An argument reaches it as its hearing
  carries the premises, and the analogy a premise crosses by is named. A
  premise lost leaves a shorter argument, which reaches the hearer only
  where a claim says it still concludes.
- Modernity is not one runtime but a DAG of them, each node a figure with
  the parents the record documents, contested edges included and marked.
- Where a figure is read two ways, both readings are nodes, and both run.
  So is an argument read two ways.
- Each case partitions the 1,024 possible horizons by what it reports. The
  parts the report depends on, and the classes it falls into, are the
  case's phase diagram, and the figures are placed on it.
- A measure that turns a final cause into an efficient force is refused,
  save where final causality survives only as desire.
- The will's act has a form of its own in two senses that oppose each
  other: Thomas's object, and Kant's form of the law. They are two parts,
  and Kant's is the one part modernity adds rather than traces.

## THE TEXTS

The evidence record is `docs/research/modernity-sources.md`. It gives every
primary locus with its status: [V] checked against the text, [S] through a
named secondary source, [M] not re-checked. The loci that decide the
encoding:

| Figure | Holds | Locus |
| --- | --- | --- |
| Thomas | Every agent acts for an end. Natural necessity is "a kind of impression from God, directing them to their end": the end is intrinsic to nature. Self-preservation is the first and lowest inclination. Use is common, and division is "superadded" by human reason. | ST I-II q. 1 a. 2 [V]; I q. 103 a. 1 ad 3 [V]; I-II q. 94 a. 2 [V]; II-II q. 57 a. 3, q. 66 aa. 1–2 [V] |
| Scotus | A natural agent "acts by necessity" and "would act just as it does even if it were … acting for the sake of no end at all". So where it acts for an end, it depends on an agent that loves the end: natural ends are extrinsic, in the First's knowing and willing. Division of possessions by mutual consent. | *De primo principio* 4, Theorem 4.4, first proof (tr. Ward, Hackett 2024, §55) [V]; Ord. IV d. 15 [S] |
| Ockham | That natural agents' ends are known or directed by anyone cannot be demonstrated. The end's causality is "esse amatum et desideratum". | Quodl. II q. 2 [S]; Quodl. IV q. 1 [S] |
| Suárez | "non sit propria causalitas finalis" in natural agents; their ends are in God's intention alone. Reports Ockham. Substantial forms kept. Division by agreement, after Scotus. | DM 23.10 nn. 5–7 [V]; DM 24.2 n. 14 [V]; DM 23.4 n. 8 [V]; DM 15.1 n. 5 [V]; *De opere* V.7 n. 17 [V] |
| Bacon | The final cause corrupts the sciences "nisi in hominis actionibus"; final causes go to metaphysics. Forms are laws. | NO II.2, II.17 [V]; *De augmentis* III.4–5 [S/M] |
| Descartes | Ends are useless "in rebus Physicis"; God's ends are not to be investigated. No forms but the soul. | Med. IV, AT VII 55 [V]; Princ. I.28 [V]; AT III 505 [S] |
| Hobbes | "no such finis ultimus"; the right of nature is liberty "for the preservation of his own nature". | Lev. 11, 14 [V]; De corpore X.7 [M/S] |
| Spinoza | Final causes are "humana … figmenta"; God acts for no end; conatus is the essence; self-preservation is "the first and only foundation of virtue". | E I App. [V]; IV Praef. [V]; III p6–7 [V/S]; IV p22c [V] |
| Locke | "the judicious Hooker"; the workmanship of God; the world "given … to mankind in common"; labour mixed, without consent; real essences unknown; the design argument kept. The parents' duty is to the Maker. | 2T §§5–6, 25, 27–28, 56, 63, 66 [V]; Essay III.iii.15–17 [S]; IV.x [M] |
| Leibniz | Forms are necessary in metaphysics; final causes are useful in physics; the two kingdoms reconciled. | DM §§10–11, 19, 22 [V] |
| Kant | Ends in nature are "regulative (not constitutive)"; morality is not "derived from a Divine absolutely perfect will"; material principles fall under self-love. The will is determined by the law's form, "not by their matter, but by their form only". Self-preservation "in itself can establish no duty". | KU §75 [V]; G 4:443 [V]; KpV §§3–4 [V]; the Doctrine of Virtue [V, locus M] |

The moral object, from `docs/research/modernity-object.md`:

| Figure | Holds | Locus |
| --- | --- | --- |
| Thomas | "actio habet speciem ex obiecto", as a natural thing from its form; the object "habet quodammodo rationem formae". The species of the whole act is formally from the end, materially from the exterior act's object. | I-II q. 18 a. 2 and ad 2 [V]; a. 6 [V] |
| Scotus | The object gives the act its first, generic goodness; moral goodness is full conformity with right reason. | Quodl. 18 [S: Wolter] |
| Ockham | Exterior acts are morally neutral; only the act of will is intrinsically good. | [S: Pelletier; Freddoso] |
| Suárez | The moral object specifies the act. | *De bonitate* disp. 7 s. 1 n. 6 [S] |
| Hobbes, Spinoza | Good is the object of appetite; good is what is useful. | *Lev.* 6, 15 [V]; *E* IV p59, IV Praef. [V] |
| Locke | Moral good is the conformity of an action to a law with sanctions. | *Essay* II.xxviii.5, 8, 16 [V] |
| Grotius | Acts are obligatory or illicit "in themselves". | DIBP I.1.10 [V] |
| Kant | The matter of a practical principle is "the object of the will", and no material principle grounds the law. | KpV §4 [V]; G 4:402, 4:421 [V] |

The readings, and the loci that warrant them:

| Reading | Holds | Locus |
| --- | --- | --- |
| Scotus, on the will | The second table, property under it, is natural law only in a looser sense. The will is not necessitated toward the last end. | Ord. III d. 37 [S]; Ord. I d. 1 p. 2 q. 2 [M] |
| Ockham, on the will | God can command what is now evil, and forbid the love of God. Right reason binds "given the ordination that is now in force". | OTh V 352–353 [S]; OTh VIII 394 [S]. Against: Freddoso [V]; Gatto 2011 [V] |
| Ockham, on common natures | No universal is a substance outside the soul. That the intellective soul is the form of the body is held by faith, not shown. | *Summa logicae* I c. 15 [V]; Quodl. I q. 10 [M] |
| Descartes, on the will | "it is because he willed to create the world in time that it is better this way." The eternal truths are created. | Sixth Replies [S]; AT I 145 [M] |
| Grotius, *etiamsi daremus* | Natural law would hold even if there were no God, a hypothesis he calls impious. Before him, Gregory of Rimini: the same dictate would be law "even if God did not exist". | DIBP Prol. §11 [M]; Gregory, as Suárez reports him, *De legibus* II.6 n. 3 [V] |

The measure:

| Text | Holds | Locus |
| --- | --- | --- |
| Henry Adams | The century 1150–1250, "expressed in Amiens Cathedral and the Works of Thomas Aquinas", is the unit from which to measure motion, "without assuming anything as true or untrue, except relation". The Virgin "had drawn man's activities to herself"; "both energies acted as interchangeable force on man, and by action on man all known force may be measured". | *Education* XXIX, XXV [V] |

## THE DESIGN

### The library (`causae.l`)

- **Two closed sorts.**
  - `cause` {material, formal, efficient, final}.
  - `domain` {nature, god_physics, god_ethics, human, will, self,
    reason}.

  The split between physics and ethics enters through the domain.
  `nature` is the domain of physics: non-rational things, their ends and
  forms. `human` (human nature: its form, its inclinations beyond
  self-preservation), `will` (a rational agent's own intending and
  choosing), `self` (the agent's self-preservation) and `reason`
  (practical reason giving itself law, apart from any object or end) are
  ethics'. God's intention appears in both, so it is split:
  `god_physics` for his ends in nature, `god_ethics` for his ends for
  human use and action.
- **Three slots.**
  - `argument(A,S,Q,V)`: an argument A, in the source S, for V on Q.
  - `argues_from(R,C,D)`: the reading R rests on cause C in domain D.
    Every argument is its own first reading, so `argues_from(A,C,D)`
    types A as committed.
  - `reading_of(R,A)`: R is a further reading of A.
  - `measures_as(M,C1,C2)`: the measure M takes a cause C1 as a cause C2.
- **A part's facts.** `holds_cause(C,D)`, set by the parts of a runtime
  and never by a case. Efficient and material causes are held in every
  domain by the library itself: no horizon traces them.
- **Availability.** A reading is available when every cause it argues from
  is held. An argument is available when any of its readings is, and
  `available_as(A,R)` says which. An argument typed by nothing is
  available everywhere.
- **The reports.**
  - `without_reason(Q,V)`: a value supported by a source in force, with
    arguments entered, none of them available.
  - `sole_reason(S,A,Q,V)`: of S's two or more arguments for V, only A
    is available.
  - `contrary_reasoned(Q,V,V2)`: V without reason while an argument for
    V2 is available.
- **The conversion.** A measure taking a final cause as an efficient one is
  refused (`cause_converted(M,final,efficient)`), save in a horizon where
  final causality survives only as desire: it holds (final, will), no
  final cause in nature, in God's intention or in human nature, and no
  form of the will's act, (formal, will) or (formal, reason). There the
  conversion is native (`conversion_native(M)`), as Hobbes has it: the end
  "has no place but in such things as have sense and will" (*De corpore*
  X.7). It is computed from the horizon, so it needs no part.
- **The phases.** A test part, `horizons_all`, makes the horizon a choice
  over the ten parts and enumerates the 1,024 horizons in one solve,
  never loaded by a runtime. A case's order parameters are the parts its
  report (`without_reason`, `sole_reason`, `contrary_reasoned`) depends
  on; its phases are the classes of horizons with one report. Each
  runtime is placed in its phase.

### The horizons (`schools.l`)

Ten parts, each one `holds_cause/2` fact:

| Part | Holds | What it holds |
| --- | --- | --- |
| `ends_in_nature` | (final, nature) | ends intrinsic to natural agents |
| `forms_in_nature` | (formal, nature) | substantial forms in natural things |
| `ends_by_god_physics` | (final, god_physics) | natural things directed by God's intention |
| `ends_by_god_ethics` | (final, god_ethics) | God's ends for human use and action |
| `ends_of_human_nature` | (final, human) | ends of human nature beyond self-preservation |
| `soul_as_form` | (formal, human) | the soul as the form of the body |
| `ends_desired` | (final, will) | ends as the agent intends them |
| `self_preservation` | (final, self) | self-preservation |
| `object_as_form` | (formal, will) | the chosen act's species from its object, "rationally chosen by the deliberate will" (VS 78) |
| `form_of_law` | (formal, reason) | the form of the law: the maxim's universality, apart from its matter |

`object_as_form` names the chosen act, so an ethics of intention alone
does not hold it through the interior act. Its line with `ends_desired`
is Thomas's: the proximate end against the further end (q. 1 a. 3 ad 3;
q. 18 a. 6).

`default` adds the first nine, so every existing school inherits them
and none of them is changed. `form_of_law` is held only where a runtime
adds it: it is the one part modernity adds rather than traces. The
record's runtimes:

| Runtime | Extends | Own excludes or adds | Warrant |
| --- | --- | --- | --- |
| `scotus_dpp` | scotist | excl. ends_in_nature | *De primo principio* 4.4 |
| `ockham` | scotus_dpp | excl. ends_by_god_physics, object_as_form | Quodl. II q. 2; exterior acts neutral [S] |
| `suarez_dm23` | suarezian, scotus_dpp, ockham | resolves its clashes: excl. ends_in_nature, add ends_by_god_physics, object_as_form | DM 23.10; 24.2; *De bonitate* disp. 7 |
| `bacon` | default | excl. ends_in_nature, forms_in_nature | NO II.2, II.17 |
| `descartes` | default, bacon, suarez_dm23* | excl. ends_in_nature, forms_in_nature, ends_by_god_physics | Med. IV; AT III 505 |
| `hobbes` | default, bacon, descartes, ockham* | excl. every part but ends_desired and self_preservation | Lev. 6, 11, 14, 15, 46; De corpore X.7 |
| `spinoza` | descartes, hobbes | as hobbes | E I App.; IV Praef.; III p7; IV p59 |
| `hooker` | thomist | none | 2T §5 |
| `grotius` | suarez_dm23 | none | DIBP II.2.2; I.1.10 |
| `locke` | hooker, descartes, grotius, hobbes* | add ends_by_god_physics, ends_by_god_ethics; excl. ends_in_nature, forms_in_nature, ends_of_human_nature, soul_as_form, object_as_form | Essay III.iii.15–17, II.xxi.55, II.xxviii.5–16, IV.x; 2T §§6, 25 |
| `leibniz` | suarez_dm23, descartes | add forms_in_nature, ends_by_god_physics, ends_in_nature | DM §§2, 10, 19, 22 |
| `kant` | leibniz | excl. every part but ends_desired; add form_of_law | KU §75; G 4:402, 4:421, 4:443; KpV §§3–4; the Paralogisms; the Doctrine of Virtue |

Kant's other parents, Wolff, Hume, Rousseau and Crusius, are outside
the DAG and traced over, as the hearers' are. Kant's horizon is
`ends_desired` and `form_of_law`; Hobbes's is `ends_desired` and
`self_preservation`.

\* A contested edge, entered and marked: Descartes ← Suárez (Ariew against
Courtine and Marion), Hobbes ← Ockham (no documented reading; Gillespie,
Villey), Locke ← Hobbes (Strauss against Dunn and Tully).

The readings, each a sibling of the record's node:

| Runtime | Extends | Own excludes | Warrant |
| --- | --- | --- | --- |
| `scotus_will` | scotus_dpp | ends_of_human_nature, object_as_form | Ord. III d. 37; Ord. I d. 44 [S] |
| `ockham_will` | ockham | ends_of_human_nature | OTh V 352–353 |
| `ockham_nominal` | ockham | soul_as_form | *Summa logicae* I c. 15; Quodl. I q. 10 |
| `descartes_will` | descartes | ends_of_human_nature, object_as_form | Sixth Replies; AT I 145 |
| `grotius_etiamsi` | grotius | ends_by_god_ethics | DIBP Prol. §11; *De legibus* II.6 n. 3 |
| `kant_humanity` | kant | adds ends_of_human_nature | G 4:429, the end in itself read as a final end |
| `kant_mm` | kant | adds ends_in_nature, self_preservation | the Doctrine of Virtue: "contrary to an end of nature" [V] |

A voluntarist reading keeps God's ends for human action and traces the
ends of human nature as a reason of their own: what binds, binds because
it is willed, and the act has no species of its own. The *etiamsi*
reading is its mirror: the ends of human nature bind without God's.
`kant_humanity` is a reading against its author: for Kant humanity is an
end "not as an end to be effected". `kant_mm` runs his use of nature's
ends in the Doctrine of Virtue, which his critique holds regulative only.

### The will line

A second copy of the DAG below the readings, so that the readings' effect
on later figures is computed and not assumed. Its nodes take the will
readings as parents in place of `scotus_dpp`, `ockham` and `descartes`:

| Runtime | Extends | Resolves, beyond its record twin | Warrant |
| --- | --- | --- | --- |
| `suarez_wl` | suarezian, scotus_will, ockham_will | add ends_of_human_nature, object_as_form | *De legibus* II.6 nn. 5, 13; *De bonitate* disp. 7 |
| `hobbes_wl` | default, bacon, descartes_will, ockham_will* | excl. ends_of_human_nature, object_as_form | Lev. 6, 11 |
| `spinoza_wl` | descartes_will, hobbes_wl | as spinoza | as spinoza |
| `locke_wl` | hooker, descartes_will, grotius, hobbes_wl* | as locke | as locke |
| `leibniz_wl` | suarez_wl, descartes_will | add ends_of_human_nature, object_as_form | DM §2 |

`ockham_nominal` stays a sibling: its effect is run on the case, and its
propagation is left for later.

### Leo's hearers

The evidence record is `docs/research/modernity-hearers.md`. Their own
parents (Hegel, Fichte, Feuerbach and Darwin for the socialists; Smith's
and George's sources; Wolff for Taparelli) are outside the DAG and are
traced over: each node rests on `default`, `thomist` or `locke`, with the
exclusions its loci warrant. A first approximation, to see the landscape.

| Runtime | Extends | Own excludes or adds | Warrant |
| --- | --- | --- | --- |
| `episcopate_1891` | thomist | none | RN's address; RN 22 quoting Thomas |
| `social_catholic` | thomist | none | Ketteler on property as use (Goyau) |
| `smith` | locke | none | *WN* I.x; *TMS* II.ii.3 |
| `angers` | thomist, smith* | resolves its clash: add ends_in_nature, forms_in_nature, ends_of_human_nature, soul_as_form, object_as_form | Storck, after Aubert (for the object, no text: marked) |
| `george` | locke* | none | *Progress and Poverty* VII.1; *The Condition of Labor*, Part I |
| `george_hn` | george | add ends_of_human_nature | *The Condition of Labor*, points 2 and 6 |
| `marx` | default | excl. ends_in_nature, forms_in_nature, ends_by_god_physics, ends_by_god_ethics, soul_as_form | the letter of 1861; the 1844 Introduction; *Capital* I chs. 7, 24 |
| `marx_social` | marx | excl. ends_of_human_nature | Theses on Feuerbach VI |
| `lassalle` | default | excl. ends_by_god_physics, ends_by_god_ethics | the *Arbeiterprogramm*, by absence; weak |

\* An edge with no documented reading, marked.

### The VM

- A part `vm_R` for each runtime R gives `guest_holds(C,D)` for R's
  horizon. Availability is computed twice in the one solve, as the host
  and as the guest.
- `guest_without_reason(Q,V)` reports what the guest cannot see.
- `guest_sole_reason(S,A,Q,V)` fires where S has another available
  argument for V in the host besides A, so A is idle there, and A is S's
  only available argument for V in the guest. The name says only that:
  idle here, sole there. Whether the shape is an accommodation to a hearer is
  an interpretation (CAVEATS).

### Hearing (with `linguae.l`)

- **A premise is a cause in a domain.** It is TTC-LINGUAE's `premise`,
  `cd(C,D)`, and `rests_on_form(A,cd(C,D),F)` puts it on a form. Where the
  argument is entered, a premise on a form that the argument does not
  argue from is refused (`premise_not_argued(A,P)`).
- **Who hears.** A hearing part declares that the run's own horizon, or
  the VM's guest, hears in an encoding by a lexicon (`hears_in/3`).
  TTC-LINGUAE's refusals stand: a hearing is never of a person, and its
  lexicon is of its encoding.
- **The argument heard.** For a hearing G, an argument's heard typing is
  the premises its hearing carries (`carried_for`), with every premise
  that rests on no form, as typed. The hearing replaces the host's typing
  for its hearer: one who hears the English does not hear the Latin. An
  argument with nothing on a form is heard as typed in every tongue.
- **What the hearer cannot hold** is computed from his parts, not
  entered, and reported as `lost_by_horizon`, apart from what the
  encoding loses (`lost_for`).
- **A shorter argument.** An argument that loses a premise in its
  hearing is short there (`info(heard_short(G,A))`). It is available to
  G only where a claim `concludes_heard(A,L,C)` holds: C claims that A,
  heard under the lexicon L, still concludes. Otherwise A does not reach
  G by that hearing. An argument that loses nothing is available to G
  where G holds its heard typing.
- **The bridge named.** `info(heard_by_analogy(G,A,P,K))`: the premise P
  reaches G through an analogical rendering of kind K, as itself or as
  another premise.
- **In the VM**, `guest_sole_reason` and `guest_without_reason` are
  computed on the guest's heard typings. A host with no hearing declared
  hears as typed.
- **The hearing parts.** `hear_la_1891` (the Latin, by
  `lex_la_1891`); `hear_en_1891_locke` and `hear_en_1891_schol` (the
  English, by the Lockean and the scholastic lexicons of 1891);
  `hear_en_2026`. Each is loaded beside `linguae_rn9`, whose texts and
  lexicons they use.
- **The hearers' tongues** enter as a part, `hearers_tongues`, loaded
  beside the case and `linguae_rn9`. Without it every hearer hears as
  typed, and PR stands as below. With it, `george` and its reading
  `george_hn` hear the English of 1891 under the Lockean lexicon: his
  reply is in English, and restates RN 9–10 as
  "Industry expended on land gives ownership in the land itself"
  (`modernity-hearers.md`). `episcopate_1891` hears the Latin. The other
  hearers keep the host's typing, since the German and French of 1891 and
  their lexicons are not entered (left for a research pass). The English
  heard is vatican.va's, standing in for the English of 1891. The record
  does not say which translation George read.

### The case (`modernity_property`)

Real texts. An argument is typed as what it says, which no tongue owns.
The Latin of RN is its promulgated encoding, made from Italian drafts;
the English of vatican.va is another, and divides some premises
differently (`modernity-hearers.md`, corrections 2–5). Property by nature is two questions, since RN's
opponents granted property in products and denied it in land, and RN
argues "non modo terrenorum fructuum, sed ipsius terrae dominatum"
(RN 7). Every typing is an interpretive fact, entered and open to
dispute:

| Argument | Source (tier) | For | Argues from | Text |
| --- | --- | --- | --- | --- |
| rn7 (two: products, land) | RN (3) | both: natural | (final, human), (formal, human) | reason links "the future with the present"; provision for needs that recur |
| rn9 | RN (3) | land: natural | (efficient, human), (material, nature), (formal, human), (final, self), (final, human) | "ad conservandam vitam maximeque ad perficiendam"; "velut formam quamdam personae suae impressam reliquit" |
| rn10_products | RN (3) | products: natural | (efficient, human) | "effectae res caussam sequuntur a qua effectae sunt" |
| rn10_land | RN (3) | land: natural | (efficient, human), (material, nature) | improvements "solo inhaerent miscenturque penitus" |
| rn13 (two: products, land) | RN (3) | both: natural | (final, human) | "Sanctissima naturae lex est" |
| rn8 | RN (3) | use common: yes | (final, god_ethics) | the earth given in common, "partem nullam cuique assignavit" |
| rn22 | RN (3) | use common: yes | (final, human) | II-II q. 66 a. 2, quoted |
| th57 | II-II q. 57 a. 3 (4 from 1567) | land: natural | (final, human) | the field, as to its cultivation |
| th66 | II-II q. 66 aa. 1–2 (4) | use common: yes | (final, nature), (final, human) | |
| gs69, ccc2403, ca30 | GS 69, CCC 2403, CA 30 (3) | use common: yes | (final, god_ethics) | |
| civ22 | CiV 22 (3) | IP absolute: no | (final, human) | |
| suarez_dl, grotius_dibp, hobbes_l24 (each two) | De legibus II.14; DIBP II.2.2; Lev. 24 (5) | both: positive addition | (efficient, will) | |
| locke27 | 2T §27 (5) | products: natural | (efficient, human), (final, self), (material, nature) | |
| locke25 | 2T §25 (5) | use common: yes | (final, god_ethics) | |

As committed, RN 9 is read as its Latin divides it, and as Hittinger
reads it: the form impressed is the person's, and intelligence orders
the matter. Its premises on forms are those of `linguae_rn9`: (formal,
human) on *formam* and *personae*, (efficient, human) on *personae*,
(material, nature) on *naturae*, (final, human) on *perficiendam*. Its
(final, self), "ad conservandam vitam", rests on no form. The English
encodes the same argument without the form. Fortin's reading of it
enters as a claim, `concludes_heard(rn9, lex_en_locke_1891,
fortin_1992)`: heard in the English of 1891 under Locke, RN 9 still
concludes for land, as Locke's argument "almost textually". The switch
`rn9_in_english`, which stood in for it, retires (TTC-LINGUAE, RN4).
Six switches of the case, each a further reading of one argument:

| Switch | Reading | Argues from | Warrant |
| --- | --- | --- | --- |
| `rn7_from_form` | rn7, from reason alone | (formal, human) | RN 7: reason links "the future with the present" |
| `rn7_from_self` | rn7, from self-preservation | (final, self) | "ius ille suum ad vitam corpusque tuendum" |
| `rn7_under_providence` | rn7, under God's government | (final, god_ethics) | "sub lege aeterna, sub potestate omnia providentissime gubernantis Dei" |
| `rn13_as_command` | rn13, as the Maker's command | (final, god_ethics) | read as Locke reads the same duty, 2T §§56, 63, 66 |
| `rn8_from_sustenance` | rn8, from the sustenance of all | (final, self) | "quoniam nemo est mortalium, quin alatur eo, quod agri efferunt" |
| `rn22_as_stewardship` | rn22, the owner as steward | (final, god_ethics) | "velut minister providentiae divinae" |

### The measure (`modernity_measure`)

One fact: `measures_as(adams_1907, final, efficient)`. The Virgin draws, as
an end does, and Adams measures her drawing and the dynamo's force as one
"interchangeable force on man" (*Education* XXV).

## PREDICTIONS

### CV: the library

- **CV1.** Authority reads no argument. On every runtime the case gives
  the same `questions`: property in products and property in land are
  natural, settled, each with the positive addition a shadow. Use common
  is yes, settled. IP absolute is no, settled. No `holds/2`, cleaving,
  note or obligation changes between runtimes or switches.
- **CV2.** An argument typed by nothing is available on every runtime,
  `bare` included. On `bare`, which holds no part, only arguments resting
  on efficient and material causes alone are available. In the case those
  are rn10_products, rn10_land and the six arguments for the positive
  addition. So use common and IP absolute are `without_reason`, and
  `sole_reason` fires for rn10_products and rn10_land, under every
  switch.
- **CV3.** A typing outside the sorts is `outside_domain`, as L gives for
  every slot.
- **CV4.** A further reading never removes availability: with a switch
  loaded, every argument available without it stays available.
- **CV5.** On `modernity_measure`, `cause_converted(adams_1907, final,
  efficient)` is refused on every runtime, `bare` included, save `hobbes`,
  `spinoza`, `hobbes_wl` and `spinoza_wl`, where `conversion_native`
  fires. Exactly one horizon in 128 is native. Adams's ruler runs only in
  the horizon at the end of the trace. It is refused at `kant`, whose
  will has the law's form, and at `marx_social`, whose horizon is
  otherwise Hobbes's but which inherits the object as form (unexamined).

### DG: the DAG

- **DG1.** Built with the parents above and before any `add`, `exclude`
  or `alter` resolving a clash, `ttc-l build` refuses exactly:
  - `suarez_dm23` on {ends_in_nature, ends_by_god_physics,
    object_as_form};
  - `descartes` on {ends_in_nature, forms_in_nature};
  - `hobbes` on {ends_in_nature, forms_in_nature, ends_by_god_physics,
    object_as_form};
  - `spinoza` on {ends_by_god_ethics, ends_of_human_nature, soul_as_form,
    object_as_form};
  - `locke` on {ends_in_nature, forms_in_nature, ends_by_god_physics,
    ends_by_god_ethics, ends_of_human_nature, soul_as_form,
    object_as_form};
  - `leibniz` on {forms_in_nature, ends_by_god_physics};
  - `angers` on {ends_in_nature, forms_in_nature, ends_of_human_nature,
    soul_as_form, object_as_form}.

  The readings, `kant` and every other hearer have one parent each and
  raise none. No clash is on `form_of_law`. It refuses nothing else.
- **DG2.** Scored against the record's nine documented clashes:
  - **Raised** at Suárez, Descartes, Hobbes, Spinoza, Locke and Leibniz.
  - **Agreeing in substance** at four:
    - Suárez: the end in nature, which Thomas has and Scotus excludes,
      and God's direction of nature, which Ockham excludes. He resolves
      it as DM 23.10 and 24.2 do.
    - Descartes: forms and ends in nature.
    - Locke: Hooker's ends against Hobbes's, the documented clash.
    - Leibniz: forms, and God's ends in nature.
  - **Agreeing in part** at two:
    - Hobbes: the clash is on nature, where the record names the ethics
      of ends.
    - Spinoza: the clash is on the soul and God's ends, where the record
      names conatus.
  - **Not raised** at three: Grotius and Ockham, whose clashes are about
    rights, not causes; and Bacon, a renaming with one parent.
  - Angers is scored apart: the hearers' record documents its quarrel with
    Liège as about the State and the wage, not causes. Its computed clash
    is reported.
  - The object moves no score. Hobbes's clash gains an ethical part that
    is not an end, so it stays "in part"; so does Spinoza's, since the
    record names conatus. Locke's agrees in substance in one more way: on
    the object he sides with Hobbes. Suárez's clash on the object is the
    record's *De legibus* II.6, which entered in revision: reported, not
    counted.
- **DG3.** Locke's resolution shows his two horizons: physics without
  forms or intrinsic ends; ethics with God's ends and self-preservation,
  without the ends of human nature as such, and without the object: moral
  good is conformity to a law. His own `add` of ends_by_god_ethics is the
  one move that separates him from Hobbes.
- **DG4.** The will line, built the same way, refuses exactly:
  - `suarez_wl` on {ends_in_nature, ends_by_god_physics,
    ends_of_human_nature, object_as_form};
  - `hobbes_wl` on {ends_in_nature, forms_in_nature, ends_by_god_physics,
    ends_of_human_nature, object_as_form};
  - `spinoza_wl` on {ends_by_god_ethics, soul_as_form};
  - `locke_wl` on the seven of `locke`;
  - `leibniz_wl` on {forms_in_nature, ends_by_god_physics,
    ends_of_human_nature, object_as_form}.

  The will readings add the ends of human nature to the clashes at
  Suárez, Hobbes and Leibniz, and take it from Spinoza's. They add the
  object at Leibniz, and take it from Spinoza's. The clash at `hobbes_wl`
  on the object stands without its contested edge, since `descartes_will`
  excludes it too.
- **DG5.** Scored:
  - Against the nine, which were fixed before the readings: Hobbes moves
    from "in part" to "in substance", since his clash now holds the
    scholastic ethics of ends the record names. Nothing else moves.
  - Against the two clashes added in revision (Suárez, *De legibus* II.6;
    Leibniz, DM §2): both are raised, on the ends of human nature. They
    were added after the will line was designed, so this is reported, not
    counted.
- **DG6.** The readings move the decisions, not the later horizons. Each
  node of the will line resolves to its record twin's horizon (a test
  compares them), so on the case each gives what its twin gives.
- **DG7.** Kant's horizon and Hobbes's differ on self-preservation and
  the form of the law, and on nothing else. Of the nine parts Leibniz
  holds, Kant keeps only ends_desired, and he adds the one part no other
  runtime of the record holds.

### PR: the case on each runtime

The runtimes fall into four groups by what the case reports (PH1). A
will-line node gives what its twin gives (DG6).

- **PR1.** The Thomist group, under every switch: no `without_reason` and
  no `sole_reason`. It is the schools, `default`, `saussure`, `vocal`,
  `lingual`, `hooker`, `leibniz`, `leibniz_wl`,
  the record's middle (PR2), `ockham_nominal`, `suarez_wl`,
  `episcopate_1891`, `social_catholic`, `angers` and `george_hn`.
- **PR2.** The record's middle: `scotus_dpp`, `ockham`, `suarez_dm23`,
  `grotius`, `bacon` and `descartes`. th66 is lost, its end in nature
  traced, and nothing fires. `ockham_nominal` loses rn7, rn9 and th66, and
  nothing fires: RN 13 still carries both questions.
- **PR3.** The will readings, before Hobbes. As committed, `scotus_will`,
  `ockham_will` and `descartes_will` lose rn7, rn9, rn13, rn22, th57,
  th66 and civ22, and give exactly what `locke` gives (PR4, PR5). The
  parts on which they differ from him carry no argument once the ends of
  human nature are gone. So the loss the review expected comes before Hobbes,
  as early as Scotus.
- **PR4.** RN's sole reasons on property, with rn10 standing for
  rn10_products and rn10_land together:

  | Runtimes | As committed | Where it differs, by switch or hearing |
  | --- | --- | --- |
  | `hobbes`, `spinoza`, `marx_social`, `kant_mm` | rn10 | `hear_en_1891_locke`: rn10_products only; `rn7_from_self`: none |
  | `kant` | rn10 | none: it holds no self-preservation |
  | `locke`, `smith`, `george` | rn10 | `hear_en_1891_locke`: rn10_products only; `rn7_from_self`, `rn7_under_providence`, `rn13_as_command`: none |
  | the will readings | rn10 | as `locke`, and `rn7_from_form`: none |
  | every other runtime | none | none |

  On the Latin, RN 9 is lost wherever the ends of human nature are traced.
  What Leo has left there is RN 10: the effect follows its cause, and the
  improvements are mixed into the soil. Heard in the English of 1891
  under Locke's lexicon, with Fortin's claim, RN 9 joins it for land
  (HE1). Under `rn7_from_self`, RN 7 reaches every horizon that holds
  self-preservation, and RN has no sole reason on property at any
  runtime.
- **PR5.** The common destination and IP:
  - `without_reason(q(use_common), yes)` at `hobbes`, `spinoza`,
    `marx_social` and `kant_mm`, under every switch but
    `rn8_from_sustenance`, and at `kant` under every switch.
  - `sole_reason(rn_1891, rn8, q(use_common), yes)` at `locke`, `smith`,
    `george` and the will readings, under every switch but
    `rn22_as_stewardship`. Under `rn8_from_sustenance` it fires at
    `hobbes`, `spinoza`, `marx_social` and `kant_mm` too.
  - `sole_reason(rn_1891, rn22, q(use_common), yes)` at `marx`,
    `lassalle` and `grotius_etiamsi` under every switch but
    `rn8_from_sustenance`, and at `kant_humanity` under every switch.
    In the horizon of human ends without God's, Leo's quotation of Thomas
    alone carries the common destination.
  - `without_reason(q(ip_absolute), no)` at every runtime without the ends
    of human nature, under every switch.
- **PR6.** No `contrary_reasoned` fires: RN 10 keeps both property
  questions reasoned everywhere, and the case enters no argument for use
  common "no".
- **PR7.** The hearers: the Catholics (`episcopate_1891`,
  `social_catholic`, `angers`) are in the Thomist group; Smith and George
  in Locke's; Marx and Lassalle in the group of human ends without God's;
  `marx_social` in Hobbes's. So on these nodes RN reaches the liberals by
  RN 10 and RN 8, and the socialists by RN 22.
- **PR8.** The two forms are idle in this case. No argument of the case
  rests on `object_as_form` or `form_of_law`, so no report changes on any
  runtime of the earlier design when they are added (a test compares
  them). `kant` and `kant_mm` fall in Hobbes's group and `kant_humanity`
  in the group of human ends without God's.

### VM: the bridge

- **VM1.** With `thomist` as host, `guest_sole_reason(S,A,Q,V)` fires
  with a guest `vm_R` exactly where `sole_reason(S,A,Q,V)` fires on R,
  under every switch (`vm_bare` aside, CV2). The host has every argument
  of this case, so every argument sole in the guest is idle in the host.
  It does not hold `form_of_law`, so a case with Kant's arguments will
  need its own host (not predicted here).
- **VM2.** So, as committed: rn10 bridges to the guests of Hobbes's and
  Locke's groups; rn8 to Locke's; rn22 to the guests of human ends without
  God's (`vm_marx`, `vm_lassalle`, `vm_grotius_etiamsi`).
- **VM3.** For every runtime R, the guest horizon of `vm_R` equals R's own
  horizon (a test compares them).

### HE: hearing

Each hearing part is loaded beside the case and `linguae_rn9`. Every
argument of the case but rn9 rests on no form, so it is heard as typed in
every tongue.

- **HE1.** The switch retires (TTC-LINGUAE, RN4, its second half). With
  `hear_en_1891_locke` on any runtime, beside any of the six switches,
  every report of the case is what `rn9_in_english` gave with the same
  switches (PR4, PR5), and so is the phase diagram over `horizons_all`
  (PH2). A test compares them, with the switch's typing kept as a test
  fixture.
- **HE2.** Without Fortin's claim, the Lockean hearing reports
  `heard_short(here, rn9)`, RN 9 does not reach the hearer, and every
  report is as committed.
- **HE3.** What crosses, in every branch unless a branch is named:
  - `hear_en_1891_locke`: (efficient, human) by attribution
    ("personality", the forensic self) and (final, self) by attribution
    ("well-being", happiness); (material, nature) univocally. Lost:
    (final, human) for want of carriage; (formal, human) for want of
    carriage, and by equivocation or a gap on the seal-word, by branch.
    `heard_by_analogy` names exactly the two attributions.
  - `hear_en_1891_schol`: where the seal-word renders the form, nothing
    is lost. `heard_by_analogy` names (formal, human) and (efficient,
    human) by attribution ("personality"), and (formal, human) by
    proportionality on the host's literal reading (on its metaphor
    reading the seal-word renders it univocally, as in TTC-LINGUAE's RN6). Where it does not, (formal, human) is lost by a gap, and
    rn9 is short and unclaimed.
  - `hear_en_2026`: (formal, human) and (efficient, human) lost by
    equivocation; rn9 short and unclaimed.
  - `hear_la_1891`: nothing lost; rn9 heard as typed.

  In none of the last three does any report change, on any runtime, under
  any switch, or over `horizons_all`: wherever RN 9's Latin typing is
  held, RN 13 also stands for land.
- **HE4.** The losses coincide (not independent: the Lockean lexicon and
  Locke's horizon are both entered from the *Essay*). Under
  `hear_en_1891_locke`, on `locke`, `locke_wl`, `smith`, `george`,
  `hobbes`, `spinoza`, `hobbes_wl`, `spinoza_wl`, `marx_social` and
  `kant_mm`, rn9 loses by encoding exactly what it loses by horizon,
  (formal, human) and (final, human), and nothing the horizon holds. On
  the will readings the English also takes (formal, human), which they
  hold. On `bare` and `kant` the horizon also lacks (final, self).
- **HE5.** The hearers' tongues (`hearers_tongues`):
  - On `george`, the sole reasons are rn10_products and rn8. None is sole
    for land, where RN 9 and RN 10 both reach him.
  - `george_hn` and `episcopate_1891` report nothing, as before. Every
    other hearer is as PR7.
  - Scored against the record: George's fourth reason takes RN 9–10
    together as one argument, "Industry expended on land", which is what
    the hearing gives him for land. The record was in hand when the
    hearing was chosen, so this is a fit, not a test.
- **HE6.** The VM, with host `thomist` hearing as typed:
  - Guest `vm_R` under `hear_en_1891_locke`: `guest_sole_reason` fires
    exactly where `sole_reason` fires on R with that hearing (HE1). For
    Locke's group that is rn10_products and rn8; for Hobbes's,
    rn10_products, save `vm_kant` and `vm_bare`, which lack
    self-preservation and keep rn10. `heard_by_analogy` names the guest's
    two attributions.
  - Guest `vm_locke` under `hear_la_1891`: rn9's (formal, human) and
    (final, human) are lost by horizon, computed from the guest's parts,
    and nothing is lost by encoding (TTC-LINGUAE RN5, its second half,
    now computed).
- **HE7.** A premise on a form that its argument does not argue from is
  refused (`premise_not_argued`); a test enters rn9 with a form for
  (final, god_ethics).

### PH: the phases

Each over every horizon of the parts (`horizons_all`). Sizes are given as
shares, so they hold however many parts the library has.

- **PH1.** As committed, the order parameters are exactly
  ends_of_human_nature and ends_by_god_ethics, and there are four phases,
  a quarter of the horizons each:

  | Phase | Holds | Reports | Runtimes |
  | --- | --- | --- | --- |
  | Thomist | both ends | nothing | PR1's group |
  | human ends without God's | human ends | rn22 sole | `marx`, `lassalle`, `grotius_etiamsi`, `kant_humanity` |
  | Lockean | God's ends | rn10 and rn8 sole; IP without reason | `locke`, `locke_wl`, `smith`, `george`, the will readings |
  | Hobbesian | neither | rn10 sole; use common and IP without reason | `hobbes`, `spinoza`, `hobbes_wl`, `spinoza_wl`, `marx_social`, `kant`, `kant_mm`, `bare` |

  Every phase holds a hearer of 1891. Neither form is an order parameter.
- **PH2.** By switch:
  - `rn7_from_form`: soul_as_form joins the order parameters; six phases.
    The will readings leave Locke's phase. One phase, the soul as form
    with neither end, holds no runtime.
  - `rn7_from_self`, and the hearing `hear_en_1891_locke`:
    self_preservation joins; six phases. `bare` and `kant` leave Hobbes's
    phase. One phase, God's ends without human ends or self-preservation,
    holds no runtime.
  - `rn8_from_sustenance`: self_preservation joins; four phases. `bare`
    and `kant` form one; `kant_humanity` is alone in the phase where rn22
    is sole; Hobbes's group joins Locke's.
  - `rn7_under_providence`, `rn13_as_command`, `rn22_as_stewardship`: the
    order parameters of PH1; four phases.
  - All six, with the Lockean hearing: the order parameters are the two
    ends, soul_as_form and self_preservation; six phases, one of them
    holding no runtime. `bare` and `kant` share one; `kant_humanity` is
    alone in another.
  - `hear_la_1891`, `hear_en_1891_schol`, `hear_en_2026`: PH1 unchanged
    (HE3).
- **PH3.** Every case added to this study (usury, lying, contraception,
  the death penalty, religious liberty) has its phase diagram predicted
  in its own preregistration, once its typing is settled and before
  stamping. The two forms enter there: Kant's arguments on lying and the
  death penalty rest on the form of the law, and *Humanae vitae* 14 on
  the object. The cases are chosen to add
  order parameters: a figure separates from another only where some
  case's report depends on a part on which they differ.

### SU: the suite

- **SU1.** No expectation changes: no existing case enters `argument/4`,
  `argues_from/3` or `reading_of/2`.
- **SU2.** The boot set is unchanged on the four school runtimes and on
  `saussure`, `vocal` and `lingual`. They gain the library's parts, and
  none of them is otherwise altered.
- **SU4.** TTC-LINGUAE's hearings are unchanged: its own scenarios (RN1–RN6
  among them) give the same atoms, since `linguae_rn9` alone enters no
  `argument/4` and no `hears_in` for a run's horizon or a guest.
- **SU3.** CL1 and PR4 stay clean. Every new rule has a test that fails
  without it.

### EX: reported, not predicted

- **EX1.** The record's DAG with the three contested edges removed,
  rebuilt and run on the case. What changes, if anything, is reported as
  found.

## CAVEATS

- **The typing is the interpretation.** The results follow from how each
  argument is typed by its causes. The typing is entered as fact,
  disputable fact by fact, and committed here before any run. A result
  shows that a reading coheres, not that it is true.
- **The DAG is the record's.** Its edges, and their status, come from
  `modernity-sources.md`. A node is a figure's horizon as the record
  documents it, not a judgement on him.
- **A reading is a hypothesis about a figure.** The will readings follow
  the nominalist-origins story (Gillespie, Gregory, Pinckaers, Villey);
  Freddoso, Gatto and Adams read Ockham otherwise, and Cross and Williams
  read Scotus otherwise. Both readings run so that the difference is
  computed, not to settle it.
- **Two of the clashes are not independent.** *De legibus* II.6 and DM §2
  entered the record after the will line was designed (DG5).
- **A guest is a horizon, not an audience.** Spinoza's horizon gives what
  Hobbes's gives, but Leo's readers were not Spinozists. So the hearers
  have nodes of their own, with a record behind them, and their parents
  traced over: a first approximation.
- **Followed is not granted.** The VM computes which of an act's reasons a
  hearer's horizon can follow, not which premises he grants. RN's
  opponents granted property in products and denied it in land; George
  answers RN 10's inseparability point by point. The hearers' record
  reads RN 9–10 as an argument from a premise its opponents shared, as
  Fortin, Costa and Behr do; Hittinger and Booth read it as Thomist. The
  VM cannot show an argument *ad hominem*, nor a dispute on a fact or on
  an object inside a cause both sides hold. Where the dispute is about the
  object, the question is split (products and land), and a rebuttal slot
  is left for later. Following is not engaging either: George answers
  RN 7 and RN 13 too (his second and sixth reasons), which the case says
  his horizon cannot follow.
- **No tongue is the word.** An argument is typed as what it says. Latin
  is one encoding of it, the promulgated one, and the Latin of RN was
  itself made from Italian. Where encodings divide a premise differently
  (the Latin's *forma personae*, the English *personality*), each
  hearing's typing is computed (TTC-LINGUAE), and none is the argument.
- **Only RN 9 is entered on forms.** Every other argument rests on no form
  and is heard as typed in every tongue. That is a limit of the entry,
  not a finding: RN 7's and RN 13's forms are left. The English heard is
  vatican.va's, standing in for the English of 1891. The German and
  French of 1891 and their lexicons are not entered, so Marx, Lassalle
  and the French Catholics hear as typed; a research pass on them is left
  for later.
- **A shorter argument is a claim.** That RN 9, heard without its form,
  still concludes is Fortin's reading, entered with him as claimant. The
  checker computes what the hearing carries, never whether what is left
  is a good argument.
- **Two forms, kept apart.** Thomas's object is a form "quodammodo", by a
  proportion, and the whole act takes its species formally from the end
  (q. 18 a. 6). An argument that crosses the line between the object and
  the further end is entered both ways. Kant defines his form against the
  object, so one part for both would have let each horizon follow the
  other's arguments. The cost of two is a part that `default` does not
  hold: the Thomist host is not the full horizon for Kant.
- **Many values on the object are inherited, not read.** Bacon's,
  Descartes's, Smith's, George's and the socialists' come from their
  parents with no text on the object; Angers's `add` extends a warrant
  written for its other four parts. So `marx_social` is no longer
  Hobbes's horizon only because of an inheritance nobody has examined.
- **A trace cannot see a word redefined.** The proportionalists keep
  "object" and measure it anew (Knauer; VS 74–83). They are left for the
  contraception case, where both readings will run.
- **The *etiamsi* node is a reading against its author.** Grotius keeps
  God, and calls the hypothesis one that cannot be granted "sine summo
  scelere". The node runs what his natural law would rest on if it were
  granted.
- **The phase diagram is an analogy, and only that.** There is no
  equilibrium and no thermodynamics here. A phase is a class of
  horizons with one report, and an order parameter is a part the report
  depends on: a partition of a Boolean cube. Adams carried Gibbs's rule
  of phase over to history (1909) as physics; this study carries over
  only the counting.
- **Two fields, not three.** Bacon gives final causes to metaphysics; here
  that is `god_physics`, held. Descartes, who will not investigate God's
  ends at all, excludes it. Metaphysics as a field of its own is left for
  later.

## SEE ALSO

[ttc-linguae(7)](linguae-preregistration.md), [ttc-schools(7)](schools-preregistration.md),
`docs/research/modernity-sources.md`, `docs/research/modernity-hearers.md`

## SCORING

Appended after the runs. Predictions committed in `e308c18`, stamped in
`f932d62`. Encoded in `causae.l` (new, the library: the sorts `cause` and
`domain`, the slots, availability, the reports, the VM, hearing, the
conversion), `schools.l` (the ten parts, the first nine in `default`; the
33 runtimes of THE DESIGN's tables, the contested edges marked; a part
`vm_R` for each of the 42 runtimes; `horizons_all`; two figure parts),
`icon_history.l` (the case `modernity_property`, its six switches,
Fortin's claim, `modernity_measure`, the four hearing parts and
`hearers_tongues`; the slot `figure/1`), `engine.py` (the library
registered), `schools.py` (the group kept out of the stamped boot set), the
suite (39 scenarios, group `modernity`), `tests/test_l.py` (the runtimes'
table and the closed sorts restated), `tests/test_suite.py` (the default
runtime restated), the guide in both copies, the roadmap
and the coverage index. The suite names PR1-PR8 `MP1`-`MP8`: PR is the
pair's. MM1-MM5 pin the library's mechanics. Of 37 predictions, 35 held,
DG3 is red in part, and PH3 is not scored; EX1 is reported. RN4's
second half (TTC-LINGUAE), left unscored there, is scored here as HE1, and
held. The full suite: 933 passed, 16 skipped; TTC_SLOW `test_schools`: 15
passed.

| | Result |
| --- | --- |
| CV1 | Held (CV1). Products and land natural, settled, the positive addition a shadow; use common yes and IP absolute no, settled. Each branch's values, status, cleaving, weights, verdicts and notes are the same on every runtime, alone and beside all six switches, and on `default` beside each. Read: a runtime's own note, given without the case (`palamite`'s `manifested_through(spirit,son)`), is not the case's and is set aside. |
| CV2 | Held (CV2). On `bare` exactly rn10_products, rn10_land and the six for the positive addition; use common and IP absolute without reason, rn10 sole, under every switch. An argument typed by nothing is available on all 42 runtimes. |
| CV3 | Held (CV3): `outside_domain` for `argues_from/3` (arguments 2 and 3) and `measures_as/3` (2 and 3). |
| CV4 | Held (CV4), over every horizon of `horizons_all` under each switch, and on every runtime alone and beside all six. |
| CV5 | Held (CV5). Refused on 38 runtimes, `bare`, `kant` and `marx_social` among them; native at `hobbes`, `spinoza`, `hobbes_wl`, `spinoza_wl`; 8 horizons of 1,024. |
| DG1 | Held (DG1), exactly: the seven runtimes on the parts predicted, and nothing else; none on `form_of_law`. Read: "before any `add`, `exclude` or `alter` resolving a clash" as the node's own attributes taken away, its parents as resolved; each refusal collected in turn by mentioning the part refused and building again. |
| DG2 | Held (DG2). Raised at Suárez, Descartes, Hobbes, Spinoza, Locke and Leibniz; not at Grotius, Ockham or Bacon. Against the record (`modernity-sources.md`, the nine): in substance at Suárez ({ends_in_nature, ends_by_god_physics, object_as_form}: the end in nature and its direction by God, as DM 23.10 and 24.2 resolve it), Descartes (forms and ends in nature), Locke (Hooker's ends against Hobbes's, seven parts) and Leibniz (forms; God's ends in nature); in part at Hobbes (nature and the object, where the record names the ethics of ends) and Spinoza (God's ends, human ends, the soul, the object, where it names conatus). The object moves no score. Angers's clash, reported: {ends_in_nature, forms_in_nature, ends_of_human_nature, soul_as_form, object_as_form}, where the record's quarrel with Liège is about the State and the wage. |
| DG3 | Red in part (DG3). Physics: `ends_by_god_physics` alone, no forms, no intrinsic ends. Ethics: `ends_by_god_ethics`, `ends_desired`, `self_preservation`; no `ends_of_human_nature`, no `object_as_form`. Held. "His own add of ends_by_god_ethics is the one move that separates him from Hobbes" holds in ethics only: Locke's own adds are two, and `ends_by_god_physics` separates him from Hobbes as well (Hobbes's horizon is his less those two). On this case only the ethical one moves a report, since no argument rests on God's ends in nature. The prediction is kept; the test pins the result as a finding (rule 7). |
| DG4 | Held (DG4), exactly. |
| DG5 | Held (DG4). Against the nine: `hobbes_wl`'s clash holds `ends_of_human_nature`, the scholastic ethics of ends, so Hobbes moves to "in substance"; Spinoza's ({ends_by_god_ethics, soul_as_form}) stays "in part", and nothing else moves. The two clashes added in revision are raised, `suarez_wl` and `leibniz_wl` each on the ends of human nature (reported). |
| DG6 | Held (DG6): each will-line node resolves to its twin's horizon, and gives on the case what its twin gives. |
| DG7 | Held (DG7). |
| PR1 | Held (MP1). |
| PR2 | Held (MP2): the middle loses exactly th66; `ockham_nominal` exactly rn7_products, rn7_land, rn9 and th66; nothing fires. |
| PR3 | Held (MP3): `scotus_will`, `ockham_will`, `descartes_will` and `locke` lose exactly the seven (nine arguments), and the three give what `locke` gives. |
| PR4 | Held (MP4), every row and column, the Lockean hearing on every runtime. Read: `bare`, which the table leaves out, is CV2's: rn10 under every switch and the hearing, as `kant`. The will line as its twins (DG6). |
| PR5 | Held (MP5), on every runtime under every switch, `bare` and the will line read as in PR4. |
| PR6 | Held (MP6): no `contrary_reasoned`, on any runtime or horizon, under any switch or the Lockean hearing. |
| PR7 | Held (MP7). |
| PR8 | Held (MP8): neither form moves a report over the 1,024 horizons; every earlier runtime gives what its horizon less the two forms gives; `kant` and `kant_mm` as `hobbes`, `kant_humanity` as `marx`. |
| VM1 | Held (VM1), `vm_bare` included, under every switch and all six; `guest_without_reason` likewise where `without_reason` fires. |
| VM2 | Held (VM2). Read: "the guests of human ends without God's" as PH1's group, which holds `kant_humanity` beside the three the parenthesis names; rn22 bridges to `vm_kant_humanity` too. |
| VM3 | Held (VM3), for all 42. |
| HE1 | Held (HE1). On every runtime, and over `horizons_all` beside each switch and all six, the Lockean hearing with Fortin's claim gives what the fixture `rn9_in_english` (rn9 read from (efficient, human), (material, nature), (final, self)) gave. So TTC-LINGUAE's RN4, its second half, held: the switch is retired, kept only as the suite's fixture. |
| HE2 | Held (HE2): Fortin's line removed, `heard_short(here,rn9)` on every runtime, rn9 available on none, every report as committed. |
| HE3 | Held (HE3), on `default`, in every branch: the Lockean hearing carries exactly (efficient, human), (material, nature) and (final, self), names the two attributions, loses (final, human) and (formal, human) by no carriage and (formal, human) on the seal-word by equivocation where it renders the form and by a gap where it does not; the scholastic as predicted, proportionality on the literal reading and univocity on the metaphor; 2026 by equivocation; the Latin as typed. No report changes under the last three, on any runtime alone or over `horizons_all` beside each switch and all six. |
| HE4 | Held (HE4), in every branch. |
| HE5 | Held (HE5). A fit, not a test, as stated. |
| HE6 | Held (HE6). |
| HE7 | Held (HE7). |
| PH1 | Held (PH1): order parameters exactly `ends_by_god_ethics` and `ends_of_human_nature`; four phases of 256; every runtime in its phase; a hearer of 1891 in each. |
| PH2 | Held (PH2), every bullet: the order parameters, the number of phases, the runtimes placed and the phases with no runtime. |
| PH3 | Not scored: a commitment on the preregistrations of the cases to come. |
| SU1 | Held. No part but this step's enters `argument/4`, `argues_from/3`, `reading_of/2` or `measures_as/3` (SU1). Every scenario before the encoding (668) gives the same atoms, in every model, before and after. |
| SU2 | Held. The boot set is unchanged, the group kept out of it; TTC_SLOW `test_schools`: 15 passed. The TTC-SCHOOLS tables gain the nine parts in every runtime but `bare`, after `default`'s own, and the 33 runtimes; no boot or pair of the nine runtimes before changes. The new runtimes are not booted there: 21 of them (`suarez_dm23` and every node below it) refuse `composition_in_god` on their own (below), which would change every scenario of the boot. Expectations restated, as predicted and stated where they stand (rule 7): the runtimes' table (`test_l`), the default runtime (`test_suite`), the closed sorts (`cause`, `domain`). |
| SU3 | Held. CL1 and PR4 clean. Each new statement was deleted in turn (48 in `causae.lp`, the four hearing rules and the two of `hearers_tongues` in `icon_history.lp`, the two choices of `horizons_all`; a part's facts are data) against the group, CL1 and PR4, and each turned a test red; then each body literal of each new rule of `causae.lp` alone, where the rule stayed safe (54 of 87). Closed on the way: the guest's arguments (`guest_available_as/2`, VM1); who hears in what under the hearers' tongues (HE5, the bishops' Latin changing no report); no guest without a part `vm_R` (VM3); TTC-LINGUAE's named hearers, for whom the library computes nothing (SU4); a premise kept only where every form carries it, and a bridge named only through the renderings of the argument's own forms, by the hearer's words, where the rendering is analogical (HE3, MM2); nothing lost by horizon where nothing is heard (HE4); an argument idle in the host, not sole there (MM5). Removed as idle: four literals implied by the others (`short/2` in `claimed/2`, `reading_rec/2` and `reheard/2` in `needs/4`, `V2 != V` in `contrary_reasoned`). None survives. |
| SU4 | Held (SU4): TTC-LINGUAE's 44 scenarios among the 668, RN1-RN6 included, give the same atoms; its named hearers get nothing from the library, and their `lost_by_horizon` stays as entered. |
| EX1 | Reported (EX1): without `descartes <- suarez_dm23`, `hobbes <- ockham` and `locke <- hobbes` the DAG still builds, and every node keeps its horizon: nothing on the case changes. The three edges are contested for what passes through them of the schools, not of the causes this case reads. |

### Readings

- **`here` and `guest`.** A hearing part declares its hearing for the VM's
  guest where a `vm_R` is loaded, and otherwise for the run's own horizon
  (`hearer/1`): so the host hears as typed in the VM (HE6), and a run with
  no VM hears as its part says (HE1). `hearers_tongues` declares for `here`
  alone, from the node's figure part (`figure/1`; `george`, which
  `george_hn` inherits, and `episcopate_1891`).
- **The heard typing.** For a hearer, an argument on forms keeps the
  premises on no form as typed, a premise on forms he hears in their own
  tongue as typed, and what his hearing carries where every form it rests
  on carries it. It replaces only the argument's own reading; a further
  reading rests on no form and is heard as typed. An argument on forms in
  none of whose texts' tongues he hears does not reach him (MM2).
- **Idle.** `guest_sole_reason/4` asks A available in the host beside
  another of S's arguments for V, as the design's "another ... besides A,
  so A is idle there".
- **`without_reason/2`** counts every argument entered for the value,
  whatever its source's force.
- **`lost_by_horizon/3`, computed,** ranges over the argument's typing, for
  `here` and `guest`; the entered `horizon_lacks/3` stands for TTC-LINGUAE's
  named hearers. `heard_by_analogy/4` names only a premise kept.
- **The library's table** `cause_domain/1` is a slot (a fact a rule reads,
  as `char_points/2`); `holds_cause/2` and `guest_holds/2` are results,
  derived by the library for the efficient and the material cause, so a case
  that writes them is refused at the gate: set by a part, never by a case.
- **"Excl. every part but …"** (Hobbes, Spinoza, Kant) is read as the cause
  parts each inherits; `form_of_law`, which none of Hobbes's parents holds,
  is not excluded there.
- **The source** is `rn_1891`, as the predictions name it; `linguae_rn9`'s
  texts name the act `rn1891`, and no rule joins them.
- **Fortin's claim** stands in the case; HE2 runs without it by removing its
  line. The retired switch is kept only as the suite's fixture, a snippet
  of slots, and is no part.
- **The marks.** A contested edge is marked by an L comment under its node,
  `-- contested edge: child <- parent`, read by EX1 and MM3; the will line's
  twins of the record's contested edges are marked too, and the hearers'
  edges with no documented reading as `undocumented`.
- **`horizons_all`** is loaded beside `rt_bare` and default's other parts
  (`classical`, `one_power`, `word_of_no_tongue`), so that only the horizon
  varies.
- **The runs.** Every runtime is run on the case alone and beside all six
  switches; each switch alone is read off `horizons_all`, and MM4 checks
  that every runtime gives what its horizon gives (alone, beside all six,
  and under the Lockean hearing). A VM is run for one guest of each horizon:
  two parts `vm_R` of one horizon differ only in `vm_guest`'s constant, and
  VM3 checks each guest's horizon against its runtime's. A run's reports are
  read by a projected solve, one model per distinct report.

### Not predicted

- **The modernities inherit the schools' metaphysics.** `suarez_dm23`
  extends `suarezian` (the Thomist simplicity) and `scotus_dpp`, which
  extends `scotist` (the formal distinction of the attributes): it refuses
  `composition_in_god` on its own, and so do the twenty runtimes below it
  (Descartes, Hobbes, Spinoza, Grotius, Locke, Leibniz, Kant and their
  readings, the will line from Suárez, Smith, Angers, George). Nothing in
  the case reads it, and no earlier runtime changes. Which of a school's
  parts a modernity keeps is left to be read, node by node (the roadmap).
- **The word on `bare` and `saussure`.** Neither holds `word_of_no_tongue`,
  so every English hearing there also loses (material, nature), by
  equivocation. No report changes: it is held by the library everywhere.
