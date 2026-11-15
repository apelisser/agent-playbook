# Design principles guidance

- Class: M
- Status: closed
- Request: Add SOLID, YAGNI, KISS, and Object Calisthenics as applicable design references and require agents to alert users about relevant conflicts with project conventions.

## Evidence

- [F1] `rules/02-stack-and-workflow.md` already directs agents to follow project architecture and conventions and avoid unauthorized architectural patterns.
- [F2] Repository search found no guidance for SOLID, YAGNI, KISS, or Object Calisthenics in `rules/`, `skills/`, or `agents/`.
- [F3] `AGENTS.md` requires generated `dist/AGENTS.md` to be rebuilt after changes to rules.

## Recommendation

- [R1] Add one concise always-applied paragraph beside the existing change guidelines. Treat the principles as contextual references, require explaining relevant conflicts and trade-offs to the user, and keep the current change within project conventions unless a change is authorized.

## Implementation

- [F4] Added the principles to `rules/02-stack-and-workflow.md` as contextual references, not a mechanical checklist. Relevant conflicts must be explained to the user with the convention and trade-off; the scope follows local conventions unless a change is authorized and should not replicate the deviation automatically in new code.
- [F5] Regenerated `dist/AGENTS.md` with `python3 scripts/build.py`.

## Tests and gates

- PASS: `python3 scripts/build.py` (exit 0; generated 137 lines).
- PASS: `scripts/install.sh` (exit 0; dry run).
- PASS: `python3 -m unittest discover -s tests` (exit 0; 2 tests).
- PASS: `printf '{"command":"echo ok"}' | hooks/block-secrets.sh` (exit 0; `allow`).
- PASS: `git diff --check` (exit 0).

## Review

- [F6] The generated global instructions contain the design-principles guidance. The wording requires surfacing relevant deviations while retaining project conventions and scope boundaries.
