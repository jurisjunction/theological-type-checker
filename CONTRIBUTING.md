# Contributing

Thank you for considering it. This project improves by being argued with,
and it needs people who know the sources better than its authors do.

## Ways to contribute

**1. Challenge an encoding.** This is the most valuable contribution and needs
no code. Open an issue saying which source is mis-tiered, mis-dated, mis-read
or mis-typed. Give the correct reference (DH number, AAS volume and page,
canon, or edition and page) and say why. If the reading is genuinely
disputed, say that too. The checker can carry both readings as branches.

**2. Propose a case.** Pick a question with a documented history: a dispute
the magisterium settled, one it protected, one still open, or a juridical
question with dated acts. List the sources with dates and what each holds.
Say what you expect the checker to show and why. An issue is enough; a pull
request with the encoding is better. The SSPX and remarriage cases are good
models.

**3. Propose a rule change.** If you think the checker is wrong rather than
the text, write the change as rules to add or lines to remove and run it
with the `fix_method` tool (or edit the rule file and run `ttc-suite`). Report
what it newly explains and what it turns red. A change that buys one case at
the price of others needs an argument for each loss. A change with no
warrant independent of the case it rescues will not be adopted.

**4. Improve the engine or the server.** Performance, a port to another
Datalog engine (Soufflé is the obvious one), better reports, client
integrations.

## Standards

- **Every source cited precisely.** Use DH numbers for conciliar and papal
  texts, the AAS where it exists, canon and paragraph for the Code, and
  edition and page for theologians. A source no one can check will not be
  merged.
- **Every rule has a warrant and a test.** Name the warrant in a comment.
  Add a scenario to `suite.py` that fails without the rule (delete the rule
  and confirm the test turns red).
- **Every interpretive choice is a fact.** If a text can be read two ways,
  encode it as `ambiguous` with both readings rather than choosing silently.
- **Non-diagnosis.** No rule may compute a person's culpability, intention
  or interior state. These are internal-forum inputs only.
- **No verdicts on persons.** Cases concern texts, acts and questions. Where
  a case concerns living people (as the SSPX case does), it encodes only what
  public acts say and keeps every personal question in the internal forum.
- **Charity in argument.** People on every side of these questions are
  represented in the sources. Contributions that mock a position, or treat a
  school the Church tolerates as illegitimate, will be asked to revise.

## Running the tests

```bash
pip install -e ".[dev]"
pytest -q          # the suite plus engine guards
ttc-suite --md report.md
```

The suite must pass, and must stay deterministic.

## Licensing of contributions

By contributing, you agree that code contributions are licensed under the
MIT License and documentation contributions under CC BY 4.0, as described in
`LICENSE` and `LICENSE-docs`.
