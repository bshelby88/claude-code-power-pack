#!/usr/bin/env bash
# Claude Code Power Pack installer — 51 skills
set -euo pipefail

DEST="${HOME}/.claude/skills"
SRC="$(cd "$(dirname "$0")" && pwd)/skills"

if [ ! -d "$SRC" ]; then
  echo "ERROR: skills/ directory not found next to install.sh"
  exit 1
fi

mkdir -p "$DEST"

installed=0
skipped=0
for skill in "$SRC"/*/; do
  name="$(basename "$skill")"
  target="$DEST/$name"
  if [ -e "$target" ]; then
    echo "skip   $name (already installed)"
    skipped=$((skipped+1))
  else
    cp -r "$skill" "$target"
    echo "ok     $name"
    installed=$((installed+1))
  fi
done

echo ""
echo "Installed: $installed"
echo "Skipped:   $skipped (already present)"
echo ""
echo "Skills now available in ~/.claude/skills/"
echo "Restart Claude Code to refresh skill list."
