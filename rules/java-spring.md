---
description: Default Java/Spring DDD persistence and transaction conventions. Project AGENTS.md wins.
globs: "**/*.java"
alwaysApply: false
---

# Java / Spring (global)

- Repositório: intenção de domínio (`findAllBlockedEmails`, não `findByBlockedTrue`).
- Escrita de agregado → Spring Data JDBC. Leitura com joins/agregação/paginação pesada → jOOQ **somente se o projeto já usa jOOQ**.
- Soft-delete ou side-effect não óbvio → Javadoc no método.
- `@Transactional` nunca em classe base abstrata sem revisar o escopo da conexão.
- RLS: policy na tabela; GUC de sessão é do projeto; testar com o role de aplicação, não superusuário.
