# TTC(7)

## NAME

**ttc** — type checking for theology and canon law: concepts

## DESCRIPTION

Most errors in theological argument are category mistakes, not false
premises:

- a disciplinary law read as a definition
- "cannot" where the text says "ought not"
- a property every person has, used to rank persons
- evidence about a group offered as a verdict on a person
- a creaturely predicate carried to God without the analogy that would
  license it

The tradition already forbids each of these. **ttc** writes the
prohibitions down where a machine can enforce them.

It shows that a claim is ill-formed. It does not show that a well-formed
claim is true (*Dei Verbum* 10). It never computes anyone's culpability.

## THE TYPE DISCIPLINES

**Predication** (ST III q.16): concrete terms take predicates of either
nature; abstract nature-terms take only their own. "God died": well-typed.
"The divinity died": not. "Christ is a creature": well-typed, needs a
qualifier.

**Analogy** (Lateran IV, DH 806; ST I q.13 aa.5–6): nothing crosses the
Creator–creature line except through a bridge. A bridge is God first (*per
prius*), with a mode on each side. Deny by default.

**Assent** (cc. 750–752; LG 25; *Donum veritatis* 23–24): a text's tier
fixes what it can demand.

**Forum** (cc. 130, 1082): interior facts belong to the internal forum.
They are inputs, never outputs.

## LAYERS

### grammar

| Relation | Reads |
| --- | --- |
| E(g, x) | g gives being to x |
| O(p, x) | principle p originates x |
| D(x, y) | x acts on y |
| N(x, y) | x gives itself to y, face to face |
| S(x, y, t) | x and y are ordered together to t |

There are thirteen axioms, each with a warrant independent of what it
explains. See [ttc-core(5)](core-edition.md). Derived results include
c. 1084 (impotence invalidates, sterility does not), c. 1057 §1 (no human
power supplies consent), the uniqueness of total gift (c. 1056; FC 19), and
*Donum vitae*'s child's right.

### authority

| Tier | Assent | Example |
| --- | --- | --- |
| 1 | divine and Catholic faith (c. 750 §1) | conciliar definitions |
| 2 | firm assent (c. 750 §2) | definitive teaching |
| 3 | religious submission (c. 752) | encyclicals; curial acts |
| 4 | — | Doctors, from the date declared |
| 5 | — | theologians |

The rules:

- Tier 1 deletes contrary branches.
- Tiers 2–3 cleave a contrary branch into a **shadow**, which names the
  acts whose relaxation would restore it.
- Protection stops cleaving at or below its tier.
- Everything else weighs, and weight states a preference, never a
  resolution.
- A papal act is tiered by its form, not its author.
- The force of tier 2 is an assumption until a strictly higher tier fixes
  it.

### canon

Canons are dated rules with no weight: canonists fill gaps (c. 19), never
in penal cases. A canon-law question branches only on disputed facts,
disputed readings without an authentic interpretation (c. 16), or the
internal forum. See [ttc-canon(5)](canon-law-layer.md).

### the ordered pair

The pair is (teaching, law), in that order:

- Law binds to teaching by reference (cc. 750, 752) and never answers a
  doctrinal question. Using law to answer one is a violation.
- A canon may presuppose a theological value: `premise(Norm, Q, V)`.
  Applying the canon where the branch denies V is a violation.
- A theological question may classify a canonical event:
  `classification(Q, Event, Kind)`. In each branch, the law follows that
  branch's classification.

## READING OUTPUT

| Status | Meaning |
| --- | --- |
| settled | in every main branch |
| open | in some main branches |
| shadow | only where something has been cleaved |
| excluded | in no branch |

Read in this order: what is settled, what is open and on what it turns,
what is in shadow and what would restore it, which violations appear and in
which branches. Weight comes last, if at all.

## THE FIX METHOD

When **ttc** disagrees with a text, either **ttc** is wrong or the text is.
To decide:

1. Write the change that would make **ttc** agree with the text.
2. Run every case with that change.
3. A change that gains without loss is a candidate.
4. A change without an independent warrant is a degenerating shift (Lakatos)
   and is refused.

## EXAMPLES

```
ttc-check ic asof_1600             # the Immaculate Conception, as of 1600
ttc-check remarriage typed_doctrinal
ttc-check sspx lattice
ttc-check trinity monopatrism distinction_opposition   # ST I q.36 a.2
```

## SEE ALSO

[Being, Relation, and Gift](theology-of-the-core.md) (this page's matter, written as theology), [ttc(1)](../README.md), [ttc-findings(7)](findings.md), [ttc-core(5)](core-edition.md),
[ttc-encoding(5)](encoding-guide.md), [ttc-flywheel(7)](flywheel.md)

## STANDARDS

- Lateran IV, DH 800, 806
- Lyons II, DH 850
- Florence, DH 1300–1302
- ST I q.13 aa.5–6; I q.36 a.4; III q.16
- *Lumen gentium* 8, 14–16, 25; *Unitatis redintegratio* 3
- *Donum veritatis* 23–24
- CIC cc. 16, 18, 19, 20, 135 §2, 750–752

## CAVEATS

The checker enforces context; it does not discover it. Where a violation
rests on an entered fact (grace is participation, CCC 1997), it is as good
as that fact.

The reservation of orders enters as given (OS 4). Deriving it from the
axioms would put fittingness in place of the ground actually taught.

The framework must not be used to schedule history (the Joachim clause).
No checker can enforce this.

## BUGS

Weight pointed the wrong way on the Immaculate Conception for centuries.
That is why it decides nothing.
