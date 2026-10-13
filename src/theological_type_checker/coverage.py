"""How much of the Catechism the base touches (TTC-COVERAGE(7)).

    python -m theological_type_checker.coverage            # print the report
    python -m theological_type_checker.coverage --write    # write docs/coverage.md

The outline is the Catechism's own, by article (by paragraph where an
article is long). Each unit's status is the encoder's judgment, pinned to
scenarios that exist (a test checks them):

    rules     a kernel or library rule encodes some of the unit's teaching
    case      a case, a candidate or a fixture touches it; no rule of its own
    frontier  nothing yet

Citations of the Catechism in the rule files are found by scanning, not
entered by hand. The report says what the base touches, not how well.
"""
from __future__ import annotations

import pathlib
import re
import sys

from . import engine

# (key, title, first, last); the leaves of the outline, in order.
OUTLINE = [
    ("prologue", "Prologue", 1, 25),
    # Part One: The Profession of Faith
    ("1.1.1", "Man's capacity for God", 27, 49),
    ("1.1.2.1", "The revelation of God", 51, 73),
    ("1.1.2.2", "The transmission of divine revelation", 74, 100),
    ("1.1.2.3", "Sacred Scripture", 101, 141),
    ("1.1.3.1", "I believe", 144, 165),
    ("1.1.3.2", "We believe", 166, 184),
    ("1.2.0", "The creeds", 185, 197),
    ("1.2.1.p1", "I believe in God", 199, 231),
    ("1.2.1.p2", "The Father", 232, 267),
    ("1.2.1.p3", "The Almighty", 268, 278),
    ("1.2.1.p4", "The Creator", 279, 324),
    ("1.2.1.p5", "Heaven and earth", 325, 354),
    ("1.2.1.p6", "Man", 355, 384),
    ("1.2.1.p7", "The Fall", 385, 421),
    ("1.2.2.a2", "And in Jesus Christ, his only Son, our Lord", 430, 455),
    ("1.2.2.a3p1", "The Son of God became man", 456, 483),
    ("1.2.2.a3p2", "Conceived by the Holy Spirit, born of the Virgin Mary", 484, 511),
    ("1.2.2.a3p3", "The mysteries of Christ's life", 512, 570),
    ("1.2.2.a4p1", "Jesus and Israel", 574, 594),
    ("1.2.2.a4p2", "Jesus died crucified", 595, 623),
    ("1.2.2.a4p3", "Jesus Christ was buried", 624, 630),
    ("1.2.2.a5p1", "Christ descended into hell", 632, 637),
    ("1.2.2.a5p2", "On the third day he rose from the dead", 638, 658),
    ("1.2.2.a6", "He ascended into heaven and is seated at the right hand", 659, 667),
    ("1.2.2.a7", "He will come again to judge the living and the dead", 668, 682),
    ("1.2.3.a8", "I believe in the Holy Spirit", 687, 747),
    ("1.2.3.a9p1", "The Church in God's plan", 751, 780),
    ("1.2.3.a9p2", "People of God, Body of Christ, Temple of the Spirit", 781, 810),
    ("1.2.3.a9p3", "One, holy, catholic and apostolic", 811, 870),
    ("1.2.3.a9p4", "Hierarchy, laity, consecrated life", 871, 945),
    ("1.2.3.a9p5", "The communion of saints", 946, 962),
    ("1.2.3.a9p6", "Mary, Mother of Christ, Mother of the Church", 963, 975),
    ("1.2.3.a10", "The forgiveness of sins", 976, 987),
    ("1.2.3.a11", "The resurrection of the body", 988, 1019),
    ("1.2.3.a12", "Life everlasting", 1020, 1060),
    ("1.2.3.amen", "Amen", 1061, 1065),
    # Part Two: The Celebration of the Christian Mystery
    ("2.1.1.a1", "The liturgy, work of the Holy Trinity", 1077, 1112),
    ("2.1.1.a2", "The paschal mystery in the Church's sacraments", 1113, 1134),
    ("2.1.2.a1", "Celebrating the Church's liturgy", 1136, 1199),
    ("2.1.2.a2", "Liturgical diversity and the unity of the mystery", 1200, 1209),
    ("2.2.1.a1", "Baptism", 1213, 1284),
    ("2.2.1.a2", "Confirmation", 1285, 1321),
    ("2.2.1.a3", "The Eucharist", 1322, 1419),
    ("2.2.2.a4", "Penance and reconciliation", 1422, 1498),
    ("2.2.2.a5", "The anointing of the sick", 1499, 1532),
    ("2.2.3.a6", "Holy orders", 1536, 1600),
    ("2.2.3.a7", "Matrimony", 1601, 1666),
    ("2.2.4.a1", "Sacramentals", 1667, 1679),
    ("2.2.4.a2", "Christian funerals", 1680, 1690),
    # Part Three: Life in Christ
    ("3.1.1.a1", "Man: the image of God", 1701, 1715),
    ("3.1.1.a2", "Our vocation to beatitude", 1716, 1729),
    ("3.1.1.a3", "Man's freedom", 1730, 1748),
    ("3.1.1.a4", "The morality of human acts", 1749, 1761),
    ("3.1.1.a5", "The morality of the passions", 1762, 1775),
    ("3.1.1.a6", "Moral conscience", 1776, 1802),
    ("3.1.1.a7", "The virtues", 1803, 1845),
    ("3.1.1.a8", "Sin", 1846, 1876),
    ("3.1.2.a1", "The person and society", 1878, 1896),
    ("3.1.2.a2", "Participation in social life", 1897, 1927),
    ("3.1.2.a3", "Social justice", 1928, 1948),
    ("3.1.3.a1", "The moral law", 1950, 1986),
    ("3.1.3.a2", "Grace and justification", 1987, 2029),
    ("3.1.3.a3", "The Church, mother and teacher", 2030, 2051),
    ("3.2.1.a1", "The first commandment", 2084, 2141),
    ("3.2.1.a2", "The second commandment", 2142, 2167),
    ("3.2.1.a3", "The third commandment", 2168, 2195),
    ("3.2.2.a4", "The fourth commandment", 2197, 2257),
    ("3.2.2.a5", "The fifth commandment", 2258, 2330),
    ("3.2.2.a6", "The sixth commandment", 2331, 2400),
    ("3.2.2.a7", "The seventh commandment", 2401, 2463),
    ("3.2.2.a8", "The eighth commandment", 2464, 2513),
    ("3.2.2.a9", "The ninth commandment", 2514, 2533),
    ("3.2.2.a10", "The tenth commandment", 2534, 2557),
    # Part Four: Christian Prayer
    ("4.1.1.a1", "Prayer in the Old Testament", 2568, 2597),
    ("4.1.1.a2", "Prayer in the fullness of time", 2598, 2622),
    ("4.1.1.a3", "Prayer in the age of the Church", 2623, 2649),
    ("4.1.2.a1", "At the wellsprings of prayer", 2652, 2662),
    ("4.1.2.a2", "The way of prayer", 2663, 2682),
    ("4.1.2.a3", "Guides for prayer", 2683, 2696),
    ("4.1.3.a1", "Expressions of prayer", 2700, 2724),
    ("4.1.3.a2", "The battle of prayer", 2725, 2745),
    ("4.1.3.a3", "The prayer of the hour of Jesus", 2746, 2758),
    ("4.2.a1", "The summary of the whole Gospel", 2761, 2776),
    ("4.2.a2", "Our Father who art in heaven", 2777, 2802),
    ("4.2.a3", "The seven petitions", 2803, 2854),
    ("4.2.a4", "The final doxology", 2855, 2865),
]

