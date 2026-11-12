# TTC-REPAIRS6(7)

## NAME

**ttc-repairs6**: a tier counts only as shown; a case that does not type-check
says so first; and a prover that prints why; predictions, committed before
encoding

## DESCRIPTION

Read as the rules stand at `6d3b5bf` (TTC-MENDACIUM's predictions stamped).

- **Deletion rests on the tier as entered, not as shown.** Rule 14 says a
  tier is computed from the form, never taken on anyone's word. The
  authority layer does check the form: an entered tier 1 or 2 without its
  warrant raises `violation(tier_without_warrant(S,T))` (`icon_authority.l`,
  rule 14). But the rules that give a tier its force read `eff_tier/2`,
  which comes from `source/4` as entered. A tier-1 truth source deletes its
  contrary whether or not `warranted(S)` holds; the violation stands beside
  the deletion, not under it.
- **How it was found.** A derivation printer run beside the base (a
  prototype, `why.py`, not in the repository) asked why `q(ic)=no` is
  excluded as of 1860. Its proof was the same with Pastor aeternus's five
  conditions shown for `ineffabilis_1854` and with all five removed: the
  integrity constraint, `eff_tier(ineffabilis_1854,1)` from `source/4`, and
  `supports(ineffabilis_1854,q(ic),yes)`. `warranted/1` appeared nowhere in
  it.
- **No answer of the base is wrong.** The suite's warrant audit (TC1) runs
  every part that holds a source at tier 1 or 2, candidates aside: 33 parts,
  none unwarranted. The gap is in the proof. It reaches answers only through
  a case entered from outside the base (`check`, `save_case`, the
  flywheel), where a reader who reads past the violation reads a deletion
  the form does not support.
- **`ttc-say` puts the answer first.** A case with a violation prints its
  QUESTIONS before the violation, which sits among IN EVERY BRANCH.
- **The checker cannot say why.** NORMS names the norm blocks whose rules
  wrote a result, "not a proof that an instance came by it" (ttc-say(1)).

The discussion that found this: a session preparing a talk on the checker,
which first ran the Immaculate Conception's data with the conditions
removed, then built the prototype to ask why the branch was still deleted.

This file is committed and stamped before any of it is encoded. SCORING
will be appended below; nothing above it will be edited.

## THE DESIGN

### A tier counts only as shown

- One rule, in `icon_authority.l`: `shown_tier(S,T)` holds where
  `eff_tier(S,T)` holds and either T is 0 or 3 and above, or T is 1 or 2 and
  `warranted(S)`. It is per tier: a source entered at two tiers (as `lg25`
  is, at 3 in `tier2` and at 1 in `cand_lg25_tier1`) is shown at the one
  and not at the other.
- Five rules of the authority layer read `shown_tier/2` in place of
  `eff_tier/2`:
  1. the integrity constraint by which a tier-1 truth source deletes its
     contrary;
  2. `outranked/2`, by which nothing below tier 1 cleaves the branch a
     tier-1 text requires;
  3. `info(against_tier1(S,Q))`;
  4. `counterfactual_by/1`, by which a tier-2 truth source's shadow is
     counterfactual where tier 2's force is assumed;
  5. `fixed/1`, by which a source of a strictly higher tier fixes the
     question about a tier's force.
- An unwarranted tier-1 truth source then deletes nothing and protects
  nothing; an unwarranted tier-2 source cleaves as a reformable act (a live
  shadow). The violation is unchanged. Tier 0 needs no warrant and is not
  touched.
- Nothing else reads `shown_tier/2`. The libraries' uses of `eff_tier(S,1)`
  (CAVEATS) are not changed by this step.

### A case that does not type-check says so first

- `ttc-say`, and the MCP `say`, print an `ILL-FORMED` section after the
  header and before QUESTIONS whenever the result holds a violation: the
  count, then each violation said through its template, its atom under it.
  The violations leave IN EVERY BRANCH.
- A result with no violation prints exactly as before.

### A prover

- `ttc-say --why ATOM` and `ttc-say --why-excluded Q=V` print a proof; the
  MCP server gains a read-only tool, `why`, with the same arguments as
  `say`.
- The prover grounds the same program as `solve`, with each rule `H :- B`
  given a twin that records the rule instance (`H`, its positive body, its
  negated body) when it fires, and each integrity constraint on `holds/2`
  given a twin that records which value it would remove. The twins'
  atoms are hidden; nothing else is added.
- A proof is read back from one model, well-founded: each atom by a rule
  instance whose positive body was proved at a lower level; facts entered
  are leaves; a negated literal is a leaf, "nothing derives it". Each step
  names its file and line, and the norm (`% @norm`) or section it sits
  under; an atom with a `say` template is said through it.

## PREDICTIONS

### The tier as shown (WR)

- **WR1.** With the conditions of `ineffabilis_1854` removed (a test part,
  HYPOTHETICAL), as of 1860, `q(ic)=no` is no longer excluded:
  `q(ic)` has a main branch for each value, and
  `violation(tier_without_warrant(ineffabilis_1854,1))` holds in both.
  Before the repair, `no` is excluded (B5's data, conditions removed).
- **WR2.** An unwarranted tier-1 truth source does not keep a tier-3 source
  from cleaving its branch: in a synthetic part, the tier-3 source's
  contrary leaves the tier-1 source's value a live shadow, and
  `info(against_tier1(…))` is not derived for the tier-3 source.
- **WR3.** An unwarranted tier-2 truth source cleaves as a live shadow,
  never a counterfactual one: with `jansenism`, `jansen_fact` and
  `cand_ad_sanctam_on_dh`, `q(five_in_augustinus)=no` is a live shadow in
  every branch, including those that assume `t2_truth`. Before the repair
  it is a counterfactual shadow where `t2_truth` is assumed.
- **WR4.** An unwarranted source of a higher tier does not fix the question
  about tier 2's force: in a synthetic part with a non-interpretive tier-1
  `meta_supports` of `t2_truth` and no warrant, `assume(t2_truth)` still
  branches both ways.
- **WR5.** No expectation of the suite changes. Every scenario's atoms are
  compared, `main` against the branch: the runs that change are only those
  loading `cand_ad_sanctam_on_dh` (WR3's atoms) and the new test parts. The
  runs loading `cand_lg25_tier1` or `cand_ev57_ex_cathedra` do not change:
  `lg25` supports no question and its meta-support is interpretive;
  `ev57_def` supports none.
- **WR6.** The warrant audit (TC1) still finds 33 parts, none unwarranted.
- **WR7.** Each of the five rewritten rules, and `shown_tier/2`'s second
  rule, has a test that fails without it. CL1 and PR4 stay clean.

### ILL-FORMED first (IF)

- **IF1.** `ttc-say` on WR1's case prints `ILL-FORMED` before `QUESTIONS`,
  with one violation, and IN EVERY BRANCH no longer lists it.
- **IF2.** For every scenario of the suite whose result holds no violation,
  `ttc-say`'s output is byte for byte what it was.

### The prover (PV)

- **PV1.** As of 1860, on the base as it stands after the repair, the proof
  of `--why-excluded 'q(ic)=no'` passes through `warranted(ineffabilis_1854)`
  and through each of its five `condition_shown/2` facts.
- **PV2.** The twins change no result: for every scenario's parts, the
  shown atoms of every model are the same with the twins as without.
- **PV3.** The proof is deterministic: two runs print the same bytes.
- **PV4.** Every step under a norm block names its citation; every step
  whose atom has a `say` template is said through it.
- **PV5.** On B1–B5, the prover takes at most three times as long as
  `ttc-check` on the same parts.

## CAVEATS

The libraries also give tier 1 force through `eff_tier(S,1)`:
`defined_value/2` and `form_given/0` (`empirica.l`), `note_by/3`
(`faith.l`), `given/3`, `endless/2`, `general_rule/0` and
`one_body_in_force/0` (`novissima.l`), `canons_on_the_sacrifice/0`
(`sacrament.l`), `oum_fixed/1` and `reception_fixed/1`
(`icon_authority.l`), and `owed/2` through `binds/3`. Whether each should
read `shown_tier/2` is a question for its library, not for this step.

A proof is one well-founded derivation among those a model may hold. A
choice is a leaf ("chosen: this branch"); an aggregate's elements are not
expanded; a false atom is said only as "nothing derives it", not as which
rules failed and why.

The prover explains a model, not the question of why no other model
exists, except where an integrity constraint on `holds/2` removes a value.

## SEE ALSO

[ttc-say(1)](../say.md), [ttc-communion(7)](communion-preregistration.md)
(TC1, the warrant audit), [ttc-repairs5(7)](repairs5-preregistration.md)
