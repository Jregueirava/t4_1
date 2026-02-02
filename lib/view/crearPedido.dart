import 'package:flutter/material.dart';
import 'package:t4_1/model/lineaProducto.dart';
import 'package:t4_1/viewModel/crearPedidoViewModel.dart';
import 'package:t4_1/view/seleccionarProducto.dart';


/// Pantalla para crear un pedido.
/// 
/// Permite:
/// - Introducir mesa/nombre.
/// - Seleccionar productos y cantidades.
/// - Ver un resumen provisional.
/// - Guardar el pedido (devolviendo un  [Pedido] a la pantalla anterior).
class Crearpedido extends StatefulWidget{
  /// Crear la pantalla de creación de pedido.
    const Crearpedido({super.key});

    @override
    State<Crearpedido> createState()=> _CrearpedidoState();
}

class _CrearpedidoState extends State<Crearpedido> {
  /// ViewModel con la lógica del pedido en construcción.
final Crearpedidoviewmodel viewModel = Crearpedidoviewmodel();
/// Controlador del campo de texto "Mesa o nombre".
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
            builder: (context) => const Seleccionarproducto(),
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
        //Ruta nombrada
        arguments: viewModel.construirPedido(),
    );
}

void _guardarPedido(){
  //Comprobación antes de guardar
    if(!viewModel.puedeGuardar()){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Completa la mesa/nombre y añade productos"),
            ),
        );
        return;
    }
    //Devuelve el pedido
    Navigator.pop(context, viewModel.construirPedido());
}

@override
Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: const Text("Crear Pedido"),
            backgroundColor: const Color.fromARGB(255, 0, 217, 255),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                    TextField(
                        controller: _mesaController,
                        decoration: const InputDecoration(
                            labelText: "Mesa o nombre",
                            border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          //Guardar mesa
                          viewModel.mesaONombre = value;
                        }
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                        onPressed: _abrirSeleccionProductos,
                        icon: const Icon(Icons.shopping_cart),
                        label: const Text("Añadir productos"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 0, 204, 255),
                            padding: const EdgeInsets.all(12),
                        ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                        "Resumen provisional:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                        child: viewModel.lineas.isEmpty
                        ? const Center(child: Text("No hay productos añadidos"))
                        :ListView.builder(
                            itemCount: viewModel.lineas.length,
                            itemBuilder: (context, index){
                                final linea = viewModel.lineas[index];
                                return ListTile(
                                    title: Text(linea.producto.nombre),
                                    subtitle: Text("${linea.producto.precio.toStringAsFixed(2)}€ x ${linea.cantidad}",
                                    ),
                                    trailing: Text("${linea.subtotal.toStringAsFixed(2)}€",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                );
                            },
                        ),
                    ),

                    const Divider(thickness: 2),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    "Total: ${viewModel.total.toStringAsFixed(2)}€",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,

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
                                        backgroundColor: const Color.fromARGB(255, 0, 204, 255),
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
                                        backgroundColor: const Color.fromARGB(255, 0, 204, 255),
                                        padding: const EdgeInsets.all(12),
                                    ),
                                    child: const Text("Guardar pedido"),
                                ),
                            ),
                        ],
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      //Cancelar sin datos
                        onPressed: ()=> Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 0, 204, 255),
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