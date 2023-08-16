import 'package:sqflite/sqflite.dart';

import 'package:beliyuk/data/models/cart_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tbCart = 'tb_cart';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final dbPath = '$path/beliyuk.db';

    final db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );

    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tbCart (
        id INTEGER PRIMARY KEY,
        name TEXT,
        price INTEGER,
        image TEXT,
        quantity INTEGER
      );
    ''');
  }

  Future<List<Map<String, dynamic>>> getCarts() async {
    final db = await database;
    return await db!.query(_tbCart);
  }

  Future<Map<String, dynamic>?> getCartById(int id) async {
    final db = await database;
    final result = await db!.query(
      _tbCart,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<int> addCart(CartModel cart) async {
    final db = await database;
    return await db!.insert(_tbCart, cart.toMap());
  }

  Future<int> removeCart(int id) async {
    final db = await database;
    return await db!.delete(
      _tbCart,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> addQuantity(CartModel cart) async {
    final db = await database;
    return await db!.update(
      _tbCart,
      cart.addQuantityToMap(),
      where: 'id = ?',
      whereArgs: [cart.id],
    );
  }

  Future<int> reduceQuantity(CartModel cart) async {
    final db = await database;
    return await db!.update(
      _tbCart,
      cart.reduceQuantityToMap(),
      where: 'id = ?',
      whereArgs: [cart.id],
    );
  }

  Future<int> deleteCarts() async {
    final db = await database;
    return await db!.delete(_tbCart);
  }
}
