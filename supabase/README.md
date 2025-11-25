# Supabase - Fork para Easy Panel

Este é um fork do Supabase configurado especificamente para deploy no Easy Panel (Hostinger).

## Origem
- Copiado de: https://github.com/supabase/supabase/tree/master/docker
- Modificações:
  - Removido `container_name` (compatibilidade Easy Panel)
  - Removido `ports` dos serviços internos
  - Adicionado `easypanel.yml` otimizado
  - Criado script de geração de secrets
  - Documentação de deploy completa

## Arquivos Importantes

- **`easypanel.yml`** - Configuração otimizada para Easy Panel
- **`code/docker-compose.yml`** - Arquivo original do Supabase
- **`code/generate-secrets.sh`** - Script para gerar secrets únicos
- **`code/.env.example`** - Exemplo de variáveis de ambiente
- **`DEPLOY-EASYPANEL.md`** - Guia completo de deploy

## Quick Start

### 1. Gerar Secrets

```bash
cd code
./generate-secrets.sh
```

### 2. Editar Configurações

Edite o arquivo `.env` gerado e configure:
- Seu domínio
- Configurações de SMTP
- Credenciais do dashboard

### 3. Deploy no Easy Panel

Siga o guia completo em [DEPLOY-EASYPANEL.md](./DEPLOY-EASYPANEL.md)

## Estrutura

```
supabase/
├── code/                          # Código fonte original
│   ├── docker-compose.yml         # Compose original
│   ├── .env.example              # Exemplo de variáveis
│   ├── generate-secrets.sh       # Gerador de secrets
│   └── volumes/                  # Volumes e configurações
├── easypanel.yml                 # Compose otimizado para Easy Panel
├── DEPLOY-EASYPANEL.md          # Guia de deploy
└── README.md                     # Este arquivo
```

## Variáveis de Ambiente Importantes

### Secrets (Gere novos valores!)
- `POSTGRES_PASSWORD` - Senha do banco de dados
- `JWT_SECRET` - Secret para tokens JWT
- `ANON_KEY` - Chave pública para API
- `SERVICE_ROLE_KEY` - Chave de admin
- `SECRET_KEY_BASE` - Secret para Realtime
- `VAULT_ENC_KEY` - Chave de encriptação

### Configuração
- `SITE_URL` - URL do seu site/app
- `API_EXTERNAL_URL` - URL da API
- `SUPABASE_PUBLIC_URL` - URL pública do Supabase
- `DASHBOARD_USERNAME` - Usuário do dashboard
- `DASHBOARD_PASSWORD` - Senha do dashboard

## Recursos

- [Documentação Oficial](https://supabase.com/docs)
- [Self-Hosting Guide](https://supabase.com/docs/guides/self-hosting)
- [Guia de Deploy Easy Panel](./DEPLOY-EASYPANEL.md)

## Segurança

⚠️ **IMPORTANTE**: Antes de fazer deploy em produção:

1. ✅ Gere novos secrets usando `generate-secrets.sh`
2. ✅ Nunca use as senhas do `.env.example` em produção
3. ✅ Configure HTTPS nos seus domínios
4. ✅ Mude o `DASHBOARD_USERNAME` e `DASHBOARD_PASSWORD`
5. ✅ Configure um SMTP confiável para emails
6. ✅ Não commite o arquivo `.env` com secrets reais

## Suporte

Para problemas ou dúvidas:
- Consulte [DEPLOY-EASYPANEL.md](./DEPLOY-EASYPANEL.md)
- Abra uma issue neste repositório
- Discord do Supabase: https://discord.supabase.com
