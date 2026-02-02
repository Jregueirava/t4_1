
import '../model/lineaProducto.dart';
import '../model/producto.dart';


/// ViewModel de la pantalla de selección de productos.
/// 
/// Contiene la carta de productos y guarda las cantidades elegidas por el usario.
/// Después construye una lista de [LineaProducto] con solo los productos con cantidad > 0.
class Seleccionproductosviewmodel {

/// Carta de productos disponibles.
  //Carta
  final List<Producto> carta = [
    Producto(nombre: "Agua", precio: 1.50),
    Producto(nombre: "Cocola", precio: 2.00),
    Producto(nombre: "Nestea", precio: 2.00),
    Producto(nombre: "Aquarius", precio: 2.00),
    Producto(nombre: "CervezaEstrella", precio: 2.50),
    Producto(nombre: "Cerveza1009", precio: 2.80),
    Producto(nombre: "Tortilla", precio: 3.50),
    Producto(nombre: "Calamares", precio: 4.00),
    Producto(nombre: "FingersDePollo", precio: 3.50),
  ];

/// Cantidades seleccionadas por el usuario.
/// 
/// La clave es el [Producto] y el valor es la cantidad.
  //Cantidades del usuario
  final Map<Producto, int> cantidades = {};

/// Construye las líneas del pedido a partir de [cantidades].
/// 
/// Solo incluye productos cuya cantidad sea mayor que 0.
  //Transformar map a lista
  List<LineaProducto> construirLineas(){
    return cantidades.entries
      .where((entry) => entry.value >0)
      .map((entry) => LineaProducto(producto: entry.key, cantidad: entry.value,
      ))
      .toList();
  }

/// Incrementa en 1 la cantidad del  [producto].
  //Incrementar cantidad
  void incrementar(Producto producto){
    cantidades[producto] = (cantidades[producto]?? 0) + 1;
  }

/// Decrementa en 1 la cantidad del [producto] sin bajar de 0.
  //Decrementar cntidad
  void decrementar(Producto producto){
      final actual = cantidades[producto]?? 0;
      if(actual > 0){
        cantidades[producto] = actual - 1;
      }
  }
  
  /// Devuelve la cantidad actual seleccionada del [producto].
  //Cantidad producto
  int getCantidad(Producto producto){
    return cantidades[producto] ?? 0;
  }
}