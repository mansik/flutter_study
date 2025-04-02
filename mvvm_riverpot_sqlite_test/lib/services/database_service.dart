import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpot_sqlite_test/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)',
        );
      },
    );
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db!.insert('users', user.toMap());
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('users');
    return List.generate(maps.length, (i) => User.fromMap(maps[i]));
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return await db!.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db!.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}

// Riverpot Provider
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});
