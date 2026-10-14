"""MCP server: the checker as a set of tools a language model can drive.

The model does the interpretive work (reading a text, deciding what it
claims, at what tier, in what form). The checker does the mechanical work
(what follows, what conflicts, what each branch rests on). Run with
``ttc-mcp`` (stdio) and register it with any MCP client, or with
``ttc-mcp --http`` behind a secret URL for the clients that call from afar.
"""
from __future__ import annotations

import argparse
import functools
import inspect
import logging
import os
import pathlib
import re
import secrets

from mcp.server.mcpserver import MCPServer
from mcp.server.mcpserver.exceptions import ToolError
from mcp_types import CallToolResult, TextContent, ToolAnnotations

import hashlib
import json

from . import __version__
from . import engine, lang, library, norms, suite

HERE = pathlib.Path(__file__).resolve().parent
GUIDE = (HERE / "guide.md").read_text()

INSTRUCTIONS = """\
Deterministic type checker for theological and canonical claims. Three
layers, used as an ordered pair (teaching first, law ordered to it):
grammar (typed relations; analogy as a sort discipline), authority (tiers,
forms, dates; questions branch; only tier 1 deletes), canon (canons as
dated yes/no rules; branches only on disputed facts, disputed readings, or
the internal forum, which is never computed).

You interpret; the checker computes. Call `guide` before encoding. Start
from the nearest case (`list_parts`, `read_part`). Read results as branches,
not verdicts. When the checker and a text disagree, ask which is wrong, and
test the checker's side with `fix_method`.

It grows with use: `flywheel_status` shows the frontier (theology, canon,
library); `save_rules`, `save_case` (theology, then canon), `save_scenario`
and `mark_consulted` record what the person has confirmed;
`library_fetch_list` gives the books still owed, nearest library first.

Never compute anyone's interior. The checker shows that a claim is
ill-formed. It does not show that a well-formed claim is true.
"""

# Over HTTP, by default, the server offers only the tools that read: one
# personal layer is shared by every client, so a save by one would change
# the answers of all. The tools that write stay on the person's own machine
# (stdio), or are served over HTTP only with `--writers`.
INSTRUCTIONS_READ_ONLY = INSTRUCTIONS.replace("""It grows with use: `flywheel_status` shows the frontier (theology, canon,
library); `save_rules`, `save_case` (theology, then canon), `save_scenario`
and `mark_consulted` record what the person has confirmed;
`library_fetch_list` gives the books still owed, nearest library first.""",
"""Over this connection the checker only reads. `flywheel_status` shows the
frontier (theology, canon, library); `library_fetch_list` gives the books
still owed, nearest library first. What the person confirms is saved on the
person's own machine, not from here.""")
assert INSTRUCTIONS_READ_ONLY != INSTRUCTIONS

server = MCPServer(name="theological-type-checker", title="Theological Type Checker",
                   instructions=INSTRUCTIONS, version=__version__)
server_read_only = MCPServer(name="theological-type-checker", title="Theological Type Checker",
                             instructions=INSTRUCTIONS_READ_ONLY, version=__version__)
WRITERS: set[str] = set()         # the tools served over HTTP only with --writers


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


def _refusal(exc) -> ToolError:
    """A refusal as data: the error's text is the compact JSON of its fields
    (engine.REFUSAL_FIELDS), the same on every path."""
    if not isinstance(exc, engine.SnippetError):
        exc = engine.SnippetError(str(exc), "input")
    return ToolError(engine.dumps(exc.as_dict()))


def _friendly(fn):
    """Report input problems (bad parts, bad snippets) to the model as
    structured refusals, and every result with its keys sorted."""
    @functools.wraps(fn)
    def wrapper(*args, **kwargs):
        try:
            return engine.stable(fn(*args, **kwargs))
        except (engine.SnippetError, ValueError) as exc:
            raise _refusal(exc) from None
    return wrapper


