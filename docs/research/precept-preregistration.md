# TTC-PRECEPT(7)

## NAME

**ttc-precept** — verdicts and obligation: an amendment to the moral
library, with social doctrine as its test set; predictions, committed
before encoding

## DESCRIPTION

The trolley problem, run on `moral.lp` after TTC-MORAL, showed four gaps.
The library says "licit on the claims" or nothing: no verdict says an act
is illicit. The push and the loop were typed as direct killings by hand:
nothing ties an evil effect that is the means to that kind. The sources
the case needed (*Evangelium vitae* 57, *Veritatis splendor* 80, CCC 2258)
were entered by hand. And "may" and "must" are not distinguished.

This amendment closes them, and tests the result on the cases the
commentary makes hard (the trolley, abortion, IVF) and on the Church's
social teaching, where principle, criterion and directive must be told
apart (CCC 2423). The death penalty is the headline case: its authority
graph is already encoded (DP1-DP7); the amendment joins it to the verdicts.

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited.

## THE AMENDMENT

Fixed here.

- **Modal type.** Every verdict on an act carries one: *may* (permitted),
  *must* (obliged), *must not* (forbidden). Verdicts are said of acts,
  never of persons (rule 3; CCC 1861).
- **Must not.** An act of a kind evil by its object is forbidden on the
  kind alone, with no interior claim: "there are acts which, in and of
  themselves, independently of circumstances, are always gravely illicit
  by reason of their object" (CCC 1756; VS 80). Negative precepts oblige
  "always and in every circumstance" (*semper et pro semper*, VS 52); no
  end, claim or circumstance lifts them.
- **May.** An act that passes double effect on the claims is permitted.
- **Silence.** An act that fails double effect only for want of a claim
  gets no verdict. "Not shown licit" is never reported as forbidden.
- **Must.** Affirmative precepts bind always, but not at every moment
  (*semper sed non ad semper*, II-II q. 33 a. 2). A precept yields "must"
  only where its occasion is supplied; without one, nothing. No "must"
  ever overrides a "must not".
- **"Direct" is a reading.** Whether an evil effect that is the means makes
  the act direct is read by the order of causes (the manualists, after
  Gury) or by what is chosen (Anscombe; Finnis, Grisez and Boyle). Pius
  XII's "as an end or as a means" (1944, 1951) is claimed by both. The
  question goes on the authority graph; what is chosen is a claim,
  computed both ways.
- **Prudential judgment is input.** The conditions of a just war belong
  "to the prudential judgment of those who have responsibility for the
  common good" (CCC 2309), as proportion in double effect belongs to the
  agent: supplied, never computed.
- **Social teaching is typed.** It "proposes principles for reflection; it
  provides criteria for judgment; it gives guidelines for action"
  (CCC 2423; *Octogesima adveniens* 4). A source's teaching carries its
  type; a directive is revisable as a principle is not.

## METHOD

Extend `moral.lp`; enter the sources on the authority graph, EV 57's "I
confirm" as a claim of the ordinary universal magisterium, computed both
ways. Write cases for the trolley (lever, push, loop), abortion (direct
abortion; craniotomy; ectopic pregnancy by salpingectomy, salpingostomy and
methotrexate), IVF, the death penalty, just war and usury, and a candidate
for each refusal. Run the whole suite, the runtimes' boots and the
coverage index.

## PREDICTIONS

### VD: verdicts

- **VD1. Three verdicts.** On the trolley, the lever is "may" on the claims
  supplied. An act of a kind evil by its object is "must not" with no
  interior claim. An act that lacks only the claim of proportion gets no
  verdict.
- **VD2. Acts, not persons.** The test of rule 3 passes unchanged: no
  verdict names a person's sin or state.

### OB: obligation

- **OB1. Must, with its occasion.** Defending others is "a grave duty for
  one who is responsible for the lives of others" (CCC 2265): with the
  occasion supplied, "must". A bystander at the lever has no such
  occasion: "may".
- **OB2. No duty to do evil.** A candidate that makes an act evil by its
  object obligatory ("you must push the man to save five") is refused.

### DI: direct and indirect

- **DI1. A reading, with both values main.** No source of tier 1 to 3
  decides between the order of causes and what is chosen.
- **DI2. The trolley, composed.** On the causal reading the push and the
  loop are direct killings of an innocent, "must not" by their object; on
  the reading by choice, each turns on the claim of what is chosen. The
  lever is "may" on both. Nothing is typed by hand.
- **DI3. Abortion.** Direct abortion is "must not" in every main branch
  (EV 62; CCC 2271). With EV 57's claim computed both ways, its contrary
  is a counterfactual shadow where the claim holds and a live shadow where
  it does not.
- **DI4. Craniotomy.** On the causal reading it is "must not". On the
  reading by choice, with a claim that the child's death is not chosen, the
  Holy Office's responses (1884, 1889: it "cannot safely be taught") still
  forbid it in the main branch, at tier 3; only their live shadow permits
  it. The reading meets a source.
