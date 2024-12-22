import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_time_collaboration_application/auth/screens/signUp.dart';
import 'package:real_time_collaboration_application/auth/service/authservice.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';
import 'package:real_time_collaboration_application/models/user.dart';
import 'package:real_time_collaboration_application/utils/TextFormField.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
   final AuthService authService = AuthService();
  // Move controllers outside build method so they persist
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

 void signin( BuildContext context) {
     authService.login(
      context: context,
      email: emailController.text,
      password: passwordController.text,
      callback: (bool success) {
      if (success) {
      //onTapLogin(context);
      print("login Succesfull");
      } else {
        
        print("Password is Incorrect");
      }
    },  
    );
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
                const Text(
                  "Welcome,",
                  style: RTSTypography.heading,
                ),
                const Text(
                  "Login to start with, Tanisha",
                  style: RTSTypography.mediumText,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: emailController,
                          labelText: "Email",
                          hintText: "Enter your email",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 10),
                        const Text(
                          "Forget Password?",
                          style: RTSTypography.smallText,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: primaryColor),
                          onPressed: () {
                            signin(context);
                          },
                          child: const Text(
                            "Log In",
                            style: RTSTypography.buttonText,
                          ),
                        ),
                        const SizedBox(height: 16),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: " Don't have an account? ",
                                  style: RTSTypography.smallText1),
                              TextSpan(
                                text: 'Register',
                                style: RTSTypography.bold,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, SignUpPage.routeName);
                                  },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 60),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: dividerColor,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Sign up with",
                                style: RTSTypography.smallText1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: dividerColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/google.svg',
                              width: 100,
                              height: 100,
                            ),
                            SvgPicture.asset(
                              'assets/svgs/facebook.svg',
                              width: 100,
                              height: 100,
                            ),
                          ],
                        )
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
  void onTapLogin(BuildContext context) {
    Navigator.pushNamed(context, '/home');
  }