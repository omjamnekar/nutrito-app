import 'package:flutter/material.dart';
import 'dart:math';

class WaterAnimation extends StatefulWidget {
  final double percentage; // New percentage parameter
  final double ml;
  WaterAnimation({required this.percentage, required this.ml});

  @override
  _WaterAnimationState createState() => _WaterAnimationState();
}

class _WaterAnimationState extends State<WaterAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ClipOval(
            child: Container(
              width: 130,
              height: 130,
              color: const Color.fromARGB(255, 228, 228, 228),
              child: Stack(
                children: [
                  // First Wave
                  Positioned.fill(
                    child: CustomPaint(
                      painter: WavePainter(
                        animation: _controller.value,
                        waveHeight: 15,
                        color: Colors.lightBlue,
                        phaseShift: 0,
                        percentage: widget.percentage,
                      ),
                    ),
                  ),
                  // Second Wave
                  Positioned.fill(
                    child: CustomPaint(
                      painter: WavePainter(
                        animation: _controller.value,
                        waveHeight: 10,
                        color: Colors.blueAccent.withOpacity(0.6),
                        phaseShift: pi,
                        percentage: widget.percentage,
                      ),
                    ),
                  ),
                  // Center Text
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${widget.ml}mL\n",
                                style: TextStyle(
                                  color: const Color.fromARGB(221, 73, 73, 73),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "${widget.percentage.toInt()}%",
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 253, 253, 253),
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final double animation;
  final double waveHeight;
  final Color color;
  final double phaseShift;
  final double percentage; // Added percentage

  WavePainter({
    required this.animation,
    required this.waveHeight,
    required this.color,
    required this.phaseShift,
    required this.percentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final double speed = 2 * pi * animation;

    // Adjust starting height based on percentage
    double waterLevel = size.height * (1 - (percentage / 100));

    path.moveTo(0, waterLevel);

    for (double i = 0; i <= size.width; i++) {
      double y =
          waveHeight * sin((i / size.width * 2 * pi) + speed + phaseShift) +
              waterLevel;
      path.lineTo(i, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.percentage != percentage;
  }
}
