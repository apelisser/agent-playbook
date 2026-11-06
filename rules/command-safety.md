---
description: Guardrails for destructive and sensitive operations.
alwaysApply: true
---

Antes de executar comando que apaga dados, reescreve histórico, muda infraestrutura ou envia credenciais, confira o alvo real, o escopo e a reversibilidade. Use prévia ou leitura quando disponível (`git diff`, plano de migração, dry run). Não coloque segredo no comando, argumento, log ou resposta.

Se o pedido já autoriza a operação e o alvo é inequívoco, prossiga com o menor escopo necessário. Se o alvo, a autorização ou uma consequência irreversível não estiverem claros, apresente o efeito concreto e peça decisão antes de executar. Não use variante de comando, script ou ferramenta alternativa para contornar um bloqueio de segurança.
