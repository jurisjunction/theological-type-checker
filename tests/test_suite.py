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
    # CR excluded: the creed loads the Trinity, and monopatrism changes its processions by design (TTC-CREED)
    # CX excluded for the same reason: the christ group loads the creed (TTC-CHRIST)
    # SAE excluded for the same reason: its order and measure cases load the creed (TTC-SAECULUM, stated in its scoring)
    changed = {s["id"] for s in suite.S if s["group"] not in (suite.FQ, suite.TH, suite.KG, suite.RT, suite.CR, suite.MR, suite.CX, suite.SAE)
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
    # CR excluded: its scenarios name their runtimes, the Thomist among them (TTC-CREED CR5)
    changed = {s["id"] for s in suite.S if s["group"] not in (suite.TH, suite.KG, suite.RT, suite.CR, suite.MR)
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
                "univocal_concept", "holds_reading", "monopatrism", "no_divine_contraction",
                "operates", "not_by_propagation", "preserved_from_os"}     # TTC-CREED: CR6, EC1


@pytest.mark.parametrize("name", KERNEL_FILES)
def test_kernel_derives_no_school_slot(name):
    import re
    code = re.sub(r"%.*", "", (engine.LP_DIR / name).read_text())
    heads = [st.split(":-")[0] for st in re.split(r"\.\s", code) if st.strip() and not st.strip().startswith("#")]
    filled = {p for h in heads for p in re.findall(r"\b([a-z]\w*)\b(?=\s*\(|\s*$)", h.strip())} & SCHOOL_SLOTS
    assert not filled, f"{name} derives school slots: {sorted(filled)}"


def test_bare_runs_no_school():
    r = engine.solve(["world", "trinity", "creed", "rt_bare"], "one",
                     show=("acts/1", "one_power/2", "divine_contraction/1", "distinction/1", "operates/2"))
    hits = [a for a in r["atoms"] if a.split("(")[0] in {"acts", "one_power", "divine_contraction", "distinction",
                                                           "operates"}]
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


# TTC-MORAL MO1: every rule that speaks of a person's sin, grace or reception rests
# on a claim (interior/3, or act.lp's due_defence, or another such predicate);
# none is derived from outward facts alone.
PERSON_STATE = {"full_knowledge", "deliberate_consent", "mortal_on_the_claims", "evil_unintended",
                "proportionate", "double_effect", "in_grace", "not_to_receive",
                "sin_on_the_claims", "fruit_on_the_claims",     # TTC-CHRIST; reborn_on_the_deposit is the deposit's (SA9)
                "formal_heresy_on_the_claims", "faith_in_no_article_on_the_claims",          # TTC-COMMUNION FD3
                "fully_incorporated_on_the_claims", "in_body_not_in_heart_on_the_claims"}    # FC3
CLAIMS = {"interior", "due_defence"} | PERSON_STATE


def test_person_state_rests_on_claims():
    import re
    bad = []
    for name in ("moral.lp", "grace.lp", "christ.lp", "sacrament.lp", "faith.lp", "canon_law.lp"):
        code = re.sub(r"%.*", "", (engine.LP_DIR / name).read_text())
        for st in re.split(r"(?<=\.)\s", code):
            st = " ".join(st.split())
            if ":-" not in st:
                continue
            head, body = st.split(":-", 1)
            hp = re.match(r"\s*(\w+)\s*\(", head)
            if hp and hp.group(1) in PERSON_STATE:
                used = set(re.findall(r"(?<!not )\b(\w+)\s*\(", body))
                if not used & CLAIMS:
                    bad.append((name, st))
    assert not bad, bad


# Proportion in double effect is weighed by the agent, never by the checker
# (TTC-MORAL MO2): proportionate/2 is derived only from a claim.
def test_proportion_is_never_computed():
    import re
    derived = []
    for f in sorted(engine.LP_DIR.glob("*.lp")):
        code = re.sub(r"%.*", "", f.read_text())
        for st in re.split(r"(?<=\.)\s", code):
            st = " ".join(st.split())
            if ":-" in st and re.match(r"proportionate\s*\(", st.split(":-")[0].strip()):
                derived.append((f.name, st))
    assert derived == [("moral.lp", "proportionate(P,A) :- interior(P,A,proportionate_reason)."),
                       ("moral.lp", "proportionate(P,A) :- due_defence(P,A).")], derived


def _heads(pred):
    """every statement in the rule base whose head is pred, with its file"""
    import re
    out = []
    for f in sorted(engine.LP_DIR.glob("*.lp")):
        code = re.sub(r"%.*", "", f.read_text())
        for st in re.split(r"(?<=\.)\s", code):
            st = " ".join(st.split())
            head = st.split(":-")[0].strip()
            if re.match(r"\{?\s*" + pred + r"\s*\(", head):
                out.append((f.name, st))
    return out


# TTC-PRECEPT SD3: the conditions of a just war, and of the death penalty, belong
# to the prudential judgment of those responsible (CCC 2309). prudential/2 is
# supplied by a case, never derived; the comparison of evils is never computed.
def test_prudence_is_never_computed():
    assert not [st for _, st in _heads("prudential") if ":-" in st]
    assert [st for _, st in _heads("condition_met")] == ["condition_met(A,C) :- prudential(A,C), not denied(C)."]


# TTC-PRECEPT DI2: the kind of a direct killing is composed from the effect and
# the reading, never typed by hand: no case gives an act a direct(...) kind.
def test_direct_kinds_are_composed():
    import re
    typed = [(f, st) for f, st in _heads("kind_of_act") if re.match(r"kind_of_act\s*\(\s*\w+\s*,\s*direct\s*\(", st)]
    assert typed == [("moral.lp", "kind_of_act(A,direct(K)) :- direct(A,E), evil_kind_of(E,K).")], typed


# TTC-MORAL GR5: no library rule makes a runtime that holds a protected reading
# (de auxiliis, Paul V 1607) incoherent.
@pytest.mark.parametrize("rt", ["rt_thomist", "rt_suarezian"])
def test_no_library_rule_condemns_a_protected_reading(rt):
    r = engine.solve(["grace_cases", "jansenism", "trent_formal_cause", "auxiliis", rt], "branches")
    v = sorted({f for m in r["all_models"] for f in m if f.startswith("violation(")})
    assert r["sat"] and not v, v


# One shape of presumption (TTC-CHRIST SA3): presumed/1 is derived by act.lp's
# one rule; the canons and libraries only say what raises and what rebuts.
def test_one_presumption():
    import re
    derived, raised = [], set()
    for f in sorted(engine.LP_DIR.glob("*.lp")):
        code = re.sub(r"%.*", "", f.read_text())
        for st in re.split(r"(?<=\.)\s", code):
            st = " ".join(st.split())
            if ":-" not in st:
                continue
            head = st.split(":-")[0].strip()
            if re.match(r"presumed\s*\(", head):
                derived.append((f.name, st))
            m = re.match(r"raises\s*\(\s*(\w+)\s*\(", head)
            if m:
                raised.add((f.name, m.group(1)))
    assert derived == [("act.lp", "presumed(X) :- raises(X), not rebutted(X).")], derived
    assert raised == {("canon_law.lp", "imputability"), ("sacrament.lp", "intention")}, raised


# Presence is typed by mode (TTC-CHRIST PM1): outside the candidates, no rule
# compares two presences unless both are of one named mode.
def test_presences_of_different_modes_are_never_compared():
    import re
    bad = []
    for f in sorted(engine.LP_DIR.glob("*.lp")):
        part = "base"
        for chunk in re.split(r"(?m)^(#program\s+\w+\s*\.)", re.sub(r"%.*", "", f.read_text())):
            m = re.match(r"#program\s+(\w+)", chunk)
            if m:
                part = m.group(1)
                continue
            if part.startswith("cand_"):
                continue
            for st in re.split(r"(?<=\.)\s", chunk):
                if ":-" not in st:
                    continue
                modes = re.findall(r"present\s*\([^,()]+,[^,()]+,\s*(\w+)\s*\)", st.split(":-", 1)[1])
                if len(modes) > 1 and (len(set(modes)) > 1 or not modes[0][0].islower()):
                    bad.append((f.name, part, " ".join(st.split())))
    assert not bad, bad


# The Catechism coverage index (docs/coverage.md): an ordered outline, scenarios
# that exist, and a document regenerated from the code.
def test_coverage_outline_is_ordered():
    from theological_type_checker import coverage
    last = 0
    for key, _title, lo, hi in coverage.OUTLINE:
        assert last < lo <= hi <= 2865, key
        last = hi
    assert set(coverage.COVER) <= {k for k, *_ in coverage.OUTLINE}


def test_coverage_names_only_existing_scenarios():
    from theological_type_checker import coverage
    ids = {s["id"] for s in suite.S}
    missing = sorted({x for _st, scen, _n in coverage.COVER.values() for x in scen} - ids)
    assert not missing, missing
    assert all(st in ("rules", "case") and scen for st, scen, _n in coverage.COVER.values())


def test_coverage_doc_is_current():
    from theological_type_checker import coverage
    assert coverage.DOC.read_text() == coverage.report(), "run: python -m theological_type_checker.coverage --write"


# TTC-COMMUNION FD3, CN2: pertinacity (c. 751's obstinacy) is a claim. No rule
# derives interior(_,_,pertinacious); both layers read the one claim.
def test_pertinacity_is_one_claim():
    import re
    readers = sorted({f for f, st in _heads_and_bodies() if "interior(P,E,pertinacious)" in st})
    assert readers == ["canon_law.lp", "faith.lp"], readers


def _heads_and_bodies():
    import re
    out = []
    for f in sorted(engine.LP_DIR.glob("*.lp")):
        code = re.sub(r"%.*", "", f.read_text())
        for st in re.split(r"(?<=\.)\s", code):
            out.append((f.name, " ".join(st.split())))
    return out


# TTC-COMMUNION TC2 (rule 14): no rule raises a source's own tier; a claimed
# consensus is a source of its own. eff_tier/2 is derived only from source/4
# and promoted/3.
def test_no_claim_raises_its_document():
    derived = [st for f, st in _heads("eff_tier")]
    assert derived == ["eff_tier(S,T) :- promoted(S,T,Y), asof(A), Y <= A.",
                       "eff_tier(S,T) :- source(S,T,_,_), not promoted_now(S)."], derived


# TTC-COMMUNION NT1: the note is the shadow, read off, in every scenario.
@pytest.mark.skipif(not os.environ.get("TTC_SLOW"), reason="slow: set TTC_SLOW=1")
def test_notes_agree_with_shadows():
    from theological_type_checker import notes_check
    bad = {s["id"]: b for s in suite.S if not s.get("facts") for b in [notes_check.check(list(s["parts"]))] if b}
    assert not bad, bad


# NT1's finding: a value fixed by a default has no note, and its contrary is
# not main: a case's stipulation is not teaching. Pinned on the moral cases.
def test_a_default_is_not_a_note():
    from theological_type_checker import notes_check
    assert notes_check.check(["moral_cases"]) == []
    assert ("default", "q(k_grave)", "yes") in notes_check.check(["moral_cases"], with_defaults=True)


# TTC-PENAL FO3 (rule 3): assent is interior. assents/2 is derived only by a
# candidate written to be refused; the base reads what is owed, never whether given.
def test_assent_is_never_computed():
    import re
    derived = []
    for f in sorted(engine.LP_DIR.glob("*.lp")):
        part = None
        for st in re.split(r"(?<=\.)\s", re.sub(r"%.*", "", f.read_text())):
            st = " ".join(st.split())
            m = re.match(r"#program\s+(\w+)\.", st)
            if m:
                part = m.group(1)
                st = st[m.end():].strip()
            if ":-" in st and re.match(r"assents\s*\(", st.split(":-")[0].strip()):
                derived.append((f.name, part))
    assert derived == [("icon_history.lp", "cand_silence_as_assent")], derived


# TTC-PENAL GP1: c. 1399's two judgments (special gravity, the need to repair
# scandal) belong to the competent authority: supplied, never derived.
def test_c1399_judgments_are_supplied():
    derived = [(f, st) for f, st in _heads_and_bodies()
               if ":-" in st and st.split(":-")[0].strip().startswith(("special_gravity(", "scandal_necessity("))]
    assert derived == [], derived


# TTC-PENAL AB8: an authentic interpretation in the form of law binds an act
# only where it reaches it (its force, c. 8 §1; or declaratory, c. 16 §2).
def test_interpretation_reaches_by_date():
    rules = [st for f, st in _heads_and_bodies() if st.startswith("reading_binds(N,R,E)") and "interpretation_form(A,law)" in st]
    assert rules and all("reaches_act(A,E)" in st for st in rules), rules


# TTC-PENAL, not predicted: two scenarios once shared an id (SA1, SA2), and one
# hid the other in every keyed report. Ids are unique.
def test_scenario_ids_are_unique():
    from collections import Counter
    dup = [k for k, n in Counter(s["id"] for s in suite.S).items() if n > 1]
    assert not dup, dup


# TTC-SAECULUM CT1-CT4: the force of a law is computed from its issue (c. 8
# §1), never typed; the calendar's counts and ages under c. 203.
import re
from theological_type_checker.engine import solve


def test_force_is_computed_not_typed():
    texts = engine.base_texts()
    assert not any("vacatio_until" in txt for txt in texts.values())
    code = "\n".join(line.split("%")[0] for f in ("canon_law.lp", "canon_cases.lp") for line in texts[f].splitlines())
    laws = set(re.findall(r"\bpromulgated\(([a-z]\w*),", code))
    dated = set(re.findall(r"\b(?:vacatio_set|aas_issue|aas_volume)\(([a-z]\w*),", code))
    assert laws <= dated, laws - dated


def _force(facts):
    return set(solve([], "one", facts=facts, show=("in_force_from/2",))["atoms"])


def test_calendar_counts():
    got = _force("aas_issue(c1,18991129). aas_issue(c2,19991129). aas_issue(c3,20231031). aas_issue(c4,20231115). "
                 "aas_issue(c5,20230531).")
    assert {"in_force_from(c1,19000301)", "in_force_from(c2,20000229)", "in_force_from(c3,20240131)",
            "in_force_from(c4,20240215)", "in_force_from(c5,20230831)"} <= got, got


def test_completed_years():
    atoms = set(solve([], "one", facts="born(p,20080229). act_date(a1,20240229). act_date(a2,20240301). "
                      "act_date(a3,20250228). act_date(a4,20250301). act_date(a5,20071231).",
                      show=("age_at/3",))["atoms"])
    want = {"age_at(p,a1,15)", "age_at(p,a2,16)", "age_at(p,a3,16)", "age_at(p,a4,17)"}
    assert want <= atoms and not any(a.startswith("age_at(p,a5,") for a in atoms), atoms


def test_no_case_of_the_base_inside_a_span():
    for parts in (["sspx"], ["life_sources", "abortion", "abortion_canon"], ["marriages_c1117"]):
        hit = {a for b in solve(parts, "branches")["branches"] for a in b["assume"] if "force_by(" in a}
        assert not hit, (parts, hit)


def test_the_saeculum_reads_no_interior():
    txt = engine.base_texts()["saeculum.lp"]
    assert "interior(" not in txt and "imputab" not in txt



# The library names only works it declares (TTC-SAECULUM: a new work, the
# New Schaff-Herzog, cited for the Quicumque's reception).
def test_library_names_declared_works():
    code = "\n".join(line.split("%")[0] for line in engine.base_texts()["library.lp"].splitlines())
    declared = set(re.findall(r"^work\((\w+),", code, re.M))
    named = set(re.findall(r"\b(?:cites_work\(\w+, *|online\(|to_read\()([a-z]\w*)", code))
    assert named <= declared, named - declared


# TTC-CCEO WB2: the law library and the moral library agree on who a merely
# ecclesiastical law binds (c. 11): for every act, binds_on/2 of the law
# exactly where binds_for/3 of its agent.
def test_libraries_agree_on_who_is_bound():
    facts = ("today(20261010). law_kind(l_w,ecclesiastical). forbids(l_w,k_w). obliging(l_w). "
             "reading_option(l_w,plain). needs_reading(l_w,all). "
             "unbaptized(p_un). baptized_in(p_or,orthodox_church). baptized_in((p_ch;p_ok),catholic). "
             "born(p_ch,20200101). born(p_ok,19900101). "
             "act_of(p_un,a_un). act_of(p_or,a_or). act_of(p_ch,a_ch). act_of(p_ok,a_ok). "
             "act_date((a_un;a_or;a_ok),20250101). act_date(a_ch,20250101). "
             "kind_of_act((a_un;a_or;a_ch;a_ok),k_w). reaches(l_w,plain,(a_un;a_or;a_ch;a_ok)).")
    atoms = set(solve([], "one", facts=facts, show=("binds_on/2", "binds_for/3"))["atoms"])
    on = {a[len("binds_on(l_w,"):-1] for a in atoms if a.startswith("binds_on(l_w,")}
    fr = {a.split(",")[1] for a in atoms if a.startswith("binds_for(") and a.endswith(",k_w)")}
    assert on == fr == {"a_ok"}, (on, fr)


# TTC-CCEO LK1: the layer test. Every Latin delict carries c. 1's gate; every
# Eastern rule that binds a person reads the person's Eastern ascription.
def test_the_codes_do_not_cross():
    rules = [(f, st) for f, st in _heads_and_bodies() if f in ("canon_law.lp", "canon_cceo.lp")]
    latin = [st for f, st in rules if f == "canon_law.lp" and st.startswith("delict(") and ":-" in st]
    assert latin and all("not eastern_faithful(" in st for st in latin), [st for st in latin if "eastern_faithful" not in st]
    eastern = [st for f, st in rules if f == "canon_cceo.lp"
               and st.startswith(("eastern_delict(", "priest_required(", "liceity_only(", "confirms_by_law_or_faculty("))]
    assert eastern and all("eastern_faithful(" in st for st in eastern), eastern


# TTC-CCEO LK2: the strata of the Latin canons; the Eastern canons are all common.
def test_strata_of_the_canons():
    from theological_type_checker import norms
    g = norms.graph()
    typed = {n: v["stratum"] for n, v in g["norms"].items() if v["stratum"] != "common"}
    assert typed == {"cic:1057": "divine", "cic:1141": "divine", "cic:842": "divine", "cic:845": "divine",
                     "cic:333": "supreme"}, typed
    # a divine canon reaches the faithful of both codes: none of its rules reads ascription
    parsed = norms.parse()[2]
    for n, f, st in parsed:
        if n in typed:
            assert "eastern_faithful" not in st and "latin_faithful" not in st, (n, st)


# TTC-CCEO IM1: c. 8 §1 for a law promulgated outside the Acta. A date
# between the earliest force from the Acta and three months from the other
# publication makes the reading disputed, as a date after both does.
def test_reading_of_c8_disputed_before_the_publications_date():
    facts = ("promulgated_elsewhere(lx,20160916). aas_volume(lx,2016,20160531). act_date(ax,20161001).")
    bs = solve([], "branches", facts=facts)["branches"]
    got = {a for b in bs for a in b["assume"] if "c8_elsewhere,lx" in a}
    assert got == {"assumed_fact(reading(c8_elsewhere,lx,from_acta))",
                   "assumed_fact(reading(c8_elsewhere,lx,from_publication))"}, got
