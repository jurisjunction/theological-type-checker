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
    want = (reads - derived - lang.GENERATED) | ((_guide_inputs() | GUIDE_PROSE) & reads)
    assert set(lang.slots(lang.sources())) == want


# LY1: absolutions and consecrations are routed from the canon layer (the
# guide, CHRIST, PRESENCE, THE SACRAMENTS); sacrament.l reads them, as a
# library reads the canon layer's input.
ROUTED = {("consecration", 4): "canon_law.l", ("absolution", 4): "canon_law.l"}


def test_each_slot_is_declared_in_the_lowest_layer_that_reads_it():
    srcs = lang.sources()
    order = sorted(srcs, key=lambda f: (lang.LAYERS.index(srcs[f].layer), engine.FILES.index(f)))
    texts = lang.compiled(srcs, domains=False)
    reads_in = {f: engine.signatures(texts[f], f)["reads"] for f in srcs}
    for sig, d in lang.slots(srcs).items():
        lowest = next(f for f in order if sig in reads_in[f])
        assert d.where == ROUTED.get(sig, lowest[:-3] + ".l"), sig


READ_P = '```clingo\nq :- p(1).\n```\n'
SORT_S = 'sort s\n  means "m"\n'
SLOT_P = 'slot p(X: s)\n  means "m"\n  say "{X} is p"\n'


@pytest.mark.parametrize("files,why", [
    ({"a.lp": 'layer kernel\n' + SORT_S + SLOT_P + READ_P,
      "b.lp": 'layer theory\n' + SLOT_P}, "declared already (a.l:4)"),
    ({"a.lp": 'layer kernel\n' + SORT_S + SLOT_P + '```clingo\nq.\n```\n'}, "slot p/1: no rule reads it"),
    ({"a.lp": 'layer kernel\nuse r/1 "x"\n' + READ_P}, "use r/1: no file declares or derives it"),
    # TY1: every argument has a sort, declared once, used, and not above its slot
    ({"a.lp": 'layer kernel\nslot p/1\n  means "m"\n' + READ_P}, "slot p/1: its arguments have no sorts"),
    ({"a.lp": 'layer kernel\n' + SLOT_P + READ_P}, "slot p/1: no sort named s"),
    ({"a.lp": 'layer kernel\n' + SORT_S + SLOT_P + READ_P, "b.lp": 'layer theory\n' + SORT_S},
     "sort s is declared already (a.l:2)"),
    ({"a.lp": 'layer kernel\n' + SORT_S + 'sort t\n' + SLOT_P + READ_P}, "sort t: no slot uses it"),
    ({"a.lp": 'layer kernel\n' + SLOT_P + READ_P, "b.lp": 'layer theory\n' + SORT_S},
     "slot p/1: sort s is declared in a higher layer (b.l)"),
])
def test_the_slots_l_refuses(files, why):
    # SO3, the one slot per predicate, and TY1
    srcs = {n: lang.parse(t, n[:-3] + ".l") for n, t in files.items()}
    with pytest.raises(lang.LError, match=re.escape(why)):
        lang.validate(srcs)


def test_a_use_of_a_derived_predicate_and_a_slot_read_compile():
    lang.validate({"a.lp": lang.parse('layer kernel\n' + SORT_S + SLOT_P + 'use q/0 "derived here"\n' + READ_P,
                                      "a.l")})


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


# ---------- TY: sorts and domains ------------------------------------------
TYPED = '''layer authority

sort force {truth, juridical, protective}
  means "a source's force"
sort tier 0..5
  means "a tier"
sort source
  means "a source"

slot source(S: source, T: tier, F: force, Y: source)
  means "source(S, T, F, Y)"

part case
```clingo
#program demo.
source(s,3,truth,y).
```
'''


def test_a_closed_sort_compiles_to_its_domain():
    out = lang.parse(TYPED, "t.l").compile()
    assert out.endswith("\n% ---------- domains (L) " + "-" * 45 + "\n#program base.\n"
                        "in_sort(force,(truth;juridical;protective)).\nin_sort(tier,0..5).\n"
                        "violation(outside_domain(source,2,T)) :- source(_,T,_,_), not in_sort(tier,T).\n"
                        "violation(outside_domain(source,3,F)) :- source(_,_,F,_), not in_sort(force,F).\n")
    src = lang.parse(TYPED, "t.l")
    assert lang.parse(src.text(), "t.l").compile() == out


