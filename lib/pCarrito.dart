import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:compras/carrito/carrito.dart';

class PantallaCarrito extends StatefulWidget {
  @override
  State<PantallaCarrito> createState() => _PantallaCarritoState();
}

class _PantallaCarritoState extends State<PantallaCarrito> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Carrito>(builder: (context, carrito, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pinkAccent,
            title: Text("Carro de compras"),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              child: carrito.items.length == 0
                  ? Center(
                      child: Text("Carrito vacio"),
                    )
                  : Column(
                      children: <Widget>[
                        for (var item in carrito.items.values)
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.pinkAccent,
                            margin: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    item.nombre,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                          child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          "assets/img/" + item.imagen,
                                          height: 130,
                                        ),
                                      )),
                                      Container(
                                          child: Column(children: <Widget>[
                                        Container(
                                          child: Text("Precio \$ " +
                                              (item.precio * item.cantidad)
                                                  .toString()),
                                        ),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                child: IconButton(
                                                  icon: Icon(Icons.remove),
                                                  onPressed: () {
                                                    setState(() {
                                                      carrito
                                                          .disminuirP(item.id);
                                                    });
                                                  },
                                                ),
                                              ),
                                              Container(
                                                child: Center(
                                                  child: Text(
                                                      item.cantidad.toString()),
                                                ),
                                              ),
                                              Container(
                                                child: IconButton(
                                                  icon: Icon(Icons.add),
                                                  onPressed: () {
                                                    setState(() {
                                                      carrito
                                                          .aumentarP(item.id);
                                                    });
                                                  },
                                                ),
                                              ),
                                              Container(
                                                  child: ElevatedButton.icon(
                                                onPressed: () {
                                                  setState(() {
                                                    carrito.eliminarP(item.id);
                                                  });
                                                },
                                                icon: Icon(
                                                    Icons.restore_from_trash),
                                                label: Text("Eliminar"),
                                                style: TextButton.styleFrom(
                                                    primary: Colors.black54,
                                                    backgroundColor:
                                                        Colors.white12),
                                              ))
                                            ],
                                          ),
                                        )
                                      ]))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xAA6EB1E6),
                                offset: Offset(9, 9),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                  child: Text(
                                    "Pagar",
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 20),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Total: \$ " + carrito.montoTotal.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ));
    });
  }
}
