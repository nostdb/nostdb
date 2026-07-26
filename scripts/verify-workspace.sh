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

if [ -f .gitmodules ]; then
  submodule_status=$(git submodule status --recursive)
  if printf '%s\n' "$submodule_status" | grep -Eq '^[+U-]'; then
    echo "one or more submodules are missing, conflicted, or not at the pinned commit" >&2
    printf '%s\n' "$submodule_status" >&2
    exit 1
  fi
fi

git diff --check

echo "workspace verification passed"
