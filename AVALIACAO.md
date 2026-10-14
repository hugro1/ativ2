# Avaliação — GitHub Actions com IA

> Antes de entregar: substitua todos os campos `PREENCHER` por links reais das execuções/PRs e registre somente resultados que você realmente observou. Não coloque tokens, segredos ou seus valores neste arquivo.

## Tarefa 1 — CI a cada commit

- Execução verde: PREENCHER_LINK_RUN_VERDE
- Execução vermelha: PREENCHER_LINK_RUN_VERMELHA
- Linha do log que mostra o erro: PREENCHER
- Por que testar a migração em SQLite antes de chegar ao D1: o teste local encontra erros de sintaxe e incompatibilidades básicas do SQL antes de aplicar a alteração no banco remoto, reduzindo o risco de falhar ou afetar o banco usado pelo site.

## Tarefa 2 — Proteção da main

- PR bloqueado pelo status check: PREENCHER_LINK_PR_BLOQUEADO
- PR liberado depois da correção: PREENCHER_LINK_PR_LIBERADO
- Tentativa de push direto recusada (registro/execução): PREENCHER

## Tarefa 3 — Revisão de PR por IA

- PR com o primeiro comentário da IA: PREENCHER_LINK_PR
- Execução com erro após retirar `pull-requests: write`: PREENCHER_LINK_RUN_ERRO_PERMISSAO
- Afirmação incorreta ou irrelevante da IA e explicação: PREENCHER COM UM EXEMPLO REAL OBSERVADO. Não invente um resultado; aponte o comentário e explique por que o código/diff não sustenta a afirmação.

## Tarefa 4 — Migrações D1 depois do merge

- Execução do merge que aplicou a migração: PREENCHER_LINK_RUN_MIGRACAO
- Saída de `PRAGMA table_info(notas)`: PREENCHER
- Merge que não alterou `migrations/` e não disparou o workflow: PREENCHER_LINK_PR_OU_RUN

## Perguntas

### 1. Por que `ci.yml` roda duas vezes quando há um PR aberto, e qual execução conta para a proteção da `main`?

Ele roda uma vez pelo evento `push` quando os commits são enviados à branch e outra pelo evento `pull_request` quando o PR é aberto ou atualizado. Para a proteção da `main`, deve ser exigido o status check `verificar` associado à execução do PR; a regra deve ser confirmada na configuração de proteção do repositório.

### 2. Por que um PR de fork não consegue usar `secrets.COPILOT_PAT`? Qual ataque isso impede?

O GitHub não entrega os segredos do repositório de destino aos workflows comuns disparados por `pull_request` de um fork. Isso impede que código não confiável enviado por alguém de fora use o workflow para roubar o token ou gastar os privilégios associados a ele.

### 3. Por que declarar `permissions` em vez de usar as permissões padrão do `GITHUB_TOKEN`?

Declarar `permissions` aplica o princípio do menor privilégio: o workflow recebe somente os acessos necessários. Na revisão por IA, `contents: read` permite ler o código e `pull-requests: write` permite publicar o comentário; se a segunda permissão for removida, a publicação deve falhar por falta de autorização.

### 4. A revisão da IA pode substituir o status check da Tarefa 2?

Não. A revisão da IA é um auxílio que pode errar, deixar de perceber um problema ou apontar algo irrelevante, enquanto o status check do CI executa verificações automatizadas definidas no workflow. A observação real do item 4 da Tarefa 3 deve ser acrescentada aqui: PREENCHER COM A AFIRMAÇÃO OBSERVADA E O MOTIVO DE ESTAR ERRADA/IRRELEVANTE.

## Configuração necessária no GitHub

- Segredo `COPILOT_PAT`: token criado conforme as instruções da avaliação e com permissão Copilot Requests.
- Segredo `CLOUDFLARE_API_TOKEN`: token Cloudflare com permissão D1 Edit.
- Segredo `CLOUDFLARE_ACCOUNT_ID`: ID da conta Cloudflare.
- Variável `D1_DATABASE_NAME`: nome exato do banco D1 remoto.
- Em `Settings > Branches` ou `Settings > Rules > Rulesets`, proteger `main`, exigir PR e exigir o status check `verificar`.
