const express = require("express");
const mongoose = require("mongoose");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const cors = require("cors");
const dotenv = require("dotenv");

dotenv.config();

const app = express();
app.use(express.json());
app.use(cors());

// Conexão com o MongoDB
mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log("Conectado ao MongoDB"))
    .catch(err => console.error("Erro ao conectar ao MongoDB:", err));

// Schema do Usuário
const userSchema = new mongoose.Schema({
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
});
const User = mongoose.model("User", userSchema);

// Schema de Tarefa
const tarefaSchema = new mongoose.Schema({
    texto: String,
    dataHora: String,
    userId: String, // Referência ao usuário dono da tarefa
});
const Tarefa = mongoose.model("Tarefa", tarefaSchema);

// Middleware para verificar JWT
const authenticateToken = (req, res, next) => {
    const authHeader = req.headers["authorization"];
    const token = authHeader && authHeader.split(" ")[1];
    if (!token) return res.status(401).json({ error: "Token não fornecido" });

    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
        if (err) return res.status(403).json({ error: "Token inválido" });
        req.user = user;
        next();
    });
};

// Registro
app.post("/api/register", async (req, res) => {
    try {
        const { email, password } = req.body;
        if (!email || !password) return res.status(400).json({ error: "Email e senha são obrigatórios" });

        const existingUser = await User.findOne({ email });
        if (existingUser) return res.status(400).json({ error: "Email já registrado" });

        const hashedPassword = await bcrypt.hash(password, 10);
        const user = new User({ email, password: hashedPassword });
        await user.save();

        res.status(201).json({ message: "Usuário registrado com sucesso" });
    } catch (error) {
        res.status(500).json({ error: "Erro ao registrar usuário" });
    }
});

// Login
app.post("/api/login", async (req, res) => {
    try {
        const { email, password } = req.body;
        if (!email || !password) return res.status(400).json({ error: "Email e senha são obrigatórios" });

        const user = await User.findOne({ email });
        if (!user || !(await bcrypt.compare(password, user.password))) {
            return res.status(400).json({ error: "Credenciais inválidas" });
        }

        const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, { expiresIn: "1h" });
        res.json({ token });
    } catch (error) {
        res.status(500).json({ error: "Erro ao fazer login" });
    }
});

// Rota protegida
app.get("/api/protected", authenticateToken, (req, res) => {
    res.json({ message: "Acesso autorizado", user: req.user });
});

// CRUD de Tarefas (Protegido)
app.get("/api/tarefas", authenticateToken, async (req, res) => {
    const tarefas = await Tarefa.find({ userId: req.user.userId });
    res.json(tarefas);
});

app.post("/api/tarefas", authenticateToken, async (req, res) => {
    const { texto, dataHora } = req.body;
    const novaTarefa = new Tarefa({ texto, dataHora, userId: req.user.userId });
    await novaTarefa.save();
    res.status(201).json(novaTarefa);
});

// Start do servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Servidor rodando na porta ${PORT}`));