def _tool(fn=None, *, writes=False, overwrites=False, open_world=False):
    """Register a tool. Called in process it raises a refusal as ToolError;
    over the wire the refusal is the call's error result, and its text is
    the same JSON, with nothing before it.

    A tool only reads unless it says otherwise: writes (to the personal
    layer), overwrites (can replace a file already there), open_world
    (reaches the network). A client that is told nothing asks the person
    before every call."""
    if fn is None:
        return functools.partial(_tool, writes=writes, overwrites=overwrites, open_world=open_world)
    friendly = _friendly(fn)

    @functools.wraps(fn)
    def wire(*args, **kwargs):
        try:
            return friendly(*args, **kwargs)
        except ToolError as exc:
            return CallToolResult(content=[TextContent(type="text", text=str(exc))], is_error=True)

    annotations = ToolAnnotations(read_only_hint=not writes, destructive_hint=overwrites,
                                  open_world_hint=open_world)
    server.tool(annotations=annotations)(wire)
    if writes:
        WRITERS.add(fn.__name__)
    else:
        server_read_only.tool(annotations=annotations)(wire)
    return friendly


def _resource(*args, **kwargs):
    """A resource, on both servers."""
    def register(fn):
        for s in (server, server_read_only):
            s.resource(*args, **kwargs)(fn)
        return fn
    return register


def _prompt():
    """A prompt, on both servers."""
    def register(fn):
        for s in (server, server_read_only):
            s.prompt()(fn)
        return fn
    return register


# ---------- tools ---------------------------------------------------------
@_tool
def guide() -> str:
    """The encoding manual: the fact vocabulary, the output atoms, how to read
    a result, and the workflow. Read it before writing any facts."""
    return GUIDE


@_tool
def list_parts(kind: str | None = None) -> list[dict]:
    """List the #program parts you can switch on in a run.

    kind filters to one of: model (core domain models), case (historical and
    current cases with questions and sources), switch (readings, typings,
    ablations), candidate (positions written as rules, usually to show they
    fail), date (asof_YYYY), search (optimisation runs), runtime (a school's
    parts loaded whole: name it as rt_<name>; with none named a run uses
    rt_default, and rt_bare loads none).
    """
    rows = []
    if kind in (None, "runtime"):
        rows += [{"part": f"rt_{n}", "kind": "runtime", "file": "engine.py", "note": ", ".join(ps) or "no runtime",
                  "questions": []} for n, ps in engine.RUNTIMES.items()]
        if kind == "runtime":
            return rows
    for name, (f, comment, block) in _part_blocks().items():
        k = _kind(name, f, block)
        if kind and k != kind:
            continue
        qs = sorted(set(re.findall(r"question\((q\([^)]*\)+)\)", block)))
        rows.append({"part": name, "kind": k, "file": f, "note": comment, "questions": qs})
    return rows


@_tool
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


@_tool
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
        return {"schema": engine.SCHEMA, "satisfiable": r["sat"], "optimal_cost": r["cost"], "atoms": r["atoms"],
                "violations": r["violations"], "truncated": r["truncated"], "warnings": r["warnings"]}
    return engine.summary(r, max_branches)


@_tool
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
    diff["warnings"] = {"a": a["warnings"], "b": b["warnings"]}
    return diff


@_tool
def run_suite(ids: list[str] | None = None) -> dict:
    """Run the regression suite (or the scenarios whose id starts with one of
    `ids`, e.g. ["SX", "DR"]). Every scenario states what it expects and what
    it got. A failure means the rule base no longer explains a case it used to."""
    rows = suite.run(ids)
    return {"passed": sum(r["ok"] for r in rows), "total": len(rows),
            "next": RED_IS_A_FINDING if any(not r["ok"] for r in rows) else None,
            "failures": [r for r in rows if not r["ok"]],
            "results": [{"id": r["id"], "name": r["name"], "ok": r["ok"]} for r in rows]}


