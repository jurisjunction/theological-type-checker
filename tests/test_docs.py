"""The hand-written pages against what they describe: every command answers
--help without running anything, and the lists a page keeps by hand (the
commands, the rule files, the encoded norms, the pages themselves) name
everything there is. A page that falls behind turns a test red."""
import importlib
import os
import pathlib
import re
from importlib.metadata import entry_points

os.environ["TTC_HOME"] = ""

import pytest

from theological_type_checker import engine

ROOT = pathlib.Path(__file__).resolve().parents[1]
DOCS = ROOT / "docs"
SCRIPTS = {e.name: e.value for e in entry_points(group="console_scripts") if e.value.startswith("theological_type_checker.")}
RULE_FILES = sorted(p.stem for p in engine.LP_DIR.glob("*.lp"))


@pytest.mark.parametrize("name", sorted(SCRIPTS))
def test_every_command_answers_help(name, capsys):
    module, func = SCRIPTS[name].split(":")
    with pytest.raises(SystemExit) as e:
        getattr(importlib.import_module(module), func)(["--help"])
    assert e.value.code == 0
    assert capsys.readouterr().out.startswith(f"usage: {name}")


def test_readme_synopsis_names_every_command():
    readme = (ROOT / "README.md").read_text()
    synopsis = readme.split("## SYNOPSIS", 1)[1].split("##", 1)[0]
    missing = [n for n in SCRIPTS if not re.search(rf"(?m)^{re.escape(n)}\b", synopsis)]
    assert not missing, f"README.md SYNOPSIS lacks {missing}"


@pytest.mark.parametrize("page", ["README.md", "CLAUDE.md"])
def test_every_rule_file_is_named(page):
    text = (ROOT / page).read_text()
    missing = [f for f in RULE_FILES if not re.search(rf"\b{f}\.(?:l|lp)\b", text)]
    assert not missing, f"{page} does not name {missing}"


def test_every_page_is_in_the_index():
    index = (DOCS / "README.md").read_text()
    linked = set(re.findall(r"\]\(([^)#]+)", index))
    pages = [p.relative_to(DOCS).as_posix() for p in DOCS.rglob("*.md") if p.name != "README.md"]
    missing = sorted(p for p in pages if p not in linked)
    assert not missing, f"docs/README.md does not link {missing}"


def test_no_page_counts_the_scenarios():
    # the count is ttc-suite's to print ("741/741 passed"); a page that states it goes stale
    for page in [ROOT / "README.md", ROOT / "examples" / "README.md", DOCS / "README.md"]:
        assert not re.search(r"\b\d+ (?:more )?scenarios|\bhas \d+ more\b", page.read_text()), page


# ---------- the canon layer's ENCODED table ----------------------------------
LATIN = {"cic", "cic1983", "cic2021", "atf1998", "dc2016", "mp2017", "pclt1988"}
NAMED = {                       # norms outside the codes: the words the table uses for them
    "collections": "Rex pacificus", "so1947": "Sacramentum ordinis", "id1967": "Indulgentiarum doctrina",
    "rs2004": "Redemptionis Sacramentum", "grants": "grants", "sst2021": "art. {n}",
    "gnly": "Liturgical Year",
}
NOT_LAW = {"checking"}          # a display block: a text's claims against the norms


def _encoded_rows():
    page = (DOCS / "canon-law-layer.md").read_text()
    table = page.split("## ENCODED", 1)[1].split("\n## ", 1)[0]
    return {m.group(1).strip(): m.group(2) for m in re.finditer(r"(?m)^\| ([^|]+) \| (.+) \|$", table)
            if m.group(1).strip() not in ("Area", "---")}


def _numbers(text):
    text = re.sub(r"\([^)]*\)", "", text)
    text = re.sub(r"\b(?:nn?|art)\.\s*\d+(?:\s*[–-]\s*\d+)?(?:,\s*\d+)*", "", text)
    text = re.sub(r"§§?\s*\d+(?:\s*[–-]\s*\d+)?", "", text)
    out = set()
    for a, b in re.findall(r"\b(\d+)(?:\s*[–-]\s*(\d+))?\b", text):
        out |= set(range(int(a), int(b or a) + 1))
    return out


def _norm_ids():
    tag = re.compile(r"(?m)^%\s*@norm\s+(\S+)")
    return sorted({i for f in engine.LP_DIR.glob("*.lp") for i in tag.findall(f.read_text())})


def test_every_norm_is_listed_as_encoded():
    rows = _encoded_rows()
    outside = {"Code of 1917", "Eastern Code", "outside the codes"}
    latin = set().union(*(_numbers(t) for k, t in rows.items() if k not in outside))
    where = {"cic1917": _numbers(rows["Code of 1917"]), "cceo": _numbers(rows["Eastern Code"])}
    missing = []
    for nid in _norm_ids():
        code, _, rest = nid.partition(":")
        m = re.match(r"(cceo)?(\d+)", rest)
        if nid in NOT_LAW:
            continue
        if code in NAMED:
            word = NAMED[code].format(n=m.group(2) if m else "")
            if word not in " ".join(rows.values()) or (code == "gnly" and int(m.group(2)) not in _numbers(
                    rows["outside the codes"].split("Liturgical Year", 1)[1])):
                missing.append(nid)
            continue
        if not m:
            missing.append(nid)
            continue
        n = int(m.group(2))
        pool = where["cceo"] if (code == "cceo" or m.group(1)) else where.get(code, latin if code in LATIN else set())
        if n not in pool:
            missing.append(nid)
    assert not missing, f"docs/canon-law-layer.md ENCODED lacks {missing}"
