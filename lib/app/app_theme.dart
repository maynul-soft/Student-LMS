import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lms/app/customTheme/text_field_theme.dart';

class AppTheme {

  static ThemeData get lightThemeData{
   return ThemeData(
      canvasColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      scaffoldBackgroundColor: Color(0xFFEFEFEF),
      useMaterial3: true,
     inputDecorationTheme: TextFieldTheme.lightTheme
    );
  }
  static ThemeData get darkThemeData{
    return ThemeData(
      canvasColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      scaffoldBackgroundColor: Color(0xFFEFEFEF),
      useMaterial3: true,
    );
  }
}