RED_IS_A_FINDING = ("A red test is a finding (house rule 7). Open each with read_test before deciding, "
                    "then say which it is: the change is wrong; the test is brittle (say why, and how it "
                    "should be written); or the expectation should change (say why). Never save over a "
                    "red test without one of these for each.")


def _definition(sid: str) -> dict:
    """A scenario's parts, mode, expectation and the source that defines its checks."""
    s = next((x for x in suite.S + suite.personal_scenarios() if x["id"] == sid), None)
    if s is None:
        raise ValueError(f"no such test: {sid}")
    src = pathlib.Path(suite.__file__).read_text()
    m = re.search(r'^scen\("' + re.escape(sid) + r'".*?(?=^\S)', src, re.S | re.M)
    body = m.group(0).rstrip() if m else "(a personal scenario: see scenarios.json)"
    helpers = []
    for w in dict.fromkeys(re.findall(r"\b([a-z_][a-z0-9_]*)\b", body)):
        f = getattr(suite, w, None)
        if w != "scen" and inspect.isfunction(f) and f.__module__ == suite.__name__:
            helpers.append(inspect.getsource(f).rstrip())
    return {"id": sid, "group": s["group"], "name": s["name"], "parts": s["parts"], "mode": s["mode"],
            "expected": s["expected"], "source": body, "checks_defined_as": helpers}


@_tool
def read_test(id: str) -> dict:
    """One regression test: its parts, mode, what it expects, and the source of
    its checks in suite.py. Open every test a change turns red before deciding
    what the red means."""
    return _definition(id)


_BASELINE = {}


def _state_key():
    texts = engine.base_texts()
    blob = json.dumps([sorted(texts.items()), engine.personal_scenarios_raw()], sort_keys=True)
    return hashlib.sha256(blob.encode()).hexdigest()


def _baseline():
    key = _state_key()
    if key not in _BASELINE:
        _BASELINE.clear()
        _BASELINE[key] = {r["id"]: r for r in suite.run()}
    return _BASELINE[key]


@_tool
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
    newly_failing = [{"id": i, "name": now[i]["name"], "expected": now[i]["expected"], "got": now[i]["got"],
                      "definition": _definition(i)}
                     for i in now if base[i]["ok"] and not now[i]["ok"]]
    newly_passing = [{"id": i, "name": now[i]["name"]} for i in now if not base[i]["ok"] and now[i]["ok"]]
    changed = [{"id": i, "before": base[i]["got"], "after": now[i]["got"]}
               for i in now if now[i]["ok"] and base[i]["ok"] and now[i]["got"] != base[i]["got"]]
    return {"tests": len(now), "newly_failing": newly_failing, "newly_passing": newly_passing,
            "passing_but_output_changed": changed,
            "verdict": "no loss" if not newly_failing else f"{len(newly_failing)} test(s) lost",
            "next": RED_IS_A_FINDING if newly_failing else None}


@_tool
def lint(rules: str = "") -> dict:
    """Static analogy check: flag any rule (in the base, or in `rules`) whose
    body mixes divine- and creature-sorted predicates without going through
    a declared bridge (licensed/2, mode/3, bridge/3). Lateran IV as a type
    discipline: nothing crosses the Creator-creature line unannounced."""
    findings = engine.lint(rules)
    return {"clean": not findings, "unbridged_rules": findings}


# ---------- the norm graph -----------------------------------------------------
@_tool
def norm_graph(focus: str | None = None, format: str = "mermaid") -> str | dict:
    """The canon-law layer as a graph: which norms feed which. Each norm is a
    tagged block of rules (`% @norm cic2021:1387 | ... | source`). Use
    format="mermaid" for a diagram, "json" for the nodes, edges and inputs.
    focus: one norm id, to show only it and its neighbours."""
    if format == "json":
        g = norms.graph()
        return {"norms": g["norms"], "edges": g["edges"], "inputs": g["inputs"], "temporal": g["temporal"]}
    return norms.mermaid(focus=focus)


