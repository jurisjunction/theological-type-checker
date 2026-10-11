# CONTRIBUTING(7)

## NAME

**contributing** — how to argue with the checker usefully

## DESCRIPTION

Contributions, most useful first:

1. **A challenge to an encoding.** A source is mis-tiered, mis-dated,
   mis-read or mis-typed. Open an issue with the correct reference (DH, AAS,
   canon, or edition and page) and the reason. If the reading is genuinely
   disputed, say so; it can be a branch.
2. **A case.** A question with dated acts, given as an ordered pair:
   theology first, canon law after. Say what you expect, and why.
3. **A rule change.** Run `fix_method` and report the gains and the
   losses. A change with no independent warrant will not be merged.
4. **Engine work.** A Soufflé port, reports, clients.

## REQUIREMENTS

- **Every source cited precisely**: DH, AAS, canon and paragraph, or
  edition and page.
- **Every rule has a warrant** (in a comment) **and a test that fails
  without it.**
- **Readings, not choices**: an ambiguous text gets `ambiguous` and its
  readings.
- **Canon law is binary.** It goes in the canon layer, never on the
  authority graph.
- **No interior states are computed.** Imputability is an input.
- **No verdicts on persons.** Public acts only.
- **Charity.** Schools the Church tolerates are not to be treated as
  illegitimate.

## FILES

`pytest -q` must pass. `ttc-suite` must be deterministic.

## LICENSE

CC0 1.0. Contributions are dedicated to the public domain on the same
terms. Contribute under a pseudonym if you like; nothing here needs a name.

## BUGS

Disagreement is the material the method runs on. Agreement is merely
pleasant.
