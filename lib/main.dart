import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:real_time_collaboration_application/auth/screens/login.dart';
import 'package:real_time_collaboration_application/auth/service/authservice.dart';
import 'package:real_time_collaboration_application/providers/taskProvider.dart';
import 'package:real_time_collaboration_application/providers/userProvider.dart';
import 'package:real_time_collaboration_application/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: LoginPage(), // Ensure this is inside the providers context
        onGenerateRoute: (settings) => generateRoute(settings),
      ),
    );
  }
}