@_tool
def norm_check() -> dict:
    """Check the canon-law layer: vicious cycles (norms that depend on each
    other in a loop), temporal loops (recursion over later acts, allowed),
    undefined predicates (used but neither derived nor declared as input:
    usually a canon not yet encoded, i.e. the frontier) and unused inputs."""
    return norms.check()


# ---------- the flywheel: a personal layer that grows with use ---------------
def theology_frontier() -> list[str]:
    """Frontier items of the theological side, across every case part."""
    found = set()
    for name, (f, _, block) in _part_blocks().items():
        if _kind(name, f, block) != "case":
            continue
        for a in engine.solve([name], "one")["atoms"]:
            if a.startswith("frontier(theology,"):
                found.add(a[len("frontier(theology,"):-1])
    return sorted(found)

_NAME = re.compile(r"^[a-z][a-z0-9_]{0,47}$")


def _home():
    home = engine.ttc_home()
    if not home:
        raise ValueError("No personal folder is configured. Set TTC_HOME to a folder (for example ~/.ttc) "
                         "in the MCP server's environment, or create ~/.ttc. See docs/flywheel.md.")
    (home / "rules").mkdir(parents=True, exist_ok=True)
    return home


@_tool
def flywheel_status(run_tests: bool = False) -> dict:
    """What the personal layer holds and what to do next: personal rule and
    case files, personal regression scenarios, the canon-law frontier
    (predicates used but not yet encoded), and optionally the full suite."""
    home = engine.ttc_home()
    out = {"personal_folder": str(home) if home else None,
           "rule_files": [f.name for f in engine.personal_rule_files()],
           "scenarios": len(engine.personal_scenarios_raw()),
           "frontier": {"theology": theology_frontier(),
                        "canon": norms.check()["undefined_predicates"],
                        "library": [w.id for w in library.wanted()]},
           "norms_encoded": len(norms.graph()["norms"])}
    if run_tests:
        rows = suite.run()
        out["suite"] = {"passed": sum(r["ok"] for r in rows), "total": len(rows),
                        "failures": [r["id"] for r in rows if not r["ok"]]}
    if not home:
        out["next"] = "Configure a personal folder (TTC_HOME) to start saving rules, cases and tests."
    return out


@_tool(writes=True, overwrites=True)
def save_rules(name: str, rules: str, force: bool = False, reasons: dict[str, str] | None = None) -> dict:
    """Save rules to the personal layer ($TTC_HOME/rules/<name>.lp), after
    running the whole suite with them. If any test that passed now fails, the
    rules are NOT saved. force=True saves anyway, but only with `reasons`: for
    every newly failing test id, why the loss is right (the test is brittle,
    or its expectation should change), as the person has agreed after you
    opened the test with read_test. Tag canon-law rules with
    `% @norm <id> | <citation> | <source URL>` and declare new fact slots
    with `% @input <name>/<arity> | <meaning>`."""
    if not _NAME.match(name):
        raise ValueError("name must be lowercase letters, digits and underscores")
    home = _home()
    report = fix_method(add_rules=rules)
    if report["newly_failing"] and not force:
        return {"saved": False, "reason": "the change turns tests red", **report}
    missing = [f["id"] for f in report["newly_failing"] if not (reasons or {}).get(f["id"], "").strip()]
    if missing:
        return {"saved": False, "reason": "force needs a stated reason for each red test: " + ", ".join(missing),
                **report}
    header = "".join(f"% red test accepted: {i}: {r}\n" for i, r in sorted((reasons or {}).items())
                     if i in {f["id"] for f in report["newly_failing"]})
    (home / "rules" / f"{name}.lp").write_text(header + rules.rstrip() + "\n")
    _BASELINE.clear()
    return {"saved": True, "file": str(home / "rules" / f"{name}.lp"), **report}


