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
