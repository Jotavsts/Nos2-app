import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeP extends StatefulWidget {
  final List<Map<String, dynamic>> tarefas;
  const HomeP({super.key, required this.tarefas});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB31357), Color(0xFFE91E63)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 100),
          const Text(
            '“Reserve momentos do dia para estar 100% presentes...',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 30),
          if (tarefas.isNotEmpty) ...[
            const Text(
              'Tarefas:',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...tarefas.map((tarefa) => Card(
              color: Colors.white.withAlpha(230), // 230 ≈ 0.9 * 255
              child: ListTile(
                leading: const Icon(Icons.task_alt, color: Colors.pink),
                title: Text(tarefa['texto']),
                subtitle: Text(
                    '${tarefa['data'].day}/${tarefa['data'].month}/${tarefa['data'].year}'),
              ),
            )),
          ]
        ],
      ),
    );
  }
}
