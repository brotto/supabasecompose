#!/bin/bash

# Script para gerar secrets seguros para o Supabase
# Execute este script para criar novas variáveis de ambiente

echo "🔐 Gerando secrets para Supabase..."
echo ""

# Função para gerar string aleatória
generate_secret() {
    openssl rand -base64 $1 | tr -d "=+/" | cut -c1-$1
}

# Função para gerar JWT
generate_jwt() {
    local secret=$1
    local role=$2
    local header='{"alg":"HS256","typ":"JWT"}'
    local iat=$(date +%s)
    local exp=$((iat + 315360000)) # 10 anos
    local payload="{\"role\":\"$role\",\"iss\":\"supabase\",\"iat\":$iat,\"exp\":$exp}"

    # Usar jq e openssl para gerar JWT
    echo -n "$header" | base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n' > /tmp/jwt_header
    echo -n "$payload" | base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n' > /tmp/jwt_payload

    local unsigned_token=$(cat /tmp/jwt_header).$(cat /tmp/jwt_payload)
    local signature=$(echo -n "$unsigned_token" | openssl dgst -sha256 -hmac "$secret" -binary | base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n')

    echo "$unsigned_token.$signature"
    rm /tmp/jwt_header /tmp/jwt_payload
}

# Gerar secrets
POSTGRES_PASSWORD=$(generate_secret 48)
JWT_SECRET=$(generate_secret 64)
SECRET_KEY_BASE=$(generate_secret 48)
VAULT_ENC_KEY=$(generate_secret 48)
LOGFLARE_LOGGER_BACKEND_API_KEY=$(generate_secret 64)
LOGFLARE_API_KEY=$(generate_secret 64)

# Gerar JWTs
echo "📝 Gerando JWT tokens..."
ANON_KEY=$(generate_jwt "$JWT_SECRET" "anon")
SERVICE_ROLE_KEY=$(generate_jwt "$JWT_SECRET" "service_role")

# Criar arquivo .env
cat > .env << EOF
############
# Secrets
# GERADO AUTOMATICAMENTE - $(date)
############

POSTGRES_PASSWORD=$POSTGRES_PASSWORD
JWT_SECRET=$JWT_SECRET
ANON_KEY=$ANON_KEY
SERVICE_ROLE_KEY=$SERVICE_ROLE_KEY
DASHBOARD_USERNAME=admin
DASHBOARD_PASSWORD=$(generate_secret 24)
SECRET_KEY_BASE=$SECRET_KEY_BASE
VAULT_ENC_KEY=$VAULT_ENC_KEY


############
# Database
############

POSTGRES_HOST=db
POSTGRES_DB=postgres
POSTGRES_PORT=5432


############
# Supavisor -- Database pooler
############
POOLER_PROXY_PORT_TRANSACTION=6543
POOLER_DEFAULT_POOL_SIZE=20
POOLER_MAX_CLIENT_CONN=100
POOLER_TENANT_ID=supabase-tenant


############
# API Proxy - Kong
############

KONG_HTTP_PORT=8000
KONG_HTTPS_PORT=8443


############
# API - PostgREST
############

PGRST_DB_SCHEMAS=public,storage,graphql_public


############
# Auth - GoTrue
############

## General
SITE_URL=https://seu-dominio.com
ADDITIONAL_REDIRECT_URLS=
JWT_EXPIRY=3600
DISABLE_SIGNUP=false
API_EXTERNAL_URL=https://seu-dominio.com

## Mailer Config
MAILER_URLPATHS_CONFIRMATION="/auth/v1/verify"
MAILER_URLPATHS_INVITE="/auth/v1/verify"
MAILER_URLPATHS_RECOVERY="/auth/v1/verify"
MAILER_URLPATHS_EMAIL_CHANGE="/auth/v1/verify"

## Email auth
ENABLE_EMAIL_SIGNUP=true
ENABLE_EMAIL_AUTOCONFIRM=false
SMTP_ADMIN_EMAIL=admin@example.com
SMTP_HOST=smtp.example.com
SMTP_PORT=587
SMTP_USER=seu_usuario_smtp
SMTP_PASS=sua_senha_smtp
SMTP_SENDER_NAME=Supabase
ENABLE_ANONYMOUS_USERS=false

## Phone auth
ENABLE_PHONE_SIGNUP=false
ENABLE_PHONE_AUTOCONFIRM=false


############
# Studio
############

STUDIO_DEFAULT_ORGANIZATION=Minha Organização
STUDIO_DEFAULT_PROJECT=Meu Projeto

STUDIO_PORT=3000
SUPABASE_PUBLIC_URL=https://seu-dominio.com

# Enable webp support
IMGPROXY_ENABLE_WEBP_DETECTION=true

# OpenAI API key (opcional)
OPENAI_API_KEY=


############
# Functions
############
FUNCTIONS_VERIFY_JWT=false


############
# Logs - Logflare
############

LOGFLARE_LOGGER_BACKEND_API_KEY=$LOGFLARE_LOGGER_BACKEND_API_KEY
LOGFLARE_API_KEY=$LOGFLARE_API_KEY

# Docker socket location
DOCKER_SOCKET_LOCATION=/var/run/docker.sock

# Google Cloud Project (opcional)
GOOGLE_PROJECT_ID=
GOOGLE_PROJECT_NUMBER=
EOF

echo "✅ Arquivo .env criado com sucesso!"
echo ""
echo "⚠️  IMPORTANTE: Edite o arquivo .env e configure:"
echo "   - SITE_URL: Seu domínio real"
echo "   - API_EXTERNAL_URL: Seu domínio real"
echo "   - SUPABASE_PUBLIC_URL: Seu domínio real"
echo "   - Configurações de SMTP para emails"
echo "   - DASHBOARD_USERNAME e DASHBOARD_PASSWORD"
echo ""
echo "📋 Credenciais geradas:"
echo "   Dashboard Username: admin"
echo "   Dashboard Password: (veja no arquivo .env)"
echo ""
