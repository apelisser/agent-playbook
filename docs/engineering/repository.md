# Repository discovery

- Updated: 2026-11-06
- Git HEAD: `eff03a1cbcff89ec87381c85719582176a962c42`

## Build

- [F] `python3 scripts/build.py` generates `dist/AGENTS.md` and agent configuration files (`AGENTS.md:15`, `scripts/build.py:94-116`).

## Tests

- [F] Full suite: `python3 -m unittest discover -s tests` (`AGENTS.md:22`).
- Single test command: NOT VERIFIED; no command is documented in the repository instructions.

## Lint

- NOT VERIFIED; no lint command is documented.

## CI

- NOT VERIFIED; no CI configuration was found.

## Commits and branches

- [F] Conventional Commits with an English, lowercase imperative subject (`commit-conventions.md:1-7`).
- [F] Merge to `main` uses `--no-ff` (`rules/03-git.md`).

## Pull requests

- NOT VERIFIED; no repository-specific PR procedure was found.

## Documentation

- `adr_dir`: `docs/engineering/adr/` if an ADR is needed (`skills/design-decision/SKILL.md`).
- [F] The repository's instructions live in `rules/`, `skills/`, and `agents/`; `dist/` is generated (`README.md:9-18`).

## Modules

- [F] `skills/` contains reusable instructions; `scripts/build.py` indexes them in `dist/AGENTS.md` (`scripts/build.py:79-81`).
- [F] `scripts/install.sh` symlinks skills into supported tools' skill directories (`scripts/install.sh:62-66,77-107`).

## API

- NOT APPLICABLE; this repository has no application API.

## Persistence

- NOT APPLICABLE; no application data store.

## Configuration

- [F] Rules and skills use Markdown frontmatter (`AGENTS.md:8-12`).

## Observability

- NOT APPLICABLE; no running application.

## Security

- [F] `hooks/block-secrets.sh` checks commands for obvious secret patterns (`README.md:41`).

## Conflicts

- None found during this discovery.
