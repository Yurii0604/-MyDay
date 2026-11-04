import 'package:flutter/material.dart';
import 'pagina_calendario.dart';
import 'pagina_estatisticas.dart';
import 'pagina_inicio.dart';

class EcranPrincipal extends StatefulWidget {
  const EcranPrincipal({super.key});

  @override
  State<EcranPrincipal> createState() => _EcranPrincipalState();
}

class _EcranPrincipalState extends State<EcranPrincipal> {
 
  int _indice = 0;

  static const List<Widget> _paginas = [
    PaginaInicio(),
    PaginaCalendario(),
    PaginaEstatisticas(),
    _Provisorio('Perfil'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginas[_indice],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indice,
        onDestinationSelected: (indice) => setState(() => _indice = indice),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Calendário',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Estatísticas',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class _Provisorio extends StatelessWidget {
  final String texto;

  const _Provisorio(this.texto);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('$texto (em construção)'));
  }
}