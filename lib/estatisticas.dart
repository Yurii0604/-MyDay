import 'package:flutter/material.dart';

import 'tarefa.dart';

class Estatisticas extends StatelessWidget {
  final List<Tarefa> tarefas;

  const Estatisticas({super.key, required this.tarefas});

  @override
  Widget build(BuildContext context) {
    final total = tarefas.length;
    final concluidas = tarefas.where((t) => t.concluida).length;
    final pendentes = total - concluidas;

    final progresso = total == 0 ? 0.0 : concluidas / total;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estatísticas',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF124B3A),
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Acompanha o teu progresso.',
              style: TextStyle(color: Color(0xFF557368)),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: _cartao('Total', total.toString(), Icons.list_alt),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _cartao(
                    'Concluídas',
                    concluidas.toString(),
                    Icons.check_circle_outline,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _cartao(
                    'Pendentes',
                    pendentes.toString(),
                    Icons.pending_actions,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _cartao(
                    'Progresso',
                    '${(progresso * 100).round()}%',
                    Icons.trending_up,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Progresso geral',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF173D32),
              ),
            ),

            const SizedBox(height: 15),

            LinearProgressIndicator(
              value: progresso,
              minHeight: 12,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: const Color(0xFFDCEAE2),
              color: const Color(0xFF20845F),
            ),

            const SizedBox(height: 12),

            Text(
              '$concluidas de $total tarefas concluídas',
              style: const TextStyle(color: Color(0xFF557368)),
            ),

            const Spacer(),

            if (total == 0)
              const Center(
                child: Text(
                  'Adiciona tarefas para veres as tuas estatísticas.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF557368)),
                ),
              ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _cartao(String titulo, String valor, IconData icone) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icone, color: const Color(0xFF20845F), size: 28),

          const SizedBox(height: 15),

          Text(
            valor,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xFF124B3A),
            ),
          ),

          const SizedBox(height: 5),

          Text(titulo, style: const TextStyle(color: Color(0xFF557368))),
        ],
      ),
    );
  }
}
