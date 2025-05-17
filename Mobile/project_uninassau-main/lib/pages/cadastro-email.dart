import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CadastroEmailPage extends StatefulWidget {
  const CadastroEmailPage({super.key});

  @override
  State<CadastroEmailPage> createState() => _CadastroEmailPageState();
}

class _CadastroEmailPageState extends State<CadastroEmailPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  Future<void> cadastrarUsuario() async {
    final email = emailController.text.trim();
    final senha = senhaController.text.trim();

    if (email.isEmpty || senha.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('Erro'),
          content: Text('Preencha todos os campos'),
        ),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/cadastro'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'senha': senha}),
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            title: Text('Sucesso'),
            content: Text('Cadastro realizado com sucesso!'),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Erro'),
            content: Text('Falha: ${response.body}'),
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Erro de conexão'),
          content: Text('Detalhes: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFc10746),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text('NÓS❤',
                  style: TextStyle(
                      fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              const Text('EMAIL & SENHA',
                  style: TextStyle(
                      fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const LinearProgressIndicator(value: 1.0, color: Colors.white),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.email, color: Colors.pink),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(labelText: 'E-mail'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.lock, color: Colors.pink),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: senhaController,
                            obscureText: true,
                            decoration: const InputDecoration(labelText: 'Senha'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('VOLTAR'),
                  ),
                  ElevatedButton(
                    onPressed: cadastrarUsuario,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Concluir'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
