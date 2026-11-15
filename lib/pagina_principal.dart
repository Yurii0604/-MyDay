import 'package:flutter/material.dart';

class PaginaPrincipal extends StatelessWidget {
  const PaginaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F6),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Olá!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF124B3A),
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        'Organiza o teu dia.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF557368),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD3F0DF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Color(0xFF20845F),
                      size: 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Cartão de progresso
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF20845F),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'O teu progresso',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '0 de 0 tarefas concluídas',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),

                        Text(
                          '0%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        value: 0,
                        minHeight: 8,
                        backgroundColor: Color(0xFF70B99A),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Título das tarefas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tarefas de hoje',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF173D32),
                    ),
                  ),

                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Ver todas',
                      style: TextStyle(color: Color(0xFF20845F)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Lista vazia
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 85,
                        height: 85,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2E9),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Icon(
                          Icons.checklist_rounded,
                          size: 48,
                          color: Color(0xFF20845F),
                        ),
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        'Ainda não tens tarefas',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF173D32),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Adiciona a tua primeira tarefa\ne começa a organizar o teu dia.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF557368),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Botão para adicionar tarefa
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Adicionar tarefa em desenvolvimento'),
            ),
          );
        },
        backgroundColor: const Color(0xFF20845F),
        foregroundColor: Colors.white,
        elevation: 2,
        child: const Icon(Icons.add, size: 30),
      ),

      // Navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF20845F),
        unselectedItemColor: const Color(0xFF8A9B93),
        currentIndex: 0,
        onTap: (index) {
          if (index != 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Página em desenvolvimento')),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Início',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendário',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Estatísticas',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
