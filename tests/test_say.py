"""ttc-say(1) and L's `result` and `label` (SY, for results): the checker's
answer said through the base's own templates, with no model between."""
import re

import pytest

from theological_type_checker import engine, lang, report


def _src(text, name="extra.lp"):
    return lang.parse(text, name.replace(".lp", ".l"))


# ---------- L: result and label ----------------------------------------------
def test_a_result_says_each_argument_once():
    for say, why in (('"{L} binds"', "names X never"), ('"{L} binds {X} and {X}"', "names X twice"),
                     ('"{L} binds {Y}"', "names no argument Y")):
        d = _src(f"layer canon\n\nresult bound_x(L: law, X: entity)\n  say {say}\n").decls(lang.Result)[0]
        with pytest.raises(lang.LError, match=why):
            lang.check_say(d)


def test_a_result_must_be_computed_and_is_never_a_slot():
    srcs = lang.sources()
    srcs["extra.lp"] = _src('layer canon\n\nresult nothing_computes_this(L: law)\n  say "{L} is nothing"\n')
    with pytest.raises(lang.LError, match="no rule computes it"):
        lang.validate(srcs)
    srcs = lang.sources()
    srcs["extra.lp"] = _src('layer canon\n\nresult reaches(L: law, R: reading, X: entity)\n  say "{L} {R} {X}"\n')
    with pytest.raises(lang.LError, match="is a slot"):
        lang.results(srcs)


def test_a_result_and_a_label_are_declared_once_and_render_nothing():
    src = _src('layer canon\n\nresult does_not_bind(L: law)\n  say "{L} does not bind"\n\nlabel c135_2 "c. 135 §2"\n')
    assert src.compile() == "\n"                                   # the rule files are unchanged by them
    srcs = lang.sources()
    srcs["extra.lp"] = src
    with pytest.raises(lang.LError, match="declared already"):
        lang.results(srcs)
    with pytest.raises(lang.LError, match="given already"):
        lang.labels(srcs)
    with pytest.raises(lang.LError, match="not a term"):
        _src('layer canon\n\nlabel C135 "x"\n')


def test_wrapped_reads_the_terms_info_violation_and_frontier_carry():
    text = ("info(foo(X,g(Y))) :- a(X,Y).  % info(commented(out))\n"
            "violation(bar) :- b.\nfrontier(canon,baz(L)) :- c(L).\n")
    assert lang.wrapped(text) == {("foo", 2), ("bar", 0), ("baz", 1)}


def test_every_result_of_the_base_is_computed_and_said():
    srcs = lang.sources()
    lang.validate(srcs)                                            # computed, typed, SY
    assert {("does_not_bind", 1), ("narrows_higher_choice", 3), ("invalid_lower_act", 2),
            ("against_higher_provision", 2)} <= set(lang.results(srcs))


# ---------- the renderer ------------------------------------------------------
def test_every_sentence_stands_over_an_atom_the_solver_found():
    text = report.render(["option_narrowed"], version="test")
    r = engine.run_checked(["option_narrowed"])
    found = set(a for m in r["all_models"] for a in m) | set(r["atoms"])
    lines = text.splitlines()
    pairs = [(lines[i - 1].strip(), ln.strip()[2:]) for i, ln in enumerate(lines) if ln.strip().startswith("= ")]
    assert pairs, text
    for sentence, atom in pairs:
        assert atom in found, atom
        assert sentence == report.Sayer().atom(atom)
    assert "l_res does not bind" in text and "= info(does_not_bind(l_res))" in text


def test_the_same_facts_give_the_same_text():
    a = report.render(["ius_superius"], version="test")
    assert a == report.render(["ius_superius"], version="test")
    assert "l_dioc_h does not bind" in a
    assert "person_b is bound by l_dioc_b" in a
    assert re.search(r"FRONTIER.*\n  l_dioc_u has no day of promulgation entered", a)
    assert "no language model wrote it" in a and a.rstrip().endswith(report.FOOT)


def test_a_case_names_itself_its_encoder_and_its_constants():
    facts = ("% @case A narrowing in a neutral place\n% @encoded-by a canonist\n"
             "% @label l_res | the reservation\n% @label book_o | the book\n")
    text = report.render(["option_narrowed"], facts, version="test")
    assert text.splitlines()[0] == "TTC-checker test · A narrowing in a neutral place · parts: option_narrowed"
    assert "Facts encoded by: a canonist." in text
    assert "the reservation narrows a choice the book leaves open, against higher ius (c. 135 §2)" in text
    assert "= info(narrows_higher_choice(l_res,book_o,c135_2))" in text      # the atom keeps its own name


def test_an_atom_with_no_template_is_shown_as_it_is_and_named():
    text = report.render([], "zz_no_template(a).", version="test")
    assert "\n  zz_no_template(a)\n" in text
    assert "UNSAID (no template yet): zz_no_template/1" in text


def test_brief_leaves_the_atoms_out():
    text = report.render(["option_narrowed"], version="test", atoms=False)
    assert "l_res does not bind" in text and "= info(" not in text


def test_the_server_says_it_too():
    pytest.importorskip("mcp")
    from theological_type_checker import server
    assert server.say(["option_narrowed"]).startswith("TTC-checker ")


def test_the_date_the_norms_and_what_is_disputed_are_shown():
    a = report.render(["ius_superius"], version="test")
    assert "As of 2026-10-10: the law is read as it stood that day." in a
    b = report.render(["option_narrowed"], version="test")
    assert "  Redemptionis Sacramentum 21 (2004), with c. 838 §4  [rs2004:21]" in b
    assert re.search(r"and rules under no single norm, in [^:]*law\.lp[^:]*: [^\n]*does_not_bind", b)


def test_what_turns_on_a_disputed_fact_is_said_once_as_a_tree(monkeypatch):
    x, nx = "assumed_fact(excluded_reading(c_a,wide))", "assumed_fact(false(excluded_reading(c_a,wide)))"
    branch = lambda status, A, here: {"status": status, "values": ["q(m)=v"], "cleaved_by": [], "assumptions": [A],
                                      "only_here": here}
    s = {"satisfiable": True, "truncated": False, "questions": {}, "in_every_branch": [], "branches_total": 3,
         "branches": [branch("main", x, ["info(does_not_bind(l_a))"]), branch("main", nx, []),
                      branch("live_shadow", x, ["info(does_not_bind(l_a))"])]}
    monkeypatch.setattr(engine, "solve", lambda *a, **k: {"all_models": [["eval_date(20200101)"]], "atoms": []})
    monkeypatch.setattr(engine, "summary", lambda r: s)
    text = report.render([], version="test", atoms=False)
    tree = text[text.index("DISPUTED"):text.index("BRANCHES")]
    assert "├─ if the reading wide of c_a is excluded:\n  │  l_a does not bind\n" in tree
    assert "└─ if it is not so that the reading wide of c_a is excluded:\n     (nothing beyond every branch)" in tree
    assert tree.count("l_a does not bind") == 1                    # said once, under its assumption
    assert "only if the reading wide of c_a is excluded" in text   # the shadow stands on one side only
