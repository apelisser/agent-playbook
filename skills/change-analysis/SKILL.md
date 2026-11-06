---
name: change-analysis
description: Analisa problema, contexto e requisitos de uma mudança M ou L antes de editar código. Use depois da classificação e do discovery. Separa [F], [I], [R] e dúvidas. Não use para classe S.
---

# Change analysis

Se este arquivo chegou no mesmo prompt que outras skills deste fluxo, ignore-as e siga só engineering-workflow.

Não edite código de produção nesta skill. Pode ler, buscar e executar teste já existente para reproduzir um bug.

Abra docs/engineering/changes/AAAA-MM-DD-slug.md. Se esse arquivo já existir, pare e pergunte. Não grave por cima. Escreva só seções que já tenham bullet. Sem transcrição de chat. Comece com classe M ou L, status aberto, e o pedido do usuário sem embelezar. status fechado não se edita.

Procure no código vizinho, testes, docs, ADRs, contratos e git log. Registre [F] com fonte, [I] com base, confiança e como validar, e dúvida que bloqueia: pergunte e pare.

Bugfix: [F] do sintoma; reproduza e registre [F] do comando, ou pare com NOT VERIFIED; causa em [F], ou [I] com caminho de validação sem implementar em cima dela; [R] da correção baseada nos [F].

Feature ou mudança de comportamento: requisito verificável; implementação semelhante como [F]; contratos, persistência e chamadores como [F] ou NOT VERIFIED; [R] do caminho. Mudança de comportamento em M para antes do código de produção. Se houver dois desenhos, carregue design-decision.

Implementar sem pausa só quando a mudança preserva comportamento e já existe teste [F] desse comportamento. Classe L, mudança de comportamento, ou qualquer gate humano: pare e mostre [R] antes de implementar.
