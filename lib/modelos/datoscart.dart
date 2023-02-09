class DatosCart {
  final int id;
  final String detalle;
  final double ptotal;

  DatosCart({this.id, this.detalle, this.ptotal});

  Map<String, dynamic> toMap() {
    return {'numero': id, 'detalle_pedido': detalle, 'precio_total': ptotal};
  }
}

class DatosCartI {
  final int numero;
  final String id_producto;
  final int cantidad;
  final double precio_unit;
  final double precio_total;

  DatosCartI(
      {this.numero,
      this.id_producto,
      this.cantidad,
      this.precio_unit,
      this.precio_total});

  Map<String, dynamic> toMap() {
    return {
      'numero': numero,
      'id_producto': id_producto,
      'cantidad': cantidad,
      'precio_unit': precio_unit,
      'precio_total': precio_total
    };
  }
}
