import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrito/util/extensions/extensions.dart';

class DrawerSection extends StatelessWidget {
  const DrawerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
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
        ),
        ListTile(
          leading: const Icon(Icons.playlist_add_outlined).withIconStyle(),
          title: const Text("Custom Meal Plans").withHeadStyle(),
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined).withIconStyle(),
          title: const Text("Family Member").withHeadStyle(),
        ),
        ListTile(
          leading:
              const Icon(Icons.keyboard_double_arrow_left_rounded).withIconStyle(),
          title: const Text("Goal Settings").withHeadStyle(),
        ),
        ListTile(
          leading: const Icon(Icons.list).withIconStyle(),
          title: const Text("Current Grocery List").withHeadStyle(),
        ),
        ListTile(
          leading: const Icon(Icons.health_and_safety_outlined).withIconStyle(),
          title: const Text("Health Settings").withHeadStyle(),
        ),
        ListTile(
          leading: const Icon(Icons.health_and_safety_outlined).withIconStyle(),
          title: const Text("Health Settings").withHeadStyle(),
        ),
        ListTile(
          leading: const Icon(Icons.compare_outlined).withIconStyle(),
          title: const Text("Compared Products").withHeadStyle(),
        ),
        ListTile(
          leading: const Icon(Icons.settings_applications_sharp).withIconStyle(),
          title: const Text("Settings").withHeadStyle(),
        ),
        ListTile(
          leading: const Icon(Icons.g_mobiledata).withIconStyle(),
          title: const Text("Gen Model").withHeadStyle(),
        ),
        ListTile(
          leading: const Icon(Icons.water_drop_outlined),
          title: const Text("Meal/Water\nReminders").withHeadStyle(),
        ),
        ListTile(
          leading: const Icon(Icons.question_answer_outlined).withIconStyle(),
          title: const Text("FAQs").withHeadStyle(),
        ),
        const Gap(20),
        Container(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          alignment: Alignment.centerLeft,
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
    );
  }
}
