# Convenção de commits

Este repositório usa [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/). Um commit representa um escopo lógico.

## Assunto

Formato: `type: short description` ou `type(scope): short description`. Escreva toda a linha principal em inglês e minúsculas, com verbo no imperativo e sem ponto final. Prefira uma frase curta que diga o que mudou.

Use `feat` para capacidade nova e `fix` para correção. Para outros escopos, escolha o tipo que descreve a mudança, como `docs`, `refactor`, `test`, `build`, `ci` ou `chore`. Não force `feat` ou `fix` para documentação ou manutenção.

Exemplos:

```text
fix(install): keep dry runs read-only
feat(codex): install generated agents
docs: describe commit conventions
chore: merge task/agent-guardrails into main
```

## Corpo e rodapé

O corpo é opcional. Se o assunto não explicar o motivo, acrescente um parágrafo curto em inglês, separado por uma linha em branco. Evite repetir a lista de arquivos, a saída de testes e detalhes que já estão no diff.

Use rodapé só quando necessário, por exemplo para referência de ticket ou `BREAKING CHANGE:`, conforme a especificação. A marca `BREAKING CHANGE` permanece em maiúsculas por exigência do formato. Inclua o ticket quando houver.

## Merge

Ao criar um commit de merge manual, escreva o assunto no mesmo formato, em inglês e minúsculas. Forneça a mensagem explicitamente para evitar o título padrão `Merge branch ...` do Git. Preserve a regra global de merge para `main` com `--no-ff`.
