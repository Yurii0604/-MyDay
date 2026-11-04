import 'package:flutter/material.dart';

import '../dados/estado_app.dart';
import '../widgets/cartao_tarefa.dart';

class EcranTodasTarefas extends StatelessWidget {
  const EcranTodasTarefas({super.key});

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
      body: ListenableBuilder(
        listenable: estado,
        builder: (context, _) {
          if (estado.tarefas.isEmpty) {
            return const Center(child: Text('Ainda não tens tarefas.'));
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final tarefa in estado.tarefas) CartaoTarefa(tarefa: tarefa),
            ],
          );
        },
      ),
    );
  }
}