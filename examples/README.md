# Examples

- `new_question.lp`: the minimal case from the encoding guide. Run
  `ttc-check --facts examples/new_question.lp`; "yes" is settled and "no" is a
  live shadow of the encyclical. Change the encyclical's character to
  `interview` and both become open.
- `hypothetical_papal_act.lp`: a *hypothetical* papal act, not a real one, on
  the SSPX faculty question. Run `ttc-check sspx lattice --facts
  examples/hypothetical_papal_act.lp`. The question, open on the real sources,
  closes: "none" is settled and "granted" becomes a shadow. This is what "only a
  papal act settles it" means.
