import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/view/home/graph/hero_Indicator.dart';
import 'package:nutrito/util/theme/color.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> part = {
      "Cal": 345,
      "Move min": 154,
      "km": 4.6,
      "Sleep": "7h 32m"
    };

    return Container(
      height: 260,
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromARGB(221, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 211, 211, 211).withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                itemCount: part.length,
                itemBuilder: (context, index) {
                  String key = part.keys.elementAt(index);
                  dynamic value = part[key];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 228, 255, 246),
                    ),
                    child: TagOss(text: key, data: value),
                  );
                },
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child: HeroIndicator()),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.suit_heart,
                        color: ColorManager.bluePrimary,
                      ),
                      Gap(5),
                      Text("Heart Pts"),
                      Gap(10),
                      Icon(
                        Icons.directions_run_outlined,
                        color: Colors.blue,
                      ),
                      Gap(5),
                      Text("Heart Pts"),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TagOss extends StatelessWidget {
  final String text;
  final dynamic data;
  const TagOss({super.key, required this.text, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          data.toString(),
          style: GoogleFonts.poppins(
              color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        Text(
          text,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(221, 71, 71, 71)),
        )
      ],
    );
  }
}
