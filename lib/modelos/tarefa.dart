const List<String> categorias = ['Estudo', 'Saúde', 'Compras', 'Trabalho', 'Pessoal'];
const List<String> prioridades = ['Baixa', 'Média', 'Alta'];
const List<String> estados = ['Pendente', 'Em curso', 'Concluída'];

class Tarefa {
  final String id;
  final String titulo;
  final String descricao;
  final String categoria;
  final DateTime data;
  final String prioridade;
  final String estado;

  const Tarefa({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.categoria,
    required this.data,
    required this.prioridade,
    required this.estado,
  });

  bool get concluida => estado == 'Concluída';

  Tarefa comEstado(String novoEstado) {
    return Tarefa(
      id: id,
      titulo: titulo,
      descricao: descricao,
      categoria: categoria,
      data: data,
      prioridade: prioridade,
      estado: novoEstado,
    );
  }

  Map<String, dynamic> paraJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'categoria': categoria,
      'data': data.toIso8601String(),
      'prioridade': prioridade,
      'estado': estado,
    };
  }

  factory Tarefa.deJson(Map<String, dynamic> json) {
    return Tarefa(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String,
      categoria: json['categoria'] as String,
      data: DateTime.parse(json['data'] as String),
      prioridade: json['prioridade'] as String,
      estado: json['estado'] as String,
    );
  }
}