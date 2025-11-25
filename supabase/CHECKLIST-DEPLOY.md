# ✅ Checklist de Deploy - Supabase no Easy Panel

Use este checklist para garantir que você não esqueça nenhum passo importante.

---

## 📋 PRÉ-DEPLOY (Local)

### Geração de Secrets
- [ ] Executei `cd supabase/code`
- [ ] Executei `./setup-for-easypanel.sh` OU `./generate-secrets.sh`
- [ ] Arquivo `.env` foi criado com sucesso
- [ ] Verifiquei que todos os secrets foram gerados (não estão vazios)

### Configuração de Variáveis
- [ ] Editei `SITE_URL` com meu domínio real
- [ ] Editei `API_EXTERNAL_URL` com meu domínio real
- [ ] Editei `SUPABASE_PUBLIC_URL` com meu domínio real
- [ ] Alterei `DASHBOARD_USERNAME` (não usar "admin")
- [ ] Defini senha forte para `DASHBOARD_PASSWORD` (mín. 16 caracteres)
- [ ] Configurei SMTP (host, porta, usuário, senha)
- [ ] Defini `SMTP_ADMIN_EMAIL` com email válido

### Segurança
- [ ] `POSTGRES_PASSWORD` é único e forte (gerado automaticamente)
- [ ] `JWT_SECRET` é único e forte (gerado automaticamente)
- [ ] Não estou usando nenhuma senha do `.env.example`
- [ ] Arquivo `.env` NÃO foi commitado no Git (está no .gitignore)
- [ ] Fiz backup do arquivo `.env` em local seguro

### Git (Opcional)
- [ ] Commitei os novos arquivos de configuração (exceto .env)
- [ ] Fiz push para o GitHub
- [ ] Repositório está acessível para o Easy Panel

---

## 🚀 DEPLOY NO EASY PANEL

### Configuração Inicial
- [ ] Acessei o Easy Panel na Hostinger
- [ ] Criei novo projeto
- [ ] Selecionei "Deploy from Git"
- [ ] Conectei minha conta do GitHub
- [ ] Selecionei o repositório correto
- [ ] Defini o branch correto (main/master)
- [ ] Defini o path: `/supabase` ou deixei vazio

### Arquivo Docker Compose
- [ ] Especifiquei o arquivo: `easypanel.yml` (ou `code/docker-compose.yml`)
- [ ] Verifiquei se o path está correto

### Variáveis de Ambiente
- [ ] Abri a aba "Environment Variables"
- [ ] Copiei TODAS as variáveis do meu arquivo `.env` local
- [ ] Colei no Easy Panel (modo Bulk Edit recomendado)
- [ ] Verifiquei cada variável importante:
  - [ ] `POSTGRES_PASSWORD`
  - [ ] `JWT_SECRET`
  - [ ] `ANON_KEY`
  - [ ] `SERVICE_ROLE_KEY`
  - [ ] `SECRET_KEY_BASE`
  - [ ] `VAULT_ENC_KEY`
  - [ ] `SITE_URL`
  - [ ] `API_EXTERNAL_URL`
  - [ ] `SUPABASE_PUBLIC_URL`
  - [ ] `DASHBOARD_USERNAME`
  - [ ] `DASHBOARD_PASSWORD`
  - [ ] Configurações de SMTP

