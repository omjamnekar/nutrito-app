import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/pages/home/graph/small_indicator.dart';
import 'package:nutrito/pages/home/graph/vit_min.dart';
import 'package:nutrito/pages/settings/components/graphs/circle_graph.dart';
import 'package:nutrito/pages/settings/components/graphs/linear.dart';
import 'package:nutrito/util/theme/color.dart';

class HeroIndicator extends StatelessWidget {
  const HeroIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(50, 50),
        painter: CircularGraphPainter(),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "14",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "6,321",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircularGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Outer background circle
    final outerBackgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawCircle(center, radius - 10, outerBackgroundPaint);

    // Outer foreground arc
    final outerProgressPaint = Paint()
      ..color = ColorManager.bluePrimary
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    const outerProgressPercent = 0.7; // 70% progress for outer arc
    final outerSweepAngle = 2 * 3.141592653589793 * outerProgressPercent;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 10),
      -3.141592653589793 / 2, // Start angle (top center)
      outerSweepAngle, // Sweep angle (progress)
      false,
      outerProgressPaint,
    );

    // Inner background circle (with gap)
    final innerBackgroundPaint = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawCircle(center, radius - 25, innerBackgroundPaint);

    // Inner foreground arc (with gap)
    final innerProgressPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    const innerProgressPercent = 0.5; // 50% progress for inner arc
    final innerSweepAngle = 2 * 3.141592653589793 * innerProgressPercent;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 25),
      -3.141592653589793 / 2, // Start angle (top center)
      innerSweepAngle, // Sweep angle (progress)
      false,
      innerProgressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint for static content
  }
}

class MainGraphSection extends StatelessWidget {
  const MainGraphSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 227, 225, 225).withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
              color: const Color.fromARGB(255, 243, 255, 253),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20),
                HealthIndicator(indicatorPosition: 2),
                Gap(20),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Carbs",
                              style: GoogleFonts.poppins(),
                            ),
                            RoundedProgressBar(percentage: 30),
                            Text(
                              "Protein",
                              style: GoogleFonts.poppins(),
                            ),
                            RoundedProgressBar(percentage: 50),
                            Text(
                              "Fats",
                              style: GoogleFonts.poppins(),
                            ),
                            RoundedProgressBar(percentage: 20),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                  width: 110,
                                  height: 110,
                                  child: HealthScoreGraph(percentage: 20)),
                              Gap(30),
                              HydrationIndicator(
                                waterLevel: 0.5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Transform.translate(
                  offset: Offset(0, -5),
                  child: Container(
                    height: 170,
                    width: 195,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "State",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: const Color.fromARGB(221, 61, 61, 61),
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 5,
                            top: 5,
                            bottom: 5,
                          ),
                          child: WaterAnimation(
                            percentage: 55,
                            ml: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(10),
                ClipRRect(
                  child: Transform.translate(
                    offset: Offset(0, -100),
                    child: Container(
                      width: 200,
                      height: 200,
                      padding: EdgeInsets.only(
                        top: 10,
                        right: 10,
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 181, 181, 181)
                                .withOpacity(0.3),
                            blurRadius: 5,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Spacer(),
                          DotIndicator(
                            text: "Vitamins",
                            indicate: 2,
                          ),
                          Gap(10),
                          DotIndicator(
                            text: "Minerals",
                            indicate: 4,
                          ),
                          Gap(10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, bottom: 8.0),
                              child: Text(
                                "More",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.poppins(
                                    color:
                                        const Color.fromARGB(221, 76, 76, 76)),
                              ),
                            ),
                          ),
                          Gap(5),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HealthIndicator extends StatelessWidget {
  final int indicatorPosition; // Position from 0 (start) to 10 (end)

  const HealthIndicator({super.key, required this.indicatorPosition});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Top Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Calories Consumed',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
            Text(
              'Calories Burned',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Indicator Bar
        Stack(
          alignment: Alignment.center,
          children: [
            // Color Blocks
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                12,
                (index) => Expanded(
                  child: Container(
                    height: 30,
                    color: _getColorForIndex(index),
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                  ),
                ),
              ),
            ),
            // Pointer Indicator
            Positioned(
              top: 0,
              left:
                  (indicatorPosition / 11) * 300, // Dynamically adjust position
              child: const Icon(
                Icons.keyboard_double_arrow_up_rounded,
                color: Colors.black,
                size: 30,
                weight: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getColorForIndex(int index) {
    if (index < 3) return Colors.red;
    if (index < 5) return Colors.orange;
    if (index < 7) return Colors.yellow;
    if (index < 9) return Colors.lightGreen;
    return Colors.green;
  }
}

class HydrationIndicator extends StatefulWidget {
  final double waterLevel; // 0.0 to 1.0

  const HydrationIndicator({super.key, required this.waterLevel});

  @override
  State<HydrationIndicator> createState() => _HydrationIndicatorState();
}

class _HydrationIndicatorState extends State<HydrationIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Water',
          style: TextStyle(),
        ),
        Gap(10),
        SizedBox(
          height: 160,
          width: 25,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return CustomPaint(
                painter: WaterPainter(
                  waterLevel: widget.waterLevel,
                  animationValue: _animationController.value,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class WaterPainter extends CustomPainter {
  final double waterLevel;
  final double animationValue;

  WaterPainter({required this.waterLevel, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorManager.bluePrimary
      ..style = PaintingStyle.fill;

    final wavePath = Path();
    final double waveHeight = 5.0;
    final double baseHeight = size.height * (1 - waterLevel);

    // Create wave pattern
    for (double i = 0; i <= size.width; i++) {
      double waveY =
          sin((i / size.width * 2 * pi) + (animationValue * 2 * pi)) *
              waveHeight;
      if (i == 0) {
        wavePath.moveTo(i, baseHeight + waveY);
      } else {
        wavePath.lineTo(i, baseHeight + waveY);
      }
    }

    wavePath.lineTo(size.width, size.height);
    wavePath.lineTo(0, size.height);
    wavePath.close();

    final backgroundPaint = Paint()
      ..color = const Color.fromARGB(66, 169, 169, 169)
      ..style = PaintingStyle.fill;

    final borderRadius = BorderRadius.circular(50);
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Draw container background
    canvas.drawRRect(borderRadius.toRRect(rect), backgroundPaint);

    // Clip and draw water
    canvas.save();
    canvas.clipRRect(borderRadius.toRRect(rect));
    canvas.drawPath(wavePath, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant WaterPainter oldDelegate) {
    return oldDelegate.waterLevel != waterLevel ||
        oldDelegate.animationValue != animationValue;
  }
}
