import 'package:flutter_test/flutter_test.dart';
import 'package:my_day/main.dart';
import 'package:my_day/modelos/tarefa.dart';

void main() {
  testWidgets('A app abre no ecrã inicial', (tester) async {
    await tester.pumpWidget(const MyDay());
    expect(find.text('MyDay'), findsOneWidget);
  });

  test('A tarefa converte-se para JSON e volta igual', () {
    final original = Tarefa(
      id: '1',
      titulo: 'Estudar Java',
      descricao: 'Rever os exercícios',
      categoria: 'Estudo',
      data: DateTime(2026, 11, 4, 10, 0),
      prioridade: 'Média',
      estado: 'Pendente',
    );

    final copia = Tarefa.deJson(original.paraJson());

    expect(copia.titulo, original.titulo);
    expect(copia.data, original.data);
    expect(copia.estado, 'Pendente');
  });
}