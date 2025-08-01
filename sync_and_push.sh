#!/usr/bin/env bash
set -euo pipefail

# ——— CONFIGURATION ———
DEFAULT_TARGET="../DemoVersionWebsite"
DEFAULT_TARGET_BRANCH="gh-pages"
SRC_BRANCH=$(git rev-parse --abbrev-ref HEAD)
TARGET_REPO="${1:-$DEFAULT_TARGET}"
TARGET_BRANCH="${2:-$DEFAULT_TARGET_BRANCH}"

# ——— SANITY CHECKS ———
if [ ! -d "$TARGET_REPO/.git" ]; then
  echo "Error: '$TARGET_REPO' is not a git repository."
  exit 1
fi

# ——— SOURCE METADATA ———
SRC_ROOT=$(pwd)
COMMIT_HASH=$(git rev-parse HEAD)
COMMIT_MSG=$(git log -1 --pretty=format:%B "$COMMIT_HASH")
FILES=$(git diff-tree --no-commit-id --name-only -r "$COMMIT_HASH")

# ——— SWITCH TO TARGET ———
cd "$TARGET_REPO"

# Checkout the target branch (must exist)
if git show-ref --verify --quiet refs/heads/"$TARGET_BRANCH"; then
  git checkout "$TARGET_BRANCH"
else
  echo "Error: branch '$TARGET_BRANCH' not found in target repo."
  exit 1
fi

CHANGED=false

# ——— FOR EACH FILE: DIFF + PROMPT ———
for f in $FILES; do
  SRC_FILE="$SRC_ROOT/$f"
  TGT_FILE="$TARGET_REPO/$f"

  if [ -f "$TGT_FILE" ]; then
    echo
    echo "====== $f ======"
    diff -u "$TGT_FILE" "$SRC_FILE" || true

    read -p "Apply this change to '$f'? [y/N] " yn
    if [[ "$yn" =~ ^[Yy] ]]; then
      mkdir -p "$(dirname "$f")"
      cp "$SRC_FILE" "$f"
      git add "$f"
      CHANGED=true
      echo "✔ Applied $f"
    else
      echo "✘ Skipped $f"
    fi
  fi
done

# ——— COMMIT & PUSH ———
if [ "$CHANGED" = true ]; then
  git commit -m "$COMMIT_MSG"

  # if no upstream, set it; otherwise simple push
  if ! git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
    git push --set-upstream origin "$TARGET_BRANCH"
  else
    git push
  fi

  echo
  echo "✅ Synced selected files to '$TARGET_REPO' on branch '$TARGET_BRANCH'."
else
  echo
  echo "ℹ️  No files were synced."
fi
