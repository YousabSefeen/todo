
import 'package:sqflite/sqflite.dart';

import '../Provider/task_mode.dart';

class DbHelper {
  static Database? _db;

  static const int _version = 1;
  static const String _tableName = 'tasks';

  static Future<void> initializeDataBase() async {
    if (_db != null) {
      print('Data Base is null');
      return;
    } else {
      try {
        String path = '${await getDatabasesPath()}tasks.db';

        _db = await openDatabase(path, version: _version,
            onCreate: (Database db, int version) async {
          print('Creating a new one');
          // When creating the db, create the table
          await db.execute(
            'CREATE TABLE $_tableName('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'title STRING, note TEXT, date STRING, '
            'startTime STRING, endTime STRING, '
            'remind INTEGER, repeat STRING, '
            'color INTEGER, isCompleted INTEGER)',
          );
        });
      } catch (error) {
        print('Error in  DataBase= $error');
      }
    }
  }

  static Future<int> insert(Task? task) async {
    try {
      print('DB insert function call ');
      return await _db!.insert(_tableName, task!.toJson());
    } catch (e) {
      print('DB insert function call Error=$e');
      return 90000;
    }
  }

  static Future<int> deleteAll() async {
    print('DB deleteAll function call ');

    return await _db!.delete(_tableName);
  }

  static Future<int> deleteSingle(Task? task) async {
    print('DB deleteSingle function call ');

    return await _db!
        .delete(_tableName, where: 'id = ?', whereArgs: [task!.id]);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('DB Query function call ');

    return await _db!.query(_tableName);
  }

  static Future<int> update(int id) async {
    print('DB update function call ');
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?
   ''', [1, id]);
  }
}
