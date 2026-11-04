
const List<String> diasSemana = [
  'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo',
];
const List<String> meses = [
  'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho',
  'agosto', 'setembro', 'outubro', 'novembro', 'dezembro',
];

bool mesmoDia(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

String _doisDigitos(int valor) => valor.toString().padLeft(2, '0');

String textoHora(DateTime data) => '${_doisDigitos(data.hour)}:${_doisDigitos(data.minute)}';

String textoData(DateTime data) {
  return '${_doisDigitos(data.day)}/${_doisDigitos(data.month)}/${data.year}';
}

String textoDataLonga(DateTime data) {
  return '${diasSemana[data.weekday - 1]}, ${data.day} de ${meses[data.month - 1]}';
}

String textoDiaRelativo(DateTime data) {
  return mesmoDia(data, DateTime.now()) ? 'Hoje' : textoData(data);
}