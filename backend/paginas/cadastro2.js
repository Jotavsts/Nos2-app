const express = require("express");
const mongoose = require("mongoose");
const Joi = require("joi");
const cors = require("cors");
const dotenv = require("dotenv");

dotenv.config();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Schema do Usuário
const usuarioSchema = new mongoose.Schema({
  nome: { type: String, required: true },
  sobrenome: { type: String, required: true },
  dataNascimento: { type: String, required: true },
  genero: { type: String, required: true },
  createdAt: { type: Date, default: Date.now },
});

const Usuario = mongoose.model("Usuario", usuarioSchema);

// Validação com Joi
const validateUsuario = (data) => {
  const schema = Joi.object({
    nome: Joi.string().min(2).required().messages({
      "string.empty": "Nome é obrigatório",
      "string.min": "Nome deve ter pelo menos 2 caracteres",
    }),
    sobrenome: Joi.string().min(2).required().messages({
      "string.empty": "Sobrenome é obrigatório",
      "string.min": "Sobrenome deve ter pelo menos 2 caracteres",
    }),
    dataNascimento: Joi.string().required().messages({
      "string.empty": "Data de nascimento é obrigatória",
    }),
    genero: Joi.string().required().messages({
      "string.empty": "Gênero é obrigatório",
    }),
  });

  return schema.validate(data, { abortEarly: false });
};

// Rota para cadastro
app.post("/api/cadastro/etapa2", async (req, res) => {
  try {
    // Validação
    const { error } = validateUsuario(req.body);
    if (error) {
      const errors = error.details.map((err) => err.message);
      return res.status(400).json({ error: errors.join(", ") });
    }

    // Criar novo usuário
    const usuario = new Usuario(req.body);
    await usuario.save();

    res.status(201).json({ message: "Dados salvos com sucesso" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Erro interno do servidor" });
  }
});

// Iniciar servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
