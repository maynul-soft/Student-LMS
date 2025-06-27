import 'package:flutter/material.dart';

class ReusableInputField extends StatefulWidget {
  final String labelText;
  final bool isPassword;
  final TextEditingController controller;
  final IconData? icon;
  final bool showPasswordIcon;

  const ReusableInputField({
    Key? key,
    required this.labelText,
    this.isPassword = false,
    required this.controller,
    this.icon,
    this.showPasswordIcon = true,
  }) : super(key: key);

  @override
  _ReusableInputFieldState createState() => _ReusableInputFieldState();
}

class _ReusableInputFieldState extends State<ReusableInputField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword && !_showPassword,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.isPassword && widget.showPasswordIcon
            ? IconButton(
                icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              )
            : null,
      ),
    );
  }
}
