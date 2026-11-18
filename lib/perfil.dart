import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  final String nomeUtilizador;
  final String emailUtilizador;

  const Perfil({
    super.key,
    required this.nomeUtilizador,
    required this.emailUtilizador,
  });

  @override
  Widget build(BuildContext context) {
    const verde = Color(0xFF20845F);
    const escuro = Color(0xFF124B3A);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Perfil',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: escuro,
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: Column(
                children: [
                  Container(
                    width: 105,
                    height: 105,
                    decoration: const BoxDecoration(
                      color: Color(0xFFDCEFE5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, size: 60, color: verde),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    nomeUtilizador,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: escuro,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    emailUtilizador,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF557368),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              'Definições',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF173D32),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFFE6EFEB)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_outline, color: verde),
                    title: const Text(
                      'Editar perfil',
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF8A9B93),
                    ),
                    onTap: () {},
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(
                      Icons.light_mode_outlined,
                      color: verde,
                    ),
                    title: const Text('Tema', style: TextStyle(fontSize: 14)),
                    trailing: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Claro',
                          style: TextStyle(
                            color: Color(0xFF8A9B93),
                            fontSize: 12,
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Color(0xFF8A9B93)),
                      ],
                    ),
                    onTap: () {},
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(Icons.notifications_none, color: verde),
                    title: const Text(
                      'Notificações',
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF8A9B93),
                    ),
                    onTap: () {},
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(Icons.lock_outline, color: verde),
                    title: const Text(
                      'Privacidade',
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF8A9B93),
                    ),
                    onTap: () {},
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(Icons.help_outline, color: verde),
                    title: const Text(
                      'Ajuda e suporte',
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF8A9B93),
                    ),
                    onTap: () {},
                  ),

                  const Divider(height: 1),

                  const ListTile(
                    leading: Icon(Icons.info_outline, color: verde),
                    title: Text(
                      'Sobre o MyDay',
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Color(0xFF8A9B93),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sessão terminada.')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  side: const BorderSide(color: Colors.redAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Terminar sessão',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                'MyDay © 2026',
                style: TextStyle(color: Color(0xFF8A9B93), fontSize: 12),
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
