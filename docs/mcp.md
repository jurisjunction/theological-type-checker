# TTC-MCP(8)

## NAME

**ttc-mcp** — the checker as an MCP server

## SYNOPSIS

```
ttc-mcp
```

## DESCRIPTION

**ttc-mcp** serves the checker over stdio. The model reads the texts and
records every interpretive choice as a fact. The server computes the
consequences. The person reads both.

## INSTALLATION

**Claude Code**, for all projects:

```
claude mcp add --env TTC_HOME="$HOME/.ttc" --transport stdio --scope user \
    theological-type-checker -- "$(pwd)/.venv/bin/ttc-mcp"
```

Inside the repository, `.mcp.json` registers it for the project.

**Any client** that reads an `mcpServers` block:

```json
{ "mcpServers": { "theological-type-checker": { "command": "ttc-mcp", "args": [] } } }
```

## TOOLS

### Reading

| Tool | Does |
| --- | --- |
| `guide` | The encoding manual, [ttc-encoding(5)](encoding-guide.md). Read it first. |
| `list_parts`, `read_part` | Models, cases, switches, candidates; the source of one. |

### Checking

| Tool | Does |
| --- | --- |
| `check` | Run parts plus new facts: statuses, violations, branches. |
| `compare` | Two configurations, and only what differs between them. |
| `run_suite` | The regression suite. |
| `read_test` | One test: its parts, its checks' source. Open every test a change turns red. |
| `lint` | Rules that cross the Creator–creature line without a bridge. |
| `norm_graph`, `norm_check` | The canon graph; its loops and gaps. |

### Changing

| Tool | Does |
| --- | --- |
| `fix_method` | Add or remove rules, rerun everything, report gains and losses. Writes nothing. |
| `save_rules`, `save_case`, `save_scenario` | Write to `$TTC_HOME`, and only if the suite stays green. `save_rules` with `force` needs a stated reason for each red test. |
| `mark_consulted` | Record a source as checked against print. |

### Library and status

| Tool | Does |
| --- | --- |
| `library_fetch_list` | Physical copies, nearest library first. |
| `flywheel_status` | The theology, canon and library frontiers. |

### Prompts

| Prompt | Does |
| --- | --- |
| `type_check_text` | Check a text. |
| `review_rule_change` | Judge a change by the fix method. |

## ENVIRONMENT

See [ttc(1)](../README.md).

## SECURITY

Snippets are data and rules. `#script`, `#include`, `#program`, `#end` and
`@`-terms are refused. Runs are capped by model count and time.

The server writes only inside `$TTC_HOME`, and only through `save_*` and
`mark_consulted`. Network access is limited to the library lookups, and to
those services only.

## EXAMPLES

> Here is a paragraph claiming the 2026 decree excommunicated every SSPX
> priest. Type-check it.

The model reads `guide` and `read_part("sspx")`, encodes the paragraph as a
tier-5 claim, and runs `check`. The answer: no declaration names a priest,
and reading the note as one is `collective_declaration`.

## SEE ALSO

[ttc(1)](../README.md), [ttc-flywheel(7)](flywheel.md), [ttc-library(1)](library.md)

## BUGS

The server trusts the model to encode honestly. The model trusts the person
to check the encoding. Nobody trusts the weights.
