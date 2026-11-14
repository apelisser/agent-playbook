---
name: stack-padrao
description: Padrões para serviços Java com Spring Boot, PostgreSQL, IAM, Kubernetes/Istio ou OpenTelemetry. Use quando o repositório adotar essa stack ou quando o usuário a pedir. Não use em repositório de outra stack. Se existir AGENTS.md ou docs/agente/, essas fontes vencem esta skill.
---

# Stack padrão

Aplique só neste tipo de repositório. `AGENTS.md` e `docs/agente/` do repo vencem este texto.

## Stack

- Java / Spring Boot
- DDD: bounded contexts e agregados
- Persistência híbrida: Spring Data JDBC para escrita de agregado. jOOQ só para leitura complexa, e só se o projeto já usa jOOQ. Não introduzir jOOQ onde não existe.
- PostgreSQL com RLS
- IAM: Keycloak, Authentik ou Azure AD B2C, e Kong
- Kubernetes / Istio
- OpenTelemetry

## Comandos na iteração

Rode um teste por vez: `./mvnw test -Dtest=NomeDaClasse`, ou o equivalente Gradle/npm do repo.

Não assuma Spotless nem Checkstyle. Confira no build se o projeto os usa.

## Código

- Nome de repositório revela intenção de domínio: `findAllBlockedEmails`, não `findByBlockedTrue`.
- Side-effect que não é óbvio (soft-delete, cache) leva Javadoc no método.
- `@Transactional` nunca em classe base abstrata sem revisar o escopo da conexão. A transação não pode abrir conexão enquanto há I/O externo ou SMTP.

## RLS

Policy na tabela, não só `WHERE` na aplicação. Teste com o role de aplicação, não com superusuário.

O nome do GUC é o do projeto. Um default comum é `app.tenant_id`. Confirme no repositório antes de escrever policy, teste ou `SET`.

Antes de escrever policy, teste de RLS ou GUC, leia a skill `postgres-rls` se ela estiver disponível. Se não estiver, siga só este trecho e diga que a skill não foi encontrada.

## IAM

SAML e OIDC não compartilham validação. Cookie ou redirect cross-site: olhar headers de proxy primeiro.

Não documente SAML2 se o projeto for só OIDC.

Antes de mexer em federação, leia a skill `saml-oidc-federation` se ela estiver disponível. Se não estiver, siga só este trecho e diga que a skill não foi encontrada.

## OpenTelemetry

Default: bridge Micrometer Tracing, não o SDK direto.

Se o projeto proíbe SDK, starter ou exporter, use só annotations e o agent.

Antes de instrumentar, leia a skill `otel-instrumentation` se ela estiver disponível. Se não estiver, siga só este trecho e diga que a skill não foi encontrada.

## Subagentes

Delegue só se o subagente estiver na lista de subagentes disponíveis nesta sessão. Sem o arquivo, faça o trabalho no agente principal.

| Escopo | Subagente |
| --- | --- |
| Desenho Java / DDD / Spring | `java-architect` |
| JDBC, jOOQ, schema, RLS | `persistence-specialist` |
| SAML, OIDC, Kong | `iam-federation-specialist` |
| Kubernetes / Istio | `k8s-istio-specialist` |
| OpenTelemetry | `observability-engineer` |
| Revisão de segurança do diff | `security-reviewer` |
| Revisão de código | `code-reviewer` |
| UI React | `frontend-react-specialist` |

Os subagentes globais vêm de `agents/<nome>.md` deste playbook, instalados no diretório de agentes da ferramenta. Subagente do repositório com o mesmo nome vence o global.
