const express = require("express");
const router = express.Router();
const db = require("../db");

// Listar todos os planos
router.get("/", (req, res) => {
  db.query("SELECT * FROM Planos", (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

// Adicionar um novo plano
router.post("/", (req, res) => {
  const { descricao } = req.body;
  db.query(
    "INSERT INTO Planos (descricao) VALUES (?)",
    [descricao],
    (err, result) => {
      if (err) return res.status(500).json({ error: err });
      res.json({ message: "Plano adicionado", id: result.insertId });
    }
  );
});

module.exports = router;
