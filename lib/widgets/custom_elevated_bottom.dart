import 'package:flutter/material.dart';
import 'package:todo3/app_theme.dart';

class CustomElevatedBottom extends StatelessWidget {
  String label;
  VoidCallback onPressed;
  CustomElevatedBottom({required this.label, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width, 52),
          backgroundColor: AppTheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: AppTheme.white),
      ),
    );
  }
}
