import 'package:flutter/material.dart';
import 'package:t4_1/model/producto.dart';
import 'package:t4_1/viewModel/seleccionProductosViewModel.dart';

import '../viewModel/seleccionProductosViewModel.dart';

class Seleccionarproducto extends StatefulWidget {
  const Seleccionarproducto({super.key});

  @override
  State<SeleccionarProducto> createState()=> _SeleccionarProductoPageState();
}

class _SeleccionarProductoPageState extends State<SeleccionarProductoPage>{
  final Seleccionarproductosviewmodel viewModel = Seleccionproductosviewmodel();

  void _confirmar(){
    final lineas = viewModel.contruirLineas();
    if(lineas.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona al menos un producto")),
      );
      return;
    }
    Navigator.pop(context, lineas);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seleccionar Producto"),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: viewModel.carta.lenght,
        itemBuilder: (context, index){
          final producto = viewModel.carta[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text(producto.nombre),
              subtitle: Text("${producto.precio.toStringAsFixed(2)}€",
              trailing: Row(
                mainAxisSize: mainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: (){
                      setState((){
                        viewModel.decrementar(producto);
                      });
                    },
                    icon: const Icon(Icons.remove_circle_outline)
                  ),
                  Text("${viewModel.getCantidad(producto)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  IconButton(
                    onPressed: (){
                      setState((){
                        viewModel.incrementar(producto);
                      });

                    },
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              ),
            )
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: ()=> Navigation.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text("Cancelar"),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevateButton(
                onPressed: _confirmar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text("Confirmar"),
              )
            )
          ]
        )
      )
    );
  }
}