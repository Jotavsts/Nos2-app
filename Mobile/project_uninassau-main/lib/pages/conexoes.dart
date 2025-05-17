import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ConexoesPage extends StatelessWidget {
  const ConexoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFc10746),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _secaoNosDois(),
              const SizedBox(height: 16),
              _secaoPessoa('VOCÊ'),
              const SizedBox(height: 16),
              _secaoPessoa('SEU AMOR'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(CupertinoIcons.list_bullet, color: Colors.pink),
              onPressed: () {
                // Você pode colocar outra navegação aqui se quiser
              },
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.house_fill, color: Colors.pink),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.person_2_fill, color: Colors.pink),
              onPressed: () {
                Navigator.pushNamed(context, '/conexoes'); // ✅ Vai para a tela de conexões
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _secaoNosDois() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'NOS DOIS',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Column(
              children: [
                Icon(Icons.account_circle, size: 60, color: Colors.pink),
                SizedBox(height: 8),
                Text('ADD FOTO', style: TextStyle(color: Colors.pink)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _secaoPessoa(String titulo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: const [
              _CampoInfo(icon: Icons.person, label: 'Nome     Sobrenome'),
              SizedBox(height: 8),
              _CampoInfo(icon: Icons.calendar_today, label: 'Data de nascimento'),
              SizedBox(height: 8),
              _CampoInfo(icon: Icons.people, label: 'Gênero'),
            ],
          ),
        ),
      ],
    );
  }
}

class _CampoInfo extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CampoInfo({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.pink),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Colors.pink),
          ),
        ),
      ],
    );
  }
}
