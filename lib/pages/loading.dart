import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/pages/home.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _yellowImageAnimation;
  late Animation<Offset> _greenImageAnimation;
  late Animation<Offset> _yellowFloatingAnimation;
  late Animation<Offset> _greenFloatingAnimation;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => HomePage(),
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(
              opacity: animation1,
              child: child,
            );
          },
        ),
      );
    });
    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeat the floating effect indefinitely

    // Initial slide-in animation (from outside)
    _yellowImageAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0), // Start from the right
      end: const Offset(0, 0), // End at the center (original position)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _greenImageAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0), // Start from the left
      end: const Offset(0, 0), // End at the center (original position)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Floating effect animation (subtle up and down movement)
    _yellowFloatingAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 0.03), // Subtle floating effect
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _greenFloatingAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.03), // Subtle floating effect
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the initial animation sequence
    _controller.forward();
  }

  @override
  void dispose() {
    // Dispose of the animation controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Yellow image animation: First move from the right, then continue floating
          Positioned(
            top: 0,
            right: -20,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return SlideTransition(
                  position: _yellowImageAnimation.value == Offset(0, 0)
                      ? _yellowFloatingAnimation // Once the first animation completes, start floating
                      : _yellowImageAnimation, // Otherwise, continue the slide-in animation
                  child: child,
                );
              },
              child: Image.asset(
                "assets/image/loading/yellow.png",
                width: 300,
              ),
            ),
          ),
          // Green image animation: First move from the left, then continue floating
          Positioned(
            bottom: -50,
            left: 0,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return SlideTransition(
                  position: _greenImageAnimation.value == Offset(0, 0)
                      ? _greenFloatingAnimation // Once the first animation completes, start floating
                      : _greenImageAnimation, // Otherwise, continue the slide-in animation
                  child: child,
                );
              },
              child: Image.asset(
                "assets/image/loading/green.png",
                width: 300,
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            right: -30,
            child: Transform.rotate(
              angle: 4.7,
              child: Text(
                "NUTRITO",
                style: GoogleFonts.poppins(
                  fontSize: 33,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