- **DI5. Ectopic pregnancy.** Salpingectomy is "may" on both readings, on
  the claims. Salpingostomy and methotrexate split by reading: "must not"
  on the causal one, a claim on the reading by choice.
- **DI6. IVF.** Procreation apart from the conjugal act is "must not" in
  the main branch (*Donum vitae* II.B.5, at tier 3), with a live shadow.
  The destruction of embryos is direct killing, as DI3.

### SD: social doctrine

- **SD1. The death penalty.** As of 2019, on the CDF's reading of CCC 2267,
  an execution is "must not" in every main branch, on the ground of
  circumstance (no necessity today), not of kind. On the intrinsic
  reading the ground is the kind. The two readings agree on the act and
  differ in type: "not in present circumstances" against "never". As of
  2017 an execution is "may" where grave necessity is claimed.
- **SD2. Usury.** *Vix pervenit* (1745) and the 1917 Code's c. 1543, which
  permits a legal rate of interest, entered as one question are refused:
  the canon would be law answering doctrine (rule 1). Typed as two, profit
  from the loan as such (a principle) and interest by an extrinsic title (a
  permission in circumstances), both stand: development, not reversal.
- **SD3. Just war.** With the conditions of CCC 2309 supplied as claims,
  the use of force is "may" on the claims; the comparison of evils is
  never computed (the test of proportion is extended to it).
- **SD4. Types.** A candidate that cites a directive as a principle,
  binding in every circumstance, is refused.

### M: meta

- **M1.** No earlier result changes, except MS1 and MS2, whose acts of a
  kind evil by its object gain "must not" (`act_m1`, `act_m2`, `act_d3`).
  The TTC-SCHOOLS tables do not change.
- **M2.** Every new rule has a test that fails without it; CL1 and PR4 stay
  clean.
- **M3.** In the coverage index, "Social justice" (CCC 1928-1948) and the
  seventh commandment leave the frontier, and the sixth commandment moves
  from cases to rules.

## CAVEATS

The craniotomy and ectopic cases concern decisions people face in grave
distress. The checker decides no case and judges no person; it shows what
each reading and each source requires.

Which side of the action-theory debate a given author takes in a given
case is the encoder's summary. The responses of the Holy Office are typed
tier 3 (doctrinal responses of a congregation).

Usury is typed through the 1917 Code because its canon is the plainest
juridical text; the doctrinal history is longer (Lateran V; *Vix
pervenit*; the extrinsic titles).

## STANDARDS

- Aquinas, ST I-II q. 18; II-II q. 33 a. 2; q. 64 a. 7
- J.-P. Gury, *Compendium theologiae moralis* (1850); G. E. M. Anscombe,
  "War and Murder" (1961), "Action, Intention and 'Double Effect'" (1982);
  J. Finnis, G. Grisez, J. Boyle, "'Direct' and 'Indirect': A Reply to
  Critics of Our Action Theory", *The Thomist* 65 (2001)
- Holy Office, responses of May 1884 (ASS 17, 556), 19 August 1889 (ASS 22,
  748) and 20 March 1902 (ASS 35, 162)
- Pius XII, addresses of 12 November 1944, 29 October 1951 and 27 November
  1951
- Benedict XIV, *Vix pervenit* (1745); CIC 1917 c. 1543
- Paul VI, *Humanae vitae* (1968) 12, 14; *Octogesima adveniens* (1971) 4
- John Paul II, *Sollicitudo rei socialis* (1987) 41; *Veritatis splendor*
  (1993) 52, 80; *Evangelium vitae* (1995) 56, 57, 62
- Congregation for the Doctrine of the Faith, *Donum vitae* (1987);
  *Dignitas personae* (2008)
- CCC 1756, 1861, 2258, 2263-2265, 2267 (1992, 1997, 2018), 2271, 2309,
  2376-2377, 2423
- Pontifical Council for Justice and Peace, *Compendium of the Social
  Doctrine of the Church* (2004)

## SEE ALSO

[ttc-moral(7)](moral-preregistration.md), [ttc-coverage(7)](../coverage.md),
[ttc-roadmap(7)](../roadmap.md)

## SCORING

Appended after the runs. Predictions committed in a02c284 and stamped in
9538e6d. Encoded in `moral.lp` (verdicts; "direct" as a reading; conditions
by prudential judgment; affirmative precepts; social teaching typed),
`icon_history.lp` (the reading of "direct"; the sources on the killing of
the innocent, craniotomy and ectopic extraction, IVF; usury as one question
and as two; a directive cited as a principle) and `canon_cases.lp` (the
trolley with the transplant, the guard's duty, abortion, ectopic pregnancy,
IVF, an execution, just war, a loan, and the candidates). Scenarios VD,
OB, DI, SD (18).

