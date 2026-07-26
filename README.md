# NostDB

NostDB is a clean-slate, local-first Property Graph Database for software
environments. It stores an opaque portable `.nostdb`, may materialize a
human-readable `.nost`, and can union explicitly linked local or GitHub-hosted
graphs without requiring a central server.

This repository is the documentation and orchestration root for the new
workspace. Runtime implementation does not belong in the root repository.

## Current status

The root workspace is initialized, and `nostdb-spec` and `nostdb-core` are
connected as submodules pinned to exact commits. No legacy runtime code has been
copied into this repository, and neither child carries implementation code yet.

The remaining seven repositories will be created and connected only after each
one is explicitly authorized.

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
├── nostdb-cli/               # not yet authorized
├── nostdb-server/            # not yet authorized
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
