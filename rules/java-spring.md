---
description: Convenções de persistência e transações Java/Spring DDD. O AGENTS.md do projeto prevalece.
globs: "**/*.java"
alwaysApply: false
---

# Java / Spring (global)

- Controller é adaptador HTTP: não deve conter SQL, `JdbcClient`, `DSLContext` nem lógica de acesso a dados. Delegue à camada de aplicação ou consulta já usada pelo projeto.
- Se controllers existentes fizerem consultas diretamente, sinalize isso como antipadrão, mesmo que pareça uma convenção local. Não copie esse padrão para código novo; ao alterar código existente, confirme a arquitetura do módulo e use a abstração já estabelecida, sem criar outra camada por conta própria.
- Repositório: intenção de domínio (`findAllBlockedEmails`, não `findByBlockedTrue`).
- Escrita de agregado → Spring Data JDBC. Leitura com joins/agregação/paginação pesada → jOOQ **somente se o projeto já usa jOOQ**.
- Soft-delete ou side-effect não óbvio → Javadoc no método.
- `@Transactional` nunca em classe base abstrata sem revisar o escopo da conexão.
- RLS: policy na tabela; GUC de sessão é do projeto; testar com o role de aplicação, não superusuário.
