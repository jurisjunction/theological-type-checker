# EXAMPLES(7)

## NAME

**examples** — files to run, and a personal layer

## DESCRIPTION

| File | Run | Shows |
| --- | --- | --- |
| `new_question.lp` | `ttc-check --facts examples/new_question.lp` | `yes` settled, `no` a shadow. Make the encyclical an `interview` and both open. |
| `hypothetical_papal_act.lp` | `ttc-check sspx lattice --facts examples/hypothetical_papal_act.lp` | A HYPOTHETICAL papal revocation of the 2016 grant. `abs_after` comes out invalid and a c. 1379 delict; `abs_2026` (before it) stays valid. Only a papal act does this. |
| `ttc-home/` | `TTC_HOME=examples/ttc-home ttc-check case_juridic foundation_erected` | A personal layer: cc. 114, 116 §2, 117, 1257 §2, 285 §4 and 286. A trading company cannot be a juridic person (c. 114 §1); a pious foundation can, once judged, approved and decreed. A cleric on the company's board needs his Ordinary's permission (c. 285 §4) on every reading; c. 286 reaches him there only on the wider reading, which c. 18 declines. Add `company_decreed` for the violation. |

## BUGS

Two examples and a layer. The suite has 232 more.

`ttc-home/` was encoded before any predictions, so it is exploratory and
not for the base as it stands (rule 12). Its norms have no tests in the
suite (rule 5). Its readings of cc. 285 §4 and 286, and its typing of both
as restricting rights (c. 18), are the encoder's.
