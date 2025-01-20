import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/theme/color.dart';

class GenLoading extends StatefulWidget {
  const GenLoading({super.key});

  @override
  State<GenLoading> createState() => _GenLoadingState();
}

class _GenLoadingState extends State<GenLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Gap(20),
              Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    scale: 0.2,
                    image: AssetImage(
                      "assets/image/gen/loading.gif",
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gap(20),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.only(right: 100),
            child: Text(
              "Gen model is working...",
              style: GoogleFonts.poppins(
                fontSize: 28,
                color: ColorManager.bluePrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(right: 100),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "model is processing image, providing you wide variety of imformation",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: const Color.fromARGB(221, 59, 59, 59),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Gap(40),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: LinearProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
