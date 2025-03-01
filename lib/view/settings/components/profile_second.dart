import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/data/settings.dart';
import 'package:get/get.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:nutrito/view/settings/pages/profile/about.dart';

import 'package:nutrito/view/settings/pages/profile/cooking.dart';
import 'package:nutrito/view/settings/pages/profile/family.dart';
import 'package:nutrito/view/settings/pages/profile/healthSetting.dart';
import 'package:nutrito/view/settings/pages/profile/myPost.dart';
import 'package:nutrito/view/settings/pages/profile/myScan.dart';
import 'package:share_plus/share_plus.dart';

class SecondSection extends ConsumerStatefulWidget {
  const SecondSection({super.key});

  @override
  ConsumerState<SecondSection> createState() => _SecondSectionState();
}

class _SecondSectionState extends ConsumerState<SecondSection> {
  String _seletedOption = "private";
  final List<String> _itemsOption = ["private", "public"];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 540,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).canvasColor,
        boxShadow: [
          // Bottom Shadow
          BoxShadow(
            // ignore: deprecated_member_use
            color: const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3), // Downward shadow
          ),
          // Top Shadow
          BoxShadow(
            // ignore: deprecated_member_use
            color: const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, -3), // Upward shadow
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: selectionList[index],
                    leading: secondProfileSection[index],
                    trailing: Image.asset(
                      "assets/image/settings/arc.png",
                      width: 30,
                    ),
                    onTap: () => onSwitch(index),
                  );
                },
              ),
            ),
            ListTile(
              title: const Text("Profile Access"),
              leading: Image.asset(
                "assets/image/settings/picture.png",
                width: 30,
                color: const Color.fromARGB(159, 0, 221, 181),
              ),
              trailing: Container(
                height: 20,
                padding: const EdgeInsets.only(left: 20),
                child: DropdownButton(
                  value: _seletedOption,
                  items: _itemsOption.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _seletedOption = newValue ?? "";
                    });
                    snackShow(newValue ?? "");
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: selectedList2[index],
                    leading: secondProfileSection2[index],
                    trailing: Image.asset(
                      "assets/image/settings/arc.png",
                      width: 30,
                    ),
                    onTap: () => onSwitch2(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void snackShow(String account) {
    Get.snackbar("Info", "Your account is now $account",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        icon: Icon(
          Icons.info_outline,
          color: Colors.white,
        ),
        colorText: Colors.white,
        margin: EdgeInsets.only(bottom: 10));
  }

  void onSwitch(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScanSettingsPage(),
            ));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CookingAISettingsPage(),
            ));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FamilyHealthPage(),
            ));
        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HealthGuideSettings(),
            ));
        break;
      default:
    }
  }

  void onSwitch2(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostSettingsPage(),
            ));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AboutPage(),
            ));
        break;
      case 2:
        Share.share(
            'Check out Nutrito for your Health and Famiy:\nhttps://github.com/omjamnekar/nutrito-app');
        break;

      default:
    }
  }
}
