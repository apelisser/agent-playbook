# Cost-aware model routing

- Class: M
- Status: closed
- Request: Add the shared conversation's model and reasoning-effort selection approach to this repository as a reusable, tool-neutral skill.

## Evidence

- [F1] The shared conversation asks for the cheapest configuration likely to complete a task with verifiable quality, with escalation when needed (conversation supplied by the user).
- [F2] The repository serves multiple agent tools (`README.md:3,28-39`).
- [F3] Model controls vary by host; this repository installs shared instructions and skills through generated indexes or symlinks (`README.md:18-39`).
- [F4] `scripts/build.py` indexes every `skills/*/SKILL.md` in `dist/AGENTS.md` (`scripts/build.py:79-81`).
- [F5] `scripts/install.sh` links repository skills into supported tools' skill directories (`scripts/install.sh:62-66,77-107`).

## Inference

- [I1] A skill cannot directly switch the model of its currently running primary agent across all supported hosts. Based on the repository's instruction-only skill format, confidence high; validate per host when a model-selection capability is exposed.

## Recommendation

- [R1] Add a tool-neutral `cost-aware-model-router` skill for task-level selection, escalation, and honest reporting, plus a short global rule that invokes it when the host exposes selection controls. Do not claim automatic primary-session switching without host confirmation.

## Decision

- [D1] Use a skill and a short invocation rule. The user asked for a tool-neutral addition to this repository; F2, F4, and F5 provide the existing integration path. A launcher for one host would conflict with this scope.

## Implementation

- [F6] Added `skills/cost-aware-model-router/SKILL.md` with four selection levels, escalation criteria, authorization for high-cost settings, and a requirement to verify effective settings.
- [F7] Added `rules/model-routing.md` to trigger the skill when model or effort controls are available; regenerated `dist/AGENTS.md`.
- [F8] The installed skill symlink resolves to this repository (`readlink` verification); the shared source also appears in the generated index.

## Tests and gates

- PASS: `python3 scripts/build.py` (exit 0; generated 125 lines).
- PASS: `scripts/install.sh` (exit 0; dry run showed the new skill link for supported tools).
- PASS: `python3 -m unittest discover -s tests` (exit 0; 2 tests).
- PASS: `printf '{"command":"echo ok"}' | hooks/block-secrets.sh` (exit 0; `allow`).
- PASS: skill frontmatter validation (exit 0; valid skill).
- PASS: `git diff --check` (exit 0).
- NOT VERIFIED: automatic primary-session model switching across hosts; the skill intentionally does not claim or perform it.

## Review

- [F9] The reviewed diff adds only the new skill, invocation rule, generated index, and engineering records. It introduces no product-specific tool name in `rules/` or `skills/`.
- Draft commit: `feat(skills): add cost-aware model routing`
