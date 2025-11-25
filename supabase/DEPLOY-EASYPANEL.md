# Guia de Deploy do Supabase no Easy Panel (Hostinger)

Este guia irá te ajudar a fazer o deploy do seu fork do Supabase no Easy Panel hospedado na Hostinger.

## 📋 Pré-requisitos

1. Acesso ao Easy Panel na Hostinger
2. Fork do repositório Supabase no seu GitHub
3. Domínio configurado (opcional, mas recomendado)

## 🔧 Passo 1: Preparar o Repositório

### 1.1 Gerar Secrets Únicos

Antes de fazer o deploy, você precisa gerar secrets únicos. Execute localmente:

```bash
cd supabase/code
./generate-secrets.sh
```

Este script irá criar um arquivo `.env` com todos os secrets necessários.

### 1.2 Editar Variáveis Importantes

Abra o arquivo `.env` gerado e **EDITE** as seguintes variáveis:

```env
# Substitua pelo seu domínio real
SITE_URL=https://seu-dominio.com
API_EXTERNAL_URL=https://seu-dominio.com
SUPABASE_PUBLIC_URL=https://seu-dominio.com

# Configure seu SMTP (recomendado usar Resend, SendGrid, etc)
SMTP_ADMIN_EMAIL=seu-email@dominio.com
SMTP_HOST=smtp.resend.com
SMTP_PORT=587
SMTP_USER=seu_usuario
SMTP_PASS=sua_senha
SMTP_SENDER_NAME=Sua Aplicação

# Credenciais do Dashboard
DASHBOARD_USERNAME=seu_usuario_admin
DASHBOARD_PASSWORD=sua_senha_forte
```

### 1.3 Commit e Push

```bash
# A partir do diretório raiz do repositório
cd /Users/alebrotto/Library/CloudStorage/OneDrive-Pessoal/Supabase/supabasecompose

# Adicionar todos os novos arquivos (exceto .env que está no .gitignore)
git add supabase/
git add README.md

# Commit
git commit -m "Configure Supabase for Easy Panel deployment"

# Push para o GitHub
git push origin main
```

**⚠️ IMPORTANTE:** O arquivo `.env` contém secrets. Se você não quer commitá-lo:
- Adicione `.env` ao `.gitignore`
- Configure as variáveis manualmente no Easy Panel (Passo 2.3)

---

## 🚀 Passo 2: Configurar no Easy Panel

### 2.1 Acessar Easy Panel

1. Faça login no seu Easy Panel na Hostinger
2. Vá para a seção de **Projetos** ou **Projects**

### 2.2 Criar Novo Projeto

1. Clique em **New Project** ou **Novo Projeto**
2. Escolha **Deploy from Git**
3. Conecte sua conta do GitHub (se ainda não estiver conectada)
4. Selecione o repositório do seu fork: `seu-usuario/supabasecompose`
5. Defina o **Branch**: `main` (ou o branch que você está usando)
6. Defina o **Path**: `/supabase` (caminho para a pasta do Supabase)

### 2.3 Configurar Variáveis de Ambiente

No Easy Panel, vá para a aba **Environment Variables** e adicione TODAS as variáveis do seu arquivo `.env`:

**Secrets (OBRIGATÓRIO - use os valores gerados):**
```
POSTGRES_PASSWORD=<valor_do_seu_.env>
JWT_SECRET=<valor_do_seu_.env>
ANON_KEY=<valor_do_seu_.env>
SERVICE_ROLE_KEY=<valor_do_seu_.env>
SECRET_KEY_BASE=<valor_do_seu_.env>
VAULT_ENC_KEY=<valor_do_seu_.env>
LOGFLARE_API_KEY=<valor_do_seu_.env>
LOGFLARE_LOGGER_BACKEND_API_KEY=<valor_do_seu_.env>
```

**Configuração de Database:**
```
POSTGRES_HOST=db
POSTGRES_DB=postgres
POSTGRES_PORT=5432
```

**Configuração de Auth:**
```
SITE_URL=https://seu-dominio.com
API_EXTERNAL_URL=https://seu-dominio.com
SUPABASE_PUBLIC_URL=https://seu-dominio.com
JWT_EXPIRY=3600
DISABLE_SIGNUP=false
ENABLE_EMAIL_SIGNUP=true
ENABLE_EMAIL_AUTOCONFIRM=false
ENABLE_ANONYMOUS_USERS=false
ENABLE_PHONE_SIGNUP=false
ENABLE_PHONE_AUTOCONFIRM=false
```

