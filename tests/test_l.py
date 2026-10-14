"""L, the language of the libraries (TTC-L): the compiler and its sources."""
import re
import shutil

import pytest

from theological_type_checker import engine, lang


# ---------- RG: regeneration -----------------------------------------------
def test_every_rule_file_is_its_source_compiled():
    # RG1, RG2: the 27 rule files byte for byte, every tag lifted
    assert lang.check() == []
    assert sorted(lang.sources()) == sorted(engine.FILES)


def test_a_hand_edit_fails_the_check(tmp_path):
    # RG3: an edit to a compiled file by hand, or a rule file with no source
    lp = tmp_path / "lp"
    shutil.copytree(lang.LP_DIR, lp)
    p = lp / "act.lp"
    p.write_text(p.read_text().replace("interior(P,A,X)", "interior(P,A,Y)", 1))
    (lp / "stray.lp").write_text("a.\n")
    assert lang.check(lang.L_DIR, lp) == ["act.lp", "stray.lp"]
    assert lang.main(["check", "--lp", str(lp)]) == 1


def test_every_tag_is_lifted():
    # RG2: no tag norms.py reads is left in a fence
    for name, src in lang.sources().items():
        for item in src.items:
            if isinstance(item, lang.Fence):
                for line in item.lines:
                    assert not line.startswith(("% @input", "% @norm", "% @end", "% @temporal", "% @recursive",
                                                "% @stratum", "%  @library")), (name, line)


# ---------- the kinds of declaration ---------------------------------------
SRC = '''layer libraries

library

slot finding/4
  means "finding(F, Q, V, Year): a finding"
use in_force/1 "icon_authority.lp"

norm cic1917:748 | Codex Iuris Canonici (1917), c. 748 | https://www.iuscangreg.it/cic1917.php
stratum cic:842 divine
temporal cic2021:1379
recursive cic2021:1329
end

-- a comment of L's, not compiled
part switch of sspx
```clingo
#program demo.   % a note
fact(1).
```
'''

OUT = '''%  @library  (read by norms.py: its predicates count as defined)
% @input finding/4 | finding(F, Q, V, Year): a finding
% @input in_force/1 | icon_authority.lp
% @norm cic1917:748 | Codex Iuris Canonici (1917), c. 748 | https://www.iuscangreg.it/cic1917.php
% @stratum cic:842 divine
% @temporal cic2021:1379
% @recursive cic2021:1329
% @end
#program demo.   % a note
fact(1).
'''


def test_each_kind_renders_its_line():
    src = lang.parse(SRC, "demo.l")
    assert src.compile() == OUT
    assert src.layer == "libraries"
    part = src.decls(lang.Part)[0]
    assert (part.name, part.kind, part.of) == ("demo", "switch", "sspx")


def test_the_source_l_writes_parses_to_the_same_rule_file():
    src = lang.parse(SRC, "demo.l")
    assert lang.parse(src.text(), "demo.l").compile() == OUT


def test_a_fence_is_copied_byte_for_byte():
    raw = "  odd(  spacing ) .\t% tab\n\n%  @input not/1 | a tag inside a fence is not lifted"
    src = lang.parse("layer kernel\n```clingo\n" + raw + "\n```\n", "f.l")
    assert src.compile() == raw + "\n"


@pytest.mark.parametrize("text,why", [
    ("slot x/1\n", "opens with exactly one `layer`"),
    ("layer nowhere\n", "unknown layer"),
    ("layer kernel\nwidget x\n", "unknown declaration"),
    ("layer kernel\nslot x\n  means \"m\"\n", "expected name/arity"),
    ("layer kernel\nslot x/1\n", "has no `means`"),
    ("layer kernel\nslot x/1\n  means \"m\"\n  colour \"red\"\n", "no attribute `colour`"),
    ("layer kernel\nslot x/1\n  means m\n", "expected a quoted string"),
    ("layer kernel\nnorm a | b\n", "expected `norm id | citation | url`"),
    ("layer kernel\nstratum a holy\n", "divine|supreme|common"),
    ("layer kernel\npart switch\n```clingo\nfact.\n```\n", "must stand before a fence opening with `#program`"),
    ("layer kernel\n```clingo\n#program p.\n```\n", "needs a `part` before it"),
    ("layer kernel\npart gadget\n", "expected `part"),
    ("layer kernel\n```clingo\nfact.\n", "never closed"),
    ("layer kernel\n```clingo\nf.\n```\n  means \"m\"\n", "no declaration above it"),
    ("layer kernel\n  means \"m\"\n", "`layer` has no attribute `means`"),
])
def test_l_refuses(text, why):
    with pytest.raises(lang.LError, match=re.escape(why)):
        lang.parse(text, "bad.l").compile()


