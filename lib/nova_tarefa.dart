import 'package:flutter/material.dart';

import 'tarefa.dart';

class NovaTarefa extends StatefulWidget {
  final Tarefa? tarefa;

  const NovaTarefa({super.key, this.tarefa});

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
  void initState() {
    super.initState();

    if (widget.tarefa != null) {
      temaController.text = widget.tarefa!.tema;
      descricaoController.text = widget.tarefa!.descricao;
      categoria = widget.tarefa!.categoria;
      prioridade = widget.tarefa!.prioridade;
      data = widget.tarefa!.data;
    }
  }

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
    if (temaController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Introduz o tema.')));
      return;
    }

    if (categoria == 'Outra' && categoriaController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Introduz a categoria.')));
      return;
    }

    final tarefa = Tarefa(
      tema: temaController.text,
      descricao: descricaoController.text,
      categoria: categoria == 'Outra' ? categoriaController.text : categoria,
      prioridade: prioridade,
      data: data,
      hora: '',
      concluida: widget.tarefa?.concluida ?? false,
    );

    Navigator.pop(context, tarefa);
  }

  @override
  Widget build(BuildContext context) {
    const verde = Color(0xFF20845F);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F6),

      appBar: AppBar(
        title: Text(
          widget.tarefa == null ? 'Adicionar tarefa' : 'Editar tarefa',
        ),
        backgroundColor: const Color(0xFFF5F8F6),
        foregroundColor: const Color(0xFF124B3A),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.tarefa == null ? 'Criar uma tarefa' : 'Alterar tarefa',
              style: const TextStyle(
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
              decoration: InputDecoration(
                hintText: 'Ex.: Estudar Java',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text('Descrição'),
            const SizedBox(height: 8),

            TextField(
              controller: descricaoController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Descrição da tarefa...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text('Categoria'),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: categoria,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
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
                setState(() {
                  categoria = valor!;
                });
              },
            ),

            if (categoria == 'Outra') ...[
              const SizedBox(height: 12),

              TextField(
                controller: categoriaController,
                decoration: InputDecoration(
                  hintText: 'Nome da categoria',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 20),

            const Text('Data'),
            const SizedBox(height: 8),

            InkWell(
              onTap: escolherData,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month, color: verde),
                    const SizedBox(width: 10),
                    Text(
                      '${data.day.toString().padLeft(2, '0')}/'
                      '${data.month.toString().padLeft(2, '0')}/'
                      '${data.year}',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text('Prioridade'),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: prioridade,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              items: ['Baixa', 'Média', 'Alta'].map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: (valor) {
                setState(() {
                  prioridade = valor!;
                });
              },
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
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  widget.tarefa == null
                      ? 'Guardar tarefa'
                      : 'Guardar alterações',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
