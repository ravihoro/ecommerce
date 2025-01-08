import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb('favorites.db');

    return _database!;
  }

  Future<Database> _initDb(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return openDatabase(path, version: 1, onCreate: createDb);
  }

  Future<void> createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites(
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        price REAL,
        category TEXT,
        image TEXT,
        rate REAL,
        count INTEGER
      )
    ''');
  }
}
