"""Physical-copy fetch lists, with the nearest library holding each work.

What to fetch is derived in the rule base (library.lp): works that encoded
sources are read in, not yet consulted and not reliably online, plus
research the theory still owes. This module turns that into a list a
person can take to a library:

1. Resolve each work to identifiers: Open Library (free) for ISBNs and OCLC
   numbers; WorldCat search when credentials are available.
2. Find holdings: WorldCat Search API v2 (requires an OCLC WSKey with
   access to it, usually through a library), restricted to a country or
   state if configured.
3. Rank holding libraries by great-circle distance from the reader.
4. Group the list by library, nearest first, with WorldCat links for
   anything unresolved.

Environment:
    OCLC_CLIENT_ID, OCLC_CLIENT_SECRET   WorldCat Search API v2 credentials
    OCLC_API_BASE    default https://americas.discovery.api.oclc.org/worldcat/search/v2
    TTC_LOCATION     "lat,lon" of the reader (never sent anywhere)
    TTC_HELD_IN      ISO country (US) or state (US-NY) to narrow holdings

A place name instead of coordinates is geocoded with OpenStreetMap
Nominatim, which does send the name to that service.
"""
from __future__ import annotations

import base64
import csv
import io
import json
import math
import os
import re
import urllib.error
import urllib.parse
import urllib.request
from dataclasses import dataclass, field

from . import __version__, engine

UA = f"theological-type-checker/{__version__} (+https://github.com/jurisjunction/theological-type-checker)"
OCLC_TOKEN = "https://oauth.oclc.org/token"
OCLC_BASE = "https://americas.discovery.api.oclc.org/worldcat/search/v2"


def http(method, url, headers=None, data=None, timeout=20):
    """(status, body bytes). Replaced in tests."""
    req = urllib.request.Request(url, data=data, method=method, headers={"User-Agent": UA, **(headers or {})})
    try:
        with urllib.request.urlopen(req, timeout=timeout) as r:
            return r.status, r.read()
    except urllib.error.HTTPError as e:
        return e.code, e.read()
    except (urllib.error.URLError, TimeoutError, OSError) as e:
        return 0, str(e).encode()


@dataclass
class Work:
    id: str
    author: str
    title: str
    imprint: str
    year: int
    why: list = field(default_factory=list)
    isbns: list = field(default_factory=list)
    oclc: list = field(default_factory=list)
    holdings: list = field(default_factory=list)
    links: dict = field(default_factory=dict)


# ---------- what to fetch -------------------------------------------------
def _unq(s):
    return s[1:-1].replace('\\"', '"') if s.startswith('"') else s


def wanted(parts=None, include_reading=True) -> list[Work]:
    """Works to fetch, for the given parts (verification limited to the
    sources those parts use), or for the whole base."""
    works, fetch, used = {}, {}, set()
    r = engine.solve(list(parts or []), "one")
    for a in r["atoms"]:
        name, args = engine.split_args(a)
        if name == "work":
            works[args[0]] = Work(args[0], _unq(args[1]), _unq(args[2]), _unq(args[3]), int(args[4]))
        elif name == "to_fetch":
            fetch.setdefault(args[0], set()).add(args[1])
        elif name == "used_work":
            used.add((args[0], args[1]))
    out = []
    for w, whys in sorted(fetch.items()):
        reasons = []
        for why in sorted(whys):
            m = re.match(r'verify\((\w+),(".*")\)$', why)
            if m and (parts is None or (w, m.group(1)) in used):
                reasons.append(f"verify {m.group(1)} at {_unq(m.group(2))}")
            m = re.match(r'read\((".*")\)$', why)
            if m and include_reading:
                reasons.append(f"read: {_unq(m.group(1))}")
        if reasons and w in works:
            works[w].why = reasons
            out.append(works[w])
    return out


# ---------- identifiers -----------------------------------------------------
def resolve_openlibrary(w: Work, get=http) -> None:
    q = urllib.parse.urlencode({"title": w.title.split(",")[0][:120], "author": w.author.split(";")[0].split("(")[0].strip(),
                                "fields": "key,title,isbn,oclc,first_publish_year", "limit": 3})
    status, body = get("GET", f"https://openlibrary.org/search.json?{q}")
    if status != 200:
        return
    try:
        docs = json.loads(body).get("docs", [])
    except ValueError:
        return
    for d in docs:
        w.isbns += [i for i in d.get("isbn", []) if i not in w.isbns][:5]
        w.oclc += [o for o in d.get("oclc", []) if o not in w.oclc][:5]
        if d.get("key") and "openlibrary" not in w.links:
            w.links["openlibrary"] = "https://openlibrary.org" + d["key"]


