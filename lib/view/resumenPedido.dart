
import 'package:flutter/material.dart';
import '../model/pedido.dart';

class ResumenPedidoPage extends StatelessWidget {
  const ResumenPedidoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pedido = ModalRoute.of(context)!.settings.arguments as Pedido;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resumen del Pedido"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pedido.mesaONombre,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${pedido.numProductos} productos",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Productos:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: pedido.lineas.length,
                itemBuilder: (context, index) {
                  final linea = pedido.lineas[index];
                  return Card(
                    child: ListTile(
                      title: Text(linea.producto.nombre),
                      subtitle: Text(
                        "${linea.producto.precio.toStringAsFixed(2)} € x ${linea.cantidad}",
                      ),
                      trailing: Text(
                        "${linea.subtotal.toStringAsFixed(2)} €",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(thickness: 2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "TOTAL: ${pedido.total.toStringAsFixed(2)} €",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.all(16),
              ),
              child: const Text("Volver"),
            ),
          ],
        ),
      ),
    );
  }
}
