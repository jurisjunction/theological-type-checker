"""What the checker declares about itself, for the tools that read it: the
summary's schema, unknown slots as warnings, refusals as data, key-sorted
results and the grammar resource (TTC-LLM-REQUESTS 2, 5 and 8)."""
import json
import re

import pytest

from theological_type_checker import engine


# ---------- unknown slots (request 2) ----------------------------------------
def test_a_misspelled_slot_is_a_warning():
    r = engine.solve([], "branches", facts="sourse(s,3,truth,2000).")
    assert r["warnings"] == ["unknown_slot(sourse/4)"]


def test_a_wrong_arity_is_an_unknown_slot():
    r = engine.solve([], "branches", facts="source(s,3,truth).")
    assert r["warnings"] == ["unknown_slot(source/3)"]


def test_an_unknown_read_is_a_warning():
    # TTC-L CG (rule 7): the head was info(x), a conclusion, refused at the gate; a premise now
    r = engine.solve([], "branches", facts="source(x,3,truth,2000) :- barr(a).")
    assert r["warnings"] == ["unknown_slot(barr/1)"]


def test_known_slots_and_a_snippets_own_helpers_are_not_warned():
    # TTC-L CG (rule 7): the last head was info(seen(S)), a conclusion; a helper, shown, now
    facts = "source(s,3,truth,2000). aux(S) :- source(S,_,_,_). seen(S) :- aux(S). #show seen/1."
    assert engine.solve([], "branches", facts=facts)["warnings"] == []


def test_rules_added_by_the_fix_method_count_as_known():
    with engine.rule_change(add="newslot_read(X) :- newslot(X). info(n(X)) :- newslot_read(X)."):
        assert engine.solve([], "branches", facts="newslot(a).")["warnings"] == []
    assert engine.solve([], "branches", facts="newslot(a).")["warnings"] == ["unknown_slot(newslot/1)"]


# ---------- the summary's schema (KEEP) ---------------------------------------
def test_the_summary_carries_its_schema_and_warnings():
    s = engine.summary(engine.run_checked([], "sourse(s,3,truth,2000)."))
    assert s["schema"] == engine.SCHEMA
    assert s["warnings"] == ["unknown_slot(sourse/4)"]
    bad = engine.summary(engine.run_checked([], ":- source(_,_,_,_). source(s,3,truth,2000)."))
    assert not bad["satisfiable"] and bad["schema"] == engine.SCHEMA and bad["warnings"] == []


# ---------- refusals as data (request 5) ---------------------------------------
@pytest.mark.parametrize("parts,facts,want", [
    (["no_such_part"], "", {"gate": "parts", "where": "parts", "text": "no_such_part"}),
    ([], 'a(1).\n#include "x.lp".', {"gate": "snippet", "where": "facts", "line": 2, "column": 1}),
    ([], "source(s,3,truth,2000).\nq(X :- p.", {"gate": "parse", "where": "facts", "line": 2, "column": 5,
                                                 "text": "q(X :- p."}),
    # TTC-L CG (rule 7): the unsafe head was info/1, now refused at the gate `conclusion`; a helper's
    ([], "source(s,3,truth,2000).\nseen(q(X)) :- source(s,3,truth,2000).",
     {"gate": "ground", "where": "facts", "line": 2, "predicate": "seen/1"}),
])
def test_a_refusal_says_where(parts, facts, want):
    with pytest.raises(engine.SnippetError) as e:
        engine.solve(parts, "branches", facts=facts)
    d = e.value.as_dict()
    assert {k: d[k] for k in want} == want
    assert d["refused"] is True and d["message"] == str(e.value)
    assert set(d) == set(engine.REFUSAL_FIELDS)


def test_a_removal_that_matches_nothing_is_refused_at_its_gate():
    with pytest.raises(engine.SnippetError) as e:
        with engine.rule_change(remove=["no line reads like this"]):
            pass
    assert e.value.as_dict()["gate"] == "removal"


