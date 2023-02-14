import 'package:compras/modelos/catalogo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../modelos/datoscart.dart';

class Op {
  static Future<Database> _OpenDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'carrito.db');
    //await deleteDatabase(path);
    String sqlC =
        "CREATE TABLE productos(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nombre TEXT, precio DOUBLE(10,2), imagen TEXT, cantidad INTEGER)";
    String sqlP =
        "CREATE TABLE pedido(numero INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, detalle_pedido TEXT, precio_total DOUBLE(10,2))";
    String sqlI =
        "CREATE TABLE items_pedido(numero INTEGER, id_producto INTEGER, cantidad INTEGER, precio_unit DOUBLE(10,2), precio_total DOUBLE(10,2))";
    List<String> consultas = [sqlC, sqlP, sqlI];

    return openDatabase(join(await getDatabasesPath(), 'carrito.db'),
        onCreate: (db, version) {
      for (String sql in consultas) {
        db.execute(sql);
      }
    }, version: 1);
  }

  static Future<void> insert(catalogo item) async {
    Database database = await _OpenDB();

    await database.insert(
      'productos',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<catalogo>> items() async {
    final database = await _OpenDB();

    final List<Map<String, dynamic>> Imaps = await database.query('productos');

    for (var n in Imaps) {
      print((n['id']).toString() +
          ": " +
          n['nombre'] +
          " cantidad: " +
          n['cantidad'].toString());
    }

    return List.generate(
        Imaps.length,
        (i) => catalogo(
            id: Imaps[i]['id'],
            nombre: Imaps[i]['nombre'],
            precio: Imaps[i]['precio'],
            imagen: Imaps[i]['imagen'],
            cantidad: Imaps[i]['cantidad']));
  }

  static Future<int> consecutivo() async {
    Database database = await _OpenDB();

    int count = Sqflite.firstIntValue(
        await database.rawQuery('SELECT COUNT(*)+1 FROM pedido'));
    print(count.toString());
    if (count == null) {
      count = 1;
    }
    return count;
  }

  static Future<void> insertP(DatosCart item) async {
    Database database = await _OpenDB();

    await database.insert(
      'pedido',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertI(DatosCartI item) async {
    Database database = await _OpenDB();

    await database.insert(
      'items_pedido',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<DatosCart>> itemsP() async {
    final database = await _OpenDB();

    final List<Map<String, dynamic>> Imaps = await database.query('pedido');

    for (var n in Imaps) {
      print("numero:" +
          (n['numero']).toString() +
          ", detalle: " +
          n['detalle_pedido']);
    }

    return List.generate(
        Imaps.length,
        (i) => DatosCart(
            id: Imaps[i]['numero'],
            detalle: Imaps[i]['detalle_pedido'],
            ptotal: Imaps[i]['precio_total']));
  }

  static Future<List<DatosCartI>> items_P() async {
    final database = await _OpenDB();

    final List<Map<String, dynamic>> Imaps =
        await database.query('items_pedido');

    for (var n in Imaps) {
      print("numero:" +
          (n['numero']).toString() +
          ", id_producto: " +
          (n['id_producto']).toString());
    }

    return List.generate(
        Imaps.length,
        (i) => DatosCartI(
            numero: Imaps[i]['numero'],
            id_producto: (Imaps[i]['id_producto']).toString(),
            cantidad: Imaps[i]['cantidad'],
            precio_unit: Imaps[i]['precio_unit'],
            precio_total: Imaps[i]['precio_total']));
  }
}
