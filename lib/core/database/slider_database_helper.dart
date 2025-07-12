import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/slider_model.dart';


class SliderDatabaseHelper {
  static Database? _db;

  static Future<Database> get database async {
    _db ??= await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'slider.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE sliders(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          asset_path TEXT,
        )
      ''');
    });
  }

  static Future<void> insertSlider(SliderModel slider) async {
    final db = await database;
    await db.insert('sliders', slider.toMap());
  }

  static Future<List<SliderModel>> fetchSliders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('sliders');
    return maps.map((map) => SliderModel.fromMap(map)).toList();
  }
}
