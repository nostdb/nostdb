# NostDB Agent Instructions

This file defines the shared rules for the clean-slate NostDB root workspace and
all future child repositories. A child repository may add a more specific
`AGENTS.md`, but it must not weaken these product, safety, or ownership
boundaries.

## Language policy

Write everything in this workspace in English only.

- Documentation, `README.md`, `AGENTS.md`, ADRs, and progress records are
  English.
- Source code, identifiers, comments, rustdoc, and test names are English.
- Commit messages, branch names, pull request titles and bodies, and issue text
  are English.
- Diagnostics, error messages, log records, and CLI output are English.
- Configuration files, fixtures, and example `.nost` content are English.

This rule holds regardless of the language a request is written in. Do not mix
another language into repository content, and do not add translated copies of a
document unless the user explicitly asks for them.

## Mission

NostDB is a local-first Property Graph Database for software environments.
It stores an always-present opaque `.nostdb`, may materialize a canonical
human-readable `.nost`, and can recursively union explicitly linked local or
GitHub-hosted graph sources without a mandatory central server.

The target is a clean-slate implementation. Code, packages, formats, APIs, and
repository layouts outside this workspace are reference material only and do
not create compatibility requirements.

## Current workspace state

The root repository is documentation and orchestration only. Runtime
implementation repositories have not yet been connected.

Do not:

- copy legacy runtime code into this repository;
- create placeholder submodules or local-path gitlinks;
- create a remote repository, add a remote, push, publish, or release without
  explicit user authorization;
- begin a later implementation Stage during a setup-only request.

`docs/REPOSITORIES.md` records the intended child paths. Real submodules require
exact remote URLs, initialized child repositories, and explicit authorization.

## Required reading order

Before starting any task, read completely:

1. `IMPLEMENTATION_PROGRESS.md`
2. `docs/PRD.md`
3. `docs/ARCHITECTURE.md`
4. `docs/REPOSITORIES.md`
5. the root `README.md`
6. this file
7. the `README.md` and `AGENTS.md` in every target child repository

If a file is missing, stop implementation and repair or report the workspace
setup first.

If documentation and code conflict, do not guess. Record the exact conflict in
`IMPLEMENTATION_PROGRESS.md` and keep the current valid behavior unchanged
until the owning contract is resolved.

## Stage workflow

1. Find the first incomplete Stage in `IMPLEMENTATION_PROGRESS.md` whose
   dependencies are satisfied.
2. Mark only that Stage `IN_PROGRESS` and record the exact scope.
3. Make the minimum changes required by its Acceptance Criteria.
4. Run formatting, build, lint, tests, and repository-specific verification.
5. Record commands and results in `IMPLEMENTATION_PROGRESS.md`.
6. Mark the Stage `DONE` only when every Acceptance Criterion passes.
7. Do not continue automatically to another Stage in the same request.

Never mark two Stages `IN_PROGRESS`.

When a Stage depends on remote creation, publication, credentials, an unknown
URL, or another external decision, leave it `PENDING` and request the missing
authority instead of inventing it.

## Root and child repository boundaries

- Root `nostdb`: cross-repository documents, exact submodule pins, integration
  orchestration, and workspace verification. No runtime implementation.
- `nostdb-spec`: executable grammar, format and protocol contracts, examples,
  and conformance fixtures. No runtime.
- `nostdb-core`: model, parsers, structural analyzers, storage, sync,
  transactions, provider interfaces, and query engine. No CLI, daemon, or HTTP
  interface.
- `nostdb-cli`: command UX, REPL, output formats, embedded Core integration, and
  the only native plugin manager. It does not duplicate storage or query logic.
- `nostdb-server`: one local daemon per OS user, named database catalog, local
  IPC, sessions, recovery, and resource limits. It calls public Core APIs.
- `nostdb-provider-github`: out-of-process GitHub `SourceProvider` and
  `GraphStoreProvider`. It retrieves bytes and metadata; Core interprets graph
  formats.
- `nostdb-distribution`: unscoped npm launcher and verified GitHub release
  assembly. No JavaScript Core reimplementation.
- `homebrew-tap`: Homebrew formula only.
- `skills`: independently installable Agent Skills. Skills may create candidate
  `.nost` or graph changes, but never write `.nostdb`.
- `plugins`: language-neutral manifest schema, authoring guidance, and
  reference plugins. It does not own a second manager or binary reader/writer.

