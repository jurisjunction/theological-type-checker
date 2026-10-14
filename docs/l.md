# TTC-L(1)

## NAME

**ttc-l** — compile the rule base from its L sources, or check it

## SYNOPSIS

```
ttc-l build [--l dir] [--lp dir]
ttc-l check [--l dir] [--lp dir]
```

## DESCRIPTION

The rule base is written in L: one `.l` file per rule file, in
`src/theological_type_checker/l/`. An `.l` file is a sequence of
declarations and fenced clingo. **ttc-l build** compiles each to its rule
file in `lp/`; the rule files stay checked in, and are what the solver
reads and what every stamp points at. **ttc-l check** compiles them and
compares: any byte of difference, or a rule file with no source, fails.

Rules stay clingo, in fences, copied byte for byte; L declares what the
rules are about. A fence is never read, except that a `part` must stand
before a fence opening with `#program`, and the part's name is read from
that line.

Edit the `.l` file, then build. Never edit a rule file by hand.

## DECLARATIONS

| Declaration | Compiles to | Says |
| --- | --- | --- |
| `layer kernel\|theory\|schools\|authority\|libraries\|canon\|pair\|library` | nothing | The file's layer, first line of every source. |
| `library` | `%  @library  (…)` | norms.py counts the file's predicates as defined. |
| `slot name/n` + `means "…"` | `% @input name/n \| …` | A predicate the base reads and never derives, declared in the lowest layer that reads it. |
| `use name/n "…"` | `% @input name/n \| …` | Read here; declared or derived elsewhere. |
| `norm id \| citation \| url` | `% @norm id \| citation \| url` | A canon, with its source (house rule 4). |
| `end`, `temporal id`, `recursive id`, `stratum id divine\|supreme\|common` | `% @end`, `% @temporal id`, … | As norms.py reads them. |
| `part model\|case\|switch\|candidate\|date\|search [of case]` | nothing | The kind of the `#program` block below, and its case. |
| ```` ```clingo ```` … ```` ``` ```` | its lines | Raw clingo. |

Attributes are indented two spaces under their declaration. Strings are
quoted, with JSON's escapes. Lines beginning `--` are comments of L's and
are not compiled.

## EXIT STATUS

0 when the base is as its sources compile; 1 when a rule file differs or
has no source; 2 when a source is refused (the file, the line and why).

## EXAMPLES

````
layer libraries

library

slot finding/4
  means "finding(F, Q, V, Year): a finding of the sciences on a question, by its year"
use in_force/1 "icon_authority.lp"

part case
```clingo
#program galileo.
question(q(earth_moves)). question_kind(q(earth_moves),empirical).
```
````

## FILES

`src/theological_type_checker/l/*.l`
: the sources.

`src/theological_type_checker/lp/*.lp`
: the compiled rule base.

`tools/lp2l`
: the converter that wrote the first sources from the hand-written base
  (TTC-L, METHOD 1); kept for the record.

## SEE ALSO

[ttc-l(7)](research/l-preregistration.md), [ttc(1)](../README.md),
[ttc-encoding(5)](encoding-guide.md)

## CAVEATS

**ttc-l check** guards against hand edits. It is not evidence that the
base is right: the evidence is the suite's expectations, written by hand,
and the stamp. Byte identity tests the compiler, not the theology.

## BUGS

Most of the base is still raw clingo in fences. A tag's text is kept as
it was written, and often repeats the arguments.
