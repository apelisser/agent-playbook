---
name: design-decision
description: Compara alternativas e decide se cabe ADR em mudança L ou em M com contrato, banco, segurança, irreversibilidade ou mais de um desenho plausível. Pare para decisão humana antes de implementar. Não use para classe S.
---

# Design decision

Se este arquivo chegou no mesmo prompt que outras skills deste fluxo, ignore-as e siga só engineering-workflow.

Não edite código de produção. Não crie diagrama por hábito.

Entrada: change record já aberto e os [F] da análise. Se faltar [F] verificável, volte para change-analysis.

No máximo três alternativas, incluindo não mudar o desenho atual quando ele existir. Para cada uma: [F], [I] se houver, trade-off. Depois uma [R] com base, argumento, trade-off aceito e confiança. Confiança alta só se a base for [F]. Se a [R] depender de [I], o gate humano é obrigatório.

Crie ADR só se a decisão for difícil de reverter: arquitetura, tecnologia nova, integração, persistência, contrato público, segurança. Não crie ADR para typo, bug local ou refatoração que preserva contrato.

Caminho: adr_dir de repository.md, ou docs/engineering/adr/AAAA-MM-DD-slug.md. Se o arquivo do ADR já existir, pare e pergunte. Não grave por cima.

O ADR fica status proposto até o usuário aceitar. Conteúdo: Contexto [F], Restrições, Premissas [I] e como validar, Alternativas, Decisão D1 pendente, Consequências. Até a aceitação, não implemente.

Pare e mostre [R], trade-off e a pergunta objetiva. Grave no change record D1 com status aceita, base R1 e quem: usuário, só depois da aceitação.
