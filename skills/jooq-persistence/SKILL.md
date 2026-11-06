---
name: jooq-persistence
description: Critérios para usar Spring Data JDBC ou jOOQ e separar suas responsabilidades. Use ao criar repositórios, consultas, agregados ou relatórios, ou ao escolher entre JDBC e jOOQ.
---

# Persistência híbrida: Spring Data JDBC + jOOQ

Se o projeto não usa jOOQ, não introduza jOOQ. `AGENTS.md` do repo vence este skill.

## Critério de decisão
| Cenário | Abordagem |
|---|---|
| Escrita de um agregado completo, invariantes de domínio a proteger | Spring Data JDBC, repositório no pacote de domínio |
| Leitura com joins de múltiplas tabelas, agregação, paginação pesada | jOOQ, camada de query separada |
| Relatório/projeção que não corresponde a um agregado de domínio | jOOQ |
| Consulta simples por ID/campo único de um agregado já modelado | Spring Data JDBC |

## Separação de camadas
- `DSLContext` do jOOQ nunca aparece em classe do pacote de domínio — isolar em `infrastructure.query` ou equivalente
- Repositórios Spring Data JDBC ficam no pacote de domínio, nomeados com intenção (`findAllBlockedEmails`, não `findByBlockedTrue`)
- Queries jOOQ retornam DTOs de leitura, nunca a entidade de agregado diretamente — evita a tentação de escrever através da query de leitura

## Transação e RLS
- Confirmar que jOOQ e Spring Data JDBC compartilham a mesma conexão transacional quando operação mista é necessária na mesma unidade de trabalho
- O `SET` do GUC de tenant precisa acontecer antes de qualquer query, JDBC ou jOOQ, na mesma transação

## Javadoc obrigatório
Documentar no método sempre que houver:
- Soft-delete (a query não retorna registros com delete lógico, mesmo que a assinatura não deixe isso óbvio)
- Cache ou refresh assíncrono por trás do método
- Qualquer comportamento que não é inferível só pela assinatura
