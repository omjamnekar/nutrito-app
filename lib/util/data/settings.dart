import 'package:flutter/material.dart';
import 'package:nutrito/util/extensions/extensions.dart';
import 'package:nutrito/util/theme/color.dart';

final List<Map<String, dynamic>> settingSearchData = [
  {
    "name": "Avatars",
    "icon": Image.asset(
      "assets/image/settings/user_box.png",
      width: 30,
      color: const Color.fromARGB(159, 0, 221, 181),
    ),
  },
  {
    "name": "Username",
    "icon": Image.asset(
      "assets/image/settings/a.png",
      width: 22,
      color: const Color.fromARGB(159, 0, 221, 181),
    ),
  },
  {
    "name": "Email",
    "icon": Image.asset(
      "assets/image/settings/e-mail.png",
      width: 30,
      color: const Color.fromARGB(159, 0, 221, 181),
    ),
  },
  {
    "name": "Diatary Intake",
    "icon": Image.asset(
      "assets/image/settings/water.png",
      width: 30,
      color: const Color.fromARGB(159, 0, 221, 181),
    ),
  },
  {
    "name": "Nutrient Deficiencies",
    "icon": Image.asset(
      "assets/image/settings/bubble_fill.png",
      width: 30,
      color: const Color.fromARGB(159, 0, 221, 181),
    ),
  },
  {
    "name": "Weight",
  },
  {
    "name": "Weight Loss",
  },
  {
    "name": "Nutri score",
  },
  {
    "name": "Groups",
  },
  {
    "name": "My Scans",
    "icon": Image.asset(
      "assets/image/settings/notebook.png",
      width: 30,
      color: const Color.fromARGB(159, 0, 221, 181),
    ),
  },
  {
    "name": "Cooking Mode",
    "icon": Image.asset(
      "assets/image/settings/book.png",
      width: 30,
      color: const Color.fromARGB(159, 0, 221, 181),
    ),
  },
  {
    "name": "Family Member",
    "icon": Image.asset(
      "assets/image/settings/home.png",
      width: 30,
      color: const Color.fromARGB(159, 0, 221, 181),
    ),
  },
  {
    "name": "Health Settings",
    "icon": Image.asset(
      "assets/image/settings/glass.png",
      width: 30,
      color: const Color.fromARGB(159, 0, 221, 181),
    ),
  },
  {
    "name": "My Post",
    "icon": Image.asset(
      "assets/image/settings/message.png",
      width: 30,
      color: const Color.fromARGB(159, 0, 221, 181),
    ),
  },
  {
    "name": "About",
    "icon": Image.asset(
      "assets/image/settings/i.png",
      width: 30,
      color: const Color.fromARGB(159, 0, 221, 181),
    ),
  },
  {
    "name": "Share App",
    "icon": Image.asset(
      "assets/image/settings/share.png",
      width: 30,
      color: const Color.fromARGB(159, 0, 221, 181),
    ),
  },
  {
    "name": "Health Rating",
    "icon": null,
  },
  {
    "name": "Allergen Alerts",
    "icon": null,
  },
  {
    "name": "Alternative Suggestion",
    "icon": null,
  },
  {
    "name": "Balanced Meal",
    "icon": null,
  },
  {
    "name": "Expiry Alert",
    "icon": null,
  },
  {
    "name": "Scan Mode Settings",
    "icon": null,
  },

  /////////////////////////////////
  {
    "name": "Notification Settings",
    "icon": Image.asset(
      "assets/image/settings/set/notifications.png",
      color: ColorManager.bluePrimary,
      width: 30,
    ),
  },
  {
    "name": "Theme/Appearance",
    "icon": Image.asset(
      "assets/image/settings/set/star.png",
      color: ColorManager.bluePrimary,
      width: 30,
    ),
  },
  {
    "name": "Accuracy",
    "icon": Image.asset(
      "assets/image/settings/set/temperature.png",
      color: ColorManager.bluePrimary,
      width: 30,
    ),
  },
  {
    "name": "Support Languages",
    "icon": Image.asset(
      "assets/image/settings/set/cloud.png",
      color: ColorManager.bluePrimary,
      width: 30,
    ),
  },
  {
    "name": "Storage Management",
    "icon": Image.asset(
      "assets/image/settings/set/bookmark.png",
      color: ColorManager.bluePrimary,
      width: 30,
    ),
  },
  {
    "name": "Purchase History",
    "icon": Image.asset(
      "assets/image/settings/set/money_light.png",
      color: ColorManager.bluePrimary,
      width: 30,
    ),
  },
  {
    "name": "Social Media Integration",
    "icon": Image.asset(
      "assets/image/settings/set/chat.png",
      color: ColorManager.bluePrimary,
      width: 30,
    ),
  },

  {
    "name": "App Updates",
    "icon": Image.asset(
      "assets/image/settings/set/time_atack.png",
      color: ColorManager.bluePrimary,
      width: 30,
    ),
  },
  {
    "name": "Subsctiption mana",
    "icon": Image.asset(
      "assets/image/settings/set/link_duonote.png",
      color: ColorManager.bluePrimary,
      width: 30,
    ),
  },
  {
    "name": "Data usage",
    "icon": Image.asset(
      "assets/image/settings/set/database.png",
      color: ColorManager.bluePrimary,
      width: 30,
    ),
  },
  {
    "name": "Privacy Policy",
    "icon": Image.asset(
      "assets/image/settings/set/privacy.png",
      color: ColorManager.bluePrimary,
      width: 30,
    ),
  },
  {
    "name": "Feedback",
    "icon": Image.asset(
      "assets/image/settings/set/normal.png",
      color: ColorManager.bluePrimary,
      width: 30,
    ),
  },
  {
    "name": "Terms of services",
    "icon": Image.asset(
      "assets/image/settings/set/terms.png",
      color: ColorManager.bluePrimary,
      width: 30,
    ),
  },
  {
    "name": "App version",
    "icon": Image.asset(
      "assets/image/settings/i.png",
      color: ColorManager.bluePrimary,
      width: 30,
    ),
  },

  {
    "name": "Sign Out",
    "icon": Icon(Icons.logout_rounded),
  }
];

