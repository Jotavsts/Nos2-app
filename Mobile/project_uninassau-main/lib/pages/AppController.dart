import 'package:flutter/material.dart';
import 'home.dart';
import 'task_page.dart';
import 'conexoes_page.dart'; 

class AppController extends StatefulWidget {
  const AppController({super.key});

  @override
  State<AppController> createState() => _AppControllerState();
}

class _AppControllerState extends State<AppController> {
  int _selectedIndex = 1; // home no meio
  List<Map<String, dynamic>> _tarefas = [];

  void _addTask(String title, DateTime date) {
    setState(() {
      _tarefas.add({'title': title, 'date': date});
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      TaskPage(onAddTask: _addTask),
      HomePage(tarefas: _tarefas),
      const ConnectionsPage(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.pink,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tarefas'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Conexões'),
        ],
      ),
    );
  }
}
