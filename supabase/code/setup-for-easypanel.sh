#!/bin/bash

# Script de configuração rápida para Easy Panel
# Execute este script para preparar o ambiente antes do deploy

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}   Supabase - Setup para Easy Panel (Hostinger)${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Verificar se está no diretório correto
if [ ! -f "docker-compose.yml" ]; then
    echo -e "${RED}❌ Erro: Execute este script do diretório supabase/code${NC}"
    exit 1
fi

# Passo 1: Gerar secrets
echo -e "${YELLOW}📝 Passo 1: Gerando secrets...${NC}"
if [ -f ".env" ]; then
    echo -e "${YELLOW}⚠️  Arquivo .env já existe!${NC}"
    read -p "Deseja sobrescrever? (s/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        echo -e "${GREEN}✓ Mantendo .env existente${NC}"
    else
        ./generate-secrets.sh
    fi
else
    ./generate-secrets.sh
fi
echo ""

# Passo 2: Configurar domínio
echo -e "${YELLOW}📝 Passo 2: Configurando domínio...${NC}"
read -p "Digite seu domínio (ex: meuapp.com): " DOMAIN

if [ -z "$DOMAIN" ]; then
    echo -e "${RED}❌ Domínio não pode ser vazio!${NC}"
    exit 1
fi

# Atualizar domínio no .env
sed -i.bak "s|SITE_URL=.*|SITE_URL=https://$DOMAIN|g" .env
sed -i.bak "s|API_EXTERNAL_URL=.*|API_EXTERNAL_URL=https://$DOMAIN|g" .env
sed -i.bak "s|SUPABASE_PUBLIC_URL=.*|SUPABASE_PUBLIC_URL=https://$DOMAIN|g" .env
rm -f .env.bak

echo -e "${GREEN}✓ Domínio configurado: https://$DOMAIN${NC}"
echo ""

# Passo 3: Configurar dashboard
echo -e "${YELLOW}📝 Passo 3: Configurando credenciais do dashboard...${NC}"
read -p "Username do dashboard (padrão: admin): " DASHBOARD_USER
DASHBOARD_USER=${DASHBOARD_USER:-admin}

read -sp "Senha do dashboard: " DASHBOARD_PASS
echo

if [ -z "$DASHBOARD_PASS" ]; then
    echo -e "${YELLOW}⚠️  Usando senha gerada automaticamente${NC}"
else
    sed -i.bak "s|DASHBOARD_USERNAME=.*|DASHBOARD_USERNAME=$DASHBOARD_USER|g" .env
    sed -i.bak "s|DASHBOARD_PASSWORD=.*|DASHBOARD_PASSWORD=$DASHBOARD_PASS|g" .env
    rm -f .env.bak
fi

echo -e "${GREEN}✓ Credenciais do dashboard configuradas${NC}"
echo ""

# Passo 4: Configurar SMTP (opcional)
echo -e "${YELLOW}📝 Passo 4: Configurar SMTP para emails...${NC}"
read -p "Deseja configurar SMTP agora? (s/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]; then
    read -p "Host SMTP (ex: smtp.resend.com): " SMTP_HOST
    read -p "Porta SMTP (ex: 587): " SMTP_PORT
    read -p "Usuário SMTP: " SMTP_USER
    read -sp "Senha SMTP: " SMTP_PASS
    echo
    read -p "Email do remetente (ex: noreply@$DOMAIN): " SMTP_EMAIL

    sed -i.bak "s|SMTP_HOST=.*|SMTP_HOST=$SMTP_HOST|g" .env
    sed -i.bak "s|SMTP_PORT=.*|SMTP_PORT=$SMTP_PORT|g" .env
    sed -i.bak "s|SMTP_USER=.*|SMTP_USER=$SMTP_USER|g" .env
    sed -i.bak "s|SMTP_PASS=.*|SMTP_PASS=$SMTP_PASS|g" .env
    sed -i.bak "s|SMTP_ADMIN_EMAIL=.*|SMTP_ADMIN_EMAIL=$SMTP_EMAIL|g" .env
    rm -f .env.bak

    echo -e "${GREEN}✓ SMTP configurado${NC}"
else
    echo -e "${YELLOW}⚠️  Lembre-se de configurar SMTP depois no arquivo .env${NC}"
fi
echo ""

# Passo 5: Resumo
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ Configuração concluída!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${GREEN}📋 Resumo da configuração:${NC}"
echo -e "   • Domínio: https://$DOMAIN"
echo -e "   • Dashboard: $DASHBOARD_USER"
echo -e "   • Arquivo .env criado com secrets únicos"
echo ""
echo -e "${YELLOW}📝 Próximos passos:${NC}"
echo ""
echo -e "1. ${GREEN}Revisar o arquivo .env${NC}"
echo -e "   Abra e verifique todas as configurações:"
echo -e "   ${BLUE}nano .env${NC}"
echo ""
echo -e "2. ${GREEN}Fazer commit (OPCIONAL)${NC}"
echo -e "   Se quiser versionar (não recomendado para .env com secrets):"
echo -e "   ${BLUE}git add ../${NC}"
echo -e "   ${BLUE}git commit -m \"Configure for Easy Panel\"${NC}"
echo -e "   ${BLUE}git push origin main${NC}"
echo ""
echo -e "   ${RED}⚠️  ATENÇÃO: O .env está no .gitignore e não será commitado${NC}"
echo -e "   ${RED}   Você precisará configurar as variáveis manualmente no Easy Panel!${NC}"
echo ""
echo -e "3. ${GREEN}Deploy no Easy Panel${NC}"
echo -e "   Siga o guia detalhado:"
echo -e "   ${BLUE}cat ../DEPLOY-EASYPANEL.md${NC}"
echo ""
echo -e "   Resumo rápido:"
echo -e "   a) Acesse seu Easy Panel na Hostinger"
echo -e "   b) Crie novo projeto > Deploy from Git"
echo -e "   c) Conecte seu repositório GitHub"
echo -e "   d) Configure as variáveis de ambiente (copie do .env)"
echo -e "   e) Use o arquivo: ../easypanel.yml"
echo -e "   f) Configure os domínios:"
echo -e "      • API: api.$DOMAIN → porta 8000"
echo -e "      • Studio: studio.$DOMAIN → porta 3000"
echo -e "   g) Deploy!"
echo ""
echo -e "${YELLOW}💡 Dica: Guarde o arquivo .env em um local seguro!${NC}"
echo -e "${YELLOW}   Você precisará das variáveis para configurar no Easy Panel.${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Boa sorte com seu deploy! 🚀${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
