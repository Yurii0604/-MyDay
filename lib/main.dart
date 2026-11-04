import 'package:flutter/material.dart';

import 'dados/estado_app.dart';
import 'ecran_inicial.dart';
import 'ecras/ecran_login.dart';
import 'ecras/ecran_principal.dart';
import 'ecras/ecran_recuperar.dart';
import 'ecras/ecran_registo.dart';
import 'ecras/ecran_tarefa.dart';
import 'ecras/ecran_todas_tarefas.dart';
import 'modelos/tarefa.dart';
import 'tema.dart';

Future<void> main() async {
  // Lê os dados guardados antes de abrir a aplicação.
  WidgetsFlutterBinding.ensureInitialized();
  await EstadoApp.instancia.carregar();
  runApp(const MyDay());
}

class MyDay extends StatelessWidget {
  const MyDay({super.key});

  @override
  Widget build(BuildContext context) {
    final estado = EstadoApp.instancia;

    return ValueListenableBuilder<bool>(
      valueListenable: estado.temaEscuro,
      builder: (context, escuro, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyDay',
          theme: temaClaro,
          darkTheme: temaEscuroApp,
          themeMode: escuro ? ThemeMode.dark : ThemeMode.light,
          // Se já houver sessão iniciada, abre logo o ecrã principal.
          home: estado.autenticado ? const EcranPrincipal() : const EcranInicial(),
          routes: {
            '/inicial': (context) => const EcranInicial(),
            '/registo': (context) => const EcranRegisto(),
            '/login': (context) => const EcranLogin(),
            '/recuperar': (context) => const EcranRecuperar(),
            '/principal': (context) => const EcranPrincipal(),
            '/tarefas': (context) => const EcranTodasTarefas(),
            '/tarefa': (context) {
              // Recebe a tarefa a editar, ou a data de uma tarefa nova.
              final argumento = ModalRoute.of(context)?.settings.arguments;
              return EcranTarefa(
                tarefa: argumento is Tarefa ? argumento : null,
                dataInicial: argumento is DateTime ? argumento : null,
              );
            },
          },
          // Em ecrãs largos, limita a largura para o conteúdo não esticar.
          builder: (context, filho) {
            return ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: filho,
                ),
              ),
            );
          },
        );
      },
    );
  }
}