//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:compras/carrito/carrito.dart';

import 'PagI.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => Carrito(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PagI(),
    );
  }
}
