import 'package:flutter/material.dart';
import 'package:my_furniture/core/init/theme/light/color_scheme_light.dart';

class TextThemeLight {
  TextThemeLight._init();
  static TextThemeLight? _instance;
  static TextThemeLight get instance => _instance ??= TextThemeLight._init();

  final TextStyle TitleExtraBig = TextStyle(
      fontWeight: FontWeight.w600, // semi-bold
      fontSize: 32,
      fontFamily: 'Poppins',
      letterSpacing: 0.5,
      color: ColorSchemeLight.instance.orange);

  final TextStyle TitleBig = TextStyle(
      fontWeight: FontWeight.w600, // semi-bold
      fontSize: 24,
      fontFamily: 'Poppins',
      letterSpacing: 0.5,
      color: ColorSchemeLight.instance.dark);

  final TextStyle TitleMedium = TextStyle(
      fontWeight: FontWeight.w600, // semi-bold
      fontSize: 20,
      fontFamily: 'Poppins',
      letterSpacing: 0.5,
      color: ColorSchemeLight.instance.dark);

  final TextStyle TextMedium =
      TextStyle(fontSize: 14, fontFamily: 'Poppins', letterSpacing: 0.5, color: ColorSchemeLight.instance.darkGray);
  final TextStyle TextSmall =
      TextStyle(fontSize: 12, fontFamily: 'Poppins', letterSpacing: 0.5, color: ColorSchemeLight.instance.darkGray);
}
