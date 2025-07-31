import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/appointment_model.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/doctor_model.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/message_model.dart';

class DoctorDatabaseService {
  static final DoctorDatabaseService _instance = DoctorDatabaseService._internal();
  static DoctorDatabaseService get instance => _instance;

  DoctorDatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'medical_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE doctors (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        specialty TEXT NOT NULL,
        qualification TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        rating REAL NOT NULL,
        workingTime TEXT NOT NULL,
        consultationFee INTEGER NOT NULL,
        experience TEXT NOT NULL,
        about TEXT NOT NULL,
        isOnline INTEGER NOT NULL DEFAULT 0,
        createdAt INTEGER NOT NULL,
        updatedAt INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE appointments (
        id TEXT PRIMARY KEY,
        doctorId TEXT NOT NULL,
        patientId TEXT NOT NULL,
        dateTime INTEGER NOT NULL,
        status INTEGER NOT NULL,
        notes TEXT,
        duration INTEGER NOT NULL DEFAULT 30,
        createdAt INTEGER NOT NULL,
        updatedAt INTEGER NOT NULL,
        FOREIGN KEY (doctorId) REFERENCES doctors (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE messages (
        id TEXT PRIMARY KEY,
        senderId TEXT NOT NULL,
        receiverId TEXT NOT NULL,
        content TEXT NOT NULL,
        type INTEGER NOT NULL,
        timestamp INTEGER NOT NULL,
        isRead INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // Insert sample data
    await _insertSampleData(db);
  }

  Future<void> _insertSampleData(Database db) async {
    final now = DateTime.now();

    // Sample doctors
    final doctors = [
      Doctor(
        id: 'doc_1',
        name: 'Prof. Dr. AGM Reza',
        specialty: 'Cardiologist',
        qualification: 'Coordinator & Senior Consultant of Cardiology',
        imageUrl: 'https://images.pexels.com/photos/612807/pexels-photo-612807.jpeg?auto=compress&cs=tinysrgb&w=400',
        rating: 4.9,
        workingTime: '11:00 AM - 05:00 PM',
        consultationFee: 2500,
        experience: '20 years',
        about: 'Prof. Dr. AGM Reza is a renowned cardiologist with over 20 years of experience.',
        isOnline: true,
        createdAt: now,
        updatedAt: now,
      ),
      Doctor(
        id: 'doc_2',
        name: 'Prof. Dr. Sohelly Jahan',
        specialty: 'Gynecologist',
        qualification: 'Obstetrician & Gynecologist',
        imageUrl: 'https://images.pexels.com/photos/5215024/pexels-photo-5215024.jpeg?auto=compress&cs=tinysrgb&w=400',
        rating: 5.0,
        workingTime: '09:00 AM - 03:00 PM',
        consultationFee: 1000,
        experience: '15 years',
        about: 'Prof. Dr. Sohelly Jahan specializes in women\'s health and reproductive medicine.',
        isOnline: false,
        createdAt: now,
        updatedAt: now,
      ),
      Doctor(
        id: 'doc_3',
        name: 'Asst. Prof. Dr. Md. Nazmul Huda',
        specialty: 'Orthopedic',
        qualification: 'General Medicine Orthopaedic Surgery',
        imageUrl: 'https://images.pexels.com/photos/5452293/pexels-photo-5452293.jpeg?auto=compress&cs=tinysrgb&w=400',
        rating: 4.5,
        workingTime: '10:00 AM - 04:00 PM',
        consultationFee: 1500,
        experience: '12 years',
        about: 'Dr. Nazmul Huda is an expert in orthopedic surgery and general medicine.',
        isOnline: true,
        createdAt: now,
        updatedAt: now,
      ),
    ];

    for (final doctor in doctors) {
      await db.insert('doctors', doctor.toMap());
    }
  }

  // Doctor CRUD operations
  Future<List<Doctor>> getAllDoctors() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('doctors');
    return List.generate(maps.length, (i) => Doctor.fromMap(maps[i]));
  }

  Future<Doctor?> getDoctorById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'doctors',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Doctor.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Doctor>> getDoctorsBySpecialty(String specialty) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'doctors',
      where: 'specialty = ?',
      whereArgs: [specialty],
    );
    return List.generate(maps.length, (i) => Doctor.fromMap(maps[i]));
  }

  // Appointment CRUD operations
  Future<int> insertAppointment(Appointment appointment) async {
    final db = await database;
    return await db.insert('appointments', appointment.toMap());
  }

  Future<List<Appointment>> getAppointmentsByPatientId(String patientId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'appointments',
      where: 'patientId = ?',
      whereArgs: [patientId],
      orderBy: 'dateTime DESC',
    );
    return List.generate(maps.length, (i) => Appointment.fromMap(maps[i]));
  }

  Future<int> updateAppointment(Appointment appointment) async {
    final db = await database;
    return await db.update(
      'appointments',
      appointment.toMap(),
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
  }

  // Message CRUD operations
  Future<int> insertMessage(Message message) async {
    final db = await database;
    return await db.insert('messages', message.toMap());
  }

  Future<List<Message>> getMessagesBetweenUsers(String userId1, String userId2) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'messages',
      where: '(senderId = ? AND receiverId = ?) OR (senderId = ? AND receiverId = ?)',
      whereArgs: [userId1, userId2, userId2, userId1],
      orderBy: 'timestamp ASC',
    );
    return List.generate(maps.length, (i) => Message.fromMap(maps[i]));
  }
}