# ---------- RU: runtimes by inheritance --------------------------------------
# The runtimes as engine.py held them by hand before L (at 3fc3601): the
# expectation is that table, not anything the compiler computes.
HAND_WRITTEN = {
    "bare": [],
    "default": ["classical", "one_power"],
    "thomist": ["classical", "one_power", "th01", "th03", "th04", "th05", "th06", "th21", "th22", "th24",
                "simplicity_thomist", "attributes_by_reason", "mixed_relations", "transcendentals",
                "holds_premotion", "one_place_circumscribed"],
    "scotist": ["classical", "one_power", "simplicity_scotist", "attributes_formal", "univocity_of_concept",
                "scotus_esse", "mixed_relations", "transcendentals"],
    "suarezian": ["classical", "one_power", "simplicity_thomist", "attributes_by_reason", "suarez_esse",
                  "mixed_relations", "transcendentals", "holds_concurrence"],
    "palamite": ["classical", "simplicity_palamite", "palamite_energies", "monopatrism", "no_divine_contraction",
                 "grace_uncreated"],
}


def test_the_runtimes_compile_to_the_hand_written_lists():
    # RU1: order included; the engine reads what L compiles
    compiled = lang.compile_runtimes(lang.sources())
    assert compiled["runtimes"] == HAND_WRITTEN and list(compiled["runtimes"]) == list(HAND_WRITTEN)
    assert engine.RUNTIMES == HAND_WRITTEN
    assert compiled["declared"]["palamite"] == {"extends": ["default"], "file": "schools.l", "ops": [
        ["exclude", "one_power"], ["add", "simplicity_palamite"], ["add", "palamite_energies"],
        ["add", "monopatrism"], ["add", "no_divine_contraction"], ["add", "grace_uncreated"]]}


PARTS = "".join(f"part switch\n```clingo\n#program {p}.\n```\n" for p in ("a", "b", "c", "d"))


def _runtimes(decls):
    return lang.compile_runtimes({"x.lp": lang.parse("layer schools\n" + PARTS + decls, "x.l")})["runtimes"]


def test_alter_puts_its_part_in_place():
    # RU2
    rt = _runtimes("runtime base\n  add a, b, c\nruntime variant extends base\n  alter b -> d\n")
    assert rt["variant"] == ["a", "d", "c"]


@pytest.mark.parametrize("parents", ["one, two", "two, one"])
def test_a_clash_between_parents_is_refused_whichever_comes_first(parents):
    # RU3: one parent has b, the other excludes it; no parent order decides
    decls = ("runtime one\n  add a, b\nruntime two extends one\n  exclude b\n  add c\n"
             f"runtime child extends {parents}\n")
    with pytest.raises(lang.LError, match="clash on b"):
        _runtimes(decls)


@pytest.mark.parametrize("combinator,expect", [
    ("  add b\n", ["a", "b", "c"]),
    ("  exclude b\n", ["a", "c"]),
    ("  alter b -> d\n", ["a", "d", "c"]),
])
def test_the_childs_combinator_settles_a_clash(combinator, expect):
    # RU3: the child says what it wants of the part, and it compiles
    decls = ("runtime one\n  add a, b\nruntime two extends one\n  exclude b\n  add c\n"
             f"runtime child extends one, two\n{combinator}")
    assert _runtimes(decls)["child"] == expect


@pytest.mark.parametrize("decls,why", [
    ("runtime r\n  add nowhere\n", "no part named nowhere"),                                  # RU4
    ("runtime r extends ghost\n", "no runtime named ghost"),
    ("runtime r extends s\nruntime s extends r\n", "in a cycle"),
    ("runtime r\n  add a\nruntime r\n", "declared twice"),
    ("runtime r\n  alter b -> c\n", "does not have"),
    ("runtime r\n  add a, b\n  alter a -> b\n", "already has b"),
    ("runtime r\n  add a\n  alter a to b\n", "expected `alter part -> part`"),
    ("runtime r\n  include a\n", "no attribute `include`"),
])
def test_a_runtime_l_refuses(decls, why):
    with pytest.raises(lang.LError, match=re.escape(why)):
        _runtimes(decls)


