#!/usr/bin/env bash

set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
workspace_root=$(CDPATH= cd -- "$script_dir/.." && pwd)

cd "$workspace_root"

required_files="
AGENTS.md
CLAUDE.md
README.md
LICENSE
IMPLEMENTATION_PROGRESS.md
docs/PRD.md
docs/ARCHITECTURE.md
docs/REPOSITORIES.md
.github/workflows/verify.yml
"

for required_file in $required_files; do
  if [ ! -e "$required_file" ]; then
    echo "missing required file: $required_file" >&2
    exit 1
  fi
done

checked_text_files="
AGENTS.md
README.md
IMPLEMENTATION_PROGRESS.md
.editorconfig
.gitignore
docs/PRD.md
docs/ARCHITECTURE.md
docs/REPOSITORIES.md
.github/workflows/verify.yml
scripts/verify-workspace.sh
"

for checked_file in $checked_text_files; do
  if grep -nE '[[:blank:]]+$' "$checked_file"; then
    echo "trailing whitespace found in: $checked_file" >&2
    exit 1
  fi
done

if [ ! -L CLAUDE.md ] || [ "$(readlink CLAUDE.md)" != "AGENTS.md" ]; then
  echo "CLAUDE.md must be a symlink to AGENTS.md" >&2
  exit 1
fi

# The root owns cross-repository documentation, exact pins, orchestration, and
# verification only. docs/PRD.md sections 8.1 and 30.10 forbid duplicating
# runtime implementation here. Submodule contents are excluded automatically,
# because `git ls-files` does not descend into a gitlink.
if runtime_paths=$(
  git ls-files |
    grep -E '(^|/)(Cargo\.(toml|lock)|package\.json|pyproject\.toml|go\.mod)$|\.(rs|js|mjs|cjs|ts|tsx|py|go|c|h|cc|cpp|java|rb)$'
); then
  echo "the root repository must not contain runtime implementation or build manifests" >&2
  echo "move these into the owning child repository:" >&2
  printf '%s\n' "$runtime_paths" >&2
  exit 1
fi

# Normative child directory names, from docs/PRD.md section 8.1.
normative_submodule_paths="
nostdb-spec
nostdb-core
nostdb-cli
nostdb-server
nostdb-provider-github
nostdb-distribution
homebrew-tap
skills
plugins
"

# A gitlink with no .gitmodules entry cannot be populated by a recursive clone,
# and a declared path with no gitlink is not pinned at all. Both sets must match
# exactly, including when no .gitmodules exists yet.
index_gitlinks=$(git ls-files -s | awk '$1 == "160000" { print $4 }' | LC_ALL=C sort)

if [ -f .gitmodules ]; then
  declared_submodule_paths=$(
    git config --file .gitmodules --get-regexp '^submodule\..*\.path$' |
      awk '{ print $2 }' | LC_ALL=C sort
  )
else
  declared_submodule_paths=""
fi

if [ "$index_gitlinks" != "$declared_submodule_paths" ]; then
  echo "gitlinks in the index do not match the paths declared in .gitmodules" >&2
  echo "index gitlinks:" >&2
  printf '%s\n' "$index_gitlinks" >&2
  echo "declared paths:" >&2
  printf '%s\n' "$declared_submodule_paths" >&2
  exit 1
fi

