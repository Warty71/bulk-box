import 'package:flutter/material.dart';
import '../constants/dimensions.dart';

class AppTextStyles {
  static const String fontFamily = 'Roboto';

  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.16,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.22,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.25,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: Dimensions.fontDisplay,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.2,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: Dimensions.fontXl,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.2,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: Dimensions.fontLg,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: Dimensions.fontMd,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.4,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: Dimensions.fontMd,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
  );
}
