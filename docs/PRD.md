# NostDB Product Requirements Document

Status: Draft implementation contract
Target: Clean-slate MVP
Document version: 0.1
Date: 2026-07-26

## 1. Document authority

This document defines the target product for the clean-slate NostDB
implementation. Existing source code, package names, repository contents, file
formats, APIs, and documentation are reference material only and are not
compatibility requirements.

This document does not authorize deleting the existing workspace, creating
remote repositories, publishing packages, or pushing changes. Those actions
require separate user authorization.

The words **MUST**, **MUST NOT**, **SHOULD**, **SHOULD NOT**, and **MAY** are
normative.

## 2. Product summary

NostDB is a local-first Property Graph Database for software environments.
It analyzes locally accessible projects and GitHub repositories into nodes,
edges, properties, and source evidence. The result is stored in an opaque,
portable `.nostdb` database file.

A `.nostdb` file can be opened by the embedded Engine without a running daemon.
Multiple databases can form one logical graph by declaring links to other
accessible `.nostdb` or `.nost` sources. A central server is not required.

Projects may opt into a canonical, human-readable `.nost` representation for
Git-based review and direct editing. Only the Engine may create or modify a
`.nostdb`. AI Skills and plugins may create `.nost`, propose versioned graph
changes, and invoke the Engine, but they MUST NOT implement or invoke a separate
binary writer.

NostDB supports three complementary operating modes:

1. **Embedded Mode** opens a `.nostdb` directly in the current process.
2. **Linked File Mode** reads a recursively linked set of local or GitHub-hosted
   graph files as one logical, read-only federation.
3. **Local Managed Mode** uses one daemon per operating-system user to manage a
   catalog of named databases on that machine.

The MVP daemon is local-only. It does not accept TCP, HTTP, or cross-host client
connections.

## 3. Problem statement

Software knowledge is fragmented across repositories, languages, manifests,
configuration, documentation, and remote source locations. Developers and
agents repeatedly inspect the same files to answer architecture, dependency,
ownership, and change-impact questions. Existing file paths are useful
locations, but they are poor permanent identities, and a mandatory central
service makes portable or decentralized use difficult.

NostDB must provide:

- a durable graph representation of software structure and meaning;
- evidence that traces graph facts back to accessible source;
- deterministic querying without requiring AI;
- optional AI enrichment without giving AI ownership of the database format;
- direct file operation when no daemon is running;
- decentralized graph federation through declared links;
- optional per-user centralized management on a single machine;
- an extensible provider and plugin model without embedding provider secrets in
  graph files.

## 4. Goals

The clean-slate MVP MUST:

- create `.nostdb/root.nostdb` for a configured local project;
- analyze local source trees and GitHub repository snapshots;
- impose no product-level programming-language allowlist;
- expose analyzer capability and confidence instead of implying equal precision
  for every language;
- create a useful structural graph without external AI token usage whenever a
  deterministic analyzer is available;
- allow AI to enrich unresolved or semantic graph areas under an explicit
  budget;
- query local and linked graphs with an openCypher-compatible subset;
- execute direct queries without AI;
- convert and synchronize `.nostdb` and `.nost`;
- recursively traverse one-way or mutual links;
- preserve broken links and return reachable partial results with structured
  warnings;
- support GitHub as the only remote provider in the MVP;
- support GitHub both as source to analyze and as storage for an existing graph
  file;
- keep linked databases read-only from the root database;
- provide one local daemon and named-database catalog per OS user;
- provide an Agent Skill as an AI-capable extension of the same CLI and Engine;
- install and execute language-neutral plugins through the native CLI manager;
- generate a WebGPU-oriented graph viewer through a separately installed
  plugin;
- distribute the Engine and CLI through npm, Homebrew, and GitHub;
- permit global and project-local npm installation;
- support pinned, no-permanent-install execution through `npx`.

## 5. Non-goals for the MVP

The MVP does not include:

- compatibility with any previous NostDB package, API, binary, or file format;
- remote network access to `nostdb server`;
- cross-server transactions or remote graph writes;
- writes through a linked database, even when its file is locally writable;
- remote providers other than GitHub;
- automatic relocation of a link when its target path or address changes;
- automatic creation of reciprocal links;
- an application HTTP API server;
- a plugin security sandbox claim;
- a promise of identical semantic accuracy for every programming language;
- an MCP adapter before the public Core API is stable;
- package publication, remote repository creation, or release automation as
  part of this PRD.

## 6. Primary users and use cases

### 6.1 Developer

A developer builds or refreshes a graph, executes Cypher, inspects evidence, and
uses the viewer:

```bash
nostdb build .
nostdb query 'MATCH (n:Function) RETURN n.name ORDER BY n.name LIMIT 20'
nostdb view .
```

### 6.2 AI-assisted developer

An AI-assisted developer invokes the Skill:

```text
/nostdb .
/nostdb query "What connects authentication to the database layer?"
/nostdb query --cypher 'MATCH p = (:Service)-[:CALLS*1..5]->(:Database) RETURN p'
```

The Skill may analyze source and propose graph changes, but the CLI and Engine
validate and commit every database mutation.

### 6.3 Decentralized graph user

A user keeps related `.nostdb` files in separate projects or GitHub
repositories. Declared links make reachable databases appear as a single
logical graph without a central server.

### 6.4 Local managed-mode user

A user starts one local daemon and registers multiple databases under stable
local names. Local clients connect through OS-user-protected IPC.

### 6.5 Provider or plugin author

An author implements an independent source provider, graph-store provider, or
action plugin using versioned, language-neutral contracts. The extension never
parses or writes `.nostdb` directly.

## 7. Product invariants

The following invariants apply across every mode:

1. A configured local project always has a `.nostdb` database, and only that
   root database plus its declared links are visible by default.
2. `.nostdb` is opaque and not human-editable.
3. Only the Core Engine writes `.nostdb`.
4. The Engine can open a readable `.nostdb` without a running daemon.
5. `.nost`, `.nostdb`, settings, plugin manifests, provider protocols, and
   server protocols carry explicit and independently versioned formats.
6. A file path is a mutable source location, not the permanent identity of an
   Entity or Schema.
7. A link is identified by its canonical source path or address. NostDB does not
   require a `link_id` or `target_database_id` to resolve a link.
8. Moving a link target requires explicit relinking unless a relative locator
   continues to resolve naturally after moving the containing tree.
9. Linking databases unions their graph records; it does not synthesize edges or
   merge same-named nodes.
10. Disconnected linked components remain disconnected and appear separately in
    the same logical result or viewer canvas.
11. An Edge always has two non-null endpoints.
12. Missing referenced symbols produce explicit Placeholder Nodes or unresolved
    Schema references.
13. Resolving a Placeholder SHOULD preserve its internal ID.
14. Query result order is undefined unless the query contains `ORDER BY`.
15. Unsupported Cypher syntax produces an explicit diagnostic and never executes
    with silently changed meaning.
16. Linked graph records are read-only from the root query context.
17. Secrets are never stored in `.nostdb`, `.nost`, project settings, plugin
    lock files, or source locators.
18. Analyzer-owned data and user-owned data are tracked separately.
19. A failed build, sync, link refresh, or plugin action must not corrupt the
    last valid database generation.

## 8. Clean-slate repository topology

### 8.1 Root superproject

The new root repository is a Git superproject named `nostdb`. Independently
versioned implementation repositories are checked out as direct child
submodules:

```text
nostdb/
├── docs/                         # Root product and architecture documents
├── nostdb-spec/                  # Language, formats, fixtures, conformance
├── nostdb-core/                  # Parser, model, storage, sync, query
├── nostdb-cli/                   # CLI, REPL, plugin manager
├── nostdb-server/                # Per-user daemon and local protocol
├── nostdb-provider-github/       # GitHub SourceProvider and GraphStoreProvider
├── nostdb-distribution/          # npm launcher and GitHub release assembly
├── homebrew-tap/                 # Homebrew formula repository
├── skills/                       # Independently installable Agent Skills
├── plugins/                      # Manifest schema and reference plugins
├── .gitmodules
└── README.md
```

