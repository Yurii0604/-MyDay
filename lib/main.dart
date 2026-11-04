import 'package:flutter/material.dart';

import 'ecran_inicial.dart';

void main() {
  runApp(const MyDay());
}

class MyDay extends StatelessWidget {
  const MyDay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyDay',
      theme: ThemeData(useMaterial3: true, fontFamily: 'Roboto'),
      home: const EcranInicial(),
    );
  }
}
