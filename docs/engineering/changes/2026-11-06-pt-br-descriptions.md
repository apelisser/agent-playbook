# PT-BR descriptions

- Class: M
- Status: closed
- Request: Standardize descriptions in PT-BR and names of files, directories, and skills in English kebab-case.

## Evidence

- [F1] `AGENTS.md` already requires English kebab-case names and permits PT-BR text (`AGENTS.md:11`).
- [F2] `description` fields in `rules/`, `skills/`, and `agents/` currently mix English and PT-BR (`rg -n '^description:' rules skills agents`).
- [F3] `scripts/build.py` copies skill and agent descriptions into generated global instructions (`scripts/build.py:79-81,91-93`).

## Recommendation

- [R1] Make the language rule explicit in `AGENTS.md` and translate existing English or mixed `description` fields. Keep domain terms and identifiers in their original form. Regenerate `dist/` through the build script.

## Implementation

- [F4] `AGENTS.md` now specifies PT-BR descriptions and English kebab-case names, with exceptions for names required by tools or language conventions.
- [F5] Updated `description` fields in six rules, seven skills, and eight subagents; regenerated `dist/AGENTS.md` and agent TOML files.

## Tests and gates

- PASS: `python3 scripts/build.py` (exit 0; generated 125 lines).
- PASS: `python3 -m unittest discover -s tests` (exit 0; 2 tests).
- PASS: `scripts/install.sh` (exit 0; dry run).
- PASS: `printf '{"command":"echo ok"}' | hooks/block-secrets.sh` (exit 0; `allow`).
- PASS: `git diff --check` (exit 0).
- [F6] Compared 21 changed source files after removing frontmatter: no rule, skill, or subagent body changed.
- [F7] Compared eight generated agent TOML files: no field other than `description` changed.

## Review

- [F8] Local Codex instructions, skill, and agent configuration are symlinks to this repository's generated or source files (`readlink` checks). No copy-based reinstall is needed; a new session may be needed to reload the updated metadata.
- Draft commit: `docs: standardize descriptions in pt-br`
