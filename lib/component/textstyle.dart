import 'package:flutter/material.dart';

class TextStyles {
  // Title Text Style
  static const TextStyle title = TextStyle(
    fontFamily: 'Inter',
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.4,
    color: Colors.black, // Title text color
  );

  // Subtitle Text Style
  static const TextStyle subtitle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.1,
    letterSpacing: 0.6,
    color: Colors.black87, // Subtitle text color
  );

  // Body Text Style
  static TextStyle bodyText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 11.0,
    fontWeight: FontWeight.normal,
    height: 1.3,
    letterSpacing: 1.0,
    color: Colors.grey[800], // Body text color
  );

  // Small Text Style
  static TextStyle smallText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: 0.8,
    color: Colors.grey[600], // Small text color
  );

  // Caption Text Style
  static TextStyle caption = TextStyle(
    fontFamily: 'Inter',
    fontSize: 8.0,
    fontWeight: FontWeight.w300,
    height: 1.1,
    letterSpacing: 0.6,
    color: Colors.grey[500], // Caption text color
  );
  static TextStyle biggerText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 30.0,
    fontWeight: FontWeight.w600,
    height: 1.1,
    letterSpacing: 0.6,
    color: Colors.grey[500], // Caption text color
  );
  static TextStyle normaltext = const TextStyle(
    fontFamily: 'Inter',
    fontSize: 14.0,
    height: 1.1,
    letterSpacing: 0.6,
    color: Colors.white, // Caption text color
  );
  static TextStyle currencytext = const TextStyle(
    fontFamily: 'Inter',
    fontSize: 30.0,
    fontWeight: FontWeight.w600,
    height: 1.1,
    letterSpacing: 0.6,
    color: Colors.white, // Caption text color
  );
}
