# TTC-MCP(8)

## NAME

**ttc-mcp** — the checker as an MCP server

## SYNOPSIS

```
ttc-mcp
ttc-mcp --http [--host addr] [--port n] [--writers]
ttc-mcp --new-token name
```

## DESCRIPTION

**ttc-mcp** serves the checker over stdio, or with `--http` over Streamable
HTTP behind a secret URL. The model reads the texts and records every
interpretive choice as a fact. The server computes the consequences. The
person reads both.

| Option | Does |
| --- | --- |
| `--http` | Serve HTTP at `/<token>/mcp`. Every other path is a 404. |
| `--host`, `--port` | Where to listen. Default `127.0.0.1`, `8765`. |
| `--writers` | With `--http`, also serve the tools that write. Off by default. |
| `--new-token name` | Mint a token for one client, print its URL once, exit. |

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

## REMOTE USE

A hosted client calls from its vendor's servers, not from the person's
machine, so the server must be reachable from the internet. The URL is the
key: add it to the client as a server with no authentication.

```
ttc-mcp --new-token claude
ttc-mcp --http
```

One token per client. The file keeps each token's hash under the client's
name. To revoke a client, delete its line; no restart is needed. The log
names the client on every request and never the URL.

Over HTTP the server offers only the tools that read. Every client shares
one personal layer, so a save by one would change the answers of all; the
`save_*` tools and `mark_consulted` stay on the person's own machine, over
stdio. `--writers` serves them anyway, and says so in the log.

In a container, which can write to one folder only:

```
docker build -t ttc-mcp .
docker run -d --name ttc-mcp --restart unless-stopped \
    -p 127.0.0.1:8765:8765 -v "$HOME/ttc-mcp:/data" \
    -e TTC_MCP_URL=https://box.example.ts.net \
    --read-only --cap-drop ALL --security-opt no-new-privileges ttc-mcp
docker exec ttc-mcp ttc-mcp --new-token claude
```

Published with Tailscale Funnel, which ends TLS and forwards to the port:

```
tailscale funnel --bg 8765
```

The server keeps no session, so a restart loses nothing.

## TOOLS

Each tool declares whether it writes. The `save_*` tools and
`mark_consulted` write; `save_rules` and `save_case` can replace a file;
`library_fetch_list` reaches the network. The rest only read. A client
uses this to decide when to ask the person first.

### Reading

| Tool | Does |
| --- | --- |
| `guide` | The encoding manual, [ttc-encoding(5)](encoding-guide.md). Read it first. |
| `list_parts`, `read_part` | Models, cases, switches, candidates, each with its kind and case (L's; the personal layer's by name); the source of one. |

### Checking

| Tool | Does |
| --- | --- |
| `check` | Run parts plus new facts: statuses, violations, branches, and which of the facts' predicates the base reads (`premises`). |
| `compare` | Two configurations, and only what differs between them. |
| `say` | The result as plain text, said through the base's templates ([ttc-say(1)](say.md)). Give it to the person as it is. |
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
| `flywheel_status` | The theology, unanswered, canon and library frontiers. |

### Prompts

| Prompt | Does |
| --- | --- |
| `type_check_text` | Check a text. |
| `review_rule_change` | Judge a change by the fix method. |

### Resources

| Resource | Holds |
| --- | --- |
| `ttc://guide` | The encoding manual. |
| `ttc://rules/{file}` | One rule file. |
| `ttc://grammar` | What the checker declares about itself, read off L (`grammar_schema` 2): slots with their sorts, sides, meanings, sentences and tags; sorts; the vocabulary; outputs; parts with their kinds and cases; runtimes with their parents and combinators; tools and their arguments; the refusal's fields and gates; the summary's schema. |

## RESULTS

Every tool's result has its keys sorted, on the wire and in process alike;
`engine.dumps` gives the compact form. `check` carries `schema` and
`warnings` ([ttc-encoding(5)](encoding-guide.md), WARNINGS AND REFUSALS).
A refusal is a tool error whose text is one compact JSON object: `gate`,
`where`, `line`, `column`, `predicate`, `text`, `message`.

## ENVIRONMENT

See [ttc(1)](../README.md).

## SECURITY

Snippets are data and rules. `#script`, `#include`, `#program`, `#end` and
`@`-terms are refused. Runs are capped by model count and time. A
snippet's rules can write conclusions (a tier, a theorem) as well as
premises; nothing refuses that yet ([ttc-l(7)](research/l-preregistration.md)).

The server writes only inside `$TTC_HOME`, and only through `save_*` and
`mark_consulted`. Network access is limited to the library lookups, and to
those services only.

Over HTTP the URL is the only credential. Whoever holds it can call every
tool the server offers: by default those that read; with `--writers`,
those that write as well, into the one personal layer every client reads.
It does not expire. The tokens file
(`$TTC_MCP_TOKENS`) holds hashes, mode 600, and belongs outside
`$TTC_HOME`. Keep `$TTC_HOME` under version control on the host: a write
can then be seen and undone.

## EXAMPLES

> Here is a paragraph claiming the 2026 decree excommunicated every SSPX
> priest. Type-check it.

The model reads `guide` and `read_part("sspx")`, encodes the paragraph as a
tier-5 claim, and runs `check`. The answer: no declaration names a priest,
and reading the note as one is `collective_declaration`.

## SEE ALSO

[ttc(1)](../README.md), [ttc-flywheel(7)](flywheel.md), [ttc-library(1)](library.md)

## BUGS

`run_suite`, `fix_method` and `save_rules` run the whole suite, which takes
minutes. A far client may give up first; the run goes on without it.

The server trusts the model to encode honestly. The model trusts the person
to check the encoding. Nobody trusts the weights. `ttc://grammar` is the
checker's word about itself: a claim, never evidence that it is right, and
nothing in the rule base reads it.
