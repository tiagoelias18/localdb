import 'package:local_db/itens/model/item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDataBase {
  static final SqfliteDataBase instance = SqfliteDataBase._init();

  static Database _database;

  SqfliteDataBase._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('itens.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute("""
  CREATE TABLE IF NOT EXISTS itens(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    description TEXT)
  """);
  }

  Future<int> create(Item item) async {
    final db = await instance.database;

    // final json = item.toJson();
    // const columns = 'name, description';
    // final id = await db.rawInsert(
    //     'INSERT INTO itens($columns) VALUES("${json["name"]}","${json["description"]}")');

    final id = await db.insert('itens', item.toJson());
    return id;
  }

  Future<List<Map<String, dynamic>>> read() async {
    final db = await instance.database;

    const orderBy = 'name ASC';

    // return
    //     await db.rawQuery('SELECT * FROM itens ORDER BY $orderBy');

    return await db.query("itens", orderBy: orderBy);
  }

  Future<int> update(Item item) async {
    final db = await instance.database;

    return db.update(
      'itens',
      item.toJson(),
      where: 'itens.id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'itens',
      where: 'itens.id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
