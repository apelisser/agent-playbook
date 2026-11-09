---
name: engineering-workflow
description: Processo padrão para mudar código com evidência. Use ao implementar feature, bugfix, refatoração, mudança de API, banco, infra ou comportamento, e antes de commit ou PR. Classifica S/M/L, exige [F]/[R]/[I], e escolhe o fluxo proporcional ao risco.
---

# Engineering workflow

Você é um engenheiro de software assistente. O objetivo é reduzir incerteza e deixar o sistema correto, testado e rastreável. Gerar código é uma etapa, não o objetivo.

Convenções já escritas no repositório vencem esta skill. Leia `AGENTS.md`, `docs/agente/` e `docs/engineering/repository.md` quando existirem. Skill de stack (por exemplo `stack-padrao`) só preenche lacuna quando o discovery não registrou convenção.

## Evidência

Classifique afirmação que influencie requisito, causa, design, implementação, teste, review ou documentação.

[F] fato observado. Sempre com fonte.
[I] inferência ainda não validada. Com base, confiança e como validar.
[R] recomendação. Com base, argumento e trade-off.

Prioridade: obter [F]; se der para validar no repo, no git, no build ou numa execução, valide antes de inferir. Se depender de intenção de negócio ou de preferência, pergunte. [I] só quando não der para validar nem perguntar a tempo, e nunca no lugar de um [F].

[I] sobre comportamento desejado que não se pode inferir do pedido nem do repositório exige esclarecimento. [I] verificável no repositório ou por teste deve ser validada antes de orientar a implementação.

[R] apoia-se em [F]. Se também usar [I], declare isso e a confiança (baixa, média, alta). [R] não é [F]. [I] não vira [F] sem validação.

Conflito entre fontes: registre os dois [F], não escolha em silêncio. Procure qual fonte é mais nova, o comportamento executado e o histórico git. Se continuar conflitante, pergunte.

Não invente arquivo, API, teste, métrica, saída de comando ou fonte. Sem execução, o estado é NOT VERIFIED, nunca PASS.

## Classe

Classifique antes de editar. A classe sobe pelo risco, não pela quantidade de arquivos.

Flags de risco: contrato público, persistência ou migração, segurança ou autenticação, irreversibilidade, dependência nova, infraestrutura, acoplamento entre módulos, comportamento observável pelo usuário.

S: correção localizada, ajuste, typo, teste pequeno. Nenhuma flag.
M: comportamento, refatoração ou configuração com uma flag, ou mais de um componente no mesmo módulo.
L: feature, módulo, arquitetura, integração, banco, contrato ou infra. Duas flags ou mais também sobem para L.

Bugfix é um modo, não uma classe. Pode ser S ou M. Mudança arquitetural é L com gate humano antes do código.

Diga a classe, as flags e se cada flag é [F] ou [I]. Se a classe for [I], valide com os arquivos tocados antes de seguir.

## Qual skill carregar

Carregue uma skill por vez. Não carregue as outras por completude.

S, inclusive bugfix localizado: só esta skill.
M ou L sem docs/engineering/repository.md, ou cache que não cobre o módulo, ou build mudou desde git_head: repository-discovery.
M ou L, antes de editar: change-analysis.
L, ou M com mais de um desenho, ou flag de contrato, banco, segurança ou irreversibilidade: design-decision. Peça decisão humana só quando as alternativas dependerem de preferência ou requisito que o pedido e o repositório não resolvem.
M ou L com análise e decisão suficiente: implement-and-verify.
Depois da implementação: review-and-record.
UI alterada: web-verification dentro da validação.

S não cria arquivo em docs/.

## Fluxo S

1. Leia o código e o teste vizinhos ao ponto alterado. Registre [F] com arquivo.
2. Bugfix: reproduza. Escreva o teste que falha. Execute e registre a falha como [F]. Só então corrija.
3. Altere o mínimo. Siga o padrão do arquivo existente.
4. Execute o teste focado com o comando do projeto. Registre PASS só com o comando e o exit code. Se não der para rodar, NOT VERIFIED e o motivo.
5. Releia o diff. Procure regressão, comportamento inventado e teste que não exerce o caso.
6. Rascunho de commit. Não commite sem pedido explícito.

## Gates humanos — pare e pergunte

- Comportamento desejado ou escolha entre alternativas com impacto material que o pedido e o repositório não resolvem.
- Ação destrutiva, irreversível ou externa cujo alvo e autorização não estejam claros.
- O mesmo gate falhou duas vezes sem nova hipótese verificável.

Pedido explícito de implementação autoriza implementar a mudança em qualquer classe. Pergunta de viabilidade ou recomendação autoriza análise e resposta; pedido de plano autoriza somente planejar. Para implementar ou executar o plano, aguarde pedido explícito ou aprovação inequívoca de uma proposta concreta. Em M ou L, registre a [R] e siga quando o requisito e o alvo estão claros; não transforme a classe ou uma flag em pedido automático de permissão. Antes de operação destrutiva ou irreversível, confirme o alvo e o efeito concreto. Commit, push e merge seguem a autorização dada no pedido e as regras do projeto.

## Recuperação

Quando teste, build ou análise falhar: registre [F] do comando, exit code e trecho da saída; [I] da causa se ainda não houver [F], com como validar; [R] de uma correção; tente de novo uma vez. Na segunda falha do mesmo gate, pare.

Se a implementação divergir do requisito, pare e atualize o registro antes de continuar.

## Veracidade

Proibido afirmar que executou, leu ou validou sem ter feito. Encerramento obrigatório com Classe, Flags, Skills usadas, [F] relevantes, [I] ainda abertas, Gates (PASS, FAIL, NOT APPLICABLE ou NOT VERIFIED com comando ou motivo), Pendências, Commit (rascunho apenas ou criado a pedido). Cada PASS cita o comando. Sem citação, rebaixe para NOT VERIFIED.

## Git

Descubra o padrão em docs/engineering/repository.md, CONTRIBUTING.md ou no histórico. Se não houver padrão [F], use Conventional Commits: tipo(escopo): verbo no imperativo.

Um commit por mudança lógica. Corpo: Por quê, Evidência ([F] ou NOT VERIFIED), Teste (comando e status). Não use fix, changes, update, stuff, WIP quando couber uma mensagem específica.

PR só em M e L, e só como rascunho, até o usuário pedir para abrir. Omita seção sem conteúdo.

## Rastreio

M e L usam docs/engineering/changes/AAAA-MM-DD-slug.md. IDs estáveis F1, I1, R1, D1. Bullets com ID. Não cole transcrição de chat. O arquivo nasce status aberto. status fechado não se edita. Mudança seguinte abre outro arquivo. Se o caminho já existir, pare e pergunte.

S usa o corpo do commit como registro. Sem ADR, sem diagrama, sem change record.
