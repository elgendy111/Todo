import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo3/app_theme.dart';
import 'package:todo3/tabs/settings/settings_provider.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final int? maxLines;
  final String? Function(String?)? validator;
  final bool isPassword;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.validator,
    this.isPassword = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return TextFormField(
      style: TextStyle(
          color: settingsProvider.isDark
              ? AppTheme.white.withOpacity(0.5)
              : AppTheme.black),
      controller: widget.controller,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: settingsProvider.isDark
                  ? AppTheme.white.withOpacity(0.5)
                  : AppTheme.grey),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    isObscure = !isObscure;
                    setState(() {});
                  },
                  icon: Icon(
                    isObscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ))
              : null),
      maxLines: widget.maxLines,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: Colors.grey,
      obscureText: isObscure,
    );
  }
}
