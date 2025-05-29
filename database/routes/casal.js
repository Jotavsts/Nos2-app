const express = require("express");
const router = express.Router();
const db = require("../db");

// Listar casais
router.get("/", (req, res) => {
  db.query("SELECT * FROM Casal", (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

// Adicionar casal com plano
router.post("/", (req, res) => {
  const { planos_idPlano } = req.body;
  db.query(
    "INSERT INTO Casal (planos_idPlano) VALUES (?)",
    [planos_idPlano],
    (err, result) => {
      if (err) return res.status(500).json({ error: err });
      res.json({ message: "Casal adicionado", id: result.insertId });
    }
  );
});

module.exports = router;
