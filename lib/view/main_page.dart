import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/network/controller/auth.dart';
import 'package:nutrito/view/functions/alternative.dart';
import 'package:nutrito/view/functions/compare.dart';
import 'package:nutrito/view/functions/gen/gen_chat.dart';
import 'package:nutrito/view/functions/nutrilization.dart';
import 'package:nutrito/view/functions/smartList.dart';
import 'package:nutrito/view/home/components/drawer.dart';
import 'package:nutrito/view/home/home.dart';
import 'package:nutrito/view/home/components/opener.dart';
import 'package:nutrito/view/media/social.dart';
import 'package:nutrito/view/options/scanHistory.dart';
import 'package:nutrito/view/searchs/search.dart';
import 'package:nutrito/view/settings/user.dart';
import 'package:nutrito/util/theme/color.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int selectedIndex = 0;
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

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> pages = [
    HomePage(),
    SearchPage(),
    const Center(child: Text("Camera Page Placeholder")),
    const SocialMediaPage(),
    SettingsPage(),
    ComaparePage(),
    NutriStateNavigate(),
    SmartListPage(),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlternativePage(),
                  ));
            },
            child: Row(
              children: [
                Text(
                  "Alter",
                  style: GoogleFonts.poppins(fontSize: 15),
                ),
                Gap(5),
                Icon(Icons.change_circle_outlined),
              ],
            ),
          ),
          Gap(20),
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
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  GenChatPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.ease;

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
              NutriStateNavigate(),
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
              SmartListPage(),
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
