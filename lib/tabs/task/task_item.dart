import 'package:flutter/material.dart';
import 'package:todo3/app_theme.dart';

class TaskItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              height: 62,
              width: 4,
              color: AppTheme.primary,
              margin: EdgeInsetsDirectional.only(end: 10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Play football',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: AppTheme.primary),
                ),
                Text(
                  'this is task discribtion',
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppTheme.primary),
              height: 34,
              width: 69,
              child: Image.asset('assets/images/icon_check.png'),
            ),
          ],
        ));
  }
}
