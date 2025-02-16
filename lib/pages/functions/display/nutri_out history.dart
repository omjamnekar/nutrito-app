import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/data/model/gen/conclusion_pr.dart';
import 'package:nutrito/data/model/gen/initial_pr.dart';
import 'package:nutrito/data/model/gen/nutri_com_state.dart';
import 'package:nutrito/data/model/gen/ratio_pr.dart';

import 'package:nutrito/network/provider/nutrilization.dart';
import 'package:nutrito/pages/settings/components/graphs/circle_graph.dart';
import 'package:nutrito/util/theme/color.dart';

class NutriOutPageHistory extends ConsumerStatefulWidget {
  NutriComState nutristate;

  NutriOutPageHistory({required this.nutristate}) : super();

  @override
  ConsumerState<NutriOutPageHistory> createState() =>
      _NutriOutPageHistoryState();
}

class _NutriOutPageHistoryState extends ConsumerState<NutriOutPageHistory>
    with TickerProviderStateMixin {
  Widget loadingWidget = const Center(child: CircularProgressIndicator());

  TabController? tabController;
  TabController? healthController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    healthController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final nutritionalProvider = widget.nutristate;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nutrition Details"),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              child: Text("Nutritional"),
            ),
            Tab(
              child: Text("HealthCare"),
            ),
            Tab(
              child: Text("Ratio"),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: FutureBuilder(
            future: Future.value(nutritionalProvider.genNutrilizationResponse),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return loadingWidget;
              } else if (snapshot.connectionState == ConnectionState.done) {
                final nutriFact = snapshot.data;

                // Extracting initialData
                final initialData =
                    nutriFact?.initialPromptManager!.initialData;
                final healthData = nutriFact?.healthPromptManager
                    ?.healthConsideration?.healthConsiderations;

                final ratioData = nutriFact?.ratioPromptManager!.ratioSpecified;
                final conclusionData =
                    nutriFact?.conclusionPromptManger!.conclusionData;

                if (initialData == null) {
                  return const Center(child: Text("No data available"));
                }

                debugPrint(
                    nutriFact?.initialPromptManager?.toJson().toString());
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: [
                      IntitalDataSection(
                        initialData: initialData,
                        conclusionData: conclusionData!,
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Health Considerations",
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromARGB(255, 3, 160, 132),
                              ),
                            ),
                          ),
                          Gap(15),
                          Expanded(
                              child: ListView.builder(
                            itemCount: healthData?.length ?? 0,
                            itemBuilder: (context, index) {
                              final item = healthData![index];
                              return Card(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 3,
                                            child: Text(
                                              item.ingredient ?? "",
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 15,
                                              color: const Color.fromARGB(
                                                  221, 30, 30, 30),
                                            ),
                                          )
                                        ],
                                      ),
                                      Gap(10),
                                      Text("Positive:",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: const Color.fromARGB(
                                                  221, 2, 121, 71))),
                                      ...(item.positive ?? [])
                                          .map((pos) => Text("+ $pos")),
                                      Text(
                                        "Negative:",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: const Color.fromARGB(
                                                221, 255, 122, 95)),
                                      ),
                                      ...(item.negative ?? [])
                                          .map((neg) => Text("- $neg")),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ))
                        ],
                      ),
                      RatioSection(ratioSpecified: ratioData!)
                    ],
                  ),
                );
              } else {
                return const Center(child: Text("Error fetching data"));
              }
            },
          ),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           "Nutrilized Report",
    //           style: GoogleFonts.poppins(),
    //         ),
    //         Text("peoduct name"),
    //       ],
    //     ),
    //   ),
    //   body: SafeArea(
    //     child: Container(
    //       padding: EdgeInsets.all(10),
    //       child: Column(
    //         children: [
    //           Container(
    //             height: 200,
    //             child: Row(
    //               children: [
    //                 Flexible(
    //                     flex: 1,
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                           color: ColorManager.bluePrimary,
    //                           borderRadius: BorderRadius.circular(20)),
    //                     )),
    //                 Gap(10),
    //                 Flexible(
    //                   flex: 1,
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                       color: ColorManager.bluePrimary,
    //                       borderRadius: BorderRadius.circular(20),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Gap(10),
    //           Container(
    //             height: 200,
    //             child: Row(
    //               children: [
    //                 Flexible(
    //                     flex: 1,
    //                     child: WaveWidget(
    //                       config: CustomConfig(
    //                         gradients: [
    //                           [
    //                             ColorManager.bluePrimary,
    //                             const Color.fromARGB(255, 158, 255, 237)
    //                           ],
    //                           [
    //                             ColorManager.bluePrimary,
    //                             const Color.fromARGB(255, 158, 255, 237)
    //                           ],
    //                         ],
    //                         durations: [5000, 3440],
    //                         heightPercentages: [0.20, 0.23],
    //                         blur: MaskFilter.blur(BlurStyle.solid, 10),
    //                         gradientBegin: Alignment.bottomLeft,
    //                         gradientEnd: Alignment.topRight,
    //                       ),
    //                       waveAmplitude: 0,
    //                       size: Size(double.infinity, double.infinity),
    //                     )),
    //                 Gap(10),
    //                 Flexible(
    //                   flex: 3,
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                       // color: ColorManager.bluePrimary,
    //                       border: Border.all(
    //                           color: ColorManager.bluePrimary, width: 2),
    //                       borderRadius: BorderRadius.circular(20),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  // Section Title Widget
}

