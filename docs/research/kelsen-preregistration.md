# TTC-KELSEN(7)

## NAME

**ttc-kelsen** — Kelsen's horizon as a node of the modernities, and the fork Benedict XVI drew
from it: predictions, committed before encoding

## DESCRIPTION

Benedict XVI, at the Bundestag (22 September 2011), reports that Kelsen held "norms can only come
from the will". On that view nature could contain norms only if a will had placed them there, which
would imply a Creator; Kelsen judged the question futile [V: bundestag.de]. That is the fork of
TTC-ART6X: law that constitutes the act's character because a will commands it, against law that
measures an act already specified. The DAG has no node for it.

Add three nodes to `schools.l`:

- **`kelsen`** extends `kant`. The Pure Theory (1934) keeps the neo-Kantian method and drops the
  moral law's form: the basic norm is a presupposition of legal cognition, not the form of the will's
  maxim [M]. Excluding `form_of_law` is contested and marked so. The legal order is a coercive order
  that motivates by its sanction [M], so `ends_desired` is kept. Imputation (*Zurechnung*) is the
  norm's connection of condition and sanction, the counterpart of causality [M].
- **`kelsen_1965`** extends `kelsen`: norms only from an act of will, as Benedict reports it. In the
  checker's typing the will's act is an efficient cause, held everywhere, so the horizon is
  `kelsen`'s. The node records the claim and gives the reading below a parent.
- **`kelsen_1965_creator`** extends `kelsen_1965`, a reading against its author: the conditional
  taken up by one who holds there is a Creator, so that norms in nature are placed by a divine will.
  `add ends_by_god_ethics`. This is Ockham's position by another road.

## PREDICTIONS

- **K1.** The DAG builds, with no clash at any of the three (one parent each). `runtimes.json` gains
  three entries, and no existing entry changes.
- **K2.** Horizons: `kelsen` and `kelsen_1965` hold only `ends_desired` among the ten cause parts;
  `kelsen_1965_creator` adds `ends_by_god_ethics`.
- **K3.** TTC-MODERNITY's phases (property case): `kelsen` and `kelsen_1965` fall in the Hobbesian
  phase with `kant`, and give on the case what `kant` gives (neither form moves a report, PR8).
  `kelsen_1965_creator` falls in the Lockean phase.
- **K4.** TTC-ART6X (adapter and versari fix, local): all three have the rule act theory, and art. 6
  is imposed by rule.
- **K5.** With AP4 typed as the soul's good (`final,god_ethics`): `kelsen` and `kelsen_1965` stay
  coherent; `kelsen_1965_creator` turns incoherent.
- **K6.** With TTC-ART6T's teaching side: `law_without_premise(art6_by_rule,…)` on all three.
- **K7.** Tests that enumerate every runtime may turn red by enumeration alone. Each is opened before
  it is judged; no expectation about an existing runtime changes.

## CAVEATS

Kelsen's own texts are cited here from memory [M]: *Reine Rechtslehre* (1934), and the late writings
on the will theory of norms. The 1965 claim is entered as Benedict reports it [V]; whether Kelsen
"abandoned" the dualism of is and ought is itself disputed. Excluding `form_of_law` is the encoding's
reading of the neo-Kantian basic norm. A reader who takes the basic norm as a form of reason would
keep it, and then the adapter gives Kelsen imputation by desert, which is surely wrong for him. That is
a sign the adapter's AP2 needs splitting: the moral law's form, and the legal order's.

## SEE ALSO

[ttc-modernity(7)](modernity-preregistration.md), [ttc-act(7)](act-preregistration.md)
