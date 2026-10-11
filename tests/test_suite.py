"""The regression suite, as pytest cases, plus guards on the engine itself."""
import json
import os
import pathlib

os.environ["TTC_HOME"] = ""        # the public suite never sees a personal layer

import pytest

from theological_type_checker import engine, suite

ROOT = pathlib.Path(__file__).resolve().parents[1]


@pytest.mark.parametrize("scenario", suite.S, ids=[s["id"] for s in suite.S])
def test_scenario(scenario):
    r = engine.solve(scenario["parts"], scenario["mode"])
    results = [check(r) for check in scenario["checks"]]
    assert all(ok for ok, _ in results), f"expected: {scenario['expected']} | got: " + " | ".join(d for _, d in results)


def test_deterministic():
    a = engine.solve(["sspx", "lattice"], "branches")["all_models"]
    b = engine.solve(["sspx", "lattice"], "branches")["all_models"]
    assert sorted(a) == sorted(b)


@pytest.mark.parametrize("snippet", ['#script (python)\nimport os\n#end.', '#include "x.lp".', 'p(@f(1)).', '#program x.'])
def test_snippets_are_data_only(snippet):
    with pytest.raises(engine.SnippetError):
        engine.solve([], "branches", facts=snippet)


def test_unknown_part_rejected():
    with pytest.raises(engine.SnippetError):
        engine.solve(["no_such_part"], "branches")


def test_rule_change_is_scoped():
    with engine.rule_change(add="a9_universal."):
        assert not all(c(engine.solve(s["parts"], s["mode"]))[0] for s in suite.S if s["id"] == "L2" for c in s["checks"])
    s = next(x for x in suite.S if x["id"] == "L2")
    assert all(c(engine.solve(s["parts"], s["mode"]))[0] for c in s["checks"])


def test_guide_copy_in_docs_matches_package():
    pkg = (ROOT / "src" / "theological_type_checker" / "guide.md").read_text()
    doc = (ROOT / "docs" / "encoding-guide.md").read_text()
    assert doc.split("\n", 2)[2] == pkg, "docs/encoding-guide.md is out of date: copy src/theological_type_checker/guide.md"


def test_norm_graph_is_clean():
    from theological_type_checker import norms
    c = norms.check()
    assert not c["vicious_cycles"] and not c["undefined_predicates"], c


def test_flywheel_saves_only_what_passes(tmp_path, monkeypatch):
    pytest.importorskip("mcp")
    monkeypatch.setenv("TTC_HOME", str(tmp_path))
    from theological_type_checker import server
    server._BASELINE.clear()
    r = server.save_case("demo_case", "question(q(d)). question_kind(q(d),doctrinal). value(q(d),yes). value(q(d),no).\n"
                                      "source(enc,3,truth,1990). supports(enc,q(d),yes).", note="synthetic")
    assert (tmp_path / "rules" / "case_demo_case.lp").exists()
    bad = server.save_scenario("P1", "wrong", ["demo_case"], [{"kind": "status", "of": "q(d)=no", "is": "settled"}])
    assert bad["saved"] is False
    good = server.save_scenario("P1", "right", ["demo_case"], [{"kind": "status", "of": "q(d)=yes", "is": "settled"}])
    assert good["saved"] is True
    assert json.loads((tmp_path / "scenarios.json").read_text())[0]["id"] == "P1"
    breaking = server.save_rules("breaker", "a9_universal.")
    assert breaking["saved"] is False and breaking["newly_failing"]
    assert not (tmp_path / "rules" / "breaker.lp").exists()
    forced = server.save_rules("breaker", "a9_universal.", force=True)
    assert forced["saved"] is False and "reason for each red test" in forced["reason"]
    assert forced["newly_failing"][0]["definition"]["source"].startswith("scen(")
    why = {f["id"]: "agreed: the universal reading is the one under test" for f in forced["newly_failing"]}
    accepted = server.save_rules("breaker", "a9_universal.", force=True, reasons=why)
    assert accepted["saved"] is True
    assert "% red test accepted:" in (tmp_path / "rules" / "breaker.lp").read_text()


def test_read_test_shows_the_checks():
    pytest.importorskip("mcp")
    from theological_type_checker import server
    d = server._definition("TH8")
    assert d["parts"] == ["family", "th22", "bridges_as_order_of_knowing"]
    assert any(h.startswith("def every_bridge_projected") for h in d["checks_defined_as"])


def test_a_new_bridge_leaves_th8_green():
    """TH8 counted five projections; any new bridge turned it red. It now counts against the bridges."""
    with engine.rule_change(add="bridge(authority,div,cr). mode(authority,div,source). mode(authority,cr,derived)."):
        rows = suite.run(["TH8"])
    assert rows[0]["ok"], rows[0]["got"]