The exact directory names above are normative for the initial workspace.

The full workspace is obtained with one command:

```bash
git clone --recurse-submodules https://github.com/<organization>/nostdb.git
```

An option-free `git clone` fetches the root and submodule pointers but not
submodule contents. Existing partial clones are completed with:

```bash
git submodule update --init --recursive
```

The root repository MUST:

- pin every submodule to an exact commit;
- never depend on a floating submodule branch for a reproducible build;
- run CI with recursive submodule checkout;
- provide a root verification command that detects missing or dirty submodules;
- contain cross-repository documentation and orchestration only;
- avoid duplicating runtime implementation owned by a child repository.

Each child repository MUST build and test independently. Root integration tests
MUST exercise the exact pinned commit set.

### 8.2 Repository responsibilities

| Repository | Responsibility |
| --- | --- |
| `nostdb-spec` | `.nost` grammar, `.nostdb` format contract, protocol schemas, examples, and conformance fixtures; no runtime |
| `nostdb-core` | model, parsers, storage, synchronization, providers' public interfaces, structural analyzers, transactions, and query engine |
| `nostdb-cli` | user-facing commands, REPL, output formats, process plugin manager, and embedded Engine integration |
| `nostdb-server` | per-user process, named database catalog, local IPC, sessions, recovery, and local resource limits |
| `nostdb-provider-github` | GitHub snapshot resolution, source enumeration, content retrieval, graph-file retrieval, and credential consumption |
| `nostdb-distribution` | unscoped npm package, native binary selection, verified release downloads, and distribution tests |
| `homebrew-tap` | Homebrew formula and checksum updates |
| `skills` | AI and non-AI action routing; never an independent `.nostdb` writer |
| `plugins` | plugin schema, authoring guide, and reference viewer; never a second plugin manager |

`nostdb-mcp` is created only after the Core API is stable. It will be a thin
adapter and will not link Core directly by default.

### 8.3 Implementation standards

The reference Core, CLI, and Server implementations use Rust stable and Edition
2024. Public APIs require explicit error types and rustdoc.

Initial Core crates use `#![forbid(unsafe_code)]` where practical. Required
`unsafe` code needs a separate ADR that defines safety invariants and a Miri or
equivalent verification plan before implementation.

Every Rust repository must pass:

```bash
cargo fmt --check
cargo check
cargo clippy --all-targets --all-features -- -D warnings
cargo test --all-targets --all-features
```

Dependencies are added only after purpose, maintenance status, and license
review. Libraries use typed errors and `tracing`, do not print directly to
stdout, and do not panic for ordinary errors.

## 9. Logical architecture

```text
                       ┌──────────────────────────┐
Local filesystem ─────▶│ Local SourceProvider     │
                       └────────────┬─────────────┘
                                    │ SourceSnapshot
GitHub repository ────▶ GitHub SourceProvider
                                    │
                                    ▼
                      ┌───────────────────────────┐
                      │ Scan and Build Planner    │
                      └────────────┬──────────────┘
                                   │
                     ┌─────────────┴─────────────┐
                     ▼                           ▼
          Deterministic analyzers        AI-capable Skill
                     │                   GraphChangeSet/.nost
                     └─────────────┬─────────────┘
                                   ▼
                        NostDB Core Engine
                 validate → transact → query → sync
                                   │
                     ┌─────────────┴─────────────┐
                     ▼                           ▼
               root.nostdb                  root.nost
                 opaque                    optional
                     │
             recursive read-only links
                     │
          local files or GitHub graph files
```

Clients use the same public Core behavior in Embedded and Server Modes. The CLI,
Server, Skill, provider implementations, and plugins MUST NOT duplicate the
query engine, `.nost` parser, synchronization engine, or `.nostdb` writer.

## 10. Project and user layout

### 10.1 Project state

A configured project stores state under its project root:

```text
<project>/
└── .nostdb/
    ├── settings.json
    ├── sync.json              # what the two representations last agreed on
    ├── root.nostdb
    ├── root.nost              # only when human-readable mode is enabled
    ├── cache/
    ├── journal/
    ├── plugins/
    └── out/
        ├── view.html
        └── view.data.bin
```

The nearest ancestor containing `.nostdb/settings.json` is the active project.
An explicit `--project` or `--database` argument overrides discovery.

`sync.json` records the synchronization baseline defined in section 14. It sits
beside the database rather than inside it: a baseline records the digest of the
whole database file, so writing it into that file would change the digest it had
just recorded and advance the generation it had just named.

The default database is:

```text
<project>/.nostdb/root.nostdb
```

### 10.2 User-global state

User-global state is stored under:

```text
~/.nostdb/
├── settings.json
├── credentials.json
├── catalog.json
├── cache/
├── plugins/
└── run/
```

All files containing operational state MUST be readable and writable only by
the current OS user where the platform supports such permissions.

### 10.3 Settings merge

Global settings load first. Project settings override global values by defined
field, not by arbitrary recursive JSON merging. Unknown fields MUST be preserved
when a newer settings version is opened read-only and rejected on mutation when
their semantics cannot be preserved.

Example project settings:

```json
{
  "settings_version": 1,
  "database": {
    "path": "root.nostdb",
    "nost": false
  },
  "analysis": {
    "ai_mode": "auto",
    "max_input_tokens": null,
    "max_output_tokens": null,
    "max_cost_usd": null,
    "on_budget_exceeded": "ask"
  },
  "links": [
    {
      "source": "./packages/child",
      "credential_ref": null,
      "refresh": "manual",
      "timeout_ms": 10000
    },
    {
      "source": "github://example/shared/graphs/root.nostdb?ref=main",
      "credential_ref": "github.work",
      "refresh": "manual",
      "timeout_ms": 15000
    }
  ],
  "plugins": {
    "view": "org.nostdb.view-webgpu"
  }
}
```

Settings link entries contain operational information and MUST NOT contain an
alias. A link is semantically declared in `.nostdb` and, when materialized, in
`.nost`. An orphan settings entry that has no matching database declaration is
ignored with `ORPHAN_LINK_SETTINGS`.

A state-changing CLI operation that adds or removes a semantic link reconciles
the corresponding settings entry through an explicit multi-file journal.
Synchronizing a `.nost` link change uses the same path. A read-only open never
mutates settings merely to fill a missing mirror entry; it uses default
operational values and reports the mismatch.

## 11. Graph data model

### 11.1 Property graph

A database contains Nodes, Edges, optional Schemas, Constraints, source
evidence, link declarations, and build metadata.

Conceptual Core types:

```rust
pub struct LocalNodeId([u8; 16]);
pub struct LocalEdgeId([u8; 16]);

pub struct ScopedNodeId {
    pub source: CanonicalSourceLocator,
    pub local: LocalNodeId,
}

pub enum PropertyValue {
    Boolean(bool),
    Integer(i64),
    Float(f64),
    String(String),
    Bytes(Vec<u8>),
    DateTime(String),
    List(Vec<PropertyScalar>),
}

pub struct Node {
    pub id: LocalNodeId,
    pub labels: Vec<String>,
    pub properties: Vec<(String, PropertyValue)>,
    pub contributions: Vec<Contribution>,
}

pub struct Edge {
    pub id: LocalEdgeId,
    pub source: NodeReference,
    pub target: NodeReference,
    pub relation: String,
    pub properties: Vec<(String, PropertyValue)>,
    pub contributions: Vec<Contribution>,
}

pub enum NodeReference {
    Local(LocalNodeId),
    External(ScopedNodeId),
}
```

Stored property `null` is not supported in the MVP. In queries, `null` means a
missing or non-applicable value. Assigning `null` removes a property.

Labels and relation names are case-sensitive UTF-8 strings after normalization
and validation defined by `nostdb-spec`.

### 11.2 Identity

`LocalNodeId` and `LocalEdgeId` are opaque persistent identifiers within a
database. A linked node is identified in a logical union by:

