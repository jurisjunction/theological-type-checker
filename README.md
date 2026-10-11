# TTC(1)

## NAME

**ttc** — theological type checker

## SYNOPSIS

```
ttc-suite [--md file] [--show id] [--with part]
ttc-check [part ...] [--facts file] [--branches n] [--list]
ttc-library [part ...] [--near lat,lon | place] [--csv file] [--no-reading]
ttc-mcp
```

## DESCRIPTION

**ttc** checks theological and canonical claims for well-formedness. It
does not check them for truth. It has three layers, used as an ordered pair
(teaching first, law ordered to it):

- **grammar**: a kernel of typed relations, with the deposit's rules.
  Analogy is a sort discipline: nothing crosses the Creator–creature line
  without a declared bridge. Schools run on it as runtimes (Thomist,
  Scotist, Suárezian, Palamite); one theory, the *Grammar of the Icon*,
  runs on them.
- **authority**: sources by tier (c. 750 §1, §2; c. 752; Doctors;
  theologians), form, character and date. Questions branch. Only tier 1
  deletes a branch; lower acts leave shadows.
- **canon**: canons as dated yes/no rules. A canon-law question branches
  only on disputed facts, disputed readings, or the internal forum, which
  **ttc** never computes.

Encoding is interpretation. Checking is mechanical. Do not confuse them.

**ttc-suite** runs 277 scenarios. **ttc-check** runs one case.
**ttc-schools** boots each school alone and in pairs.
**ttc-library** prints a fetch list of physical copies, with the nearest
library first. **ttc-mcp** serves all of it to a language model. The model
reads the texts; **ttc** computes what follows.

## INSTALLATION

```
pip install -e ".[mcp]"
```

The repository is on GitHub
(<https://github.com/jurisjunction/theological-type-checker>) and on
Radicle, peer to peer: `rad clone rad:z9REkMbmisawZ51TYM8PxU9FK3jZ`. See
[ttc-archive(7)](docs/archive.md).

Requires Python 3.10 and clingo, which is installed automatically.

## ENVIRONMENT

| Variable | Meaning |
| --- | --- |
| `TTC_HOME` | Personal layer: rules, cases, tests. Default `~/.ttc` if it exists; empty disables it. |
| `TTC_LOCATION` | `lat,lon` for distance to libraries. Never sent anywhere. |
| `TTC_HELD_IN` | Narrows holdings to a country (`US`) or state (`US-NY`). |
| `OCLC_CLIENT_ID`, `OCLC_CLIENT_SECRET` | WorldCat Search API credentials. Without them, links only. |

## FILES

| Path | Contents |
| --- | --- |
| `src/theological_type_checker/lp/` | The rule base. |
| `~/.ttc/rules/*.lp` | Personal rules and cases. |
| `~/.ttc/scenarios.json` | Personal regression tests. |

## EXAMPLES

```
ttc-check sspx lattice
ttc-library ic --near 41.90,12.45
claude mcp add --env TTC_HOME="$HOME/.ttc" --transport stdio --scope user \
    theological-type-checker -- "$(pwd)/.venv/bin/ttc-mcp"
```

## EXIT STATUS

**ttc-suite** exits 1 if any scenario fails. A failing scenario is a
finding, not an inconvenience.

## SEE ALSO

[Being, Relation, and Gift](docs/theology-of-the-core.md) (the theology, in the discipline's language),
[ttc(7)](docs/guide-for-theologians-and-canonists.md),
[ttc-findings(7)](docs/findings.md), [ttc-core(5)](docs/core-edition.md),
[ttc-layers(7)](docs/layers.md), [ttc-schools(7)](docs/research/schools-preregistration.md),
[ttc-canon(5)](docs/canon-law-layer.md), [ttc-encoding(5)](docs/encoding-guide.md),
[ttc-flywheel(7)](docs/flywheel.md), [ttc-library(1)](docs/library.md),
[ttc-mcp(8)](docs/mcp.md), [cases](docs/cases/),
[research report](docs/research/warrants-and-prior-art.md).

## STANDARDS

Lateran IV (DH 806). Codex Iuris Canonici (1983; Book VI as revised 2021).
*Lumen gentium* 25. *Dei Verbum* 10.

## HISTORY

Written in 2026 to test one paper, *The Grammar of the Icon*. Most of what
it found was wrong with the paper. See [ttc-findings(7)](docs/findings.md).

## AUTHORS

Ora pro me, peccatore, and contributors. See [CONTRIBUTING](CONTRIBUTING.md).

## BUGS

**ttc** cannot show that a well-formed claim is true. That judgment belongs
to Scripture, Tradition and the magisterium (DV 10), not to software.

Weight is a vote count, and votes are cheap.

The rule base encodes a small fraction of the Code. The rest is the
frontier; see [ttc-flywheel(7)](docs/flywheel.md).

Everything here is argument from fittingness, submitted to the judgment of
the Church.

## LICENSE

CC0 1.0: code, rules and documentation are dedicated to the public domain.
No permission is needed and no credit is required. See [LICENSE](LICENSE).
Quotations from magisterial documents, the Code of Canon Law and other
sources remain under their own terms, reproduced as brief quotations for
commentary. Where the work lives, and how to keep it: [ttc-archive(7)](docs/archive.md).
