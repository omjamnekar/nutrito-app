import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/network/controller/auth.dart';
import 'package:nutrito/pages/home/opener.dart';
import 'package:nutrito/util/color.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex = 0; // Keep track of the selected tab

  final List<Map<String, String>> tabs = [
    {"icon": "assets/image/home/home.png", "label": "Home"},
    {"icon": "assets/image/home/search.png", "label": "Search"},
    {"icon": "assets/image/home/camera.png", "label": "Camera"},
    {"icon": "assets/image/home/message.png", "label": "Message"},
    {"icon": "assets/image/home/profile.png", "label": "Profile"},
  ];

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Stack(
          children: [
            Container(), // Placeholder for spinner or actuator
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () {},
                child: Image.asset(
                  "assets/image/home/menu.png",
                  width: 35,
                ),
              ),
            )
          ],
        ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      bottomNavigationBar: Container(
        height: 200,
        child: Stack(
          children: [
            // Conditionally display OpenerCamera only when the third tab is selected
            if (selectedIndex == 2) OpenerCamera(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 63,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(tabs.length, (index) {
                    return _buildTabItem(
                      icon: tabs[index]["icon"]!,
                      isSelected: selectedIndex == index,
                      onTap: () => onTabTapped(index),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required String icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onTap,
            icon: Image.asset(
              icon,
              width: 35,
            ),
          ),
          if (isSelected)
            Container(
              height: 2,
              width: 40,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 4,
                    color: ColorManager.greenPrimary,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
