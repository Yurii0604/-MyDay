import 'package:flutter/material.dart';

import '../dados/estado_app.dart';
import '../modelos/tarefa.dart';
import '../widgets/cartao_tarefa.dart';

// Lista completa de tarefas, com pesquisa e filtro por estado.
class EcranTodasTarefas extends StatefulWidget {
  const EcranTodasTarefas({super.key});

  @override
  State<EcranTodasTarefas> createState() => _EcranTodasTarefasState();
}

class _EcranTodasTarefasState extends State<EcranTodasTarefas> {
  String _pesquisa = '';
  // Filtro escolhido: 0 = todas, 1 = pendentes, 2 = concluídas
  int _filtro = 0;

  // Aplica a pesquisa (título ou descrição) e o filtro de estado.
  List<Tarefa> _filtrar(List<Tarefa> tarefas) {
    final texto = _pesquisa.trim().toLowerCase();

    return tarefas.where((t) {
      final combina = t.titulo.toLowerCase().contains(texto) ||
          t.descricao.toLowerCase().contains(texto);
      final estadoCerto = _filtro == 0 ||
          (_filtro == 1 && !t.concluida) ||
          (_filtro == 2 && t.concluida);
      return combina && estadoCerto;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final estado = EstadoApp.instancia;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const Text(
          'Todas as tarefas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: TextField(
              onChanged: (valor) => setState(() => _pesquisa = valor),
              decoration: InputDecoration(
                hintText: 'Pesquisar tarefas',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: SegmentedButton<int>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: 0, label: Text('Todas')),
                ButtonSegment(value: 1, label: Text('Pendentes')),
                ButtonSegment(value: 2, label: Text('Concluídas')),
              ],
              selected: {_filtro},
              onSelectionChanged: (escolha) =>
                  setState(() => _filtro = escolha.first),
            ),
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: estado,
              builder: (context, _) {
                if (estado.tarefas.isEmpty) {
                  return const Center(child: Text('Ainda não tens tarefas.'));
                }
                final visiveis = _filtrar(estado.tarefas);
                if (visiveis.isEmpty) {
                  return const Center(child: Text('Nenhuma tarefa encontrada.'));
                }
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  children: [
                    for (final tarefa in visiveis) CartaoTarefa(tarefa: tarefa),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}