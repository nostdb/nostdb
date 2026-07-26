# NostDB

NostDB is a clean-slate, local-first Property Graph Database for software
environments. It stores an opaque portable `.nostdb`, may materialize a
human-readable `.nost`, and can union explicitly linked local or GitHub-hosted
graphs without requiring a central server.

This repository is the documentation and orchestration root for the new
workspace. Runtime implementation does not belong in the root repository.

## Current status

The root workspace is initialized, but implementation repositories are not yet
connected. No legacy runtime code has been copied into this repository.

Remote repositories and submodules will be added only after their exact URLs
and creation are explicitly authorized.

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
├── nostdb-spec/
├── nostdb-core/
├── nostdb-cli/
├── nostdb-server/
├── nostdb-provider-github/
├── nostdb-distribution/
├── homebrew-tap/
├── skills/
└── plugins/
```

After the real submodules are connected, the complete workspace will be cloned
with:

```bash
git clone --recurse-submodules https://github.com/<organization>/nostdb.git
```

Do not add placeholder submodule URLs. An option-free clone fetches only the
root and gitlink records; `--recurse-submodules` is required for a complete
workspace.

## Verify this root

```bash
./scripts/verify-workspace.sh
```

## License

Root documentation is licensed under CC BY-NC-SA 3.0 unless a file states
otherwise. Child repositories carry their own licenses as defined by the PRD.
