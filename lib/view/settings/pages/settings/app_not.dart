import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

final notificationProvider =
    StateNotifierProvider<NotificationController, Map<String, bool>>(
  (ref) => NotificationController(),
);

class NotificationController extends StateNotifier<Map<String, bool>> {
  NotificationController() : super({}) {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    state = {
      'general': prefs.getBool('general') ?? true,
      'meal_reminders': prefs.getBool('meal_reminders') ?? true,
      'ingredient_alerts': prefs.getBool('ingredient_alerts') ?? true,
      'recipe_suggestions': prefs.getBool('recipe_suggestions') ?? true,
      'weekly_reports': prefs.getBool('weekly_reports') ?? true,
      'offers_updates': prefs.getBool('offers_updates') ?? true,
      'dnd': prefs.getBool('dnd') ?? false,
    };
  }

  Future<void> toggleNotification(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
    state = {...state, key: value};
  }
}

class NotificationSettingsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationProvider);
    final notifier = ref.read(notificationProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
        backgroundColor: ColorManager.bluePrimary.withOpacity(0.5),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSwitchTile(
            context,
            'General Notifications',
            'general',
            notifications['general'] ?? true,
            notifier,
          ),
          _buildSwitchTile(
            context,
            'Meal Reminders',
            'meal_reminders',
            notifications['meal_reminders'] ?? true,
            notifier,
          ),
          _buildSwitchTile(
            context,
            'Ingredient Alerts',
            'ingredient_alerts',
            notifications['ingredient_alerts'] ?? true,
            notifier,
          ),
          _buildSwitchTile(
            context,
            'Recipe Suggestions',
            'recipe_suggestions',
            notifications['recipe_suggestions'] ?? true,
            notifier,
          ),
          _buildSwitchTile(
            context,
            'Weekly Health Reports',
            'weekly_reports',
            notifications['weekly_reports'] ?? true,
            notifier,
          ),
          _buildSwitchTile(
            context,
            'Special Offers & Updates',
            'offers_updates',
            notifications['offers_updates'] ?? true,
            notifier,
          ),
          Divider(),
          _buildSwitchTile(
            context,
            'Do Not Disturb Mode',
            'dnd',
            notifications['dnd'] ?? false,
            notifier,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context,
    String title,
    String key,
    bool value,
    NotificationController notifier,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: (newValue) => notifier.toggleNotification(key, newValue),
      activeColor: ColorManager.bluePrimary.withOpacity(0.4),
    );
  }
}
