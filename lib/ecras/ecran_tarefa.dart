import 'package:flutter/material.dart';

import '../dados/estado_app.dart';
import '../modelos/tarefa.dart';
import '../utilitarios/datas.dart';
import '../utilitarios/validacoes.dart';
import '../widgets/botao_principal.dart';
import '../widgets/campo_formulario.dart';

// Formulário usado tanto para adicionar como para editar uma tarefa.
class EcranTarefa extends StatefulWidget {
  final Tarefa? tarefa; // se vier preenchida, estamos a editar
  final DateTime? dataInicial; // dia sugerido para uma tarefa nova

  const EcranTarefa({super.key, this.tarefa, this.dataInicial});

  @override
  State<EcranTarefa> createState() => _EcranTarefaState();
}

class _EcranTarefaState extends State<EcranTarefa> {
  final _formulario = GlobalKey<FormState>();
  late final TextEditingController _titulo;
  late final TextEditingController _descricao;
  late DateTime _data;
  late String _categoria;
  late String _prioridade;
  late String _estado;

  bool get _aEditar => widget.tarefa != null;

  @override
  void initState() {
    super.initState();
    final tarefa = widget.tarefa;
    final agora = DateTime.now();
    final dia = widget.dataInicial ?? agora;

    _titulo = TextEditingController(text: tarefa?.titulo ?? '');
    _descricao = TextEditingController(text: tarefa?.descricao ?? '');
    _data = tarefa?.data ??
        DateTime(dia.year, dia.month, dia.day, agora.hour, agora.minute);
    _categoria = tarefa?.categoria ?? categorias.first;
    _prioridade = tarefa?.prioridade ?? 'Média';
    _estado = tarefa?.estado ?? estados.first;
  }

  @override
  void dispose() {
    _titulo.dispose();
    _descricao.dispose();
    super.dispose();
  }

  Future<void> _escolherData() async {
    final escolhida = await showDatePicker(
      context: context,
      initialDate: _data,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (escolhida == null) return;
    setState(() {
      _data = DateTime(
        escolhida.year,
        escolhida.month,
        escolhida.day,
        _data.hour,
        _data.minute,
      );
    });
  }

  Future<void> _escolherHora() async {
    final escolhida = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_data),
      builder: (context, filho) {
        // Mostra a hora em formato 24 horas.
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: filho!,
        );
      },
    );
    if (escolhida == null) return;
    setState(() {
      _data = DateTime(
        _data.year,
        _data.month,
        _data.day,
        escolhida.hour,
        escolhida.minute,
      );
    });
  }

  // Valida o formulário e grava a tarefa (nova ou editada).
  Future<void> _guardar() async {
    if (!_formulario.currentState!.validate()) return;

    final tarefa = Tarefa(
      id: widget.tarefa?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      titulo: _titulo.text.trim(),
      descricao: _descricao.text.trim(),
      categoria: _categoria,
      data: _data,
      prioridade: _prioridade,
      estado: _estado,
    );
    await EstadoApp.instancia.guardarTarefa(tarefa);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_aEditar ? 'Tarefa atualizada.' : 'Tarefa adicionada.')),
    );
    Navigator.pop(context);
  }

  // Pede confirmação antes de remover.
  Future<void> _remover() async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (contexto) => AlertDialog(
        title: const Text('Remover tarefa?'),
        content: const Text('Esta ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(contexto, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(contexto, true),
            child: const Text('Remover'),
          ),
        ],
      ),
    );
    if (confirmado != true) return;

    await EstadoApp.instancia.removerTarefa(widget.tarefa!.id);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tarefa removida.')),
    );
    Navigator.pop(context);
  }

  // Lista de escolha reutilizada para categoria, prioridade e estado.
  Widget _lista(
    String rotulo,
    IconData icone,
    List<String> opcoes,
    String atual,
    ValueChanged<String> aoMudar,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        initialValue: atual,
        decoration: InputDecoration(
          labelText: rotulo,
          prefixIcon: Icon(icone),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
        items: opcoes
            .map((o) => DropdownMenuItem(value: o, child: Text(o)))
            .toList(),
        onChanged: (valor) => aoMudar(valor!),
      ),
    );
  }

  // Botão que mostra a data ou a hora e abre o seletor.
  Widget _botaoSeletor(IconData icone, String texto, VoidCallback aoCarregar) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      icon: Icon(icone),
      label: Text(texto),
      onPressed: aoCarregar,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Text(
          _aEditar ? 'Editar tarefa' : 'Adicionar tarefa',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (_aEditar)
            IconButton(
              tooltip: 'Remover',
              icon: const Icon(Icons.delete_outline),
              onPressed: _remover,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Form(
          key: _formulario,
          child: Column(
            children: [
              CampoFormulario(
                rotulo: 'Título da tarefa *',
                dica: 'Ex: Estudar Java',
                controlador: _titulo,
                validador: validarObrigatorio,
              ),
              CampoFormulario(
                rotulo: 'Descrição (opcional)',
                dica: 'Ex: Rever os exercícios da aula...',
                controlador: _descricao,
                linhas: 3,
              ),
              _lista('Categoria', Icons.folder_outlined, categorias, _categoria,
                  (v) => _categoria = v),
              Row(
                children: [
                  Expanded(
                    child: _botaoSeletor(
                      Icons.calendar_today_outlined,
                      textoData(_data),
                      _escolherData,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _botaoSeletor(
                      Icons.schedule,
                      textoHora(_data),
                      _escolherHora,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _lista('Prioridade', Icons.flag_outlined, prioridades, _prioridade,
                  (v) => _prioridade = v),
              _lista('Status', Icons.timelapse, estados, _estado,
                  (v) => _estado = v),
              const SizedBox(height: 6),
              BotaoPrincipal(texto: 'Guardar', aoCarregar: _guardar),
            ],
          ),
        ),
      ),
    );
  }
}