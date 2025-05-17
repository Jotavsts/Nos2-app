const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors"); // ✅ Adicionado para habilitar CORS

const app = express();
const port = 3000;

// Middleware para permitir CORS (para aceitar requisições do Flutter)
app.use(cors());

// Middleware para parsear JSON
app.use(bodyParser.json());


// Endpoint para cadastro
app.post("/cadastro", (req, res) => {
  const { email, senha } = req.body;

  // Validação básica
  if (!email || !senha) {
    return res.status(400).json({ error: "Email e senha são obrigatórios" });
  }

  // Simulação de salvamento (substitua por lógica de banco de dados em produção)
  console.log(`Novo cadastro - Email: ${email}, Senha: ${senha}`);
  res.status(200).json({ message: "Cadastro realizado com sucesso!" });
});

// Iniciar o servidor
app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
