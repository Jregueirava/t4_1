import 'package:t4_1/model/lineaProducto.dart';

class Pedido {
  final String mesaONobre;
  final List<LineaProducto> lineas;

  const Pedido({
    required this.mesaONobre,
    required this.lineas,
  });

  int get numProductos => lineas.fold(0, (acc, linea) => acc + linea.cantidad);

  double get total => lineas.fold(0, (acc, linea) => acc + linea.subtotal);
}