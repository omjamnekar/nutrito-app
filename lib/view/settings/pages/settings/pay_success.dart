import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class PaySuccessPage extends StatefulWidget {
  const PaySuccessPage({super.key});

  @override
  State<PaySuccessPage> createState() => _PaySuccessPageState();
}

class _PaySuccessPageState extends State<PaySuccessPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animationController,
              child: Center(
                child: Lottie.asset(
                  "assets/gifs/done.json",
                  repeat: false,
                ),
              ),
            ),
            FadeTransition(
              opacity: _animationController.drive(
                CurveTween(curve: Interval(0.5, 1.0, curve: Curves.easeIn)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Payment Successful!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Continue',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
