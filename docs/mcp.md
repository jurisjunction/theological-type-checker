# Using the checker from a language model (MCP)

The checker is deterministic. Turning a text into facts is not: it takes
reading, judgment and a knowledge of the sources. That division of labour is
why the checker ships as an [MCP](https://modelcontextprotocol.io) server. A
capable model does the interpretation and records every choice as a fact. The
checker computes what follows. The person reads both.

## Install

```bash
git clone https://github.com/jurisjunction/theological-type-checker
cd theological-type-checker
pip install -e ".[mcp]"
ttc-suite            # optional: run the 139-test regression suite
```

## Register the server

**Claude Code.** The repository includes a project-scoped `.mcp.json`, so
opening the repo in Claude Code offers the server automatically. To add it
for all your projects instead:

```bash
claude mcp add --transport stdio --scope user theological-type-checker -- ttc-mcp
```

**Other MCP clients** that read an `mcpServers` JSON block:

```json
{
  "mcpServers": {
    "theological-type-checker": { "command": "ttc-mcp", "args": [] }
  }
}
```

If `ttc-mcp` is not on the client's `PATH`, use the absolute path that
`which ttc-mcp` prints, or `"command": "python", "args": ["-m", "theological_type_checker.server"]`.

## Tools

| Tool | What it does |
| --- | --- |
| `guide` | The encoding manual. A model should read it before writing facts. |
| `list_parts` | The models, cases, switches, dates and candidate rules available. |
| `read_part` | The source of one part or rule file, to model a new case on an old one. |
| `check` | Run parts plus new facts. Returns each question's status, violations and notes, and the branches. |
| `compare` | Two configurations side by side: what one reading, date, typing or source changes. |
| `run_suite` | The regression suite, or a subset. |
| `fix_method` | Add or remove rules, rerun every test, and report what the change gains and loses. Nothing is written to disk. |
| `lint` | The static analogy check: rules that cross the Creator–creature line without a bridge. |

There are also two prompts. `type_check_text` walks a model through
checking a text. `review_rule_change` evaluates a proposed change to the
theory with the fix method.

## A session, in outline

> **You:** Here is a paragraph from a recent article arguing that the 2026
> decree excommunicated every SSPX priest. Type-check it.
>
> **Model:** reads `guide`, then `read_part("sspx")`. It encodes the article as
> a tier-5 source supporting a new juridical question about whether the priests
> are declared. Then it calls `check(["sspx","lattice"], facts=…)`.
>
> **Checker:** no declaration names a priest. Reading the note as declaring
> the clergy excommunicated is a `collective_declaration` violation. The
> note's "invalid confessions" goes through only on the conditioned reading of
> *Misericordia et misera* 12.
>
> **Model:** reports this, states each encoding choice it made, and notes
> that the question would close if a papal act fixed the reading.

## Safety

Snippets are data and rules only. `#script`, `#include`, `#program`,
`#end` and `@`-terms are rejected, so a snippet cannot run code or read
files. Runs have a model cap and a time limit. The server never writes to
the rule base: `fix_method` works on an in-memory copy.

## Command line, without a model

```bash
ttc-check --list                         # every part
ttc-check sspx lattice                   # a case, as JSON
ttc-check --facts my_case.lp             # your own facts
```