def test_the_server_refuses_with_the_same_object():
    pytest.importorskip("mcp")
    from mcp.server.mcpserver.exceptions import ToolError
    from theological_type_checker import server
    with pytest.raises(ToolError) as e:
        server.check([], facts="source(s,3,truth,2000).\nq(X :- p.")
    d = json.loads(str(e.value))
    assert (d["gate"], d["line"], d["where"]) == ("parse", 2, "facts")


def test_a_fact_on_the_wrong_side_is_refused_at_the_layer_gate(tmp_path, monkeypatch):
    pytest.importorskip("mcp")
    monkeypatch.setenv("TTC_HOME", str(tmp_path))
    from mcp.server.mcpserver.exceptions import ToolError
    from theological_type_checker import server
    with pytest.raises(ToolError) as e:
        server.save_case("mixed", theology="question(q(m)).\ndecree(d,ddf,20260101).")
    d = json.loads(str(e.value))
    assert (d["gate"], d["where"], d["predicate"], d["line"]) == ("layer", "theology", "decree/3", 2)


@pytest.mark.parametrize("theology,canon,where,pred", [
    ("question(q(m)).\npremise(n1364,q(m),yes).", "", "theology", "premise/3"),     # the pair's: canon
    ("", "% the act\nconciliar_act(s,canon).", "canon", "conciliar_act/2"),         # the authority graph's
    ("", "act_date(a,20260101).\noum_claimant(s,c).", "canon", "oum_claimant/2"),
])
def test_every_slot_keeps_its_side_not_only_the_old_lists(tmp_path, monkeypatch, theology, canon, where, pred):
    # TTC-L LY2: each slot's side is its declaring file's; none of these was
    # on the hand lists, which are gone
    pytest.importorskip("mcp")
    monkeypatch.setenv("TTC_HOME", str(tmp_path))
    from mcp.server.mcpserver.exceptions import ToolError
    from theological_type_checker import server
    assert not hasattr(server, "THEOLOGY_ONLY") and not hasattr(server, "CANON_ONLY")
    with pytest.raises(ToolError) as e:
        server.save_case("sides", theology=theology, canon=canon)
    d = json.loads(str(e.value))
    assert (d["gate"], d["where"], d["predicate"], d["line"]) == ("layer", where, pred, 2)


def test_a_librarys_slot_goes_on_either_side():
    # interior/3 (act.l) and classification/3 (moral.l): the libraries serve both
    pytest.importorskip("mcp")
    from theological_type_checker import server
    for side in ("theology", "canon"):
        server._layer_lint("interior(p,a,deliberate).\nclassification(q(k),kill,grave_matter).", side)


# ---------- stable JSON (KEEP) -------------------------------------------------
def _keys_sorted(o):
    if isinstance(o, dict):
        return list(o) == sorted(o) and all(_keys_sorted(v) for v in o.values())
    if isinstance(o, list):
        return all(_keys_sorted(v) for v in o)
    return True


def test_tool_results_are_key_sorted_on_every_path():
    pytest.importorskip("mcp")
    import pydantic_core
    from theological_type_checker import server
    s = server.check(["sspx", "lattice"], max_branches=3)
    assert _keys_sorted(s)
    # the stdio server writes the same object, indented, in the same order
    assert pydantic_core.to_json(s, indent=2).decode() == json.dumps(s, indent=2, sort_keys=True, ensure_ascii=False)
    assert engine.dumps(s) == json.dumps(json.loads(pydantic_core.to_json(s)), sort_keys=True,
                                         separators=(",", ":"), ensure_ascii=False)
    assert _keys_sorted(server.list_parts("case"))


