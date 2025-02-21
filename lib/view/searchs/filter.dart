import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrito/util/theme/color.dart';

Future<void> filter(
    BuildContext context, Function(List<String> filterOption) onSelected) async {
  List<String> nutritionalFoodTypes = [
    "Protein-Based Foods",
    "Vitamins & Supplements",
    "Functional Beverages",
    "Meal Replacements",
    "Organic & Natural Foods",
    "Healthy Snacks",
    "Fortified Foods",
    "Low-Calorie & Diet Foods",
    "Sports Nutrition"
  ];

  List<IconData> foodTypeIcons = [
    Icons.fitness_center,
    Icons.local_pharmacy,
    Icons.local_drink,
    Icons.fastfood,
    Icons.eco,
    Icons.restaurant,
    Icons.local_dining,
    Icons.no_food,
    Icons.sports,
  ];
  List<String> selectedElement = ["", "", "", "", "", "", "", "", ""];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Filter'),
            content: Container(
              width: double.maxFinite,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedElement[index] ==
                            nutritionalFoodTypes[index]) {
                          selectedElement[index] = "";
                        } else {
                          selectedElement[index] = nutritionalFoodTypes[index];
                        }
                      });
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: selectedElement[index] ==
                                        nutritionalFoodTypes[index]
                                    ? ColorManager.bluePrimary
                                    : Color.fromARGB(255, 216, 216, 216))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(foodTypeIcons[index]),
                            Text(
                              '${nutritionalFoodTypes[index]}',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: nutritionalFoodTypes.length, // 2 rows * 3 columns
                shrinkWrap: true,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Clear'),
                onPressed: () {
                  onSelected([]);

                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Ok'),
                onPressed: () async {
                await  onSelected(selectedElement
                      .where((element) => element.isNotEmpty)
                      .toList());
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    },
  );
}
