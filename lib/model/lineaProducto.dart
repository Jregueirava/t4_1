
import 'producto.dart';

class LineaProducto{
  final Producto producto;
  final int cantidad;

  const LineaProducto({
    required this.producto,
    required this.cantidad,
  });

  double get subtotal => producto.precio * cantidad;
}