@pytest.mark.parametrize("decl,why", [
    ("sort s {a, a}\n", "a value given twice"),
    ("sort s {a, B}\n", "not a value: B"),
    ("sort s a..b\n", "expected {values} or a range"),
    ("slot p(x: s)\n", "expected `Arg: sort`"),
    ("slot p(X s)\n", "expected `Arg: sort`"),
])
def test_a_sort_l_refuses(decl, why):
    with pytest.raises(lang.LError, match=re.escape(why)):
        lang.parse("layer kernel\n" + decl, "bad.l")


def test_each_sort_is_declared_in_the_lowest_layer_whose_slots_use_it():
    # TY1
    srcs = lang.sources()
    order = sorted(srcs, key=lambda f: (lang.LAYERS.index(srcs[f].layer), engine.FILES.index(f)))
    users = {}
    for d in lang.slots(srcs).values():
        for _, sort in d.args or []:
            users.setdefault(sort, set()).add(d.where[:-2] + ".lp")
    for name, s in lang.all_sorts(srcs).items():
        assert s.where == next(f for f in order if f in users[name])[:-3] + ".l", name


# The closed sorts, from the guide's tables (TTC-L, Domains): pasted.
CLOSED = {"tier", "force", "question_kind", "papal_form", "character", "conciliar_act", "shown_condition",
          "object", "presence_mode", "nature", "sacrament", "teaching_type", "valence",
          "table_rank"}   # TTC-CALENDAR: the Table of Liturgical Days, 1..13


def _domain_args():
    srcs = lang.sources()
    sorts = lang.all_sorts(srcs)
    return sorts, [(d, i, sorts[s]) for d in lang.slots(srcs).values()
                   for i, (_, s) in enumerate(d.args or []) if sorts[s].closed]


def _inside(sort):
    return str(sort.range[0]) if sort.range else sort.values[0]


def _fact(d, i, value, sorts_of):
    args = [_inside(sorts_of[j]) if j in sorts_of else "x" for j in range(d.arity)]
    args[i] = value
    return f"{d.name}({','.join(args)})."


def test_the_closed_sorts_are_the_guides():
    sorts, _ = _domain_args()
    assert {n for n, s in sorts.items() if s.closed} == CLOSED


def test_a_value_outside_its_sort_is_a_violation_and_one_inside_is_not():
    # TY2, M3: every generated domain rule, through a snippet, at once
    sorts, args = _domain_args()
    closed_at = {}
    for d, i, s in args:
        closed_at.setdefault(d.sig, {})[i] = s
    outside = [_fact(d, i, "out_of_sort", closed_at[d.sig]) for d, i, _ in args]
    want = {f"violation(outside_domain({d.name},{i + 1},out_of_sort))" for d, i, _ in args}
    r = engine.solve([], "one", facts="\n".join(outside))
    assert {a for a in r["atoms"] if "outside_domain" in a} == want
    inside = [_fact(d, i, _inside(s), closed_at[d.sig]) for d, i, s in args]
    r = engine.solve([], "one", facts="\n".join(inside))
    assert r["sat"] and not [a for a in r["atoms"] if "outside_domain" in a]
    assert {s.name for _, _, s in args} == CLOSED          # a test per closed sort


# TY3: the one fact of the base outside its sort, after scoring: a candidate
# that enters a mode no one knows, to be refused (untyped_presence).
OUTSIDE = {("present", 3, "located", "cand_mode_unknown")}


