import 'package:flutter/material.dart';
import 'package:my_furniture/core/init/theme/light/color_scheme_light.dart';

class TextThemeLight {
  TextThemeLight._init();
  static TextThemeLight? _instance;
  static TextThemeLight get instance => _instance ??= TextThemeLight._init();

  final TextStyle TitleExtraBig = TextStyle(
      fontSize: 32, fontFamily: 'Poppins-SemiBold.ttf', letterSpacing: 0.5, color: ColorSchemeLight.instance.orange);

  final TextStyle TitleBig = TextStyle(
      fontSize: 24, fontFamily: 'Poppins-SemiBold.ttf', letterSpacing: 0.5, color: ColorSchemeLight.instance.dark);
  final TextStyle TitleMedium = TextStyle(
      fontSize: 20, fontFamily: 'Poppins-SemiBold.ttf', letterSpacing: 0.5, color: ColorSchemeLight.instance.dark);

  final TextStyle TextMedium = TextStyle(
      fontSize: 14, fontFamily: 'Poppins-Regular.ttf', letterSpacing: 0.5, color: ColorSchemeLight.instance.darkGray);
  final TextStyle TextSmall = TextStyle(
      fontSize: 12, fontFamily: 'Poppins-Regular.ttf', letterSpacing: 0.5, color: ColorSchemeLight.instance.darkGray);
}
