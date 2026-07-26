# NostDB Implementation Progress

Last updated: 2026-07-26

Current stage: `Stage 1 IN_PROGRESS` (2 of 9 child repositories connected)

Current milestone: The clean-slate root workspace is initialized, and
`nostdb-spec` and `nostdb-core` are connected as exact-commit submodules in the
authorized `nostdb` GitHub organization. Root and child CI both verify the pinned
commit set. The remaining seven child repositories are not yet authorized for
creation.

## Authority

`docs/PRD.md` is the target product contract. Existing implementations outside
this repository are reference material only and do not create compatibility
requirements.

## Stage table

| Stage | Status | Scope | Dependency |
| --- | --- | --- | --- |
| 0 | DONE | Root workspace documents, instructions, license, and verification | none |
| 1 | IN_PROGRESS | Create/connect and pin child repositories as submodules | exact URLs and explicit remote authorization |
| 2 | PENDING | Executable `.nost` and `.nostdb` specification foundation | Stage 1 |
| 3 | PENDING | Core model and typed change contracts | Stage 2 |
| 4 | PENDING | Storage and transaction foundation | Stage 3 |
| 5 | PENDING | Parser, sync, and deterministic analysis foundation | Stage 4 |
| 6 | PENDING | openCypher subset and query execution | Stage 5 |
| 7 | PENDING | CLI, REPL, conversion, and link management | Stage 6 |
| 8 | PENDING | Per-user local daemon | Stage 7 |
| 9 | PENDING | GitHub provider | Stage 7 |
| 10 | PENDING | Skills and AI enrichment workflow | Stages 7 and 9 |
| 11 | PENDING | Plugin manager and WebGPU reference viewer | Stage 7 |
| 12 | PENDING | npm, Homebrew, and GitHub distribution gates | Stages 8 through 11 |

Only one Stage may be `IN_PROGRESS`. Do not continue automatically to the next
Stage in the same request.

## Stage 0 scope

- Replace the placeholder `AGENTS.md` with clean-slate development rules.
- Keep `CLAUDE.md` linked to the same instructions.
- Add the English PRD and concise architecture/repository documents.
- Add root licensing and editor/ignore defaults.
- Add a non-mutating workspace verification script.
- Preserve the installed commit-message Skill and its lock file.
- Do not add implementation crates, providers, plugins, package manifests,
  remotes, or submodules.

## Stage 0 acceptance criteria

- Required documents exist and are internally consistent.
- `CLAUDE.md` resolves to `AGENTS.md`.
- The PRD is English and omits the prohibited inspiration-project name.
- Fenced JSON examples parse.
- Markdown code fences are paired.
- `git diff --check` passes.
- The workspace verifier passes with no `.gitmodules`.
- Git has no remote mutation.

## Stage 0 verification

Passed on 2026-07-26:

- `bash -n scripts/verify-workspace.sh`
- `./scripts/verify-workspace.sh`
- `git diff --check`
- trailing-whitespace scan across root setup documents and scripts
- dependency-free Node validation of all 7 fenced JSON examples and all 61
  paired fenced blocks in `docs/PRD.md`
- English-only and prohibited-name checks for `docs/PRD.md`
- normalized `diff` against the approved source PRD
- `CLAUDE.md` symlink target verification
- empty `git remote -v`
- absence of `.gitmodules`

## Stage 1 scope

Connect every intended child repository from `docs/REPOSITORIES.md` as a direct
child submodule pinned to an exact commit.

Full Stage 1 requires all nine children: `nostdb-spec`, `nostdb-core`,
`nostdb-cli`, `nostdb-server`, `nostdb-provider-github`, `nostdb-distribution`,
`homebrew-tap`, `skills`, and `plugins`.

### Resolved dependency: repository URLs

The root remote resolves the organization, so the child URLs are no longer
unknown:

```text
origin  git@github.com:nostdb/nostdb.git
```

`nostdb` is a GitHub Organization. Each child locator is therefore
`git@github.com:nostdb/<repository>.git`.

### Authorized scope: nostdb-spec

The first increment's authorization covered `nostdb-spec` only:

- create `nostdb-spec` as a public repository in the `nostdb` organization;
- push its initial commit;
- pin it as a root submodule;
- push root `main`.

The initial `nostdb-spec` commit is repository scaffolding only. It carries
`README.md`, `AGENTS.md`, `CLAUDE.md`, `LICENSE`, editor and ignore defaults,
and a non-mutating repository verifier. It deliberately contains no grammar,
format contract, protocol schema, example, or conformance fixture, because
authoring those is Stage 2.

### Still blocked