def test_no_fact_of_the_base_is_outside_its_sort_but_a_candidates():
    from clingo import ast
    sorts, args = _domain_args()
    closed = {(d.sig, i): s for d, i, s in args}
    found = set()
    for f, src in lang.sources().items():
        part = None
        for item in src.items:
            if isinstance(item, lang.Part):
                part = item.name
            if not isinstance(item, lang.Fence):
                continue

            def on(st, part=part):
                if st.ast_type != ast.ASTType.Rule:
                    return

                def walk(n):
                    if isinstance(n, ast.AST):
                        if n.ast_type == ast.ASTType.SymbolicAtom and n.symbol.ast_type == ast.ASTType.Function:
                            sig = (n.symbol.name, len(n.symbol.arguments))
                            for i, a in enumerate(n.symbol.arguments):
                                s = closed.get((sig, i))
                                text = str(a)
                                if not s or text[:1].isupper() or text == "_" or ".." in text:
                                    continue
                                for v in (text[1:-1].split(";") if text.startswith("(") else [text]):
                                    inside = (s.range[0] <= int(v) <= s.range[1]) if s.range else v in s.values
                                    if not inside:
                                        found.add((sig[0], i + 1, v, part))
                        for k in n.child_keys:
                            walk(getattr(n, k))
                    elif isinstance(n, (list, tuple)):
                        for x in n:
                            walk(x)
                walk(st.head)
            ast.parse_string("\n".join(item.lines), on)
    assert found == OUTSIDE


def test_nothing_reads_the_domains_but_the_domain_rules():
    # SR1: no rule body reads outside_domain; only the domain rules read in_sort/2
    from clingo import ast
    srcs = lang.sources()
    for f, text in lang.compiled(srcs).items():
        generated = text.split(lang.DOMAINS_HEADER)[1] if lang.DOMAINS_HEADER in text else ""
        own = text.split(lang.DOMAINS_HEADER)[0]
        bodies = []
        ast.parse_string(own, lambda st: bodies.append(" ".join(str(b) for b in st.body))
                         if st.ast_type == ast.ASTType.Rule else None)
        assert not [b for b in bodies if "outside_domain" in b or "in_sort(" in b], f
        rules = [line for line in generated.splitlines() if ":-" in line]
        assert all(re.match(r"^violation\(outside_domain\(\w+,\d+,\w+\)\) :- \w+\([^)]*\), not in_sort\(\w+,\w+\)\.$",
                            r) for r in rules), f


def test_the_gate_knows_no_more_than_before():
    # TY4: in_sort/2 is L's, not a case's, and left the summary's shape alone
    # (schema 1). Restated (rule 7): the shape changed later, with `premises`
    # (the gate's fix, CG7), so the schema is 2; in_sort/2 still adds nothing.
    assert engine.unknown_slots("in_sort(force,bogus).") == ["unknown_slot(in_sort/2)"]
    assert engine.unknown_slots("source(s,3,truth,2000).") == []
    assert engine.SCHEMA == 2


# ---------- OF, SY: parts and their cases; sentences ------------------------
def _p_with(say):
    return {"a.lp": lang.parse('layer kernel\n' + SORT_S + 'slot p(X: s, Y: s)\n  means "m"\n' + say
                               + '```clingo\nq :- p(1,2).\n```\n', "a.l")}


@pytest.mark.parametrize("say,why", [
    ("", "slot p/2 has no `say`"),
    ('  say "{X} is p of {Z}"\n', "`say` names no argument Z"),
    ('  say "{X} is p of {X}"\n', "`say` names X twice"),
    ('  say "{X} is p"\n', "`say` names Y never"),
])
def test_a_sentence_l_refuses(say, why):
    with pytest.raises(lang.LError, match=re.escape(why)):
        lang.validate(_p_with(say))


def test_every_slot_says_each_argument_once():
    # SY1: every template rendered with its arguments leaves no name unfilled
    for d in lang.slots(lang.sources()).values():
        values = [f"<{a.lower()}>" for a, _ in d.args or []]
        out = lang.say(d, values)
        assert "{" not in out and "}" not in out, (d.name, out)
        assert all(out.count(v) == 1 for v in values), (d.name, out)
    src = lang.slots(lang.sources())[("source", 4)]
    assert lang.say(src, ["enc_x", "3", "truth", "1990"]) == "enc_x is a source at tier 3, of force truth, from 1990"


CASES_OF = """layer authority
part case
```clingo
#program c.
question(q(c)).
```
part switch of c
```clingo
#program s.
```
"""


