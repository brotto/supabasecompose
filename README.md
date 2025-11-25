# Easypanel Compose - Supabase para Easy Panel

Este repositório contém a configuração do **Supabase** otimizada para deploy no **Easy Panel** (Hostinger).

## 🚀 Quick Start

### Para Supabase no Easy Panel:

1. **Clone este repositório:**
   ```bash
   git clone https://github.com/brotto/supabasecompose.git
   cd supabasecompose/supabase/code
   ```

2. **Execute o script de configuração:**
   ```bash
   ./setup-for-easypanel.sh
   ```

3. **Siga o guia de deploy:**
   - Abra: [supabase/DEPLOY-EASYPANEL.md](./supabase/DEPLOY-EASYPANEL.md)
   - Ou acesse online: [GitHub - brotto/supabasecompose](https://github.com/brotto/supabasecompose)

## 📁 Estrutura do Repositório

```
supabasecompose/
├── supabase/                          # ⭐ Configuração Supabase
│   ├── code/
│   │   ├── docker-compose.yml        # Compose original
│   │   ├── generate-secrets.sh       # Gerador de secrets
│   │   ├── setup-for-easypanel.sh   # Setup automático
│   │   ├── .env.example             # Exemplo de variáveis
│   │   └── volumes/                 # Volumes e configs
│   ├── easypanel.yml                # Compose otimizado Easy Panel
│   ├── DEPLOY-EASYPANEL.md         # 📖 Guia completo de deploy
│   ├── EASYPANEL-ENV-TEMPLATE.txt  # Template de variáveis
│   └── README.md
├── appwrite/                         # Outras aplicações
├── dify/
├── plane/
├── twenty/
└── README.md                         # Este arquivo
```

## 🎯 Foco: Supabase

Este repositório foi configurado especialmente para o **Supabase**. A pasta `supabase/` contém:

- ✅ Configuração otimizada para Easy Panel
- ✅ Scripts de geração automática de secrets
- ✅ Guia completo de deploy passo a passo
- ✅ Template de variáveis de ambiente
- ✅ Segurança aprimorada (gitignore para .env)

## 📖 Documentação

### Guia Completo de Deploy
**→ [supabase/DEPLOY-EASYPANEL.md](./supabase/DEPLOY-EASYPANEL.md)**

Este guia contém:
- Passo a passo detalhado
- Configuração de variáveis de ambiente
- Configuração de domínios
- Troubleshooting completo
- Checklist de segurança

### Template de Variáveis
**→ [supabase/EASYPANEL-ENV-TEMPLATE.txt](./supabase/EASYPANEL-ENV-TEMPLATE.txt)**

Template pronto para copiar/colar no Easy Panel.

## ⚡ Início Rápido (TL;DR)

```bash
# 1. Gerar secrets
cd supabase/code
./setup-for-easypanel.sh

# 2. Revisar configurações
nano .env

# 3. Fazer deploy no Easy Panel
# - Conecte seu repositório GitHub
# - Configure variáveis de ambiente (copie do .env)
# - Use o arquivo: supabase/easypanel.yml
# - Configure domínios e deploy!
```

## 🔒 Segurança

⚠️ **IMPORTANTE:**

- ✅ **SEMPRE** gere novos secrets antes do deploy
- ✅ **NUNCA** use senhas do `.env.example` em produção
- ✅ **NÃO** commite arquivos `.env` com secrets reais
- ✅ Configure HTTPS nos domínios (automático no Easy Panel)
- ✅ Use senhas fortes para dashboard e PostgreSQL

## 🛠️ Scripts Disponíveis

### `generate-secrets.sh`
Gera todos os secrets necessários automaticamente:
- Senhas do PostgreSQL
- JWT secrets
- Tokens de API (ANON_KEY, SERVICE_ROLE_KEY)
- Chaves de encriptação

### `setup-for-easypanel.sh`
Script interativo completo que:
- Gera secrets
- Configura domínio
- Configura credenciais do dashboard
- Configura SMTP (opcional)
- Exibe próximos passos

## 🌐 Domínios Recomendados

Configure dois subdomínios no Easy Panel:

- **API**: `api.seu-dominio.com` → porta 8000
- **Dashboard**: `studio.seu-dominio.com` → porta 3000

## 📋 Requisitos

### Servidor (Easy Panel na Hostinger)
- **CPU**: 2-4 vCPU
- **RAM**: 4-8 GB
- **Disco**: 20+ GB SSD
- **Rede**: Boa latência

### Ferramentas Locais
- Git
- Bash (Linux/Mac) ou WSL (Windows)
- Editor de texto

### Serviços Externos (Recomendado)
- **SMTP**: Resend, SendGrid, ou Amazon SES
- **Domínio**: Seu domínio próprio

## 🐛 Troubleshooting

Consulte a seção de Troubleshooting no guia completo:
**→ [supabase/DEPLOY-EASYPANEL.md#troubleshooting](./supabase/DEPLOY-EASYPANEL.md#troubleshooting)**

Problemas comuns:
- Containers não iniciam → Verifique variáveis de ambiente
- JWT errors → Regere secrets
- Database não conecta → Verifique POSTGRES_PASSWORD
- SMTP não funciona → Teste credenciais externamente

## 📚 Recursos

- [Documentação Oficial Supabase](https://supabase.com/docs)
- [Self-Hosting Guide](https://supabase.com/docs/guides/self-hosting)
- [Easy Panel Docs](https://easypanel.io/docs)
- [Supabase Discord](https://discord.supabase.com)

## 🤝 Contribuindo

Este é um fork pessoal para uso no Easy Panel. Sinta-se livre para:
- Fazer fork deste repositório
- Abrir issues para problemas
- Sugerir melhorias
- Adaptar para seu uso

## 📄 Licença

Este projeto segue a licença do Supabase original.

---

## ⚠️ Outras Aplicações

Este repositório também contém outras aplicações (appwrite, dify, plane, twenty) que não foram configuradas para Easy Panel. O foco deste setup é exclusivamente o **Supabase**.

---

**Criado com ❤️ para deploy fácil no Easy Panel da Hostinger**
