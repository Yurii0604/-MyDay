import 'package:flutter/material.dart';

import 'tarefa.dart';

class Calendario extends StatefulWidget {
  final List<Tarefa> tarefas;

  const Calendario({super.key, required this.tarefas});

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  DateTime dataSelecionada = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final tarefasDoDia = widget.tarefas.where((tarefa) {
      return tarefa.data.year == dataSelecionada.year &&
          tarefa.data.month == dataSelecionada.month &&
          tarefa.data.day == dataSelecionada.day;
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Calendário',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF124B3A),
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Organiza as tuas tarefas por data.',
              style: TextStyle(color: Color(0xFF557368)),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: CalendarDatePicker(
                initialDate: dataSelecionada,
                firstDate: DateTime(2020),
                lastDate: DateTime(2035),
                onDateChanged: (data) {
                  setState(() {
                    dataSelecionada = data;
                  });
                },
              ),
            ),

            const SizedBox(height: 25),

            Text(
              'Tarefas de ${dataSelecionada.day}/'
              '${dataSelecionada.month}/${dataSelecionada.year}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF173D32),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: tarefasDoDia.isEmpty
                  ? const Center(
                      child: Text(
                        'Não existem tarefas para esta data.',
                        style: TextStyle(color: Color(0xFF557368)),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tarefasDoDia.length,
                      itemBuilder: (context, index) {
                        final tarefa = tarefasDoDia[index];

                        return Card(
                          color: Colors.white,
                          elevation: 0,
                          child: ListTile(
                            leading: Icon(
                              tarefa.concluida
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: const Color(0xFF20845F),
                            ),
                            title: Text(tarefa.tema),
                            subtitle: Text(
                              '${tarefa.categoria} • ${tarefa.prioridade}',
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
}