@pytest.mark.parametrize("text,why", [
    (CASES_OF.replace("part switch of c", "part switch of nowhere"), "`of nowhere` names no case"),
    (CASES_OF + "part model of c\n```clingo\n#program m.\n```\n", "only a switch or a candidate names its case"),
])
def test_of_l_refuses(text, why):
    lang.validate({"a.lp": lang.parse(CASES_OF, "a.l")})
    with pytest.raises(lang.LError, match=re.escape(why)):
        lang.validate({"a.lp": lang.parse(text, "a.l")})


def _questions(text, stated=False):
    from clingo import ast
    out = set()

    def on(st):
        if st.ast_type == ast.ASTType.Rule:
            s = str(st.head) if stated else str(st.head) + " " + " ".join(map(str, st.body))
            out.update(re.findall(r"\bquestion\(q\(([a-z_]\w*)" if stated else r"\bq\(([a-z_]\w*)", s))
    ast.parse_string(text, on)
    return out


def test_a_part_of_a_case_names_only_its_questions():
    # OF1: every q(...) term in a part `of C` is a question C states, or one
    # no case states
    srcs = lang.sources()
    parts = [(f, it, "\n".join(src.items[i + 1].lines)) for f, src in srcs.items()
             for i, it in enumerate(src.items) if isinstance(it, lang.Part)]
    states = {}
    for f, it, text in parts:
        if it.kind == "case":
            for q in _questions(text, stated=True):
                states.setdefault(q, set()).add(it.name)
    with_of = [(f, it, text) for f, it, text in parts if it.of]
    assert 100 <= len(with_of) <= 250
    for f, it, text in with_of:
        for q in _questions(text):
            assert it.of in states.get(q, {it.of}), (it.name, it.of, q)
    named = {it.name: it.of for _, it, _ in with_of}
    assert [named.get(p) for p in ("recourse_decided_2026", "ccc_intrinsic", "trolley", "cand_monothelite")] == [
        "sspx", "deathpenalty", "life_sources", None]


def test_cases_and_sentences_change_no_rule_file():
    # OF2, SY1: `of` and `say` compile into no rule file
    srcs = lang.sources()
    before = lang.compiled(srcs)
    for src in srcs.values():
        for item in src.items:
            if isinstance(item, lang.Part):
                item.of = None
            if isinstance(item, lang.Slot):
                item.attrs.pop("say", None)
    assert lang.compiled(srcs) == before


# ---------- IS: interiors supplied ------------------------------------------
def test_every_interior_supplied_or_disputed_is_named_in_every_branch():
    # IS1: a name, never a finding (rule 3)
    facts = ("act_of(p,a). interior(p,a,deliberate). disputed(interior(p,a,full_knowledge)).\n"
             "act_of(q,b).")
    r = engine.solve([], "branches", facts=facts)
    assert len(r["all_models"]) == 2
    for m in r["all_models"]:
        named = {a for a in m if a.startswith("info(interior_supplied(")}
        assert named == {"info(interior_supplied(p,a,deliberate))", "info(interior_supplied(p,a,full_knowledge))"}


def test_no_rule_reads_the_interiors_named():
    for f, text in lang.compiled(lang.sources()).items():
        assert not re.search(r":-[^.]*interior_supplied", text), f


# ---------- CG: premises, not conclusions; SR: the checker's word ----------
EXAMPLE = ("question(q(example)). question_kind(q(example),doctrinal).\n"
           "value(q(example),yes). value(q(example),no).\n"
           "source(enc_x,3,truth,1990). papal_form(enc_x,ordinary). character(enc_x,encyclical).\n"
           "supports(enc_x,q(example),yes).\n"
           "source(blog,5,truth,2026). supports(blog,q(example),no).\n")


