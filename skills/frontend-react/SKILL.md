---
name: frontend-react
description: Padrões de React/TypeScript em produção para estado, componentes, desempenho, acessibilidade, Vite/Next e integração com API. Use ao implementar ou revisar componentes, hooks, configuração Vite/Next ou busca de dados na UI.
---

# React / TypeScript (produção)

`AGENTS.md` do projeto vence este skill.

## Estado
- Estado de servidor (API) e estado de UI não compartilham o mesmo `useState`/reducer. Sem lib de data-fetching (TanStack Query, SWR), perguntar antes de reimplementar cache/retry.
- `useState` para estado local simples. Context só quando a hierarquia não resolve com 2 níveis de props.
- Não derivar estado de props com `useEffect` + `useState` se o cálculo no corpo do componente resolve.

## Componentes
- Passou de ~150–200 linhas ou mistura fetch + apresentação + validação → dividir.
- Props tipadas; sem `any` nem `object` genérico.
- Nome do arquivo = o que o componente renderiza, não a lib.

## Performance
- Sem `useMemo`/`useCallback`/`React.memo` sem render desnecessário medido.
- Lista grande: `key` estável (não índice, salvo lista estática).
- API duplicada em `useEffect` sem dependência estável: verificar isso antes de memoizar.

## Acessibilidade
- Clique em `div` é bug: usar `button`/`a`, ou `role` + teclado.
- Input sem `label` associado é bug.

## API
- Loading, erro e vazio explícitos.
- Erro para o usuário, não stack trace nem HTTP cru.

## Tooling
- Confirmar bundler (Vite, Next, CRA, Webpack) antes de sugerir config.
- Vite: `import.meta.env` + prefixo `VITE_`, não `process.env`.
- Alias `@/` precisa existir no bundler **e** em `tsconfig.json` `paths`.
