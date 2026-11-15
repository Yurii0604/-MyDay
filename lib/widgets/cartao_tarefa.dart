import 'package:flutter/material.dart';

import '../dados/estado_app.dart';
import '../modelos/tarefa.dart';
import '../utilitarios/datas.dart';

// Cor associada a cada prioridade.
Color corPrioridade(String prioridade) {
  switch (prioridade) {
    case 'Alta':
      return Colors.red;
    case 'Média':
      return Colors.orange;
    default:
      return Colors.green;
  }
}

// Cartão de uma tarefa: o círculo conclui e o resto abre a edição.
class CartaoTarefa extends StatelessWidget {
  final Tarefa tarefa;

  const CartaoTarefa({super.key, required this.tarefa});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    // Uma tarefa por concluir cuja hora já passou está atrasada.
    final atrasada = !tarefa.concluida && tarefa.data.isBefore(DateTime.now());

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
        title: Text(
          tarefa.titulo,
          style: TextStyle(
            decoration: tarefa.concluida ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          '${textoDiaRelativo(tarefa.data)}, ${textoHora(tarefa.data)} · ${tarefa.categoria}'
          '${atrasada ? ' · Atrasada' : ''}',
          style: TextStyle(color: atrasada ? Colors.red : null),
        ),
        trailing: Tooltip(
          message: 'Prioridade ${tarefa.prioridade}',
          child: Icon(
            Icons.flag,
            size: 20,
            color: corPrioridade(tarefa.prioridade),
          ),
        ),
        onTap: () => Navigator.pushNamed(context, '/tarefa', arguments: tarefa),
      ),
    );
  }
}