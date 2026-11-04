import 'package:flutter/material.dart';

class SeccaoGoogle extends StatelessWidget {
  const SeccaoGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Row(
          children: [
            Expanded(child: Divider()),
            Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('ou')),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(shape: const StadiumBorder()),
            icon: const Icon(Icons.g_mobiledata, size: 30),
            label: const Text('Continuar com o Google'),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('O início de sessão com Google ainda não está disponível.')),
              );
            },
          ),
        ),
      ],
    );
  }
}