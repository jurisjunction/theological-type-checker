# TTC-FLYWHEEL(7)

## NAME

**ttc-flywheel** — a personal checker that grows with use

## SYNOPSIS

```
git clone https://github.com/jurisjunction/theological-type-checker
cd theological-type-checker
python3 -m venv .venv && .venv/bin/pip install -e ".[mcp]"
mkdir -p ~/.ttc && git -C ~/.ttc init
claude mcp add --env TTC_HOME="$HOME/.ttc" --env TTC_LOCATION="41.90,12.45" \
    --transport stdio --scope user theological-type-checker -- "$(pwd)/.venv/bin/ttc-mcp"
```

## DESCRIPTION

Nobody encodes the whole apparatus first: the Code, authentic
interpretations, jurisprudence, the Fathers, the Doctors, the
commentators. It accumulates one question at a time. **ttc** is built to
accumulate the same way.

Every turn of the wheel works on an ordered pair, (teaching, law). The
theological side comes first, and the canonical side is ordered to it. Both
sides grow.

## THE LOOP

1. **Ask.** Bring a real question.
2. **Encode.** The model writes the theology side (questions, sources,
   readings) and the canon side (events, decrees, acts), linked by
   `classification/3` and `premise/3`. Every interpretive choice becomes a
   fact.
3. **Find the frontier.** `flywheel_status` lists three things:
   - *theology*: sources cited but not encoded, questions without sources,
     ambiguous texts without readings
   - *canon*: predicates no canon defines yet
   - *library*: works to fetch and read
4. **Fill it.** For law, fetch the primary text (see
   [ttc-canon(5)](canon-law-layer.md)), tag it, and call `save_rules`. For
   theology, encode the source with its tier, form, character and date, and
   call `save_case`. Neither is saved if any test turns red.
5. **Read.** `library_fetch_list` gives the books, nearest library first.
   Check each source against the printed text, then record it with
   `mark_consulted`. The list gets shorter.
6. **Keep.** When you agree with a result, `save_scenario`. From then on,
   every change must keep that result or say why not.

The frontier shrinks, the scenarios accumulate, and the fetch list is the
reading you still owe.

## FILES

| File | Contents |
| --- | --- |
| `~/.ttc/rules/*.lp` | your canons and rules |
| `~/.ttc/rules/case_*.lp` | cases, each an ordered pair under its own part |
| `~/.ttc/rules/consulted.lp` | sources checked against the original |
| `~/.ttc/scenarios.json` | results you confirmed |

Keep `~/.ttc` in git, and push it wherever you like. The public base is
unaffected until you contribute.

## TOOLS

| Tool | Does |
| --- | --- |
| `flywheel_status` | Frontiers: theology, canon, library. Optionally the suite. |
| `save_rules` | Save rules if the suite stays green; over a red test only with a stated reason for it. |
| `save_case` | Save an ordered pair, `theology` then `canon`. Mixing the sides is refused. |
| `save_scenario` | Record a result as a test, only if it passes now. |
| `mark_consulted` | Record a source as checked against the original. |
| `library_fetch_list` | Physical copies, nearest library first. |
| `norm_check`, `fix_method` | Gaps in the norm graph; the price of a rule change. |

## WHERE THINGS GO

| Source | Layer | Acts as |
| --- | --- | --- |
| Councils, popes (by form), curial teaching | theology | tiers 1–3; cleaves |
| Doctors, theologians | theology | tiers 4–5; weighs |
| Code, papal and curial legislation | canon | rules |
| Authentic interpretations (c. 16) | canon | `authentic_reading/3` |
| Decrees, rescripts, grants | canon | facts, within competence |
| Rota, Signatura | canon | gap-filling (c. 19), never penal |
| Commentators | theology, tier 5 | names readings; decides none |

## EXAMPLES

Things to say to the model:

> c. 1332 isn't encoded. Fetch it from iuscangreg, encode it, save it if the
> suite stays green.

> What's on the frontier? Pick what unblocks the most.

> Make me a fetch list for the remarriage case. I'm at the Gregorian.

> I checked Scotus in the Vatican edition, vol. IX. Mark it consulted.

> I agree with that result. Save it as a scenario.

## SEE ALSO

[ttc-canon(5)](canon-law-layer.md), [ttc-library(1)](library.md),
[ttc-mcp(8)](mcp.md), [CONTRIBUTING](../CONTRIBUTING.md)

## CAVEATS

A red test is information. Do not change an old expectation to pass a new
rule without saying why.

Never encode anyone's interior. It is an input, and **ttc** has no input
for it except the internal forum's.

## BUGS

The wheel turns only when used. Unread books do not read themselves.
