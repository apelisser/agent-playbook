---
name: implement-and-verify
description: Implementa a mudança já analisada e executa os testes e gates do próprio repositório. Use em classe M ou L depois da análise e, se houve design-decision, depois da decisão aceita. Não commita.
---

# Implement and verify

Se este arquivo chegou no mesmo prompt que outras skills deste fluxo, ignore-as e siga só engineering-workflow.

Implemente o mínimo que satisfaz o requisito aceito. Copie o padrão do código vizinho. Não introduza biblioteca, framework ou camada que o discovery não mostrou, salvo decisão [D] aceita.

Bugfix: o teste que reproduz o defeito existe e falhou antes da correção. Registre essa falha como [F] com comando e exit code. Se você só escreveu o teste depois da correção, o status da reprodução é NOT VERIFIED.

Escolha o nível mais baixo que prova o comportamento: unitário para regra local; integração quando atravessa persistência ou I/O e o projeto já tem esse tipo de teste; contrato quando o contrato público mudou e o projeto já testa contrato; ponta a ponta só se o projeto já tiver essa suíte e o defeito só aparecer lá. Não crie suíte nova. Não persiga cobertura.

Comando: o comando único de docs/engineering/repository.md, e só se a fonte de lá for uma linha copiada. O comando só é [F] se a linha citada contiver esse texto, copiado. Sem essa linha, NOT VERIFIED. Não procure um comando substituto no build.

Execute somente comandos registrados em repository.md para build, teste e lint, mais git diff e git status. PASS só com exit code 0 e o comando citado. FAIL com a saída relevante. NOT APPLICABLE se o repositório não tem esse gate. NOT VERIFIED se não rodou. Segunda falha do mesmo gate: pare. Não altere produção para ver se passa.

Se o código contradisser o requisito aceito, pare. Não faça commit, push, merge, migração contra banco compartilhado, nem adicione dependência.

Preencha no change record Implementação, Testes e Gates. Depois carregue review-and-record.