class IntitalDataSection extends ConsumerWidget {
  InitialData initialData;
  ConclusionData conclusionData;
  IntitalDataSection(
      {super.key, required this.initialData, required this.conclusionData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nutristate = ref.read(nutrilizationCrrntProvider.notifier).getState();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (nutristate.fileImage != null)
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(
                    nutristate.fileImage ?? File(""),
                  ),
                  colorFilter: ColorFilter.mode(
                    ColorManager.bluePrimary.withOpacity(0.8),
                    BlendMode.color,
                  ),
                  fit: BoxFit.cover,
                ),
                color: ColorManager.bluePrimary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorManager.bluePrimary,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 200,
            ),
          Gap(10),
          SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 1,
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorManager.bluePrimary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name"),
                          Text(
                            initialData.name?.toString() ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.poppins(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Text(
                            initialData.dietaryInformation ??
                                initialData.usageInstructions ??
                                initialData.countryOfOrigin ??
                                initialData.additionalInformation ??
                                "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    )),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: ColorManager.bluePrimary,
                    ),
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: HealthScoreGraph(
                          title: "Overall Health\nRating",
                          percentage: double.parse(
                                  conclusionData.overallHealthRating ?? "0.0") *
                              10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: ColorManager.bluePrimary),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/image/gen/gen-logo.png",
                      width: 20,
                      color: ColorManager.bluePrimary,
                    ),
                    Gap(5),
                    Text("Gen AI suggestion"),
                  ],
                ),
                Gap(20),
                AnimatedTextKit(
                  repeatForever: false,
                  totalRepeatCount: 1,
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      conclusionData.conclusion.toString(),
                      speed: const Duration(milliseconds: 50),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Gap(20),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recommendations:",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(conclusionData.recommendations?.toString() ??
                            "N/A"),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Serving\nsize:",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          conclusionData.servingSize?.toString() ?? "N/A",
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 251, 199, 199),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Allergens:",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(conclusionData.allergenInformation?.toString() ?? "N/A"),
              ],
            ),
          ),

          Gap(20),
          _buildSectionTitle("Product Details"),
          _buildInfoRow(" Name", initialData.name ?? "N/A"),
          _buildInfoRow("Allergens", initialData.allergenInformation ?? "N/A"),
          _buildInfoRow("Barcode", initialData.barcode ?? "N/A"),
          _buildInfoRow(
              "Country of Origin", initialData.countryOfOrigin ?? "N/A"),
          _buildInfoRow("Certifications",
              initialData.certifications?.join(", ") ?? "None"),
          _buildInfoRow(
              "Dietary Info", initialData.dietaryInformation ?? "N/A"),
          _buildInfoRow("Expiry Date", initialData.expiryDate ?? "N/A"),

          _buildInfoRow(
              "Additional Info", initialData.additionalInformation ?? "N/A"),

          const SizedBox(height: 20),

          // Ingredients List
          _buildSectionTitle("Ingredients"),

          SizedBox(
            height: (initialData.ingredients?.length ?? 0) * 80,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: initialData.ingredients?.length ?? 0,
              itemBuilder: (context, index) {
                final ingredient = initialData.ingredients![index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text((index + 1).toString()),
                  ),
                  title: Text(ingredient.name ?? ""),
                  subtitle: Text(ingredient.quantity ?? "Quantity: N/A"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Key-Value Row Widget
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Flexible(child: Text(value, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}

class RatioSection extends StatelessWidget {
  RatioSpecified ratioSpecified;
  RatioSection({super.key, required this.ratioSpecified});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ingredient Analysis",
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: const Color.fromARGB(255, 0, 145, 119),
            ),
          ),
          Gap(10),
          Container(
            height: (ratioSpecified.ingredientAnalysis?.length ?? 0) * 105,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color.fromARGB(43, 0, 0, 0),
              ),
            ),
            child: Scrollbar(
              child: ListView.builder(
                itemCount: ratioSpecified.ingredientAnalysis?.length ?? 0,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = ratioSpecified.ingredientAnalysis?[index] ??
                      IngredientAnalysis(
                          ingredient: "", comment: "", healthRating: 0);
                  return Container(
                    height: 100,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.ingredient ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.ubuntu(
                                  height: 1,
                                  fontSize: 20,
                                  color:
                                      const Color.fromARGB(255, 118, 203, 165),
                                ),
                              ),
                              Text(
                                item.comment ?? "",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: 90,
                            height: 80,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorManager.bluePrimary,
                            ),
                            child: Center(
                                child: Text(
                              "${item.healthRating}/10",
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Gap(20),
          Text(
            "NutritionalAnalysis",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          Gap(20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Component",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(137, 0, 0, 0),
                        fontSize: 15),
                  ),
                ),
                Spacer(),
                Container(
                  child: Text(
                    "Feedback\nRatio",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(137, 0, 0, 0),
                        fontSize: 15),
                  ),
                ),
                Container(
                  width: 100,
                  child: Text(
                    "Qty.",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(137, 0, 0, 0),
                        fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          Builder(
            builder: (context) {
              final data = ratioSpecified.nutritionalAnalysis!.metrics;
              final nutriAn = data?.entries.map((entry) {
                    return [
                      entry.key,
                      entry.value.feedbackRatio,
                      entry.value.value
                    ];
                  }).toList() ??
                  [];
              return Container(
                height: (nutriAn.length) * 70,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: nutriAn.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(5),
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            nutriAn[index][0].toString(),
                          ),
                          Spacer(),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10),
                            width: 50 +
                                double.parse(nutriAn[index][1].toString()) * 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber[200],
                            ),
                            child: Text(
                              "${nutriAn[index][1].toString()}-10",
                              style: GoogleFonts.poppins(fontSize: 15),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 100,
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              nutriAn[index][2].toString(),
                              textAlign: TextAlign.right,
                              style: GoogleFonts.poppins(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Gap(10),
        ],
      ),
    );
  }
}
