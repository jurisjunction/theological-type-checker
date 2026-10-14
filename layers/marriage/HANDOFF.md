# HANDOFF — Coverage, the marriage layer, and the Reader

Written 2026-10-14 for the agent taking this over. Read all of it before touching anything. The person's name does not appear in commits or files of the checker (its rule 13: anonymous, CC0, commits say *Ora pro me, peccatore*). Nothing in either repo was committed or pushed; everything below is in working trees.

## 1. What this is

Two repos on the person's laptop (`pop-os`, Linux):

| Repo | Path | Remote | What |
| --- | --- | --- | --- |
| Theological type checker (TTC) | `~/src/theological-type-checker/` | Radicle (GitHub is the hub; `tools/sync` pushes to Radicle) | A clingo/ASP checker for theological and canonical claims, exposed as an MCP server (`ttc-mcp`). Read its `CLAUDE.md` first: 14 rules, all binding. Edit `.l`, build `.lp`; personal work goes to `$TTC_HOME` (`~/.ttc`) via `save_rules`/`save_case`/`save_scenario`, never to the public base unless asked. |
| lextribunalis (tribunal software) | `~/projects/tribunal-software-project/` | GitHub | Next.js 16 / Prisma 6 / SQLite case management for diocesan marriage tribunals. Every mutation goes through `src/lib/services` with actor, authorization and an audit row in one transaction. Existing "AI Assistance" extracts dated facts from depositions tied to quotations and grounds (`src/lib/ai/`, `/api/ai/extract`), each proposal accepted one at a time. |

The feature built this session is **Coverage**: for a case, every formulated ground of nullity against every deponent, the claims accepted from the acts under each, and what the law makes of those claims — computed by the checker, rendered by templates. Coverage, not conclusions. A ground formulated with nothing under it is *bare*. See `tribunal-software-project/docs/coverage.md` for the design in full; `claude/coverage-method.md` in the claude.ai project states the method topic-free.

**Naming rule from the person: do not call anything "AI" in the product.** The sheet is Coverage; the tagging model is the Reader (an index to the acts); the rule system is the Checker. Leave the existing "AI Assistance" switch alone unless told to rename it.

## 2. What exists, by file

### Checker: `layers/marriage/` (uncommitted; a stale first draft in `layers/marriage_consent/` has a MOVED.md — delete that directory)

| File | Holds |
| --- | --- |
| `marriage_consent.lp` | cc. 1095–1103 and CCEO 818–826 reading supplied `interior/3` claims → `consent_vitiated_by(M,G)` → the base's bond (c. 1057). Cross-code `same_ground/2`. Output `info(ground(M,G,engaged\|not_engaged))`, `info(ground(M,G,engaged_by(N)))`. Latin canons bind Latin faithful only (c. 1); Eastern canons the Eastern, from 1 Oct 1991. c. 1098 before 1983 branches on a disputed reading (`declarative_of_natural_law` / `merely_positive`), neither preferred. Divergence: c. 1102 §2 vs CCEO 826. |
| `marriage_impediments.lp` | cc. 1083–1094, CCEO 800–812, c. 1078. Kinship by Roman reckoning from `father/mother/adopted`; affinity only from a valid marriage dated before the one at issue. Each → `defect_of_marriage(M,impediment(K))`; dispensation through the base's c. 85 and `law_kind`. Impotence typed natural, prior bond divine positive (the canons' own words); c. 1078 §3 "never given" encoded as a rule about dispensing (violation, relaxes nothing), **not** as divine law — that question is left open on the theology side (Thomas Suppl. q. 54 a. 3, two readings). Reserved impediments (orders, pontifical vow, crime): an incompetent dispensation is a violation and the impediment stands. Divergences: CCEO 809 (affinity, 2nd collateral), CCEO 811 (spiritual relationship). |
| `marriage_form.lp` | Adds Eastern non-Catholic Churches the base lacks (Church of the East; named Orthodox/Oriental Orthodox churches), c. 1116 / CCEO 832 extraordinary form, liceity (c. 1124 / CCEO 813 permission; c. 1127 §1 form for liceity only → `valid_form_but_illicit`), `lack_of_form` as a ground. |
| `marriage_*_cases.lp` | HYPOTHETICAL invented cases exercising every rule. |
| `marriage_scenarios.json`, `make_scenarios.py` | 47 scenarios in `save_scenario` shape; 44 red without the layers and green with; 3 guards. `python3 make_scenarios.py` rebuilds and verifies (run from a checkout with the package installed). |
| `README.md` | Man-page style. **Read CAVEATS.** |

Verified: `fix_method` over the base's 563 tests with all three layers added → `no loss`. **Frame must load `sacrament_conditions`** or a dispensed form reads as lack of form. Not done before saving (the person's rules): stamp the scenarios as predictions (rule 12); check every quoted canon text against iuscangreg/vatican.va (rule 4) — I wrote them from memory. Known gaps: c. 1091 §4 (doubt of consanguinity) not encoded; CCEO 810 §1 possible third source not entered; theology-side sources for why impotence/prior bond are divine law owed; a reported papal dispensation of siblings raised in review, unverified, not entered.

### App: tribunal-software-project (uncommitted)

