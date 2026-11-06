# agent-playbook — instruções para quem edita este repositório

Este repositório é a fonte das instruções globais de Abner para agentes de IA. Ele não é o perfil em si: o perfil instalado é `dist/AGENTS.md` e os symlinks de `scripts/install.sh`.

Antes de commitar neste repositório, siga [`commit-conventions.md`](commit-conventions.md).

## Regras de edição

- Conteúdo neutro de ferramenta. Não escreva caminho, nome de tool ou recurso exclusivo de um produto (`~/.cursor/...`, `CallDynamicTool`, `Task`) em `rules/`, `skills/` ou `agents/`. Quando o comportamento depende de capacidade, descreva a capacidade ("se houver browser", "se a ferramenta suportar subagentes").
- Nomes de arquivos, diretórios, skills e subagentes em inglês, kebab-case, exceto nomes exigidos por ferramentas ou linguagens (como `SKILL.md` e arquivos Python). Descrições de regras, skills e subagentes em PT-BR; preserve termos técnicos, APIs e identificadores no original. O restante do texto pode ser PT-BR.
- Skill: `skills/<name>/SKILL.md`, frontmatter só com `name` (igual ao nome da pasta) e `description` (o que faz + quando usar). Arquivo auxiliar fica ao lado e é citado pelo `SKILL.md`.
- Regra: `rules/<name>.md` com `alwaysApply: true`, ou `alwaysApply: false` + `globs`. Curta. Procedimento longo vira skill.
- Subagente: `agents/<name>.md` com `name` e `description`. O corpo é o system prompt.
- Uma informação, um lugar. Antes de adicionar, procure se já existe em outra regra ou skill.
- Não edite `dist/`. Rode `python3 scripts/build.py` depois de qualquer mudança em `rules/`, `skills/` ou `agents/` e commite o resultado junto. `hooks/codex.rules` é a fonte das regras nativas do Codex.

## Verificação

```bash
python3 scripts/build.py
scripts/install.sh            # dry-run, não altera nada
python3 -m unittest discover -s tests
```

Hook: `printf '{"command":"echo ok"}' | hooks/block-secrets.sh` deve imprimir `allow`.
