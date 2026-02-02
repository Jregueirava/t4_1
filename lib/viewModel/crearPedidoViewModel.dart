

import '../model/lineaProducto.dart';
import '../model/pedido.dart';

/// ViewModel para la pantalla de creación de pedidos.
/// 
/// Guarda el estado temporal (mesa/nombre y líneas) mientras el usario
/// construye el pedido, y expone cálculos y validación para la UI.
class Crearpedidoviewmodel {
/// Mesa o nombre del cliente escrito por el usario.
  String mesaONombre="";
  /// Líneas seleccionadas (producto + cantidad).
  List<LineaProducto> lineas = [];

/// Total de unidades sumando las cantidades de todas las [lineas].
  //Suma total productos
  int get numProductos => lineas.fold(0, (acc, listaproducto) => acc + listaproducto.cantidad);
/// Total del pedido sumando los subtotales de todas las [lineas].
  //Suma total pedido
  double get total => lineas.fold(0.0, (acc, listaproducto) => acc + listaproducto.subtotal);

/// Indica si el pedido tiene datos mínimos para guardarse.
/// 
/// Devuelve "true" si:
/// - [mesaONombre] no está vacío (ignorado espacios).
/// - Existe al menos una línea en [lineas].

  //Validación
  bool puedeGuardar(){
    return mesaONombre.trim().isNotEmpty && lineas.isNotEmpty;
  }

/// Contruye un [Pedido] "final" a partir del estado actual.
/// 
/// Se usa para:
/// - Navegar al resumen ("/resumen").
/// - Devolver el pedido al hacer "Guardar".
  Pedido construirPedido(){
    return Pedido(mesaONombre: mesaONombre, lineas: List.from(lineas));
  }
}