def _layer_lint(text, layer):
    """Refuse a slot of the other side: each slot's side is its declaring
    file's (lang.sides), theology, canon or either (TTC-L, LY)."""
    other = "canon" if layer == "theology" else "theology"
    sides = lang.sides()
    s = engine.signatures(text, layer)
    wrong = sorted(sig for sig in s["heads"] | s["reads"] if sides.get(sig) == other)
    if not wrong:
        return
    code = re.sub(r"%.*", "", text)
    found = []
    for name, arity in wrong:
        rx = rf"(?<![\w]){name}\s*\(" if arity else rf"(?<![\w]){name}(?![\w(])"
        m = re.search(rx, code)
        found.append((m.start() if m else len(code), f"{name}/{arity}"))
    first, pred = min(found)
    line = code.count("\n", 0, first) + 1
    raise engine.SnippetError(f"the {layer} side may not contain {', '.join(p for _, p in sorted(found, key=lambda f: f[1]))}: "
                              "theology goes in `theology`, canon law in `canon` (house rule 1)",
                              "layer", layer, line, None, pred, engine._line_of(text, line))


@_tool(writes=True, overwrites=True)
def save_case(part: str, theology: str = "", canon: str = "", note: str = "") -> dict:
    """Save a case to the personal layer as an ordered pair, theology first and
    canon law second, both under `#program <part>.` in
    $TTC_HOME/rules/case_<part>.lp.

    theology: questions, sources, readings (the authority graph).
    canon: events, decrees, grants, acts (the canon-law layer). Link the two
    with classification(Q,Event,Kind) and premise(Norm,Q,V), which go on the
    canon side: the law follows the teaching, never the reverse.
    Write facts only from sources you can cite; say where in `note`.
    """
    if not _NAME.match(part):
        raise ValueError("part must be lowercase letters, digits and underscores")
    if part in engine.known_parts() and not (engine.ttc_home() and (engine.ttc_home() / "rules" / f"case_{part}.lp").exists()):
        raise ValueError(f"part {part!r} already exists in the base; choose another name")
    if not (theology.strip() or canon.strip()):
        raise ValueError("give the theology side, the canon side, or both")
    engine.check_snippet(theology, "theology")
    engine.check_snippet(canon, "canon")
    _layer_lint(theology, "theology")
    _layer_lint(canon, "canon")
    home = _home()
    header = "".join(f"% {line}\n" for line in note.splitlines()) if note else ""
    path = home / "rules" / f"case_{part}.lp"
    path.write_text(f"{header}#program {part}.\n% --- theology (first) ---\n{theology.rstrip()}\n"
                    f"% --- canon law (ordered to it) ---\n{canon.rstrip()}\n")
    try:
        r = engine.run_checked([part])
    except engine.SnippetError:
        path.unlink()
        raise
    _BASELINE.clear()
    return {"saved": str(path), "check": engine.summary(r, 5)}


@_tool(writes=True)
def save_scenario(id: str, name: str, parts: list[str], expect: list[dict], facts: str = "",
                  expected: str = "") -> dict:
    """Record a verified result as a regression test in
    $TTC_HOME/scenarios.json. It is saved only if it passes now, so the
    suite remembers what the person has checked and confirmed.

    expect: a list of checks, each one of
      {"kind": "status", "of": "q(x)=v", "is": "settled|open|shadow|excluded"}
      {"kind": "present", "atom": "info(...)" or "violation(...)", "in": "every|some|none"}
      {"kind": "preferred", "question": "q(x)", "value": "v"}
    """
    if not re.match(r"^P[A-Za-z0-9_-]{1,30}$", id):
        raise ValueError("personal scenario ids start with P (e.g. P12)")
    home = _home()
    existing = engine.personal_scenarios_raw()
    if any(s["id"] == id for s in existing):
        raise ValueError(f"scenario {id} already exists")
    entry = {"id": id, "name": name, "parts": parts, "facts": facts, "expect": expect,
             "expected": expected or name}
    checks = [suite._expect_check(e) for e in expect]
    r = engine.solve(parts, "branches", facts=facts)
    results = [c(r) for c in checks]
    if not all(ok for ok, _ in results):
        return {"saved": False, "reason": "the scenario does not pass now", "got": [d for _, d in results]}
    (home / "scenarios.json").write_text(json.dumps(existing + [entry], indent=2, ensure_ascii=False) + "\n")
    _BASELINE.clear()
    return {"saved": True, "id": id, "got": [d for _, d in results]}


