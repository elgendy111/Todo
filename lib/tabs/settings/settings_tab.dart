import 'package:flutter/material.dart';
import 'package:todo3/app_theme.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppTheme.primary,
          ),
          height: MediaQuery.of(context).size.height * 0.17,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(top: 40, start: 20),
            child: Text(
              'Settings',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 22, color: AppTheme.white),
            ),
          ),
        )
      ],
    );
  }
}
