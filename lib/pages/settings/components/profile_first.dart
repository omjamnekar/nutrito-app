import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrito/pages/settings/components/graphs/circle_graph.dart';
import 'package:nutrito/pages/settings/components/graphs/linear.dart';
import 'package:nutrito/pages/settings/components/graphs/semi_circle.dart';
import 'package:nutrito/util/data/settings.dart';

import 'package:nutrito/util/extensions/extensions.dart';

class SectionFirst extends StatefulWidget {
  const SectionFirst({super.key});

  @override
  State<SectionFirst> createState() => _SectionFirstState();
}

class _SectionFirstState extends State<SectionFirst> {
  bool isGood = true;
  final List<String> _itemsOption = ["A", "B", "C", "D", "E", "F"];
  String _seletedOption = "A";

  final List<Text> _titles = [
    const Text("Avatars").withStyle(),
    const Text("Username").withStyle(),
    const Text("Email").withStyle(),
    const Text("Dietary Intake:").withStyle(),
    const Text("Nutrient Deficiencies").withStyle(fontSize: 16),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 630,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          // Bottom Shadow
          BoxShadow(
            // ignore: deprecated_member_use
            color: const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3), // Downward shadow
          ),
          // Top Shadow
          BoxShadow(
            // ignore: deprecated_member_use
            color: const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, -3), // Upward shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Column(
            children: [
              Flexible(
                flex: 9,
                child: Row(
                  children: [
                    Flexible(
                      flex: 6,
                      child: SizedBox(
                        child: ListView.builder(
                          itemCount: 4,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: profileFirstSection[index],
                              title: _titles[index],
                            );
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Center(
                            child: SizedBox(
                                width: 140,
                                height: 140,
                                child: HealthScoreGraph(percentage: 20)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Gap(5),
              Flexible(
                flex: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 20),
                        width: 180,
                        child: const RoundedProgressBar(percentage: 20)),
                    const Gap(6),
                    ListTile(
                      leading: profileFirstSection[4],
                      title: _titles[4],
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(200, 222, 221, 221),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/image/settings/happy.png",
                              width: 30,
                              color: const Color.fromARGB(159, 0, 221, 181),
                            ),
                            Text(isGood ? "GOOD" : "BAD")
                          ],
                        ),
                      ),
                    ),
                    const Gap(10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Divider(
                        color: Color.fromARGB(255, 220, 220, 220),
                      ),
                    ),
                    ListTile(
                      title: const Text("Weight").withStyle(),
                      trailing: const Text("70kg").withStyle(fontSize: 14),
                    ),
                    ListTile(
                      title: const Text("Weight Loss").withStyle(),
                      trailing: const Text("6kg").withStyle(fontSize: 14),
                    ),
                    ListTile(
                      title: const Text("Nutri score").withStyle(),
                      trailing: const SizedBox(
                        width: 55,
                        height: 200,
                        child: DynamicCircularGraph(
                          value: 75, // Value between 1 to 100
                          middleText: 'B', // Dynamic middle character
                        ),
                      ),
                    ),
                    const Gap(10),
                    ListTile(
                      title: const Text("Groups"),
                      trailing: SizedBox(
                        height: 40,
                        width: 70,
                        child: Container(
                          padding: const EdgeInsets.only(left: 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(59, 185, 185, 185)
                                    // ignore: deprecated_member_use
                                    .withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: DropdownButton(
                            // value: _seletedOption,
                            value: _seletedOption,
                            items: _itemsOption.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _seletedOption = newValue ?? "";
                              });
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
