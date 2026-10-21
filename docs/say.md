# TTC-SAY(1)

## NAME

**ttc-say** — the checker's answer as plain text, said through its own templates

## SYNOPSIS

```
ttc-say [case.lp] [--parts p,…] [--brief] [--no-entered]
```

## DESCRIPTION

**ttc-say** runs a case and prints the result as text meant to be pasted
as it is, in a code block. Every sentence is the `say` template of a slot
or a result ([ttc-l(1)](l.md)), its arguments filled from the atom printed
under it. No language model stands between the solver and the reader: the
same facts give the same text, byte for byte.

The sections, in order:

| Section | Holds |
| --- | --- |
| header | The base's commit, the case, the parts; the date the law is read as of (`eval_date/1`); who encoded the facts. |
| `QUESTIONS` | Each question's values: settled, open, shadow, excluded. |
| `IN EVERY BRANCH` | What holds whatever the branch. |
| `DISPUTED` | A tree: for each assumption on a disputed fact or reading, what follows from it, said once. The checker does not decide between them. |
| `BRANCHES` | Each branch: its values, what cleaves it, on which assumptions it stands, and what is its own. |
| `NORMS` | The norm blocks whose rules wrote the results shown, with their citations; results written under no single norm, with their files. Where a rule stands, not a proof that an instance came by it. |
| `FRONTIER` | What is still to encode or read. Nothing there is decided. |
| `ENTERED` | Every fact of the case, said through its slot. |
| `UNSAID` | Predicates printed raw, for want of a template. |

A case file may say three things of itself in comment tags:

```
% @case Title of the case
% @encoded-by who encoded the facts
% @label term | display name
```

A label changes how a constant is shown in a sentence, never the atom
under it.

## OPTIONS

| Option | Does |
| --- | --- |
| `--parts p,…` | Load parts of the base, as `ttc-check` does. |
| `--brief` | Sentences only, without the atoms under them. |
| `--no-entered` | Leave out the facts entered. |

The MCP tool `say` takes the same arguments ([ttc-mcp(1)](mcp.md)).

## EXAMPLES

```
ttc-say --parts option_narrowed
ttc-say case.lp --brief
```

## SEE ALSO

[ttc-l(1)](l.md), [ttc-encoding(5)](encoding-guide.md), [ttc-mcp(1)](mcp.md)

## CAVEATS

The text is mechanical, not neutral. Whoever writes a template or a label
chooses its words, and whoever encodes a case chooses its facts; the header
names the encoder, and the atoms stay beside the words so either can be
checked. A sentence is only as good as its template.

A layout another model proposes is not this program's output unless this
program printed it. Its header names a commit; rerun it there.

## BUGS

Many results have no template yet; they print raw and are listed under
`UNSAID`. The branches shown are those the summary keeps (30 at most).