# ---------- the library: physical copies -------------------------------------
@_tool(open_world=True)
def library_fetch_list(parts: list[str] | None = None, near: str | None = None, per_item: int = 3,
                       include_reading: bool = True, format: str = "markdown") -> str | dict:
    """A fetch list of physical copies: works the encoded sources are read in
    (not yet consulted, not reliably online) and research the theory still
    owes, grouped by the nearest library holding each.

    near: "lat,lon" or a place name (default $TTC_LOCATION). Holdings come
    from the WorldCat Search API when OCLC_CLIENT_ID/OCLC_CLIENT_SECRET are
    set; otherwise WorldCat links are given. format: markdown, csv or json."""
    rep = library.build(parts, near, per_item, include_reading)
    if format == "csv":
        return library.to_csv(rep)
    if format == "json":
        return library.to_json(rep)
    return library.to_markdown(rep)


@_tool(writes=True)
def mark_consulted(source: str, note: str) -> dict:
    """Record that a source has been checked against the original (edition,
    page, date) in the personal layer. It then drops off the fetch list. The
    note is kept as the record of what was checked."""
    if not _NAME.match(source):
        raise ValueError("source must be an encoded source id")
    home = _home()
    f = home / "rules" / "consulted.lp"
    line = f"consulted({source}).   % {' '.join(note.split())}\n"
    f.write_text((f.read_text() if f.exists() else "% sources checked against the original\n") + line)
    _BASELINE.clear()
    return {"recorded": line.strip(), "file": str(f)}


# ---------- resources and prompts --------------------------------------------
@_resource("ttc://guide", name="guide", mime_type="text/markdown",
                 description="The encoding manual.")
def guide_resource() -> str:
    return GUIDE


@_resource("ttc://rules/{file}", name="rules", mime_type="text/plain",
                 description="One rule file of the base, e.g. kernel_core.lp.")
def rules_resource(file: str) -> str:
    texts = engine.base_texts()
    if file not in texts:
        raise ValueError(f"no such file; files are: {', '.join(texts)}")
    return texts[file]


GRAMMAR_CAVEAT = ("The checker's word about itself: a claim, never evidence that it is right. "
                  "Nothing in the rule base reads it.")


