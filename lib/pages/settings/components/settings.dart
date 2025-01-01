import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/data/settings.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:nutrito/util/extensions/extensions.dart';

class SettingSection extends StatefulWidget {
  const SettingSection({super.key});

  @override
  State<SettingSection> createState() => _SettingSectionState();
}

class _SettingSectionState extends State<SettingSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 350,
            margin: const EdgeInsets.only(
              top: 20,
              left: 8,
              right: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                // Bottom Shadow
                BoxShadow(
                  color:
                      const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // Downward shadow
                ),
                BoxShadow(
                  color:
                      const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, -3), // Upward shadow
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "App Settings",
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ).withHeadStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: settingsTitle.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.asset(
                            settingsIcon1[index],
                            color: ColorManager.bluePrimary,
                            width: 30,
                          ),
                          title: Text(settingsTitle[index])
                              .withStyle(fontSize: 17),
                        );
                      },
                    ),
                  )
                ],
              ),
            )),
        Container(
            height: 350,
            margin: const EdgeInsets.only(
              top: 20,
              left: 8,
              right: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color:
                      // ignore: deprecated_member_use
                      const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // Downward shadow
                ),
                BoxShadow(
                  color:
                      const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, -3), // Upward shadow
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "Accesss",
                    ).withHeadStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: settingsTitle2.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.asset(
                            settingsIcon2[index],
                            color: ColorManager.bluePrimary,
                            width: 30,
                          ),
                          title: Text(settingsTitle2[index])
                              .withStyle(fontSize: 17),
                        );
                      },
                    ),
                  )
                ],
              ),
            )),
        Container(
            height: 350,
            margin: const EdgeInsets.only(
              top: 20,
              left: 8,
              right: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                // Bottom Shadow
                BoxShadow(
                  color:
                      const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // Downward shadow
                ),
                // Top Shadow
                BoxShadow(
                  color:
                      const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, -3), // Upward shadow
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Services",
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ).withHeadStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: settingTitle3.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.asset(
                            settingIcon3[index],
                            color: ColorManager.bluePrimary,
                            width: 30,
                          ),
                          title: Text(settingTitle3[index])
                              .withStyle(fontSize: 17),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: const Divider(
                        color: Color.fromARGB(221, 189, 188, 188),
                      ),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Sign Out"),
                  )
                ],
              ),
            )),
      ],
    );
  }
}
