import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FamilyHealthPage extends StatefulWidget {
  @override
  _FamilyHealthPageState createState() => _FamilyHealthPageState();
}

class _FamilyHealthPageState extends State<FamilyHealthPage> {
  List<Map<String, String>> familyMembers = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController healthConditionController =
      TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController medicationsController = TextEditingController();
  String selectedBloodType = 'A+';
  bool hasChronicDisease = false;
  final TextEditingController emergencyContactController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFamilyData();
  }

  Future<void> _loadFamilyData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      familyMembers = (prefs.getStringList('familyMembers') ?? []).map((e) {
        List<String> details = e.split('|');
        return {
          'name': details[0],
          'age': details[1],
          'healthCondition': details[2],
          'weight': details[3],
          'height': details[4],
          'allergies': details[5],
          'medications': details[6],
          'bloodType': details[7],
          'chronicDisease': details[8],
          'emergencyContact': details[9],
        };
      }).toList();
    });
  }

  Future<void> _saveFamilyData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> data = familyMembers
        .map((e) =>
            "${e['name']}|${e['age']}|${e['healthCondition']}|${e['weight']}|${e['height']}|${e['allergies']}|${e['medications']}|${e['bloodType']}|${e['chronicDisease']}|${e['emergencyContact']}")
        .toList();
    await prefs.setStringList('familyMembers', data);
  }

  void _addFamilyMember() {
    if (nameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        healthConditionController.text.isNotEmpty &&
        weightController.text.isNotEmpty &&
        heightController.text.isNotEmpty &&
        allergiesController.text.isNotEmpty &&
        medicationsController.text.isNotEmpty &&
        emergencyContactController.text.isNotEmpty) {
      setState(() {
        familyMembers.add({
          'name': nameController.text,
          'age': ageController.text,
          'healthCondition': healthConditionController.text,
          'weight': weightController.text,
          'height': heightController.text,
          'allergies': allergiesController.text,
          'medications': medicationsController.text,
          'bloodType': selectedBloodType,
          'chronicDisease': hasChronicDisease ? 'Yes' : 'No',
          'emergencyContact': emergencyContactController.text,
        });
        _saveFamilyData();
      });
      nameController.clear();
      ageController.clear();
      healthConditionController.clear();
      weightController.clear();
      heightController.clear();
      allergiesController.clear();
      medicationsController.clear();
      emergencyContactController.clear();
      setState(() {
        selectedBloodType = 'A+';
        hasChronicDisease = false;
      });
    }
  }

  void _removeFamilyMember(int index) {
    setState(() {
      familyMembers.removeAt(index);
      _saveFamilyData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Health Information'),
        backgroundColor: ColorManager.bluePrimary.withOpacity(0.4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name')),
              TextField(
                  controller: ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number),
              TextField(
                  controller: healthConditionController,
                  decoration: InputDecoration(labelText: 'Health Condition')),
              TextField(
                  controller: weightController,
                  decoration: InputDecoration(labelText: 'Weight (kg)')),
              TextField(
                  controller: heightController,
                  decoration: InputDecoration(labelText: 'Height (cm)')),
              TextField(
                  controller: allergiesController,
                  decoration: InputDecoration(labelText: 'Allergies')),
              TextField(
                  controller: medicationsController,
                  decoration: InputDecoration(labelText: 'Medications')),
              DropdownButtonFormField(
                value: selectedBloodType,
                items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBloodType = value.toString();
                  });
                },
                decoration: InputDecoration(labelText: 'Blood Type'),
              ),
              CheckboxListTile(
                title: Text("Chronic Disease"),
                value: hasChronicDisease,
                onChanged: (value) {
                  setState(() {
                    hasChronicDisease = value!;
                  });
                },
              ),
              TextField(
                  controller: emergencyContactController,
                  decoration: InputDecoration(labelText: 'Emergency Contact')),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: _addFamilyMember,
                  child: Text(
                    'Add Family Member',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              familyMembers.isEmpty
                  ? Center(child: Text('No family members added'))
                  : Container(
                      height: 500,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: familyMembers.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(familyMembers[index]['name']!),
                              subtitle: Text(
                                  "Age: ${familyMembers[index]['age']}\nHealth: ${familyMembers[index]['healthCondition']}\nWeight: ${familyMembers[index]['weight']} kg\nHeight: ${familyMembers[index]['height']} cm\nAllergies: ${familyMembers[index]['allergies']}\nMedications: ${familyMembers[index]['medications']}\nBlood Type: ${familyMembers[index]['bloodType']}\nChronic Disease: ${familyMembers[index]['chronicDisease']}\nEmergency Contact: ${familyMembers[index]['emergencyContact']}"),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _removeFamilyMember(index),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
