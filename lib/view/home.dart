
import 'package:flutter/material.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/viewModel/homeViewModel.dart';
import 'package:t4_1/view/crearPedido.dart';
import 'package:t4_1/model/producto.dart';
import 'package:t4_1/model/lineaProducto.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _HomePageState();

}

class _HomePageState extends State<Home>{
  final Homeviewmodel viewModel = Homeviewmodel();

  @override
  void initState(){
    super.initState();

    //Pedidos iniciales
    viewModel.addPedido(Pedido(mesaONombre: "Mesa 1", 
    lineas: [
      LineaProducto(producto: Producto(nombre: "Agua", precio: 1.50), cantidad: 3),
      LineaProducto(producto: Producto(nombre: "FingersDePollo", precio: 3.5), cantidad: 3),
    ],
    ));

    viewModel.addPedido(Pedido(mesaONombre: "Mesa 5", 
    lineas: [
      LineaProducto(producto: Producto(nombre: "CervezaEstrella", precio: 2.50), cantidad: 2),
    ],
    ));
  }

  Future<void> _abrirCrearPedido() async{
    final resultado = await Navigator.push<Pedido>(
      context, MaterialPageRoute(builder: (context) => Crearpedido()),
    );

    if(!mounted)return;

    if(resultado !=null){
      setState((){
        viewModel.addPedido(resultado);
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bar - Pedidos"),
        backgroundColor: Colors.orange,
      ),
      body: viewModel.pedidos.isEmpty
      ? const Center(child: Text("No hay pedidos"))
      : ListView.builder(
        itemCount: viewModel.pedidos.length,
        itemBuilder: (context, index){
          final pedido = viewModel.pedidos[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                pedido.mesaONombre,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${pedido.numProductos} productos"),
              trailing: Text("${pedido.total.toStringAsFixed(2)}€",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _abrirCrearPedido,
        label: const Text("Nuevo pedido"),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}