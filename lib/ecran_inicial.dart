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
        child: const SafeArea(
          child: Center(
            child: Text(
              'MyDay',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF124B3A),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