Create `nostdb-mcp` only after the public Core API is stable. It must be a thin
adapter and must not link Core directly by default.

Shared behavior calls public `nostdb-core` APIs. Do not create separate
parsers, synchronizers, query engines, or `.nostdb` writers in CLI, Server,
Skills, providers, plugins, or future adapters.

## Rust standards

- Use Rust stable and Edition 2024.
- Public APIs require explicit error types and rustdoc.
- Use `#![forbid(unsafe_code)]` in initial Core crates where practical.
- Required `unsafe` code needs a separate ADR with documented safety
  invariants and a Miri or equivalent verification plan before implementation.
- Libraries do not panic for ordinary errors.
- Libraries use `tracing` and do not write directly to stdout.
- Configuration and serialization formats have explicit version fields.
- Do not add a dependency without documenting purpose, maintenance status, and
  license.

Every Rust repository must pass:

```bash
cargo fmt --check
cargo check
cargo clippy --all-targets --all-features -- -D warnings
cargo test --all-targets --all-features
```

## Product architecture invariants

- A configured project has `.nostdb/root.nostdb`.
- `.nostdb` is opaque and only Core writes it.
- A readable `.nostdb` opens without a running daemon.
- `.nost` language, `.nostdb` format, settings, provider protocol, plugin
  protocol, and Server protocol versions evolve independently.
- `nost: true` materializes the canonical `.nostdb/root.nost`.
- `nost: false` removes only the configured generated source and never the
  database or unrelated user files.
- Synchronization uses database generations and content digests, not
  “newest timestamp wins.”
- If both `.nost` and `.nostdb` changed from the same baseline, report
  `SYNC_CONFLICT` and modify neither.
- A file path is a mutable source location, not a permanent Entity or Schema
  identity. Use persisted Stable Module IDs and opaque record IDs.
- An Edge always has two non-null endpoints.
- Missing symbols create Warning diagnostics and Placeholder Nodes or unresolved
  Schema references.
- Preserve Placeholder IDs during resolution whenever possible.
- Schema validation may be soft; explicit Constraints are hard.
- Analyzer-owned and user-owned contributions are separate.
- A failed mutation preserves the last valid database generation.

## Analysis and AI boundary

- Storage and queries are programming-language-neutral.
- Do not encode a closed source-language allowlist into `.nostdb`.
- Deterministic analyzers declare their language, fact coverage, precision, and
  version.
- Unsupported text remains eligible for AI fallback and receives an explicit
  capability diagnostic.
- Structural analysis of supported source consumes zero external AI tokens.
- Build a valid structural database before optional semantic enrichment.
- AI receives compact, versioned analysis packets and selected evidence instead
  of a default whole-repository transcript.
- No AI call starts before a visible plan and budget check.
- Partial, truncated, unvalidated, or out-of-scope AI output is not an
  authoritative cache hit.
- AI Skills may propose a versioned GraphChangeSet or write candidate `.nost`.
  Core validates ownership, generation, endpoints, Schemas, Constraints, and
  evidence before commit.

## Provider and credential policy

The MVP remote provider is GitHub only. GitHub must support both:

1. source repository analysis;
2. read-only retrieval of an existing `.nostdb` or `.nost`.

Provider credentials are referenced by name and injected through environment,
OS credential store, protected key-path binding, or process-memory-only prompt.

Never persist or print raw IDs, passwords, tokens, private keys, or PEM content
in settings, graph files, links, caches, plugin locks, diagnostics, or command
output.

Resolve a GitHub branch or tag to one immutable commit before analysis or
query. Queries never advance a remote ref silently; refresh is explicit.

## Link and federation policy

Both forms are valid:

```nost
@link "./packages/child"
@link "./packages/child" as child
```

- Alias is recommended and optional.
- Alias is stored in `.nost` and `.nostdb`, never settings.
- Settings mirror the canonical source and operational credential/timeout data.
- Link identity is the canonical source path or address, not a `link_id` or
  `target_database_id`.
- Moving a target requires explicit relinking unless its relative locator still
  resolves.
- One-way links are valid; mutual links are recommended but never created
  automatically.
- Links recursively union graphs and detect cycles by canonical source.
- Linking does not create Edges or merge same-named Nodes.
- Disconnected components remain disconnected in one result or canvas.
- Linked data is read-only from the root transaction.
- An unavailable link remains declared and yields reachable partial results plus
  a structured warning.

