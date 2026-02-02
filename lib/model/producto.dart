/// Representa un producto de la carta del bar.
/// 
/// Un [Producto]  tiene un [nombre] visible para el usario y un [precio]
/// por unidad.

class Producto{
  /// Nombre del producto (por ejemplo: "Agua", "Tortilla").
  final String nombre;
  /// Precio por unidad del producto.
  final double precio;

  /// Crea un producto con [nombre] y [precio].
  const Producto({
    required this.nombre,
    required this.precio,
  });
}