```text
(canonical source locator, local node ID)
```

The target database's internal identity is not used for link resolution.

A minted identifier is a UUID version 7, written as a kind prefix followed by
the canonical UUID text. The prefix keeps a node identifier from being accepted
where an edge identifier is required. An identifier a user states in `.nost` uses
the same form, so every implementation reads it identically.

Source path, package path, and repository URL are mutable locators, never an
identity. On rename, the Engine may use provider-native rename information,
content hashes, and unambiguous structural evidence to preserve a record's
identity. If preservation is ambiguous, it MUST create a new identity rather
than silently merging two entities.

An analyzer-owned entity is matched through a versioned analyzer namespace and a
semantic symbol key. A user-authored `.nost` entity may declare its opaque ID
explicitly, and omitting it lets the Engine mint one.

### 11.3 Contributions and ownership

Graph records may contain contributions from multiple producers:

```rust
pub struct Contribution {
    pub owner: Owner,
    pub source_unit: SourceUnitId,
    pub evidence: Vec<Evidence>,
}

pub struct Owner(String);
```

An owner is one string, and its kind follows from the name: `user` is the user,
an `ai:` prefix is AI analysis followed by the digest of the contract that ran,
and every other name is an analyzer naming itself. `user` and the `ai:` prefix
are reserved.

An owner carries no version. Carrying one was justified by saying an upgraded
analyzer must not adopt the previous version's facts, and that is what left
records answering to a name no change set names, so nothing could withdraw them
and a graph held two readings of every file. What this section needs is that a
refresh replaces its **own** prior contributions, which one name delivers.

An analyzer refresh may replace only contributions owned by that analyzer and
source unit. It MUST preserve user contributions and contributions from other
analyzers. A Node is physically removed only when no contribution or retained
Edge requires it.

### 11.4 Evidence and confidence

Every analyzer-created Node and Edge MUST have provenance:

```rust
pub struct Evidence {
    pub source: CanonicalSourceLocator,
    pub resolved_revision: Option<String>,
    pub path: Option<String>,
    pub content_digest: String,
    pub range: Option<SourceRange>,
    pub producer: String,
    pub producer_version: String,
    pub method: EvidenceMethod,
    pub confidence: Confidence,
}

pub enum EvidenceMethod {
    Deterministic,
    AiInferred,
    UserDeclared,
}

pub enum Confidence {
    Extracted,
    Inferred { score: f32 },
    Ambiguous { score: f32 },
}
```

Confidence scores MUST be finite and within `0.0..=1.0`.

### 11.5 Missing symbols

If an import, call, Schema endpoint, or external reference names a symbol that
cannot be resolved, the Engine creates a typed Placeholder Node or unresolved
Schema reference. It never stores an Edge with a null endpoint.

Resolution SHOULD reuse the Placeholder's local ID. When it cannot, the
transaction records an explicit identity replacement event.

### 11.6 Schemas and Constraints

Schemas may validate Nodes, Edges, labels, relation types, properties, and Edge
endpoints. Schema validation may operate in a soft mode that records warnings.
Explicit Constraints are always hard and reject the transaction.

A missing imported Schema produces a Warning and an unresolved Schema reference
by default. It is never treated as a matching wildcard. Removing a Schema that
is still referenced by a hard Constraint is rejected.

## 12. `.nostdb` database format

`.nostdb` is a single opaque file optimized for size, opening, graph traversal,
and indexed property search. The storage implementation is owned exclusively by
`nostdb-core`.

The format MUST provide:

- a magic header and independent `nostdb_format_version`;
- explicit endianness and integer-width rules;
- bounded parsing for untrusted files;
- per-section or per-page checksums;
- a database generation number;
- transaction or journal recovery;
- atomic commit semantics;
- schema and index metadata;
- link declarations and last resolved link snapshots;
- analyzer and sync metadata;
- migration detection and explicit unsupported-version diagnostics;
- reopen, checksum, rollback, and migration conformance tests.

The format MUST NOT contain:

- plaintext credentials;
- provider passwords, tokens, private keys, or PEM contents;
- executable plugin code;
- a requirement that a daemon be running;
- a path used as the permanent identity of an Entity or Schema.

An Engine may use memory mapping, buffered reads, an embedded database
algorithm, or a custom page format, provided the public format invariants and
acceptance tests pass. Low-level layout is specified in `nostdb-spec`, not in
the CLI or Server repositories.

## 13. `.nost` human-readable format

### 13.1 Purpose

`.nost` is an optional canonical source representation for direct editing,
review, and Git management. It is not required in Embedded or Server Mode.

The MVP materializes one canonical file:

```text
<project>/.nostdb/root.nost
```

Multi-file source layouts may be added later without changing graph semantics.

### 13.2 Illustrative syntax

The exact EBNF belongs to `nostdb-spec`. The required semantic shape is:

```nost
@nost 2

@link "./packages/child"
@link "./packages/shared" as shared
@link "github://example/platform/graphs/root.nostdb?ref=main" as platform

schema Function {
  name: string,
  language?: string,
  labels?: string[],
}

schema Database {
  name: string,
}

node login: Function {
  id: "n_0198a1b2-c3d4-7e5f-8a9b-0c1d2e3f4a5b",
  name: "login",
  language: "rust",
}

node database: Database {
  name: "primary",
}

edge login -> database :CALLS {}

edge login -> shared::authorize :CALLS {}
```

A Schema declares the typed fields a record of that kind carries, and its name
is that record's label. A record MAY name no Schema, in which case the name is
an unvalidated label. A Node MAY name several Schemas; an Edge names exactly
one, because an Edge has exactly one relation type.

Schema validation is soft and records warnings, as section 11.6 requires.
Explicit Constraints remain hard.

`id` and `labels` are reserved property keys. `id` carries the opaque record
identifier and MAY be omitted, in which case the Engine mints one. `labels`
carries additional labels beyond the Schema name, and a Schema must declare the
field before its records may use it.

Both link forms are valid:

```nost
@link "./packages/child"
@link "./packages/child" as child
```

Aliases are recommended and optional. An alias is stored in `.nost` and
`.nostdb`, never in settings.

An aliasless link can participate in the logical union. An explicit external
reference without an alias uses the locator form defined by `nostdb-spec`;
aliases are recommended for readable manual edges.

### 13.3 Canonical formatting and comments

The formatter MUST:

- parse into a comment-preserving CST;
- preserve comments and their attachment to declarations;
- reserialize the complete file;
- use a deterministic declaration and property order;
- produce byte-identical output for a second format pass;
- write atomically;
- reject invalid identifiers or properties with source ranges.

AI and user edits to `.nost` MUST be passed through the canonical formatter
before synchronization.

### 13.4 Human-readable mode

Project setting `database.nost` controls materialization:

- `nost: true` materializes and maintains `root.nost`;
- `nost: false` removes only the configured generated `root.nost`;
- changing the setting never deletes `root.nostdb`;
- unrelated user `.nost` files are never deleted automatically.

## 14. Synchronization

Synchronization uses database generations and content digests, not “newest
timestamp wins.”

The baseline records:

```rust
pub struct SyncBaseline {
    pub database_generation: u64,
    pub database_digest: String,
    pub nost_content_digest: String,
}
```

The required state machine is:

| Database since baseline | `.nost` since baseline | Result |
| --- | --- | --- |
| unchanged | unchanged | no-op |
| unchanged | changed | validate and atomically update `.nostdb` |
| changed | unchanged | report `.nost` stale; require explicit regeneration |
| changed | changed | `SYNC_CONFLICT`; modify neither representation |

If `nost: true` and `root.nost` is missing, the Engine materializes it from the
current database. A stale `.nost` is regenerated only by an explicit export or
materialization command.

Synchronization MUST:

- validate syntax, references, Schemas, and hard Constraints before mutation;
- use a journal or single atomic transaction;
- detect a source edit that occurs during synchronization through content
  hashes;
