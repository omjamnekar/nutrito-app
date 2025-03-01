import 'package:flutter/material.dart';
import 'package:nutrito/util/theme/color.dart';

class InstantAlertSettingsPage extends StatefulWidget {
  const InstantAlertSettingsPage({super.key});

  @override
  _InstantAlertSettingsPageState createState() =>
      _InstantAlertSettingsPageState();
}

class _InstantAlertSettingsPageState extends State<InstantAlertSettingsPage> {
  bool soundAlert = true;
  bool vibrationAlert = true;
  bool popupAlert = true;
  bool emailNotification = false;
  bool criticalOnly = false;

  void _saveSettings() {
    // Save settings logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alert settings saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instant Alert Settings'),
        backgroundColor: ColorManager.bluePrimary.withOpacity(0.1),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customize Your Alerts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Sound Alert'),
              value: soundAlert,
              onChanged: (bool value) {
                setState(() {
                  soundAlert = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Vibration Alert'),
              value: vibrationAlert,
              onChanged: (bool value) {
                setState(() {
                  vibrationAlert = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Popup Alert'),
              value: popupAlert,
              onChanged: (bool value) {
                setState(() {
                  popupAlert = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Email Notification'),
              value: emailNotification,
              onChanged: (bool value) {
                setState(() {
                  emailNotification = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Only Critical Alerts'),
              value: criticalOnly,
              onChanged: (bool value) {
                setState(() {
                  criticalOnly = value;
                });
              },
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: _saveSettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.bluePrimary,
                ),
                child: const Text('Save Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
