import 'package:flutter/material.dart';
import 'package:real_time_collaboration_application/auth/screens/login.dart';
import 'package:real_time_collaboration_application/auth/screens/signUp.dart';
import 'package:real_time_collaboration_application/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const LoginPage(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
