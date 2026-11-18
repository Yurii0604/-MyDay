class Tarefa {
  String tema;
  String descricao;
  String categoria;
  String prioridade;
  DateTime data;
  String hora;
  bool concluida;

  Tarefa({
    required this.tema,
    required this.descricao,
    required this.categoria,
    required this.prioridade,
    required this.data,
    this.hora = '09:00',
    this.concluida = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'tema': tema,
      'descricao': descricao,
      'categoria': categoria,
      'prioridade': prioridade,
      'data': data.toIso8601String(),
      'hora': hora,
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
      hora: json['hora'] ?? '09:00',
      concluida: json['concluida'] ?? false,
    );
  }
}
