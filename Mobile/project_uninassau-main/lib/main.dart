import 'package:flutter/material.dart';
import 'pages/tela_inicial.dart';
import 'pages/cadastro.dart';
import 'pages/cadastrpt2.dart';
import 'pages/cadastro-email.dart';
import 'pages/login.dart';
import 'pages/Appcontroller.dart'; // NOVO: Importa o controlador principal
import 'pages/home.dart'; // Adiciona o import da home

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Primeira tela mostrada
      routes: {
        '/': (context) => const TelaInicial(),
        '/cadastro': (context) => const CadastroEtapa1Page(),
        '/cadastro2': (context) => const CadastroEtapa2Page(),
        '/cadastroEmail': (context) => const CadastroEmailPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => HomePage(tarefas: []),
      },
    );
  }
}
