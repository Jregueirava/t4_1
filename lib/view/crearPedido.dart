import 'dart:io';
import 'package:flutter/material.dart';
import '../model/lineaProducto.dart';

class Crearpedido extends StatefulWidget{
    const Crearpedido({super.key});

    @override
    State<Crearpedido> createState()=> _CrearPedidoState();
}

class _CrearPedidoState extends State<CrearPedido> {
final Crearpedidoviewmodel viewModel = Crearpedidoviewmodel();
final TextEditingController _mesaController = TextEditingController();

@override
void dispose(){
    _mesaController.dispose();
    super.dispose();
}

Future<void> _abrirSeleccionProductos()async {
    final resultado = await Navigator.push<List<LineaProducto>>(
        context,
        MaterialPageRoute(
            builder: (context) => const SeleccionarProducto();
        ),
    );

    if(!mounted)return;

    if(resultado != null && resultado.isNotEmpty){
        setState((){
            viewModel.lineas = resultado;
        });
    }
}

void _verResumen(){
    if(!viewModel.puedeGuardar()){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Completa la mesa/nombre y añade productos"),
            ),
        );
        return;
    }
    Navigator.pushNamed(
        context,
        "/resumen",
        arguments: viewModel.construirPedido(),
    );
}

void _guardarPedido(){
    if(!viewModel.puedeGuardar()){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Completa la mesa/nombre y añade productos"),
            ),
        );
        return;
    }
    Navigator.pop(context, viewModel.construirPedido());
}

@override
Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: const Text("Crear Pedido"),
            backgroundColor: Colors.orange,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAligment.stretch,
                children: [
                    TextField(
                        controller: _mesaController,
                        decoration: const inputDecoration(
                            labelText: "Mesa o nombre",
                            border: OutlineInputBorder(),
                        ),
                    ),
                    const SizedBox(height: 16),
                    ElevateButton.icon(
                        onPressed: _abrirSeleccionProductos,
                        icon: const Icon(Icons.shopping_cart),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.all(12),
                        ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                        "Resumen provisional",
                        style: TextStyle(fontSize: 18, fontWeight: fontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                        child: viewModel.lineas.isEmpty
                        ? const Center(child: Text("No hay productos añadidos"))
                        :ListView.builder(
                            itemCount: viewModel.lineas.lenght,
                            itemBuilder: (context, index){
                                final linea = viewModel.lineas[index];
                                return ListTile(
                                    title: Text(linea.producto.nombre),
                                    subtitle: Text("${linea.producto.precio.toStringAsFixed(2)}€ x ${linea.cantidad}",
                                    ),
                                    trailing: Text("${linea.subtotal.toStringAsFixed(2)}€",
                                    style: const TExtStyle(fontWeight: FontWeight.bold),
                                    ),
                                );
                            },
                        ),
                    ),

                    const Divider(thickness: 2),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                            mainAxisAlignment: mainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    "Total: ${viewModel.total.toStringAsFixed(2)}€",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeigth.bold,

                                    ),
                                ),
                                Text("${viewModel.numProductos} productos",
                                style: const TextStyle(fontSize: 16),
                                ),
                            ],
                        ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                        children:[
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: _verResumen,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.purple,
                                        padding: const EdgeInsets.all(12),
                                    ),
                                    child: const Text("Ver resumen"),
                                ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: _guardarPedido,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        padding: const EdgeInsets.all(12),
                                    ),
                                    child: const Text("Guardar pedido"),
                                ),
                            ),
                        ],
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                        onPressed: ()=> Navigator.pop(context),
                        style: ElevateButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.all(12),
                        ),
                        child: const Text("Cancelar"),
                    ),
                ],
            ),
        ),
    );
}
}