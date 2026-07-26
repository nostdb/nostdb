# NostDB Implementation Progress

Last updated: 2026-07-26

Current stage: `Stage 3 DONE` (`Stage 4 PENDING`)

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
| 4 | PENDING | Storage and transaction foundation | Stage 3 |
| 5 | PENDING | Parser, sync, and deterministic analysis foundation | Stage 4 |
| 6 | PENDING | openCypher subset and query execution | Stage 5 |
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

Stage 4 was not started in this request.
