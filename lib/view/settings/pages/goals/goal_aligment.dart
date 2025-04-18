import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/theme/color.dart';

class GoalAlignmentReportPage extends StatelessWidget {
  const GoalAlignmentReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock user data (replace with real data later)
    final Map<String, dynamic> userHealthData = {
      'Calories': 2200,
      'Protein': 90,
      'Steps': 8000,
      'Water Intake': 2.5,
    };

    final Map<String, dynamic> userGoals = {
      'Calories': 2000,
      'Protein': 100,
      'Steps': 10000,
      'Water Intake': 3.0,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Goal Alignment Report'),
        backgroundColor: ColorManager.bluePrimary.withOpacity(0.1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Goal Alignment Report',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: userGoals.length,
                itemBuilder: (context, index) {
                  String goal = userGoals.keys.elementAt(index);
                  var goalValue = userGoals[goal];
                  var currentValue = userHealthData[goal] ?? 'No Data';
                  bool isAligned = goalValue == currentValue;

                  return Card(
                    color: isAligned ? Colors.green[50] : Colors.red[50],
                    child: ListTile(
                      title: Text(goal,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle:
                          Text('Goal: $goalValue\nCurrent: $currentValue'),
                      trailing: Icon(
                        isAligned ? Icons.check_circle : Icons.warning,
                        color: isAligned ? Colors.green : Colors.black87,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.bluePrimary,
                ),
                child: Text(
                  'Back to Dashboard',
                  style: GoogleFonts.poppins(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
