
import '../model/pedido.dart';

/// ViewModel de la pantalla principal (lista de pedidos).
/// 
/// Mantiene la lista de [Pedido] que se muestra en la pantalla [Home].

class Homeviewmodel {
/// Lista de pedidos en memoria
/// 
/// En una app más grande, esta lista podría venir de base de datos o API.
  List<Pedido> pedidos = [];
/// Añade un [pedido] a la lista.
/// 
/// La vista (UI) suele llamar a este método y luego hace "setState()" para
/// refrescar la lista en pantalla
  void addPedido(Pedido pedido){
    pedidos.add(pedido);
  }
}