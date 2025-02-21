import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/theme/color.dart';

// ignore: must_be_immutable
class SplashPage extends StatefulWidget {
  Widget widget;
  SplashPage({super.key, required this.widget});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Ensure the widget is still in the widget tree
        _animationController.reverse().then((_) {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => widget,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = 0.0;
                  const end = 1.0;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var fadeAnimation = animation.drive(tween);

                  return FadeTransition(
                    opacity: fadeAnimation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(seconds: 1),
                reverseTransitionDuration: const Duration(seconds: 1),
              ),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset:
                            Offset(0, -_animation.value), // Moves up and down
                        child: child,
                      );
                    },
                    child: Image.asset(
                      "assets/image/nutrito-logo.png",
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      const Gap(30),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Loading....",
                          style: GoogleFonts.inter(),
                        ),
                      ),
                      const Gap(10),
                      LinearProgressIndicator(
                        minHeight: 5,
                        borderRadius: BorderRadius.circular(20),
                        color: ColorManager.greenPrimary,
                      ),
                    ],
                  ),
                ),
              ),
              const Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("WEEBHUB"),
                      Text("version 1.0 beta"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
