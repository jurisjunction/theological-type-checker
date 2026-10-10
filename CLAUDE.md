# CLAUDE(5)

## NAME

**CLAUDE.md** — rules for working in this repository

## DESCRIPTION

This is a deterministic checker for theological and canonical claims
(clingo). The rule base is in `src/theological_type_checker/lp/`:

| Layer | Files |
| --- | --- |
| grammar | `icon_core.lp`, `icon_analogy.lp`, `icon_models.lp`, `icon_tests.lp` |
| authority (teaching) | `icon_authority.lp`, `icon_history.lp` |
| canon (law) | `canon_law.lp`, `canon_cases.lp` |
| pair, frontier | `pair.lp` |
| library | `library.lp` |

The suite is `suite.py`, the server is `server.py`, the fetch lists are
`library.py`, the norm graph is `norms.py`.

## COMMANDS

```
pip install -e ".[dev]"
pytest -q
ttc-suite
ttc-check sspx lattice
ttc-library ic --near 41.90,12.45
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
    capitals, opinions confined to BUGS and CAVEATS.
11. **Run `pytest -q` before every commit.**

While the person is growing their own checker, write to their layer with
`save_rules`, `save_case`, `save_scenario` and `mark_consulted`. Change the
public base only when asked.
