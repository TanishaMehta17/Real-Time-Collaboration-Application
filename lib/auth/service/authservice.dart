import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:real_time_collaboration_application/model/user.dart';
import 'package:real_time_collaboration_application/global_variable.dart';
import 'package:real_time_collaboration_application/providers/userprovider.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

typedef OtpVerificationCallback = void Function(bool success);

class AuthService {
  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
    required OtpVerificationCallback callback,
  }) async {
    final response = await http.post(
      Uri.parse('$uri/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    Map<String, dynamic> data = json.decode(response.body);
    //print(data);
    if (data['isSuccess']) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(data["data"]["token"]);
      prefs.setString('token', data['data']['token']);
      // ignore: use_build_context_synchronously
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (data["data"] != null) {
  userProvider.setUser(data["data"]["user"]);
}

      print(userProvider.user.token);
      callback(true);
    }
    else{
      callback(false);
    }
  }

  void updateUser(BuildContext context, dynamic userData) {
    Provider.of<UserProvider>(context, listen: false).setUser(userData["user"]);
  }

  Future<bool> register(
      {required BuildContext context,
      required String username,
      required String email,
      required String password,
      required String number,
      required String confirmpas}) async {
    User user = User(
      id: '',
      username: username,
      password: password,
      confirmpas: confirmpas,
      email: email,
      token: '',
    );
    print(user.toJson());
    final response = await http.post(
      Uri.parse('$uri/api/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: user.toJson(),
    );
    print(response.body);
    print(response.statusCode);
   
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
