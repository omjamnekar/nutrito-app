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

              if (nutriFact.compareProducts != null) {
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
  final CompareManager compareManager;
  const ComposerComapareSection({super.key, required this.compareManager});

  @override
  Widget build(BuildContext context) {
    final data = compareManager.compareProducts;
    final summary = data?.comparisonSummary;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Product Images
          Row(
            children: [
              Expanded(
                child: _buildImageCard(compareManager.file1),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildImageCard(compareManager.file2),
              ),
            ],
          ),

          const SizedBox(height: 24),

          /// Key Differences
          if (summary?.keyDifferences != null &&
              summary!.keyDifferences!.isNotEmpty) ...[
            const Text("Key Differences",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...summary.keyDifferences!.map((diff) => Card(
                  child: ListTile(
                    leading: Icon(Icons.compare_arrows),
                    title: Text(diff.aspect ?? ""),
                    subtitle: Text(
                      "Product 1: ${diff.product1 ?? "N/A"}\nProduct 2: ${diff.product2 ?? "N/A"}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                )),
            const SizedBox(height: 24),
          ],

          /// Key Similarities
          if (summary?.keySimilarities != null &&
              summary!.keySimilarities!.isNotEmpty) ...[
            const Text("Key Similarities",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...summary.keySimilarities!.map((sim) => Card(
                  child: ListTile(
                    leading:
                        Icon(Icons.check_circle_outline, color: Colors.green),
                    title: Text(sim.aspect ?? ""),
                    subtitle: Text(sim.value ?? "N/A"),
                  ),
                )),
            const SizedBox(height: 24),
          ],

          /// Conclusion
          const Text("Overall Conclusion",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            color: Colors.blue.shade100,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                summary?.overallComparisonConclusion ??
                    "No conclusion available.",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget to show image or placeholder
  Widget _buildImageCard(dynamic file) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            ColorManager.bluePrimary.withOpacity(0.7),
            BlendMode.color,
          ),
          fit: BoxFit.cover,
          image: file != null
              ? FileImage(file)
              : const AssetImage("assets/image/no_image.jpg") as ImageProvider,
        ),
      ),
    );
  }
}
