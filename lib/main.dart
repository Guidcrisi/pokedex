import 'package:flutter/material.dart';
import 'package:pokedex/ui/home_page.dart';
import 'package:pokedex/ui/splash_page.dart';

Future<void> main() async {
//Inicia o app
  runApp(app());
}

class app extends StatelessWidget {
  static Color vermelho = const Color(0xFFDC0A2D);
  static Color azul = const Color(0xFF28AAFE);
  static Color cinza = const Color(0xFFDEDEDE);

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
