import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'ia_sig_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  void _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE messages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT NOT NULL,
        sender TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        conversation_id INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE conversations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        key TEXT UNIQUE NOT NULL,
        value TEXT NOT NULL
      )
    ''');

    // Insertar configuración inicial
    await db.insert('settings', {
      'key': 'dark_mode',
      'value': 'false',
    });

    await db.insert('settings', {
      'key': 'language',
      'value': 'es',
    });

    await db.insert('settings', {
      'key': 'voice_enabled',
      'value': 'true',
    });

    await db.insert('settings', {
      'key': 'offline_mode',
      'value': 'false',
    });
  }

  Future<void> initDatabase() async {
    await instance.database;
  }

  // Métodos para manejar mensajes
  Future<int> insertMessage(Map<String, dynamic> message) async {
    final db = await instance.database;
    return await db.insert('messages', message);
  }

  Future<List<Map<String, dynamic>>> getMessages(int conversationId) async {
    final db = await instance.database;
    return await db.query(
      'messages',
      where: 'conversation_id = ?',
      whereArgs: [conversationId],
      orderBy: 'id ASC',
    );
  }

  // Métodos para manejar conversaciones
  Future<int> insertConversation(Map<String, dynamic> conversation) async {
    final db = await instance.database;
    return await db.insert('conversations', conversation);
  }

  Future<List<Map<String, dynamic>>> getConversations() async {
    final db = await instance.database;
    return await db.query('conversations', orderBy: 'updated_at DESC');
  }

  Future<int> updateConversation(int id, Map<String, dynamic> conversation) async {
    final db = await instance.database;
    return await db.update(
      'conversations',
      conversation,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Métodos para manejar configuración
  Future<String?> getSetting(String key) async {
    final db = await instance.database;
    final result = await db.query(
      'settings',
      where: 'key = ?',
      whereArgs: [key],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first['value'] as String?;
    }
    return null;
  }

  Future<void> setSetting(String key, String value) async {
    final db = await instance.database;
    await db.insert(
      'settings',
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Cerrar base de datos
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}