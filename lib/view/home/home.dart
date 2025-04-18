import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrito/view/home/components/hero_Section.dart';
import 'package:nutrito/view/home/components/second_section.dart';
import 'package:nutrito/view/home/components/trigger.dart';
import 'package:nutrito/view/home/graph/ai_suggestion.dart';
import 'package:nutrito/view/home/graph/goals.dart';
import 'package:nutrito/view/home/graph/sleep.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("home page");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 3, right: 3),
          child: Column(
            children: [
              HeroSection(),
              Gap(20),
              TriggerSection(),
              Gap(20),
              WeeklySection(),
              Gap(20),
              SleepDurationSection(),
              Gap(20),
              AiSuggestion(),
              Gap(20),
              // MainGraphSection(),
              GoalHomeSections(),
              // BarGraphSection(),
              // DashboardWidget(
              //   steps: 7500,
              //   goalSteps: 10000,
              //   water: 2.5,
              //   calories: '1800 kcal',
              //   pulse: 72,
              //   weight: 68.5,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
