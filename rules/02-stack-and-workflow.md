---
alwaysApply: true
---

A stack Java/Spring, PostgreSQL, IAM, Kubernetes e OpenTelemetry não é padrão de todo repositório. Use a skill stack-padrao só quando o repositório for esse stack ou quando o usuário pedir. Se o repo tiver AGENTS.md ou docs/agente/, essas fontes vencem a skill.

Mudança de código segue a skill engineering-workflow (classe S/M/L, evidência [F]/[R]/[I]). Ela escolhe as outras skills do fluxo.

Em toda mudança, siga a arquitetura e as convenções existentes, faça alterações incrementais, reutilize componentes e abstrações e evite refatoração fora do escopo. Não introduza padrões arquiteturais sem autorização explícita. Preserve compatibilidade de API, salvo instrução contrária; ao mudar contrato, atualize servidor e interface de forma consistente. Inclua ou ajuste testes relevantes e execute as validações aplicáveis.

Em decisões de produto e UX, siga os padrões visíveis e os comportamentos existentes. Não remova, esconda ou reposicione controles por conveniência ou por uma suposição sobre o que combina com o fluxo. Se um controle existente precisar de ações diferentes em outro contexto, adapte suas ações e preserve a affordance sempre que isso atender ao pedido. Quando o pedido e o produto não determinarem uma escolha material de fluxo, conteúdo, disponibilidade ou posicionamento, exponha a dúvida e pergunte antes de decidir; continue o trabalho independente dessa resposta. Pedido explícito autoriza a mudança solicitada, não mudanças colaterais de experiência.

Use SOLID, YAGNI, KISS e Object Calisthenics como referências quando forem adequadas à linguagem, ao domínio e ao escopo; não os aplique como checklist mecânico. Ao encontrar um conflito relevante entre esses princípios e uma convenção do projeto, explique ao usuário a convenção, o princípio afetado e o trade-off. Siga a convenção no escopo atual, salvo autorização para mudá-la, e não replique automaticamente o desvio em código novo.

Paginação de dados deve ocorrer na fonte da consulta, aplicando filtros e ordenação antes de limitar os resultados. Não carregue o conjunto completo para paginar em memória, salvo em caso extremo explicitamente solicitado pelo usuário.

Pergunta sobre viabilidade, recomendação ou pedido de plano autoriza responder ou planejar, não implementar. Implemente ou execute um plano somente após pedido explícito ou aprovação inequívoca de uma proposta concreta. Se a autorização estiver ambígua, responda ao que foi perguntado e aguarde a decisão antes de alterar código, branch ou outros artefatos.

Em aplicação web (UI, layout, estilo, rota, estado de cliente ou dado renderizado), verifique o fluxo no browser antes de declarar a tarefa pronta. O procedimento está na skill web-verification. Se não houver browser, use o substituto mais próximo e diga o que ficou sem verificar.

Não invente conteúdo de skill, subagente ou regra que não esteja disponível. Se o arquivo não existir, trabalhe com o que está no contexto e diga o que faltou.
