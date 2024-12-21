import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ConnectivityPage extends StatefulWidget {
  const ConnectivityPage({super.key});

  @override
  State<ConnectivityPage> createState() => _ConnectivityPageState();
}

class _ConnectivityPageState extends State<ConnectivityPage>
    with TickerProviderStateMixin {
  late AnimationController _buttonController;
  late Animation<double> _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05)
      .animate(
          CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut));

  @override
  void initState() {
    super.initState();

    _buttonController = AnimationController(
      duration: const Duration(seconds: 1), // Reduced duration
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
        CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
          builder: (context, double opacity, child) {
            return Opacity(
              opacity: opacity,
              child: child,
            );
          },
          child: Text("No Connection !"),
        ),
      ),
      body: Stack(
        children: [
          // Animated Background with Bounce Effect

          Positioned(
            bottom: -500,
            child: TweenAnimationBuilder(
              tween: Tween<Offset>(
                  begin: const Offset(0, 1), end: const Offset(0, 0)),
              duration: const Duration(seconds: 2), // Reduced duration
              curve: Curves.bounceOut,
              builder: (context, Offset offset, child) {
                return Transform.translate(
                  offset: Offset(0, offset.dy * 100),
                  child: child,
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 800,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 221, 179),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(10),
                    Container(
                      width: 40,
                      height: 10,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 246, 246, 246),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Animated Lottie Animation
          Center(
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 1), // Reduced duration
              curve: Curves.easeIn,
              builder: (context, double opacity, child) {
                return Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: opacity,
                    child: child,
                  ),
                );
              },
              child: Lottie.asset(
                "assets/gifs/no connection.json",
                width: 300,
                repeat: true,
              ),
            ),
          ),

          // Animated Text Slide from Bottom
          Positioned(
            bottom: 140,
            left: 0,
            right: 0,
            child: TweenAnimationBuilder(
              tween: Tween<Offset>(
                  begin: const Offset(0, 1), end: const Offset(0, 0)),
              duration: const Duration(seconds: 2), // Reduced duration
              curve: Curves.elasticOut,
              builder: (context, Offset offset, child) {
                return Transform.translate(
                  offset: Offset(0, offset.dy * 50),
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(seconds: 1),
                    builder: (context, double opacity, child) {
                      return Opacity(
                        opacity: opacity,
                        child: child,
                      );
                    },
                    child: child,
                  ),
                );
              },
              child: Text(
                "Is there any problem\nin Internet Connection?",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          // Animated "Try Again" Button with Scale Transition
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Try Again",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
