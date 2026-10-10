"""MCP server: the checker as a set of tools a language model can drive.

The model does the interpretive work (reading a text, deciding what it
claims, at what tier, in what form). The checker does the mechanical work
(what follows, what conflicts, what each branch rests on). Run with
``ttc-mcp`` (stdio) and register it with any MCP client.
"""
from __future__ import annotations

import functools
import pathlib
import re

from mcp.server.mcpserver import MCPServer
from mcp.server.mcpserver.exceptions import ToolError

from . import __version__
from . import engine, suite

HERE = pathlib.Path(__file__).resolve().parent
GUIDE = (HERE / "guide.md").read_text()

INSTRUCTIONS = """\
A deterministic type checker for theological and canonical claims. It has
two layers. A core grammar types relations (being, origination, action,
nuptial gift, side-by-side), with the analogia entis enforced as a sort
discipline. An authority graph tiers sources (c. 750 §1, §2, c. 752,
Doctors, theologians), dates them, and splits every disputed question into
branches.

Your job is the interpretation: turning a text into facts. The checker's
job is the consequences. Before encoding anything, call `guide`. Start from
the nearest existing case (`list_parts`, `read_part`). Run `check` and read
the result as branches, not verdicts. When the checker disagrees with an
author, treat that as a question (is the checker wrong, or the
literature?) and test the checker's side with `fix_method`.

Never compute anyone's imputability or interior state: that is an input
from the internal forum (the rule of non-diagnosis). The checker can show
that a claim is ill-formed in this grammar. It cannot show that a
well-formed claim is true.
"""

server = MCPServer(name="theological-type-checker", title="Theological Type Checker",
                   instructions=INSTRUCTIONS, version=__version__)


# ---------- helpers -----------------------------------------------------
def _part_blocks():
    """name -> (file, comment, source text) for every #program block."""
    out = {}
    for f, text in engine.base_texts().items():
        lines = text.splitlines()
        starts = [i for i, l in enumerate(lines) if re.match(r"#program\s+\w+\s*\.", l)]
        for k, i in enumerate(starts):
            name = re.match(r"#program\s+(\w+)", lines[i]).group(1)
            end = starts[k + 1] if k + 1 < len(starts) else len(lines)
            block = "\n".join(lines[i:end]).rstrip()
            comment = ""
            m = re.search(r"%\s*(.*)$", lines[i])
            if m:
                comment = m.group(1).strip()
            elif i + 1 < len(lines) and lines[i + 1].lstrip().startswith("%"):
                comment = lines[i + 1].strip("% ").strip()
            else:
                for j in range(i - 1, max(i - 4, -1), -1):
                    if lines[j].startswith("% ----------"):
                        comment = lines[j].strip("%- ").strip()
                        break
            out.setdefault(name, (f, comment, block))
    return out


def _kind(name, f, block):
    if name.startswith("asof_"):
        return "date"
    if name.startswith("cand_"):
        return "candidate"
    if f == "icon_models.lp":
        return "model"
    if "question(" in block and "#program" in block and f == "icon_history.lp":
        return "case"
    if f == "icon_tests.lp" and re.search(r"#(minimize|maximize)", block):
        return "search"
    return "switch"


def _run(parts, facts, max_models, timeout_s, optimize=False):
    return engine.run_checked(parts, facts, max_models, timeout_s, optimize)


def _friendly(fn):
    """Report input problems (bad parts, bad snippets) to the model as tool errors."""
    @functools.wraps(fn)
    def wrapper(*args, **kwargs):
        try:
            return fn(*args, **kwargs)
        except (engine.SnippetError, ValueError) as exc:
            raise ToolError(str(exc)) from None
    return wrapper


# ---------- tools ---------------------------------------------------------
@server.tool()
@_friendly
def guide() -> str:
    """The encoding manual: the fact vocabulary, the output atoms, how to read
    a result, and the workflow. Read it before writing any facts."""
    return GUIDE


