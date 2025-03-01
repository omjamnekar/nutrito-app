import 'package:flutter/material.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanSettingsPage extends StatefulWidget {
  @override
  _ScanSettingsPageState createState() => _ScanSettingsPageState();
}

class _ScanSettingsPageState extends State<ScanSettingsPage> {
  bool enableAutoScan = false;
  bool enableIngredientWarnings = false;
  bool enableDetailedAnalysis = false;
  bool enableVoiceGuidance = false;
  bool enableScanHistory = false;
  bool enableSmartSuggestions = false;
  bool enableDietaryAlerts = false;
  bool enableCustomNotifications = false;
  bool enableEcoFriendlyScan = false;
  bool enableAIRecommendations = false;
  bool enableQuickScanMode = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      enableAutoScan = prefs.getBool('enableAutoScan') ?? false;
      enableIngredientWarnings =
          prefs.getBool('enableIngredientWarnings') ?? false;
      enableDetailedAnalysis = prefs.getBool('enableDetailedAnalysis') ?? false;
      enableVoiceGuidance = prefs.getBool('enableVoiceGuidance') ?? false;
      enableScanHistory = prefs.getBool('enableScanHistory') ?? false;
      enableSmartSuggestions = prefs.getBool('enableSmartSuggestions') ?? false;
      enableDietaryAlerts = prefs.getBool('enableDietaryAlerts') ?? false;
      enableCustomNotifications =
          prefs.getBool('enableCustomNotifications') ?? false;
      enableEcoFriendlyScan = prefs.getBool('enableEcoFriendlyScan') ?? false;
      enableAIRecommendations =
          prefs.getBool('enableAIRecommendations') ?? false;
      enableQuickScanMode = prefs.getBool('enableQuickScanMode') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('enableAutoScan', enableAutoScan);
    await prefs.setBool('enableIngredientWarnings', enableIngredientWarnings);
    await prefs.setBool('enableDetailedAnalysis', enableDetailedAnalysis);
    await prefs.setBool('enableVoiceGuidance', enableVoiceGuidance);
    await prefs.setBool('enableScanHistory', enableScanHistory);
    await prefs.setBool('enableSmartSuggestions', enableSmartSuggestions);
    await prefs.setBool('enableDietaryAlerts', enableDietaryAlerts);
    await prefs.setBool('enableCustomNotifications', enableCustomNotifications);
    await prefs.setBool('enableEcoFriendlyScan', enableEcoFriendlyScan);
    await prefs.setBool('enableAIRecommendations', enableAIRecommendations);
    await prefs.setBool('enableQuickScanMode', enableQuickScanMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Configuration Settings'),
        backgroundColor: ColorManager.bluePrimary.withOpacity(0.4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SwitchListTile(
              title: Text('Enable Auto Scan'),
              subtitle:
                  Text('Automatically analyze food ingredients upon scanning'),
              value: enableAutoScan,
              onChanged: (value) {
                setState(() {
                  enableAutoScan = value;
                });
                _savePreferences();
              },
            ),
            SwitchListTile(
              title: Text('Enable Ingredient Warnings'),
              subtitle:
                  Text('Receive alerts for harmful or unhealthy ingredients'),
              value: enableIngredientWarnings,
              onChanged: (value) {
                setState(() {
                  enableIngredientWarnings = value;
                });
                _savePreferences();
              },
            ),
            SwitchListTile(
              title: Text('Enable Detailed Analysis'),
              subtitle: Text('Get a detailed breakdown of food composition'),
              value: enableDetailedAnalysis,
              onChanged: (value) {
                setState(() {
                  enableDetailedAnalysis = value;
                });
                _savePreferences();
              },
            ),
            SwitchListTile(
              title: Text('Enable Voice Guidance'),
              subtitle: Text('Get spoken feedback for scans'),
              value: enableVoiceGuidance,
              onChanged: (value) {
                setState(() {
                  enableVoiceGuidance = value;
                });
                _savePreferences();
              },
            ),
            SwitchListTile(
              title: Text('Enable Scan History'),
              subtitle: Text('Keep a log of past scans'),
              value: enableScanHistory,
              onChanged: (value) {
                setState(() {
                  enableScanHistory = value;
                });
                _savePreferences();
              },
            ),
            SwitchListTile(
              title: Text('Enable Smart Suggestions'),
              subtitle: Text('Get AI-powered alternative suggestions'),
              value: enableSmartSuggestions,
              onChanged: (value) {
                setState(() {
                  enableSmartSuggestions = value;
                });
                _savePreferences();
              },
            ),
            SwitchListTile(
              title: Text('Enable Dietary Alerts'),
              subtitle: Text('Receive dietary restriction warnings'),
              value: enableDietaryAlerts,
              onChanged: (value) {
                setState(() {
                  enableDietaryAlerts = value;
                });
                _savePreferences();
              },
            ),
            SwitchListTile(
              title: Text('Enable Custom Notifications'),
              subtitle: Text('Set custom alerts for specific ingredients'),
              value: enableCustomNotifications,
              onChanged: (value) {
                setState(() {
                  enableCustomNotifications = value;
                });
                _savePreferences();
              },
            ),
            SwitchListTile(
              title: Text('Enable Eco-Friendly Scan'),
              subtitle: Text('Identify environmentally friendly products'),
              value: enableEcoFriendlyScan,
              onChanged: (value) {
                setState(() {
                  enableEcoFriendlyScan = value;
                });
                _savePreferences();
              },
            ),
            SwitchListTile(
              title: Text('Enable AI Recommendations'),
              subtitle: Text('Receive AI-based food recommendations'),
              value: enableAIRecommendations,
              onChanged: (value) {
                setState(() {
                  enableAIRecommendations = value;
                });
                _savePreferences();
              },
            ),
            SwitchListTile(
              title: Text('Enable Quick Scan Mode'),
              subtitle: Text('Faster scanning with minimal details'),
              value: enableQuickScanMode,
              onChanged: (value) {
                setState(() {
                  enableQuickScanMode = value;
                });
                _savePreferences();
              },
            ),
          ],
        ),
      ),
    );
  }
}