def _fake_http(method, url, headers=None, data=None, timeout=20):
    if url.startswith("https://oauth.oclc.org/token"):
        return 200, json.dumps({"access_token": "T"}).encode()
    if url.startswith("https://openlibrary.org/search.json"):
        oclc = ["123"] if "Scotus" in url else []
        return 200, json.dumps({"docs": [{"key": "/works/OL1W", "oclc": oclc, "isbn": []}]}).encode()
    if "/bibs-holdings" in url:
        return 200, json.dumps({"briefRecords": [{"institutionHolding": {"briefHoldings": [
            {"institutionName": "Far Library", "oclcSymbol": "FAR", "address": {"city": "Florence", "lat": 43.77, "lon": 11.25}},
            {"institutionName": "Near Library", "oclcSymbol": "NEA", "address": {"city": "Rome", "lat": 41.904, "lon": 12.454}}]}}]}).encode()
    return 200, json.dumps({"bibRecords": []}).encode()


def test_fetch_list_without_credentials(monkeypatch):
    from theological_type_checker import library
    monkeypatch.delenv("OCLC_CLIENT_ID", raising=False)
    rep = library.build(["ic"], near="41.90,12.45", include_reading=False, get=lambda *a, **k: (0, b"offline"))
    md = library.to_markdown(rep)
    assert "Not yet placed" in md and "search.worldcat.org" in md and "verify scotus" in md
    assert "Comentario" not in md
    full = library.to_markdown(library.build(["ic"], include_reading=True, get=lambda *a, **k: (0, b"offline")))
    assert "Comentario exegético" in full and "read: Bañares" in full


def test_fetch_list_nearest_first(monkeypatch):
    from theological_type_checker import library
    monkeypatch.setenv("OCLC_CLIENT_ID", "id")
    monkeypatch.setenv("OCLC_CLIENT_SECRET", "secret")
    rep = library.build(["ic"], near="41.9029,12.4534", include_reading=False, get=_fake_http)
    scotus = next(w for w in rep["works"] if w.id == "scotus_vat")
    assert [h["name"] for h in scotus.holdings] == ["Near Library", "Far Library"]
    assert scotus.holdings[0]["km"] < 1 < scotus.holdings[1]["km"]
    assert library.to_markdown(rep).index("Near Library") < library.to_markdown(rep).index("Not yet placed")


def test_consulted_sources_leave_the_list(tmp_path, monkeypatch):
    pytest.importorskip("mcp")
    monkeypatch.setenv("TTC_HOME", str(tmp_path))
    from theological_type_checker import library, server
    assert any(w.id == "scotus_vat" for w in library.wanted(["ic"], include_reading=False))
    server.mark_consulted("scotus", "Vatican ed. vol. IX, checked")
    assert not any(w.id == "scotus_vat" for w in library.wanted(["ic"], include_reading=False))


def test_case_sides_are_kept_apart(tmp_path, monkeypatch):
    pytest.importorskip("mcp")
    monkeypatch.setenv("TTC_HOME", str(tmp_path))
    from theological_type_checker import server
    with pytest.raises(Exception):
        server.save_case("mixed", theology="decree(d,ddf,20260101).")
    with pytest.raises(Exception):
        server.save_case("mixed", canon="source(s,3,truth,2000).")


def test_theology_frontier_reports_what_is_missing():
    facts = ("source(x,3,truth,2000). character(x,letter). cites(x,y). question(q(z)). value(q(z),a). value(q(z),b). "
             "source(w,3,truth,2001). ambiguous(w).")
    atoms = set(engine.solve([], "one", facts=facts)["atoms"])
    assert "frontier(theology,cited_not_encoded(y,x))" in atoms
    assert "frontier(theology,question_without_sources(q(z)))" in atoms
    assert "frontier(theology,ambiguous_without_readings(w))" in atoms
    assert "frontier(theology,teaching_without_character(w))" in atoms


# The Filioque against the rest of the theory. Under monopatrism exactly these
# scenarios change, all of them about the processions or their images; every
# creaturely, canonical and authority result is identical.
FILIOQUE_DEPENDENT = {
    "M1", "M5", "AN1", "AN6", "S4",      # the Spirit's principle; the Son's two positions
    "X1",                                # one fewer instance of the prohibited ranking
    "S3", "AN3", "UN2",                  # the costs of one license, shown in God
    "T6c", "AN9", "AN10", "AN11",        # the images
}


def _outcome(s, extra=()):
    r = engine.solve(s["parts"] + list(extra), s["mode"])
    return sorted(tuple(m) for m in r["all_models"]) if s["mode"] in ("all", "branches") else r["atoms"]


def test_monopatrism_changes_only_the_processions():
    # RT excluded: its scenarios load whole runtimes; switching monopatrism under one tests nothing here
    changed = {s["id"] for s in suite.S if s["group"] not in (suite.FQ, suite.TH, suite.KG, suite.RT)
               and _outcome(s) != _outcome(s, ["monopatrism"])}
    assert changed == FILIOQUE_DEPENDENT


# The Thomistic stack (defined attributes, the 24 Theses, Thomas's readings)
# against everything else. Pre-registered prediction M3 was that only scenarios
# carrying another school's switch would change; AN4 falsified it.
THOMIST_STACK_CHANGES = {
    "UN1", "UN2",                                   # univocity of mode refused (Th. 4)
    "FQ1", "FQ3", "FQ7", "FQ8", "FQ19",             # monopatrism: Thomist simplicity decides it
    "FQ12", "FQ13", "FQ15",                         # Palamas's mind refused (Th. 21 as Thomas reads it)
    "AN4",                                          # deny by default: the persons undistinguished
}