@server.tool()
@_friendly
def list_parts(kind: str | None = None) -> list[dict]:
    """List the #program parts you can switch on in a run.

    kind filters to one of: model (core domain models), case (historical and
    current cases with questions and sources), switch (readings, typings,
    ablations), candidate (positions written as rules, usually to show they
    fail), date (asof_YYYY), search (optimisation runs).
    """
    rows = []
    for name, (f, comment, block) in _part_blocks().items():
        k = _kind(name, f, block)
        if kind and k != kind:
            continue
        qs = sorted(set(re.findall(r"question\((q\([^)]*\)+)\)", block)))
        rows.append({"part": name, "kind": k, "file": f, "note": comment, "questions": qs})
    return rows


@server.tool()
@_friendly
def read_part(name: str) -> str:
    """The source of one #program part, or of a whole rule file (e.g.
    'icon_authority.lp'). Use it to model a new case on an existing one."""
    if name.endswith(".lp"):
        texts = engine.base_texts()
        if name not in texts:
            raise ValueError(f"no such file; files are: {', '.join(texts)}")
        return texts[name]
    blocks = _part_blocks()
    if name not in blocks:
        raise ValueError(f"no such part: {name}")
    f, _, block = blocks[name]
    return f"% from {f}\n{block}"


@server.tool()
@_friendly
def check(parts: list[str], facts: str = "", max_branches: int = 30, max_models: int = 20000,
          timeout_s: float = 60.0, optimize: bool = False) -> dict:
    """Run the checker on the named parts plus your own facts.

    parts: #program names from list_parts (e.g. ["sspx", "lattice"]).
    facts: ASP facts and rules you wrote for a new text or case (see guide).
    Returns, per question and value, settled / open / shadow / excluded and
    the value preferred by weight. It also returns the violations and notes
    found in every branch or only in some, and the branches themselves, each
    with what it rests on, what cleaves it, and what would bring it back.
    Set optimize=True only for the search parts (lateran, rescue_*).
    """
    r = _run(parts, facts, max_models, timeout_s, optimize)
    if optimize:
        return {"satisfiable": r["sat"], "optimal_cost": r["cost"], "atoms": r["atoms"],
                "violations": r["violations"], "truncated": r["truncated"]}
    return engine.summary(r, max_branches)


@server.tool()
@_friendly
def compare(parts_a: list[str], parts_b: list[str], facts_a: str = "", facts_b: str = "") -> dict:
    """Run two configurations and report only what differs: the status of
    each question=value, the preferred values, and the violations or notes
    found in every branch. Use it to see what one reading, date, typing or
    source changes (e.g. a: ["sspx","lattice","asof_2018"], b: ["sspx","lattice"])."""
    a = engine.summary(_run(parts_a, facts_a, 20000, 60.0))
    b = engine.summary(_run(parts_b, facts_b, 20000, 60.0))
    diff = {"questions": {}, "every_branch_added": [], "every_branch_removed": []}
    for q in sorted(set(a.get("questions", {})) | set(b.get("questions", {}))):
        qa, qb = a.get("questions", {}).get(q), b.get("questions", {}).get(q)
        if qa != qb:
            diff["questions"][q] = {"a": qa, "b": qb}
    ea, eb = set(a.get("in_every_branch", [])), set(b.get("in_every_branch", []))
    diff["every_branch_added"] = sorted(eb - ea)
    diff["every_branch_removed"] = sorted(ea - eb)
    diff["stable_models"] = {"a": a.get("stable_models"), "b": b.get("stable_models")}
    return diff


@server.tool()
@_friendly
def run_suite(ids: list[str] | None = None) -> dict:
    """Run the regression suite (or the scenarios whose id starts with one of
    `ids`, e.g. ["SX", "DR"]). Every scenario states what it expects and what
    it got. A failure means the rule base no longer explains a case it used to."""
    rows = suite.run(ids)
    return {"passed": sum(r["ok"] for r in rows), "total": len(rows),
            "failures": [r for r in rows if not r["ok"]],
            "results": [{"id": r["id"], "name": r["name"], "ok": r["ok"]} for r in rows]}


_BASELINE = {}


def _baseline():
    key = tuple((f, (engine.LP_DIR / f).stat().st_mtime) for f in engine.FILES)
    if key not in _BASELINE:
        _BASELINE.clear()
        _BASELINE[key] = {r["id"]: r for r in suite.run()}
    return _BASELINE[key]


