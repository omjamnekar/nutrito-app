import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/pages/auth/forgot.dart';
import 'package:nutrito/pages/auth/verification.dart';
import 'package:nutrito/util/color.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _offsetAnimation;
  bool isSendVerification = false;
  bool isSignIn = false;

  bool isSendCode = false;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Total animation duration
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _offsetAnimation = Tween<double>(begin: -50, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward(); // Start the animation
  }

  void signInFrameChange() {
    setState(() {
      isSignIn = !isSignIn;
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget animatedWidget(Widget child, double delayMultiplier) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _offsetAnimation.value * delayMultiplier),
            child: child,
          ),
        );
      },
    );
  }

  List<double> widthof = [250, 400];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // Smooth image transition with position and opacity animation

        Positioned(
          left: 20,
          top: 50,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        Positioned(
          top: -60,
          right: -60,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.translate(
                  offset: Offset(0, _offsetAnimation.value),
                  child: Image.asset(
                    !isSignIn
                        ? "assets/image/auth/signup.png"
                        : "assets/image/auth/signIn.png",
                    key: ValueKey<bool>(isSignIn),
                    width: !isSignIn ? widthof[0] : widthof[1],
                  ),
                ),
              );
            },
          ),
        ),
        // Ensure 'Positioned' is inside the 'Stack'
        Center(
          child: Form(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(30),
                  animatedWidget(
                    Text(
                      "Forgot Password ?",
                      style: GoogleFonts.inter(
                        fontSize: 49,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    1,
                  ),
                  const Gap(20),

                  animatedWidget(
                    TextFormField(
                      decoration: InputDecoration(
                        focusColor: ColorManager.greenPrimary,
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 129, 129, 129),
                            fontSize: 20),
                        hintText: "Email",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 3,
                              color: Color.fromARGB(221, 163, 163, 163),
                              style: BorderStyle.solid,
                            )),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            width: 20,
                            color: Color.fromARGB(221, 163, 163, 163),
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                    1,
                  ),

                  // Login
                  const Gap(20),
                  animatedWidget(
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerificationPage(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black87),
                        ),
                        child: Text(
                          "Send Verification Link",
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    0.5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
