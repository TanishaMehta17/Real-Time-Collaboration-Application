import 'package:flutter/material.dart';
import 'package:real_time_collaboration_application/model/task.dart';

class TaskProvider with ChangeNotifier {
  // Single Task
  Task _task = Task(
    id: '',
    description: '',
    description1: '',
    status: '',
    title: '',
    teamId: '',
    date: '',
    type: '',
    membersName: List.empty(),
  );

  Task get task => _task;

  void setTask(String task) {
    _task = Task.fromJson(task);
    notifyListeners();
  }

  void setTaskFromModel(Task task) {
    _task = task;
    notifyListeners();
  }

  // Task Lists
  List<Task> _allTasks = [];
  List<Task> get allTasks => _allTasks;

  // Filter tasks by category
  List<Task> getTasksByCategory(String category) {
    return _allTasks
        .where((task) => task.status.toLowerCase() == category.toLowerCase())
        .toList();
  }

  void setTasks(List<dynamic> tasks) {
    _allTasks = tasks
        .map((task) => Task.fromMap(task as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  // Add a new task
  void addTask(Task task) {
    // print(task);
    _allTasks.add(task);
    notifyListeners();
  }
}