- preserve the prior database on failure;
- preserve comments during canonical reserialization;
- never modify records reached through a link, which are read-only;
- report create, update, delete, and unresolved deltas.

## 15. Source and graph-store providers

### 15.1 Separate provider roles

Source analysis and graph-file federation are separate capabilities:

```rust
pub trait SourceProvider {
    type Snapshot;

    fn resolve(
        &self,
        locator: &SourceLocator,
        credentials: &CredentialHandle,
    ) -> Result<Self::Snapshot, ProviderError>;

    fn enumerate(
        &self,
        snapshot: &Self::Snapshot,
    ) -> Result<Box<dyn Iterator<Item = SourceEntry>>, ProviderError>;

    fn read(
        &self,
        snapshot: &Self::Snapshot,
        entry: &SourceEntry,
    ) -> Result<Vec<u8>, ProviderError>;
}

pub trait GraphStoreProvider {
    type Snapshot;

    fn resolve_graph(
        &self,
        locator: &GraphLocator,
        credentials: &CredentialHandle,
    ) -> Result<Self::Snapshot, ProviderError>;

    fn materialize_read_only(
        &self,
        snapshot: &Self::Snapshot,
        cache: &ContentCache,
    ) -> Result<ReadOnlyGraphArtifact, ProviderError>;
}
```

A provider may implement one or both interfaces. Provider protocols are
versioned and language-neutral. Third-party providers execute out of process
unless separately approved for in-process use.

### 15.2 MVP providers

The MVP includes:

- a built-in local filesystem provider;
- an independently maintained GitHub provider.

The GitHub provider is a separate executable built from
`nostdb-provider-github`, bundled at a compatible version in official
distributions, and invoked out of process through the provider protocol. It is
not a general action plugin. The provider retrieves bytes and metadata; only
Core interprets `.nost` or `.nostdb`.

GitHub supports both:

1. analyzing repository source into graph changes;
2. retrieving an existing `.nostdb` or `.nost` for read-only federation.

Remote SSH hosts, object stores, databases, and other repository services are
deferred.

### 15.3 Credential resolution

Settings contain only `credential_ref`. A credential definition describes how
to obtain a secret without storing the secret:

```json
{
  "credentials_version": 1,
  "credentials": {
    "github.work": {
      "provider": "github",
      "token_env": "NOSTDB_GITHUB_TOKEN"
    },
    "future.ssh": {
      "provider": "ssh",
      "username_env": "NOSTDB_SSH_USER",
      "private_key_path_env": "NOSTDB_SSH_KEY_PATH"
    }
  }
}
```

MVP credential resolvers MAY use:

- environment variables;
- an OS credential store;
- an interactive, process-memory-only prompt;
- a path to a protected key file, where only the path is persisted.

Raw credentials MUST NOT appear in logs, command output, caches, settings,
links, plugin locks, `.nost`, or `.nostdb`.

## 16. GitHub provider contract

### 16.1 Locator

The canonical GitHub grammar is:

```text
github://<owner>/<repository>/<path>?ref=<git-ref>
```

Examples:

```text
github://example/payments/?ref=main
github://example/payments/.nostdb/root.nostdb?ref=v1.2.0
```

Owner and repository names are canonicalized case-insensitively. Repository
paths and refs preserve case. Reserved characters are percent-encoded.
Credentials never appear in the URI.

The provider MAY accept normal GitHub browser URLs as input, but MUST normalize
them to the canonical form before storing or comparing a locator.

### 16.2 Immutable snapshots

A branch or tag is resolved to an immutable commit before enumeration or
reading. Every build and query uses one consistent commit snapshot.

The configured locator remains the link identity. The resolved commit and
content digest are operational snapshot metadata, not a target identity.

Queries MUST NOT silently advance a branch. `nostdb link refresh` explicitly
resolves and records a newer commit.

### 16.3 Efficient first build

The provider SHOULD enumerate the Git tree before fetching content. It uses Git
Blob IDs and the user content cache to avoid downloading files with reusable
analysis artifacts. Every downloaded graph artifact receives an independent
cryptographic digest before opening.

If a cached immutable snapshot is available, it MAY be used while GitHub is
temporarily inaccessible and MUST be reported as cached. If no valid snapshot
is available, the link remains declared but unavailable.

## 17. Analysis and build pipeline

### 17.1 Pipeline

The initial and incremental pipeline is:

```text
resolve immutable source snapshot
  → enumerate and filter
  → produce BuildPlan
  → deterministic structural extraction
  → resolve cross-file structural references
  → validate GraphChangeSet
  → atomically commit usable structural `.nostdb`
  → select semantic gaps
  → budgeted AI enrichment
  → validate and atomically commit each completed semantic batch
  → record coverage and diagnostics
```

The usable structural generation MUST be committed before optional AI
enrichment. AI failure therefore cannot erase the structural database.

### 17.2 Scan filtering

The scanner MUST:

- honor `.gitignore`;
- honor a `.nostdbignore` with Git-ignore-compatible exclusion semantics;
- never allow `.nostdbignore` to re-include a path already excluded by
  `.gitignore` unless the user explicitly disables Git ignore handling;
- prune known dependency, build, cache, and generated-output directories;
- skip binary and oversized files unless an analyzer explicitly supports them;
- identify potentially sensitive sources before any AI dispatch;
- record ignored, sensitive, unclassified, permission-denied, and unsupported
  files in build coverage;
- default to not following symlinks;
- detect symlink cycles when following is explicitly enabled.

### 17.3 Language policy

Storage and query behavior are language-neutral. The Engine MUST NOT encode a
closed list of programming languages into `.nostdb`.

Each analyzer declares:

```rust
pub struct AnalyzerCapability {
    pub language: String,
    pub precision: PrecisionClass,
    pub facts: Vec<FactKind>,
}

pub enum PrecisionClass {
    DeterministicSemantic,
    DeterministicSyntactic,
    Heuristic,
    AiFallback,
    Unsupported,
}
```

A capability declares coverage and precision, not attribution. It carries no
version: which named analyzer among a build's own deterministic readers produced
a record is not something a query can act on, and the information a reader does
act on is `precision`, `EvidenceMethod`, and `Confidence`. Versioning what a
build asserts about a file belongs to one number, the graph record shape version,
rather than one per analyzer.

This does not touch `Owner::Analyzer` in section 11.3. An owner's version is part
of a contribution's identity, is declared in `nostdb-spec`, and is required
grammar in `.nost`.

An unsupported text language remains eligible for AI analysis and at minimum
produces a source/module record with an explicit capability diagnostic. The UI
and query results MUST NOT imply that heuristic or AI fallback results have the
same confidence as deterministic facts.

### 17.4 Structural analysis

Deterministic analyzers SHOULD extract, where the language allows:

- packages, modules, files, types, classes, functions, methods, and fields;
- declarations and definitions;
- import/export and package dependencies;
- direct calls;
- inheritance and interface implementation;
- configuration-defined entry points;
- source ranges and content hashes.

Each of these is an ordinary Node or Edge. A module in this list is a module of
the analyzed programming language, extracted like any other record; it is not a
container the graph model treats specially, and `.nost` has no module
declaration.

Structural analysis of supported files uses zero external AI tokens.

### 17.5 AI analysis packet

The Skill MUST NOT send an entire repository to AI by default. It requests a
compact, versioned packet from the Engine:

```rust
pub struct AnalysisPacket {
    pub packet_version: u32,
    pub source_unit: SourceUnitId,
    pub symbols: Vec<SymbolSummary>,
    pub structural_edges: Vec<EdgeSummary>,
    pub unresolved_references: Vec<ReferenceSummary>,
    pub selected_evidence_spans: Vec<SourceExcerpt>,
    pub neighboring_units: Vec<SourceUnitSummary>,
}
```

A packet is anchored on the source unit it was derived from, which is the same
unit a `Contribution` names. Anchoring both on one identity is what lets an
analyzer refresh replace exactly the contributions its previous run produced.

AI enrichment is prioritized for:

