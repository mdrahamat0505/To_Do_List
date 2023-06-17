import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  DatabaseHelper._instance();

  String tasksTable = 'task_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDes = 'Descreption';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';

// Task Tables
// Id | Title| Description | Date | Priority | Status
// 0     ''      ''      ''         0
// 1     ''      ''      ''         0
// 2     ''      ''      ''         0
}
