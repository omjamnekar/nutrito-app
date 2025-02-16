import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/data/model/gen/alternative/alternative.dart';
import 'package:nutrito/network/controller/alternative.dart';
import 'package:nutrito/util/theme/color.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _globalKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  String _selectedCategory = "Vitamins"; // Default category
  final List<String> _categories = [
    "Vitamins",
    "Minerals",
    "Nutrients",
    "Fats",
    "Proteins"
  ];
  List<String> _suggestedProducts = [];

  void _searchProducts(String query) {
    // Simulate a search and filter by category (replace with actual logic)
    setState(() {
      _suggestedProducts = _getSuggestedProducts(query, _selectedCategory);
    });
  }

  List<String> _getSuggestedProducts(String query, String category) {
    // Sample logic to simulate products based on the search query and category
    List<String> products = [
      "Vitamin C Supplement",
      "Vitamin D Supplement",
      "Mineral Supplement",
      "Protein Shake",
      "Fat Burner",
      "Multivitamins"
    ];

    return products.where((product) {
      return product.toLowerCase().contains(query.toLowerCase()) &&
          product.toLowerCase().contains(category.toLowerCase());
    }).toList();
  }

  List<AlthernativeModel> dataMap = [];
  AlternativeController alternativeController =
      AlternativeController(product: "", data: "");

  @override
  void initState() {
    super.initState();
    setup();
  }

  void setup() async {
    await alternativeController.fullRamdom();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Nutritional Products")),
      body: GetBuilder(
          init: alternativeController,
          builder: (ctrl) {
            ctrl.fullRamdom();
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _globalKey,
                child: Column(
                  children: [
                    // Search Title

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FilterChip(
                          label: Text("Filter"),
                          selected: false,
                          onSelected: (bool selected) {},
                        ),
                        DropdownButton<String>(
                          value: _selectedCategory,
                          onChanged: (String? newCategory) {
                            setState(() {
                              _selectedCategory = newCategory!;
                              _searchProducts(_textEditingController
                                  .text); // Update search results
                            });
                          },
                          items: _categories.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Gap(10),
                    // Search Input Field
                    TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: "Search for a food product...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: ColorManager.bluePrimary),
                        ),
                      ),
                      onChanged: (query) {
                        if (query.isEmpty) {
                          ctrl.fullRamdom();
                        }
                        ctrl.searchBycharacter(query);
                      },
                    ),
                    Gap(20),
                    // Display Suggested Products
                    Expanded(
                      child: Obx(() {
                        if (ctrl.alternativeList.isEmpty) {
                          return Center(child: CircularProgressIndicator());
                        }

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: ctrl.alternativeList.length,
                          itemBuilder: (context, index) {
                            final item = ctrl.alternativeList[index];

                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(137, 0, 221, 181),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Container(
                                      width: double.maxFinite,
                                      child: Image.network(
                                        item.imageUrl ?? "",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Container(
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color.fromARGB(
                                            255, 176, 255, 240),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  flex: 8,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Gap(5),
                                                      Text(
                                                        item.name ?? "",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 18),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Text(
                                                        item.companyName ?? "",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 4, 144, 118),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 6),
                                                    child: Icon(
                                                      Icons
                                                          .shopping_cart_outlined,
                                                      size: 23,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              203,
                                                              203,
                                                              203),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Gap(5),
                                            Row(
                                              children: [
                                                Flexible(
                                                  flex: 7,
                                                  child: Text(
                                                    item.healthBenefits
                                                            ?.join('. ') ??
                                                        "",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                ),
                                                Gap(5),
                                                Flexible(
                                                  flex: 3,
                                                  child: Container(
                                                    height: 34,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.white,
                                                    ),
                                                    child: TextButton(
                                                      onPressed: () {},
                                                      child: Text("See"),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
