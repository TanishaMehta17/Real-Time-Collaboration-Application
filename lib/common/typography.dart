import 'package:flutter/material.dart';
import 'colors.dart';

/// Font Size
class RTSTypography {
  static const TextStyle heading = TextStyle(
    fontFamily: 'SFProDisplay',
    color: primaryColor,
    fontSize: 42, // Material Design 3 convention
    fontWeight: FontWeight.bold,
  );
  static const TextStyle mediumText = TextStyle(
    fontFamily: 'SFProDisplay',
    color: textColor,
    fontSize: 22, // Material Design 3 convention
    fontWeight: FontWeight.w500,
  );
  static const TextStyle buttonText = TextStyle(
    fontFamily: 'SFProDisplay',
    color: white,
    fontSize: 16, // Material Design 3 convention
    fontWeight: FontWeight.w700,
  );
  static const TextStyle smallText = TextStyle(
    fontFamily: 'SFProDisplay',
    color: primaryColor,
    fontSize: 16, // Material Design 3 convention
    fontWeight: FontWeight.w400,
  );
   static const TextStyle smallText1 = TextStyle(
    fontFamily: 'SFProDisplay',
    color: textColor,
    fontSize: 16, // Material Design 3 convention
    fontWeight: FontWeight.w400,
  );
   static const TextStyle bold = TextStyle(
    fontFamily: 'SFProDisplay',
    color: primaryColor,
    fontSize: 16, // Material Design 3 convention
    fontWeight: FontWeight.bold,
  );
}
