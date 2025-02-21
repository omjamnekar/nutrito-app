import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SleepDurationSection extends StatefulWidget {
  const SleepDurationSection({super.key});

  @override
  State<SleepDurationSection> createState() => _SleepDurationSectionState();
}

class _SleepDurationSectionState extends State<SleepDurationSection> {
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
            title: Text("Sleep duration"),
            subtitle: Text(
              "Last 7 days",
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
          SleepDurationWidget(sleepData: [0.8, 4, 5, 2, 4, 1, 9]),
        ],
      ),
    );
  }
}

class SleepDurationWidget extends StatelessWidget {
  final List<double> sleepData;

  const SleepDurationWidget({super.key, required this.sleepData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "7",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(123, 138, 70, 255),
                          ),
                        ),
                        TextSpan(
                          text: "h",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "30",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(123, 138, 70, 255),
                          ),
                        ),
                        TextSpan(
                          text: "m",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Average",
                    style: GoogleFonts.poppins(
                      color: Color.fromARGB(123, 138, 70, 255),
                    ),
                  )
                ],
              )),
          Flexible(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: sleepData.asMap().entries.map((entry) {
                int index = entry.key;
                double value = entry.value;
                return Column(
                  children: [
                    Container(
                      width: 10.0,
                      height:
                          value * 20, // Dynamic height based on sleep duration
                      color: const Color.fromARGB(123, 138, 70, 255),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      _dayLabel(index),
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _dayLabel(int index) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return days[index];
  }
}