| | Result |
| --- | --- |
| VD1 | Held (VD1, VD1b). The lever is "may" on the claims; the transplant, with nothing claimed, "must not" in every main branch; the lever without the claim of proportion gets no verdict, and with it, "may". In the moral cases the acts of a kind evil by its object are "must not" with or without consent claimed; d2 and d4, not shown licit, are not forbidden. |
| VD2 | Held (VD2). The test of rule 3 passes unchanged; every verdict, in the trolley, abortion and IVF cases, is said of an act, none of a person. |
| OB1 | Held (OB1). The guard, with the occasion supplied, "must" defend his charges; the bystander has no obligation and "may". |
| OB2 | Held (OB2). The candidate is refused in every main branch, and the push stays "must not" on the causal reading. In the shadow where the direct killing of the innocent is not evil by its object, nothing refuses it: the refusal rests on the teaching, as it should. |
| DI1 | Held (DI1). Both values main; the sources are of tier 5. Weight prefers the reading by choice, two to one, because two of its authors were entered and one manualist: a preference only, and here a count of the encoding (§2 of the findings). |
| DI2 | Held (DI2). On the causal reading the push and the loop are "must not" as direct killings of the innocent; on the reading by choice each is "must not" where the death is claimed chosen and "may" where it is claimed not chosen; the lever is "may" on both. No case gives an act a direct kind; a test pins it. |
| DI3 | Held (DI3), with the standing qualification of every counterfactual shadow: the contrary is counterfactual where a claim of the ordinary universal magisterium holds (EV 57 or EV 62) *and* tier 2 is read as truth (`t2_truth`), live otherwise. Never main. |
| DI4 | Held (DI4). |
| DI5 | False for salpingostomy (DI5). Salpingectomy is "may" on both readings and methotrexate splits by reading, as predicted. Salpingostomy does not split: typed as what it outwardly is, the extraction of an immature ectopic fetus, it meets the Holy Office's response of 1902 in every main branch on both readings, as craniotomy meets those of 1884 and 1889 (DI4); only the live shadow of the response permits it. The source was entered for the case and not seen to apply. |
| DI6 | Held (DI6). |
| SD1 | Held in part (SD1, SD1b, SD1c). As of 2019 on the CDF's reading, "must not" in every main branch by circumstance, never by kind: held. On the intrinsic reading the kind is the ground in the branch that holds it, but the circumstance stays main beside it: read so, CCC 2267 contradicts EV 56 and DH 795 at tier 3, a tension in which neither cleaves (as DP3 already shows). The readings agree on the act. As of 2017, false as stated: "may" holds only where necessity today is "sometimes", and whether it is was open, since no source before 2018 answers the question; EV 56's "very rare, if not practically non-existent" is not entered on it. |
| SD2 | Held (SD2, SD2b). |
| SD3 | Held (SD3). Three claims of four: silence; a condition denied: "must not" by circumstance. `prudential/2` is derived by no rule; a test pins it, beside the test of proportion. |
| SD4 | Held (SD4). |
| M1 | Held in part. No earlier scenario's pass or fail changed, nor any branch count. But seven outputs gained verdicts, not two: every scenario that loads the moral cases (MS1, MS1b, MS2, MS2b, MS2c, MS2d) and CH2. The acts named gain "must not" as predicted; the prediction missed the "may" of d1 and of defence, the candidate of MS2c making d2 and d3 "may" (d3 is then "may" and "must not" at once, and refused as before), and the candidate act of the Son in CH2. The TTC-SCHOOLS tables did not change. |
| M2 | Held after closing gaps. Each new statement was deleted in turn (20 in `moral.lp`, 50 in `icon_history.lp`, 58 in `canon_cases.lp`); every deletion now turns a scenario red. Closed on the way: a death chosen as the means, in the shadow where the direct killing of the innocent is not evil by its object, still fails double effect (DI2; the means condition on the reading by choice had no test); each source pinned by the branches it cleaves, or by weight; each claim of the ordinary universal magisterium shown sufficient alone (DI3); salpingostomy direct on the causal reading (DI5); the candidate's obligation derived and refused (OB2); usury as one question left open (SD2); a loan for profit as such "must not" (SD2b); verdicts said of acts in the abortion and IVF cases (VD2). Removed as inert: two law kinds, two descriptive kinds on acts whose kind is composed, a loan by an extrinsic title. CL1 and PR4 clean. |
| M3 | Held in part. The seventh commandment leaves the frontier (SD2, SD2b, SD4) and the sixth moves to rules (DI6). "Social justice" (CCC 1928-1948) stays on the frontier: nothing in the amendment encodes respect for the person, equality or solidarity. The prediction counted the social teaching tested here (CCC 2309, 2423, 2267) as that article's; it belongs to the fifth and seventh commandments. |

### Not predicted

- **Weight by headcount** (DI1): the reading by choice is preferred
  because more of its authors were entered.
- **The transplant.** VD1 needed an act evil by its object with nothing
  claimed; the trolley's own companion (one killed for five transplants)
  supplied it.
- **The death penalty's questions are not yes or no.** The case states the
  bridge from its values to the kind and the condition (two rules in
  `dp_verdict`); `classification/3` reads only "yes".
- **Salpingostomy meets 1902** (DI5).
- **The intrinsic reading keeps the circumstance main** (SD1b).
- **2017 was open** (SD1c).