@pytest.mark.parametrize("conclusion,pred", [
    ("eff_tier(blog,1).", "eff_tier/2"),
    ("theorem(anything_i_like).", "theorem/1"),
    (":- holds(q(example),yes).", "holds/2"),
    ("h(X) :- holds(q(example),X).\n:- h(yes).", "holds/2"),            # through a helper of its own
    ("hypothetical_warrant(blog).", "hypothetical_warrant/1"),           # CG5
    ("in_sort(force,bogus).", "in_sort/2"),                              # L's own
    ("event_date(e,20200101).", "event_date/2"),                         # CG1's example: no slot (SCORING)
])
def test_a_conclusion_is_refused_at_its_gate(conclusion, pred):
    # CG1: refused, naming its predicate; without it, the run is as before
    with pytest.raises(engine.SnippetError) as e:
        engine.solve([], "branches", facts=EXAMPLE + conclusion)
    assert (e.value.gate, e.value.where, e.value.predicate) == ("conclusion", "facts", pred)
    r = engine.solve([], "branches", facts=EXAMPLE)
    assert {f for b in r["all_models"] for f in b if f.startswith("holds(")} == {"holds(q(example),yes)",
                                                                                  "holds(q(example),no)"}


@pytest.mark.parametrize("premise", [
    ":- not read_as(s,r).",                                   # the guide's way to fix a reading
    "aux(S) :- source(S,_,_,_).\n:- aux(nothing).",          # a helper of its own, written and read
    "source(oum_x,1,truth,2000).",                           # a slot some rule also derives
    "source(s,1,truth,600) :- attributed(s,a).",              # a premise on the branch of a claim
])
def test_a_premise_passes_the_gate(premise):
    engine.conclusion_gate(premise)


@pytest.mark.parametrize("witness,pred", [
    ("condition_shown(s,dispersed_in_communion) :- oum_holds(s).", "oum_holds/1"),       # WG2: the claim shows itself
    ("witnessed_by(s,faith_or_morals,w) :- oum_grade(s,1).", "oum_grade/2"),
    ("h(S) :- oum_holds(S).\ncommunion_judged_by(w,q(x)) :- h(s).", "oum_holds/1"),     # through a helper of its own
])
def test_a_witness_drawn_from_a_conclusion_is_refused(witness, pred):
    # TTC-WITNESS WG1: a witness of LG 25's conditions reads no conclusion of the base
    with pytest.raises(engine.SnippetError) as e:
        engine.conclusion_gate(witness)
    assert (e.value.gate, e.value.predicate) == ("conclusion", pred)
    assert "rule 14" in str(e.value)


def test_a_witness_from_premises_passes_the_gate():
    # TTC-WITNESS WG1: a witness drawn from premises passes; whether it is apart is the base's to say (WN2)
    engine.conclusion_gate("witnessed_by(S,C,w) :- oum_claim(S,_), oum_condition(C).")


@pytest.mark.parametrize("side", ["theology", "canon"])
def test_save_case_refuses_a_conclusion_on_either_side(tmp_path, monkeypatch, side):
    # CG3
    pytest.importorskip("mcp")
    monkeypatch.setenv("TTC_HOME", str(tmp_path))
    from mcp.server.mcpserver.exceptions import ToolError
    from theological_type_checker import server
    import json
    with pytest.raises(ToolError) as e:
        server.save_case("concl", **{side: "% a case\nwarranted(blog)."})
    d = json.loads(str(e.value))
    assert (d["gate"], d["where"], d["predicate"], d["line"]) == ("conclusion", side, "warranted/1", 2)


# The predicates rule 14 computes: never premises.
RULE_14 = [("eff_tier", 2), ("in_force", 1), ("warranted", 1), ("received", 1), ("oum_holds", 1)]


def test_no_predicate_rule_14_computes_is_a_slot():
    # CG4
    declared = lang.slots(lang.sources())
    assert [sig for sig in RULE_14 if sig in declared] == []
    reads, derived = _base_reads_and_derives()
    assert all(sig in derived for sig in RULE_14)


