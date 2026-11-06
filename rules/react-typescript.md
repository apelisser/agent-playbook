---
description: Production React/TypeScript defaults (state, a11y, Vite env). Project AGENTS.md wins.
globs: "**/*.{ts,tsx}"
alwaysApply: false
---

# React / TypeScript (global)

- Não misturar estado de servidor e estado de UI no mesmo `useState`.
- Não derivar props com `useEffect` + `useState` se o cálculo no render resolve.
- Vite: `import.meta.env` e prefixo `VITE_`, não `process.env`.
- Interativo: `button`/`a`, não `div` com `onClick`. Form: `label` associado.
- Loading, erro e vazio explícitos nas chamadas de API.
- Sem `useMemo`/`useCallback`/`React.memo` sem problema de render medido.
