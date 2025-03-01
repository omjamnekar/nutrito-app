import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/util/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeSettings extends ConsumerStatefulWidget {
  const AppThemeSettings({Key? key}) : super(key: key);

  @override
  _AppThemeSettingsState createState() => _AppThemeSettingsState();
}

class _AppThemeSettingsState extends ConsumerState<AppThemeSettings> {
  bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Settings'),
      ),
      body: SwitchListTile(
        title: Text('Dark Theme'),
        value: _isDarkTheme,
        onChanged: (bool value) {
          setState(() {
            _isDarkTheme = value;
            ref.read(themeNotifierProvider.notifier).toggleTheme();
          });
        },
      ),
    );
  }
}
