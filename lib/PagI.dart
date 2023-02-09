import 'package:compras/PagC.dart';
import 'package:flutter/material.dart';
import 'package:compras/db/op.dart';
import 'package:compras/modelos/catalogo.dart';

class PagI extends StatefulWidget {
  @override
  State<PagI> createState() => _PagIState();
}

class _PagIState extends State<PagI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    "assets/img/logo.jpg",
                    width: MediaQuery.of(context).size.width / 2,
                    height: 300,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 100)),
                ElevatedButton(
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    /*Op.insert(catalogo(
                        nombre: "Mantequilla corporal Trendy",
                        precio: 25000.00,
                        imagen: "mantequilla.jpg",
                        cantidad: 15));*/
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (BuildContext) => PagC()));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.pinkAccent),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(13.0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(color: Colors.white))),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
