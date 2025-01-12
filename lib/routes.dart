import 'package:flutter/material.dart';
import 'package:real_time_collaboration_application/auth/screens/login.dart';
import 'package:real_time_collaboration_application/auth/screens/signUp.dart';
import 'package:real_time_collaboration_application/chat/screen/chat_screen.dart';
import 'package:real_time_collaboration_application/kanban/screen/all-list.dart';
import 'package:real_time_collaboration_application/kanban/screen/baclog.dart';
import 'package:real_time_collaboration_application/kanban/screen/complete-task-screen.dart';
import 'package:real_time_collaboration_application/kanban/screen/review.dart';
import 'package:real_time_collaboration_application/kanban/screen/to-do.dart';
import 'package:real_time_collaboration_application/team/screens/createTeam.dart';
import 'package:real_time_collaboration_application/team/screens/joinOrCreateTeam.dart';
import 'package:real_time_collaboration_application/team/screens/joinTeam.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignUpPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpPage(),
      );
    case LoginPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginPage(),
      );
    case JoinTeam.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const JoinTeam(),
      );
    case CreateTeam.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CreateTeam(),
      );
    case Joinorcreateteam.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Joinorcreateteam(),
      );
     case Backlog.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  Backlog(),
      );
    case ToDoScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  ToDoScreen(),
      );
    case Review.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  Review(),
      );
      case CompleteTask.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  CompleteTask(),
      );
    case AllTask.routeName:
      final args = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AllTask(
          teamId: args,
        ),
      );

    case ChatScreen.routeName:
      final args = routeSettings.arguments as Map<String, dynamic>;
      String taskId = args['taskId']; // Extract taskId

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ChatScreen(taskId: taskId,),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen does not exist!!"),
          ),
        ),
      );
  }
}
