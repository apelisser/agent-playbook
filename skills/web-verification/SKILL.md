---
name: web-verification
description: Use quando implementar ou corrigir qualquer coisa numa aplicação web (UI, layout, estilo, rota, estado de cliente ou dado renderizado). Verificar o fluxo no browser antes de declarar a tarefa pronta.
---

# Verificação de aplicação web

Uma captura de tela do estado final não é verificação. Confirme o comportamento.

## Fluxo

1. Abra o app com as ferramentas de browser disponíveis e percorra a funcionalidade alterada como um usuário: clique, digite, envie, navegue.
2. Confira cada página e rota que compartilha o estado, o dado ou o componente alterado. Se a escrita ou a derivação do estado mudou, confira as outras superfícies que leem esse estado.
3. Procure regressão no entorno. O caso típico é a mudança funcionar isolada e quebrar um fluxo que já existia.
4. Cubra os caminhos e bordas que a mudança toca: vazio, erro, variantes de rota e de flag. Não pare no caminho feliz.
5. Se layout ou estilo mudou, verifique desktop e mobile quando a diferença importar.
6. Se achar um problema, corrija e verifique de novo. Não encerre com UI não verificada.

Se não houver ferramenta de browser, use o substituto mais próximo (teste, curl no servidor de desenvolvimento, script de render) e diga o que não foi possível verificar.