PARTS = [("1", "Part One: The Profession of Faith", 26, 1065),
         ("2", "Part Two: The Celebration of the Christian Mystery", 1066, 1690),
         ("3", "Part Three: Life in Christ", 1691, 2557),
         ("4", "Part Four: Christian Prayer", 2558, 2865)]

# key -> (status, scenarios that exercise it, what the base holds). Units not
# listed are frontier.
COVER = {
    "1.1.2.2": ("rules", ["CS2", "CS2b", "CS4", "B14"], "tier 0 read only through its readings; the teaching office; the tiers"),
    "1.1.3.1": ("rules", ["NT3", "FD2", "FD3"], "the note de fide; heresy only after the definition; one article denied, none held by faith"),
    "1.1.3.2": ("rules", ["NT2", "NT4", "TC1"], "what the Church proposes as revealed (CCC 182); tiers computed, not asserted"),
    "1.1.2.3": ("rules", ["CS2", "CS2c", "CS3", "CS3b"], "inerrancy; senses defined; the analogy of faith"),
    "1.2.0": ("rules", ["CR1", "CR1b", "CR1d"], "the creeds at tier 1, dated"),
    "1.2.1.p1": ("rules", ["TH0", "K5"], "the attributes as defined; no demiurge"),
    "1.2.1.p2": ("rules", ["M1", "FQ1", "RT1", "TH20"], "the processions, one principle, distinction by relation"),
    "1.2.1.p4": ("rules", ["K1", "K5", "RT2", "B6"], "being from God alone; creatures act; de auxiliis protected"),
    "1.2.1.p5": ("rules", ["K1", "K10", "K12"], "angels as created persons"),
    "1.2.1.p6": ("rules", ["K11", "X1"], "the image, not graded"),
    "1.2.1.p7": ("rules", ["CE1", "CE1c", "CE1e"], "original sin by propagation; why Christ is free"),
    "1.2.2.a2": ("rules", ["CR2", "CR2d"], "the incarnate is the Son"),
    "1.2.2.a3p1": ("rules", ["CR3", "CR5", "CR6", "CR7a", "CH1", "CH1c"], "two natures, wills, operations; acts by a nature"),
    "1.2.2.a3p2": ("rules", ["CM1b", "CS3", "B5", "CE1d"], "ever-virgin; the Immaculate Conception's history"),
    "1.2.2.a4p2": ("rules", ["CE0", "CE2", "MD4"], "the economy's order; merits foreseen; God's act not dated, its effects are (CCC 600)"),
    "1.2.2.a4p3": ("case", ["CE0"], "the economy's order"),
    "1.2.2.a5p1": ("case", ["CE0"], "the economy's order"),
    "1.2.2.a5p2": ("case", ["CE0", "CE3"], "risen after he died"),
    "1.2.2.a6": ("rules", ["PM1", "PM2"], "at the right hand by the natural mode"),
    "1.2.2.a7": ("rules", ["CE0", "OR2", "OR2b"], "return and judgment in the order; the end neither dated nor past (CCC 673, 1040)"),
    "1.2.3.a8": ("rules", ["FQ1", "RT1", "CR1"], "the procession of the Spirit"),
    "1.2.3.a9p3": ("rules", ["FC1", "FC2", "EC1", "EC6", "EC9", "EC10"],
                   "incorporation (c. 96) and full communion (c. 205); subsistit in; 'outside the Church'"),
    "1.2.3.a9p4": ("rules", ["B10", "B12", "B14"], "the teaching office's tiers and forms (LG 25)"),
    "1.2.3.a9p6": ("rules", ["CM3", "CH2b"], "the Assumption; Mary without actual sin"),
    "1.2.3.a10": ("case", ["CS2"], "Jn 20:23 read sacramentally"),
    "2.1.1.a2": ("rules", ["SM4", "SM8", "SM6b"], "ex opere operato; the character; the fruit and disposition"),
    "2.1.2.a1": ("case", ["LT3", "G1"], "liturgical law: the old Missal, translations"),
    "2.1.2.a2": ("rules", ["LT5", "LT6", "AS1", "AS2"], "lex orandi typed as teaching or governance; the Churches sui iuris and their rites, ascription choosing the code"),
    "2.2.1.a1": ("rules", ["SM2", "SM5", "SM8", "SM9", "L2"], "matter, form, character, fruit, infants"),
    "2.2.1.a2": ("rules", ["SM6b", "CF1"], "the minister, a presbyter by law or faculty; the character"),
    "2.2.1.a3": ("rules", ["PM1", "PM4", "PM6", "MS3", "MS5", "CS4"], "presence; cc. 915-916; Jn 6"),
    "2.2.2.a4": ("rules", ["SX15", "SX20", "SM7", "SM2"], "absolution's validity; faculties; the seal"),
    "2.2.2.a5": ("rules", ["SM6b"], "the minister"),
    "2.2.3.a6": ("rules", ["SM6", "SM6c", "EC2"], "consecration and character; Anglican orders"),
    "2.2.3.a7": ("rules", ["SM10", "SM10b", "SM10c", "AC9", "DR1", "IM1", "IM2", "IM3"], "consent and form, across the codes; dissolution and nullity; remarriage"),
    "3.1.1.a1": ("rules", ["K11", "X3"], "the image; personhood"),
    "3.1.1.a3": ("rules", ["AC1", "AC5", "AC8"], "imputability, ignorance, fear"),
    "3.1.1.a4": ("rules", ["MS1", "MS2", "MS2c", "VD1", "DI2"], "the sources of morality; double effect; may, must not; \"direct\" as a reading"),
    "3.1.1.a5": ("rules", ["AC3"], "undeliberate passion mitigates"),
    "3.1.1.a8": ("rules", ["MS1", "MS1b", "CH2", "FL2"], "mortal and venial, on the claims; structures of sin said by analogy, never of a collective (CCC 1869)"),
    "3.1.2.a1": ("rules", ["FL1", "FL2", "FL4"], "a society a unity of order: juridic persons act through persons, with no interior, sin or delict (cc. 113-118; CCC 1880)"),
    "3.1.2.a2": ("rules", ["LW3", "LW5"], "a law against a higher law does not bind"),
    "3.1.3.a1": ("rules", ["LW1", "LW4", "LW7", "LW7b", "OB1", "OB2"], "eternal, natural, divine and human law; affirmative precepts"),
    "3.1.3.a2": ("rules", ["GR1", "GR2", "GR3", "GR4", "GR5", "GR6", "B6"], "necessity, cooperation, efficacy, resisted grace"),
    "3.1.3.a3": ("rules", ["B10", "B12", "DR3"], "the magisterium in morals"),
    "3.2.1.a1": ("rules", ["FD1", "FD5", "CN2", "SX8"], "heresy, apostasy and schism (CCC 2089; c. 751); dissent, not schism"),
    "3.2.2.a5": ("rules", ["DP1", "DP2", "DP5", "SD1", "MS2", "MS2b", "DI3", "DI4", "DI5", "SD3", "AB1", "AB4"],
                 "the death penalty's history and verdict; legitimate defence; abortion and its penalty (c. 1397 §2; CCC 2272); just war"),
    "3.2.2.a6": ("rules", ["DI6", "DR1", "K11"], "IVF \"must not\" (Donum vitae); remarriage; the embryo's image"),
    "3.2.2.a7": ("rules", ["SD2", "SD2b", "SD4"], "usury as two questions; social teaching typed (CCC 2423)"),
    "3.2.2.a8": ("rules", ["SM7", "SM7c"], "the seal"),
    "4.2.a2": ("case", ["PM5"], "'in heaven' is no place (CCC 2794): God located refused"),
}

