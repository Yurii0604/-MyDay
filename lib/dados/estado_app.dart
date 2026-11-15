import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modelos/tarefa.dart';

class EstadoApp extends ChangeNotifier {
  EstadoApp._();

  static final EstadoApp instancia = EstadoApp._();

  final ValueNotifier<bool> temaEscuro = ValueNotifier<bool>(false);

  Map<String, dynamic> _contas = {};
  String? _email;
  List<Tarefa> _tarefas = [];

  bool get autenticado => _email != null;
  String get email => _email ?? '';
  List<Tarefa> get tarefas => List.unmodifiable(_tarefas);

  String get nome {
    final conta = _contas[_email] as Map<String, dynamic>?;
    return (conta?['nome'] as String?) ?? '';
  }

  Future<void> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    temaEscuro.value = prefs.getBool('temaEscuro') ?? false;
    _contas = jsonDecode(prefs.getString('contas') ?? '{}') as Map<String, dynamic>;

    final sessao = prefs.getString('sessao');
    if (sessao != null && _contas.containsKey(sessao)) {
      _email = sessao;
      _lerTarefas(prefs);
    }
  }

 Future<String?> registar(String nome, String email, String palavraPasse) async {
    final emailLimpo = email.trim().toLowerCase();
    if (_contas.containsKey(emailLimpo)) {
      return 'Já existe uma conta com este email.';
    }

    final prefs = await SharedPreferences.getInstance();
    _contas[emailLimpo] = <String, dynamic>{
      'nome': nome.trim(),
      'hash': _resumo(emailLimpo, palavraPasse),
    };
    await prefs.setString('contas', jsonEncode(_contas));
    await _iniciarSessao(prefs, emailLimpo);
    return null;
  }

  Future<String?> entrar(String email, String palavraPasse) async {
    final emailLimpo = email.trim().toLowerCase();
    final conta = _contas[emailLimpo] as Map<String, dynamic>?;
    if (conta == null || conta['hash'] != _resumo(emailLimpo, palavraPasse)) {
      return 'Email ou palavra-passe incorretos.';
    }

    final prefs = await SharedPreferences.getInstance();
    await _iniciarSessao(prefs, emailLimpo);
    return null;
  }

  Future<void> sair() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessao');
    _email = null;
    _tarefas = [];
    notifyListeners();
  }

  Future<void> atualizarNome(String novoNome) async {
    final prefs = await SharedPreferences.getInstance();
    final conta = _contas[_email] as Map<String, dynamic>;
    conta['nome'] = novoNome.trim();
    await prefs.setString('contas', jsonEncode(_contas));
    notifyListeners();
  }

  Future<void> definirTemaEscuro(bool ativo) async {
    temaEscuro.value = ativo;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('temaEscuro', ativo);
  }

  Future<void> guardarTarefa(Tarefa tarefa) async {
    final posicao = _tarefas.indexWhere((t) => t.id == tarefa.id);
    if (posicao >= 0) {
      _tarefas[posicao] = tarefa;
    } else {
      _tarefas.add(tarefa);
    }
    await _gravarTarefas();
  }

  Future<void> removerTarefa(String id) async {
    _tarefas.removeWhere((t) => t.id == id);
    await _gravarTarefas();
  }

  Future<void> alternarConcluida(Tarefa tarefa) async {
    await guardarTarefa(tarefa.comEstado(tarefa.concluida ? 'Pendente' : 'Concluída'));
  }

  List<Tarefa> tarefasDoDia(DateTime dia) {
    return _tarefas
        .where((t) =>
            t.data.year == dia.year && t.data.month == dia.month && t.data.day == dia.day)
        .toList();
  }

  Future<void> _iniciarSessao(SharedPreferences prefs, String email) async {
    _email = email;
    await prefs.setString('sessao', email);
    _lerTarefas(prefs);
    notifyListeners();
  }

  void _lerTarefas(SharedPreferences prefs) {
    final texto = prefs.getString('tarefas_$_email') ?? '[]';
    final lista = jsonDecode(texto) as List<dynamic>;
    _tarefas = lista.map((e) => Tarefa.deJson(e as Map<String, dynamic>)).toList();
    _ordenar();
  }

  Future<void> _gravarTarefas() async {
    _ordenar();
    final prefs = await SharedPreferences.getInstance();
    final texto = jsonEncode(_tarefas.map((t) => t.paraJson()).toList());
    await prefs.setString('tarefas_$_email', texto);
    notifyListeners();
  }

  void _ordenar() {
    _tarefas.sort((a, b) => a.data.compareTo(b.data));
  }

  String _resumo(String email, String palavraPasse) {
    return sha256.convert(utf8.encode('$email:$palavraPasse')).toString();
  }
}