const mysql = require("mysql2");

const connection = mysql.createConnection({
  host: "localhost",
  user: "biancamoura",
  password: "220203040311",
  database: "casalDB",
});

connection.connect((err) => {
  if (err) {
    console.error("Erro ao conectar:", err);
    return;
  }
  console.log("Conectado ao MySQL!");
});

module.exports = connection;
