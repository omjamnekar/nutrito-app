import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/network/controller/auth.dart';
import 'package:nutrito/pages/auth/forgot.dart';
import 'package:nutrito/pages/auth/verification.dart';
import 'package:nutrito/util/color.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _offsetAnimation;
  bool isSendVerification = false;
  bool isSignIn = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

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
      body: GetBuilder(
        init: AuthController(ref: ref),
        builder: (ctrl) {
          return Stack(
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
                  key: _formKey,
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
                            controller: _emailController,
                            validator: (value) => validateEmail(value ?? ""),
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
                                validation(
                                  (p0) {
                                    ctrl.forgotpassword(_emailController.text);
                                  },
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

                        const Gap(18),
                        animatedWidget(
                            Container(
                              child: Text(
                                "Once it is reset! Try\nlogin Again.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            1),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void validation(void Function(void) onSubmit) {
    if (_formKey.currentState?.validate() ?? false) {
      onSubmit;
    } else {
      return;
    }
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email cannot be empty';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }
}
