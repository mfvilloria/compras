class catalogo {
  final int id;
  final String nombre;
  final double precio;
  final String imagen;
  final int cantidad;

  catalogo({this.id, this.nombre, this.precio, this.imagen, this.cantidad});

  Map<String, dynamic> toMap() {
    return {'id': id, 'nombre': nombre, 'precio': precio, 'imagen': imagen, 'cantidad': cantidad};
  }
}


/*final productos = [
  new catalogo(
      id: 1,
      nombre: "Delineador Cat",
      precio: 15000.00,
      imagen: "cateye.jpg"),
  new catalogo(
      id: 2,
      nombre: "Corrector Ani-k",
      precio: 18000.00,
      imagen: "correctorAnik.jpg"),
  new catalogo(
      id: 3,
      nombre: "Mantequilla corporal",
      precio: 25000.00,
      imagen: "mantequilla.jpg"),
  new catalogo(
      id: 4,
      nombre: "Pestañina",
      precio: 20000.00,
      imagen: "pestañinaanik.jpg"),
];*/
