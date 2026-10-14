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
