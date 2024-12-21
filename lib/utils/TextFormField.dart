import 'package:flutter/material.dart';
import 'package:real_time_collaboration_application/common/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: white),
        hintText: hintText,
        hintStyle: const TextStyle(color: white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: white),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: white, width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Colors.transparent,
        suffixIcon: suffixIcon,
      ),
      style: const TextStyle(color: white),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
