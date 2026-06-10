// modelo sencillo para los eventos de la sala
class Evento {
  // definimos los atributos que tendrá cada evento
  final String id;
  final String nombre;
  final String dj;
  final double precio;
  final String imagen;
  final String horario;

  Evento({
    required this.id,
    required this.nombre,
    required this.dj,
    required this.precio,
    required this.imagen,
    required this.horario,
  });

  // esta factoría toma un mapa (json) y lo transforma en una instancia de evento
  // es el puente entre los datos crudos que vienen de internet y nuestra lógica
  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      id: json["id"].toString(),
      nombre: json["nombre"] ?? "sin nombre",
      dj: json["dj"] ?? "dj invitado",
      // convertimos el precio a double para operar matemáticamente con él
      precio: (json["precio"] as num).toDouble(),
      imagen: json["imagen"] ?? "",
      // asignamos un valor por defecto si el campo horario no viene en el json
      horario: json["horario"] ?? "23:00 - 06:00",
    );
  }
}