# Catálogo de Produtos Flutter

Aplicativo Flutter de catálogo de produtos, consumindo a API pública do DummyJSON, com gerenciamento de estado usando **GetX**, consumo de API com **Dio** e cache local com **Isar**.

---

## 🎯 Objetivo

Demonstrar:

- Gerenciamento de estado com **GetX**
- Consumo de API REST com **Dio**
- Persistência local com **Isar**
- Lista, detalhes e pesquisa de produtos

---

## 🌐 API Utilizada

- Base URL: `https://dummyjson.com`
- Endpoint principal: `GET /products`

---

## 📱 Funcionalidades

### 1. Lista de Produtos

- Busca produtos via `GET /products`
- Exibe:
  - Imagem
  - Título
  - Preço
- Suporte a **pull-to-refresh**
- Exibe **loading** enquanto carrega
- Exibe mensagem de **erro** em caso de falha na requisição

### 2. Detalhes do Produto

Ao tocar em um item da lista:

- Navegação para a tela de detalhes (`/product/:id`)
- Exibe:
  - Nome
  - Descrição
  - Preço
  - Imagem principal
  - Outras imagens (carrossel opcional, se disponíveis)

### 3. Cache Local (Isar)

- Ao abrir o app:
  - Se houver dados no **Isar**, lista os produtos do cache
- Após uma sincronização bem-sucedida com a API:
  - Atualiza o cache local com a nova lista de produtos
- Permite visualizar produtos mesmo em cenário offline (desde que já tenham sido sincronizados anteriormente)

### 4. Pesquisa Local

- Campo de busca na tela de lista
- Filtragem feita **em memória**, sobre a lista carregada
- Busca por título do produto (e/ou outros campos, dependendo da implementação)

---

## 🧱 Tecnologias e Bibliotecas

- **Flutter**
- **GetX** (estado, injeção de dependência, rotas)
- **Dio** (HTTP client)
- **Isar** (banco de dados local)
- **Flutter Hooks / Widgets básicos** (ListView, Image, etc.) – conforme necessidade