def grammar() -> dict:
    """What the checker declares about itself, read off the rule files and
    the server: the summary's schema; the slots the @input tags declare,
    each with every tag (file and text) and the longest text as its
    meaning; the vocabulary (every
    predicate of the base, and what the base does with it: the gate's
    known set); the outputs; the parts; the runtimes; the tools with their
    arguments; the refusal's fields and gates; the warnings."""
    texts = engine.base_texts()
    tags = {}
    for f, t in texts.items():
        for m in engine._TAG_INPUT.finditer(t):
            tags.setdefault(f"{m.group(1)}/{m.group(2)}", []).append((f, " ".join(m.group(3).split())))
    slots = {sig: {"meaning": max((d for _, d in rows), key=len),
                   "tags": [{"file": f, "meaning": d} for f, d in rows]} for sig, rows in tags.items()}
    v = engine.vocabulary()
    every = v["heads"] | v["reads"] | v["shown"] | v["tagged"]
    vocab = {f"{n}/{a}": {"written": (n, a) in v["heads"], "read": (n, a) in v["reads"],
                          "derived": (n, a) in v["derived"], "shown": (n, a) in v["shown"],
                          "tagged": (n, a) in v["tagged"]} for n, a in every}
    parts = {}
    for name, (f, comment, block) in _part_blocks().items():
        parts[name] = {"file": f, "kind": _kind(name, f, block), "note": comment,
                       "questions": sorted(set(re.findall(r"question\((q\([^)]*\)+)\)", block)))}
    tools = {t.name: {"description": inspect.cleandoc(t.description or ""), "parameters": t.parameters}
             for t in server._tool_manager.list_tools()}
    return engine.stable({
        "caveat": GRAMMAR_CAVEAT,
        "schema": engine.SCHEMA,
        "version": __version__,
        "slots": slots,
        "vocabulary": vocab,
        "outputs": sorted(f"{n}/{a}" for n, a in v["shown"]),
        "parts": parts,
        "runtimes": {k: list(ps) for k, ps in engine.RUNTIMES.items()},
        "tools": tools,
        "refusal": {"fields": list(engine.REFUSAL_FIELDS), "gates": dict(engine.REFUSAL_GATES)},
        "warnings": {"unknown_slot": inspect.cleandoc(engine.unknown_slots.__doc__)},
    })


@_resource("ttc://grammar", name="grammar", mime_type="application/json",
                 description="What the checker says about itself: slots, vocabulary, parts, runtimes, "
                             "tools, refusals and the summary's schema, as compact key-sorted JSON. "
                             "A claim, never evidence that the checker is right.")
def grammar_resource() -> str:
    return engine.dumps(grammar())


@_prompt()
def type_check_text(text: str, context: str = "") -> str:
    """Type-check a theological or canonical text against the authority graph."""
    return f"""Type-check the following text with the theological-type-checker tools.

1. Call `guide`, then `list_parts`, and read the nearest existing case with `read_part`.
2. Identify each claim the text makes. For each, decide the question it answers,
   the question's kind (doctrinal / governance / juridical), and the value it holds.
   Teaching goes on the theology side; juridical facts on the canon side (the
   ordered pair: teaching first, law ordered to it).
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


@_prompt()
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


# ---------- over HTTP: one secret URL per client -------------------------------
log = logging.getLogger("ttc-mcp")


def tokens_file() -> pathlib.Path:
    """Where the tokens' hashes are kept: $TTC_MCP_TOKENS, else
    ~/.config/ttc-mcp/tokens. Never inside $TTC_HOME: that folder is the
    person's work, to be copied and versioned, and this file is the lock."""
    v = os.environ.get("TTC_MCP_TOKENS")
    return pathlib.Path(v or "~/.config/ttc-mcp/tokens").expanduser()


def _digest(token: str) -> str:
    return hashlib.sha256(token.encode()).hexdigest()


def read_tokens(path: pathlib.Path) -> dict[str, str]:
    """hash -> client name, from lines of `name hash`. No file, no tokens."""
    try:
        lines = path.read_text().splitlines()
    except OSError:
        return {}
    rows = [l.split() for l in lines if l.strip() and not l.lstrip().startswith("#")]
    return {r[1]: r[0] for r in rows if len(r) == 2}


def new_token(name: str, path: pathlib.Path | None = None) -> str:
    """Mint a token for one client and record its hash under `name`. The
    token is returned once and kept nowhere. To revoke it, delete its line."""
    if not _NAME.match(name):
        raise ValueError("name must be lowercase letters, digits and underscores")
    path = path or tokens_file()
    if name in read_tokens(path).values():
        raise ValueError(f"a token named {name!r} exists; delete its line in {path} to replace it")
    token = secrets.token_urlsafe(32)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.touch(mode=0o600)
    with path.open("a") as f:
        f.write(f"{name} {_digest(token)}\n")
    return token


