import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lms/app/customTheme/text_field_theme.dart';
import 'package:lms/app/utils/app_colors.dart';

import '../customTheme/elevated_button_theme_settings.dart';

class AppTheme {

  static ThemeData get lightThemeData{
   return ThemeData(
      canvasColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColors.themColor
      ),
      scaffoldBackgroundColor: Color(0xFFEFEFEF),
      useMaterial3: true,
     inputDecorationTheme: TextFieldTheme.lightTheme,
     elevatedButtonTheme: ElevatedButtonThemeSettings.lightTheme



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