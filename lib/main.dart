import 'package:flutter/material.dart';
import 'package:nutrito/pages/connection/connectivity.dart';
import 'package:nutrito/pages/connection/navigator.dart';
import 'package:nutrito/pages/splashPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrito-beta',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: NavigatorPage(
        desireWidget: SplashPage(),
      ),
    );
  }
}
