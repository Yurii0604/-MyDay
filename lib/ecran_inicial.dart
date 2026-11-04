import 'package:flutter/material.dart';

class EcranInicial extends StatelessWidget {
  const EcranInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEAF8F0), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFD3F0DF),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(
                    Icons.eco_rounded,
                    size: 65,
                    color: Color(0xFF20845F),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'MyDay',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF124B3A),
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'O teu dia, organizado.',
                  style: TextStyle(fontSize: 14, color: Color(0xFF557368)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
