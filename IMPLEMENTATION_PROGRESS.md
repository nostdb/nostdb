# NostDB Implementation Progress

Last updated: 2026-07-28

Current stage: every Stage is `DONE`. NostDB 0.1.0 is published to npm and to a GitHub release
with checksums, and `brew install nostdb/tap/nostdb` installs it.

The three **installed** routes — npm, Homebrew, and the release archive — report byte-identical
`--version --json`. A source install with `cargo install --git … --tag v0.1.0 --locked` builds and
runs, and was not part of that comparison, so this summary used to claim four routes where the
Stage 12 record claims three.

The source route also has a defect this release keeps: the command `docs/PRD.md` section 25.3
publishes ends in a package name that was wrong at `v0.1.0`, so following it verbatim fails with
"could not find `nostdb`". Omitting the trailing name works, and the published spelling is correct
from the next tag. Re-cutting `v0.1.0` to fix a documentation defect would invalidate an npm package
whose checksums describe exactly the archives that release attached, which is the larger harm.

Nothing in Stage 10 has ever called a model, and that is the design rather than a gap: what
a model returns cannot be pinned by a fixture, so everything testable is the surface around
the call. A live run with a provider and a credential remains unauthorized, and is the only
thing that would show whether a model's proposals are any good.

Stage 10 has one repair recorded against it, and it did not reopen the Stage. `skills` was
delivered with no `SKILL.md` in it, so the Skills three documents called independently
installable could not be installed at all. Each is now published at
`skills/skills/<name>/SKILL.md`, and the layout is confirmed by installing the published child
rather than only by a document describing the installer. See
`Stage 10 repair: nothing in skills was installable`.

One thing Stage 9 built is unverified against reality: every test proves the provider behaves
correctly against a *recorded* GitHub, and only a live run with a real credential proves the
recording is what GitHub actually sends. That run is named in the Stage 9 scope as needing
separate authorization, and it still does.

Current milestone: every child repository the normative layout names is connected as an
exact-commit submodule in the `nostdb` GitHub organization, and root and child CI verify the
pinned commit set. Thirteen of the fourteen registered contracts are published with conformance
suites an implementation can fail against; `credentials_version` is the one still deferred, and
nothing has needed it because a credential is referenced by name and never stored.

A configured project can be analyzed, built, queried, linked, synchronized, and converted from
the command line with no daemon running. That is the boundary every later Stage had to avoid
erasing: the daemon manages named databases and never becomes a requirement for a path, the
provider is reached out of process, and a plugin is neither.

This paragraph described the workspace as of Stage 8 increment 1 until 0.1.0 had already
shipped. It said `nostdb-server` was scaffolding and that children remained unconnected, both of
which stopped being true several Stages earlier — a reminder that the line above it was kept
current while the paragraph under it was not.

## Authority

`docs/PRD.md` is the target product contract. Existing implementations outside
this repository are reference material only and do not create compatibility
requirements.

## Stage table

| Stage | Status | Scope | Dependency |
| --- | --- | --- | --- |
| 0 | DONE | Root workspace documents, instructions, license, and verification | none |
| 1 | DONE | Connect and pin the specification and Engine repositories `nostdb-spec` and `nostdb-core` | exact URLs and explicit remote authorization |
| 2 | DONE | Executable `.nost` and `.nostdb` specification foundation | Stage 1 |
| 3 | DONE | Core model and typed change contracts | Stage 2 |
| 4 | DONE | Storage and transaction foundation | Stage 3 |
| 5 | DONE | Parser, sync, and deterministic analysis foundation | Stage 4 |
| 6 | DONE | openCypher subset and query execution | Stage 5 |
| 7 | DONE | CLI, REPL, conversion, and link management | Stage 6, plus connected `nostdb-cli` |
| 8 | DONE | Per-user local daemon | Stage 7, plus connected `nostdb-server` |
| 9 | DONE | GitHub provider | Stage 7, plus connected `nostdb-provider-github` |
| 10 | DONE | Skills and AI enrichment workflow | Stages 7 and 9, plus connected `skills` |
| 11 | DONE | Plugin manager and reference viewer | Stage 7, plus connected `plugins` |
| 12 | DONE | npm, Homebrew, and GitHub distribution gates | Stages 8 through 11, plus connected `nostdb-distribution` and `homebrew-tap` |
| 13 | DONE | Language-neutral analysis: every project builds a graph, with or without an analyzer | Stage 7 |
| 14 | DONE | One workspace, one set of pins: a child depends on the sibling revision the root pins | Stage 12 |
| 15 | DONE | A second analyzer: the boundary that holds one, and Kotlin | Stage 13 |
| 16 | DONE | A recommendation that can be followed: the plugin source, and the bundled provider | Stage 12 |
| 17 | DONE | A plugin repository declares itself: `plugins/*` and `nostdb.plugins.json` | Stage 16 |
| 18 | DONE | Framework analyzers, and AI where none covers a framework | Stage 15 |
| 19 | DONE | Builtin breadth: many languages named, six analyzed, and a decision about files that are not code | Stage 18 |
| 20 | DONE | Skill presets: a vocabulary the Engine validates, for facts no deterministic analyzer can claim | Stage 19 |
| 21 | DONE | An import resolves to what a file declares, not to what it is named | Stage 19 |
| 22 | DONE | An analyzer declares no version: attribution is not identity | Stage 21 |
| 23 | DONE | The Skill's export flag names its representation: `--export=nost` | Stage 20 |
| 24 | DONE | Export is a verb, and `nost` is its default: `/nostdb export .` | Stage 23 |
| 25 | DONE | The scan flag names its reader: `--scan=analyzer`, `--scan=ai` | Stage 24 |
| 26 | DONE | `help` shows what an option accepts, not only one of its values | Stage 25 |
| 27 | DONE | Two scan values: the analyzers first, and AI required | Stage 26 |
| 28 | DONE | An owner is one string, and the builtin one is `nostdb` | Stage 27 |
| 29 | DONE | No legacy owner: two contracts bump instead | Stage 28 |
| 30 | DONE | `sync` is a verb, and `convert` is the bidirectional one | Stage 29 |
| 31 | DONE | `convert --replace`, and the Skill keeps only `convert` | Stage 30 |
| 32 | DONE | A release builds the children the root pins | Stage 31 |
| 33 | DONE | A Spring Boot vocabulary, and the preset check that could not run | Stage 32 |
| 34 | DONE | Evidence a proposal declares, MIT Skills, Kotlin, Python, and the reconciliation workflow | Stage 33 |
| 35 | DONE | The Skill's scripts in Python, and two JSON readers that were regexes | Stage 34 |
| 36 | DONE | `--scan=ai` is a pipeline, not a flag: AI reads instead of the analyzers | Stage 35 |
| 37 | DONE | Analyzer Skills are found rather than assumed, and named when used | Stage 36 |
| 38 | DONE | A schema field may declare an object, and a separator is optional | Stage 37 |

A Stage whose dependency names a child repository cannot start until that
repository is created, connected, and pinned, and creating it still requires
explicit user authorization at that time.

Only one Stage may be `IN_PROGRESS`.

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

Connect the specification and Engine repositories as direct child submodules
pinned to exact commits:

- `nostdb-spec`
- `nostdb-core`

This scope was narrowed from all nine children after the original decomposition
was found to block every implementation Stage on repositories that no early Stage
needs. See `Resolved conflict: Stage granularity` at the end of this document.

### Resolved dependency: repository URLs

The root remote resolves the organization, so the child URLs are no longer
unknown:

```text
origin  git@github.com:nostdb/nostdb.git
```

`nostdb` is a GitHub Organization. Each child locator is therefore
`git@github.com:nostdb/<repository>.git`.

### Scope amendment: `link refresh` moves to Stage 9

Increment 4 was scoped with `link refresh` in it. It is not implemented, and the increment
is marked DONE without it. That is a scope change, so it is recorded here rather than left
to be noticed from a table.

`refresh` advances a remote snapshot to a newer immutable commit. A local link is read live
at every query and has no snapshot to advance, so there is nothing for the command to do
until a source exists that has one — which is the GitHub provider, in Stage 9. Implementing
it against a local source would mean inventing a meaning the product contract does not give
it.

The command is refused by name with that reason, and a test asserts the message says
`snapshot` and does not say `journal` — which is what it used to say, and was true only
until `link add` started using the journal.

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

### Deferred to the Stage that first needs them

These seven children are uncreated and unpinned. Each is now a named dependency
of a later Stage rather than of Stage 1:

| Child | Required by |
| --- | --- |
| `nostdb-cli` | Stage 7 |
| `nostdb-server` | Stage 8 |
| `nostdb-provider-github` | Stage 9 |
| `skills` | Stage 10 |
| `plugins` | Stage 11 |
| `nostdb-distribution` | Stage 12 |
| `homebrew-tap` | Stage 12 |

Creating each one still requires explicit user authorization, and the owning Stage
cannot start until its repository is connected and pinned. Deferring the
connection does not weaken that boundary; it only stops seven distribution-time
repositories from blocking specification and Engine work.

## Stage 1 acceptance criteria

Every criterion applies to the two children in scope.

| Criterion | Met by |
| --- | --- |
| Each in-scope child exists with a real remote URL and at least one commit | `nostdb-spec` at `725b761a`, `nostdb-core` at `661d035a` |
| `.gitmodules` records each child at its normative directory name | verifier rejects a non-normative path |
| Every gitlink pins an exact commit, not a floating branch | verifier rejects a recorded branch |
| Each child carries its own `README.md`, `AGENTS.md`, and PRD-mandated license | Apache-2.0 for `nostdb-spec`, SSPL-1.0 for `nostdb-core`, both verifier-checked |
| No child `AGENTS.md` weakens a root product, safety, or ownership boundary | each states the root contract wins on conflict and only narrows it |
| No placeholder URL or local-path gitlink is present | verifier rejects both, plus orphan gitlinks |
| The root workspace verifier passes with `.gitmodules` present | passes with two pinned children |
| `git clone --recurse-submodules` populates every pinned child | proven from the public HTTPS remote with no SSH keys |
| No runtime implementation is added to the root repository | verifier rejects runtime manifests and sources |
| Root CI verifies the exact pinned commit set | run `30196287155` checked out both pins and passed all three verifiers |

Stage 1 is `DONE` for this scope. Stage 2 was not started in the same request.

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

Stage 1 remained `IN_PROGRESS` through this increment, which connected no
additional child because creating one was not yet authorized. It closed the gap
between the Stage 1 acceptance criteria and what the workspace could actually
detect.

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

Stage 1 remained `IN_PROGRESS` after this increment, at 2 of the 9 children the
scope then required.

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

Stage 1 remained `IN_PROGRESS` through this increment, which created nothing
remote because the seven remaining children were not authorized. It enforced two
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

### The Stage 14 check earned itself on its first real round

Re-pinning for this Stage failed workspace verification: the Core bump moved `nostdb-server`, and
`nostdb-cli` was left pinning the previous one. Without the check added last Stage that would have
shipped as a client for one revision of a daemon on another revision of the Engine — the exact defect
it was written to refuse, caught on the first round where it could have recurred.

Worth recording because it is the cheapest kind of evidence there is: a check whose value was argued
for in prose one Stage ago and demonstrated one Stage later.

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

## Resolved conflict: Stage granularity

### The conflict

The original Stage table made Stage 2 depend on Stage 1, and the Stage 1 scope was
every one of the nine child repositories. Read strictly, no specification or Engine
work could begin until seven more repositories existed, including `homebrew-tap`,
`plugins`, `skills`, and `nostdb-distribution`, which no Stage needs before Stages
10 through 12.

Stage 2 in fact depends only on `nostdb-spec`, and Stages 3 through 6 depend only
on `nostdb-core`. Both were already connected and verified.

The conflict was recorded first and the Stage table left unamended, as the root
`AGENTS.md` requires, until the owning decision was made.

### The resolution

The user selected resolution 2 of the two recorded options: narrow the Stage 1
scope to the specification and Engine repositories, and make every remaining child
a named dependency of the Stage that first needs it.

Applied changes:

- Stage 1 scope is now `nostdb-spec` and `nostdb-core`, and Stage 1 is `DONE`.
- Stages 7 through 12 each name the child repository they require.
- Creating each remaining repository still requires explicit authorization, and
  the owning Stage cannot start until that repository is connected and pinned.

No product invariant, safety boundary, or ownership boundary changed. The
authorization gate moved to the point of need rather than being removed, and no
placeholder or local-path gitlink was introduced for a deferred child.

The alternative resolution, authorizing all seven children at once, remains
available and would satisfy several later dependencies in a single step.

## Stage 2 scope

Author the `.nost` language contract and the `.nostdb` format contract in
`nostdb-spec`, with a conformance fixture suite and a test-only harness that
proves the contracts are internally consistent.

In scope:

- an independent version registry in human and machine-readable form;
- the `.nost` language contract v1: lexical rules, a normative generator-neutral
  EBNF, property value types, endpoint reference forms, and the spec-owned
  diagnostic code registry;
- an executable reference encoding of the grammar, so the grammar is runnable;
- the `.nostdb` format contract v1: magic, versioning, endianness, integer widths,
  header layout, section table layout, checksums, generation, bounded-parsing
  limits, and unsupported-version behavior;
- machine-readable descriptors for versions, diagnostics, and the `.nostdb`
  header;
- conformance fixtures covering accepted `.nost`, syntactically rejected `.nost`,
  semantically rejected `.nost`, and `.nostdb` header bytes;
- a test-only conformance harness, wired into the repository verifier and CI.

### Deferred out of Stage 2

- provider, plugin, and server protocol schemas, and the settings, credentials,
  catalog, and result-envelope schemas. Stages 7 through 12 depend on those;
  Stages 3 through 6 do not.
- any parser, CST, formatter, analyzer, or storage implementation, which
  `nostdb-core` owns.

### Normativity split

The normative artifacts are the contract documents, the generator-neutral EBNF,
and the fixture suite with its declared expectations. The executable grammar is a
reference encoding: it must agree with the fixtures, but it does not constrain
which parser technology `nostdb-core` chooses. `nostdb-core` proves conformance in
Stage 5 by passing the same fixtures with its own parser.

This keeps the parser in `nostdb-core` and keeps `nostdb-spec` free of a second
implementation, while still making the grammar executable rather than prose.

## Stage 2 acceptance criteria

- The version registry declares the `.nost`, `.nostdb`, settings, provider,
  plugin, and server versions independently, in human and machine-readable form.
- Every nonterminal in the normative EBNF is defined, and every defined rule is
  reachable from the start symbol.
- The contract defines the aliasless external reference form that `docs/PRD.md`
  section 13.2 delegates to `nostdb-spec`.
- Stored `null` is unrepresentable in the grammar.
- Every diagnostic code a fixture declares exists in the registry, and every
  registry code is documented.
- Accepted fixtures parse under the reference encoding.
- Syntactically rejected fixtures fail with the declared code, and the reference
  encoding reports each fixture's recorded informative position.
- Semantically rejected fixtures parse, and each declares the diagnostic code an
  implementation must raise.
- The `.nostdb` contract fixes magic, version, endianness, integer widths, header
  layout, section table layout, checksum algorithm, and bounded-parsing limits.
- Header fixtures cover a valid header and every rejection class, and the harness
  reproduces each declared outcome.
- `cargo fmt --check`, `cargo check`, `cargo clippy --all-targets --all-features
  -- -D warnings`, and `cargo test --all-targets --all-features` pass.
- `scripts/verify-repository.sh` runs the harness, and root CI passes over the new
  pin.
- No parser, CST, formatter, or storage implementation is added to `nostdb-spec`.

## Stage 2 verification

Passed on 2026-07-26 in `nostdb-spec` at commit `b19afd0`.

Rust command set, all clean:

- `cargo fmt --check`
- `cargo check --all-targets --all-features`
- `cargo clippy --all-targets --all-features -- -D warnings`
- `cargo test --all-targets --all-features`, 20 tests passing

Repository and workspace:

- `bash -n scripts/verify-repository.sh`
- `./scripts/verify-repository.sh`, which now requires every contract artifact and
  runs the Rust command set, so a local pass and a CI pass are equivalent
- `./scripts/verify-workspace.sh` in the root with both children pinned
- the exact `git submodule foreach` command from the root workflow, across both
  children
- the child workflow parsed as YAML

Conformance suite:

| Suite | Fixtures | What it establishes |
| --- | --- | --- |
| `fixtures/nost/valid` | 9 | accepted, and each obeys the encoding rules in language contract section 2 |
| `fixtures/nost/invalid-syntax` | 13 | rejected, each at its recorded reference position |
| `fixtures/nost/invalid-semantic` | 12 | parse, and each declares a registered diagnostic code |
| `fixtures/nostdb/header` | 20 | 3 accepted containers and 17 rejections spanning `NOSTDB_CORRUPT`, `NOSTDB_FORMAT_UNSUPPORTED`, and `NOSTDB_LIMIT_EXCEEDED` |

Harness checks beyond fixture outcomes:

- every EBNF nonterminal is defined, and every rule is reachable from the declared
  roots;
- the reference encoding defines the same rule set as the normative EBNF, with
  documented allowances where pest has a built-in for a lexical primitive;
- the version registry and `VERSIONS.md` agree, and every `specified` contract
  names a file that exists;
- every registered diagnostic code is documented in the contract that owns it, and
  every code a fixture declares is registered;
- every `.nost` semantic diagnostic in the registry has a fixture;
- the header descriptor's fields are contiguous and total its declared length;
- CRC-32C reproduces the standard check value `0xE3069283` for `123456789`;
- flipping any single bit in the 44 checksum-covered header bytes is detected.

### Defects this Stage found and fixed

The EBNF consistency checker failed on its first run. The grammar file's own header
comment contained a comment terminator inside a notation example, which closed the
comment early, so the remaining prose was scanned as grammar. The file was
corrected rather than the checker relaxed.

The reference encoding reported `expected escape_sequence` at a position inside a
well-formed string literal whenever an enclosing rule failed later, because
compound-atomic literal rules leaked inner failures into error reporting. Making
the literal rules fully atomic moved the reported position to the start of the
failing declaration, which is where a reader would look.

### Recorded decision: normative and informative expectations

A fixture expectation separates `outcome` and `code`, which every implementation
must reproduce, from `reference_line` and `reference_column`, which pin the
reference encoding alone.

The position at which a parser detects a syntax error is an artifact of its
technology. A PEG reports the furthest position reached while backtracking, a
table-driven parser reports the offending token, and a parser with error recovery
may report several. Requiring one exact column would bind every implementation to
one parser design, which is precisely what `nostdb-spec` must avoid. What every
implementation MUST do is reject the input and attach a source range.

### Recorded decision: normativity of the grammar

The normative grammar is `grammar/nost.ebnf`, which is parser-generator neutral,
together with the fixture suite. `grammar/nost.pest` is an executable reference
encoding: it makes the grammar runnable and is cross-checked against the EBNF rule
set, but it does not constrain `nostdb-core`'s parser technology.

The reference encoding and the container validator live in `tests/` with no public
API, and the crate declares `publish = false`. They recognize and validate; they
build no CST and interpret no section payload. `nostdb-core` implements the real
parser and reader in Stages 3 through 5 and proves conformance against this same
suite.

### Dependencies added

| Dependency | Scope | Purpose | Maintenance | License |
| --- | --- | --- | --- | --- |
| `pest`, `pest_derive` | dev only | executable reference encoding of the grammar | active, `pest-parser/pest` | MIT OR Apache-2.0 |
| `serde_json` | dev only | reading the machine-readable registries so they are checked rather than trusted | active, `serde-rs/json` | MIT OR Apache-2.0 |

All three are development dependencies, so no consumer of `nostdb-spec` inherits
them. `rust-toolchain.toml` pins the channel to stable with `rustfmt` and `clippy`,
so a local run and a CI run use the same toolchain rather than whatever a runner
image preinstalls.

### Deferred out of Stage 2

The settings, credentials, catalog, result-envelope, provider, plugin, manifest,
and change-set contracts keep reserved version keys and remain unauthored. Stages
7 through 12 depend on them; Stages 3 through 6 do not.

Section payload encodings are also deferred. Stage 2 fixes the container envelope
so an implementation can already refuse a corrupt or unsupported file; how a node
record is laid out inside the `nodes` section is specified when the model lands in
Stage 3.

## Stage 3 scope

Implement the graph model and the typed change contract in `nostdb-core`, as data
types with validated construction and explicit error types. This Stage adds no
behavior beyond validation.

In scope:

- opaque record identifiers, with a documented textual representation;
- the canonical source locator;
- validated names: label, relation, property key, declaration name, link alias;
- property values and scalars, honoring the no-null and finite-number rules;
- `Node`, `Edge`, `NodeReference`, and `ScopedNodeId`, with two non-null endpoints
  enforced by the type rather than by a check;
- `Contribution`, `Owner`, and `ContributionKey`;
- `Evidence`, `EvidenceMethod`, and `Confidence` with a validated score range;
- `SourceRange`;
- `Diagnostic`, `Severity`, and a typed diagnostic code aligned with the
  `nostdb-spec` registry;
- `GraphChangeSet`, `GraphOperation`, the drafts, and shape validation;
- `BuildCoverage` and its states;
- typed error types with rustdoc.

### Deferred out of Stage 3

- storage, transactions, and the journal, which are Stage 4;
- the `.nost` parser, CST, formatter, synchronization, and analyzers, which are
  Stage 5;
- the query engine, which is Stage 6;
- identifier minting, because choosing an entropy source and an ordering policy
  belongs with storage in Stage 4. Stage 3 provides construction from bytes and
  the textual round trip.

## Stage 3 acceptance criteria

- `nostdb-core` declares `#![forbid(unsafe_code)]`.
- Every public item carries rustdoc.
- Public fallible operations return explicit error types. The crate does not panic
  for ordinary errors and does not write to stdout.
- A stored null is unrepresentable in `PropertyValue`.
- A non-finite float is rejected at construction.
- A confidence score outside `0.0..=1.0` is rejected at construction.
- An `Edge` cannot be constructed with a missing endpoint.
- Names are validated against the `.nost` identifier rules, and a reserved word is
  rejected where the language contract reserves it.
- Every diagnostic code the crate can emit exists in the `nostdb-spec` registry,
  proven by a root integration check rather than by inspection.
- `cargo fmt --check`, `cargo check`, `cargo clippy --all-targets --all-features
  -- -D warnings`, and `cargo test --all-targets --all-features` pass.
- Child CI is green, and root CI is green over the new pin.
- No CLI, daemon, network interface, storage engine, parser, or query engine is
  added to `nostdb-core`.

## Stage 3 verification

Passed on 2026-07-26 in `nostdb-core` at commit `f1f712f`.

Rust command set, all clean:

- `cargo fmt --check`
- `cargo check --all-targets --all-features`
- `cargo clippy --all-targets --all-features -- -D warnings`
- `cargo test --all-targets --all-features`, 71 tests passing

Repository and workspace:

- `bash -n scripts/verify-repository.sh`
- `./scripts/verify-repository.sh`, which now also runs the Rust command set and
  the ownership-boundary checks
- `./scripts/verify-workspace.sh` in the root, including the new cross-repository
  diagnostic check
- the exact `git submodule foreach` command from the root workflow, across both
  children
- the child workflow parsed as YAML

### How each invariant is enforced

| Invariant | Mechanism |
| --- | --- |
| stored null is unrepresentable | `PropertyValue` has no null variant |
| a float property is finite | `FiniteF64` cannot hold an infinity or a NaN |
| a confidence score is within `0.0..=1.0` | `Score` rejects anything else |
| an Edge has two non-null endpoints | `Edge` endpoints are `NodeReference`, not `Option` |
| a name is a valid identifier | `Label`, `RelationName`, `PropertyKey`, `DeclarationName`, and `LinkAlias` apply the UAX #31 rule and reject reserved words |
| a datetime is RFC 3339 | `DateTime` validates shape and component ranges |
| a link identity is its locator | `CanonicalSourceLocator` is the only link identity; no generated identifier exists |
| an analyzer replaces only its own work | `ContributionKey` pairs owner with source unit, and change-set validation rejects removing another owner's contribution |
| a Node has at least one label, a key is not set twice | reported by `Node::violations` and change-set validation, so a diagnostic can carry a source range |
| rustdoc on every public item | `missing_docs = "deny"` in `Cargo.toml` |
| documented error contracts | `clippy::missing_errors_doc = "deny"` |
| no unsafe code | `#![forbid(unsafe_code)]` |
| no command surface or listener in the Engine | the verifier rejects `fn main`, a listener type, and `src/bin` |

The first eight are enforced by types, so the invalid state cannot be built. The
ninth is reported rather than refused, because the Engine has to surface it as a
diagnostic against real source and refusing construction would discard the position
a caller needs.

### Cross-repository diagnostic check

A diagnostic code is a stable public identifier, and the vocabulary `nostdb-core`
recognizes must equal the registry `nostdb-spec` publishes. The two are separate
repositories pinned together, so `scripts/verify-workspace.sh` now compares them
directly. Both sides currently list the same fifteen codes.

The check was proven in both drift directions: removing a code from the registry,
and renaming one in the Engine, each fail with the differing code named. It also
deliberately excludes the Engine file's test section, which names an unregistered
code on purpose to prove an unknown code is rejected rather than guessed.

While wiring that check, its failure output listed thirteen phantom differences,
because `comm` ran under the default locale while its inputs were sorted with
`LC_ALL=C`. The exit status was already correct, but the message would have sent a
reader chasing differences that did not exist, so the collation was fixed.

### Recorded decision: typed errors instead of unregistered codes

Change-set validation returns typed errors rather than diagnostics. Several
conditions it detects, such as an empty change set or a placeholder replaced by
itself, have no registered diagnostic code, because `change_set_version` is a
reserved but unauthored contract.

Inventing codes here would put the Engine's vocabulary ahead of the published
registry and would then fail the cross-repository check. Reporting them as typed
errors is also the more accurate description: a malformed change set is a caller
contract violation, not a finding about analyzed content.

When `change_set_version` is authored, those conditions can be promoted to
registered codes.

### Recorded finding: the identifier textual form belongs in the contract

`nostdb-core` defines the textual form of a record identifier as a two-character
kind prefix followed by 26 Crockford base32 characters, matching the shape the root
PRD examples show.

A `.nost` file may state a record identifier explicitly, so any implementation
reading that file needs the same string-to-bytes mapping. That makes this a
cross-implementation contract rather than an Engine detail, and it should be
absorbed into the `.nost` language contract in `nostdb-spec`. It is recorded here
rather than added silently, because expanding a contract that Stage 2 already closed
is a decision, not a detail.

### Deferred out of Stage 3

- storage, transactions, and the journal, which are Stage 4;
- the `.nost` parser, CST, formatter, synchronization, and analyzers, which are
  Stage 5;
- the query engine, which is Stage 6;
- identifier minting, because the entropy source and any ordering guarantee are
  storage decisions;
- `tracing` was not added as a dependency. The root contract requires a library to
  log through `tracing` rather than stdout, which constrains how it logs; a pure
  data-model crate has nothing to log yet, and adding an unused dependency would
  contradict the dependency-review rule.

## Stage 4 scope

Implement the `.nostdb` container and the transaction foundation in `nostdb-core`,
against the contract `nostdb-spec` published in Stage 2.

In scope:

- CRC-32C, verified against its standard check value;
- the 48-byte header and the 32-byte section table entry, read and written;
- the twelve ordered bounded-parsing checks, mapped to `NOSTDB_CORRUPT`,
  `NOSTDB_FORMAT_UNSUPPORTED`, and `NOSTDB_LIMIT_EXCEEDED`;
- a writer that lays out, checksums, and serializes a container;
- a monotonic database generation;
- a journal record format with a per-record checksum, idempotent replay, and
  rejection of a torn record;
- atomic commit through staged write and promotion, preserving the last valid
  generation when a commit fails;
- conformance against the `nostdb-spec` container fixtures, exercised from the
  superproject.

### Deferred out of Stage 4: section payload encodings

Stage 4 stores and retrieves section bytes. How a Node, an Edge, a property, or an
Evidence record is laid out *inside* a section is not specified here.

Stage 2 deliberately drew the contract boundary at the container envelope, so an
implementation could refuse a corrupt or unsupported file before record encodings
were designed. Stage 3 defined the model as types, not as bytes. The encoding is
therefore its own contract, and it lands with the parser in Stage 5, which is what
first needs to turn records into bytes.

That keeps this Stage honest: the container is complete and conformant, and it
carries opaque section payloads until the encoding contract exists.

## Stage 4 acceptance criteria

- CRC-32C reproduces the standard check value `0xE3069283` for `123456789`.
- A written container reads back identically, including generation and every
  section.
- Each of the twelve ordered checks is exercised, and each reports the diagnostic
  code the contract assigns it.
- The checks run in contract order, so a container breaking several rules reports
  the first one rather than an arbitrary one.
- Every `nostdb-spec` container fixture reproduces its declared outcome, run
  against the pinned commit set from the superproject rather than a vendored copy.
- A generation advances monotonically and never decreases.
- A journal replays idempotently, and a torn record is discarded rather than
  replayed.
- A failed commit leaves the previous container readable.
- `cargo fmt --check`, `cargo check`, `cargo clippy --all-targets --all-features
  -- -D warnings`, and `cargo test --all-targets --all-features` pass.
- No conformance fixture is copied into `nostdb-core`.
- Child CI is green, and root CI is green over the new pin.

## Stage 6 scope

Stage 6 is taken in three increments, for the same reason Stage 5 was: each is
verifiable on its own, and the later ones depend on the earlier.

| Increment | Content | Status |
| --- | --- | --- |
| 1 | query subset contract in `nostdb-spec`, plus the Cypher lexer and parser for the read subset | DONE |
| 2 | semantic analysis and read execution over a graph | DONE |
| 3 | write clauses, explicit transactions, and `CALL nostdb.*` procedures | DONE |

### Increment 3 scope

Complete the published query subset, so nothing in it is refused by the Engine.

In `nostdb-spec`:

- specify aggregation, including the grouping rule, the value each aggregate yields
  over no input, and the scope `WHERE` and `ORDER BY` see after an aggregating
  projection;
- specify inline property maps, which `MERGE` needs to be meaningful;
- specify write-clause semantics for `CREATE`, `MERGE`, `SET`, `REMOVE`, `DELETE`, and
  `DETACH DELETE`, including the rules NostDB's model imposes on openCypher;
- specify explicit transactions and the stale-base-generation conflict;
- specify the `CALL nostdb.*` procedure and `nostdb.*` function registry, with each
  one's columns, and mark the one that needs a capability this build does not have;
- register `LINKED_DATABASE_READ_ONLY`, which the contract already named and the
  registry did not carry;
- add write, aggregation, and procedure fixtures, plus a `semantic/` suite, because no
  fixture covered `CYPHER_SEMANTIC_ERROR` at all.

In `nostdb-core`:

- parse and execute every construct above;
- mint record identifiers, deferred since Stage 3;
- add explicit transactions over an open database.

## Stage 6 increment 3 verification

Passed on 2026-07-26 in `nostdb-spec` at `9bb9665` and `nostdb-core` at `b40421b`.

Rust command set clean in both children: 327 unit tests plus 17 conformance and storage
tests in the Engine, and 28 tests in the specification harness.

All 67 published Cypher fixtures reproduce their declared outcome: 38 accepted, 19 refused
with `CYPHER_UNSUPPORTED`, and 10 refused with `CYPHER_SEMANTIC_ERROR`.

This completes Stage 6. Nothing in the published subset is refused by the Engine, apart from
the one procedure whose capability is gated.

### Version 1 was completed rather than superseded

Adding writing, aggregation, and procedures to a published contract without bumping its
version needs a reason. Version 1 already declared `CREATE`, `MERGE`, `SET`, `REMOVE`,
`DELETE`, `DETACH DELETE`, and `CALL` in the subset, and stated that write fixtures would
arrive with write support; aggregation and map expressions are named by `docs/PRD.md` section
19.1 as part of the same MVP subset. Sections 8 through 12 are therefore the completion of
version 1, and the document says so at the top.

A second version would have implied that an implementation could conform to version 1 by
implementing reading only, which the first revision explicitly did not offer.

### A published contract named an unregistered code

`docs/QUERY_SUBSET.md` named `LINKED_DATABASE_READ_ONLY` from its first revision, and
`diagnostics.json` never carried it. The registry check ran only in the other direction, so a
published contract promised a code no implementation could look up and nothing noticed.

The code is now registered, and a new tripwire fails when a specified contract mentions a
code-shaped token the registry does not carry. Every backticked upper-snake token across the
three contracts is a diagnostic code, so the check is exact rather than approximate.

The Engine carries the variant and cannot yet emit it. That is recorded on the variant itself
rather than left for a reader to wonder about: no linked record is bindable until link
resolution and recursive federation land, so a write has no way to name one. The guarantee is
structural rather than checked, because every mutation resolves through the root graph.

### The cross-repository check caught the drift it exists for

Registering the code in the specification and not the Engine failed
`scripts/verify-workspace.sh` immediately, naming `LINKED_DATABASE_READ_ONLY` as present in
one and absent from the other. That is the second time this check has earned its place.

### Two defects the increment found

The sort key ordered `-3` before `-5`. It formatted a number into a fixed-width string and
compared strings, so `"-00000000000000000003"` sorted before `"-00000000000000000005"`, and
an integer could not be compared against a float at all. The key is now a typed enumeration
whose variant order *is* the total order the contract states, with an exact integer-to-float
comparison rather than a conversion that would call two distinct large integers equal.

Equality was made to agree with it, because `1 = 1.0` is true in Cypher and `DISTINCT`
already treated them as one value. Leaving them apart would have meant `DISTINCT` folding
together two values that `=` reported as different.

The defect was carried from increment 2 and surfaced only because this increment wrote the
ordering rule down. Fixing it also removed the trick that expressed a descending sort by
complementing each character of the key; one comparator that knows each key's direction
replaces it.

An unaliased column was named by the Rust debug rendering of its expression, so
`RETURN toUpper(n.name)` produced a column called `Call { name: "toUpper", .. }`. Columns are
now named by the expression's own text, which is what openCypher does, and which aggregation
needed anyway.

### Identifier minting: deterministic rather than random

Minting was deferred in Stage 3 because choosing an entropy source belonged with storage.
There is no entropy source: an identifier is derived from the generation being written and a
counter within the transaction.

An identifier only has to be unique within one database, because a record is identified
across databases by the pair of canonical locator and local identifier. A generation is
committed at most once, so no two transactions can mint the same value and a deleted record's
identifier is never reissued.

Determinism also buys something randomness would take away: the same write against the same
database produces the same bytes, which is what lets synchronization compare content digests
rather than wall-clock time. A test asserts two identical databases stay byte-identical after
the same write.

A `.nost` file may state an identifier explicitly, so a minted candidate is checked against
the graph and skipped if taken. The counter never repeats, so that terminates.

### The read-only boundary is structural

`execute` takes `&mut Graph`. A caller holding a shared graph therefore cannot execute a
writing query at all, rather than being told it may not. That replaced the alternative of a
read-only entry point that refuses a write, which would have needed a diagnostic code
meaning "correct query, wrong entry point" — and the contract's own definitions say
`CYPHER_SEMANTIC_ERROR` means retrying will not help, which would have been false.

### A write reporting no change modifies nothing

A transaction decides from its change count whether to advance the generation, so the count
saying nothing changed has to mean the file is untouched. `REMOVE` of an absent property and
`SET` of a label already present therefore record no user contribution either; an earlier
draft added one, which would have advanced a generation over a query that did nothing.

The rule is one-directional on purpose, and the contract says why: reporting a change that
did nothing costs a caller a generation, while reporting no change after modifying the
database would lose the modification.

### Snapshot semantics for write values, stated rather than emergent

The values a write clause assigns are evaluated against the graph as the clause found it, so
one row's write cannot change what another row assigns. `MERGE` is the deliberate exception,
because matching per row is what keeps a repeated row from creating a duplicate.

Both are tested: swapping two properties in one `SET` swaps them rather than collapsing them
to one value, and merging over `["alpha", "alpha", "beta"]` creates two records.

### A third fixture suite, because one code had none

No fixture covered `CYPHER_SEMANTIC_ERROR`, even though the code is required by
`docs/PRD.md` section 28 and registered since increment 1. `fixtures/cypher/semantic/` now
holds ten.

Writing it exposed a wrong assumption. Four of the ten are not refused while parsing: a
created node without a label depends on whether the variable is already bound, which the
parser does not know. The suite's requirement is therefore that a fixture is refused against
*any* graph including an empty one, and that it leaves that graph untouched, which is both
honest and a stronger assertion than refusal alone.

Two of the four moved into the parser on the way, because an undirected or untyped
relationship in a write clause is settled by the pattern alone. The writer still refuses
them, since it is a public API a caller can hand a hand-built pattern to.

### Recorded divergence closed

Increment 1 refused every write clause and increment 2 refused every aggregate, both
recorded as temporary. Both are now implemented, and the fixture suites cover them.

`nostdb.refresh_links()` is the one remaining refusal, and it is a contract feature rather
than a gap: the contract marks it capability-gated, and refusing with `CYPHER_UNSUPPORTED`
naming the missing provider is what it requires of a build without one. Answering "nothing
changed" instead would be a plausible lie. It closes with the GitHub provider in Stage 9 and
link management in Stage 7.

### Deferred out of Stage 6

- the machine-readable result envelope. `result_version` is still unauthored in
  `nostdb-spec`, and `QueryResult` stays an in-memory type carrying a write summary. It lands
  with the CLI output formats in Stage 7;
- link resolution and recursive federation, which Stage 7 needs for link management and
  Stage 9 for remote sources. Until then a query sees its root database only, which is a
  subset of what the contract permits rather than a contradiction of it;
- build coverage in `nostdb.build_status()`. The container reserves a section for it and
  nothing writes one yet, so the procedure reports what the database records. Adding a
  column later is a `query_subset_version` change, which the contract states.

### Verification commands

In `nostdb-spec`:

- `cargo fmt --check`, `cargo check --all-targets --all-features`,
  `cargo clippy --all-targets --all-features -- -D warnings`,
  `cargo test --all-targets --all-features`
- `bash -n scripts/verify-repository.sh` and `./scripts/verify-repository.sh`

In `nostdb-core`, the same command set plus `./scripts/verify-repository.sh`.

In the root:

- `./scripts/verify-workspace.sh` over the re-pinned commit set, which also failed first on
  the diagnostic drift described above
- `git diff --check`

Continuous integration, after the push was authorized:

| Repository | Run | Commit |
| --- | --- | --- |
| `nostdb-spec` | `30210517259` | `9bb9665` |
| `nostdb-core` | `30210523368` | `b40421b` |
| root `nostdb` | `30210528017` | `1041ff4` |

The root run checked out both pins recursively, passed `scripts/verify-workspace.sh`, and
passed each child's `scripts/verify-repository.sh`. The children were pushed before the root,
because a root pin cannot resolve until the commit it names exists on the remote.

Four new specification checks, each proven to reject rather than assumed to work:

| Rejected condition | Diagnostic |
| --- | --- |
| a contract naming an unregistered code | `docs/QUERY_SUBSET.md mentions LINKED_DATABASE_READ_ONLY, which the registry does not carry` |
| a fixture declaring the wrong outcome for its directory | `must declare outcome = accept` |
| an expectation file whose fixture was deleted | `has no fixture` |
| a declared aggregate with no accepted fixture | `the contract declares sum() in section 9.1, but no accepted fixture uses it` |

Every newly published refusal was also exercised end to end and reports the intended code
with a message that says why, including each write-clause model rule, both whole-record
assignment spellings, `DISTINCT` inside an aggregate, an aggregate in a `MATCH` predicate, a
nested aggregate, a writing `UNION` operand, a `YIELD` of a column no procedure produces, an
unknown procedure, and the capability-gated one.

## Stage 7 scope

Stage 7 is taken in four increments, for the same reason Stages 5 and 6 were.

| Increment | Content | Status |
| --- | --- | --- |
| 1 | connect `nostdb-cli` as scaffolding; `.nost` language version 2; `.nost` to graph conversion in both directions | DONE |
| 2 | the settings contract, then `help`, `init`, `check`, `convert`, `export`, and the exit classes | DONE |
| 3 | the result envelope contract, then `query` in immediate mode, the multiline REPL, and table, JSON, JSONL, and CSV output | DONE |
| 4 | link resolution and recursive federation in Core, then `link add|remove|list|check`, `build`, `plan`, `apply`, and `sync` | DONE |

The first two were one increment until the work was inspected. Core stops at the `.nost`
tree: it parses, validates, and formats, and nothing turns a parsed document into a graph or
a graph back into a document. Synchronization decides *whether* to convert and then has
nothing to call. That conversion is Engine work, it is what `convert`, `export`, and `sync`
all stand on, and it is larger than the command surface that uses it.

### Authorized scope

Creating each remaining child repository, connecting it, and pushing was authorized for
Stages 7 through 12 in one grant rather than per repository. `nostdb-cli` is created in this
increment; the rest are created by the Stage that first needs them, as the Stage table
records.

### Why the language contract comes first

`nostdb convert` is in this Stage, and it cannot turn a stated `.nost` identifier into a
record identifier until the contract says what one looks like. Checking that turned up a
second conflict, and answering both took the language to version 2. Both conflicts and the
resulting design are recorded below.

Increment 1 is therefore larger than first estimated. It is still one increment rather than
two, because the grammar change, the fixture rewrite, and the conversion it exists to enable
are not separately verifiable: a fixture suite half-way between two language versions proves
nothing.

### Deferred out of increment 1

- every command, including the `nostdb-cli` crate itself. Its initial commit is repository
  scaffolding only, as `nostdb-spec` and `nostdb-core` were when they were connected, so how
  the CLI depends on the Engine is decided in increment 2 rather than guessed at now;
- `query` and every output format, which need the result envelope contract;
- `build`, `plan`, `apply`, and `sync`, which need the analysis pipeline and link resolution;
- `catalog`, `server`, `plugin`, and `view`, which belong to Stages 8, 11, and 12.

## Stage 11 scope

Stage 11 builds the plugin system: the first mechanism by which code somebody else wrote
runs alongside the Engine.

| Increment | Content | Status |
| --- | --- | --- |
| 1 | this scope | DONE |
| 2 | the `manifest_version` contract and the GitHub plugin source grammar, with fixtures | DONE |
| 3 | connect `plugins`; a reference manifest and the authoring guidance | DONE |
| 4 | reading a plugin source and validating a manifest | DONE |
| 5 | `nostdb plugin add`: fetching, digests, consent, and the install record | DONE |
| 6 | out-of-process execution and the Engine-owned exchange stream | DONE |
| 7 | the viewer's exchange format, and a reference viewer that consumes it | DONE |

### Increment 2: a manifest is a request, not a grant

Everything under `permissions` is what a plugin **asks** for. The user approves an
installation, the approval is recorded, and execution is checked against the record rather
than against what the manifest says today. A plugin that could widen its own permissions by
editing its manifest would grant itself whatever it liked, and the recorded digest is what
makes an edit visible.

Four decisions the document argues rather than states:

- **`entrypoint.command` is an argument vector, never a string.** A manifest comes from a
  repository somebody else wrote, and a string a shell interprets is that author choosing
  what runs — including what runs *instead*. The path must name something inside the plugin:
  one naming `/bin/sh` or `../../../usr/bin/env` is naming something it did not ship;
- **`database_write` exists so it can be refused by name.** Only the Engine writes `.nostdb`,
  so the field could have been omitted — but then a manifest requesting it would be silently
  ignored, and an author who asked has a misunderstanding worth correcting rather than one
  worth leaving them holding;
- **`network_hosts` rejects `*`.** Not treating it as a wildcard: a plugin wanting the whole
  network is asking for something a user cannot meaningfully approve, and a field able to
  express that makes refusing harder rather than easier;
- **two digests are recorded, not one.** The manifest digest detects an edited request; the
  tree digest detects edited code behind an *unchanged* request, which is the more dangerous
  of the two precisely because nothing about the plugin's stated intent would have changed.

An escaping `output_paths` entry is rejected rather than clamped, for the reason clamping is
usually wrong: it would grant something adjacent to what was asked, and the author would not
know which.

Twenty-two fixtures install nothing. Here that is not only the convenience it was for the
change-set and locator suites — a suite that installed a plugin to test installation would be
executing the thing this contract exists to keep from executing.

### Increment 3: the authoring surface, and a check written the other way round

`plugins` is created, connected, and pinned — the seventh child repository and the last one
the Stage table names. Apache-2.0: a schema nobody can implement freely is a schema with one
implementation.

The reference manifest **explains** each permission rather than only stating it, because a
reference is the thing people copy and a copied permission nobody understood is one nobody
audited.

`AUTHORING.md` says plainly that a plugin is **not sandboxed**. The MVP does not implement
one and does not claim one; a plugin runs as your user, with your files, and the process
boundary is the whole of the isolation. It also says that nothing here claims an unsigned
third-party plugin is safe, because nothing here has earned the right to.

**A check written the other way round, after four failures.** The obvious way to enforce
"do not claim a sandbox" is to search documents for the claim. That check fired immediately
— on this repository's own `AGENTS.md`, in the list of things it forbids. A grep cannot
distinguish a document *making* a claim from one *forbidding* it, and this project has now
hit that exact failure four times: the provider's `.nostdb` path check, the Skill's unpinned
`npx` check, the natural-language keyword scan that needed literals stripped, and this.

So the check is inverted. Instead of searching for the claim, it **requires the disclaimer**:
the two documents a user reads must each say plainly that there is no sandbox. That cannot
false-positive on prose about the rule, and a document that added a false claim would have
had to drop the disclaimer first — which is the thing being checked.

A positive check is not always available. Where it is, it is the better one, because it fails
when the thing you want is absent rather than when a string you fear is present.

### Increment 4: deciding acceptability, with no way to run anything

The half of `plugin add` that decides whether a plugin is acceptable. Nothing in it fetches,
writes, or executes.

That is the contract's separation rather than a convenience. Installation must not execute
plugin code, and the surest way to hold that is for the code deciding acceptability to have
**no way** to run one — a rule enforced by what a module can reach is one that does not
depend on anybody remembering it.

Every problem is reported rather than the first, so an author fixes a manifest in one pass
rather than one failed install per mistake. An unsupported version is returned alone, because
naming a malformed field after an unreadable version sends somebody looking for one that is
not there.

A source with no ref is **not** resolved here. The manager resolves the default branch once
and records the commit, so a user pins what they installed and moving a branch does not move
them. That is a decision with a cost — a fix reaches a user only when they ask — and the
authoring guidance says so rather than leaving an author to discover it.

**Scope split.** Increment 4 was scoped as all of `plugin add`. Reading is now increment 4
and fetching is increment 5, because the two have different testability: reading is gated by
twenty-two published fixtures with no network at all, and fetching needs the same recorded-
response treatment the provider got. Grouping them would have meant reporting neither until
both were done.

### Increment 5 scope

The half of `plugin add` that fetches. Increment 4 decided whether a plugin is acceptable and
had no way to obtain one; this obtains one, records what was approved, and still executes
nothing.

In `nostdb-spec`:

- a new contract `plugin_install_version`, specified in `docs/PLUGIN_INSTALL.md`. The manifest
  contract names the seven things an installation records and stops there, which is right —
  it is the document a plugin *author* reads, and the record is written by the manager and
  read later by the executor. Coupling the record's shape to the shape of the document an
  author writes would make one unable to change without the other;
- the two digests' exact computation, because a digest whose derivation is not written down
  cannot be verified by a second implementation, and the whole point of recording one is that
  somebody else can check it;
- the archive limits and the path rules a fetched tree must satisfy, which `docs/PRD.md`
  section 23.3 requires an installation to validate and nothing has specified;
- the Engine range grammar. Section 2.2 of the manifest contract says a plugin declares the
  Engine versions it works with "as a range" and never says what a range is;
- register `PLUGIN_INCOMPATIBLE`, `PLUGIN_DIGEST_MISMATCH`, `PLUGIN_SOURCE_INVALID`, and
  `PLUGIN_LIMIT_EXCEEDED`;
- fixtures for records, ranges, and trees, none of which installs anything.

In `nostdb-cli`:

- fetch through the public `nostdb_core::provider::ProviderClient`. The command surface must
  not bundle a GitHub implementation, and the provider protocol already has exactly the three
  requests an install needs: resolve a ref to a commit, enumerate a tree, read an entry;
- enforce the path rules and the archive limits over the enumerated tree **before** reading
  any content, because a limit checked after the download is not a limit;
- validate the manifest with increment 4's reader, and check its Engine range against this
  build;
- compute both digests, write the plugin's files and the install record, and preserve the
  previous state when any of it fails;
- `nostdb plugin add`, with the scope question section 23.4 requires.

### Deferred out of increment 5

- execution and the digest re-check in front of it, which is increment 6. The record exists so
  that something can be refused later; nothing yet does the refusing;
- `PLUGIN_REQUIRED`, which stays on the root's awaiting list. It belongs to an action that
  needs a missing plugin, and no action needs one until the viewer in increment 7. Registering
  it now would mean publishing a code no implementation can raise, which is the exact failure
  `LINKED_DATABASE_READ_ONLY` recorded in Stage 6;
- `plugin list` and `plugin remove`, refused by name rather than falling through to "unknown",
  which is the treatment `link refresh` established.

### The format's shape is fixed by what a renderer does, not by taste

`docs/PRD.md` section 24.3 requires instanced node and edge rendering, incremental decoding, and no
allocation of the full graph as DOM elements. Those decide the format:

- **columns, not records.** A renderer uploads a buffer per attribute. A record layout would make it
  walk the whole graph to gather one attribute and copy it into the buffer it wanted anyway;
- **edges name endpoints by index.** An edge naming opaque identifiers would make a renderer build a
  hash map over every node before drawing one line — the exact work a million-edge graph cannot
  afford. The identifier is still carried, in its own section, because source navigation needs it;
  what changed is that drawing never resolves one;
- **sections are independently locatable**, so a viewer may draw geometry before reading evidence it
  does not need yet.

The counts sit in the header rather than in the sections because a viewer allocates before it
decodes. Reading a count out of a section would mean two passes or a growing allocation.

### Nothing in the format can express a relationship the graph does not have

Section 24.2 requires disconnected components to stay disconnected. A format with a parent or root
field a layout could hang everything from would make violating that the easy path, so there is no
such field — and the reference viewer finds components from the edges and lays each out separately.

The same reasoning put the **broken-link marker** in the sources table rather than leaving an
unavailable link out of it. Omitting it would report a link as never having been declared, and the
product contract requires an unavailable source to stay declared.

### `VIEW_CAPACITY_EXCEEDED` is not a refusal of the format

`VIEW_EXCHANGE_INVALID` means the bytes are not a readable exchange. `VIEW_CAPACITY_EXCEEDED` means
the bytes were fine and this viewer on this machine cannot draw them.

The same file may exceed one machine's capacity and not another's, so the second is a fact about a
renderer and never about the file. They send a user to different places: one to whoever produced the
file, one to a smaller graph or a better machine. `VIEW_CAPACITY_EXCEEDED` has been on the root's
awaiting list since Stage 1 and is registered now, because there is finally a renderer that can
reach its own limit.

### The check that caught the wrong owner

Both new codes were registered against `nostdb-cli`, and the workspace ownership check refused the
pin: the command surface never declares either. It was right, and the fix was not to declare them.

A container is *written* by the CLI and *read* by a viewer, and both codes are raised by a reader. So
the owner is `plugins`, which is where the reference viewer lives. Making that pass needed one more
correction: the check looked for an owner's implementation under `src`, and `plugins` keeps reference
plugins under `reference` — its own verifier forbids a `src`. So an owner that had implemented every
code assigned to it would have been reported as awaiting an implementation.

That is the fourth time this check has earned its place, and the first time it was right about
something other than drift.

### Two suites, split where a decoder is needed

The specification harness parses the header and the section table and stops. Four rules — a string
index out of range, an endpoint past the node count, a source zero that is not the root, evidence out
of order — are payload rules, and refusing them needs a decoder.

So `nostdb-cli` carries the decoder and its suite runs all twenty-one containers, and the split is
asserted rather than implied: a test names those four and fails if any lacks a fixture. Without that,
the half of the published suite only an implementation can run could have quietly stopped running.

The CLI's suite also decodes a container this build **wrote**, through the same reader. A writer whose
own reader refuses its output would be two implementations of one contract, and this file is the one a
browser fetches.

### The fixtures are generated, and the generator is the readable form

Twenty-one binary containers, written by `fixtures/view-exchange/generate.mjs`. A hand-edited byte
array is one nobody can extend and one people copy without understanding, so the construction of every
fixture is a script a reader can follow.

`scripts/verify-repository.sh` re-runs it and fails if any fixture changes. That gates two things at
once: a fixture edited by hand, and a generator that drifted from its own output — a document
describing a file it no longer writes.

### The reference viewer, and what it does not claim

`plugins/reference/view-webgpu/bin/nostdb-view` speaks the protocol, verifies the artifact's digest
before interpreting it, decodes every section, and writes `view.html` and `view.data.bin`.

It draws with **Canvas 2D**. It does not use WebGPU and implements no instanced rendering, compute
layout, level of detail, clustering, edge aggregation, or label culling, and claims no performance
tier. Stage 11's own deferral said this increment owes a reference that proves the format and not the
tiers, and the repository verifier now requires the README to say both things — the positive form of
the check, which is the shape this project settled on after four attempts at the negative one.

Layout is a deterministic ring per component rather than a force simulation. A simulation would look
better and would draw the same input differently every run, which is the wrong trade for a reference.

Data is embedded in the page rather than fetched from the sibling file, because a page opened with
`file://` cannot fetch its sibling. `view.data.bin` is still written, because the manager removes its
temporary artifact and a page that wanted to re-read the data would otherwise find nothing.

### Resolved: the rule that made the viewer untestable

The increment first shipped with the viewer's decoder unverified by any suite, because
`plugins/AGENTS.md` said "Never execute a plugin's code here" — and that rule was not relaxed for the
one plugin the repository owns, on the grounds that a rule holding except for the code you wrote
yourself is not a rule. The gap was recorded and put to the user rather than worked around.

The user selected narrowing the rule. It now forbids **installing** a plugin and **executing an
installed one**, while permitting a reference plugin's own suite to run the code in its own
repository against fixtures it was given.

That is what the rule was protecting all along. Installation must not execute a stranger's code; an
author testing their own is a different act, where nothing is installed, nothing is fetched, and what
runs is code the repository authored and can read. A reference nobody can test is one whose
correctness is a claim rather than a result.

`reference/view-webgpu/test/viewer.test.mjs` now runs the viewer over all 21 published containers:
each accepted one decoded to the counts its expectation declares, each rejected one refused with the
declared code, and every refusal leaving no page behind. Plus the protocol cases that need no
fixtures, a digest that does not match, and a media type this build does not read — 69 checks.

So the format has **three** independently tested decoders reading the same published fixtures: the
specification harness, `nostdb-cli`, and the viewer itself. The third is the one a browser's data
actually passes through.

The fixtures reach it as a sibling inside the superproject, and root CI exports
`NOSTDB_SPEC_FIXTURES` for the child verifiers so a skip there would be a gap rather than a pass.
Cloned on its own the suite skips the container half and says so.

### One repair root CI found, in code this increment did not touch

The first root run after Stage 11 closed went red on `nostdb-core`, in a Stage 9 test nothing here
changed: `a_provider_that_exits_instead_of_answering_says_so_rather_than_hanging`.

Whether a vanished provider surfaces as a failed write or as end-of-file on the read is a race the
operating system decides. If the child is already gone the write fails with a broken pipe; if it is
still alive the write succeeds and the read finds nothing. The test accepted only the second, so it
passed on every machine slow enough to lose the race — until a CI runner won it.

Fixed in the test rather than the transport, because both messages are correct and the property the
test's own name asks for is that the conversation *ends with a reason* rather than blocking. Pinning
which of the two reasons appeared was pinning the scheduler.

Recorded here rather than left to look like part of increment 7: it is a latent flake that was always
there, and it is only in this record because a push of mine is what surfaced it.

### Deferred out of Stage 11, and now the record of what Stage 11 did not do

- **WebGPU rendering and the three performance tiers.** Real requirements, and not Stage 11 ones;
- **the benchmark report.** Section 24.3 requires one identifying browser, GPU, CPU, memory, dataset,
  and whether WebGPU or fallback rendering was used, measured on a published reference machine. No
  such machine exists. A report naming this one would be a number nobody can reproduce, and an
  unreproducible measurement is worse than none because the first gets mistaken for a guarantee;
- **a signature scheme**, which would let the MVP imply a guarantee it has not earned;
- **non-GitHub plugin sources**, for the reason Stage 9 deferred non-GitHub providers.

### Stage 12 scope

The last Stage, and the one that makes every earlier one reachable by somebody who did not build it.

| Increment | Content | Status |
| --- | --- | --- |
| 1 | the version report, completed | DONE |
| 2 | connect `nostdb-distribution`; the npm launcher, platform resolution, and artifact checksums | DONE |
| 3 | connect `homebrew-tap`; the formula and its checksum verification | DONE |
| 4 | release assembly, published checksums, and the source-install route | DONE |

### Increment 1 first, because it is what every other increment is verified against

`docs/PRD.md` section 25.3 requires release archives, npm wrappers, Homebrew formulae, and source
builds to "report compatible `nostdb --version --json` data". That report is therefore the surface
every install route is checked at, and it is incomplete.

It states five keys. Section 25.4 names three the build does not report at all —
`server_protocol_versions`, `provider_protocol_versions`, and `plugin_protocol_versions` — and six
more contracts have been specified since that section was written and appear nowhere:
`query_subset_version`, `result_version`, `catalog_version`, `manifest_version`,
`plugin_install_version`, `change_set_version`, and `view_exchange_version`.

This is not only a reporting gap. `skills/skills/nostdb/RESOLUTION.md` decides whether an Engine is
compatible by asking the report for **the contract versions it needs**, and
`scripts/resolve-engine.sh` looks the key up in the reply. A Skill asking for
`provider_protocol_version` finds nothing and concludes a working Engine is incompatible. The
mechanism Stage 10 built has been reading a report that could not answer it.

### What the report says, and what it must not

It reports every contract this build **implements**, taken from the constant each owning crate
exports rather than from a list written out here — a hand-written list is the thing that was already
six contracts behind.

A `deferred` contract is deliberately absent. `credentials_version` has a reserved key and no
authored contract, so nothing implements it, and a report claiming support for a contract nobody has
written would be false in the one place a caller trusts to be exact.

### The two defects increment 1 found

**The report listed five contracts of thirteen.** Three are named outright in section 25.4 and were
never reported: `server_protocol_versions`, `provider_protocol_versions`, and
`plugin_protocol_versions`. Six more were specified after that section was written —
`query_subset_version`, `result_version`, `catalog_version`, `manifest_version`,
`plugin_install_version`, `change_set_version`, and `view_exchange_version` — and appeared nowhere.

The list was hand-written, which is how it fell six contracts behind. It is now built from the
constant each owning crate exports, and `tests/version_conformance.rs` checks it against the
registry in both directions: every specified contract present with the versions it declares, nothing
invented, no deferred contract claimed, and the human column naming the same contracts as the JSON.

`query_subset_version` had no constant anywhere. The Engine implements a versioned subset and had
never said which version, so the report had nothing to read; `nostdb-core` now states it, in the
crate that owns it.

**The Skill has never been able to read a real report.** `resolve-engine.sh` looked up the contract
key, `nost_language_version`. The report answers with what a build *supports*, which is a list,
keyed `nost_language_versions` — and the singular key is not a substring of the plural one, so the
lookup failed and every real Engine was reported incompatible.

Stage 10 built that resolution and recorded it as tested against fakes, with the argument that a fake
answers a version report exactly as a real Engine would. It did not: **every fake emitted the
singular key**, so the fakes agreed with the question and neither agreed with the Engine.

That is the same failure the budget fixtures found in Stage 10, in the same repository, one increment
over: a suite whose author also wrote the thing it tests agrees with the author's idea of the
document. Recording it twice is the point — the first time it was called out as a lesson, and the
lesson did not transfer to the suite next door.

The script now takes the contract key and looks up that key plus an `s`, which is the vocabulary
every document already uses. The fakes answer the real shape, and the suite checks a real report when
one is on the path — the check that stops this returning. Proven against the built binary: before the
fix a real Engine on the path was refused, and after it resolves.

### A second flake, and what was and was not fixed

Root CI went red again, this time on the Stage 8 daemon round trip: `no daemon is listening`.
`start_daemon` had reported success, so the daemon acquired its lock and then was not there when the
query ran.

**The cause is not established.** `is_running()` is a real lock acquisition rather than a check for a
leftover socket, which is what the server contract requires and rules out the obvious explanation.
What is established is that nothing could say why: `start_daemon` discarded the daemon's standard
error, so a failure of the thing being started reported only that it had not worked.

That is the failure mode this project already named for a provider — swallowing diagnostics into a
buffer nothing reads makes a misbehaving process silent — and it was in the CLI's own daemon client
the whole time. The diagnostics are kept now and appear in both failure messages, so the next
occurrence names something instead of being guessed at.

The test is also no longer run where several repositories' suites share one operating-system user.
The daemon's endpoint and lock are **per-user**, and root CI runs every child's suite in one job as
one user; a per-user singleton is not safe to share. Root CI sets `NOSTDB_SHARED_RUNNER`, the child
leaves the round trip off and says so, and `nostdb-cli`'s own CI — which has the runner to itself —
still runs it.

Recorded as an isolation change rather than a fix, because that is what it is. A test moved to where
it can run is not a bug closed, and the next red run is the one that will say what the bug was.

### Recorded gap: neither distribution repository has a license

`docs/PRD.md` section 33 lists the license for every clean-slate repository and names neither
`nostdb-distribution` nor `homebrew-tap`. Every repository must carry its own license and the
workspace verifier checks that it does, so the two cannot be created without one.

The PRD's own pattern is unambiguous about which tier each thing is in: SSPL-1.0 for the three
repositories that **are** the product — Core, the CLI, the daemon — and Apache-2.0 for everything at
the edge that a third party should be able to fork and reimplement: the specification, the Skills, a
future thin adapter, and provider and plugin schemas and drivers.

A launcher and a formula are edges by exactly that logic, and there is a concrete reason beyond
pattern-matching. An npm package that *installs* SSPL binaries is not itself the SSPL work, and
putting a copyleft licence on a launcher would make packaging NostDB for a distribution or a mirror
legally fraught for no benefit — while the entire purpose of a launcher is that people install
through it.

So both carry **Apache-2.0**, with the reasoning above rather than as an assumption. `docs/PRD.md` is
not edited: it is the approved contract and Stage 0 verification diffs it against an approved source.

This is reversible at the cost of one commit for as long as nothing is published, and nothing is.
Overruling it is the user's call and is cheap until the first release.

## Stage 12 increment 2: the launcher

`nostdb-distribution` is created, connected, and pinned — the eighth child, and the last one the
Stage table names besides the tap. Apache-2.0, for the reason recorded above.

### What a launcher is, and the one thing it must not become

It resolves this platform to a published release target, verifies the installed artifact against
checksums the package itself ships, and executes it with the arguments untouched and the exit code
unchanged.

`docs/PRD.md` section 25.1 says outright that it does not reimplement Core in JavaScript. That is the
prohibition worth enforcing rather than trusting, because a launcher is exactly where a convenience
reimplementation would appear: reading a `.nost` to answer a question without starting the Engine
looks like an optimization right up until two implementations disagree. The verifier searches the
launcher and its library for the names such a thing would have.

It also does not interpret arguments. Everything after the program name is forwarded and the native
exit code is reported unchanged, because section 25.3 requires every install route to report
compatible `nostdb --version --json` data — and the only way to be sure of that is to not be in the
way. A launcher that answered `--version` itself would be reporting on the launcher.

### Three decisions about verification

- **the checksums ship inside the package.** An artifact comes from a release and is checked against a
  digest that travelled in the npm tarball, so somebody who can serve a substituted artifact cannot
  also serve the digest that would accept it. A checksum fetched from beside the artifact verifies
  that the file arrived intact, which is not the question worth asking;
- **verification happens on every run, not only at install.** An artifact replaced after installation
  is precisely the case an install-time check cannot see. The cost is one digest per invocation;
- **a truncation is reported as a truncation.** The length is checked before the digest, because
  reporting "the digest does not match" for a half-downloaded file sends somebody looking for
  tampering.

A digest mismatch is refused and never retried into acceptance. An artifact that is not the one
recorded is not one a retry makes right.

### Resolution is a table, not a computation

Six targets, keyed by what Node reports before any native code has run — which is the entire
situation a launcher is in. A computed triple would name an artifact nobody built, and the failure
would arrive as a download that 404s rather than as a refusal that lists what exists.

An unpublished platform is refused by name, with the published targets and the source-install route
section 25.3 publishes. Falling back to the nearest target would run a binary built for another
machine, and that fails somewhere unrelated to the cause.

### What is tested, and the state the package is actually in

Section 25.1 requires platform resolution and artifact checksums to be tested "for every supported
release target", and both are testable with no network and no release: one is a table, and the other
is a digest over bytes the suite writes itself. 58 checks.

The launcher's behaviour **with no artifact present** is tested too, because that is the state the
package is in: nothing is published, so `checksums.json` records nothing. It refuses by name, says
what is missing and how to get it, and writes nothing to stdout. Inventing a digest for an artifact
nobody has built would have been a value nobody could reproduce.

No test publishes anything and no test reaches the network. A suite that reached a registry would be
testing the registry.

### A credential limit worth recording

The first push was refused: the OAuth token this session holds lacks the `workflow` scope, so it
cannot create a file under `.github/workflows/`. The push went through the SSH host alias the root
already uses, which is how every other child was pushed.

Recorded because the next person to create a child repository will hit it, and the diagnostic —
"refusing to allow an OAuth App to create or update workflow" — does not say that a different remote
would work.

## Stage 12 increment 3: the tap

`homebrew-tap` is created, connected, and pinned. **Every child the normative layout names is now
connected**, which is the first time that has been true since Stage 1 narrowed its own scope to two.

The formula installs the same native binary npm and a GitHub release install, and verifies the same
release checksum. It builds nothing, and the verifier refuses `cargo`, `make`, or a Rust dependency
appearing in it: section 25.2 says the formula installs the native CLI and Engine and verifies the
release checksum, and one that compiled from source would be installing something no checksum in the
file describes.

### The test asserts the report, not that the binary starts

Section 25.3 requires release archives, npm wrappers, Homebrew formulae, and source builds to report
compatible `nostdb --version --json` data. A formula test that only checked for a running process
would pass for a build that reported nothing, so it reads the report and checks the product, the
version, and the contract lists — and then runs `nostdb init`, because a path-based command working
with no daemon is the invariant the product is arranged around and the one an install is most likely
to break.

### Placeholder digests, said out loud

Every `sha256` is the all-zero placeholder, so `brew install` refuses rather than fetching something
unverified. That is the correct state for an unpublished tap.

The verifier requires that state to be **deliberate**: a formula carrying placeholder digests must
also say why in the file. Otherwise the difference between "no release yet" and "somebody forgot to
update the digests after one" is invisible, and the second is how an unverified download gets shipped.

### `brew style` found two defects `ruby -c` could not

The verifier must be non-mutating, and `brew style` requires the formula to be inside a real tap —
installing one would change this machine's Homebrew. So the verifier runs it only where the repository
*is* a tap, and otherwise says so and prints the commands to do it by hand.

Run that way once, it found two real defects: `version` must precede `license`, and
`assert_predicate ..., :exist?` is deprecated in favour of `assert_path_exists`. Neither is visible to
a syntax check, and both are the kind of thing that fails at somebody else's install rather than here.
The temporary tap was removed afterwards and Homebrew's state restored.

Recorded because the verifier now prints those commands: a check it cannot run itself is one a reader
has to be told how to run, or it is a check nobody runs.

## Stage 12 increment 4: assembling a release without publishing one

The packaging half. It takes a binary somebody else built, attests it, packages it, and records the
digests the launcher and the formula verify. It builds nothing and publishes nothing.

### Two digests per target, because they answer at different moments

The archive digest is what a formula and a release page verify. The binary digest is what the launcher
verifies **after unpacking**, when the archive is gone and the file on disk is what will run. Recording
only the first would leave the thing that actually executes unverified from the moment it was extracted.

Both are written by the same run that wrote the archive. A digest computed separately is a digest of
something that might not be the archive.

### Attestation, and the honest limit of it

A native binary is run and its `--version --json` read before it is packaged: the product, the version,
and at least five contracts. An assembler that packaged whatever it was pointed at would publish an
archive named for NostDB containing something else, with a digest faithfully describing the wrong file.

A cross-target assembly cannot run the binary, so it records `attested: false` rather than passing the
check over in silence — a cross-assembled archive carries one fewer check than a native one and whoever
reads the release should know which they have.

What attestation verifies is the **report**, not the implementation. A stub that reports correctly is
indistinguishable from the Engine by this check. That is written into the suite next to the stub that
proves it, because a check whose limit is not stated gets read as stronger than it is.

### The reproducibility check found a defect on its first run

Two assemblies of the same binary produced different archive digests. Two things were leaking: the
staged copy's modification time, which `tar` records, and gzip's own embedded timestamp. The
`GZIP=-n` environment variable that used to suppress the second is deprecated and ignored by newer
gzip, so the flag is passed to the program instead.

Without that, a digest says two identical releases are different releases — which is the one thing a
release digest exists not to say.

### Verified end to end, short of publishing

Assembled a real archive from the release build of `nostdb-cli`, installed it the way the launcher
expects, wrote `checksums.json` from what the assembly recorded, and ran the launcher against it:

| What | Result |
| --- | --- |
| `--version --json` through the launcher | byte-identical to the native binary's |
| `nostdb init` through the launcher | configured a project, no daemon involved |
| a failing command's exit code | 9 through the launcher, 9 native — not normalized |
| one byte appended to the artifact | `DISTRIBUTION_ARTIFACT_TRUNCATED`, refused |
| the same binary assembled three times | one digest, three times |

That is the whole chain except the two acts that need authorization, and it is what makes the claim
"every install route reports compatible version data" a result rather than an intention for this route.

## Diagnosed, twice: the provider tests exec'd a file they had just written

Root CI failed a third time in `nostdb-core`'s `provider_process` tests, and this time the diagnostic
named the cause: `Text file busy (os error 26)` starting `/tmp/nostdb-provider-handshake.sh`.

The test helper built that path from the test's **label alone**, in a directory every test and every
concurrent run shares. Tests in one binary run in parallel, so one could write a script while another
was executing it — which the operating system reports as `ETXTBSY`. Each test also removed the shared
path when it finished, so a slower one could lose its program mid-run.

Fixed by making the path unique per script, with the process id and an atomic counter. Twelve runs of
the module to confirm it is stable rather than lucky.

### Unique paths were the wrong fix, and the diagnostic said so

It failed again, on `/tmp/nostdb-provider-handshake-8334-0.sh` — a path no other test could touch. So
the collision was never between tests, and the first reading of `ETXTBSY` was wrong even though the
message named the file.

It is fork and exec. These tests run in parallel and `Command::spawn` forks, so a child forked by one
thread briefly inherits the write descriptor another thread still holds on its own script. While that
duplicate exists the file cannot be exec'd **by anyone**. The descriptor is what is busy, not the name,
which is why every unique path in the world does not help.

The fix is to stop exec'ing a written file at all: the fake provider now runs as `sh <script>`, so the
script is an argument and `sh` is the program. Nothing under test is lost — the point is the framing
across a real pipe with a real child, and `sh` reading a script is both. A real provider is an
executable named by configuration, not a file the Engine wrote a moment ago, so exec'ing a freshly
written file was never the case worth covering.

**What proves it is not a run count.** The unique-path fix passed twenty local runs and then failed on
CI. This one is verified structurally: nothing in the crate marks a written file executable any more,
and the only spawns left are `/bin/sh` and a path that deliberately does not exist. A statistical
argument is what the last fix had.

### This is probably what the earlier failure was

The first failure in this module was a broken pipe, and it was "fixed" by accepting either of two
legitimate messages — the write failing or the read finding end-of-file. That was not wrong: both mean
the provider is gone, and pinning which one appeared was pinning the scheduler.

But it was the smaller of the two things worth doing, and it left the cause unfound. A child whose
program is overwritten or removed mid-exec dies, and the parent's next write finds a closed pipe —
which is exactly the symptom. Two failures, one shared path, and the first fix made the symptom
tolerable instead of asking why a provider had vanished.

Recorded rather than quietly superseded, because the lesson is about the fix and not the bug: a test
that accepts a second outcome has stopped asking a question, and that is worth doing only when the
question has an answer.

### The daemon flake is still separate, and still unexplained

`a_named_database_is_queried_through_the_daemon` binds a per-user endpoint rather than writing a
script, so nothing above touches it. It failed once locally after the pull and has passed every run
since, and the diagnostics added for it did not fire — so it is not the path they instrument.

## Release 0.1.1, and a gate that made a second release impossible

Reported against the published 0.1.0: a repository still built to `0 nodes, 0 edges`. Correct for what
was installed — everything Stage 13 landed was source-only, so nothing a user could install had it.
0.1.1 is that work, released.

### The number understates one thing, on purpose

What a build produces changed: `Directory` nodes, a `precision` property, and `GRAPH_SCHEMA_VERSION`
1 to 2, so the first build after this redraws the graph it holds. A patch number is still right,
because the old output was a defect against `docs/PRD.md` section 17.3 rather than a design anybody
chose — what 0.1.0 shipped was never the contract, and the rebuild is the cost of correcting it. The
reasoning sits beside the version in `Cargo.toml` rather than only here.

0.1.1 also satisfies the source-install route section 25.3 published and 0.1.0 could not: the package
is now named `nostdb`, so `cargo install --git … --tag v0.1.1 --locked nostdb` resolves.

### The release gate was circular, and only the second release could show it

Every target refused with `the launcher is 0.1.0`. The gate required the input, the crate, **and**
`nostdb-distribution`'s `package.json` to be one version before building.

That cannot be satisfied. `nostdb-distribution`'s own verifier requires its `package.json` to match
the `checksums.json` it ships, and `checksums.json` cannot exist until the release has been built and
digested. So the launcher could not legally be bumped before the release, and the release would not
start until it was.

0.1.0 hid it completely: the launcher *started* at 0.1.0, so the two agreed for free. The cycle
appeared on the first release that was not the first — which is the kind of defect no amount of
verification on one release can surface.

The launcher check is dropped, and nothing is lost. Its version decides which archive names it looks
*up*, and that those are names the release actually wrote is exactly what its own verifier enforces
by requiring the two documents to agree. Checking it in the workflow as well added no guarantee and
made the process circular.

### The same cycle again, one layer down

With the gate fixed, two of four targets built and two refused with
`ASSEMBLY_REFUSED: reports 0.1.1 and this release is 0.1.0`. `assemble-release.mjs` attests that a
binary reports the version its archive is named for, and it read that version from the launcher's
`package.json` — the identical constraint the gate had, in the script the gate was protecting.

The split was informative rather than random: attestation is skipped when the binary cannot run on
the host, so the two cross-assembled targets passed the check by not performing it. A release where
half the targets are attested and half are not is stated in each recorded entry's `attested` flag,
which is how this was legible at all.

`assemble-release.mjs` now takes `--version`. What is attested does not weaken — the binary must
still report the version its archive is named for — and the only change is who names it. Two checks
were added: a binary that does not report the named version is refused, and a named version it does
report assembles into the archive that version is named for.

### The workaround that was refused rather than taken

Pushing the launcher bump alone would have satisfied the gate. It was not done: it leaves a commit on
`main` that fails its own verifier, and a launcher whose `package.json` says 0.1.1 while its
`checksums.json` describes 0.1.0 archives would refuse every artifact it fetched. A window in which
nobody happens to publish is not the same as a state that is safe to be in.

### What was verified before anything became public

The release was built as a **draft**, and every check below ran against the draft's own artifacts
rather than against a rebuild of them:

- all eight recorded digests re-computed from the assets they name, including the four binaries
  inside the archives. No mismatches;
- the `aarch64-apple-darwin` binary extracted and run: `engine 0.1.1`, 13 contracts, and a Kotlin
  plus `.txt` project building to 4 nodes and 3 edges with the tree traversable;
- the launcher packed with `npm pack`, installed from the tarball, and run — it fetched the released
  artifact, verified it against the `checksums.json` it ships, and reported `engine 0.1.1`;
- each of the four formula digests checked against the downloaded artifact rather than copied from
  the checksums document on trust.

Only then was the draft published, npm published, and the tap pointed at it. `checksums.json` in
`nostdb-distribution` is the document the release wrote, copied unedited.

The reported command, run against the registry afterwards:

```text
npx --yes --package=nostdb nostdb build --project .
recorded   3 files, 3 with no analyzer for their language
nodes      5 created
edges      4 created
note: it analyzes rust; this project is kotlin, markdown, unknown
```

## Reported: a Kotlin repository built to zero nodes

`/nostdb .` succeeded on a 41-file Kotlin project and committed nothing.

### That is the correct answer, and the report was the reasonable reading of it

This build ships **one** deterministic analyzer, for Rust. Nothing in a Kotlin tree is analyzable, so
`0 nodes, 0 edges` is a fact about the project rather than a failure — and `build` exits `0`, because
exiting non-zero over it would break a pipeline that runs `build` before knowing what a repository
holds.

What made it read as a failure is that the note said only:

```text
note: no file has a language this build analyzes, so nothing was committed
```

True, and unactionable. A reader cannot tell from it whether they excluded their own sources by
mistake or whether the language has no analyzer yet, and those have **opposite** fixes: one is a
settings change, the other is waiting for a release. The note now names both sides —
`it analyzes rust; this project is kotlin` — and when every file was skipped before classification
there is nothing found to name, so it reports what it analyzes and lets the skip reasons answer the
rest.

`plan` already reported this correctly (`kotlin 2 files 91 bytes unsupported`), which is the part
worth recording: the information existed on the same report object and `build` was not printing it.

### Found while confirming it: argument order was load-bearing and undocumented

`plan --format json .` was refused and `plan . --format json` accepted, because `split_project_path`
looked at the first word only. `query` documents the opposite rule in the same file — options may
come before or after its statement, since somebody reaching for `--format` after typing a long one
should not have to move it — so the surface disagreed with itself about argument order.

The refused spelling is the one `SKILL.md` documents for the enrichment step. It was refused by
release 0.1.0 **and** by current source, and the dispatcher never emits it, so every check passed
while the one command a reader would copy worked against neither Engine.

Two checks were extended rather than added, because both already existed and both were weaker than
they looked:

- `every_advertised_path_argument_is_accepted` tried the path **first** only. It now tries both
  orders. Writing it revealed a second trap: the summary line names `--format` for none of these
  commands, so deriving the flag from the summary made the new order untested while the check read
  as covering it. It reads the command's own help instead.
- the Skill's suite ran every **emitted** command against a real Engine and never read its own
  **prose**. It now requires a documented invocation to name its project with `--project`, and that
  check is proven to fail on the line that shipped.

The pattern in all three reports this round is the same. Nothing was unverified; each defect sat in
the gap between two things that were each verified alone — a help text and a parser, a dispatcher and
a document, a report object and what got printed.

## Reported from a real run: the Skill emitted a command the Engine refused

`/nostdb .` configured a project and then failed with:

```text
`build` does not take `/Users/ujon/git/ujon/meerdog-server`
```

### The command surface changed without any contract version changing

Release 0.1.0 **refuses** a positional path to `build` and accepts `--project PATH`. A later build
accepts both. The two report **byte-identical `--version --json`** — every contract, every version,
because no contract changed.

So Engine resolution did exactly what it is specified to do: it asked whether `nost_language_version` 2
was supported, was told yes, and resolved. Then the Skill handed that Engine an argument it rejects.
Nothing in the compatibility check could see it, because a contract version covers a file format or a
protocol and **not the command surface**.

That is a real gap in the design rather than a bug in either component. A contract version for the
command surface would be the fix; inventing one in the Skill would be a version only the Skill believed
in, so `RESOLUTION.md` states the limit instead, and the Skill now emits the form every version accepts.

### Two checks were missing, one on each side

**The Skill pinned the string and never ran it.** The dispatch suite asserted what the dispatcher
*printed* — which proves the mapping did not drift, and not that anything would run it. It now runs each
emitted command against whatever Engine is on the path.

Its reach is stated in the test rather than assumed: against a **fixed** Engine it passes, so it would
not have caught this bug. What pins the decision is a separate check requiring `--project` by name. A
check whose limits are not written down gets read as stronger than it is.

**The CLI's help advertised a form its parser refused.** The summary said `build [PATH]` and
`plan [PATH]`; the parser took `--project PATH` and rejected a positional. The summary is prose, the
parser is code, and nothing read them against each other — so the help advertised a form that did not
work, and a Skill built on the advertised form emitted a command the Engine rejected.

Both are accepted in the current source already. What was missing is anything that would notice if they
stopped being, so a test now reads every `[PATH]` out of the summary and requires the parser to take it.
The list is read from the summary rather than written down, because a hand-written list is exactly what
went stale: it would have had to be edited by whoever added the row that lied.

### The second report was a correct guard that read as a bug

`init` appeared to run every time. It did not — the guard `[ -f .../settings.json ] || init` is correct,
and the transcript shows no `configured` line on the second run. But the printed command contained `init`
on every invocation, and a command that says it will initialize is read as one that will.

So `init` is now left out of the emitted command entirely when the settings file is already there. The
guard stays for the gap between printing a command and running it. Nothing about the behaviour changed;
what changed is that the command shown is the command that will happen.

Worth recording because the fix is not a behaviour fix. A guard that is correct and looks wrong gets
reported as a bug, and the reporter was reading the only thing they were shown.

## Reported twice: a checkbox nobody could tick, then a sentence nobody could read

Reported directly. With no Engine installed, the Skill showed:

```text
[ ] install   npm install --global nostdb        install globally
[ ] npx       npx --yes --package=nostdb nostdb  run without installing
[ ] none      do not resolve; report what required the Engine
```

and nothing could be selected.

`SKILL.md` said "present the options as a checkbox list", and an agent followed it exactly — rendering
three empty boxes into a chat, where there is nothing to click. Worse than prose, because it looks like
it should work.

### The resolver was never the problem

`resolve-engine.sh` draws `[x]`/`[ ]` too, and there they are a **real** control: the arrow keys move
the selection when the script owns a terminal. When an agent runs it there is no terminal, so it exits
`1` with plain text naming the three answers. That path was correct. Only the instruction about what to
do with it was wrong.

The definition now says to ask the way the agent asks anything else, to use a native way of offering a
choice where it has one, and to take a typed answer — and names the three answers as prose rather than
as rows of a widget.

### The first fix over-corrected

Banning the checkbox left the definition saying "ask in one sentence and name the three answers", and
that was reported too: a sentence with three words buried in it is not something anybody scans. The
broken widget at least read as a list.

So the rule is not "no list". It is **no imitated control**:

- a **list** is required, because that is what somebody reads;
- a **native single-select** is preferred wherever the agent has one — that is the only place a real
  `[x]` can come from, since the harness draws the control and hands back the answer;
- **empty brackets in a message** are refused, because nothing can tick them.

A number a reader can type is a list. A bracket a reader cannot click is a broken widget. Both fixes
were reactions to a report, and the second one is the one that reads the way the reporter asked for.

### The check is scoped, because the same markers are legitimate one file over

A checkbox marker in `SKILL.md` now fails, proven by adding one. The resolver is deliberately not
covered: forbidding the string everywhere would forbid the working control while fixing the imitation
of it.

One of the checks added with the first fix required `**install**` in bold, and broke the moment the
bullet list became a numbered one. It was testing how the answer was formatted rather than whether it
was there — the same mistake as pinning a tar column position, one domain over.

That distinction is the whole lesson. This project has now written four checks that fired on a document
*explaining* a rule rather than breaking it, and the fix each time was to narrow the scope rather than
loosen the rule. This is the same shape from the other side: the string is fine in one file and wrong in
another, and what separates them is whether a reader can act on it.

## Decided: a Skill's surface is its own

Requested directly, and it relaxes an invariant the root contract stated. Recorded here because a
child cannot weaken a root boundary — the root itself had to change.

### What the rule said, and what it says now

The root contract said "AI-free Skill actions map exactly to deterministic CLI actions", and the Skill
restated it as "an AI-free action calls the same Core command the CLI calls. Not an equivalent one."

It now says: an AI-free action **has the CLI do the work** and never computes an answer itself. It need
not be one CLI command, nor be named after one.

### Why the old rule was already strained

`/nostdb .` runs two commands — a guarded `init` and a `build`. That was true before this change, and
it is why `tests/dispatch.test.sh` had to bridge three vocabularies by hand: the table's `/nostdb .`,
the dispatcher's `build`, and the CLI's `init` plus `build`. The mapping was never one-to-one; the rule
said it was.

What the rule was protecting is a second engine, and the new wording protects exactly that and nothing
more. Mirroring a command table bought no additional guarantee — the surface a user types and the
commands that run it are different questions, and conflating them made the smaller surface the one that
had to give.

### Two things the relaxation made possible

**`/nostdb help` runs nothing.** It mapped to `nostdb help`, so reading a help message required
resolving an Engine — and with none installed, resolution stops and asks whether to install one. Asking
somebody to install a database to find out what a Skill does is the wrong order of operations. The
surface now lives in `SKILL.md`, `/nostdb help` shows it from there, and `scripts/help.sh` prints it for
a script caller by **reading `SKILL.md`** rather than carrying a second copy.

**`/nostdb .` is what `build` serves.** It had been labelled `/nostdb . --ai=off`, so the plain form
every user actually types named no action and an agent had to guess which one to reach for. It now
serves the bare form, and the surface states what it writes — `settings.json` and `root.nostdb` — and
that it does **not** write `.nost` unless the project has it enabled or `--nost` is passed, because a
flag's absence is not a request.

### One check had to stop being textual, and one was decoration

The dispatch test decided which actions the dispatcher maps by grepping its `case` labels. With `help`
now a label that maps nothing, that scan counted an action emitting no command — so the set is
determined by *running* the dispatcher. An action that emits no command is legitimate now, which is
precisely why the check cannot read source any more.

The first version of the new extraction check compared `help.sh`'s output against a string built from
`SKILL.md`, and passed on both branches of its own `case` — it could not fail. It now edits `SKILL.md`,
requires the edit to appear in `help.sh`'s output, and restores the file. A grep for a string the test
invented would have passed just as well against a hard-coded copy, which is the thing it exists to rule
out.

## Stage 12 increment 5: published

Authorized explicitly: `0.1.0`, npm and GitHub. Everything below was verified after publishing rather
than asserted before it.

### Only one machine can build one target, so a release needs a matrix

`.github/workflows/release.yml` builds each target on the runner that can build it, checks out
`nostdb-distribution`'s assembler rather than reimplementing one, and ends with a single
`checksums.json` covering every target. Run by hand: cutting a release is a deliberate act somebody
performs, and a workflow firing on a tag push would make it a side effect of pushing one.

### The first run found that NostDB does not build for Windows

Four targets built and both Windows ones failed. `nostdb-server` implements only the Unix domain
socket, while `SERVER_PROTOCOL.md` section 2 specifies a named pipe for Windows — so **nothing in
NostDB compiles for Windows**, and nothing had ever tried until a release matrix did.

`fail-fast: false` is what made one run answer the question for both Windows targets instead of for
whichever failed first.

Windows was removed from the published targets, and recorded as intended-and-not-buildable with the
reason. A Windows user is told that rather than being told their platform is unpublished, and is not
offered the source-install command — which would fail for the same reason and waste a toolchain
install. Windows returns when the daemon has its endpoint, which is `nostdb-server`'s work.

### The second run shipped two empty archives, and reported success

Both Linux archives were 20 bytes: an empty gzip stream. `--uid`/`--gid` are BSD tar's flags and not
GNU tar's, so the same command worked on macOS and failed on Linux — and because the assembler used a
**pipeline**, `sh` reported `gzip`'s status, and gzip compressed nothing perfectly well. The assembler
then recorded a digest that faithfully described an empty archive.

The flag was the instance. The class of defect was an assembler that never opened its own archive, and
that is what got fixed: two steps with each status checked, then the archive **unpacked** and its
bytes compared against the binary it was given, plus the executable bit.

Getting that check right took three attempts, which is worth recording because each failure was the
same kind of mistake:

| Attempt | Why it was wrong |
| --- | --- |
| a minimum archive size | a guess about how well a binary compresses; refused a legitimately small test stub |
| a parsed size column from `tar -tv` | column position differs between BSD and GNU tar — the same portability trap that caused the bug |
| unpack and compare digests | compares the thing itself, identical everywhere, and proves the archive round-trips |

### The launcher advertised a command that did not exist

Its refusal said "run `npm rebuild nostdb`", and there was no install script — so the package would
have installed and then refused, pointing at a command that did nothing. `scripts/install.mjs` now
fetches the archive, verifies its length and digest **before writing anything**, unpacks it, and
verifies the unpacked binary separately because unpacking is a step between the two.

A digest that does not match fails the install. A package that installed an unverified binary is worse
than one that failed: the failure is visible and recoverable, and the binary is not.

An unpublished platform exits **successfully** with a warning, so `npm install` does not break for a
project that merely has this as a development dependency on one. The launcher refuses by name when it
is actually run, which is the moment somebody wanted it.

### What every route now reports

| Route | Verified |
| --- | --- |
| `npm install nostdb` | fetches, verifies, runs; 13 contracts |
| `npm install --global nostdb` | installs and runs |
| `npx --yes --package=nostdb@0.1.0 nostdb help` | the pinned form section 25.1 publishes |
| `brew install nostdb/tap/nostdb` | installs, and `brew test` passes |
| the GitHub release archive | every digest matches the published `checksums.json`; the binary runs |
| `cargo install --git … --tag v0.1.0 --locked` | builds and runs |

All three installed routes report **byte-identical** `--version --json`, which is what section 25.3
requires and what nothing had ever checked.

Tampering was checked at the end of the chain that matters: one byte appended to the installed
artifact is refused as truncated, and re-running the install repairs it.

### Recorded conflict: the source route's published spelling is wrong

Section 25.3 publishes:

```bash
cargo install --git https://github.com/<organization>/nostdb-cli --tag <version> --locked nostdb
```

That trailing word is a **package** name, not a binary name, and the package was `nostdb-cli` — so the
published command fails with "could not find `nostdb`". Verified against the `v0.1.0` tag, after the
release.

Omitting the trailing name works today, and the package is now named `nostdb` so the published command
is correct **from the next tag**. `v0.1.0` keeps the defect, and deliberately: the npm package
published at 0.1.0 records digests of the exact archives attached to that release, so re-cutting it
would invalidate a package already on the registry. A wrong spelling in one release's documentation is
a smaller harm than a published package whose checksums no longer describe anything.

`docs/PRD.md` is not edited. It is the approved contract, and Stage 0 verification diffs it against an
approved source.

### What publishing did not prove

- **Windows.** Not built, not published, and the reason is a named gap in the daemon;
- **the release workflow's own reproducibility across runners.** Each target's archive is
  reproducible on the runner that built it, which is what was checked. Whether two different runners
  of the same platform produce identical bytes is not something one release can establish;
- **`brew audit`.** `brew style` accepted the formula; the stricter audit needs the tap to be
  installed and was not run.

### Deferred out of Stage 12 until authorized

Creating `nostdb-distribution` and `homebrew-tap` is covered by the standing Stages 7 through 12
grant. **Publishing is not.** Nothing in that grant covers publishing an npm package, creating a
GitHub release, or modifying a registry, and the root contract names each of those separately.

So increments 2 through 4 can build and verify the machinery — platform resolution, checksum
verification, archive assembly, the formula — against local artifacts, and cannot verify a real
`npm install nostdb` or `brew install`. That boundary is named here rather than discovered at the
point where a push would have been needed.

## Stage 11 increment 7 verification

Passed on 2026-07-28 in `nostdb-spec` at `bf6a3b9`, `nostdb-cli` at `c7a23a8`, and
`plugins` at `8008a24`.

Rust command set clean in both Rust children:

- `cargo fmt --check`
- `cargo check --all-targets --all-features`
- `cargo clippy --all-targets --all-features -- -D warnings`
- `cargo test --all-targets --all-features` — 89 unit and 133 integration tests in the command
  surface; 14 test binaries in the specification harness

Fixtures published and gated:

| Suite | Fixtures | What it establishes |
| --- | --- | --- |
| `view-exchange/container/valid` | 4 | decodes, with the declared counts, covering an empty graph, evidence, and two disconnected components |
| `view-exchange/container/invalid` | 17 | refused, twelve from the header and five needing a decoder |

Repository and workspace:

- `./scripts/verify-repository.sh` in `nostdb-spec`, `nostdb-cli`, and `plugins`
- `./scripts/verify-workspace.sh` in the root, which now runs four plugin and viewer conformance
  suites and reports the diagnostic ownership of all four owners
- the fixture generator re-run and confirmed idempotent
- `git diff --check`

Three tripwires fired as designed:

| Tripwire | What it caught |
| --- | --- |
| `the_specified_contracts_are_exactly_those_that_have_been_authored` | the twelfth specified contract |
| the diagnostic ownership check | two codes assigned to a repository that never raises them |
| the conformance runner's confirmation line | a suite printing `decoded` rather than `verified`, which read as a suite that had not run |


## Stage 11 increment 6 scope

The first point in this project where code somebody else wrote actually runs. Increment 5 recorded
what was approved so that something could later be refused; this is the thing that refuses.

In `nostdb-spec`:

- author `plugin_protocol_version`, reserved since Stage 2 and unauthored, in
  `docs/PLUGIN_PROTOCOL.md`: the transport, the handshake, invoking an action, the exchange
  handoff, and the refusals;
- the same line-and-bytes framing the provider protocol uses. A second framing would be a second
  set of framing bugs, and this project already has one implementation of that reader worth
  reusing rather than paraphrasing;
- the **exchange as an artifact handoff** rather than a payload format. The protocol says what
  kind of artifact is being handed over, where, and what its digest is; what is *inside* it is a
  media type that evolves separately. Increment 7 adds the viewer's, and nothing published here
  has to be replaced when it does;
- the pre-execution checks: the recorded digests, the Engine range again, and the handshake
  agreeing with the manifest that was approved;
- register the codes execution needs, and `PLUGIN_REQUIRED` only if this increment can raise it;
- fixtures for the protocol messages and for the refusals.

In `nostdb-cli`:

- re-verify both recorded digests against the installed directory before starting anything, and
  refuse `PLUGIN_DIGEST_MISMATCH` when either moved;
- check the recorded approval rather than the manifest on disk, which is the whole point of
  having recorded it;
- start the plugin as a child process with a shell-free argument vector, hand it the exchange,
  and reap it — including when it never answers;
- `nostdb plugin list` and `nostdb plugin remove`, refused by name in increment 5 and
  implementable now that a record has something to be checked against;
- `nostdb plugin run`, so the mechanism is reachable and inspectable before an action depends on
  it. That is the same reasoning increment 4 used for a dispatcher that prints the command.

### Deferred out of increment 6

- the viewer's exchange format, `view.html`, `view.data.bin`, and the rendering tiers, which are
  increment 7 and are what `docs/PRD.md` section 24 specifies;
- a sandbox. The MVP does not implement one and must not describe the process boundary as one.

## Stage 11 increment 7 scope

The last increment in Stage 11, and the one with a requirement the others did not have: a shape
that has to be efficient rather than merely correct.

In `nostdb-spec`:

- author `view_exchange_version` in `docs/VIEW_EXCHANGE.md`: the media type a viewer receives, and
  the binary layout of `view.data.bin`. A new contract key rather than part of the plugin protocol,
  because section 6.1 of that protocol says outright that adding a media type is not a change to
  it — the payload and the handoff move separately, and this is the first payload;
- **columnar and index-addressed**, because `docs/PRD.md` section 24.3 requires instanced node and
  edge rendering and incremental decoding. An edge that named its endpoints by opaque identifier
  would make a renderer build a hash map before it could draw anything;
- everything section 24.2 requires be present: scoped source identity per item, link statuses and
  broken-link markers, evidence metadata for source navigation, and disconnected components with
  no synthetic relationship invented to connect them;
- register `VIEW_CAPACITY_EXCEEDED`, which section 24.3 requires a viewer to return rather than
  crash, and which the root has carried on its awaiting list since Stage 1;
- fixtures for the container and for the rejections.

In `nostdb-cli`:

- `nostdb view [PATH] [--standalone]`, which is the first action that needs a plugin the user did
  not name. That is the full `docs/PRD.md` section 23.4 flow, and the point at which
  `PLUGIN_REQUIRED` carries a recommended source rather than only a name;
- write the exchange in the published format and hand it over as the viewer media type.

In `plugins`:

- a reference viewer that decodes every section and renders the graph, proving the format carries
  what a viewer needs.

### Deferred out of increment 7, and named rather than implied

- **the WebGPU rendering itself, and the three performance tiers.** Stage 11's own deferral already
  says so: a reference that proves the exchange format is what this increment owes, and the tiers
  are a real requirement that is not a Stage 11 one. The reference viewer therefore implements the
  Canvas path section 24.3 requires as a fallback, and claims nothing about WebGPU;
- **the benchmark report.** Section 24.3 requires one identifying browser, GPU, CPU, memory,
  dataset, and whether WebGPU or fallback rendering was used, measured on a published reference
  machine. No such machine exists, and a report naming this one would be a number nobody can
  reproduce. Publishing an unreproducible measurement is worse than publishing none, because the
  first is mistaken for a guarantee.

### The order is the safety property

Every check happens before the plugin process exists, and the order is normative rather than
incidental:

1. the plugin is installed — a name with no record is `PLUGIN_REQUIRED`;
2. both recorded digests still hold over the installed directory — `PLUGIN_DIGEST_MISMATCH`;
3. the Engine range still admits this build — `PLUGIN_INCOMPATIBLE`;
4. the action is one the approved manifest declared — `PLUGIN_ACTION_UNKNOWN`.

Step 4 refuses *before* the process starts, so a plugin is never launched to be told no. And the
ordering of 2 before 3 and 4 is what makes those two possible at all — see below.

### The gap the record had, and why the answer was not more record

The record carries the permissions, the version, the commit, and the digests. It does not carry the
entrypoint, the declared actions, or the Engine range — and steps 3 and 4 need all three.

Two answers were available. Duplicating the manifest into the record would have made the record a
second copy of a document that already exists, with two ways for them to disagree and no rule for
which wins. The other is the one taken: **after the digest check, the installed manifest is the
approved manifest, byte for byte**, so reading it is reading what was approved.

`PLUGIN_PROTOCOL.md` section 1.3 now says so outright, because section 1.2 — "the approval is the
authority, never the manifest on disk" — reads like a prohibition on ever opening that file. It is
not. It is a prohibition on reading it *unverified*, and the difference is one step in an ordered
list. An implementer who missed the distinction would have duplicated the manifest.

A test proves the property rather than the rule: an `exfiltrate` action added by editing the
installed manifest does not become invocable, because the run is refused before the file is read.

### The installed directory is effectively read-only, and that is a consequence rather than a rule

Recomputing the tree digest over the installed directory means a plugin that writes into its own
directory fails its **next** invocation. The contract states that rather than leaving it to be
discovered: a plugin that treats its installation as scratch space appears to work once and then
refuses.

It is detected, not prevented. Nothing stops a plugin from writing there, which is section 1.1
again — every rule here is about what the manager hands over and what it accepts back, never a
restraint on what a plugin can do.

A symbolic link found in the installed directory is refused rather than followed. No installation
writes one, so one that is there arrived afterwards, and following it would digest a file outside
the plugin.

### The exchange is a handoff, not a format

The protocol says what kind of artifact is being handed over, where, how long it is, and what its
digest is. It does not say what is inside it.

That separation is the reason increment 7 costs nothing here: the viewer's binary format arrives as
another media type and nothing published in this increment is replaced. Version 1 defines one
media type, a versioned JSON graph document, and the contract says outright that it is
"deliberately unremarkable — it exists so the handoff can be exercised end to end".

Three properties of the handoff are worth naming:

- **the artifact is absent when `graph_read` was not approved.** That absence is the permission
  meaning something. A manager that built one and withheld it would have read the graph for
  nothing, and a manager that supplied one anyway would have made the field decorative;
- **the digest travels with it**, and a plugin verifies before interpreting. The manager is not
  asking to be trusted; it is stating what it wrote;
- **it is removed when the invocation ends, including when it failed.** An artifact left behind is
  authorized graph data sitting in a temporary directory after the authorization ended. A `Drop`
  holds that rather than a cleanup path somebody has to remember.

### What a plugin says about itself is a separate claim from what its bytes are

The digests cover the files. The handshake covers what the running process asserts, and a plugin
whose files are exactly as installed can still answer that question untruthfully.

So a handshake claiming an action the approved manifest never declared is
`PLUGIN_IDENTITY_MISMATCH`, refused before anything is invoked. Claiming **fewer** actions is not a
mismatch: a plugin may implement less than it advertised, and invoking a missing one is refused by
name — a smaller problem than a plugin claiming more.

`plugin_version` is read and never compared. It is what the process says it is; an edited manifest
is what the digests detect, and comparing the two would report the same defect twice under a code
that describes it worse.

### A code that was a synonym, and the tripwire that found it

The protocol contract first minted `PLUGIN_NOT_INSTALLED`, with a section arguing why it was not
`PLUGIN_REQUIRED`: the latter, per `docs/PRD.md` section 23.4, belongs to a flow that knows which
plugin it wants and can name a pinned source, and the former to a user who named one themselves.

Publishing that section failed `every_code_shaped_name_in_a_contract_is_registered` — a specified
contract mentioned `PLUGIN_REQUIRED`, which the registry did not carry. The tripwire was right, and
it forced the question the argument had been avoiding.

The argument turned out to rest on something the contract forbids. It assumed a caller would find
an install command in the message, and every protocol in this project states that `message` carries
no structure a caller may branch on. With that removed, the two codes answer one question and one
of them was a synonym.

So `PLUGIN_REQUIRED` covers both directions, is registered, is raised by `plugin run` and
`plugin remove`, and left the root's awaiting-a-contract list. The increment 5 record predicted it
would arrive with the viewer; it arrived one increment earlier because a command that names a plugin
by hand can be given one that is not there.

### Who has the defect decides the code

Five fixtures disagreed with the implementation on first run, all the same way, and the
implementation was right: `PLUGIN_REQUEST_INVALID` is a plugin's complaint about a message it was
**sent**, and a malformed **reply** is the plugin breaking the protocol, which is `PLUGIN_FAILED`.

The distinction is worth a separate code because it is worth a different response. A caller seeing
`PLUGIN_REQUEST_INVALID` has a manager to fix or a version to reconcile; one seeing `PLUGIN_FAILED`
has a plugin to report to its author. Collapsing them would send a user to look in the wrong place.

Every fixture in `message/invalid/` now declares the `role` of the message it holds, and both the
specification harness and the implementation's suite check the role-to-code rule. The fixtures were
written before the section 7 table attributed each code to a side; writing the rule down is what
made them checkable.

### The transport is the provider's, deliberately

The published protocol uses the framing `PROVIDER_PROTOCOL.md` already defines, so the
implementation uses the reader that implements it — `ProviderProcess`, unchanged.

A second framing would be a second set of framing bugs, and the subtle one is worth solving once: a
buffered line reader will consume part of a fixed-length content run while looking for a newline,
and the bytes it swallowed are gone. The type's name is about where the framing came from rather
than what it carries. Renaming it would churn a public API `link refresh` also uses, for a naming
nit; it is recorded here instead so the next reader is not left wondering.

### Two commands that increment 5 refused by name

`plugin list` and `plugin remove` were refused with a message saying nothing yet executed an
installed plugin. Something does now, so both are implemented.

`list` reads the **record**, not the plugin directories. A listing built from what is on disk would
report a directory somebody copied in as an installation, which is the one distinction the record
exists to make — and a test asserts exactly that case is refused.

`remove` updates the record first and the directory second. A directory removed first would leave a
record naming files that are gone, which every check here treats as tampering. An empty listing
writes its explanation to stderr, because a caller piping the output should receive nothing rather
than a sentence.

`plugin run` is new surface the product contract does not name. It exists so the mechanism is
reachable and inspectable before an action depends on it, which is the reasoning increment 4 used
for a dispatcher that prints its command. The action may be omitted when a plugin declares exactly
one; with more than one, naming it is required, because choosing between two on a user's behalf is
guessing.

### Stage 11 increment 6 verification

Passed on 2026-07-28 in `nostdb-spec` at `a2f0fff`, `nostdb-cli` at `4c0c576`, and
`plugins` at `97be6e6`.

Rust command set clean in both Rust children:

- `cargo fmt --check`
- `cargo check --all-targets --all-features`
- `cargo clippy --all-targets --all-features -- -D warnings`
- `cargo test --all-targets --all-features` — 84 unit and 130 integration tests in the command
  surface, 12 of them the execution flow and 3 the new conformance suite; 13 test binaries in the
  specification harness

Fixtures published and gated:

| Suite | Fixtures | What it establishes |
| --- | --- | --- |
| `plugin-protocol/message/valid` | 8 | read, with every kind version 1 defines represented |
| `plugin-protocol/message/invalid` | 16 | refused with the declared code, and the role-to-code rule holds |
| `plugin-protocol/handshake` | 8 | agrees with the approval, or is refused with the declared code |

Repository and workspace:

- `./scripts/verify-repository.sh` in `nostdb-spec`, `nostdb-cli`, and `plugins`
- `./scripts/verify-workspace.sh` in the root, which now runs three plugin conformance suites and
  reports the diagnostic ownership of all fourteen `nostdb-cli` codes
- `git diff --check`

Two workspace tripwires fired as designed:

| Tripwire | What it caught |
| --- | --- |
| `every_code_shaped_name_in_a_contract_is_registered` | a published contract naming `PLUGIN_REQUIRED`, which the registry did not carry — the synonym above |
| the root's `awaiting_a_contract` list | `PLUGIN_REQUIRED` became registered and had to leave the deferral list |

### One correction carried in from the previous increment

`plugins/AUTHORING.md` still told authors that a source with no ref resolves the default branch,
which the resolution recorded under increment 5 had made untrue. It is the document authors
actually read, so a stale rule there is worse than a stale rule anywhere else. Corrected at
`97be6e6`, with the practical consequence added: publish a tag and tell people to install it by
name, because a version in an install command is a record a user can read without opening a lock
file.

## Stage 11 increment 5: the half that fetches

`nostdb plugin add` resolves a ref to a commit, enumerates the tree, refuses what is not a
plugin, reads and checks the manifest, computes both digests, writes the files, and records what
was approved. Nothing in it executes anything, and there is no path from the installing module to
a process: no `Command`, no `spawn`, nothing that could reach one.

### Resolved conflict: resolving a default branch

Two published contracts disagree, and the disagreement is load-bearing rather than cosmetic.

`docs/PLUGIN_MANIFEST.md` section 4, on a source with no ref:

> With no `ref`, the manager resolves the default branch **once** and records the commit.

`docs/PROVIDER_PROTOCOL.md` section 6, on the locator every retrieval request carries:

> `ref` is required. An implementation MUST NOT default it to a branch name, because the
> default branch of a repository can change and a locator is an identity.

The manager's only retrieval path is the provider — the command surface must not bundle a GitHub
implementation, and `nostdb-cli/AGENTS.md` forbids one by name. The provider protocol has no
request that reports a default branch, and `nostdb-provider-github` refuses a ref-less locator
with `PROVIDER_LOCATOR_INVALID`. So the manager is required to resolve something it has no way to
ask about.

The conflict was recorded first and the behavior left unchanged, as the root contract requires,
with three resolutions available:

1. **amend the provider protocol** so a default branch is askable — a `resolve` accepting
   `?ref=HEAD`, which is a symbolic ref rather than a branch name and so does not violate the
   letter of section 6;
2. **add a protocol request** that reports the default branch, letting the manager build a locator
   from the answer;
3. **amend the manifest contract** to require a ref.

#### The resolution

The user selected resolution 3. `docs/PLUGIN_MANIFEST.md` section 4 now requires a `ref`, and a
source without one is refused with `PLUGIN_MANIFEST_INVALID`.

It is the narrowest change and it agrees with what the rest of that contract argues for.
Installation exists to pin a plugin to one commit, and asking for the ref in the command that
installs makes what was installed visible in the command that installed it rather than recoverable
only by reading the record afterwards.

Applied changes:

- section 4 requires the `ref`, and a new section 4.1 records why it is required rather than
  defaulted, so the next reader finds the reason instead of the rule alone;
- `fixtures/plugin/source/valid/repository_root` became
  `fixtures/plugin/source/invalid/no_ref`. The published suite is what makes this binding on an
  implementation, and a contract that changed while its fixtures still accepted the old form would
  have two answers;
- `PluginSource::parse` refuses a ref-less source, so `reference()` returns a `&str` rather than an
  `Option` and `locator_for` became **infallible**. That is the shape of the resolution showing up
  in the code: a source that could not supply a ref is one no locator could represent, and refusing
  it at the grammar means nothing downstream carries the possibility;
- the refusal happens while parsing rather than on the way to a provider, so somebody is not sent
  to install a provider and then met with this anyway.

#### Why this is a correction to version 1 rather than a version 2

A version bump would imply that an implementation could conform to `manifest_version` 1 as first
written. None could: section 4 required a manager to resolve something the provider protocol
forbids any locator from expressing, and every implementation must obey both. That made version 1
internally contradictory rather than merely permissive, and fixing a contradiction is a correction.

Nothing has shipped, no plugin exists, and no installer has ever run, so no author is holding a
manifest this invalidates. Recorded because it is the second time this project has decided whether
completing a published contract needs a new version — the first was Stage 6 increment 3 — and the
two were decided on the same test: whether a conforming implementation of the old text was
possible.

### A separate contract for the record

`plugin_install_version`, specified in `docs/PLUGIN_INSTALL.md`. The manifest contract names the
seven things an installation records and stops there, which is right: it is the document a plugin
*author* reads, and the record is written by the manager and read later by the executor.

Coupling them would mean a manager that wanted to record one more field could not do so without
changing the document every author has already written — and an author's manifest would appear to
need reissuing because a manager learned to remember something new.

It is the eleventh specified contract, and the `nostdb-spec` tripwire that fails on a new one
until its expectation is updated on purpose did exactly that.

### Two digests, and why the derivation had to be written down

The manifest digest covers the manifest's bytes **as received**, before parsing and without
reserialization. Digesting a reserialized manifest would make a formatting change look like a
content change and, worse, could make a content change invisible — two different documents can
serialize identically once a reader has normalized them.

The tree digest is `<path> LF <hex> LF` per accepted entry, in ascending byte order of path. Every
part of that is a decision a second implementation has to make the same way:

- **ascending byte order, not a locale collation.** A digest that depended on the installing
  machine's locale would differ between two machines installing the same commit, and the
  disagreement would look exactly like tampering;
- **the manifest is included.** Excluding it would leave the manifest covered only by its own
  digest, and an implementation comparing trees would report two installations identical when
  their manifests differed;
- **the path and not the mode.** A file's executable bit is not covered. That is written into the
  contract rather than left to be discovered, because a reader who assumed otherwise would
  believe a mode change was detectable.

Recording only the tree digest would technically cover both, since the manifest is in the tree.
Two are recorded because they answer different questions, and the refusal message says *which*
one moved — whether the plugin asked for more, or merely became a different plugin.

### The Engine range needed a grammar, because the contract never gave it one

Section 2.2 of the manifest contract said a plugin declares the Engine versions it works with "as
a range" and never said what a range is. An implementation reading `^0.1.0` would have had to
pick an ecosystem's reading.

The grammar is a conjunction of comparators over three-component versions, and deliberately
nothing else: no caret, no tilde, no wildcard, no pre-release, no build metadata. Each of those
is a shorthand whose meaning differs between ecosystems, so an author who wrote one expecting one
reading would get another. A conjunction has one reading everywhere.

A leading zero is refused, because a number with two spellings gives one range two spellings —
and a manifest with two spellings of one range has two manifest digests.

The split between the two codes is what the grammar buys: a range that does not parse is
`PLUGIN_MANIFEST_INVALID`, because it is a malformed member somebody edits. A range that parses
and excludes this build is `PLUGIN_INCOMPATIBLE`, because the manifest is correct and this is not
the build it is for.

### Limits pinned from both sides

Five fixed limits: 4096 entries, 8 MiB per entry, 64 MiB per plugin, 1024 bytes per path, 32
segments deep. Every one is checked from the **enumeration**, before a byte is downloaded, which
is the only thing that makes a hostile source a refusal rather than a resource exhaustion.

Each limit has a fixture one past it and a fixture sitting exactly on it. The second half is what
makes the numbers normative: a suite with only the exceeding half would pass against a build whose
limit was 64 rather than 4096, because a tree over 4096 entries is also over 64. The limits would
have been advisory while appearing to be checked.

They are fixed rather than configurable. A limit a project can raise is one an install can ask it
to raise, and the request would arrive attached to the plugin that wants it.

### What a refusal is honest about

- **the provider's code passes through.** A host that could not be reached reports
  `PROVIDER_SOURCE_UNAVAILABLE` and exit class 5, not a plugin failure. Relabelling it would name
  the wrong layer, and a script that wanted to retry later needs to know which layer to wait on;
- **no flag installs over a digest mismatch.** A commit is immutable, so the same commit yielding
  different bytes means something between the host and this machine is not what it was. A user
  cannot evaluate that question, and a flag that exists to be passed when a check fails is a check
  nobody has;
- **a different commit is not a mismatch.** That is somebody asking for a different version, and
  the request names the commit it wants;
- **a tree with one escaping path is refused whole.** Not skipped: whoever wrote that path meant
  something by it, and installing the rest would install a plugin that is not the one the author
  published, with nothing saying which parts are missing.

### Consent asks where, not whether

An explicit `plugin add` is authorization to install. What is asked is the scope, and only when
the invocation did not say and somebody can answer.

A non-interactive session takes project scope rather than refusing for want of an answer.
Refusing would make every unattended install depend on a person being present, and the narrower
of the two scopes is the safe one to choose without being told.

Whether anybody can answer is decided in `lib.rs`, where the process streams are, and passed down
as a fact. Everything below stays drivable by a test that supplies the answer itself — the same
shape the REPL uses, and the reason the whole command surface is testable in process.

`--scope` takes a value rather than being spelled `--project`. `--project` means a directory
everywhere else on the surface, and one word meaning a scope here and a path there is the kind of
thing people get wrong once and never trust again.

### Tested over a scripted provider, and what that does not cover

`Transport` is a trait, so the whole install runs against a recorded conversation: the request
order, what is refused before anything is downloaded, both digests, the reinstall outcomes, and
what the record ends up saying. No test reaches the network.

What that does **not** cover is the process glue — starting the provider, wiring its pipes, and
reading `NOSTDB_GITHUB_PROVIDER`. That is the same code path `link refresh` uses and is exercised
there. It is named here rather than left implied, because a suite that covered the interesting
part and skipped the boring part should say which part it skipped.

The record this build writes is read back through `Record::parse` rather than trusted because
this build wrote it. A writer that produced a document its own reader refuses would be two
implementations of one contract, and the file is the one a later execution depends on.

### Two defects this increment found

**A provider was demanded before a source was judged.** The first version checked
`NOSTDB_GITHUB_PROVIDER` before deciding whether the source could become a locator at all, so a
ref-less source reported a missing provider. Somebody would have installed one and met the real
refusal afterwards. The order is now: judge what is decidable locally, then reach for anything
external.

**Two commands had no help topic.** `every_command_has_a_help_topic` carried its own list of six
command names, written when the surface had six commands and never extended — so a test whose
name claimed completeness covered under half of the surface, and `nostdb help query` and
`nostdb help sync` both reported `unknown command`. The list is now stated once and used by both
help checks, and the two missing topics are written.

That is the same failure shape as the Stage 10 repair recorded above, one level smaller: a check
that was right about everything except its own scope.

### Stage 11 increment 5 verification

Passed on 2026-07-28 in `nostdb-spec` at `f0d16a2` and `nostdb-cli` at `e21b88c`, and again
after the conflict resolution below at `nostdb-spec` `af6ef85` and `nostdb-cli`
`a568cbb`.

Rust command set clean in both children:

- `cargo fmt --check`
- `cargo check --all-targets --all-features`
- `cargo clippy --all-targets --all-features -- -D warnings`
- `cargo test --all-targets --all-features` — 66 unit and 128 integration tests in the command
  surface, 10 of them the install flow and 5 the new conformance suite; 63 tests in the
  specification harness, 10 of them the new suite

Fixtures published and gated, all reproducing their declared outcomes:

| Suite | Fixtures | What it establishes |
| --- | --- | --- |
| `plugin-install/record/valid` | 3 | read, name-ordered, and every member present |
| `plugin-install/record/invalid` | 10 | refused with the declared code, covering both record codes |
| `plugin-install/range` | 8 | parses, and admits or excludes the declared engine version |
| `plugin-install/range-invalid` | 8 | refused as a malformed manifest member |
| `plugin-install/tree` | 19 | 7 accepted, 12 refused, with every limit pinned from both sides |

Repository and workspace:

- `./scripts/verify-repository.sh` in both children
- `./scripts/verify-workspace.sh` in the root, which now runs `plugin_install_conformance` from
  the superproject and reports the diagnostic ownership of all eight `nostdb-cli` codes
- `git diff --check`

Two workspace tripwires fired as designed and were resolved on purpose rather than worked around:

| Tripwire | What it caught |
| --- | --- |
| `the_specified_contracts_are_exactly_those_that_have_been_authored` | a new specified contract, which must be acknowledged rather than appear |
| the root's `awaiting_a_contract` list | `PLUGIN_INCOMPATIBLE` and `PLUGIN_DIGEST_MISMATCH` became registered and had to leave the deferral list, or it would rot into a record of what used to be missing |

`PLUGIN_REQUIRED` stays deferred. It belongs to an action that needs a missing plugin, and no
action needs one until the viewer in increment 7. Registering it now would publish a code no
implementation can raise, which is the exact failure `LINKED_DATABASE_READ_ONLY` recorded in
Stage 6.

### The sentence this Stage is organized around

> Installation MUST NOT execute plugin code.

Everything else follows. A manager that ran anything before validating it would have already
lost, because the validation exists to decide whether running is safe and a plugin that ran
first has had its answer. So installation is: resolve a ref to a commit, fetch a tree, check
paths and archive limits, read a manifest, verify digests, record what was approved — and
stop. Execution is a separate act, later, and it refuses an installation whose digest no
longer matches.

### What the manager owns, and where

The native plugin manager exists **once**, in `nostdb-cli`. Skills invoke it. A second
registry in the Skill would mean two answers to "what is installed", and the one a user got
would depend on which surface they reached for — the same argument that shaped Stage 10's
dispatcher, arriving at a different component.

Installations persist across CLI and Server processes, and project scope beats global scope
for a plugin of the same name, for the reason a project-local Engine beats a global one: a
project that pinned something did so on purpose.

### What a plugin never receives

- **the binary format.** A plugin gets authorized graph data through a versioned
  Engine-owned exchange, never a `.nostdb` parser API and never the file. A viewer that
  parsed the container would be a second reader of a format with exactly one, and the
  ownership boundary this project has held for eleven Stages would end here;
- **a shell.** An entrypoint is an argument vector. A manifest comes from a repository
  somebody else wrote, and a string a shell interprets is that author choosing what runs;
- **permissions it did not declare.** A manifest states what it wants; the user approves it;
  the recorded approval is what execution is checked against.

### The honesty this Stage has to maintain

The MVP does not claim an unsigned third-party plugin is safe, and the contract says so
outright. This Stage must not describe out-of-process execution as a sandbox, because it is
not one — the root contract forbids claiming a sandbox that is not implemented, and a
process boundary is a real boundary that does not become a different one by being described
warmly.

What it does buy is stated plainly: a plugin cannot read the Engine's memory, cannot reach a
database handle, and cannot outlive the request it was started for. That is the same argument
the provider was built on in Stage 9, and it is worth no more here than it was there.

### Deferred out of Stage 11

- a signature scheme. A signature may strengthen trust later; adding one now would let the
  MVP imply a guarantee it has not earned;
- non-GitHub plugin sources, for the reason Stage 9 deferred non-GitHub providers: an
  abstraction designed against one example is a description of that example;
- the WebGPU rendering itself beyond a reference that proves the exchange format carries
  what a viewer needs. Performance tiers are a real requirement and not a Stage 11 one.

## Stage 10 scope

Stage 10 builds the Agent Skill: the AI-capable extension of the command surface, and the
first component in this project that is allowed to call a model.

| Increment | Content | Status |
| --- | --- | --- |
| 1 | this scope | DONE |
| 2 | connect `skills`; the action table and its declared AI usage | DONE |
| 3 | Engine resolution, and the version check that decides compatibility | DONE |
| 4 | AI-free actions, each proving it calls the same Core command the CLI does | DONE |
| 5 | the analysis packet in PRD 17.5, and the budget check before any call | DONE |
| 6 | natural-language read, write, and the ambiguous case | DONE |

### Authorized scope

Creating `skills`, connecting it, and pushing was covered by the Stages 7 through 12 grant,
relied on directly rather than re-confirmed — which is the direction recorded under Stage 9
and the reason this asks nothing.

Performed: created `https://github.com/nostdb/skills` as a public repository, pushed its
initial commit, and pinned it as a root submodule at `f5a6742`.

Apache-2.0. A Skill is meant to be read, forked, and replaced, which a copyleft licence
would discourage.

### Increment 2: the action table, before there are actions

The table is written first because the declaration is the part that has to be true before
anything runs. An action that could quietly become AI-requiring is one nobody can budget
for, and `--ai=off` only means something if it is a filter over a declared column rather
than a hope.

Two rows carry most of the weight:

- **`none` obliges an action to call the same Core command the CLI calls** — not an
  equivalent one. Two implementations of one action is two answers to one question, and
  which a user gets would depend on which surface they happened to use. Every `none` row is
  therefore a row a fixture can pin, and that is where this Stage's tests go;
- **`required` with no model fails.** It does not fall back to a deterministic approximation
  and report success, because a caller who asked a question in English and got an answer
  derived some other way has been told something untrue about where it came from.

The verifier checks what this repository can get wrong without compiling anything: no
database writer, no unpinned `latest` fallback, and no credential. The last matters more here
than elsewhere — this repository holds prompts, which is the easiest place in the product for
a secret to be pasted by accident.

### Increment 3: deciding which `nostdb`

Project-local, then a compatible global, then a pinned `npx`. Project-local first because a
project that pinned a version did so on purpose, and a global overriding it would mean one
checkout giving two people different answers from the same command.

**Compatibility is asked per contract, not per Engine version.** A Skill checks the contract
versions it needs: an Engine two releases newer that still reads `nost_language_version` 2 is
compatible, and one that dropped it is not however close the numbers look. That is only
possible because `--version --json` lists each contract separately, which is the independent
versioning from Stage 1 paying off in a component written eight Stages later.

**A command that does not answer is not an old `nostdb`.** It is treated as not being
`nostdb` at all — something on the path with the right name and the wrong behavior is more
dangerous than nothing on the path.

**Never an unpinned fallback.** A version resolved at run time is a version nobody reviewed:
merely surprising in an interactive session, but in a script it means last week's command and
tonight's are different programs, and the only evidence of the change is that the output
differs.

Tested against fakes, and that is not a compromise. What is under test is the order and the
check, both of which a fake answers exactly as a real Engine would — and it is the only way
to test the case where *nothing* compatible exists, which a machine with a working
installation cannot produce.

**A verifier check that was wrong in a way this project has now seen twice.** It searched
markdown for an unpinned `npx` invocation and fired on the document that *states* the
prohibition — the same mistake the provider's verifier made about `.nostdb` paths. A document
explaining a rule has to be able to write the rule down, and a check that forbids that is one
people learn to work around. Twice is a pattern worth naming: a check written against a
*string* will eventually fire on the text that explains why the string is forbidden.

### Increment 4: one answer to what an action does

Every AI-free action maps to the `nostdb` command it invokes. Not an equivalent command and
not a reimplementation — two implementations of one action is two answers to one question,
and which a user gets would depend on which surface they reached for.

The dispatcher **prints** the command rather than running it. That makes the mapping
testable with no Engine installed, and it means a caller can show a user exactly what will
run before anything does — which is what a natural-language write is separately required to
do, so building it here means that requirement is already satisfied when increment 6 needs
it.

An action needing a model is refused *specifically* rather than reported as unknown.
Reporting it as unknown suggests a typo, when the truth is that it exists and needs
something this path cannot supply.

**The table and the dispatcher are checked against each other**, in both directions: a
mapping with no row fails, and a row with no mapping fails. A table that drifted from the
dispatcher would describe a Skill that does not exist, and a dispatcher with an undeclared
action would be one nobody could budget for.

The first version of that check counted `none` rows and was wrong. `build-nost` is the
AI-free path of an **optional** row, and `optional` means precisely that the action completes
without a model — so the dispatcher legitimately maps more than the `none` rows. Arithmetic
over prose could not express that, and the bridge between the two vocabularies is now written
out as a list. It is the third time this Stage that a check has been wrong in a way the thing
it checked was not.

### Increment 5: the packet, and the gate in front of the call

**The packet is compact by construction.** Section 17.5 opens with a prohibition — a Skill
must not send an entire repository — and this makes it a property of the shape rather than a
rule somebody follows. A packet is built from one source unit and the units an edge reaches
from it, so its size is bounded by that unit and a fixed neighbour budget and does not grow
when the repository does.

A builder that took a graph and a filter would be one wrong filter away from sending
everything, and the failure would be invisible: a larger prompt looks like a more thorough
one right up until the bill arrives.

It is anchored on the identity a `Contribution` names, which is what lets an enrichment's
result be replaced exactly the way an analyzer's is. Deterministic edges are summarized
rather than omitted — section 17.5 forbids AI from re-emitting one as an independent fact,
and showing them is how that becomes possible to obey rather than only possible to violate.

A truncated excerpt **says** it was truncated. A model shown one that does not may reason
about what the code does after the cut and be confident about something it never saw.

Excerpts are supplied by the caller rather than read by the Engine, which does not hold
source. A packet builder that read files would be one that could read a file the scanner
deliberately withheld, and a test asserts the inheritance: a `.env` in the project reaches
neither the graph nor the packet.

**The gate distinguishes four outcomes**, and the distinctions are the point. `refuse` is
not `skip`: a skip says nobody was asked, a refusal says somebody already answered. `ask`
happens once, because asking per unit trains a user to approve without reading. And a
non-interactive session skips rather than proceeding on a default nobody chose — the
structural database, the part that matters most, is already committed by then.

### The defect that only a real plan could find

The budget check passed eleven hand-written fixtures. Run against a plan `nostdb plan`
actually produces, it revealed that the plan document carried no `ai_mode` field at all — so
the **refusal path was unreachable in reality** while every fixture agreed it worked.

The fixtures were not wrong about the check. They were wrong about the document, because
their author wrote both. A suite written only against shapes its author invented tests the
author's idea of the document, and the two agree by construction.

The fix was to state `ai_mode` in the plan rather than have the Skill infer it from a zero
estimate — a caller deciding whether enrichment may start has to tell "nothing to do" from
"refused", and both produce zero. The test now runs against a real Engine when one is on the
path, which is what stops this returning.

### Increment 6: the statement decides, not the label

A model produces a proposal — what kind of request it thinks this was, and the openCypher it
generated. The Skill applies policy to that proposal, and the policy is the part that can be
tested.

**The safety property is that the statement decides.** A model that mislabels a
`DETACH DELETE` as a read would otherwise have it executed with no confirmation, and the
label is the one part of a proposal that costs nothing to get wrong. So the statement is
inspected, and a write clause makes it a write however it was announced. Three tests exercise
exactly that: a `DELETE`, a `SET`, and a `MERGE`, each announced as a read, each still
waiting.

String literals are stripped first, so a statement returning the text `'DELETE'` is still a
read. Without that the conservative rule would be unusable, and a rule people cannot live
with is one they turn off.

Every procedure call is treated as a write, because this cannot tell which ones write. Being
asked to confirm a read is a smaller cost than a write running unconfirmed.

**Ambiguity is not resolved by confirmation.** Confirming a request nobody has stated
precisely is confirming the Skill's guess at it, which is the failure that makes a
natural-language surface untrustworthy rather than merely wrong.

A proposal that contradicts itself — claiming a write over a statement that writes nothing —
is refused rather than downgraded. Running it would mean deciding the model was wrong about
its own intent, which is not a decision a gate is entitled to make.

**The clause list is tied to the Engine's.** The two live in different repositories and
cannot import each other, so a test exercises every clause the Engine's query subset treats
as a write. One added there and not here would let a write run unconfirmed, which is the
failure the whole file exists to prevent.

### Where Stage 10 ended

Six increments: the action table, Engine resolution, the AI-free dispatcher, the analysis
packet, the budget gate, and the natural-language gate. Four test suites, none of which
calls a model.

That is the design and not a gap. What a model returns cannot be pinned by a fixture, so
everything testable is the surface *around* the call — which action is AI-free and provably
identical to its CLI equivalent, what a packet may contain, what the budget decides, and what
happens to a proposal before anything runs. A Stage that tested only the call would have
tested almost nothing.

**What is unproven** is whether a model's proposals are any good, and no amount of work here
answers that. It needs a provider, a credential, and a live run, and none is authorized.

### What makes this Stage different from every one before it

Nine Stages have built things that are deterministic: the same input produces the same
output, and a test can assert it. This one is not that, and the contract's response is to
constrain *when* a model is consulted rather than what it says.

- **every action declares its AI requirement.** `AiUsage::None`, `Optional`, or `Required`
  is part of an action's identity, not a runtime discovery. An action that could quietly
  become AI-requiring is one nobody can budget for;
- **an AI-free action must call the same Core command the CLI calls.** The Skill is not a
  second implementation, and the root contract requires fixtures proving it. That is the
  one part of this Stage that *is* deterministic, and it is where the tests go;
- **no call starts before a visible plan and a budget check.** Stage 7 built the plan and
  the check; this Stage is where something finally has to pass through them.

### Three refusals the contract states outright

- **a natural-language write shows its exact scope and waits.** Generating the operation is
  not permission to run it;
- **an ambiguous request asks and does not execute.** Guessing which of two readings was
  meant is the failure mode that makes a natural-language surface untrustworthy, and one
  wrong guess costs more confidence than ten clarifying questions;
- **no unpinned `latest` fallback for a state-changing non-interactive action.** A version
  resolved at run time is a version nobody reviewed.

### What this Stage cannot verify, and what that means for its shape

The same problem Stage 9 had, one step further. Stage 9 could at least record what GitHub
sent; a model's output is not reproducible even in principle, so no fixture can pin it.

So the testable surface has to be everything *around* the call: which actions are AI-free
and provably identical to their CLI equivalents, what a packet contains, what the budget
check decides, and that a write refuses without confirmation. The call itself is the one
part left, and a Stage that tested only that would have tested almost nothing.

An AI provider and its credential are not authorized, and this scope does not assume them.

### Deferred out of Stage 10

- the plugin surface `/nostdb plugin add` names, which is Stage 11;
- the viewer `/nostdb view` names, which is Stage 11;
- distribution, which is what makes Engine resolution find anything at all, and is Stage 12.
  Until then resolution is testable against a fake `nostdb` on the path, which is enough to
  prove the *order* is right.

## Stage 10 repair: nothing in `skills` was installable

Stage 10 stays `DONE` and Stage 11 stays the only `IN_PROGRESS` Stage. This is recorded here
rather than as a Stage because it repairs delivered work: the Stage's claim was untrue rather
than incomplete.

### The defect

`skills` shipped an action table, a resolution document, an enrichment document, four scripts,
and four test suites. It shipped no `SKILL.md`, anywhere. Nothing in it could be installed,
which is the one thing the repository exists to do.

Three documents said otherwise:

| Document | What it said |
| --- | --- |
| `docs/PRD.md` section 8.1 | `skills/` — `Independently installable Agent Skills` |
| `docs/REPOSITORIES.md` | `independently installable Agent Skills; no database writer` |
| the child `README.md` | opened with `Independently installable Agent Skills for NostDB` |

### Why nothing caught it

Every check the repository had was a prohibition. No database writer, no unpinned `latest`
fallback, no credential, no second copy of the PRD or the grammar. A repository containing no
Skill violates none of them, so all of them passed.

The Stage 10 record even names the testable surface as everything *around* the model call and
lists four suites for it. All four test the scripts, and the scripts are real. None tests that
anything would ever cause an agent to run them.

That is the Stage's own recorded lesson arriving one level up. Three times in Stage 10 a check
was wrong in a way the thing it checked was not; this time the checks were right about
everything except whether the subject existed.

### The layout, and why the path repeats itself

```text
skills/skills/nostdb/SKILL.md
```

The first `skills/` is the submodule path in this workspace. The second is the directory an
installer scans. Both have to hold at once, because the child is a submodule of this
superproject *and*, independently, a source `npx skills add nostdb/skills` reads with no
knowledge of this root at all. An installer discovers `skills/<name>/SKILL.md` and
`skills/<category>/<name>/SKILL.md`; the child uses the first.

**The skill folder is the unit an installer copies.** That is the whole reason the four
scripts moved into `skills/nostdb/scripts/`: a definition that referenced them from the
repository root would resolve here and be missing from every install, which is the one way a
Skill can pass every check in this workspace and still be broken for the person who installed
it.

`tests/` and `scripts/verify-repository.sh` stayed outside, because they verify the repository
rather than travelling with an install. Shipping a test harness into every install would be
payload nobody asked for.

### The map moved out of a test and into the shipped document

The action table speaks in invocations, `/nostdb . --ai=off`. The dispatcher speaks in action
names, `build`. The only place the two vocabularies met was a case statement inside
`tests/dispatch.test.sh` — a file no running agent ever opens. An agent could read the shipped
repository, learn that both existed, and have no way to connect them.

So the map is now a table in `SKILL.md`, and the test checks it rather than holding it. It is
pinned in both directions and against both neighbours: the dispatcher must map exactly the
actions the table declares AI-free, and every invocation the definition promises must be one
the action table declares, with the same AI usage. Three vocabularies, one copy.

### What is checked now

Fourteen conditions, each proven to reject rather than assumed to work.

In the child verifier:

| Rejected condition | Diagnostic |
| --- | --- |
| no definition at a discoverable path | `no installable skill found; an installer discovers skills/<name>/SKILL.md` |
| a definition too shallow, at `skills/SKILL.md` | `these definitions are at a path no installer discovers` |
| a definition too deep, at `skills/a/b/c/SKILL.md` | `these definitions are at a path no installer discovers` |
| frontmatter not opening on line 1 | `must open with a --- frontmatter delimiter on line 1` |
| no closing frontmatter delimiter | `has no closing --- frontmatter delimiter` |
| no `name` | `declares no name in its frontmatter` |
| no `description` | `declares no description in its frontmatter` |
| `name` differing from the directory | `declares the name nostdb-graph and sits in nostdb; the two must agree` |
| a reference reaching outside the folder | `references ../shared/HELPER.md, which is not in the folder an installer copies` |
| a script not committed executable | `is not executable, so an installed skill could not run it` |

In `tests/dispatch.test.sh`:

| Rejected condition | Diagnostic |
| --- | --- |
| a dispatcher action the definition does not declare | `expected [...], got [... peek ...]` |
| an invocation the action table does not declare | `view serves /nostdb peek ., which the table does not declare` |
| an AI usage disagreeing with the action table | `sync is declared optional in SKILL.md and otherwise in the table` |

In `scripts/verify-workspace.sh`:

| Rejected condition | Diagnostic |
| --- | --- |
| the child publishing no definition | `the skills child publishes no skills/<name>/SKILL.md, so nothing in it is installable` |

The root check exists because the root is where the promise is made. What a definition must
contain is the child's business; that one exists is this workspace's, and `docs/PRD.md`
section 8.1 is the document that would otherwise stay untrue.

One positive control matters as much as the rejections: a definition at
`skills/graph/probe/SKILL.md` is **accepted**. The depth rule permits both layouts an
installer scans rather than only the one this child happens to use, so a future category
layout is a choice rather than a verifier change.

### The one check that could not be a fixture

Every rejection above tests this workspace's idea of the installer. The Stage 9 problem in
miniature: a recording proves the recorder, not the thing recorded.

So the published child was installed for real, into a scratch directory rather than this
project, because the root contract requires the installed `.agents/skills` and
`skills-lock.json` here to be preserved:

```bash
npx --yes skills add nostdb/skills --agent claude-code --yes
```

It reported `Installed 1 skill: nostdb (copied) → ./.claude/skills/nostdb`, and wrote a lock
recording the path it had discovered:

```json
"skillPath": "skills/nostdb/SKILL.md"
```

All eight files arrived — four documents and four scripts. Each script arrived mode `755`, so
the claim that a copy preserves the executable bit is now an observation rather than an
assumption. `dispatch.sh build-nost .` and the natural-language gate both ran from the
installed copy.

That is what makes this repair verified rather than merely argued: the layout is confirmed by
the installer, not only by a document describing the installer.

### What this repair does not establish

- only the project-scope `claude-code` install was exercised. Global install, the
  `--skill <name>` per-skill form, and the other agent targets are unexercised;
- the definition is still unproven where Stage 10 was: no model has read it, so whether its
  instructions actually produce good behavior is unknown, and no fixture can settle that.

### Verification

In `skills`, at commit `0272a4b`:

- `sh -n scripts/verify-repository.sh`
- `./scripts/verify-repository.sh`, which now reports `installable: skills/nostdb`
- all four test suites, 22 checks in the dispatch suite alone
- `git diff --check`
- the ten child rejections and three dispatch rejections above, each run against a copy of the
  tree in a scratch directory
- the live install and the run of the installed copy

In the root:

- `bash -n scripts/verify-workspace.sh`
- `./scripts/verify-workspace.sh`, which now reports `installable skills: nostdb`
- the root rejection above, proven by holding the definition aside and restoring it
- `git diff --check`

### Two stale documents corrected on the way

`README.md` and `docs/REPOSITORIES.md` both listed `nostdb-provider-github`, `skills`, and
`plugins` as not connected and not yet authorized. All three have been connected and pinned
since Stages 9, 10, and 11 respectively. The lists were three Stages behind, and one of them
directly contradicted the repair being recorded here.

## Stage 9 scope

Increment 1 is done and needed no child repository: a contract is specification work, and
`nostdb-spec` is already connected. That ordering was not a convenience — writing the
protocol first is the same rule Stages 7 and 8 followed, and here it also means the
repository is authorized against a written interface rather than against an intention.

### Authorized scope

Creating `nostdb-provider-github`, connecting it, and pushing was covered by the Stages 7
through 12 grant. Confirmation was asked for once and given, together with a direction to
rely on the standing grant for the remaining children rather than re-asking per repository.
That direction is recorded here so Stages 10 through 12 do not repeat the question.

Performed:

- created `https://github.com/nostdb/nostdb-provider-github` as a public repository;
- pushed its initial commit to `main`;
- pinned it as a root submodule at `ec0ba39`.

The crate is scaffolding: no request is served, and the binary exits non-zero rather than
answering a handshake it cannot follow through on. A caller that got a handshake would go on
to send a `resolve` this build cannot serve.

Apache-2.0 rather than SSPL, which the root licensing policy puts the provider tier under
deliberately: a provider is the component a third party is most likely to write, and
copyleft on the protocol side would discourage exactly the implementations the product
wants to exist.

### Two boundaries the verifier holds before there is code to break them

- **a dependency on `nostdb-core` is rejected outright, not pinned.** Every sibling
  repository has a rule requiring the Engine dependency to name an exact commit; this one
  has a prohibition instead, and the verifier says why in place of the missing pin rule — a
  pinning rule beside a prohibition reads as permission to add the dependency as long as the
  pin is right;
- **a token literal in `src` or `tests` fails the build.** This is the repository that holds
  a credential, so it is where an accidental one is most likely and most costly.

Connecting it also tripped a check Stage 8 built: the workspace verifier compares each
diagnostic code's registered owner against the source that declares it, and found seven
assigned to this repository that the crate never named. They are declared now rather than
deferred, because owning them is a fact about the contract rather than about how much of it
is built.

Stage 9 builds the out-of-process GitHub provider: the second source of graph data the
product has, and the first that is not a local filesystem.

| Increment | Content | Status |
| --- | --- | --- |
| 1 | the `provider_protocol_version` contract and the `github://` locator grammar, with fixtures | DONE |
| 2 | connect `nostdb-provider-github` as scaffolding, and the Core-side out-of-process client | DONE |
| 3 | locator parsing and browser-URL normalization | DONE |
| 4 | the HTTP boundary, ref-to-commit resolution, tree enumeration, and blob reading | DONE |
| 5 | the request loop | DONE |
| 6 | the per-snapshot tree cache | DONE |
| 7 | an HTTP client, and the binary that serves the protocol | DONE |
| 8 | running a provider as a child process | DONE |
| 9 | the settings snapshot fields and `link refresh` | DONE |
| 10 | read-only federation over a remote `.nostdb` | DONE |

The contract comes first for the same reason it did in Stages 7 and 8: the provider is a
separate executable, so the protocol between it and the Engine is the whole interface, and
writing the implementation first would make the contract a description of whatever got
built.

### The dependency this Stage has that no earlier Stage had

Every Stage so far could be verified offline. This one cannot be verified end to end without
**network access to GitHub and a credential**, and the root contract is explicit that a
Stage depending on credentials leaves them to be requested rather than invented.

So the provider is built against a transport abstraction, and every increment above is
testable against recorded fixtures with no network and no token. That is not a workaround
for the missing authority — it is the design the contract already implies. A provider whose
correctness can only be demonstrated by reaching a live third-party service is one nobody
can test in CI, and section 16.3 requires behavior on a *cached* snapshot that a live-only
test could not exercise at all.

What still needs authorization, and is not part of any increment above:

- a live conformance run against a real repository, with a real token;
- anything that would place a token in this workspace. Section 15.3 already forbids it
  reaching settings, graph files, caches, diagnostics, or command output, and nothing here
  changes that.

### Increment 1: what the protocol had to decide

The shape follows from what a provider *is*: the component that holds a credential and talks
to a network, and the one most likely to have been written by somebody other than whoever
shipped the Engine. That is why it runs out of process, and why the protocol between them is
the entire interface rather than an implementation detail.

Three decisions the document argues rather than asserts:

- **a credential travels as a name, never a secret.** The Engine cannot leak one it never
  held. Section 15.3 lists where a raw credential must not appear and does not mention
  provider diagnostics, only because providers did not exist when it was written — the
  protocol document closes that gap explicitly rather than relying on the list being read
  generously;
- **`content_id` is the host's own identifier and not a digest the Engine may trust.**
  Section 16.3 uses a Git blob ID to decide what to *avoid downloading*; everything actually
  downloaded is digested independently before it is opened. Conflating the two would let a
  host decide what the Engine believes about bytes it never checked;
- **a refusal is a reply, not an exit.** An Engine that gets no reply cannot tell a version
  mismatch from a crash, and those need different things from whoever hits them.

Binary content does not travel inside JSON. A `read` reply names a length and the bytes
follow the newline as an opaque run, which keeps a megabyte blob from being base64-inflated
by a third on every hop. A provider that writes the wrong number has corrupted the stream,
and the Engine closes it rather than resynchronizing: a stream whose framing is wrong cannot
be trusted to report that it is wrong.

Twenty-five fixtures, none of which reaches a network — twelve locators, thirteen messages.
The locator set includes a browser URL that must normalize, because a locator is a link's
identity and two spellings of one identity is two links.

### Increment 2: what the Engine refuses to take on trust

`nostdb-core` can now hold the whole conversation. The transport is a trait, so every test
runs against a scripted stream — no process spawned, no pipe opened, no network touched. A
client exercisable only by launching a real executable against a real host is one nobody can
verify in CI, and the contract requires behavior on a *cached* snapshot while the host is
unreachable, which a live test could not produce on demand.

A provider is the least trusted component in the system: it holds a credential, talks to a
network, and is the one most likely to have been written by somebody else. So the client
checks rather than accepts, and each of these has a test:

- **a `materialize` digest is a claim.** The Engine computes its own over the bytes it
  received. Recording the provider's answer would make the digest decorative, which is the
  opposite of why it travels with the artifact;
- **a `read` declares a length and exactly that many bytes are consumed.** A stream that
  cannot supply them fails as a transport error rather than being resynchronized, because a
  stream whose framing is wrong cannot be trusted to report that it is wrong;
- **a resolve that does not say whether it was cached is refused.** Absent is not "fresh",
  and a provider that did not say must not be recorded as having confirmed the snapshot;
- **a reply answering a different request is a protocol violation**, not something to match
  up later;
- **nothing may precede the handshake.** A request sent before a version is agreed has
  already guessed what the reply will mean.

`ProviderError::leaves_link_declared` is true for the provider's own unavailability code and
nothing else. The contract requires an unavailable source to keep its declaration and yield
reachable partial results, but a protocol violation is a defect in the provider rather than
a fact about the host — treating the two alike would hide a broken provider behind a
warning. A rejected credential is likewise not a source that happens to be down.

### Increment 3: the locator, and a scope move

The provider canonicalizes a `github://` locator, and the twelve published fixtures are now
gated by the workspace verifier rather than only by the child repository — a suite only the
child runs is one a workspace-level change can break without anything noticing.

Everything in the implementation follows from one fact: **a locator is a link's identity**.
Two spellings of one repository must produce one locator, or the graph holds two links where
the user declared one and neither is wrong enough to look wrong.

- owner and repository are lowered, because GitHub treats them case-insensitively;
- path and ref are left exactly as written, because a repository's paths are case-sensitive
  and so are Git refs. Lowering a path would silently rename a file;
- percent-encoding is preserved rather than decoded, since decoding would make two distinct
  paths compare equal;
- a browser URL is accepted and normalized rather than refused — somebody pasting one has
  named a real repository — and never stored in that form, which is the half that would give
  one repository two identities;
- **no ref is ever invented**, including for a bare browser URL. A default branch can
  change, and an identity that changes underneath the thing it identifies is not an
  identity;
- a locator carrying a credential is refused rather than stripped. Somebody who wrote one
  meant to use it, and dropping it quietly would turn an authentication mistake into a
  confusing "not found".

The conformance suite checks each accepted locator's **declared canonical form**, not merely
that parsing succeeded. An implementation that accepted a browser URL without normalizing it
would pass a parse-only suite while getting the identity wrong, which is exactly the defect
the fixtures exist to catch.

**Scope move.** Increment 3 was scoped with ref-to-commit resolution in it, and that has
moved to increment 4. Resolution is the first thing here that needs an HTTP transport, and
so is the enumeration increment 4 already contains; splitting the transport across two
increments would mean designing it against one caller and then discovering the second. The
locator half is complete and independently gated, which is what makes the move a
reorganization rather than a deferral.

### Increment 4: the HTTP boundary, and no HTTP client

The provider can resolve a ref to a commit, list what that commit contains, and read one
blob. All of it against an `Http` trait, so every test uses a recorded response and none
reaches a network.

The trait is not only a testing device. It makes choosing an HTTP client a decision about
*one implementation of one trait* rather than one the whole crate is built on top of, so it
can be argued on its own merits when it is made rather than inherited from whatever was
convenient on the first day. It is also the only way to exercise what the contract actually
asks for: section 16.3 requires behavior when the host is **unreachable** and when a rate
limit is **reached**, neither of which a live test can produce on demand and both of which a
recorded response produces exactly.

Mapping a status to a code is the part worth arguing, because the code is what a caller
branches on and each one sends somebody somewhere different:

- **an unauthenticated 404 reports that a credential is required**, not that the source is
  gone. GitHub answers 404 for a private repository deliberately, so that a probe cannot
  enumerate them — and reporting "gone" would send somebody looking for a typo in a name
  that is spelled correctly;
- **a 403 is a rate limit or a permissions failure**, told apart by the remaining-quota
  header. Reporting a rate limit as a rejected credential would send somebody to rotate a
  token that is working;
- **5xx and a transport failure are the same thing to a caller.** The host did not answer,
  the link stays declared, and a query returns what it can reach.

A truncated tree is refused rather than returned. A build over a partial listing would
report coverage it does not have, and every file the listing omitted would look like a file
the repository does not contain — which is worse than an error, because it is a wrong answer
that looks like a right one.

Blobs are fetched with the raw media type. Base64 inside JSON would inflate every file by a
third and make a large one cost more to decode than to fetch.

`serde_json` is the first dependency this crate takes, reviewed in the manifest. There is
still no HTTP client, and that is deliberate rather than pending.

**Scope move.** The content cache tie-in moves to increment 5. It needs a real client to be
worth anything — the point of a blob ID is to avoid a download, and there is nothing to
avoid until something downloads.

### Increment 5: the request loop, and a check that was wrong

The provider serves the protocol. Both halves now exist and speak the same version, and what
separates them is one `Http` implementation rather than any unwritten logic.

- **every failure is a reply.** A provider that exited to signal one would leave the Engine
  unable to tell a version mismatch from a crash;
- **a session remembers which commit each snapshot refers to**, and refuses a snapshot it
  did not resolve. Re-resolving a ref per request would let a branch move underneath a build
  and produce a graph assembled from two states of one repository;
- **a request carrying a secret instead of a name is refused.** A provider that accepted one
  would make the Engine a place a credential had been, which is the arrangement passing a
  name exists to prevent;
- **a graph locator naming a repository root names no artifact.** Guessing at
  `.nostdb/root.nostdb` would be inventing a path the user did not write.

`sha2` is the second dependency, reviewed in the manifest. Hand-writing SHA-256 to avoid a
crate the workspace already uses everywhere would trade a reviewed implementation for an
unreviewed one, at a place where being wrong is silent.

**A check this repository's own verifier got wrong.** It rejected any mention of a `.nostdb`
path, and fired on a test fixture. That was not merely a noisy pattern: naming a `.nostdb`
file is *exactly* what a graph locator does, and doing so is this provider's job in the
`graph_store` role. A check that forbids the thing the component is for is one people learn
to work around, so it now matches Engine API calls, which is what the boundary is actually
about.

**Scope split.** Increment 5 was scoped with the client, the cache, `link refresh`, and
federation alongside the loop. Those are now increment 6. The loop is complete and gated on
its own, and grouping four unrelated things behind one status would have meant reporting
none of them until all of them were done.

### Increment 6: listing a snapshot once

Reading every file in a repository cost one tree request per file, which for a repository of
any size is the difference between one API call and thousands. That was a note in the code
rather than a decision, and it is now a decision.

It is safe **precisely because a snapshot is an immutable commit**: the listing cannot go
stale. Caching a *ref* would be a different thing entirely and is what section 16.2 forbids
— the distinction is the whole reason resolution happens once and everything afterwards
names a commit.

A failed listing is not remembered. A rate limit or an unreachable host is a fact about this
moment, and caching it would make one bad minute poison a session that could otherwise
recover.

Both halves have a test that **counts requests**. The existing tests passed with or without
the cache, which is exactly the failure mode a cache test exists to avoid: a cache nothing
measures is a claim, not a behavior.

### Increment 7: the client, and the argument it was deferred for

`ureq` behind the `Http` trait, confined to `src/client.rs`. Everything else speaks the
trait, so replacing it is one file and no test changes — which is what the trait was for and
why the choice did not have to be made on the first day.

Chosen over `reqwest` because this provider is **synchronous by design**: it reads a line,
answers it, and reads the next. An async client would bring an executor into a program with
nothing to schedule, along with its dependency tree and a class of bug — a blocked reactor,
a runtime nested in a runtime — that a line-oriented process has no reason to own. TLS
through rustls rather than the platform's OpenSSL, which matters because this executable
ships inside official distributions and a link-time dependency on a system library is a
support burden on every platform it reaches.

Three things in the client are about not trusting what a host sends:

- **the response body is capped.** A repository somebody else controls can contain a file of
  any size, and an uncapped read fails as an allocation rather than as a diagnostic anybody
  can act on;
- **the API version is pinned.** An unpinned client is one whose behavior changes without a
  release;
- **a transport error's message is this crate's own, never the library's.** A transport
  error can carry a URL, a URL can carry whatever a caller put in it, and this is the one
  place in the crate where a credential could reach a diagnostic.

The binary resolves its credential from the environment — first among the resolvers section
15.3 permits — and reads it once.

Driven end to end, the executable answers a handshake and refuses an unknown request, which
is the first time both halves of Stage 9 have been observable from outside a test.

### Increment 8: reaching a real provider

The Engine could speak the protocol and had nothing to speak it to. This is the transport
that reaches one: a child process, its standard input, and its standard output.

**The framing is written out by hand, and that is the point.** A reply is a line; the
content after a `read` is a fixed run of bytes on the same stream. A buffered line reader
consumes part of that run looking for a newline, and the bytes it swallows are gone. So one
reader owns the stream for its whole life and both the line read and the exact-length read
go through it. A test sends content containing newlines — the ordinary case, and exactly
what a line-oriented reader would truncate.

A length mismatch is fatal rather than recoverable. Once the reader has consumed the wrong
number of bytes it cannot know where the next reply begins, and guessing would turn a
provider's bug into the Engine's corrupted data.

Two smaller decisions with the same shape:

- **the argument vector is passed directly, never through a shell.** A provider path comes
  from configuration, and configuration is read from a repository somebody else may have
  written;
- **standard error is inherited rather than captured.** Swallowing a provider's diagnostics
  into a buffer nothing reads would make a misbehaving provider silent, which is worse than
  noisy.

These tests spawn **real processes**. Every other test in Stage 9 uses a fake, deliberately;
this one cannot, because what is under test is the framing across a pipe and a fake transport
cannot get that wrong in the same way.

### Increment 9: closing a refusal that stood for two Stages

`link refresh` was refused in Stage 7 with a message that was true when it was written: a
local link is read live at every query and has no snapshot to advance. Stage 9 supplies a
source that has one, so the command now does what it was always meant to.

It needed a third amendment to the settings contract. Section 16.2 requires a resolved
commit to be kept and is specific about what it is *not*: the locator remains the link's
identity, and the commit is operational snapshot metadata. `links[].resolved_commit` and
`resolved_digest` are where that lives — **settings rather than the graph, for the mirror
image of the reason an alias goes the other way.** An alias is semantic and belongs with the
declaration; a commit is operational, and putting one in a shared graph file would make two
checkouts disagree about a link that is identical in both.

No version bump, for the third time and the same reason: the preservation rule in that
contract was written for exactly this.

Three behaviors, each with a test:

- **refresh is the only thing that advances a snapshot.** A query never does, so two queries
  a week apart see the same commit unless somebody asked for a newer one;
- **a local link reports having no snapshot** rather than failing, which is the refusal
  message from Stage 7 turned into an answer;
- **a link that cannot be reached keeps the commit it had.** Forgetting where it pointed
  would turn one unreachable minute into a rebuild of everything it reached.

The provider executable is named by an environment variable rather than a settings field: a
provider is a machine-local installation detail, and a path in a shared settings file would
name an executable that does not exist on somebody else's machine — or, worse, one that
does. It is started on first use, so a project whose links are all local never needs a
provider installed to be told it has nothing to do.

`Action::DEFERRED` in the command surface is now empty, and a test asserts it. Every link
action the product contract names is built.

**A near miss worth recording.** Repinning the Engine was done with a `sed` over every
40-character `rev` in the manifest, which also rewrote the `nostdb-server` pin Stage 8 had
added. The build failed immediately because the invented commit does not exist — but a
`sed` that matches a *shape* rather than a *name* would have silently repinned a real commit
had one collided, and pinning is the mechanism the whole workspace's reproducibility rests
on.

### Increment 10: a remote database in a query

A remote link opens. Bytes a provider materialized and the Engine already verified are
parsed and joined to the federation the way a local link is.

The opener is a closure, for the same reason `refresh_links` takes one: this decides what a
link *means*, not how an executable is found, and a caller that owns the provider can be
tested without one. Generic rather than a trait object so it can be reborrowed for each
link — a closure that opens a network source cannot be cloned, and every step of the walk
needs the same one.

Passing none reports every remote link as having no provider, which is a fact about the
caller rather than about the link. That is what `resolve` still does, so nothing that
federated before behaves differently.

A remote source is parsed from bytes rather than opened from a path. It has no local path,
and materializing one to disk would put a file somewhere nobody asked for — so its `path`
is the locator, which was always its identity.

**A remote source's own links are not followed**, and that is a decision rather than an
omission. One provider round trip per level is a cost worth deciding on rather than
discovering, and a link it declares is not silently dropped: it is simply not followed, and
one level is what this build promises.

Every failure leaves the link declared and the root intact — a provider that refuses, an
artifact that will not decode, a caller with no provider at all. That is the contract
requirement that where a break happened does not change what a query returns.

### Where Stage 9 ended

The provider works. The protocol is specified and gated by fixtures, the Engine speaks it,
the provider serves it on standard input and output, locators canonicalize, and the GitHub
API layer resolves, enumerates, reads, and caches — 47 tests, **none of which touches a
network**.

Everything it scoped, across ten increments: a specified protocol with fixtures, a connected
child repository, a locator that canonicalizes, a GitHub API layer, a request loop, a tree
cache, an HTTP client, a process transport, `link refresh`, and remote federation.

Four contracts were amended or authored along the way — `provider_protocol_version` written
from nothing, and the settings contract amended twice more. None needed a version bump,
because the preservation rule in that contract was written for exactly this kind of
addition.

**What is not proven.** Every test in Stage 9 runs against a recorded GitHub. That was the
right design — section 16.3 requires behavior on a cached snapshot and when a host is
unreachable, and neither can be produced on demand against a live service — but it means the
recordings are assumptions until a live run checks them. That run needs a real credential,
the scope named it as unauthorized when it was written, and nothing built since has changed
that.

What also remains, and is not an increment, is the **live conformance run against a real
repository with a real credential**. The scope has named it unauthorized since it was
written, and nothing built since has changed that: every test here proves the provider
behaves correctly against a *recorded* GitHub, and only a live run proves the recording is
what GitHub actually sends.

### What section 16 pins down before any code

- **the locator is `github://<owner>/<repository>/<path>?ref=<git-ref>`.** Owner and
  repository canonicalize case-insensitively; path and ref preserve case. The provider may
  accept a browser URL but must normalize before storing or comparing one, because a locator
  is a link's identity and two spellings of one identity is two links;
- **a branch or tag resolves to one immutable commit before anything is read.** The
  configured locator stays the identity; the resolved commit is operational metadata. A
  query must never silently advance a branch, which is precisely why `link refresh` exists
  and why it could not be built before this Stage;
- **the provider retrieves bytes and metadata, and only Core interprets them.** A provider
  that parsed `.nost` would be a second parser, which the ownership boundaries forbid;
- **an unavailable source leaves the link declared.** A cached immutable snapshot may serve
  a query and must be reported as cached; with no valid snapshot the link is declared and
  unavailable, which is the behavior `link check` already reports for a local one.

### Deferred out of Stage 9

- every other remote host. Section 15.2 defers SSH, object stores, and databases, and
  building a second provider before the first one's protocol has been used once would be
  designing an abstraction against a single example;
- `GraphStoreProvider` write support. The MVP retrieves an existing `.nostdb` read-only;
- the AI enrichment that Stage 10 layers on top of remote source.

## Stage 8 scope

Stage 8 is taken in four increments, for the same reason Stages 5 through 7 were.

| Increment | Content | Status |
| --- | --- | --- |
| 1 | connect `nostdb-server` as scaffolding; the local protocol and catalog contracts in `nostdb-spec` | DONE |
| 2 | the daemon: the endpoint, the one-instance OS lock, the OS-user boundary, and catalog persistence | DONE |
| 3 | framing, version negotiation, and message decoding | DONE |
| 4 | sessions, transaction isolation, query timeouts, per-session resource limits, recovery, and stale-session cleanup | DONE |
| 5 | the client side in `nostdb-cli`: `server start|status|stop|run`, `catalog add|remove|list`, and `--database @name` | DONE |

### Scope amendment: increment 3 split in two

Stage 8 was scoped in four increments and is now five. Increment 3 was "sessions, transaction
isolation, query timeouts, per-session resource limits, recovery, and stale-session cleanup",
and the wire protocol was not named in any increment because it looked like part of sessions.

It is not part of sessions; it is underneath them. A session spans messages, which is why
section 3 says the protocol is not request-per-connection, so nothing about a session can be
built before framing and negotiation exist. Splitting it is not a narrowing: the wire protocol
is separately verifiable against nine of the eleven refusal rows section 8 publishes, and
sessions turned out to be blocked on a design question the message loop had to exist to pose.

That question is recorded below. This is the same reason Stage 7 split its first increment in
two after inspecting the work rather than before.

### Authorized scope

Creating `nostdb-server`, connecting it, and pushing was covered by the Stages 7 through 12
grant recorded above, and re-confirmed for this repository before it was created. Performed:

- created `https://github.com/nostdb/nostdb-server` as a public repository;
- pushed its initial commit to `main`;
- pinned it as a root submodule at `f05de0b`.

### Why the protocol contract comes first

The daemon cannot frame a request until a contract says what a request is, and it cannot
refuse an incompatible client until the versions it negotiates are published rather than
implied. `docs/PRD.md` section 21.1 gives the local protocol its own
`server_protocol_version` and section 21.3 gives the catalog its own `catalog_version`, so
both are published contracts that happen to have no file format yet. This is the same
ordering Stage 7 used when the `.nost` language contract preceded `convert`.

### Two codes this Stage must unregister from a deferral list

`SERVER_ALREADY_RUNNING` and `SERVER_PROTOCOL_UNSUPPORTED` are listed in
`scripts/verify-workspace.sh` as awaiting the contract that will own them. Increment 1 is
that contract. The verifier fails when a registered code is still listed as awaiting one, so
registering them in `nostdb-spec` and removing them from that list is one change rather than
two, and the check that enforces it is the one added after the same gap appeared three times.

### What the scaffolding already enforces

"No TCP or HTTP listener" is a product invariant in `docs/PRD.md` sections 21.1 and 30.6
rather than a current limitation, so the child verifier enforces it structurally before a
transport exists to break it. It checks the dependency list as well as the source, because an
HTTP server crate would supply the listener even if this repository never names the type
itself. Both refusals were proven to fire rather than assumed to work.

### Deferred out of increment 1

- the daemon itself, including the `nostdb-server` crate. Its initial commit is repository
  scaffolding only, as every sibling's was when it was connected, so how the daemon depends
  on the Engine is decided in increment 2 rather than guessed at now;
- every `server` and `catalog` command, which belongs to increment 4 and lands in
  `nostdb-cli`, because the command surface is owned there and not here;
- `--database @name` resolution, which needs both a catalog and a session;
- the Windows named pipe. It is required by section 21.1 and is not deferred out of the
  Stage; it belongs to increment 2 with the Unix socket, because one endpoint abstraction
  covering both is the point rather than a port added afterwards.

## Resolved conflict: a published code whose implementation is not the Engine

Found while starting Stage 8 increment 1, before registering anything. Recorded before
acting, as the root `AGENTS.md` requires. Resolved by the owner on 2026-07-28; see the
resolution at the end of this section.

### The conflict

`scripts/verify-workspace.sh` requires the diagnostic vocabulary `nostdb-core` recognizes
and the registry `nostdb-spec` publishes to be **exactly** equal. Both hold 33 codes today
and the check passes.

Increment 1 must publish `server_protocol_version` 1, and `docs/PRD.md` section 28 requires
two codes for it:

```text
SERVER_ALREADY_RUNNING
SERVER_PROTOCOL_UNSUPPORTED
```

Neither is an Engine code. The daemon raises both, and `nostdb-server` has no crate yet.
Registering them therefore fails the equality check, because `nostdb-core` will never
declare a code it cannot emit. Leaving them unregistered is not available either: they sit
on the same script's `awaiting_a_contract` list, increment 1 is the contract that list is
waiting for, and a registered code still listed there is itself a failure.

Every code in the registry so far has been an Engine code, which is why the check could
assume one implementation. These are the first two that are not.

### It is not only Stage 8

Six more codes on that same deferral list have a non-Engine owner, so this recurs in every
remaining Stage rather than being a Stage 8 quirk:

| Code | Owner | Stage |
| --- | --- | --- |
| `PROVIDER_AUTH_REQUIRED`, `PROVIDER_PERMISSION_DENIED` | `nostdb-provider-github` | 9 |
| `PLUGIN_REQUIRED`, `PLUGIN_INCOMPATIBLE`, `PLUGIN_DIGEST_MISMATCH` | `nostdb-cli` and `plugins` | 11 |
| `VIEW_CAPACITY_EXCEEDED` | a viewer plugin | 11 |

### The options

1. **The Engine declares every published code**, including ones no Engine API can return.
   Cheapest, and keeps one comparison. It costs the meaning of the Engine's error enum,
   which becomes a registry rather than that crate's error surface, and it contradicts the
   recorded decision to use typed errors instead of unregistered codes.
2. **Compare the registry against the union of every implementation's vocabulary.** Most
   faithful. It cannot be done in increment 1, because the only other implementation is a
   crate that increment 2 creates, so increment 1 would publish two codes nothing verifies.
3. **Give each code an explicit owner in `diagnostics.json`.** The root check then compares
   the Engine against exactly the codes owned by the Engine, and requires every other
   owner's codes to be declared by that owner once its crate exists, listing the ones that
   are not yet implemented the same visible way `awaiting_a_contract` already lists codes
   awaiting a contract.

### The resolution: option 3

Chosen by the owner. Every code records an `owner` beside the `contract` it already
recorded, and the workspace verifier compares each owner against the codes it owns:

- all 33 existing codes are owned by `nostdb-core`, which is what made one comparison look
  sufficient for six Stages;
- the Engine is still compared in **both** directions, because a code it recognizes that
  the registry does not assign to it is drift just as much as the reverse;
- any other owner is compared in one direction only. Every code assigned to it must appear
  in its source, and the reverse is deliberately not required, because an owner legitimately
  names a code it forwards from the Engine rather than raises itself;
- an owner whose crate does not exist yet is **reported**, not skipped:
  `diagnostic ownership: nostdb-server awaits an implementation for ...`.

`registry_version` stays 1. The addition is a new key on every entry with no reader that
could misread an absent one, which is the same preservation rule that let the settings
`cache` section land without a bump.

The owner list is closed, to the five child repositories that can raise a code. An owner
outside it names a repository the verifier cannot check, so `nostdb-spec` rejects it.

Three paths were each proven to fire rather than assumed to work:

| Probe | Result |
| --- | --- |
| a code reassigned away from `nostdb-core` | `recognized in nostdb-core but not owned by it in nostdb-spec: SYNC_CONFLICT` |
| a code owned by `nostdb-server`, which has no source | `nostdb-server awaits an implementation for SERVER_ALREADY_RUNNING` |
| the same code once `nostdb-server/src` exists without raising it | `nostdb-spec assigns these codes to nostdb-server, whose source never raises them` |

The second probe also confirmed the coupling this record predicted before it was built: the
same run failed with `these codes are registered and still listed as awaiting a contract`,
which is why registering the server codes and removing them from that list has to be one
change.

Publishing the two contracts is the remainder of increment 1.

### Two registry defects fixed while finding this

`change_set_version` was published in Stage 7 increment 4, and `versions.json` recorded it
as `specified`. The `VERSIONS.md` row still read `deferred` and `not yet specified`.

The check that exists to hold those two forms together passed anyway. It asked whether the
row *contained* the status string, and `not yet specified` contains `specified`, so a row
stating the opposite of the registry satisfied it. Both the version and the status column
were compared that loosely.

The check now splits the row into columns and compares the status, the current version, and
the linked document exactly. It was run against the stale row first and does fail on it:

```text
VERSIONS.md row for change_set_version states status deferred, registry says specified
```

## Resolved conflict: the `.nost` record identifier

Found while checking what Stage 7 needs. Recorded before acting, as the root `AGENTS.md`
requires. Resolved by the owner on 2026-07-27; see the resolution at the end of this section.

### The conflict

| Source | What it says |
| --- | --- |
| `nostdb-core/src/id.rs` | a record identifier's textual form is a two-character kind prefix followed by exactly 26 Crockford base32 characters |
| `nostdb-spec/docs/NOST_LANGUAGE.md` section 5.3 | `id` "carries the opaque persisted record identifier", and never says what one looks like |
| `nostdb-spec/grammar/nost.ebnf` line 48 | `id_clause = "id" , string_literal ;`, so any string at all |
| `nostdb-spec/fixtures/nost/valid` | states `id "n_1"`, `id "e_2"`, `id "m_1"` |
| `docs/PRD.md` section 11.2 | "A user-authored `.nost` entity **may** declare its opaque ID explicitly" |
| `nostdb-spec/grammar/nost.ebnf` lines 36, 41, 44 | `id_clause` is mandatory on every module, node, and edge |

Two disagreements follow. The Engine rejects every identifier the published fixtures state:
`LocalNodeId::from_str("n_1")` is `WrongLength { expected: 26, found: 1 }`, which
`id::tests::rejects_a_wrong_length_body` already asserts. And the grammar requires an
identifier the root PRD says a user *may* supply.

### Why nothing has broken yet

The `.nost` tree keeps an identifier as `Spanned<String>` and nothing converts it to a typed
one, so the parser, the formatter, and every `.nost` fixture pass. The gap is latent.

It stops being latent at `nostdb convert .nostdb/root.nost .nostdb/root.nostdb`, which
`docs/PRD.md` section 20.3 requires and Stage 7 owns: converting has to turn that string into
a `LocalNodeId`, and every published valid fixture would be refused.

### Recorded resolutions

1. Complete the language contract: define the textual form as the Engine's, make `id_clause`
   optional so a hand-authored declaration may omit it, register a code for a malformed
   identifier, and restate the fixtures. This is what the Stage 3 finding asked for, and it
   keeps one form across implementations.
2. Define a `.nost` identifier as any non-empty string and have the Engine map it to a minted
   record identity. This keeps hand-authoring easy but introduces a second identity concept
   alongside the opaque 16-byte one, which `docs/PRD.md` section 11.2 does not have.
3. Leave the contract silent and let each implementation choose. Rejected on sight: an
   identifier a `.nost` file states is read by every implementation, so an unspecified form is
   exactly the divergence `nostdb-spec` exists to prevent.

### The resolution

Resolution 1 is taken, because `docs/PRD.md` section 11.2 already describes an opaque
identifier a user *may* declare, and its own illustrative syntax writes one as `"n_01J..."`.
It lands in Stage 7 increment 1, which is where conversion first needs it.

Two details of it changed when the owner settled the wider language shape on 2026-07-27, so
the resolution is recorded as amended rather than as first written:

- the identifier is no longer an `id_clause` in declaration position. It is the reserved
  property key `id`, so "a user *may* declare it" is expressed by omitting a field rather
  than by an optional grammar production;
- the body is a UUID version 7 in canonical text rather than 26 Crockford base32 characters.
  That part overturns a decision Stage 6 recorded; see `Reversed decision: identifier
  minting` below.

The kind prefix survives both changes. `LocalNodeId::from_str` refuses an edge identifier
today, which `id::tests::a_kind_prefix_is_required_and_not_interchangeable` asserts, and
dropping the prefix would delete that guarantee for nothing.

Constraining the form does invalidate a `.nost` file that stated `id "n_1"`, which version 1
accepted as a string. That is folded into the version 2 bump recorded below rather than
treated as completing version 1, because version 2 breaks those files for a larger reason
anyway.

## Resolved conflict: a `.nost` module has nowhere to go in `.nostdb`

Found immediately after the identifier conflict, while starting the conversion work.
Recorded rather than guessed at, because unlike the identifier form the root PRD points in
two directions at once. Resolved by the owner on 2026-07-27, and not by either recorded
option; see the resolution at the end of this section.

### The conflict

| Source | What it says |
| --- | --- |
| `nostdb-spec/grammar/nost.ebnf` | a document is `{ module_declaration }`, and `module_item = node_declaration \| edge_declaration`, so every node and edge is inside a module |
| `nostdb-spec/docs/NOST_LANGUAGE.md` section 5.3 | a module carries an `id` and an optional `source`, and "holds nodes and edges" |
| `nostdb-core/src/encoding.rs` | `Graph` is `nodes`, `edges`, and `links`. There is no module |
| `nostdb-core/src/container.rs` | fourteen section kinds, and none of them is modules |
| `docs/PRD.md` section 11.2 | "Analyzed modules receive a persisted `StableModuleId`", a type distinct from a node identifier |
| `docs/PRD.md` section 17.4 | analyzers extract "packages, modules, files, types, classes, functions, methods, and fields", which are graph records |

Converting `.nost` to `.nostdb` therefore drops each module's identity, name, and source,
and converting back has nothing to rebuild a module from while the grammar requires one. A
round trip cannot be faithful in either direction, and `docs/PRD.md` section 30.2 requires
both.

The two PRD sections disagree about what a module *is*. Section 11.2 gives it an identity
type of its own, which is what a thing that is not a node looks like. Section 17.4 lists it
among the records an analyzer extracts, which is what a node looks like.

### Recorded resolutions

1. **A module is a first-class record.** `Graph` gains modules, each with its
   `StableModuleId`, name, and optional source locator, and a node or edge records which
   module it belongs to. A section kind is promoted for them, which is a
   `nostdb_format_version` change. Faithful in both directions, and it keeps
   `StableModuleId` meaning what section 11.2 says. A record created by a Cypher `CREATE`
   belongs to no module, so membership is optional and export needs a home for the rest.
2. **A module is a node.** A module declaration converts to a Node carrying the module's
   name and source, and membership becomes an Edge. No format change, and it matches
   section 17.4, which already treats a module as an extracted record; a query can then ask
   about modules with no new syntax. `StableModuleId` becomes redundant, or a module node
   carries it as a property, which is the part that grates: an identity in a property is
   exactly what section 11.2 says a locator must not be.
3. **A module is lexical only.** The block groups declarations and carries nothing.
   Rejected on sight: it makes a documented round trip lossy.

Resolution 1 is the better fit for the model as built, and resolution 2 is the smaller
change and the more queryable result. The decision belongs to whoever owns the product
shape, so it is recorded and left open rather than taken here.

Stage 7 increment 1 is blocked on it. Nothing in the workspace depends on the answer yet,
and the current valid behavior is unchanged.

### The resolution: a fourth option

The owner took neither recorded option. A module is not represented in `.nostdb` because
**the concept is removed from the product**. A database holds Nodes, Edges, and Links, and
`.nost` has no module declaration to convert.

That is close to recorded resolution 3, which this document had rejected on sight for making
a documented round trip lossy. The rejection assumed the grammar would keep requiring a
module block while the database dropped it, which is what makes a round trip lossy. Removing
the declaration from the language too removes the thing that would have been lost, so the
objection does not apply to what was actually chosen. Recording that distinction matters
more than being consistent with the earlier dismissal.

Nothing about source location is lost with it. A module's `source "src/auth.rs"` duplicated
what `Evidence` already carries per record, and `Evidence` carries it more precisely, with a
path, a range, and a content digest.

`StableModuleId` goes with the concept. It is removed from `nostdb-core/src/id.rs` and from
`docs/PRD.md` sections 11.2, 17.5, and 17.7.

### A consequence this leaves open

`docs/PRD.md` section 11.2 says an analyzer-owned entity is matched through "a versioned
analyzer namespace, Stable Module ID, and semantic symbol key". Removing `StableModuleId`
deletes the middle term of that triple, and nothing yet replaces it.

Incremental rebuild is what needs the answer, and that is Stage 10 rather than this one, so
it is recorded here instead of being invented now. No current behavior depends on it: no
analyzer runs yet, so nothing matches an entity across builds today.

## The `.nost` language version 2

Removing the module declaration cannot be done alone: it changes the file's top level, so
every fixture is rewritten either way. The owner used that opening to settle the whole
declaration shape at once, on 2026-07-27. This section records what was decided and why, so a
later reader does not have to reconstruct it from the grammar.

The shape:

```nost
@nost 2

@link "./packages/child" as child

schema project {
  name: string,
  version: double,
  labels?: string[],
}

schema authority {
  scope: string,
}

schema CONTAINS (project -> feature) {
  since?: datetime,
}

node foo: project, authority {
  id: "n_0198a1b2-c3d4-7e5f-8a9b-0c1d2e3f4a5b",
  name: "nostdb",
  version: 0.1,
  scope: "admin",
  labels: ["Entity"],
}

edge foo -> login :CONTAINS {
  since: datetime"2026-07-27T00:00:00Z",
}
```

### Why version 2 rather than completing version 1

Version 1 was completed rather than superseded twice before, both times because the thing
being changed had never been specified, so no implementation could have relied on it.

That reasoning does not reach here. The module declaration was specified in
`docs/NOST_LANGUAGE.md` section 5.3, required by the normative EBNF, and exercised by all
nine accepted fixtures. An implementation could have relied on it, and removing it breaks
every version 1 file. `nost_language_version` therefore becomes 2, and an implementation that
reads `@nost 1` refuses it with `NOST_VERSION_UNSUPPORTED` rather than guessing.

Only `nost_language_version` moves. The `.nostdb` format, settings, provider, plugin, and
server versions are independent and none of them changes, which is the rule
`nostdb-spec/AGENTS.md` states about never letting one version bump imply another.

### The decisions and what each one buys

| Decision | Why |
| --- | --- |
| A module declaration is removed | The owner's product call. See the resolved conflict above |
| `schema` becomes a declaration, and a node names one or more of them | `docs/PRD.md` section 11.6 already required Schemas to validate nodes, edges, labels, properties, and endpoints. Nothing implemented it, and `.nost` could not express it at all |
| A schema name is a label | `Node.labels` is unchanged, so `MATCH (n:project)` works with no new query syntax and the model's at-least-one-label rule is satisfied without a special case |
| An edge carries exactly one schema | `Edge.relation` is one value. Allowing two would mean inventing a second relation concept the model does not have |
| `id` and `labels` are reserved property keys | The owner's preference for one uniform "everything is a field" shape. It also deletes `id_clause` from the grammar, so "an identifier is optional" is expressed by omitting a field |
| Fields separate with commas, and a trailing comma is accepted | The owner's call. Canonical output omits the trailing comma |
| `?` marks an optional field, written on the key | `description?: string` says the key may be absent. `string?` would read as a nullable value, and a stored null is unrepresentable, so it would be a false signal |
| Scalar types are `boolean`, `integer`, `double`, `string`, `bytes`, `datetime` | One name per model type keeps canonical output decidable. `double` rather than `float` because `PropertyValue::Float` holds an `f64` |
| An array is `string[]`, and arrays do not nest | `PropertyValue::List` holds scalars only, so `string[][]` has nothing to represent it |
| Contributions and evidence get `@by` and `@evidence` blocks | Without them, `.nostdb` to `.nost` silently drops ownership and provenance, and a round trip would collapse every contribution into `Owner::User`. That would break the section 11.3 guarantee that an analyzer refresh preserves user edits |

### Two consequences accepted rather than solved

A node may name a schema that was never declared, because a schema is optional and a schema
name is just a label. A typo in a schema name is therefore indistinguishable from an
intentional bare label, and it becomes an unvalidated label instead of an error. Nothing in
the syntax can tell the two apart, and refusing an undeclared name would contradict the
owner's decision that a schema is optional.

An edge has no declaration name, because nothing referenced one: an endpoint names a node.
Two identical `edge foo -> login :CONTAINS {}` declarations are then distinguishable only by
`id`. The graph is a multigraph, so both are kept, and canonical output orders them
deterministically.

### Where two schemas disagree

A node naming two schemas is validated against the union of their fields. If both declare the
same key, the declared types must match, and a mismatch raises a diagnostic. If one marks the
key optional and the other does not, the key is required. Requiring the stricter reading is
the only rule that cannot silently weaken a declaration the author wrote.

## Stage 7 increment 4: link resolution, and an honest scope

Increment 4 is larger than the three before it put together. It is being taken in parts,
and this records what is done, what is not, and why the split falls where it does.

Done, at `nostdb-spec` `be857c4`, `nostdb-core` `9d9657e`, and `nostdb-cli` `6caa2a2`:
link resolution and recursive federation in Core, federated queries, `link list`, `link
check`, `sync`, and `link add` and `link remove` through the multi-file journal, and the source scanner with
its hand-written Git-ignore matcher, `plan`, the Rust structural analyzer, `build`, and `apply`.
`./scripts/verify-workspace.sh` passes over all three pins, with 683 tests in the Engine
and 124 in the command surface.

### Recorded decision: resolution reports rather than fails

Root PRD section 18.6 requires an inaccessible source to keep its declaration and the
query to return everything reachable. `federation::resolve` therefore cannot return an
error for a link at all: every outcome is a `LinkStatus` and, when unreachable, a
warning. The only `Err` it produces is for the root, which is a different problem.

A corrupt target is the test that proves it: the link is unavailable and the root's
records are still there.

### Recorded decision: each source keeps its own graph

Two sources may carry the same local identifier. A database copied and then linked from
its original has exactly that, and section 18.4 says two locators stay two logical
sources however identical their bytes. Concatenating the graphs would make one record of
two, so `Federation` holds a list of sources and a record is identified by the pair of
canonical locator and local identifier.

A test builds that collision on purpose and asserts the locators are what tell them
apart.

### Recorded decision: `list` reports and `check` judges

A broken link is a fact about the workspace rather than a failure of the command that
listed it, so `link list` always succeeds. `link check` is the one a pipeline runs and
exits 5 when anything could not be reached. An orphan settings entry changes neither
class, because it is about settings rather than reachability.

### An ambiguity the implementation forced

`max_link_databases` named a limit and left its unit unstated. The first implementation
and the first test took opposite readings, which is how it surfaced. It counts linked
databases and excludes the root, so it counts the same thing as `linked_databases_opened`
in the result envelope; a limit counting one thing while the number printed beside it
counted another would be a trap. The settings contract now says so for all three limits.

### Recorded decision: a bound record carries its source

A `LocalNodeId` is unique within one database and nowhere else, and a federation may hold
two sources carrying the same one. Merging the graphs and looking a record up by
identifier would find whichever came first; every binding, endpoint resolution, and
`DELETE` target goes through that lookup, so it would pick the wrong record silently.

`QueryValue::Node` and `QueryValue::Relationship` therefore carry `Scoped<T>`: a source
index beside the identifier. Three consequences follow, each with a test:

- the sort key carries the source, so `ORDER BY` and `DISTINCT` cannot fold two records
  into one, while `Display` still renders the identifier alone because that is what the
  result envelope carries;
- the visited set in a variable-length walk is scoped, so reaching one identifier in two
  sources is two nodes rather than a cycle;
- `Scoped::is_root` is what a write turns on, so `LINKED_DATABASE_READ_ONLY` is enforced
  in one place — where a binding becomes something the writer will modify — rather than
  at each call site.

`execute` and `Transaction::run` delegate to federated forms with an empty source list,
so every existing caller and test was unchanged by the refactor.

### The contradiction increment 3 left, now closed

`link list` reported an opened source while `query` saw none, and
`linked_databases_opened` sat at zero beside it. Both now come from the same resolved
federation. A query over a broken link is partial and still answers with what it reached.

The federation is resolved once per invocation rather than per statement, so a REPL
session pins each linked source for its whole life; a second statement seeing a link that
changed underneath it would not be one snapshot.

### Recorded decision: the baseline cannot live inside the database it describes

This is what the synchronization work turned up, and it decided the design.

A baseline records the digest of the whole database file. Writing it into that file would
change the digest it had just recorded, and advance the generation it had just named, so
the baseline would be wrong the instant it was stored.

Breaking that circle from inside means digesting everything *except* one section and
writing the baseline in the same commit that produces the generation it names. Both are
possible and neither is explicable. `.nostdb/sync.json` has no circle to break, and
`docs/PRD.md` section 10.1 now lists it with the reason.

The container's reserved `sync_metadata` section therefore stays unwritten. A test asserts
it stays that way, so the omission is not later "fixed".

### Recorded decision: two refusals that decline rather than guess

With no baseline, synchronization declines. Nothing records what the two last agreed on,
so neither side can be called the one that moved, and a guess would overwrite whichever it
went against. `export --nost` establishes a baseline and `convert` adopts a document
wholesale; both are explicit, and the refusal names both.

A malformed baseline is refused rather than treated as absent. Treating it as absent would
silently discard the record of an agreement and leave the next run declining instead of
acting.

A stale file and a conflict both exit 4. They are different states with the same
consequence: synchronization could not proceed and a person has to choose. The product
contract gives class 4 to a sync conflict and has no closer class for the first.

### Recorded decision: four files move together or none do

`link add` changes the declaration in the database, its mirror in the settings, the
materialized `.nost`, and the baseline recording that the two agree. A staged write
followed by a rename is already all-or-nothing for one file; four renames are not, and a
crash between two of them leaves the files disagreeing about what is declared.

`journal::FileTransaction` stages every destination, writes the journal, and then promotes.
`Project::open` finishes a committed journal before reading anything, so a crash is
resolved rather than observed. Replay is idempotent because a promotion whose staging file
is gone has already happened.

A journal with no commit record is discarded along with its staging files. The intent was
never made durable, so carrying it out would be inventing a decision the user never
committed to; the last valid generation is the one already on disk. Both directions have a
test, and removing the recovery call makes both fail.

This is the first use of `journal.rs`, which Stage 4 built for exactly this case and
nothing had needed until now.

### Recorded decision: the mirror is edited, not regenerated

The settings contract requires an unknown field to survive a write, because a writer that
drops what it does not recognize makes downgrading lossy. `link add` therefore rewrites the
document the user has — reading it, replacing the `links` array, and reserializing —
rather than rendering a fresh one from the fields this build knows. Each surviving entry
keeps its `timeout_ms` and `credential_ref` exactly as written.

The alias is not written there. A test lists the entry's keys rather than searching the
text, because the source `"./child"` ends in the alias `child` and a substring check would
have passed either way.

### Recorded decision: a change refuses rather than overwriting a `.nost`

When `.nost` is materialized, `link add` regenerates it. If that file holds edits the
database has not adopted, regenerating destroys them, so the command refuses with exit
class 4 and names `nostdb sync`. A file with no baseline is refused for the same reason:
nothing records what the two last agreed on, so nothing establishes that the file is the
Engine's own output rather than something a person wrote.

Every refusal — a malformed locator, a duplicate source, a duplicate alias, an undeclared
removal, an unsynchronized `.nost` — happens before the first byte is staged. A test reads
the database file before and after three refusals and compares the bytes.

### A defect the end-to-end test found

The federation resolved a relative locator against the directory holding the database
file. In a configured project that directory is `.nostdb`, so `@link "./packages/child"` —
the example in the product contract — meant `.nostdb/packages/child`, inside the opaque
state directory.

Every federation unit test wrote its root database straight into a temporary directory
rather than into a `.nostdb` beneath it, so none of them used the layout a real project
has, and the first `link add` test to run against a real project is what surfaced it. The
base now steps out of the state directory when it finds one, derived from the path so the
rule holds identically at every depth. Three tests use the project layout, including a
nested link, and one keeps the bare-file reading `nostdb convert` output gets.

### Recorded decision: `refresh` was refused for the wrong reason

It was refused as "needs the multi-file journal". That is no longer true — the journal
exists and `add` uses it. `refresh` advances a remote snapshot to a newer immutable commit,
and a local link is read live at every query and has no snapshot to advance. Implementing
it against a local source would mean inventing a meaning the product contract does not give
it, so it waits for the GitHub provider in Stage 9. The message and its test now say that.

### Recorded decision: analyzers are hand-written and take no dependency

This is the decision the Stage had not made, and the user made it: no dependency, and the
best-performing option available.

That means no `tree-sitter`, no `syn`, and no ignore-matching crate. Every parser the
Engine needs is written here. The choice is consistent with what the repository already
does — the `.nost` lexer and parser and the Cypher parser are both hand-written — and it
keeps the dependency documentation requirement in `AGENTS.md` from growing a transitive
tree for each language added.

What it costs is stated plainly rather than discovered later. A hand-written analyzer per
language is a large, ongoing body of work, and its precision is lower than a full grammar's
for the same effort. That is survivable only because the analyzer contract already requires
each analyzer to *declare* its precision: `PrecisionClass::DeterministicSyntactic` for a
skim of item structure is an honest claim, where presenting the same result as
`DeterministicSemantic` would not be. Section 17.3 requires that declaration, and this
decision is what makes it load-bearing rather than decorative.

The first consequence landed with the scanner. Git's ignore syntax is a closed, stable set,
so the matcher is stated in `ignore.rs` — last match wins, trailing `/` for directories
only, an interior `/` anchoring, `*` and `?` stopping at a separator where `**` does not,
character classes, escapes, and per-directory precedence — rather than delegated. A rule
that excludes a path in Git and includes it here would analyze a file the user believed was
gone, so approximating it would be worse than not implementing it.

### The scanner, and what running it on this workspace found

`scan` walks a tree and reports which files a build may analyze and, for each file it may
not, why. Every exclusion is a coverage record. A scanner that quietly omits a file reports
a build that covered everything when it did not, and nobody reading the report can tell.

Recording a symlink that was not followed needed a new `SkipReason`. Following is off by
default, which section 17.2 requires, so a project keeping real source behind a link would
otherwise have shown full coverage over a subtree that was never read.

Cycle detection sits in the directory walk rather than the symlink branch, so a link to its
own ancestor is caught on the first hop rather than after going round once. The visited set
is only maintained when following is enabled: without links a tree cannot contain a cycle,
and canonicalizing every directory to prove that is a syscall per directory paid for
nothing.

Running it over this workspace found one defect and confirmed one non-defect. The defect: a
submodule's `.git` is a file holding a gitlink, not a directory, so the directory prune list
never saw it and it reached the report as unclassified. The non-defect: 318 unclassified
files, almost all of them this project's own `.expected`, `.cypher`, and `.hex` conformance
fixtures. Those genuinely have no language this build can name, and saying so is the
correct answer rather than a gap.

### `plan`, and two counts that must not be confused

`nostdb plan` reports what a build would do and does none of it. Section 17.6's rule is
that no AI action begins before a plan exists, so the plan is produced from a scan and a
capability registry alone.

`BuildPlan` carries exactly the shape section 17.6 publishes, field for field. Everything
else this build knows — the per-language breakdown, the exclusion counts — sits in
`PlanReport` beside it, so the published contract stays what the contract says.

`semantic_candidates` and the token estimate answer different questions and are kept
apart. The first is a fact about the source: how many files *could* be enriched. The second
is what *this* run would spend, which is zero with `ai_mode: off`. A plan can then say "412
files could be enriched, and this run will spend nothing" rather than leaving a reader to
infer one from the other.

The token estimate is a band — six bytes per token to two — and the budget check compares
its top. Understating a cost is precisely what would let a run start a call it cannot
afford, and the contract requires that a call which *could* cross a hard limit never
starts. A real tokenizer would narrow the band and would be a dependency bought for an
estimate that only has to be a safe bound.

`source_revision` is tagged `tree:` for a local working tree and derived from every scanned
path with its content digest. A provider supplies an immutable commit for a remote source;
a content-derived revision must never be read as one.

Two numbers this build cannot honestly report are zero rather than omitted.
`semantic_cache_hits` stays zero until a cache exists, because reporting a hit that cannot
happen would make the first real cache look like a regression. `structural_files` stays
zero until an analyzer registers — and `plan` writes a note saying the build is what has no
analyzer, because "0 covered, 48 unsupported" otherwise reads as a strange project. A unit
test asserts the registry is empty, so the first analyzer to land fails it and whoever adds
it is reminded to revisit the plan's counts.

`plan` exits 8 when the estimate would cross a configured limit. Planning succeeded; the
plan is still printed, because a caller needs to see the number that failed.

### The first analyzer, and what running it on real source found

The Rust analyzer is hand-written and takes no dependency, which is the decision recorded
above. It reads item structure and resolves nothing across files, which is exactly what
`DeterministicSyntactic` claims: a call is recorded as a reference to a *name*, never as an
edge to a function, because deciding which `parse` a bare `parse(` means needs imports,
generics, and trait resolution.

The lexer is where the correctness lives. A `/*` inside a line comment, a `}` inside a raw
string, an apostrophe in `'\''` — each silently moves a brace, and from there every item
lands in the wrong parent. A skim parser is allowed to be imprecise about meaning; it is
not allowed to be wrong about nesting, because nesting is the only thing it actually knows.

Four defects came out of running it over `nostdb-core` rather than over fixtures. Each is
now a named test, and each is a case a fixture suite written by the same person who wrote
the parser would not have contained:

- `call_site` consumed its path and the caller advanced again, so `Self { .. }` in a
  constructor skipped a brace and the body's depth count was wrong from then on;
- `skip_generics` ran after every path segment including in expression position, so
  `if float < -LIMIT {` read as generic arguments and the scan ate braces looking for a
  `>`. Rust requires a turbofish in expression position for the same reason, and the
  analyzer now draws the same distinction;
- `skip_to_comma` split at every comma, so a field typed `BTreeMap<&'a str, (FieldType,
  bool)>` ended the field list at its closing paren and took the rest of the file with it.
  The test that should have caught this passed by luck: splitting `BTreeMap<String,
  Vec<u8>>` still left the next field recognizable;
- a mid-path turbofish ended the path, dropping the qualifier from
  `Vec::<u8>::with_capacity`.

Cross-checked against an independent line scan: 1442 items across 43 files where a crude
scan finds 1463. The difference is `macro_rules!` bodies and `fn` inside test string
literals, both of which the analyzer refuses to treat as items on purpose. 123 MB/s in
release, digesting included.

### The pipeline joined up

`plan` now reads the Engine's registry rather than an empty one, and the guard test
asserting the registry was empty failed — which is what it was for. Over a real tree, 46
Rust files move from unsupported to `deterministic syntactic`, semantic candidates fall
from 48 to 2, and the estimate falls from 189k–549k tokens to 2k–5k. That is the "structural
analysis of supported source spends zero AI tokens" invariant showing up as a number rather
than as a claim.

### `build`, and what a real project found that fixtures did not

`nostdb build` analyzes a project's source and commits it. `GraphChangeSet` already
described what a producer proposes and nothing carried it out, so `apply` was written
first: it is the only place ownership is enforced against real records. A removal drops one
`(owner, source unit)` pair and leaves every other contribution alone, so an analyzer
refresh cannot delete what a person wrote about the same record.

A path locates a record; it does not identify one. A rebuild finds the `File` record whose
`path` matches, takes the source unit persisted on its contribution, and reuses the
identifiers stored under it. Moving a function down a file keeps its identifier; renaming it
retires the old record and mints a new one, which is correct rather than convenient — a
renamed function is not the same function to anything that referred to it by name.

An unresolved call is counted, never invented. Not creating the edge already satisfies "a
missing symbol must never produce a null endpoint", and at syntactic precision the analyzer
cannot tell a genuinely missing symbol from one in a dependency it was never given. This
crate has some nine thousand such call sites; manufacturing a Placeholder for each would
assert that the project declares them.

Three defects came out of building `nostdb-core` with it, and every one of them appeared
only on the **second** build — the case a single-shot fixture cannot reach:

- 243 duplicate node identifiers. A qualified name is not unique within a file: Rust allows
  several inherent `impl` blocks for one type, and `execute.rs` has three for `Scoped`.
  Identity is now keyed by qualified name *and* occurrence, with the occurrence stored on the
  record rather than inferred from the order storage returns rows in;
- 566 duplicate edge identifiers, once edges were given stable identity. A function calling
  another three times produced three `CALLS` edges between one pair. A relation is a fact
  and not an occurrence, so it is one edge carrying a count — which is both the correct model
  and the only one a change set accepts;
- an unchanged rebuild reported `3335 created, 3335 deleted`. The delete-then-restate is how
  the ownership rule is expressed, but reporting it literally makes an untouched tree look
  like it rewrote the database. A record withdrawn and restated in one set is counted as an
  update, and an unchanged rebuild now reports zero created and zero deleted.

The pipeline runs end to end over this crate: 45 files, 3335 nodes, 4776 edges, 2052
references resolved. Appending one function and rebuilding reports `1 created, 3335
updated`, and a Cypher query finds it at the right line.

### Incremental rebuild, and the correctness question it raised

A file whose bytes match the digest already recorded is no longer re-read, which is what
section 17.8 asks for. `--rebuild` asks for the work to be redone anyway.

Reuse is only sound while the names an unchanged file could refer to have not moved. When a
re-read file adds or removes a declared name, an edge from a file this build never opened
may have become right or wrong, and at syntactic precision there is no way to know which —
so the build reads everything. That is the "affected context-resolution units" half of 17.8
taken conservatively rather than approximately.

Two things this exposed that had nothing to do with reuse. A file the source no longer holds
now takes its records with it: nothing else would ever remove them, because they belong to a
source unit no scan will name again. And a build that reuses everything commits no
generation — committing one anyway would make every run look like a change to whatever
watches the file.

Then the correctness question. An incremental build resolved names against only the files it
re-read, so a call into a file it skipped stopped resolving and its edge was dropped — and
the next full rebuild put it back. A graph that depends on how it was built rather than on
what the source says is the one thing a database of facts must never be.

It was spotted in the numbers rather than by a test: a comment-only edit to one file reported
33 edges deleted **and 33 created**, which is what dropping and re-minting cross-file calls
looks like. References now resolve against reused files as well, the created half is gone,
and a test that fails without the fix covers it.

### The observation, run down

It was a real bug, and the reproduction is exact. Build `nostdb-core`, edit one comment,
rebuild: 1275 `CALLS` edges where a full build of the same source produces 1308. A forced
rebuild immediately after — nothing else in between — creates exactly the 33 that were
missing. The loss is entirely in call resolution out of the one file that was re-read.

The cause is that per-file reuse resolved references against **two** indexes, one for the
files it re-read and one for the files it skipped, and the two together do not answer the
same question a single index does. Adding the second index fixed the visible half of the
problem — cross-file calls stopped being dropped and re-minted — and left this half. Why is
still not understood.

So the finer rule is gone. If anything was re-read, everything is. A graph that depends on
how it was built is worse than one that took longer to build, and that is the whole reason
this was being chased in the first place; keeping a faster path that is known to be wrong
would have been choosing the speed over the property.

What survives is the case that matters most and is provably safe: a tree where every file
matches its recorded digest is not read at all and commits no generation. On this crate that
is the difference between 0.27s and 0.20s, and after any edit the build is a full one again.

Two tests now compare an incrementally built graph with a freshly built one record for
record, with identifiers dropped so they compare what the graphs assert rather than which
objects they are. They are what a return to per-file reuse has to pass.

### The cache keys

Section 17.7's three keys are in, and the rule that governs all of them is what shaped
them: the Engine's version must not invalidate every cache, because a cache is invalidated
only by the component contract that affects its result. That is why they are three types
rather than one key carrying a version. Tests assert both halves — every part of a key moves
it, and a new analyzer leaves the semantic keys alone while a new model leaves the parses
alone.

Two details that would otherwise be silent corruption. Each part is length-prefixed before
digesting, so two keys whose parts differ only in where one ended cannot name one entry; and
each digest is tagged with its kind, so a parse and a resolution built from the same strings
cannot collide.

Project tier before user tier, which the contract fixes and which matters: a project may
hold an artifact produced under settings that differ from the user's default, and reading
the user's copy first would serve the wrong one. Omitting the user tier is how a project
disables it.

`prepare_cache` writes a `.gitignore` into the cache directory, because `.nostdb` as a
whole is not excluded — the database inside it is meant to be shared. Writing the file is
what makes "neither cache is committed by default" true rather than advisory.

### The parse cache, and what it recovers

The store is in, and it gives back the incremental win that making reuse all-or-nothing gave
up — without touching the thing that broke. A cached parse **still enters the build**, so the
index references resolve against is complete and resolution is unaffected. What is saved is
the reading and the parsing, not the resolving.

On this crate, editing one file: 46 files enter the build, 45 parses come from cache. A
forced rebuild immediately after reports zero created and zero deleted, so the incremental
graph is the graph a full build produces.

The artifact format is **not** a specification contract, and deciding that was the question.
A cache entry is written and read by the Engine alone, and its key already carries
`graph_schema_version` — so an artifact written under an older shape can never be *found* by
a newer key. There is no migration to write and no reader that has to understand two
layouts: the entry misses and the work is redone. A version field remains for the case where
a build changes the shape without bumping the constant.

Reuse is now decided up front from digests alone rather than discovered mid-pass and
recursed on. The recursion re-ran pass one and found what the outer pass had just stored, so
a rebuild after editing one of two files reported *both* parses as cache hits — a number
that was true and told the reader the wrong thing.

Three smaller decisions, each with a test:

- an artifact is stored **before** the build commits. A parse depends on the bytes and the
  analyzer, not on whether the transaction that follows succeeds, so an abandoned build
  still leaves work its successor can use;
- writes go to the project tier and reads to both. A shared user cache written to by every
  project is a trust surface the contract has not designed — one project's build placing
  artifacts another project's build reads — and 17.7 says as much about a team cache one
  step further out;
- a corrupt entry is a miss and is deleted. A cache is derived data, and a build that
  refused to run because an entry was truncated would be choosing the cache over the thing
  it exists to speed up.

And one reporting fix: a build that reused everything said `structural skipped`, which is
the opposite of what happened. Everything is covered; it was covered earlier and nothing has
changed since.

### Amending a published contract, for the first time this Stage

Section 17.7 says the user cache "can be disabled per project" and `settings_version` 1 had
no field for it. `cache.user` is that field, defaulting to true, and adding it is the first
change this Stage has made to a published contract.

**No version bump**, and the reason is the contract's own rule: an unknown field inside a
supported version is preserved on write and otherwise ignored. An older build carries this
one through untouched and a newer build reading an older document takes the default. That
rule exists precisely so a compatible addition does not cost a version.

The project tier gets no field. A project that could not cache its own derived work would
have nothing to turn off — that tier lives inside the project and is discarded with it. The
user tier is shared across every project the same operating-system user builds, which is the
thing a project might have reason not to read from.

The document says outright that `user: false` is **not** a privacy guarantee about the other
direction. Nothing in it constrains what an implementation writes, and reading the field as
though it did is the misunderstanding worth heading off in the text rather than in a later
issue.

Four fixtures: one accepting the field, one rejecting a string where a boolean belongs, one
merge proving a project's `false` overrides a global's `true` by defined field, and the
existing merge results gain the section.

On the Engine side the user directory is now derived from the global settings path already
supplied to `Project::open` — that file lives in the user's `.nostdb`, which is also where
their cache tier is. Asking a caller for the same directory twice would be two places to get
it wrong.

### `apply`, and the contract it needed

`change_set_version` 1 is authored, which unblocked the last command this increment scoped
that was not waiting on another Stage. The document says two things before it says anything
else, and both were the reason to write it rather than infer it from the in-memory type:

- **a change set is a proposal, not a transaction.** Satisfying every rule in the document
  does not make it apply. A producer must not be able to widen its own authority by writing
  a well-formed file, so everything a database would decide stays outside the document
  rules;
- **one set carries one owner.** A refresh replaces only its own producer's contributions,
  so two owners in one document would mean two replacement scopes in one transaction, and a
  failure partway through would leave a state neither producer asked for.

The decoder delegates every batch rule — an empty set, a repeated identifier, two link
operations in conflict — to the in-memory validator rather than restating it. Two
implementations of one rule is two answers waiting to diverge.

`apply` keeps two refusals apart, because they mean different things to whoever hits them. A
document that breaks the contract exits 3 and reports **every** problem at once, so a batch
is fixed in one pass rather than one failed run per mistake. A document that is well formed
and cannot be applied is the other kind, and an unreadable version says so without also
naming a malformed operation that is not there.

Twelve fixtures, and the rejection test checks the declared **code** rather than only the
refusal. The workspace verifier now runs the suite, which is what makes the published set a
gate rather than documentation.

### Not done, and what each needs

| Remaining | Needs |
| --- | --- |
| `link refresh` | the GitHub provider in Stage 9. A local link has no snapshot to advance |
| per-file reuse | understanding why resolving against a fresh index and a recorded one together loses edges that a single index finds. The graph-comparison tests are in place and are what a second attempt has to pass |
| AI enrichment | the analysis packet in 17.5 and a provider. `plan` already produces the budget check it has to pass |

Every command this increment scoped is now implemented except `link refresh`, which needs
the GitHub provider that arrives in Stage 9: a local link is read live and has no snapshot
to advance. What remains inside
`build` is optimization and enrichment rather than correctness: it produces a correct
database today, and re-reads files it could skip.

## Stage 8 verification

Passed on 2026-07-28 in `nostdb-spec` at `2ac0f68`, `nostdb-core` at `7097a23`, `nostdb-cli` at
`b8e9900`, and `nostdb-server` at `8ab7850`.

`./scripts/verify-workspace.sh` exits 0 over all four pins. Child CI is green on all four
repositories, and the root's is green over the pinned set.

### PRD section 30.6, criterion by criterion

Each row names the evidence rather than asserting the criterion. Two are weaker than the rest and
say so.

| Criterion | Evidence |
| --- | --- |
| exactly one daemon per OS user | an advisory lock; a second acquisition reports already-held, and a released lock is reacquired without a process-id guess |
| current-user IPC access | the socket is 0600 inside a 0700 directory, narrowed even when inherited wide open |
| denial across user boundaries | **by construction, not by test.** See below |
| named database catalog recovery | a truncated file on disk is refused rather than read as far as it goes, and a replacing write leaves the previous catalog intact. Both added by this audit |
| concurrent sessions and transaction isolation | two connections are served at once, and one does not see the other's uncommitted write |
| timeouts and resource limits | a query past its timeout is stopped by the Engine; a result past its ceiling names the limit; an over-long frame is refused before a buffer is sized |
| no TCP or HTTP listener in the MVP | enforced structurally by the child verifier, over both the source and the dependency list, proven to fire |

### The criterion that is argued rather than tested

"Denial across user boundaries" has no test, and it is worth being exact about what does and does
not exist.

What is proven: the endpoint's directory is mode 0700 and the socket is 0600, tested directly, and
tested again after the directory was deliberately widened first so the test cannot pass by accident.

What is not proven: that a process belonging to a different operating-system user is actually
denied. That needs a second user, which neither a developer's machine nor a CI runner offers, and
the operating system rather than this code is what performs the denial.

So the mechanism is tested and the outcome is inferred from it. The inference is sound — a directory
another user cannot traverse holds a socket they cannot reach — but it is an inference, and a reader
deciding whether to trust this boundary should know that rather than find a row in a table saying
"denied".

The protocol contract's section 1.2 says the same thing from the other side: the endpoint's only
authentication is the operating system's, and there is deliberately no password to test.

### What Stage 8 produced that was not in its scope

Two contracts and one Engine capability.

`catalog_version` 1 and `server_protocol_version` 1 were both reserved keys with no document. The
second needed amending twice while implementing it — once to say a refusal states no negotiated
version, and once to say a connection carries one session — and both amendments came from the
implementation failing against the contract rather than from review.

`nostdb-core` gained cooperative cancellation, because section 7's query timeout could not otherwise
be honoured. Stage 10's AI token budget needs the same shape, and the CLI's REPL has wanted an
interruptible query since Stage 7.

### The defects this Stage found in its own checks

Five, and none of them were in the daemon:

| Defect | What it did |
| --- | --- |
| the version registry's two forms were compared by substring | `not yet specified` satisfied a test for `specified`, so a row stating the opposite of the registry passed |
| the diagnostic check assumed every code is the Engine's | Stage 8's codes belong to the daemon; the check had to learn owners, which Stages 9 and 11 will need too |
| the conformance loop assumed every contract is the Engine's | running the catalog suite from `nostdb-core` would have run nothing and reported success |
| the workspace verifier filtered for `verified` | it hid the lines a suite prints to say what it did **not** cover, which is the opposite of their purpose |
| the accept loop joined each connection before accepting the next | connections were served strictly in turn, and all twenty conversation tests passed because each used one connection |

The pattern is worth naming: every one was a check that passed while proving less than it claimed.
The daemon's own defects were caught by tests; these were caught by writing the next thing and
noticing the check should have complained.

### Deferred out of Stage 8

- the Windows named pipe. `endpoint::address()` returns `Unsupported` there rather than a wrong
  path. Section 2 names both platforms, so this is a gap against the contract and not a silent one;
- peer-credential checking, for the reason above: the directory mode already holds the boundary the
  operating system enforces;
- rendering a named database's result as anything but JSON, which needs the envelope readable back
  in `nostdb-core`;
- `catalog` operations through the daemon. They write the catalog directly, which the contract
  permits and which keeps them working before a daemon exists.

## Stage 8 increment 5: the command surface

Increment 5 is `DONE`. `catalog add|remove|list`, `server start|status|stop|run`, and
`--database @name` all work.

Verified on 2026-07-28 in `nostdb-cli` at `b8e9900`, with `nostdb-server` at `2ee27a0`,
`nostdb-core` at `7097a23`, and `nostdb-spec` at `2ac0f68`. 49 unit tests, 77 command tests, and 13
REPL tests; the child verifier exits 0.

### Three gaps that were one

`--database @name`, `server start`, and `server stop` were listed as three remaining items. They all
wanted a protocol client and nothing else, so writing it closed all three at once. Listing them
separately was right at the time and wrong in hindsight, which is worth recording: the previous
increment's estimate said three pieces of work where there was one.

### Recorded decision: `server start` spawns this binary

`nostdb server start` runs `this binary server run` rather than looking for `nostdb-server` on the
PATH. The daemon a caller starts then always matches the client that started it, and the command
works from a build directory where only one of the two binaries is on the PATH.

It waits for the endpoint to appear rather than assuming it did. A start that returned early would
have the very next command fail against a daemon that had not finished binding.

### A defect the round-trip test found in the design

`start_daemon` first used `std::env::current_exe()`. That is the `nostdb` binary when a person runs
it and the **test binary** under a test harness, so the test spawned itself, the harness read
`server run` as a test filter, and it exited 0. The failure read `the daemon exited immediately with
exit status: 0`.

The binary is now a parameter. The fix is better than the bug hid: a caller that knows which binary
to run says so, rather than the function guessing from its own process.

### The named route renders JSON only, and says so

The daemon forwards the Engine's envelope as JSON. `output::write` renders a `ResultEnvelope`, and
rebuilding one from JSON would be a second reader of a published shape, while rendering a table
straight from the JSON would be a second renderer of it. Both are the duplication the root contract
forbids and both would drift on the first change to the envelope.

So `--format json` passes through verbatim and every other format is refused by name. The real fix
is making the envelope readable back in `nostdb-core`, which nothing needs yet.

### The round trip declines rather than stopping a daemon it did not start

The end-to-end test binds this user's real endpoint and stops the daemon when it is done. Stopping
one it did not start would kill a daemon a developer is using, so it skips in that case. That is
what makes it safe to switch on in the child verifier, which keeps a local run and a CI run checking
the same invariants rather than leaving the headline feature covered only in CI.

### Recorded decision: the CLI depends on the daemon crate

`nostdb-cli/AGENTS.md` prohibits this repository from owning a named-database catalog or an IPC
transport, and permits it to own the daemon **client**. Those two rules together decide the
dependency: the client is in the CLI, and the catalog type and the protocol's framing and messages
are imported from `nostdb-server` rather than written again.

A second catalog writer or a second framing would be exactly the duplication the root contract
forbids, and the two would drift on the first change to either. The dependency is pinned to an exact
commit, as the Engine's is.

### Recorded decision: `catalog add` writes the catalog rather than asking the daemon

The catalog contract's section 5 requires a write to be a complete replacement moved into place and
says two processes may attempt one at once, with the last complete write winning. That makes a
direct write safe.

It is also the only design that keeps the command working with no daemon running, which matters more
than it first appears: registering a name is exactly what someone does **before** starting one. A
`catalog add` that required a daemon would be a chicken-and-egg problem in the first command a new
user runs.

### Two commands refused rather than stubbed

`server start` needs to spawn a detached process and wait for the endpoint to appear. `server stop`
needs a protocol client to send `shutdown`. Neither is written, so both are refused by name and
point at `server run`, which does work.

A stub that exited 0 would have been worse than the refusal: a caller would believe a daemon was
running and find out later, somewhere else.

### Not done, and what each needs

| Remaining | Needs |
| --- | --- |
| `--database @name` | a protocol client in the CLI: connect, handshake, open a session, send the query, render the envelope |
| `server start` | spawning the daemon detached, then waiting for the endpoint to appear rather than assuming it did |
| `server stop` | the same protocol client, to send `shutdown` |

All three want the same client, so they are one piece of work rather than three.

## Resolved conflict: section 7 requires a query timeout the Engine could not provide

Found while implementing the request loop, recorded before acting, and resolved by the owner on
2026-07-28. The resolution is at the end of this section.

### The conflict

`server_protocol_version` 1 section 7 requires an implementation to enforce and make configurable:

```text
a query timeout
```

`nostdb-core` exposes no deadline, budget, or cancellation hook. `execute` runs to completion, and
`Transaction::run` calls it. Grepping the Engine for `timeout`, `deadline`, `cancel`, and `budget`
finds nothing in `execute.rs`, `transaction.rs`, or `cypher.rs`.

So a timeout in the daemon could only be measured **after** a query had already finished, and
reporting one then would name a limit that stopped nothing. Section 7 also says a request stopped by
a limit must report which limit stopped it, which is a promise about a request that was stopped.

### Why the obvious workarounds are worse than the gap

- **run the query on a worker thread and abandon it on timeout.** The database is borrowed by the
  transaction, so the borrow cannot cross threads while the transaction lives, and abandoning a
  thread part way through a write leaves the transaction's own copy in a state nothing owns;
- **measure and report afterwards.** This is the dishonest option: the caller is told a ceiling
  stopped their query when the work had already been done and paid for;
- **poll a flag inside the Engine.** That is the real fix, and it is a `nostdb-core` change rather
  than a daemon one.

### What the daemon does instead

It enforces the limits it can, and claims only those:

| Section 7 limit | Status |
| --- | --- |
| a maximum frame size, at least 8 MiB | enforced, before any buffer is sized |
| a per-session result-size ceiling | enforced on the way out, and reported by name |
| a maximum number of concurrent sessions | one per connection, by construction |
| a query timeout | **not enforced.** Needs a cancellation hook in `nostdb-core` |

The result ceiling is honest about its own reach: it bounds what crosses the socket rather than what
was computed, because the Engine produces a whole result before returning it. The rustdoc on
`Limits` says so, rather than leaving a reader to assume a row cap is a work cap.

### The resolution: cancellation in the Engine

Chosen by the owner: add it to `nostdb-core` rather than approximate it in the daemon or defer the
requirement. It was the only option that satisfies what section 7 and PRD 30.6 already say.

`nostdb-core` `7097a23` adds `cancel`, with `ShouldStop` as a trait and `Never`, `Deadline`, and
`Flag` as answers to it. The Engine takes the *question* rather than one answer, because a
wall-clock deadline, a client disconnecting, and an AI token budget running out in Stage 10 are the
same question asked by different callers. Stage 10 gets the shape it needs for free.

Every existing entry point delegates with `Never`, so no caller changed behavior and `nostdb-cli`
needed no change at all.

**The granularity is published rather than implied.** Query subset contract section 11.1 requires an
implementation to observe a cancellation between the parts of a `UNION`, between the clauses of a
part, and between the input rows of a `MATCH`, and forbids claiming more:

> An implementation MUST NOT claim a granularity it does not have: a caller that is told a query
> can be stopped, and then waits through a pattern expansion that never checks, has been given a
> guarantee that does not hold in the case it most needed one.

A pattern expansion producing a large cartesian product from **one** input row still runs to
completion. That is stated in the contract, in `nostdb_core::cancel`, and in the daemon's `Limits`.

Two tests matter more than the rest. One proves the token is asked **more than once** per query:
checking only at the start would satisfy a naive test and stop nothing that had already begun. The
other drives a timeout through a whole conversation and checks the reply carries the Engine's own
`QUERY_CANCELLED` with a message naming the limit, and that the daemon adds no code of its own.

All four of section 7's limits are now enforced:

| Section 7 limit | Status |
| --- | --- |
| a maximum frame size, at least 8 MiB | enforced, before any buffer is sized |
| a query timeout | enforced through Engine cancellation, at the published granularity |
| a maximum number of concurrent sessions | one per connection, by construction |
| a per-session result-size ceiling | enforced on the way out, and reported by name |

Clippy found something real on the way. Threading the token pushed `run_part` past a readable
argument list, so the four values every clause reads and none changes are now grouped into a `Run`
struct rather than the lint being suppressed.

## Stage 8 increment 4: sessions and the request loop

Increment 4 is `DONE`. The session model, the request loop, and the query timeout all landed; the
timeout needed a `nostdb-core` change, recorded as a resolved conflict above.

Verified on 2026-07-28 in `nostdb-server` at `bd713f7` and `nostdb-spec` at `36b9821`, with
`nostdb-core` at `96011ce` and `nostdb-cli` at `36edb62`. 53 unit tests, 20 conversation tests, and
6 conformance tests in the daemon; both child verifiers and the workspace verifier exit 0.

### The request loop, and the region the Engine's borrow requires

`begin` enters a nested loop that reads the connection's messages until commit or rollback. Nothing
outside that scope can hold the transaction, so there is no state in which the daemon believes a
transaction is open and it is not. `nostdb-cli`'s REPL reached the same shape for the same reason,
and its record was right to call it a design rather than a workaround.

Inside the region a nested `begin` is refused, and so is closing the session or stopping the daemon:
each would decide the transaction's fate on the client's behalf.

A `commit` with no transaction is an `error` outcome and **not** a section 8 refusal. It is a
well-formed message in the wrong state, which the client can act on, and that is what separates the
two classes.

### A defect the concurrency test found, which nothing else would have

The accept loop was first written to spawn a thread per connection and then join it immediately.
That serves connections strictly in turn, which is the exact opposite of what section 6.1 promises
when it says concurrency comes from opening more connections — the restriction to one session per
connection is only defensible *because* more connections are served at once.

Every other test uses one connection at a time, so all twenty passed. The test that catches it holds
a transaction open on one connection and requires a second to be answered while it is held.

### Two things proven about a dropped connection

Section 6.2 says a client that disconnects mid-transaction has not decided to commit. The test drops
the connection with an uncommitted write outstanding, then reopens the database from disk and checks
the generation is still 1 — not merely that a later query sees no rows, which a caching bug could
also produce.

### Resolved: a connection carries one session

The question increment 3 recorded, answered by the owner: option 1. Section 6.1 now states that a
connection carries at most one session, with the reason and the cost.

`server_protocol_version` stays 1. Nothing has implemented the protocol yet, so this completes an
underspecified point rather than changing a published behavior. Section 6 had said a session is
the unit of isolation and left the count unstated, and the `session_id` in section 5.1 implied
several.

The restriction buys the transaction model. A transaction is a region during which the daemon is
committed to one session's view, so a second session's request arriving inside it must be queued —
unbounded buffering a client cannot see — or refused, a failure it cannot predict. Opening a
second connection is a better answer than either, and concurrency comes from there.

`session_id` stays on the wire rather than becoming redundant. It names the session `close_session`
ends, and it lets a request confirm which session it believes it is in instead of inheriting
whatever the connection currently holds.

A later version may lift this. Adding multiplexing would need `server_protocol_version` 2 rather
than a silent widening, which the contract says outright.

### The rule is enforced by construction

`Slot` holds either no session or one and has no representation for two, so a second
`open_session` cannot be honoured by a code path somebody forgot to guard. A twelfth refusal row
was added to section 8 with its fixture, because a rule with no fixture is prose.

### Two failures kept apart because their fixes differ

A name the catalog does not hold is `UnknownName`; a catalogued name whose target will not open is
`Storage`. The first is fixed with `catalog add` and the second by mounting a disk.

The second is exactly the case the catalog contract's section 1.3 keeps out of catalog validation,
so it has to surface at open instead. A single "could not open" would have told a caller to check
the wrong thing half the time.

### Not done, and what each needs

| Remaining | Needs |
| --- | --- |
| the Windows named pipe | an access control list for the user's security identifier. `address()` returns `Unsupported` there rather than a wrong path |
| peer-credential checking | nothing, unless the directory mode is judged insufficient. Section 1.2's guarantee is the operating system's, and the endpoint directory is 0700 |

Everything else this increment scoped is implemented. `run` now stays in the foreground and serves
until a client sends `shutdown`.

### A stale deferral corrected

The protocol conformance suite listed `unknown_session` as awaiting a session registry. That
registry now exists, so the reason had become false while the deferral stayed correct: the rule is
decided against a connection's state rather than a document, which is why a document-driven suite
still cannot check it. Both session rules now say that, and point at the tests that do prove them.

## Stage 8 increment 3 verification

Passed on 2026-07-28 in `nostdb-server` at `5d67829`, with `nostdb-spec` at
`bb7c5eb`, `nostdb-core` at `96011ce`, and `nostdb-cli` at `36edb62`.

45 unit tests and 6 conformance tests in the daemon. `./scripts/verify-workspace.sh` exits 0
over all four pins and reports the protocol suite:

```text
server conformance: 2 published replies verified
server conformance: 1 handshakes and 4 requests verified
server conformance: deferred, peer_is_another_user (held structurally by the endpoint's directory mode)
server conformance: deferred, unknown_session (needs a session registry, which arrives with sessions)
server conformance: 9 refusal rules verified
```

### Acceptance criteria

| Criterion | Evidence |
| --- | --- |
| framing | a 4-byte big-endian prefix, two frames on one connection, and a byte-order test so a change is a failure rather than a silent incompatibility |
| an over-long frame is refused before allocating | the length is compared to the maximum before any buffer is sized; the test supplies four bytes of prefix and no body |
| version negotiation | the highest common version, and a refusal naming the supported set |
| the published refusals | 9 of 11 rules verified against the fixtures by declared rule, not merely by refusing |
| a refusal carries a code only where the contract assigns one | proven in both directions: the version refusal carries it, the other ten carry none |
| the daemon's own replies match the published shapes | `welcome` and `refused` compared against the fixtures as whole documents |

### A refusal names its rule, so the fixtures can check it

Each refusal carries the section 8 row it came from. That is what makes the suite compare a
fixture's declared `rule` against what the decoder actually reported, rather than checking that
something was refused.

The difference matters: a decoder that reported every malformed message as one rule would satisfy
"it was refused" and tell a client nothing about what to fix. Two of the rules are about *where*
a message arrived rather than what it holds — a perfectly well-formed request is still refused as
the first message on a connection — so the suite names the entry point per rule instead of
inferring it from the document.

### Two rules this suite cannot decide, reported rather than skipped

`unknown_session` needs a session registry, and `peer_is_another_user` is held by the endpoint's
directory mode rather than by anything in a message. A document-driven suite cannot decide either.

The suite prints both with the reason, and **fails** on a fixture whose rule is in neither its
decidable table nor its deferred table, so a rule added to the contract cannot quietly go
unchecked.

### The root verifier was hiding exactly those lines

The deferral reporting did not reach the workspace verifier's output. That verifier surfaces a
child suite's lines by filtering for `verified`, and a line saying what a suite did **not** cover
does not contain that word.

So the discipline of reporting a partial cap was defeated by the filter meant to surface it: nine
of eleven rules would have been reported as nine `verified` lines with nothing saying two were
outstanding. The filter now surfaces `deferred` as well, which also revealed that the `.nost`
suite has been reporting a deferral of its own that nobody was seeing.

### The finding that blocks sessions: a transaction cannot outlive a lexical region

`Transaction<'a>` in the Engine holds `&'a mut Database`. A session that keeps a transaction open
across socket reads would therefore have to hold both the database and a transaction borrowing it
in one structure, which Rust does not allow without a self-referential construction — meaning
`unsafe` or a dependency, and an ADR under the root Rust standards for the first.

`nostdb-cli` already met this and solved it: its REPL nests a second loop that owns the
transaction and returns when it commits or rolls back. Its record calls that "not a workaround",
because it makes the transaction's extent a lexical region, so there is no state in which the
REPL believes it is in a transaction and is not.

The daemon can do the same thing — a session that begins a transaction enters an inner loop
reading that connection's messages until commit or rollback. That leaves one consequence to
decide, and it is a contract question rather than an implementation detail:

> While a connection is inside that inner loop it is serving one session. Section 6 does not say
> a connection carries one session, and the `session_id` in section 5.1 implies it may carry
> several. A transaction in one session would then stall every other session on the same
> connection.

Three ways out, none of them chosen yet:

1. **amend section 6 to one session per connection.** Simplest, and it matches the only client
   that exists: the CLI opens a connection, opens a session, and works in it. It makes
   `session_id` redundant on the wire, which is a published field to remove or to keep as
   confirmation;
2. **keep multiplexing and publish that a transaction serializes its connection.** Honest, and it
   makes a client's performance depend on something it cannot see;
3. **give the Engine a session type that owns its database**, so a transaction need not borrow
   one. The cleanest, and the only option that changes `nostdb-core` rather than the protocol.

Recorded before acting, as the root `AGENTS.md` requires. Increment 4 needs this answered first,
because all three change what the session code looks like.

## Stage 8 increment 2 verification

Passed on 2026-07-28 in `nostdb-server` at `17f4864`, with `nostdb-spec` at `bb7c5eb`,
`nostdb-core` at `96011ce`, and `nostdb-cli` at `36edb62`.

22 unit tests and 3 conformance tests in the daemon. `./scripts/verify-workspace.sh` exits 0
over all four pins, and two of its lines are new:

```text
diagnostic ownership: nostdb-server declares every code assigned to it
catalog conformance: 4 accepted fixtures verified
catalog conformance: 11 rejected fixtures verified
catalog conformance: 4 round trips verified
```

The first line is the one increment 1 predicted: the ownership check has turned from a deferral
into a comparison, because the crate it was waiting for now exists.

### Acceptance criteria

| Criterion | Evidence |
| --- | --- |
| catalog persistence | parse, load, store, insert, remove, and a complete-replacement write moved into place |
| the one-instance lock | `File::try_lock`; a second acquisition reports already-held, and a released lock is reacquired |
| a stale lock is reclaimed | the operating system releases an advisory lock when its holder dies; the test drops a guard and reacquires |
| the OS-user boundary | the socket is mode 0600 inside a directory narrowed to 0700, narrowed even when inherited wide |
| the catalog contract is a gate, not prose | the daemon reproduces all 15 published fixtures, against the declared code rather than merely refusing |
| no TCP, UDP, or HTTP listener | enforced structurally by the child verifier, proven to fire |

### The lock needed neither a dependency nor `unsafe`

`std::fs::File::try_lock` has been stable since Rust 1.89. An advisory lock is released by the
operating system when its holder dies, however it died, and that **is** the stale-lock reclaim
section 2.1 requires rather than an approximation of it.

So nothing in the daemon reads a process id or probes the socket. Both were ruled out by that
section, and a recorded process id is wrong the moment the id is reused. A leftover lock file
whose owner is gone is simply not locked, so acquiring it succeeds.

The alternatives were a third-party crate wrapping `flock` or `unsafe` calls into libc, and the
second would have required an ADR under the root Rust standards. This crate therefore declares
`rust-version = "1.89"` where its siblings declare 1.85, which is recorded in its manifest
beside the reason.

### An ordering that is the contract rather than a preference

The lock is acquired **before** the endpoint is bound.

The lock is what proves no other daemon is running, so replacing a leftover socket file is only
safe once it is held. Binding first and locking second would let two processes each unlink the
other's socket, and each conclude it was the daemon. The rustdoc on `bind` states the
requirement rather than leaving the order to look incidental.

### Three defects this increment found in its own checks

| Defect | What it did |
| --- | --- |
| the Engine-pin check triggered on any mention of `nostdb-core` | it failed on the manifest's own dependency review, which explains in prose why there is no Engine dependency yet. A check a comment can fail is one people learn to work around, so it now requires a dependency declaration |
| the root conformance loop assumed every contract belongs to the Engine | running `catalog_conformance` from `nostdb-core` would have run nothing and reported success. The loop now names the owning crate per suite, and reports a crate that does not exist yet rather than passing over it |
| the ownership check claimed more than it verifies | it said an owner *raises* every code assigned to it. Grep proves a code is **declared**; the owner's own tests are what cover reachability. The message now says declares |

### Deferred out of increment 2

- the protocol loop. Nothing accepts a connection and reads a frame yet, and `run` binds the
  endpoint and exits rather than looping, because a loop that accepted a connection and did
  nothing with it would look like a working daemon;
- `tracing`. There are no log records yet, because there is no long-running loop to produce
  them. The library writes nothing to stdout today and the child verifier now enforces that, so
  the boundary is held before the logging arrives to fill it;
- the Windows named pipe. `address()` returns `Unsupported` there rather than a wrong path.
  This is the increment's one honest gap against section 2, which names both platforms; the
  Unix side is complete and the pipe needs an access control list, not another abstraction;
- peer-credential checking. The directory mode already makes the endpoint unreachable by
  another user, which is what section 1.2 means by the operating system authenticating, so a
  `SO_PEERCRED` read would need `unsafe` or a dependency to restate a guarantee already held.

## Stage 8 increment 1 verification

Passed on 2026-07-28 in `nostdb-spec` at `bb7c5eb`, with `nostdb-core` at `96011ce`,
`nostdb-cli` at `36edb62`, and `nostdb-server` at `f05de0b`.

47 tests in the specification harness, and `./nostdb-spec/scripts/verify-repository.sh`
reports the two new suites:

```text
catalog conformance: accepted fixtures verified
catalog conformance: rejected fixtures verified
catalog conformance: 11 rejection rules verified
server conformance: accepted fixtures verified
server conformance: rejected fixtures verified
server conformance: 11 refusal rules verified
```

These two run in the `nostdb-spec` harness rather than in the root verifier's
cross-repository conformance loop, and that is where they belong. That loop runs
`nostdb-core` suites against the published fixtures, and neither of these contracts has a
Core implementation to run: the daemon owns both. Root CI runs each connected child's
verifier, so the suites are still a gate rather than documentation.

`./scripts/verify-workspace.sh` passes over all four pins and reports what the ownership
resolution was built to make visible:

```text
diagnostic ownership: nostdb-server awaits an implementation for CATALOG_INVALID
CATALOG_VERSION_UNSUPPORTED SERVER_ALREADY_RUNNING SERVER_PROTOCOL_UNSUPPORTED
```

Increment 2 adds the daemon crate, at which point that line becomes a comparison against its
source instead of a deferral.

### Acceptance criteria

| Criterion | Evidence |
| --- | --- |
| `nostdb-server` connected and pinned | `f05de0b`, child CI green, recursive clone verified at the pin |
| `catalog_version` 1 published | `docs/CATALOG.md`, 15 fixtures, 11 rejection rules each with one |
| `server_protocol_version` 1 published | `docs/SERVER_PROTOCOL.md`, 19 fixtures, 11 refusal rules each with one |
| the two PRD section 28 server codes registered | owned by `nostdb-server`, and removed from the deferral list in the same change |
| no code registered without an owner the verifier can check | closed owner list, rejected by the `nostdb-spec` suite |

### Two rules that are deliberately the opposite of the settings contract

A catalog `path` MUST be absolute; a project settings `database` path MUST be relative. The
two documents answer to different things, and the contract says so where an implementer will
look: a project document is committed and shared, so it must not carry one machine's layout,
while a catalog is per user and resolved from whatever working directory the caller was in, so
a relative path in one has no anchor.

A catalog also has no merge. Settings merge a global document under a project one; a name means
one thing per machine per user, so there is no second document to merge.

### A stale entry is not a malformed catalog

An entry whose target is absent, unreadable, or not a database stays in the catalog, and the
failure is reported against the operation that used it. Refusing the document instead would
mean one unplugged disk takes every named database on the machine with it. The contract states
this before the shape, because it is the rule most likely to be implemented the other way by
someone validating a document member by member.

### The protocol carries a result envelope and defines none

`result` in a query response is a `result_version` envelope, verbatim. The contract states no
field of it. The daemon calls the Engine, receives the envelope the Engine built, and forwards
it, so there is one implementation of a published shape rather than two that drift on the
first change to either.

The same rule covers diagnostics: the daemon MUST NOT translate an Engine code into one of its
own, and MUST NOT add a code for a failure the Engine already named. That is why only two of
the eleven refusals in section 8 carry a code at all.

### What the conformance suite found rather than confirmed

The suite failed on the refusal fixture. A `refused` message states no
`server_protocol_version`, and the rule as first written required every message after the
handshake to carry one.

The fixture was right and the rule was incomplete: a refusal is the one message sent when the
two sides have just established that they share no version, so there is no negotiated version
to name, and stating one would be a claim about a language neither agreed to speak. Section 4
now says this, and the test encodes the exception with the reason instead of letting a missing
version pass everywhere.

`hello` and `refused` are therefore both exceptions, for different reasons: one cannot know a
version yet, the other has established there is none.

### Deferred out of increment 1

- `SERVER_ALREADY_RUNNING` has no fixture, and the suite records why: it is a lifecycle
  outcome reported when a start request finds a healthy daemon, which is a running process
  rather than a document. Section 2.1 states it and increment 2 proves it with a lifecycle
  test;
- framing, endpoint permissions, the one-daemon lock, and session isolation are behavioral and
  are not expressible as a JSON document. Section 10 says so outright rather than leaving a
  reader to assume the fixtures cover them;
- `credentials_version` stays deferred. The protocol has no credential to define, because the
  operating system authenticates and section 1.2 forbids adding one.

## Stage 7 increment 4 verification

Passed on 2026-07-27 in `nostdb-spec` at `89fcd66`, `nostdb-core` at `96011ce`, and `nostdb-cli` at
`36edb62`.

Rust command set clean in all three children: 683 tests in the Engine, 124 across the
command surface, and 37 in the specification harness. `./scripts/verify-workspace.sh`
passes over all three pins and now runs six conformance suites, the last of them added by this
increment:

```text
change set conformance: 3 accepted fixtures verified
change set conformance: 9 rejected fixtures verified
```

### Acceptance criteria

| Criterion | Evidence |
| --- | --- |
| link resolution and recursive federation in Core | `federation::resolve`, cycle detection by canonical locator, depth and database limits |
| `link list` and `link check` | `list` reports and `check` judges; an orphan settings entry changes neither class |
| `link add` and `link remove` | four files move together through the multi-file journal, or none do |
| `sync` | the four-state machine, refusing rather than guessing where it cannot tell |
| `plan` | the `BuildPlan` shape section 17.6 publishes, and a budget check that compares the top of the estimate |
| `build` | scanner, hand-written Git-ignore matcher, Rust structural analyzer, change set, and commit |
| `apply` | `change_set_version` 1, twelve fixtures, and a conformance suite the workspace verifier runs |
| `link refresh` | **not implemented.** Amended out of scope above, with the reason |

### What this Stage produced that was not in its scope

Three contracts were authored to get here — the result envelope, the settings `cache`
section, and `change_set_version` — and the last two were the first amendments this project
has made to a published specification. The settings addition needed no version bump, which
is the preservation rule in that contract doing exactly what it was written for.

Three defect classes came out of running the code on this repository rather than on
fixtures, and every one of them appeared only on a **second** run: duplicate identifiers
from a qualified name that is not unique in a file, duplicate edges from a relation counted
per occurrence, and an incremental build resolving against two indexes where a full build
uses one. A fixture suite written by whoever wrote the parser would not have contained any
of them.

## Stage 7 increment 3 verification

Passed on 2026-07-27 in `nostdb-spec` at `668b871`, `nostdb-core` at `32fb7dd`, and
`nostdb-cli` at `db54107`.

Rust command set clean in all three children: 434 unit tests plus 25 conformance and
storage tests in the Engine, 35 in the specification harness, and 70 across the command
surface. `./scripts/verify-workspace.sh` passes over all three pins and reports 22
further fixtures:

```text
result conformance: 4 produced envelopes verified
result conformance: a produced query envelope verified
result conformance: 8 published envelopes verified
```

### Acceptance criteria

| Criterion | Met by |
| --- | --- |
| The result envelope is published with fixtures | 8 accepted, 14 rejected, each rejection naming the rule it breaks |
| The Engine's envelopes satisfy it | proven against hand-built shapes, a real query's output, and every published accepted fixture |
| `query` runs in immediate mode | one statement, one transaction, committed when it changed anything |
| The REPL is multiline with transaction controls | 13 sessions covering `:help`, `:begin`, `:commit`, `:rollback`, `:database`, `:quit` |
| Four output formats exist | table, JSON, JSONL, CSV, each a rendering of the one envelope |
| Data and diagnostics stay separate | every test asserts the exit class and both streams together |

### Recorded decision: the envelope is built once, in the Engine

Four formats render it, and all four live in the command surface. Building the shape
there would put the published contract in four places, and a fifth consumer, the daemon,
would make it five. `ResultEnvelope` is therefore a Core type and each format is a
rendering of it.

### Recorded decision: a read reports no write summary

`writes` is supplied by the caller rather than read off the result, because only the
caller knows whether the query was permitted to write. A read reporting eight zeroes
would say "changed nothing" where the truth is "could not change anything", and a caller
deciding whether to commit needs those apart.

### Recorded decision: the REPL's transaction is a lexical region

A `Transaction` borrows its `Database`, so the REPL cannot hold one across iterations of
a loop that also owns the database. `:begin` enters a second loop that owns the
transaction and returns when it closes.

That shape was chosen rather than worked around. It makes the transaction's extent
lexical, so no state exists in which the REPL believes it is in a transaction and is not,
and every exit from that loop must decide what happens to the open work. Three exits do,
and all three roll back: `:rollback`, `:quit`, and end of input. Committing work its
author never confirmed is the worse guess, and each has a test proving the write did not
survive.

### The same gap, a third time, and what now catches it

`LINK_UNAVAILABLE`, `LINK_CYCLE`, and `LINK_LIMIT_EXCEEDED` are required by `docs/PRD.md`
section 28 and were never registered. That is the third instance: `LINKED_DATABASE_READ_ONLY`
was found in Stage 6 and `ORPHAN_LINK_SETTINGS` in increment 2. Each was required from the
first revision of the PRD, each went unregistered until a contract happened to need it,
and nothing detected any of them.

`scripts/verify-workspace.sh` now checks that every code section 28 requires is either
registered in `nostdb-spec` or named in an explicit deferral list, and that a code which
became registered has left that list. Both directions were proven to reject rather than
assumed. Eleven codes remain deferred, each waiting on the provider, plugin, server, or
analysis contract that will own it.

A code is still registered by the contract that first names it, which is why the three
link codes are owned by `result_version`: that document defines `partial`, and `partial`
is meaningless without saying which warnings set it. The deferral was legitimate; what
was missing was making it visible.

### Two defects the suites found in themselves

The specification's envelope checker used `?` throughout. In a function returning
`Option<String>`, `?` on a missing member returns `None`, and `None` means "no
violation" — so a malformed envelope read as a valid one and the fixture for a missing
version passed while proving nothing. A conformance suite had grown exactly the failure
mode it exists to prevent, and only a fixture declaring `reject` and then passing
revealed it.

A comment in the Engine claimed a float was "placed by hand" because `serde_json` drops a
trailing `.0`. It does not, and the code did nothing special. The test asserted
`as_f64() == 20.0`, which would have passed while `20` was written; it now asserts the
rendered text, which is the distinction the contract actually asks for.

### Deferred out of increment 3

- `linked_databases_opened` is always zero and `partial` is always false, because no link
  is resolved yet. The fields are in the envelope and the three codes that set `partial`
  are registered, so increment 4 fills them in rather than changing the shape;
- parameters. `Parameters` is passed empty: the query subset declares them, and a CLI flag
  for them needs a form this increment did not settle.

## Stage 7 increment 2 verification

Passed on 2026-07-27 in `nostdb-spec` at `fa7fde1`, `nostdb-core` at `7411b97`, and
`nostdb-cli` at `9c6214d`.

Rust command set clean in all three children: 423 unit tests plus 22 conformance and
storage tests in the Engine, 31 in the specification harness, and 36 in the command
surface. `./scripts/verify-workspace.sh` passes over all three pins and now reports 27
further fixtures:

```text
settings conformance: 6 accepted fixtures verified
settings conformance: 4 merge fixtures verified
settings conformance: 17 rejected fixtures verified
```

### Acceptance criteria

| Criterion | Met by |
| --- | --- |
| The settings contract is published with fixtures an implementation can fail | 6 accepted, 17 rejected, 4 merge |
| `ORPHAN_LINK_SETTINGS` is registered | with `SETTINGS_INVALID` and `SETTINGS_VERSION_UNSUPPORTED` |
| The Engine reproduces every declared outcome | all 27, read from the pinned commit set |
| `help`, `init`, `check`, `convert`, `export`, `--version` exist | 36 tests across the surface |
| The exit classes match section 20.4 | asserted number by number, with class 1 left unassigned |
| Machine-readable output carries no commentary | every test asserts the class and both streams together |
| A failed command preserves what it did not change | a refused conversion leaves the target byte-identical and removes its staging file |
| The CLI implements no database behavior | every command calls a public Core API; the verifier rejects a listener, a grammar copy, and a fixture copy |

### Recorded decision: the Engine dependency is a pinned git commit

`docs/REPOSITORIES.md` requires each child to build independently and forbids depending
on uncommitted sibling state. Those two rules together leave one option.

| Option | Why it fails |
| --- | --- |
| path dependency on `../nostdb-core` | breaks a standalone clone and child CI, which check out `nostdb-cli` alone |
| vendoring Core | a second copy of the Engine, which every ownership boundary forbids |
| publishing Core to a registry | `nostdb-core` is `publish = false`, and SSPL-1.0 is source-available |
| git dependency pinned to an exact commit | taken |

`nostdb-cli/scripts/verify-repository.sh` enforces it, and all four refusals were proven
rather than assumed: a path dependency, a `branch`, a `tag`, and a short commit hash are
each rejected with `must be pinned to an exact 40-character commit over https`.

Raising the pin is therefore a deliberate act rather than a drift.

### Recorded decision: settings and project discovery live in the Engine

Both the command surface and the daemon read settings and answer "which project is
this?", and they must answer identically. The root contract's rule is that shared
behavior calls a public `nostdb-core` API rather than being implemented twice, so
`SettingsDocument`, `Settings`, and `Project` are Core types.

The alternative, treating either as command-surface configuration, would put the merge
rule and the discovery rule in two repositories and let them drift the first time one is
changed.

### Recorded decision: no argument-parsing crate

The command surface is small and its exit classes are normative, so the parser is written
by hand. That keeps the mapping from a malformed invocation to exit class 2 explicit
rather than delegated to a crate's own idea of what a usage error is, and it keeps the
dependency list at one entry.

### Recorded decision: `run` returns rather than exits

`run` writes through `&mut dyn Write` and returns an `ExitClass`; `main` is the only place
that touches the process streams or the process status. A test can then drive the whole
surface in-process and assert the class and both streams together.

Asserting both streams is the point rather than a convenience. A command that reports the
right class while printing a diagnostic to stdout has still broken the rule that
machine-readable output carries no commentary, and only checking both catches it.

### Two classifications worth stating

Exit class 1 is left unassigned. A shell reports 1 for a great many things a process did
not choose, including an uncaught panic, so leaving it free keeps "the command reported a
failure it understands" distinguishable from "something went wrong before it could say
so".

An external endpoint in a conversion is exit class 5, unavailable, not class 3. The
document is well formed and the build is incomplete; calling it a validation error would
blame the file for a capability that has not landed.

### Deferred out of increment 2

- `export --nost` writes the file and does not set `database.nost`. Changing a setting
  needs a settings *writer*, and the multi-file journal the settings contract requires for
  reconciling a link entry is not built. Until then the command reports a warning when the
  setting is false, which is honest about the file not being maintained;
- conversion to an existing target replaces it atomically but detects no synchronization
  conflict. Conflict detection needs a baseline, which is increment 4;
- `plan`, `build`, `apply`, `sync`, `query`, `link`, `catalog`, `server`, `plugin`, and
  `view`, each owned by a later increment or Stage.

## Superseded: the increment 2 blocker

The contract half was done before the command half, which was blocked on an
authorization, not on a decision. The blocker is kept here because the reasoning that
produced the dependency design is the same reasoning recorded above.

### Done: `settings_version`

`nostdb-spec` at `fa7fde1` publishes `docs/SETTINGS.md` with 27 fixtures, and
`nostdb-core` at `755672a` implements it. All 27 reproduce their declared outcome: 6
accepted, 17 refused with the code they name, and 4 merges producing the declared
effective document exactly.

`ORPHAN_LINK_SETTINGS` is now registered. `docs/PRD.md` section 28 required it from the
start and the registry never carried it, which is the same class of gap the query subset
had with `LINKED_DATABASE_READ_ONLY`. Nothing detected it either time until the contract
that owns the code was authored.

### Recorded decision: settings live in the Engine

Both the command surface and the daemon read settings and must agree on what a document
means. The root contract's rule is that shared behavior calls a public `nostdb-core` API
rather than being implemented twice, so `SettingsDocument` and `Settings` are Core types
and `nostdb-cli` will call them.

The alternative, treating settings as command-surface configuration, would put the merge
rule in two repositories and let them drift the first time one is changed.

### Recorded decision: parsing keeps every field optional

The merge is by defined field, so the parsed form must distinguish "absent" from "set to
the default". A reader that applied defaults first cannot, and the merge collapses into
last-writer-wins.

An analysis budget goes one further and is a nested option, because `null` is a *defined*
value meaning unlimited: a project writing it must override a global limit, and a project
omitting the field must inherit one. Both have a test.

### Blocked: the command surface

`nostdb-cli` still holds scaffolding only, and increment 1 deliberately left "how the CLI
depends on the Engine" to be decided here rather than guessed at. The decision is forced
by two rules already in `docs/REPOSITORIES.md`: each child must build and test
independently, and none may depend on uncommitted sibling state.

| Option | Why it fails |
| --- | --- |
| path dependency on `../nostdb-core` | breaks a standalone clone and child CI, which check out `nostdb-cli` alone |
| vendoring Core | a second copy of the Engine, which every ownership boundary forbids |
| publishing Core to a registry | `nostdb-core` is `publish = false`, and SSPL-1.0 is source-available |
| git dependency pinned to an exact commit | correct, and blocked below |

A git dependency is the only option that satisfies both rules, and it requires the pinned
commit to exist on the remote. It does not:

```text
nostdb-spec  2 commits unpushed
nostdb-core  6 commits unpushed
```

Pushing needs explicit authorization, which the Stage 1 grant covered for creating and
connecting repositories and which is not assumed here. Until then the CLI crate cannot be
written against a resolvable dependency, so no part of it was written: a `Cargo.toml`
naming a commit that does not exist would be a placeholder, and this workspace does not
create placeholders.

Everything in increment 2 that does not need the CLI is done. What remains is `help`,
`init`, `check`, `convert`, `export`, and the exit classes, all of which sit on top of
Core APIs that now exist.

## Stage 7 increment 1 verification

Passed on 2026-07-27 in `nostdb-spec` at `83d0dbd` and `nostdb-core` at `b470820`.

Rust command set clean in both children: 396 unit tests plus 24 conformance and storage
tests in the Engine, and 28 tests in the specification harness.

`./scripts/verify-workspace.sh` passes over both new pins and reports:

```text
container conformance: 20 fixtures verified, 3 accepted and 17 rejected
nost conformance: 18 accepted fixtures verified
nost conformance: round trip verified, 11 comments preserved
nost conformance: 17 graph round trips verified, 1 deferred pending link resolution
nost conformance: 19 rejected fixtures verified
nost conformance: 18 semantic fixtures verified
cypher conformance: 10 semantic fixtures verified
cypher conformance: 19 unsupported fixtures verified
cypher conformance: 38 supported fixtures verified
```

### Acceptance criteria

| Criterion | Met by |
| --- | --- |
| The published language is version 2, and version 1 is refused rather than parsed | `NOST_VERSION_UNSUPPORTED`, with a fixture for `@nost 1` specifically |
| Every accepted fixture parses, validates without a diagnostic, and formats idempotently | 18 fixtures, 11 comments preserved |
| Every rejected fixture is refused with a range | 19 fixtures, each at its re-recorded reference position |
| Every semantic fixture raises exactly the code it declares | 18 fixtures, covering all five new codes |
| A `.nost` document converts to a graph and back without losing content | 17 fixtures; the eighteenth is refused for a stated reason, not skipped |
| A minted identifier is a UUID version 7 | asserted on the version nibble and the variant bits rather than on the text |
| Schemas persist | written to container section 5 and read back from a real file on disk |
| Ownership survives a round trip | an analyzer and a user contribution come back distinct, through a real `.nostdb` |
| No fixture is copied into `nostdb-core` | the suite is read from `NOSTDB_SPEC_FIXTURES`, and the verifier fails without the confirmation line |
| The Rust command set passes in both children | `cargo fmt --check`, `cargo check`, `cargo clippy -- -D warnings`, `cargo test`, all `--all-targets --all-features` |

### What the round trip actually guarantees

Graph content round-trips exactly. The text does not, on the first pass, and cannot: a
node's declaration name and the split between schema names and the reserved `labels`
property are both file-local rather than graph data, and the model stores neither.
Export regenerates the first from the record identifier and derives the second from
which labels a Schema declares.

Both are stable, so the second pass reproduces the first byte for byte. That fixed point
is the guarantee, and it is the one synchronization needs; requiring byte equality on the
first pass would be requiring the model to store something it deliberately does not.

Conversion also orders the graph canonically: schemas by name, records by identifier,
labels and keys by value, contributions by owner. Two things follow. The round trip is a
fixed point at the graph level, because re-importing whatever order the canonical writer
chose sorts back to the same one. And the same content written in any declaration order
commits to identical bytes, which is what the digest comparison in section 14 rests on.

Each of those four orderings was added because a fixture caught the round trip failing on
it. That is the suite working rather than four separate oversights, and it is worth
recording that none of them was found by reading the code.

### Deferred out of increment 1, with the reason

An aliased or locator endpoint names a declaration *inside a linked source*, and turning
that name into a `ScopedNodeId` means opening that source. Link resolution is increment
4, so importing one is refused with a typed error naming what it needs.

The alternative was degrading it into a local Placeholder Node, which would export as a
local endpoint and quietly turn `shared::authorize` into something else. Refusing is the
same discipline the query subset applies: a construct outside what this build implements
is reported rather than approximated.

Export handles an external reference fine, because a `ScopedNodeId` already carries the
identifier a locator needs. The asymmetry is real, and the conformance test counts the
deferred fixture rather than passing over it.

### A defect the idempotence test caught

A trailing comment after the last property moved down one line on every format pass.
Looking for the separating comma skips trivia, and skipping trivia files every comment as
a *leading* one, so a same-line comment was handed to the next entry instead of the one it
followed.

Every individual output was valid and readable. Only comparing two passes showed it
drifting, which is exactly what that test exists for.

### A stale list the Schema work uncovered

`name::RESERVED_WORDS` still held the version 1 set, so `PropertyKey::new("id")` failed.
Since `id` is how a record states its identifier in version 2, conversion would have been
unable to build the key for its own reserved property. Nothing else referenced the list,
so nothing else noticed.

### Still open

`docs/PRD.md` section 11.2 said an analyzer-owned entity is matched through "a versioned
analyzer namespace, Stable Module ID, and semantic symbol key". Removing `StableModuleId`
deleted the middle term, and the amended section names the remaining two. Incremental
rebuild is what needs a replacement, and that is Stage 10, so nothing is invented here.

## Reversed decision: identifier minting

Stage 6 increment 3 decided that identifiers are derived from the generation being written
and a counter within the transaction, with no entropy source. The owner replaced that on
2026-07-27: a minted identifier is a UUID version 7.

This is recorded as a reversal rather than an addition because `nostdb-core/src/id.rs`
carries a `# Why not randomness` rustdoc section arguing the opposite, and
`transaction.rs::identifiers_a_write_mints_are_reproducible_across_two_identical_databases`
asserts it. The rustdoc is rewritten and the test is removed.

### One of the original arguments was overstated

The Stage 6 record claimed determinism is "what lets synchronization compare content digests
rather than wall-clock time". Rereading section 14 against the implementation, that is not
so. Synchronization compares one file against its own recorded baseline: a generation it
stored and a digest of the bytes on disk. It never compares two independently produced
databases, so it does not need them to agree.

What the change actually costs is the reproducible-build property, that the same source
rebuilt yields the same bytes. `docs/PRD.md` never asked for it. Correcting the earlier
overstatement matters here, because leaving it standing would make this reversal look like it
sacrificed synchronization, which it does not.

### What the change costs and what it buys

A minted identifier now needs a wall clock and a cryptographic random source, neither of
which `nostdb-core` used before. The default minter is UUID version 7 and a deterministic
minter is kept for tests, which is what the owner's word "default" asked for: without it no
test could assert an exact identifier.

`SourceUnitId::QUERY` is `[0; 16]`, which is exactly the nil UUID. A version 7 value always
carries 7 in its version nibble, so a minted identifier can never collide with the sentinel.
That was luck rather than design, and it is recorded so nobody later "fixes" the constant.

In exchange the identifiers are time-ordered and globally unique. Global uniqueness is not
required, since `docs/PRD.md` section 11.2 identifies a record across databases by the pair
of canonical locator and local identifier, but it costs nothing and removes a class of
mistake when identifiers are copied between files by hand.

## Stage 6 increment 3 acceptance criteria

- Every clause the query subset contract declares is accepted and executed, with the single
  capability-gated procedure refused as the contract requires.
- Aggregation groups by the non-aggregate items, and an aggregate with no grouping key
  answers over no input rather than answering nothing.
- A write is user-owned and preserves every other contribution on the record.
- A created record satisfies the model's rules or the query is refused; nothing invalid is
  stored.
- A transaction reports a conflict rather than rebasing when the database advanced, a
  rollback leaves the file byte-identical, and a read-only transaction does not advance the
  generation.
- Identifiers are minted without an entropy source, and the same write against the same
  database produces the same bytes.
- Every published fixture reproduces its declared outcome, and no fixture is copied into
  `nostdb-core`.
- The Rust command set passes in both children, and the root verifier passes over both new
  pins.

### Increment 1 scope

- a query subset contract in `nostdb-spec`, defining exactly what is accepted, what is
  refused, and the two diagnostic codes the root PRD requires;
- registration of `CYPHER_UNSUPPORTED` and `CYPHER_SEMANTIC_ERROR`;
- Cypher conformance fixtures, accepted and refused;
- a Cypher lexer and parser in `nostdb-core` covering the read subset, refusing
  everything outside it with `CYPHER_UNSUPPORTED` and a source range.

### Why the contract comes first again

Stage 5 increment 3 established the pattern: the Engine implements a published contract
rather than inventing vocabulary. `CYPHER_UNSUPPORTED` and `CYPHER_SEMANTIC_ERROR` are
required by the root PRD section 28 but were never registered, so registering them and
defining the subset is a prerequisite rather than a parallel task.

This adds a third specified contract to `nostdb-spec`. A deliberate tripwire test written
in Stage 2 asserts exactly which contracts are specified, so adding one requires updating
that expectation, which is the point: a new contract cannot appear unnoticed.

## Stage 6 increment 2 verification

Passed on 2026-07-26 in `nostdb-core` at commit `490ee3a`. Rust command set clean, with
232 unit tests plus 15 conformance and storage tests.

Queries now run: pattern matching, bounded variable-length traversal, predicates,
projection, `DISTINCT`, `ORDER BY`, `SKIP`, `LIMIT`, `UNWIND`, and `UNION`.

### Undefined order is tested as a set, not a sequence

The contract promises a row *set* when a query has no `ORDER BY`. The test asserts exactly
that, comparing sets across runs rather than sequences, so it cannot accidentally lock in
an incidental order and turn an unspecified behavior into a de facto guarantee.

A total order across value kinds is imposed for `ORDER BY`, because Cypher leaves
cross-type comparison loose and an ordered query over a mixed column would otherwise not
be reproducible.

### Three defects found, two of them semantics rather than slips

`WITH ... WHERE` was evaluated before projection, so a predicate naming the alias the
projection introduced saw it as unbound. Projection now happens first, and the scope for
both the predicate and the sort keys is the incoming bindings plus the new column names,
which also keeps `ORDER BY n.age` working next to `ORDER BY alias`.

A failed `OPTIONAL MATCH` kept its row but left the pattern's variables absent, so a later
`x.name` raised an unbound variable error instead of yielding null. Every variable the
pattern would have introduced is now bound to null.

`LIMIT -1` failed as a syntax error, because the expression parser had no unary minus.
Adding it means the query now reports the more useful complaint: the value must not be
negative.

### Null is not truthy, deliberately

Only `true` passes a predicate. A comparison against null evaluates to null, so a row with
a missing property simply does not pass, and an unmatched optional row cannot slip through
a filter. Arithmetic overflow and division by zero yield null rather than panicking.

### Recorded divergence: aggregation

Aggregate functions are refused with `CYPHER_UNSUPPORTED` and a message saying this build
does not evaluate them. Grouping semantics are the part of aggregation that is easy to get
subtly wrong, and a wrong grouping returns a plausible number rather than an error, which
is the failure mode the whole subset discipline exists to avoid. Increment 3 closes it.

### The result envelope stays out of Core for now

`QueryResult` is an in-memory type. The machine-readable envelope with `result_version`,
summary counts, and structured warnings is a serialization contract, and `result_version`
is still deferred in `nostdb-spec`. It belongs with the CLI output formats in Stage 7
rather than being invented here.

## Stage 6 increment 1 verification

Passed on 2026-07-26 in `nostdb-spec` at `001ef00` and `nostdb-core` at `f89f47b`.

Rust command set clean in both children: 211 unit tests plus 12 conformance and storage
tests in the Engine, and 20 tests in the specification harness.

All 28 published Cypher fixtures reproduce their declared outcome: 15 accepted, 13
refused with `CYPHER_UNSUPPORTED` and a source range.

### Refusal is structural rather than a check

There is no code path that turns an unsupported construct into an approximation.
Parsing returns `Result`, so a refusal yields no query at all, and a conformance test
asserts that for every refused fixture. The contract's promise that nothing executes is
therefore carried by the type rather than by remembering to check.

Excluded keywords and functions are scanned before parsing begins, so an excluded
construct is never partly interpreted on the way to being rejected.

### Two defects found while implementing

`shortestPath` was refused by the expression parser, which never sees it: it appears in a
*pattern* position, as `MATCH p = shortestPath((a)-->(b))`. The check moved into the
pre-parse scan, which covers every position.

A unit test asserted that `RETURN a.n UNION ALL RETURN b.n` parses. It should not:
`a.n` and `b.n` are genuinely different column names in Cypher, so the query is a
semantic error. The parser was right and the test was wrong, which is worth recording,
because the reflex is to assume the opposite.

### Unsupported and semantic are different answers

`CYPHER_UNSUPPORTED` means the construct is outside the subset and may be supported by a
later build, so retrying is reasonable. `CYPHER_SEMANTIC_ERROR` means the query is wrong
and retrying will not help.

The distinction is applied rather than declared: an unbounded `*1..` is unsupported, while
an inverted `*5..1` is semantic, because the construct is in the subset and only its
values are wrong.

### Recorded divergence: write clauses

The published subset includes `CREATE`, `MERGE`, `SET`, `REMOVE`, `DELETE`, `DETACH
DELETE`, and `CALL`. This build refuses them with `CYPHER_UNSUPPORTED` and a message
saying it implements reading only.

That is a deliberate, temporary divergence from the contract, closed by increment 3. The
alternative was worse: half-parsing a write clause could produce a plan that drops a
`SET`, which is exactly the silent approximation the contract exists to prevent. It is
recorded here rather than left for a reader to discover.

The fixture suite covers reading only for the same reason, which the query contract states
explicitly rather than leaving the gap to look like an oversight.

## Stage 6 increment 1 acceptance criteria

- The query subset contract states exactly which clauses are accepted and what happens to
  everything else.
- `CYPHER_UNSUPPORTED` and `CYPHER_SEMANTIC_ERROR` are registered and documented.
- Every accepted fixture parses; every refused fixture is refused with
  `CYPHER_UNSUPPORTED` and a source range.
- A refused query never runs under a guessed alternative, which the parser structure makes
  unrepresentable rather than merely avoided.
- No fixture is copied into `nostdb-core`.
- The Rust command set passes in both children, and root CI is green over both new pins.

## Stage 5 increment 3 verification

Passed on 2026-07-26 in `nostdb-spec` at `0d1ad42` and `nostdb-core` at `fcffa38`.

Rust command set clean in both children, with 194 unit tests plus 12 conformance and
storage tests in the Engine, and 20 tests in the specification harness.

This completes Stage 5.

### The contract was extended before the Engine implemented it

Synchronization needed `SYNC_CONFLICT` and `NOST_SOURCE_STALE`, and neither was
registered. Rather than inventing codes in the Engine, `nostdb-spec` gained a
Synchronization section defining the baseline, the four-way state machine, what a
conflict is not, and the determinism synchronization depends on. The Engine then
implemented a published contract instead of leading it.

Two findings recorded during increment 1 were closed in the same change:

- the confidence range rule now names `confidence_score`, since a range rule is
  unenforceable without knowing which property it governs;
- the blank-line rule now applies to block declarations, so link directives form one
  group rather than being separated from each other, which is what the PRD's own example
  shows.

### Why a baseline rather than a timestamp

A generation advances only on a successful commit and a digest changes only when bytes
change, so both are properties of content. A modification time is a property of the
environment: two machines can disagree about the clock while both files are legitimate,
and a copy can carry any time at all.

The database counts as changed when *either* its generation or its digest differs.
Neither alone is sufficient, and both failure modes are tested: a generation comparison
alone would accept an externally rewritten file at the same generation as unchanged, and
a digest comparison alone carries no ordering.

### A conflict authorizes nothing

Exactly one of the four outcomes permits modification, and a test asserts that by
filtering all four rather than by checking the conflict case alone. A conflict is not a
merge failure to retry: both sides hold work derived from one baseline, so preferring
either would discard the other silently.

### No closed language list

An unregistered language is `PrecisionClass::Unsupported`, which is a value rather than
an error, because unsupported text stays eligible for AI fallback and still produces a
source record. Treating it as a failure would discard work the product promises.

Registration refuses a capability that declares unsupported or extracts no fact kind.
Both would make a language look covered while producing no graph.

`ANALYZER_UNSUPPORTED` was deliberately not registered. Capability is data, not a
finding, so it is returned as a value; the code belongs to an analysis contract that does
not exist yet.

### A defect the cross-repository check found in itself

Re-pinning failed the root diagnostic cross-check, which reported `SYNC_CONFLICT` as
present in the specification and absent from the Engine. The Engine had it. The check's
extraction was anchored on a `NOST` prefix and could not see a code starting with `SYNC`.

The check was broadened to any upper-snake-case literal, which is exact because every
other quoted string in the non-test part of that file starts lower case. Worth noting
that the failure was in the checking code rather than the checked code, and that it was
caught the first time a code broke the prefix assumption.

## Stage 5 increment 2 verification

Passed on 2026-07-26 in `nostdb-core` at commit `ef53474`.

Rust command set all clean, with 175 unit tests, 3 container conformance tests, 4
`.nost` conformance tests, and 5 on-disk graph storage tests.

This closes the payload gap carried since Stage 4. A graph now round-trips through a
real `.nostdb` file: create, commit, close, reopen, read back identical.

### Decoding is validation

Every decoded value is rebuilt through the same typed constructors the model uses, so a
corrupt or hostile container cannot produce a model that breaks an invariant. A stored
label goes through `Label` and a reserved word is refused; a stored score goes through
`Score` and a value outside `0.0..=1.0` is refused; a stored timestamp goes through
`DateTime`. The result is an error, never an invalid graph.

Every count is checked against the bytes that remain before anything is allocated, so a
corrupt length cannot drive a large allocation. A payload with bytes left after its last
record is refused rather than ignored, because trailing data would be a place to hide
content a reader never validates.

### The mutation test asserts a property, not the absence of a crash

Flipping every byte of every encoded section and re-decoding proves more than "no
panic": when decoding succeeds, the decoded graph is re-encoded and decoded again and
must be identical. That catches encoder and decoder asymmetry, which a panic-only check
would miss entirely.

### Recorded decision: properties are inlined

Properties and contributions are encoded inside their node or edge rather than in the
`properties`, `evidence`, and `contributions` sections the container reserves.

Nothing in the container contract requires a kind to be present, and inlining keeps a
record readable in one pass. Those kinds stay reserved for a layout that would justify
them, such as a columnar store supporting indexed property search, which is a
performance decision that needs a benchmark rather than a guess.

A section holding no records is omitted entirely, so an empty graph produces a container
with only a string table.

### Byte-identical commits

The same graph content committed at the same generation produces byte-identical files,
which is tested on disk. That is what lets synchronization compare generations and
content digests rather than wall-clock time, as the root PRD section 14 requires.

## Stage 5 increment 1 verification

Passed on 2026-07-26 in `nostdb-core` at commit `49b33e2`.

Rust command set, all clean: `cargo fmt --check`, `cargo check`, `cargo clippy
--all-targets --all-features -- -D warnings`, and `cargo test --all-targets
--all-features` with 161 unit tests, 3 container conformance tests, and 4 `.nost`
conformance tests.

### Conformance against the published fixtures

All 34 `.nost` fixtures reproduce their declared outcome:

| Suite | Fixtures | Result |
| --- | --- | --- |
| accepted | 9 | parse, and raise no diagnostic at all |
| syntactically rejected | 13 | rejected, each with a usable source range |
| semantically rejected | 12 | parse, and raise the declared diagnostic code |
| round trip | 9 | formatting is idempotent, and 9 comments survive |

This parser was written independently of the reference encoding in `nostdb-spec` and
agrees with it on every accept and reject decision. The two use different technology,
which is the point: the reference encoding is a PEG and this is recursive descent, so
agreement is evidence about the contract rather than about shared code.

### Positions are deliberately not compared

The fixtures record a line and column for each rejection, and the language contract
marks them informative. This suite asserts rejection with a range and does not compare
positions.

That decision, made in Stage 2, paid off here. The reference encoding reports the
furthest position it reached while backtracking; this parser reports the offending
token. Their positions differ on most rejection fixtures, and both are correct. Had
Stage 2 made positions normative, conformance would have failed for a reason that says
nothing about the language.

### Defects this increment found and fixed

Formatting was not idempotent. The lexer kept the leading space of a `// comment`, and
the formatter added one on output, so each pass grew the gap by a character. The lexer
now trims comment text on both ends, which makes one space after `//` the canonical
form and makes output stabilize.

A comment could be lost. A module with a comment after both its opening and closing
brace had two candidates for one trailing slot, and the second was discarded. The
closing-brace comment is now left in the stream to attach to whatever follows, so no
comment is dropped.

Both were caught by tests written alongside the code rather than by the fixtures, which
do not exercise a comment in both positions of one module.

### Recorded finding: two small contract gaps

The confidence range rule names no property key. The language contract requires a
confidence score to fall within `0.0..=1.0` but does not say which property carries
one. This build uses `confidence_score`, matching the fixture, and the key should be
fixed in the contract.

The blank-line rule is ambiguous for single-line declarations. The contract requires
one blank line between sibling declarations. Read strictly, that puts a blank line
between every `@link`, which contradicts the PRD's own illustrative example. This build
treats the link declarations as one group and separates block declarations, and the
rule should be narrowed to block declarations.

Both are recorded rather than silently decided, and both are contract changes belonging
to `nostdb-spec`.

### Remaining Stage 5 work

All three increments landed; see their verification sections above. Stage 5 is `DONE`.

## Stage 4 verification

Passed on 2026-07-26 in `nostdb-core` at commit `c548903`.

Rust command set, all clean:

- `cargo fmt --check`
- `cargo check --all-targets --all-features`
- `cargo clippy --all-targets --all-features -- -D warnings`
- `cargo test --all-targets --all-features`, 122 unit tests plus 3 conformance tests

Repository and workspace:

- `bash -n` and a pass of `nostdb-core/scripts/verify-repository.sh`
- `bash -n` and a pass of `./scripts/verify-workspace.sh`
- the exact `git submodule foreach` command from the root workflow, across both
  children

### Container conformance against the pinned specification

`nostdb-core` reproduces every outcome the `nostdb-spec` container suite declares:
20 fixtures, 3 accepted and 17 rejected, each rejection carrying the diagnostic code
the fixture names.

That result is worth stating precisely: the Engine's reader and the reference
validator in `nostdb-spec` were written independently against the same prose
contract, and they agree on all 20 cases including the ordering-sensitive ones. A
disagreement would have meant the contract was ambiguous.

The fixtures are not copied into the Engine. The conformance test reads them from a
path the superproject supplies in `NOSTDB_SPEC_FIXTURES`, so it runs against the
exact pinned commit.

### Closing the silent-skip hole

A standalone clone of `nostdb-core` has no sibling checkout, so the conformance test
reports itself skipped and passes. An independent build must not require a sibling,
but a skipped test proves nothing.

`scripts/verify-workspace.sh` therefore runs that test with the fixture path set and
fails unless it confirms the fixtures ran. That was proven by moving the fixture
directory aside: the root check fails with `the container conformance test did not run
against the nostdb-spec fixtures`.

### Ordering is part of the contract

The twelve checks run in the contract's order, and that is tested rather than
assumed. A container whose section count exceeds the limit *and* whose table would
fall outside the file reports `NOSTDB_LIMIT_EXCEEDED`, because the limit is checked
before the table is sized. Reporting the bounds failure instead would be a defect,
since the whole point of the ordering is to bound allocation before any length from
an untrusted file is trusted.

Flipping any single bit in the 44 checksum-covered header bytes is detected, tested
exhaustively rather than by sampling.

### Recorded decision: what the journal is actually for

Replacing one file atomically needs no journal, because a staged write followed by a
rename is already all-or-nothing. The journal exists for what a rename cannot cover:
a change spanning several files. Adding a link touches the database, the settings
mirror, and possibly the materialized `.nost`, and a crash between those renames
would leave them disagreeing.

The journal therefore records promotion and removal intent, brackets it with a
`Begin` and a `Commit`, and is replayed by re-applying only the last committed
transaction. Actions are expressed as a desired end state, which is what makes
replaying twice equal to replaying once.

Recovery was tested at every truncation point of a transaction, not only at record
boundaries, because a crash during an append can land anywhere.

### Recorded decision: durability limits stated rather than implied

The staged file and the journal are flushed with `sync_all` before the rename. The
containing directory is flushed best effort, because not every platform and
filesystem supports flushing a directory handle and treating that as a failure would
break commits on systems where the rename is already durable.

The consequence is stated in the module documentation rather than left implicit: on a
system that ignores directory flushes, a power loss immediately after a rename can
lose the rename, and the journal is what lets the next open finish the promotion.

### Deferred out of Stage 4

Section payload encodings. Stage 4 stores and retrieves section bytes; how a Node, an
Edge, a property, or an Evidence record is laid out inside a section is a separate
contract that lands with the parser in Stage 5, which is the first thing that needs
to turn a record into bytes.

## Stage 5 scope

Stage 5 carries three separable bodies of work. It is taken in three increments so
each one is verifiable on its own, and the Stage stays `IN_PROGRESS` until all three
are done. The Stage table is unchanged; only the order of work inside it is recorded.

| Increment | Content | Status |
| --- | --- | --- |
| 1 | `.nost` lexer, comment-preserving CST, parser, semantic validation, canonical formatter | DONE |
| 2 | section payload encodings, so a graph round-trips through a container | DONE |
| 3 | synchronization state machine and the deterministic analyzer capability boundary | DONE |

Increment 1 is first because everything else in Stage 5 depends on it: an encoding has
nothing to encode until records can be read, and synchronization has nothing to
compare until a `.nost` file can be parsed and canonicalized.

### Increment 1 scope

- a lexer producing tokens, spans, and trivia, including the tagged `bytes` and
  `datetime` literals;
- a recursive-descent parser producing a comment-preserving tree, with parse errors
  carrying source ranges;
- the semantic diagnostics the language contract lists, which parsing cannot express;
- the canonical formatter, whose second pass is byte-identical;
- conformance against all 34 `.nost` fixtures in `nostdb-spec`, exercised from the
  superproject rather than a vendored copy.

### Deferred to later increments

- section payload encodings, carried over from Stage 4;
- the synchronization state machine, including `SYNC_CONFLICT` when both
  representations changed from one baseline;
- analyzer capability declaration and deterministic structural extraction.

## Stage 5 increment 1 acceptance criteria

- Every accepted `.nost` fixture parses.
- Every syntactically invalid fixture is rejected with a diagnostic carrying a source
  range. Positions are not compared against the fixtures' recorded values, which the
  language contract marks informative and specific to the reference encoding.
- Every semantically invalid fixture parses and raises the diagnostic code it
  declares.
- Every comment survives a parse and format round trip, with its attachment.
- Formatting is idempotent: formatting formatted output reproduces it byte for byte.
- Canonical output obeys the contract's ordering, indentation, and empty-block rules.
- No `.nost` fixture is copied into `nostdb-core`.
- `cargo fmt --check`, `cargo check`, `cargo clippy --all-targets --all-features
  -- -D warnings`, and `cargo test --all-targets --all-features` pass.
- Child CI is green, and root CI is green over the new pin.

## Stage 13 scope

Reported: a 41-file Kotlin repository built to `0 nodes, 0 edges`, and the answer given was that a
structural graph of it is not available. **That answer was wrong at the product level**, and the
direction is that analysis must not depend on the language — a repository holding only documents and
no code has to be analyzable too. An analyzer is a means of spending fewer tokens, not the thing that
decides whether a graph exists.

| Increment | Content | Status |
| --- | --- | --- |
| 1 | this scope, and the defect it records | DONE |
| 2 | a source record for every scanned file, whatever its language | DONE |
| 3 | containment, so a graph with no analyzer is still navigable | DONE |
| 4 | a file whose language cannot be named at all | DONE |

### This is a defect against the PRD, not a change to it

Worth settling first, because the two have different consequences: a change to the product contract
needs the contract amended and a version considered, and a defect needs fixing and nothing else.

`docs/PRD.md` section 17.3 already says it outright:

> An unsupported text language remains eligible for AI analysis and **at minimum produces a
> source/module record with an explicit capability diagnostic**.

Section 4 lists two goals beside it: "impose no product-level programming-language allowlist", and
"create a useful structural graph without external AI token usage **whenever a deterministic analyzer
is available**". Read together they say precisely what the direction says. The analyzer is what makes a
graph free; its absence means depth may cost tokens, not that nothing is recorded.

`nostdb-core/src/build.rs` skips a file whose language has no deterministic analyzer, before anything
is recorded:

```rust
if !registry.precision(&file.language).is_deterministic() {
    coverage.skipped_sources.push(/* … SkipReason::Unsupported */);
    continue;
}
```

So the minimum in 17.3 was never produced. Every Kotlin file was classified correctly, counted
correctly, reported correctly as unsupported — and then dropped. The scan names 42 extensions and 6
extensionless files, which is why `plan` could say `kotlin 2 files unsupported`: the language was
known all along, and the record was the part that was missing.

### What was misread, and why it survived a whole Stage

Nothing here was an accident of implementation. The gate reads as correct if you believe a record
requires facts to put in it, and every test agreed with it — `analysis: unsupported languages` was
covered, and what it covered was that an unsupported language is *skipped and reported*, which is the
behaviour the PRD contradicts. A test can pin the wrong thing precisely.

The reading it encodes is that an analyzer produces the record. What 17.3 says is that the **scan**
produces the record and an analyzer adds facts to it. The file exists, its path exists, its digest
exists, and its language is named — those are facts about the repository that no analyzer is needed
for, and `ScannedFile` already carries every one of them.

### The consequence that mattered

A Kotlin project got `generation 1` holding nothing, and the enrichment route is documented as
"build the structural database and **commit it**" first, so an AI-free graph is the precondition for
the AI-assisted one. With no record to attach anything to, every language without an analyzer was
locked out of both routes — which is exactly the product-level language allowlist section 4 forbids,
arrived at without anybody writing a list.

### Acceptance criteria

- Every file a scan keeps produces a source record, whatever its language, and a project with no
  analyzable source commits a generation holding those records.
- A record carries its language and the precision available for it, so a query can tell a deterministic
  fact from a file nothing analyzed. No new `PrecisionClass` variant: section 17.3 fixes that enum, and
  `Unsupported` is the honest answer for a file no analyzer read.
- An explicit capability diagnostic accompanies it, per section 17.3.
- A documents-only project — no code at all — builds a non-empty, navigable graph.
- Coverage keeps saying what has no analyzer. Recording a file is not claiming to have analyzed it, and
  `structural` must not report `Complete` because records exist.
- A Rust project's graph is unchanged: same nodes, same edges, same generation behaviour.
- `cargo fmt --check`, `cargo check`, `cargo clippy --all-targets --all-features -- -D warnings`, and
  `cargo test --all-targets --all-features` pass in every touched repository.
- Child CI is green, and root CI is green over the new pins.

### Increment 2: the record an analyzer is not required for

A file the scan keeps always leaves a record. Its path, language, and digest are the scan's, so this
costs no read at all — `ScannedFile` already carried all three, which is what made the omission a
decision rather than a limitation.

Three things follow from separating *recorded* from *analyzed*, and each was a choice:

- **`Unit` stores whether an analyzer read the file** rather than deriving it from the language's
  precision. A covered language whose bytes could not be read also arrives unanalyzed, and deriving
  it would count that file as analyzed and report coverage the build does not have.
- **the record carries `precision`.** Section 17.3 requires that results not imply equal confidence
  across languages, and `unsupported` on the record says the file is here and nothing read it —
  which is a different claim from an analyzer having found no items in it. No new `PrecisionClass`
  variant: 17.3 fixes that enum.
- **evidence for a recorded file names the scan as its producer.** `Deterministic` and `Extracted`
  still hold, and that is not a loophole: the path and the digest were read off the filesystem
  rather than inferred, so the claim being made is exact.

Coverage is unchanged. An unsupported file is still recorded in coverage as such, per section 17.2,
and `structural` still stays short of `Complete`, because recording a file is not analyzing it.

`recorded_files` sits beside `analyzed_files` in the report and in the CLI table. One number for both
would either claim coverage the build lacks or hide the graph it committed — and a report reading
`analyzed 0 files` above `nodes 41 created` looks like a contradiction until the second line is there.

### Increment 3: a bag of files is not a graph

The minimum in 17.3 is satisfied by file records alone, and file records alone are not worth
querying: a project with no analyzer for its language would hold records nothing connects, and
"which files are under `docs/`" would be a string comparison rather than a traversal. Directory nodes
and `CONTAINS` edges are deterministic, language-neutral, and derived from paths, so they spend
nothing.

**The tree has a source unit of its own.** A directory outlives any one file in it, so owning it
through a file would delete `docs/` when `docs/api.md` was removed and leave its siblings parentless.
Three consequences followed, and every one was found by a test rather than reasoned about first:

- the tree unit must count as **present**, or every build reports it departed and redraws everything;
- it must **withdraw before being redrawn**, or a directory whose last file was deleted is never
  removed — the graph keeps claiming a directory that is gone;
- it must withdraw **only when there is a tree**, or a project holding nothing commits a change set
  carrying a lone withdrawal and bumps the generation on every build over a project that never
  changes.

A directory is **not** a neighbour in an analysis packet. Its whole content is its path, the packet
already carries the path, and every file has a parent — so without the exclusion every packet in the
repository would name the tree's unit and spend tokens describing what the model can read off the
file name. That is the sense in which an analyzer is a token-efficiency device: the same reasoning
decides what is worth sending.

### Increment 4: an extension decided whether a file existed

`.txt` is in no language list and never will be in every language list. Classification ran *before*
the read, so a file whose extension named no language was skipped — and a documents-only project of
`.txt` files built nothing at all. Increment 2 fixed the Kotlin case and left this one, because
Kotlin has a name in the list and plain text does not.

Extending the list until every document form appeared in it is the allowlist section 4 forbids,
arrived at one extension at a time. So a file whose language cannot be named is kept and named
`unknown`, whose precision is `Unsupported` because that is the truth.

Coverage reports it `Unclassified` rather than `Unsupported`. Section 17.2 requires both, and they
are different facts: one says no analyzer covers this language, the other says there was no language
to look up. Collapsing them would lose the distinction the section asks for.

Moving the read earlier also corrected a mislabel nobody had noticed: a `.png` was reported
`Unclassified` when `Binary` is what it is, because nothing had looked at the bytes. What it costs is
reading text files that will hold no facts, bounded by `max_file_bytes`. **`.env` and its family are
caught by name before any read**, and that check did not move, so recording unclassified text never
reaches a secret.

### A version bump is the migration

`GRAPH_SCHEMA_VERSION` guarded only the parse cache. Reuse compares digests, an unchanged tree is
never read, and so nothing would ever rewrite records that predate a new property: a database written
before `precision` existed would have kept its old shape forever, and no test would have noticed
because every test starts from an empty graph.

It is now recorded on every record and reuse requires a match, so a bump makes the next build redraw
what it holds. Found while writing increment 3, having been introduced by increment 2.

### What this changes for an existing database

Every graph gains directory nodes, including a Rust project's. Item records and the edges between
them are unchanged — the 712 Core tests covering the Rust analyzer are the evidence — and the tree is
added alongside them. The first build after this change rewrites what it holds, by design.

### Verification

Run in `nostdb-core`, then in `nostdb-cli` against the new pin, then at the root:

```bash
cargo fmt --check && cargo check
cargo clippy --all-targets --all-features -- -D warnings
cargo test --all-targets --all-features
./scripts/verify-repository.sh
./scripts/verify-workspace.sh
```

`nostdb-core` 712 tests pass, `nostdb-cli` 93, and both verifiers pass. The reported repository — a
Kotlin service with 74 files — builds **149 nodes and 148 edges** where it built nothing, and its tree
traverses:

```text
recorded   71 files, 71 with no analyzer for their language
note: it analyzes rust; this project is css, kotlin, make, markdown, sql, toml, unknown, yaml
note: 2 file(s) skipped: sensitive
```

## Stage 14 scope

Every Stage was `DONE`, every repository verified green, and the product shipped **three revisions of
one workspace**.

| Increment | Content | Status |
| --- | --- | --- |
| 1 | this scope, the audit, and the check that holds it | DONE |

### What the audit found

The root pins each child as an exact submodule commit. A child that depends on a sibling pins it by
revision in its own `Cargo.toml`. Nothing compared the two:

```text
nostdb-cli    pins nostdb-server at 2ee27a0; this root pins 8ab7850
nostdb-server pins nostdb-core   at 7097a2; this root pins 775c794
```

`nostdb-server` was **eleven Core commits behind** the Core the root pinned, and `nostdb-cli` — the
crate published as 0.1.1 — was built against a daemon two commits behind the one the root pinned,
which was itself built on that older Core. So released 0.1.1 contained a client for one revision of a
daemon built on a third revision of the Engine.

### Why this is worse than being out of date

The daemon does not build graphs; it opens databases, runs queries, and holds transactions. So no
graph was written wrongly, and the severity is not in what was stored.

It is in the query engine. The daemon's and the CLI's are the same source at two revisions, so a query
could answer differently depending on whether it was reached through `@name` or through a path. The
ownership boundaries in `AGENTS.md` exist to prevent "two implementations of one question", and one
implementation at two revisions is indistinguishable from two implementations from the outside — the
same defect wearing a disguise the boundaries were not written to catch.

Among what the daemon was missing: `State the query subset version`, which is the contract it reports
over its own protocol. It was answering with a version from before the contract was stated.

### Why no repository could have caught it

Each child verified green, correctly. `nostdb-server` builds and passes on Core `7097a2` — there is
nothing wrong with it in isolation, and asking it to check would require it to know what the root
pinned, which it cannot.

`docs/REPOSITORIES.md` gives the root exactly this job: cross-repository documents, **exact pins**, and
integration orchestration. The pins were exact and unverified against the only other place that
records them. This is the one check that had to live at the root and did not.

### The check reads the index, not `HEAD`

Its first version compared against `HEAD` and refused the very commit that fixes a mismatch: a re-pin
round stages the new gitlink and the child's matching manifest together, so `HEAD` still holds the old
pin while the index holds the correct one. A pre-commit verifier that can only pass after the commit
is the wrong way round, and the rest of this script already reads gitlinks from the index.

It also writes findings to a file rather than a variable. The loop reads from a pipe, so it runs in a
subshell, and a count assigned inside would be discarded when the pipeline ended — a check that
reports success having found something.

Proven to reject: pointing `nostdb-cli` at a Core revision of all zeroes fails with the mismatch
named, and restoring it passes.

### Acceptance criteria

- Every child that depends on a sibling depends on the revision the root pins, and the root refuses a
  commit where one does not.
- The check names the child, the dependency, both revisions, and reads the index so a re-pin round can
  satisfy it.
- `nostdb-server` and `nostdb-cli` build, test, lint, and verify on the aligned pins with no source
  change.
- Child CI is green, and root CI is green over the new pins.

## Stage 15 scope

Stage 13 made every repository appear in its own graph. This Stage is about depth: the reported Kotlin
service records 71 files and analyzes none of them, because Rust is the only analyzer this build has.

The direction that opened Stage 13 said an analyzer is a means of spending fewer tokens. That makes a
second analyzer worth having on its own terms — Kotlin structure extracted deterministically is
structure nobody pays a model for — and it makes the *boundary* worth fixing first, because there is
no second-analyzer boundary yet. There is a Rust analyzer with its name written into places that
should not know it.

| Increment | Content | Status |
| --- | --- | --- |
| 1 | this scope, and the audit of what one analyzer hid | DONE |
| 2 | provenance per producer; ownership recorded as blocked on the contract | DONE |
| 3 | the Kotlin lexer | DONE |
| 4 | Kotlin items and its declared capability | DONE |

### The audit: five places that know the analyzer is Rust

```text
build.rs  parse_cache_key   analyzer_digest = "rust/1", for every language
build.rs  analyzer_owner    Owner::Analyzer { name: "rust", version: "1" }, for every record
build.rs  analyzed_evidence producer_version = rust::VERSION, for every item
build.rs  file_evidence     the same, for every file record
build.rs  a link's evidence producer = rust::LANGUAGE, for a fact no analyzer produced
```

Each is harmless with one analyzer and wrong with two:

- **the cache key** would store a Kotlin parse under the Rust analyzer's identity, so bumping the
  Kotlin analyzer would not invalidate Kotlin parses and bumping the Rust one would invalidate them
  for no reason;
- **the owner** is the serious one, below;
- **the evidence** would have Kotlin items claiming the Rust analyzer's version as their provenance,
  which is precisely the question evidence exists to answer;
- **a link's evidence** names the Rust analyzer as the producer of a link the user declared.

### The owner is one value per change set, and the PRD makes it per-analyzer

`docs/PRD.md` section 11.3 is explicit:

> An analyzer refresh may replace only contributions owned by that analyzer and source unit. It MUST
> preserve user contributions and contributions from other analyzers.

A `GraphChangeSet` carries exactly one owner. So a project holding both Rust and Kotlin cannot be
drafted as one change set once the two analyzers are distinct owners — and today it "works" only
because every record in every language is owned by `rust/1`, which is the boundary not existing rather
than the boundary holding.

`apply` takes `&mut Graph` and one change set, and nothing commits inside it. Several change sets can
therefore apply against one in-memory graph before a single commit, which keeps "a failed mutation
preserves the last valid generation" intact while giving each producer its own owner.

The directory tree gets its own owner for the same reason. It is not a Rust fact and no analyzer
produced it: the scan did, and its evidence already says so.

### Recorded, not fixed: how a superseded analyzer version is retired

Section 11.3 says a refresh replaces only contributions owned by **that analyzer and source unit**, and
`Owner::Analyzer` carries a version, documented as deliberate — "upgrading an analyzer does not
silently adopt facts the previous version produced".

Both are reasonable and together they leave a gap. When the Rust analyzer goes from version 1 to 2,
version 2's refresh may not touch version 1's contributions, and nothing else is specified that
retires them. Section 11.3's "A Node is physically removed only when no contribution or retained Edge
requires it" then keeps version 1's records alive indefinitely, and the graph holds both readings of
every file.

Nothing here changes that, because the owning contract has to decide it: whether a build withdraws
every `Owner::Analyzer` contribution for the units it rebuilds regardless of version, or whether a
version bump is a migration with its own explicit step. It is not blocking this Stage — a second
analyzer is a different *name*, not a different version — and it is recorded because adding the second
analyzer is what made it visible.

### Increment 2: provenance moved, ownership did not

Three of the five sites the audit found were fixed, and all three are provenance:

- the **parse cache key** names the analyzer for the file's language. Fixed to Rust, a Kotlin parse
  would be stored under the Rust analyzer's identity, so bumping Kotlin would not invalidate Kotlin
  parses and bumping Rust would invalidate them for nothing;
- an **analyzed record's evidence** carries the version its own analyzer declares, read from the
  declared capability rather than from a second copy of it;
- a **declared link's evidence** names the scan. It named the Rust analyzer as the producer of a link
  the settings declare — a language analyzer credited with finding something it never read.

**Ownership is unchanged and still named `rust/1`.** That is wrong with a second analyzer and it was
not changed, because it cannot be without deciding what the product contract has not decided.
`GraphChangeSet::validate` enforces section 11.3 by rejecting a removal whose owner is not the set's
own, so renaming the owner would leave every record an earlier build wrote owned by a name nothing can
withdraw: `existing_unit` would not find them, fresh units would be minted beside them, and the graph
would hold both readings of every file. The reason is written where the owner is defined, not only
here, because that is where somebody will next be tempted to rename it.

What makes this liveable rather than merely deferred is that the per-language identity is now in
`Evidence`, which section 11.4 dedicates to provenance. The owner answers "who may replace this"; the
evidence answers "who produced it, at which version". Only the first is stuck.

### Increments 3 and 4: Kotlin

A separate lexer rather than the Rust one with a flag. The two share a shape and almost nothing else,
and a flag would branch at every difference — a change for one language would be a change to the
other's tokenizer. What must not be duplicated is the analysis contract, and `FileAnalysis` is shared.

Four traps the lexer exists for, each with a test that fails without the fix:

- a **nested block comment** closes once. Rust's rule leaves the trailing `*/` as code and finds
  declarations inside a comment;
- a **`${...}` template** is brace-counted and recurses into a nested string, so `"${if (x) "}" else
  ""}"` closes where Kotlin closes it. Losing that moves every following declaration into the wrong
  scope, which is worse than missing one;
- a **raw string** holds a lone quote and a brace, and four closing quotes close once rather than
  opening another string;
- a **backtick identifier** is never a keyword, so ``fun `class`()`` declares a function.

Four more in the reader:

- **`data class C` declares `C`.** A modifier and a declaration keyword are both plain identifiers, so
  stopping at the first would name every `data class` in a project `class`;
- **`fun interface Handler` declares an interface**, not a function named `interface`;
- **an expression body has no terminator.** Kotlin has no statement separator, so nothing in the token
  stream ends `fun f() = 1`. Without a bound, `g` becomes a call inside `f` and stops being a
  declaration;
- **`companion object` unnamed is `Companion`**, which is what a reference to it is written as.

#### What it declares it cannot do

`InterfaceImplementation` is deliberately **not** among its facts. `:` introduces a supertype list and
Kotlin does not say which entries are interfaces, so `implements` stays empty and every supertype is
reported as a reference. Declaring the fact would advertise coverage it cannot have, which is the one
thing a capability declaration exists to prevent.

A template's contents are not tokenized, so a reference written in `"${server.port}"` is invisible and
an edge that could have come from it will not. Stated in the lexer rather than discovered later.

A local `val` is not recorded: it is not something anything outside the function can refer to, and
recording every one would bury the queryable structure in structure that is not.

### The reported repository, before and after

```text
before   recorded 71 files, 71 with no analyzer      nodes 149   edges 148
after    analyzed 48 files                           nodes 305   edges 373
```

34 classes, 35 methods, 71 properties, 8 functions, 4 enums, 4 interfaces, and the tree they sit in.
`MATCH (c:Struct)-[:CONTAINS]->(m:Method) RETURN c.name, count(m)` answers, and so does `CALLS`.

**72 references resolved and 241 did not**, and that is the declared precision rather than a defect.
Most unresolved names are platform and dependency types — `String`, `UUID`, framework annotations —
declared in source this build never read. A syntactic analyzer that resolved them would be guessing,
and `build` leaves a name two records share unresolved rather than picking one.

### Two tests were repointed, and one had gone stale by becoming wrong

Two tests asserting that a Kotlin project analyzes nothing now use Ruby. The case each was written for
moved rather than went away, and leaving them on a language that is now read would have made both pass
for the wrong reason.

One of them asserted the note contains `it analyzes rust` and **failed on a note that had become more
correct** — `it analyzes kotlin, rust`. It now requires every language this build analyzes, and says
that a third analyzer belongs in the list. A test that pins one item of a set it means to describe
fails the moment the set grows, which reads as a regression and is the opposite.

### Verification

`nostdb-core` 747 tests, `nostdb-cli` 93, `nostdb-server` 28, every verifier, and
`GRAPH_SCHEMA_VERSION` is 3 — a Kotlin file used to assert only that it existed, so a database built
before this holds Kotlin records this build would not write, and reuse would keep them because the
bytes did not change.

## Stage 16 scope

Reported from a real run: `nostdb view .` reported `PLUGIN_REQUIRED` and named a plugin, and
`nostdb plugin add` then **refused the source it had just been told to run**:

```text
PLUGIN_SOURCE_INVALID: `ref` is not `ref=<git-ref>`
```

Replacing the branch with an immutable commit changed nothing, which reads as a bug in the source
grammar. It was not the grammar, and there were two defects behind one symptom.

| Increment | Content | Status |
| --- | --- | --- |
| 1 | the operand that never arrived whole | DONE |
| 2 | the provider no release has ever shipped | DONE |

### Increment 1: the source parser never saw the source

Every argument was split on `=` to support `--scope=global`, and the part *before* the `=` was pushed
as the operand. So

```text
https://github.com/nostdb/plugins?ref=main#reference/view-webgpu
```

reached the source parser as `https://github.com/nostdb/plugins?ref`, and was refused for not being
`ref=<git-ref>`. The message described the source grammar for a source the grammar never saw — which
is why replacing `main` with a commit hash changed nothing, and why the conclusion "engine-side
source-parser bug" was the reasonable reading of it.

The split now applies only to an option. Two checks, both proven to fail on the old code:

- the source `PLUGIN_REQUIRED` recommends is **read out of `view.rs`** and required to survive the
  operand parser *and* the source grammar with its ref and subdirectory intact. Read rather than
  written out, so changing what is recommended cannot leave a test checking a string nobody prints;
- an `=` splits an option and never an operand.

This is the third instance this round of the same shape: a message the surface prints and a parser
that refuses it, with nothing reading the two against each other. The others were `build [PATH]` and
the Skill's documented `plan --format json .`.

### Increment 2: no release has ever contained a provider

With the URL arriving whole, the install failed for the next reason — no provider executable. That is
not a configuration mistake. `docs/PRD.md` section 17.5 requires the GitHub provider "bundled at a
compatible version in official distributions", and every archive published so far holds exactly one
program.

So **every published install refused every plugin install and every GitHub link**, and the
recommendation the CLI prints could not be followed from anything a user could install. `plugin add`
and `link refresh` both looked the provider up in an environment variable only, which made section
17.5 impossible to honour: a release could ship the provider and still refuse, until the caller found
out about a variable nothing had mentioned.

**Finding it.** `NOSTDB_GITHUB_PROVIDER` still wins; the executable beside this one is checked after
it. The sibling rather than `PATH`, because a release archive holds both programs — so the sibling is
the one this build was published with, and picking one off `PATH` could start a provider from another
install at another protocol version.

**Shipping it.** The assembler takes `--provider` and stages it under the exact name the engine looks
for; every member is digested and every member is checked to round-trip out of the archive with its
executable bit. Members are sorted so entry order cannot depend on insertion order, and the
reproducibility check now proves it with two members rather than one.

`attested` is `false` for the provider. It is packaged and digested and never started, and claiming
otherwise would claim a check nothing performed.

The workflow builds it for each target from **the revision the superproject pins**, not from its
default branch. The root is what records which revision of each child this product is, and a release
taking whatever the branch happened to be would ship a provider nothing had verified beside this
engine. A target whose provider fails to build now fails the release rather than assembling one
without it.

### What is fixed and what is not, until a release

Both defects are fixed in source and **neither reaches a user without a release**. Published 0.1.1
still truncates the operand and still ships no provider, so `nostdb view .` cannot install its viewer
from npm, Homebrew, or the GitHub archive. That is the same gap Stage 13 had and it is stated rather
than left to be discovered: a fix that is not published is a fix nobody has.

### Verification

`nostdb-cli` 96 tests and its verifier, `nostdb-distribution` 87 checks and its verifier, and an
archive assembled locally holding both programs with three recorded digests, reproducible across two
runs, with the launcher's own verification accepting the provider member.

## Stage 17 scope

Requested: a plugin lives at `plugins/*` rather than `reference/*`, a repository is recognised only when
it holds `nostdb.plugins.json`, and that file does the mapping.

`plugin_install_version` **1 to 2**. Version 1 recognised a plugin by a **path**: a fragment named a
subdirectory, and any directory holding `nostdb-plugin.json` was installable. Version 2 recognises one
by a **declaration**.

### What the path-based rule cost

Two things, and both are worth naming because neither is obvious from the symptom:

- **any tree was a plugin.** A fork, a vendored copy, a test fixture — anything holding a manifest
  somewhere inside it was installable, whether or not its author published it as a plugin;
- **a path was part of the published command.** `#reference/view-webgpu` meant an author who
  reorganised their repository broke every install command anybody had written down, and nothing would
  say so. This Stage's own first act — moving `reference/` to `plugins/` — is exactly that break.

An index makes the name stable and the directory an implementation detail. `#view-webgpu` keeps working
across the move; the fragment names a key and the key names a place.

### Why a bump, and why `supported` is `[2]` alone

Section 4 of the manifest contract was **corrected in place** earlier in this workspace, when it began
requiring `?ref=`, on the grounds that nothing had shipped against the old reading. That argument was
available then and is not available here: version 1 is published in 0.1.0 and 0.1.1 and reported by both.

What is true is that **no published build could install a plugin at all** — the GitHub provider was
never bundled, so every install refused for want of one before reaching any of this. That makes the
practical cost of the bump zero. It is not a reason to pretend the version did not change, and it was
not used as one.

Neither direction round-trips, so `supported` lists 2 only:

- a version-1 source has no index, and version 2 refuses it;
- a version-2 fragment names a key that version 1 would read as a directory path and fail to find;
- a version-1 **record**'s `subdirectory` is the fragment a caller typed, not a directory an index
  resolved. Reading one as version 2 would take that string for a resolved directory and be wrong about
  where the plugin came from — the one thing the record exists to say.

### The index is not part of the plugin

It is read at step 4, before validation, because it decides *which* entries are the plugin: validating
the whole repository first would refuse a source over a path in a directory the install never touches.

And it is removed from the entries **before** planning rather than filtered afterwards. It only collides
when a plugin sits at the repository root, and there it would otherwise be planned, read, digested, and
written as one of the plugin's own files. The tree digest would then cover a file that decided what to
install, and an unrelated edit to the index would report the plugin's bytes as changed.

### Decisions inside the contract

- **one declared plugin needs no fragment**; several with no fragment refuse and list them, because
  choosing for the caller installs something nobody named;
- **every mapping is validated**, not only the one being installed. An index with one unusable mapping
  is one its author got wrong, and installing past it leaves the mistake for whoever asks for the other;
- **`.` is the root and an empty path is refused.** An empty string is not the root spelled differently;
  it is a mapping nobody wrote. A test of mine asserted the opposite and contradicted the contract I had
  just written — the contract was right;
- **the index name need not equal the manifest's name.** The index says what to fetch and the manifest
  says what was installed, and both appear in the install report so nobody has to guess which a later
  command wants.

### Three fixtures that had stopped testing anything

The bump made `plugin_install_version` 2 *supported*, and three places asserted 2 as the unsupported
value:

- the spec's `version_unsupported` fixture;
- the CLI's `an_unsupported_record_version_is_reported_alone`;
- every `record/invalid/*` fixture still declaring 1, each of which then failed on its version before
  reaching the rule it exists for — a fixture rejecting for the wrong reason passes against a build with
  the bug it was written to catch.

The version fixtures are now named for their direction. `version_below_the_supported_range` covers
version 1, which is what 0.1.1 wrote and what is on disk if anyone has one, and
`version_above_the_supported_range` covers a downgrade. Keeping only the future case would have left the
case the bump created untested.

### The plugins repository checks both directions

`scripts/verify-repository.sh` refuses an index naming a directory that is not there, one outside
`plugins/`, or one holding no manifest — and refuses **a plugin directory the index does not declare**.
The second is the one worth having: a plugin nobody declared is a plugin nobody can install, and its
manifest, its entrypoint, and its tests all look exactly right.

### Verification

`nostdb-spec` 12 index fixtures with their own rule tripwire, `nostdb-cli` 104 tests including four new
install-flow refusals, the plugins verifier proven to reject in both directions, and
`nostdb --version --json` reporting `plugin_install_versions: [2]`.

**Not published.** Like Stages 13 through 16, this reaches nobody without a release.

## Stage 18 scope

Reported: `MATCH (e:Endpoint)` returned nothing for a Spring service, and the explanation given was that
Kotlin internals were not analyzed. That was the weakest of three causes.

1. **`Endpoint` is a label nothing produces.** The query returns 0 rows on every build that has ever
   existed, including one with the Kotlin analyzer. Fixing language analysis changes nothing about it.
2. **The route was discarded.** Endpoints in that repository are `@GetMapping("/api/...")`, and the
   Kotlin analyzer skipped annotations and their arguments. Proven against a real controller: the
   database holds `TempController`, `temp`, `googleCallback`, and `GetMapping` appears zero times.
3. **The installed 0.1.1 has no Kotlin analyzer at all** — true, and the least of the three.

The direction: add framework analyzers, and where no analyzer covers a framework, let AI decide.

| Increment | Content | Status |
| --- | --- | --- |
| 1 | this scope, and what the contract already required | DONE |
| 2 | annotations survive the language analyzer | DONE |
| 3 | the framework analyzer boundary, its capability, and the AI-fallback diagnostic | DONE |
| 4 | Spring: `Endpoint` records for HTTP routes | DONE |
| 5 | a diagnostic that described the wrong thing, and three severities that did | DONE |

### This was already contracted, and unimplemented

`docs/PRD.md` section 17.4 lists what a deterministic analyzer SHOULD extract, and one line of it is:

> - configuration-defined entry points;

`FactKind::EntryPoint` exists in `nostdb-core` with exactly that doc comment, declared by nothing. A
Spring route is a configuration-defined entry point in the most literal sense: the method is declared in
Kotlin and the route is declared in an annotation argument.

So this is not a new product direction and is not recorded as one. It is a SHOULD that no analyzer has
ever satisfied, and the reason it went unnoticed is that nothing named the gap — an unimplemented
`FactKind` is invisible until somebody asks the question it answers.

### Why a framework layer rather than more Kotlin

A route is not a language fact. `@GetMapping` means nothing to Kotlin; it means something to Spring, and
the same annotation in a project not using Spring is an ordinary annotation. Putting Spring knowledge
into the Kotlin analyzer would mean:

- the Kotlin analyzer's declared coverage would grow every time a framework was added, so its version
  would move for reasons having nothing to do with Kotlin;
- a second language on the same framework — Spring from Java — would duplicate the framework knowledge
  in a second language analyzer, which is the "two implementations of one question" failure again.

So a framework analyzer consumes what a language analyzer produced and declares its own capability. The
language layer says what the source declares; the framework layer says what those declarations mean to
a framework.

### Where AI comes in, and what it may not do

A framework this build has no analyzer for gets an explicit capability diagnostic and its units stay
eligible for enrichment, which is section 17.3's existing rule for an unsupported language applied to an
unsupported framework. Nothing changes about the order: a structural generation commits first, AI runs
under a plan and a budget, and its output is `PrecisionClass::AiFallback` with evidence that says so.

An AI-produced `Endpoint` must never be indistinguishable from a deterministic one. Section 17.3 already
requires it — "results MUST NOT imply that heuristic or AI fallback results have the same confidence as
deterministic facts" — and a record's `precision` property is where that is answered.

### Increments 2 to 4: where the route was, and where it goes

**Annotations survive.** `Item` carries them, and the Kotlin lexer carries a string literal's content —
a route lives *inside* a string, and an annotation whose arguments read `<literal>` says a string was
there and not which one. A number never carries that kind of meaning, so a numeric literal stays a bare
fact.

Arguments are kept verbatim. `@GetMapping("/x")` and `@RequestMapping(value = ["/x"], method = [...])`
mean the same to Spring and nothing to Kotlin, so normalising them in a language analyzer would be
guessing at a framework it does not know. Three things this needed that were not obvious:

- **an annotation ends the previous expression body.** `fun a() = 1` followed by `@Test fun b()` swallowed
  the `@Test`, because `@` is not a declaration keyword and the body reader ran past it;
- **a modifier may sit on either side of it.** Both `@Inject private val x` and `private @Inject val x`
  are legal, and gathering only before modifiers dropped half of them;
- **annotations round-trip through the parse cache.** Without that a framework analyzer would see them on
  a first build and not on a second — the same file yielding different facts depending on caching.

**The framework layer.** A framework analyzer consumes what a language analyzer produced and declares its
own capability and version. Spring's declares `EntryPoint` and `SourceRange` and nothing else: it reads
routes, not injection or persistence or scheduling, and declaring more would advertise coverage it has
not got.

What it refuses to claim is the substance of it. It does not evaluate `${api.base}/x`, because the value
lives in a properties file it does not read. `@RequestMapping(method = [...])` reports `ANY`, because
reading that list means parsing an expression language a syntactic analyzer has no grammar for. A mapping
outside a route holder is not a route, because Spring does not serve it. A class-level `@RequestMapping`
is a prefix, because emitting it would report an endpoint the application does not answer.

**Where AI comes in.** A file carrying annotations no analyzer interprets is reported **by annotation
name**, not by framework name. Naming the framework would need a list of frameworks this build knows of
and cannot read — a closed allowlist by another route, which section 4 forbids. Annotation names are
evidence rather than a guess, and they are what makes the fallback well posed: those are the units worth
enriching, and the diagnostic says why.

An annotation on that list is not an error. Most annotations mean nothing to any framework.

### The reported question, answered

```text
endpoints  5 from spring

MATCH (e:Endpoint) RETURN e.method, e.path
GET  /temp                       GET  /auth/google/login
GET  /api/auth/callback/google   GET  /auth/google/register
GET  /auth/callback/google
```

Cross-checked against the source: five method-level mappings, all five present, the class-level
`@RequestMapping("/auth")` joined as a prefix and correctly absent as a route of its own. Each reaches its
handler through `HANDLED_BY`.

### Increment 5: zero rows was indistinguishable from zero rows

`CYPHER_UNKNOWN_LABEL` is registered and emitted. Nothing in an empty result had said the label was
unknown, so the empty table looked like a data problem and the explanation produced from it named the
wrong cause — reasonably.

A warning rather than an error, because a label may be absent since the project has none of that thing,
and a query written once and run against many databases must not become invalid because one lacks a
label. `MATCH` only: a label a query `CREATE`s is one the database is about to carry.

**And three severities that were wrong.** The registry declares a severity per code and `nostdb-core`
decided it again, with nothing holding the two together — so this landed as a warning in the registry, an
error in Rust, and printed `error:` for a query that had executed and returned what it was entitled to.

The root verifier now compares the two, and on its first run it found three more:
`LINK_UNAVAILABLE`, `LINK_CYCLE`, and `LINK_LIMIT_EXCEEDED` were registered as warnings and returned
errors. The rest of the Engine already treated them as warnings — `result.rs` makes each mark a result
**partial**, which only a warning can do to a result that returned rows — and `AGENTS.md` says outright
that an unavailable link "yields reachable partial results plus a structured warning".

They went unnoticed because the test that checked severity **exempted exactly those three codes**. The
exemption list was not a convenience; it was the reason nobody knew. It now names the seven warnings and
requires every other code to be an error, with nothing tolerated in between.

### A mistake worth recording

I pushed three failing tests. The command that was supposed to gate the push ran the suite, the linter,
and the verifier in one `&&` chain that an `echo "verifier=$?"` had already broken, so the commit ran
unconditionally and I read the exit codes afterwards. Fixed in the next commit and stated in its message.

The lesson is not "be careful". It is that a gate written as a chain of `&&` with anything printed in the
middle is not a gate, and every check in this session that reported success while proving nothing has had
the same shape: something between the test and the assertion.

### Verification

`nostdb-core` 771 tests, `nostdb-cli` 95, `nostdb-server` 28, every verifier, and the root's new severity
comparison: `62 codes, 7 Engine warnings agree`. `GRAPH_SCHEMA_VERSION` is 4.

**Not published.** Stages 13 through 18 all reach nobody without a release.

## Release 0.1.2, and an entrypoint nothing could start

Six Stages reached a published build: the Kotlin analyzer, the bundled GitHub provider, the plugin index,
Spring route extraction, `CYPHER_UNKNOWN_LABEL`, and the pin and diagnostic corrections around them.

A **patch** number, chosen after 0.2.0 was recommended. What it understates is recorded beside the version
in `Cargo.toml` rather than only here: `plugin_install_version` went 1 to 2, so a plugin record an older
build wrote is refused rather than read, and `GRAPH_SCHEMA_VERSION` went 2 to 4, so the first build after
this redraws. Nothing has such a record — no published build could install a plugin, because the provider
was never bundled until this release — which makes the cost zero in practice and does not make the break
smaller.

### The draft caught a defect the suite did not

Verifying the draft, `plugin add` reported success and `nostdb view` then failed:

```text
PLUGIN_FAILED: .../org.nostdb.view-webgpu/bin/nostdb-view could not be started: Permission denied
```

A plugin is executed out of process by path, so a file written without an executable bit is a plugin
nothing can start — and the failure arrives three commands after the thing that caused it.

The archive assembler has checked its own executable bit since the first release, on the stated grounds
that "a tar that lost the bit produces an install nothing can run". **Installation had no equivalent
check.** The same defect in the other half of the same journey, and the reason it survived is that both
halves were verified separately and nobody walked the whole path until a release forced it.

Two decisions in the fix:

- **only the declared entrypoint**, and not according to a mode the source supplied. A remote tree saying a
  file is executable is not a reason to make it so: installation must produce a plugin that can start,
  which is one file, and marking the rest would widen what a plugin can do because its author said to;
- **an entrypoint the plugin lacks is refused at `add`**, where somebody is watching. `PLUGIN_FAILED` at
  the first action that needs it names the symptom instead of the cause, which is exactly how this
  presented.

The draft was discarded and rebuilt rather than patched, so nothing published ever held it.

### What was verified before anything became public

- all **twelve** digests recomputed from the assets they name — four archives and, for the first time, two
  programs inside each;
- each of the four archives confirmed to hold `nostdb` **and** `nostdb-provider-github`;
- the darwin-arm64 archive extracted and walked end to end with `NOSTDB_GITHUB_PROVIDER` unset:
  `build` found a Spring route, `plugin add` installed the viewer from the pinned index, and `view`
  rendered and wrote its output;
- the launcher packed, installed from the tarball, and run — it fetched, verified, reported
  `engine 0.1.2`, and unpacked the provider beside `nostdb`;
- each of the four formula digests checked against the downloaded artifact rather than copied on trust.

### The reported question, from the registry

```text
npx --yes --package=nostdb nostdb build --project .
analyzed   48 files    recorded 71 files    endpoints 5 from spring

MATCH (e:Endpoint) RETURN e.method, e.path
GET /api/auth/callback/google   GET /auth/callback/google   GET /auth/google/login
GET /auth/google/register       GET /temp
```


## Reported: `File` and `Endpoint` had no schema

`/.nostdb/root.nost` used `File`, `Directory`, `Endpoint`, `Struct`, `Method`, `Field`, `Function`,
`Trait`, and `Enum`, and declared a schema for none of them.

### It was valid, and the contract says why

`nost_language_version` section 5.3.3 permits a record to name a schema nothing declares, and
`nostdb check` reported the file valid. So this was not a conformance failure and is not recorded as one.

What the section also says is that the consequence is **"accepted rather than solved"**: a misspelled
schema name is indistinguishable from an intentional bare label, and "no syntax can tell the two apart
while schemas remain optional."

That is the same gap `CYPHER_UNKNOWN_LABEL` had just closed on the query side, unclosed on the file side.
And the Engine is in a position nobody else is: it knows the shape exactly, because it wrote the records.

### The decision, and what it costs

A schema declaration carries no `@by` in version 2 and `Schema` carries no owner in Core, so an
Engine-declared schema is indistinguishable from a hand-written one. Three options were put, and the one
chosen was **write them unowned and accept clobbering**, over a `nost_language_version` 3 bump.

So the cost is real and stated rather than softened: **a hand-written `schema File { … }` is replaced on the
next build.** What was built to keep that from being silent, without inventing ownership:

- the build reports `replaced_schemas` when the stored form **differed** from what it declares. An
  identical one is not reported, because nothing was lost;
- a schema naming a label the Engine does not write is **kept**. A user's schemas for their own records are
  nobody's business here, and replacing the whole list would delete them.

They are also not change-set operations, because there is no operation for a schema: a change set carries
contributions and validates their owner, and a thing with no owner does not fit it. This is the one thing a
build writes outside its change set, and that is stated at the line that does it.

### Node schemas only

An endpoint constraint names one source schema and one target schema. `CONTAINS` legitimately runs
`Directory -> File`, `Directory -> Directory`, `File -> Struct`, `File -> Endpoint`, and `Struct -> Method`
— so no edge schema is declared, because declaring any one of those shapes would raise a violation on every
edge of the others.

### What the tests pin

Both directions: a label with no schema fails, and a schema naming a label nothing writes fails. The item
labels are read from `label_for` rather than listed twice, so adding an `ItemKind` fails here instead of
quietly gaining a label with no schema.

Every required field is checked against the properties a record actually carries — a schema requiring a
field the writer never sets would make every record of that label raise `NOST_SCHEMA_VIOLATION`, which
would be worse than declaring nothing. And the materialized `.nost` is reparsed and validated: declaring
schemas produced **zero** violations.

### The reported file

```text
schema Constant   schema Directory   schema Endpoint   schema Enum    schema Field
schema File       schema Function    schema Impl       schema Method  schema Module
schema Struct     schema Trait       schema TypeAlias  schema Union

.nostdb/root.nost: valid
```

`GRAPH_SCHEMA_VERSION` is 5. **Not published**: 0.1.2 does not have this.

## Release 0.1.3: one release number, and a Skill that says it follows latest

Requested: update everything, have the Skill always target latest, unify the versions, and pick the lowest
number npm will take.

**0.1.3**, because npm holds 0.1.2 and a registry never goes backwards. Every package and crate now carries
it: `nostdb-core`, `nostdb-cli`, `nostdb-server`, `nostdb-provider-github`, `nostdb-spec`,
`nostdb-distribution`, the reference plugin, and the Skill — nine places that held four different numbers.

### Contract versions were not unified, and that is the substance of the request

"Unify the versions" read literally would set `nost_language_version`, `nostdb_format_version`,
`plugin_install_version`, `manifest_version`, `provider_protocol_version`, and the rest to 0.1.3 as well.
That was **not** done, and the reason is the whole point of them. `VERSIONS.md` states it:

> Changing the `.nostdb` container layout must not invalidate a `.nost` file, and adding a plugin action
> must not renumber the daemon protocol.

Fourteen contracts each answer a question a release number cannot. Giving them one number would make every
one of them mean the same thing, which is to say nothing — and `nostdb --version --json` reports them
separately precisely so a caller can ask about one without being told about all.

So: package versions unify, contract versions stay independent. The distinction is recorded in each commit
that moved a number, because that is where somebody will next be tempted to move the others with it.

### The Skill declares what it already did

`engine: latest` in the frontmatter. The default path already resolved `npx --yes --package=nostdb nostdb`,
unpinned — nothing said so, and every `0.1.0` in the Skill's prose is history explaining why `--project` is
used rather than a pin.

Checked **both** ways, because they drift in opposite directions: a frontmatter line claiming `latest` while
the script emits a pinned command is a promise nothing kept, and a script that happens to be unpinned with
nothing declaring it should be is one commit from being pinned by somebody who reads it as an oversight.

`metadata.version` is the Skill's own version and moves with the release number. Stated in the definition,
because a reader seeing one number there would reasonably assume the Skill was tied to that Engine.

A caller who asks for a version still gets it pinned, and that is tested. Removing it would leave no way to
pin at all, and the contract objects to an unpinned *fallback* — what happens when nobody chose — not to
pinning on request.

### A version that drifted, caught by eye

The release walk showed `plugin add` reporting `org.nostdb.view-webgpu 0.1.3` and the render reporting
`0.1.0`, two lines apart. The viewer keeps its own `NAME` and `VERSION` constants, and the version drifted
the moment the manifest was bumped.

A viewer that misreports its version reports it into the exchange stream, where a caller has no other source
for it. The `plugins` verifier now requires both constants to equal the manifest's and is proven to reject.

The draft was discarded and rebuilt against the corrected plugin, so nothing published held it. This is the
second release in a row where the draft caught something the suites did not — the first was an entrypoint
written without an executable bit.

### Verified before publishing

Twelve digests recomputed, both programs confirmed in all four archives, the darwin archive walked end to
end with the provider variable unset (`build`, `export --nost`, `check`, `plugin add`, `view`), the launcher
packed and installed from its tarball, and every formula digest checked against the download.

### From the registry, on the reported repository

```text
npx --yes --package=nostdb nostdb build --project .
analyzed 48 files    endpoints 5 from spring

schemas in the .nost: 14        .nostdb/root.nost: valid
npx resolves engine 0.1.3
```

Every Stage from 13 through 18 is now in a published build.

## Stage 19 scope

Requested: builtins for many programming languages, and for video, audio, and text files. The request
divided into three pieces with different characters, and only two of them are this Stage's to build.

1. **Naming a language** already existed for 28 languages and was cheap to widen. Done in increment 1.
2. **Analyzing a language** costs roughly 2,100 lines each — `rust.rs` is 1,412 and `rust_lexer.rs`
   about 700 — so which languages are analyzed is a decision, not a detail. Six were chosen: Java
   first, then TypeScript/JavaScript, Python, Go, C++, and C.
3. **Files that are not code** are not in the graph at all today. The first plan was to record them
   from the scan, which contradicts a `MUST` in the PRD; the resolution is that they are not recorded
   from the scan at all. See below — the conflict dissolved rather than being decided.

| Increment | Content | Status |
| --- | --- | --- |
| 1 | language naming widened from 28 languages to 69, and the table's invariants pinned | DONE |
| 2 | Java: the analyzer, and Spring coverage for Java projects | DONE |
| 3 | TypeScript and JavaScript: the language layer, which the web layer has nothing to read without | DONE |
| 4 | Python | DONE |
| 5 | Go | DONE |
| 6 | C and C++ | DONE |
| 7a | imports become graph facts, which two analyzers already claim to produce | DONE |
| 7b | an import target that is not code as an `Asset` joined to what references it | DONE |
| 7c | the web framework layer: a `Component` of its own, above the file that holds it | DONE |

### Increment 1: naming is not analyzing, and the table says so

`LANGUAGES` went from 42 extensions naming 28 languages to 95 naming 69, and `NAMED_FILES` from 6 to
12. The additions are the languages a report kept calling `unknown`: Dart, Elixir, Erlang, Clojure,
F#, Groovy, R, Nim, Crystal, Solidity, PowerShell, Racket, Scheme, Terraform, HCL, Nix, Protobuf,
GraphQL, Prisma, Vue, Svelte, Astro, SCSS, Sass, Less, XML, XSLT, INI, Java properties, Objective-C++,
Pascal, Fortran, assembly, batch, Elisp, ERB, Handlebars, TeX, Jupyter, and VB.NET.

Three invariants are now tested rather than described:

- the table stays **sorted with no duplicate extension**. `language_of` takes the first match, so a
  second row for one extension is unreachable and silently decides which language wins. Sortedness is
  what makes a duplicate visible in a diff;
- an **ambiguous extension stays unnamed**. `.m` is Objective-C and MATLAB, `.v` is Verilog and V,
  `.s` is assembly for several assemblers, `.pro` is Prolog and a Qt project file, and `.d` is D and a
  make dependency file. A misnamed file says something false where an unnamed one says nothing, so the
  test asserts these are absent and a later addition has to argue with a test rather than a comment;
- **naming a language is not claiming to analyze it.** `dart` resolves and `is_supported("dart")` is
  false, so precision stays `Unsupported` until an analyzer exists. This is the line the rest of the
  Stage must not blur, and it is what makes a report say "42 Dart files, unsupported" instead of "42
  unclassified files".

Commands: `cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings`,
`cargo test --all-targets --all-features` (787 passed, 0 failed), `./scripts/verify-repository.sh`.

### Recorded, not fixed: a file that is not code has nowhere to be

Video, audio, and every other binary file is **absent from the graph**, and not by oversight:

```rust
pub fn looks_binary(bytes: &[u8]) -> bool {
    bytes.iter().take(BINARY_SNIFF_BYTES).any(|byte| *byte == 0)
}
fn skip(&mut self, relative: &str, reason: SkipReason) { self.scan.skipped.push(/* not files */) }
```

An MP4, MP3, or WAV holds a NUL byte in its first 8 KiB, so it is `SkipReason::Binary`. A file over
`DEFAULT_MAX_FILE_BYTES` — 2 MiB, which most video exceeds — is `SkipReason::TooLarge` before it is
read at all. Either way there is a coverage record and no Node, so nothing can query it.

`docs/PRD.md` section 17.2 is why this is not simply a defect:

> The scanner MUST: (…) **skip binary and oversized files unless an analyzer explicitly supports
> them**;

Recording a File Node for an unanalyzed video from the scan contradicts that `MUST`. It was the plan
for about an hour, and the escape clause is not a way around it either: `AnalyzerCapability` is keyed
by a language string and `register` rejects an empty `facts` list, and the only members of `FactKind` a
media file could honestly claim are `File` and `ContentHash` — both of which the scan already produces.
An analyzer that reads no internals would be declaring a capability it does not add, which is the
claim `PrecisionClass` exists to prevent.

### The conflict dissolves, because an asset is a fact about code

The requirement was never media metadata. It is that a frontend component referencing
`./assets/logo.png` is **joined to that asset in the graph** — a schema, a path, and an edge from the
component. Duration, codec, and resolution were never wanted.

That is a fact about **analyzed source**, not about the binary:

- the scanner still skips the file. It is never read, never sniffed, never analyzed, and section 17.2
  is satisfied exactly as written;
- the Node comes from the `import` statement in a component the analyzer *did* read;
- `FactKind::ImportExport` already exists, so the capability is honest;
- `FactKind` and `ItemKind` need no new member, so the closed-enum question is not on this path.

Nothing about the scanner changes. The whole feature lives where imports are turned into graph facts,
which is where the defect below already lives.

### Recorded and to be fixed here: `ImportExport` is declared and never produced

`rust::capability()` and `kotlin::capability()` both declare `FactKind::ImportExport`. Neither produces
it. `build.rs` reads `analysis.items` and never `analysis.imports`; the only consumers of `imports` are
`cache.rs`, which serializes it, and `spring.rs`, which reads it to recognize a framework. No import
relation type exists — the build emits `CONTAINS`, `CALLS`, `FOR_TYPE`, `HANDLED_BY`, and `IMPLEMENTS`.

Reproduced on the reported repository, whose Kotlin sources do contain `import` statements:

```text
772 :CONTAINS    307 :CALLS    9 :HANDLED_BY
```

This is Stage 18's defect again, one fact kind over: there, `Endpoint` was a label nothing produced and
the query returned zero rows on every build that had ever existed. Here a caller asking
`capability.extracts(FactKind::ImportExport)` is told `true` and then finds nothing, which is worse than
an absent capability because it is a promise.

So increment 7a fixes the declaration by making it true, and 7b is the asset case of the same
mechanism: an import target that resolves to no code becomes an `Asset` rather than a Placeholder for a
symbol that was never a symbol. Increments 2 through 6 are unaffected — a language analyzer is squarely
inside what section 17.2 already permits.

### Increment 7a: the declaration is now true

`IMPORTS` joins a file to a file it imports from, and `FactKind::ImportExport` stops being a promise.
`GRAPH_SCHEMA_VERSION` is 6, because the version is part of every parse cache key and a new relation
changes what a build asserts.

**Resolved by path correspondence, never by name.** An import is a path written in the language's own
separator, and the file it names is that path on disk: `a.b.C` is `.../a/b/C.kt`, `crate::helper::Thing`
is `.../helper.rs`. Both separators are normalized, the last segment is dropped as a second candidate so
one rule serves a language whose import ends in a declaration and one whose import ends in a symbol
inside a module file, and a leading `crate` or `self` is stripped because it names the root rather than
a directory under it. A candidate that two files answer to resolves to neither, which is the rule the
name index already uses.

Matching by last segment would have been cheaper and wrong. A project declaring exactly one `List`
would have had `import java.util.List` resolve to it, and the graph would assert that a file imports a
class it does not import. That case is a test rather than a caution: a suffix of a real path cannot be
produced by an import naming something outside the project, so a dependency is counted in
`unresolved_units` exactly as an unresolved call is.

Correspondence is anchored on a separator, so `a/b/at` is not found by `a/b/Cat.rs`, and a trailing
`/mod` is dropped so a directory module is imported by its directory's name.

Five tests: an internal import becomes an edge, a dependency never matches a same-named local
declaration, a `use` ending in a symbol finds the module file, an ambiguous path resolves to neither,
and correspondence is anchored.

Commands: `cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings` (clean),
`cargo test --all-targets --all-features` (784 passed, 0 failed), `./scripts/verify-repository.sh`.

### Found while placing 7a: the Kotlin analyzer discards the package it documents

`src/analyze/kotlin.rs`'s table of what it reads says:

> | `package a.b` | the file's package, on every qualified name below |

It is not on any qualified name. The parser consumes the declaration and drops it:

```rust
Some("package") => {
    self.advance();
    self.qualified_name();   // the return value is not bound
}
```

The reported repository proves it — every Kotlin record is `AuthController` or
`AuthController::googleLoginUrl`, never `com.meerdog.api.AuthController`. So the documentation
overstates what the analyzer records, which is the same class of defect as a capability declaring a fact
kind nothing produces.

Not fixed here, and 7a does not need it: path correspondence resolves imports without any package
information, which is why it was chosen. Fixing it means putting the package on every qualified name,
and a qualified name is an identity — every Kotlin record in every existing database would be retired
and re-minted. That is what `GRAPH_SCHEMA_VERSION` exists for, but it is a migration to run
deliberately rather than as a side effect of an import edge.

### Increment 2: Java, and the layer earning its keep

`java_lexer.rs` and `java.rs`, registered in `builtin_registry` and in `analyze`. 32 tests.

**A separate lexer, for the reason the Kotlin one gives about Rust.** Java is the closest case yet —
same platform, same annotation syntax — and still a different grammar where a lexer cannot be wrong:
a **block comment does not nest**, so `/* /* */ */` closes at the first terminator and reading it
Kotlin's way swallows the rest of the file; there are **no string templates**, so `"${a}"` is four
ordinary characters; there are **no backtick identifiers**, so `Token` carries no flag for one; and a
**text block opens on three quotes followed by a line terminator**, so `""` beside `"x"` is two
strings rather than a text block holding the rest of the file. Each of those is a test.

Two decisions the analyzer records rather than guesses:

- **every supertype is a reference, and `implements` is never claimed.** Java writes `extends` and
  `implements` separately and looks like it distinguishes them, but an `interface` also writes
  `extends` for what it inherits, and at syntactic precision nothing here can tell which name is a
  class. Kotlin's analyzer reached the same conclusion from the same problem;
- **no `Constant` is produced.** Kotlin records one for a `val` at file scope and Java has no file
  scope. Recording `static final` as a Constant would make one declaration two kinds depending on its
  modifiers, and nothing downstream asks that question.

Java has no keyword introducing a method or a field, so the two are told apart by what follows the
name: a `(` makes it a method. That is the whole rule, and it is the one a reader uses — which is why
`Map<String, List<Integer>> grouped()` needs the type walked before the name is known.

**Spring came for free, and that is the layer's whole claim discharged.** Nothing in
`framework/spring.rs` mentions Java: it reads `FileAnalysis`, and an analyzer producing the same
annotations reaches it. A Java `@RestController` with `@GetMapping` now yields the same `Endpoint`
records a Kotlin one does, proven by a test in `spring.rs` that runs the Java analyzer through the
same `framework::analyze`. Spring is predominantly Java, so until now the framework layer covered the
smaller half of its own ecosystem.

One behavior changed while writing it. A stray `}` at file scope used to end the parse, which would
hide every declaration after it in a file somebody is partway through editing; it is now skipped.

Commands: `cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings` (clean),
`cargo test --all-targets --all-features` (818 passed, 0 failed), `./scripts/verify-repository.sh`.

### Increment 3: TypeScript and JavaScript, and the import bug they exposed

`typescript_lexer.rs` and `typescript.rs`, registered for both languages. 38 tests in the analyzer, 16
in the lexer.

**One lexer and one analyzer for both languages**, which is the opposite of the call made for Java, and
for a reason: every JavaScript file is a TypeScript file that declares no types. `interface`, `type`, and
`enum` do not appear in a `.js` file and cost nothing to read for. Java and Kotlin share a platform and
not a grammar; these two share a grammar. Two capabilities are registered so a caller asking about
`javascript` gets an answer, and they declare the same facts and version because it is one analyzer.

Two ambiguities decide whether anything after them reads correctly, and both are tested:

- **a `/` is division or a regex, and only the previous token says which.** `a / b` divides;
  `return /ab+/.test(x)` does not. A regex holding `{`, `"`, or `'` is ordinary, so reading one as
  division unbalances every brace after it and moves every later declaration into the wrong scope. The
  rule is decided from the previous token, with the keywords that may precede an expression listed;
- **a template literal nests.** `` `${ {a: `${b}`} }` `` holds a brace, an object, a nested template, and
  a string inside a string. This is Kotlin's problem again and worse, because templates are how
  JavaScript writes most of its strings.

**JSX is read as punctuation, and the cost is recorded rather than hidden.** No element grammar: a
structural analyzer wants the declarations around JSX, not inside it. The one cost is that JSX text
holding an apostrophe — `<p>don't</p>` — opens a string that runs to the end of the line. It cannot run
further, because a quoted string stops at a newline, so the damage is one line of one body and never the
file's brace balance. A test states it.

#### The bug increment 3 found in increment 7a

`imported_file` normalized dots to slashes, which is right for `a.b.C` and **destroys a filesystem
path**: `./assets/logo.png` became `//assets/logo/png`, which names nothing. Every relative TypeScript
import resolved to no file and was counted unresolved — and the asset case increment 7b exists for would
have silently produced zero edges.

The resolver now tells the two shapes apart by the leading `.` or an embedded `/`, which a dotted module
name never has. A relative path is joined to the importing file's own directory with `.` and `..`
resolved, then matched whole. Three spellings of one file are accepted — as written with its extension,
without one, and as a directory holding an `index` — because those are the forms every JavaScript
toolchain agrees on. A `tsconfig` alias, a package `exports` map, and a bundler rewrite are not resolved,
because guessing at one would put a file in the graph that nobody imported.

A path built at run time records nothing. The lexer keeps a template's `${...}` as written and emits it
as text like any other string, so an interpolated path is rejected where it is pushed — while
`` require(`./m`) ``, a template with no interpolation, is a static path and is still recorded.

Commands: `cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings` (clean),
`cargo test --all-targets --all-features` (860 passed, 0 failed), `./scripts/verify-repository.sh`.

### Increment 7b: an asset is a fact about code, and the scan already knew it was there

`ASSET_LABEL`, its schema, and its resolution. `GRAPH_SCHEMA_VERSION` is 7. Six tests in `build`, one
end to end through a real build and a real graph in `project`.

**Nothing in the scanner changed, which is the whole point.** A `.png` still holds a NUL byte in its
first 8 KiB, is still `SkipReason::Binary`, and is still never read, sniffed, or analyzed. Section 17.2
is satisfied exactly as written. What changed is that an import naming it is now resolved, and the
record it produces exists because **analyzed source references the path** — not because the scan found a
file.

The scan had already recorded what was needed. A skipped file leaves a `SkippedSource` carrying its path
and its reason, so an asset asserts only what is known: something at this path was imported, it was
skipped, and this is why. Duration, codec, and resolution are absent because reading them means opening
the file, which is the thing forbidden and which nothing about an import requires.

Identity and ownership follow `Directory` rather than `File`, because an asset is the same kind of thing:
observed by the scan, read by no analyzer, and identified by its path. `existing_asset` keeps the
identifier across a rebuild, one path is one record however many components import it, and the tree unit
owns it — owning it through one importing file would delete it when that file stopped importing it while
another still did.

Two refusals are tested rather than described:

- **an excluded file is not reachable through an import.** `Ignored` and `Sensitive` never become
  assets. The exclusion is the decision, and a route into the graph that bypassed it would make
  `.gitignore` and the sensitive list advisory rather than binding. Only `Binary` and `TooLarge` qualify,
  which are the two reasons that mean "a real file nobody read";
- **only a relative path names an asset.** `react` and `a.b.C` name a module through a resolution rule
  this build does not implement, so matching either against a skipped file would be a guess. There is no
  `index` fallback and no extension guessing either: `./logo` is not `./logo.png` to any toolchain
  without a loader configured, and inventing that rule would attach a component to a file it does not
  import.

The end-to-end test writes a real PNG signature, builds the project, and asserts the shape a query
answers: `MATCH (f:File)-[:IMPORTS]->(a:Asset)` reaches the image, the sibling module is reached by the
same relation with a `File` on the other end, and `react` reaches neither.

One relation for both, not two. An asset import and a module import are the same syntactic fact, and the
label is what separates them — which is how a Cypher reader would ask the question anyway.

**What is left of the original 7b** is the framework layer itself, now increment 7c. `FrameworkAnalysis`
carries `frameworks`, `endpoints`, and `uninterpreted`, and `trait Framework`'s only fact method is
`endpoints`, so a `Component` record of its own needs that widened. The asset requirement did not need
it: a `.tsx` file is the component in the convention every one of these frameworks follows, and
`File -[:IMPORTS]-> Asset` is the join that was asked for.

Commands: `cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings` (clean),
`cargo test --all-targets --all-features` (866 passed, 0 failed), `./scripts/verify-repository.sh`,
`./scripts/verify-workspace.sh`.

### Increment 4: Python, whose blocks are not delimited by anything

`python_lexer.rs` and `python.rs`. 19 tests in the analyzer, 13 in the lexer.

**The lexer emits `Indent` and `Dedent` where every other language has a brace.** Indentation is not a
character to count; it is a comparison against the enclosing line. Resolving it once in the lexer means
the analyzer reads the same shape it reads for Java or TypeScript, rather than carrying a column on every
declaration and comparing against its parent at each site that asks.

Three rules decide where a block ends, and each one was a bug before it was a test:

- **a newline inside brackets is not a newline.** `f(\n  a,\n)` is one logical line. The first attempt set
  the at-line-start flag on any newline, so the flag stayed on until the bracket closed and then the first
  real newline after the `)` was consumed as a blank line by the indentation measurement — the statement
  and the declaration after it ran together;
- **a comment-only line produces no newline at all.** Leaving its newline behind made it a logical one,
  so a comment between two methods ended a statement that had already ended — an extra empty statement in
  the middle of a class body;
- **a file ending inside a block still closes it**, or the last declaration waits for a `Dedent` that
  never comes and every member of a trailing class is lost.

A triple-quoted string is one token, because a docstring is the first thing in most bodies and holds `#`,
quotes, and blank lines. An f-string's replacement field is tracked like a template literal, and the
quotes inside it belong to it: pushing only the content turned `{a['k']}` into `{a[k]}`, a different
expression.

**A relative import keeps its dots.** `from . import x` records `.` and `from ..pkg import y` records
`..pkg`. Dropping them names a different module and a plausible one, which is worse than naming none.

**An instance attribute is not a declaration.** `self.total = 0` names something every reader would, and
at syntactic precision there is no telling it from an assignment to something else called `self`, nor one
declaration from a reassignment in another method. A class body's bindings are recorded because they are
unambiguous.

#### A test that asserted the opposite of its own name

`a_file_no_analyzer_reads_is_recorded_rather_than_dropped` used a `.py` file as its example of an
unsupported language. Python gaining an analyzer made it assert the reverse of what it was written for,
and it would have kept passing the two lines under it. It now uses Markdown — named so a report can say
what it is, and a prose format no structural analyzer is ever coming for. The comment says why, so the
next analyzer does not silently invalidate it again.

Commands: `cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings` (clean),
`cargo test --all-targets --all-features` (898 passed, 0 failed), `./scripts/verify-repository.sh`.

### Increment 5: Go, and the receiver no other language here writes

`go_lexer.rs` and `go.rs`. 15 tests in the analyzer, 8 in the lexer, and one in `build` for the edge.

**A method states its own owner.** `func (s *Service) Do()` declares the method *and* says what type it
is on, in the declaration itself. Every other language in this module puts a method inside its type's
body, so containment says whose it is; Go's methods may live in any file of the package, and often not the
one the type is declared in.

So the method is recorded at file scope with its `target` naming the receiver's type, and `build` draws
the `FOR_TYPE` edge from it — the same edge a Rust `impl` block produces. That condition was
`Implementation` only and is now `Implementation | Method`, which is additive: nothing else sets a target
on a method, because every other language answers the question by containment.

What is deliberately **not** done is inventing a grouping declaration to hold the methods. Rust has an
`impl` block because somebody wrote one; manufacturing one here would put a declaration in the graph that
appears nowhere in the source, and a test asserts none is created. The pointer is dropped from the target,
because `*Service` and `Service` are one type to a reader asking what methods it has.

#### Semicolon insertion, left out and then required

The lexer's first version said implementing it "would add a rule with no reader", on the reasoning that
braces delimit every body. That is wrong, and three tests failed in the same way to prove it: Go
terminates **a grouped declaration and a struct field with the inserted semicolon**, not with a brace. So
`const ( A = 1 / B = 2 )` had no boundary between `A = 1` and `B`, `Name string` after an embedded field
read `string` as a second embedded type, and an interface's second method name was consumed as part of the
first one's result type.

It is now implemented as the specification states it, and the analyzer's field, value, and result-type
boundaries are the semicolon rather than a guess about what token comes next. The module documentation
says so instead of claiming the opposite.

A raw string in backticks is the one form nothing else here has: it honours no escape and spans lines, so
one holding `{`, `"`, or `//` must not unbalance the file or start a comment. A rune literal is consumed
for the same reason — `'}'` read as punctuation closes a body that is still open.

`InterfaceImplementation` is **not** declared. Go satisfies an interface implicitly, so stating one needs
a type checker; declaring the fact would advertise coverage no syntactic analyzer can have.

Commands: `cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings` (clean),
`cargo test --all-targets --all-features` (922 passed, 0 failed), `./scripts/verify-repository.sh`.

### Increment 6: C and C++, where the import statement is a preprocessor directive

`c_lexer.rs` and `c.rs`, registered for `c`, `cpp`, and `objcpp`. 20 tests in the analyzer, 11 in the lexer.

**A directive is one token, not punctuation.** `#include <vector>` is this language's import statement, and
its argument is a header name that only *looks* like a comparison. Lexed as punctuation it becomes `#`,
`include`, `<`, `vector`, `>`, and reassembling a path from that means deciding — in the analyzer, at every
call site — whether a `<` opened a header name or a template argument list. So a directive line is one
token carrying its name and the rest of its logical line as written, and the code between directives is
tokenized normally.

**Both arms of a conditional are read.** `#ifdef` cannot be evaluated without the build's flags, and a
declaration inside a branch is a declaration the source contains. Reading one arm means picking a build;
reading neither loses whole files of platform-specific code. So a graph may hold two declarations no single
build compiles, which is stated rather than hidden.

**An out-of-line definition names its class the way Go's receiver does.** `void Service::Do() { … }` is
recorded with `Service` as its target, so `build` draws the same `FOR_TYPE` edge without knowing which
language wrote it — the mechanism added for Go, reused without change.

Four defects the tests caught, each a rule that looked right:

- `typedef int (*Callback)(void);` named the alias **`void`**. The declarator is in the first parenthesis
  group and the parameter list in the second, so a later group must not overwrite the name;
- a **union's members were file-scope constants.** The field-or-constant question was decided on `Struct`
  alone, and a union holds fields exactly as a struct does;
- `using namespace std;` declared a constant called **`std`**, by falling through to the declarator rule.
  A `using` that brings a name into scope declares nothing and is consumed;
- `struct S *p;` declared nothing at all. The type keyword names a type rather than declaring one, and the
  declarator after it is still a declaration — so it is read rather than skipped.

**A macro's expansion is absent rather than guessed at.** `DECLARE_CLASS(Foo)` declares a class in many
codebases and is a call here, because expanding it means implementing the preprocessor and knowing the
build's flags. `#define NAME` is recorded as a `Constant`, which is the part that is written down.

`objcpp` is registered as its own language rather than folded into `cpp`, because a file using Objective-C's
message syntax and `@interface` yields its C++ declarations and not its Objective-C ones. A report can name
that; folding it in would report coverage the analyzer has not got.

Commands: `cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings` (clean),
`cargo test --all-targets --all-features` (953 passed, 0 failed), `./scripts/verify-repository.sh`.

### Increment 7c: the web layer, and the first analyzer honest enough to call itself heuristic

`framework/react.rs`, `Component` and `Recognition` on the framework layer, `COMPONENT_LABEL`, and
`DECLARED_BY`. `GRAPH_SCHEMA_VERSION` is 8. 9 tests in the analyzer, 2 in `build`.

The layer carried one fact kind — `endpoints` — and now carries two. `trait Framework` gained
`components`, defaulted to none so an analyzer for a framework with no such concept does not have to say
so. A route holder is not a component: one is reached by an HTTP request from outside the program, the
other is rendered by something else inside it.

**A record of its own, not a second label on the declaration.** The tempting alternative was to add
`Component` to the `Function` node the language analyzer already wrote. That fails on ownership: a
framework analyzer declares its own version, and section 11.3 lets a change set withdraw only its own
contributions — so a label on somebody else's record could not be withdrawn when the framework analyzer's
version moved. `Endpoint` settled this already, and the same answer holds.

`DECLARED_BY` rather than `HANDLED_BY`, because the two say different things: an entry point is *served
by* a handler it names, and a component *is* its declaration seen through a framework's eyes. One relation
for both would make "what serves this route" and "where is this component written" the same question.

#### The first `Heuristic` analyzer, and why that is the honest class

Spring's precision is `DeterministicSyntactic` because a route is written down: `@GetMapping("/x")` says
what it is. A React component is mostly a **convention** — a capitalised function — and `Wrapper`,
`Fragment`, and `Layout` are all names a helper might have. So this analyzer declares
`PrecisionClass::Heuristic`: "pattern-based, so a fact may be wrong in ways the analyzer cannot detect".

That is the first use of the class, and it is what section 17.3 exists for. Two refinements keep it from
being a blunt instrument:

- **recognition is carried per component**, not taken from the analyzer's class. A class extending
  `Component` is `declared` and a capitalised function is `convention`, because one analyzer knowing some
  facts exactly and others by convention is the ordinary case — collapsing them would make the exact ones
  look like guesses;
- **the evidence follows.** A `declared` component is `Extracted`; a `convention` one is `Inferred` with a
  score of 0.8. Reporting a capitalised function as extracted would say the source declared what it only
  implied. `Score::literal` was added for the constant, mirroring `NonEmptyText::literal` and for the same
  documented reason: an infallible fallback without `unwrap`, crate-internal so runtime data cannot reach
  it.

The capitalisation rule is the one **JSX itself enforces** — `<Card />` is a component and `<div />` is a
tag — so it is the framework's convention rather than one invented here, which is why it is worth reading
at all. `SCREAMING_CASE` is excluded: `MAX_RETRIES` is a constant by every convention in the language.

Recognition requires an import of `react`, `react-dom`, or `next/`. Without it the signal would be "this
file declares a capitalised function", which every file in every language does. A `.vue`, `.svelte`, or
`.astro` single-file component is **not** read: each is its own grammar with a template section this build
has no reader for, so such a project gets no components and an honest capability report rather than a
partial list that looks complete.

Commands: `cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings` (clean),
`cargo test --all-targets --all-features` (964 passed, 0 failed), `./scripts/verify-repository.sh`.

### Stage 19 closed

Ten languages analyzed — c, cpp, objcpp, go, java, javascript, kotlin, python, rust, typescript — and 69
named. Two framework analyzers, spring and react, on a layer that now carries entry points and components.
Imports are graph facts for the first time, and a file the scanner skips is an `Asset` when analyzed source
imports it.

Four defects were found in code that already existed, each passing its own tests at the time:

1. `FactKind::ImportExport` was declared by two analyzers and produced by neither — Stage 18's defect, one
   fact kind over;
2. `imported_file` normalized dots to slashes, which is right for `a.b.C` and destroyed `./assets/logo.png`;
3. `a_file_no_analyzer_reads_is_recorded_rather_than_dropped` used a `.py` file, so Python gaining an
   analyzer made it assert the reverse of its own name;
4. the Kotlin analyzer's documentation claims the package appears on every qualified name, and the parser
   discards it. **Still open**, and recorded above: fixing it re-mints every Kotlin record in every existing
   database, which is a migration to run deliberately.

### Recorded decision: `web` is a layer above TypeScript, not a replacement for it

Raised: that the frontend work might be better factored as `web` than as TypeScript and JavaScript.
Right about where the facts belong, and it does not remove the language increment.

`framework::analyze` takes `&FileAnalysis` and nothing else, and only a language analyzer produces one.
Until a TypeScript analyzer exists there is no `FileAnalysis` for a `.tsx` file, so a `web` analyzer has
nothing to read. The two are different layers and one feeds the other; `web` is additive.

What is right is that a component, a route, and an asset reference are **not language facts**, which is
the argument this layer's own documentation already makes about `@GetMapping` meaning nothing to Kotlin.
So they belong beside `spring` rather than inside a TypeScript analyzer, and `spring` shows the shape:
`Endpoint` and `HANDLED_BY` are HTTP routing, so **half of "web" is already built, on the JVM side.**

Two consequences worth recording now:

- if analyzers are ever split into independently released units, the split is by **layer first**: a web
  crate holds `spring`, `react`, and the rest across every language they are reached from, and a
  TypeScript crate holds the lexer and the item extraction. A single `nostdb-analyzer-web` holding both
  would put a lexer in a crate named for a domain, and the next language reaching those frameworks
  would need the framework knowledge written a second time — the exact cost this layer exists to avoid;
- the framework layer currently carries **one fact kind**. `FrameworkAnalysis` holds `frameworks`,
  `endpoints`, and `uninterpreted`, and `trait Framework`'s only fact method is `endpoints`. Components
  and asset references need that widened before 7b can land, which is part of 7b's cost rather than a
  surprise inside it.

## Stage 20 scope

Asked: extract API endpoints, database entities, and their schema from a Spring Boot project. The first
works; the rest do not, and the reason they do not is where this Stage starts.

`spring.rs` interprets eight annotations, all of them routes. `@Entity` and `@Table` are reported
**uninterpreted** — by name, which is the honest record and the AI-fallback signal. Reading them
deterministically runs into `FactKind` having eighteen members, every one a code concept, with nothing for a
table.

**The direction chosen, and it routes around that entirely:** relation types are not pre-specified in Core,
so the Skill carries **presets** — a vocabulary the model's proposals follow and the Engine validates. A
preset may be added or modified without touching Core.

### Why the premise holds

`RelationName` is `validated_name!` — an identifier with a reserved-word check and no list. The
`CONTAINS`/`CALLS`/`FOR_TYPE` constants in `build.rs` are the **builtin analyzer's vocabulary**, not a
Core-wide closed set. An edge schema is expressible in the language too:
`schema Name(Source -> Target) { … }`. `build.rs` declares none only because `CONTAINS` legitimately runs
between five different shapes, which one constraint cannot describe — a preset relation with one shape has
no such problem.

And `FactKind` does not apply on this path. It is part of `AnalyzerCapability`, which a **deterministic
analyzer** registers to say what it extracts. An AI contribution registers none: its owner is
`@by ai "<contract-digest>"`, its evidence carries `method: ai_inferred` and `confidence: inferred(score)`,
and no fact kind is named. So the closed enum that blocks a builtin JPA analyzer does not block this.

### What a preset is for, in the spec's own words

`nostdb-spec/docs/NOST_LANGUAGE.md` states a consequence it accepts rather than solves:

> A record MAY name a schema that is never declared. (…) a misspelled schema name is indistinguishable from
> an intentional bare label, and it silently becomes an unvalidated label. **No syntax can tell the two
> apart while schemas remain optional.**

A preset is what fixes the vocabulary on the **producing** side, which is the only side where the two can
be told apart. Without one, a model proposing `Entity` on Monday and `JpaEntity` on Tuesday produces two
unvalidated labels and no error, and the graph holds both readings for ever.

### Route A, and the mechanics it actually has

Records reach the graph through `nostdb apply`, whose own help already says an AI Skill proposes one. That
path is complete today and validates the generation, the endpoints, the ownership, and the evidence.

Schema **declaration** has no route through a change set: `GraphOperation` has `UpsertNode`, `UpsertEdge`,
`RemoveContribution`, `ResolvePlaceholder`, `UpsertLink`, and `RemoveLink`, and `build.rs` says why there is
no seventh — "a change set carries contributions and validates their owner, and a thing with no owner does
not fit it". Schemas are unowned.

**That does not block the Stage**, because a record may name an undeclared schema and schema validation is
soft. So a preset's records apply today, and declaring the preset's schemas is a separate act through the
canonical `.nost`. Route B — a change-set operation for a schema — would need schema ownership decided
first, which is the same open question as retiring a superseded owner.

### The boundary this must not cross

A preset is a **vocabulary and a validation target**. The Skill must not derive facts from one AI-free: that
would be a second analyzer, reading annotations the Engine's own analyzers do not read, and the root
contract's rule that an AI-free action has the CLI do the work exists to prevent exactly that. The
interpretation is the model's, and the validation is the Engine's — including validating the preset itself,
which is a `.nost` document `nostdb check` reads.

| Increment | Content | Status |
| --- | --- | --- |
| 1 | this scope, the preset format, and a JPA preset the Engine validates | DONE |
| 2 | the Skill surface: listing presets AI-free, and proposing with one | DONE |

### Increment 1: the preset is a `.nost` document, so the Engine validates it

`skills/nostdb/presets/jpa.nost` and `presets/index`, with `scripts/presets.sh` reading them and
`tests/presets.test.sh` in the repository verifier.

**A preset is a `.nost` file and nothing else**, which is what keeps the Skill from growing a reader. The
suite hands each one to `nostdb check` when an Engine is on the path, and the JPA preset reports `valid`. A
malformed preset therefore fails before it is ever offered to a model, and the Skill validates nothing
itself.

The index is pipe separated rather than JSON, because the script reading it is `/bin/sh` and this repository
ships no `jq`. A JSON index would mean a dependency an install cannot assume, or a parser written in shell —
and a parser in the Skill is the thing this boundary exists to avoid.

The vocabulary is six schemas: `Entity`, `Column`, `Repository`, and the edges `HAS_COLUMN`,
`REFERENCES_ENTITY`, `SERVES`. Two decisions worth recording:

- **one association relation with a `cardinality` property, not four relation types.** `MANY_TO_ONE` and
  `ONE_TO_MANY` are the same fact read from either end, and a query asking what an entity references would
  otherwise have to name every direction to avoid missing one;
- **`table` and `column` are optional.** `@Entity` alone is legal, and the table name then follows from the
  provider's naming strategy — configuration this graph has not read. Absent says "not written down", which
  is a different claim from a guess at what the provider would pick.

Two rules the suite enforces, and both are about a schema being **unowned**:

- **no preset declares a label a build already writes.** A preset sharing a name with `File`, `Endpoint`,
  `Component`, or any item label is replaced on the next build; the preset would vanish and the only sign
  would be a warning;
- **no preset declares a label called `Schema`.** NostDB already has schemas — a preset is made of them —
  and `MATCH (s:Schema)` would mean two things at once. This is the naming collision the question that
  opened this Stage walked straight into.

### Increment 2: listing is the Skill's, checking is the Engine's, applying is the model's

Three actions, and the split between them is the boundary:

| Action | AI usage | Who does the work |
| --- | --- | --- |
| `/nostdb preset` | none | the Skill lists its own files; `preset-check` hands one to `nostdb check` |
| `/nostdb preset jpa` | required | the model interprets, the Engine validates |

`preset-apply` sits beside `query-natural` and `enrich` in the dispatcher's refusal, and the comment there
says why: **deriving a fact from a preset without a model would make the Skill a second analyzer**, reading
annotations the Engine's own analyzers do not read. That is exactly what the AI-free rule prevents, and a
preset is the most tempting place to break it — the vocabulary is right there, and `@Entity` looks easy.

A preset is chosen **by the Engine's own report**, not by naming a framework. A build says which annotations
it saw and did not interpret, and `presets.sh for Entity` answers which preset covers one. Naming the
framework would need a list of frameworks this build knows of and cannot read, which section 4 forbids by
another route — the same trap `framework.rs` documents about reporting uninterpreted annotations by name.

`presets.sh for` matches a whole name between commas, so `Id` does not match `GeneratedValue`. A substring
match would claim a preset for an annotation nobody wrote a schema for.

One bug found while writing it, and it is an awk one worth remembering: assigning to `$1` to trim it makes
awk **rebuild `$0` with its output separator**, so the `|` the format is made of was gone by the time the row
was printed. Trimming into a variable instead leaves the record intact.

### Stage 20 closed

Records reach the graph through `nostdb apply`, whose help already said an AI Skill proposes one. Schema
**declaration** still has no change-set operation, and does not need one: a record may name an undeclared
schema and validation is soft, so a preset's records apply today. Route B — a seventh `GraphOperation` —
stays unopened, and would need schema ownership decided first.

Commands: `./scripts/verify-repository.sh` (skills), and the preset suite run separately with an Engine on
the path so `nostdb check` reads every preset.

## Stage 21 scope

Asked whether a Kotlin file's character is being decided by its name. For one edge it is, and the answer is
narrower and worse than the question: `IMPORTS` is the only relation resolved from a file name, and for
Kotlin a file name is not allowed to carry that weight.

`imported_file` (`nostdb-core/src/build.rs`) turns `import com.demo.app.Payload` into the path
`com/demo/app/Payload` and looks for a scanned file whose path corresponds to it. That is the whole
resolution. It has to be, because both analyzers read the package declaration and **throw it away**:

```rust
Some("package") => {
    // The package a file joins, not a declaration in it. Consumed so its dots do not
    // read as anything else.
    self.advance();
    self.qualified_name();
}
```

With no package held anywhere, the only thing an import can be matched against is a name in the tree.

### Why this is sound for Java and unsound for Kotlin

Java requires a public top-level class to sit in a file of the same name, so path correspondence agrees
with the language. Kotlin requires nothing of the kind: `class Payload` may be declared in `Models.kt`,
one file may declare many top-level classes, and `import com.demo.app.doThing` names a top-level function
that belongs to no file of its own name at all.

Two failures follow, and the second is the one that matters:

- **a missing edge.** `Payload` declared in `Models.kt` matches no path, so the import is counted
  unresolved and no edge is drawn. Silent, and common;
- **a wrong edge.** A `Payload.kt` that exists in that package and declares something else is matched
  anyway, and the graph asserts that a file imports a class the file does not declare.

`imported_file`'s own documentation already rejects exactly that second failure as the reason it does not
match on a last segment: "the graph would assert that a file imports a class it does not import." Path
correspondence avoids the last-segment version of the error and reintroduces the same error for a language
whose file names are free.

### The direction, and why the earlier objection does not apply

Record the package as a file-level fact and resolve a dotted import against a **declared** fully-qualified
name — the target file's package joined to a top-level declaration in it — falling back to path
correspondence only for a file that declared no package.

`java.rs` states why the package was dropped: "a qualified name is an identity, and putting the package on
one would retire and re-mint every record in every existing database." That objection stands and this does
not meet it. The package goes on the **file**, not into any item's `qualified` name, so no record's identity
changes. Nothing is retired and nothing is re-minted.

### Scope

- `FileAnalysis` carries the package a file declares, `None` where a language declares none;
- `kotlin.rs` and `java.rs` record it instead of discarding it, and both analyzer versions bump, because an
  analyzer that extracts a new fact is not the analyzer that did not;
- the file node carries it as a property, and the `File` schema declares it optional;
- a dotted import from a file that declared a package resolves by declared FQN only. No path fallback
  there: path correspondence is the guess being removed, and a miss is the honest answer, because most
  imports in any real file name a dependency this build never scanned;
- `GRAPH_SCHEMA_VERSION` bumps, so an existing database redraws rather than keeping edges the old rule drew;
- the stale row in `kotlin.rs`'s module documentation, which claims the package is put "on every qualified
  name below" and never was, is corrected.

Out of scope: Go's package, whose imports are paths and are already resolved as paths; star imports, which
name a package rather than a file and stay unresolved; and the `analyzer_owner` oddity that names every
builtin contribution `rust` regardless of the language read, which is a separate defect.

### Stage 21 acceptance criteria

1. a Kotlin class declared in a differently-named file resolves from an import of its package-qualified
   name;
2. a file whose name matches an import but which declares nothing of that name receives no `IMPORTS` edge;
3. a Java import continues to resolve, by declaration rather than by file name;
4. a dotted import naming something outside the build stays unresolved and draws no edge;
5. `cargo fmt --check`, `cargo check`, `cargo clippy --all-targets --all-features -- -D warnings`,
   `cargo test --all-targets --all-features`, and `./scripts/verify-repository.sh` pass in `nostdb-core`.

### Stage 21 verification

Commands, all in `nostdb-core`:

```
cargo fmt --check
cargo check
cargo clippy --all-targets --all-features -- -D warnings
cargo test --all-targets --all-features   # 971 passed, 0 failed
./scripts/verify-repository.sh            # nostdb-core verification passed
```

And in the root: `./scripts/verify-workspace.sh` — workspace verification passed.

Both defects were reproduced before being fixed rather than argued about. With the resolver switched back to
path correspondence, the two new tests fail exactly as the scope predicted:

- `a_kotlin_declaration_in_a_differently_named_file_resolves` — `left: []`, no edge drawn to the file that
  declares `Payload`, because it is called `Models.kt`;
- `a_file_named_for_an_import_it_does_not_declare_gets_no_edge` — an edge drawn to
  `com/demo/app/data/Payload.kt`, which declares `Other`. The graph asserting an import of a class the
  target does not declare, which is the failure `imported_file`'s own documentation rejects.

A third fell out of the same rule and was not anticipated in the scope: a star import. `import com.demo.data.*`
matched a file called `data.kt` under path correspondence, because dropping the last segment turned the
package into a name. `a_star_import_names_a_package_and_draws_no_edge` pins it, and `imported_declaration`
rejects a trailing `*` outright rather than walking it back.

### What the existing tests already proved

`an_import_naming_a_file_in_this_build_becomes_an_edge` and
`an_import_naming_a_dependency_is_never_matched_by_name` write real Kotlin with real `package` lines, so they
resolve through the new rule without being touched and still pass. The first now resolves by declaration; the
second still refuses `java.util.List` in a project that declares exactly one `List`, which is what the rule
was chosen for.

`an_import_two_files_answer_to_resolves_to_neither` declares no package and therefore still exercises path
correspondence — the fallback is live and covered, not dead code.

### Decisions worth recording

- **the package is on the file, not on a qualified name.** `java.rs` already stated the objection to the
  alternative: a qualified name is an identity, and moving a package into one would retire and re-mint every
  record in every existing database. That objection is untouched. `Payload` is still `Payload`, and the tests
  in both analyzers assert it;
- **no path fallback for a file that declared a package.** Falling back would have kept the wrong edge:
  `Payload.kt` declaring `Other` is exactly the case where the FQN misses and the path hits. An unresolved
  import is the honest answer, and the coverage counter already reports it;
- **Go keeps `None` deliberately.** Go writes `package main`, but a Go import names a directory rather than
  the package clause in it, so recording the clause would put a fact in the graph that nothing resolves
  through and would route every Go import onto a rule that cannot answer it. Written as a comment at the
  construction site so it does not read as an omission;
- **both analyzer versions bumped to 2**, which is what makes a stored parse artifact from the earlier
  analyzer miss rather than be read back as complete. `GRAPH_SCHEMA_VERSION` bumped to 9, which is the
  migration for a database that holds edges the old rule drew.

### Left undone, and why

`analyzer_owner` names every builtin contribution `rust` regardless of the language read, so a Kotlin file's
contributions are owned by `Analyzer { name: "rust", version: … }`. Untouched here: it is a real defect and a
separate one, and changing an owner rewrites the ownership identity of every existing record, which is a
migration that deserves its own Stage rather than a line in this one.

Downstream is unaffected for now. `nostdb-cli` and `nostdb-server` depend on `nostdb-core` by pinned
revision, so re-pinning them onto this change is a separate act and needs authorization, along with the
commit and push it requires.

### Stage 21 closed

Every Acceptance Criterion passes. An import now resolves to what a file declares; a file named for a
declaration it does not make receives no edge; a Java import still resolves, by declaration; a dotted import
naming something outside the build stays unresolved and counted.

## Stage 22 scope

Asked to remove analyzer version management, after establishing that which analyzer read a file does not
matter. The scope chosen is the `AnalyzerCapability.version` axis and the seven language analyzer `VERSION`
constants behind it.

### Two version axes, and only one is in scope

Surveying before editing found a contract the question had not accounted for. There are two:

- **`AnalyzerCapability.version`** — what an analyzer *declares* about itself, `docs/PRD.md` section 17.3.
  Read in exactly one place, `analyzer_version` in `build.rs`, which feeds the parse cache key and evidence.
  Removable within the root PRD and the Engine. **In scope**;
- **`Owner::Analyzer { name, version }`** — section 11.3, and it is not only a PRD field.
  `nostdb-spec/docs/CHANGE_SET.md` states "an analyzer's version is part of its identity", and
  `nostdb-spec/docs/NOST_LANGUAGE.md` makes `analyzer "<name>" "<version>"` **required** grammar. Removing it
  is a `.nost` language change with a `@nost` version consequence. **Out of scope**, and untouched.

The distinction is what makes this Stage possible without touching the grammar.

### What replaces each use

- **the parse cache key.** `analyzer_digest` becomes the language alone. Shape versioning moves entirely to
  `graph_schema_version`, which is already a separate component of the same key;
- **evidence `producer_version`** for a language analyzer becomes `GRAPH_SCHEMA_VERSION`. Section 11.4 keeps
  requiring the field — it was not in scope to remove — and this is the number that actually tracks what a
  build asserts about a file;
- **`analyzer_owner`** must keep producing `Analyzer { name: "rust", version: "1" }` **byte for byte**. It
  read `rust::VERSION` for the version, so deleting that constant requires freezing the literal in place.
  This is the hazard `build.rs` already documents: an owner nothing can withdraw leaves every record an
  earlier build wrote unremovable, fresh units minted beside them, and both readings of every file held for
  ever. The frozen constant is not an analyzer's version and says so;
- **framework analyzers keep `react::VERSION` and `spring::VERSION`.** They are not among the seven and they
  are a different producer: `react` is `Heuristic` and `spring` is `DeterministicSyntactic`, they write their
  own records, and their evidence names them. Only the `version` field of their declared capability goes.

### The cost, accepted when the option was chosen

Per-language cache invalidation is lost. A change to one language's parser that leaves the record shape alone
will be served from a stale artifact unless `GRAPH_SCHEMA_VERSION` moves, where before bumping that language's
own constant was enough.

Two hand-maintained numbers become one, which is the honest reading: it is coarser and there is less to
forget. `GRAPH_SCHEMA_VERSION`'s documentation is rewritten to say what it now governs — any change to what an
analyzer produces, not only a change to the shape of a record.

### Stage 22 acceptance criteria

1. `AnalyzerCapability` declares no version, in `docs/PRD.md` section 17.3 and in the Engine;
2. the seven language analyzer `VERSION` constants are gone;
3. `analyzer_owner` still returns `Analyzer { name: "rust", version: "1" }`, pinned by a test, so no existing
   database holds records nothing can withdraw;
4. an existing database still reuses an unchanged file and still redraws one whose `GRAPH_SCHEMA_VERSION`
   moved;
5. `cargo fmt --check`, `cargo check`, `cargo clippy --all-targets --all-features -- -D warnings`,
   `cargo test --all-targets --all-features`, and `./scripts/verify-repository.sh` pass in `nostdb-core`, and
   `./scripts/verify-workspace.sh` passes in the root.

### Stage 22 verification

Commands, in `nostdb-core`:

```
cargo fmt --check
cargo check --all-targets --all-features
cargo clippy --all-targets --all-features -- -D warnings
cargo test --all-targets --all-features   # 973 passed, 0 failed
./scripts/verify-repository.sh            # nostdb-core verification passed
```

And in the root: `./scripts/verify-workspace.sh` — workspace verification passed, including
`version conformance: 13 contracts verified`, which is unaffected: it checks the independently evolving
format and protocol versions, and an analyzer's declared version was never one of them.

### What was removed, and what was found in the way

Removed: `AnalyzerCapability.version` from `docs/PRD.md` section 17.3 and from the Engine, the seven
language analyzer `VERSION` constants, and `analyzer_version` in `build.rs`, its only reader.

Two things the survey caught that the plan had to route around:

- **`FrameworkCapability` is a different struct** with its own `version` field, and `react`/`spring` build
  it. The first pass removed those too and the compiler caught it. Restored: they are not among the seven,
  they are a different producer with its own precision, and their evidence is what tells a reader a route
  was found by `spring/1` rather than by a later reader with wider coverage;
- **`analyzer_owner` read `rust::VERSION`** for its version half, so deleting that constant would have
  changed the owner every existing database holds. `OWNER_NAME` and `OWNER_VERSION` freeze `"rust"` and
  `"1"` in place, and `the_analyzer_owner_is_frozen_at_what_existing_databases_hold` pins both. Without that
  test the value was right only by inspection, which is how it would have moved eventually.

`Owner::Analyzer`'s version is untouched, and `an_analyzer_version_is_part_of_its_identity` in
`contribution.rs` still asserts it. That is the axis `nostdb-spec` declares and `.nost` requires as grammar,
and it was out of scope by design rather than by omission.

### What replaced each use

- `analyzer_digest` in the parse cache key is the language alone. Still per language, because two analyzers
  must not share one identity, and `one_analyzer_never_reads_anothers_work_back` was renamed and rewritten to
  guard what it now actually guards — a Kotlin parse handed to a reader asking for Rust — rather than a
  newer version of one analyzer, which can no longer arise;
- `producer_version` on a language analyzer's evidence is `GRAPH_SCHEMA_VERSION`. Section 11.4 still requires
  the field: attribution stopped being versioned, provenance did not stop being required.

### The cost, stated where it will be read

`GRAPH_SCHEMA_VERSION` is now the only number of its kind, which widens what obliges a bump. A parser that
starts recording a declaration it used to skip changes what a build asserts even when every label and property
is identical, and a warm cache serves the old answer until that number moves. Its rustdoc says so in those
words, because the next person to change a parser reads that and not this file.

Stage 21 is the worked example: it bumped `kotlin` and `java` from 1 to 2 *and* the schema version. Under this
Stage the schema version alone would have carried it, and forgetting it would have left the fixed bug live on
any machine with a warm cache.

### Stage 22 closed

Every Acceptance Criterion passes. `AnalyzerCapability` declares no version in the PRD or the Engine, the
seven constants are gone, the analyzer owner is frozen and pinned by a test, and reuse still turns on an
unchanged digest while a moved `GRAPH_SCHEMA_VERSION` still forces a redraw.

## Stage 23 scope

Asked to respell one Skill surface flag: `/nostdb . --nost` becomes `/nostdb . --export nost`, with the
question of whether the value takes an `=` left to judgment.

### The judgment on `=`: it takes one

`--export=nost`, because the surface already answers this question about itself. Its only other
value-taking flags are `--ai=off` and `--ai=full`, both written with `=`, and the whole surface is thirteen
lines long — a second spelling style in a table that short is a rule a reader has to learn twice.

The space form is also genuinely ambiguous here in a way it is not in a shell. A model maps this surface to
an action, and `/nostdb . --export nost` puts a bare word after a positional path in a surface where paths do
appear: `/nostdb .nostdb/root.nost --sync` is a row of the same table. Whether `nost` is the flag's value or a
second path is a question `=` does not raise.

The CLI accepts both spellings for every value flag it has — `--project VALUE` and `--project=VALUE`,
`--format` likewise — so the Skill documents `=` as canonical and states that the space form is understood
too. Being stricter than the CLI the Skill extends would be a difference with nothing behind it.

### What changes, and what deliberately does not

The **surface** changes. The action name `build-nost` and the CLI command it emits,
`nostdb export --nost <path>`, do not.

That is the boundary this repository's own invariant draws: an action "need not be one CLI command, or be
named after one — what is fixed is who does the work, not how the request is spelled". The CLI's `--nost` is
required and is the only representation that build exports, so generalizing the emitted command would be
inventing a format the Engine does not have. Renaming the action would churn the dispatcher and its fixtures
to change an identifier no user types.

One consequence worth stating: the Skill's `--export=nost` and the CLI's `export --nost` now read
differently, where before they matched. The documentation says which is which at the one place it maps a
surface to a command.

### Scope

- `SKILL.md`: the surface listing, the prose about what a build does not write, and the `Serves` column of
  the action map;
- `ACTIONS.md`: the table row and the prose about omitting the flag;
- `tests/dispatch.test.sh`: the comment and label naming the surface flag. The command it asserts,
  `ENGINE export --nost .`, is unchanged and must stay unchanged — that is the point of the boundary above.

`help.sh` reads the surface out of `SKILL.md` rather than copying it, so it follows without being touched.

### Stage 23 acceptance criteria

1. no shipped document offers `/nostdb . --nost`;
2. the emitted CLI command is still `nostdb export --nost <path>`;
3. the cross-check between `SKILL.md`'s action map and `ACTIONS.md`'s table passes, which is what would catch
   respelling one and not the other;
4. `./scripts/verify-repository.sh` passes in `skills`, and `./scripts/verify-workspace.sh` in the root.

### Stage 23 verification

Commands: `./tests/dispatch.test.sh` and `./scripts/verify-repository.sh` in `skills` — both every check
passed — and `./scripts/verify-workspace.sh` in the root, which passed.

The check that mattered is the cross-check, and it reported the new spelling on both sides:

```
ok   build-nost serves /nostdb . --export=nost, declared optional
ok   --export=nost emits the Engine's export --nost
```

The first is `SKILL.md`'s action map matched against `ACTIONS.md`'s table by literal string, so respelling one
document and not the other fails rather than shipping a Skill that promises an invocation nothing declares.
The second is the boundary: the surface moved and the emitted command did not.

`help.sh` was not touched and renders the new line already, because it reads the surface out of `SKILL.md`
rather than holding a copy. The column alignment of the block survived: `--export=nost` is seven characters
longer than `--nost` and the descriptions still start where every other row's does.

### Where `--nost` still appears, and why that is correct

Two places, both prose that exists to distinguish the two flags: `SKILL.md` where it maps the surface to the
command, and the test's comment on the same point. Nothing offers `/nostdb . --nost` as an invocation any
more.

### Stage 23 closed

Every Acceptance Criterion passes. No shipped document offers the old spelling, the emitted command is still
`nostdb export --nost <path>`, the map and the table agree, and both verifiers pass.

## Stage 24 scope

Stage 23 respelled a flag. This replaces it, because the flag was the wrong shape and Stage 23's own survey
is what shows it. `nost` becomes the default representation of a verb, with `--format` reserved for when the
Engine has a second one.

### What the Engine actually does, which decides this

`nostdb export --nost`'s own help says it "finds the nearest configured project" and writes the canonical
document, and that it **warns when `database.nost` is false, because the file is written but nothing will
keep it current**. It does not build, and it does not turn the setting on.

Nor can the Skill turn it on: the CLI's command list has no `settings` or `config`, so there is no command to
set `database.nost`, and a Skill writing settings itself would be a state change without the Engine.

So the action's honest description is a one-shot write plus a staleness warning — and `/nostdb . --export=nost`
described something else. A flag on a build reads as "this build now materializes", which is the one thing it
does not mean.

### Two further reasons the flag was wrong

- **it forced a rebuild on somebody who only wanted the document.** `build-nost` emitted `build && export`, so
  writing `.nost` from an already-built database re-analyzed the whole tree;
- **the surface is already verb-first**, in seven of thirteen rows. The rows that put a path first are the
  build and its true modifiers — `--ai=off` and `--ai=full` change *how* the build runs — plus `--sync`, which
  is on a different path entirely. `--export=nost` was the only flag on `/nostdb .` that requested a **second
  action** rather than modifying the one being asked for.

### `nost` is the default, and `--format` is reserved

`/nostdb export .` writes `.nost`. The CLI requires `--nost` precisely so that a later representation cannot
silently change what a bare `export` means, and that guard is not weakened here: the Skill **always emits
`--nost` explicitly**, so a bare export never reaches the Engine. The default lives in the Skill's surface,
where a person reads it, and is spelled at the boundary, where it is executed.

When the Engine gains a second representation the surface gains `--format=<name>`, spelled with `=` for the
reason Stage 23 recorded. It is **not documented now**: a shipped document promising an action the dispatcher
does not map describes a Skill that does not exist, which is what this repository's cross-check exists to
prevent.

### Scope

- `dispatch.sh`: `build-nost` becomes `export`, emitting `nostdb export --nost <path>` and nothing else. Same
  position in the case, because the AI-free set is compared in order against `SKILL.md`'s map;
- `SKILL.md`: the surface row, the prose about what a build does not write, the action map row — whose AI usage
  becomes `none`, since an export involves no model at any setting — and the build section;
- `ACTIONS.md`: the table row and the prose about omitting the flag;
- `tests/dispatch.test.sh`: the action lists, the export assertion, and the "substituted everywhere, not
  prefixed once" check, which named `build-nost` because it named the command three times. An export names it
  once, so that check moves to `summary`, which names it five times.

The staleness warning is documented on the surface. Somebody will see it, and the Skill knowing it cannot turn
the setting on is exactly what it should say in advance.

### Stage 24 acceptance criteria

1. `/nostdb export .` is the surface, and no document offers `/nostdb . --export=nost` or `/nostdb . --nost`;
2. the emitted command is `nostdb export --nost <path>`, with no build and no `init` guard;
3. the emitted command never spells a bare `export`, so a future representation cannot change its meaning;
4. the cross-check between `SKILL.md`'s map and `ACTIONS.md`'s table passes, and the AI-free set still matches
   the dispatcher in order;
5. `./scripts/verify-repository.sh` passes in `skills`, and `./scripts/verify-workspace.sh` in the root.

### Stage 24 verification

Commands: `./tests/dispatch.test.sh` and `./scripts/verify-repository.sh` in `skills`, both every check passed,
and `./scripts/verify-workspace.sh` in the root, which passed.

```
ok   export emits exactly the Engine's export, with the representation spelled
ok   export neither builds nor initializes
ok   export serves /nostdb export ., declared none
ok   every occurrence is substituted, not just the first
```

The first pins the whole emitted command rather than matching a substring, which is what makes criterion 3
testable: a bare `export` fails the equality, so a future representation cannot change what this action means
by changing the Engine's default. The second is the new assertion — the old action emitted `build && export`
behind a flag, and nothing had ruled that out for an action named `export`.

### A check that would have silently stopped testing anything

"Every occurrence is substituted, not just the first" was anchored on `build-nost` **because** it chained
three commands. `export` emits one, so the check would have kept passing while proving nothing about
substitution — one occurrence is indistinguishable from a prefix. Moved to `summary`, which names the resolved
command five times.

Worth recording as a kind: removing a chained action can quietly disarm a test that was never about that
action, only about its shape.

### A reading error the reorder fixed

`--ai=off` is described as "the same, with enrichment refused", and "the same" refers to the row above it.
Putting `/nostdb export .` second split the `/nostdb .` family and left that phrase pointing two rows up at
something else. The export row moved below `--ai=full`, which keeps the build variants contiguous and puts
the two `.nost` document rows — `export` and `--sync` — beside each other.

The surface listing's order is independent of the action map's, which must stay aligned with the dispatcher's
case order because the AI-free set is compared in sequence. Only the listing moved.

### What Stage 23 got right and wrong

Stage 23's judgment about `=` stands and is why `--format=<name>` is the reserved spelling. What it got wrong
was accepting the premise that this is a flag on a build at all. Its own survey held the answer — the emitted
command was `build && export`, two actions — and the shape was not questioned because the request was about
spelling.

`--format` is deliberately not documented. The Engine has one representation, and a shipped document promising
an action the dispatcher does not map describes a Skill that does not exist.

### Stage 24 closed

Every Acceptance Criterion passes. `/nostdb export .` is the surface, the old spellings appear nowhere, the
emitted command is `nostdb export --nost <path>` with no build and no guard and no bare `export`, and both
verifiers pass.

## Stage 25 scope

Asked to respell the enrichment flag: `--ai=off` and `--ai=full` become `--scan=analyzer` and `--scan=ai`,
with `--scan=default` as the third value.

### It maps one to one onto what the Engine already has

`nostdb_core::settings::AiMode` has exactly three values, and the three names land on them without
remainder:

| Surface | `AiMode` | AI usage | Means |
| --- | --- | --- | --- |
| `--scan=analyzer` | `Off` | `none` | deterministic analyzers only, enrichment refused |
| `--scan=default` | `Auto` | `optional` | both, enrichment within the configured budget |
| `--scan=ai` | `Full` | `required` | enrichment is not optional and fails without a model |

The new names are better than the ones they replace, for a reason this workspace spent a while
establishing: the flag now names **which reader does the work** rather than whether AI is switched on.
`analyzer` and `ai` are the two readers, and the default is both.

### `--scan=default` is documented as a value, not as a surface row

Writing it changes nothing a bare `/nostdb .` does not already do, and the surface is a thirteen-line list
where a row whose description is "the same as the row above, with a flag that changes nothing" is noise. So
the two informative values get rows and `default` is named in the prose beside them, where somebody looking
for the spelling finds it.

### What this flag does and does not reach

Worth recording, because the flag looks like it is passed through and is not: **the CLI exposes no AI
option.** `ai_mode` is read from `.nostdb/settings.json` by the Engine, and the only place the CLI mentions
it is `plan` reporting what it found there.

So this flag governs what the *Skill* does around the build — which is what `ACTIONS.md` already says about
its predecessor, that it "is a filter over this column, not a hope". `--scan=analyzer` takes the `build`
action and refuses enrichment; `--scan=ai` takes `enrich`, which is `required` and has no AI-free mapping.
Neither adds an argument to a command.

### One naming collision, noted rather than resolved

`scan` already means something in the Engine: `scan.rs` enumerates and filters files, which is the step
*before* any analyzer runs. So `--scan=analyzer` reads as "scan with the analyzer" on the surface while
"scan" upstream means "find the files". The two do not meet anywhere a user can see — no CLI flag, document,
or diagnostic puts them side by side — so this is recorded as a thing that is true rather than a defect to
fix.

### Scope

- `SKILL.md`: the two surface rows, the `Serves` column of the `enrich` row, and prose naming the default;
- `ACTIONS.md`: the two table rows, the sentence about what the flag is a filter over, and the two places
  in "What `optional` means" that name it;
- `ENRICHMENT.md`: the row reading "`ai_mode` is `off`", which names the setting rather than the flag and is
  checked for whether it still reads correctly beside the new spelling;
- `tests/dispatch.test.sh`: the comment quoting the old spelling.

The action names `build` and `enrich` do not change. They are identifiers no user types, and the surface
spelling is decoupled from them by this repository's own invariant.

### Stage 25 acceptance criteria

1. no document offers `--ai=off` or `--ai=full`;
2. `--scan=default` is documented as an accepted value and has no surface row of its own;
3. the `enrich` action still serves the AI-required spelling, and the cross-check between `SKILL.md`'s map
   and `ACTIONS.md`'s table passes;
4. `./scripts/verify-repository.sh` passes in `skills`, and `./scripts/verify-workspace.sh` in the root.

### Stage 25 verification

Commands: `./tests/dispatch.test.sh` and `./scripts/verify-repository.sh` in `skills`, both every check passed,
and `./scripts/verify-workspace.sh` in the root, which passed.

```
ok   enrich serves /nostdb . --scan=ai, declared required
ok   enrich is not reachable AI-free
```

The first is the cross-check matching `SKILL.md`'s map against `ACTIONS.md`'s table by literal string, so
respelling one document and not the other fails. The second is the boundary the spelling must not move: an
AI-required action stays unreachable through the AI-free path.

`grep -- "--ai="` over the shipped skill and the tests returns nothing.

### The setting keeps its own name

`ENRICHMENT.md` has a row reading "`ai_mode` is `off`", and that was left as the setting's name because it is
the setting's name — `analysis.ai_mode` in `settings.json`, which the Engine reads. What changed is that the
row now says which surface value asks for it, so a reader meeting `--scan=analyzer` above and `ai_mode` here
is not left to infer that they are the same thing.

### Where this flag reaches, which is less far than it looks

The CLI exposes **no** AI option. `ai_mode` is read from `.nostdb/settings.json` by the Engine, and the only
place the CLI names it is `plan`, reporting what it found. So `--scan` adds no argument to any emitted command:
`--scan=analyzer` takes the `build` action and refuses enrichment, and `--scan=ai` takes `enrich`, which is
`required` and has no AI-free mapping at all.

That is what `ACTIONS.md` means by calling it "a filter over this column, not a hope", and it is why the
respelling touched no dispatcher case.

### Stage 25 closed

Every Acceptance Criterion passes. No document offers the old spellings, `--scan=default` is documented as an
accepted value with no surface row of its own, `enrich` still serves the AI-required spelling, and both
verifiers pass.

## Stage 26 scope

Asked for the option values to be visible in `/nostdb help`. They partly were and the part that was not is a
gap Stage 25 opened.

`help.sh` extracts the whole `## Surface` section, so the `--scan` table Stage 25 added does reach the output.
What does not reach the **compact block** — the fenced list a reader's eye goes to, and the only part of the
output that reads like a help screen — is the value set. It shows `--scan=analyzer` and `--scan=ai` as two
invocations and never says they are two of three, because Stage 25 deliberately gave `default` no row and put
it in prose below.

That decision was right about rows and wrong about visibility: a value nobody can see is not documented, it is
merely written down.

### The fix

An `Options:` block inside the same fence, listing every option that takes a value together with the values it
accepts. Two qualify: `--scan` and `--cypher`. `--sync` takes none, and `--format` does not exist — offering
it would document an action the dispatcher does not map, which is the thing Stage 24 refused to do.

The per-value rows stay. They carry what a value set cannot: that `analyzer` refuses enrichment rather than
skipping it quietly, and that `ai` fails outright without a model.

One sentence in the `--scan` table becomes false once `default` appears in the block — it says `default` "has
no line of its own in the surface above" — and is corrected rather than left to rot.

### Scope

- `SKILL.md`: an `Options:` block in the surface fence, and the corrected sentence;
- `tests/dispatch.test.sh`: the option values added to what the extracted surface must contain, so this cannot
  silently regress the way it just did.

### Stage 26 acceptance criteria

1. `/nostdb help` shows `--scan`'s three accepted values and `--cypher`'s argument, inside the compact block;
2. it offers no option the dispatcher does not serve — in particular no `--format`;
3. a test fails if a value disappears from the extracted surface;
4. `./scripts/verify-repository.sh` passes in `skills`, and `./scripts/verify-workspace.sh` in the root.

### Stage 26 verification

Commands: `./tests/dispatch.test.sh` and `./scripts/verify-repository.sh` in `skills`, both every check passed,
and `./scripts/verify-workspace.sh` in the root, which passed.

```
ok   and says what every option accepts
ok   and names no option the dispatcher does not serve
```

### The second check failed first, on something real

Written to guard `--format` in the options block, it failed immediately — because the surface already named
`--format`, in the sentence Stage 24 added to the export subsection explaining that it is the reserved
spelling. Correct as rationale, and reaching the wrong reader: `help.sh` extracts the **entire** `## Surface`
section, so a person asking what the Skill can do was told about a flag that does nothing.

The sentence now says what a user needs — `nost` is the only representation, so there is no option to select
one — and points at this file for the reservation. The check was widened from the options block to the whole
surface, because where the name appears does not matter.

This is the second time in three Stages that the Surface section's double duty has bitten: it is both the help
screen and the place agent-facing prose about the surface lives. Recorded rather than fixed — separating them
means deciding what `help` is for, which is a larger question than an options block.

### What `Options` lists, and what it leaves out

`--scan` and `--cypher` take values, so both are there with what they accept. `--sync` is listed as taking
none, because a reader scanning a value set is exactly who would otherwise wonder. `--format` is absent for the
reason above.

The per-value invocation lines stay alongside it. They carry what a value set cannot: that `analyzer` refuses
enrichment rather than skipping it quietly, and that `ai` fails outright with no model.

### Stage 26 closed

Every Acceptance Criterion passes. The compact block shows `--scan`'s three values and `--cypher`'s argument,
names no option nothing serves, and a test now fails if a value disappears from it — which is what had already
happened once, silently.

## Stage 27 scope

Asked for two values instead of three: `--scan=default` meaning the analyzer judges and AI takes what it could
not, and `--scan=ai` meaning analysis by AI alone.

The first is delivered and is a real sharpening. The second is delivered as **AI required** rather than AI
alone, and this section records why the literal request is not implementable rather than quietly narrowing it.

### `--scan=ai` cannot mean AI alone

Two independent reasons, either sufficient:

- **no mechanism.** `nostdb build` takes `--rebuild`, `--format`, and `--project`. Nothing suppresses the
  deterministic analyzers, and the Skill invokes the CLI rather than analyzing anything itself. A surface
  offering it would promise an action no command performs;
- **the root contract forbids it.** "Structural analysis of supported source consumes zero external AI tokens"
  and "Build a valid structural database before optional semantic enrichment." An AI-first read of supported
  source spends tokens where the contract says zero and has no structural generation to commit before
  enrichment. `AnalysisPacket` is derived from the structural pass, so removing it leaves the whole-repository
  transcript the contract also prohibits.

So `--scan=ai` means the two passes still run and the **AI half is required**: the action fails without a model
instead of reporting a structural-only result. That is `AiMode::Full`, which is what it already mapped to.

The names now describe requirement rather than reader — `ai` does not mean "only AI". The descriptions say so
in the words a reader will act on, because a value whose name overstates it is worse than a longer name.

### What `default` now says, which is what was asked for

Previously "both, with enrichment inside the configured budget" — true and vague. Now: the deterministic
analyzers read what they cover, and AI is asked about what they could not resolve, within the budget. That is
what the pipeline does, so the surface finally describes it.

### What removing `--scan=analyzer` costs

It was `AiMode::Off` — no AI at all, enrichment refused rather than skipped quietly — and `ACTIONS.md` called
it the way the AI-usage column "means something: it is a filter over this column, not a hope". Dropping it
removes the only spelling a caller had for guaranteeing a build spends nothing.

Not a capability loss, a surface loss: `analysis.ai_mode` in `.nostdb/settings.json` still takes `off`, and the
Engine reads it. A project that must not spend tokens pins it there, which is more durable than remembering a
flag. Recorded because the guarantee moved rather than vanished, and somebody looking for the flag needs to
know where it went.

### Scope

- `SKILL.md`: the surface rows, the `Options` block, the `--scan` table from three values to two;
- `ACTIONS.md`: the `--scan=analyzer` row removed, the `--scan=ai` row reworded, the "filter over this column"
  sentence whose example that row was, and the two places in "What `optional` means";
- `ENRICHMENT.md`: the row naming `--scan=analyzer` reverts to naming the setting alone, which is where the
  guarantee now lives;
- `tests/dispatch.test.sh`: the pinned value set.

### Stage 27 acceptance criteria

1. `--scan` accepts exactly `default` and `ai`, and no document offers `analyzer`;
2. no document claims analysis by AI alone;
3. `default` is described as the analyzers first and AI for what they could not resolve;
4. the surface names where a no-tokens guarantee now lives;
5. `./scripts/verify-repository.sh` passes in `skills`, and `./scripts/verify-workspace.sh` in the root.

### Stage 27 verification

Commands: `./tests/dispatch.test.sh` and `./scripts/verify-repository.sh` in `skills`, both every check passed,
and `./scripts/verify-workspace.sh` in the root, which passed.

`grep -- "scan=analyzer"` over the shipped skill and the tests returns nothing. The rendered `Options` block
reads:

```
  --scan=default|ai                default: analyzers first, AI for what they could not
                                   resolve. ai: the same, with the AI half required
```

Two lines rather than one, because the difference between the values is the whole point and a single line could
only have named them.

### The one part not delivered as asked

`--scan=ai` does not mean analysis by AI alone, and the surface says so in those words: "**`ai` does not mean AI
alone.**" Two reasons, recorded in the scope above — no CLI option suppresses the deterministic analyzers, and
the root contract requires structural analysis of supported source to spend zero external tokens with a valid
structural generation committed before any enrichment.

Delivered instead: both passes always run, and `ai` makes the second one required, so a run without a model
fails rather than reporting a structural-only result. That is `AiMode::Full`, unchanged from what the value
already mapped to. What changed is that the documentation no longer lets the name imply more than the value
does.

### A stale comment the greps caught

`tests/dispatch.test.sh` explained why the action map is shipped rather than living in the test, using
`--scan=analyzer` and `build` as its example. The value is gone, so the example named a spelling nothing
offers. Now `--scan=ai` and `enrich`, which is the same point with a pair that exists.

### Stage 27 closed

Every Acceptance Criterion passes. `--scan` accepts `default` and `ai` and nothing else, no document claims
analysis by AI alone, `default` is described as the analyzers first with AI for what they could not resolve, and
the surface names `analysis.ai_mode: off` as where a no-tokens guarantee lives now that no flag carries it.

## Stage 28 scope

Asked to make the builtin owner `nostdb` and to carry an owner as one string rather than a structured
identity, without a separate id and without `@by`'s sub-parts.

Three of the four are delivered. `@by` itself stays, and the reason is in the grammar it belongs to.

### `@by` cannot be replaced by a single record field

`nostdb-spec/docs/NOST_LANGUAGE.md` section 5.6 states the consequence: without contribution blocks, "a
database exported to `.nost` and read back would collapse every contribution into one user-owned
contribution, which would break the root PRD section 11.3 guarantee that an analyzer refresh preserves user
edits."

Its own fixture shows why — one record carrying three contributions, each with its own source unit and its own
evidence:

```nost
@by analyzer "rust-structural" "0.1.0" unit "u_0198…" { @evidence { … } }
@by ai "sha256:1f0e…"                                { @evidence { … } }
@by user {}
```

A single `by:` property per record has nowhere to put the second one. So `@by` remains a block, and the
"one field" is the owner **inside** it.

### The single-string owner

| Was | Is |
| --- | --- |
| `@by analyzer "rust-structural" "0.1.0"` | `@by "rust-structural"` |
| `@by ai "sha256:1f0e…"` | `@by "ai:sha256:1f0e…"` |
| `@by user {}` | `@by "user"` |
| `"owner": {"kind":"analyzer","name":"rust","version":"1"}` | `"owner": "nostdb"` |

The kind is derived rather than declared: `user` is the user, an `ai:` prefix is AI analysis, and anything
else is an analyzer. Both are reserved names, which the spec must say out loud since an analyzer could
otherwise be called `user`.

`RelationName` is already a validated name with no closed list, and Stage 22 removed the analyzer version from
declared capability. An owner as one validated string is the same move on the last axis that still carried a
structure.

### The version leaves the owner, which is the point rather than a loss

`CHANGE_SET.md` says an analyzer's version is part of its identity so that "upgrading an analyzer MUST NOT
silently adopt the previous version's facts as the new version's own". That sentence is what produced the
hazard `build.rs` documents: an owner nobody can withdraw, because the version moved and the old records
answer to a name no change set names.

Not adopting them was never the behavior anyone wanted. A refresh replacing its **own** prior contributions is
the guarantee section 11.3 actually needs, and dropping the version from the owner is what delivers it. The
"retiring a superseded version" question `build.rs` records as open closes here.

### Migration happens on read, not at every comparison

`.nostdb` stores an owner behind a tag byte. The decoder keeps reading the three legacy tags and maps them
forward: `Analyzer { name: "rust", version: "1" }` becomes `nostdb`, any other legacy analyzer becomes its own
name, `AiAnalysis { digest }` becomes `ai:<digest>`, and `User` becomes `user`.

That is exact, because `analyzer_owner` was a single value and `rust`/`1` is the only analyzer owner an
existing database can hold. And it means `existing_unit` finds those records immediately and
`RemoveContribution` withdraws them normally — no alias at any comparison site, and no database left holding
two readings of every file.

### `@nost` stays at 2

The reader accepts both spellings and the canonical formatter writes only the new one, so a document converts
the next time it is reserialized. That is what a comment-preserving CST and a canonical formatter are for. The
fixture goldens changing to the new form is the evidence the conversion happens.

### Increments

| Increment | Content | Status |
| --- | --- | --- |
| 1 | the Core model: `Owner` as one string, derived kind, legacy decode, `nostdb` | DONE |
| 2 | `.nost` parser accepting both forms, formatter writing one | DONE |
| 3 | the change set document, and `nostdb-spec`'s schema, grammar, and fixtures | DONE |
| 4 | the root PRD section 11.3 | DONE |

### Stage 28 acceptance criteria

1. an owner is one validated string, and `user` and the `ai:` prefix are reserved;
2. the builtin owner is `nostdb`;
3. a database written before this reads back with its contributions withdrawable, proven by a test that
   builds under the old owner and refreshes under the new one;
4. `.nost` reads both spellings and writes the new one, with the goldens updated to match;
5. `cargo fmt --check`, `cargo check`, `cargo clippy --all-targets --all-features -- -D warnings`, and
   `cargo test --all-targets --all-features` pass in `nostdb-core`, both repository verifiers pass, and
   `./scripts/verify-workspace.sh` passes in the root.

### Stage 28 verification

`nostdb-core`: `cargo fmt --check`, `cargo check --all-targets --all-features`,
`cargo clippy --all-targets --all-features -- -D warnings`,
`cargo test --all-targets --all-features` — **982 passed, 0 failed** — and
`./scripts/verify-repository.sh` passed. `nostdb-spec`: `./scripts/verify-repository.sh` passed. Root:
`./scripts/verify-workspace.sh` passed.

The migration is pinned by five tests over the decoder, including the one that matters:

```
ok   the_legacy_builtin_owner_decodes_as_the_current_one
ok   a_legacy_ai_owner_decodes_with_its_contract_digest_intact
```

and by a `.nost` round trip, `the_legacy_builtin_owner_converts_to_the_current_one`, asserting that
`@by analyzer "rust" "1"` comes back out as `@by "nostdb"`.

### Four things the conformance suite found that the plan had not

Each one was a way to lose or reject something, and none was visible from the model change alone.

- **`nostdb-spec` owns an executable grammar**, in two encodings. `grammar/nost.pest` had to learn
  `named_owner`, and `grammar/nost.ebnf` had to declare the same rule name — a test enforces that the
  reference encoding and the normative EBNF define the same set, and it caught the omission;
- **the validator is a second reader of ownership**, separate from the converter. It required evidence of
  every contribution not written with the `user` **keyword**, so a document spelling the user as a name was
  invalid. Fixed by putting the derived kind on `OwnerDeclaration` itself, so the two cannot disagree about
  what `@by "user"` means;
- **the formatter was losing a field.** A legacy `analyzer "<name>" "<version>"` owner supplied a version its
  evidence blocks could leave unwritten. Converting the owner takes that away, so a document that was valid
  came back invalid. The version is now written into any block relying on it, sorted into canonical position
  rather than appended;
- **an AI owner must not supply a producer name.** The first pass inherited it from any non-user owner, which
  would have reported an enricher as `ai:sha256:…` — a digest where a tool name belongs. Only an analyzer
  supplies one, because only an analyzer's owner *is* one. A pre-existing test asserting that an `ai` owner
  requires both fields is what caught it.

### What `@by` kept, and why the request could not be met in full

`@by` stays a block. One record carries several contributions, each with its own source unit and evidence, and
`NOST_LANGUAGE.md` section 5.6 already stated the consequence of collapsing them: every contribution would
read back as one user-owned contribution, breaking section 11.3's guarantee that a refresh preserves user
edits. Its own fixture shows three on one record. A single `by:` property has nowhere to put the second.

The "one field" is the owner inside it, which is delivered: `@by "nostdb"`, `@by "ai:<digest>"`, `@by "user"`,
and `"owner": "nostdb"` in a change set.

### Stage 28 closed

Every Acceptance Criterion passes. An owner is one validated string with `user` and `ai:` reserved, the builtin
owner is `nostdb`, a database written before this reads back with its contributions withdrawable, `.nost` reads
both spellings and writes one, and all three verifiers pass.

## Stage 29 scope

Asked to remove the legacy owner support Stage 28 added rather than leave it in place.

### Removing it forces two version bumps, and they are the point

Both contracts already implement an explicit unsupported-version diagnostic, and that is what a removed
reader has to reach instead of a confusing one:

- **`.nostdb`**: without the legacy tags, an existing database's first owner byte is an unknown tag, and
  `DecodeError::UnknownTag` is what a *corrupt* file reports. `FORMAT_VERSION` goes 1 → 2, so the header check
  fires first and says "nostdb_format_version 1 is not supported by this build" — a database to rebuild rather
  than a database to fear;
- **`.nost`**: without the keyword forms, a document written by release 0.1.3 fails at `@by` with a parse
  error. `LANGUAGE_VERSION` goes 2 → 3, so it fails at the header instead, with the unsupported-version
  diagnostic the validator already raises.

The second bump is also the honest one for a different reason. `@nost 2` shipped accepting
`@by analyzer "<name>" "<version>"`. Removing that from version 2 would make version 2 mean two different
things depending on which build read it, which is exactly what a version field exists to prevent — and
`nostdb-spec`'s own rule is that every contract carries its own explicit version and no bump implies another.
These two are bumped independently, each for its own reason.

### What that costs, stated plainly

An existing `.nostdb` must be rebuilt. Structural analysis of supported source spends no external tokens and
is incremental, so a rebuild is cheap — but it is a rebuild, and any `.nost` written by hand under version 2
needs its owner spellings and its version header updated by whoever wrote it.

There is no migration path left after this Stage. That is what was asked for, and it is recorded here so the
decision is not rediscovered later as an accident.

### Scope

- `nostdb-core`: the three legacy `.nostdb` owner tags and their decode arms, the change set's object form,
  `OwnerDeclaration`'s three keyword variants — leaving one shape, so it stops being an enum — the version
  inheritance those variants supplied, the formatter's carried-version injection, `LEGACY_OWNER_NAME` and
  `LEGACY_OWNER_VERSION`, and the five decoder migration tests;
- `FORMAT_VERSION` 1 → 2, `SUPPORTED_FORMAT_VERSIONS` to match, `LANGUAGE_VERSION` 2 → 3, and every
  `@nost 2` header in the test suite;
- `nostdb-spec`: `named_owner` becomes the only owner rule in both grammar encodings, the "MUST also read"
  clauses go from `NOST_LANGUAGE.md` and `CHANGE_SET.md`, the legacy fixture is deleted, and all 53 fixture
  headers move to `@nost 3`;
- the root `docs/PRD.md`, wherever it names either version.

### Stage 29 acceptance criteria

1. no legacy owner spelling is accepted by the grammar, the parser, the decoder, or a change set;
2. an existing `.nostdb` reports an unsupported format version rather than an unknown tag;
3. a `.nost` document declaring version 2 reports an unsupported language version;
4. `cargo fmt --check`, `cargo check`, `cargo clippy --all-targets --all-features -- -D warnings`, and
   `cargo test --all-targets --all-features` pass in `nostdb-core`, both repository verifiers pass, and
   `./scripts/verify-workspace.sh` passes in the root.

### Stage 29 verification

`nostdb-core`: `cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings`,
`cargo test --all-targets --all-features` — **976 passed, 0 failed** — and `./scripts/verify-repository.sh`
passed. `nostdb-spec`: `./scripts/verify-repository.sh` passed.

**`./scripts/verify-workspace.sh` does not pass yet, and cannot from this working tree.** Its one remaining
failure is `version_conformance` in `nostdb-cli`:

```
assertion `left == right` failed: nost_language_versions
  left: [2]
  right: [3]
```

The CLI reports `SUPPORTED_LANGUAGE_VERSIONS` and `SUPPORTED_FORMAT_VERSIONS` from the Core revision the root
**pins**, which is the one before this Stage. It will report `[3]` and `[2]` once re-pinned, and not before.
So this criterion completes with the pin cascade rather than in the tree, the same way Stage 21's did: Core and
`nostdb-spec` push, `nostdb-server` and `nostdb-cli` re-pin, then the root.

`nostdb-cli` also asserts `"nost_language_versions": [2]` as a literal in its own suite, which has to move in
the same commit that re-pins it. Recorded here so it is found then rather than discovered as a failure.

### Two contracts moved, and the registry is what proved it

`nostdb-spec` holds `versions.json` as the machine registry and `VERSIONS.md` as its human table, and a test
asserts they agree. Both keys moved there — `nost_language_version` 2 → 3, `nostdb_format_version` 1 → 2 — with
the bump recorded in the document that owns each key, per that repository's own procedure.

Neither lists its predecessor as supported. That is what makes the removal real: there is no reader for the
earlier spellings, so listing them would promise a parse no implementation can deliver.

### What the fixture suites forced, beyond the model

- **twenty `.nostdb` header fixtures encode a version.** Every one declared 1, so after the bump the version
  check fired before the condition each fixture exists to test — `bad_header_crc` reported an unsupported
  version rather than corruption. Each was moved to 2 and its `header_crc32c` recomputed over bytes 0..44, and
  `unsupported_version.hex` moved to 3 so it still names a version above the maximum;
- **`bad_header_crc` keeps its deliberately wrong checksum**, which is the one fixture the recompute had to
  skip;
- **52 `.nost` fixtures carry a version header**, all swept to `@nost 3`, and two still spelled a keyword owner
  — `ambiguous_confidence` and `invalid_evidence` — which the accepted and semantic suites caught.

### Stage 29 closed

The pin cascade ran and `./scripts/verify-workspace.sh` passes, including
`version conformance: 13 contracts verified` — which is the check that could not pass from the working tree,
because the CLI reports the version constants of the Core the root pins.

Pushed in dependency order: `nostdb-spec` 0762999, `nostdb-core` fb18a8d, `nostdb-server` 7f82e25 re-pinned
onto Core, `nostdb-cli` f980ad3 re-pinned onto both, then the root.

Two things the cascade found, neither predicted:

- **`nostdb-cli` holds its own `.nost` and change set fixtures.** Twelve command tests wrote `@nost 2`, and one
  hand-written change set wrote `"owner": {"kind": "user"}`. Both are contracts that moved, so a crate that
  only re-pinned would have failed on documents it wrote itself;
- **`cargo tree -i nostdb-core` is the check that matters when re-pinning.** Moving only the Core pin left
  `nostdb-cli` building two Core revisions — its own and the one reached through Server — which is the failure
  the root's pin check exists to prevent. Server had to push first so the CLI could name both.

Every Acceptance Criterion passes.

## Release 0.1.4: the owner change reaches a published build

Reported: a database still writes `@by analyzer "rust" "1"`, with the guess that npm had not been
published. The guess was right. Everything from Stage 21 onward existed only in Git, and npm `latest` was
0.1.3 — so every `npx nostdb` ran a build that predated the owner change.

**0.1.4**, chosen over 0.2.0 when asked. The release number moved in ten places, and no contract version
moved with it: `nost_language_version` and `nostdb_format_version` changed in Stages 28 and 29 for their
own reasons and stay independent, which is the distinction `VERSIONS.md` exists to keep.

### This release refuses what 0.1.3 wrote, and that is the intended behavior

Neither contract lists its predecessor as supported. An existing `.nostdb` reports
`NOSTDB_FORMAT_UNSUPPORTED` and is rebuilt; an existing `.nost` reports `NOST_VERSION_UNSUPPORTED` and is
regenerated. The release notes say so first, before what changed, because that is what a reader upgrading
needs.

The database in the report is the first case. Refusing at the header rather than at an owner byte is what
makes it a database to rebuild instead of one that looks corrupt.

### Verified against the release binary, not against the source

The archive was downloaded from the published release, its digest checked against the attached
`checksums.json`, unpacked, and run over a two-file Kotlin project:

```
nostdb 0.1.4   nost_language 3   nostdb_format 2

@nost 3
@by "nostdb" unit "u_019fb1ea-…" {
      producer_version: "9",
```

and the Stage 21 fix with it — `src/Service.kt` imports `com.demo.app.data.Payload`, which is declared in
`Models.kt`, and the query returns that edge. 0.1.3 drew none, because no file is named `Payload.kt`.
`File.package` carries `com.demo.app` and `com.demo.app.data`.

The launcher was then exercised end to end: packed, installed from the tarball, and run. It fetched the
archive from the public release, verified length and digest before writing, and produced the same build.

### Two verifiers caught what the bump missed

- `plugins` reported that `bin/nostdb-view` declares its own `VERSION`, a tenth place the release number
  lives that a manifest-only bump would have left disagreeing with the manifest;
- `nostdb-distribution` reported `package.json` at 0.1.4 against `checksums.json` at 0.1.3. That one is not
  a miss to fix but an ordering: the checksums are written by the release workflow from the archives it
  assembles. The repository was held back and bumped after the release existed, so it never pointed at
  archive names nobody had written.

### What could not be done here, and why

**The artifacts cannot be built on one machine.** `release.yml` is a matrix run by hand, and its own
comments record why: `assemble-release.mjs` packages a binary somebody else built, because "which
toolchain built a published artifact is a release decision rather than a packaging one". The two Linux
targets need Linux runners. The workflow was dispatched with `draft: true`, its default, and the draft was
reviewed before publishing.

**npm publish took three attempts, and the first two diagnosed the wrong thing.** `npm whoami` returned
`E401`; after logging in it returned `ujon` and publish still returned 403, naming "two-factor
authentication or granular access token with bypass 2fa enabled". An OTP did not help, and the reason is
that `npm profile get` reports **`two-factor auth: disabled`** — there was nothing for a code to satisfy.
The token had `read-write` on `nostdb`, so it was not a permission either. What npm accepts for publishing
is one of exactly two things, and a classic token is neither. A granular token with bypass-2FA published
on the first try.

Worth recording as a shape: the error named two acceptable auth methods, and the fix was to read that
literally rather than to keep supplying the one it mentioned first.

### Verified through npm, which is where the report came from

```
$ npm view nostdb dist-tags
{ next: '0.0.4', latest: '0.1.4' }

$ npx --yes nostdb@latest --version
nostdb 0.1.4   nost_language 3   nostdb_format 2
```

and a build in an empty directory through `npx --yes nostdb@latest`:

```
@nost 3
  @by "nostdb" unit "u_019fb1fa-…" {
```

The reported symptom was `@by analyzer "rust" "1"`. It is gone on the path the report came from.

### Release 0.1.4 closed

GitHub, Homebrew, and npm all carry it. Every one of the ten repositories is clean and synchronized, and
`./scripts/verify-workspace.sh` passes.

## Stage 30 scope

Asked for two things after reading `/nostdb help`: give `sync` the verb-first shape the rest of the surface
has, in the form `sync <source> <target>`, and make `.nost` and `.nostdb` synchronizable in both directions.

They are two different commands, and the reason is worth stating before the change rather than after.

### `sync` cannot take a source and a target

`nostdb sync [PATH]` reconciles a **configured project's** two representations against a recorded baseline,
comparing generations and content digests. Its whole job is answering "which side changed since they last
agreed", and when both did it modifies neither and reports `SYNC_CONFLICT` — the CLI's own help says there is
no option to prefer one, "because preferring either would discard the other's changes and nothing here can
know which of the two a person meant to keep".

Two arbitrary files have no recorded baseline, so that question has no answer for them. A `sync a b` would
therefore have to be either a blind copy, which discards whatever it overwrites, or a conversion — and a
conversion is a command that already exists.

### What delivers the second half: `convert`

`nostdb convert INPUT OUTPUT` converts in whichever direction the extensions name — `.nost -> .nostdb`
validates then commits, `.nostdb -> .nost` reads the graph then writes canonical `.nost`. It refuses two
identical extensions, because that is a copy rather than a conversion.

**The Skill does not expose it at all.** So the bidirectional operation the request asks for is not a change
to `sync`; it is a row the surface never had, and its shape is exactly the `<source> <target>` that was asked
for.

### What the reshape also fixes

The surface reads `/nostdb .nostdb/root.nost --sync`, which names a **file**. The dispatcher emits
`nostdb sync <path>`, which takes a **project**. So the documented invocation has been showing an argument of
the wrong kind — passing that path through would hand `sync` a file where it expects the project containing
it. Verb-first removes the flag and the wrong argument together.

`--sync` leaves the `Options` block with it, because it stops being a flag.

### Scope

- `dispatch.sh`: a `convert` action emitting `nostdb convert INPUT OUTPUT`, refusing when it is not given
  two operands, in the same position discipline the AI-free set comparison requires;
- `SKILL.md`: the `sync` row becomes verb-first and project-scoped, a `convert` row is added, `--sync` leaves
  `Options`, and both action-map rows follow;
- `ACTIONS.md`: the two table rows;
- `tests/dispatch.test.sh`: the action lists, the pinned option values, and assertions that `convert` emits
  both operands and that `sync` still names a project.

### Stage 30 acceptance criteria

1. `/nostdb sync .` is the surface, and no document offers the flag form or a file path to `sync`;
2. `/nostdb convert <input> <output>` is offered and emits `nostdb convert INPUT OUTPUT` unchanged, in either
   direction;
3. `convert` with fewer than two operands is refused rather than emitting a partial command;
4. the cross-check between `SKILL.md`'s map and `ACTIONS.md`'s table passes, and the AI-free set still matches
   the dispatcher in order;
5. `./scripts/verify-repository.sh` passes in `skills`, and `./scripts/verify-workspace.sh` in the root.

### Stage 30 verification

`./tests/dispatch.test.sh` and `./scripts/verify-repository.sh` in `skills`, both every check passed, and
`./scripts/verify-workspace.sh` in the root, which passed.

```
ok   convert emits the input and the output, in order
ok   and the other direction is the same command
ok   convert with one operand is refused
ok   sync names a project
ok   and not a representation
```

And against the published Engine rather than the mapping alone:

```
$ nostdb convert .nostdb/root.nostdb /tmp/out.nost   -> @nost 3
$ nostdb convert /tmp/out.nost /tmp/out.nostdb       -> wrote 6 nodes, 6 edges, 0 links, 16 schemas
$ nostdb convert /tmp/out.nost /tmp/copy.nost
cannot convert .nost to .nost: that is a copy rather than a conversion
```

### The action probe assumed one argument, and `convert` takes two

The check that decides which actions the dispatcher maps does it by **running** each case label, because an
action is no longer required to emit a command. It passed a single path, so `convert` refused, and the
AI-free set came back missing an action the dispatcher does map.

The probe now passes two. Every other action reads only what it needs, so the spare argument changes nothing
for them — and the alternative, special-casing `convert`, would have put knowledge of one action's arity in a
check whose whole point is not to have any.

### A wrong argument the reshape removed

The old surface read `/nostdb .nostdb/root.nost --sync`, naming a **file**, while the dispatcher emits
`nostdb sync <path>`, which takes a **project**. Following the documented invocation would have handed `sync`
a representation where it expects the directory containing both. A test now fails if a representation reaches
it.

### Stage 30 closed

Every Acceptance Criterion passes. `sync` reconciles a project, `convert` converts two files in whichever
direction their extensions name, and the surface says which is which.

## Stage 31 scope

Asked to drop `sync` from the Skill so only `convert` remains, and to give `convert` a `--replace` option:
overwrite an existing output when it is passed, fail when it is not.

### The second half is an Engine change, not a surface one

`nostdb convert` has no such option, and it **silently overwrites** an existing output today — verified
against the published 0.1.4 binary, which returned exit 0 and replaced the file without a word. A Skill
emitting `--replace` would name a flag the Engine rejects, which is the thing this repository's cross-check
exists to prevent.

So `nostdb-cli` changes first, and the Skill follows it.

### The default becomes refusal, which is a breaking change worth stating

After this, a bare `convert` onto an existing path fails where it used to succeed. That is the request, and
it is also the safer default: the current behavior destroys a file without naming it, and the one command
whose whole job is writing a second representation is the one most likely to be pointed at something that
already exists.

`ExitClass::Conflict` rather than `Usage`, because the invocation is well formed and the filesystem is what
refuses. It is the class `sync` uses when both representations changed, and for the same reason: two things
want that path and nothing here can know which one was meant.

### What removing `sync` from the Skill costs

`convert x.nost .nostdb/root.nostdb --replace` overwrites a database with no baseline check — precisely the
case `sync` refuses with `SYNC_CONFLICT`. The capability is not gone, because the CLI keeps `sync`; what goes
is the Skill's route to it, so an agent reconciling a project has only the destructive command left.

Requiring `--replace` is the mitigation that makes it survivable: the destruction is now something somebody
typed rather than something that happened.

### Scope

- `nostdb-cli`: `--replace` on `convert`, refusing an existing output without it, in whichever position the
  flag appears among the operands; the help text; and tests covering both directions, both defaults, and the
  flag's effect;
- `skills`: the `sync` action and its surface row removed, `--replace` added to the `convert` row and to
  `Options`, and the prose contrasting the two commands replaced by what `convert` alone now guarantees;
- a release, because the Skill's emitted command does not work against a published Engine until one carries
  the flag.

### Stage 31 acceptance criteria

1. `nostdb convert` refuses an existing output and exits `Conflict`, naming the path and the flag;
2. `--replace` overwrites, in both directions, and is accepted before or after the operands;
3. a `convert` onto a path that does not exist is unaffected;
4. no Skill document offers `sync`, and the `convert` row and `Options` name `--replace`;
5. `cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings`, and
   `cargo test --all-targets --all-features` pass in `nostdb-cli`, both repository verifiers pass, and
   `./scripts/verify-workspace.sh` passes in the root.

### Stage 31 verification

`nostdb-cli`: `cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings`,
`cargo test --all-targets --all-features` — **97 command tests passed, 0 failed** — and
`./scripts/verify-repository.sh` passed. `skills`: `./scripts/verify-repository.sh` passed. Root:
`./scripts/verify-workspace.sh` passed.

```
$ nostdb convert out.nostdb exists.nost
exists.nost already exists: pass --replace to overwrite it        (exit 4)
$ nostdb convert out.nostdb exists.nost --replace                 (exit 0)
$ nostdb convert --replace out.nostdb exists.nost                 (exit 0)
```

### The existing suite showed how often this overwrite was relied on

Twelve tests failed the moment the default became refusal, and none of them was testing `convert`. Every
one seeded a freshly initialized project by converting a document onto the `.nostdb/root.nostdb` that `init`
had just written — "put something in the database by converting into it", as one comment says. Each now
passes `--replace`, which is what they were always doing.

One failure was more than bookkeeping. `a_refused_conversion_leaves_the_target_exactly_as_it_was` proves a
document that fails validation does not touch the target, and it reached the existence check first, so it
stopped testing validation at all. It now passes `--replace` and proves the stronger statement: **even when
overwriting is permitted**, an invalid document leaves the target as it was.

### Order of refusals

Extensions are checked before existence. `convert a.nost b.nost` reports the copy it is rather than
complaining that `b.nost` exists — one is a mistake in the command and the other a fact about the
filesystem, and naming the command's mistake sends somebody to fix the right thing. Pinned by a test.

### What the Skill lost, and what it says instead

`sync` is gone from the surface and remains in the CLI. So the Skill's only route from a `.nost` onto a
project's database is `convert --replace`, which discards whatever the database held with no comparison of
what changed — the case `sync` refuses with `SYNC_CONFLICT`.

The surface says this where it will be read, and names `nostdb sync` for reconciling rather than
converting. Requiring the flag is what makes the destruction something somebody typed.

`--replace` is forwarded and never added. A Skill supplying it on a caller's behalf would convert a refusal
they were meant to see into a file they did not know they lost, and a test pins that it is absent unless
asked for.

### The sync concept did not leave the code, and a rename was checked rather than assumed

Asked to rename what the removal made stale, on the reading that synchronization was gone internally. It is
not, and a blanket rename would have destroyed a live capability the root contract mandates:

- `nostdb sync [PATH]` is still a command — "Bring .nostdb and .nost into agreement, or say why not";
- `nostdb-core/src/sync.rs` is 329 lines of it;
- `CLAUDE.md` requires it twice: synchronization compares generations and content digests rather than
  timestamps, and when both representations changed from one baseline it reports `SYNC_CONFLICT` and
  modifies neither.

What Stage 31 removed is the **Skill's route** to that command. So every remaining mention was checked
against what it refers to:

| Mention | Verdict |
| --- | --- |
| `SKILL.md` naming `nostdb sync` for reconciling | deliberate — it points at the CLI command the surface no longer offers |
| `SKILL.md` "not a synchronizer" | a prohibition on reimplementing the Engine, still true |
| the test asserting `sync` is not an action | the point of the removal |
| `sync` among the writing commands `summary` must not emit | the CLI still has it, and it still writes |
| `sync` among the positional-taking CLI commands | describes the CLI's parser, unchanged |

One was genuinely stale: the frontmatter **description** opened with "Build, query, and synchronize". That
sentence is what an agent selects the Skill by, so it was promising a capability the surface had just lost —
worse than omitting one, because it decides whether the Skill is reached for at all. It now says "convert".

### The options block had one row that did not fit

`--scan=default|ai` was the only row whose description wrapped, and the wrap forced the prose to name both
values again inside it — "default: … ai: …" — in a column narrow enough to break. The two values a reader
came to find were the least legible thing in the block.

One row per value: `--scan=default` and `--scan=ai`, each with its own description, each a complete
fragment somebody can copy. A pipe-separated set is neither. `--replace` also dropped "takes no value",
which every other row now shows by carrying its value inline.

The test pins each value separately rather than the joined spelling, which no longer appears anywhere.

### Stage 31 closed

Every Acceptance Criterion passes. **Not yet released:** the Skill emits `--replace`, and no published
Engine accepts it until a release carries this CLI.

## Release 0.1.5: convert refuses an existing output

Stage 31 gave `convert` a `--replace` option and the Skill emits it. No published Engine accepted it, so
this release carries one.

The release number moved in ten places. No contract version moved: nothing here changes a format, a
language, or a protocol, and the CLI command surface is not among the versioned contracts — which is why
0.1.4 databases and documents are read by this release unchanged.

### The first run failed on all four targets, and the local gate could not have caught it

`nostdb-provider-github`'s `Cargo.lock` still recorded 0.1.4 while its manifest said 0.1.5, and the release
builds that crate with `--locked`.

Its verifier checked repository shape, ownership boundaries, the licence, and the stdout rule — and ran
**no cargo command at all**, while the root contract requires every Rust repository to pass fmt, check,
clippy, and test. So a version bump passed every gate the repository had and failed in the most expensive
place available.

The verifier now runs the four commands, and passes `--locked` to `cargo check` specifically because that
is how the release builds this crate. A lock disagreeing with its manifest now fails locally rather than
four jobs into a release.

Worth recording as a kind: a repository whose gate is weaker than its release will discover the difference
during a release.

### One thing found and not fixed

`release.yml` checks out `nostdb-provider-github` with no `ref`, so it takes the default branch — while its
own comment says it is "checked out at the revision the superproject pins rather than at its default
branch", and explains that a release taking whatever the branch happened to be "would ship a provider
nothing had verified alongside this engine". The comment describes an intent the step does not implement.

Not changed here, because fixing it means deciding how the workflow learns the root's pin, and a release in
progress is the wrong moment to answer that. Recorded so it is not rediscovered as a surprise.

### Verified against the published artifacts

```
$ nostdb --version                                   nostdb 0.1.5
$ nostdb convert root.nostdb out.nost                exit 0
$ nostdb convert root.nostdb out.nost
out.nost already exists: pass --replace to overwrite it     exit 4
$ nostdb convert root.nostdb out.nost --replace      exit 0
```

first against the release archive, then again in an empty directory through
`npx --yes nostdb@latest`, which is the path a user reaches.

### Release 0.1.5 closed

npm `latest` is 0.1.5, the GitHub release carries four targets and their checksums, and the tap points at
them with the digests the release recorded.

## Stage 32 scope

Release 0.1.5 recorded that `release.yml` checks out `nostdb-provider-github` with no `ref`, taking its
default branch, while the step's own comment says it is "checked out at the revision the superproject pins
rather than at its default branch" and explains that a release taking whatever the branch happened to be
"would ship a provider nothing had verified alongside this engine".

The comment describes an intent the step does not implement. This implements it.

### The assembler has the same defect, and it matters as much

`nostdb-distribution` is checked out the same way. That repository owns what a release archive *is* — its
shape, its digests, and their reproducibility — so a release assembled by whatever is on its branch is a
release assembled by something the root never verified beside this engine. Both checkouts read the pin.

### Where the pin comes from

The root superproject records a gitlink per child, and `git rev-parse HEAD:<path>` reads it out of the tree
without fetching the child. So the workflow checks the root out once and resolves both revisions from it.

### What this obliges, which is the substance rather than a side effect

**The root must be re-pinned before a release is cut.** Until now the order did not matter, because the
workflow took whatever each branch held. Reading the pin makes the root's state decide what ships.

Release 0.1.5 is the worked example, and it cuts the other way: the root was re-pinned **after** the
release. Had this been in place, the first run would have built the provider revision the root still
pinned — the 0.1.4 one — and produced a 0.1.5 archive containing a 0.1.4 provider, quietly and
successfully. The stale-lock failure that actually happened was louder and more useful.

So this is a trade rather than a pure win: a release now ships what the root says the product is, and a
root that is behind ships something behind. Naming that in the workflow is part of the change.

### Scope

- `nostdb-cli/.github/workflows/release.yml`: check the root out once, resolve both children's pinned
  revisions from its tree, and pass each as the `ref` of its checkout;
- the step comments, so the one that already claimed this behavior now describes it, and the ordering the
  change obliges is stated where somebody cutting a release reads.

### Stage 32 acceptance criteria

1. both `nostdb-distribution` and `nostdb-provider-github` are checked out at the revision the root pins;
2. a release whose root pin does not exist fails at the checkout rather than silently building something
   else;
3. the workflow states that the root must be re-pinned before a release is cut;
4. `./scripts/verify-repository.sh` passes in `nostdb-cli`, and `./scripts/verify-workspace.sh` in the root.

### Stage 32 verification

`./scripts/verify-repository.sh` passed in `nostdb-cli`, and `./scripts/verify-workspace.sh` in the root.
The YAML parses, and both `ref:` expressions reference environment names the resolution step writes.

The resolution was exercised against the real root rather than reasoned about:

```
$ git rev-parse HEAD:nostdb-distribution     3b8bfa3a…   (matches its HEAD)
$ git rev-parse HEAD:nostdb-provider-github  396733df…   (matches its HEAD)
```

and the failure path, which is what criterion 2 asks for:

```
$ git rev-parse HEAD:not-a-child
fatal: path 'not-a-child' does not exist in 'HEAD'        exit 128
```

`rev-parse` writes the fatal to stderr and echoes its argument to stdout, so the check that matters is
whether `set -e` stops the loop rather than assigning that echo. Run as the step runs it, the loop aborts
and the step exits 128 — confirmed by running it, because `set -e` with a command substitution in an
assignment is exactly the shape that silently does not propagate.

### The next release is where this is really tested

Nothing here proves the workflow behaves, only that its inputs resolve. The proof is a release, and the
first one under this change carries a new obligation: **re-pin the root before cutting it.** Release 0.1.5
would have violated that — its root was re-pinned afterwards, so the first run would have built the
provider revision the root still pinned and shipped a 0.1.5 archive containing a 0.1.4 provider, quietly
and successfully.

That is the trade this Stage makes and does not hide: the release now ships what the root records, which is
right, and a root left behind now ships something behind.

### Stage 32 closed

Every Acceptance Criterion passes.

## Surface: real paths in the convert row, and a line for `--replace`

Asked for `convert <in> <out>` to read as paths, and for `--replace` to appear in the invocation block the
way `--scan` does.

`/nostdb convert in.nost out.nostdb` shows the extension pair, which is the thing that decides the
direction, and `/nostdb convert ... --replace` extends it in the same "the same, …" shape `--scan=ai` uses.
The description column widened from 35 to 38 to fit them; the longest row is now 34 characters.

### A check that could not fail, again

The action map and the table had drifted to `<in> <out>` while the surface showed real paths, and the
existing cross-check could not see it: it ties the **map** to `ACTIONS.md`, and both are prose an agent
reads rather than the help a person sees. Two documents agreeing with each other while a third shows
something else passes it.

The new check greps the rendered surface for every invocation the map declares. Its first version was
written near the top of the test file, where `$map` is not yet extracted — so the loop ran zero times and
the check passed unconditionally. That is the second time in this repository a new check has been written
in a shape that cannot fail, and the same method caught it both times: **create the drift the check
targets and watch it fail before trusting it.**

It was moved after the extraction, verified against the real drift, and its summary line now reports the
loop's result rather than printing `ok` beside a failure.

## Surface: convert shows the paths a project has

Asked to use `.nostdb/root.nostdb` in the example, since a configured project always has one, and to write
`--replace` out rather than leaving it behind an ellipsis.

Both together are 55 characters. Measured against the block, that puts the widest line at **112** — a
two-column grid cannot hold a 55-character command beside a 52-character description, and the only way to
keep the grid was to shorten descriptions until they fit, which is the layout deciding what the
documentation says.

So `convert` left the grid. It is the only command taking two operands, and it now has a short section: the
rule stated once, then two invocations written in full. The grid stays at 38 and the widest line is 91.

### The two examples are a sequence, and the destructive direction is not one of them

```
/nostdb convert .nostdb/root.nostdb root.nost
/nostdb convert .nostdb/root.nostdb root.nost --replace
```

The second re-runs the first, which is exactly when `--replace` is needed and the shape most people meet it
in. The first draft showed the reverse for the second line — a `.nost` onto the project's database — which
is the case the paragraph below the fence warns about, with no baseline check of what the database held. A
help screen demonstrating the dangerous direction while the prose warns against it teaches the wrong half.

## Stage 33 scope

Asked for a `nostdb-analyzer-springboot` Skill carrying a preset schema covering endpoints, requests,
responses, rules, databases, tables, collections, schedulers and jobs — in detail, with the relations among
them — plus configuration files (gradle, toml, yaml, properties) and dependencies.

This is the first step of the direction recorded above: moving framework recognition out of Core. It adds a
vocabulary and adds nothing to Core, so it is reversible and proves the vocabulary before anything is
removed.

### A defect found first, and it is why this Stage starts here

`skills/nostdb/presets/jpa.nost` declared `@nost 2`. Stage 29 raised the language to 3 and swept
`nostdb-core` and `nostdb-spec`; it missed this repository. So the only preset this workspace ships has been
**refused by the Engine** since that Stage:

```
23:7: error: NOST_VERSION_UNSUPPORTED: language version 2 is not supported; this build supports [3]
```

`tests/presets.test.sh` is written to catch exactly this — it hands every preset to `nostdb check` — and it
reported `skip no nostdb on the path`, because neither the skills verifier nor the root workspace verifier
puts an Engine there. The check that existed for this could not run in either place it runs.

Fixed, and the gap closed: the root builds an Engine and owns the skills child, so it is the only place that
has both.

### What the preset covers, and what it deliberately does not

It owns the **web contract**, the **physical data store**, **framework-invoked work**, and
**configuration and build**. It does not own persistence mappings: `Entity`, `Column`, and `Repository`
belong to the `jpa` preset, and two presets declaring one label would leave whichever was applied last
standing.

Three boundaries decide every name in it:

- **no label a build already writes.** `Endpoint`, `File`, `Module`, `Field`, and `Method` are among them, so
  the route record is not redeclared — the preset *references* `Endpoint` in an endpoint constraint and hangs
  its own records off it. Settings hang off the builtin `File` rather than a `ConfigFile` of their own, which
  would put two records on one path;
- **no label the `jpa` preset declares**, hence `TableColumn` rather than `Column`;
- **no builtin relation name.** `HANDLED_BY` runs `Endpoint -> Method` in every build, so a preset declaring a
  schema for it would raise a violation on every build's own edges. `Job` reaches its declaration through
  `RUNS` instead.

### Two credential decisions, made structurally rather than by rule

- **`Datasource` has no `url` field.** A JDBC URL routinely carries a user and a password, and a field for
  one invites recording it. `kind`, `driver`, `host`, `port`, `database`, and `schema_name` are the parts that
  matter, and none of them can hold a credential;
- **`Setting.secret` means the value is absent.** A settings file holds tokens beside ports. The flag says a
  value was withheld rather than that the setting is unremarkable, so a reader can tell "not written down"
  from "deliberately not recorded".

### Scope

- `skills/skills/nostdb-analyzer-springboot/`: `SKILL.md`, `presets/springboot.nost`, `presets/index`, and
  its own `scripts/presets.sh`, because the verifier requires every reference to resolve inside the folder an
  installer copies;
- `skills/tests/springboot-preset.test.sh`, wired into the repository verifier;
- `skills/nostdb/presets/jpa.nost`: `@nost 3`;
- `scripts/verify-workspace.sh`: put the workspace's own Engine on the path for the skills verifier, so the
  preset check stops skipping.

### Stage 33 acceptance criteria

1. `nostdb check` reports both presets valid, and the suite fails rather than skips when no Engine is
   reachable from the workspace;
2. the new preset declares no builtin label, no `jpa` label, no builtin relation name, and no label called
   `Schema`;
3. the Skill is installable: its name matches its folder, and every reference resolves inside it;
4. a proposal in the preset's vocabulary applies through `nostdb apply` and is queryable, proven against a
   real Spring Boot tree rather than asserted;
5. `./scripts/verify-repository.sh` passes in `skills`, and `./scripts/verify-workspace.sh` in the root.

### Stage 33 verification

`./scripts/verify-repository.sh` in `skills` — both Skills reported installable, `springboot preset: every
check passed` — and `./scripts/verify-workspace.sh` in the root, which now reports
`preset conformance: 2 Skill preset(s) verified by the Engine`.

The preset-conformance check was verified by reintroducing the defect it exists for. Putting `@nost 2` back
into `jpa.nost` makes the workspace verifier print `the Engine refused skills/skills/nostdb/presets/jpa.nost`
and exit 1. Zero presets found is a failure there rather than a pass, because a glob that stopped matching is
how this check would quietly become the skip it replaced.

### The vocabulary, proven against a real tree rather than asserted

A Spring Boot project was built — two routes, a scheduled job, `application.yaml`, `application.properties`,
`gradle/libs.versions.toml`, `build.gradle.kts`, and a migration — and the build reported what it could not
read:

```
endpoints  2 from spring
note: no framework analyzer here interprets Component, NotBlank, ResponseStatus, Scheduled
```

Three of those four are in the preset's coverage column and `Component` deliberately is not. A 21-operation
proposal then applied — 12 records and 9 edges — and answers:

```
job    kind       mode   table        key                         value  secret
sweep  scheduled  write  users        server.port                 8080
                                      spring.datasource.password         true

constrained      kind        rule
["Request"]      validation  email not blank
["TableColumn"]  database    email unique
```

The last one is the design decision paying off: `CONSTRAINED_BY` is declared without endpoints, and one query
finds rules over two different shapes. A relation per shape would have needed two.

### Two Engine gaps this found, both verified and neither fixed here

**An edge cannot reach a record a build wrote.** A change set names an endpoint by opaque identifier —
`{"local": "n_…"}` — and nothing exposes the identifier of a record the Engine minted one for: `nostdb.id` is
not a function, and the reserved `id` property reads empty on those records. So five relations in the preset
are declared and unproposable: `ACCEPTS`, `RETURNS`, `RUNS`, `DECLARES_SETTING`, `ROOTED_AT`.

This is the primitive the whole "analyzers as Skills" direction needs, not a nicety for one preset. Any
out-of-Core analyzer has to attach facts to records something else wrote. It also means Stage 20's preset
records have only ever been able to stand alone — nobody noticed, because nobody drew an edge.

**A change set cannot carry a list property.** `read_property_value` in `change_document.rs` takes a boolean,
a string, and a number and refuses an array, while `PropertyValue::List` exists, `.nost` reads and writes
lists, and a schema may declare `string[]` — which is why `nostdb check` accepts this preset and `apply`
refuses one field of it. `Bytes` and `DateTime` are missing from the same reader, and those genuinely need a
tagging decision JSON does not make for them; a list does not.

Both are left in place, and both are stated in the preset **and** in `SKILL.md`, because the model reads the
second. Declaring the names anyway is deliberate: a preset exists to fix a name before one is invented, and
leaving them out until the routes exist guarantees that whatever arrives then is called something else.

### Stage 33 closed

Every Acceptance Criterion passes. The Skill is installable, its 26 schemas collide with no builtin label, no
builtin relation, no `jpa` label, and no `Schema`, the Engine validates both presets from the root, and a
proposal in the vocabulary applies and answers questions about a real project.

## Stage 34 scope

Five things, asked as one: expose the identifier an edge needs, put the Skills under MIT, make the Spring
Boot vocabulary serve Kotlin as well as Java, replace its shell script with Python, and write down the
workflow where two producers analyze one project and their answers are reconciled into one graph.

### The first was already there, and Stage 33 said otherwise

There is nothing to expose. `RETURN e` in JSON format already yields the identifier a change set endpoint
needs:

```
$ nostdb query "MATCH (e:Endpoint) RETURN e AS record" --project . --format json
[{"node": "n_019fb6a0-43b7-7942-8c96-a7c7fcf8341c"}, ...]
```

`nostdb export --nost` writes it too, as the reserved `id` property. Both were verified by drawing
`Endpoint -ACCEPTS-> Request` with an identifier read that way, applying it, and querying the result across
the boundary.

Stage 34 therefore **corrects Stage 33**, which recorded the opposite. That record was written after looking
for `nostdb.id()` and for `e.id` — neither exists — and concluding there was no route without trying
`RETURN e`. The consequence was worse than a wrong note: `SKILL.md` told a model not to do something that
works, and a test pinned the wrong statement.

### What is actually broken, and it is in the way of the last item

`change_document.rs` reads an evidence entry's `method` and then hardcodes
`confidence: Confidence::Extracted`, discarding whatever the document declared. It drops `range` the same
way. So **every proposal, whatever it claims, is stored at the confidence reserved for a fact read directly
out of source.**

That is the axis on which two producers' answers are compared. With every proposal recorded as `extracted`,
an AI's inference and an analyzer's extraction are indistinguishable in the graph — which the root contract
forbids in as many words: results must not imply that heuristic or AI results carry the same confidence as
deterministic ones.

Nothing caught it because `nostdb-spec/docs/CHANGE_SET.md` never says what an evidence entry contains. The
shape lives only in a fixture, and that fixture happens to declare `"confidence": "extracted"` — the one
value the hardcoding produces.

The `.nost` route has always honored both: `ambiguous_confidence.nost` is a published fixture, and
`convert` reads `inferred(0.82)` correctly. So the two routes into one graph disagree about what evidence
means.

### Scope

- `nostdb-core`: read `confidence` and `range` from a change set's evidence rather than substituting one;
- `nostdb-spec`: document what an evidence entry contains, which is why this was invisible, and add fixtures
  for a rejected score and an accepted inferred one;
- `skills`: correct Stage 33's five markers and the `SKILL.md` section that acted on them, and the test;
- `skills`: MIT, both definitions and the repository, with the root contract and the PRD moved with it;
- `skills`: the Spring Boot vocabulary stated as serving Kotlin and Java, proven on a Kotlin tree;
- `skills`: the lookup rewritten in Python;
- `skills`: a coverage document in the `nostdb` Skill for the workflow — build, find what was not read, use
  an installed Skill for what one covers, have the model read the rest, and reconcile the two onto one record.

### Stage 34 acceptance criteria

1. an evidence entry's `confidence` and `range` survive a change set, and a malformed score is refused rather
   than silently downgraded;
2. no Skill document tells a model that an edge into a build-written record cannot be proposed, and the
   recipe for the identifier is stated instead;
3. the Skills and the repository are MIT, and no document still claims Apache-2.0 for them;
4. the vocabulary is proven on a Kotlin Spring Boot tree as well as a Java one;
5. the Spring Boot Skill ships Python and no shell script;
6. the workflow is written down, including how two producers' answers reach one record and how a
   disagreement stays visible;
7. every repository verifier passes, and `./scripts/verify-workspace.sh` in the root.

### Stage 34 verification

`nostdb-core`: `cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings`,
`cargo test --all-targets --all-features` — **985 passed, 0 failed** — and `./scripts/verify-repository.sh`
passed. `nostdb-spec` and `skills`: their verifiers passed. Root: `./scripts/verify-workspace.sh` passed,
including `preset conformance: 2 Skill preset(s) verified by the Engine`.

Change-set conformance went from 3 accepted and 9 rejected fixtures to **4 and 11**, which is the three new
ones running.

### The evidence fix, proven by reverting it

Six unit tests cover the decoder. Reverting it to the substituted values fails five of them and passes one —
`an_absent_confidence_is_extracted_and_an_absent_range_is_none`, which is the single case the old behavior got
right, and the reason no fixture had caught it.

A conformance fixture could not have caught this on its own: it proves a document is accepted or refused, not
that a value survived. The bug was "accepted and discarded". So both layers exist — fixtures for the contract,
unit tests for the preservation.

### A second defect, found while proving Kotlin

`kotlin.rs` read the annotations on a primary-constructor property and dropped them:
`annotations: Vec::new()`. That is where an idiomatic Kotlin request type states its constraints —
`data class NewUser(@NotBlank val email: String)` — so **a build reported none of them**, while the same
`@NotBlank` on a Java field was reported.

The Skill could not have compensated. Step 1 of its workflow reads the capability diagnostic to decide what
needs enrichment, and for an idiomatic Kotlin project that diagnostic said there was nothing to read. Fixed,
with `GRAPH_SCHEMA_VERSION` at 10 so a database built before it is redrawn, and pinned twice: the analyzer
keeps them, and `project.rs` asserts the report now names `NotBlank` and `Size`.

The clearing rule needed its own test. The first implementation carried an annotation on a plain parameter —
`class C(@Inject dependency: Service, val kept: String)` — forward onto the next property, attributing a
constraint to the wrong field. A parameter boundary clears what was read.

### Python, and two gaps in the verifier it exposed

The Spring Boot Skill's lookup is Python and ships no shell. Shell is right when the work *is* running
commands, which is what the `nostdb` Skill does; this one reads a table and matches a name, and the index was
pipe-separated precisely because a shell reader could not be trusted with JSON.

The verifier knew only about shell. It extracted `scripts/*.sh` references and checked the executable bit on
`*.sh`, so **a Python script a definition named would have been unverified in both** — the reference could
have pointed at nothing, and the bit could have been missing. Both now cover `.py`, and both were confirmed by
breaking them.

The `nostdb` Skill's six shell scripts are **not** converted. Each is pinned by a suite asserting its exact
output and exit codes, and rewriting them is a Stage of its own rather than a side effect of this one.

### What the Skills are licensed as

MIT, in both definitions, the repository's `LICENSE`, its verifier, its README, and the root contract, the
PRD, and `docs/REPOSITORIES.md`. A Skill is a document somebody reads, forks, and replaces; `nostdb-mcp`
stays Apache-2.0, which is why that line was split rather than edited.

### The workflow, written where the coordinator is

`skills/nostdb/COVERAGE.md`. The `nostdb` Skill is what runs the Engine and reads its report, so the
orchestration is its own; the Spring Boot Skill knows nothing about Flyway and should not.

Two parts are worth naming because they are not obvious from the model:

- **each producer proposes separately.** A change set carries one owner, and an owner is what
  `RemoveContribution` withdraws — so redoing the Flyway reading replaces the Flyway facts and leaves the
  Spring Boot ones alone. One combined set makes that impossible;
- **the second producer upserts the first's record.** Ask for the identifier, propose with it, and the Engine
  merges: one record, both contributions, both evidences, each naming its own producer. Verified end to end
  earlier in this Stage. That is the "one schema" two readings reach — not a merge that picks a winner, but a
  record that keeps who said what.

Where they disagree on a value, the later proposal wins the property and both evidences remain, so the
disagreement is findable. The document says to surface it and let the user decide rather than average, prefer
the newer, or prefer one's own — and it says that a graph where one producer quietly overwrote another reads
as agreement, which is the failure to avoid.

### Stage 34 closed

Every Acceptance Criterion passes.

## Release 0.1.6: evidence that means what it says, and Kotlin's constraints

Stage 34 fixed two things a published build did not have. The release number moved in ten places; no contract
version moved with it, because nothing here changes a format or a protocol — `graph_schema_version` went to 10
for its own reason and is a record shape version, so a 0.1.5 database opens unchanged and a Kotlin project
needs one rebuild to gain what it was missing.

### The first release under Stage 32's rule, and the rule held

`release.yml` now checks the children out at the revision the **root** pins rather than at their default
branch, which makes the order matter: the root was re-pinned before the release was cut rather than after. The
log shows it resolving what the root records:

```
nostdb-distribution=3b8bfa3a38bd5739e274a7199adbdfa69dca8056
nostdb-provider-github=48a0adb8af29b55db9585e55779f7df3cc4510fb
```

0.1.5 was re-pinned afterwards and would have built a provider one revision behind — quietly, because the
build would have succeeded.

### The lock check earned itself back immediately

Bumping the version left every `Cargo.lock` recording 0.1.5, and `nostdb-provider-github`'s verifier — which
Stage 33 gave `cargo check --locked` for exactly this — refused before anything was pushed. That is the failure
that cost 0.1.5 four build jobs, caught locally this time in the repository that caused it.

Worth noting the asymmetry it exposes: `nostdb-spec` and `nostdb-core` run `cargo check` **without**
`--locked`, so their verifiers refresh a stale lock as a side effect and report a pass. Neither is built with
`--locked` by the release, so nothing breaks — but the two repositories differ in whether their gate would
notice, and only one of them would.

### Verified against the published artifacts

The archive was downloaded, its digest checked against the attached `checksums.json`, unpacked — both programs
present, `nostdb 0.1.6` and the provider — and run:

```
$ nostdb build --project .          # data class NewUser(@NotBlank val email: String)
note: no framework analyzer here interprets NotBlank, Size; enrichment is what reads them
```

0.1.5 reported nothing for that file. And a proposal's evidence, read back out of the database:

```nost
@evidence {
  confidence: inferred(0.8199999928474426),
  range: "4:3:40-4:32:69",
  method: ai_inferred,
  ...
}
```

0.1.5 stored `confidence: extracted` and no range. Then again in an empty directory through
`npx --yes nostdb@latest`, which is the path a user reaches.

### One cosmetic thing found and left

A score renders as `0.8199999928474426` because `Score` holds an `f32` and the `.nost` writer prints the
widened `f64`. It re-parses to the same `f32`, so a round trip is stable and formatting stays idempotent — it
is verbose rather than wrong. Left alone: narrowing the rendering is a decision about the language's float
output, not about this release.

### Release 0.1.6 closed

npm `latest` is 0.1.6, the GitHub release carries four targets and their checksums, and the tap points at them
with the digests the release recorded.

## Stage 35 scope

The `nostdb` Skill's six scripts in Python. Stage 34 converted the Spring Boot Skill's one and recorded these
as a Stage of their own, because each is pinned by a suite asserting its exact output and exit codes.

### That reasoning was half right, and the half that was wrong matters

Stage 34's note said shell is right when the work *is* running commands, which is what this Skill does. Two of
these six parse JSON with a regex:

```sh
# resolve-engine.sh, reading a contract's supported versions
sed -n "s/.*\"$reported\":\[\([^]]*\)\].*/\1/p"

# budget-check.sh, reading a plan's estimate
echo "$plan" | tr -d ' \n' | sed -n "s/.*\"$1\":\([0-9]*\).*/\1/p"
```

Neither is parsing. `budget-check` strips every space and newline and matches a pattern anywhere in the
result; the nested form assumes the inner key follows the outer within one `{}`. `resolve-engine` reads a JSON
array with a character class that stops at the first `]`.

Both work against what the Engine writes today, and that is the point rather than a reprieve: what they depend
on is its member order. `max_input_tokens` happens to be written first inside `budget`, so the pattern finds
it — and JSON member order carries no meaning, so moving one line in the emitter would change the answer with
no contract change and nothing to notice. The gate would read no limit and return `ask` on a plan that should
skip.

So this is not churn. It removes a class of defect from the two scripts that decide whether an AI call is
affordable and whether an Engine is compatible — the two places a wrong answer is least visible.

### The suites are the specification

Every script is pinned by a suite asserting exact output and exit codes. A faithful rewrite is one those
suites accept **unchanged apart from the path they invoke**, which is what makes this verifiable rather than
hopeful. Nothing about a suite's assertions is relaxed to fit a rewrite; where one fails, the rewrite is
wrong.

### Also in scope, because last Stage recorded it

`nostdb-spec` and `nostdb-core` run `cargo check` without `--locked`, so their verifiers refresh a stale lock
as a side effect and report a pass. Release 0.1.6 showed the provider's `--locked` check earning itself back;
these two would not have noticed the same thing.

### Stage 35 acceptance criteria

1. the `nostdb` Skill ships Python and no shell script, and every document referencing one names the Python;
2. every existing suite passes with no assertion changed, only the path it invokes;
3. neither JSON reader is a regex: a reordered or nested reply is read correctly, pinned by a test that fails
   against the shell behavior;
4. `nostdb-spec` and `nostdb-core` check with `--locked`;
5. every repository verifier passes, and `./scripts/verify-workspace.sh` in the root.

### Stage 35 verification

`skills`: `./scripts/verify-repository.sh` passed, with every suite green —
`resolution` 40 checks, `dispatch` 63, `presets` 10, `budget` its own, `natural language` 25, and the
Spring Boot preset suite. `nostdb-spec` and `nostdb-core`: their verifiers passed. Root:
`./scripts/verify-workspace.sh` passed.

**No assertion was relaxed.** Every suite runs its original checks against the Python, and the only thing that
changed in five of the six is the path invoked. Two mechanisms had to move, and both were mechanisms rather
than assertions:

- the pty driver ran the script as `["/bin/sh", script, …]`, which made it a second declaration of what the
  script was written in — wrong the moment the script changed language. It now execs the script and lets the
  shebang decide;
- the check that discovers which actions the dispatcher maps grepped `case` labels, which Python does not have.
  It reads the dispatcher's own `ACTIONS` now, and still decides what *maps* by running each — which is the
  part worth keeping, because `help` is an action that maps nothing.

`ACTIONS` is load-bearing rather than a list for a reader: an action absent from it is refused before any
branch runs, so a branch not named there is unreachable. A decorative list would have drifted.

### Two bugs the rewrite found, and one it did not

**Reading `/dev/tty` hung the suite.** The first draft of the key reader opened `/dev/tty`, which is the
obvious source for a keypress and is wrong here: a caller driving the menu through a pseudo-terminal writes to
the child's *standard input*, so the reader waited for ever on a key that had already arrived. The shell read
stdin, and so does this. It is also `os.read` rather than a buffered reader, which waits for more than the one
byte asked for.

**Detecting Windows needs both sources.** The suite reaches that branch with a fake `uname` on the path — the
only way to reach it from a machine that is not Windows. `platform.system()` uses the syscall and ignores a
fake binary, so three checks failed. Both are consulted now, `uname -s` first, and that is more correct than
either alone: under a POSIX layer the layer's own answer is what counts, because that is the environment the
npm and brew commands would run in, and where there is no `uname` at all — Windows-native Python — only
`platform.system()` can say so.

**`budget-check`'s two failing cases are shapes the contract permits, not shapes the CLI emits.** Against
today's output the shell reader worked, because `max_input_tokens` happens to be written first inside
`budget`. What it depended on was that order, and JSON member order carries no meaning — so moving one line in
the emitter would have made the gate read no limit and answer `ask` on a plan that should skip. Four cases pin
the reader to the document; two of them fail against the shell version.

### What this makes the Skill depend on

`python3`. The suite already needed it for the pty test and said so — "skipped where python3 is absent rather
than made a dependency of the suite" — and that is no longer a soft dependency. It is a real cost, recorded
rather than argued away: `/bin/sh` is present on more machines than `python3`.

What it buys is the two JSON readers, and the arithmetic. Shell has no floats, so a fractional token limit was
read as its integer prefix; now it is refused as the defect it is.

### Stage 35 closed

Every Acceptance Criterion passes.

### A record written into the wrong repository

This section was appended to a file in the `skills` child and pushed there, because a command ran with the
working directory inside it rather than at the root. `skills/AGENTS.md` says sequencing is tracked in the root
superproject, and nothing in that repository enforced it — so a copy landed, was committed, and passed its
verifier.

Removed, and refused by that verifier now. The check is one file test, and it exists because the boundary was
written down in prose that nothing read.

### Stage 35 closed

Every Acceptance Criterion passes.

## Stage 36 scope

Reported: `--scan=ai` should not use the analyzers — AI should read the whole project — and the surface
should say so. Asked to check whether it works that way.

**It did not, and the reason was worse than the surface suggested.**

### `--scan=ai` sent a supported project nothing at all

`PrecisionClass::eligible_for_ai` is `Unsupported | Heuristic`, and `plan` counted a candidate only for a
language matching it. So a file a deterministic analyzer covers was never a candidate **in any mode**. On a
project written entirely in supported languages — the ordinary case now that ten languages are analyzed —
`--scan=ai` had nothing to send, spent nothing, and changed nothing, while declaring itself `required`.

Measured on a three-file Java project, before and after:

```text
--scan=default  scanned=3 structural=2 candidates=1 input_tokens=366–700
--scan=ai       scanned=3 structural=2 candidates=1 input_tokens=366–700     <- before
--scan=ai       scanned=3 structural=2 candidates=3 input_tokens=2766–7100   <- after
```

### `AiMode::Full` was indistinguishable from `AiMode::Auto`

The narrower fact underneath it, and the one that made the surface's promise unkeepable: **the only branch
on `ai_mode` in the whole crate was `== AiMode::Off`**, for the token estimate. `Full` — documented as
"enrichment is required rather than optional" — produced byte-identical output to `Auto` everywhere,
including in the plan a budget check reads.

So a setting of `ai_mode: "full"` in `.nostdb/settings.json` did nothing whatsoever. This is the same shape
as the defects Stages 18, 19, and 33 each found: a value declared and never produced, passing its own tests
because nothing asserted the two modes differed.

### What changed

`plan` now decides candidacy by mode. `Auto` and `Off` read what an analyzer could not cover; `Full` reads
every scanned file, because that mode asks for AI over the project rather than over the leftovers.

`Off` answers as `Auto` does deliberately. The count is what AI *would* read and the estimate is what this
run spends, which is what lets a plan say "412 files could be enriched, and this run will spend nothing" —
returning zero candidates would collapse that into a number a reader cannot tell from "there is nothing to
enrich".

The budget is why this had to move with the mode rather than being a documentation change. Section 17.6
requires that a call which *could* exceed a hard limit never starts, and the check compares the top of the
plan's estimate. A plan counting one file while AI read three would let a run cross a configured ceiling
with the plan reporting that it fit.

### The direction, given after the finding

`--scan=default` uses the analyzers to scan and produce the `.nostdb`; `--scan=ai` does **not** use them and
a model reads from scratch; and the CLI validates what comes back, with a fix loop on failure.

That resolves what the finding above could not decide, and it resolves it without any of the contract
questions I had recorded — because the model's output is a **`.nost` document**, not a packet and not a
change set. Root `CLAUDE.md` already permits exactly that: "Skills may create candidate `.nost` or graph
changes, but never write `.nostdb`." No `AnalysisPacket` is needed, because there is no structural graph to
build one from and the model reads the source directly. Nothing in `ENRICHMENT.md` is contradicted, because
this is not enrichment.

**The deliverable is the `.nostdb`**, the same artifact `default` produces. A model cannot write one — the
format is opaque and only the Engine writes it — so the candidate is a mechanism, not a second artifact.

### The pipeline, and every command in it already existed

```bash
nostdb init PATH                                                    # 1
nostdb plan --format json --project PATH                            # 2, then the budget check
                                                                    # 3, the model writes CANDIDATE.nost
nostdb convert CANDIDATE.nost STAGING.nostdb                        # 4
nostdb check STAGING.nostdb                                         # 5
                                                                    # 6, the model fixes; back to 4
nostdb convert CANDIDATE.nost PATH/.nostdb/root.nostdb --replace    # 7
```

Verified end to end against 0.1.6 before it was written down: a hand-written candidate standing in for the
model's output checks clean, converts, and `MATCH (n)` returns its records. Three things that had to be
measured rather than assumed:

- **`convert` does not create `.nostdb/`.** Without step 1 it fails with `exit 9`, no such file. So `init` is
  in the pipeline for a mechanical reason as well as a contractual one;
- **step 6 needs `--replace`**, because step 1 already wrote `root.nostdb`. That overwrites the database, and
  on a project that was already built it discards the analyzers' facts and anything a person contributed.
  `SCAN.md` says so and requires the caller be told before it runs;
- **the candidate document is never checked on its own.** It is an intermediate the Engine consumes, and
  what is validated is the database. That was asked for explicitly after an earlier reading checked both.

### The fix loop cannot trust the exit code

Schema validation is soft, so a document violating every schema it declares exits `0` and prints `valid`,
and `convert` commits it while warning. The loop is therefore driven by **whether a diagnostic was printed**,
not by the exit status. Three attempts, then report and do not convert — each attempt costs what the whole
repository costs, and a document nobody could validate is not one to commit over a database that opens.

`NOST_UNRESOLVED_ENDPOINT` is explicitly **not** a failure to fix away: a missing symbol becoming a
Placeholder is the contract's answer, and a model deleting the edge to silence it would remove a fact the
source contains.

### Scope

- `nostdb-core`: `plan` counts candidates by mode, so `Full` reads the whole tree — recorded above, and now
  load-bearing rather than a correction, since step 2 is the only thing between a caller and the cost of
  their repository;
- `nostdb-cli`: `check` validates a `.nostdb` against the Schemas it holds, which is what makes
  "the CLI validates the generated database" true rather than a container decode;
- `skills`: `SCAN.md` is new and required by the verifier; the `enrich` action is renamed **`scan-ai`**,
  because it no longer enriches anything — it replaces the reader; a `check` action is added, which is what
  closes the loop; `SKILL.md`, `ACTIONS.md`, and `ENRICHMENT.md` follow, the last of them now saying it
  describes the `default` pipeline only.

The suite pins the invariant that matters: **`scan-ai` emits no build and offers none as a fallback.** An
action that quietly built with the analyzers when no model was available would report a graph the caller
explicitly did not ask for, and the report would look identical to the one they wanted.

### The restated requirement, and the gap it exposed in `check`

Restated with the correction: the CLI validates the AI-generated **`.nostdb`**, and a failed validation is
fixed. Taken literally that did not work, and the reason was not in the Skill.

**`nostdb check` validated a `.nost` and merely decoded a `.nostdb`.** The `.nost` branch calls `validate`;
the `.nostdb` branch opened the container, read the graph, and printed counts. So the same graph answered
differently depending on which way it was read:

```text
$ nostdb check bad.nost
8:6: warning: NOST_SCHEMA_VIOLATION: the required field count of type integer is missing
9:9: warning: NOST_SCHEMA_VIOLATION: the field name is declared string but holds a integer

$ nostdb check bad.nostdb
bad.nostdb: valid, generation 2, 1 nodes, 0 edges, 0 links, 1 schemas
```

A loop validating the database would therefore never have fired, whatever the model produced.

**The validator already existed and nothing called it.** `EffectiveSchema::combine(schemas, labels)` and its
`violations(properties)` are public, tested, and had no caller outside their own tests — a complete
graph-level conformance rule, written for the model rather than for the document. `check` now uses it, so
there is one answer to "does this record satisfy its Schema" rather than a second rule that could drift from
`validate.rs`.

A record is named by identifier and labels rather than a line and column, because a container has no source
to point into. That is the honest difference between checking a document and checking a database, and it is
why step 4 is still in the pipeline: step 6 overwrites, so a candidate validated only afterwards is one whose
predecessor is already gone by the time anything is known to be wrong.

It stays a **warning** in both readers. Schema validation is soft by contract and an explicit Constraint is
what rejects, so exiting non-zero here would make `check` stricter than the language it reads.

### Validating the database means staging it first

With the document check removed, validating "the generated `.nostdb`" has an ordering problem: step 7
overwrites the project's database, so a run that checked only afterwards would have destroyed the previous
generation before learning anything was wrong. The contract is explicit that a failed mutation preserves the
last valid generation.

So the model's output is converted into a **staging** database, checked there, and only a candidate that
survives is converted over the real one. Both writes are the Engine's: step 7 re-converts from the same
document rather than moving the staging file into place, because a Skill copying an opaque container around
would be handling a format only the Engine may write. The staging database is a validation artifact and is
thrown away.

Step 4 also catches what `check` cannot reach. A document that does not parse never becomes a database, so
`convert` failing *is* the diagnostic and there is nothing left to check.

### What is still missing, and it is one thing

`nostdb plan` has no `--scan` option. It reads `analysis.ai_mode` from `.nostdb/settings.json`, and `init`
writes neither — so the default is `auto`, under which the plan counts only the files no analyzer covers.
Run `--scan=ai` on a Java project with default settings and the plan reports almost nothing while the model
is about to read everything, and the budget is checked against that.

So `--scan=ai` currently requires `"ai_mode": "full"` in the project's settings, set by the caller. A Skill
cannot set it: writing settings is changing state without the Engine, which this repository's own boundary
forbids. `SCAN.md` states the requirement and what the plan under-reports without it.

A `--scan` option on `plan` removes the problem entirely and is a CLI change on top of the Core change this
Stage made. It is not done here because the Core change is unreleased, and a CLI depending on an unpushed
revision is the pin failure Stage 32 exists to prevent.

### What the finding left undecided, and how the direction resolved it

At the point the finding was reported, suppressing the analyzers had no route and three contract questions
stood in the way. They are kept here because the answer is only legible beside them:

- **nothing can express it.** The CLI exposes no AI option at all, and `build` has no mode that skips
  analysis — it calls `analyze::analyze` for every file with a registered language. A `build` flag and a
  `BuildRequest` field would be mechanically easy;
- **`ENRICHMENT.md` says a Skill never sends a repository**, and an analyzer-free run has nothing else to
  send. An `AnalysisPacket` is built *from* the structural graph — symbols, structural edges, unresolved
  references — so with no analyzers there is no packet, and AI would receive raw source instead. Root PRD
  section 17.5 forbids sending an entire repository **by default**, which an explicit flag is not, but this
  repository's own document hardened that into "never";
- **two invariants would need re-reading.** Section 29.1's "supported structural extraction consumes zero
  external AI tokens" governs the analyzer path and is arguably silent about a mode that runs no structural
  extraction; the root contract's "build a valid structural database before optional semantic enrichment"
  is satisfied vacuously by `init` alone, since a failed AI run would then have no structural facts to
  erase. Both readings are defensible, and neither is this Stage's to choose.

Recorded rather than decided, because the choice is what a run costs and whether a whole repository reaches
a model. `IMPLEMENTATION_PROGRESS.md` is where the root contract says an unresolved contract question goes.

### Stage 36 verification

`cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings` (clean),
`cargo test --all-targets --all-features` (986 passed, 0 failed), `./scripts/verify-repository.sh` in
`nostdb-core` and in `skills`, and `./scripts/verify-workspace.sh` in the root.

## Stage 37 scope

Asked that `/nostdb` be able to search for sub-Skills like `nostdb-analyzer-*`, use one when it fits, and
**say** when it does.

`nostdb-analyzer-springboot` had existed since Stage 33 and `/nostdb` could not see it. One sentence of
`COVERAGE.md` mentioned it by name; nothing else did, and there was no way to ask what was installed.

### Discovery, not reference

The layout rule this repository enforces is that everything a definition references lives inside its own
folder, because an installer copies a folder and a reference outside one resolves here and is absent
everywhere else. So `scripts/analyzers.py` holds **no path to a sibling and no list of names**. It looks at
the directory this Skill is installed in — `skills/nostdb` here, `.agents/skills/nostdb` in a project that
installed it — and reports whichever `nostdb-analyzer-*` folders are there.

That is correct beside one, beside several, and beside none, and it is stronger than what it replaces:
`COVERAGE.md` said the *agent* is what knows which Skills are installed. An agent's belief can be a year old.
A directory listing cannot.

The test proves it by **inventing** an analyzer at run time — a folder this repository has never heard of,
created in a temporary install — and asserting it is found and can be announced. A hard-coded list could not
find that, which a grep for names would not have shown.

### Only the frontmatter is read

`name` and `description`, and nothing further. Both are required of every Skill by the verifier, and
`description` is precisely what an agent selects a Skill by — so it is what a caller needs to decide whether
an analyzer fits the project in front of them.

Reading deeper, into a sibling's `presets/index` or its schemas, would couple one Skill to another's internal
layout. A definition is the part a Skill publishes; the rest is its own business.

The reader is about twenty lines rather than a YAML dependency: it takes top-level `key: value` between the
delimiters and skips an indented line, so a nested `metadata:` block is passed over rather than misread. Two
fields do not justify a dependency every install would have to carry.

### Announcing is a command, and refusing is the half that matters

`analyzers.py using NAME` prints one sentence and **refuses a name that is not installed**.

One format means a reader sees the same sentence every time rather than whatever each run invented, and a
test pins it. The refusal is the part about honesty: a Skill announcing a vocabulary it does not have would
be claiming a reading nobody performed, and the output would look exactly like the one that did.

Both spellings of a name resolve — `springboot` and `nostdb-analyzer-springboot` — because the short form is
what somebody types and the long form is what a document names, and refusing either would refuse a name that
is not ambiguous.

### An analyzer Skill is optional, and reading past one is not

Nothing fails when none is installed; `/nostdb` uses the vocabulary it ships itself, and listing reports that
on standard error while printing nothing on standard output. What `AGENTS.md` now forbids is reading a
framework by hand **while a Skill for it is installed**: that produces the same facts under different names,
and the graph then holds two vocabularies for one subject with no way to tell which a query should use.

### Scope

`skills/nostdb/scripts/analyzers.py` is new, with `tests/analyzers.test.sh` in the repository verifier.
`/nostdb analyzers` joins the surface, and the dispatcher refuses it the way it refuses `help` — which Skills
are installed is something the Skill can see and an Engine cannot, so resolving a database to ask what is on
disk would be the wrong order of operations twice over. `SKILL.md`, `COVERAGE.md`, and `AGENTS.md` follow.

### Stage 37 verification

`./scripts/verify-repository.sh` in `skills` (fourteen new checks among them) and `./scripts/verify-workspace.sh`
in the root.

## Stage 38 scope

Asked that a schema be declarable like this:

```nost
schema Project {
  name: string
  description?: string
  dependencies?: {
    name: string
    version?: string
  }[]
}
```

Measured against 0.1.6 first. `?` and one `[]` suffix already worked; **two things did not**, and they
are independent:

```text
schema Project { name: string  description?: string }   -> NOST_PARSE_ERROR: expected `}`
schema Project { d?: { name: string }[] }               -> NOST_PARSE_ERROR: expected a field type
```

So the request is a separator change and a type change, and only the first is confined to syntax.

### The type change could not be a grammar change

`docs/PRD.md` section 11.1 defined `PropertyValue` with `List(Vec<PropertyScalar>)` and no object. Opening
the grammar alone would have declared a field **no record could satisfy** — the same shape as the defects
Stages 18, 19, 33, and 36 each found, and it would have passed its own tests because nothing asserted a
value existed for the type.

Three readings were possible and they were not equivalent, so the choice was requested rather than
invented, which is what this file's own rule says to do when the owning contract has to move:

- **related nodes** — the nested object becomes records joined by an edge. No format change, queryable with
  today's engine, but a field then means a traversal and an anonymous type needs a generated label;
- **embedded object value** — `PropertyValue` gains an object. Reverses two stated invariants and moves
  `nostdb_format_version`;
- **named type only** — `dependencies?: Dependency[]` beside a declared `schema Dependency`, which is not
  the syntax that was asked for.

**Embedded object value was chosen**, with the canonical writer keeping the comma. Both costs were stated
before the choice and both were paid.

### Three contract versions moved, and one deliberately did not

| Contract | From | To | `supported` |
| --- | --- | --- | --- |
| `nost_language_version` | 3 | 4 | `[4]` |
| `nostdb_format_version` | 2 | 3 | `[2, 3]` |
| `result_version` | 1 | 2 | `[1, 2]` |

**The language and the format disagree on their predecessor on purpose.** Every version 4 syntax is
additive, so a version 3 document means exactly what it meant before — and it is still refused, because a
reader accepting `@nost 3` would have to refuse the syntax version 3 had no production for, or else the
number it read governed nothing. That is a field declared and never enforced, which is the defect class
above. Gating syntax on a declared version is real machinery whose whole return is saving a one-line edit
to a file `nost: true` regenerates from the database.

A `.nostdb` is the opposite case: opaque, uneditable, and holding user-owned contributions no analyzer can
rebuild from source. Refusing version 2 would have destroyed data to avoid one decode branch. The branch is
narrow, and the reason is worth recording — **a version 2 list is byte-identical to a version 3 list**,
because a version 2 element was written by the scalar writer and the value tags are disjoint from the
scalar tags, so the version 3 element reader falls through to the same bytes. Only a schema field's declared
type actually changed shape, from a discriminant and a flag to a tagged recursive form, so `Container` now
retains the version it validated and exactly one function reads it.

`query_subset_version` does **not** move. Returning a property that holds an object is the envelope's
business; reaching *inside* one would be new query syntax, and none is added.

### What the finding cost that the request did not predict

Four things had to change that no reading of the request would have named:

- **the CST needed its own field type.** It re-exported `schema::FieldType`, which was safe while a field
  type was one token carrying nothing. An object type contains *fields*, and a field in the CST carries
  comments and a range that the model deliberately does not. Sharing one type would have made a comment
  inside a nested object type unrepresentable, and the canonical form requires every comment to survive a
  format pass;
- **`accepts` had to stop being the whole answer.** An object type accepts any object, and the entries are
  reported separately by path — `dependencies[0].name` — because a Schema is open and validation is soft,
  so a missing nested key is a violation of that key rather than evidence the value is not an object.
  Folding both into one boolean reported a nested typo as "this is not an object", which it is;
- **the object form in a result envelope had to be tagged.** `RESULT.md` already required a tagged value to
  carry exactly one member, and a bare `{"path": "src/main.rs"}` is a path to every consumer reading that
  table. Three of the six tag names — `bytes`, `datetime`, `node` — are reserved words a property key can
  never be, but `relationship`, `path`, and `object` are ordinary identifiers. That only half collide is
  not a reason to emit bare and forbid those three: a key is the author's to choose, and forbidding `path`
  so the envelope could stay untagged pushes a format's problem onto the data;
- **`p.dependencies[0]` was refused with the wrong code.** It reported `CYPHER_SEMANTIC_ERROR: expected the
  end of the query`, which describes a malformed query. Indexing is recognized syntax outside the subset,
  so it is `CYPHER_UNSUPPORTED` now, and the message says to return the property and read it in the caller.

### The bound, and where it is enforced

Nesting is capped at **eight** levels. The contract states it as a *minimum every implementation must
accept* rather than a maximum, so refusal past it is permitted and deliberately **not** fixtured: a fixture
asserting rejection at nine would forbid another implementation from accepting nine. What is fixtured is
acceptance at eight, at both ends of the range.

Enforced in three places, because each reads untrusted input by a different route: the parser checks the
finished type and value, the container decoder checks **while reading** — nothing in a length or a count
bounds how deeply a list nests, so a decoder measuring the finished value would already have recursed as
deep as the bytes asked — and `depth` itself is iterative over an explicit stack, because a value deep
enough to be worth measuring is deep enough to overflow the stack measuring it.

### Two fixtures moved from invalid to valid

`nested_array_type` and `nested_list` asserted the restrictions this version withdraws. They are `valid`
now, with their notes saying version 3 rejected them, rather than deleted: the record that the rule once
existed is the useful part.

### A separator rule without significant whitespace

The comma is optional between two fields, two properties, and two evidence fields — one rule for every
block, because two separator rules would be two rules to learn. Stated without making a line ending
significant: a field is `key [?] : type`, so an identifier after a complete type can only open the next
field, and nothing beyond the current token decides it. Trivia stays trivia.

One regression came out of exactly that. `parse_type_expression` called `skip_trivia` before looking for
`[`, and skipping trivia files every comment as a *pending leading* one — so `name: string // note` lost
its trailing comment to the next line, and a format pass moved that comment down one line every time. The
fixture suite caught it as non-idempotent formatting. An array suffix now sits directly against its type,
which is what version 3 required of the one suffix it allowed.

### Three stale contract headers, and the test that found the third

`NOST_LANGUAGE.md` read `Current version: 2` while the registry said 3, and `NOSTDB_FORMAT.md` read
`Current version: 1` while the registry said 2. Both had survived a bump each, and nothing compared the
line to the registry — so a reader opening a contract was told the wrong version by the document that owns
it.

The check is now a test, and it immediately found a third: `PLUGIN_INSTALL.md` at 1 against a registry
saying 2. The `supported` column went unchecked too, which only mattered once a contract listed two
versions; it is checked now.

### Scope

- `nostdb-spec`: both grammars, `NOST_LANGUAGE.md`, `NOSTDB_FORMAT.md`, `QUERY_SUBSET.md`, `RESULT.md`, the
  version registry, and fixtures — nine new, two moved, and 52 headers bumped;
- `nostdb-core`: `PropertyValue::Map` and a value-holding list, a recursive `FieldType` that loses `Copy`, a
  CST field type of its own, the parser, the canonical writer, validation by path, format version 3 with
  version 2 still readable, `QueryValue::Object`, and the Cypher refusal;
- `nostdb-cli`: the plugin graph exchange renderer and `graph_exchange_version`, plus the two pins;
- `nostdb-server`: the Core pin and nothing else, because the daemon calls public APIs;
- `skills`: the version header in the Spring Boot and JPA presets;
- root: `docs/PRD.md` section 11.1, which is the contract that had to move first.

### The publication step, once it was authorized

`nostdb-cli` pins `nostdb-core` by exact revision, so nothing in the CLI could see this change until Core
was pushed — the constraint Stage 32 exists to enforce and the reason Stage 36 deferred a CLI change. With
the push authorized, the chain was walked in dependency order: `nostdb-spec`, `nostdb-core`,
`nostdb-server`, then `nostdb-cli`. `nostdb-server` is in that chain because it pins Core too, and a CLI
pinning one revision beside a Server pinning another gives Cargo two copies of the Engine.

**The CLI was not, in the end, untouched, and the prediction that it might be was wrong.** Two downstream
consequences only appeared once the new Engine was actually linked:

- **the plugin graph exchange assumed a list element is a scalar.** `plugin_run.rs` duplicated every scalar
  case inside its list arm, which is what a list of scalars needs and a list of objects cannot use. Both
  containers recurse now, and `graph_exchange_version` moved 1 to 2 — a CLI-local version field that no
  registry carries, which is its own small gap. The object is emitted **bare** here, unlike in the result
  envelope: the only tag a value position in this document carries is `{"bytes": n}`, and `bytes` is a
  reserved word no property key can be, so there is nothing to collide with;
- **two Skill presets still declared `@nost 3`.** A preset is a `.nost` document the Engine validates, and a
  version 4 Engine refuses one at the header. The workspace verifier caught it, which is worth recording
  because the test beside it says a preset carried `@nost 2` for two releases after the language moved to 3
  — that time nothing put an Engine on the path.

The CLI also carried two literals that had gone stale through two bumps each: its version-report test
asserted `[3]` and `[2]`, beside a comment claiming the language was at 2 and the container at 1. Both are
derived from the constants now, which is the same repair the specification's contract headers needed.

### One thing this Stage got wrong and corrected

`result_version` was first published with `supported: [1, 2]`, reasoned as "an envelope is a message rather
than a stored artifact, so version 1 stays readable." That is wrong about what `supported` means in this
registry: **the versions this implementation accepts as input.** Nothing in NostDB reads a result envelope —
it only produces them — so listing 1 claimed a reader that does not exist, which is precisely the defect
class this Stage was about. It is `[2]` now, in a follow-up commit, with the reasoning replaced in
`VERSIONS.md` and `RESULT.md` and the lenient check in Core's conformance suite tightened to match.

The format's `[2, 3]` survives that correction unchanged, because Core genuinely does read a version 2
container.

No remote was created and no release was cut. Crate versions stay at 0.1.6: publishing is a separate act
with its own gates, and `nostdb --version --json` reports contract versions rather than a product number.

## Stage 38 acceptance criteria

- The requested declaration parses, validates with no diagnostic, converts to a graph, and round-trips
  through a container.
- A comma is optional between two fields and two properties, and the canonical writer still emits it.
- An object field type is satisfied by an object value, and `{ … }[]` by a list of them.
- A violation inside an object names the offending entry by path.
- Nesting past eight levels is refused by the parser and by the container decoder, and eight is accepted.
- The three moved contract versions agree between `VERSIONS.md`, `versions.json`, and each owning document.
- A version 2 container still opens; a written container declares version 3.
- Formatting stays idempotent, and every comment survives a format pass.
- `cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings`,
  `cargo test --all-targets --all-features`, and both repository verifiers pass.
- `./scripts/verify-workspace.sh` passes at the root, which means every child reports the versions the
  registry declares.

## Stage 38 published revisions

| Repository | Revision |
| --- | --- |
| `nostdb-spec` | `97def88`, after `29a04c5` |
| `nostdb-core` | `9203c6b`, after `f52b35c` |
| `nostdb-server` | `e9c7b46` |
| `nostdb-cli` | `02d2a8d` |
| `skills` | `20abd37` |

Two of them carry a second commit because the `result_version` correction above was found after the first
was already pushed. Each repository was verified on its own before being pushed, and the root pins all five.

## Stage 38 verification

In `nostdb-spec`: `cargo test --all-targets --all-features` (14 suites, all passing) and
`./scripts/verify-repository.sh`.

In `nostdb-core`: `cargo fmt --check`, `cargo clippy --all-targets --all-features -- -D warnings` (clean),
`cargo test --all-targets --all-features` (**1023 passed, 0 failed**), and `./scripts/verify-repository.sh`.
Both run with `NOSTDB_SPEC_FIXTURES` pointing at the sibling checkout, which is how the superproject
supplies them.

`tests/nested_object_values.rs` is new and covers the requested shape end to end through the public API
only: the declaration, the stored value, the container round trip, the canonical form, validation by path,
the depth bound at and past the limit, and the refusal of a contribution block inside an object literal.

In `nostdb-server`: the same four commands, 83 tests passing, and its repository verifier.

In `nostdb-cli`: the same four commands, **259 passed, 0 failed**, and its repository verifier.
`nostdb --version --json` reports `"nost_language_versions": [4]` and `"nostdb_format_versions": [2, 3]`.

In `skills`: `./scripts/verify-repository.sh`.

At the root: `./scripts/verify-workspace.sh` passes, reporting `version conformance: 13 contracts verified`.

### The workspace verifier caught the inconsistency before it was resolved

Between the Engine landing and the CLI being re-pinned, `./scripts/verify-workspace.sh` failed one check,
`every_specified_contract_is_reported` in `nostdb-cli`:

```text
assertion `left == right` failed: nost_language_versions
  left: [3]
 right: [4]
```

That is the gate Stage 14 built, working. Its own comment states the rule: *a build reporting a version the
registry does not carry is claiming something unpublished; one omitting a version the registry carries is
understating what it can read.* For that interval the workspace genuinely was inconsistent — the
specification declared versions the shipped Engine could not read — and the failure is recorded here rather
than erased, because the three ways to make it green without publishing were all worse than the red:

- pinning the CLI to an unpushed revision is the failure Stage 32 exists to prevent;
- relaxing the test would trade a true report for a green one;
- holding the registry at the old versions while the code implemented the new ones would be the same defect
  the Stage was about.

`nostdb --version --json` now reports `[4]` and `[2, 3]`, and the verifier passes with 13 contracts verified.

### Stage 38 closed

Every Acceptance Criterion passes, including the workspace verifier.

### Stage 38 follow-up: the output formats were stated and unproven

Closing the Stage left one thing verified only by hand. `RESULT.md` section 4.2 says a CSV value is rendered
as its JSON form would be, and the same rule carries the table, so an object needed no renderer change at
all: `value_csv` falls back to the JSON form rather than enumerating variants. Correct, and covered by
nothing.

Exercised through the built CLI, all four formats were already right — JSON and JSONL nest the tagged
object, and CSV and the table carry its JSON form in a cell, quoted per RFC 4180. **No defect was found**,
which is worth stating plainly: this is a note about coverage rather than a repair.

A test now pins it in `nostdb-cli`, because the quoting is the part that would have broken silently — an
object's JSON form is made of the two characters RFC 4180 cares about, and a renderer that stopped quoting
would still look like output. `nostdb-cli` is at `485c87c`.

The Stage stays `DONE`. Nothing in its Acceptance Criteria was unmet; a criterion was simply narrower than
the behavior it governed.
