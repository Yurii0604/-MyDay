import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tarefa.dart';
import 'nova_tarefa.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  List<Tarefa> tarefas = [];

  final verde = const Color(0xFF20845F);

  @override
  void initState() {
    super.initState();
    carregarTarefas();
  }

  Future<void> carregarTarefas() async {
    final prefs = await SharedPreferences.getInstance();
    final dados = prefs.getString('tarefas');

    if (dados != null) {
      final lista = jsonDecode(dados);

      setState(() {
        tarefas = (lista as List).map((item) => Tarefa.fromJson(item)).toList();
      });
    }
  }

  Future<void> guardarTarefas() async {
    final prefs = await SharedPreferences.getInstance();

    final dados = tarefas.map((t) => t.toJson()).toList();

    await prefs.setString('tarefas', jsonEncode(dados));
  }

  Future<void> adicionarTarefa() async {
    final novaTarefa = await Navigator.push<Tarefa>(
      context,
      MaterialPageRoute(builder: (context) => const NovaTarefa()),
    );

    if (novaTarefa != null) {
      setState(() {
        tarefas.add(novaTarefa);
      });

      await guardarTarefas();
    }
  }

  Future<void> concluirTarefa(int index, bool? valor) async {
    setState(() {
      tarefas[index].concluida = valor ?? false;
    });

    await guardarTarefas();
  }

  double get progresso {
    if (tarefas.isEmpty) return 0;

    return tarefas.where((t) => t.concluida).length / tarefas.length;
  }

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
                style: TextStyle(fontSize: 15, color: Color(0xFF557368)),
              ),

              const SizedBox(height: 30),

              // Progresso
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: verde,
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${tarefas.where((t) => t.concluida).length} '
                          'de ${tarefas.length} tarefas concluídas',
                          style: const TextStyle(color: Colors.white),
                        ),

                        Text(
                          '${(progresso * 100).round()}%',
                          style: const TextStyle(
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
                      child: LinearProgressIndicator(
                        value: progresso,
                        minHeight: 8,
                        backgroundColor: const Color(0xFF70B99A),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'As minhas tarefas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF173D32),
                ),
              ),

              const SizedBox(height: 15),

              // Lista de tarefas
              Expanded(
                child: tarefas.isEmpty
                    ? const Center(
                        child: Text(
                          'Ainda não tens tarefas.\n'
                          'Adiciona a tua primeira tarefa!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF557368),
                            height: 1.5,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: tarefas.length,
                        itemBuilder: (context, index) {
                          final tarefa = tarefas[index];

                          return Card(
                            color: Colors.white,
                            elevation: 0,
                            margin: const EdgeInsets.only(bottom: 12),
                            child: CheckboxListTile(
                              activeColor: verde,
                              value: tarefa.concluida,
                              onChanged: (valor) {
                                concluirTarefa(index, valor);
                              },
                              title: Text(
                                tarefa.tema,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: tarefa.concluida
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              subtitle: Text(
                                '${tarefa.categoria} • '
                                '${tarefa.prioridade}\n'
                                '${tarefa.data.day}/'
                                '${tarefa.data.month}/'
                                '${tarefa.data.year}',
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),

      // Adicionar tarefa
      floatingActionButton: FloatingActionButton(
        onPressed: adicionarTarefa,
        backgroundColor: verde,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 30),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: verde,
        unselectedItemColor: const Color(0xFF8A9B93),
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
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
