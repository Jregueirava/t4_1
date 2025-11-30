
import 'package:flutter/material.dart';
import 'package:t4_1/viewModel/seleccionProductosViewModel.dart';

class Seleccionarproducto extends StatefulWidget {
  const Seleccionarproducto({super.key});

  @override
  State<Seleccionarproducto> createState()=> _SeleccionarProductoPageState();
}

class _SeleccionarProductoPageState extends State<Seleccionarproducto>{
  final Seleccionproductosviewmodel viewModel = Seleccionproductosviewmodel();

  void _confirmar(){
    final lineas = viewModel.construirLineas();
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
        title: const Text("Seleccionar Productos"),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: viewModel.carta.length,
        itemBuilder: (context, index){
          final producto = viewModel.carta[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text(producto.nombre),
              subtitle: Text("${producto.precio.toStringAsFixed(2)}€"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
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
            );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: ()=> Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text("Cancelar"),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
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