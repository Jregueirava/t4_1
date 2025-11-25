import 'package:flutter/material.dart';
import 'package:t4_1/model/lineaProducto.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/model/producto.dart';

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
  //List<LineaProducto> cosntruirLineas();


  /*void cosntruirLineas(){
    return Pedido(producto: producto, cantidad: List.from(LineaProducto));
  }*/

  //Mostrar carta
  //ListView.builde
}