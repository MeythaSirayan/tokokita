import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OrderDatabase {
  static final OrderDatabase instance = OrderDatabase._init();

  static Database? _database;

  OrderDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('tokokita.db');

    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final pathDB = join(dbPath, fileName);

    return await openDatabase(
      pathDB,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tanggal TEXT NOT NULL,
        daftarItem TEXT NOT NULL,
        totalHarga REAL NOT NULL,
        status TEXT NOT NULL
      )
    ''');
  }

  // CREATE
  Future<int> insertOrder(Map<String, dynamic> order) async {
    final db = await instance.database;

    return await db.insert(
      'orders',
      order,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // READ
  Future<List<Map<String, dynamic>>> getAllOrders() async {
    final db = await instance.database;

    return await db.query(
      'orders',
      orderBy: 'id DESC',
    );
  }

  // SEARCH BERDASARKAN STATUS
  Future<List<Map<String, dynamic>>> searchOrders(
    String status,
  ) async {
    final db = await instance.database;

    return await db.query(
      'orders',
      where: 'status LIKE ?',
      whereArgs: ['%$status%'],
      orderBy: 'id DESC',
    );
  }

  // UPDATE
  Future<int> updateOrderStatus(
    int id,
    String status,
  ) async {
    final db = await instance.database;

    return await db.update(
      'orders',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE
  Future<int> deleteOrder(int id) async {
    final db = await instance.database;

    return await db.delete(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
    _database = null;
  }
}
