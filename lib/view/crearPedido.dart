import 'package:flutter/material.dart';
import 'package:t4_1/model/lineaProducto.dart';
import 'package:t4_1/viewModel/crearPedidoViewModel.dart';
import 'package:t4_1/view/seleccionarProducto.dart';
import 'package:flutter/services.dart';

/// Pantalla para crear un pedido.
///
/// Permite:
/// - Introducir mesa/nombre.
/// - Seleccionar productos y cantidades.
/// - Ver un resumen provisional.
/// - Guardar el pedido (devolviendo un  [Pedido] a la pantalla anterior).
class Crearpedido extends StatefulWidget {
  /// Crear la pantalla de creación de pedido.
  const Crearpedido({super.key});

  @override
  State<Crearpedido> createState() => _CrearpedidoState();
}

class _CrearpedidoState extends State<Crearpedido> {
  /// ViewModel con la lógica del pedido en construcción.
  final Crearpedidoviewmodel viewModel = Crearpedidoviewmodel();

  /// Controlador del campo de texto "Mesa o nombre".
  final TextEditingController _mesaController = TextEditingController();

  //Identifiacdor del Form para validar
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _mesaController.dispose();
    super.dispose();
  }

  bool _validarMesaONombre() {
    //Ejecuta todos los validator() dentro del Form
    //Devuelve true si todo es válido, false si hay errores(lo muestra)
    return _formKey.currentState?.validate() ?? false;
    //Si no existe state, consideramos inválido.
  }

  bool _validarProductos() {
    // Reglas de negocio: un pedido sin líneas no tiene sentido

    return viewModel
        .lineas
        .isNotEmpty; //True si hay al menos 1 producto añadido
  }

  void _mostrarError(String mensaje) {
    //Un único sitio para mostrar errores:
    ScaffoldMessenger.of(context).showSnackBar(
      //SanckBar sin deshacer simple
      SnackBar(content: Text(mensaje)),
    );
  }

  /// Abre la pantalla de selección de producto y espera un resultado.
  ///
  /// Si el usuario confirma, recibimos una lista de [LineaProducto] y la guardamos
  /// en el [viewModel] para actualizar el resumen provisional.
  Future<void> _abrirSeleccionProductos() async {
    final resultado = await Navigator.push<List<LineaProducto>>(
      context,
      MaterialPageRoute(builder: (context) => const Seleccionarproducto()),
    );

    if (!mounted) return;

    if (resultado != null && resultado.isNotEmpty) {
      setState(() {
        viewModel.lineas = resultado;
      });
    }
  }

  /// Navega a la pantalla de resumen del pedido.
  ///
  /// Si el pedido no es válido, muestra un [SnackBar] para informar al usuario.
  /*void _verResumen(){
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
}*/

  void _verResumen() {
    final mesaOk = _validarMesaONombre(); // Validación del campo del usuario
    final productosOk =
        _validarProductos(); // Validación de selección de productos

    if (!mesaOk || !productosOk) {
      _mostrarError("Revisa la mesa/nombre y añade al menos un producto");
      return;
    }

    Navigator.pushNamed(
      context,
      "/resumen",
      arguments: viewModel
          .construirPedido(), // Construimos el pedido final desde el ViewModel
    );
  }

  /// Guarda el pedido actual y lo devuelve a la pantalla anterior.
  ///
  /// Si el pedido no es válido, muestra un [SnackBar] y no cierra la pantalla.
  /*void _guardarPedido(){
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
}*/
  void _guardarPedido() {
    final mesaOk = _validarMesaONombre(); // Validación del campo
    final productosOk = _validarProductos(); // Validación de productos

    if (!mesaOk || !productosOk) {
      _mostrarError("Revisa la mesa/nombre y añade al menos un producto");
      return;
    }

    Navigator.pop(
      context,
      viewModel.construirPedido(),
    ); // Devuelve el pedido a Home
  }

  @override
  Widget build(BuildContext context) {
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
            Form(
              key: _formKey, // Conecta este Form con la key para validar
              child: TextFormField(
                controller: _mesaController,
                decoration: const InputDecoration(
                  labelText: "Mesa o nombre",
                  border: OutlineInputBorder(),
                  hintText: "Ej: Mesa 5, Juan, Juan-5", // Ayuda al usuario
                ),
                inputFormatters: [
                  // Solo permite letras (con acentos), números, espacios y guiones
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z0-9áéíóúÁÉÍÓÚñÑüÜ \-]"),
                  ),
                ],
                validator: (value) {
                  // 1) Validación: campo obligatorio
                  if (value == null || value.trim().isEmpty) {
                    return "Este campo es obligatorio";
                  }

                  // 2) Validación: solo letras/números/espacios/guiones
                  final texto = value.trim();
                  final valido = RegExp(
                    r"^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑüÜ \-]+$",
                  ).hasMatch(texto);
                  if (!valido) {
                    return "Solo letras, números, espacios y guiones";
                  }

                  return null; // null = sin error
                },
                onChanged: (value) {
                  // Guardamos en el ViewModel
                  viewModel.mesaONombre = value;
                },
              ),
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
                  : ListView.builder(
                      itemCount: viewModel.lineas.length,
                      itemBuilder: (context, index) {
                        final linea = viewModel.lineas[index];
                        return ListTile(
                          title: Text(linea.producto.nombre),
                          subtitle: Text(
                            "${linea.producto.precio.toStringAsFixed(2)}€ x ${linea.cantidad}",
                          ),
                          trailing: Text(
                            "${linea.subtotal.toStringAsFixed(2)}€",
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
                  Text(
                    "${viewModel.numProductos} productos",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
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
              onPressed: () => Navigator.pop(context),
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
