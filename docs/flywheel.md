# A checker that grows with use

A working canonist uses the whole jurisprudential apparatus: the Code,
authentic interpretations, Rotal jurisprudence, curial practice, and the
commentators. Nobody encodes all of that up front. This checker is built to
grow the way a canonist's own files grow, **one question at a time**. Each
time you use it, it should end up knowing a little more and testing a
little more. This page explains how to set that up, and how to keep the
growth honest.

## Set it up (Claude Code, on your own computer)

```bash
git clone https://github.com/jurisjunction/theological-type-checker
cd theological-type-checker
python3 -m venv .venv && .venv/bin/pip install -e ".[mcp]"
.venv/bin/ttc-suite                       # check it runs

mkdir -p ~/.ttc && git -C ~/.ttc init     # your personal layer, versioned

claude mcp add --env TTC_HOME="$HOME/.ttc" --transport stdio --scope user \
  theological-type-checker -- "$(pwd)/.venv/bin/ttc-mcp"
```

Now every Claude Code session has the checker's tools. Your own rules,
cases and tests live in `~/.ttc`, a folder of plain text files that is
yours: keep it private, or push it to a repository of your own. The public
rule base stays untouched until you decide to contribute something back.

| In `~/.ttc` | What it holds |
| --- | --- |
| `rules/*.lp` | canons you have encoded, and your own rules |
| `rules/case_*.lp` | cases: the facts of a question, as a part you can run |
| `scenarios.json` | results you have checked and confirmed, kept as regression tests |

Everything in it loads automatically, and every test in it runs with the
public suite.

## The loop

Each turn of the wheel follows the same five steps.

1. **Ask.** Bring a real question: a case, a text, a decree.
2. **Encode.** The model turns it into facts, using the canons already
   encoded and stating every interpretive choice as a fact you can check.
3. **Find the gap.** If a canon the question needs is missing, `norm_check`
   shows it in the frontier, or the result is simply silent. The model
   fetches the **primary text** (iuscangreg for legislative documents,
   vatican.va for the Code), encodes it under a `% @norm` tag with the
   citation, and proposes it with `save_rules`. The rules are saved **only if
   the whole suite stays green.** If something turns red, that is a finding:
   either the new rule is wrong, or an old test encoded a mistake. You decide
   which.
4. **Check.** Run the case. Where the checker disagrees with a text, ask
   whether the checker is wrong or the text is. If you suspect the checker,
   test the change with `fix_method` before adopting it.
5. **Keep.** When you have checked a result and agree with it, record it with
   `save_scenario`. From then on, every change to the rules must keep that
   result, or say why not.

Over time the frontier shrinks, the scenarios accumulate, and the checker
becomes your own annotated Code: every canon tied to its text, every result
tied to a case you once had to think through.

Things to say to the model in Claude Code:

- *"Check this decree against the canon-law layer, and tell me which canons
  you had to assume."*
- *"c. 1332 isn't encoded. Fetch it, encode it, and save it if the suite
  stays green."*
- *"I agree with that result. Save it as a scenario."*
- *"What's on the frontier? Pick the canon that would unblock the most."*
- *"Run fix_method on this change to c. 751 and tell me what it costs."*

## Growing the apparatus, in order

Each kind of source has its own place, and none of them is "weight" in the
canon-law layer:

| Source | Where it goes | How it acts |
| --- | --- | --- |
| The Code and papal legislation | `@norm` rules | binding rules, dated |
| Authentic interpretations (c. 16; the Dicastery for Legislative Texts, with papal approval) | `authentic_reading/3` facts | fix the reading of a canon |
| Curial acts (decrees, rescripts, grants) | case facts | binding within their competence; a lower act cannot defeat a higher one (c. 135 §2) |
| Rotal jurisprudence and curial practice | case facts and, where the law is silent, readings | fill gaps under c. 19, never in penal cases |
| Commentators | tier-5 sources in the authority layer | name readings; never decide them |

A sensible order: first the canons your recurring cases touch, then the
authentic interpretations of those canons, then jurisprudence for the gaps
you actually meet.

## Keeping it honest

- **Every rule cites its source,** with the text paraphrased closely in the
  tag.
- **Every rule earns a test.** A scenario should fail if the rule is
  deleted. The public suite is checked this way, by mutation; do the same
  for your own rules.
- **Hypothetical facts stay in switches,** marked `HYPOTHETICAL`. Real facts
  go in cases, with their source.
- **Never compute a person's interior.** Imputability, intention and belief
  are inputs from the internal forum, never outputs.
- **A red test is information,** not an obstacle. Do not change an old
  expectation to make a new rule pass without saying why.

## Contributing back

When a canon or case in your folder is solid (sourced, tested, and used
more than once), it belongs in the public rule base. Move the file into
`src/theological_type_checker/lp/` and the scenario into `suite.py`, run
`pytest`, and open a pull request. See [CONTRIBUTING](../CONTRIBUTING.md).
