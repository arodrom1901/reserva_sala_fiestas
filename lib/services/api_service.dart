import "dart:convert";
import "package:http/http.dart" as http;
import "../models/evento_model.dart";

class ApiService {
  // aquí pondremos la url de nuestra api, en este caso una url de mockapi.io con datos de ejemplo
  final String _url = "https://6a1703791b90031f81b1e417.mockapi.io/:endpoint";

  Future<List<Evento>> obtenerEventos() async {
    try {
      final respuesta = await http.get(Uri.parse(_url));

      if (respuesta.statusCode == 200) {
        List<dynamic> listaJson = json.decode(respuesta.body);
        // convertimos cada objeto del json a nuestra clase modelo
        return listaJson.map((json) => Evento.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      // si falla internet o la api, devolvemos lista vacía
      print("Error al conectar con la api: $e");
      return [];
    }
  }
}