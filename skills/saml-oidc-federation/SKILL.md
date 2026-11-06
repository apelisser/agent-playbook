---
name: saml-oidc-federation
description: Diagnóstico de falhas de login SSO com Keycloak, Authentik, Azure AD B2C, Kong e CDN. Use ao depurar SAML, OIDC, OAuth, cookies, redirect_uri, headers de proxy ou falhas de federação.
---

# Troubleshooting de federação SAML2/OIDC atrás de proxy/CDN

## Ordem de diagnóstico (do mais comum ao mais raro)

1. **Keycloak não reconhece HTTPS do proxy**
   Sintoma: redirect para `http://` em vez de `https://`, ou erro de "invalid redirect_uri".
   Fix: `KC_PROXY_HEADERS=xforwarded` (ou equivalente na versão em uso).

2. **Kong não propaga corretamente os headers de proxy**
   Sintoma: mesmo com Keycloak configurado, o header não chega correto.
   Fix: no plugin `request-transformer`, usar `add` **e** `replace` juntos para `X-Forwarded-Proto` e `X-Forwarded-Port` — só `add` não sobrescreve um header já existente vindo de upstream.

3. **Kong não confia no upstream**
   Fix: `KONG_TRUSTED_IPS=0.0.0.0/0` (ajustar o range para algo mais restrito que isso em produção — 0.0.0.0/0 é o valor usado para destravar o diagnóstico, não necessariamente o valor final recomendado).

4. **CDN na frente do gateway reescrevendo headers**
   Uma CDN pode injetar ou remover `X-Forwarded-*` antes do Kong. Confirmar com uma ferramenta de trace o que efetivamente chega em cada camada.

5. **Cookie `SameSite=Lax` bloqueando POST cross-site**
   Sintoma: sessão perdida ou "invalid state" logo após o IdP redirecionar de volta via POST (comum em SAML). É consequência dos itens acima (contexto HTTPS não reconhecido), não causa raiz isolada na maioria dos casos.

6. **Bug de validação de protocolo errado**
   Só suspeitar depois de descartar os itens acima. Exemplo real já encontrado: função de construção de URL de login aplicando validação de domínio OIDC a um domínio configurado como SAML2.

## Regra geral
SAML2 e OIDC não compartilham lógica de validação mesmo quando o mesmo IdP serve os dois. Nunca generalizar uma correção de um protocolo para o outro sem confirmar.

## Cache entre instâncias
Ambientes com Keycloak admin e Keycloak público separados podem ter cache dessincronizado — uma mudança aplicada via admin API pode não refletir imediatamente no endpoint público. Confirmar invalidação de cache antes de assumir que a config não foi aplicada.

## Documentação
Excluir referências a SAML2 em documentação pública quando o padrão do projeto for OIDC-only, e vice-versa.
