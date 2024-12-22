import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_collaboration_application/kanban/screen/all-list.dart';
import 'package:real_time_collaboration_application/provider/taskProvider.dart';
import 'package:real_time_collaboration_application/routes.dart';


void main() {
   runApp(
    ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child:const MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home:  AllTask(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
