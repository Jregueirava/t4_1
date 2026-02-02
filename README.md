# t4_1

## Bar MVVM
Aplicación Flutter para gestionar pedidos de un bar de forma sencilla: crear pedidos por mesa o nombre, añadir productos con cantidades y consultar un resumen con el total.

## Tecnologías usadas

- Flutter (UI multiplataforma)
- Dart
- Arquitectura MVVM (Model - ViewModel - View)

## Características principales

- Lista de pedidos con:
  - Mesa o nombre
  - Número total de productos
  - Total del pedido
- Crear pedido:
  - Introducir mesa/nombre (admite letras, números y guiones)
  - Añadir productos desde una carta con control de las cantidades con (+ / -)
  - Ver resumen del pedido antes de guardar
- Validaciones y feedback el usaurio:
   - Validaciones de campo obligatorio (mesa/ nombre)
   - Avisos con SnacKBar cuando faltan datos
   - Tooltips en acciones importantes para mejorar la usabilidad
 
## Estructura del proyecto

- "lib/model/": clases de datos ("Producto", "LineaProducto", "Pedido")
- "lib/viewModel/": lógica de negocio (cálculos, validaciones, construcción del pedido)
- "lib/view/": pantallas (Home, Crear pedido, Selección de productos, Resumen)
