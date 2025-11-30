

import '../model/pedido.dart';

class Homeviewmodel {

  List<Pedido> pedidos = [];

  void addPedido(Pedido pedido){
    pedidos.add(pedido);
  }
}