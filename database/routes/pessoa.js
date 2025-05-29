const express = require("express");
const router = express.Router();
const db = require("../db");

// Listar pessoas
router.get("/", (req, res) => {
  db.query("SELECT * FROM Pessoa", (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

// Adicionar pessoa ao casal
router.post("/", (req, res) => {
  const { nome, email, senha, telefone, casal_idCasal } = req.body;
  db.query(
    "INSERT INTO Pessoa (nome, email, senha, telefone, casal_idCasal) VALUES (?, ?, ?, ?, ?)",
    [nome, email, senha, telefone, casal_idCasal],
    (err, result) => {
      if (err) return res.status(500).json({ error: err });
      res.json({ message: "Pessoa adicionada", id: result.insertId });
    }
  );
});

module.exports = router;
