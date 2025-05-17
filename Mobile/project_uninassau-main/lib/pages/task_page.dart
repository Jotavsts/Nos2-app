import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  final Function(String, DateTime) onAddTask;
  const TaskPage({super.key, required this.onAddTask});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController _taskController = TextEditingController();
  DateTime? _selectedDate;

  void _submitTask() {
    if (_taskController.text.isNotEmpty && _selectedDate != null) {
      widget.onAddTask(_taskController.text, _selectedDate!);
      _taskController.clear();
      Navigator.pop(context);
    }
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB31357),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'O que deseja fazer hoje?',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Digite sua tarefa...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today),
              label: Text(_selectedDate == null
                  ? 'Selecionar data'
                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.pink),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitTask,
              child: const Text('Adicionar tarefa'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.pink),
            )
          ],
        ),
      ),
    );
  }
}
