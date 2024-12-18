import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nutrito/pages/home.dart';
import 'package:nutrito/pages/trailing.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String nutrito = " Nutrito!";
  bool isVarified = false;

  Future<void> verifyUser() async {
    setState(() {
      isVarified = true;
    });

    // Ensure the dialog is shown after the widget has been updated
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isVarified) {
        showDialog(
          context: context,
          builder: (context) => Center(
            child: Lottie.asset("assets/image/auth/done.json",
                width: 300, height: 300),
          ),
        );

        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop();
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  TrailingPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(200),
              Column(
                children: [
                  Text(
                    "Waiting for Verification !!",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.ubuntu(
                        height: 1.2, fontSize: 50, fontWeight: FontWeight.w700),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5, top: 10, right: 20),
                    child: Text(
                      "You're just one step away from unlocking the full power of$nutrito",
                      maxLines: 2,
                      style: const TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
              Transform.translate(
                offset: const Offset(110, 5),
                child: Lottie.asset("assets/image/auth/cat.json",
                    width: 300, height: 300),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(40), right: Radius.circular(40)),
                  color: Color.fromARGB(45, 24, 255, 151),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(60)),
                      child: TextButton.icon(
                        onPressed: () async {
                          await verifyUser();
                        },
                        icon: !isVarified
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const SizedBox.shrink(),
                        label: Text(
                          isVarified ? "Let's Get Started" : "",
                          style: GoogleFonts.ubuntu(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 10),
                      child: Column(
                        children: [
                          Container(
                            width: 350,
                            child: Text(
                              """○ We need to verify your email to ensure the security of your account.\n○ A verification link has been sent to your email. Please click to continue.""",
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: Colors.black87),
                            ),
                          ),
                          Gap(20),
                          RichText(
                            text: const TextSpan(
                              text: "Need help? Contact support at ",
                              style: TextStyle(color: Colors.black54),
                              children: [
                                TextSpan(
                                  text: "nutrito@gmail.com",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(
                                  text: ".",
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
