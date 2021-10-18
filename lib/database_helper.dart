import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'models/user.dart';

class DatabaseHelper{
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDB();

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "mydatabase.db");
    return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE User (
        firstName TEXT,
        lastName TEXT,
        username TEXT PRIMARY KEY,
        password TEXT
      )
    ''');
    await db.execute(
        'INSERT INTO User (firstName, lastName, username, password) values ("Admin", "Admin", "Admin", "Admin")'
    );
  }
    Future<List<User>> getUsers() async{
      Database db = await instance.database;
      var users = await db.query('User', orderBy: 'lastName');
      List<User> userList = users.isNotEmpty
      ? users.map((c) => User.fromMap(c)).toList() : [];
      print(userList);
      return userList;
    }

    Future<bool> authenticateLogin(String username, String password) async{
      Database db = await instance.database;
      var userRow = await db.rawQuery('SELECT * FROM User WHERE username=? and password=?', [username, password]
      );
      Future<bool> rval = userRow.isNotEmpty ? Future<bool>.value(true) : Future<bool>.value(false);
      return rval;
    }

  Future<User> getUserByUsername(String username) async {
    Database db = await instance.database;
    var result = await db.query("User", where: "username = ", whereArgs: [username]);
    return User.fromMap(result.first);
  }

}