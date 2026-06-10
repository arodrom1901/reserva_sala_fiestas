import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../providers/cart_provider.dart";

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // conectamos con el provider para leer los datos del carrito en tiempo real
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Tu Carrito", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.amber),
      ),
      body: Column(
        children: [
          // usamos expanded para que la lista ocupe el espacio disponible
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return Card(
                  color: Colors.black87,
                  child: ListTile(
                    title: Text(
                      item.nombre,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "${item.precio}€",
                      style: TextStyle(color: Colors.amber),
                    ),
                    // botón para borrar un elemento específico del carrito
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => cart.eliminarEvento(item),
                    ),
                  ),
                );
              },
            ),
          ),
          // sección inferior con el total y el botón de compra
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.black,
            child: Column(
              children: [
                Text(
                  "Total: ${cart.total}€",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                    ),
                    // si el carrito está vacío, deshabilitamos el botón
                    onPressed: cart.items.isEmpty
                        ? null
                        : () {
                            // vaciamos el carrito tras la compra y volvemos atrás
                            cart.limpiarCarrito();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("¡Compra realizada con éxito!"),
                              ),
                            );
                            Navigator.pop(context);
                          },
                    child: Text("Finalizar compra"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}