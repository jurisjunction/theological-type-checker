# TTC-L(1)

## NAME

**ttc-l** — compile the rule base from its L sources, or check it

## SYNOPSIS

```
ttc-l build [--l dir] [--lp dir]
ttc-l check [--l dir] [--lp dir]
ttc-l gbnf [--side theology|canon] [--slot name/n ...]
```

## DESCRIPTION

The rule base is written in L: one `.l` file per rule file, in
`src/theological_type_checker/l/`. An `.l` file is a sequence of
declarations and fenced clingo. **ttc-l build** compiles each to its rule
file in `lp/`; the rule files stay checked in, and are what the solver
reads and what every stamp points at. **ttc-l check** compiles them and
compares: any byte of difference, or a rule file with no source, fails.

Rules stay clingo, in fences, copied byte for byte; L declares what the
rules are about. A fence is read only to check that a `part` stands before
a fence opening with `#program` (the part's name is read from that line),
and, through clingo's own parser, to check the slots against the rules.

Edit the `.l` file, then build. Never edit a rule file by hand.

**ttc-l gbnf** writes the slots and sorts as a GBNF grammar, for an
encoder held to it in constrained decoding (llama.cpp; xgrammar and
outlines read the same form). `root` is any number of facts; each fact is
a slot, each argument of its sort: a closed sort's values, a range's
numbers, a `date` of eight digits, a `year` or `number` an integer, a
`string` quoted, any other open sort a term. No result, output or rule can
be written in it. `--side` keeps the slots a case of that side enters;
`--slot` keeps the named slots, so a question about one slot is answered
in it alone.

## DECLARATIONS

| Declaration | Compiles to | Says |
| --- | --- | --- |
| `layer kernel\|theory\|schools\|authority\|libraries\|canon\|pair\|library` | nothing | The file's layer, first line of every source. |
| `library` | `%  @library  (…)` | norms.py counts the file's predicates as defined. |
| `sort name`, `sort name {a, b, …}`, `sort name lo..hi` + `means "…"` | the domains section | A sort of slot argument: open (named, not enforced) or closed, by values or a range. Declared once, in the lowest layer whose slots use it. |
| `slot name(A: sort, …)` (`name/0` with no arguments) + `means "…"` + `say "…"` [+ `hypothetical "…"`] | `% @input name/n \| …` | A predicate a case enters: one the base reads and no rule derives, or one the guide gives to enter though a rule derives it (`source/4`, `interior/3`). Declared once, in the lowest layer that reads it; absolutions and consecrations in the canon layer, which a library reads. |
| `use name/n "…"` | `% @input name/n \| …` | Read here; declared or derived elsewhere. |
| `result name(A: sort, …)` + `say "…"` | nothing | A predicate the base computes, as a result shows it: a derived predicate, or the term an `info`, `violation` or `frontier` atom carries. Its `say` is what ttc-say(1) prints above the atom. |
| `label term "…"` | nothing | A display name for a constant of the base (`label c135_2 "c. 135 §2"`), used when an atom is said. |
| `norm id \| citation \| url` | `% @norm id \| citation \| url` | A canon, with its source (house rule 4). |
| `end`, `temporal id`, `recursive id`, `stratum id divine\|supreme\|common` | `% @end`, `% @temporal id`, … | As norms.py reads them. |
| `part model\|case\|switch\|candidate\|date\|search [of case]` | nothing | The kind of the `#program` block below, and its case. A case states its questions (`question/1`), or is the canon half of one, by its name; a switch is loaded with a case or a model to change it. A switch or candidate names the case whose matter it changes or tests with `of`; one of a model, a school or the creed names none. |
| `runtime name [extends parent, ...]` + `add p, ...`, `exclude p, ...`, `alter p -> q`, `express a [at l, ...]`, `carry a [at l, ...]` | `runtimes.json` | A school's parts, loaded whole, by inheritance. |
| `locus name` + `allele a = p, ...` | `runtimes.json` | A question the schools read differently, and its alleles: each a set of parts that travel together (LOCI). |
| ```` ```clingo ```` … ```` ``` ```` | its lines | Raw clingo. |

Attributes are indented two spaces under their declaration. Strings are
quoted, with JSON's escapes.

A runtime is a set of parts, kept in the order of first mention. `add`
appends, `exclude` removes, `alter p -> q` puts `q` where `p` was; a
runtime records what it excludes and inherits the record. Two parents
**clash** on a part one has and the other excludes; the child must then
say `add`, `exclude` or `alter` for it, or it does not compile. No order
between parents decides. A part a runtime names must exist. A runtime
inherits at a locus as LOCI says.

A slot's side, for a case, is its layer's: theology (kernel, theory,
schools, authority), canon (canon, pair), either (libraries, library).
`save_case` refuses a slot of the other side. A slot declared twice, a
slot no rule reads, and a `use` of a predicate no file declares or
derives do not compile.

Every argument of a slot has a sort. A closed sort compiles to
`in_sort/2` facts in its file, and each slot argument of it to one rule
in the slot's file, at its end, under `% ---------- domains (L)` (and
`#program base.` where the file has parts):

