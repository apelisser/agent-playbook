---
name: otel-instrumentation
description: Padrões de instrumentação OpenTelemetry em Spring Boot (Micrometer bridge ou agent + annotations) e Grafana LGTM. Use when adding traces, metrics, logs, OTLP exporters, OpenTelemetryAppender, or RabbitMQ observation.
---

# OpenTelemetry em Spring Boot

`AGENTS.md` do projeto vence este skill. Dois padrões válidos — não misturar no mesmo repo:

1. **Micrometer Tracing bridge**: instrumentação via Micrometer, nunca OTel SDK direto. O Spring Boot já gerencia a versão do SDK via BOM; adicionar o SDK diretamente costuma causar conflito de versão.
2. **Agent + annotations**: só `opentelemetry-instrumentation-annotations` no Maven. SDK, starter e exporters ficam de fora; o agent é attached em runtime. Use quando o projeto proíbe SDK, starter ou exporter.

## Logs
`logback-spring.xml` com `OpenTelemetryAppender` — confirmar a versão do appender contra o BOM do Spring Boot antes de atualizar isoladamente. Conflito de versão entre appender e SDK gerenciado já quebrou build. Não adicionar appender/SDK se o projeto forçou o padrão agent.

## Endpoints OTLP
Configurar exporters separadamente para traces, métricas e logs. Não assumir que um único endpoint/collector aceita os três sem confirmar a config do collector (Grafana LGTM/Alloy). Com agent, o exporter é do agent, não da aplicação.

## RabbitMQ observability
Confirmar que a versão do starter do RabbitMQ suporta a observation API do Micrometer antes de simplesmente habilitar a propriedade — em versões antigas a propriedade existe mas não tem efeito.

## Docker Compose local
Stack local de referência (quando o projeto usa o padrão Micrometer): Grafana LGTM (Loki, Grafana, Tempo, Mimir) via Docker Compose, apontando os exporters da aplicação para o collector local durante desenvolvimento.
