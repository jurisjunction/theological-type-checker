# TTC-ARCHIVE(7)

## NAME

**ttc-archive** — where the work lives, and how to keep it open,
anonymous and permanent

## DESCRIPTION

The work is dedicated to the public domain (CC0 1.0). No one needs
permission to copy it, and no one need credit anyone. It carries no
author's name: the citation and the commits say *Ora pro me, peccatore*.

Copies are the defence. Each place below is free. None is enough alone.

| Place | Gives | Account | Decentralized |
| --- | --- | --- | --- |
| GitHub | the working copy; issues; discovery | yes, pseudonymous | no |
| Radicle | peer-to-peer git; the identity is a key | no: a key and an alias | yes |
| Software Heritage | a permanent archive, with intrinsic identifiers (SWHID) | no | no: a non-profit archive with mirrors |
| IPFS | a content-addressed copy: one CID names one release | no | yes, while someone pins it |
| OpenTimestamps | proof in the Bitcoin chain that a commit existed by a date | no | yes |
| Wayback Machine | snapshots of the public pages | no | no |

## COMMANDS

On your own machine. The sandbox that writes this repository cannot
reach these networks.

**Radicle.** Publish the repository to a peer-to-peer network. The node
replicates it to others; it survives the loss of any one host.

```
curl -sSLf https://radicle.xyz/install | sh
rad auth                       # alias: a pseudonym; keep the passphrase safe
rad node start
cd theological-type-checker && rad init      # public; default branch main
git push rad main              # thereafter: git push rad
rad sync status                # which nodes hold it
```

**Software Heritage.** Ask the archive to take a copy:
<https://archive.softwareheritage.org/save/>, origin type git, the
repository URL. Repeat after each release. Each archived revision gets a
SWHID (`swh:1:rev:...`), derived from its content, which names it forever.

**OpenTimestamps.** Stamp a commit: `tools/stamp`. The stamp is a hash in
the Bitcoin chain, so it reveals nothing and proves the commit existed no
later than its block. A few hours later, `ots upgrade` completes it.

```
uv tool install opentimestamps-client
tools/stamp                     # writes stamps/<commit>.txt.ots
git add stamps && git commit -m "Stamp" && git push
ots upgrade stamps/*.ots        # later; then ots verify
```

**IPFS.** Add each release as one archive:

```
git archive --format=tar.gz -o ttc-v0.4.0.tar.gz HEAD
ipfs add --cid-version 1 ttc-v0.4.0.tar.gz   # prints the CID
```

Put the CID in the release notes. It stays reachable while some node pins
it: yours, or anyone's who chooses to.

**Wayback Machine.** <https://web.archive.org/save/> with the repository's
URL.

## FILES

| Path | Contents |
| --- | --- |
| `LICENSE` | the CC0 1.0 legal code |
| `CITATION.cff` | how to cite, if anyone wishes to |
| `stamps/` | OpenTimestamps proofs, one per stamped commit |
| `tools/stamp` | stamps a commit |

## CAVEATS

The history was rewritten on 11 October 2026: an author's name and
timezone were removed from every commit. Anything copied before then
still has them: caches, forks, clones.

The rewrite changed every commit's hash, including that of the Thomist
pre-registration. Its order before the results is still fixed by the
chain of commits; its clock time is not. Predictions are stamped from now
on, before anything is encoded.

A hosting account is tied to whoever made it. A separate account, a
separate email and Tor put distance between the work and a person.

Commit messages end with a link to the Claude session that wrote them.
Only the account that ran the session can open it.

Style and subject matter identify people too.

## BUGS

Anonymity is a practice, not a setting.