**Configuração de SMTP:**
```
SMTP_ADMIN_EMAIL=seu-email@dominio.com
SMTP_HOST=smtp.resend.com
SMTP_PORT=587
SMTP_USER=seu_usuario
SMTP_PASS=sua_senha
SMTP_SENDER_NAME=Sua Aplicação
MAILER_URLPATHS_CONFIRMATION=/auth/v1/verify
MAILER_URLPATHS_INVITE=/auth/v1/verify
MAILER_URLPATHS_RECOVERY=/auth/v1/verify
MAILER_URLPATHS_EMAIL_CHANGE=/auth/v1/verify
```

**Configuração de Dashboard:**
```
DASHBOARD_USERNAME=seu_usuario_admin
DASHBOARD_PASSWORD=sua_senha_forte
STUDIO_DEFAULT_ORGANIZATION=Minha Organização
STUDIO_DEFAULT_PROJECT=Meu Projeto
STUDIO_PORT=3000
```

**Configurações Adicionais:**
```
PGRST_DB_SCHEMAS=public,storage,graphql_public
KONG_HTTP_PORT=8000
KONG_HTTPS_PORT=8443
POOLER_TENANT_ID=supabase-tenant
POOLER_DEFAULT_POOL_SIZE=20
POOLER_MAX_CLIENT_CONN=100
POOLER_PROXY_PORT_TRANSACTION=6543
FUNCTIONS_VERIFY_JWT=false
IMGPROXY_ENABLE_WEBP_DETECTION=true
DOCKER_SOCKET_LOCATION=/var/run/docker.sock
```

### 2.4 Selecionar Arquivo Docker Compose

1. No Easy Panel, vá para a configuração do projeto
2. Em **Docker Compose File**, especifique: `easypanel.yml`
   - Se preferir usar o arquivo original: `code/docker-compose.yml`

### 2.5 Configurar Domínios

1. Vá para a aba **Domains** no Easy Panel
2. Adicione seu domínio personalizado
3. Configure os seguintes serviços:
   - **Studio (Dashboard)**: `studio.seu-dominio.com` → porta `3000`
   - **API (Kong)**: `api.seu-dominio.com` → porta `8000`

Ou use um único domínio com reverse proxy:
   - `seu-dominio.com` → porta `8000` (API)
   - `seu-dominio.com/studio` → porta `3000` (Studio)

### 2.6 Configurar Volumes (Persistência de Dados)

O Easy Panel geralmente cria volumes automaticamente, mas verifique se os seguintes volumes estão configurados:

- `db-data` - Dados do PostgreSQL
- `storage-data` - Arquivos do Storage
- `db-config` - Configurações do banco

### 2.7 Deploy!

1. Clique em **Deploy** ou **Implantar**
2. Aguarde o processo de build e deploy
3. Monitore os logs para verificar se há erros

---

## 🔍 Passo 3: Verificar o Deploy

### 3.1 Verificar Serviços

Aguarde alguns minutos e verifique se todos os serviços estão rodando:

1. No Easy Panel, vá para a aba **Services**
2. Verifique se todos os containers estão com status **Running** (verde):
   - db
   - auth
   - rest
   - realtime
   - storage
   - kong
   - studio
   - analytics
   - vector
   - meta
   - functions
   - supavisor
   - imgproxy

### 3.2 Acessar o Dashboard

1. Acesse: `https://studio.seu-dominio.com` (ou o domínio que você configurou)
2. Faça login com:
   - **Username**: Valor de `DASHBOARD_USERNAME`
   - **Password**: Valor de `DASHBOARD_PASSWORD`

### 3.3 Testar a API

Teste se a API está respondendo:

```bash
curl https://api.seu-dominio.com/rest/v1/
```

Deve retornar uma resposta JSON.

---

## 🐛 Troubleshooting (Solução de Problemas)

### Problema: Containers não iniciam

**Solução:**
1. Verifique os logs de cada container no Easy Panel
2. Verifique se todas as variáveis de ambiente estão configuradas corretamente
3. Certifique-se de que os secrets foram gerados corretamente

### Problema: Erro "JWT secret is invalid"

**Solução:**
1. Verifique se `JWT_SECRET`, `ANON_KEY` e `SERVICE_ROLE_KEY` estão corretos
2. Regere os tokens usando o script `generate-secrets.sh`
3. Atualize as variáveis no Easy Panel

