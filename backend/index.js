console.log("Iniciando o servidor...");
const express = require("express");
const connectDB = require("./database");
const app = express();
app.use(express.json()); // Para parsear JSON no corpo das requisições

// Inicializar o servidor
async function startServer() {
  console.log("Tentando conectar ao MySQL...");
  const db = await connectDB();

  // Exemplo de rota para testar a conexão
  app.get("/test", async (req, res) => {
    try {
      const [rows] = await db.execute("SELECT 1 + 1 AS result");
      res.json({ message: "Conexão OK", result: rows[0].result });
    } catch (error) {
      res
        .status(500)
        .json({ error: "Erro ao testar conexão", details: error.message });
    }
  });

  // Criar uma nova pessoa
  app.post("/pessoa", async (req, res) => {
    const { nome, email, senha, telefone, casal_idCasal } = req.body;
    try {
      const [result] = await db.execute(
        "INSERT INTO Pessoa (nome, email, senha, telefone, casal_idCasal) VALUES (?, ?, ?, ?, ?)",
        [nome, email, senha, telefone, casal_idCasal]
      );
      res
        .status(201)
        .json({ id: result.insertId, message: "Pessoa criada com sucesso" });
    } catch (error) {
      res
        .status(500)
        .json({ error: "Erro ao criar pessoa", details: error.message });
    }
  });

  // Listar todas as pessoas
  app.get("/pessoa", async (req, res) => {
    try {
      const [rows] = await db.execute("SELECT * FROM Pessoa");
      res.json(rows);
    } catch (error) {
      res
        .status(500)
        .json({ error: "Erro ao listar pessoas", details: error.message });
    }
  });

  // Atualizar uma pessoa
  app.put("/pessoa/:id", async (req, res) => {
    const { id } = req.params;
    const { nome, email, senha, telefone, casal_idCasal } = req.body;
    try {
      const [result] = await db.execute(
        "UPDATE Pessoa SET nome = ?, email = ?, senha = ?, telefone = ?, casal_idCasal = ? WHERE idPessoa = ?",
        [nome, email, senha, telefone, casal_idCasal, id]
      );
      if (result.affectedRows === 0) {
        return res.status(404).json({ error: "Pessoa não encontrada" });
      }
      res.json({ message: "Pessoa atualizada com sucesso" });
    } catch (error) {
      res
        .status(500)
        .json({ error: "Erro ao atualizar pessoa", details: error.message });
    }
  });

  // Deletar uma pessoa
  app.delete("/pessoa/:id", async (req, res) => {
    const { id } = req.params;
    try {
      const [result] = await db.execute(
        "DELETE FROM Pessoa WHERE idPessoa = ?",
        [id]
      );
      if (result.affectedRows === 0) {
        return res.status(404).json({ error: "Pessoa não encontrada" });
      }
      res.json({ message: "Pessoa deletada com sucesso" });
    } catch (error) {
      res
        .status(500)
        .json({ error: "Erro ao deletar pessoa", details: error.message });
    }
  });

  // Iniciar o servidor
  const PORT = 3000;
  app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`);
  });
}

startServer();
