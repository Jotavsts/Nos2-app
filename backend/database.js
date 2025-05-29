const mysql = require("mysql2/promise");

async function connectDB() {
  try {
    const connection = await mysql.createConnection({
      host: "localhost",
      user: "biancamoura",
      password: "220203040311",
      database: "casalDB",
      port: 3306,
    });
    console.log("✅ Conectado ao MySQL com sucesso!");
    return connection;
  } catch (error) {
    console.error("❌ Erro ao conectar ao MySQL:", error.message);
    process.exit(1);
  }
}

module.exports = connectDB;
