"""The regression suite, as pytest cases, plus guards on the engine itself."""
import pathlib

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
