import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/pages/auth/signup.dart';
import 'package:nutrito/pages/home.dart';
import 'package:nutrito/util/color.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<String> _frame1 = [
    "assets/image/ellipse/Ellipse 1.png",
    "assets/image/ellipse/Ellipse 3.png",
    "assets/image/ellipse/Ellipse 5.png",
    "assets/image/ellipse/Ellipse 7.png",
  ];
  final List<String> _frame2 = [
    "assets/image/ellipse/Ellipse 2.png",
    "assets/image/ellipse/Ellipse 4.png",
    "assets/image/ellipse/Ellipse 6.png",
    "assets/image/ellipse/Ellipse 8.png",
  ];

  final List<Widget> heroAnimation = [
    Image.asset(
      'assets/gifs/product_assistant.gif',
      height: 300,
      width: 300,
    ),
    Image.asset(
      "assets/gifs/ingredient.gif",
      height: 300,
      width: 300,
    ),
    Image.asset(
      "assets/gifs/personal_assistant.gif",
      height: 300,
      width: 300,
    ),
    Image.asset(
      "assets/gifs/smart_grocery.gif",
      height: 300,
      width: 300,
    )
  ];

  List<String> heading = [
    "Your Personal Product Assistant",
    "Ingredient Breakdown and Explanation",
    "Personalized assistant",
    "Smart Grocery"
  ];

  List<String> description = [
    "Avoid the hassle of reading lengthy labels. This app does the work for you.",
    "Provide breakdown of each ingredient in product, including what is there in it.",
    "Act as virtual guide, helping users to make the best decision based on their health.",
    "It helps you with selecting only the necessary list of products that you need."
  ];

  final List coordinates1 = const [
    Offset(-100, 0),
    Offset(-100, 0),
    Offset(-100, 0),
    Offset(-100, -10),
  ];

  final List coordinates2 = const [
    Offset(90, 350),
    Offset(90, 350),
    Offset(90, 590),
    Offset(90, 430),
  ];

  int currentIndex = 0;
  bool isVisible = true;

  void navigateToSignUp() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SignUpPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  bool makeHomeVisible = false;

  void changeIndex({required bool isNext}) async {
    if (currentIndex == 3) {
      setState(() {
        makeHomeVisible = true;
      });

      return;
    }

    setState(() {
      isVisible = false;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      if (isNext) {
        currentIndex = (currentIndex + 1) % _frame1.length;
      } else {
        currentIndex = (currentIndex - 1 + _frame1.length) % _frame1.length;
      }
      isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AnimatedOpacity(
                opacity: isVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Transform.translate(
                  offset: coordinates1[currentIndex],
                  child: Image.asset(
                    _frame1[currentIndex],
                    width: 250,
                    height: 250,
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: isVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Transform.translate(
                  offset: coordinates2[currentIndex],
                  child: Image.asset(
                    _frame2[currentIndex],
                    width: 150,
                    height: 250,
                  ),
                ),
              ),
            ],
          ),
          AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Transform.translate(
              offset: const Offset(80, 0),
              child: heroAnimation[currentIndex],
            ),
          ),
          const Spacer(),
          AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                heading[currentIndex],
                style: GoogleFonts.cabin(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: MediaQuery.of(context).size.width + 100 / 2,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                description[currentIndex],
                style: GoogleFonts.ibmPlexSans(
                    color: const Color.fromARGB(221, 96, 96, 96),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Gap(30),
          Container(
            // color: Colors.amber,
            padding: const EdgeInsets.symmetric(horizontal: 10),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                      onPressed: () {
                        changeIndex(
                            isNext: false); // Trigger backward animation
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(50)),
                    child: TextButton(
                      onPressed: () {
                        changeIndex(isNext: true);
                      },
                      child: Text(
                        "Next",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: ColorManager.greenPrimary),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 2,
                  child: Visibility(
                    visible: makeHomeVisible,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(50)),
                      child: TextButton(
                        onPressed: () {
                          navigateToSignUp();
                        },
                        child: const Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(20)
        ],
      ),
    );
  }
}
