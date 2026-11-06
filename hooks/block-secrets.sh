#!/usr/bin/env bash
# Block shell commands that look like they paste a private key or api/secret key assignment.
# Fail-open on parse errors. Regex is obvious-cases only — not DLP.
#
# Speaks two hook protocols, detected from stdin:
#   Cursor beforeShellExecution: {"command": "..."}             -> JSON {"permission": ...} on stdout
#   Claude Code PreToolUse:      {"tool_input": {"command": ...}} -> exit 2 + reason on stderr to block
set -euo pipefail

input=$(cat)
parsed=$(printf '%s' "$input" | python3 -c '
import json, sys
try:
    data = json.load(sys.stdin)
except Exception:
    print("cursor")
    raise SystemExit(0)
if isinstance(data.get("tool_input"), dict):
    print("claude")
    print(data["tool_input"].get("command") or "")
else:
    print("cursor")
    print(data.get("command") or data.get("cmd") or "")
' 2>/dev/null || printf 'cursor\n')

protocol=$(printf '%s\n' "$parsed" | head -n 1)
cmd=$(printf '%s\n' "$parsed" | tail -n +2)

if printf '%s' "$cmd" | python3 -c '
import re, sys
text = sys.stdin.read()
pat = re.compile(
    r"BEGIN (RSA |OPENSSH |EC |DSA |ENCRYPTED )?PRIVATE KEY"
    r"|(api|secret)[_-]?key\s*=\s*[\"'\''][A-Za-z0-9]{16,}",
    re.I,
)
sys.exit(0 if pat.search(text) else 1)
'; then
  if [ "$protocol" = "claude" ]; then
    echo "Hook global bloqueou o comando por parecer expor credencial. Não reexecute com o segredo no comando." >&2
    exit 2
  fi
  printf '%s\n' '{
    "permission": "deny",
    "user_message": "Comando bloqueado: possível segredo (chave privada ou api/secret key) no shell.",
    "agent_message": "Hook global bloqueou o comando por parecer expor credencial. Não reexecute com o segredo no comando."
  }'
  exit 0
fi

if [ "$protocol" = "cursor" ]; then
  printf '%s\n' '{ "permission": "allow" }'
fi
exit 0
