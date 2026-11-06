#!/usr/bin/env bash
# Symlink the playbook into each AI tool's global config directory.
#
#   scripts/install.sh                 dry-run for every tool whose home dir exists
#   scripts/install.sh --apply         do it
#   scripts/install.sh --apply cursor claude
#
# Targets: cursor, claude, codex, gemini.
# Existing real files are moved to ~/.agent-playbook-backup/<timestamp>/ before linking.
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
APPLY=0
TARGETS=()
for arg in "$@"; do
  case "$arg" in
    --apply) APPLY=1 ;;
    cursor|claude|codex|gemini) TARGETS+=("$arg") ;;
    -h|--help) sed -n '2,10p' "$0"; exit 0 ;;
    *) echo "unknown argument: $arg" >&2; exit 1 ;;
  esac
done

if [ ${#TARGETS[@]} -eq 0 ]; then
  [ -d "$HOME/.cursor" ] && TARGETS+=(cursor)
  [ -d "$HOME/.claude" ] && TARGETS+=(claude)
  [ -d "$HOME/.codex" ] && TARGETS+=(codex)
  [ -d "$HOME/.gemini" ] && TARGETS+=(gemini)
fi

BACKUP="$HOME/.agent-playbook-backup/$(date +%Y%m%d-%H%M%S)"

run() {
  if [ "$APPLY" -eq 1 ]; then "$@"; fi
}

backup() {
  local path=$1 dest="$BACKUP/${1#"$HOME"/}"
  echo "  backup $path -> $dest"
  run mkdir -p "$(dirname "$dest")"
  run mv "$path" "$dest"
}

link() {
  local src=$1 dst=$2
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "  ok     $dst"
    return
  fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    backup "$dst"
  fi
  echo "  link   $dst -> $src"
  run mkdir -p "$(dirname "$dst")"
  run ln -s "$src" "$dst"
}

retire() {
  if [ -e "$1" ] || [ -L "$1" ]; then backup "$1"; fi
}

link_skills() {
  local dir=$1
  for skill in "$ROOT"/skills/*/; do
    skill=${skill%/}
    link "$skill" "$dir/$(basename "$skill")"
  done
}

link_agents() {
  local dir=$1
  for agent in "$ROOT"/agents/*.md; do
    link "$agent" "$dir/$(basename "$agent")"
  done
}

install_cursor() {
  local home="$HOME/.cursor"
  link_skills "$home/skills"
  link_agents "$home/agents"
  for rule in "$ROOT"/rules/*.md; do
    link "$rule" "$home/rules/$(basename "$rule" .md).mdc"
  done
  retire "$home/rules/01-identidade.mdc"
  retire "$home/rules/02-stack-e-fluxo.mdc"
  link "$ROOT/hooks/block-secrets.sh" "$home/hooks/block-secrets.sh"
  link "$ROOT/hooks/cursor.hooks.json" "$home/hooks.json"
  echo "  note   Cursor Settings > Rules > User Rules duplica rules/. Apague as User Rules depois de instalar."
}

install_claude() {
  local home="$HOME/.claude"
  link "$ROOT/dist/AGENTS.md" "$home/CLAUDE.md"
  link_skills "$home/skills"
  link_agents "$home/agents"
  link "$ROOT/hooks/block-secrets.sh" "$home/hooks/block-secrets.sh"
  echo "  note   merge hooks/claude-code.settings.json em $home/settings.json (não é feito automaticamente)"
}

install_codex() {
  link "$ROOT/dist/AGENTS.md" "$HOME/.codex/AGENTS.md"
  link_skills "$HOME/.agents/skills"
}

install_gemini() {
  link "$ROOT/dist/AGENTS.md" "$HOME/.gemini/GEMINI.md"
}

[ "$APPLY" -eq 1 ] || echo "dry-run: nada será alterado. Use --apply para aplicar."
python3 "$ROOT/scripts/build.py"

for target in "${TARGETS[@]}"; do
  echo "[$target]"
  "install_$target"
done
