import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/network/controller/auth.dart';
import 'package:nutrito/pages/functions/compare.dart';
import 'package:nutrito/pages/functions/nutrilization.dart';
import 'package:nutrito/pages/functions/suggestion.dart';
import 'package:nutrito/pages/home/components/drawer.dart';
import 'package:nutrito/pages/home/home.dart';
import 'package:nutrito/pages/home/components/opener.dart';
import 'package:nutrito/pages/media/social.dart';
import 'package:nutrito/pages/searchs/search.dart';
import 'package:nutrito/pages/settings/user.dart';
import 'package:nutrito/util/extensions/extensions.dart';
import 'package:nutrito/util/theme/color.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int selectedIndex = 0; // Track selected tab index

  // List of pages for each tab

  bool isBottomNeeded = false;

  bool cameraOpenState = false;

  void onTabTapped(int index) {
    if (index == 2) {
      setState(() {
        cameraOpenState = !cameraOpenState;
      });
    } else {
      setState(() {
        selectedIndex = index;
        isBottomNeeded = false;
        cameraOpenState = false;
      });
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> pages = [
    HomePage(),
    SearchPage(),
    const Center(child: Text("Camera Page Placeholder")),
    const SocialMediaPage(),
    const SettingsPage(),
    ComaparePage(),
    NutrilizationPage(),
    SuggestionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: GestureDetector(
          onTap: () {},
          child: Text(
            "Nutrito",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 1, 192, 157)),
          ),
        ),

        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                isBottomNeeded = !isBottomNeeded;
              });
            },
            child: Row(
              children: [
                Text(
                  "Scans",
                  style: GoogleFonts.poppins(fontSize: 15),
                ),
                Gap(10),
                Icon(Icons.document_scanner_outlined),
              ],
            ),
          ),
          const Gap(20)
        ],
        shadowColor: const Color.fromARGB(255, 187, 253, 241),
        surfaceTintColor: const Color.fromARGB(159, 0, 221, 181),

        // backgroundColor: ColorManager.bluePrimary,
      ),
      drawer: const Drawer(
        elevation: 30,
        backgroundColor: Color.fromARGB(255, 229, 255, 251),
        child: DrawerSection(),
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: selectedIndex,
            children: pages,
          ),
          if (cameraOpenState)
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                height: 250,
                child: Transform.translate(
                  offset: const Offset(0, 130),
                  child: Column(
                    children: [
                      Expanded(
                        child: OpenerCamera(
                          onTapOfnavigation: (value) =>
                              _navigationCamera(value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AuthController(ref: ref).signout(context);
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Image.asset(
          "assets/image/home/boat.png",
          width: 60,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed, // Ensures all tabs are shown
        selectedItemColor: ColorManager.greenPrimary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/image/home/home.png')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/image/home/search.png')),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/image/home/camera.png')),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/image/home/message.png')),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/image/home/profile.png')),
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.black,
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
      bottomSheet: isBottomNeeded
          ? ScanHistory(
              scannedProducts: [
                "Product 1",
                "Product 2",
                "Product 3",
                "Product 4",
                "Product 5",
              ],
              oncencel: () {
                setState(() {
                  isBottomNeeded = false;
                });
              },
            )
          : null,
    );
  }

  _navigationCamera(int value) {
    if (value == 1) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              NutrilizationPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    } else if (value == 2) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ComaparePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SuggestionPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    }
  }
}

class ScanHistory extends StatelessWidget {
  final Function() oncencel;
  final List<String> scannedProducts; // List of scanned product names

  const ScanHistory({
    super.key,
    required this.oncencel,
    required this.scannedProducts, // Add the list as a parameter
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(42, 0, 0, 0),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, -2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: oncencel,
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.black87,
              ).withIconStyle(iconSize: 30),
            ),
          ),
          const Center(
            child: Text(
              'Scan History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Add a ListView to display the history
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,

              itemCount: scannedProducts.length, // Number of items in the list
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://www.foodiesfeed.com/wp-content/uploads/2023/06/burger-with-melted-cheese.jpg",
                        fit: BoxFit.cover,
                        width: 80,
                        height: 100,
                      ),
                    ),
                    title: Text(
                        scannedProducts[index]), // Display each scanned product

                    subtitle: Text("product descriptions"),
                    trailing: IconButton(
                      icon: const Icon(Icons.label_important_sharp),
                      onPressed: () {
                        // Handle delete action if needed
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
