import 'package:flutter/material.dart';
import 'package:compras/modelos/item.dart';

class Carrito extends ChangeNotifier {
  Map<String, Item> _items = {};
  Map<String, Item> get items {
    return {..._items};
  }

  int get numeroItems {
    return _items.length;
  }

  double get montoTotal {
    var total = 0.0;
    items.forEach(
        (key, elementos) => total += elementos.precio * elementos.cantidad);
    return total;
  }

  void agregarP(
    String producto_id,
    String nombre,
    double precio,
    String unidad,
    String imagen,
    int cantidad,
  ) {
    if (_items.containsKey(producto_id)) {
      _items.update(
          producto_id,
          (old) => Item(
              id: old.id,
              nombre: old.nombre,
              precio: old.precio,
              imagen: old.imagen,
              cantidad: old.cantidad + 1));
    } else {
      _items.putIfAbsent(
          producto_id,
          () => Item(
              id: producto_id,
              nombre: nombre,
              precio: precio,
              imagen: imagen,
              cantidad: 1));
    }
  }

  void eliminarP(String producto_id) {
    _items.remove(producto_id);
  }

  void aumentarP(String producto_id) {
    if (_items.containsKey(producto_id)) {
      _items.update(
          producto_id,
          (old) => Item(
              id: old.id,
              nombre: old.nombre,
              precio: old.precio,
              imagen: old.imagen,
              cantidad: old.cantidad + 1));
    }
  }

  void disminuirP(String producto_id) {
    if (!_items.containsKey(producto_id)) return;
    if (_items[producto_id].cantidad > 1) {
      _items.update(
          producto_id,
          (old) => Item(
              id: old.id,
              nombre: old.nombre,
              precio: old.precio,
              imagen: old.imagen,
              cantidad: old.cantidad - 1));
    } else {
      _items.remove(producto_id);
    }
  }

  void vaciarCarrito(){
    _items={};
  }
}
