import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/location_model.dart';

class LocationDatabaseHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'user.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY,
        name TEXT,
        location TEXT
      )
    ''');
  }

  static Future<void> insertUser(LocationModel user) async {
    final db = await database;
    await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<LocationModel?> fetchUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user', where: 'id = ?', whereArgs: [1]);
    if (maps.isNotEmpty) {
      return LocationModel.fromMap(maps.first);
    }
    return null;
  }
}
