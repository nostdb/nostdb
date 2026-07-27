# NostDB Implementation Progress

Last updated: 2026-07-28

Current stage: none is `IN_PROGRESS`. Stage 8 closed at increment 5. Stage 9 stays `PENDING`
until `nostdb-provider-github` is authorized, created, and pinned.

Current milestone: The clean-slate root workspace is initialized, and the
specification, Engine, and command-surface repositories `nostdb-spec`,
`nostdb-core`, and `nostdb-cli` are connected as exact-commit submodules in the
`nostdb` GitHub organization, joined now by `nostdb-server` as scaffolding. Root
and child CI verify the pinned commit set. A configured project can be analyzed,
built, queried, linked, synchronized, and converted from the command line with no
daemon running, which is the boundary the daemon must not erase: it manages named
databases and never becomes a requirement for a path. Each remaining child
repository is a named dependency of the Stage that first needs it rather than a
blocker on all implementation.

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
| 9 | PENDING | GitHub provider | Stage 7, plus connected `nostdb-provider-github` |
| 10 | PENDING | Skills and AI enrichment workflow | Stages 7 and 9, plus connected `skills` |
| 11 | PENDING | Plugin manager and WebGPU reference viewer | Stage 7, plus connected `plugins` |
| 12 | PENDING | npm, Homebrew, and GitHub distribution gates | Stages 8 through 11, plus connected `nostdb-distribution` and `homebrew-tap` |

A Stage whose dependency names a child repository cannot start until that
repository is created, connected, and pinned, and creating it still requires
explicit user authorization at that time.

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

Done, at `nostdb-spec` `89fcd66`, `nostdb-core` `96011ce`, and `nostdb-cli` `36edb62`:
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
