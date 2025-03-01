import 'package:flutter/material.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthGuideSettings extends StatefulWidget {
  @override
  _HealthGuideSettingsState createState() => _HealthGuideSettingsState();
}

class _HealthGuideSettingsState extends State<HealthGuideSettings> {
  bool enableHealthRecommendations = false;
  String dietType = 'Balanced';
  String activityLevel = 'Moderate';
  String healthGoal = 'Maintain Weight';
  double dailyCalories = 2000;
  double hydrationGoal = 2.0;
  List<String> selectedAllergies = [];
  final List<String> allergyOptions = [
    'Dairy',
    'Nuts',
    'Gluten',
    'Soy',
    'Eggs'
  ];
  final TextEditingController medicalDetailsController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      enableHealthRecommendations =
          prefs.getBool('enableHealthRecommendations') ?? false;
      dietType = prefs.getString('dietType') ?? 'Balanced';
      activityLevel = prefs.getString('activityLevel') ?? 'Moderate';
      healthGoal = prefs.getString('healthGoal') ?? 'Maintain Weight';
      dailyCalories = prefs.getDouble('dailyCalories') ?? 2000;
      hydrationGoal = prefs.getDouble('hydrationGoal') ?? 2.0;
      selectedAllergies = prefs.getStringList('selectedAllergies') ?? [];
      medicalDetailsController.text = prefs.getString('medicalDetails') ?? '';
    });
  }

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'enableHealthRecommendations', enableHealthRecommendations);
    await prefs.setString('dietType', dietType);
    await prefs.setString('activityLevel', activityLevel);
    await prefs.setString('healthGoal', healthGoal);
    await prefs.setDouble('dailyCalories', dailyCalories);
    await prefs.setDouble('hydrationGoal', hydrationGoal);
    await prefs.setStringList('selectedAllergies', selectedAllergies);
    await prefs.setString('medicalDetails', medicalDetailsController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Health Guide Settings'),
          backgroundColor: ColorManager.bluePrimary.withOpacity(0.4)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SwitchListTile(
              title: Text('Enable Health Recommendations'),
              value: enableHealthRecommendations,
              onChanged: (value) {
                setState(() {
                  enableHealthRecommendations = value;
                });
                _saveSettings();
              },
            ),
            DropdownButtonFormField(
              value: dietType,
              items: ['Balanced', 'Vegan', 'Keto', 'Paleo', 'Vegetarian']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  dietType = value as String;
                });
                _saveSettings();
              },
              decoration: InputDecoration(labelText: 'Diet Type'),
            ),
            DropdownButtonFormField(
              value: activityLevel,
              items: ['Low', 'Moderate', 'High']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  activityLevel = value as String;
                });
                _saveSettings();
              },
              decoration: InputDecoration(labelText: 'Activity Level'),
            ),
            DropdownButtonFormField(
              value: healthGoal,
              items: ['Lose Weight', 'Maintain Weight', 'Gain Muscle']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  healthGoal = value as String;
                });
                _saveSettings();
              },
              decoration: InputDecoration(labelText: 'Health Goal'),
            ),
            Slider(
              value: dailyCalories,
              min: 1200,
              max: 3500,
              divisions: 23,
              label: '${dailyCalories.toInt()} kcal',
              onChanged: (value) {
                setState(() {
                  dailyCalories = value;
                });
                _saveSettings();
              },
            ),
            Text('Daily Calorie Goal: ${dailyCalories.toInt()} kcal'),
            Slider(
              value: hydrationGoal,
              min: 1,
              max: 5,
              divisions: 8,
              label: '${hydrationGoal.toStringAsFixed(1)} L',
              onChanged: (value) {
                setState(() {
                  hydrationGoal = value;
                });
                _saveSettings();
              },
            ),
            Text('Daily Hydration Goal: ${hydrationGoal.toStringAsFixed(1)} L'),
            Text('Select Allergies:'),
            Column(
              children: allergyOptions.map((allergy) {
                return CheckboxListTile(
                  title: Text(allergy),
                  value: selectedAllergies.contains(allergy),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedAllergies.add(allergy);
                      } else {
                        selectedAllergies.remove(allergy);
                      }
                    });
                    _saveSettings();
                  },
                );
              }).toList(),
            ),
            TextField(
              controller: medicalDetailsController,
              decoration:
                  InputDecoration(labelText: 'Additional Medical Details'),
              maxLines: 3,
              onChanged: (value) => _saveSettings(),
            ),
          ],
        ),
      ),
    );
  }
}