def test_thomist_stack_changes_exactly_these():
    # RT excluded: the Thomist runtime is this stack; adding it to other runtimes is the pair test (test_schools.py)
    changed = {s["id"] for s in suite.S if s["group"] not in (suite.TH, suite.KG, suite.RT)
               and _outcome(s) != _outcome(s, suite.THOMIST)}
    assert changed == THOMIST_STACK_CHANGES


# Layering: the kernel names nothing of the Grammar of the Icon. Dependencies
# point downward: the theory may use the kernel, never the reverse (docs/layers.md).
THEORY_PREDICATES = {
    "nupt", "called_bridal", "needs_welcome", "vicarious_ok", "welcomed", "valid_bond", "bond",
    "counter_phase", "closed", "circuit", "closure_mode", "license_policy", "gen_policy", "lone",
    "consent", "held_for", "proposed_bond", "capable_closing", "closed_in_act", "total",
    "side_by_side", "intense", "bridegroom", "performs", "claimed_counter_phase", "self_gift_measure",
    "level", "band", "obligate_sexual", "of_kind", "impeded", "uses", "nonact_reception", "a9_universal",
}
KERNEL_FILES = ("kernel_core.lp", "kernel_analogy.lp", "kernel_world.lp")


@pytest.mark.parametrize("name", KERNEL_FILES)
def test_kernel_names_nothing_of_the_theory(name):
    import re
    code = re.sub(r"%.*", "", (engine.LP_DIR / name).read_text())
    used = {w for w in re.findall(r"\b([a-z]\w*)\b", code)} & THEORY_PREDICATES
    assert not used, f"{name} names the theory's predicates: {sorted(used)}"


# The kernel fills no school's slot (TTC-SCHOOLS M2): no rule in the kernel files
# derives a slot a runtime fills, and with no runtime nothing fills one.
SCHOOL_SLOTS = {"acts", "one_power", "divine_contraction", "distinction", "esse_not_really_distinct",
                "univocal_concept", "holds_reading", "monopatrism", "no_divine_contraction"}


@pytest.mark.parametrize("name", KERNEL_FILES)
def test_kernel_derives_no_school_slot(name):
    import re
    code = re.sub(r"%.*", "", (engine.LP_DIR / name).read_text())
    heads = [st.split(":-")[0] for st in re.split(r"\.\s", code) if st.strip() and not st.strip().startswith("#")]
    filled = {p for h in heads for p in re.findall(r"\b([a-z]\w*)\b(?=\s*\(|\s*$)", h.strip())} & SCHOOL_SLOTS
    assert not filled, f"{name} derives school slots: {sorted(filled)}"


def test_bare_runs_no_school():
    r = engine.solve(["world", "trinity", "rt_bare"], "one",
                     show=("acts/1", "one_power/2", "divine_contraction/1", "distinction/1"))
    hits = [a for a in r["atoms"] if a.split("(")[0] in {"acts", "one_power", "divine_contraction", "distinction"}]
    assert not hits, hits


def test_default_runtime_is_the_relocated_statements():
    assert engine.RUNTIMES["default"] == ["classical", "one_power"]
    assert engine.expand_runtimes(["trinity"]) == ["classical", "one_power", "trinity"]
    assert engine.expand_runtimes(["trinity", "rt_bare"]) == ["trinity"]


# Non-diagnosis (house rule 3; TTC-ACT L2): the agent's interior is input.
# interior/3 is derived by one rule only, the choice that computes a disputed
# claim both ways; everywhere else it appears as a case's fact or in a body.
def test_interior_is_never_derived():
    import re
    derived = []
    for f in sorted(engine.LP_DIR.glob("*.lp")):
        code = re.sub(r"%.*", "", f.read_text())
        for st in re.split(r"(?<=\.)\s", code):
            st = " ".join(st.split())
            if ":-" in st and re.match(r"\{?\s*interior\s*\(", st.split(":-")[0].strip()):
                derived.append((f.name, st))
    assert derived == [("act.lp", "{ interior(P,A,X) } :- disputed(interior(P,A,X)).")], derived


# Equity is input (c. 19; TTC-LAW G5): equity_rule/2 is derived by one rule only,
# the choice that computes a disputed rule both ways.
def test_equity_is_never_computed():
    import re
    derived = []
    for f in sorted(engine.LP_DIR.glob("*.lp")):
        code = re.sub(r"%.*", "", f.read_text())
        for st in re.split(r"(?<=\.)\s", code):
            st = " ".join(st.split())
            if ":-" in st and re.match(r"\{?\s*equity_rule\s*\(", st.split(":-")[0].strip()):
                derived.append((f.name, st))
    assert derived == [("canon_law.lp", "{ equity_rule(M,R) } :- disputed(equity_rule(M,R)).")], derived
