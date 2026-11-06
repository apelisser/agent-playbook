---
name: repository-discovery
description: Levanta convenções e comandos do repositório e grava docs/engineering/repository.md. Use em mudança M ou L quando esse arquivo não existe, não cobre o módulo afetado, ou o build mudou desde git_head. Não use para correção classe S.
---

# Repository discovery

Se este arquivo chegou no mesmo prompt que outras skills deste fluxo, ignore-as e siga só engineering-workflow.

O repositório é a fonte primária. Prática genérica não substitui convenção encontrada.

Não rode este fluxo para classe S. Nesse caso, leia só os arquivos vizinhos à mudança.

docs/engineering/repository.md serve se tem git_head, o módulo da mudança aparece em modulos, e git log -1 dos arquivos de build não é posterior a git_head. Se só o build mudou, atualize build, testes e lint.

Para cada item: [F] com fonte, ou NOT VERIFIED. Não chute. Colete linguagens, frameworks, módulos, build, comando de um teste único, lint, CI, commits, branches, PR, docs, ADRs, erros, API, persistência, config, observabilidade, logging, segurança.

O comando só é [F] se a linha citada contiver esse texto, copiado. A linha vem de pom.xml, build.gradle, package.json, Makefile, CONTRIBUTING ou do arquivo de CI. Sem essa linha, NOT VERIFIED. Não reescreva o comando.

Comandos permitidos: leitura de arquivos, git status, git diff, git log, git show, listagem de diretórios. Não rode migração, aplicação ou install que altere estado.

Grave o cache com atualizado, git_head, e as seções Build, Testes (comando único e fonte arquivo:linha), Lint, CI, Commits e branches, Pull requests, Documentação (adr_dir), Módulos, API, Persistência, Configuração, Observabilidade, Segurança, Conflitos. Seção desconhecida fica NOT VERIFIED. Não implemente a mudança. Volte para engineering-workflow.