if [ -f .gitmodules ]; then
  submodule_status=$(git submodule status --recursive)
  if printf '%s\n' "$submodule_status" | grep -Eq '^[+U-]'; then
    echo "one or more submodules are missing, conflicted, or not at the pinned commit" >&2
    printf '%s\n' "$submodule_status" >&2
    exit 1
  fi

  # A recorded branch lets `git submodule update --remote` float a pin, which
  # docs/PRD.md section 8.1 forbids for a reproducible build.
  if recorded_branches=$(git config --file .gitmodules --get-regexp '^submodule\..*\.branch$'); then
    echo "a submodule records a branch; every pin must be an exact commit" >&2
    printf '%s\n' "$recorded_branches" >&2
    exit 1
  fi

  while read -r url_key submodule_url; do
    submodule_name=${url_key#submodule.}
    submodule_name=${submodule_name%.url}

    # A placeholder or local-path URL would make the promised recursive clone
    # non-portable. Contributors who push over SSH use the pushInsteadOf
    # redirect documented in docs/REPOSITORIES.md instead of editing this value.
    case "$submodule_url" in
      *'<'* | *'>'*)
        echo "submodule $submodule_name records a placeholder URL: $submodule_url" >&2
        exit 1
        ;;
      https://github.com/*/*.git) ;;
      *)
        echo "submodule $submodule_name must record https://github.com/<owner>/<repository>.git, found: $submodule_url" >&2
        exit 1
        ;;
    esac

    submodule_path=$(git config --file .gitmodules --get "submodule.$submodule_name.path")
    if [ "$submodule_path" != "$submodule_name" ]; then
      echo "submodule $submodule_name must use its own name as its path, found: $submodule_path" >&2
      exit 1
    fi

    if ! printf '%s\n' $normative_submodule_paths | grep -qx "$submodule_path"; then
      echo "submodule path is not a normative child directory name: $submodule_path" >&2
      exit 1
    fi

    # docs/REPOSITORIES.md requires every child to provide this, and root CI runs
    # it for each connected child. Checking it here keeps a local pass and a CI
    # pass equivalent instead of letting CI discover the gap first.
    if [ ! -x "$submodule_path/scripts/verify-repository.sh" ]; then
      echo "submodule $submodule_name must provide an executable scripts/verify-repository.sh" >&2
      exit 1
    fi
  done < <(git config --file .gitmodules --get-regexp '^submodule\..*\.url$')
fi

# Cross-repository distribution check.
#
# This root, docs/REPOSITORIES.md, and docs/PRD.md section 8.1 all describe the Skills as
# independently installable, and an installer discovers a definition at
# `skills/<name>/SKILL.md` inside that child. Nothing checked it, and the child satisfied every
# pin invariant here while shipping an action table, four scripts, and no definition at all —
# so the claim was made in three documents and true in none.
#
# What a definition must contain is the child's verifier to check. That one exists is checked
# here, because this is where the promise is made.
if [ -d skills ]; then
  installable=$(
    find skills/skills -mindepth 2 -maxdepth 3 -name SKILL.md 2>/dev/null |
      LC_ALL=C sort
  )
  if [ -z "$installable" ]; then
    echo "the skills child publishes no skills/<name>/SKILL.md, so nothing in it is installable" >&2
    exit 1
  fi
  echo "installable skills:" $(printf '%s\n' "$installable" | sed 's|^skills/skills/||; s|/SKILL\.md$||')
fi

# Cross-repository integration check.
#
# A diagnostic code is a stable public identifier, and the registry nostdb-spec publishes
# must agree with the implementation that raises it. They live in separate repositories
# pinned together, so this is the only place that can hold them together. Matching them by
# inspection would drift on the first change.
#
# Until Stage 8 every registered code was an Engine code, so comparing one vocabulary
# against the whole registry was the same thing as comparing owners. The daemon raises
# SERVER_ALREADY_RUNNING and SERVER_PROTOCOL_UNSUPPORTED and the Engine never can, so the
# registry records an owner per code and each owner is compared against the codes it owns.
# An owner whose crate does not exist yet is reported rather than skipped in silence.
spec_registry="nostdb-spec/diagnostics.json"
core_diagnostics="nostdb-core/src/diagnostic.rs"

