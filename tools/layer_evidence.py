"""Evidence for docs/layers.md: every statement of the given rule files, what it
cites, which sorts it touches, and its blast radius (the scenarios that turn red
when it alone is deleted).

    python tools/layer_evidence.py OUT.json kernel_core.lp,kernel_analogy.lp,icon_theory.lp

Takes about half an hour on two cores. The layer labels are a judgment and live
in docs/layers.csv; this script only gathers the evidence they are checked against.
"""
import json, os, re, sys
from multiprocessing import Pool
os.environ["TTC_HOME"] = ""
import theological_type_checker.engine as E

FILES = sys.argv[2].split(",")
OUT = sys.argv[1]

def theory_parts():
    """The theory's parts: every #program that declares uses(icon)."""
    out = set()
    for f in E.LP_DIR.glob("*.lp"):
        body = re.sub(r"%.*", "", f.read_text())
        chunks = re.split(r"(?m)^#program\s+(\w+)", body)
        out |= {chunks[i] for i in range(1, len(chunks), 2) if "uses(icon)" in chunks[i + 1]}
    return out
APP_PREDS = {"nupt", "consent", "held_for", "proposed_bond", "capable_closing", "closed_in_act", "total",
             "side_by_side", "intense", "bridegroom", "valid_bond", "bond", "counter_phase", "welcomed",
             "needs_welcome", "called_bridal", "circuit", "performs", "claimed_counter_phase", "sterile",
             "impeded", "self_gift_measure", "denies_image", "stage", "married"}

def statements(path):
    text = (E.LP_DIR / path).read_text()
    out, i, n, start, prog = [], 0, len(text), None, "base"
    while i < n:
        c = text[i]
        if c == "%":
            j = text.find("\n", i); i = n if j < 0 else j
            continue
        if start is None and not c.isspace():
            start = i
        if c == "." and start is not None and text[i:i+2] != ".." and text[i-1] != ".":
            stmt = text[start:i+1]
            line = text.count("\n", 0, start) + 1
            lstart = text.rfind("\n", 0, start) + 1
            lend = text.find("\n", i); lend = n if lend < 0 else lend
            comment = " ".join(m.strip() for m in re.findall(r"%(.*)", text[lstart:lend]))
            if stmt.lstrip().startswith("#program"):
                prog = stmt.split()[1].rstrip(".")
            elif not stmt.lstrip().startswith("#"):
                out.append(dict(file=path, span=(start, i + 1), line=line, text=" ".join(stmt.split()),
                                program=prog, comment=comment))
            start = None
        i += 1
    return out

_SPAN = None
_orig = E.base_texts
def patched():
    t = _orig()
    if _SPAN:
        f, (a, b) = _SPAN
        s = t[f]
        t[f] = s[:a] + " " * (b - a) + s[b:]
    return t
E.base_texts = patched

def work(st):
    global _SPAN
    from theological_type_checker import suite
    _SPAN = (st["file"], tuple(st["span"]))
    try:
        rows = suite.run()
        red = [r["id"] for r in rows if not r["ok"]]
    except Exception as e:
        red = ["ERROR:" + str(e)[:80]]
    _SPAN = None
    return red

if __name__ == "__main__":
    from theological_type_checker import suite
    app_ids = {s["id"] for s in suite.S if theory_parts() & set(s["parts"])}
    groups = {s["id"]: s["group"] for s in suite.S}
    sorts = {p: s for f in ("kernel_analogy.lp", "icon_theory.lp") for p, s in re.findall(r"sort_of\((\w+),(\w+)\)", (E.LP_DIR / f).read_text())}
    sts = [s for f in FILES for s in statements(f)]
    print(len(sts), "statements", flush=True)
    with Pool(2) as pool:
        reds = pool.map(work, sts, chunksize=4)
    for s, red in zip(sts, reds):
        preds = set(re.findall(r"(\w+)\(", s["text"]))
        s["sorts"] = sorted({sorts[p] for p in preds if p in sorts})
        s["app_preds"] = sorted(preds & APP_PREDS)
        s["red"] = red
        s["red_app"] = sorted(r for r in red if r in app_ids)
        s["red_free"] = sorted(r for r in red if r not in app_ids)
        s["red_groups"] = sorted({groups.get(r, r) for r in red})
        s["span"] = list(s["span"])
    json.dump(sts, open(OUT, "w"), indent=1)
    print("done", flush=True)
