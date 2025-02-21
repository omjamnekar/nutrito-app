import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/view/settings/components/graphs/linear.dart';
import 'package:nutrito/util/extensions/extensions.dart';

class WeeklySection extends StatefulWidget {
  const WeeklySection({super.key});

  @override
  State<WeeklySection> createState() => _WeeklySectionState();
}

class _WeeklySectionState extends State<WeeklySection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 214, 214, 214).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text("Your weekly target").withHeadStyle(),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            subtitle: Text(
                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}  -  ${DateTime.now().day + 5}/${DateTime.now().month}/${DateTime.now().year} "),
          ),
          Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: RichText(
                    text: TextSpan(
                      text: '102',
                      style: DefaultTextStyle.of(context).style.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(213, 33, 149, 243)),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' of 150',
                          style: GoogleFonts.poppins(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Flexible(flex: 2, child: RoundedProgressBar(percentage: 70))
              ],
            ),
          ),
          Gap(20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Text(
                      "Scoring 150 Heart Points a Week Points a Week can help you live longer, sleep, better, and boost you need."),
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Image.asset(
                      'assets/image/icon.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
