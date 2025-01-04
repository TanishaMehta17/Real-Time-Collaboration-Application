import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:real_time_collaboration_application/global_variable.dart';
import 'package:real_time_collaboration_application/model/task.dart';

import 'package:real_time_collaboration_application/providers/taskProvider.dart';
import 'package:real_time_collaboration_application/providers/teamProvider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

typedef Result = void Function(bool success);
typedef TaskResult = void Function(bool success, List<dynamic> tasks);
typedef TaskResults = void Function(bool success, List<dynamic> tasks);

class TaskService {
  Future<void> CreateTask({
    required BuildContext context,
    required String TaskName,
    required String TaskDecscription1,
    required String TaskDescription,
    required String TaskStatus,
    required String teamId,
    required String TaskType,
    required String date,
    required List<String> membersName, //selected members names
    required Result callback,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(membersName);

    final response = await http.post(
      Uri.parse('$uri/api/tasks/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token!,
      },
      body: jsonEncode(<String, dynamic>{
        'title': TaskName,
        'type': TaskType,
        'description': TaskDescription,
        'description1': TaskDecscription1,
        'status': TaskStatus,
        'teamId': teamId,
        'date': date,
        'membersName': membersName,
      }),
    );
    final data = json.decode(response.body);
    debugPrint(data.toString());

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    if (data['isSuccess']) {
      taskProvider
          .setTask(response.body); // Update the task list in TaskProvider
        
      callback(true);
    } else {
      callback(false);
    }
  }

  Future<void> getmembers({
    required BuildContext context,
    required String teamname,
    required TaskResult callback,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.post(
      Uri.parse('$uri/api/teams/getTeamMenbers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token!,
      },
      body: jsonEncode(<String, String>{
        'name': teamname,
      }),
    );
    final data = json.decode(response.body);
    debugPrint(data.toString());
    if (data['isSuccess']) {
      callback(true, data['members']);
    } else {
      callback(false, []);
    }
  }

  Future<void> getTask({
    required BuildContext context,
    required String teamId,
    required TaskResults callback,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    String? token = prefs.getString('token');
    final response = await http.post(
      Uri.parse('$uri/api/tasks/getTask'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token!,
      },
      body: jsonEncode(<String, String>{
        'teamId': teamId,
      }),
    );
    // print(response.body);
    final data = json.decode(response.body);
    // debugPrint(data);
    if (data['isSuccess']) {
      callback(true, data['tasks']);
    } else {
      callback(false, []);
    }
  }
}

