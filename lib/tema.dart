import 'package:flutter/material.dart';

const Color verdeMyDay = Color(0xFF20845F);

final ThemeData temaClaro = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(seedColor: verdeMyDay, primary: verdeMyDay),
);

final ThemeData temaEscuroApp = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFF0F2119),
  colorScheme: ColorScheme.fromSeed(
    seedColor: verdeMyDay,
    brightness: Brightness.dark,
  ),
);