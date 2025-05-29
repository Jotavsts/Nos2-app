const express = require("express");
const router = express.Router();
const db = require("../db");

// Listar rotinas
router.get("/", (req, res) => {
  db.query("SELECT * FROM Rotina", (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

// Adicionar rotina para um casal
router.post("/", (req, res) => {
  const { data_evento, hora_inicio, hora_fim, nome_do_evento, casal_idCasal } =
    req.body;
  db.query(
    "INSERT INTO Rotina (data_evento, hora_inicio, hora_fim, nome_do_evento, casal_idCasal) VALUES (?, ?, ?, ?, ?)",
    [data_evento, hora_inicio, hora_fim, nome_do_evento, casal_idCasal],
    (err, result) => {
      if (err) return res.status(500).json({ error: err });
      res.json({ message: "Rotina adicionada", id: result.insertId });
    }
  );
});

module.exports = router;
