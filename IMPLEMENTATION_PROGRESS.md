# NostDB Implementation Progress

Last updated: 2026-07-26

Current stage: `Stage 6 DONE`. Stage 7 is `PENDING` on a connected `nostdb-cli`.

Current milestone: The clean-slate root workspace is initialized, and the
specification and Engine repositories `nostdb-spec` and `nostdb-core` are
connected as exact-commit submodules in the `nostdb` GitHub organization. Root and
child CI verify the pinned commit set. Each remaining child repository is now a
named dependency of the Stage that first needs it rather than a blocker on all
implementation.

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
| 7 | PENDING | CLI, REPL, conversion, and link management | Stage 6, plus connected `nostdb-cli` |
| 8 | PENDING | Per-user local daemon | Stage 7, plus connected `nostdb-server` |
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

Not yet run: continuous integration. All three commits are local, because pushing was not
authorized in this request. Root CI verifies the pinned commit set, and a root pin cannot
resolve until the child commits are pushed, so the order when it is authorized is both
children first and the root last.

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
