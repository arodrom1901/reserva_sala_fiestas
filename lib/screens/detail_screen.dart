import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../models/evento_model.dart";
import "../providers/cart_provider.dart";

class DetailScreen extends StatelessWidget {
  // recibimos el evento a mostrar desde la pantalla anterior
  final Evento evento;

  const DetailScreen({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(evento.nombre, style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.amber),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // cargamos la imagen en grande usando la url que viene en el modelo
            Image.network(
              evento.imagen,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // indicamos que es un título para los lectores de pantalla (accesibilidad)
                  Semantics(
                    header: true,
                    child: Text(
                      evento.nombre,
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "DJ: ${evento.dj}",
                    style: TextStyle(fontSize: 20, color: Colors.amber),
                  ),
                  SizedBox(height: 10),
                  // visualizamos el horario con un icono para dar contexto
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Horario: ${evento.horario}",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Precio: ${evento.precio}€",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 30),
                  // botón para comprar el evento, actualizando el carrito global
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        // usamos el provider para guardar el evento en la lista global
                        Provider.of<CartProvider>(
                          context,
                          listen: false,
                        ).agregarEvento(evento);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${evento.nombre} añadido al carrito",
                            ),
                          ),
                        );
                      },
                      child: Text("Añadir al carrito"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}