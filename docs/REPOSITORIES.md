# NostDB Repository Topology

## Root model

The root `nostdb` repository is a Git superproject. Each implementation boundary
is an independently versioned direct child submodule.

The root owns:

- cross-repository product and architecture documents;
- exact gitlink pins;
- root verification and integration orchestration;
- no duplicated runtime implementation.

## Intended child repositories

| Local path | Remote repository | Responsibility |
| --- | --- | --- |
| `nostdb-spec/` | `nostdb-spec` | `.nost`, `.nostdb`, protocol contracts, examples, and conformance fixtures |
| `nostdb-core/` | `nostdb-core` | parsers, model, storage, sync, structural analysis, and query |
| `nostdb-cli/` | `nostdb-cli` | CLI, REPL, output formats, and the only plugin manager |
| `nostdb-server/` | `nostdb-server` | per-user local daemon, catalog, sessions, and local IPC |
| `nostdb-provider-github/` | `nostdb-provider-github` | GitHub source and graph-store provider |
| `nostdb-distribution/` | `nostdb-distribution` | npm launcher and GitHub release assembly |
| `homebrew-tap/` | `homebrew-tap` | Homebrew formula |
| `skills/` | `skills` | independently installable Agent Skills; no database writer |
| `plugins/` | `plugins` | plugin manifest schema, guidance, and reference plugins |

`nostdb-mcp` is created only after the public Core API stabilizes.

## Current bootstrap state

The organization is `nostdb`, so every child locator is
`https://github.com/nostdb/<repository>.git`.

Connected and pinned to an exact commit:

- `nostdb-spec/`
- `nostdb-core/`
- `nostdb-cli/`
- `nostdb-server/`
- `nostdb-provider-github/`
- `skills/`
- `plugins/`
- `nostdb-distribution/`

Not connected. Each is a named dependency of the Stage that first needs it, and
creating it still requires explicit authorization at that time:

- `homebrew-tap/`

`.gitmodules` records read-only HTTPS URLs so that the documented recursive
clone works without SSH keys. A contributor who pushes to a child keeps the
recorded URL and redirects only the push side. One global setting covers every
repository and submodule:

```bash
git config --global url."git@github.com:".pushInsteadOf https://github.com/
```

The equivalent setting scoped to a single submodule is:

```bash
git -C nostdb-spec config url."git@github.com:".pushInsteadOf https://github.com/
```

Do not use `git config submodule.<name>.url` for this. That key only redirects
where `git submodule update` clones from, `git submodule sync` resets it from
`.gitmodules`, and it does not affect the push URL at all.

Do not create placeholder gitlinks or local-path submodules for the unconnected
paths: they would make the promised recursive clone non-portable.

Connecting a child repository requires:

1. exact organization and repository URLs;
2. explicit authorization before creating any missing remote repository;
3. an initial commit in each child repository;
4. exact commit pins in the root;
5. recursive checkout in root CI.

## Clone contract

A recursive clone populates every connected child at its pinned commit:

```bash
git clone --recurse-submodules https://github.com/nostdb/nostdb.git
```

Existing non-recursive clones use:

```bash
git submodule update --init --recursive
```

Submodule commits are the reproducible source of truth. Root builds must not
follow floating branches with `git submodule update --remote`.

## Independence

Each child repository must:

- contain its own `README.md` and `AGENTS.md`;
- carry its own license;
- format, build, lint, and test independently;
- provide an executable `scripts/verify-repository.sh` covering that repository;
- run its own CI on push and pull request;
- expose versioned public boundaries;
- avoid depending on uncommitted sibling state.

Root CI checks out the pinned commit set recursively, runs
`scripts/verify-workspace.sh`, and then runs each child's
`scripts/verify-repository.sh`. A child that does not provide that script fails
root verification.

## Installable Skills

`skills/` is a submodule of this workspace and, independently, a source an Agent
Skill installer reads directly. Both have to hold at once, so the child publishes
each Skill at the path an installer discovers:

```text
skills/skills/<name>/SKILL.md
```

The first `skills/` is the submodule path in this workspace; the second is the
directory the installer scans. A Skill is then installed by name, with no
reference to this superproject:

```bash
npx skills add nostdb/skills
```

The **skill folder is the unit an installer copies**, so everything a definition
references lives inside its own folder. A reference reaching outside it resolves
in the child repository and is missing from every install, which is the one way
a Skill can pass every check here and still be broken for the person who
installed it. The child verifier enforces it, and root verification requires the
child to publish at least one discoverable definition — this root claims the
Skills are independently installable, so this is where that claim is checked
rather than assumed.

## Licensing

- `nostdb-core`, `nostdb-cli`, `nostdb-server`: SSPL-1.0, described as
  source-available.
- `nostdb-distribution` and `homebrew-tap`: Apache-2.0. `docs/PRD.md` section 33
  names a licence for every other repository and names neither of these, so the
  reasoning is recorded in `IMPLEMENTATION_PROGRESS.md` under Stage 12 rather than
  assumed. A launcher and a formula that *install* source-available binaries are not
  themselves that work, and a copyleft licence on either would make packaging NostDB
  for a distribution or a mirror needlessly fraught — while the whole purpose of both
  is that people install through them.
- `nostdb-spec` executable grammar and fixtures: Apache-2.0.
- `skills` and a future thin `nostdb-mcp`: Apache-2.0.
- provider/plugin extension schemas and future drivers: Apache-2.0.
- root documentation: CC BY-NC-SA 3.0 unless otherwise noted.
