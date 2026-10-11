"""The boot and pair tables of TTC-SCHOOLS(7), pinned. Slow (about six minutes):

    TTC_SLOW=1 pytest -q tests/test_schools.py
"""
import os

import pytest

os.environ["TTC_HOME"] = ""
from theological_type_checker.schools import Experiment  # noqa: E402

pytestmark = pytest.mark.skipif(not os.environ.get("TTC_SLOW"), reason="slow: set TTC_SLOW=1")

# The theory's scenarios gain bridge_without_mode(principle,div) wherever the Latin
# license is absent (RESULTS, "not predicted"); the rest is as predicted.
THEORY_RED = {"L2", "L4", "M2", "M3", "M4", "S2", "S7", "S8", "S9", "X5b"}

BOOT_B = {
    "thomist": (["AN4", "FQ13", "FQ19", "K7", "K9", "UN1", "UN2"], ["FQ19"]),
    "scotist": ([], []),
    "suarezian": (["AN4", "FQ19"], ["FQ19"]),
}
PAIRS = {
    ("thomist", "scotist"): ["composition_in_god", "received_esse_without_real_distinction"],
    ("thomist", "suarezian"): ["received_esse_without_real_distinction"],
    ("thomist", "palamite"): ["composition_in_god", "persons_not_distinguished"],
    ("scotist", "suarezian"): ["composition_in_god"],
    ("scotist", "palamite"): ["composition_in_god"],
    ("suarezian", "palamite"): ["composition_in_god", "persons_not_distinguished"],
}


@pytest.fixture(scope="module")
def x():
    return Experiment()


@pytest.mark.parametrize("rt", sorted(BOOT_B))
def test_boot(x, rt):
    b = x.boot(rt)
    assert (b["changed"], b["red"]) == BOOT_B[rt]


def test_boot_palamite(x):
    b = x.boot("palamite")
    trinity_or_fixture = {s["id"] for s in x.scen if {"trinity", "augustine", "lateran"} & set(s["parts"])}
    assert set(b["red"]) - trinity_or_fixture == THEORY_RED


# Bare, no creature acts, so no human act and no penalty (TTC-ACT L4): the
# scenarios that expect the SSPX penalties turn red there too.
NO_HUMAN_ACT = {"PR1", "SX11", "SX15", "SX22"}


def test_bare(x):
    b = x.boot("bare")
    named = {"M1", "M5", "AN1", "FQ18", "FQ19", "T1", "K1", "K2"}
    assert named <= set(b["red"])
    assert set(b["red"]) - named == THEORY_RED | NO_HUMAN_ACT


@pytest.mark.parametrize("pair", sorted(PAIRS))
def test_pair(x, pair):
    assert sorted(x.clashes(*pair)) == PAIRS[pair]


def test_dh1330_deposit():
    from theological_type_checker import suite
    from theological_type_checker.schools import encoding, run
    # RT13, RT14 probe encoding A themselves. The creed group, written after the stamp, is left out: under
    # encoding A it gains the expected undistinguished persons in CR1e (as FQ19) and CR2b, and turns nothing red.
    scen = [s for s in suite.S if s["group"] not in (suite.RT, suite.CR)]
    with encoding(True):
        a = {s["id"]: run(s) for s in scen}
    b = {s["id"]: run(s) for s in scen}
    assert sorted(i for i in a if a[i][0] != b[i][0]) == ["AN4", "FQ1", "FQ19", "FQ3", "FQ7", "FQ8",
                                                           "TH14", "TH15", "TH15c", "TH20b"]
    newly_red = sorted(i for i in a if not a[i][2] and b[i][2])
    assert newly_red == ["FQ1", "FQ19", "FQ3", "FQ4", "FQ7", "TH14", "TH15", "TH15c", "TH20b"]
