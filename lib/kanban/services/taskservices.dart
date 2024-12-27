import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:real_time_collaboration_application/global_variable.dart';

import 'package:real_time_collaboration_application/providers/taskProvider.dart';
import 'package:real_time_collaboration_application/providers/teamProvider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


typedef Result = void Function(bool success);

class TaskService {

  Future<void> CreateTask({
    required BuildContext context,
    required String TaskName,
    required String TaskDescription,
    required String TaskStatus,
    required String teamId,
    required String TaskType,
    required List<String> membersName, //selected members names
    required Result callback,
  }) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.post(
      Uri.parse('$uri/api/tasks/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token!,
      },
      body: jsonEncode(<String, String>{
        'title':TaskName,
        'description': TaskDescription,
        'status':TaskStatus,
        'type':TaskType,
        'teamId':teamId,
        'membersName':membersName.toString(),
      }),
    );

    Map<String, dynamic> data = json.decode(response.body);
    debugPrint(data.toString());
    final taskprovider = Provider.of<TaskProvider>(context, listen: false);
    taskprovider.setTask(response.body);
    if (data['isSuccess']) {
      callback(true);
    } else {
      callback(false);
    }
  }

}