#!/usr/bin/env bash
set -euo pipefail

# Resolve the directory where this script lives (the ai-guidelines repo root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

REDIRECT_LINE='Read and follow all instructions from `.ai/guidelines.md` before starting any task.'

# --- Usage ---
usage() {
  echo "Usage: $0 <target-project-path>"
  echo ""
  echo "Installs AI agent guidelines into the target project."
  echo "Copies portable files (roles/, flows/, meta/, prd/) into .ai/"
  echo "and creates agent entry points (CLAUDE.md, AGENTS.md, .junie/guidelines.md)."
  exit 1
}

# --- Validate arguments ---
if [[ $# -lt 1 ]]; then
  usage
fi

TARGET="$1"

if [[ ! -d "$TARGET" ]]; then
  echo "Error: '$TARGET' is not a directory or does not exist."
  exit 1
fi

# Resolve to absolute path
TARGET="$(cd "$TARGET" && pwd)"

echo "Installing AI guidelines into: $TARGET"

# --- Create .ai/ directory structure ---
mkdir -p "$TARGET/.ai"
mkdir -p "$TARGET/.ai/project"

# --- Copy portable files (overwrite for upgrade-safety) ---
echo "Copying portable files..."
rm -rf "$TARGET/.ai/roles" "$TARGET/.ai/flows" "$TARGET/.ai/meta"
cp -r "$SCRIPT_DIR/roles" "$TARGET/.ai/roles"
cp -r "$SCRIPT_DIR/flows" "$TARGET/.ai/flows"
cp -r "$SCRIPT_DIR/meta"  "$TARGET/.ai/meta"

# Copy prd/ templates — but preserve existing prd.md if it exists
PRD_BACKUP=""
if [[ -f "$TARGET/.ai/prd/prd.md" ]]; then
  PRD_BACKUP="$(mktemp)"
  cp "$TARGET/.ai/prd/prd.md" "$PRD_BACKUP"
fi
rm -rf "$TARGET/.ai/prd"
cp -r "$SCRIPT_DIR/prd" "$TARGET/.ai/prd"
if [[ -n "$PRD_BACKUP" ]]; then
  mv "$PRD_BACKUP" "$TARGET/.ai/prd/prd.md"
fi

# --- Copy guidelines.md (only if it doesn't exist) ---
if [[ ! -f "$TARGET/.ai/guidelines.md" ]]; then
  echo "Creating .ai/guidelines.md from example template..."
  cp "$SCRIPT_DIR/meta/guidelines-example-shopware.md" "$TARGET/.ai/guidelines.md"
else
  echo "Keeping existing .ai/guidelines.md"
fi

# --- Create agent entry points ---
echo "Creating agent entry points..."

echo "$REDIRECT_LINE" > "$TARGET/CLAUDE.md"
echo "$REDIRECT_LINE" > "$TARGET/AGENTS.md"
mkdir -p "$TARGET/.junie"
echo "$REDIRECT_LINE" > "$TARGET/.junie/guidelines.md"

# --- Add .gitignore rules ---
GITIGNORE="$TARGET/.gitignore"
touch "$GITIGNORE"

add_gitignore_rule() {
  local rule="$1"
  if ! grep -qxF "$rule" "$GITIGNORE"; then
    echo "$rule" >> "$GITIGNORE"
  fi
}

add_gitignore_rule ".ai/prd/*"
add_gitignore_rule "!.ai/prd/prd.md"

echo ""
echo "Done! AI guidelines installed into: $TARGET"
echo ""
echo "Next step — paste this prompt into your AI agent:"
echo ""
echo "  Read \`.ai/meta/init.md\` and run discovery + project file generation for this project."
echo ""
