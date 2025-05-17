const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");

const app = express();
app.use(cors());
app.use(bodyParser.json());

const usuarios = [{ email: "teste@email.com", senha: "123456", nome: "João" }];

app.post("/login", (req, res) => {
  const { email, senha } = req.body;
  const usuario = usuarios.find((u) => u.email === email && u.senha === senha);

  if (usuario) {
    res.json({ nome: usuario.nome });
  } else {
    res.status(401).json({ erro: "Credenciais inválidas" });
  }
});

app.listen(3000, () => {
  console.log("Servidor rodando em http://localhost:3000");
});
