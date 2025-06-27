import 'package:flutter/material.dart';

class ReusableInputField extends StatefulWidget {
  final String labelText;
  final bool isPassword;
  final TextEditingController controller;
  final IconData? icon;
  final bool showPasswordIcon;
  final FormFieldValidator<String>? validator;

  const ReusableInputField({
    super.key,
    required this.labelText,
    this.isPassword = false,
    required this.controller,
    this.icon,
    this.showPasswordIcon = true,
    required this.validator
  });

  @override
  _ReusableInputFieldState createState() => _ReusableInputFieldState();
}

class _ReusableInputFieldState extends State<ReusableInputField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator ,
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