class SecretPath:
    """The gate in front of the server: /<token>/mcp reaches it as /mcp, and
    every other path is a 404 that says nothing. The address is the key, so
    it works with any client that takes a URL and no login. The file is read
    again whenever it changes: a deleted line is revoked at once."""

    def __init__(self, app, path: pathlib.Path):
        self.app, self.path, self._seen, self._tokens = app, path, None, {}

    def client(self, token: str) -> str | None:
        try:
            st = self.path.stat()
            seen = (st.st_mtime_ns, st.st_size)
        except OSError:
            seen = None
        if seen != self._seen:
            self._tokens, self._seen = read_tokens(self.path), seen
        return self._tokens.get(_digest(token))

    async def __call__(self, scope, receive, send):
        if scope["type"] != "http":                      # lifespan: the server's own start and stop
            return await self.app(scope, receive, send)
        token, _, rest = scope["path"].lstrip("/").partition("/")
        name = self.client(token) if rest == "mcp" else None
        if name is None:
            await send({"type": "http.response.start", "status": 404,
                        "headers": [(b"content-type", b"text/plain; charset=utf-8")]})
            return await send({"type": "http.response.body", "body": b"Not Found\n"})
        log.info("%s %s", name, scope["method"])         # the client's name, never its path
        await self.app(dict(scope, path="/mcp", raw_path=b"/mcp"), receive, send)


def http_server(writers: bool = False) -> MCPServer:
    """The server HTTP serves: the tools that read, or with `writers` all."""
    return server if writers else server_read_only


def http_app(path: pathlib.Path | None = None, writers: bool = False):
    """The server as an ASGI app behind the gate. Stateless, so a restart
    loses no session. The SDK's Host check is off: it guards a local server
    against a browser, and here no request arrives without the token."""
    from mcp.server.transport_security import TransportSecuritySettings
    inner = http_server(writers).streamable_http_app(
        stateless_http=True,
        transport_security=TransportSecuritySettings(enable_dns_rebinding_protection=False))
    return SecretPath(inner, path or tokens_file())


def serve_http(host: str, port: int, writers: bool = False):
    import uvicorn
    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(name)s %(message)s", force=True)
    logging.getLogger("mcp").setLevel(logging.WARNING)   # else one line per request about a session that is not kept
    path = tokens_file()
    if not read_tokens(path):
        log.warning("no tokens in %s: every request is a 404 until `ttc-mcp --new-token NAME`", path)
    if writers:
        log.warning("serving the tools that write (%s): a save by any client changes every client's answers",
                    ", ".join(sorted(WRITERS)))
    uvicorn.run(http_app(path, writers), host=host, port=port, access_log=False)   # the access log would print the token


def main(argv=None):
    p = argparse.ArgumentParser(prog="ttc-mcp", description="The checker as an MCP server: over stdio, "
                                "or over HTTP behind a secret URL.")
    p.add_argument("--http", action="store_true", help="serve Streamable HTTP at /<token>/mcp instead of stdio")
    p.add_argument("--host", default="127.0.0.1", help="address to bind with --http (default %(default)s)")
    p.add_argument("--port", type=int, default=8765, help="port to bind with --http (default %(default)s)")
    p.add_argument("--writers", action="store_true", help="with --http, also serve the tools that write to the "
                   "personal layer (off by default: one layer is shared by every client)")
    p.add_argument("--new-token", metavar="NAME", help="mint a token for one client, print its URL once "
                   "(after $TTC_MCP_URL, if set), and exit")
    a = p.parse_args(argv)
    if a.new_token:
        try:
            print(f"{os.environ.get('TTC_MCP_URL', '').rstrip('/')}/{new_token(a.new_token)}/mcp")
        except ValueError as exc:
            p.error(str(exc))
    elif a.http:
        serve_http(a.host, a.port, a.writers)
    else:
        server.run()


if __name__ == "__main__":
    main()
