import 'package:flutter/material.dart';
import 'package:gas_station/utils/constants.dart';

class CustomTextFeild extends StatefulWidget {
  final String? Function(String?)? validation;
  final bool isPassword;
  final String? hintText;
  final TextEditingController? controller;

  const CustomTextFeild({
    super.key,
    this.validation,
    this.isPassword = false,
    this.hintText,
    this.controller,
  });

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = !widget.isPassword; // visible by default if not password
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? !_passwordVisible : false,
      validator:
          widget.validation ??
          (String? value) =>
              (value == null || value.isEmpty) ? 'Required' : null,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }
}
