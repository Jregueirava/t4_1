

import '../model/lineaProducto.dart';
import '../model/pedido.dart';

class Crearpedidoviewmodel {

  String mesaONombre="";
  List<LineaProducto> lineas = [];


  //Suma total productos
  int get numProductos => lineas.fold(0, (acc, listaproducto) => acc + listaproducto.cantidad);

  //Suma total pedido
  double get total => lineas.fold(0.0, (acc, listaproducto) => acc + listaproducto.subtotal);

  bool puedeGuardar(){
    return mesaONombre.trim().isNotEmpty && lineas.isNotEmpty;
  }

  Pedido construirPedido(){
    return Pedido(mesaONombre: mesaONombre, lineas: List.from(lineas));
  }
}