def test_a_hand_edit_to_the_runtimes_fails_the_check(tmp_path):
    rj = tmp_path / "runtimes.json"
    rj.write_text(lang.RUNTIMES_JSON.read_text().replace('"th24",\n', "", 1))
    assert lang.check(lang.L_DIR, lang.LP_DIR, rj) == ["runtimes.json"]


# ---------- SO: slots, declared once ----------------------------------------
def _base_reads_and_derives():
    reads, derived = set(), set()
    for f in engine.FILES:
        s = engine.signatures((engine.LP_DIR / f).read_text(), f)
        reads |= s["reads"]
        derived |= s["derived"]
    return reads, derived


def _top_args(s):
    out, depth, cur = [], 0, ""
    for ch in s:
        depth += ch in "({["
        depth -= ch in ")}]"
        if ch == "," and depth == 0:
            out.append(cur)
            cur = ""
        else:
            cur += ch
    out.append(cur)
    return [x for x in out if x.strip()]


def _guide_inputs():
    """The facts the guide gives a person to enter: the first column of its
    tables from THEOLOGY to LIBRARY, outputs and parts aside. The guide is a
    person's word, not the checker's."""
    guide = (engine.LP_DIR.parent / "guide.md").read_text()
    body = guide.split("## THEOLOGY")[1].split("## OUTPUT")[0]
    out = set()
    for line in body.splitlines():
        if not line.startswith("| ") or line.startswith(("| ---", "| Fact")):
            continue
        first = line.split(" | ")[0]
        if "*output*" in first or first.startswith("| parts"):
            continue
        for m in re.finditer(r"`([a-z_][a-z0-9_]*)(?:\(([^`]*)\)|/(\d+))`", first):
            name, args, n = m.groups()
            out.add((name, len(_top_args(args)) if args is not None else int(n)))
    return out


# Named as facts to enter in the guide's prose, not its first column.
GUIDE_PROSE = {("appears_otherwise", 2), ("interpretation_form", 2)}


def test_every_slot_is_declared_once():
    # SO1 (amended, L SCORING): a slot is a predicate the base reads that a
    # case enters: one no rule derives, or one the guide gives to enter though
    # a rule also derives it (source/4, interior/3). Declared twice fails.
    reads, derived = _base_reads_and_derives()
    want = (reads - derived) | ((_guide_inputs() | GUIDE_PROSE) & reads)
    assert set(lang.slots(lang.sources())) == want


# LY1: absolutions and consecrations are routed from the canon layer (the
# guide, CHRIST, PRESENCE, THE SACRAMENTS); sacrament.l reads them, as a
# library reads the canon layer's input.
ROUTED = {("consecration", 4): "canon_law.l", ("absolution", 4): "canon_law.l"}


def test_each_slot_is_declared_in_the_lowest_layer_that_reads_it():
    srcs = lang.sources()
    order = sorted(srcs, key=lambda f: (lang.LAYERS.index(srcs[f].layer), engine.FILES.index(f)))
    reads_in = {f: engine.signatures(srcs[f].compile(), f)["reads"] for f in srcs}
    for sig, d in lang.slots(srcs).items():
        lowest = next(f for f in order if sig in reads_in[f])
        assert d.where == ROUTED.get(sig, lowest[:-3] + ".l"), sig


@pytest.mark.parametrize("files,why", [
    ({"a.lp": 'layer kernel\nslot p/1\n  means "m"\n```clingo\nq :- p(1).\n```\n',
      "b.lp": 'layer theory\nslot p/1\n  means "m"\n'}, "declared already (a.l:2)"),
    ({"a.lp": 'layer kernel\nslot p/1\n  means "m"\n```clingo\nq.\n```\n'}, "slot p/1: no rule reads it"),
    ({"a.lp": 'layer kernel\nuse r/1 "x"\n```clingo\nq :- p(1).\n```\n'}, "use r/1: no file declares or derives it"),
])
def test_the_slots_l_refuses(files, why):
    # SO3 and the one slot per predicate
    srcs = {n: lang.parse(t, n[:-3] + ".l") for n, t in files.items()}
    with pytest.raises(lang.LError, match=re.escape(why)):
        lang.validate(srcs)


