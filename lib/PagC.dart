import 'package:compras/carrito/carrito.dart';
import 'package:compras/pCarrito.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modelos/catalogo.dart';

class PagC extends StatefulWidget {
  @override
  State<PagC> createState() => _PagCState();
}

class _PagCState extends State<PagC> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Carrito>(builder: (context, carrito, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: Text("Catalogo de productos"),
          actions: <Widget>[
            new Stack(
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      carrito.numeroItems != 0
                          ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext) => PantallaCarrito()
                      ))
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Carrito vacio", textAlign: TextAlign.center,)));
                    },
                    icon: Icon(Icons.shopping_cart)),
                new Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      child: Text(
                        carrito.numeroItems.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
              ],
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: GridView.builder(
              physics: ScrollPhysics(),
              itemCount: productos.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 3),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x000005cc),
                            blurRadius: 30,
                            offset: Offset(10, 10))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          //padding: EdgeInsets.only(left: 50),
                          child: Text(
                        productos[index].nombre,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                        textAlign: TextAlign.center,
                      )),
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                            Container(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/img/" + productos[index].imagen,
                                height: 140,
                              ),
                            )),
                            Container(
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Precio \$ " +
                                          productos[index].precio.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                      child: ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        carrito.agregarP(
                                            productos[index].id.toString(),
                                            productos[index].nombre,
                                            productos[index].precio,
                                            "1",
                                            productos[index].imagen,
                                            1);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.add_shopping_cart,
                                    ),
                                    style: TextButton.styleFrom(
                                        primary: Colors.black54,
                                        backgroundColor: Colors.white12),
                                    label: Text(
                                      "Agregar",
                                    ),
                                  ))
                                ])),
                          ])),
                    ],
                  ),
                );
              }),
        ),
      );
    });
  }
}
