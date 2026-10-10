# Working in this repository

This is a deterministic checker for theological and canonical claims, built
on answer-set programming (clingo). Three layers live in
`src/theological_type_checker/lp/`:

- **Core grammar** (`icon_core.lp`, `icon_analogy.lp`, `icon_models.lp`,
  `icon_tests.lp`): typed relations, with the analogia entis enforced as a
  sort discipline.
- **Authority graph** (`icon_authority.lp`, `icon_history.lp`): tiers,
  forms, dates, and branches and shadows for *teaching*.
- **Canon-law layer** (`canon_law.lp`, `canon_cases.lp`): yes/no rules for
  *law*, dated and tagged as a norm graph.

The suite is `src/theological_type_checker/suite.py`. The MCP server is
`server.py`.

## Commands

```bash
pip install -e ".[dev]"
pytest -q                      # the suite plus engine guards
ttc-suite                      # the suite, readable
ttc-check sspx lattice         # one case, as JSON
```

The personal layer loads from `$TTC_HOME` (default `~/.ttc` if it exists).
Tests run with it disabled.

## House rules

1. **Theology branches; canon law is binary.** Do not put juridical
   questions into the authority graph or give canonists' opinions weight
   against the law. In canon law, branch only on a disputed fact, a disputed
   reading with no authentic interpretation, or the internal forum.
2. **Never compute anyone's imputability, intention or interior state.**
   These are inputs from the internal forum (the rule of non-diagnosis).
3. **Cite primary sources.** Every canon-law rule sits under a
   `% @norm <id> | <citation> | <URL>` tag. Primary texts come from
   iuscangreg (https://www.iuscangreg.it/, the Gregorian's Faculty of Canon
   Law): `cic1983.php` for the Code, `diritto_tutto.php` for extra-codal
   legislation, `risposte.php` for authentic interpretations, and
   `cic1917.php` for earlier versions. vatican.va also has the current
   English text of the Code.
   Declare new fact slots with `% @input`.
4. **Every new rule needs a test that fails without it.** Delete the rule,
   rerun, and confirm something turns red. Keep `norm_check` clean (test
   CL1).
5. **Hypothetical facts only in switch programs,** marked `HYPOTHETICAL`.
6. **A red test is a finding.** Never change an existing expectation to make
   a change pass without saying so plainly and giving the reason.
7. **Keep the encoding guide in sync.** `docs/encoding-guide.md` is a copy of
   `src/theological_type_checker/guide.md`, and a test checks they match.
8. **Run `pytest -q` before every commit.**

When the person is growing their own checker, save to their personal layer
with the MCP tools (`save_rules`, `save_case`, `save_scenario`). Change the
public rule base only when they ask for it.
