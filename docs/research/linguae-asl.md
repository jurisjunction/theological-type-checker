# ASL as *verba*: the findings, the runtimes, the encoding in time and the canons, the evidence record for TTC-LINGUAE

This is a research record for TTC-LINGUAE, compiled on 23 October 2026. It is an evidence record, so it keeps prose (rule 10). It follows `linguae-signs.md` and serves one decision: how SG1–SG8 change before stamping. The question under research, not a premise, is the reading that whether the signs of a signed language are *verba* (c. 849, "verborum forma"; c. 1104 §2, "verbis" against "signis aequipollentibus") is "perhaps more empirical, or at least part of a runtime"; denying it is "a philosophical assumption"; validity can fail at c. 1108 §2; the liceity analysis was too narrow. Edward Peters's canonlaw.info is read by a separate pass and is not used here.

**How sure each item is:**
- **[V]** The wording was checked against a primary text or translation fetched for this record. For a secondary work or a claimant's own page (a lexicon, a ministry, a publisher), [V] means its own wording was fetched.
- **[S]** It was checked through a named secondary source that quotes or reports the primary.
- **[M]** It comes from memory or a standard citation and was not re-checked. It is unverified until someone checks it in print.

Quotations are under 25 words. They came through a fetch tool that returns short extracts, so a quotation is exact as returned, not proof-read against a printed page. "Proposal" marks this record's own design. "Observation" marks a comparison that no fetched source makes.

**Corrections to the brief, kept because they shape the encoding:**

1. **Thomas's Latin on consent says *nutus*, and "counted for" words.** Supplement q. 45 a. 2 ad 2: the mute "possunt tamen exprimere nutibus. Et tales nutus pro verbis computantur" [V, liriocatolico.com.br]. The Dominican English "such signs count for words" widens *nutus* (nods) to signs. *Computantur* treats them as standing for words, so it presupposes they are not words (observation).
2. **Thomas falls on both sides, by reading.** His definitions make the outer word a *vox* (I q. 34 a. 1; *Peryermenias* I lect. 4), but his reason for words in the sacraments is functional (III q. 60 a. 6). See the runtimes below.
3. **Augustine is more open than "the word of no tongue".** *De Trinitate* XV.10.19 lets the inner word go out by a nod to the eyes: "what is to nod or beckon, except to speak in some way to the sight?" [V, Haddan].
4. ***De quantitate animae* 18** is headed "Loquendi facultas, quam puer paulatim assequitur, non tribuenda incrementis animae" [V, bkv.unifr.ch]. That the chapter tells of a deaf man at Milan is [M]; its body was not reached.
5. **The Managua dates differ by source.** Senghas and Coppola (2001): a school "founded in Managua in 1977 with 25 deaf students"; the vocational school opened "The following year" [V]. Wikipedia: 50 children at first, and the vocational school in 1980 [S]. Senghas, Kita and Özyürek (2004): 50 students, "200 nel 1981" [V, Italian translation].
6. **The Nicaraguan schools taught Spanish, not signing.** "Teachers focused on teaching them to lip-read and speak Spanish, with minimal success"; the children signed "on the buses and school grounds" [V, Senghas and Coppola 2001]. This is the spontaneous development in deaf schools that the question names. Polich (2005) dissents on who made it (The findings).
7. **Linguistics once defined language vocally too.** Hockett's design features (1960) begin with the "vocal-auditory channel", which "did not take sign language into account" and "has since been modified" [S: Wikipedia, "Hockett's design features"]. The vocal definition was not only theology's.
8. **The Catholic ASL register is an interpretation of the English, not an approved ASL text.** Of the 2011 Missal work led by the National Catholic Office for the Deaf: "We're obviously not trying to create a new translation of the missal" (J. Mulcrone) [V, *Chicago Catholic*, 6 November 2011].
9. **c. 1120 keeps the reception even in a conference's own rite**: "firma tamen lege ut assistens matrimonio praesens requirat manifestationem consensus contrahentium eamque recipiat" [V, vatican.va]. The 1917 wording, "requirant excipiantque contrahentium consensum" (c. 1095 §1 3°, from *Ne temere*), is [M].
10. **c. 850 dispenses the liturgical books in urgent necessity**: there "ea tantum observari debent, quae ad validitatem sacramenti requirantur" [V]. A lay baptism in danger of death raises no liceity question of an unapproved signed text.
11. **Costello's date.** The record's 1986 is [M]. Goodreads lists a "First published January 1, 1997" edition with "more than 750 signs" [S]; *Adoremus* gave "nearly 600 signs" [S, record]. These are likely different editions.

## The findings

The empirical layer reads `question_kind(Q,empirical)` and `finding(F,Q,V,Year)`. A finding fixes Q from its year, a later finding supersedes an earlier, and a finding laid on a doctrinal question is refused (`finding_on_a_doctrine`). So the findings below cannot answer whether a signed form is a "verborum forma". They answer narrower questions that a runtime may read (next section).

**The empirical questions (proposal).** Each is `question_kind(_, empirical)`, with values `yes | no`. E is an encoding (`ase`, `ncs`, the Al-Sayyid language) or a homesign system.
- `q(human_language(E))`: E has the structure of a human language (sublexical units, grammar, productive combination).
- `q(signifies_by_convention(E))`: E's signs signify by convention, not by likeness. This is Aristotle's condition for a name ("only so when it becomes a symbol") and Thomas's line between words and acts.
- `q(left_lateralized(E))`: E is processed by the left-hemisphere language system.
- `q(acquired_as_language(E))`: E is acquired on the timetable of a spoken language.
- `q(arises_without_model(E))`: children made E's structure without a language model.

### The findings, one by one

