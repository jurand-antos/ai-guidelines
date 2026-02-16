#!/usr/bin/env bash
set -euo pipefail

# Resolve the directory where this script lives (repo root is one level up)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# --- Usage ---
usage() {
  echo "Usage: $0 <category> <target>"
  echo ""
  echo "Installs an instruction category into the target directory."
  echo ""
  echo "Arguments:"
  echo "  category   Name of the category directory in the repo (e.g., it-support)"
  echo "  target     Destination directory (created if it doesn't exist)"
  echo ""
  echo "Examples:"
  echo "  $0 it-support ./.ai"
  echo "  $0 it-support ../my-project/.ai"
  exit 1
}

# --- List available categories ---
list_categories() {
  local cats=()
  for dir in "$SCRIPT_DIR"/*/; do
    local name
    name="$(basename "$dir")"
    # Skip hidden dirs and bin/
    [[ "$name" == .* || "$name" == bin ]] && continue
    cats+=("$name")
  done
  echo "${cats[@]}"
}

# --- Validate arguments ---
if [[ $# -lt 2 ]]; then
  usage
fi

CATEGORY="$1"
TARGET="$2"
CATEGORY_DIR="$SCRIPT_DIR/$CATEGORY"

if [[ ! -d "$CATEGORY_DIR" ]]; then
  echo "Error: category '$CATEGORY' does not exist."
  echo ""
  echo "Available categories:"
  for cat in $(list_categories); do
    echo "  - $cat"
  done
  exit 1
fi

# Resolve target to absolute path (create if needed)
mkdir -p "$TARGET"
TARGET="$(cd "$TARGET" && pwd)"

echo "Installing '$CATEGORY' into: $TARGET"

# --- Copy category contents ---
# Find subdirectories in the category (e.g., roles/, flows/, meta/, prd/)
for subdir in "$CATEGORY_DIR"/*/; do
  [[ ! -d "$subdir" ]] && continue
  local_name="$(basename "$subdir")"

  # Special handling for prd/ — preserve existing prd.md
  if [[ "$local_name" == "prd" ]]; then
    PRD_BACKUP=""
    if [[ -f "$TARGET/prd/prd.md" ]]; then
      PRD_BACKUP="$(mktemp)"
      cp "$TARGET/prd/prd.md" "$PRD_BACKUP"
    fi
    rm -rf "$TARGET/prd"
    cp -r "$subdir" "$TARGET/prd"
    if [[ -n "$PRD_BACKUP" ]]; then
      mv "$PRD_BACKUP" "$TARGET/prd/prd.md"
    fi
  else
    rm -rf "$TARGET/$local_name"
    cp -r "$subdir" "$TARGET/$local_name"
  fi
done

# Copy any top-level files from the category (non-directory files)
for file in "$CATEGORY_DIR"/*; do
  [[ -d "$file" ]] && continue
  cp "$file" "$TARGET/"
done

echo ""
echo "Done! '$CATEGORY' installed into: $TARGET"
