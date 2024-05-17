import 'package:flutter/material.dart';
import '../models/task.dart';
import '../utils/shared_preferences_helper.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider() {
    loadTasks();
  }

  void loadTasks() async {
    _tasks = await SharedPreferencesHelper.loadTasks();
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    SharedPreferencesHelper.saveTasks(_tasks);
    notifyListeners();
  }

  void updateTask(String id, Task newTask) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex >= 0) {
      _tasks[taskIndex] = newTask;
      SharedPreferencesHelper.saveTasks(_tasks);
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    SharedPreferencesHelper.saveTasks(_tasks);
    notifyListeners();
  }
}
