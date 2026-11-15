class Tarefa {
  String tema;
  String descricao;
  String categoria;
  String prioridade;
  DateTime data;
  bool concluida;

  Tarefa({
    required this.tema,
    required this.descricao,
    required this.categoria,
    required this.prioridade,
    required this.data,
    this.concluida = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'tema': tema,
      'descricao': descricao,
      'categoria': categoria,
      'prioridade': prioridade,
      'data': data.toIso8601String(),
      'concluida': concluida,
    };
  }

  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
      tema: json['tema'],
      descricao: json['descricao'],
      categoria: json['categoria'],
      prioridade: json['prioridade'],
      data: DateTime.parse(json['data']),
      concluida: json['concluida'],
    );
  }
}
