import 'package:flutter/material.dart';

class RoundedProgressBar extends StatelessWidget {
  final double percentage;
  final Color backgroundColor;
  final Color progressColor;

  const RoundedProgressBar({
    super.key,
    required this.percentage,
    this.backgroundColor = Colors.grey,
    this.progressColor = const Color.fromARGB(159, 0, 221, 181),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 16,
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: backgroundColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: percentage / 100, // Controls progress
              child: Container(
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
