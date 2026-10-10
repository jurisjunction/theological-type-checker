"""Command-line check, for use without an MCP client.

    ttc-check sspx lattice                    # run parts, print the digest as JSON
    ttc-check --facts my_case.lp              # your own facts, alone
    ttc-check remarriage --facts extra.lp --branches 10
"""
import argparse
import json
import pathlib
import sys

from . import engine


def main(argv=None):
    ap = argparse.ArgumentParser(prog="ttc-check", description="Run the theological type checker.")
    ap.add_argument("parts", nargs="*", help="#program parts to switch on")
    ap.add_argument("--facts", type=pathlib.Path, help="a file of facts and rules (ASP)")
    ap.add_argument("--branches", type=int, default=30, help="how many branches to list")
    ap.add_argument("--list", action="store_true", help="list the available parts and exit")
    a = ap.parse_args(argv)
    if a.list:
        for name, f in sorted(engine.known_parts().items()):
            print(f"{name:28} {f}")
        return 0
    facts = a.facts.read_text() if a.facts else ""
    try:
        r = engine.run_checked(a.parts, facts)
    except engine.SnippetError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 2
    print(json.dumps(engine.summary(r, a.branches), indent=2, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    sys.exit(main())
