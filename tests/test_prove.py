"""The prover (TTC-REPAIRS6 PV; ttc-say(1), PROOFS): why an atom holds, or
why a value is excluded, read back from one model."""
import pytest

from theological_type_checker import engine, prove, report


def _shown_models(parts, facts=""):
    return sorted(sorted(m) for m in engine.solve(parts, "all", facts=facts, max_models=20000)["all_models"])


def _twin_models(parts, facts=""):
    _, ctl = prove._ground(list(parts), facts)
    out = []
    ctl.solve(on_model=lambda m: out.append(sorted(str(s) for s in m.symbols(shown=True))))
    return sorted(out)


def test_the_deletion_of_1854_rests_on_its_warrant():
    """PV1, as it holds: the proof passes through warranted/1 (the five
    conditions sit behind a negated literal, a leaf: see the scoring)."""
    (heading, where, steps), = prove.prove(["ic", "asof_1860"], excluded=["q(ic)=no"])
    assert heading == "WHY q(ic)=no IS EXCLUDED" and where.startswith("icon_authority.lp:")
    atoms = [a for _, a, _ in steps]
    assert "shown_tier(ineffabilis_1854,1)" in atoms and "warranted(ineffabilis_1854)" in atoms
    assert "not ec_unmet(ineffabilis_1854)" in atoms


def test_without_its_conditions_nothing_removes_no():
    with engine.rule_change(remove=["condition_shown(ineffabilis_1854,"]):
        (_, where, steps), = prove.prove(["ic", "asof_1860"], excluded=["q(ic)=no"])
    assert where is None and "no integrity constraint" in steps[0][2]


@pytest.mark.parametrize("parts", [["ic", "asof_1860"], ["art6_case"], ["jansenism", "jansen_fact", "ad_sanctam_defined"],
                                   ["tier2", "cand_uw_fixing"]])
def test_the_twins_change_no_result(parts):
    """PV2, on a sample; the whole suite is compared in the scoring."""
    assert _twin_models(parts) == _shown_models(parts)


def test_a_proof_is_the_same_twice():
    """PV3."""
    a = report.render_why(["art6_case"], why=["info(delict(cl_b,n1398_1,act_b))"], version="X")
    assert a == report.render_why(["art6_case"], why=["info(delict(cl_b,n1398_1,act_b))"], version="X")


def test_a_step_names_its_norm_and_is_said_through_its_template():
    """PV4: a canon step carries its citation; an entered fact is said."""
    text = report.render_why(["art6_case"], why=["info(delict(cl_b,n1398_1,act_b))"], version="X")
    assert "(c. 1398 §1 n. 1 [cic2021:1398])" in text and "(c. 7 [cic:7])" in text
    assert "cl_b is a priest   [entered: canon_cases.lp:" in text
    assert "    = priest(cl_b)" in text and "    = priest(cl_b)" not in report.render_why(
        ["art6_case"], why=["info(delict(cl_b,n1398_1,act_b))"], atoms=False, version="X")


def test_an_atom_in_no_model_is_said_so():
    (_, _, steps), = prove.prove(["ic", "asof_1860"], atoms=["holds(q(ic),no)"])
    assert steps == [(0, "holds(q(ic),no)", "in no model")]


def test_the_server_proves_it_too():
    pytest.importorskip("mcp")
    from theological_type_checker import server
    text = server.why(["ic", "asof_1860"], excluded=["q(ic)=no"], brief=True)
    assert "WHY q(ic)=no IS EXCLUDED" in text and "warranted(ineffabilis_1854)" in text
