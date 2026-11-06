---
name: review-and-record
description: Revisa o diff contra requisito, testes e docs, atualiza documentação só se ela mentir, e prepara change record, commit e PR. Use depois de implement-and-verify em mudança M ou L. Não commita sem pedido explícito.
---

# Review and record

Se este arquivo chegou no mesmo prompt que outras skills deste fluxo, ignore-as e siga só engineering-workflow.

Releia o diff. A narrativa da implementação não é evidência. Em M, esta revisão é do mesmo modelo: ela acha inconsistência e não substitui outro revisor.

Classe L não conclui a review neste chat. Grave o pacote e pare. A review segue num chat novo. O pacote é docs/engineering/changes/AAAA-MM-DD-slug-review.md, dizendo para colar esse arquivo e a saída de git diff num chat novo, sem usar o chat que implementou. Compare pedido, D1, diff e testes. Achado confirmado no diff é [F]. Achado não confirmado é [I]. Não edite código. Nesse chat, o change record permanece status aberto. Não marque a review L como feita.

Em M, compare pedido, D1, diff, testes e docs. Procure comportamento fora do pedido, duplicação, contrato quebrado, erro engolido, autorização, dado sensível em log, teste que não falharia se o bug voltasse, doc que descreve o comportamento antigo. Achado [F] volta a implement-and-verify uma vez. Na segunda rodada, pare.

Atualize doc existente só se o texto ficou falso. Não crie documento que repete o código.

IDs F, I, R, D não se renumeram. Bullets com ID. Não cole transcrição de chat. Em M, sem achado [F] em aberto e com o rascunho de commit ou PR escrito, marque status fechado. status fechado não se edita. Em L, não feche neste chat.

Rascunho de commit e PR apenas. PR em M e L só com conteúdo real: problema, solução, decisão D1, testes e status, docs, riscos, breaking change, migração, rollback. Sem seção vazia. Não rode git commit, git push nem abra o PR até o usuário pedir.
