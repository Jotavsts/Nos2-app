const express = require("express");
const cors = require("cors");
const Joi = require("joi");
const dotenv = require("dotenv");

// Carrega variáveis de ambiente
dotenv.config();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Schema de validação com Joi
const cadastroValidationSchema = Joi.object({
  nome: Joi.string().min(2).required().messages({
    "string.empty": "Nome é obrigatório",
    "string.min": "Nome deve ter pelo menos 2 caracteres",
  }),
  sobrenome: Joi.string().min(2).required().messages({
    "string.empty": "Sobrenome é obrigatório",
    "string.min": "Sobrenome deve ter pelo menos 2 caracteres",
  }),
  dataNascimento: Joi.string()
    .pattern(/^\d{2}\/\d{2}\/\d{4}$/)
    .required()
    .messages({
      "string.empty": "Data de nascimento é obrigatória",
      "string.pattern.base":
        "Data de nascimento deve estar no formato DD/MM/AAAA",
    }),
  genero: Joi.string()
    .valid("Masculino", "Feminino", "Outro")
    .required()
    .messages({
      "string.empty": "Gênero é obrigatório",
      "any.only": "Gênero deve ser Masculino, Feminino ou Outro",
    }),
});

// Endpoint para cadastro etapa 1
app.post("/api/cadastro/etapa1", async (req, res) => {
  try {
    // Validação dos dados
    const { error } = cadastroValidationSchema.validate(req.body);
    if (error) {
      return res.status(400).json({ message: error.details[0].message });
    }

    // Cria novo cadastro
    const cadastro = new Cadastro(req.body);
    await cadastro.save();

    res.status(201).json({ message: "Cadastro salvo com sucesso" });
  } catch (error) {
    console.error("Erro ao salvar cadastro:", error);
    res.status(500).json({ message: "Erro interno do servidor" });
  }
});

// Middleware para tratamento de erros
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: "Algo deu errado!" });
});

// Inicia o servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
