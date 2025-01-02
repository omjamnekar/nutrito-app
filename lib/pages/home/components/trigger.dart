import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/pages/functions/compare.dart';
import 'package:nutrito/pages/functions/nutrilization.dart';
import 'package:nutrito/pages/functions/smartList.dart';

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
      "onTap": null,
    },
    {
      "icon": Icons.shopping_cart,
      "name": "Smart Shopping",
      "onTap": null,
    },
    {
      "icon": CupertinoIcons.heart_solid,
      "name": "Heart Health",
      "onTap": null,
    },
    {
      "icon": Icons.compare_sharp,
      "name": "Compare Product",
      "onTap": ComaparePage(),
    },
    {
      "icon": Icons.grain_outlined,
      "name": "Suggestion Product",
      "onTap": SmartListPage(),
    },
    {
      "icon": Icons.auto_graph_outlined,
      "name": "Goals",
      "onTap": null,
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
          return Container(
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
          );
        },
      ),
    );
  }
}