def worldcat_token(client_id, secret, post=http):
    basic = base64.b64encode(f"{client_id}:{secret}".encode()).decode()
    status, body = post("POST", OCLC_TOKEN, {"Authorization": f"Basic {basic}",
                                             "Content-Type": "application/x-www-form-urlencoded"},
                        b"grant_type=client_credentials&scope=wcapi")
    if status != 200:
        raise RuntimeError(f"OCLC token request failed ({status}): {body[:200]!r}")
    return json.loads(body)["access_token"]


def worldcat_search(w: Work, token, get=http, base=None):
    base = base or os.environ.get("OCLC_API_BASE", OCLC_BASE)
    q = f'ti:"{w.title.split(",")[0][:100]}"'
    status, body = get("GET", f"{base}/bibs?{urllib.parse.urlencode({'q': q, 'limit': 3})}",
                       {"Authorization": f"Bearer {token}", "Accept": "application/json"})
    if status == 200:
        for rec in json.loads(body).get("bibRecords", []) or json.loads(body).get("briefRecords", []):
            num = (rec.get("identifier") or {}).get("oclcNumber") or rec.get("oclcNumber")
            if num and num not in w.oclc:
                w.oclc.append(str(num))


def _holding(h):
    a = h.get("address") or {}
    lat = a.get("lat", h.get("lat"))
    lon = a.get("lon", h.get("lon"))
    return {"name": h.get("institutionName") or h.get("name") or h.get("oclcSymbol"),
            "symbol": h.get("oclcSymbol"),
            "city": a.get("city") or h.get("city"), "region": a.get("state") or h.get("state"),
            "country": a.get("country") or h.get("country"),
            "lat": float(lat) if lat not in (None, "") else None, "lon": float(lon) if lon not in (None, "") else None}


def worldcat_holdings(oclc, token, get=http, base=None, held_in=None, limit=50):
    base = base or os.environ.get("OCLC_API_BASE", OCLC_BASE)
    params = {"oclcNumber": oclc, "limit": limit}
    held_in = held_in or os.environ.get("TTC_HELD_IN")
    if held_in:
        params["heldInState" if "-" in held_in else "heldInCountry"] = held_in
    status, body = get("GET", f"{base}/bibs-holdings?{urllib.parse.urlencode(params)}",
                       {"Authorization": f"Bearer {token}", "Accept": "application/json"})
    if status != 200:
        return []
    out = []
    for rec in json.loads(body).get("briefRecords", []):
        for h in (rec.get("institutionHolding") or {}).get("briefHoldings", []):
            out.append(_holding(h))
    return out


# ---------- location -----------------------------------------------------
def km(a, b):
    (la1, lo1), (la2, lo2) = a, b
    p1, p2 = math.radians(la1), math.radians(la2)
    dp, dl = p2 - p1, math.radians(lo2 - lo1)
    h = math.sin(dp / 2) ** 2 + math.cos(p1) * math.cos(p2) * math.sin(dl / 2) ** 2
    return 6371.0 * 2 * math.asin(math.sqrt(h))


def locate(near=None, get=http):
    """(lat, lon) from 'lat,lon', a place name (Nominatim), or TTC_LOCATION."""
    near = near or os.environ.get("TTC_LOCATION")
    if not near:
        return None
    m = re.match(r"^\s*(-?\d+(?:\.\d+)?)\s*,\s*(-?\d+(?:\.\d+)?)\s*$", near)
    if m:
        return float(m.group(1)), float(m.group(2))
    status, body = get("GET", "https://nominatim.openstreetmap.org/search?" +
                       urllib.parse.urlencode({"q": near, "format": "json", "limit": 1}))
    if status == 200:
        hits = json.loads(body)
        if hits:
            return float(hits[0]["lat"]), float(hits[0]["lon"])
    return None


def nearest(holdings, here, k=3):
    with_d = []
    for h in holdings:
        if here and h["lat"] is not None and h["lon"] is not None:
            with_d.append({**h, "km": round(km(here, (h["lat"], h["lon"])), 1)})
        else:
            with_d.append({**h, "km": None})
    with_d.sort(key=lambda h: (h["km"] is None, h["km"] if h["km"] is not None else 0, h["name"] or ""))
    return with_d[:k]