# ---------- the grammar (request 8) ---------------------------------------------
def test_the_grammar_is_read_off_the_checker():
    pytest.importorskip("mcp")
    from theological_type_checker import server
    g = json.loads(server.grammar_resource())
    assert g["schema"] == engine.SCHEMA
    assert g["slots"]["finding/4"]["tags"] == [{"file": "empirica.lp", "meaning": g["slots"]["finding/4"]["meaning"]}]
    assert g["slots"]["finding/4"]["meaning"].startswith("finding(F, Q, V, Year)")
    # TTC-L SO1 (rule 7): source/4 gained its slot's tag in icon_authority.lp,
    # the file that declares it; the three cross-references follow
    assert [t["file"] for t in g["slots"]["source/4"]["tags"]] == ["icon_authority.lp", "faith.lp", "sources.lp",
                                                                   "empirica.lp"]
    assert g["parts"]["galileo"]["kind"] == "case" and g["parts"]["galileo"]["file"] == "icon_history.lp"
    # TTC-L M5 (rule 7): grammar_schema 2 gives each runtime its parents and
    # combinators beside its parts; the parts are as before
    assert {k: v["parts"] for k, v in g["runtimes"].items()} == {k: list(v) for k, v in engine.RUNTIMES.items()}
    assert {"parts", "facts"} <= set(g["tools"]["check"]["parameters"]["properties"])
    assert set(g["refusal"]["fields"]) == set(engine.REFUSAL_FIELDS)
    assert set(g["slots"]) <= set(g["vocabulary"])
    assert g["vocabulary"]["source/4"]["read"] and g["vocabulary"]["violation/1"]["shown"]
    assert "claim" in g["caveat"]


def test_the_grammar_reads_l():
    # TTC-L M5: slots with their sorts, side, file, meaning and sentence;
    # closed sorts with their values; parts with kind and case; runtimes with
    # parents and combinators; the caveat kept
    pytest.importorskip("mcp")
    from theological_type_checker import server
    g = json.loads(server.grammar_resource())
    # the summary's schema restated (rule 7): 2 since `premises` (CG7)
    assert g["grammar_schema"] == 2 and g["schema"] == 2
    src = g["slots"]["source/4"]
    assert [(a["name"], a["sort"]) for a in src["args"]] == [("S", "source"), ("T", "tier"), ("F", "force"),
                                                             ("Y", "year")]
    assert (src["side"], src["file"], src["layer"]) == ("theology", "icon_authority.lp", "authority")
    assert src["say"] == "{S} is a source at tier {T}, of force {F}, from {Y}"
    assert g["slots"]["interior/3"]["side"] == "either" and "in_force/1" not in g["slots"]
    assert g["sorts"]["tier"]["range"] == [0, 5] and g["sorts"]["force"]["values"] == ["truth", "juridical",
                                                                                         "protective"]
    assert g["sorts"]["source"]["closed"] is False
    assert (g["parts"]["trolley"]["kind"], g["parts"]["trolley"]["of"]) == ("switch", "life_sources")
    assert g["parts"]["act_fear"]["kind"] == "case" and g["parts"]["galileo"]["of"] is None
    assert g["runtimes"]["palamite"]["extends"] == ["default"] and ["exclude", "one_power"] in g["runtimes"][
        "palamite"]["ops"]
    assert "act_fear" in {r["part"] for r in server.list_parts("case")}


def _top_args(s):
    out, depth, cur = [], 0, ""
    for ch in s:
        depth += ch in "(["
        depth -= ch in ")]"
        if ch == "," and depth == 0:
            out.append(cur)
            cur = ""
        else:
            cur += ch
    out.append(cur)
    return [x for x in out if x.strip()]


def test_every_predicate_the_guide_documents_is_in_the_base():
    # Checked against the guide, which a person wrote, not against anything
    # the checker says about itself: a test of the vocabulary by its own
    # function could not fail for the reason that matters.
    guide = (engine.LP_DIR.parent / "guide.md").read_text().split("## WARNINGS AND REFUSALS")[0]
    documented = set()
    for line in guide.splitlines():
        if line.startswith("| ") and not line.startswith("| ---"):
            for m in re.finditer(r"`([a-z_][a-z0-9_]*)(?:\(([^`]*)\)|/(\d+))`", line.split(" | ")[0]):
                name, args, n = m.groups()
                documented.add((name, len(_top_args(args)) if args is not None else int(n)))
    v = engine.vocabulary()
    assert len(documented) > 250
    assert sorted(documented - (v["heads"] | v["reads"] | v["shown"] | v["tagged"])) == []
    assert engine.unknown_slots("not_in_the_base(c).") == ["unknown_slot(not_in_the_base/1)"]


