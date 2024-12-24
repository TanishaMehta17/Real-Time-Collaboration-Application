import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:real_time_collaboration_application/global_variable.dart';
import 'package:real_time_collaboration_application/providers/userProvider.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

typedef Result = void Function(bool success);
class TeamService {
  Future<void> JoinTeam({
   required BuildContext context,
   required String TeamName,
    required String password,
    required Result callback,
  }) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final response = await http.post(
      Uri.parse('$uri/api/teams/join'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': userProvider.user.token,
      },
      body: jsonEncode(<String, String>{
        'name': TeamName,
        'password': password,
      }),
    );

    Map<String, dynamic> data = json.decode(response.body);
    if (data['isSuccess']) {
      callback(true);
    }
    else{
      callback(false);
    }



  }


  Future<void> CreateTeam({
    required BuildContext context,
    required String ManagerId,
    required String TeamName,
    required String password,
    required Result callback,
  }) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final response = await http.post(
      Uri.parse('$uri/api/teams/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': userProvider.user.token,
      },
      body: jsonEncode(<String, String>{
        'managerid': ManagerId,
        'name': TeamName,
        'password': password,
      }),
    );

    Map<String, dynamic> data = json.decode(response.body);
    if (data['isSuccess']) {
      callback(true);
    }
    else{
      callback(false);
    } 
  }
}