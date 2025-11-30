

import 'lineaProducto.dart';

class Pedido {
  final String mesaONombre;
  final List<LineaProducto> lineas;

  const Pedido({
    required this.mesaONombre,
    required this.lineas,
  });

  int get numProductos => lineas.fold(0, (acc, linea) => acc + linea.cantidad);

  double get total => lineas.fold(0, (acc, linea) => acc + linea.subtotal);
}