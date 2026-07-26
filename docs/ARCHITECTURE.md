# NostDB Target Architecture

This document summarizes the target architecture. The normative product
contract is [PRD.md](PRD.md).

## System shape

```text
Local filesystem ──▶ Local SourceProvider ─┐
                                          ├─▶ Build Planner
GitHub ─────────────▶ GitHub Provider ─────┘        │
                                                   ├─▶ deterministic analysis
                                                   └─▶ optional AI enrichment
                                                               │
                                                               ▼
                                                        NostDB Core
                                               validate / store / sync / query
                                                               │
                                           ┌───────────────────┴─────────────┐
                                           ▼                                 ▼
                                    opaque `.nostdb`                 optional `.nost`
                                           │
                                           └─▶ recursive read-only links
```

## Modes

### Embedded Mode

The CLI or a library client opens a readable `.nostdb` directly. No daemon is
required.

### Linked File Mode

The root database recursively opens declared `.nostdb` or `.nost` targets from
the local filesystem or GitHub. Reachable databases form one logical graph.
Links do not synthesize Edges or merge same-named Nodes.

### Local Managed Mode

One daemon per operating-system user manages a local catalog of named
databases. It accepts only current-user Unix-domain-socket or Windows named-pipe
connections. The MVP has no TCP or HTTP listener.

## Write ownership

Only `nostdb-core` writes `.nostdb`. CLI, Server, Skills, providers, and plugins
must call its public API.

AI Skills may write candidate `.nost` or versioned graph changes. The Engine
validates and commits them. Plugins receive Engine-owned graph exchange data
and never parse the database format.

## Source and graph identity

Files and repository paths are mutable source locations, not permanent Entity
or Schema identities. Stable module and record IDs live in the database.

A link is identified by its canonical source path or address. It does not use a
separate `link_id` or `target_database_id`. Moving a target requires explicit
relinking unless a relative path continues to resolve.

## Federation behavior

- One-way links are valid; mutual links are recommended.
- Links are recursive and cycle-safe.
- Linked data is read-only from the root transaction.
- Unavailable targets remain declared.
- Queries return reachable partial results plus structured warnings.
- Disconnected components remain disconnected in query results and the viewer.

## Provider boundary

Local filesystem access is built in. GitHub is the only MVP remote provider and
implements two independent roles:

1. `SourceProvider` for source analysis.
2. `GraphStoreProvider` for retrieving existing `.nostdb` or `.nost` files.

Credentials are injected through named environment or credential-store
bindings and are never persisted in graph files or project settings.

## Query boundary

The public query surface is an explicit openCypher-compatible subset.
NostDB-specific operations use `CALL nostdb.*`, functions, or CLI commands.
Unsupported syntax fails explicitly.

## Viewer boundary

Viewing is a plugin action. The reference viewer uses WebGPU when available and
writes:

```text
.nostdb/out/view.html
.nostdb/out/view.data.bin
```

The viewer plugin is installed separately and receives data through the Engine.