- unresolved dynamic calls and references;
- reflection and generated dispatch;
- cross-language boundaries;
- high-centrality public modules;
- rationale present in comments or design documents;
- files without a deterministic analyzer;
- areas directly relevant to the user's requested analysis.

AI MUST NOT re-emit deterministic imports, calls, inheritance, or package edges
as independent facts. It may attach additional evidence or semantic
contributions to an existing record.

### 17.6 Build planning and budget

No AI action begins before producing a plan:

```rust
pub struct BuildPlan {
    pub plan_version: u32,
    pub source_revision: String,
    pub scanned_files: u64,
    pub structural_files: u64,
    pub unsupported_files: u64,
    pub semantic_candidates: u64,
    pub semantic_cache_hits: u64,
    pub estimated_input_tokens: TokenRange,
    pub estimated_output_tokens: TokenRange,
    pub budget: AiBudget,
}

pub struct AiBudget {
    pub max_input_tokens: Option<u64>,
    pub max_output_tokens: Option<u64>,
    pub max_cost_usd: Option<String>,
    pub on_exceeded: BudgetAction,
}
```

Token limits are normative. USD estimates are advisory unless the active AI
provider exposes reliable pricing and usage.

Before each AI batch, the Skill verifies that the maximum estimated batch cost
fits the remaining budget. It never starts a call that would exceed a hard
limit.

AI work units are grouped by module and dependency neighborhood, then packed by
estimated tokens rather than a fixed file count. Oversized units are split on
syntax or document boundaries before dispatch. Context-overflow retries use a
bounded split depth and are charged to the same budget; retries never bypass a
limit. AI concurrency is provider-configurable and bounded, because concurrency
reduces elapsed time but not token cost.

Default Skill behavior:

1. build the structural database without asking;
2. use configured AI limits when present;
3. when limits are absent, show the estimate and ask once before enrichment;
4. in non-interactive mode, skip enrichment unless explicit limits or
   authorization are present;
5. report `semantic: partial` when the budget or a failed batch leaves work.

### 17.7 Cache keys

Parsing and contextual resolution use separate keys:

```rust
pub struct StructuralParseCacheKey {
    pub content_digest: String,
    pub language: String,
    pub analyzer_digest: String,
    pub analyzer_config_digest: String,
    pub graph_schema_version: u32,
}

pub struct ContextResolutionCacheKey {
    pub source_unit: SourceUnitId,
    pub parse_artifact_digest: String,
    pub dependency_context_digest: String,
    pub resolver_digest: String,
}

pub struct SemanticCacheKey {
    pub analysis_packet_digest: String,
    pub context_digest: String,
    pub analysis_contract_digest: String,
    pub model_identity: String,
    pub analysis_mode: String,
}
```

The whole Engine version MUST NOT invalidate all caches. A cache is invalidated
only by the component contract that affects its result.

Partial, truncated, unvalidated, or out-of-scope AI output MUST NOT become an
authoritative cache hit. Completed batches are checkpointed so a later failure
does not rebill successful work.

Cache lookup order is:

1. project cache under `<project>/.nostdb/cache`;
2. current-user content-addressed cache under `~/.nostdb/cache`;
3. fresh analysis.

The user cache is private to the OS user and can be disabled per project.
Neither cache is committed by default. A future remote or team cache requires a
separate trust and confidentiality design.

### 17.8 Incremental rebuild

Repeated `/nostdb .` and `nostdb build .` invocations are incremental by
default:

- unchanged files are skipped using provider revision metadata and content
  hashes;
- only changed source units and affected context-resolution units are analyzed;
- analyzer-owned contributions for changed or deleted sources are replaced
  atomically;
- user-owned contributions remain;
- a failed replacement preserves the prior valid generation;
- `--rebuild` explicitly bypasses reusable analysis artifacts.

### 17.9 Graph changes and coverage

Analyzers and Skills submit a versioned change contract:

```rust
pub struct GraphChangeSet {
    pub change_set_version: u32,
    pub base_generation: u64,
    pub owner: Owner,
    pub source_snapshot: String,
    pub operations: Vec<GraphOperation>,
}

pub enum GraphOperation {
    UpsertNode(NodeDraft),
    UpsertEdge(EdgeDraft),
    RemoveContribution(ContributionKey),
    ResolvePlaceholder(PlaceholderResolution),
    UpsertLink(LinkDraft),
    RemoveLink(CanonicalSourceLocator),
}

pub struct BuildCoverage {
    pub coverage_version: u32,
    pub structural: CoverageState,
    pub semantic: CoverageState,
    pub cached_units: u64,
    pub deferred_units: u64,
    pub failed_units: Vec<SourceUnitFailure>,
    pub skipped_sources: Vec<SkippedSource>,
    pub unresolved_units: u64,
}
```

The Engine validates the complete change set, ownership boundary, base
generation, endpoints, Schemas, Constraints, and evidence before commit. A
stale `base_generation` returns a conflict instead of rebasing silently.

A change set is an interchange artifact, not a database. It cannot be renamed
to `.nostdb` or opened as one.

## 18. Links and decentralized federation

### 18.1 Declaration

Links are stored in `.nostdb` and, when materialized, in `.nost`:

```nost
@link "./packages/child"
@link "./packages/child" as child
```

The `source` string, after provider-specific canonicalization, is the link
identity. NostDB does not allocate a separate `link_id` and does not resolve by
a target database ID.

### 18.2 Local resolution

A local link may reference:

- a `.nostdb` file;
- a `.nost` file;
- a project directory containing `.nostdb/settings.json`;
- a directory containing `.nostdb/root.nostdb`.

Relative paths resolve from the file that declares the link. Directory
resolution prefers the configured project database. A `.nost` target is parsed
into an Engine-owned read-only graph representation; the Skill or plugin does
not compile it independently.

### 18.3 Nested project discovery

When building a parent project, the scanner treats a nested configured
`.nostdb` directory as a child database boundary:

- the parent does not duplicate the child's source;
- the parent adds or reconciles an aliasless relative link to the nearest child
  root;
- an existing manual link wins and is not duplicated;
- nested child discovery is deterministic;
- running inside the child selects the child as the active project.

### 18.4 Logical union

Starting from root database `A`:

- if `A` links `B`, query and view include `A ∪ B`;
- if `B` links `C`, they include `A ∪ B ∪ C`;
- traversal continues recursively within configured limits;
- cycles are detected by canonical source locator;
- the same reachable locator is opened once per query snapshot.

Linking does not create a relationship. Same-name Nodes in different sources
remain distinct because their scoped IDs differ. If no Edge connects two
components, both components remain visible and disconnected.

Two different canonical locators remain different logical sources even when
their current bytes are identical. NostDB does not guess that a moved or copied
database is the same target; the user must relink explicitly.

Default safety limits are:

```json
{
  "max_link_depth": 16,
  "max_link_databases": 256,
  "link_open_timeout_ms": 10000
}
```

Limits are configurable and exceeding one returns a structured partial-result
warning.

### 18.5 One-way and mutual links

A one-way link is valid. A mutual link is recommended for symmetric discovery,
but the Engine never modifies the target to create it. A linter MAY emit an
informational `ONE_WAY_LINK` diagnostic.

### 18.6 Unavailable links

An inaccessible source does not delete its declaration. The Engine returns:

- all reachable results;
- a `LinkStatus` entry for the unavailable source;
- `LINK_UNAVAILABLE` with the canonical locator and reason;
- Placeholder results for explicitly referenced remote symbols when necessary.

The viewer renders the broken link and disconnected reachable components. A
query can opt into `--strict-links`, which turns any unavailable required link
into a non-zero command result.

### 18.7 Link refresh

Queries operate against the last resolved immutable snapshot and never
silently advance a remote ref.

```bash
nostdb link refresh
nostdb link refresh 'github://example/shared/.nostdb/root.nostdb?ref=main'
```

Refresh verifies and caches the new snapshot before replacing the old snapshot
metadata. On failure, the previous valid snapshot remains available.

### 18.8 Writes