### Configuração de Domínios
- [ ] Adicionei domínio para API: `api.meudominio.com` → porta 8000
- [ ] Adicionei domínio para Studio: `studio.meudominio.com` → porta 3000
- [ ] Verifiquei que os domínios apontam para o servidor (DNS)
- [ ] Habilitei HTTPS/SSL (Let's Encrypt automático)

### Volumes (Persistência)
- [ ] Verifiquei que os volumes estão configurados:
  - [ ] `db-data` - Dados do PostgreSQL
  - [ ] `storage-data` - Arquivos do Storage
  - [ ] `db-config` - Configurações do banco

### Deploy
- [ ] Cliquei em "Deploy" ou "Create"
- [ ] Aguardei o processo de build iniciar

---

## 🔍 PÓS-DEPLOY (Verificação)

### Status dos Serviços
- [ ] Todos os containers estão com status "Running" (verde):
  - [ ] db
  - [ ] vector
  - [ ] analytics
  - [ ] kong
  - [ ] auth
  - [ ] rest
  - [ ] realtime
  - [ ] storage
  - [ ] imgproxy
  - [ ] meta
  - [ ] functions
  - [ ] studio
  - [ ] supavisor

### Acesso ao Dashboard
- [ ] Acessei `https://studio.meudominio.com`
- [ ] Login funcionou com minhas credenciais
- [ ] Dashboard carregou corretamente
- [ ] Consigo ver o projeto padrão

### Teste da API
- [ ] Testei a API: `curl https://api.meudominio.com/rest/v1/`
- [ ] Recebi resposta JSON válida
- [ ] Não houve erros 500 ou 404

### Banco de Dados
- [ ] Consigo acessar o SQL Editor no Studio
- [ ] Consigo criar uma tabela de teste
- [ ] Consigo inserir dados
- [ ] Consigo fazer queries

### Storage
- [ ] Consigo criar um bucket de teste
- [ ] Consigo fazer upload de arquivo
- [ ] Consigo visualizar o arquivo
- [ ] URL pública funciona (se configurado)

### Autenticação
- [ ] Configurei email templates (opcional)
- [ ] Testei registro de usuário (se `DISABLE_SIGNUP=false`)
- [ ] Recebi email de confirmação (se SMTP configurado)
- [ ] Login de usuário funciona

---

## 🔧 CONFIGURAÇÃO ADICIONAL

### SMTP (Email)
- [ ] Testei envio de email de teste
- [ ] Email de confirmação chega na caixa de entrada (não spam)
- [ ] Email de recuperação de senha funciona
- [ ] Templates de email estão personalizados (opcional)

### Segurança Adicional
- [ ] Revisei regras de RLS (Row Level Security) no banco
- [ ] Configurei políticas de acesso adequadas
- [ ] Revisei `DISABLE_SIGNUP` (true para produção restrita)
- [ ] Configurei rate limiting (se disponível no Easy Panel)
- [ ] Revisei configurações de CORS (se necessário)

### Backup
- [ ] Configurei backup automático dos volumes (se disponível)
- [ ] Documentei onde estão os volumes persistentes
- [ ] Criei snapshot inicial (se disponível no Easy Panel)
- [ ] Salvei arquivo `.env` em local seguro (cofre de senhas)

### Monitoramento
- [ ] Configurei alertas de down time (se disponível)
- [ ] Verifiquei logs de cada serviço (sem erros críticos)
- [ ] Configurei monitoramento de recursos (CPU, RAM)

---

## 📊 MÉTRICAS E OTIMIZAÇÃO

### Performance
- [ ] Tempo de resposta da API está aceitável (< 500ms)
- [ ] Dashboard carrega rápido (< 3s)
- [ ] Upload de arquivos funciona corretamente
- [ ] Queries no banco estão performando bem

### Recursos
- [ ] Uso de CPU está dentro do esperado (< 70%)
- [ ] Uso de RAM está dentro do esperado (< 80%)
- [ ] Disco tem espaço suficiente (> 5 GB livre)
- [ ] Sem containers em restart loop

### Ajustes (Se Necessário)
- [ ] Aumentei `POOLER_DEFAULT_POOL_SIZE` se necessário
- [ ] Aumentei `POOLER_MAX_CLIENT_CONN` se necessário
- [ ] Ajustei `FILE_SIZE_LIMIT` para uploads maiores
- [ ] Otimizei índices do banco de dados

---

## 📚 DOCUMENTAÇÃO

### Interno
- [ ] Documentei credenciais de acesso (em local seguro)
- [ ] Documentei URLs de acesso
- [ ] Documentei estrutura do banco
- [ ] Criei guia interno para equipe (se aplicável)

### Usuários Finais (Se Aplicável)
- [ ] Criei documentação de API
- [ ] Documentei endpoints disponíveis
- [ ] Criei exemplos de uso
- [ ] Configurei Swagger/OpenAPI (opcional)

---

## 🆘 TROUBLESHOOTING

Se algo não funcionou, verifique:

- [ ] Revisei todos os logs no Easy Panel
- [ ] Consultei a seção Troubleshooting do [DEPLOY-EASYPANEL.md](./DEPLOY-EASYPANEL.md)
- [ ] Verifiquei se todas as variáveis de ambiente estão corretas
- [ ] Testei conectividade de rede
- [ ] Verifiquei se os domínios estão resolvendo (DNS)
- [ ] Verifiquei se HTTPS está funcionando
- [ ] Reiniciei os containers problemáticos

---

## ✅ FINALIZAÇÃO

- [ ] **Tudo funcionando perfeitamente!**
- [ ] Todos os serviços estão rodando
- [ ] Testes básicos passaram
- [ ] Segurança configurada
- [ ] Backup configurado
- [ ] Documentação criada
- [ ] Equipe informada (se aplicável)

---

## 🎉 PARABÉNS!

Se você marcou todos os itens acima, seu Supabase está pronto para uso em produção!

### Próximos Passos:
1. Comece a desenvolver sua aplicação
2. Configure RLS (Row Level Security) nas tabelas
3. Implemente políticas de acesso
4. Configure webhooks (se necessário)
5. Monitore regularmente

---

## 📞 Suporte

Se precisar de ajuda:
- Consulte: [DEPLOY-EASYPANEL.md](./DEPLOY-EASYPANEL.md)
- Discord Supabase: https://discord.supabase.com
- Documentação: https://supabase.com/docs

---

**Data do Deploy:** __________

**Responsável:** __________

**Domínios:**
- API: __________
- Studio: __________

**Notas Adicionais:**
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
