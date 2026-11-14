# agent-playbook

Regras, skills, subagentes e hooks para agentes de IA. Uma fonte, vários consumidores: Cursor, Claude Code, Codex, Gemini CLI, Copilot ou qualquer modelo que aceite um prompt de sistema em Markdown.

Commits neste repositório seguem [`commit-conventions.md`](commit-conventions.md).

## Estrutura

| Caminho | Conteúdo | Formato |
| --- | --- | --- |
| `rules/` | Instruções curtas, sempre ativas ou por tipo de arquivo | Markdown com frontmatter `description`, `globs`, `alwaysApply` |
| `skills/<nome>/SKILL.md` | Procedimentos carregados sob demanda | [Agent Skills](https://agentskills.io): frontmatter `name` + `description` |
| `agents/<nome>.md` | Prompts de subagente especialista | Frontmatter `name` + `description`, corpo é o system prompt |
| `hooks/` | Bloqueio de segredo e regras nativas de comando | Script para Cursor/Claude Code; `.rules` para Codex |
| `dist/AGENTS.md` | Gerado. Regras + índice de skills e subagentes num arquivo só | Markdown puro. Caminhos sob `~/.agent-playbook/` |
| `dist/codex/agents/` | Gerado a partir de `agents/` | Agentes TOML do Codex |

`rules/`, `skills/` e `agents/` são a fonte. `dist/` sai de `scripts/build.py` e não se edita à mão. O instalador cria `~/.agent-playbook` como link para a raiz desta fonte, para os caminhos do índice funcionarem fora do checkout.

## Instalar

```bash
scripts/install.sh            # dry-run somente leitura: mostra o que faria
scripts/install.sh --apply    # cria symlinks; arquivo real existente vai para ~/.agent-playbook-backup/
scripts/install.sh --apply cursor claude   # só esses alvos
```

Sem argumento, instala para cada ferramenta cujo diretório já existe em `~`.

| Ferramenta | Instruções globais | Skills | Subagentes | Hook |
| --- | --- | --- | --- | --- |
| Cursor | `~/.cursor/rules/*.mdc` | `~/.cursor/skills/` | `~/.cursor/agents/` | `~/.cursor/hooks.json` |
| Claude Code | `~/.claude/CLAUDE.md` | `~/.claude/skills/` | `~/.claude/agents/` | merge manual de `hooks/claude-code.settings.json` |
| Codex | `~/.codex/AGENTS.md` | `~/.agents/skills/` | `~/.codex/agents/` (TOML gerado) | `~/.codex/rules/agent-playbook.rules` |
| Gemini CLI | `~/.gemini/GEMINI.md` | via índice em `GEMINI.md` | — | — |

Ferramenta sem suporte a arquivo global (ChatGPT, Copilot web, API crua): cole `dist/AGENTS.md` como instrução de sistema. Para usar o índice de skills e subagentes, forneça também acesso ao checkout da fonte; os caminhos são relativos à raiz dele.

Por serem symlinks, editar aqui vale para todas as ferramentas na hora. Execute `python3 scripts/build.py` depois de mexer em `rules/`, `skills/` ou `agents/`; ele atualiza `dist/AGENTS.md` e os agentes TOML do Codex. Um novo processo do Codex pode ser necessário para recarregar instruções e regras.

Os guardrails de `rules/command-safety.md` orientam todas as ferramentas. `hooks/block-secrets.sh` bloqueia padrões óbvios de segredo no Cursor e Claude Code. As regras nativas em `hooks/codex.rules` pedem confirmação para alguns prefixos de comando **somente quando o Codex solicita execução fora do sandbox**; não interceptam toda operação dentro da área gravável. Esses mecanismos não substituem sandbox, revisão do alvo nem política de permissões; comandos com wrappers ou opções em outra posição podem não casar com os prefixos.

## Precedência

`AGENTS.md` e `docs/agente/` do repositório em que o agente está trabalhando vencem este playbook. Isso está escrito nas regras e nas skills.

## O que ficou de fora

- Skills embutidas do Cursor (`~/.cursor/skills-cursor/`) e plugins de terceiros (`superpowers`): não foram escritas aqui e se atualizam sozinhas.
- Planos, canvases, `AGENTS.md` e `docs/` de cada projeto: moram no git do projeto, não aqui.
