import 'package:flutter/material.dart';

class OpenerCamera extends StatefulWidget {
  Function(int) onTapOfnavigation;

  OpenerCamera({super.key, required this.onTapOfnavigation});

  @override
  State<OpenerCamera> createState() => _OpenerCameraState();
}

class _OpenerCameraState extends State<OpenerCamera> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: -60,
        left: 0,
        right: 0,
        child: Center(
          child: Container(
            width: 230,
            height: 230,
            decoration: BoxDecoration(
                color: const Color.fromARGB(155, 42, 42, 42),
                borderRadius: BorderRadius.circular(130)),
            padding: const EdgeInsets.only(bottom: 10),
            child: Stack(
              children: [
                Positioned(
                  top: 18,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      widget.onTapOfnavigation(1);
                    },
                    child: Center(
                      child: Image.asset(
                        "assets/image/home/nutrilization.png",
                        color: Colors.white,
                        width: 60,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -50,
                  right: 22,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      widget.onTapOfnavigation(2);
                    },
                    child: Center(
                      child: Image.asset(
                        "assets/image/home/compare.png",
                        color: Colors.white,
                        width: 60,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -50,
                  left: 20,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      widget.onTapOfnavigation(3);
                    },
                    child: Center(
                      child: Image.asset(
                        "assets/image/home/suggestion.png",
                        color: Colors.white,
                        width: 60,
                        height: 100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
