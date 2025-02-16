import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/data/model/gen/compare/compare.dart';
import 'package:nutrito/network/provider/compare.dart';
import 'package:nutrito/util/theme/color.dart';

class ComOutPage extends ConsumerStatefulWidget {
  const ComOutPage({
    super.key,
  });

  @override
  ConsumerState<ComOutPage> createState() => _NutriOutPageState();
}

class _NutriOutPageState extends ConsumerState<ComOutPage> {
  Widget widgettoShow = SizedBox(
    width: 90,
    height: 90,
    child: Center(child: CircularProgressIndicator()),
  );

  @override
  Widget build(BuildContext context) {
    final comparedProvider =
        ref.watch(compareCurrntProvider.notifier).getState();

    return Scaffold(
      appBar: AppBar(
        title: Text("Compared Detail"),
        actions: [
          TextButton.icon(
              iconAlignment: IconAlignment.end,
              onPressed: () {},
              label: Text("Share"),
              icon: Icon(
                Icons.photo_size_select_actual_outlined,
              ))
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Future.value(
            comparedProvider.compareManager,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return widgettoShow;
            } else if (snapshot.connectionState == ConnectionState.none) {
              return widgettoShow;
            } else if (snapshot.connectionState == ConnectionState.done) {
              final nutriFact = snapshot.data;
              print(jsonEncode(nutriFact!.compareProducts));

              if (nutriFact != null && nutriFact.compareProducts != null) {
                return ComposerComapareSection(
                  compareManager: nutriFact,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            } else {
              return widgettoShow;
            }
          },
        ),
      ),
    );
  }
}

class ComposerComapareSection extends StatelessWidget {
  CompareManager compareManager;
  ComposerComapareSection({super.key, required this.compareManager});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 200,
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                              ColorManager.bluePrimary.withOpacity(0.8),
                              BlendMode.color,
                            ),
                            fit: BoxFit.cover,
                            image: compareManager.file1 != null
                                ? FileImage(compareManager.file1!)
                                : AssetImage("assets/image/no_image.jpg"))),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                              ColorManager.bluePrimary.withOpacity(0.8),
                              BlendMode.color,
                            ),
                            fit: BoxFit.cover,
                            image: compareManager.file2 != null
                                ? FileImage(compareManager.file2!)
                                : AssetImage("assets/image/no_image.jpg"))),
                  ),
                ),
              ],
            ),
          ),

          //////////////////////////////////////////

          Text(compareManager.compareProducts?.toJson().toString() ?? ""),

          Text("Key Similarities",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...compareManager.compareProducts?.comparisonSummary?.keySimilarities
                  ?.map((similarity) => ListTile(
                        title: Text(similarity.aspect ?? ""),
                        subtitle: Text(similarity.value ?? "s"),
                      )) ??
              [],
          SizedBox(height: 16),
          Text("Overall Conclusion",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Card(
            color: Colors.blueAccent.shade100,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                compareManager.compareProducts?.comparisonSummary
                        ?.overallComparisonConclusion ??
                    "",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}
