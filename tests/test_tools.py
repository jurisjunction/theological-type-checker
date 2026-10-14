"""tools/sync: main from GitHub to Radicle, and nothing when the folder is
not clean (run against throwaway repositories standing in for both)."""
import pathlib
import shutil
import subprocess

import pytest

SYNC = pathlib.Path(__file__).resolve().parent.parent / "tools" / "sync"
ID = ["-c", "user.name=t", "-c", "user.email=t@example.org"]


def git(cwd, *args):
    return subprocess.run(["git", *ID, *args], cwd=cwd, check=True, capture_output=True, text=True).stdout.strip()


def sync(cwd):
    return subprocess.run(["sh", str(SYNC)], cwd=cwd, capture_output=True, text=True)


@pytest.fixture
def repos(tmp_path):
    if not shutil.which("git"):
        pytest.skip("no git")
    seed, origin, rad, work = (tmp_path / n for n in ("seed", "origin.git", "rad.git", "work"))
    for bare in (origin, rad):
        git(tmp_path, "init", "-q", "--bare", "-b", "main", str(bare))
    git(tmp_path, "init", "-q", "-b", "main", str(seed))
    (seed / "a").write_text("1\n")
    git(seed, "add", "a")
    git(seed, "commit", "-q", "-m", "first")
    git(seed, "push", "-q", str(origin), "main")
    git(tmp_path, "clone", "-q", str(origin), str(work))
    git(work, "remote", "add", "rad", str(rad))
    (seed / "a").write_text("2\n")
    git(seed, "commit", "-q", "-am", "second")
    git(seed, "push", "-q", str(origin), "main")          # GitHub moves on
    return seed, origin, rad, work


def test_sync_brings_main_from_github_to_radicle(repos):
    seed, origin, rad, work = repos
    r = sync(work)
    assert r.returncode == 0, r.stderr
    head = git(origin, "rev-parse", "main")
    assert git(work, "rev-parse", "HEAD") == head == git(rad, "rev-parse", "main")
    assert "from GitHub to Radicle" in r.stdout
    assert sync(work).returncode == 0                      # again: nothing to move


@pytest.mark.parametrize("make_unclean,why", [
    (lambda w: (w / "new").write_text("x\n"), "not committed"),
    (lambda w: (w / "a").write_text("edited\n"), "not committed"),
    (lambda w: git(w, "switch", "-q", "-c", "pc/topic"), "not main"),
    (lambda w: ((w / "a").write_text("mine\n"), git(w, "commit", "-q", "-am", "local")), "commits GitHub lacks"),
])
def test_sync_changes_nothing_unless_the_folder_is_clean(repos, make_unclean, why):
    seed, origin, rad, work = repos
    before = git(work, "rev-parse", "HEAD")
    make_unclean(work)
    r = sync(work)
    assert r.returncode == 1 and why in r.stderr
    assert subprocess.run(["git", "rev-parse", "--verify", "-q", "main"], cwd=rad, capture_output=True).returncode != 0
    if why != "commits GitHub lacks":
        assert git(work, "rev-parse", "HEAD") == before
