# Controller query guardrails

- Class: M
- Status: closed
- Request: Refine the agent playbook to flag queries in controllers and add the supplied development guidelines without duplicating existing rules.

## Evidence

- [F1] `rules/02-stack-and-workflow.md` already requires source-side pagination and use of `engineering-workflow`.
- [F2] `rules/java-spring.md` contains Java persistence conventions but does not define controller boundaries or flag direct queries as an antipattern.
- [F3] `AGENTS.md` requires regeneration of `dist/AGENTS.md` after changes to rules and requires repository tests.

## Recommendation

- [R1] Put concise general development guidelines in the always-applied workflow rule, and put the SQL/data-access controller guardrail in the Java-scoped rule. Explicitly flag existing direct-query controllers as antipatterns while requiring agents to reuse the module's established abstraction rather than inventing a new architecture.

## Implementation

- [F4] Added general incremental-change, reuse, compatibility, cross-contract, test, and validation guidance to `rules/02-stack-and-workflow.md`.
- [F5] Added Java controller boundaries to `rules/java-spring.md`: direct persistence queries are flagged as an antipattern even when present in existing code; changes should use the module's established abstraction and avoid inventing layers.
- [F6] Regenerated `dist/AGENTS.md` with `python3 scripts/build.py`.

## Tests and gates

- PASS: `python3 scripts/build.py` (exit 0; generated 135 lines).
- PASS: `scripts/install.sh` (exit 0; dry run).
- PASS: `python3 -m unittest discover -s tests` (exit 0; 2 tests).
- PASS: `printf '{"command":"echo ok"}' | hooks/block-secrets.sh` (exit 0; `allow`).
- PASS: `git diff --check` (exit 0).

## Review

- [F7] The generated global instructions include the general development guidelines and Java-scoped controller rules. No runtime code or unrelated source files changed.
