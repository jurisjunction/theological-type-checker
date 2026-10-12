# CLAUDE(5)

## NAME

**CLAUDE.md** — rules for working in this repository

## DESCRIPTION

This is a deterministic checker for theological and canonical claims
(clingo). The rule base is in `src/theological_type_checker/lp/`:

| Layer | Files |
| --- | --- |
| kernel (and the deposit's rules) | `kernel_core.lp`, `kernel_analogy.lp`, `kernel_world.lp` |
| the Grammar of the Icon (one theory) | `icon_theory.lp`, `icon_models.lp`, `icon_tests.lp` |
| schools (runtimes, readings, switches) | `schools.lp`, `icon_metaphysics.lp` |
| authority (teaching) | `icon_authority.lp`, `icon_history.lp` |
| libraries: the human act, law, morality and sin, grace, Christ, the sacraments, faith | `act.lp`, `law.lp`, `moral.lp`, `grace.lp`, `christ.lp`, `sacrament.lp`, `faith.lp` |
| canon (law) | `canon_law.lp`, `canon_cases.lp` |
| pair, frontier | `pair.lp` |
| library | `library.lp` |

The suite is `suite.py`, the server is `server.py`, the fetch lists are
`library.py`, the norm graph is `norms.py`. The runtimes are
`engine.RUNTIMES`; their boot and pair tables are `schools.py`.

## COMMANDS

```
pip install -e ".[dev]"
pytest -q
TTC_SLOW=1 pytest -q tests/test_schools.py
ttc-suite
ttc-schools
ttc-check sspx lattice
ttc-library ic --near 41.90,12.45
ttc-coverage --write
```

The personal layer is `$TTC_HOME` (default `~/.ttc` if present). Tests run
with it disabled.

## RULES

1. **The ordered pair.** Teaching first, law ordered to it. Theology facts
   go on the authority graph; juridical facts go in the canon layer. Link
   them only with `classification/3` and `premise/3`. Law never answers a
   doctrinal question.
2. **Canon law is binary.** It branches only on a disputed fact, a disputed
   reading with no authentic interpretation, or the internal forum.
   Canonists never weigh against the law.
3. **Non-diagnosis.** Never compute imputability, intention or interior
   state.
4. **Primary sources.** Every canon-law rule sits under
   `% @norm id | citation | URL`. Texts come from iuscangreg
   (https://www.iuscangreg.it/: `cic1983.php`, `diritto_tutto.php`,
   `risposte.php`, `cic1917.php`) or vatican.va. Declare new slots with
   `% @input`.
5. **A test per rule.** Each rule needs a test that fails without it. Keep
   CL1 and PR4 clean.
6. **Hypothetical facts go in switch programs only,** marked `HYPOTHETICAL`.
7. **A red test is a finding.** Never change an expectation without
   stating the change and the reason.
8. **No hand-entered ISBNs or OCLC numbers.** They are resolved at fetch
   time.
9. **Keep `docs/encoding-guide.md` identical to `guide.md`.**
10. **Write docs in the house style:** a BSD man page, terse, sections in
    capitals, opinions confined to BUGS and CAVEATS. Two exceptions stay
    prose. `docs/theology-of-the-core.md` is a theological treatise in the
    manner of Clarke's *The One and the Many*: the discipline's vocabulary
    only, no notation in the body (the concordance maps it). The research
    report is an evidence record.
11. **Run `pytest -q` before every commit.**
12. **Stamp predictions before encoding.** Commit the predictions, run
    `tools/stamp`, commit the proof, then begin. Commit dates are typed by
    whoever commits; a stamp is not.
13. **No names.** The work is CC0 and anonymous. Commits and citations say
    *Ora pro me, peccatore*; examples use neutral places. See
    `docs/archive.md`.
14. **Tiers are computed, never taken on anyone's word.** A source's tier
    comes from its form, and the form's conditions are shown, not
    asserted: for a papal definition, those of Pastor aeternus (DH 3074);
    for a council, that it openly declares a definition (Vatican II,
    notification of 16 November 1964); for the ordinary universal
    magisterium, those of LG 25. Any statement about the tier or grade of
    a teaching, its own or another's, by any author (a dicastery, a pope,
    a council), is a claim: entered with its claimant, computed both ways,
    flagged when a lower tier speaks of a higher, refused when treated as
    fixing. A document that reports a teaching of the ordinary universal
    magisterium keeps its own tier. "No doctrine is understood as defined
    infallibly unless this is manifestly evident" (c. 749 §3): where the
    conditions are not shown by evidence independent of the claimant, the
    branch resting on the claim is never preferred.

While the person is growing their own checker, write to their layer with
`save_rules`, `save_case`, `save_scenario` and `mark_consulted`. Change the
public base only when asked.
