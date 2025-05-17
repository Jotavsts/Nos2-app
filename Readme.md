# 📱 Projeto Nos2 App

Este é um projeto mobile desenvolvido com **Flutter** e backend em **Node.js** usando **Express**. O aplicativo é uma aplicação de exemplo para fins de estudo e prática de integração front-end/back-end.

## 🚀 Tecnologias Utilizadas

- Flutter
- Dart
- Node.js
- Express
- Git & GitHub

## 📁 Estrutura do Projeto

```
Nos2-app/
│
├── backend/              # Backend Node.js (API REST)
│   ├── server.js         # Ponto de entrada do servidor
│   ├── routes/           # Rotas da aplicação
│   └── controllers/      # Lógica dos endpoints
│
├── frontend/             # Aplicativo Flutter
│   ├── lib/
│   │   └── screens/      # Telas do app
│   └── pubspec.yaml      # Dependências do Flutter
│
└── README.md             # Este arquivo
```

## ⚙️ Como Executar o Projeto

### 🔧 Backend (Node.js)

1. Acesse a pasta do backend:

   ```bash
   cd backend
   ```

2. Instale as dependências:

   ```bash
   npm install
   ```

3. Inicie o servidor:

   ```bash
   node server.js
   ```

   O servidor iniciará em: [http://localhost:3000](http://localhost:3000)

---

### 📱 Frontend (Flutter)

1. Acesse a pasta do frontend:

   ```bash
   cd frontend
   ```

2. Instale os pacotes do Flutter:

   ```bash
   flutter pub get
   ```

3. Execute o aplicativo:
   ```bash
   flutter run
   ```

---

## 🔄 Integração

Certifique-se de que o app Flutter está configurado para enviar requisições para `http://localhost:3000` (ou IP da máquina se for testar em celular físico).

## 🛠️ Funcionalidades

- Login simples via API REST
- Navegação entre telas no Flutter
- Conexão e autenticação front-end com back-end

## 📄 Licença

Este projeto é livre para uso acadêmico e está aberto para contribuições.