# ---------- the list ------------------------------------------------------------
def build(parts=None, near=None, per_item=3, include_reading=True, get=http):
    works = wanted(parts, include_reading)
    here = locate(near, get)
    cid, secret = os.environ.get("OCLC_CLIENT_ID"), os.environ.get("OCLC_CLIENT_SECRET")
    token, notes = None, []
    if cid and secret:
        try:
            token = worldcat_token(cid, secret, get)
        except (RuntimeError, ValueError, KeyError) as e:
            notes.append(f"WorldCat unavailable: {e}")
    else:
        notes.append("No OCLC credentials: holdings not looked up; WorldCat links given instead.")
    if not here:
        notes.append("No location: libraries are not ranked by distance.")
    for w in works:
        resolve_openlibrary(w, get)
        if token and not w.oclc:
            worldcat_search(w, token, get)
        if token:
            holdings = []
            for num in w.oclc[:3]:
                holdings += worldcat_holdings(num, token, get)
                if holdings:
                    break
            seen, uniq = set(), []
            for h in holdings:
                if (h["symbol"], h["name"]) not in seen:
                    seen.add((h["symbol"], h["name"]))
                    uniq.append(h)
            w.holdings = nearest(uniq, here, per_item)
        w.links["worldcat"] = (f"https://search.worldcat.org/title/{w.oclc[0]}" if w.oclc else
                               "https://search.worldcat.org/search?" + urllib.parse.urlencode({"q": f"{w.title} {w.author}"}))
    return {"location": here, "works": works, "notes": notes}


def to_markdown(report) -> str:
    lines = ["# Fetch list", ""]
    for n in report["notes"]:
        lines.append(f"*{n}*")
    if report["notes"]:
        lines.append("")
    if not report["works"]:
        lines.append("Nothing to fetch: every source is online or consulted.")
        return "\n".join(lines).rstrip() + "\n"
    by_lib = {}
    unplaced = []
    for w in report["works"]:
        if w.holdings:
            top = w.holdings[0]
            by_lib.setdefault((top["km"] if top["km"] is not None else 1e9, top["name"], top["city"]), []).append(w)
        else:
            unplaced.append(w)
    for (d, name, city), ws in sorted(by_lib.items(), key=lambda x: (x[0][0], x[0][1] or "")):
        dist = f", {d} km" if d < 1e9 else ""
        lines.append(f"## {name}{' (' + city + ')' if city else ''}{dist}")
        for w in ws:
            links = " · ".join(f"[{k}]({v})" for k, v in w.links.items())
            lines.append(f"- [ ] {w.author}, *{w.title}* ({w.imprint}, {w.year}). {'; '.join(w.why)}. {links}")
            for alt in w.holdings[1:]:
                lines.append(f"  - also: {alt['name']}" + (f", {alt['km']} km" if alt["km"] is not None else ""))
        lines.append("")
    if unplaced:
        lines.append("## Not yet placed")
        for w in unplaced:
            links = " · ".join(f"[{k}]({v})" for k, v in w.links.items())
            ids = f" OCLC {', '.join(w.oclc[:2])}." if w.oclc else ""
            lines.append(f"- [ ] {w.author}, *{w.title}* ({w.imprint}, {w.year}).{ids} {'; '.join(w.why)}. {links}")
    return "\n".join(lines).rstrip() + "\n"


def to_csv(report) -> str:
    buf = io.StringIO()
    wr = csv.writer(buf)
    wr.writerow(["work", "author", "title", "imprint", "year", "why", "oclc", "isbn", "library", "city", "km", "worldcat"])
    for w in report["works"]:
        h = w.holdings[0] if w.holdings else {}
        wr.writerow([w.id, w.author, w.title, w.imprint, w.year, " | ".join(w.why), " ".join(w.oclc[:3]),
                     " ".join(w.isbns[:3]), h.get("name", ""), h.get("city", ""), h.get("km", ""), w.links.get("worldcat", "")])
    return buf.getvalue()


def to_json(report):
    return {"location": report["location"], "notes": report["notes"],
            "works": [w.__dict__ for w in report["works"]]}


def main(argv=None):
    import argparse
    import sys
    ap = argparse.ArgumentParser(prog="ttc-library", description="Physical-copy fetch list, nearest library first.")
    ap.add_argument("parts", nargs="*", help="limit to these parts (default: every case)")
    ap.add_argument("--near", help="'lat,lon' or a place name (default: $TTC_LOCATION)")
    ap.add_argument("--per-item", type=int, default=3)
    ap.add_argument("--no-reading", action="store_true", help="only sources to verify, not research to read")
    ap.add_argument("--csv", help="also write a CSV file")
    a = ap.parse_args(argv)
    rep = build(a.parts or None, a.near, a.per_item, not a.no_reading)
    sys.stdout.write(to_markdown(rep))
    if a.csv:
        with open(a.csv, "w", newline="") as f:
            f.write(to_csv(rep))
    return 0
