import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import '../models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  factory DatabaseHelper() => instance;

  static Database? _db;

  DatabaseHelper._instance();

  String tasksTable = 'task_table.db';
  String tableUser = 'tableUser';
  String colId = 'id';
  String colTitle = 'title';
  String colDes = 'descriptio';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';

// Task Tables
// Id | Title| Description | Date | Priority | Status
// 0     ''      ''      ''         0
// 1     ''      ''      ''         0
// 2     ''      ''      ''         0


  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, tasksTable);
    var theDb = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
         CREATE TABLE $tableUser($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,  $colDes TEXT, $colDate TEXT, $colPriority TEXT, $colStatus INTEGER)
          ''');
    });
    return theDb;
  }

  DatabaseHelper.internal();

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(tasksTable);
    return result;
  }

  Future<Task> insert(Task task) async {
    var dbClient = await db;
    task.id = await dbClient?.insert(tableUser, task.toMap());
    return task;
  }

  // Future<List<Task>> getTaskList() async {
  //   final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
  //   final List<Task> taskList = [];
  //   taskMapList.forEach((taskMap) {
  //     taskList.add(Task.fromMap(taskMap));
  //   });
  //   taskList.sort((taskA, taskB) => taskA.date!.compareTo(taskB.date!));
  //   return taskList;
  // }
  //
  // Future<int> insertTask(Task task) async {
  //   Database? db = await this.db;
  //   final int result = await db!.insert(tasksTable, task.toMap());
  //   return result;
  // }
  //
  // Future<int> updateTask(Task task) async {
  //   Database? db = await this.db;
  //   final int result = await db!.update(
  //     tasksTable,
  //     task.toMap(),
  //     where: '$colId = ?',
  //     whereArgs: [task.id],
  //   );
  //   return result;
  // }
  //
  // Future<int> deleteTask(int id) async {
  //   Database? db = await this.db;
  //   final int result = await db!.delete(
  //     tasksTable,
  //     where: '$colId = ?',
  //     whereArgs: [id],
  //   );
  //   return result;
  // }
  //
  // Future<int> deleteAllTask() async {
  //   Database? db = await this.db;
  //   final int result = await db!.delete(tasksTable);
  //   return result;
  // }

  Future<Task?> getUser(int id) async {
    var dbClient = await db;
    var maps = (await dbClient!.query(tableUser,
        columns: [colId, colTitle, colDes, colDate, colPriority, colStatus],
        where: '$colId = ?',
        whereArgs: [id]));
    if (maps.length > 0) {
      return Task.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!
        .delete(tableUser, where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> update(Task user) async {
    var dbClient = await db;
    return await dbClient!.update(tableUser, user.toMap(),
        where: '$colId = ?', whereArgs: [user.id]);
  }

  Future<List> getAllUsers() async {
    List<Task> user = [];
    var dbClient = await db;
    var maps = (await dbClient!.query(tableUser, columns: [
      colId,
      colTitle,
      colDes,
      colDate,
      colPriority,
      colStatus
    ]));
    if (maps.length > 0) {
      maps.forEach((f) {
        user.add(Task.fromMap(f));
//          print("getAllUsers"+ User.fromMap(f).toString());
      });
    }
    return user;
  }

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }
}
