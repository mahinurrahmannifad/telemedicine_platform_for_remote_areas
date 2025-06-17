import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class UserDBHelper {
  static final UserDBHelper _instance = UserDBHelper._internal();
  factory UserDBHelper() => _instance;
  UserDBHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'users.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password TEXT,
            fullName TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertUser(String email, String password, String fullName) async {
    final db = await database;
    final hashedPassword = sha256.convert(utf8.encode(password)).toString();
    await db.insert(
      'users',
      {
        'email': email,
        'password': hashedPassword,
        'fullName': fullName,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }
}
