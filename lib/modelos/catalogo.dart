class catalogo {
  final int id;
  final String nombre;
  final double precio;
  final String imagen;
  final String descripcion;

  const catalogo(
      {this.id,
      this.nombre,
      this.precio,
      this.imagen,
      this.descripcion});

}

final productos = [
  new catalogo(
      id: 1,
      nombre: "Delineador Cat",
      precio: 15000.00,
      imagen: "cateye.jpg",
      descripcion: "Delineador doble punta"),
  new catalogo(
      id: 2,
      nombre: "Corrector Ani-k",
      precio: 18000.00,
      imagen: "correctorAnik.jpg",
      descripcion: "Corrector alta cobertura"),
  new catalogo(
      id: 3,
      nombre: "Mantequilla corporal",
      precio: 25000.00,
      imagen: "mantequilla.jpg",
      descripcion: "Crema super hidratante"),
  new catalogo(
      id: 4,
      nombre: "Pestañina",
      precio: 20000.00,
      imagen: "pestañinaanik.jpg",
      descripcion: "Pestañina a prueba de agua"),
];
