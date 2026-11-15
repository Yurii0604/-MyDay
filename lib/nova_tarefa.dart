import 'package:flutter/material.dart';

import 'tarefa.dart';

class NovaTarefa extends StatefulWidget {
  const NovaTarefa({super.key});

  @override
  State<NovaTarefa> createState() => _NovaTarefaState();
}

class _NovaTarefaState extends State<NovaTarefa> {
  final temaController = TextEditingController();
  final descricaoController = TextEditingController();
  final categoriaController = TextEditingController();

  String categoria = 'Estudo';
  String prioridade = 'Média';
  DateTime data = DateTime.now();

  @override
  void dispose() {
    temaController.dispose();
    descricaoController.dispose();
    categoriaController.dispose();
    super.dispose();
  }

  Future<void> escolherData() async {
    final escolhida = await showDatePicker(
      context: context,
      initialDate: data,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (escolhida != null) {
      setState(() {
        data = escolhida;
      });
    }
  }

  void guardar() {
    if (temaController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Introduz o tema.')));
      return;
    }

    if (categoria == 'Outra' && categoriaController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Introduz a categoria.')));
      return;
    }

    final tarefa = Tarefa(
      tema: temaController.text.trim(),
      descricao: descricaoController.text.trim(),
      categoria: categoria == 'Outra'
          ? categoriaController.text.trim()
          : categoria,
      prioridade: prioridade,
      data: data,
    );

    Navigator.pop(context, tarefa);
  }

  @override
  Widget build(BuildContext context) {
    const verde = Color(0xFF20845F);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F6),
      appBar: AppBar(
        title: const Text('Nova tarefa'),
        backgroundColor: const Color(0xFFF5F8F6),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Criar uma tarefa',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF124B3A),
              ),
            ),

            const SizedBox(height: 25),

            const Text('Tema'),
            const SizedBox(height: 8),

            TextField(
              controller: temaController,
              decoration: const InputDecoration(
                hintText: 'Ex.: Estudar Java',
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            const Text('Descrição'),
            const SizedBox(height: 8),

            TextField(
              controller: descricaoController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Descrição da tarefa...',
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            const Text('Categoria'),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: categoria,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
              ),
              items:
                  [
                    'Estudo',
                    'Trabalho',
                    'Pessoal',
                    'Saúde',
                    'Desporto',
                    'Outra',
                  ].map((item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
              onChanged: (valor) {
                setState(() => categoria = valor!);
              },
            ),

            if (categoria == 'Outra') ...[
              const SizedBox(height: 12),
              TextField(
                controller: categoriaController,
                decoration: const InputDecoration(
                  hintText: 'Nome da categoria',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ],

            const SizedBox(height: 20),

            const Text('Prioridade'),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: prioridade,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
              ),
              items: ['Baixa', 'Média', 'Alta'].map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: (valor) {
                setState(() => prioridade = valor!);
              },
            ),

            const SizedBox(height: 20),

            const Text('Data'),
            const SizedBox(height: 8),

            ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: const Icon(Icons.calendar_month, color: verde),
              title: Text('${data.day}/${data.month}/${data.year}'),
              trailing: const Icon(Icons.edit_calendar),
              onTap: escolherData,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: guardar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: verde,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Guardar tarefa'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
