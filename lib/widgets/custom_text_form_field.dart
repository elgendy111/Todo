import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  int? maxLines;
  String? Function(String?)? validator;
  CustomTextFormField(
      {required this.controller,
      required this.hintText,
      this.maxLines,
      this.validator});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      maxLines: maxLines,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
