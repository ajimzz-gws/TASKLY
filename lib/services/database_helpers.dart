import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'taskly.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate, // Use the _onCreate function here
    );
  }

  // Correctly initialize both tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE collections (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        color TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        isCompleted INTEGER,
        collection_id INTEGER,
        FOREIGN KEY (collection_id) REFERENCES collections (id)
      )
    ''');
  }

  // CRUD for tasks
  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  // CRUD for collections
  Future<int> addCollection(String name, String color) async {
    final db = await database;
    return await db.insert('collections', {'name': name, 'color': color});
  }

  Future<List<Map<String, dynamic>>> getCollections() async {
    final db = await database;
    return await db.query('collections');
  }

  Future<int> deleteCollection(int id) async {
    final db = await database;

    // First, delete all tasks associated with the collection
    await db.delete('tasks', where: 'collection_id = ?', whereArgs: [id]);

    // Then delete the collection
    return await db.delete('collections', where: 'id = ?', whereArgs: [id]);
  }
}
