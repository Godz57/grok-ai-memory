#!/usr/bin/env bash
set -euo pipefail
KIT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MODE="${1:-global}"
WIRE=0
[[ "${1:-}" == "wire" || "${2:-}" == "wire" ]] && WIRE=1
[[ "${1:-}" == "wire" ]] && MODE="global"
[[ "${1:-}" == "project" ]] && MODE="project"

if [[ "$MODE" == "project" ]]; then
  BASE="$(pwd)/.grok"
  echo "Install mode: PROJECT -> $BASE"
else
  BASE="${HOME}/.grok"
  echo "Install mode: GLOBAL -> $BASE"
fi

SKILLS="$BASE/skills"
COMMANDS="$BASE/commands"
DST="$SKILLS/ai-memory"
DOCS="$DST/docs"

mkdir -p "$SKILLS" "$COMMANDS" "$DST" "$DOCS"
cp -R "$KIT_ROOT/skills/ai-memory/." "$DST/"
cp -f "$KIT_ROOT/docs/grok-pi-setup.md" "$DOCS/"
echo "  skill: ai-memory"

for f in "$KIT_ROOT"/commands/*.md; do
  cp -f "$f" "$COMMANDS/"
  echo "  command: $(basename "$f")"
done

if command -v ai-memory >/dev/null 2>&1; then
  echo "  ai-memory CLI: found"
  if [[ "$WIRE" -eq 1 ]]; then
    ai-memory install-hooks --agent grok --apply || true
    echo "  optional: ai-memory install-hooks --agent pi --apply"
  fi
else
  echo "  ai-memory CLI: NOT on PATH - install Docker server first"
fi

echo ""
echo "Done. Try: /memory-status | /memory-handoff"
echo "Guide: $DOCS/grok-pi-setup.md"