A root query transaction may write only to its root database. Attempting to
create, update, or delete a linked Node, linked Edge, or linked property returns
`LINKED_DATABASE_READ_ONLY`.

A user may open a local target database directly and write to it as a new root
transaction. Cross-server and provider-mediated remote writes are deferred.

## 19. Query language

### 19.1 Compatibility policy

The public query language starts with an openCypher-compatible subset.
NostDB-specific behavior uses functions, procedures, or CLI commands rather
than incompatible syntax.

The MVP subset includes:

- `MATCH` and `OPTIONAL MATCH`;
- fixed and bounded variable-length patterns;
- `WHERE`;
- `WITH`;
- `RETURN` and `DISTINCT`;
- `ORDER BY`, `SKIP`, and `LIMIT`;
- `UNION` and `UNION ALL`;
- `UNWIND`;
- parameters;
- scalar, list, map, aggregation, predicate, and path expressions required by
  the mapped conformance fixtures;
- `CREATE`, `MERGE`, `SET`, `REMOVE`, `DELETE`, and `DETACH DELETE` against the
  root database;
- explicit transactions at the Core API and REPL boundaries;
- `CALL` procedures.

Unsupported clauses or expression semantics return `CYPHER_UNSUPPORTED` with a
source range. They never run using a guessed alternative.

### 19.2 NostDB functions and procedures

Initial extensions include:

```cypher
CALL nostdb.links()
CALL nostdb.build_status()
CALL nostdb.evidence($scoped_node_id)
CALL nostdb.refresh_links()

RETURN nostdb.source(n)
RETURN nostdb.source_location(n)
RETURN nostdb.source_revision(n)
RETURN nostdb.link_alias(n)
RETURN nostdb.is_available(n)
```

`nostdb.evidence` returns bounded source evidence and access metadata. Reading a
source excerpt requires provider permission and is read-only. An unavailable
source returns metadata and a warning rather than fabricating content.

### 19.3 Logical graph scope

A query starts at one root database and sees that root plus recursively linked
databases. No unrelated database from the filesystem or daemon catalog is
implicitly visible.

### 19.4 Results

The canonical machine-readable result envelope is:

```json
{
  "result_version": 1,
  "columns": ["name", "source"],
  "rows": [
    ["authorize", "github://example/shared/.nostdb/root.nostdb?ref=main"]
  ],
  "summary": {
    "rows": 1,
    "database_generation": 42,
    "linked_databases_opened": 2,
    "partial": true
  },
  "warnings": [
    {
      "code": "LINK_UNAVAILABLE",
      "source": "./packages/legacy",
      "message": "The declared target could not be opened."
    }
  ]
}
```

CLI output formats include table, JSON, JSONL, and CSV. Machine-readable modes
keep data on stdout and diagnostics on stderr. JSON includes structured
warnings in the result envelope.

## 20. Core and CLI commands

### 20.1 Required command surface

```text
nostdb help [COMMAND]
nostdb init [PATH]
nostdb plan [PATH]
nostdb build [PATH]
nostdb apply CHANGESET
nostdb check TARGET
nostdb convert INPUT OUTPUT
nostdb export --nost
nostdb sync NOST_FILE
nostdb query [CYPHER]
nostdb link add|remove|list|check|refresh
nostdb catalog add|remove|list
nostdb server [start|run|stop|status]
nostdb plugin add|remove|list|inspect
nostdb view [TARGET]
```

`nostdb plan` and `nostdb build` are deterministic Engine actions. They do not
call an AI provider. The Skill adds semantic analysis and passes a versioned
`.nost` or `GraphChangeSet` back through `nostdb apply` or `nostdb sync`.

### 20.2 Query modes

Interactive mode:

```bash
nostdb query
```

The REPL supports multiline Cypher terminated by `;` and:

```text
:help
:begin
:commit
:rollback
:database
:quit
```

Immediate mode:

```bash
nostdb query 'MATCH (n) RETURN n LIMIT 10'
```

### 20.3 Conversion and validation

Both directions are supported:

```bash
nostdb convert .nostdb/root.nostdb .nostdb/root.nost
nostdb convert .nostdb/root.nost .nostdb/root.nostdb
nostdb check .nostdb/root.nost
nostdb check .nostdb/root.nostdb
```

`.nost` to `.nostdb` conversion is always performed by the Core Engine. A
conversion to an existing target uses atomic replacement and refuses an
unresolved sync conflict.

### 20.4 Exit classes

Stable symbolic diagnostics are normative. Numeric exit classes are:

| Exit | Class |
| --- | --- |
| `0` | success, including success with non-strict warnings |
| `2` | usage or unsupported query syntax |
| `3` | validation or format error |
| `4` | sync or transaction conflict |
| `5` | unavailable required source or strict-link failure |
| `6` | credential or permission failure |
| `7` | plugin requirement or plugin execution failure |
| `8` | AI budget or analysis authorization failure |
| `9` | I/O or corruption error |
| `10` | internal invariant failure |

Libraries return typed errors and never convert ordinary errors to process exit
codes.

## 21. Per-user local daemon

### 21.1 Scope

There is at most one running NostDB daemon per OS user. It provides local
central management for named databases on that machine.

The MVP daemon:

- uses a Unix domain socket on Unix-like systems;
- uses a current-user ACL-protected named pipe on Windows;
- does not listen on TCP or HTTP;
- trusts the OS-authenticated current user instead of implementing passwords;
- rejects clients from other OS users;
- persists the named database catalog under `~/.nostdb/catalog.json`;
- uses an OS lock to enforce one instance.

Suggested endpoints:

```text
Unix:    ~/.nostdb/run/nostdb.sock
Windows: \\.\pipe\nostdb-<user-sid>
```

The local protocol has its own `server_protocol_version`.

### 21.2 Lifecycle

```bash
nostdb server
nostdb server start
nostdb server status
nostdb server stop
nostdb server run
```

`nostdb server` is an alias for `nostdb server start`. `run` stays in the
foreground for service managers and debugging. Starting when the daemon is
already healthy returns success and reports its endpoint.

### 21.3 Catalog

```json
{
  "catalog_version": 1,
  "databases": {
    "work": {
      "path": "/absolute/path/to/.nostdb/root.nostdb"
    }
  }
}
```

A path-based CLI command uses Embedded Mode. A named target such as `@work`
uses the daemon:

```bash
nostdb query --database @work 'MATCH (n) RETURN count(n)'
```

The daemon does not make an unrelated named database visible to a query.

### 21.4 Transactions and recovery

The Server calls the public Core transaction API. It does not duplicate storage
or query behavior. It enforces:

- transaction isolation;
- query timeouts;
- per-session resource limits;
- crash recovery;
- stale-session cleanup;
- serialized catalog mutation;
- local authentication boundaries.

## 22. Agent Skill

### 22.1 Product relationship

The Skill is the AI-capable extension of the NostDB CLI. It is not a separate
database implementation, competing command surface, or file writer.

Every action declares its AI requirement:

```rust
pub enum AiUsage {
    None,
    Optional,
    Required,
}
```

Examples:

| Skill action | AI usage |
| --- | --- |
| `/nostdb help` | none |
| `/nostdb view .` | none |
| `/nostdb plugin add ...` | none |
| `/nostdb query --cypher ...` | none |
| `/nostdb query "natural language"` | required |
| `/nostdb . --ai=off` | none |
| `/nostdb .` | optional for enrichment |
| `/nostdb . --ai=full` | required |

### 22.2 Required examples

```text
/nostdb .
/nostdb query "What connects authentication to persistence?"
/nostdb query --cypher 'MATCH (n)-[r]->(m) RETURN n, r, m LIMIT 100'
/nostdb help
/nostdb . --nost
/nostdb .nostdb/root.nost --sync
/nostdb view .
/nostdb plugin add 'https://github.com/owner/repository'
```

`/nostdb .` uses the current directory and creates or incrementally refreshes:

```text
<project>/.nostdb/root.nostdb
```

