---
name: ddd-conventions
description: Convenções de nomenclatura e modelagem DDD (agregados, repositórios, bounded contexts). Use ao desenhar agregados, nomear repositórios, revisar limites de domínio ou criar abstrações em código Java/Spring DDD.
---

# Convenções DDD

`AGENTS.md` / `docs/agente/` do projeto vencem este skill.

## Nomenclatura de repositório
Nome revela intenção de domínio, não a implementação da query:
- `findAllBlockedEmails()` — correto, comunica o conceito de negócio
- `findByBlockedTrue()` — evitar, vaza detalhe de implementação (nome de coluna/flag) para a assinatura

## Limites de agregado
- Uma transação de escrita = um agregado. Se uma operação precisa escrever em dois agregados na mesma transação, questionar se o limite do agregado está certo antes de forçar a transação a cobrir os dois
- Repositório de domínio só expõe operações que fazem sentido no vocabulário do negócio, não CRUD genérico

## Documentação de comportamento não óbvio
Qualquer método com efeito colateral que não é inferível pela assinatura (soft-delete, cache, invalidação assíncrona, refresh agendado) precisa de Javadoc explicando o comportamento — não deixar só no histórico do commit.

## Antes de adicionar abstração nova
Perguntar: existe um segundo caso de uso concreto hoje, ou isso é especulação para o futuro? Se for só especulação, não adicionar a camada de indireção agora.

## Transação
`@Transactional` nunca em classe base abstrata sem revisar o escopo da conexão — já causou bug de conexão aberta durante I/O externo (SMTP).
