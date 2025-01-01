import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';
import 'package:real_time_collaboration_application/providers/userProvider.dart';
import 'package:real_time_collaboration_application/team/screens/createTeam.dart';
import 'package:real_time_collaboration_application/team/screens/joinTeam.dart';

class Joinorcreateteam extends StatelessWidget {
  static const String routeName = '/joinOrCreateTeam-screen';
  const Joinorcreateteam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // Color(0xFFE3F2FD), // Very Light Blue
              // Color.fromARGB(255, 149, 182, 209), // Slightly Deeper Light Blue
              gradientColor1,
              gradientColor2,
              gradientColor1,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                "Join one of the teams",
                style: RTSTypography.mediumText.copyWith(
                  color: textColor1,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Text(
                "Or create your own team to collaborate and achieve your goals together.",
                style: RTSTypography.mediumText.copyWith(
                  color: textColor1.withOpacity(0.7),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              'assets/png/team.png', 
              width: 300,
              height: 300,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context,CreateTeam.routeName );
                  },
                  
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: black26,
                              blurRadius: 15,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person_add,
                            color: iconColor1,
                            size: 40,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Create your Team",
                        style: RTSTypography.mediumText.copyWith(
                          color: textColor1.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context,JoinTeam.routeName );
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: black26,
                              blurRadius: 15,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.group_add,
                            color: iconColor1,
                            size: 40,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Join a Team",
                        style: RTSTypography.mediumText.copyWith(
                          color: textColor1.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    // Add your onPressed code here!
                    // Code to expire the token
                    // Assuming you have a method to handle token expiration
                    // var userprovider = Provider.of<UserProvider>(context, listen: false);
                    // userprovider.user.token = "123";
                    Navigator.pushReplacementNamed(context, '/login-screen');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'New Button',
                    style: RTSTypography.mediumText.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
