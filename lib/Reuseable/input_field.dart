import 'package:flutter/material.dart';

class ReusableInputField extends StatelessWidget {
  final String labelText;
  final bool isPassword;
  final TextEditingController controller;
  final IconData icon;

  const ReusableInputField({
    Key? key,
    required this.labelText,
    this.isPassword = false,
    required this.controller,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        prefixIcon: Icon(icon),
      ),
    );
  }
}
