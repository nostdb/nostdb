# NostDB

NostDB is a clean-slate, local-first Property Graph Database for software
environments. It stores an opaque portable `.nostdb`, may materialize a
human-readable `.nost`, and can union explicitly linked local or GitHub-hosted
graphs without requiring a central server.

This repository is the documentation and orchestration root for the new
workspace. Runtime implementation does not belong in the root repository.

## Current status

The root workspace is initialized, and `nostdb-spec`, `nostdb-core`,
`nostdb-cli`, `nostdb-server`, `nostdb-provider-github`, `skills`, `plugins`, and
`nostdb-distribution`, and `homebrew-tap` are connected as submodules pinned to exact
commits — every child the topology names. No legacy runtime code has been copied into
this repository.

`nostdb-spec` publishes the `.nost` language, `.nostdb` container, and query
subset contracts with a conformance suite. `nostdb-core` implements the graph
model, the container and its transactions, the `.nost` parser and canonical
formatter, synchronization, the deterministic analysis boundary, and the
openCypher subset including writes and explicit transactions. See
[Implementation progress](IMPLEMENTATION_PROGRESS.md) for the current Stage.

`nostdb-cli` provides `help`, `init`, `check`, `convert`, `export`, `query` and its
REPL, `link`, `plan`, `build`, `apply`, `sync`, `catalog`, `server`, and
`--version`, with the exit classes the product contract fixes. `link refresh` waits for the GitHub provider,
because a local link has no snapshot to advance.

`nostdb-server` is the per-user local daemon. It holds the named database catalog,
the local endpoint, the lock that keeps one instance per user, and sessions that
call public Core APIs. `nostdb query --database @name` runs through it; every
path-based command still runs without it.

`nostdb-provider-github` is the out-of-process GitHub provider: it retrieves
bytes and metadata, and Core interprets the graph formats. `skills` publishes the
Agent Skills, installable on their own with `npx skills add nostdb/skills`.
`plugins` owns the plugin manifest schema and the reference plugins; the only
plugin manager is in `nostdb-cli`.

`nostdb-distribution` publishes the unscoped `nostdb` npm package: a thin launcher
that resolves this platform to a released artifact, verifies it against checksums the
package itself ships, and executes it. `homebrew-tap` holds the formula, which
installs the same native binary and verifies the same release checksum.

Nothing is published. Both refuse by name and say what is missing rather than
fetching something unverified, which is the correct state for a release that does not
exist yet.

Every child the topology names is now connected and pinned.

## Start here

Read in this order:

1. [Implementation progress](IMPLEMENTATION_PROGRESS.md)
2. [Product requirements](docs/PRD.md)
3. [Architecture](docs/ARCHITECTURE.md)
4. [Repository topology](docs/REPOSITORIES.md)
5. [Agent instructions](AGENTS.md)

## Intended workspace

```text
nostdb/
├── nostdb-spec/              # connected and pinned
├── nostdb-core/              # connected and pinned
├── nostdb-cli/               # connected and pinned
├── nostdb-server/            # connected and pinned
├── nostdb-provider-github/   # connected and pinned
├── skills/                   # connected and pinned
├── plugins/                  # connected and pinned
├── nostdb-distribution/      # connected and pinned
└── homebrew-tap/             # connected and pinned
```

Every connected submodule is cloned at its pinned commit with:

```bash
git clone --recurse-submodules https://github.com/nostdb/nostdb.git
```

Do not add placeholder submodule URLs. An option-free clone fetches only the
root and gitlink records; `--recurse-submodules` is required for a complete
workspace.

## Verify this root

```bash
./scripts/verify-workspace.sh
```

CI runs the same verifier over a recursive checkout of the pinned commit set,
then runs each connected child's `scripts/verify-repository.sh`.

## License

Root documentation is licensed under CC BY-NC-SA 3.0 unless a file states
otherwise. Child repositories carry their own licenses as defined by the PRD.
