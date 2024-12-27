import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:real_time_collaboration_application/auth/screens/login.dart';
import 'package:real_time_collaboration_application/auth/service/authservice.dart';
import 'package:real_time_collaboration_application/chat/screen/chat_screen.dart';
import 'package:real_time_collaboration_application/model/user.dart';
import 'package:real_time_collaboration_application/providers/taskProvider.dart';
import 'package:real_time_collaboration_application/providers/teamProvider.dart';
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
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_)=> TeamProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserProvider>(context).user.id);
    bool isUserLoggedIn = Provider.of<UserProvider>(context).user.token.isNotEmpty;
    print(isUserLoggedIn);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      // home: isUserLoggedIn
      //     ? Joinorcreateteam()
      //     : const LoginPage(), // Correct context access for providers
      home: ChatScreen(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
    
}
