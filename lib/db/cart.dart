import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modelos/datoscart.dart';

class Cart {
  static Future<Database> _OpenP() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'pedido.db');
    //await deleteDatabase(path);

    return openDatabase(join(await getDatabasesPath(), 'pedido.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE pedido(numero INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, detalle_pedido TEXT, precio_total DOUBLE(10,2))");
    }, version: 1);
  }

  static Future<Database> _OpenI() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'items_pedido.db');
    //await deleteDatabase(path);

    return openDatabase(join(await getDatabasesPath(), 'items_pedido.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE items_pedido(numero INTEGER, id_producto INTEGER, cantidad INTEGER, precio_unit DOUBLE(10,2), precio_total DOUBLE(10,2))");
    }, version: 1);
  }

  static Future<int> consecutivo() async {
    Database database = await _OpenP();

    int count = Sqflite.firstIntValue(
        await database.rawQuery('SELECT COUNT(*)+1 FROM pedido'));
    print(count.toString());
    return count;
  }

  static Future<void> insert(DatosCart item) async {
    Database database = await _OpenP();

    await database.insert(
      'pedido',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertI(DatosCartI item) async {
    Database database = await _OpenI();

    await database.insert(
      'items_pedido',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<DatosCart>> items() async {
    final database = await _OpenP();

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
    final database = await _OpenI();

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
