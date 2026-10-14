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
