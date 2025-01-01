import 'package:flutter/material.dart';

class ComaparePage extends StatefulWidget {
  const ComaparePage({super.key});

  @override
  State<ComaparePage> createState() => _ComaparePageState();
}

class _ComaparePageState extends State<ComaparePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Compare page"),
      ),
    );
  }
}
