import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nutrito/view/dist/onboarding.dart';
import 'package:nutrito/util/theme/color.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  bool isToggled = false;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Define the opacity animation
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Define the scale animation
    _scaleAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void navigateToOnboarding() {
    _animationController.reverse().then((_) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const OnboardingPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Apply the FadeTransition to fade out current page before navigating
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dynamically calculate the container width
    double containerWidth =
        MediaQuery.of(context).size.width - 60; // Margin on both sides
    double rollerSize = 90;

    return Scaffold(
      body: FadeTransition(
        opacity:
            _opacityAnimation, // Fade out the current page before navigating
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background leaf animation
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Lottie.asset(
                      "assets/gifs/leaf.json", // Add your Lottie file path here
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),

            // Welcome text
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "WELCOME TO\n",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextSpan(
                        text: "NUTRITO",
                        style: GoogleFonts.ubuntu(
                          color: ColorManager.greenPrimary,
                          fontSize: 60,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
                child: Transform.translate(
              offset: const Offset(0, 100),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.only(right: 40.0, left: 15),
                  child: Text(
                    "A healthy lifestyle, personalized nutrition tracking. Stay fit with Nutrito!",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color.fromARGB(221, 104, 104, 104),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            )),

            // Toggle switch
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  // Adjust toggle state based on drag direction
                  if (details.delta.dx > 0 && !isToggled) {
                    setState(() {
                      isToggled = true;
                    });
                    navigateToOnboarding();
                  } else if (details.delta.dx < 0 && isToggled) {
                    setState(() {
                      isToggled = false;
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: rollerSize,
                  width: containerWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: isToggled
                          ? ColorManager.bluePrimary
                          : const Color.fromARGB(165, 133, 132, 132),
                      border: Border.all(
                          width: 4, color: ColorManager.bluePrimary)),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        left: isToggled
                            ? containerWidth - rollerSize + 20
                            : 0, // Ensure it stops at the edges
                        child: Container(
                          width: rollerSize - 10,
                          height: rollerSize - 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                          child: !isToggled
                              ? Text(
                                  "Let's Start",
                                  key: const ValueKey("start"),
                                  style: GoogleFonts.poppins(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  "Be Healthy!!",
                                  key: const ValueKey("healthy"),
                                  style: GoogleFonts.poppins(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
