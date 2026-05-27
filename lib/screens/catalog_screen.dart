import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../services/api_service.dart";
import "../models/evento_model.dart";
import "../providers/cart_provider.dart";

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  // instancia de nuestro servicio para pedir los datos
  final ApiService _apiService = ApiService();
  late Future<List<Evento>> _listaEventos;

  @override
  void initState() {
    super.initState();
    // iniciamos la llamada a la api
    _listaEventos = _apiService.obtenerEventos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cartelera de la Sala")),
      body: FutureBuilder<List<Evento>>(
        future: _listaEventos,
        builder: (context, snapshot) {
          // mientras carga
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // si hubo error o no hay datos
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay eventos disponibles"));
          }

          final eventos = snapshot.data!;

          // pintamos la lista
          return ListView.builder(
            itemCount: eventos.length,
            itemBuilder: (context, index) {
              final evento = eventos[index];
              return ListTile(
                leading: Image.network(evento.imagen),
                title: Text(evento.nombre),
                subtitle: Text("${evento.dj} - ${evento.precio}€"),
                trailing: IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    // llamamos al provider para añadir al carrito
                    Provider.of<CartProvider>(
                      context,
                      listen: false,
                    ).agregarEvento(evento);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}