import 'package:compras/modelos/catalogo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Op {
  static Future<Database> _OpenDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'productos.db');
    //await deleteDatabase(path);

    return openDatabase(join(await getDatabasesPath(), 'productos.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE productos(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nombre TEXT, precio DOUBLE(10,2), imagen TEXT, cantidad INTEGER)");
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
}
