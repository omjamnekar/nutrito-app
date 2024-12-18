import 'package:flutter/material.dart';
import 'package:nutrito/util/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            // Spinner
            Container(),
            // Actuator
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
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: Image.asset("assets/image/home/boat.png"),
      ),
      bottomNavigationBar: Container(
        height: 63,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
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
              decoration: BoxDecoration(
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