## Query policy

- Start with an explicit openCypher-compatible subset.
- Use `CALL nostdb.*`, functions, or CLI commands for NostDB-specific behavior.
- Unsupported Cypher returns a source-ranged diagnostic and never executes with
  silently changed semantics.
- Result order is undefined without `ORDER BY`.
- A query sees only its root database and recursively declared links.
- Writes affect only the root database.
- JSON, JSONL, CSV, and table output keep data and diagnostics separated.

## Daemon policy

- At most one daemon runs per OS user.
- Use a current-user-protected Unix domain socket or Windows named pipe.
- The MVP has no TCP or HTTP listener.
- Path-based commands work in Embedded Mode without the daemon.
- Named databases use the local daemon catalog under `~/.nostdb/`.
- Server calls public Core APIs and does not duplicate storage or query logic.

## Skill and plugin policy

- The Skill is an AI-capable extension of the CLI, not another Engine.
- AI-free Skill actions map exactly to deterministic CLI actions.
- Resolve commands project-local, then compatible global, then pinned `npx`.
- Never use an unpinned `latest` fallback for a state-changing non-interactive
  action.
- Natural-language reads show generated Cypher and execute it.
- Natural-language writes show exact scope and require confirmation.
- Ambiguous natural-language requests do not execute.
- The CLI owns project/global plugin installation across process boundaries.
- Install plugins from a GitHub source pinned to an exact commit and verified
  digest.
- Plugin installation never executes code.
- A missing required plugin prompts in interactive mode; refusal shows exact
  commands; non-interactive mode returns `PLUGIN_REQUIRED`.
- Plugins execute out of process with shell-free argument vectors.
- Do not claim a plugin sandbox that is not implemented.
- Viewer plugins receive Engine-owned exchange data and never parse `.nostdb`.

## File editing policy

- Preserve existing user changes.
- Never remove or revert them without authorization.
- Use a comment-preserving CST and canonical formatter for `.nost`.
- Reserialize the complete `.nost` file after edits.
- Detect concurrent external edits with content hashes.
- Use a journal or explicit migration plan for coordinated multi-file changes.
- Do not modify imported read-only modules automatically.
- Do not duplicate the PRD into divergent child copies; link to the root
  contract and keep executable details in `nostdb-spec`.

## Testing expectations

Every feature includes coverage appropriate to its boundary:

- parser: valid/invalid syntax, comments, recovery, golden fixtures;
- imports/links: recursion, missing sources, duplicate aliases, cycles,
  namespaces, and disconnected components;
- sync: create/update/delete, stale sources, conflicts, crash rollback, and
  concurrent edits;
- storage: reopen, checksums, migration, corruption, and transaction rollback;
- analysis: provenance, cache invalidation, ownership, unsupported languages,
  partial AI output, and hard budgets;
- query: parse, semantic analysis, execution, transactions, and mapped
  openCypher conformance fixtures;
- CLI: exit classes, JSON/JSONL/CSV, and multiline REPL;
- Server: concurrency, timeouts, user boundary, recovery, and isolation;
- Skills: fixtures proving AI-free actions call the same Core command;
- plugins: manifest, pinning, integrity, consent, failure preservation, and
  viewer performance tiers;
- distribution: project npm, global npm, pinned npx, Homebrew, and GitHub.

## Licensing

- `nostdb-core`, `nostdb-cli`, `nostdb-server`: SSPL-1.0. Describe them as
  **source-available**, not open source.
- `nostdb-spec` executable grammar and fixtures: Apache-2.0.
- `skills` and a future thin `nostdb-mcp`: Apache-2.0.
- provider/plugin extension schemas and future drivers: Apache-2.0.
- root documentation: CC BY-NC-SA 3.0 unless otherwise noted.

## Safety and external actions

- Inspect an existing repository before initialization or topology changes.
- Do not create remote repositories, add remotes, push, publish packages, create
  releases, or modify registries without explicit authorization.
- Never expose credentials in files or tool output.
- Do not use destructive Git commands or broad deletion.
- Preserve the installed `.agents/skills` and `skills-lock.json` unless the user
  explicitly requests changes.
- Existing nested repositories or future submodules are separate ownership
  boundaries. Do not commit across them accidentally.