CITE = re.compile(r"CCC\s+(\d{1,4}(?:\s*[-–]\s*\d{1,4})?(?:\s*,\s*\d{1,4}(?:\s*[-–]\s*\d{1,4})?)*)")


def cited_paragraphs() -> set[int]:
    """Catechism paragraphs cited in the rule files (comments included)."""
    out = set()
    for f in engine.FILES:
        for m in CITE.finditer((engine.LP_DIR / f).read_text()):
            for piece in m.group(1).split(","):
                a, _, b = piece.replace("–", "-").partition("-")
                lo, hi = int(a), int(b or a)
                out.update(range(lo, hi + 1))
    return out


def rows():
    cited = cited_paragraphs()
    for key, title, lo, hi in OUTLINE:
        status, scen, note = COVER.get(key, ("frontier", [], ""))
        nc = sum(1 for n in range(lo, hi + 1) if n in cited)
        yield dict(key=key, title=title, lo=lo, hi=hi, n=hi - lo + 1, status=status, scen=scen, note=note, cited=nc)


def report() -> str:
    rs = list(rows())
    by = {s: sum(1 for r in rs if r["status"] == s) for s in ("rules", "case", "frontier")}
    cited = cited_paragraphs()
    out = ["# TTC-COVERAGE(7)", "", "## NAME", "",
           "**ttc-coverage** — how much of the Catechism the base touches", "",
           "## DESCRIPTION", "",
           "The Catechism's outline, by article, with what the rule base holds of",
           "each. Generated by `python -m theological_type_checker.coverage --write`;",
           "a test checks the file is current and every scenario named exists.", "",
           "| Status | Meaning |", "| --- | --- |",
           "| rules | a kernel or library rule encodes some of the unit's teaching |",
           "| case | a case, a candidate or a fixture touches it; no rule of its own |",
           "| frontier | nothing yet |", "",
           "## SUMMARY", "",
           f"Of {len(rs)} units: {by['rules']} touched by rules, {by['case']} by cases only,",
           f"{by['frontier']} frontier. A unit counts as touched if one rule reaches",
           "it, so this measures reach, not depth. The rule files cite",
           f"{len(cited)} of the Catechism's 2,865 paragraphs by number (the column",
           "\"Cited\"). The Prologue (1–25) is frontier.", ""]
    for _pk, ptitle, plo, phi in PARTS:
        prs = [r for r in rs if plo <= r["lo"] <= phi]
        nr = sum(1 for r in prs if r["status"] == "rules")
        nc = sum(1 for r in prs if r["status"] == "case")
        out += [f"## {ptitle.upper()}", "", f"{len(prs)} units: {nr} under rules, {nc} under cases only, "
                f"{len(prs) - nr - nc} frontier.", "",
                "| CCC | Unit | Status | Cited | Scenarios | The base holds |", "| --- | --- | --- | --- | --- | --- |"]
        for r in prs:
            out.append(f"| {r['lo']}–{r['hi']} | {r['title']} | {r['status']} | {r['cited'] or ''} | "
                       f"{', '.join(r['scen'])} | {r['note']} |")
        out.append("")
    out += ["## CAVEATS", "",
            "A status is the encoder's judgment and says what the base touches, not how",
            "well: one rule on a unit makes it \"rules\". Introductions between units",
            "are left out. The ranges follow the Catechism's numbering (1997).", "",
            "## SEE ALSO", "", "[ttc-roadmap(7)](roadmap.md), [ttc-findings(7)](findings.md)", ""]
    return "\n".join(out)


DOC = pathlib.Path(__file__).resolve().parents[2] / "docs" / "coverage.md"


def main(argv=None):
    argv = sys.argv[1:] if argv is None else argv
    text = report()
    if "--write" in argv:
        DOC.write_text(text)
        print(f"wrote {DOC}")
    else:
        print(text)


if __name__ == "__main__":
    main()