`--nost` sets `database.nost` to `true` and materializes the canonical `.nost`.
Omitting `--nost` does not turn an already enabled human-readable project off.
Disabling it requires an explicit settings or CLI action.

### 22.3 Natural-language query policy

For a read-only natural-language request, the Skill:

1. generates openCypher;
2. displays the generated query;
3. executes it automatically;
4. returns both query and results;
5. may inspect bounded source evidence through the provider when the graph
   identifies relevant files.

For a write request, the Skill:

1. generates openCypher or a GraphChangeSet;
2. displays the exact operation and affected scope;
3. requires explicit confirmation;
4. executes only after confirmation.

For an ambiguous request, the Skill asks a clarifying question and does not
execute.

### 22.4 Engine resolution

The Skill resolves the compatible `nostdb` command in this order:

1. project-local executable, including `node_modules/.bin/nostdb`;
2. compatible global executable from npm, Homebrew, or GitHub installation;
3. pinned no-permanent-install execution:

```bash
npx --yes --package=nostdb@<compatible-version> nostdb ...
```

The Skill MUST NOT use an unpinned `latest` fallback for a state-changing
non-interactive action. The selected command is verified with:

```bash
nostdb --version --json
```

No Engine installation is required for the Skill to draft `.nost`, but that
draft is not a valid `.nostdb`. Validation, synchronization, query, and
database creation require the resolved Engine command.

## 23. Plugin system

### 23.1 Ownership

The native plugin manager is implemented once in `nostdb-cli`. Installations
persist across CLI and Server processes. Skills invoke that manager and do not
implement a second registry.

Install locations:

```text
Project: <project>/.nostdb/plugins/
Global:  ~/.nostdb/plugins/
```

Project plugins take precedence over global plugins with the same name.

### 23.2 Manifest

Every plugin contains `nostdb-plugin.json`:

```json
{
  "manifest_version": 1,
  "name": "org.nostdb.view-webgpu",
  "version": "1.0.0",
  "nostdb": ">=0.1.0 <0.2.0",
  "entrypoint": {
    "command": ["bin/nostdb-view"]
  },
  "protocol_version": 1,
  "actions": [
    {
      "name": "view",
      "ai_usage": "none"
    }
  ],
  "permissions": {
    "graph_read": true,
    "database_write": false,
    "output_paths": [".nostdb/out/**"],
    "network_hosts": []
  }
}
```

The command is an argument vector. It is never interpreted by a shell.
Manifest and plugin protocols are language-neutral.

Plugins execute out of process. They receive authorized graph data through a
versioned Engine-owned exchange stream or temporary artifact. They do not
receive a `.nostdb` parser API and MUST NOT read or write the binary format
directly.

### 23.3 GitHub installation

The MVP plugin source is GitHub:

```text
https://github.com/<owner>/<repository>[?ref=<git-ref>][#<subdirectory>]
```

If no ref is supplied, the manager resolves the default branch once. Every
installation records:

- canonical repository URL;
- exact resolved commit;
- plugin subdirectory;
- manifest digest;
- source tree digest;
- selected global or project scope;
- approved permissions.

Installation MUST NOT execute plugin code. It validates paths, archive limits,
manifest compatibility, and digests first. Later execution refuses a
digest-mismatched installation.

Anyone may author a compatible plugin. A signature may strengthen trust, but
the MVP does not claim that an unsigned third-party plugin is safe.

### 23.4 Consent

An explicit `nostdb plugin add` is installation authorization. If scope is
omitted in an interactive project, the CLI asks between project and global and
recommends project scope.

If another action requires a missing plugin:

1. identify the exact recommended plugin, pinned source, permissions, and scope;
2. ask whether to install;
3. on consent, install and immediately resume the original action;
4. on refusal, show exact install and retry commands;
5. in non-interactive mode, return `PLUGIN_REQUIRED` and commands without
   installing.

## 24. Viewer plugin

### 24.1 Command

```text
/nostdb view .
```

maps to the deterministic CLI/plugin action and writes:

```text
.nostdb/out/view.html
.nostdb/out/view.data.bin
```

For sufficiently small graphs:

```bash
nostdb view . --standalone
```

may embed data in `view.html`.

### 24.2 Logical content

The viewer receives:

- the root graph;
- recursively reachable linked graphs;
- scoped source identity for every item;
- disconnected components without synthetic relationships;
- link statuses and broken-link markers;
- evidence metadata needed for source navigation.

The plugin receives this data through the Engine and never parses raw
`.nostdb`.

### 24.3 Rendering strategy

The reference viewer MUST:

- use WebGPU when available;
- use instanced node and edge rendering;
- use compute-assisted layout where supported;
- stream or incrementally decode `view.data.bin`;
- apply level of detail, clustering, edge aggregation, and label culling;
- avoid allocating the full graph as browser DOM elements;
- provide a Canvas-based small-graph fallback;
- return `VIEW_CAPACITY_EXCEEDED` rather than crash when safe limits cannot be
  met.

Target tiers on the published reference benchmark machine:

| Tier | Graph size | Target |
| --- | --- | --- |
| Baseline | 10,000 Nodes / 50,000 Edges | interactive in at most 2 seconds; 60 FPS target |
| Full detail | 100,000 Nodes / 1,000,000 Edges | first interaction in at most 10 seconds; 30 FPS target |
| Overview | 1,000,000 Nodes / 10,000,000 Edges | clustered/LOD interaction in at most 30 seconds |

The benchmark report MUST identify browser, GPU, CPU, memory, dataset, and
whether WebGPU or fallback rendering was used.

## 25. Distribution and installation

### 25.1 npm

The unscoped npm package is:

```text
nostdb
```

It is an intentional clean-slate package and has no compatibility obligation
to any previous package with that name.

Supported installation:

```bash
npm install --save-dev nostdb
npm install --global nostdb
npx --yes --package=nostdb@<version> nostdb help
```

The npm package is a thin launcher for verified platform-native artifacts. It
does not reimplement Core in JavaScript. Platform resolution and artifact
checksums are tested for every supported release target.

### 25.2 Homebrew

```bash
brew install <organization>/tap/nostdb
```

The formula installs the same native CLI/Engine and verifies the release
checksum.

### 25.3 GitHub

GitHub installation supports:

- a versioned native archive from GitHub Releases with published checksums;
- source installation from a pinned CLI tag:

```bash
cargo install --git https://github.com/<organization>/nostdb-cli \
  --tag <version> --locked nostdb
```

Release archives, npm wrappers, Homebrew formulae, and source builds MUST report
compatible `nostdb --version --json` data.

### 25.4 Version report

```json
{
  "product": "nostdb",
  "engine_version": "0.1.0",
  "nostdb_format_versions": [1],
  "nost_language_versions": [1],
  "server_protocol_versions": [1],
  "provider_protocol_versions": [1],
  "plugin_protocol_versions": [1]
}
```

## 26. Security requirements

The MVP MUST:

- treat source repositories, `.nost`, `.nostdb`, plugin archives, and query text
  as untrusted input;
- never execute analyzed source code;
- bound recursion, allocation, archive expansion, source file size, query work,
  and link traversal;
- prevent archive path traversal and symlink escape;
- reject non-finite numeric properties;
- validate every Edge endpoint before commit;
- redact secrets and credential-bearing environment variables;
- keep project and user caches out of source analysis;
- use TLS and normal GitHub certificate validation;
- restrict the daemon endpoint to the current OS user;
- keep plugins out of process;
- display plugin permissions before implicit dependency installation;
- avoid claiming plugin sandboxing where none exists;
- preserve the last valid database after corruption, process interruption, or
  partial AI output.

Libraries use typed errors and `tracing`; they do not write directly to stdout
and do not panic for ordinary failures.

## 27. Reliability and transactional behavior

### 27.1 Build

- Structural output commits as one atomic generation.
- Each semantic batch validates and commits atomically.
- A semantic job tracks completed, failed, deferred, and cached source units.
- Deleting a source removes only owned contributions.
- External source changes during a build invalidate the affected batch.

### 27.2 Query

