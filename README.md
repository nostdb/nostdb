# NostDB

NostDB is a clean-slate, local-first Property Graph Database for software
environments. It stores an opaque portable `.nostdb`, may materialize a
human-readable `.nost`, and can union explicitly linked local or GitHub-hosted
graphs without requiring a central server.

This repository is the documentation and orchestration root for the new
workspace. Runtime implementation does not belong in the root repository.

## Current status

The root workspace is initialized, and `nostdb-spec`, `nostdb-core`,
`nostdb-cli`, and `nostdb-server` are connected as submodules pinned to exact
commits. No legacy runtime code has been copied into this repository.

`nostdb-spec` publishes the `.nost` language, `.nostdb` container, and query
subset contracts with a conformance suite. `nostdb-core` implements the graph
model, the container and its transactions, the `.nost` parser and canonical
formatter, synchronization, the deterministic analysis boundary, and the
openCypher subset including writes and explicit transactions. See
[Implementation progress](IMPLEMENTATION_PROGRESS.md) for the current Stage.

`nostdb-cli` provides `help`, `init`, `check`, `convert`, `export`, `query` and its
REPL, `link`, `plan`, `build`, `apply`, `sync`, and `--version`, with the exit
classes the product contract fixes. `link refresh` waits for the GitHub provider,
because a local link has no snapshot to advance.

`nostdb-server` is repository scaffolding only. The per-user daemon, its local
protocol, and the named database catalog land across the Stage 8 increments.

The remaining five repositories will be created and connected by the Stage that
first needs each one.

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
├── nostdb-server/            # connected and pinned, scaffolding only
├── nostdb-provider-github/   # not yet authorized
├── nostdb-distribution/      # not yet authorized
├── homebrew-tap/             # not yet authorized
├── skills/                   # not yet authorized
└── plugins/                  # not yet authorized
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
