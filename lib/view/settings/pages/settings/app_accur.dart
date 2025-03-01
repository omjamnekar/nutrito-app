import 'package:flutter/material.dart';

class AppAccuracySettingsPage extends StatefulWidget {
  @override
  _AppAccuracySettingsPageState createState() =>
      _AppAccuracySettingsPageState();
}

class _AppAccuracySettingsPageState extends State<AppAccuracySettingsPage> {
  double _accuracy = 0.5;
  double _volume = 0.5;
  bool _notificationsEnabled = true;
  String _selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Accuracy and Volume Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Accuracy',
              style: TextStyle(fontSize: 18),
            ),
            Slider(
              value: _accuracy,
              min: 0,
              max: 1,
              divisions: 10,
              label: _accuracy.toString(),
              onChanged: (double value) {
                setState(() {
                  _accuracy = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'App Volume',
              style: TextStyle(fontSize: 18),
            ),
            Slider(
              value: _volume,
              min: 0,
              max: 1,
              divisions: 10,
              label: _volume.toString(),
              onChanged: (double value) {
                setState(() {
                  _volume = value;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Enable Notifications',
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: _notificationsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Select Theme',
                  style: TextStyle(fontSize: 18),
                ),
                DropdownButton<String>(
                  value: _selectedTheme,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTheme = newValue!;
                    });
                  },
                  items: <String>['Light', 'Dark', 'System']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