These seven children remain uncreated and unpinned pending explicit
authorization for each remote repository creation:

```text
nostdb-cli
nostdb-server
nostdb-provider-github
nostdb-distribution
homebrew-tap
skills
plugins
```

Stage 1 therefore stays `IN_PROGRESS` and MUST NOT be marked `DONE` until every
child is connected and pinned.

## Stage 1 acceptance criteria

- Every intended child repository exists with a real remote URL and at least one
  commit.
- `.gitmodules` records each child at its normative directory name.
- Every gitlink pins an exact commit, not a floating branch.
- Each child carries its own `README.md`, `AGENTS.md`, and PRD-mandated license.
- No child `AGENTS.md` weakens a root product, safety, or ownership boundary.
- No placeholder URL or local-path gitlink is present.
- The root workspace verifier passes with `.gitmodules` present.
- `git clone --recurse-submodules` populates every pinned child.
- No runtime implementation is added to the root repository.

Criteria met so far apply to `nostdb-spec` only.

## Stage 1 verification

Passed on 2026-07-26 for the authorized `nostdb-spec` scope.

Child repository, before publication:

- `bash -n scripts/verify-repository.sh`
- `./scripts/verify-repository.sh`
- Apache-2.0 `LICENSE` taken verbatim from
  `https://www.apache.org/licenses/LICENSE-2.0.txt` and confirmed as the
  canonical Git blob `d645695673349e3947e8e5ae42332d0ac3164cd7`
- `CLAUDE.md` committed as a symlink to `AGENTS.md`, Git mode `120000`
- `scripts/verify-repository.sh` committed executable, Git mode `100755`

Root workspace, after pinning:

- `bash -n scripts/verify-workspace.sh`
- `./scripts/verify-workspace.sh`, now exercising its `.gitmodules` branch
- `git diff --check`
- `git submodule status --recursive` reports one clean exact pin
- `./nostdb-spec/scripts/verify-repository.sh` from the submodule checkout

Recorded pin:

```text
nostdb-core  661d035ae6a6b540200f35c21ed182b861f1ff79
nostdb-spec  725b761a9104b591633427bdba21b735217bdf77
```

Clone contract, verified against fresh clones of the committed root:

- `git clone --recurse-submodules` populates `nostdb-spec` at the pinned commit,
  and both the root and the child verifier pass inside that clone;
- an option-free `git clone` leaves `nostdb-spec` empty, and
  `./scripts/verify-workspace.sh` correctly fails with
  `-b3f302b1eccb91cf426e03f08419859ebd8e8898 nostdb-spec`.

That satisfies the first two `docs/PRD.md` section 30.10 workspace criteria for
the connected child. The remaining section 30.10 criteria stay open because they
require the other children and root CI.

### Authorized remote actions

Authorization covered `nostdb-spec` only. Performed:

- created `https://github.com/nostdb/nostdb-spec` as a public repository;
- pushed its initial commit to `main`.

Root `main` is pushed to `origin` as the closing step of this Stage increment.

### Recorded decisions

`.gitmodules` records the read-only HTTPS locator
`https://github.com/nostdb/nostdb-spec.git` rather than the SSH locator used by
the root `origin`. The child is public, so HTTPS lets the recursive clone
documented in `docs/PRD.md` section 8.1 succeed without SSH keys. A contributor
who pushes to the child overrides the URL locally instead of changing the
recorded value.

`docs/PRD.md` was not modified. Its `<organization>` placeholders belong to the
approved normative contract, and Stage 0 verification diffs the PRD against an
approved source. Only `README.md` and `docs/REPOSITORIES.md` were made concrete,
because both asserted that no child repository was connected.

The initial `nostdb-spec` commit contains no grammar, format contract, protocol
schema, example, or conformance fixture. Authoring those is Stage 2, which was
not started.

## Stage 1 continuation: enforcement and CI

Stage 1 stays `IN_PROGRESS`. This increment connected no additional child,
because creating one is still unauthorized. It closed the gap between the Stage 1
acceptance criteria and what the workspace could actually detect.

### Continuous integration

`docs/PRD.md` section 8.1 requires the root to run CI with recursive submodule
checkout, and section 30.10 requires root CI to verify the exact pinned commit
set. Neither existed. `.github/workflows/verify.yml` now checks out the pinned
set recursively, runs `scripts/verify-workspace.sh`, and then runs each connected
child's `scripts/verify-repository.sh`.

`nostdb-spec` received an equivalent workflow so it verifies independently, as
`docs/REPOSITORIES.md` requires of every child. That document now also records
the `scripts/verify-repository.sh` convention root CI depends on.

Dependency review covering both workflows:

