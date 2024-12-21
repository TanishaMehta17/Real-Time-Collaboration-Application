
import 'package:flutter/material.dart';
import 'package:real_time_collaboration_application/auth/screens/login.dart';
import 'package:real_time_collaboration_application/auth/screens/signUp.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignUpPage.routeName:
      {
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const SignUpPage(),
        );
      }
      case LoginPage.routeName:
      {
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const LoginPage(),
        );
      }

    default:
      {
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
}
