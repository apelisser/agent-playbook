# agent-playbook

Regras, skills, subagentes e hooks pessoais de Abner para agentes de IA. Uma fonte, vários consumidores: Cursor, Claude Code, Codex, Gemini CLI, Copilot ou qualquer modelo que aceite um prompt de sistema em Markdown.

## Estrutura

| Caminho | Conteúdo | Formato |
| --- | --- | --- |
| `rules/` | Instruções curtas, sempre ativas ou por tipo de arquivo | Markdown com frontmatter `description`, `globs`, `alwaysApply` |
| `skills/<nome>/SKILL.md` | Procedimentos carregados sob demanda | [Agent Skills](https://agentskills.io): frontmatter `name` + `description` |
| `agents/<nome>.md` | Prompts de subagente especialista | Frontmatter `name` + `description`, corpo é o system prompt |
| `hooks/` | Bloqueio de segredo em comando de shell | Script único que fala o protocolo do Cursor e do Claude Code |
| `dist/AGENTS.md` | Gerado. Regras + índice de skills e subagentes num arquivo só | Markdown puro. Caminhos relativos à raiz do repositório |

`rules/`, `skills/` e `agents/` são a fonte. `dist/AGENTS.md` sai de `scripts/build.py` e não se edita à mão.

## Instalar

```bash
scripts/install.sh            # dry-run: mostra o que faria
scripts/install.sh --apply    # cria symlinks; arquivo real existente vai para ~/.agent-playbook-backup/
scripts/install.sh --apply cursor claude   # só esses alvos
```

Sem argumento, instala para cada ferramenta cujo diretório já existe em `~`.

| Ferramenta | Instruções globais | Skills | Subagentes | Hook |
| --- | --- | --- | --- | --- |
| Cursor | `~/.cursor/rules/*.mdc` | `~/.cursor/skills/` | `~/.cursor/agents/` | `~/.cursor/hooks.json` |
| Claude Code | `~/.claude/CLAUDE.md` | `~/.claude/skills/` | `~/.claude/agents/` | merge manual de `hooks/claude-code.settings.json` |
| Codex | `~/.codex/AGENTS.md` | `~/.agents/skills/` | — | — |
| Gemini CLI | `~/.gemini/GEMINI.md` | via índice em `GEMINI.md` | — | — |

Ferramenta sem suporte a arquivo global (ChatGPT, Copilot web, API crua): cole `dist/AGENTS.md` como instrução de sistema. O índice no fim do arquivo aponta o caminho de cada skill e subagente para leitura sob demanda.

Por serem symlinks, editar aqui vale para todas as ferramentas na hora. Só `dist/AGENTS.md` precisa de `python3 scripts/build.py` depois de mexer em `rules/`, `skills/` ou `agents/`.

## Precedência

`AGENTS.md` e `docs/agente/` do repositório em que o agente está trabalhando vencem este playbook. Isso está escrito nas regras e nas skills.

## O que ficou de fora

- Skills embutidas do Cursor (`~/.cursor/skills-cursor/`) e plugins de terceiros (`superpowers`): não foram escritas aqui e se atualizam sozinhas.
- Planos, canvases, `AGENTS.md` e `docs/` de cada projeto: moram no git do projeto, não aqui.
