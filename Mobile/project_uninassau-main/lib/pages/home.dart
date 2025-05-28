import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List<Map<String, dynamic>> tarefas;
  const HomePage({super.key, required this.tarefas});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página Inicial')),
      body: ListView.builder(
        itemCount: widget.tarefas.length,
        itemBuilder: (context, index) {
          final tarefa = widget.tarefas[index];
          return ListTile(
            title: Text(tarefa['title']),
            subtitle: Text(tarefa['date'].toString()),
          );
        },
      ),
    );
  }
}

