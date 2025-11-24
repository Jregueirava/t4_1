import 'package:flutter/material.dart';
import 'view/home.dart';
import 'view/resumenPedido.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bar MVVM",
      routes: {
        "/resumen": (context) => const ResumenPedidoPage(),
      },
      home: const HomePage(),

    );
  }
}