import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo3/app_theme.dart';
import 'package:todo3/auth/login.dart';
import 'package:todo3/auth/register.dart';
import 'package:todo3/auth/user_provider.dart';
import 'package:todo3/home_screenn.dart';
import 'package:todo3/tabs/settings/settings_provider.dart';
import 'package:todo3/tabs/task/edit_task.dart';
import 'package:todo3/tabs/task/task_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SettingsProvider settingsProvider = SettingsProvider();
  await settingsProvider.loadTheme();
  await settingsProvider.loadLanguage();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
    ),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => TaskProvider()),
  ], child: const TodoApp()));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        EditTask.routeName: (_) => const EditTask(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
      },
      initialRoute: LoginScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingsProvider.themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settingsProvider.language),
    );
  }
}
