import 'dart:math';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PerformanceIndicator extends StatefulWidget {
  double value;
  PerformanceIndicator({super.key, required this.value});

  @override
  _PerformanceIndicatorState createState() => _PerformanceIndicatorState();
}

class _PerformanceIndicatorState extends State<PerformanceIndicator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 150,
          height: 75,
          child: CustomPaint(
            painter: PerformanceIndicatorPainter(value: widget.value),
          ),
        ),
        // Slider(
        //   value: widget.value,
        //   min: 0,
        //   max: 100,
        //   divisions: 100,
        //   label: widget.value.toStringAsFixed(0),
        //   onChanged: _updateValue,
        // ),
      ],
    );
  }
}

class PerformanceIndicatorPainter extends CustomPainter {
  final double value;

  PerformanceIndicatorPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height;
    final radius = size.width / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;

    // Green Section
    paint.color = Color.fromARGB(255, 19, 191, 114);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      3.14,
      3.14 / 5,
      false,
      paint,
    );

    // Yellow-Green Section
    paint.color = Color.fromARGB(255, 50, 255, 218);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      3.14 + (3.14 / 5),
      3.14 / 5,
      false,
      paint,
    );

    // Yellow Section
    paint.color = Color.fromARGB(255, 158, 255, 237);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      3.14 + (2 * 3.14 / 5),
      3.14 / 5,
      false,
      paint,
    );

    // Orange Section
    paint.color = Color.fromARGB(255, 175, 255, 240);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      3.14 + (3 * 3.14 / 5),
      3.14 / 5,
      false,
      paint,
    );

    // Red Section
    paint.color = Color.fromARGB(255, 208, 255, 246);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      3.14 + (4 * 3.14 / 5),
      3.14 / 5,
      false,
      paint,
    );

    // Calculate needle angle
    double angle = 3.14 + (value / 100) * 3.14;

    // Indicator Needle
    final needlePaint = Paint()
      ..color = const Color.fromARGB(221, 69, 69, 69)
      ..style = PaintingStyle.fill;

    // Draw needle base circle
    canvas.drawCircle(Offset(centerX, centerY), 8, needlePaint);

    // Draw needle
    final needlePath = Path();
    needlePath.moveTo(centerX, centerY);
    needlePath.lineTo(
      centerX + radius * 0.7 * cos(angle),
      centerY + radius * 0.7 * sin(angle),
    );
    needlePath.lineTo(
      centerX + radius * 0.05 * cos(angle + 1.57),
      centerY + radius * 0.05 * sin(angle + 1.57),
    );
    needlePath.close();
    canvas.drawPath(needlePath, needlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
