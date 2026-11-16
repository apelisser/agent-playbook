# Evitar decisões unilaterais de produto e UX

classe: M; status: fechado

## Pedido

Reforçar no agent-playbook que o agente não deve escolher por conta própria mudanças de produto e UX sem base no pedido ou nos padrões existentes.

## Evidência

- [F1] `rules/02-stack-and-workflow.md` já exige seguir arquitetura e convenções, e perguntar quando uma escolha material depende de preferência ou requisito não definido.
- [F2] A regra não trata explicitamente de remover, ocultar ou reposicionar affordances existentes por suposição do agente.

## Decisão

- [R1] Acrescentar orientação global curta em `rules/02-stack-and-workflow.md`: preferir padrões visíveis existentes, adaptar ações ao contexto e consultar o usuário para escolhas materiais ainda não resolvidas. Base: [F1], [F2].

## Implementação

- [I1] `rules/02-stack-and-workflow.md` agora orienta a preservar padrões de UX existentes, adaptar controles ao contexto e perguntar quando uma escolha material não está definida.

## Testes e gates

- [F] `python3 scripts/build.py` passou e regenerou `dist/AGENTS.md`.
- [F] `scripts/install.sh` passou em dry-run sem alterar arquivos locais.
- [F] `python3 -m unittest discover -s tests` passou: 2 testes.
- [F] `printf '{"command":"echo ok"}' | hooks/block-secrets.sh` retornou `allow`.

## Pendências

Nenhuma.

## Commit

Rascunho: `docs: clarify product ux decision boundaries`.
