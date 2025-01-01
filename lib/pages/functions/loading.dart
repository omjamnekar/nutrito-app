import 'package:flutter/material.dart';

class CameraLoadingPage extends StatefulWidget {
  const CameraLoadingPage({super.key});

  @override
  State<CameraLoadingPage> createState() => _CameraLoadingPageState();
}

class _CameraLoadingPageState extends State<CameraLoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets"),
      ),
    );
  }
}
