import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/slider_model.dart';

class SliderDatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'slider.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE sliders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            photo_path TEXT NOT NULL,
            description TEXT NOT NULL
          )
        ''');
      },
    );
  }

  static Future<void> insertSlider(SliderModel model) async {
    final db = await database;
    await db.insert('sliders', model.toMap());
  }

  static Future<List<SliderModel>> getSliders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('sliders');
    return List.generate(maps.length, (i) => SliderModel.fromMap(maps[i]));
  }

  static Future<void> deleteAllSliders() async {
    final db = await database;
    await db.delete('sliders');
  }
}
