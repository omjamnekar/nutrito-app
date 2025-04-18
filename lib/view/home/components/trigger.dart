import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/view/functions/alternative.dart';
import 'package:nutrito/view/functions/compare.dart';
import 'package:nutrito/view/functions/goal.dart';
import 'package:nutrito/view/functions/nutrilization.dart';
import 'package:nutrito/view/functions/smartList.dart';
import 'package:nutrito/view/searchs/search.dart';
import 'package:nutrito/view/settings/user.dart';

class TriggerSection extends StatefulWidget {
  const TriggerSection({super.key});

  @override
  State<TriggerSection> createState() => _TriggerSectionState();
}

class _TriggerSectionState extends State<TriggerSection> {
  final List<Map<String, dynamic>> _functionality = [
    {
      "icon": Icons.camera,
      "name": "Nutrtilization",
      "onTap": NutrilizationPage(),
    },
    {
      "icon": Icons.set_meal_rounded,
      "name": "Food",
      "onTap": SearchPage(),
    },
    {
      "icon": Icons.shopping_cart,
      "name": "Smart Shopping",
      "onTap": SmartListPage(),
    },
    {
      "icon": CupertinoIcons.heart_solid,
      "name": "Heart Health",
      "onTap": SettingsPage(),
    },
    {
      "icon": Icons.compare_sharp,
      "name": "Compare Product",
      "onTap": ComaparePage(),
    },
    {
      "icon": Icons.grain_outlined,
      "name": "Suggestion Product",
      "onTap": AlternativePage(),
    },
    {
      "icon": Icons.auto_graph_outlined,
      "name": "Goals",
      "onTap": GoalTrackingPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: ListView.builder(
        itemCount: _functionality.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _functionality[index]["onTap"],
                  ));
            },
            child: Container(
              width: 160,
              height: 100,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(177, 0, 221, 181),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    _functionality[index]["icon"],
                    color: Colors.white,
                    size: 45,
                  ),
                  Gap(10),
                  Text(
                    _functionality[index]["name"],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
