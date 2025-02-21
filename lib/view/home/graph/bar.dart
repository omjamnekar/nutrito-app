import 'package:flutter/material.dart';
import 'dart:math';

import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class StepGraph extends StatelessWidget {
  final List<double> stepData;
  final double barWidth;
  final double spacing;
  final Color barColor1;
  final Color barColor2;
  final double graphHeight;

  const StepGraph({
    super.key,
    required this.stepData,
    this.barWidth = 30,
    this.spacing = 15,
    this.barColor1 = const Color(0xFF338A7A),
    this.barColor2 = const Color(0xFFD7E9E4),
    this.graphHeight = 150, // Set a fixed graph height
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Use SizedBox to control the graph's size
      height: graphHeight + 30, // Add some extra height for labels
      child: CustomPaint(
        size: Size(double.infinity, graphHeight),
        painter: _StepGraphPainter(
          stepData: stepData,
          barWidth: barWidth,
          spacing: spacing,
          barColor1: barColor1,
          barColor2: barColor2,
        ),
      ),
    );
  }
}

class _StepGraphPainter extends CustomPainter {
  final List<double> stepData;
  final double barWidth;
  final double spacing;
  final Color barColor1;
  final Color barColor2;

  _StepGraphPainter({
    required this.stepData,
    required this.barWidth,
    required this.spacing,
    required this.barColor1,
    required this.barColor2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double maxBarHeight = size.height - 20;
    final double startX =
        (size.width - (stepData.length * (barWidth + spacing))) / 2;
    double currentX = startX;

    for (int i = 0; i < stepData.length; i++) {
      final double barHeight = maxBarHeight * stepData[i];
      final double topY = size.height - barHeight - 10;

      final paint = Paint()
        ..color = (i % 2 == 0) ? barColor1 : barColor2
        ..style = PaintingStyle.fill;

      final rect = Rect.fromLTWH(currentX, topY, barWidth, barHeight);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)),
          paint); // More rounded corners

      currentX += barWidth + spacing;
    }

    // Draw horizontal lines with labels
    final linePaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i <= 5; i++) {
      final y = size.height - (maxBarHeight * (i / 5)) - 10;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);

      // Draw labels
      textPainter.text = TextSpan(
        text: (i * 1000).toString(), // Adjust label values
        style: const TextStyle(color: Colors.grey, fontSize: 10),
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(-10, y - 5)); // Position labels to the left
    }
  }

  @override
  bool shouldRepaint(_StepGraphPainter oldDelegate) {
    return stepData != oldDelegate.stepData ||
        barWidth != oldDelegate.barWidth ||
        spacing != oldDelegate.spacing;
  }
}

class BarGraphSection extends StatefulWidget {
  const BarGraphSection({super.key});

  @override
  State<BarGraphSection> createState() => _BarGraphSectionState();
}

class _BarGraphSectionState extends State<BarGraphSection> {
  String data = 'Past Days';

  final List<DropdownMenuItem> _list = [
    DropdownMenuItem(
      value: 'Past Weeks',
      child: Text('Past Weeks'),
    ),
    DropdownMenuItem(
      value: 'Past Years',
      child: Text('Past Years'),
    ),
    DropdownMenuItem(
      value: 'Past Days',
      child: Text('Past Days'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<int> rawSteps = [3800, 5000, 4100, 4600, 3900, 4200];
    double maxSteps = rawSteps.reduce(max).toDouble();
    List<double> normalizedSteps =
        rawSteps.map((step) => step / maxSteps).toList();

    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Steps",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                  ),
                ),
                DropdownButton(
                  value: data,
                  items: _list,
                  onChanged: (value) {
                    setState(() {
                      data = value;
                    });
                  },
                  iconSize: 40,
                ),
              ],
            ),
          ),
          Gap(10),
          Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border: Border.all(
                      color: const Color.fromARGB(221, 182, 182, 182))),
              child: StepGraph(stepData: normalizedSteps)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(
                          color: const Color.fromARGB(221, 221, 220, 220))),
                  child: _InfoCard(
                      title: "Calories Burnt",
                      value: "1.2k",
                      unit: "kcal",
                      icon: Icons.local_fire_department),
                ),
              ),
              Gap(20),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(
                          color: const Color.fromARGB(221, 221, 220, 220))),
                  child: _InfoCard(
                      title: "Distance Covered",
                      value: "3.3",
                      unit: "KM",
                      icon: Icons.directions_walk),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  const _InfoCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(title,
                      maxLines: 2,
                      style: GoogleFonts.roboto(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                ),
                Flexible(
                  child: Icon(
                    icon,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            Gap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(value,
                    style: GoogleFonts.roboto(
                        fontSize: 30, fontWeight: FontWeight.w700)),
                Text(unit, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