```
violation(outside_domain(source,3,F)) :- source(_,_,F,_), not in_sort(force,F).
```

Nothing else reads `in_sort/2`, and no rule reads `outside_domain`. An
argument of no sort, a sort no slot uses, a sort declared twice, or one
declared above a slot that uses it does not compile.

A slot's `say` is its sentence, each argument named once in braces
(`"{S} is a source at tier {T}, of force {F}, from {Y}"`). A `say` naming
an argument twice, never, or one the slot lacks, and an `of` naming no
case, do not compile. `say` and `of` reach no rule file.

A result is typed and said as a slot is, under the same rule. A result no
rule computes, one also declared a slot (a slot is entered, a result
computed), one declared twice, and a term labelled twice do not compile.
Results and labels reach no rule file.

A snippet, or a case saved with `save_case`, writes premises: the slots,
helpers of its own, and constraints that read only those and `read_as/2`.
A head on what the base derives or shows and no slot declares, or a
constraint that reads it, directly or through a helper, is refused at the
gate `conclusion`, naming the predicate and the slots it is drawn from.
`check` reports which of a snippet's predicates the base reads
(`premises`). A slot declared `hypothetical` is
written only in a part whose `#program` line is marked HYPOTHETICAL (house
rule 6), never in a snippet; another part writing it does not compile.
`fix_method` and `save_rules` are not gated: they change the theory, and
answer to the suite.

Lines beginning `--` are comments of L's and are not compiled.

## LOCI

A locus is declared with its alleles; an allele's parts travel together.
A runtime **expresses** an allele when it holds all its parts. At each
locus a runtime expresses one allele or none, and **carries** the others
it inherits:

- Parents expressing one allele: the child expresses it.
- Parents expressing two or more: the child carries them all and
  expresses none, and their parts are not loaded.
- An allele the child adds whole itself, it expresses.
- `express a` expresses an allele the child inherits, expressed or
  carried, and carries the rest; one that every parent only carries is
  reported (`re_expressed`, printed by **ttc-l build**).
- `carry a` silences the allele the child would express: its parts are
  not loaded, and it passes on as carried.
- Carried alleles are inherited as carried.

`at l, ...` names the loci; it may be left out where one locus has an
allele of that name. `runtimes.json` records the alleles (`alleles`),
per runtime and locus the allele expressed and those carried (`loci`),
and `re_expressed`. Two runtimes named in one run (a pair) are no child:
the engine loads both whole.

Refused: a locus declared twice or with no allele; an allele given twice,
or naming what is not a part; a part at two loci, or in two alleles of
one; a runtime holding part of an allele and not the rest, or adding two
alleles at one locus; an `express` of an allele it does not inherit, or
beside an allele it adds; a `carry` of an allele it would not express;
`express` and `carry` at one locus; an allele or locus that does not
exist, and an allele named at two loci without `at`.

## EXIT STATUS

0 when the base is as its sources compile; 1 when a rule file or
`runtimes.json` differs, or a rule file has no source; 2 when a source is
refused (the file, the line and why).

## EXAMPLES

````
layer libraries

library

sort finding
  means "a finding of the sciences"

slot finding(F: finding, Q: question, V: value, Year: year)
  means "finding(F, Q, V, Year): a finding of the sciences on a question, by its year"
  say "from {Year}, the finding {F} holds {V} on {Q}"
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

`src/theological_type_checker/runtimes.json`
: the compiled runtimes, read by the engine.

`tools/lp2l`
: the converter that wrote the first sources from the hand-written base
  (TTC-L, METHOD 1); kept for the record.

## SEE ALSO

[ttc-l(7)](research/l-preregistration.md), [ttc(1)](../README.md),
[ttc-encoding(5)](encoding-guide.md), [ttc-loci(7)](research/loci-preregistration.md)

## CAVEATS

**ttc-l check** guards against hand edits. It is not evidence that the
base is right: the evidence is the suite's expectations, written by hand,
and the stamp. Byte identity tests the compiler, not the theology.

The grammar guarantees form, not fidelity. An open sort admits any term,
and a well-typed fact can be the wrong fact; that is for the tests with
answers people gave.

A locus is bookkeeping of inheritance, and only that: the genetic words
name no fitness and no selection. A runtime that carries two alleles holds
none of the schools' readings, which is not to hold the deposit's against
them.

## BUGS

The GBNF is tested against a small recognizer of its own subset, not yet
against llama.cpp's parser.

Two loci are declared, simplicity and esse. Ockham's and Hobbes's own
readings of the attributes (as terms, as honours) are no alleles yet.

Most of the base is still raw clingo in fences. A tag's text is kept as
it was written, and often repeats the arguments.

22 parts of `canon_cases.l` enter slots of the theology side: eight
hypothetical cases with their own questions, four candidates, and ten
parts on Christ, grace and presence filed with the canon cases (house
rule 1). A test lists them; they are to be split.

`of_kind/2` is the pair's conclusion, and two parts write it as a fact;
a snippet cannot. It is to be split.
