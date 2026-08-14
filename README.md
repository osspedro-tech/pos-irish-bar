# POS - Irish Bar Inventory System

Sistema de gestão de faltas para bar irlandês com tema verde/dourado.

## Deploy no Render.com (Gratuito)

### Pré-requisitos
- Conta no GitHub
- Conta no Render.com (gratuito)

### Passos para Deploy

1. **Fazer commit e push para GitHub**
   ```bash
   git add .
   git commit -m "Preparado para deploy no Render"
   git push origin main
   ```

2. **Criar conta no Render.com**
   - Acede a https://render.com
   - Faz login com GitHub

3. **Criar novo Web Service**
   - Clica em "New" → "Web Service"
   - Seleciona o repositório do GitHub
   - Configura:
     - **Name**: pos-irish-bar
     - **Environment**: Java
     - **Build Command**: `mvn clean package`
     - **Start Command**: `java -jar target/dependency/webapp-runner.jar target/POS.war`

4. **Criar PostgreSQL Database**
   - Clica em "New" → "PostgreSQL"
   - **Name**: pos-db
   - **Database Name**: dbagenda2
   - **User**: pos_user

5. **Conectar Database ao Web Service**
   - No Web Service, vai a "Environment"
   - Adiciona variável `DATABASE_URL`
   - Copia a connection string do PostgreSQL

6. **Deploy Automático**
   - Render faz deploy automático quando fazes push para GitHub
   - URL do app: `https://pos-irish-bar.onrender.com`

## Desenvolvimento Local

### Banco de Dados MySQL
- **Database**: dbagenda2
- **User**: root
- **Password**: NovaPasswordForte

### Executar Localmente
```bash
mvn clean package
mvn tomcat7:deploy
```

## Funcionalidades

- ✅ Tema irlandês (verde/dourado)
- ✅ Gestão de produtos/faltas
- ✅ Upload de imagens
- ✅ Pesquisa de imagens via Bing
- ✅ Contador de tempo
- ✅ Deploy automático no Render
