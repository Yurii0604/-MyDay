import 'package:flutter/material.dart';
import 'dados/estado_app.dart';
import 'ecran_inicial.dart';
import 'ecras/ecran_registo.dart';
import 'tema.dart';
import 'ecras/ecran_login.dart';
import 'ecras/ecran_recuperar.dart';

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
    return const Scaffold(
      body: Center(child: Text('Ecrã principal em construção')),
    );
  }
}
