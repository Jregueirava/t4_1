
import 'package:flutter/material.dart';
import 'package:t4_1/viewModel/seleccionProductosViewModel.dart';


/// Pantalla para seleccionar productos de la carta y sus cantidades.
/// 
/// El usuario incrementa/decrementa cantidades y confirma para devolver
/// las líneas seleccionadas a la pantalla anterior.
class Seleccionarproducto extends StatefulWidget {
  /// Crea la pantalla de selección de productos.
  const Seleccionarproducto({super.key});

  @override
  State<Seleccionarproducto> createState()=> _SeleccionarProductoPageState();
}

class _SeleccionarProductoPageState extends State<Seleccionarproducto>{
  /// ViewModel con la carta y las cantidades selccionadas.
  final Seleccionproductosviewmodel viewModel = Seleccionproductosviewmodel();

/// Confirma la selección actual.
/// 
/// Si no hay productos seleccionados, muestra un [SnackBar].
/// Si hay selección, devuelve la lista de líneas con "Navigator.pop(...)".
  void _confirmar(){
    final lineas = viewModel.construirLineas();
    if(lineas.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona al menos un producto")),
      );
      return;
    }
    //Devolver los productos
    Navigator.pop(context, lineas);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seleccionar Productos"),
        backgroundColor: const Color.fromARGB(255, 0, 217, 255),
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
                    tooltip: "Quitar una unidad", // Tooltip 
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
                    tooltip: "Añadir una cantidad", // Tooltip
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
                //Cancelada sin datos
                onPressed: ()=> Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 204, 255),
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
                  backgroundColor: const Color.fromARGB(255, 0, 204, 255),
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