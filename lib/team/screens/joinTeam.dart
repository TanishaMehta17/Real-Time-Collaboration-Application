import 'package:flutter/material.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';
import 'package:real_time_collaboration_application/kanban/screen/all-list.dart';
import 'package:real_time_collaboration_application/utils/TextFormField.dart';

class JoinTeam extends StatefulWidget {
   static const String routeName = '/joinTeam-screen';
  const JoinTeam({super.key});

  @override
  State<JoinTeam> createState() => _JoinTeamState();
}


class _JoinTeamState extends State<JoinTeam> {
  final TextEditingController teamNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    teamNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradientColor1,
              gradientColor2,
              gradientColor1,
            ],
            stops: [0.2, 0.5, 1.0],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Join one of the teams",
                  style: RTSTypography.mediumText.copyWith(
                    color: textColor1,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Collaborate and achieve together!",
                  style: RTSTypography.mediumText.copyWith(
                    color: textColor1.withOpacity(0.7),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: teamNameController,
                          labelText: "Team Name",
                          hintText: "Enter the team name",
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the team name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: passwordController,
                          labelText: "Password",
                          hintText: "Enter your password",
                          keyboardType: TextInputType.text,
                          obscureText:
                              !_passwordVisible, // This controls the visibility of the text
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: primaryColor),
                          onPressed: () {
                              Navigator.pushNamed(context, AllTask.routeName);
                          },
                          child: const Text(
                            "Join",
                            style: RTSTypography.buttonText,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
