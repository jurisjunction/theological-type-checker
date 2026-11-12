# TTC(1)

## NAME

**ttc** — theological type checker

## SYNOPSIS

```
ttc-suite [--md file] [--show id] [--with part]
ttc-check [part ...] [--facts file] [--branches n] [--list]
ttc-say [case.lp] [--parts p,…] [--brief] [--no-entered] [--why atom] [--why-excluded q=v]
ttc-schools [--dh1330]
ttc-library [part ...] [--near lat,lon | place] [--per-item n] [--no-reading] [--csv file]
ttc-coverage [--write]
ttc-l build | check | gbnf [--l dir] [--lp dir] [--home dir] [--side theology | canon] [--slot name/n]
ttc-mcp [--http [--host addr] [--port n] [--writers]] [--new-token name]
```

## DESCRIPTION

**ttc** checks theological and canonical claims for well-formedness. It
does not check them for truth. Its layers are used as an ordered pair
(teaching first, law ordered to it):

- **grammar**: a kernel of typed relations, with the deposit's rules.
  Analogy is a sort discipline: nothing crosses the Creator–creature line
  without a declared bridge. Schools run on it as runtimes (Thomist,
  Scotist, Suárezian, Palamite); so do the modernities, a DAG from Scotus
  to Kant with Leo XIII's hearers; the tongues; and a runtime of the
  person's own. One theory, the *Grammar of the Icon*, runs on them.
- **authority**: sources by tier (Scripture, tier 0, read and never raw;
  the creeds and c. 750 §1, §2; c. 752; Doctors; theologians), form,
  character and date. A tier is computed from the form, never taken on
  anyone's word. Questions branch. Only tier 1 deletes a branch; lower
  acts leave shadows.
- **libraries**: what the cases call: the human act, law, morality and
  sin, grace, Christ, the sacraments, faith, time, authorship, the
  liturgy, the last things, the empirical, language, the four causes,
  substitutions for God, a term lifted above an order, the intellect,
  things by their causes, the Word and the light.
- **canon**: canons as dated yes/no rules, in two codes (the Latin, the
  Eastern), chosen by ascription. A canon-law question branches only on
  disputed facts, disputed readings, or the internal forum, which **ttc**
  never computes.

The rule base is written in L and compiled to clingo
([ttc-l(1)](docs/l.md)). Each step is predicted and stamped before it is
encoded, then scored ([ttc-roadmap(7)](docs/roadmap.md)).

Encoding is interpretation. Checking is mechanical. Do not confuse them.

**ttc-suite** runs every scenario. **ttc-check** runs one case.
**ttc-say** prints a result as text, through the base's own templates
([ttc-say(1)](docs/say.md)). **ttc-schools** boots each school and tongue
alone, and the schools in pairs. **ttc-library** prints a fetch list of
physical copies, with the nearest library first
([ttc-library(1)](docs/library.md)). **ttc-coverage** maps the Catechism,
article by article, to what the base holds
([ttc-coverage(7)](docs/coverage.md)). **ttc-l** compiles the rule base
from its L sources, checks that the compiled files are current, and
writes the slots as a GBNF grammar. **ttc-mcp** serves all of it to a
language model ([ttc-mcp(8)](docs/mcp.md)). The model reads the texts;
**ttc** computes what follows.

## INSTALLATION

```
pip install -e ".[mcp]"
```

The repository is on Radicle, peer to peer:
`rad clone rad:z9REkMbmisawZ51TYM8PxU9FK3jZ`. To browse it:
<https://radicle.network/nodes/iris.radicle.network/rad:z9REkMbmisawZ51TYM8PxU9FK3jZ>.
See [ttc-archive(7)](docs/archive.md).

Requires Python 3.10 or later, and clingo, which is installed
automatically.

## ENVIRONMENT

| Variable | Meaning |
| --- | --- |
| `TTC_HOME` | Personal layer: rules, cases, tests, runtimes. Default `~/.ttc` if it exists; empty disables it. |
| `TTC_LOCATION` | `lat,lon` for distance to libraries. Never sent anywhere. |
| `TTC_HELD_IN` | Narrows holdings to a country (`US`) or state (`US-NY`). |
| `OCLC_CLIENT_ID`, `OCLC_CLIENT_SECRET` | WorldCat Search API credentials. Without them, links only. |
| `TTC_MCP_TOKENS` | Token hashes for `ttc-mcp --http`. Default `~/.config/ttc-mcp/tokens`. |
| `TTC_MCP_URL` | Public address of the server, printed before each new token's path. |
| `TTC_SLOW`, `TTC_SLOW_MODERNITY` | Run the slow tests: the schools' boots and pairs; the modernities' boots too. |

