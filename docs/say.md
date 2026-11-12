# TTC-SAY(1)

## NAME

**ttc-say** — the checker's answer as plain text, said through its own templates

## SYNOPSIS

```
ttc-say [case.lp] [--parts p,…] [--brief] [--no-entered]
ttc-say [case.lp] [--parts p,…] [--brief] --why atom … --why-excluded q=v …
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
| `ILL-FORMED` | Only where the result holds a violation: their count, then each, those in some branches marked so. The case does not type-check; the answers below are computed from it all the same. |
| `QUESTIONS` | Each question's values: settled, open, shadow, excluded. |
| `IN EVERY BRANCH` | What holds whatever the branch, the violations aside. |
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
| `--why atom` | Print a proof of the atom instead (PROOFS). Repeatable. |
| `--why-excluded q=v` | Print the constraint that removes the value and the proof of its body. Repeatable. |

The MCP tool `say` takes the same arguments; `why` takes the parts, the
facts, `atoms`, `excluded` and `brief` ([ttc-mcp(1)](mcp.md)).

## PROOFS

The prover (`prove.py`) grounds the program `ttc-check` grounds, with each
rule given a twin that records the rule instance when it fires, and each
integrity constraint on `holds/2` a twin that records the value it would
remove. The twins' atoms are hidden; the models are the same.

A proof is read back from the first model that holds the atom, or in which
a constraint would remove the value. It is well-founded: each atom by a
rule instance whose positive body was proved at a lower level. Each step
gives the atom, said through its template where it has one, and in
brackets where its rule stands: the rule file and line, and the norm
(citation and id) or section it sits under.

| Leaf | Means |
| --- | --- |
| `entered: file:line` | A fact of the base, a part or the case. |
| `not … [nothing derives it]` | A negated literal: no rule derives the atom in this model. |
| `chosen: this branch` | A value a choice rule picked; the branch, not a rule, holds it. |
| `proved above` | Proved earlier in the same proof; not repeated. |
| `in no model` | The atom holds in no model of the run. |

## EXAMPLES

```
ttc-say --parts option_narrowed
ttc-say case.lp --brief
ttc-say --parts ic,asof_1860 --why-excluded 'q(ic)=no'
ttc-say --parts art6_case --why 'info(delict(cl_b,n1398_1,act_b))' --brief
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

A proof explains a model, not why no other model exists, except where an
integrity constraint on `holds/2` removes a value. A negated literal is a
leaf: the proof does not say which rules failed to derive it, so what a
rule reads through a negation (the five conditions of a papal definition,
behind `not ec_unmet`) is not shown in the proof. An aggregate's elements
are not expanded. A proof is one well-founded derivation among those the
model may hold.