- A query uses a consistent root database generation.
- Each linked source is pinned to one snapshot for the query.
- Root writes execute in a transaction.
- Linked writes fail before mutation.
- Timeouts and resource limits return structured diagnostics.

### 27.3 Sync

- Conflict detection occurs before mutation.
- Journal recovery is tested at each write boundary.
- A formatter or validation failure changes neither representation.

### 27.4 Plugin

- Installation and lock update are atomic.
- Execution uses the locked digest.
- Plugin failure preserves database and prior viewer output unless the new
  output has been fully generated and atomically promoted.

## 28. Diagnostics

Every diagnostic has:

```rust
pub struct Diagnostic {
    pub code: String,
    pub severity: Severity,
    pub message: String,
    pub source: Option<String>,
    pub range: Option<SourceRange>,
    pub details: Option<serde_json::Value>,
}
```

Required stable codes include:

```text
CYPHER_UNSUPPORTED
CYPHER_SEMANTIC_ERROR
NOST_PARSE_ERROR
NOSTDB_FORMAT_UNSUPPORTED
NOSTDB_CORRUPT
SYNC_CONFLICT
NOST_SOURCE_STALE
LINK_UNAVAILABLE
LINK_CYCLE
LINK_LIMIT_EXCEEDED
LINKED_DATABASE_READ_ONLY
ORPHAN_LINK_SETTINGS
PROVIDER_AUTH_REQUIRED
PROVIDER_PERMISSION_DENIED
ANALYZER_UNSUPPORTED
ANALYSIS_PARTIAL
AI_BUDGET_EXCEEDED
PLUGIN_REQUIRED
PLUGIN_INCOMPATIBLE
PLUGIN_DIGEST_MISMATCH
VIEW_CAPACITY_EXCEEDED
SERVER_ALREADY_RUNNING
SERVER_PROTOCOL_UNSUPPORTED
```

Warnings do not silently change query semantics.

## 29. Performance and cost requirements

### 29.1 Initial build cost

- Supported structural extraction consumes zero external AI tokens.
- No AI call starts before a visible BuildPlan exists.
- A configured hard token budget is never exceeded by starting another batch.
- AI input is based on compact AnalysisPackets and selected evidence, not a
  default whole-repository transcript.
- GitHub Blob and local content cache hits avoid redundant parsing and AI work.
- Concurrency is bounded separately for CPU analysis, provider I/O, and AI
  calls.

### 29.2 Open and query

The Core benchmark suite MUST publish results for:

- 10,000 Nodes / 50,000 Edges;
- 100,000 Nodes / 1,000,000 Edges;
- 1,000,000 Nodes / 10,000,000 Edges.

Metrics include database size, cold open, warm open, indexed equality lookup,
one-hop traversal, bounded path traversal, and linked-union overhead.

Specific release gates are set from the first reproducible baseline rather than
invented from an unimplemented format. Regressions require an explicit recorded
exception.

### 29.3 Query safety

Default query and federation limits are configurable. An estimate or `EXPLAIN`
surface MUST be available before executing work likely to exceed configured
limits.

## 30. Test and acceptance matrix

### 30.1 Storage and format

- create, close, reopen, and query `.nostdb`;
- detect modified bytes through checksums;
- recover or roll back after interruption at every journal boundary;
- migrate supported old fixtures;
- reject unsupported format versions explicitly;
- prove platform-portable fixture reads;
- prove no daemon is needed to open a file.

### 30.2 `.nost`

- valid and invalid syntax;
- comments and canonical round trips;
- recovery diagnostics with ranges;
- link declarations with and without aliases;
- duplicate alias and duplicate source diagnostics;
- user edits synchronized through Core;
- stale and divergent state handling;
- conversion in both directions.

### 30.3 Analysis

- valid and invalid language syntax;
- deterministic provenance;
- unsupported-language capability reporting;
- changed, created, deleted, and renamed sources;
- analyzer-owned replacement preserving user data;
- cached, partial, failed, and deferred AI units;
- hard budget enforcement;
- source changes during analysis;
- zero external AI tokens for structural-only supported fixtures.

### 30.4 Links

- local file, local directory, `.nost`, and `.nostdb` targets;
- GitHub public and credentialed fixtures;
- one-way, mutual, recursive, and cyclic links;
- duplicate reachable sources;
- alias and aliasless links;
- disconnected components;
- unavailable targets with partial results;
- explicit remote refresh;
- moved target requiring relink;
- linked write rejection;
- Placeholder preservation.

### 30.5 Query

- parsing, semantic analysis, planning, execution, and rollback;
- mapped openCypher conformance scenarios;
- explicit diagnostics for unsupported syntax;
- undefined ordering without `ORDER BY`;
- JSON, JSONL, CSV, and table output;
- multiline REPL;
- bounded path queries over linked graphs;
- evidence and source procedures.

### 30.6 Server

- exactly one daemon per OS user;
- current-user IPC access;
- denial across user boundaries;
- named database catalog recovery;
- concurrent sessions and transaction isolation;
- timeouts and resource limits;
- no TCP or HTTP listener in the MVP.

### 30.7 Skills

- AI-free actions call the same CLI commands across Codex and Claude;
- natural-language reads display and execute generated Cypher;
- natural-language writes require confirmation;
- ambiguous requests do not execute;
- project, global, and pinned `npx` command resolution;
- Skill never writes `.nostdb`;
- missing viewer plugin consent, refusal, and non-interactive paths.

### 30.8 Plugins and viewer

- manifest validation and compatibility;
- global/project precedence;
- GitHub ref resolution and exact commit pinning;
- no code execution during installation;
- digest mismatch refusal;
- shell-free invocation;
- database preservation on plugin failure;
- WebGPU and fallback behavior;
- published viewer benchmark tiers.

### 30.9 Distribution

- npm project install;
- npm global install;
- pinned npx execution;
- Homebrew install;
- GitHub native archive;
- pinned Cargo Git installation;
- identical version and conformance fixture behavior across channels.

### 30.10 Repository workspace

- recursive clone populates every pinned child repository;
- root verification detects an uninitialized submodule;
- each child builds and tests independently;
- root CI verifies the exact pinned commit set;
- no runtime implementation is duplicated in the root repository.

## 31. MVP completion criteria

The MVP is complete only when a user can:

1. recursively clone the clean-slate source workspace;
2. install the same Engine through npm, Homebrew, or GitHub;
3. run `/nostdb .` or `nostdb build .` in a local project;
4. obtain a valid `.nostdb/root.nostdb` before optional AI enrichment finishes;
5. query it without a daemon;
6. opt into, edit, validate, and synchronize `.nostdb/root.nost`;
7. analyze a GitHub repository through the GitHub provider;
8. link local and GitHub graph sources recursively;
9. receive partial results and visible broken-link state when a target is
   unavailable;
10. start one per-user local daemon and query a named database;
11. install a viewer plugin with consent and generate the required viewer
    artifacts;
12. pass the conformance, reliability, security, distribution, and performance
    gates in this document.

## 32. Deferred roadmap

The following require a later PRD or ADR:

- network-accessible Server Mode;
- cross-server or provider-mediated writes;
- providers other than local filesystem and GitHub;
- distributed transactions;
- multi-user authentication and authorization;
- encrypted `.nostdb`;
- automatic link relocation;
- multi-file `.nost` layouts;
- plugin sandboxing;
- remote plugin registries;
- MCP and language drivers;
- application API server behavior.

## 33. Licensing

The clean-slate repositories use:

- `nostdb-core`, `nostdb-cli`, and `nostdb-server`: SSPL-1.0 and described as
  **source-available**, not open source;
- `nostdb-spec` executable grammar and fixtures: Apache-2.0;
- `skills` and a future thin `nostdb-mcp`: Apache-2.0;
- provider/plugin extension schemas and future drivers: Apache-2.0;
- root documentation: CC BY-NC-SA 3.0 unless otherwise noted.

Every repository carries its own license and dependency review. New
dependencies require purpose, maintenance, and license review before adoption.
