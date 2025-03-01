import 'package:flutter/material.dart';

class CustomGoalPage {
  final Function(List<String>) onGoalsSubmitted;
  final BuildContext context;
  CustomGoalPage(
      {required this.context,
      required this.customGoal,
      required this.onGoalsSubmitted}) {
    _showCustomGoalDialog();
  }

  final List<String> providedGoals = [
    'Lose Weight',
    'Build Muscle',
    'Improve Cardio',
    'Eat Healthier',
    'Increase Flexibility'
  ];

  final List<String> selectedGoals = [];
  String? customGoal;

  void _showCustomGoalDialog() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: const Text('Add Custom Goal'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter your goal'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    customGoal = controller.text.trim();
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      }),
    );
  }

  void _submitGoals() {
    List<String> finalGoals = List.from(selectedGoals);
    if (customGoal != null && customGoal!.isNotEmpty) {
      finalGoals.add(customGoal!);
    }
    onGoalsSubmitted(finalGoals);
  }
}
