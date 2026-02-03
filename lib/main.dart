import 'package:flutter/material.dart';
import 'view/home.dart';
import 'view/resumenPedido.dart';

/// Punto de entrada de la aplicación.
void main() {
  runApp(const MyApp());
}

/// Widget raíz de la aplicación.
/// 
/// Configura el título, las rutas nombradas y la pantalla inicial.
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bar MVVM",
      //Ruta definida
      routes: {
        "/resumen": (context) => const ResumenPedidoPage(),
      },
      home: const Home(),

    );
  }
}