| Dependency | Purpose | Maintenance | License | Pin |
| --- | --- | --- | --- | --- |
| `actions/checkout` | recursive checkout of the pinned commit set | maintained by GitHub | MIT | commit `3d3c42e5aac5ba805825da76410c181273ba90b1`, tag `v7.0.1` |

Both workflows request only `contents: read` and disable credential persistence.
The default `GITHUB_TOKEN` reads public submodules only, so connecting a private
child will additionally require a token that can read that repository.

### Enforced submodule pin invariants

`scripts/verify-workspace.sh` previously checked only that a submodule sat at its
recorded pin. It now also rejects an illegitimate pin. Every check was proven to
reject rather than assumed to work:

| Rejected condition | Diagnostic |
| --- | --- |
| recorded submodule branch | `a submodule records a branch; every pin must be an exact commit` |
| SSH URL in `.gitmodules` | `must record https://github.com/<owner>/<repository>.git` |
| placeholder URL | `records a placeholder URL` |
| local-path URL | `must record https://github.com/<owner>/<repository>.git` |
| path differing from the submodule name | `must use its own name as its path` |
| path outside the normative section 8.1 names | `not a normative child directory name` |
| gitlink with no `.gitmodules` entry | `gitlinks in the index do not match the paths declared in .gitmodules` |
| missing root CI workflow | `missing required file: .github/workflows/verify.yml` |

Two of those checks are defense in depth. A path or name inconsistency in an
initialized submodule normally trips the gitlink-match, path-equals-name, or
off-pin check first, so proving the normative-name check required declaring a
fully consistent, initialized submodule at a non-normative path.

### Correction

The previous increment documented this override for contributors who push over
SSH:

```text
git config submodule.<name>.url <ssh-url>
```

That is wrong, and `docs/REPOSITORIES.md` has been corrected. The key only
redirects where `git submodule update` clones from, `git submodule sync` resets
it from `.gitmodules`, and it does not affect the push URL at all. The working
mechanism is a `pushInsteadOf` redirect, which keeps fetches on HTTPS, sends
pushes over SSH, and survives `git submodule sync`.

The error surfaced because pushing the child actually failed rather than because
the document was reread. The verifier now rejects an SSH URL recorded in
`.gitmodules`, so the intuitive wrong fix cannot be committed.

### Stage 1 continuation verification

Passed on 2026-07-26:

- `bash -n scripts/verify-workspace.sh`
- `./scripts/verify-workspace.sh`
- `./nostdb-spec/scripts/verify-repository.sh`
- both workflow files parsed as YAML, confirming a single `contents: read`
  permission and the pinned `actions/checkout` commit
- the eight negative cases above, each rejected with its intended diagnostic
- the advanced submodule rejected before re-pinning and accepted after
  `git add nostdb-spec`
- the exact `git submodule foreach` command from the root workflow
- `git diff --check`
- `nostdb-spec` CI run `30195693215` succeeded on its first push, using the
  pinned `actions/checkout` commit

Root CI has not executed. See the billing blocker below.

### Resolved: root CI billing blocker

Two root pushes recorded failed runs because GitHub refused to start the job:

```text
The job was not started because recent account payments have failed or your
spending limit needs to be increased.
```

`nostdb/nostdb` was private, so its Actions minutes were billed, while the public
`nostdb/nostdb-spec` ran free. The workflow was unexercised rather than broken.

Making the root repository public was authorized, and Actions then ran free.
Run `30196084203` passed: it checked out `nostdb-spec` at its exact pin, passed
`scripts/verify-workspace.sh`, and passed the child verifier through
`git submodule foreach`. The `docs/PRD.md` sections 8.1 and 30.10 CI requirement
is now verified rather than only implemented.

The two earlier failed runs stay in the history as a record of the blocked state.
Neither was a workflow defect.

## Stage 1 continuation: nostdb-core

Stage 1 stays `IN_PROGRESS` at 2 of 9 children.

### Authorized scope: nostdb-core and root visibility

- create `nostdb-core` as a public repository in the `nostdb` organization;
- push its initial commit;
- pin it as a root submodule;
- make `nostdb/nostdb` public so root Actions run free.

`nostdb-core` is licensed SSPL-1.0 and is described as source-available, not open
source. `LICENSE` is the verbatim SPDX text for `SSPL-1.0`: 557 lines,
`sha256 3fac2f3a7404f72330ae38e3a1d2632ede9ad3fbdb0d471d04c33f2c1d0e94ca`.

Its initial commit is scaffolding only. It carries no model, storage, parser,
analyzer, provider, or query code, because that work belongs to Stage 3 and later.
Its `AGENTS.md` does record the Engine ownership boundary and the product
invariants the Engine must never break, so later Stages inherit them.

