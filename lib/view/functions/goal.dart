import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/theme/color.dart';

class Goal {
  final String title;
  final String type; // e.g. "Daily", "Intermediate", "Advanced"
  final String unit;
  int current; // <-- removed final
  final int target;
  bool isCompleted; // <-- removed final

  Goal({
    required this.title,
    required this.type,
    required this.unit,
    required this.current,
    required this.target,
    this.isCompleted = false,
  });

  double get progress => current / target;
}

class GoalTrackingPage extends StatefulWidget {
  const GoalTrackingPage({super.key});

  @override
  State<GoalTrackingPage> createState() => _GoalTrackingPageState();
}

class _GoalTrackingPageState extends State<GoalTrackingPage> {
  String selectedCategory = "Daily";

  List<Goal> goals = [
    Goal(
        title: "Step Count",
        type: "Daily",
        unit: "Steps",
        current: 6745,
        target: 12000),
    Goal(
        title: "Calorie Burn Target",
        type: "Daily",
        unit: "kcal",
        current: 172,
        target: 300),
    Goal(
        title: "Calorie Burn Target",
        type: "Intermediate",
        unit: "kcal",
        current: 172,
        target: 300),
    Goal(
        title: "Calorie Burn Target",
        type: "Advanced",
        unit: "kcal",
        current: 200,
        target: 200,
        isCompleted: true),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredGoals = goals
        .where((g) => g.type == selectedCategory && !g.isCompleted)
        .toList();
    final completedGoals = goals.where((g) => g.isCompleted).toList();

    final double progress = goals.isEmpty
        ? 0
        : goals.map((g) => g.progress.clamp(0.0, 1.0)).reduce((a, b) => a + b) /
            goals.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Goals",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: ColorManager.bluePrimary)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          _buildHeader(progress),
          const SizedBox(height: 20),
          _buildCategoryTabs(),
          const SizedBox(height: 10),
          ...filteredGoals.map(_buildGoalCard).toList(),
          const SizedBox(height: 16),
          _buildNewGoalButton(),
          if (completedGoals.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text("Completed Goals",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            ...completedGoals.map(_buildCompletedCard).toList(),
          ]
        ],
      ),
    );
  }

  Widget _buildHeader(double progress) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.bluePrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${(progress * 100).toInt()}%",
              style: GoogleFonts.poppins(
                  fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text("Goal Progress", style: GoogleFonts.poppins(fontSize: 14)),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white,
            color: ColorManager.bluePrimary,
            minHeight: 6,
          ),
        ],
      ),
    );
  }

  void _showAddGoalDialog() {
    final titleController = TextEditingController();
    final typeController = TextEditingController(text: selectedCategory);

    final unitController = TextEditingController();
    final targetController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Set New Goal", style: GoogleFonts.poppins()),
          backgroundColor: const Color.fromRGBO(233, 255, 251, 1),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                TextField(
                  controller: typeController,
                  decoration: const InputDecoration(
                      labelText: "Type (Daily, Intermediate, Advanced)"),
                ),
                TextField(
                  controller: unitController,
                  decoration: const InputDecoration(
                      labelText: "Unit (e.g. Steps, kcal)"),
                ),
                TextField(
                  controller: targetController,
                  decoration: const InputDecoration(labelText: "Target"),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: GoogleFonts.poppins()),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final type = typeController.text;
                final unit = unitController.text;
                final target = int.tryParse(targetController.text) ?? 0;

                if (title.isNotEmpty &&
                    type.isNotEmpty &&
                    unit.isNotEmpty &&
                    target > 0) {
                  setState(() {
                    goals.add(
                      Goal(
                        title: title,
                        type: type,
                        unit: unit,
                        current: 0,
                        target: target,
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Add Goal", style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCategoryTabs() {
    const categories = ["Daily", "Intermediate", "Advanced"];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: categories.map((type) {
        final isSelected = selectedCategory == type;
        return GestureDetector(
          onTap: () => setState(() => selectedCategory = type),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              type,
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 13,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGoalCard(Goal goal) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ListTile(
        title: Text(goal.title,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: goal.progress.clamp(0.0, 1.0),
              backgroundColor: Colors.grey.shade300,
              color: ColorManager.bluePrimary,
              minHeight: 5,
            ),
            const SizedBox(height: 6),
            Text(
              "${goal.current} / ${goal.target} ${goal.unit}",
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            setState(() {
              goal.current = goal.target;
              goal.isCompleted = true;
            });
          },
        ),
      ),
    );
  }

  Widget _buildCompletedCard(Goal goal) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              goal.title,
              style: GoogleFonts.poppins(
                decoration: TextDecoration.lineThrough,
                color: Colors.green,
              ),
            ),
          ),
          Text(
            "${goal.target} ${goal.unit}",
            style: GoogleFonts.poppins(color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildNewGoalButton() {
    return ElevatedButton(
      onPressed: _showAddGoalDialog,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.bluePrimary,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        "+ Set New Goal",
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
