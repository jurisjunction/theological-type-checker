# TTC-LIBRARY(1)

## NAME

**ttc-library** — fetch list of physical copies, nearest library first

## SYNOPSIS

```
ttc-library [part ...] [--near lat,lon | place] [--per-item n] [--no-reading] [--csv file]
```

## DESCRIPTION

**ttc-library** lists the books a case still depends on:

- works its sources are read in (`cites_work/3`) that are not reliably
  online and not yet `consulted/1`
- research the theory still owes (`to_read/2`)

For each work it does the following:

1. Resolves identifiers through Open Library (free).
2. Finds holdings through the WorldCat Search API v2, if credentials are
   set.
3. Ranks holding libraries by great-circle distance from you.

The output is grouped by nearest library: a pull list for each building.
Works it cannot place get WorldCat links.

With no parts, the whole base is listed.

## OPTIONS

| Option | Meaning |
| --- | --- |
| `--near` | `lat,lon`, or a place name, which is geocoded. Default `$TTC_LOCATION`. |
| `--per-item` | Holding libraries per work (default 3). |
| `--no-reading` | Sources to verify only; skip research reading. |
| `--csv` | Also write CSV. |

## ENVIRONMENT

| Variable | Meaning |
| --- | --- |
| `OCLC_CLIENT_ID`, `OCLC_CLIENT_SECRET` | WorldCat Search API v2 (client credentials, scope `wcapi`). |
| `OCLC_API_BASE` | Default `https://americas.discovery.api.oclc.org/worldcat/search/v2`. |
| `TTC_LOCATION` | Your `lat,lon`. Used locally; never sent. |
| `TTC_HELD_IN` | `US` or `US-NY`: limit holdings to a country or state. |

## FILES

| File | Contents |
| --- | --- |
| `lp/library.lp` | `work/5`, `cites_work/3`, `online/2`, `to_read/2`, `to_fetch/2` |
| `~/.ttc/rules/consulted.lp` | your `consulted/1` facts, written by `mark_consulted` |

## EXAMPLES

```
ttc-library ic --near 41.90,12.45
ttc-library sspx remarriage --near "Piazza della Pilotta 4, Roma" --csv pull.csv
```

## DIAGNOSTICS

- *No OCLC credentials*: holdings are not looked up, and links are given
  instead.
- *No location*: libraries are not ranked by distance.
- *WorldCat unavailable*: the token request failed. Check the key.

## SECURITY

A place name is sent to OpenStreetMap Nominatim. Coordinates are sent
nowhere. Titles and authors go to Open Library and, with credentials, to
OCLC.

## SEE ALSO

[ttc-flywheel(7)](flywheel.md), [WorldCat](https://search.worldcat.org/),
[Open Library](https://openlibrary.org/developers/api)

## CAVEATS

WorldCat Search API access comes through a library's OCLC subscription.
Ask yours for a key. Individuals usually cannot get one.

Holdings are not call numbers. The catalogue link gets you to the shelf.

## BUGS

The WorldCat client is written to OCLC's documented interface and tested
against recorded responses. It has not been run against the live service,
which could not be reached from the machine it was built on. Report what it
gets wrong.

No ISBN is entered by hand; all are resolved at run time. Old editions
resolve badly. Patristic and medieval *Opera omnia* resolve worse.
