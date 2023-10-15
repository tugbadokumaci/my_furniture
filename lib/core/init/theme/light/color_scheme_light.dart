import 'package:flutter/material.dart';

class ColorSchemeLight {
  ColorSchemeLight._init();
  static ColorSchemeLight? _instace;
  static ColorSchemeLight get instance => _instace ??= ColorSchemeLight._init();

  final Color dark = const Color(0xff121212);
  final Color orange = const Color(0xffe29547);
  final Color white = const Color(0xffffffff);
  final Color red = const Color(0xffe24747);
  final Color lightRed = Color.fromARGB(255, 234, 89, 89);
  final Color darkGray = const Color(0xffaaaaaa);
  // final Color gray = const Color(0xffcfcfcf);
  final Color extraDarkGray = const Color(0xff69727D);

  final Color lightGray = const Color(0xffdedede);
  final Color extraLightGray = const Color(0xfffafafa);
  final Color gray = const Color(0xffc4c4c4);
  final Color yellow = const Color(0xffffc107);
  final Color cream = const Color(0xffffeedd);
  final Color blue = const Color(0xff0895ED);
  final Color green = const Color(0xffB1F2BC);

  final Color azure = const Color(0xff27928d);
}
