#!/usr/bin/env bash
set -euo pipefail

# default target path
DEFAULT_TARGET="../DemoVersionWebsite"
TARGET_REPO="${1:-$DEFAULT_TARGET}"

# verify target is a git repo
if [ ! -d "$TARGET_REPO/.git" ]; then
  echo "Error: '$TARGET_REPO' is not a git repository."
  exit 1
fi

# source-repo info
SRC_ROOT=$(pwd)
SRC_BRANCH=$(git rev-parse --abbrev-ref HEAD)
COMMIT_HASH=$(git rev-parse HEAD)
COMMIT_MSG=$(git log -1 --pretty=format:%B "$COMMIT_HASH")
FILES=$(git diff-tree --no-commit-id --name-only -r "$COMMIT_HASH")

# cd into target and ensure branch
cd "$TARGET_REPO"
if git show-ref --verify --quiet refs/heads/"$SRC_BRANCH"; then
  git checkout "$SRC_BRANCH"
else
  git checkout -b "$SRC_BRANCH"
fi

CHANGED=false

# iterate changed files
for f in $FILES; do
  SRC_FILE="$SRC_ROOT/$f"
  TGT_FILE="$TARGET_REPO/$f"

  if [ -f "$TGT_FILE" ]; then
    echo
    echo "====== $f ======"
    # show diff
    diff -u "$TGT_FILE" "$SRC_FILE" || true

    # prompt
    read -p "Apply this change to '$f'? [y/N] " yn
    case "$yn" in
      [Yy]* )
        mkdir -p "$(dirname "$f")"
        cp "$SRC_FILE" "$f"
        git add "$f"
        CHANGED=true
        echo "✔ Applied $f"
        ;;
      * )
        echo "✘ Skipped $f"
        ;;
    esac
  fi
done

# commit & push if anything staged
if [ "$CHANGED" = true ]; then
  git commit -m "$COMMIT_MSG"
  git push
  echo
  echo "✅ Synced selected file(s) to '$TARGET_REPO' on branch '$SRC_BRANCH'."
else
  echo
  echo "ℹ️  No files were synced."
fi
