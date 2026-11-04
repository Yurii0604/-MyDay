import 'package:flutter/material.dart';

import '../dados/estado_app.dart';
import '../modelos/tarefa.dart';
import '../widgets/anel_progresso.dart';

class PaginaEstatisticas extends StatefulWidget {
  const PaginaEstatisticas({super.key});

  @override
  State<PaginaEstatisticas> createState() => _PaginaEstatisticasState();
}

class _PaginaEstatisticasState extends State<PaginaEstatisticas> {
  int _periodo = 0;

  static const Map<String, (IconData, Color)> _estilos = {
    'Estudo': (Icons.school_outlined, Color(0xFF9C6ADE)),
    'Saúde': (Icons.favorite_border, Color(0xFFF08A3C)),
    'Compras': (Icons.shopping_bag_outlined, Color(0xFFE05A9C)),
    'Trabalho': (Icons.work_outline, Color(0xFF3F7FD9)),
    'Pessoal': (Icons.person_outline, Color(0xFFE5534B)),
  };

  List<Tarefa> _filtrar(List<Tarefa> tarefas) {
    final agora = DateTime.now();
    late DateTime inicio;
    late DateTime fim;

    if (_periodo == 0) {
      inicio = DateTime(agora.year, agora.month, agora.day - (agora.weekday - 1));
      fim = DateTime(inicio.year, inicio.month, inicio.day + 7);
    } else if (_periodo == 1) {
      inicio = DateTime(agora.year, agora.month);
      fim = DateTime(agora.year, agora.month + 1);
    } else {
      inicio = DateTime(agora.year);
      fim = DateTime(agora.year + 1);
    }
    return tarefas
        .where((t) => !t.data.isBefore(inicio) && t.data.isBefore(fim))
        .toList();
  }

  List<String> _rotulos() {
    if (_periodo == 0) return const ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
    if (_periodo == 1) return const ['S1', 'S2', 'S3', 'S4', 'S5'];
    return const ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'];
  }

  int _posicao(DateTime data) {
    if (_periodo == 0) return data.weekday - 1;
    if (_periodo == 1) return (data.day - 1) ~/ 7;
    return data.month - 1;
  }

  Widget _barras(List<Tarefa> concluidas, Color cor) {
    final rotulos = _rotulos();
    final contagens = List<int>.filled(rotulos.length, 0);
    for (final tarefa in concluidas) {
      contagens[_posicao(tarefa.data)]++;
    }
    final maximo = contagens.fold<int>(1, (a, b) => a > b ? a : b);

    return SizedBox(
      height: 140,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < rotulos.length; i++)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 4 + 96 * contagens[i] / maximo,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: cor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(rotulos[i], style: const TextStyle(fontSize: 11)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _linhaCategoria(String categoria, double parte) {
    final estilo = _estilos[categoria] ?? (Icons.label_outline, Colors.grey);
    final cor = estilo.$2;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: cor.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(estilo.$1, color: cor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(categoria)),
                    Text('${(parte * 100).round()}%'),
                  ],
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: parte,
                  minHeight: 6,
                  color: cor,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final estado = EstadoApp.instancia;

    return SafeArea(
      child: ListenableBuilder(
        listenable: estado,
        builder: (context, _) {
          final doPeriodo = _filtrar(estado.tarefas);
          final concluidas = doPeriodo.where((t) => t.concluida).toList();
          final progresso =
              doPeriodo.isEmpty ? 0.0 : concluidas.length / doPeriodo.length;

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            children: [
              const Text(
                'Estatísticas',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SegmentedButton<int>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: 0, label: Text('Semana')),
                  ButtonSegment(value: 1, label: Text('Mês')),
                  ButtonSegment(value: 2, label: Text('Ano')),
                ],
                selected: {_periodo},
                onSelectionChanged: (escolha) =>
                    setState(() => _periodo = escolha.first),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  AnelProgresso(valor: progresso),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tarefas concluídas'),
                      const SizedBox(height: 2),
                      Text(
                        '${concluidas.length} de ${doPeriodo.length}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _barras(concluidas, Theme.of(context).colorScheme.primary),
              const SizedBox(height: 24),
              const Text(
                'Categorias',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              for (final categoria in categorias)
                _linhaCategoria(
                  categoria,
                  doPeriodo.isEmpty
                      ? 0.0
                      : doPeriodo.where((t) => t.categoria == categoria).length /
                          doPeriodo.length,
                ),
            ],
          );
        },
      ),
    );
  }
}