import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nutrito/network/controller/auth.dart';
import 'package:nutrito/view/dist/trailing.dart';

// ignore: must_be_immutable
class VerificationPage extends ConsumerStatefulWidget {
  AuthController authcontroller;
  VerificationPage({super.key, required this.authcontroller});

  @override
  ConsumerState<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends ConsumerState<VerificationPage> {
  String nutrito = " Nutrito!";
  bool isVarified = false;

  Future<void> verifyUser() async {
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
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const TrailingPage(),
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
  void initState() {
    super.initState();

    dataNotify();
  }

  Future<void> dataNotify() async {
    await widget.authcontroller.varificationChannel();
  }

  Future<void> dataBinding() async {
    final data = await widget.authcontroller.velidation();
    setState(() {
      isVarified = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    dataBinding();

    return Scaffold(
      body: Container(
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
              padding: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(40), right: Radius.circular(40)),
                color: Color.fromARGB(45, 24, 255, 151),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 70,
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
                        SizedBox(
                          width: 350,
                          child: Text(
                            """○ We need to verify your email to ensure the security of your account.\n○ A verification link has been sent to your email. Please click to continue.""",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: Colors.black87),
                          ),
                        ),
                        const Gap(20),
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
    );
  }
}
