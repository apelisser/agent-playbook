---
name: review-and-record
description: Revisa o diff contra requisito, testes e docs, atualiza documentação só se ela mentir, e prepara change record, commit e PR. Use depois de implement-and-verify em mudança M ou L. Não commita sem pedido explícito.
---

# Review and record

Se este arquivo chegou no mesmo prompt que outras skills deste fluxo, ignore-as e siga só engineering-workflow.

Releia o diff. A narrativa da implementação não é evidência. Em M, esta revisão é do mesmo modelo: ela acha inconsistência e não substitui outro revisor.

Em L, peça revisão independente quando houver revisor disponível e compare o resultado com pedido, D1, diff e testes. Sem revisor, faça a revisão no próprio chat e declare essa limitação. Achado confirmado no diff é [F]; achado não confirmado é [I]. Corrija achados de corretude antes de fechar o registro.

Em M, compare pedido, D1, diff, testes e docs. Procure comportamento fora do pedido, duplicação, contrato quebrado, erro engolido, autorização, dado sensível em log, teste que não falharia se o bug voltasse, doc que descreve o comportamento antigo. Achado [F] volta a implement-and-verify uma vez. Na segunda rodada, pare.

Atualize doc existente só se o texto ficou falso. Não crie documento que repete o código.

IDs F, I, R, D não se renumeram. Bullets com ID. Não cole transcrição de chat. Em M ou L, sem achado [F] em aberto e com o rascunho de commit ou PR escrito, marque status fechado. status fechado não se edita.

Rascunho de commit e PR apenas. PR em M e L só com conteúdo real: problema, solução, decisão D1, testes e status, docs, riscos, breaking change, migração, rollback. Sem seção vazia. Não rode git commit, git push nem abra o PR até o usuário pedir.
