import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:real_time_collaboration_application/auth/screens/login.dart';
import 'package:real_time_collaboration_application/model/user.dart';
import 'package:real_time_collaboration_application/providers/taskProvider.dart';
import 'package:real_time_collaboration_application/providers/userProvider.dart';
import 'package:real_time_collaboration_application/routes.dart';
import 'package:real_time_collaboration_application/team/screens/joinOrCreateTeam.dart';
import 'package:real_time_collaboration_application/utils/sizer.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    
   const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: Consumer<UserProvider>(
      builder: (context, userProvider, child) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home:  Provider.of<UserProvider>(context).user.token.isNotEmpty? Joinorcreateteam(): const LoginPage(), // Correct context access for providers
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
    ));
}
}