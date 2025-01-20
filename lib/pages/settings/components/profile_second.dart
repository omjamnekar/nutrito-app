import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/util/data/settings.dart';

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
        color: Colors.white,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