- **Stokoe (1960).** *Sign Language Structure: An Outline of the Visual Communication Systems of the American Deaf*, University of Buffalo, 1960; reprinted by Linstok Press in 1993 "with a new preface by the author" and John B. Carroll's first review [V, Holy Cross catalogue]. The analysis divides signs into tab, dez and sig, as phonemes are divided [S, record; New World Encyclopedia]. Reception: Stokoe "was faced with confusion and opposition from deaf and hearing faculty and students" [S, *New World Encyclopedia*]. Atom: `finding(stokoe_1960, q(human_language(ase)), yes, 1960)`.
- **Stokoe, Casterline and Croneberg (1965).** *A Dictionary of American Sign Language on Linguistic Principles* (Gallaudet College Press). It "cataloged more than 2,000 signs" in a notation independent "from English translation" [S, Wikipedia]. The authors "received criticism on their work" [S]. It is a lexicon (ASL in time), and a finding only through Stokoe's analysis.
- **Frishberg (1975).** "Arbitrariness and iconicity: Historical change in American Sign Language", *Language* 51(3): 696–719. Signs change "in the direction of arbitrariness", for consistency "at the expense of transparency" [S, CNLSE catalogue]. Atom: `finding(frishberg_1975, q(signifies_by_convention(ase)), yes, 1975)`.
- **Klima and Bellugi (1979).** *The Signs of Language* (Harvard University Press), pp. xii + 417 [S, the review's heading in *Language in Society*]. The description covers ASL's units, "the grammatical processes it employs", and its "poetry and wit" [S, CNLSE]. On transparency, shown 90 signs, non-signers guessed so that "only 9 of the 90 signs produced any correct guesses"; with multiple choice, "slightly less than chance" [S: Dye, Woll and Baker, Intersign workshop, citing Klima and Bellugi 1979, p. 22]. Atoms: `finding(klima_bellugi_1979, q(human_language(ase)), yes, 1979)` and `finding(klima_bellugi_1979t, q(signifies_by_convention(ase)), yes, 1979)`.
- **Poizner, Klima and Bellugi (1987)**, *What the Hands Reveal about the Brain* (MIT Press) [S: reference list of Hickok et al. 1998]. **Hickok, Bellugi and Klima (1996)**, "The neurobiology of signed language and its implications for the neural basis of language", *Nature* 381: 699–702 [S, same]. **Hickok, Bellugi and Klima (1998)**, *Trends in Cognitive Sciences* 2(4): 129–136 [V]: "left-hemisphere damaged (LHD) signers presented with disruptions in various aspects of their signing ability (aphasia)", while "right-hemisphere damaged (RHD) signers were non-aphasic" [V]. Atom: `finding(hickok_1996, q(left_lateralized(ase)), yes, 1996)`, with `poizner_1987` before it.
- **Petitto and Marentette (1991).** "Babbling in the manual mode: evidence for the ontogeny of language", *Science* 251(5000): 1493–1496. Between "40% and 70%" of deaf infants' manual activity is manual babbling, against under 10% in hearing infants [S, Wikipedia, "Manual babbling"]. Dissent: Cormier, Mauk and Repp (1998) hold that manual babbling "is mainly influenced by motor development"; Petitto (2004, *Cognition* 93) ascribes the difference to "different coding methods" [S, same]. A later PET study (Petitto and Zatorre) found sign activating "the superior temporal gyrus", an area "connected to the auditory nerves" [S, *McGill Reporter*]. Atom: `finding(petitto_1991, q(acquired_as_language(ase)), yes, 1991)`.
- **Goldin-Meadow and Mylander (1998).** "Spontaneous sign systems created by deaf children in two cultures", *Nature* 391(6664): 279–281 [V, RePEc abstract]. American and Chinese deaf children of hearing parents, whose access to conventional input is "severely limited", share "patterned ordering of those elements within the sentence" [V]. Homesign is language-like structure, not a community's language (observation). Goldin-Meadow and Feldman, *Science* 1977, is [M]. Atoms: `finding(goldin_meadow_1998, q(arises_without_model(homesign)), yes, 1998)`; no finding sets `q(human_language(homesign))` to yes.
- **Nicaragua.**
  - Kegl, Senghas and Coppola (1999), "Creation through contact: Sign language emergence and sign language change in Nicaragua", in M. DeGraff (ed.), pp. 179–237, MIT Press [S, Wikipedia]. Wikipedia names the volume *Comparative Grammatical Change*; the usual title, *Language Creation and Language Change*, is [M].
  - Senghas and Coppola (2001), "Children creating language: How Nicaraguan Sign Language acquired a spatial grammar", *Psychological Science* 12(4): 323–328 [V]. The first signing was "an early, rudimentary sign language"; the systematizing came from the young: "the early-exposed signers of the second cohort produced them significantly more" [V].
  - Senghas, Kita and Özyürek (2004), *Science* 305(5691): 1779 ff., 17 September 2004 [V, Italian translation by S. Zucchi]. The signers came "dissezionare il modo e il percorso e di comporli in una sequenza di unità di base". Such sequences "non vengono mai osservate nei gesti dei parlanti dello spagnolo". The conclusion: "le capacità di apprendimento umane sono in grado di crearle dal nulla".
  - **Dissent.** Polich (2005, Gallaudet University Press) finds that a standardized sign language came only with "a community of users meeting on a regular basis, especially beyond childhood", and that its adoption "took many years and was fed by multiple influences" [V, publisher's page]. Stokoe "disagreed that the emergence of ISN is evidence of a language acquisition device" [S, Wikipedia]. Pinker called it "the only time that we've seen a language being created out of thin air" [S, Wikipedia]. The dissent concerns who made the language and how fast, not whether it is one (observation).
  - Kegl's policy, from June 1986, was "to document and study rather than to impose or change the language" [S, Wikipedia].
  - Atoms: `finding(senghas_coppola_2001, q(arises_without_model(ncs)), yes, 2001)`; `finding(senghas_2004, q(human_language(ncs)), yes, 2004)`. Its ISO code `ncs` is [S, a Wikipedia URL].
- **Al-Sayyid Bedouin Sign Language.** Sandler, Meir, Padden and Aronoff, "The emergence of grammar: Systematic structure in a new language", *PNAS* 102(7): 2661–2665, 15 February 2005 [V]. The language "has arisen in the last 70 years", in a community of 3,500 where "150 individuals with congenital deafness have been born" over three generations. Its order is "S–O–V", against the S–V–O of the local Arabic and of Hebrew. The authors call it "rare empirical verification of the unique proclivity of the human mind" for grammar [V]. Atom: `finding(sandler_2005, q(human_language(absl)), yes, 2005)`.
- **The qualification now current.** Liddell (2003) treats "directional uses of signs as gradient and gestural phenomena" [V, Cambridge front matter]. Goldin-Meadow and Brentari, *Behavioral and Brain Sciences* 40 (2017) e46, report the swing from "segno ... come un sistema di gesti pittorici" to "lingua parlata, con tutte le stesse strutture" and back to "il segno è gestuale, o almeno ha componenti gestuali" [V, Italian abstract]. This does not deny that ASL is a language. It says some parts of a signed form, the direction of a point among them, may be gesture (The grammar of the form).

### Earlier claims, entered as claims and not findings (proposal)

No one of these is an observational study of a signed language. Each enters as a claim with its claimant and year. Where the question was then open, none fixes it.
- **Épée** (school founded 1760; *Institution des sourds et muets, par la voie des signes méthodiques*, 1776). He saw the Paris deaf signing "as primitive" and added signs for "all the verb endings, articles, prepositions, and auxiliary verbs of the French language" [S, Wikipedia]. His methodical signs are a manual code of French, as SEE-II is of English (observation).
- **Milan, 6–11 September 1880.** "the oral method should be preferred to that of signs", passed 160 to 4, under "Caval. Sac. Giulio Tarra" [S, Wikipedia]. It is a vote. In July 2010 the 21st ICED "formally voted to reject all of the 1880 Milan resolutions" [S].
- **Seton (1918)**, *Sign Talk*: "The Sign Language is a system of root *ideas* expressed by *gestures*"; "Its syntax is simple and primitive" [V, Gutenberg ebook 50938]. His subject mixes Plains signing with the signs of the deaf.
- **Bloomfield (1933)**, *Language* (New York), on gesture languages of deaf groups as "merely developments of ordinary gestures": the wording is [M].
- **Hockett (1960)**, "The Origin of Speech", *Scientific American* 203(3): a definition, not a finding (correction 7) [S].

### What the findings can and cannot do (observation)

- They can fix that ASL, NSL and ABSL are languages by linguistics' criteria from 1960 on. Those criteria changed after the findings (Hockett), so each finding is relative to its discipline's criteria at its date. That is the empirical layer's ordinary situation, as with `expansion_1929`.
- They cannot fix that a sign of ASL is a *verbum* of c. 849 or c. 1104 §2. Entered there, they are refused (`finding_on_a_doctrine`). A teaching act resting a value on them is refused (`doctrine_rests_on_finding`).
- The step from "a sign of a human language" to "*verbum*" is a reading of the canons and of the sacramental tradition. The guide puts such an assumption in a runtime, not in the facts.

## Vox or any route: the philosophical assumption

### The texts

| Figure | Locus | What it says | Vocal by definition? | Mark |
| --- | --- | --- | --- | --- |
| Aristotle | *De int.* 1, 16a3–8 | "Spoken words are the symbols of mental experience and written words are the symbols of spoken words"; the experiences "are the same for all". | Vocal priority. Writing is second, and no third route is named. | [V, Edghill] |
| Aristotle | *De int.* 2, 16a19–29 | "By a noun we mean a sound significant by convention"; "nothing is by nature a noun or name–it is only so when it becomes a symbol"; brutes' sounds "are significant, yet none of these constitutes a noun". | Yes: a noun is a sound. The ratio that makes it a name is convention. | [V, Edghill] |
| Aristotle | *De anima* II.8, 420b | "Vox autem sonus animalis est"; "significativus enim quidam sonus est vox"; not every sound of an animal is voice ("sicut accidit in tussi", Thomas). | Yes: voice is struck air with signification. | [V, Thomas's commentary, lect. 18] |
| Aristotle | *De sensu* 1, 437a | Hearing contributes most to intelligence "indirectly", because discourse teaches "in virtue of its being audible"; "the blind are more intelligent than the deaf and dumb". | An empirical premise, that learning comes through audible discourse. The deaf schools contradict it (observation). | [V, Beare] |
| Aristotle | *Hist. an.* IV.9, 536b | "Men that are born deaf are in all cases also dumb; that is, they can make vocal sounds, but they cannot speak." | Says nothing of signing. | [V, Thompson] |
| Isidore | *Etym.* (PL 82:89B) | "Omnis vox, aut est articulata, aut confusa. Articulata est hominum". | Yes. | [S, *In the Medieval Middle* blog] |
| Augustine | *De doctrina christiana* II.3.4 | Nods give signs "to the eyes"; words hold the chief place; "I could by no effort express words in terms of those signs." | He classes hand signs beneath words. His reason is an empirical claim of expressive power. | [V, Shaw] |
| Augustine | *De magistro* 3.5; 4.8 | "Numquamne vidisti, ut homines cum surdis gestu quasi sermocinentur"; elsewhere words are for hearing and *gestus* for sight. | Classification by the receiving sense, with a *quasi*. | [S: Correia, p. 50; Burrow 2002, n. 5] |
| Augustine | *De Trinitate* XV.10.19–11.20 | The inner word is made known by "generally a sound, sometimes a nod … the former to the ears, the latter to the eyes"; "what is to nod or beckon, except to speak in some way to the sight?"; "our word becomes an articulate sound, yet is not changed into one". | No. The route is open, and the nod is a visible speaking. | [V, Haddan] |
| Augustine | *Contra Iulianum* III, "fides ex auditu" | E. A. Fay (1912) argued that the deaf-excluding sentence often ascribed to it is not Augustine's. | Not a vocal definition. | [S: Carrier, MA thesis, Alberta, 2018] |
| Thomas | I q. 34 a. 1 | Primarily "the interior concept of the mind is called a word"; "secondarily, the vocal sound itself"; "thirdly, the imagination of the vocal sound". | Yes for the outer word. | [V, English] |
| Thomas | *Peryermenias* I lect. 4 n. 3 | "vox est sonus ab ore animalis prolatus". | Yes. | [V, logicmuseum] |
| Thomas | III q. 60 a. 6 | Words, because they "can be formed in various ways for the purpose of signifying various mental concepts"; sensible acts are comprised "sub rebus", so they are matter (ad 2). | The reason is functional. The class of acts is matter. | [V, English; ad 2 Latin, record] |
| Thomas | III q. 60 a. 7 ad 1 | The sense "est idem apud omnes, licet non eaedem voces". | It varies the *vox*, not the route. | [V, record] |
| Thomas | Suppl. q. 45 a. 2 | Consent "verbis exprimatur"; the mute "possunt tamen exprimere nutibus. Et tales nutus pro verbis computantur". | Signs are classed as not words, yet are equal in effect. | [V] |
| Thomas | Suppl. q. 9 a. 3 | Confession by "that act which is most commonly employed"; for one ignorant of a language, "by writing, or by signs, or by an interpreter". | Equivalence. | [V, record] |
| Saussure | CLG p. 26 (on Whitney) | "The question of the vocal apparatus is, then, secondary"; "men could just as well have chosen gesture and used visual images in place of acoustic images". | No. The route is accidental. | [S: semioticon paper] |
| Consilium | *Notitiae* 2 (1966) n. 95 | A "lingua sic dicta « per gestus »"; the celebrant "verba profert et simul illa gestibus significat". | It names the system a *lingua*, yet classes the signs as gestures signifying spoken words. | [V, record] |
| DDF | *Gestis verbisque* 14 (2024) | "The form of the Sacrament is constituted by the word". | Silent on route. | [V, record] |
| O'Neill | *Catholic Encyclopedia* (1908), "Consent (in Canon Law)" | For matrimonial consent, "words are by no means necessary", given some outward manifestation. | Open, for consent. | [V, New Advent] |
| Canonists | Dzierżon (2017) | Cites the PWN dictionary's "word" as a set of sounds, and Viladrich's "own word - oral expression". | Yes, by dictionary. | [S] |

### Two runtimes (proposal)

- **`rt_vocal`** (part `verbum_vocal`).
  - A *verbum* of a sacramental form (c. 849) or of consent (c. 1104 §2) is a *vox*, a significant sound.
  - A manual sign is a sensible act. In a sacrament it is matter (III q. 60 a. 6 ad 2). In consent it is a *signum aequipollens* (Suppl. q. 45 a. 2 ad 2: "pro verbis computantur"; 1917 c. 1088 §2).
  - No finding bears on its answer: the predicate is fixed by the channel.
  - It reads c. 1104 §2 as `r_signa`, and the baptism case as `r_vocal`.
  - Holders: Aristotle by his definitions; Isidore; Thomas by his definitions (reading `thomas_definition`); the 1966 response and England and Wales (1992) in their practice; Zuhlsdorf (2011) and Akin (1998) [record]; Viladrich, as reported. Hockett (1960) held the same definition in linguistics, since modified.
- **`rt_lingual`** (part `verbum_lingual`).
  - A *verbum* is a conventional sign of the inner word in a human language, by any route (vocal, manual, tactile).
  - Whether a signed language is a human language, and signifies by convention, is empirical. A sign is a *verbum* from the year a finding fixes `q(human_language(E))` and `q(signifies_by_convention(E))` to `yes` (from 1960 and 1975 for `ase`).
  - Homesign, nods, a handshake and rings stay *signa aequipollentia*: no finding makes homesign a community's language. So §2's second clause keeps its work (observation).
  - It reads c. 1104 §2 as `r_verba` for E, and the baptism case as `r_lingual`.
  - Holders: Augustine, *De Trinitate* XV.10.19; Thomas by his reason (reading `thomas_reason`: III q. 60 a. 6, a. 7 ad 1); Saussure's route (CLG p. 26); O'Neill (1908) for consent; Peters, McNamara and Hysell [record].
- **`default`** loads neither part, so `form_reading(route_manual, …)` runs both ways, as now. `thomist` loads neither; Thomas enters as two sibling readings, the way TTC-MODERNITY's `scotus_will` and `ockham_will` do. `saussure` sits nearer `rt_lingual` on the route. It is a runtime about division, not about the channel, and is left as it is.
- **One reading per runtime across the canons** (proposal; c. 17's "ad locos parallelos" [M for that phrase]). A runtime reads *verba* alike in c. 849, c. 1104 §2 and the other canons of form. Reading it two ways without a declared reason is refused (`verba_read_two_ways(R)`).

### Is the vocal reading question-begging? (observation)

- On `rt_vocal` no observation could bear on the answer. That marks a definition, not a finding. It begs the question only when entered as a fact or a finding. Entered as a runtime, it is an assumption with named claimants, and `read_as` shows it.
- `rt_lingual` also assumes something: that *verba* names a function (a conventional sign of the inner word in a language), not a channel. Its assumption hands the minor premise to the sciences. The vocal one does not.
- The case of spontaneous development is the test. On `rt_vocal`, NSL has no *verba*, though it was made by children whom a school taught only Spanish, and it has Thomas's "formed in various ways" and Aristotle's convention. On `rt_lingual`, it has *verba* from the year a finding fixes its status (2004 in this record).
- Thomas's and Aristotle's texts carry both premises: a definition (sound) and a ratio (convention, the power to signify many concepts). The two runtimes divide over which one is essential.

## ASL in time

### Descent and varieties

- **LSF.** Épée was a "Catholic priest" who founded his school in 1760. His aim was to educate the deaf so they could receive the sacraments, after meeting "two young deaf sisters who communicated using a sign language" [S, Wikipedia]. Sicard succeeded him.
- **Clerc** (26 December 1785–18 July 1869) was "taught by Abbé Sicard and Deaf educator Jean Massieu". The Hartford school opened "on April 15, 1817" [S, Wikipedia].
- **Martha's Vineyard.** The first known deaf settler came "in 1694". At its peak (1854) the island had "one person in 155" deaf; Chilmark "1 in 25". Its users were "influential in the development of ASL". "Katie West, the last deaf person born into the island's sign-language tradition, died in 1952" [S, Wikipedia]. Groce, *Everyone Here Spoke Sign Language* (Harvard, 1985) [S]. The page hedges: "Little is known of it other than its existence" [S].
- **Black ASL.** McCaskill, Lucas, Bayley and Hill, *The Hidden Treasure of Black ASL* (Gallaudet, 2011), "the first sociohistorical and linguistic study of this language variety" [V, publisher's page]. "Raleigh Sign Language" is "a North Carolina variety of Black American Sign Language" [V: Hill and McCaskill, introduction to M. H. Wright, *Sounds Like Home*]. Its features (larger signing space, two-handed forms, lowered signs) and its segregated schools' dates are [M]. Regional variation: Lucas, Bayley and Valli, *Sociolinguistic Variation in ASL* (2001) [M].
- **A parallel in Catholic schools.** Irish Sign Language is "unique among sign languages for having different gendered versions", because boys and girls were taught apart, at St Joseph's and St Mary's (Cabra). The girls' school turned to "an oral approach in 1946", the boys' in 1956 [S, Wikipedia, citing LeMaster 1998]. Two varieties grew in two Catholic schools (observation).
- **Change.** Signs move "in the direction of arbitrariness" (Frishberg 1975) [S].

### Dated lexicons, each a claimant

| Year | Lexicon | Kind | What it gives | Mark |
| --- | --- | --- | --- | --- |
| c. 1900 | *Sign-language*, by "A Sister of St. Joseph and Deaf Mute Institute" | Catholic vocabulary | 76 typewritten leaves, "some distinctively Catholic terms"; believed to have circulated among Jesuit scholastics | [V, Deaf Catholic Archives, Holy Cross] |
| 1900–1938 | *The Catholic Deaf-Mute* (New York) | Periodical | "A newsletter published for Deaf Catholics in New York, NY" | [V, DCA] |
| 1910, 1918 | J. S. Long, *The Sign Language: A Manual of Signs* | Dictionary | "about 1,500 signs used by the deaf, with 500 admirable photographic illustrations" | [S: Seton 1918]; 1918 edition [V, HSLDB] |
| 1923, 1942 | D. D. Higgins, C.Ss.R., *How to Talk to the Deaf* | Catholic, by a Redemptorist priest | Serialized in *The Catholic Deaf-Mute*; 1942 edition, Chicago, J. S. Paluch | [V, HSLDB; DCA] |
| 1923 | J. W. Michaels, *A Handbook of the Sign Language of the Deaf* | Dictionary | listed | [V, HSLDB] |
| 1965 | Stokoe, Casterline, Croneberg, *DASL* | Dictionary, by form | "more than 2,000 signs" | [S] |
| 1972 | SEE-II | A code of English | (record) | [S, record] |
| 1986 (?) | E. Costello, *Religious Signing* | All faiths | "nearly 600" or "more than 750" signs, by edition | [S]; date [M] |
| 2001 | D. Bar-Tzur, Our Father in ASL | Interpreter's gloss | "OUR HEAVENLY-FATHER, YOURSELF LIVE HEAVEN, YOUR-rt NAME HOLY." | [V, theinterpretersfriend.com] |
| 2011 | NCOD and Archdiocese of Washington, *The New Roman Missal for Interpreters* | Catholic liturgical register | "sign choices based on the liturgical meaning of the particular sign in context"; "chalice" "outlines the shape" | [V, NCR, 11 October 2011] |
| 2017 | ASL-LEX (Caselli et al., *Behavior Research Methods* 49(2): 784–801) | Database | "nearly 1,000 signs"; frequency "from 25–31 deaf signers"; iconicity "from 21–37 hearing non-signers" | [V, abstract] |
| 2017 | ASL Signbank (Hochgesang, Crasborn, Lillo-Martin) | ID-gloss database | "Over 2300 signs"; "no definitions"; "Linked to ELAN" | [V, poster] |
| 2020 | S. Loomis, *Hands of Grace* (Ascension) | Catholic sacraments | a glossary of "more than 50 Catholic Sacrament-related signs"; Loomis "is not deaf" | [V, Archdiocese of Baltimore; NC Register, 31 January 2020] |
| 2021 | ASL-LEX 2.0 (Sehyr et al., *JDSDE* 26(2): 263–277) | Database | "2,723 ASL signs"; transparency ("guessability") ratings from non-signers | [V, abstract] |
| n.d. | Religious American Sign Language (RASL), Rockford | Catholic register | For "Priests, deacons and seminarians", interpreters and Deaf lectors | [V, Diocese of Camden list] |
| n.d. | M. Depcik and S. Carey, "ASL Translation of Mass Prayers" | Deaf priests' videos | listed | [V, title only, Camden list] |

**The Catholic liturgical holdings** of the Deaf Catholic Archives (Holy Cross) are catalogue records, not read. Each is "digitized, but is not available for download" [V]:
- *Luke and Acts, English version for the Deaf* (1975);
- *Eucaristic Prayer for the Deaf* (1977);
- *Suggested Gloss of Liturgical Texts* (1984–);
- *Rite of Infant Baptism*, by R. Bek and R. Luberti (1990);
- *Interpreting the Mass for Interpreters* (1994);
- *Liturgical Sign Language Controversies, 1997–2002*;
- *COA Sacramentary (Draft)* (June 2013);
- *Eucharist Prayer in ASL* (2016);
- the ICDA histories.

**The bodies.**
- The ICDA came from "the convention, held July 1949 in Toronto", with Cardinal McGuigan's support [V, Holy Cross finding aid].
- The NCOD's newsletter runs from 1971 [V, DCA record]. Its founding date is [M].
- No approval by a conference with the Holy See's *recognitio* was found for any of these. Nor was any act of any approver (observation, by absence).

### How to enter ASL in time (proposal)

- **Encodings.** `encoding(ase, "ase", 1817, 2026)`, its span opening with the Hartford school. Dated slices where a lexicon fixes a state: `ase_1910`, `ase_1965`, `ase_2026`, like `en_1891` and `en_2026`. Black ASL is `ase_black`, with `variety_of(ase_black, ase, mccaskill_2011)`. ASL's descent is a claim: `descends_from(ase, fsl, C)` and `descends_from(ase, mvsl, groce_1985)`. Neither is `made_from/2`, which is for texts. SEE-II stays `code_of(en_see2, en)`, and Épée's methodical signs (1776) are `code_of(fr_methodical, fr)`.
- **Lexicons.** `lexicon(C, E, Year, Kind)`, with Kind one of `dictionary` (meanings), `database` (form and identity, no meanings), `register` (a religious register), `gloss` (an interpreter's rendering of an English text). Every `means(T, W, C)` names a lexicon at its year. A lexicon used outside its encoding's span is reported: `info(lexicon_out_of_span(F, C))`.
- **Three claims, kept apart.** Which lexeme a token is (`token_id`, from an ID-gloss database). What a lexeme means in a register (`means`, from a dictionary or a register). How a token is formed (a phonological notation). A database without definitions (Signbank) never supplies `means`.
- **The religious register as a claimant at no tier.** NCOD, a diocese, an interpreter or a publisher gives a lexicon claim, never an approval. A rendering of the approved English (NCOD 2011, Bar-Tzur 2001) is a rendering of an English text in ASL. `host_declared(F_asl, F_en, C)` records it, and its mode is computed against the English host and, through it, the Latin.

## The grammar of the form

### What published sources show of the formula

- No published ASL gloss or video description of "I baptize you in the name of the Father, and of the Son, and of the Holy Spirit" was found.
- The Trinitarian clause is signed in the Sign of the Cross. The Archdiocese of Washington's deaf ministry signs it on Loyola Press videos ("shown in video with voice"; no gloss) [V, Loyola Press].
- The DCA's *Rite of Infant Baptism* (1990) is not downloadable [V].
- *Hands of Grace* (2020) has "three-part videos on each sacrament". Whether they show the forms is not said [V, NC Register].

### Person, number and the subject

- **First person.** A point at the signer is first person [S, record]. Meier (1990) holds that ASL marks no grammatical distinction "between 2nd and 3rd person". Lillo-Martin and Chen Pichler give the alternative of "massive syncretism" [S, their poster, citing Meier in Fischer and Siple, eds., *Theoretical Issues in Sign Language Research* I (Chicago, 1990), pp. 175–190].
- **The addressee.** On Meier's view, the gloss "IX-2" builds in a category the language may lack. The second person is then fixed by the point's direction, which Liddell treats as "gradient and gestural" [V]. Observation: *te* is carried in part by deixis. A notation can only claim the target; seeing it is the senses step's.
- **Number.** A singular point against a plural sweep [S, record]. Pronouns incorporate numerals "from two to five" [S, Wikipedia, "ASL grammar"]. `WE` is a distinct sign [S, record].
- **Null arguments.** Lillo-Martin, "Two kinds of null arguments in American Sign Language", *NLLT* 4 (1986): 415–444 [S, CNLSE]. ASL counts as "a pro-drop language" [S, Wikipedia]. That null arguments with plain verbs are licensed by topic, and with agreeing verbs by agreement, is [M].
- **Verb classes.** An agreeing verb "indicates the person/number of its subject and object by modification of the beginning and ending locations" [V: Kwok, Berk and Lillo-Martin, *Sign Language & Linguistics* 23 (2020)]. The three classes go back to Padden (1983; Garland, 1988) [M for the attribution]. That BAPTIZE is plain is still [M] (record).
- **Non-manuals.** For "YES/NO questions, the eyebrows are raised"; for WH-questions they "are lowered"; topics: "the eyebrows are raised and the head is tilted back"; negation by "shaking the head during the entire clause" [S, Wikipedia, citing Watson 2010 and Aarons 1994]. A non-manual marking "obligatorily spreads over the c-command domain" when its manual sign is omitted [S, citing Neidle 2002]. Conditional marking and the assertive head nod are [M].

### The lexical items

- **FATHER (everyday).** A "5-hand" with "the tip of the thumb … on or near your forehead" [V, Lifeprint]. Lifeprint names no religious variant.
- **HEAVENLY-FATHER.** A two-handed compound: both [A] hands at the forehead, opening to [5] "while moving upwards" [V, Bar-Tzur 2001]. So a religious lexicon can give the First Person a sign other than the everyday FATHER. SG3's lexicon split is attested.
- **SPIRIT.** One sign group, "SPIRIT / ghost / soul" [V, Lifeprint]. HOLY-SPIRIT as HOLY + SPIRIT, and the forms of HOLY, SON, TRINITY and NAME, are [M].
- **Abstract terms.** "Consubstantial with the Father" is hard to sign because it is "very abstract" [V, *Chicago Catholic*, 2011].

### The variants a case should enter (proposal)

- `G1`: `IX-1 BAPTIZE IX-nonfirst[→addressee] NAME FATHER SON HOLY-SPIRIT`, everyday FATHER.
- `G2`: the same, with HEAVENLY-FATHER (Bar-Tzur's register).
- `G3`: the subject dropped (Lillo-Martin).
- `G4`: `WE BAPTIZE …`.
- `G5`: a topicalized order, the names first with raised brows, then `IX-1 BAPTIZE IX-nonfirst` [M as a possible form].
- `G6`: the same manual string under raised brows throughout, read as a yes/no question. A notation without a non-manual tier cannot tell `G6` from `G1`.

## Notation and claimants

| Notation | Manual form | Non-manuals | Lexical identity | Claimant and date | Mark |
| --- | --- | --- | --- | --- | --- |
| English gloss | no (a label) | only by added conventions (e.g. `YOUR-rt`) | by the glosser's word | the glosser | [V, Bar-Tzur 2001 conventions] |
| ID gloss | no | no | yes, a "unique sign-type" identifier tied to a lexical database | the database and annotator | [V: Johnston, *IJCL* 15(1): 106–131, 2010] |
| Stokoe notation (1960, 1965) | tab, dez, sig | no | no | the transcriber | [S, record] |
| HamNoSys (1984/1987) | yes, phonetic | "rather limited" | no canonical form | the transcriber | [S, Hanke 2004, record] |
| SignWriting (Sutton, 1974; Unicode 8.0, 2015, U+1D800–1DAAF) | yes | yes: ISWA "Category 4: Head & Faces" | no | the writer | [S, Wikipedia; V, signbank.org ISWA] |
| ELAN tiers (Wittenburg et al., LREC 2006, pp. 1556–1559) | per tier, time-aligned | as separate tiers | through ID-gloss tiers | the annotator, per tier | [V, abstract] |
| SignStream (Neidle, BU; conventions, Report 11, August 2002) | glosses | non-manual fields | glosses | the ASLLRP annotator | [S, title only] |

- **Annotation over transcription.** Johnston: a corpus should be "annotated rather than simply transcribed", and ID-glosses "can only be used if a comprehensive reference lexical database of the language already exists" [V, abstract].
- **The annotator is already a property of a tier.** Crasborn and Sloetjes (2008) add an annotator property so a group sees "which tier has been filled by whom". They plan "different values" that are "simultaneously present and can be compared", "particularly useful for different translations or analyses" [V].
- **Signbank's entries** "are produced by actors (not necessarily the signs they use)" [V]. A database's form is a citation form, not the performance (observation).

### How a transcriber's claim enters (proposal)

- `notated(F, N, C)`: the performance F is given in notation N by C. `tier(F, N, Tier)` for each tier N carries (`manual`, `nonmanual`, `gloss`, `id_gloss`, `translation`). A missing tier gives `info(notation_gap(F, N, Tier))`.
- `token(F, I, T)` from a notation. `token_id(F, I, Entry, C)` links a token to a database entry by the annotator's claim. `means(Entry, W, Lexicon)` is a separate claim.
- **Two transcriptions that disagree.** Both run, each with its claimant. The checker reports `info(transcriptions_differ(F, C1, C2, Tier))` and never chooses. A difference on the subject token (IX-1 against WE, or none) carries into `minister_act`. A difference on the non-manual tier carries into the mood, statement or question. Settling it from the video is the senses step's. An agreement score between annotators is a claim about the pair, never a fixing.
- `gloss_as_word(F)` stays refused: a gloss names a sign.

## The canon side

### Validity: the assistant and the witnesses

- **The canons.**
  - c. 1057 §1: "Matrimonium facit partium consensus inter personas iure habiles legitime manifestatus", which "nulla humana potestate suppleri valet" [V].
  - c. 1104 §1: "Ad matrimonium valide contrahendum necesse est ut contrahentes sint praesentes una simul" [V].
  - c. 1108 §1: "Ea tantum matrimonia valida sunt, quae contrahuntur coram loci Ordinario aut parocho" … "coram duobus testibus" [V].
  - c. 1108 §2: the assistant is the one who "praesens exquirit manifestationem contrahentium consensus eamque nomine Ecclesiae recipit" [V, record].
  - c. 1120 keeps that requirement in a conference's own rite (correction 9) [V].
- **The 1917 law.** *Ne temere* (1907) required the qualified witness to be active: he "debía pedir el consentimiento" [S, *Diccionario panhispánico del español jurídico*, "testigo de matrimonio"]. 1917 c. 1095 §1 3° is [M].
- **What the qualified witness does.** He "constata la existencia cierta del consentimiento matrimonial expresado por los cónyuges" [V, DPEJ]. Boni reports canonists (Bertola) for whom the form serves "to facilitate the perception of the event by a qualified witness" [S: Dzierżon 2017, n. 26, citing G. Boni, *La manifestazione*, p. 607].
- **When the manifestation fails.** A rotal decision *coram* Grazioli, 10 July 1939 (SRRD 31, p. 436): if the party "would not answer the parish priest's questions, then the marriage would be invalid" [S, Dzierżon n. 30]. Chiappetta: "a passive attitude has no legal effect" [S, Dzierżon n. 29].
- **The common witnesses.** Doctrine has held it enough that "los testigos comunes percipiant personas et ut percipiant has celebrare matrimonium"; anyone with "uso de razón" who "pueda testimoniar el hecho de la prestación del consentimiento" [S: J. M. González del Valle, review of A. Moroni, *Il testimone comune* (Giuffrè, 1972), p. 463]. Moroni asked for "requisitos de conocimiento y voluntariedad mayores", under which a defect "provocaría la nulidad"; the reviewer calls it excessive formalism [S, p. 464]. A diocesan answer: witnesses should "be capable of understanding the events they are witnessing" [V, Diocese of Camden, 25 March 2009].
- **The deaf or blind assistant or witness, the interpreter's error, a Rota decision on deaf parties**: none was found (What I could not verify).

So, as the evidence stands (observation):
1. Whether the assistant received the manifestation is a fact of the external forum, entered `yes | no | disputed`, never computed (rule 3). What shows it is outward: his knowing ASL, an interpreter's presence, the parties' answering.
2. What "recipit" requires is a reading with claimants and no authentic interpretation, so it branches (rule 2):
   - `r_recipit_celebration`: he perceives the persons and that they celebrate marriage (the minimum held of common witnesses);
   - `r_recipit_consent`: he perceives the manifestation as consent (DPEJ's "existencia cierta"; Bertola; Moroni's stricter line).
3. Both readings are route-neutral. A deaf assistant receiving spoken consent through an interpreter falls under the same computation as a hearing one receiving ASL.

### c. 1104 §2: *signa aequipollentia*

- **The text.** "Sponsi consensum matrimonialem verbis exprimant; si vero loqui non possunt, signis aequipollentibus" [V]. 1917 c. 1088 §2 [V, record].
- **What the commentators count as equivalent signs** [all S, Dzierżon 2017]:
  - a nod: Pawluk's party "not being able to speak out only with a nod" (p. 170);
  - "exchanging rings or by a mutual handshake" (Prader; Althaus);
  - Eastern "gestures or special rhythms" (Salachas);
  - not silence, which "does not meet this condition" (Bersini).
- **The signs must be clear.** They "should be unambiguous for witnesses" (Pawluk; Viladrich) [S].
- **Validity or liceity.** Gasparri and Biskupski: words were required for fairness, not validity [S]. Dzierżon reports the same of Innocent III, *De sponsalibus et matrimonio* [S]. On the decretal for the deaf (1198), what they "cannot express by words, they can declare by means of signs" [S: Oates 2023]. Its incipit and Liber Extra number are [M].
- **Whether a signed language's signs are *verba*.** No commentator fetched here decides it (observation, by absence; Peters is the other pass's). The USCCB footnote cites §2 without saying which clause (n. 45, fn. 55) [V, record]. *NCR* (2011) reads the canon as making equivalent signs "just as accepted" [V].
- **CCEO.** c. 837 §1 "does not explicitly state the requirement to get married using specific words"; in Eastern law "the parties must receive a priestly blessing" [S: Dzierżon, p. 7 and p. 2 n. 2].

### c. 1106 and c. 849

- **c. 1106.** "Matrimonium per interpretem contrahi potest; cui tamen parochus ne assistat, nisi de interpretis fide sibi constet" [V]. Pawluk: it "is not necessary to obtain the permission of the ordinary" [S, Dzierżon n. 42]. 1917 cc. 1090–1091 [V, record].
- **c. 849** (form "of words") and **c. 850** (correction 10) [V].

### Liceity: the conditions beyond §2

The record weighed liceity only by c. 1104 §2. The other conditions found:
- **c. 1106**: the assisting is licit only where the interpreter's fidelity is established [V].
- **c. 1119**: "Extra casum necessitatis, in matrimonii celebratione serventur ritus in libris liturgicis praescripti aut legitimis consuetudinibus recepti" [V]. No approved ASL rite exists. Whether signing the approved English formula is the approved rite, or a change, is a reading. Its claimants: NCOD 2011, rendering and not translating; c. 846 §1 [V], "nemo in iisdem quidpiam proprio marte addat, demat aut mutet".
- **c. 838** (conferences prepare versions; the Holy See confirms): no ASL text with confirmation (record).
- **c. 1120**: a conference's own rite needs the Holy See's *recognitio* [V]. The USCCB *Guidelines* (2017, n. 45) are a conference norm that offers sign language, not a rite. They weigh as practice at the conference's level [V, record].
- **c. 1063**: the pastors' duty of preparation ("praeparatione personali"; "fructuosa liturgica matrimonii celebratione") [V]. It binds the community, not the act's liceity.
- **cc. 1066–1067**: "constare debet nihil eius validae ac licitae celebrationi obsistere"; the conference sets norms "de examine sponsorum" [V]. A prenuptial examination of deaf parties needs a common language or an interpreter (observation).
- **c. 1071 §1** lists vagi, the civil law, natural obligations, notorious rejection of the faith, censure, a minor without the parents' knowledge, and proxy [V, by the openings of its numbers]. Nothing on deafness (observation).
- **Baptism and absolution.** c. 846 §1 and c. 838 bind the signed form of absolution, which has no approved text. Lay baptism in danger of death is spared them by c. 850. Confession through an interpreter: cc. 990, 983 §2, 1386 §2 [V, record].

## Proposed revision of SG1–SG8

All proposals. The case `linguae_signed` stays a switch marked `HYPOTHETICAL`.

- **SG0 (new): the empirical questions.**
  - `q(human_language(ase))` is fixed `yes` from 1960 (`stokoe_1960`), and `q(signifies_by_convention(ase))` from 1975 (`frishberg_1975`), each superseded by its later findings (`klima_bellugi_1979`, `hickok_1996`, `petitto_1991`).
  - Run with `asof(1950)`, neither is fixed: Épée, Seton and Milan weigh nothing, being claims.
  - A finding entered on `q(valid_form(…))` or `q(verba_1104(ase))` is refused (`finding_on_a_doctrine`). A source resting a doctrinal value on one is refused (`doctrine_rests_on_finding`).
  - `q(human_language(homesign))` has no finding, so homesign's gestures are never *verba*.
- **SG-R (new): two runtimes for *verbum*.**
  - On `rt_vocal`, a manual form is not a "verborum forma" on any finding, and c. 1104 §2 reads `r_signa`.
  - On `rt_lingual`, it is one from the year SG0's questions are fixed `yes`, and §2 reads `r_verba`.
  - On `default` and `thomist`, both branches run, with Thomas as two sibling readings.
  - `read_as` names the runtime's part on every branch it decides. A runtime reading *verba* two ways is refused (`verba_read_two_ways`).
- **SG1 (revised).**
  - `G1` under the religious lexicon: `minister_act` `expressed`; `trinity_invoked` `yes` under `G2`'s HEAVENLY-FATHER, and `yes` or `no` under everyday FATHER by lexicon (SG3); number closed.
  - The person of the addressee is `form_feature(F, addressee, deictic, C)`. It is fixed by the point's target, a gestural component on Liddell's analysis.
  - A gloss `IX-2` is a claim carrying Meier's disputed category. It reports `info(gloss_presumes_category(F, second_person))`.
- **SG2 (unchanged).** SEE-II opens `r_plural` as English does; no mode is computed between it and English. Épée's methodical signs give the same against French.
- **SG3 (revised).** With no subject token, `minister_act` is `disputed`, both values run, and `valid_form` keeps every branch. On a register claim, FATHER may be everyday or HEAVENLY-FATHER, and each is a lexicon with its year (`means(…, C)`).
- **SG4 (revised).** `gloss_as_word` refused. `notation_gap(…, nonmanual)` for Stokoe notation and for a gloss without a non-manual tier; partial for HamNoSys; none for SignWriting or an ELAN file with a non-manual tier. `G1` and `G6` are distinct only where a non-manual tier is entered. Two transcriptions report `transcriptions_differ` and both run. `token_id` from Signbank or ASL-LEX never supplies `means`.
- **SG5 (revised).**
  - Baptism: `q(valid_form(baptism, …))` has no sourced value.
  - c. 869 §1 gives conditional baptism on `rt_vocal` and on the vocal branch of `default`. Not on `rt_lingual`, where SG0 is fixed and `minister_act` is `expressed`.
  - The England and Wales rubric and *Notitiae* 1966, entered as answering validity, are refused (`teaching_from_law`). Entered as practice, they weigh at their tier.
  - c. 850 means no liceity question of an unapproved text arises for the lay baptism.
- **SG6 (revised: consent).**
  - c. 1104 §2 never invalidates (c. 10), on `r_verba`, `r_signa` and the USCCB branch alike.
  - Validity can fail at c. 1108 instead:
    - `received(E, no)`: invalid on every branch;
    - `received(E, disputed)`: both;
    - `received(E, yes)`: valid where `witness_perceived(E, W, yes)` holds for two witnesses.
  - Variant A (the assistant signs): received.
  - Variant B (an interpreter): received through the interpreter; licit only where `interpreter_fidelity(E, established)` (c. 1106).
  - Variant C (new): the assistant knows no ASL and there is no interpreter. Valid on `r_recipit_celebration`, invalid on `r_recipit_consent`: two branches, because the reading is disputed and no authentic interpretation answers it.
  - Variant D (new): the witnesses know no ASL. Valid on the common-witness minimum ("ut percipiant has celebrare matrimonium"), since they perceive the celebration.
  - Liceity: illicit on `r_signa` only for the party who can speak, where that fact is undisputed (as before). Further: c. 1106 as above; c. 1119 with c. 846 §1, two readings of a signed rendering of the approved formula (the rite kept, or changed); c. 1120, the USCCB *Guidelines* weighing as practice, never as a rite; c. 1071 §1, no condition.
- **SG7 (revised).** The absolution through an interpreter computes cleanly (cc. 990, 983 §2, 1386 §2). The absolution signed without voice carries SG-R's branches. Its liceity also meets c. 846 §1 and c. 838 (no approved ASL text), as two readings, rendering or change. The internal forum is never computed.
- **SG8 (unchanged).** BAPTIZE signed as immersion beside poured water gives `iconic_manner_differs`, never a refusal. Under `q(signifies_by_convention(ase))` fixed `yes`, the sign's likeness is not its signifying.
- **SG9 (new): ASL in time.** Every `means` cites a lexicon with its year and kind. A lexicon outside its encoding's span reports `lexicon_out_of_span`. `ase_black` is a variety, not an encoding made from `ase`. No ecclesiastical approval is entered for any Catholic ASL lexicon, because none was found.
- **SG10 (new): symmetry.** A deaf assistant receiving spoken consent through an interpreter computes exactly as a hearing assistant receiving ASL through one (c. 1106; c. 1108 §2). The route never enters c. 1108.
- **M1 still holds:** `linguae_we_baptize` and every earlier scenario unchanged. The TTC-SCHOOLS tables gain `rt_vocal` and `rt_lingual`, and do not otherwise change.

## What I could not verify

- **Primary texts not reached.**
  - Stokoe (1960) itself, and its JDSDE reprint (2005) and pages.
  - Klima and Bellugi (1979) itself.
  - Poizner, Klima and Bellugi (1987).
  - Hickok, Bellugi and Klima (1996).
  - Petitto and Marentette (1991): PubMed Central and the journal returned a robot check.
  - Kegl, Senghas and Coppola (1999), and its volume's title.
  - Polich (2005) beyond the publisher's page.
  - Goldin-Meadow and Feldman (1977).
  - Bloomfield (1933)'s wording on gesture languages.
  - Hockett (1960)'s pages, and whether he later revised the feature himself.
  - Desloges (1779); Bébian's *Mimographie* (1825); Groce (1985).
  - McCaskill et al. (2011)'s features and dates; Lucas, Bayley and Valli (2001); LeMaster (1998).
- **Augustine.** *De quantitate animae* 18.31–32's body (the deaf man at Milan); *De magistro* 3.5 and 4.8 in full; *Contra Iulianum* III.4.10. The Latin of *De Trinitate* XV.10.19 was not fetched; augustinus.it and bkv.unifr.ch gave headings only.
- **Thomas.** I q. 34 a. 1 in Latin; *In De sensu* lect. 2; Suppl. q. 9 a. 3 in Latin; the *Scriptum* IV d. 27 behind Suppl. q. 45. liriocatolico.com.br failed for these pages; it served only q. 45 and *In De anima* II lect. 18.
- **Saussure's** French (CLG p. 26) and his own judgement of Whitney's point.
- **The grammar.** Meier (1990); Lillo-Martin (1986)'s licensing claim; Padden (1983/1988); the conditional and assertive non-manuals; whether BAPTIZE is plain; the ASL forms of HOLY, SON, TRINITY, NAME and HOLY-SPIRIT in any Catholic register; any published gloss or video description of the baptismal form in ASL.
- **The Catholic holdings.** The DCA's *Rite of Infant Baptism* (1990), *Liturgical Sign Language Controversies, 1997–2002*, *Eucharist Prayer in ASL* (2016) and *COA Sacramentary* (2013): catalogue records only. Costello's first edition and date. The NCOD's founding date and any approval of its 2011 sign choices. The content of the AOW Sign of the Cross videos and of *Hands of Grace*.
- **Notation.** SignStream Report 11 (2002); Neidle's gloss conventions (IX-1p); any published inter-annotator agreement for ASL non-manuals.
- **Canon law.**
  - 1917 c. 1095 §1 3° and *Ne temere* n. 4 §3 in Latin.
  - The 1917 commentators named in the brief (Gasparri, Wernz–Vidal, Cappello), seen only through Dzierżon.
  - The *Exegetical Commentary* and the CLSA *New Commentary* on cc. 1104 and 1108.
  - Any Rota decision on deaf parties, interpreters or an assistant who did not understand.
  - Whether a deaf, blind or non-signing witness satisfies c. 1108 §1.
  - CCEO cc. 828 and 837 in Latin.
  - The Innocent III decretal's incipit and Liber Extra number.
  - c. 17's "ad locos parallelos" in full.
  - vatican.va's c. 850 came back as "Baptismus minstratur"; the spelling may be the fetch's slip or the page's.
- **Blocked or failed.** gutenberg.org by direct download (proxy 403); pmc.ncbi.nlm.nih.gov (robot check, one article); revistas.unav.edu (access check); dpej.rae.es ("forma canónica"); quod.lib.umich.edu; liriocatolico.com.br for several pages; www.cdow.org (binary).
