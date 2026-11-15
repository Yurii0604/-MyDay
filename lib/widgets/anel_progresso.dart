import 'package:flutter/material.dart';

class AnelProgresso extends StatelessWidget {
  final double valor;

  const AnelProgresso({super.key, required this.valor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      height: 76,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: valor,
            strokeWidth: 8,
            strokeCap: StrokeCap.round,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          Center(
            child: Text(
              '${(valor * 100).round()}%',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}