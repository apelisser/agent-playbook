---
description: Exige nomes em inglês para arquivos, código e branches git.
alwaysApply: true
---

# Nomes em inglês

Arquivos, pastas, componentes, tipos, ids, rotas internas, testes, **branches git** e slugs de commit: **inglês**. Sem português nesses nomes.

```text
# errado
task/cadastros-ux
PlantFicha.tsx
src/cadastros/

# certo
task/records-ux
PlantRecordPage.tsx
src/records/
```

Texto que o **usuário vê** pode ser PT-BR — só na camada de cópia de interface do produto, nunca como nome de símbolo ou de branch.

Se um artefato (prompt, plan) pedir um nome em PT, use o equivalente em inglês e não copie o PT para git/código.