@server.tool()
@_friendly
def fix_method(add_rules: str = "", remove_lines: list[str] | None = None) -> dict:
    """The fix method: change the rule base, rerun the whole suite, and report
    what the change gains and loses.

    add_rules: rules to add to the base (e.g. a proposed new axiom).
    remove_lines: exact substrings, each matching one line of the rule base,
    to comment out (e.g. an axiom you think is wrong).
    A good fix explains the disputed case and turns nothing else red; a bad
    one buys the case at the price of others. Nothing is written to disk.
    """
    base = _baseline()
    with engine.rule_change(add_rules, remove_lines or []):
        now = {r["id"]: r for r in suite.run()}
    newly_failing = [{"id": i, "name": now[i]["name"], "expected": now[i]["expected"], "got": now[i]["got"]}
                     for i in now if base[i]["ok"] and not now[i]["ok"]]
    newly_passing = [{"id": i, "name": now[i]["name"]} for i in now if not base[i]["ok"] and now[i]["ok"]]
    changed = [{"id": i, "before": base[i]["got"], "after": now[i]["got"]}
               for i in now if now[i]["ok"] and base[i]["ok"] and now[i]["got"] != base[i]["got"]]
    return {"tests": len(now), "newly_failing": newly_failing, "newly_passing": newly_passing,
            "passing_but_output_changed": changed,
            "verdict": "no loss" if not newly_failing else f"{len(newly_failing)} test(s) lost"}


@server.tool()
@_friendly
def lint(rules: str = "") -> dict:
    """Static analogy check: flag any rule (in the base, or in `rules`) whose
    body mixes divine- and creature-sorted predicates without going through
    a declared bridge (licensed/2, mode/3, bridge/3). Lateran IV as a type
    discipline: nothing crosses the Creator-creature line unannounced."""
    findings = engine.lint(rules)
    return {"clean": not findings, "unbridged_rules": findings}


# ---------- resources and prompts --------------------------------------------
@server.resource("ttc://guide", name="guide", mime_type="text/markdown",
                 description="The encoding manual.")
def guide_resource() -> str:
    return GUIDE


@server.resource("ttc://rules/{file}", name="rules", mime_type="text/plain",
                 description="One rule file of the base, e.g. icon_core.lp.")
def rules_resource(file: str) -> str:
    texts = engine.base_texts()
    if file not in texts:
        raise ValueError(f"no such file; files are: {', '.join(texts)}")
    return texts[file]


@server.prompt()
def type_check_text(text: str, context: str = "") -> str:
    """Type-check a theological or canonical text against the authority graph."""
    return f"""Type-check the following text with the theological-type-checker tools.

1. Call `guide`, then `list_parts`, and read the nearest existing case with `read_part`.
2. Identify each claim the text makes. For each, decide the question it answers,
   the question's kind (doctrinal / governance / juridical), and the value it holds.
   Where the text can be read more than one way, encode it as `ambiguous` with
   one `reading` per interpretation rather than choosing.
3. Enter the text and any sources it relies on or contradicts, each with tier,
   force, year, papal form, character and legislator rank.
4. Run `check` with the relevant parts plus your facts. Report, for each question,
   what is settled, what is open, what is a shadow and what would bring it back.
5. List every violation, and for each one ask: is the checker wrong, or the text?
   If you suspect the checker, propose a rule change and test it with `fix_method`.
6. Never assign anyone an interior state or a degree of culpability.

State every interpretive choice you made as a fact the reader can dispute.

Context: {context}

Text:
{text}
"""


@server.prompt()
def review_rule_change(proposal: str) -> str:
    """Evaluate a proposed change to the theory with the fix method."""
    return f"""A change to the rule base has been proposed:

{proposal}

Write it as rules to add and/or exact lines to remove, run `fix_method`, and report:
what it newly explains, which tests it turns red (and what each of those tests
encodes, theologically), and whether the change has a warrant independent of the
case it was made to fix (a change without one is a degenerating shift). Recommend
adopting it only if it gains without loss, or if every loss is argued for.
"""


def main():
    server.run()


if __name__ == "__main__":
    main()
