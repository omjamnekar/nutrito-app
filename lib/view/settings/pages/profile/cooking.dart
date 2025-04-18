import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CookingAISettingsPage extends StatefulWidget {
  const CookingAISettingsPage({super.key});

  @override
  _CookingAISettingsPageState createState() => _CookingAISettingsPageState();
}

class _CookingAISettingsPageState extends State<CookingAISettingsPage> {
  String cookingStyle = "";
  String preferredCuisine = "";
  String skillLevel = "Beginner";
  final TextEditingController _styleController = TextEditingController();
  final TextEditingController _cuisineController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cookingStyle = prefs.getString('cookingStyle') ?? "Healthy";
      preferredCuisine = prefs.getString('preferredCuisine') ?? "Indian";
      skillLevel = prefs.getString('skillLevel') ?? "Beginner";
    });
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cookingStyle', cookingStyle);
    await prefs.setString('preferredCuisine', preferredCuisine);
    await prefs.setString('skillLevel', skillLevel);
  }

  void _showQuizDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Customize Your Cooking Assistant"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _styleController,
                decoration:
                    InputDecoration(labelText: "Preferred Cooking Style"),
              ),
              TextField(
                controller: _cuisineController,
                decoration: InputDecoration(labelText: "Favorite Cuisine"),
              ),
              DropdownButtonFormField(
                value: skillLevel,
                items: ["Beginner", "Intermediate", "Expert"].map((level) {
                  return DropdownMenuItem(value: level, child: Text(level));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    skillLevel = value.toString();
                  });
                },
                decoration: InputDecoration(labelText: "Cooking Skill Level"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  cookingStyle = _styleController.text;
                  preferredCuisine = _cuisineController.text;
                });
                _savePreferences();
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cooking AI Settings"),
        backgroundColor: ColorManager.bluePrimary.withOpacity(0.4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.fastfood),
                Gap(10),
                Text(" Your Cooking Preferences",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text("Cooking Style"),
              subtitle: Text(cookingStyle),
            ),
            ListTile(
              title: Text("Preferred Cuisine"),
              subtitle: Text(preferredCuisine),
            ),
            ListTile(
              title: Text("Skill Level"),
              subtitle: Text(skillLevel),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: TextButton(
          onPressed: _showQuizDialog,
          child: Text(
            "Edit Preferences",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
