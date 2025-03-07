import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrito/data/model/sections/settings.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:nutrito/util/extensions/extensions.dart';
import 'package:nutrito/view/functions/gen/gen_chat.dart';
import 'package:nutrito/view/settings/pages/goals/custom_goal.dart';
import 'package:nutrito/view/settings/pages/goals/goal_aligment.dart';
import 'package:nutrito/view/settings/pages/goals/instantAlert.dart';
import 'package:nutrito/view/settings/pages/goals/ml_model.dart';
import 'package:nutrito/view/settings/pages/goals/personalize_con.dart';

class GoalSection extends StatefulWidget {
  const GoalSection({super.key});

  @override
  State<GoalSection> createState() => _GoalSectionState();
}

class _GoalSectionState extends State<GoalSection> {
  Goals goals = Goals(section1: null, section2: null);
  UserGoalManagement? userGoalManagement;
  FoodProductAnalysis? foodProductAnalysis;
  FoodProductConclusion? foodprooductConclusion;

  Section1 section1 = Section1(
      userGoalManagement: null,
      foodProductAnalysis: null,
      foodProductConclusion: null);
  @override
  Widget build(BuildContext context) {
    List<String> goalCategories = [
      "Weight Loss",
      "Muscle Gain",
      "Balanced Diet",
      "Low Sugar",
      "Heart Health"
    ];

    String selectedgoal = "Heart Health";
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 550,
            margin: const EdgeInsets.only(
              top: 20,
              left: 8,
              right: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).canvasColor,
              boxShadow: [
                // Bottom Shadow
                BoxShadow(
                  color:
                      const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // Downward shadow
                ),
                // Top Shadow
                BoxShadow(
                  color:
                      const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, -3), // Upward shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18,
                    right: 18,
                    top: 10,
                  ),
                  child: const Text(
                    "User Goal Management",
                  ).withHeadStyle(fontSize: 16),
                ),
                ListTile(
                    title: const Text("Goal Categories").withStyle(),
                    trailing: DropdownButton<String>(
                      value: selectedgoal,
                      items: goalCategories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category).withStyle(),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Handle change here
                        setState(() {
                          selectedgoal = newValue ?? "";
                        });
                      },
                    )),
                ListTile(
                  title: const Text("Custom Goals").withStyle(),
                  trailing: const Icon(
                    Icons.amp_stories_outlined,
                    color: ColorManager.bluePrimary,
                    size: 30,
                  ),
                  onTap: () {
                    CustomGoalPage(
                      context: context,
                      customGoal: "",
                      onGoalsSubmitted: (p0) {
                        snackBarMassenger("Your data is stored");
                      },
                    );
                  },
                ),
                ListTile(
                  title: const Text("AI Recommendations").withStyle(),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GenChatPage(),
                        ));
                  },
                  trailing: const Icon(
                    Icons.workspaces_outline,
                    color: ColorManager.bluePrimary,
                    size: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18,
                    right: 18,
                    top: 10,
                  ),
                  child: const Text(
                    "Food Product Analysis",
                  ).withHeadStyle(fontSize: 16),
                ),
                ListTile(
                  title: const Text("ML model").withStyle(),
                  trailing: const Icon(
                    Icons.wysiwyg_outlined,
                    color: ColorManager.bluePrimary,
                    size: 30,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            MLModelShowcase(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18,
                    right: 18,
                    top: 10,
                  ),
                  child: const Text(
                    "Food Product Conslusion",
                  ).withHeadStyle(fontSize: 16),
                ),
                ListTile(
                  title: const Text("Personalized Conclusions").withStyle(),
                  trailing: const Icon(
                    Icons.info_outline,
                    color: ColorManager.bluePrimary,
                    size: 30,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            PersonalizeConPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text("Goal Alignment Report").withStyle(),
                  trailing: const Icon(
                    Icons.auto_graph_sharp,
                    color: ColorManager.bluePrimary,
                    size: 30,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            GoalAlignmentReportPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text("Instant Alerts").withStyle(),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            InstantAlertSettingsPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  trailing: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Instant Alerts"),
                            content: const Text("This is an alert message."),
                            actions: [
                              TextButton(
                                child: const Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.notifications_active_outlined,
                      color: ColorManager.bluePrimary,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 550,
            margin: const EdgeInsets.only(
              top: 20,
              left: 8,
              right: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).canvasColor,
              boxShadow: [
                // Bottom Shadow
                BoxShadow(
                  color:
                      const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // Downward shadow
                ),
                // Top Shadow
                BoxShadow(
                  color:
                      const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, -3), // Upward shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18,
                    right: 18,
                    top: 10,
                  ),
                  child: const Text(
                    "Health Data Recording & Visualization",
                  ).withHeadStyle(fontSize: 16),
                ),
                ListTile(
                  title: const Text("Health Metrics Tracking").withStyle(),
                  trailing: const Icon(
                    Icons.list_sharp,
                    color: ColorManager.bluePrimary,
                    size: 30,
                  ),
                ),
                ListTile(
                  title: const Text("Habit Insights").withStyle(),
                  trailing: const Icon(
                    Icons.stacked_line_chart_rounded,
                    color: ColorManager.bluePrimary,
                    size: 30,
                  ),
                ),
                ListTile(
                  title: const Text("Periodic Reports").withStyle(),
                  trailing: const Icon(
                    Icons.short_text_sharp,
                    color: ColorManager.bluePrimary,
                    size: 30,
                  ),
                ),
                ListTile(
                  title: const Text("Integration with Wearables").withStyle(),
                  trailing: const Icon(
                    Icons.watch_outlined,
                    color: ColorManager.bluePrimary,
                    size: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18,
                    right: 18,
                    top: 10,
                  ),
                  child: const Text(
                    "other",
                  ).withHeadStyle(fontSize: 16),
                ),
                ListTile(
                  title: const Text("Recipe Suggestions").withStyle(),
                  trailing: const Icon(
                    Icons.wb_twilight,
                    color: ColorManager.bluePrimary,
                    size: 30,
                  ),
                ),
                ListTile(
                  title: const Text("Meal Planning").withStyle(),
                  trailing: const Icon(
                    Icons.workspaces_outlined,
                    color: ColorManager.bluePrimary,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void snackBarMassenger(String data) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
  }
}
