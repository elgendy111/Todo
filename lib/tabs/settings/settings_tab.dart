import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo3/app_theme.dart';
import 'package:todo3/tabs/settings/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
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
              AppLocalizations.of(context)!.settings,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 22,
                  color: settingsProvider.isDark
                      ? AppTheme.backgriundDark
                      : AppTheme.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    settingsProvider.isDark
                        ? AppLocalizations.of(context)!.lightMode
                        : AppLocalizations.of(context)!.darkMode,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 20,
                          color: settingsProvider.isDark
                              ? AppTheme.white
                              : AppTheme.black,
                        ),
                  ),
                  Switch(
                    value: settingsProvider.isDark,
                    onChanged: (isDark) => settingsProvider.changeThemeMode(
                        isDark ? ThemeMode.dark : ThemeMode.light),
                    activeTrackColor: AppTheme.primary,
                    inactiveTrackColor: AppTheme.white,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 20,
                          color: settingsProvider.isDark
                              ? AppTheme.white
                              : AppTheme.black,
                        ),
                  ),
                  DropdownButton<String>(
                    style: TextStyle(
                      color: settingsProvider.isDark
                          ? AppTheme.primary
                          : AppTheme.black,
                    ),
                    alignment: Alignment.centerLeft,
                    value: settingsProvider.language,
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: 'ar',
                        child: Text('العربيه'),
                      ),
                    ],
                    onChanged: (selectedLang) {
                      if (selectedLang == null) return;
                      settingsProvider.changeLanguage(selectedLang);
                    },
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
