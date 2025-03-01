import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/network/controller/auth.dart';
import 'package:nutrito/network/provider/auth.dart';
import 'package:nutrito/util/data/settings.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:nutrito/util/extensions/extensions.dart';
import 'package:nutrito/view/settings/pages/settings/acc_media.dart';
import 'package:nutrito/view/settings/pages/settings/acc_purchase.dart';
import 'package:nutrito/view/settings/pages/settings/acc_sub.dart';
import 'package:nutrito/view/settings/pages/settings/acc_update.dart';
import 'package:nutrito/view/settings/pages/settings/app_accur.dart';
import 'package:nutrito/view/settings/pages/settings/app_not.dart';
import 'package:nutrito/view/settings/pages/settings/app_storage.dart';
import 'package:nutrito/view/settings/pages/settings/app_support.dart';
import 'package:nutrito/view/settings/pages/settings/app_theme.dart';
import 'package:nutrito/view/settings/pages/settings/ser_feedback.dart';
import 'package:nutrito/view/settings/pages/settings/ser_privacy.dart';
import 'package:nutrito/view/settings/pages/settings/ser_terms.dart';
import 'package:nutrito/view/settings/pages/settings/ser_ver.dart';

class SettingSection extends ConsumerStatefulWidget {
  const SettingSection({super.key});

  @override
  ConsumerState<SettingSection> createState() => _SettingSectionState();
}

class _SettingSectionState extends ConsumerState<SettingSection> {
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
              color: Theme.of(context).canvasColor,
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
                          onTap: () => setSwitch(index),
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
              color: Theme.of(context).canvasColor,
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
                          onTap: () => setSwitch2(index),
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
                          onTap: () => setSwitch3(index),
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
                  GestureDetector(
                    onTap: () async {},
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("Sign Out"),
                      onTap: () async {
                        await ref
                            .watch(authStateProvider.notifier)
                            .signOut(context, ref);
                      },
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }

  void setSwitch(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationSettingsPage(),
            ));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppThemeSettings(),
            ));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppAccuracySettingsPage(),
            ));
        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StorageManagementPage(),
            ));
        break;
      case 4:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StorageManagementPage(),
            ));
        break;
      default:
        exit(0);
    }
  }

  void setSwitch2(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PurchaseHistoryPage(),
            ));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SocialMediaIntegrationPage(),
            ));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppUpdatePage(),
            ));
        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubscriptionPage(),
            ));
        break;
      case 4:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StorageManagementPage(),
            ));
        break;

      default:
    }
  }

  void setSwitch3(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PrivacyPolicyPage(),
          ),
        );
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FeedbackPage(),
            ));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TermsOfServicePage(),
            ));
        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppVersionPage(),
            ));
        break;

      default:
    }
  }
}