def test_a_hypothetical_slot_is_written_only_in_a_part_marked_so():
    # CG5: the base's four parts are marked; a fifth, unmarked, is refused
    srcs = lang.sources()
    assert "hypothetical" in lang.slots(srcs)[("hypothetical_warrant", 1)].attrs
    lang.validate(srcs)
    text = ('layer authority\nsort source\n  means "s"\nslot w(S: source)\n  means "m"\n  say "{S}"\n'
            '  hypothetical "supposed"\n```clingo\nok(S) :- w(S).\n```\n')
    marked = 'part switch\n```clingo\n#program h.   % HYPOTHETICAL: supposed\nw(a).\n```\n'
    lang.validate({"a.lp": lang.parse(text + marked, "a.l")})
    unmarked = 'part switch\n```clingo\n#program fifth.\nw(a).\n```\n'
    with pytest.raises(lang.LError, match=re.escape("w/1 is hypothetical") + ".*part fifth"):
        lang.validate({"a.lp": lang.parse(text + unmarked, "a.l")})
    with pytest.raises(lang.LError, match="outside its parts"):
        lang.validate({"a.lp": lang.parse(text + '```clingo\nw(b).\n```\n', "a.l")})


def test_the_gates_name_conclusion():
    # M5
    assert "conclusion" in engine.REFUSAL_GATES


# CG7 (SCORING, the gate's fix): what the base's own cases enter as premises,
# and the base reads, a case may enter too. Before the fix each was refused.
CLAIM_VOCABULARY = [
    ("marriage(m,pr,20190615). spouse(m,(a;b)). priest(pr).", "priest/1"),
    ("created_person(x).", "created_person/1"),
    ("divine(father). divine(son). gen(begetting,father,son).", "divine/1"),
    ("god(g). created_person(p). being(demiurge,p).", "being/2"),
    ("less(peter,gabriel).", "less/2"),
    ("denies_image(embryo,not_yet_born).", "denies_image/2"),
    ("held_for(church,child,son).", "held_for/3"),
    ("question(q(x)). question_kind(q(x),doctrinal). law_answers(q(x)).", "law_answers/1"),
]


@pytest.mark.parametrize("facts,pred", CLAIM_VOCABULARY)
def test_the_claim_vocabulary_passes_the_gate(facts, pred):
    engine.conclusion_gate(facts)
    sig = tuple(pred.split("/"))
    assert (sig[0], int(sig[1])) in lang.slots(lang.sources())


@pytest.mark.parametrize("facts,pred,drawn", [
    ("info(anything).", "info/1", None),                                  # an output
    ("of_kind(e,k).", "of_kind/2", None),                                 # the pair's conclusion
    ("monopatrism.", "monopatrism/0", None),                              # a switch's flag: load its part
    ("bridge(beauty,div,cr).", "bridge/3", None),                         # a theory's vocabulary
    ("dispensed(l,x).", "dispensed/2", "dispensation/3"),                # drawn from a premise
    ("sacred_minister(a).", "sacred_minister/1", "deacon/1"),
    ("removes_voluntary(p,a,violence).", "removes_voluntary/3", "interior/3"),
])
def test_a_conclusion_stays_refused_and_names_its_premises(facts, pred, drawn):
    # CG7: the refusal names the slots the conclusion is drawn from
    with pytest.raises(engine.SnippetError) as e:
        engine.conclusion_gate(facts)
    assert (e.value.gate, e.value.predicate) == ("conclusion", pred)
    if drawn:
        assert drawn in str(e.value).split("drawn from (TTC-L CG): ")[1]


def test_the_summary_says_which_premises_the_base_reads():
    # CG7: a fact under a predicate nothing reads computes nothing, and says so
    s = engine.summary(engine.run_checked([], "marriage(m,pr,20190615). spouse(m,(a;b)). wedding_day(m)."))
    assert s["premises"] == {"read": ["marriage/3", "spouse/2"], "unread": ["wedding_day/1"]}
    assert engine.summary(engine.run_checked([], ""))["premises"] == {"read": [], "unread": []}


def test_what_the_grammar_alone_holds_reaches_no_rule_file():
    # SR2: parts' kinds and cases, runtimes' parents, sentences, sides
    srcs = lang.sources()
    before = lang.compiled(srcs)
    for src in srcs.values():
        src.layer = "library"                         # a side is its layer's: read by save_case alone
        for item in src.items:
            if isinstance(item, lang.Part):
                item.kind, item.of = "switch", None
            if isinstance(item, lang.Slot):
                item.attrs.pop("say", None)
            if isinstance(item, lang.Runtime):
                item.parents, item.ops = [], []
    assert lang.compiled(srcs) == before
