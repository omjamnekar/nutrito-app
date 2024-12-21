import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/pages/home/home.dart';
import 'package:nutrito/pages/loading.dart';

class TrailingPage extends StatefulWidget {
  const TrailingPage({super.key});

  @override
  State<TrailingPage> createState() => _TrailingPageState();
}

class _TrailingPageState extends State<TrailingPage> {
  List<String> icons = [
    "scan.png",
    "compare.png",
    "drink.png",
    "buy.png",
    "list.png"
  ];

  List<String> heading = [
    "Neutralization",
    "Meal Plan Generator",
    "Scan & Compare",
    "Should i Buy? Poll",
    "Smart Shopping List"
  ];

  List<String> description = [
    "Speed:  Quickly access information with a single scan. Depth:  Get comprehensive details on ingredients and nutrition. Insight:  Make informed choices based on the data.",
    "Personalized: Tailor meal plans to individual needs. Variety: Offer diverse recipe options. Calorie Control: Estimate daily calorie intake.",
    "Product Scanning: Scan product using a camera. Price Comparison: Compare prices across different retailers. Product Information: Access detailed product information reviews, ratings.",
    "Voting Analytics: Track voting statistics and display results in real time. Customization: Allow users to customize the poll's appearance and add additional options.",
    "Efficiency: Save time and reduce impulse purchases. Savings: Track prices and find the best deals on items. Healthy Eating: Use meal planning integration to promote food choices.",
  ];

  List<String> buttonString = [
    "Let's neutralize",
    "Start Planning",
    "Compare products",
    "Test product",
    "Add Product"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 224, 255, 241),
      body: CustomScrollView(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        slivers: [
          //sliver app bar

          SliverAppBar(
            leading: const Icon(Icons.menu),
            actions: [
              GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            LoadingPage(
                          toWidget: const HomePage(),
                        ),
                        transitionsBuilder:
                            (context, animation1, animation2, child) {
                          return FadeTransition(
                            opacity: animation1,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "HOME",
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(131, 0, 0, 0)),
                    ),
                  ))
            ],
            expandedHeight: 350,
            backgroundColor: const Color.fromARGB(248, 158, 222, 193),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: const Color.fromARGB(248, 224, 255, 241),
              ),
              title: Text(
                "FEATURES",
                style: GoogleFonts.poppins(
                    fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(198, 192, 192, 192),
                        spreadRadius: 6,
                        blurRadius: 18)
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  for (int i = 0; i < heading.length; i++)
                    CardManager(
                      icon: icons[i],
                      heading: heading[i],
                      description: description[i],
                      buttonString: buttonString[i],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CardManager extends StatelessWidget {
  String heading;
  String icon;
  String description;
  String buttonString;
  CardManager({
    super.key,
    required this.icon,
    required this.heading,
    required this.description,
    required this.buttonString,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(219, 192, 192, 192),
            spreadRadius: 1,
            blurRadius: 16,
          ),
        ],
        borderRadius: BorderRadius.circular(60),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 6, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/image/features/$icon",
                  width: 35,
                ),
                Image.asset(
                  "assets/image/features/menu.png",
                  width: 35,
                )
              ],
            ),
            const Gap(14),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                heading,
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 3, 90, 107)),
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                description,
                style: GoogleFonts.poppins(
                    fontSize: 13,
                    height: 1.5,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(143, 112, 112, 112)),
              ),
            ),
            const Gap(10),
            TextButton(
              style: const ButtonStyle(
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: Color.fromARGB(221, 121, 121, 121),
                    width: 5,
                  ),
                ),
                padding: WidgetStatePropertyAll(
                    EdgeInsets.only(top: 6, left: 60, bottom: 6, right: 60)),
                backgroundColor: WidgetStatePropertyAll(
                  Color.fromARGB(255, 37, 33, 23),
                ),
              ),
              onPressed: () {},
              child: Text(
                buttonString,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: const Color.fromARGB(172, 255, 255, 255),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
