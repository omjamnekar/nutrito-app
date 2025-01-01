import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DotIndicator extends StatelessWidget {
  final String text;
  final int indicate;
  const DotIndicator({super.key, required this.text, required this.indicate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 4; i++) ...[
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color:
                  i < indicate ? const Color.fromARGB(255, 8, 192, 183) : null,
              border:
                  Border.all(color: const Color.fromARGB(255, 148, 148, 148)),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Gap(10),
        ],
        Text(text),
      ],
    );
  }
}
