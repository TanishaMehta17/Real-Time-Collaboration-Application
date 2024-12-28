// import 'package:flutter/material.dart';
// import 'package:real_time_collaboration_application/model/task.dart';

// class TaskProvider with ChangeNotifier {
//   Task _task = Task(
//     id: '',
//     bodyText1: '',
//     bodyText2: '',
//     heading1: '',
//     heading2: '',
//     name: '',
//     date: '',
//     category: '',
//     membersName: List.empty(),
//   );

//   Task get task => task;

//   void setTask(String task) {
//     _task = Task.fromJson(task);
//     notifyListeners();
//   }

//   void setTaskFromModel(Task task) {
//     _task = task;
//     notifyListeners();
//   }

//   List<Task> _allTasks = [];
//   List<Task> _toDoTasks = [];
//   List<Task> _backlogTasks = [];
//   List<Task> _reviewTasks = [];

//   List<Task> get allTasks => _allTasks;
//   List<Task> get toDoTasks => _toDoTasks;
//   List<Task> get backlogTasks => _backlogTasks;
//   List<Task> get reviewTasks => _reviewTasks;

//    void setTasks(List<dynamic> tasks) {
//     _allTasks = tasks.map((task) => Task.fromJson(task)).toList();
//     notifyListeners();
//   }

//     void getTasksByCategory(String category) {
//     if (category == 'to-do') {
//       _toDoTasks = _allTasks.where((task) => task.category == 'to-do').toList();
//     } else if (category == 'backlog') {
//       _backlogTasks = _allTasks.where((task) => task.category == 'backlog').toList();
//     } else if (category == 'review') {
//       _reviewTasks = _allTasks.where((task) => task.category == 'review').toList();
//     } else if (category == 'all') {
//       _toDoTasks = _allTasks.where((task) => task.category == 'to-do').toList();
//       _backlogTasks = _allTasks.where((task) => task.category == 'backlog').toList();
//       _reviewTasks = _allTasks.where((task) => task.category == 'review').toList();
//     }
//     notifyListeners();
//   }

//   // Add a new task
//   void addTask(Task task) {
//     _allTasks.add(task);
//     getTasksByCategory(task.category);
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:real_time_collaboration_application/model/task.dart';

class TaskProvider with ChangeNotifier {
  // Single Task
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
    return _allTasks.where((task) => task.category.toLowerCase() == category.toLowerCase()).toList();
  }

  // Set tasks from a list of JSON
  void setTasks(List<dynamic> tasks) {
    _allTasks = tasks.map((task) => Task.fromJson(task)).toList();
    notifyListeners();
  }

  // Add a new task
  void addTask(Task task) {
    _allTasks.add(task);
    notifyListeners();
  }

}