def test_the_version_the_server_reports_is_the_packages():
    import pathlib
    from theological_type_checker import __version__
    pyproject = (pathlib.Path(__file__).resolve().parent.parent / "pyproject.toml").read_text()
    assert __version__ == re.search(r'^version = "([^"]+)"$', pyproject, re.M).group(1)   # no tomllib on 3.10


def test_on_the_wire_a_result_is_key_sorted_and_a_refusal_is_bare_json():
    pytest.importorskip("mcp")
    import anyio
    from theological_type_checker import server
    ok = anyio.run(server.server.call_tool, "check", {"parts": ["sspx", "lattice"], "max_branches": 2})
    text = ok.content[0].text
    assert not ok.is_error and text == json.dumps(json.loads(text), indent=2, sort_keys=True, ensure_ascii=False)
    bad = anyio.run(server.server.call_tool, "check", {"parts": [], "facts": "a.\nq(X :- p."})
    assert bad.is_error
    d = json.loads(bad.content[0].text)
    assert (d["gate"], d["line"], d["column"]) == ("parse", 2, 5)


# ---------- over HTTP: what a far client is told, and the gate ------------------
def test_every_tool_says_whether_it_writes():
    pytest.importorskip("mcp")
    import inspect
    import anyio
    from theological_type_checker import server
    hints = {t.name: t.annotations for t in anyio.run(server.server.list_tools)}
    assert all(None not in (a.read_only_hint, a.destructive_hint, a.open_world_hint) for a in hints.values())
    writers = {n for n, a in hints.items() if not a.read_only_hint}
    assert writers == {"save_rules", "save_case", "save_scenario", "mark_consulted"}
    opens_home = re.compile(r"(?<!\w)_home\(\)")                     # the one way a tool gets a folder to write in
    assert writers == {n for n in hints if opens_home.search(inspect.getsource(getattr(server, n)))}
    assert {n for n, a in hints.items() if a.destructive_hint} == {"save_rules", "save_case"}
    assert {n for n, a in hints.items() if a.open_world_hint} == {"library_fetch_list"}


def test_only_a_minted_path_reaches_the_server(tmp_path):
    pytest.importorskip("mcp")
    import anyio
    from theological_type_checker import server
    tokens = tmp_path / "tokens"
    path = f"/{server.new_token('one', tokens)}/mcp"
    assert path[1:-4] not in tokens.read_text() and oct(tokens.stat().st_mode)[-3:] == "600"   # the hash only
    reached = []

    async def inner(scope, receive, send):
        reached.append(scope["path"])

    gate = server.SecretPath(inner, tokens)

    def status(p):
        sent = []

        async def call():
            async def send(m):
                sent.append(m)
            await gate({"type": "http", "method": "POST", "path": p}, None, send)
        anyio.run(call)
        return sent[0]["status"] if sent else "passed on"

    assert [status(p) for p in ("/", "/mcp", "/" + "A" * 43 + "/mcp", path[:-4] + "/other", path + "/")] == [404] * 5
    assert reached == []
    assert status(path) == "passed on" and reached == ["/mcp"]       # the server never sees the token
    with pytest.raises(ValueError):
        server.new_token("one", tokens)                              # one token per name
    tokens.write_text("")
    assert status(path) == 404                                       # a deleted line is revoked at once


def test_over_http_only_the_tools_that_read_are_served_unless_asked():
    # option 1: one personal layer is shared by every far client
    pytest.importorskip("mcp")
    import anyio
    from theological_type_checker import server
    every = {t.name for t in anyio.run(server.server.list_tools)}
    read_only = {t.name for t in anyio.run(server.server_read_only.list_tools)}
    assert server.WRITERS == {"save_rules", "save_case", "save_scenario", "mark_consulted"}
    assert read_only == every - server.WRITERS
    assert server.http_server() is server.server_read_only and server.http_server(writers=True) is server.server
    assert "save_rules" not in server.server_read_only.instructions and "save_rules" in server.server.instructions
    for listing in ("list_resources", "list_resource_templates", "list_prompts"):
        names = [sorted(str(getattr(x, "uri_template", None) or getattr(x, "uri", None) or x.name)
                        for x in anyio.run(getattr(srv, listing))) for srv in (server.server, server.server_read_only)]
        assert names[0] == names[1] and names[0]
