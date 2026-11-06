---
name: postgres-rls
description: Padrões e antipadrões de Row-Level Security no PostgreSQL para isolamento multitenant. Use ao trabalhar com RLS, isolamento de tenants, GUCs de sessão, pools de conexão ou policies multitenant.
---

# Row-Level Security para multitenancy

Se o projeto tiver `AGENTS.md` ou `docs/agente/`, essas fontes vencem este skill — inclusive o nome da variável de sessão.

## Padrão de sessão
Toda conexão de aplicação define o tenant atual no início da transação/sessão. O nome do GUC é o do projeto. Um default comum é `app.tenant_id`:

```sql
SET app.tenant_id = '<uuid-do-tenant>';
```

A policy referencia essa variável de sessão, nunca um valor passado diretamente na query:

```sql
CREATE POLICY tenant_isolation ON pedidos
  USING (tenant_id = current_setting('app.tenant_id')::uuid);
```

## Antipadrões conhecidos
- **Superusuário ou role com `BYPASSRLS` executando queries de aplicação**: RLS é ignorado silenciosamente. Sempre testar com o role real de produção.
- **Confiar só no filtro da aplicação** (`WHERE tenant_id = ?`) sem policy ativa: um bug de um `WHERE` esquecido em uma query nova vaza dados entre tenants. RLS é a rede de segurança, não o filtro em si.
- **Pool de conexões sem reset do GUC entre reuses**: se a variável de sessão não for limpa/redefinida a cada checkout de conexão do pool, uma requisição pode herdar o tenant da requisição anterior. Confirmar que o `SET` acontece por transação, não por conexão física.
- **Migrations rodando com role que tem `BYPASSRLS`**: correto para migration, mas confirme que esse role nunca é usado em runtime de aplicação.
- **Forçar RLS no dono do esquema**: alguns projetos proíbem isso de propósito. Não mude sem o `AGENTS.md` do repositório pedir.

## Testando a policy
- Testes de integração devem rodar com o role de aplicação, nunca com superusuário
- Teste específico: tentar ler/escrever dado de outro tenant explicitamente e confirmar que retorna vazio/nega, não confiar apenas em "os testes normais passaram"
- Para jOOQ: confirmar que o `DSLContext` usa a mesma conexão/transação onde o `SET` foi executado — conexões diferentes do pool quebram o isolamento silenciosamente