### Problema: Database não conecta

**Solução:**
1. Verifique se `POSTGRES_PASSWORD` está configurado
2. Verifique os logs do container `db`
3. Certifique-se de que o volume `db-data` está persistido

### Problema: SMTP não envia emails

**Solução:**
1. Verifique as configurações de SMTP
2. Teste suas credenciais SMTP externamente
3. Verifique se a porta SMTP está aberta na Hostinger
4. Considere usar serviços como:
   - **Resend** (recomendado, 100 emails grátis/dia)
   - **SendGrid** (100 emails grátis/dia)
   - **Amazon SES**

### Problema: "Cannot connect to Docker socket"

**Solução:**
1. Verifique se `DOCKER_SOCKET_LOCATION=/var/run/docker.sock` está configurado
2. Isso é necessário para o container `vector`
3. Se o Easy Panel não permitir, você pode desabilitar o serviço `vector` temporariamente

### Problema: Erro de permissão em volumes

**Solução:**
1. No Easy Panel, vá para **Volumes**
2. Recrie os volumes se necessário
3. Reinicie os containers

---

## 🔒 Segurança

### Checklist de Segurança

- [ ] **Trocar TODAS as senhas padrão** do `.env.example`
- [ ] **Gerar novos JWT secrets** usando o script `generate-secrets.sh`
- [ ] **Configurar HTTPS** nos domínios (Let's Encrypt automático no Easy Panel)
- [ ] **Mudar `DASHBOARD_USERNAME` e `DASHBOARD_PASSWORD`**
- [ ] **Não commitar o arquivo `.env` com secrets** no Git público
- [ ] **Configurar `DISABLE_SIGNUP=true`** se você não quer registro público
- [ ] **Usar senha forte** para PostgreSQL (`POSTGRES_PASSWORD`)
- [ ] **Habilitar firewall** para limitar acesso ao database (se possível)
- [ ] **Manter as imagens Docker atualizadas**

---

## 📊 Recursos e Limites

### Recursos Recomendados na Hostinger:

- **CPU**: Mínimo 2 vCPU (recomendado 4 vCPU)
- **RAM**: Mínimo 4 GB (recomendado 8 GB)
- **Disco**: Mínimo 20 GB SSD (crescerá conforme uso)
- **Rede**: Boa latência e largura de banda

### Limites Configurados:

- **File Upload**: 50 MB (ajuste `FILE_SIZE_LIMIT` no storage)
- **JWT Expiry**: 1 hora (3600s)
- **DB Pool Size**: 20 conexões (ajuste `POOLER_DEFAULT_POOL_SIZE`)
- **Max Connections**: 100 (ajuste `POOLER_MAX_CLIENT_CONN`)

---

## 🔄 Atualizações Futuras

Para atualizar o Supabase no futuro:

1. Faça pull das últimas mudanças do repositório original
2. Atualize as versões das imagens no `easypanel.yml` ou `docker-compose.yml`
3. Commit e push para o seu fork
4. No Easy Panel, clique em **Redeploy**

---

## 📚 Recursos Adicionais

- [Documentação Oficial do Supabase](https://supabase.com/docs)
- [Self-Hosting Guide](https://supabase.com/docs/guides/self-hosting)
- [Easy Panel Docs](https://easypanel.io/docs)
- [Supabase GitHub](https://github.com/supabase/supabase)

---

## 🆘 Suporte

Se você encontrar problemas:

1. **Verifique os logs** no Easy Panel
2. **Consulte este guia** na seção Troubleshooting
3. **GitHub Issues**: Abra uma issue no seu repositório
4. **Supabase Discord**: [discord.supabase.com](https://discord.supabase.com)

---

## ✅ Checklist Final

Antes de considerar o deploy completo:

- [ ] Todos os containers estão rodando (verde no Easy Panel)
- [ ] Dashboard acessível e login funcionando
- [ ] API respondendo corretamente
- [ ] Variáveis de ambiente configuradas
- [ ] Domínios configurados e acessíveis via HTTPS
- [ ] Backup do arquivo `.env` em local seguro
- [ ] SMTP testado e funcionando
- [ ] Volumes persistentes configurados
- [ ] Senhas padrão alteradas

---

**Parabéns! 🎉 Seu Supabase está pronto para uso!**
