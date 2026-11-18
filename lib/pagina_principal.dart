import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tarefa.dart';
import 'nova_tarefa.dart';
import 'calendario.dart';
import 'estatisticas.dart';
import 'perfil.dart';

class PaginaPrincipal extends StatefulWidget {
  final String nomeUtilizador;
  final String emailUtilizador;

  const PaginaPrincipal({
    super.key,
    this.nomeUtilizador = 'Utilizador',
    this.emailUtilizador = '',
  });

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  List<Tarefa> tarefas = [];
  int paginaSelecionada = 0;

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
      setState(() {
        tarefas = (jsonDecode(dados) as List)
            .map((item) => Tarefa.fromJson(item))
            .toList();
      });
    }
  }

  Future<void> guardarTarefas() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'tarefas',
      jsonEncode(tarefas.map((t) => t.toJson()).toList()),
    );
  }

  Future<void> adicionarTarefa() async {
    final tarefa = await Navigator.push<Tarefa>(
      context,
      MaterialPageRoute(builder: (context) => const NovaTarefa()),
    );

    if (tarefa != null) {
      setState(() {
        tarefas.add(tarefa);
      });
      guardarTarefas();
    }
  }

  Future<void> editarTarefa(int index) async {
    final tarefa = await Navigator.push<Tarefa>(
      context,
      MaterialPageRoute(
        builder: (context) => NovaTarefa(tarefa: tarefas[index]),
      ),
    );

    if (tarefa != null) {
      setState(() {
        tarefas[index] = tarefa;
      });
      guardarTarefas();
    }
  }

  void eliminarTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
    guardarTarefas();
  }

  void concluirTarefa(int index, bool? valor) {
    setState(() {
      tarefas[index].concluida = valor ?? false;
    });
    guardarTarefas();
  }

  Widget paginaInicial() {
    final hoje = DateTime.now();

    final tarefasHoje = tarefas
        .where(
          (t) =>
              t.data.year == hoje.year &&
              t.data.month == hoje.month &&
              t.data.day == hoje.day,
        )
        .toList();

    final concluidas = tarefas.where((t) => t.concluida).length;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, ${widget.nomeUtilizador}!',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF124B3A),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '$concluidas de ${tarefas.length} tarefas concluídas',
              style: const TextStyle(fontSize: 14, color: Color(0xFF557368)),
            ),

            const SizedBox(height: 25),

            const Text(
              'Tarefas de hoje',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF124B3A),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: tarefasHoje.isEmpty
                  ? const Center(
                      child: Text(
                        'Não tens tarefas para hoje.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tarefasHoje.length,
                      itemBuilder: (context, index) {
                        final tarefa = tarefasHoje[index];
                        final indice = tarefas.indexOf(tarefa);

                        return Card(
                          color: Colors.white,
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: CheckboxListTile(
                            activeColor: verde,
                            value: tarefa.concluida,
                            onChanged: (valor) {
                              concluirTarefa(indice, valor);
                            },
                            title: Text(
                              tarefa.tema,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(tarefa.categoria),
                            secondary: PopupMenuButton<String>(
                              onSelected: (valor) {
                                if (valor == 'editar') {
                                  editarTarefa(indice);
                                } else {
                                  eliminarTarefa(indice);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'editar',
                                  child: Text('Editar'),
                                ),
                                const PopupMenuItem(
                                  value: 'eliminar',
                                  child: Text('Eliminar'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F6),

      body: IndexedStack(
        index: paginaSelecionada,
        children: [
          paginaInicial(),
          Calendario(tarefas: tarefas),
          Estatisticas(tarefas: tarefas),
          Perfil(
            nomeUtilizador: widget.nomeUtilizador,
            emailUtilizador: widget.emailUtilizador,
          ),
        ],
      ),

      floatingActionButton: paginaSelecionada == 0
          ? FloatingActionButton(
              onPressed: adicionarTarefa,
              backgroundColor: verde,
              foregroundColor: Colors.white,
              child: const Icon(Icons.add),
            )
          : null,

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: paginaSelecionada,
        selectedItemColor: verde,
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            paginaSelecionada = index;
          });
        },

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