def test_a_use_of_a_derived_predicate_and_a_slot_read_compile():
    lang.validate({"a.lp": lang.parse('layer kernel\nslot p/1\n  means "m"\nuse q/0 "derived here"\n'
                                      '```clingo\nq :- p(1).\n```\n', "a.l")})


def test_a_part_is_a_case_where_it_states_its_questions():
    # SO2: a case writes question/1 (a candidate, model, date or search aside),
    # or bears the name of one that does (the canon half of the pair); any
    # other part is a switch.
    srcs = lang.sources()
    parts = [(f, it, "\n".join(src.items[i + 1].lines)) for f, src in srcs.items()
             for i, it in enumerate(src.items) if isinstance(it, lang.Part)]
    states = {it.name for f, it, text in parts
              if it.kind in ("case", "switch") and ("question", 1) in engine.signatures(text, f)["heads"]}
    for f, it, text in parts:
        if it.kind in ("case", "switch"):
            assert it.kind == ("case" if it.name in states else "switch"), (f, it.name)
    assert {it.name for f, it, _ in parts if f == "canon_cases.lp" and it.kind == "case"} == {
        "sspx", "act_fear", "law_cases", "moral_cases", "c915_case", "seal_case", "prudential_case",
        "c1399_case", "fiction_acts"}


# ---------- LY: layers -----------------------------------------------------
# The hand lists server.py held before L (at 0b7ad94): the expectation,
# pasted, not anything the compiler computes.
HAND_THEOLOGY = ("source", "supports", "question", "value", "question_kind", "character", "papal_form",
                 "cites", "reaffirms", "interprets", "ambiguous", "reading", "reads", "oum_claim", "protects")
HAND_CANON = ("consecration", "co_consecrator", "decree", "declares", "heard", "recourse", "grant",
              "permission", "revocation", "absolution", "marriage", "delegation", "remission", "asserts")


def test_the_sides_agree_with_the_hand_lists():
    # LY1, with consecration/4 and absolution/4 declared in canon_law.l
    sides = {}
    for (name, _), side in lang.sides().items():
        sides.setdefault(name, set()).add(side)
    assert {n: sides.get(n) for n in HAND_THEOLOGY} == {n: {"theology"} for n in HAND_THEOLOGY}
    assert {n: sides.get(n) for n in HAND_CANON} == {n: {"canon"} for n in HAND_CANON}


def test_the_libraries_slots_go_on_either_side():
    # LY (amended): the guide enters them on both sides
    sides = lang.sides()
    assert [sides[s] for s in [("interior", 3), ("act_of", 2), ("law_kind", 2), ("classification", 3)]] == [
        "either"] * 4
    assert sides[("premise", 3)] == "canon" and sides[("oum_claimant", 2)] == "theology"


# Parts of canon_cases.l that write slots of the theology side: a finding of
# LY (L SCORING), not yet split into their two halves.
MIXED = {"act_fear", "c1399_case", "c915_case", "fiction_acts", "law_cases", "moral_cases", "prudential_case",
         "seal_case", "cand_art6_moral", "cand_sin_of_christ", "cand_state_is_evil",
         "cand_law_types_the_substance", "grace_cases", "cand_pelagian", "christ_acts",
         "cand_one_theandric_operation", "cand_father_acts_humanly", "cand_god_located",
         "cand_angel_circumscribed", "cand_bilocation", "cand_father_in_the_host", "cand_mode_unknown"}


def test_no_part_enters_a_slot_of_the_other_side_but_the_known_mixed_ones():
    sides = lang.sides()
    found = set()
    for f, src in lang.sources().items():
        own = lang.SIDE[src.layer]
        if own == "either":
            continue
        for i, it in enumerate(src.items):
            if isinstance(it, lang.Part):
                heads = engine.signatures("\n".join(src.items[i + 1].lines), f)["heads"]
                if any(sides.get(sig) not in (None, "either", own) for sig in heads):
                    found.add((f, it.name))
    assert found == {("canon_cases.lp", n) for n in MIXED}


def test_the_clocks_slot_is_not_an_unused_input():
    # custom_asof/0, declared in saeculum.l, is one of the clock's predicates
    # the norm graph does not read (norms.BUILTIN)
    from theological_type_checker import norms
    assert ("custom_asof", 0) in lang.slots(lang.sources())
    assert norms.check()["unused_inputs"] == []
