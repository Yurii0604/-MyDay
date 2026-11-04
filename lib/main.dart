import 'package:flutter/material.dart';
import 'dados/estado_app.dart';
import 'ecran_inicial.dart';
import 'ecras/ecran_registo.dart';
import 'tema.dart';
import 'ecras/ecran_login.dart';
import 'ecras/ecran_recuperar.dart';
import 'ecras/ecran_tarefa.dart';
import 'modelos/tarefa.dart';
import 'widgets/cartao_tarefa.dart';

Future<void> main() async {
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
          home: estado.autenticado ? const _EmConstrucao() : const EcranInicial(),
          routes: {
            '/inicial': (context) => const EcranInicial(),
            '/registo': (context) => const EcranRegisto(),
            '/login': (context) => const EcranLogin(),
            '/recuperar': (context) => const EcranRecuperar(),
            '/principal': (context) => const _EmConstrucao(),
            '/tarefa': (context) {
              // Recebe a tarefa a editar, ou a data de uma tarefa nova.
              final argumento = ModalRoute.of(context)?.settings.arguments;
              return EcranTarefa(
                tarefa: argumento is Tarefa ? argumento : null,
                dataInicial: argumento is DateTime ? argumento : null,
              );
            },
          },
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

class _EmConstrucao extends StatelessWidget {
  const _EmConstrucao();

  @override
  Widget build(BuildContext context) {
    final estado = EstadoApp.instancia;

    return Scaffold(
      appBar: AppBar(title: const Text('Tarefas (provisório)')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar tarefa',
        onPressed: () => Navigator.pushNamed(context, '/tarefa'),
        child: const Icon(Icons.add),
      ),
      body: ListenableBuilder(
        listenable: estado,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [for (final t in estado.tarefas) CartaoTarefa(tarefa: t)],
          );
        },
      ),
    );
  }
}