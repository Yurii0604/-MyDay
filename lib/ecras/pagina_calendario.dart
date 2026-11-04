import 'package:flutter/material.dart';

import '../dados/estado_app.dart';
import '../utilitarios/datas.dart';
import '../widgets/cartao_tarefa.dart';

class PaginaCalendario extends StatefulWidget {
  const PaginaCalendario({super.key});

  @override
  State<PaginaCalendario> createState() => _PaginaCalendarioState();
}

class _PaginaCalendarioState extends State<PaginaCalendario> {
  DateTime _mes = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime _selecionado = DateTime.now();

  void _mudarMes(int diferenca) {
    setState(() => _mes = DateTime(_mes.year, _mes.month + diferenca));
  }

  String _tituloMes() {
    final nome = meses[_mes.month - 1];
    return '${nome[0].toUpperCase()}${nome.substring(1)} ${_mes.year}';
  }

  Widget _celula(int dia, ColorScheme cores) {
    final data = DateTime(_mes.year, _mes.month, dia);
    final ativo = mesmoDia(data, _selecionado);
    final hoje = mesmoDia(data, DateTime.now());
    final temTarefas = EstadoApp.instancia.tarefasDoDia(data).isNotEmpty;

    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () => setState(() => _selecionado = data),
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ativo ? cores.primary : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              '$dia',
              style: TextStyle(
                fontWeight: ativo || hoje ? FontWeight.bold : FontWeight.normal,
                color: ativo ? cores.onPrimary : (hoje ? cores.primary : null),
              ),
            ),
            if (temTarefas)
              Positioned(
                bottom: 5,
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ativo ? cores.onPrimary : cores.primary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _grelha(ColorScheme cores) {
    final vazios = _mes.weekday - 1;
    final totalDias = DateTime(_mes.year, _mes.month + 1, 0).day;

    return Column(
      children: [
        Row(
          children: [
            for (final d in const ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'])
              Expanded(
                child: Center(child: Text(d, style: const TextStyle(fontSize: 12))),
              ),
          ],
        ),
        const SizedBox(height: 6),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (var i = 0; i < vazios; i++) const SizedBox.shrink(),
            for (var dia = 1; dia <= totalDias; dia++) _celula(dia, cores),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final estado = EstadoApp.instancia;
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar tarefa',
        shape: const CircleBorder(),
        // Passa o dia escolhido para o formulário.
        onPressed: () =>
            Navigator.pushNamed(context, '/tarefa', arguments: _selecionado),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: estado,
          builder: (context, _) {
            final doDia = estado.tarefasDoDia(_selecionado);

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              children: [
                const Text(
                  'Calendário',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      tooltip: 'Mês anterior',
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () => _mudarMes(-1),
                    ),
                    Expanded(
                      child: Text(
                        _tituloMes(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Mês seguinte',
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () => _mudarMes(1),
                    ),
                  ],
                ),
                _grelha(cores),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Tarefas do dia',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(doDia.length == 1 ? '1 tarefa' : '${doDia.length} tarefas'),
                  ],
                ),
                const SizedBox(height: 10),
                if (doDia.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('Não há tarefas neste dia.'),
                  ),
                for (final tarefa in doDia) CartaoTarefa(tarefa: tarefa),
                const SizedBox(height: 70), // espaço para o botão +
              ],
            );
          },
        ),
      ),
    );
  }
}