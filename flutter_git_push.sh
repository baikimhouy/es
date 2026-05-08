#!/bin/bash

# Flutter Git helper script
# Runs analyze + test before commit and push

set -e

echo "📂 Current working directory: $(pwd)"

if ! command -v git >/dev/null 2>&1; then
  echo "❌ Git is not installed or not available in PATH."
  exit 1
fi

if ! command -v flutter >/dev/null 2>&1; then
  echo "❌ Flutter is not installed or not available in PATH."
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "❌ Not inside a Git repository."
  exit 1
fi

REPO_ROOT=$(git rev-parse --show-toplevel)
cd "$REPO_ROOT"

echo "📁 Using repository root: $REPO_ROOT"

if [ ! -f pubspec.yaml ]; then
  echo "❌ pubspec.yaml not found. This does not look like a Flutter project root."
  exit 1
fi

if [ -z "${1:-}" ]; then
  read -r -p "Enter commit message: " COMMIT_MESSAGE
else
  COMMIT_MESSAGE="$1"
fi

if [ -z "$COMMIT_MESSAGE" ]; then
  echo "❌ Commit message cannot be empty."
  exit 1
fi

# Detect whether this repo already has at least one commit
if git rev-parse --verify HEAD >/dev/null 2>&1; then
  HAS_COMMITS=true
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
else
  HAS_COMMITS=false
  BRANCH=$(git branch --show-current 2>/dev/null || true)

  if [ -z "$BRANCH" ]; then
    BRANCH="main"
  fi
fi

echo "🌿 Current branch: $BRANCH"

echo "🔍 Running flutter analyze..."
flutter analyze

echo "🧪 Running flutter test..."
flutter test

echo "➕ Staging changes..."
git add .

# Check whether there is anything staged
if git diff --cached --quiet; then
  echo "ℹ️ No changes to commit."
  exit 0
fi

echo "📝 Creating commit..."
git commit -m "$COMMIT_MESSAGE"

# If this is the first commit and branch is unborn, set branch name clearly
if [ "$HAS_COMMITS" = false ]; then
  git branch -M "$BRANCH"
fi

echo "🚀 Pushing to branch '$BRANCH'..."
git push -u origin "$BRANCH"

echo "✅ Flutter checks passed. Changes committed and pushed to branch '$BRANCH'."