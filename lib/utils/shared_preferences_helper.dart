import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class SharedPreferencesHelper {
  static const String _tasksKey = 'tasks';

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((task) => task.toJson()).toList();
    prefs.setStringList(_tasksKey, tasksJson);
  }

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getStringList(_tasksKey) ?? [];
    return tasksJson.map((taskJson) => Task.fromJson(taskJson)).toList();
  }
}
