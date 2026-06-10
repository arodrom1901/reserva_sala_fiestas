import "package:flutter/material.dart";
import "../models/evento_model.dart";

class CartProvider with ChangeNotifier {
  // esta es la lista interna donde guardamos las cosas
  final List<Evento> _items = [];

  List<Evento> get items => _items;

  // metodo para añadir un evento al carrito
  void agregarEvento(Evento evento) {
    _items.add(evento);
    // esto avisa a los widgets que escuchan que la lista cambió
    notifyListeners();
  }

  // metodo para vaciar el carrito
  void limpiarCarrito() {
    _items.clear();
    notifyListeners();
  }

  //metodo para eliminar un evento específico del carrito
  void eliminarEvento(Evento evento) {
    _items.remove(evento);
    // avisamos a la pantalla para que refresque la lista
    notifyListeners();
  }

  // calcula el total de la compra
  double get total => _items.fold(0, (suma, item) => suma + item.precio);
}