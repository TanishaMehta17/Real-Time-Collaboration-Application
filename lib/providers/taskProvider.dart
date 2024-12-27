import 'package:flutter/material.dart';
import 'package:real_time_collaboration_application/model/task.dart';

class TaskProvider with ChangeNotifier {
  Task _task = Task(
    id: '',
    bodyText1: '',
    bodyText2: '',
    heading1: '',
    heading2: '',
    name: '',
    date: '',
    category: '',
    membersName: List.empty(),
  );
  
  Task get task => task;

  void setTask(String task) {
    _task = Task.fromJson(task);
    notifyListeners();
  }

  void setTaskFromModel(Task task) {
    _task = task;
    notifyListeners();
  }

  List<Task> _allTasks = [];
  List<Task> _toDoTasks = [];
  List<Task> _backlogTasks = [];
  List<Task> _reviewTasks = [];

  List<Task> get allTasks => _allTasks;
  List<Task> get toDoTasks => _toDoTasks;
  List<Task> get backlogTasks => _backlogTasks;
  List<Task> get reviewTasks => _reviewTasks;

  void addTask(Task task) {
    _allTasks.add(task);
    if (task.category == 'To-Do') {
      _toDoTasks.add(task);
    } else if (task.category == 'Backlog') {
      _backlogTasks.add(task);
    } else if (task.category == 'Review') {
      _reviewTasks.add(task);
    }
    notifyListeners();
  }

  List<Task> getTasksByCategory(String category) {
    if (category == 'All') {
      return _allTasks;
    } else if (category == 'To-Do') {
      return _toDoTasks;
    } else if (category == 'Backlog') {
      return _backlogTasks;
    } else {
      return _reviewTasks;
    }
  }
}
