"""ttc-l gbnf: L's slots and sorts as a grammar for constrained decoding.
A small recognizer for the GBNF subset the exporter writes stands in for
llama.cpp's here: literals, character classes, groups, alternation, * + ?."""
import re

import clingo
import pytest

from theological_type_checker import engine, gbnf, lang


# ---------- a recognizer for the subset ---------------------------------------
def _parse(text):
    rules = {}
    for line in text.splitlines():
        if not line.strip() or line.startswith("#"):
            continue
        name, body = line.split(" ::= ", 1)
        rules[name] = _alts(_tokens(body))[0]
    return rules


def _tokens(body):
    out, i = [], 0
    while i < len(body):
        c = body[i]
        if c.isspace():
            i += 1
        elif c == '"':
            j, s = i + 1, ""
            while body[j] != '"':
                if body[j] == "\\":
                    s += {"n": "\n", "t": "\t"}.get(body[j + 1], body[j + 1])
                    j += 2
                else:
                    s += body[j]
                    j += 1
            out.append(("lit", s))
            i = j + 1
        elif c == "[":
            j = i + 1
            while body[j] != "]":
                j += 2 if body[j] == "\\" else 1
            cls = body[i + 1:j].replace("\\t", "\t").replace("\\n", "\n").replace('\\"', '"').replace("\\\\", "\\\\")
            out.append(("cls", re.compile("[" + cls + "]")))
            i = j + 1
        elif c in "()|*+?":
            out.append((c, None))
            i += 1
        else:
            m = re.match(r"[a-zA-Z0-9-]+", body[i:])
            out.append(("ref", m.group(0)))
            i += len(m.group(0))
    return out


def _alts(toks, i=0):
    alts, seq = [], []
    while i < len(toks) and toks[i][0] not in (")",):
        k, v = toks[i]
        if k == "|":
            alts.append(seq)
            seq = []
            i += 1
            continue
        if k == "(":
            node, i = _alts(toks, i + 1)
            i += 1
        else:
            node, i = (k, v), i + 1
        if i < len(toks) and toks[i][0] in "*+?":
            node, i = (toks[i][0], node), i + 1
        seq.append(node)
    alts.append(seq)
    return ("alt", alts), i


def _match(rules, node, s, i):
    k = node[0]
    if k == "lit":
        if s.startswith(node[1], i):
            yield i + len(node[1])
    elif k == "cls":
        if i < len(s) and node[1].fullmatch(s[i]):
            yield i + 1
    elif k == "ref":
        yield from _match(rules, rules[node[1]], s, i)
    elif k == "alt":
        for seq in node[1]:
            yield from _seq(rules, seq, s, i)
    elif k == "?":
        yield i
        yield from _match(rules, node[1], s, i)
    elif k in "*+":
        def more(j, n):
            if n or k == "*":
                yield j
            for e in _match(rules, node[1], s, j):
                if e > j:
                    yield from more(e, n + 1)
        yield from more(i, 0)


def _seq(rules, seq, s, i):
    if not seq:
        yield i
        return
    for j in _match(rules, seq[0], s, i):
        yield from _seq(rules, seq[1:], s, j)


def accepts(grammar, text):
    rules = _parse(grammar)
    return any(e == len(text) for e in _match(rules, ("ref", "root"), text, 0))


# ---------- the grammar ----------------------------------------------------------
@pytest.fixture(scope="module")
def full():
    return gbnf.grammar()


def test_it_admits_well_typed_facts_and_nothing_else(full):
    assert accepts(full, "promulgated(l_a,20250101).\nlegislator(l_a,bishop_h).\nauthority(bishop_h,1).\n")
    assert accepts(full, "source(sc1963,3,truth,1963).")
    for bad, why in (("source(sc1963,7,truth,1963).", "a tier outside 0..5"),
                     ("source(sc1963,3,truthy,1963).", "a force not of its sort"),
                     ("promulgated(l_a,2025).", "a date not of eight digits"),
                     ("promulgated(l_a,20250101)", "no full stop"),
                     ("promulgated(l_a).", "the wrong arity"),
                     ("does_not_bind(l_a).", "a result: computed, never entered"),
                     ("info(obliged(p,l)).", "an output"),
                     ("promulgated(L,20250101).", "a variable: a fact, not a rule")):
        assert not accepts(full, bad), why


def test_every_slot_fact_of_a_part_is_admitted(full):
    """The LW12 part, its pools flattened by clingo: each fact of a slot is
    admitted as it stands."""
    _, _, block = engine_part("ius_superius")
    ctl = clingo.Control(["--warn=none"])
    ctl.add("base", [], "\n".join(l for l in block.splitlines() if not l.startswith("#program")))
    ctl.ground([("base", [])])
    slots = lang.slots(lang.sources())
    facts = [str(a.symbol) + "." for a in ctl.symbolic_atoms
             if a.is_fact and (a.symbol.name, len(a.symbol.arguments)) in slots]
    assert len(facts) > 40
    for f in facts:
        assert accepts(full, f), f


def engine_part(name):
    from theological_type_checker import server
    return server._part_blocks()[name]


def test_a_side_or_a_slot_narrows_it():
    canon = gbnf.grammar(side="canon")
    assert accepts(canon, "promulgated(l_a,20250101).")
    assert not accepts(canon, "source(sc1963,3,truth,1963).")      # the authority layer's: theology
    one = gbnf.grammar(only={"promulgated/2"})
    assert accepts(one, "promulgated(l_a,20250101).") and not accepts(one, "legislator(l_a,b).")
    with pytest.raises(ValueError, match="no such slot"):
        gbnf.grammar(only={"does_not_bind/1"})


def test_the_grammar_is_read_off_l_and_names_each_rule_once(full):
    names = [l.split(" ::= ")[0] for l in full.splitlines() if " ::= " in l]
    assert len(names) == len(set(names))
    refs = set(re.findall(r"(?<![\w-])(?:slot|sort)-[a-z0-9-]+", full)) | {"ws", "ident", "int", "string", "date", "term"}
    assert set(names) <= refs | {"root", "fact"}
    assert full.count("slot-") >= 2 * len(lang.slots(lang.sources()))
    assert gbnf.grammar() == full                                   # the same L, the same grammar


def test_ttc_l_writes_it(capsys):
    assert lang.main(["gbnf", "--slot", "promulgated/2"]) == 0
    out = capsys.readouterr().out
    assert out.startswith("# GBNF read off L: 1 slots") and accepts(out, "promulgated(l_a,20250101).")
    assert lang.main(["gbnf", "--slot", "nope/1"]) == 2
    assert "no such slot here: nope/1" in capsys.readouterr().err
