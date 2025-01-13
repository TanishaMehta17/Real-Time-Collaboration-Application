import 'package:flutter/material.dart';
import 'package:real_time_collaboration_application/common/colors.dart';
import 'package:real_time_collaboration_application/common/typography.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller; // Define controller
  final String label; // Define label


  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
  
  });

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$label cannot be empty',
          style: RTSTypography.smallText.copyWith(color: white),
        ),
        backgroundColor: errorPrimaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          // Return error string for the field
          return '$label cannot be empty';
        }
        return null;
      },
      onFieldSubmitted: (value) {
        if (value.isEmpty) {
          showSnackBar(context); // Show snackbar on field submission
        }
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: textColor2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Icon(Icons.edit, color: textColor2),
      ),
    );
  }
}
