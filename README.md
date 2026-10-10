# Theological Type Checker

**A deterministic type checker for theological and canonical claims, built to
be driven by a language model and read by theologians and canonists.**

Much of what goes wrong in theological argument is a category mistake, not a
false premise. Some typical forms:

- a disciplinary law read as a doctrinal definition
- a "cannot" where the text means "ought not"
- a property every person has used to rank persons
- evidence about a group offered as a verdict about a person
- a creaturely predicate carried over to God without the analogy that would
  license it

This project writes the tradition's own type discipline down as rules a
machine can check. The rules come from the communicatio idiomatum, the
analogia entis, the grades of assent in cc. 750–752, and the distinction of
forums. The result is a checker you can run against a text, a case or a
proposed change to the theory.

It has three layers:

- **A core grammar.** *The Grammar of the Icon* is a small typed theory of five
  relations: giving being, originating, acting on, nuptial self-gift, and being
  ordered together to a common end. Analogy is enforced as a sort discipline:
  nothing crosses the Creator–creature line except through a declared bridge
  with a mode on each side. From thirteen axioms it derives results such as
  c. 1084's line between impotence and sterility, and it shows several real
  positions to be ill-formed.
- **An authority graph.** Every source has a tier (c. 750 §1, c. 750 §2,
  c. 752 and ecclesiastical law, the Doctors, theologians), a force, a form,
  a character and a date. Every disputed question splits into branches. Only a
  tier-1 act deletes a branch. Lower acts cleave a branch into a *shadow* that
  names exactly what would bring it back. Teaching and governance are
  different types: lex posterior applies to law, never to doctrine.
- **A canon-law layer.** Canons are encoded as dated yes/no rules: given the
  facts and the norm in force, an effect follows or it does not. The canons
  form a graph, from definitions to delicts to penalties to effects and
  their exceptions, and the checker tests it for loops and gaps. It branches
  only on disputed facts, disputed readings of a canon, and the internal
  forum, which it never computes.

> The checker can show that a claim is ill-formed in this grammar. It cannot
> show that a well-formed claim is true. That judgment belongs to Scripture,
> Tradition and the magisterium (*Dei Verbum* 10). Everything here is argument
> from fittingness, submitted to the judgment of the Church.

## What it has found

Running the theory on cases it was never built for has mostly found errors
*in the theory*. That is the point. A few highlights; the full list is in
[docs/findings.md](docs/findings.md):

- **Univocity has a visible cost.** Give the grain of origination one mode on
  both sides of the analogy and the theory either declares existing children
  impossible or lays a norm on God. The checker's bridge is compatible with
  Scotus's univocity of *concept*. What fails is univocity of *mode*, which is
  the distinction the Radical Orthodoxy debate tends to blur.
- **Weight is not prediction.** In the Immaculate Conception backtest, the
  weight of authority ran against Scotus's position from 1400 to 1661, Doctors
  included. Protective acts kept it alive as an open branch until 1854. The
  checker never lets weight delete a branch.
- **Two axioms overstated their modality** ("cannot" for "ought not"; "is" for
  "is called to be"). The second silently excluded a school the magisterium
  protects (limbo). The fix came from rereading the axiom's own warrant
  (*Mulieris dignitatem* 25) and changed nothing else.
- **Public disputes reduce to typings.** Communion after remarriage turns on
  whether one norm is teaching or governance, and recency favours opposite
  sides under the two typings. The death penalty turns on the modal type of one
  text and the tier of another.
- **Canon law is not weighed.** The first encoding of the SSPX case ran
  juridical questions through the theological authority graph. That was a
  type error, and the binary canon-law layer replaced it. On the facts of
  record, the 2016 papal grant stands until a competent revocation, so the
  DDF note's "confessions are invalid" holds for some acts and not others.
  The checker shows exactly which fact would change that. "The process was
  superfluous" is c. 1717 §1: notoriety can dispense the investigation,
  never the hearing. See [docs/cases/sspx-2026.md](docs/cases/sspx-2026.md).

## Quick start

```bash
git clone https://github.com/jurisjunction/theological-type-checker
cd theological-type-checker
pip install -e ".[mcp]"

ttc-suite                                   # 144 tests, deterministic
ttc-check sspx lattice                      # one case, as JSON
ttc-check --facts examples/new_question.lp  # your own facts
ttc-mcp                                     # the MCP server (stdio)
```

Requires Python 3.10+ and [clingo](https://potassco.org/clingo/) (installed
automatically).

## Using it with a language model

The interpretive step, turning a text into typed facts, needs a capable
model or a careful person. The checker does the rest. The MCP server exposes
these tools:

- `guide`, `list_parts` and `read_part`, to learn the encoding and the
  existing cases
- `check` and `compare`, to run a case with new facts
- `run_suite`, the regression suite
- `fix_method`, to propose a change to the theory and see what it gains and
  loses across every case
- `lint`, the static analogy check

It also has `norm_graph` and `norm_check` for the canon-law graph, plus
tools that let the checker **grow with use**. Your own canons, cases and
confirmed results are saved to a personal folder and run with every test
from then on. Setup and an example session are in [docs/mcp.md](docs/mcp.md).
How to make your checker better every time you use it is in
[docs/flywheel.md](docs/flywheel.md).

## Documentation

| Read this | If you want |
| --- | --- |
| [Guide for theologians and canonists](docs/guide-for-theologians-and-canonists.md) | What the checker is, how it reasons, how to read a result |
| [Findings](docs/findings.md) | What running it has turned up, with test references |
| [Core Edition](docs/core-edition.md) | The formal statement: axioms, warrants, theorems, every test table |
| [Canon-law layer](docs/canon-law-layer.md) | Why canon law is binary here, how a canon is encoded, the norm graph |
| [The flywheel](docs/flywheel.md) | Set up a personal checker in Claude Code that grows with use |
| [Cases](docs/cases/) | Worked cases with sources |
| [Research report](docs/research/warrants-and-prior-art.md) | The A4a warrant, prior art in the Navarra school, and the grounds of the reservation of orders |
| [Encoding guide](docs/encoding-guide.md) | The fact vocabulary, for writing new cases |
| [MCP](docs/mcp.md) | Running it from a language model |

## Status: an evolving research programme

This is version 0.2. The theory has changed every time it met a new case, and
that is how it is meant to work. It is judged as a research programme is
judged (Lakatos): a change must explain more without explaining less, and a
change made only to rescue a case is not adopted. See [ROADMAP.md](ROADMAP.md)
for what is open.

## Collaborators welcome

Theologians, canonists, historians, philosophers and programmers are all
welcome. The most useful contributions are:

- a new **case**, as dated sources and the questions they answer
- a **challenge** to an existing encoding: this text is mis-tiered, mis-read
  or mis-typed
- a **rule change**, tested with the fix method

Disagreement is the material the method runs on. See
[CONTRIBUTING.md](CONTRIBUTING.md).

## License

Code under the [MIT License](LICENSE). Documentation under
[CC BY 4.0](LICENSE-docs). If you use this work, please cite it
([CITATION.cff](CITATION.cff)).
