import 'package:flutter/material.dart';
import 'package:nutrito/util/extensions/extensions.dart';

class ScancSection extends StatefulWidget {
  const ScancSection({super.key});

  @override
  State<ScancSection> createState() => _ScancSectionState();
}

class _ScancSectionState extends State<ScancSection> {
  String _seletedOption = "A-F";
  final List<String> _itemsOption = ["A-F", "A-r", "A-s", "A-c"];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 540,
      margin: const EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 500),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          // Bottom Shadow
          BoxShadow(
            color: const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3), // Downward shadow
          ),
          // Top Shadow
          BoxShadow(
            color: const Color.fromARGB(70, 219, 219, 219).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, -3), // Upward shadow
          ),
        ],
      ),
      child: SizedBox(
        height: 540,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                title: const Text("Health Rating").withStyle(),
                trailing: Container(
                  height: 40,
                  padding: const EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(59, 185, 185, 185)
                            .withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
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
              ListTile(
                title: const Text("Allergen Alerts").withStyle(),
                trailing: const SwitchHandler(),
              ),
              ListTile(
                title: const Text("Alternative Suggestion").withStyle(),
                trailing: const SwitchHandler(),
              ),
              ListTile(
                title: const Text("Balanced Meal").withStyle(),
                trailing: const SwitchHandler(),
              ),
              ListTile(
                title: const Text("Expiry Alart").withStyle(),
                trailing: const SwitchHandler(),
              ),
              ListTile(
                title: const Text("Scan Mode Settings").withStyle(),
                trailing: Container(
                  height: 40,
                  padding: const EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(59, 185, 185, 185)
                            .withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class SwitchHandler extends StatefulWidget {
  const SwitchHandler({super.key});

  @override
  State<SwitchHandler> createState() => _SwitchHandlerState();
}

class _SwitchHandlerState extends State<SwitchHandler> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeTrackColor: const Color.fromARGB(197, 172, 246, 235),
      overlayColor:
          const WidgetStatePropertyAll(Color.fromARGB(197, 223, 255, 249)),
      activeColor: const Color.fromARGB(197, 0, 221, 181),
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}
