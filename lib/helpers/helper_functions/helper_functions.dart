import 'package:flutter/material.dart';

Color getFigmaColor(String value, [int percentageOpacity = 100]) {
  return Color(int.parse("0xff$value"))
      .withAlpha((((255 * percentageOpacity) ~/ 100)));
}