final List<Image> profileFirstSection = [
  Image.asset(
    "assets/image/settings/user_box.png",
    width: 30,
    color: const Color.fromARGB(159, 0, 221, 181),
  ),
  Image.asset(
    "assets/image/settings/a.png",
    width: 22,
    color: const Color.fromARGB(159, 0, 221, 181),
  ),
  Image.asset(
    "assets/image/settings/e-mail.png",
    width: 30,
    color: const Color.fromARGB(159, 0, 221, 181),
  ),
  Image.asset(
    "assets/image/settings/water.png",
    width: 30,
    color: const Color.fromARGB(159, 0, 221, 181),
  ),
  Image.asset(
    "assets/image/settings/bubble_fill.png",
    width: 30,
    color: const Color.fromARGB(159, 0, 221, 181),
  ),
];

final List<Image> secondProfileSection = [
  Image.asset(
    "assets/image/settings/notebook.png",
    width: 30,
    color: const Color.fromARGB(159, 0, 221, 181),
  ),
  Image.asset(
    "assets/image/settings/book.png",
    width: 30,
    color: const Color.fromARGB(159, 0, 221, 181),
  ),
  Image.asset(
    "assets/image/settings/home.png",
    width: 30,
    color: const Color.fromARGB(159, 0, 221, 181),
  ),
  Image.asset(
    "assets/image/settings/glass.png",
    width: 30,
    color: const Color.fromARGB(159, 0, 221, 181),
  ),
];

final List<Image> secondProfileSection2 = [
  Image.asset(
    "assets/image/settings/message.png",
    width: 30,
    color: const Color.fromARGB(159, 0, 221, 181),
  ),
  Image.asset(
    "assets/image/settings/i.png",
    width: 30,
    color: const Color.fromARGB(159, 0, 221, 181),
  ),
  Image.asset(
    "assets/image/settings/share.png",
    width: 30,
    color: const Color.fromARGB(159, 0, 221, 181),
  ),
];

final List<Text> selectionList = [
  const Text("My Scans").withStyle(),
  const Text(
    "Cooking Mode",
  ).withStyle(),
  const Text(
    "Family Member",
  ).withStyle(),
  const Text(
    "Health Settings",
  ).withStyle(),
];

final List<Text> selectedList2 = [
  const Text(
    "My Post",
  ).withStyle(),
  const Text(
    "About",
  ).withStyle(),
  const Text(
    "Share App",
  ).withStyle(),
];

final List<String> settingsTitle = [
  "Notification Settings",
  "Theme/Appearance",
  "Accuracy",
  "Supported Languages,",
  "Storage Management",
];

final List<String> settingsIcon1 = [
  "assets/image/settings/set/notifications.png",
  "assets/image/settings/set/star.png",
  "assets/image/settings/set/temperature.png",
  "assets/image/settings/set/cloud.png",
  "assets/image/settings/set/bookmark.png",
];

final List<String> settingsTitle2 = [
  "Purchase History",
  "Social Media Integration",
  "App Updates",
  "Subscription management",
  "Data usage"
];

final List<String> settingsIcon2 = [
  "assets/image/settings/set/money_light.png",
  "assets/image/settings/set/chat.png",
  "assets/image/settings/set/time_atack.png",
  "assets/image/settings/set/link_duonote.png",
  "assets/image/settings/set/database.png",
];

final List<String> settingTitle3 = [
  "Privacy policy",
  "Feedback",
  "Terms of services",
  "App version"
];

final List<String> settingIcon3 = [
  "assets/image/settings/set/privacy.png",
  "assets/image/settings/set/normal.png",
  "assets/image/settings/set/terms.png",
  "assets/image/settings/i.png",
];
