import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _tarefas = [];

  @override
  void initState() {
    super.initState();
    _buscarTarefas();
  }

  Future<void> _buscarTarefas() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/tarefas'));
      if (response.statusCode == 200) {
        setState(() {
          _tarefas = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        print('Erro ao carregar tarefas: ${response.body}');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página Inicial')),
      body: ListView.builder(
        itemCount: _tarefas.length,
        itemBuilder: (context, index) {
          final tarefa = _tarefas[index];
          return ListTile(
            title: Text(tarefa['title'] ?? 'Sem título'),
            subtitle: Text(tarefa['date'] ?? 'Sem data'),
          );
        },
      ),
    );
  }
}

