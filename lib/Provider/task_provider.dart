import 'package:flutter/material.dart';
import 'package:flutter_todo/Provider/task_mode.dart';

import '../Services/db_helper.dart';

class TaskProvider with ChangeNotifier {
  List<Task> tasksList = [];

  void addTask({Task? task}) {
    DbHelper.insert(task);
getTasks();
    notifyListeners();
  }

  Future<void> getTasks() async {
    List<Map<String, dynamic>> tasks = await DbHelper.query();
    tasksList = tasks.map((data) => Task.fromJson(data)).toList();
    notifyListeners();
  }

  void deleteTask(Task task) async {
    await DbHelper.deleteSingle(task);
    getTasks();
    notifyListeners();
  }

  void updateTask(int id) async {
    await DbHelper.update(id);
getTasks();
    notifyListeners();
  }

  void deleteAll() async {
    await DbHelper.deleteAll();
   getTasks();
    notifyListeners();
  }
}