### Pre-publication review

Making a private repository public exposes its whole history irreversibly, so the
root history was reviewed before the visibility change:

- every path ever committed was enumerated, and all are documentation, scripts, or
  Skill metadata;
- every commit was scanned for credential patterns, covering GitHub tokens, AWS
  access keys, PEM private-key headers, Slack tokens, certificates, and bearer
  tokens, with no match;
- `skills-lock.json` holds only a public source path and a content digest;
- `.claude/skills` is a symlink to `../.agents/skills`.

### nostdb-core verification

Passed on 2026-07-26:

- `bash -n scripts/verify-repository.sh`
- `./scripts/verify-repository.sh`
- `CLAUDE.md` committed as a symlink, Git mode `120000`, and the verifier
  committed executable, Git mode `100755`
- the child workflow parsed as YAML with a single `contents: read` permission and
  the pinned `actions/checkout` commit
- SSPL section 13, `Offering the Program as a Service`, confirmed present, which
  the verifier now requires so a truncated or substituted license is rejected
- `./scripts/verify-workspace.sh` in the root with both submodules pinned, which
  also exercises the new pin-legitimacy checks against a second entry
- the exact `git submodule foreach` command from the root workflow across both
  children
- `nostdb-core` CI run `30196046094` passed on its first push
- root CI run `30196139463` passed on the connecting push, checking out
  `nostdb-core` at `661d035a` and `nostdb-spec` at `725b761a`, then passing
  `workspace verification`, `nostdb-core verification`, and `nostdb-spec
  verification`

That run is the first full demonstration of the `docs/PRD.md` section 30.10
requirement that root CI verify the exact pinned commit set.

## Stage 1 continuation: root boundary enforcement

Stage 1 stays `IN_PROGRESS` at 2 of 9. This increment created nothing remote,
because the seven remaining children are still unauthorized. It enforced two
Stage 1 acceptance criteria that nothing previously checked.

### No runtime implementation in the root

`docs/PRD.md` sections 8.1 and 30.10 forbid duplicating runtime implementation in
the root, and the root `AGENTS.md` limits this repository to cross-repository
documents, exact pins, orchestration, and verification. Nothing enforced it.

`scripts/verify-workspace.sh` now rejects any tracked root path that is a runtime
build manifest or a runtime source file. Submodule contents are excluded
automatically, because `git ls-files` does not descend into a gitlink.

### Child verifier convention enforced locally

Root CI required every connected child to provide an executable
`scripts/verify-repository.sh`, but the local verifier did not check it, so a
local pass did not imply a CI pass. The local verifier now checks it too.

### Verification

Passed on 2026-07-26. Six further negative cases, each rejected with its intended
diagnostic:

| Rejected condition | Diagnostic |
| --- | --- |
| root `Cargo.toml` | `must not contain runtime implementation or build manifests` |
| root `package.json` | `must not contain runtime implementation or build manifests` |
| root `src/lib.rs` | `must not contain runtime implementation or build manifests` |
| nested `docs/helper.py` | `must not contain runtime implementation or build manifests` |
| child verifier not executable | `must provide an executable scripts/verify-repository.sh` |
| child verifier missing | `must provide an executable scripts/verify-repository.sh` |

The current root tree still passes, which confirms `skills-lock.json` and the
shell and YAML orchestration files are not false positives.

Counting the earlier increment, the workspace verifier now has fourteen proven
rejections.

## Recorded conflict: Stage granularity blocks all implementation

The root `AGENTS.md` requires recording a contract conflict here and keeping the
current valid behavior unchanged until the owning contract is resolved. This is
such a conflict, so the Stage table is deliberately left unamended.

The Stage table makes Stage 2 depend on Stage 1, and the Stage 1 scope is every
one of the nine child repositories. Read strictly, no specification or Engine work
can begin until seven more repositories exist, including `homebrew-tap`,
`plugins`, `skills`, and `nostdb-distribution`, which no Stage needs before
Stages 10 through 12.

Stage 2 in fact depends only on `nostdb-spec`, connected in the first increment.
Stages 3 through 6 depend only on `nostdb-core`, connected in the second.

Two resolutions exist, and both are the user's decision:

1. authorize the remaining seven children, which closes Stage 1 as written;
2. narrow the Stage 1 scope to the children that later Stages actually depend on,
   and move the distribution-time repositories into their own late Stage.

Until one is chosen, Stage 1 stays `IN_PROGRESS`, Stage 2 stays `PENDING` with an
unmet dependency, and no Stage is started. No part of the workspace is blocked by
a defect.
