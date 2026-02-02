
import 'producto.dart';

/// Línea de pedido: une un [Producto] con una [cantidad].
/// 
/// Se usa para calcular importes(por ejemplo, [subtotal]) y para contruir un [Pedido].
class LineaProducto{
/// Producto seleccionado por el usuario.
  final Producto producto;
/// Cantidad del producto(El número de unidades).
  final int cantidad;
/// Crear una línea con un [producto] y su [cantidad].
  const LineaProducto({
    required this.producto,
    required this.cantidad,
  });

/// Importe de esta línea: precio del producto por cantidad.
  double get subtotal => producto.precio * cantidad;
}