import 'package:flutter/material.dart';
import 'package:todo3/app_theme.dart';
import 'package:todo3/home_screenn.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
      },
      theme:AppTheme.lightTheme ,
      darkTheme:AppTheme.darkTheme ,
      themeMode:ThemeMode.light ,
    );
  }
}
