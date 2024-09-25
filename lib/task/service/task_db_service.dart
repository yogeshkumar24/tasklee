import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasklee/task/model/model.dart';
import 'package:tasklee/task/service/task_service_abstract.dart';

class TaskDBService implements TaskService {
  static const String _dbName = 'tasklee.db';
  static const String _tableName = 'tasks';
  static const int _dbVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      create table $_tableName(
        id integer primary key,
        title text not null,
        deadline integer not null,
        description text,
        taskPriority text,
        taskStatus text
      )
    ''');
  }

  @override
  Future addTask(Task task) async {
    final db = await database;
    await db.insert(
      _tableName,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    fetchTasks();
  }

  @override
  Future<List<Task>> fetchTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  @override
  Future editTask(Task task) async {
    final db = await database;
    await db.update(
      _tableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  @override
  Future<bool> deleteTask(int id) async {
    final db = await database;
    final deletedRows = await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return deletedRows > 0;
  }
}
