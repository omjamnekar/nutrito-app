import 'package:flutter/material.dart';

class DynamicCircularGraph extends StatelessWidget {
  final int value; // Value between 1 to 100
  final String middleText; // Middle character

  const DynamicCircularGraph({
    super.key,
    required this.value,
    required this.middleText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(150, 150), // Adjust the size of the circle
      painter: CircularGraphPainter(value: value, middleText: middleText),
    );
  }
}

class CircularGraphPainter extends CustomPainter {
  final int value; // Value between 1 to 100
  final String middleText;

  CircularGraphPainter({
    required this.value,
    required this.middleText,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    // Calculate sweep angle based on value
    double sweepAngle = (value / 100) * 2 * 3.14;

    // Draw the dynamic arc
    paint.color = const Color.fromARGB(135, 255, 153, 0);
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -3.14 / 2, // Start angle (top center)
      sweepAngle, // Dynamic sweep angle
      false,
      paint,
    );

    // Draw the remaining arc
    paint.color = Colors.grey.shade300;
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -3.14 / 2 + sweepAngle, // Start after the orange arc
      2 * 3.14 - sweepAngle, // Remaining angle
      false,
      paint,
    );

    // Add the dynamic center text
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: middleText,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(135, 255, 153, 0),
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(size.width / 2 - textPainter.width / 2,
          size.height / 2 - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(CircularGraphPainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.middleText != middleText;
  }
}
