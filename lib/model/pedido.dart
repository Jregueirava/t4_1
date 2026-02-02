

import 'lineaProducto.dart';

/// Representa un pedido del bar asociado a una mesa o aun nombre de cliente.
/// 
/// Un [Pedido] contiene varias líneas de producto ([LienaProducto]) con cantidades.
class Pedido {
/// Identificador visible para el camarero: número de mesa o nombre del cliente.
  final String mesaONombre;
/// Lista de líneas (producto + cantidad) incluidad en el pedido.
  final List<LineaProducto> lineas;

/// Crea un pedido con [mesaONombre] y sus [lineas].
  const Pedido({
    required this.mesaONombre,
    required this.lineas,
  });

/// Devuelve el número total de producto sumando las cantitades de cada línea.

  int get numProductos => lineas.fold(0, (acc, linea) => acc + linea.cantidad);

/// Devuelve el importe total del pedido sumando los subtotales de cada línea.
  double get total => lineas.fold(0, (acc, linea) => acc + linea.subtotal);
}