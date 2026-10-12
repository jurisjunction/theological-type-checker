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
