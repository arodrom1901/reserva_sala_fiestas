// modelo sencillo para los eventos de la sala
class Evento {
  final String id;
  final String nombre;
  final String dj;
  final double precio;
  final String imagen;

  Evento({
    required this.id,
    required this.nombre,
    required this.dj,
    required this.precio,
    required this.imagen,
  });

  // esto nos ayuda a convertir el json de la api a nuestro objeto evento
  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      id: json["id"].toString(),
      nombre: json["nombre"] ?? "sin nombre",
      dj: json["dj"] ?? "dj invitado",
      // nos aseguramos de que el precio sea double
      precio: (json["precio"] as num).toDouble(),
      imagen: json["imagen"] ?? "",
    );
  }
}
