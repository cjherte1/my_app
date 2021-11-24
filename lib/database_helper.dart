import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'models/task.dart';
import 'models/user.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDB();

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'mydatabase.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE User (
        userId INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT,
        lastName TEXT,
        username TEXT,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE Task (
        taskId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        datetime TEXT,
        description TEXT,
        isCompleted INTEGER DEFAULT 0,
        userId INTEGER,
        FOREIGN KEY(userId) REFERENCES User(userId)
      )
    ''');
    await db.execute(
        'INSERT INTO User (firstName, lastName, username, password) VALUES ("Admin", "Admin", "admin", "Admin")');

    await db.execute(
        'INSERT INTO Task (name, datetime, description, userId) VALUES ("Get Started", "2021-09-11 00:00:00.000", "Placeholder for description", 1)');
    print('Database Initialized.');
  }

  Future<List<User>> getUsers() async {
    Database db = await instance.database;
    var users = await db.query('User', orderBy: 'lastName');
    List<User> userList =
        users.isNotEmpty ? users.map((c) => User.fromMap(c)).toList() : [];
    print(userList);
    return userList;
  }

  Future<bool> authenticateLogin(String username, String password) async {
    Database db = await instance.database;
    var userRow = await db.rawQuery(
        'SELECT * FROM User WHERE username=? and password=?',
        [username, password]);
    userRow.isNotEmpty
        ? print('Login success for user ' + username)
        : print('Login failed for user ' + username);
    Future<bool> rval = userRow.isNotEmpty
        ? Future<bool>.value(true)
        : Future<bool>.value(false);
    return rval;
  }

  Future<bool> addUser(String firstName, String lastName, String username,
      String password) async {
    Database db = await instance.database;
    var userRow =
        await db.rawQuery('SELECT * FROM User WHERE username=?', [username]);
    if (userRow.isEmpty) {
      await db.rawInsert(
          'INSERT INTO User (firstName, lastName, username, password) VALUES (?, ?, ?, ?)',
          [firstName, lastName, username, password]);
      print('Inserted user ' + username);
      return Future<bool>.value(true);
    } else {
      print('Could not insert ' + username + '. Username already exists.');
      return Future<bool>.value(false);
    }
  }

  void removeUser(String username) async {
    Database db = await instance.database;
    await db.rawQuery('DELETE from User where username=?', [username]);
    print('Removed user ' + username);
  }

  void clearDb() async {
    Database db = await instance.database;
    await db.execute('DELETE from Task where taskId!=1');
    await db.execute('DELETE from User where username!="admin"');
    print('Cleared database.');
  }

  void deleteDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "mydatabase.db");
    await deleteDatabase(path);
    print('Deleted database.');
  }

  Future<User> getUserByUsername(String username) async {
    Database db = await instance.database;
    List users = await db.query("User",
        where: "username = ?", whereArgs: [username], limit: 1);
    return User.fromMap(users[0]);
  }

  Future<void> addTask(
      String name, String datetime, String description, int userId) async {
    Database db = await instance.database;
    await db.rawInsert(
        'INSERT INTO Task (name, datetime, description, userId) VALUES (?, ?, ?, ?)',
        [name, datetime, description, userId]);
    print('Inserted task ' + name);
  }

  void completeTask(int taskId) async {
    Database db = await instance.database;
    await db.rawUpdate(
        'UPDATE Task SET isCompleted = 1 WHERE taskId = ?', [taskId]);
    print('Marked task complete ID: ' + taskId.toString());
  }

  void removeTask(int taskId) async {
    Database db = await instance.database;
    await db.rawDelete('DELETE FROM Task WHERE taskId = ?', [taskId]);
    print('Deleted task ID: ' + taskId.toString());
  }

  Future<List<Task>> getTasksByUser(int userId) async {
    Database db = await instance.database;
    var tasks = await db.query('Task',
        where: 'userID = ? AND isCompleted = 0', whereArgs: [userId], orderBy: 'taskId');
    List<Task> taskList =
        tasks.isNotEmpty ? tasks.map((c) => Task.fromMap(c)).toList() : [];
    print(taskList);
    return taskList;
  }

  Future<List<Task>> getCompletedTasksByUser(int userId) async {
    Database db = await instance.database;
    var tasks = await db.query('Task',
        where: 'userID = ?  AND isCompleted = 1', whereArgs: [userId], orderBy: 'taskId');
    List<Task> taskList =
    tasks.isNotEmpty ? tasks.map((c) => Task.fromMap(c)).toList() : [];
    print(taskList);
    return taskList;
  }
}
