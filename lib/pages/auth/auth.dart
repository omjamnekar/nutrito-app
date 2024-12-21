import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/data/model/auth.dart';
import 'package:nutrito/data/repositories/googleService.dart';
import 'package:nutrito/network/controller/auth.dart';
import 'package:nutrito/pages/auth/forgot.dart';
import 'package:nutrito/pages/trailing.dart';
import 'package:nutrito/util/color.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _offsetAnimation;
  bool isSignIn = false;

  final TextEditingController emailController =
      TextEditingController(text: "omjjamnekar@gmail.com");
  final TextEditingController usernameController =
      TextEditingController(text: "om");
  final TextEditingController passwordController =
      TextEditingController(text: "omJAMNEKAR@1234");

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

  Widget animatedWidget(Widget child, int delayMultiplier) {
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
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    child: Stack(
                      children: [
                        Positioned(
                          top: -100,
                          right: -50,
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
                      ],
                    ),
                  ),
                  // Ensure 'Positioned' is inside the 'Stack'
                  Center(
                    child: Form(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Gap(30),
                            animatedWidget(
                              Text(
                                !isSignIn ? "Register" : "Login",
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
                                controller: emailController,
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
                                        color:
                                            Color.fromARGB(221, 163, 163, 163),
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
                              2,
                            ),
                            if (isSignIn == false) const Gap(20),
                            if (isSignIn == false)
                              animatedWidget(
                                TextFormField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    focusColor: ColorManager.greenPrimary,
                                    hintStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 129, 129, 129),
                                        fontSize: 20),
                                    hintText: "Username",
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 3,
                                          color: Color.fromARGB(
                                              221, 163, 163, 163),
                                          style: BorderStyle.solid,
                                        )),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        width: 20,
                                        color:
                                            Color.fromARGB(221, 163, 163, 163),
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                                2,
                              ),
                            const Gap(20),
                            animatedWidget(
                              TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  focusColor: ColorManager.greenPrimary,
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(255, 129, 129, 129),
                                      fontSize: 20),
                                  hintText: "Password",
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 3,
                                        color:
                                            Color.fromARGB(221, 163, 163, 163),
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
                              2,
                            ),
                            const Gap(50),
                            // Login
                            animatedWidget(
                              GestureDetector(
                                onTap: () {
                                  signInFrameChange();
                                },
                                child: const Text(
                                  "Already have an account? Login",
                                  style: TextStyle(
                                    height: 2,
                                    fontSize: 15,
                                    color: Colors.black87,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              2,
                            ),
                            const Gap(10),
                            animatedWidget(
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: TextButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    if (!isSignIn) {
                                      ctrl.signUpAuth(
                                          ref,
                                          usernameController.text,
                                          emailController.text,
                                          passwordController.text,
                                          ctrl);
                                    } else {
                                      ctrl.signIn(emailController.text,
                                          passwordController.text, context);
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.black87),
                                  ),
                                  child: Text(
                                    !isSignIn ? "Sign Up" : "Sign In",
                                    style: GoogleFonts.inter(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              1,
                            ),
                            Gap(30),
                            animatedWidget(Text("OR"), 1),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () => ctrl.googleSignin(context),
                                  child: _buildSocialButton('Google',
                                      'assets/image/auth/google.png', 1),
                                ),
                                const Gap(10),
                                _buildSocialButton('Github',
                                    'assets/image/auth/github.png', 2),
                              ],
                            ),
                            const Gap(50),
                            animatedWidget(
                                Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ForgotPasswordPage(),
                                              ));
                                        },
                                        child: Text(
                                          "Forgot Password ?",
                                          style:
                                              GoogleFonts.poppins(fontSize: 15),
                                        ),
                                      ),
                                      const Gap(40)
                                    ],
                                  ),
                                ),
                                1)
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Add this 'Positioned' widget only if needed in the Stack
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSocialButton(
      String label, String iconPath, int delayMultiplier) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _offsetAnimation.value + 10 * delayMultiplier),
            child: child,
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color.fromARGB(95, 33, 149, 243)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(5),
            Image.asset(iconPath, width: 40),
            const Gap(20),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(221, 78, 78, 78),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
