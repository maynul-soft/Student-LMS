import 'package:flutter/material.dart';

class ElevatedButtonThemeSettings{
  static ElevatedButtonThemeData get lightTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      )
    );
  }
}
