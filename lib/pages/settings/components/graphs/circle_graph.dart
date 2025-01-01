import 'package:flutter/material.dart';
import 'package:nutrito/util/theme/color.dart';

class HealthScoreGraph extends StatelessWidget {
  final double percentage; // Value between 0 and 100

  const HealthScoreGraph({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(150, 150), // Set the size of the graph
        painter: CircularGraphPainter(percentage),
        child: Center(
          child: Text(
            '${percentage.toInt()}%\nhealth score',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class CircularGraphPainter extends CustomPainter {
  final double percentage; // Value between 0 and 100

  CircularGraphPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = const Color.fromARGB(255, 136, 136, 136).withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..color = ColorManager.bluePrimary.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background circle (full circle)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14 / 2, // Start angle (12 o'clock)
      2 * 3.14, // Full circle
      false,
      circlePaint,
    );

    // Progress arc (based on percentage)
    double progress = (percentage / 100).clamp(0.0, 1.0); // Ensures 0.0 - 1.0
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14 / 2,
      2 * 3.14 * progress, // Dynamic sweep angle
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint if percentage changes
  }
}
