import 'package:flutter/material.dart';

import '../dados/estado_app.dart';
import '../modelos/tarefa.dart';
import '../utilitarios/datas.dart';

class CartaoTarefa extends StatelessWidget {
  final Tarefa tarefa;

  const CartaoTarefa({super.key, required this.tarefa});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cores.outlineVariant),
      ),
      child: ListTile(
        leading: IconButton(
          tooltip: tarefa.concluida ? 'Marcar como pendente' : 'Marcar como concluída',
          icon: Icon(
            tarefa.concluida ? Icons.check_circle : Icons.radio_button_unchecked,
            color: cores.primary,
          ),
          onPressed: () => EstadoApp.instancia.alternarConcluida(tarefa),
        ),
        title: Text(tarefa.titulo),
        subtitle: Text(
          '${textoDiaRelativo(tarefa.data)}, ${textoHora(tarefa.data)} · ${tarefa.categoria}',
        ),
        onTap: () => Navigator.pushNamed(context, '/tarefa', arguments: tarefa),
      ),
    );
  }
}