# The codes the registry assigns to one owner. The registry is machine-written with `code`
# ahead of `owner` in every entry and the nostdb-spec suite requires both fields on every
# entry, so pairing them by order is exact rather than approximate.
registered_for_owner() {
  awk -v want="$1" '
    /"code":[[:space:]]*"/ {
      line = $0
      sub(/^.*"code":[[:space:]]*"/, "", line)
      sub(/".*$/, "", line)
      code = line
    }
    /"owner":[[:space:]]*"/ {
      line = $0
      sub(/^.*"owner":[[:space:]]*"/, "", line)
      sub(/".*$/, "", line)
      if (line == want && code != "") {
        print code
        code = ""
      }
    }
  ' "$spec_registry" | LC_ALL=C sort -u
}

if [ -f "$spec_registry" ]; then
  registry_owners=$(
    grep -oE '"owner": *"[a-z-]+"' "$spec_registry" |
      sed 's/.*"\([a-z-]*\)"$/\1/' | LC_ALL=C sort -u
  )
  if [ -z "$registry_owners" ]; then
    echo "extracted no code owners from $spec_registry" >&2
    exit 1
  fi

  for owner in $registry_owners; do
    owned=$(registered_for_owner "$owner")
    if [ -z "$owned" ]; then
      echo "extracted no codes for owner $owner from $spec_registry" >&2
      exit 1
    fi

    if [ "$owner" = "nostdb-core" ]; then
      if [ ! -f "$core_diagnostics" ]; then
        continue
      fi

      # The Engine's vocabulary is one file and is compared in both directions: a code it
      # recognizes that the registry does not assign to it is drift just as much as the
      # reverse.
      #
      # The core file's test section is excluded deliberately: it names an unregistered
      # code on purpose, to prove an unknown code is rejected rather than guessed.
      #
      # Any upper-snake-case quoted string, not only a NOST prefix. An earlier version
      # anchored on NOST and silently missed SYNC_CONFLICT, so the check reported a code as
      # absent from the Engine when the Engine had it. Every other quoted string in the
      # non-test part of that file starts lower case, so this stays exact.
      core_codes=$(
        sed '/#\[cfg(test)\]/,$d' "$core_diagnostics" |
          grep -oE '"[A-Z][A-Z_]+"' | tr -d '"' | LC_ALL=C sort -u
      )
      if [ -z "$core_codes" ]; then
        echo "extracted no diagnostic codes from $core_diagnostics" >&2
        exit 1
      fi

      if [ "$core_codes" != "$owned" ]; then
        echo "the nostdb-core diagnostic vocabulary and the codes it owns in nostdb-spec differ" >&2
        # comm must collate the same way the lists were sorted, or it reports every
        # line as unique and sends the reader chasing differences that do not exist.
        echo "recognized in nostdb-core but not owned by it in nostdb-spec:" >&2
        LC_ALL=C comm -23 <(printf '%s\n' "$core_codes") <(printf '%s\n' "$owned") >&2
        echo "owned by nostdb-core but not recognized in nostdb-core:" >&2
        LC_ALL=C comm -13 <(printf '%s\n' "$core_codes") <(printf '%s\n' "$owned") >&2
        exit 1
      fi
      continue
    fi

    # Any other owner. Its crate arrives with the Stage that implements it, so an owner with
    # no source yet is reported and not counted as a pass. Once the source exists, every code
    # the registry assigns to that owner must appear in it. The reverse is deliberately not
    # required: an owner legitimately names a code it forwards from the Engine rather than
    # raises itself.
    if [ ! -d "$owner/src" ]; then
      echo "diagnostic ownership: $owner awaits an implementation for" $owned
      continue
    fi

    # This proves the code is *declared* by the owner, not that it is raised in anger. Grep can
    # tell the difference between present and absent, and cannot tell the difference between a
    # declared code and a reachable one. The owner's own tests are what cover reachability, so
    # the message says declares rather than raises: a check that claimed more than it verifies
    # is worse than one that claims less.
    undeclared=""
    for code in $owned; do
      if ! grep -rq "\"$code\"" "$owner/src"; then
        undeclared="$undeclared $code"
      fi
    done
    if [ -n "$undeclared" ]; then
      echo "nostdb-spec assigns these codes to $owner, whose source never declares them:$undeclared" >&2
      exit 1
    fi
    echo "diagnostic ownership: $owner declares every code assigned to it"
  done
fi

# Every diagnostic code docs/PRD.md section 28 requires is either registered in
# nostdb-spec or listed below as awaiting the contract that will own it.
#
# This check exists because the same gap appeared three times: LINKED_DATABASE_READ_ONLY,
# ORPHAN_LINK_SETTINGS, and LINK_UNAVAILABLE were each required from the first revision of
# the PRD and each went unregistered until a contract happened to need it. Nothing
# detected any of them. A code is registered by the contract that first names it, so a
# deferral is legitimate; what was missing was making the deferral visible.
if [ -f nostdb-spec/diagnostics.json ]; then
  awaiting_a_contract="
ANALYZER_UNSUPPORTED
ANALYSIS_PARTIAL
AI_BUDGET_EXCEEDED
PLUGIN_REQUIRED
PROVIDER_AUTH_REQUIRED
PROVIDER_PERMISSION_DENIED
VIEW_CAPACITY_EXCEEDED
"

  required_codes=$(
    sed -n '/^Required stable codes include:$/,/^```$/p' docs/PRD.md |
      grep -E '^[A-Z][A-Z_]+$'
  )
  if [ -z "$required_codes" ]; then
    echo "could not read the required code list from docs/PRD.md section 28" >&2
    exit 1
  fi

  unaccounted=""
  for code in $required_codes; do
    if grep -q "\"$code\"" nostdb-spec/diagnostics.json; then
      continue
    fi
    case " $(echo $awaiting_a_contract) " in
      *" $code "*) continue ;;
    esac
    unaccounted="$unaccounted $code"
  done

  if [ -n "$unaccounted" ]; then
    echo "docs/PRD.md section 28 requires these codes, and they are neither registered" >&2
    echo "in nostdb-spec nor listed as awaiting a contract:$unaccounted" >&2
    exit 1
  fi

  # A code that became registered must leave the deferral list, or the list rots into a
  # record of what used to be missing.
  stale=""
  for code in $awaiting_a_contract; do
    if grep -q "\"$code\"" nostdb-spec/diagnostics.json; then
      stale="$stale $code"
    fi
  done
  if [ -n "$stale" ]; then
    echo "these codes are registered and still listed as awaiting a contract:$stale" >&2
    exit 1
  fi
fi

# Cross-repository conformance check.
#
# An implementation must reproduce every outcome nostdb-spec declares, run against the pinned
# commit set rather than a copy vendored into the implementation. Each suite skips when it is
# not given a fixture path, so that a standalone clone still builds; a skip proves nothing, so
# this requires the confirmation line and fails without it.
#
# The owning crate is named per suite rather than assumed to be the Engine. Stage 8 published
# the first contract the Engine does not implement: the catalog belongs to the daemon, and
# running its suite from nostdb-core would run nothing and report success for it.
run_conformance_suite() {
  conformance_crate=$1
  conformance_suite=$2

  # A crate that does not exist yet is reported rather than skipped in silence, the same way an
  # unimplemented diagnostic owner is above.
  if [ ! -f "$conformance_crate/Cargo.toml" ]; then
    echo "conformance: $conformance_crate has no crate yet, so $conformance_suite is not run"
    return 0
  fi

  conformance_log=$(
    NOSTDB_SPEC_FIXTURES="$workspace_root/nostdb-spec/fixtures" \
      cargo test --quiet --manifest-path "$conformance_crate/Cargo.toml" \
      --test "$conformance_suite" -- --nocapture 2>&1
  ) || {
    echo "the $conformance_suite test in $conformance_crate failed" >&2
    printf '%s\n' "$conformance_log" >&2
    exit 1
  }

  if ! printf '%s\n' "$conformance_log" | grep -q 'verified'; then
    echo "$conformance_suite in $conformance_crate did not run against the nostdb-spec fixtures" >&2
    printf '%s\n' "$conformance_log" >&2
    exit 1
  fi

  # `deferred` is surfaced alongside `verified`. A suite that covers nine of eleven rules and
  # reports only the nine reads as covering all of them, and this filter was hiding exactly the
  # lines a suite prints to say what it did not cover.
  printf '%s\n' "$conformance_log" | grep -E 'verified|deferred' | sed 's/^\.*//'
}

if [ -d nostdb-spec/fixtures ]; then
  if ! command -v cargo >/dev/null 2>&1; then
    echo "cargo is required to run the cross-repository conformance check" >&2
    exit 1
  fi

  for suite in container_conformance nost_conformance cypher_conformance settings_conformance result_conformance change_set_conformance; do
    run_conformance_suite nostdb-core "$suite"
  done

  run_conformance_suite nostdb-server catalog_conformance
  run_conformance_suite nostdb-server server_conformance

  # The provider owns the locator, so the locator fixtures are gated where they are
  # implemented rather than in the Engine. Running them here is what makes the published
  # set a gate: a suite only the child repository runs is one a workspace-level change can
  # break without anything noticing.
  run_conformance_suite nostdb-provider-github locator_conformance

  # The plugin manifest is validated where the manager lives, so the fixtures are gated
  # there. Running them here is what makes the published set a gate rather than a document.
  run_conformance_suite nostdb-cli plugin_conformance

  # The installation contract is a separate suite because it is a separate contract: the
  # manifest is what an author writes and the record is what the manager writes, and the two
  # versions move independently.
  run_conformance_suite nostdb-cli plugin_install_conformance
fi

git diff --check

echo "workspace verification passed"
