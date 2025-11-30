
import '../model/lineaProducto.dart';
import '../model/producto.dart';

class Seleccionproductosviewmodel {

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

  //Cantidades del usuario
  final Map<Producto, int> cantidades = {};

  //Transformar map a lista
  List<LineaProducto> construirLineas(){
    return cantidades.entries
      .where((entry) => entry.value >0)
      .map((entry) => LineaProducto(producto: entry.key, cantidad: entry.value,
      ))
      .toList();
  }

  //Incrementar cantidad
  void incrementar(Producto producto){
    cantidades[producto] = (cantidades[producto]?? 0) + 1;
  }

  //Decrementar cntidad
  void decrementar(Producto producto){
      final actual = cantidades[producto]?? 0;
      if(actual > 0){
        cantidades[producto] = actual - 1;
      }
  }
  
  //Cantidad producto
  int getCantidad(Producto producto){
    return cantidades[producto] ?? 0;
  }
}