## FILES

The sources are `src/theological_type_checker/l/*.l`; each compiles to the
rule file of the same name in `lp/`, which the solver reads.

| Layer | Sources |
| --- | --- |
| kernel, and the deposit's rules | `kernel_core.l`, `kernel_analogy.l`, `kernel_world.l` |
| schools: runtimes, readings, loci | `schools.l`, `icon_metaphysics.l` |
| the *Grammar of the Icon* | `icon_theory.l`, `icon_models.l`, `icon_tests.l` |
| authority: tiers, branches; the cases | `icon_authority.l`, `icon_history.l` |
| libraries | `act.l`, `law.l`, `moral.l`, `grace.l`, `christ.l`, `sacrament.l`, `faith.l`, `saeculum.l`, `sources.l`, `liturgy.l`, `novissima.l`, `empirica.l`, `linguae.l`, `causae.l`, `substitutio.l`, `pendet.l`, `intellectus.l`, `rerum.l`, `verbum.l` |
| canon | `canon_law.l` (Latin), `canon_cceo.l` (Eastern), `canon_cases.l` |
| the ordered pair, the frontier | `pair.l` |
| works and fetch lists | `library.l` |

| Path | Contents |
| --- | --- |
| `~/.ttc/rules/*.lp` | Personal rules and cases. |
| `~/.ttc/runtimes/*.l`, `~/.ttc/runtimes.json` | Personal runtimes, in L, and their compiled table. |
| `~/.ttc/scenarios.json` | Personal regression tests. |
| `~/.config/ttc-mcp/tokens` | One line per remote client: name, hash of its token. |

## EXAMPLES

```
ttc-check sspx lattice
ttc-say --parts sspx,lattice --brief
ttc-library ic --near 41.90,12.45
claude mcp add --env TTC_HOME="$HOME/.ttc" --transport stdio --scope user \
    theological-type-checker -- "$(pwd)/.venv/bin/ttc-mcp"
```

## EXIT STATUS

**ttc-suite** exits 1 if any scenario fails. A failing scenario is a
finding, not an inconvenience.

**ttc-l check** exits 1 if a rule file differs from its source.
**ttc-l** exits 2 when it refuses a source, naming the file and line.

## SEE ALSO

[Being, Relation, and Gift](docs/theology-of-the-core.md) (the theology, in the discipline's language),
[ttc(7)](docs/guide-for-theologians-and-canonists.md),
[ttc-findings(7)](docs/findings.md), [ttc-core(5)](docs/core-edition.md),
[ttc-layers(7)](docs/layers.md), [ttc-schools(7)](docs/research/schools-preregistration.md),
[ttc-canon(5)](docs/canon-law-layer.md), [ttc-encoding(5)](docs/encoding-guide.md),
[ttc-flywheel(7)](docs/flywheel.md), [ttc-roadmap(7)](docs/roadmap.md),
[cases](docs/cases/), [research report](docs/research/warrants-and-prior-art.md),
[intro(7)](docs/README.md) (every page).

## STANDARDS

Lateran IV (DH 806). Codex Iuris Canonici (1983; Book VI as revised 2021).
Codex Canonum Ecclesiarum Orientalium (1990). *Lumen gentium* 25. *Dei
Verbum* 10.

## HISTORY

Written in 2026 to test one paper, *The Grammar of the Icon*. Most of what
it found was wrong with the paper. It then grew a library for each matter
the cases kept needing. See [ttc-findings(7)](docs/findings.md).

## AUTHORS

Ora pro me, peccatore, and contributors. See [CONTRIBUTING](CONTRIBUTING.md).

## BUGS

**ttc** cannot show that a well-formed claim is true. That judgment belongs
to Scripture, Tradition and the magisterium (DV 10), not to software.

Weight is a vote count, and votes are cheap.

The rule base encodes a small fraction of either Code. The rest is the
frontier; see [ttc-flywheel(7)](docs/flywheel.md).

**ttc-suite** takes ten minutes or more.

Everything here is argument from fittingness, submitted to the judgment of
the Church.

## LICENSE

CC0 1.0: code, rules and documentation are dedicated to the public domain.
No permission is needed and no credit is required. See [LICENSE](LICENSE).
Quotations from magisterial documents, the Code of Canon Law and other
sources remain under their own terms, reproduced as brief quotations for
commentary. Where the work lives, and how to keep it: [ttc-archive(7)](docs/archive.md).