| File | Holds |
| --- | --- |
| `src/lib/domain/claims.ts` | The closed menu: 17 claims over the 11 consent grounds, each with the checker term, subject, slot; `GROUND_NORM` mapping app ground keys → layer norm ids (consent, impediments, `lack_of_form`). The contract between notary, Checker and Reader. |
| `src/lib/coverage/facts.ts` | `lockClaims` (the lock step), `buildFacts` (the clingo snippet), `readGrounds` (standing per ground incl. `engagedBy`). |
| `src/lib/coverage/checker.ts` | MCP Streamable HTTP client, hand-rolled (initialize → initialized → tools/call `check`). Env: `TTC_MCP_URL`, `TTC_PARTS` (default `sacrament_conditions`), `TTC_TIMEOUT_MS`. |
| `src/lib/coverage/render.ts` | Templates only; passive voice; `headline`, `standingSentence`, `claimSentence`. |
| `src/lib/coverage/load.ts` | Loads marriage, parties, witnesses, accepted events with `claim`/`claimSlot`. |
| `src/app/cases/[id]/coverage/page.tsx` | The sheet. Uses `getCase` for visibility. |
| `prisma/schema.prisma` | `EventGround.claim String?`, `EventGround.claimSlot String?` — applied and migrated (`event_claims`). |
| `.env` | `TTC_MCP_URL=http://127.0.0.1:8765/<token>/mcp`, `TTC_PARTS=sacrament_conditions` (added). |
| `docs/coverage.md`, `docs/coverage/` | Design; schema diff, migration SQL, env diff (historical now that they're applied). |
| `scripts/coverage-check.ts` | End-to-end on an invented case against the live checker: `set -a; source .env; set +a; npx tsx scripts/coverage-check.ts`. Verified working on the laptop. |
| `training/reader/` | `claims.py` (mirror of claims.ts; `python3 claims.py ../../src/lib/domain/claims.ts` fails on drift), `generate.py` (templates → JSONL, each claim set validated by the checker in-process), `model.py` (sizes tiny/small/reader≈20M), `train.py` (CPU/CUDA/XPU), `serve.py` (`POST /read`), `README.md` with commands. Smoke-tested: tiny model reaches exact-match 1.0 on template validation in 2 epochs; serves proposals correctly. |

### Running processes on the laptop (may or may not still be up)
- `ttc-mcp --http --port 8765` with `~/.ttc/rules/marriage_*.lp` loaded (the three layer files, cases removed). Token URL is in the app's `.env`.
- Possibly `npm run dev` for the app.

### Two checkers, not one
The MCP that claude.ai sessions talk to (project "Sovereign Data at Home") runs elsewhere with personal folder `/data/home`, **0 rule files, 0 scenarios** — the marriage layers are not loaded there. Any check of cc. 1095–1103, impediments or form through that connection will return `not_engaged` as an artifact. Either load the three `.lp` into that server's `TTC_HOME/rules`, or point the project's MCP config at the laptop's `ttc-mcp --http`.

## 3. What is next, in order

1. **Claim menu on the event form.** `components/case/event-form.tsx` and `review-view.tsx`: per ground, offer `claimsForGround(key)` with the slot field where the claim takes one; the service that accepts/edits an event writes `claim`/`claimSlot` on `EventGround` in the same transaction and audit row. Until this, every ground reads bare (correctly).
2. **Coverage tab** in `components/case/case-tabs.tsx`, visible to those who see the chronology.
3. **What-if and orphaned evidence.** `?dubium=` on the page: same facts, different formulated set; show alternatives side by side, never rank. Surface passages tagged under grounds not formulated. (c. 1514: changing the formula is a decree for grave cause with the parties heard; the person framed the decision as maximin / minimax regret — show the table, don't decide it.)
4. **Reader corpus with variety.** Paraphrase generated passages through the local Ollama model (`qwen3:8b`, see `.env.example` `LOCAL_LLM_*`); relabel the 286 existing synthetic depositions in `training/kept/` with claims as the held-out test. Then train `--size reader` on yams (the person's LAN box with an integrated Intel GPU; `train.py` picks XPU if `torch.xpu.is_available()`, else CPU). Commands in `training/reader/README.md`.
5. **Reader pass in the app.** `READER_URL`; a pass in `lib/ai/` calling `POST /read` per passage, offering `{claim, bearing, slot?}` for acceptance, replacing the grounds pass's `{ground, bearing}`. Same quote guard, same accept-one-at-a-time.
6. **Checker saves.** When the person confirms: stamp, `save_rules` ×3, `save_scenario` ×47, first `save_case` on the doctrinal question under c. 1098 (deceit as natural-law defect of consent). Never save without their confirmation in-conversation.

## 4. Rules to keep (from the checker's CLAUDE.md and the project instructions)
- Teaching first, law ordered to it; law never answers a doctrinal question.
- Never compute anyone's interior (knowledge, intention, consent, grace, culpability). Claims are supplied, never derived.
- Canon law is binary; it branches only on a disputed fact, a disputed reading with no authentic interpretation, or the internal forum.
- Boot the checker and fix a frame before any claim; print the frame line; never add a part silently. Frame used this session: `rt_thomist · today 20261014 · sacrament_conditions (+ cases as needed) · no fixed readings`.
- A refusal is an encoding error, never a finding. Settled/open/shadow/excluded are the only statuses. A passing check shows well-formed, not true.
- Primary sources for every norm; a test per rule; hypothetical facts only in switch programs marked HYPOTHETICAL; stamp predictions before encoding; no names.
- Not "AI". No generative model writes a sentence of the sheet.

## 5. Other artifacts from this session
- claude.ai project doc `claude/coverage-method.md` (method + state).
- A proposed skill `checker-grounded-coverage` (the method as a reusable procedure) — may or may not have been saved by the person.
- A doc artifact, "The Voice in the Clock Radio" (an essay; unrelated to the code).
- The person also has a home-stack project (VPN egress, no-feed firewall, Jellyfin/Tube Archivist, Proton migration) in the same claude.ai project; not touched by code this session.
