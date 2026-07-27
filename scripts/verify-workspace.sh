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

# Cross-repository integration check.
#
# A diagnostic code is a stable public identifier. The vocabulary nostdb-core
# recognizes and the registry nostdb-spec publishes must match exactly, and they
# live in separate repositories pinned together, so this is the only place that can
# hold them together. Matching them by inspection would drift on the first change.
#
# The core file's test section is excluded deliberately: it names an unregistered
# code on purpose, to prove an unknown code is rejected rather than guessed.
core_diagnostics="nostdb-core/src/diagnostic.rs"
spec_registry="nostdb-spec/diagnostics.json"

if [ -f "$core_diagnostics" ] && [ -f "$spec_registry" ]; then
  # Any upper-snake-case quoted string, not only a NOST prefix. An earlier version
  # anchored on NOST and silently missed SYNC_CONFLICT, so the check reported a code as
  # absent from the Engine when the Engine had it. Every other quoted string in the
  # non-test part of that file starts lower case, so this stays exact.
  core_codes=$(
    sed '/#\[cfg(test)\]/,$d' "$core_diagnostics" |
      grep -oE '"[A-Z][A-Z_]+"' | tr -d '"' | LC_ALL=C sort -u
  )
  spec_codes=$(
    grep -oE '"code": *"[A-Z_]+"' "$spec_registry" |
      sed 's/.*"\([A-Z_]*\)"$/\1/' | LC_ALL=C sort -u
  )

  if [ -z "$core_codes" ]; then
    echo "extracted no diagnostic codes from $core_diagnostics" >&2
    exit 1
  fi
  if [ -z "$spec_codes" ]; then
    echo "extracted no diagnostic codes from $spec_registry" >&2
    exit 1
  fi

  if [ "$core_codes" != "$spec_codes" ]; then
    echo "the nostdb-core diagnostic vocabulary and the nostdb-spec registry differ" >&2
    # comm must collate the same way the lists were sorted, or it reports every
    # line as unique and sends the reader chasing differences that do not exist.
    echo "registered in nostdb-core but not in nostdb-spec:" >&2
    LC_ALL=C comm -23 <(printf '%s\n' "$core_codes") <(printf '%s\n' "$spec_codes") >&2
    echo "registered in nostdb-spec but not in nostdb-core:" >&2
    LC_ALL=C comm -13 <(printf '%s\n' "$core_codes") <(printf '%s\n' "$spec_codes") >&2
    exit 1
  fi
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
PLUGIN_INCOMPATIBLE
PLUGIN_DIGEST_MISMATCH
PROVIDER_AUTH_REQUIRED
PROVIDER_PERMISSION_DENIED
SERVER_ALREADY_RUNNING
SERVER_PROTOCOL_UNSUPPORTED
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
# nostdb-core must reproduce every container outcome nostdb-spec declares, run against
# the pinned commit set rather than a copy vendored into the Engine. The Engine's own
# test skips when it is not given a fixture path, so that a standalone clone still
# builds; a skip proves nothing, so this requires the confirmation line and fails
# without it.
if [ -f nostdb-core/Cargo.toml ] && [ -d nostdb-spec/fixtures ]; then
  if ! command -v cargo >/dev/null 2>&1; then
    echo "cargo is required to run the cross-repository conformance check" >&2
    exit 1
  fi

  for suite in container_conformance nost_conformance cypher_conformance settings_conformance result_conformance change_set_conformance; do
    conformance_log=$(
      NOSTDB_SPEC_FIXTURES="$workspace_root/nostdb-spec/fixtures" \
        cargo test --quiet --manifest-path nostdb-core/Cargo.toml \
        --test "$suite" -- --nocapture 2>&1
    ) || {
      echo "the $suite test failed" >&2
      printf '%s\n' "$conformance_log" >&2
      exit 1
    }

    if ! printf '%s\n' "$conformance_log" | grep -q 'verified'; then
      echo "$suite did not run against the nostdb-spec fixtures" >&2
      printf '%s\n' "$conformance_log" >&2
      exit 1
    fi
    printf '%s\n' "$conformance_log" | grep 'verified' | sed 's/^\.*//'
  done
fi

git diff --check

echo "workspace verification passed"
