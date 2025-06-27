import 'package:flutter/material.dart';

class TextFieldTheme {
  static InputDecorationTheme get lightTheme {
    return const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    );
  }

  static InputDecoration get darkTheme {
    return const InputDecoration(
      border: OutlineInputBorder(),
    );
  }
}
