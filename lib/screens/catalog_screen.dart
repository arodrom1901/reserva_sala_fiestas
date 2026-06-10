import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../services/api_service.dart";
import "../models/evento_model.dart";
import "../providers/cart_provider.dart";
import "cart_screen.dart";
import "detail_screen.dart";

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  // instancia del servicio para obtener los datos de la api
  final ApiService _apiService = ApiService();
  late Future<List<Evento>> _listaEventos;

  @override
  void initState() {
    super.initState();
    // inicializamos la carga de eventos al entrar en la pantalla
    _listaEventos = _apiService.obtenerEventos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      // fondo elegante tipo noche
      appBar: AppBar(
        title: Text(
          "Cartelera de la Sala",
          style: TextStyle(color: Colors.amber),
        ),
        backgroundColor: Colors.black, // color principal de la marca
        actions: [
          // botón para cerrar sesión y volver a la pantalla de login
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.red),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
          // escuchamos cambios en el carrito para actualizar el contador en tiempo real
          Consumer<CartProvider>(
            builder: (context, cart, child) => Padding(
              padding: EdgeInsets.all(8.0),
              child: Badge(
                isLabelVisible: cart.items.isNotEmpty,
                label: Text("${cart.items.length}"),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.amber),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CartScreen()),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // futurebuilder gestiona los estados de espera, error y éxito de la petición
      body: FutureBuilder<List<Evento>>(
        future: _listaEventos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.amber),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No hay eventos disponibles",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final eventos = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: eventos.length,
            itemBuilder: (context, index) {
              final evento = eventos[index];
              return Card(
                color: Colors.black87, // contraste para cumplir accesibilidad
                margin: EdgeInsets.symmetric(vertical: 8),
                child: InkWell(
                  // al pulsar navegamos a la pantalla de detalle del evento seleccionado
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(evento: evento),
                      ),
                    );
                  },
                  // semantics ayuda a los lectores de pantalla a entender qué hay aquí
                  child: Semantics(
                    label:
                        "evento ${evento.nombre}, precio ${evento.precio} euros",
                    child: ListTile(
                      leading: Image.network(
                        evento.imagen,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return CircularProgressIndicator(color: Colors.amber);
                        },
                      ),
                      title: Text(
                        evento.nombre,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "${evento.dj} - ${evento.precio}€",
                        style: TextStyle(color: Colors.amber),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.add_shopping_cart,
                          color: Colors.amber,
                        ),
                        // añadimos el evento al carrito usando provider sin escuchar cambios
                        onPressed: () {
                          Provider.of<CartProvider>(
                            context,
                            listen: false,
                          ).agregarEvento(evento);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${evento.nombre} añadido")),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}