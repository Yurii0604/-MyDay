import 'package:flutter/material.dart';

import '../dados/estado_app.dart';
import '../utilitarios/datas.dart';
import '../widgets/anel_progresso.dart';
import '../widgets/cartao_tarefa.dart';

class PaginaInicio extends StatelessWidget {
  const PaginaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    final estado = EstadoApp.instancia;
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar tarefa',
        shape: const CircleBorder(),
        onPressed: () => Navigator.pushNamed(context, '/tarefa'),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        
        child: ListenableBuilder(
          listenable: estado,
          builder: (context, _) {
            final hoje = estado.tarefasDoDia(DateTime.now());
            final feitas = hoje.where((t) => t.concluida).length;
            final progresso = hoje.isEmpty ? 0.0 : feitas / hoje.length;
            final primeiroNome = estado.nome.trim().split(' ').first;

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            primeiroNome.isEmpty ? 'Olá!' : 'Olá, $primeiroNome!',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(textoDataLonga(DateTime.now())),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: cores.primaryContainer,
                      child: Text(
                        primeiroNome.isEmpty ? '?' : primeiroNome[0].toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: cores.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: cores.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      AnelProgresso(valor: progresso),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$feitas de ${hoje.length} tarefas',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text('concluídas'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Tarefas de hoje',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/tarefas'),
                      child: const Text('Ver todas'),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                if (hoje.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'Não tens tarefas para hoje.\nCarrega em + para adicionar.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                for (final tarefa in hoje) CartaoTarefa(tarefa: tarefa),
                const SizedBox(height: 70),
              ],
            );
          },
        ),
      ),
    );
  }
}