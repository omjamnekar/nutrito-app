import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrito/util/extensions/extensions.dart';
import 'package:nutrito/view/functions/compare.dart';
import 'package:nutrito/view/functions/display/chat.dart';
import 'package:nutrito/view/functions/display/shopping_list.dart';
import 'package:nutrito/view/functions/goal.dart';
import 'package:nutrito/view/options/scanHistory.dart';
import 'package:nutrito/view/settings/pages/goals/ml_model.dart';
import 'package:nutrito/view/settings/pages/profile/healthSetting.dart';
import 'package:nutrito/view/settings/pages/settings/ser_feedback.dart';
import 'package:nutrito/view/settings/user.dart';

class DrawerSection extends StatelessWidget {
  const DrawerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void navigator(Widget appPage) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => appPage,
          ));
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Gap(100),
          ListTile(
            leading: const Icon(Icons.grass).withIconStyle(),
            title: const Text("Nutritional Progress").withHeadStyle(),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: const Divider(
                color: Colors.black87,
              )),
          ListTile(
            leading: const Icon(Icons.library_books_outlined).withIconStyle(),
            title: const Text("My Scans").withHeadStyle(),
            onTap: () => navigator(ScanHistory(
              oncencel: () {},
            )),
          ),
          ListTile(
            leading: const Icon(Icons.playlist_add_outlined).withIconStyle(),
            title: const Text("Custom Meal Plans").withHeadStyle(),
            onTap: () => navigator(ChatScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined).withIconStyle(),
            title: const Text("Family Member").withHeadStyle(),
            onTap: () => navigator(GoalTrackingPage()),
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_left_rounded)
                .withIconStyle(),
            title: const Text("Goal Settings").withHeadStyle(),
            onTap: () => navigator(GoalTrackingPage()),
          ),
          ListTile(
            leading: const Icon(Icons.list).withIconStyle(),
            title: const Text("Current Grocery List").withHeadStyle(),
            onTap: () => navigator(ShoppingListPage()),
          ),
          ListTile(
            leading:
                const Icon(Icons.health_and_safety_outlined).withIconStyle(),
            title: const Text("Health Settings").withHeadStyle(),
            onTap: () => navigator(HealthGuideSettings()),
          ),
          ListTile(
            leading: const Icon(Icons.compare_outlined).withIconStyle(),
            title: const Text("Compared Products").withHeadStyle(),
            onTap: () => navigator(ComaparePage()),
          ),
          ListTile(
            leading:
                const Icon(Icons.settings_applications_sharp).withIconStyle(),
            title: const Text("Settings").withHeadStyle(),
            onTap: () => navigator(SettingsPage()),
          ),
          ListTile(
            leading: const Icon(Icons.g_mobiledata).withIconStyle(),
            title: const Text("Gen Model").withHeadStyle(),
            onTap: () => navigator(MLModelShowcase()),
          ),
          ListTile(
            leading: const Icon(Icons.water_drop_outlined),
            title: const Text("Meal/Water\nReminders").withHeadStyle(),
            onTap: () => navigator(GoalTrackingPage()),
          ),
          ListTile(
            leading: const Icon(Icons.question_answer_outlined).withIconStyle(),
            title: const Text("FAQs").withHeadStyle(),
            onTap: () => navigator(FeedbackPage()),
          ),
          const Gap(40),
          Container(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            alignment: Alignment.bottomLeft,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("WeebHub"),
                Text("version 1.0.0"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
