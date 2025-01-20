import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  void initState() {
    super.initState();
    print("Search Page Initialized");
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
      body: Padding(
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
                    borderSide: BorderSide(color: ColorManager.bluePrimary),
                  ),
                ),
                onChanged: (query) {
                  _searchProducts(query); // Update search as user types
                },
              ),
              Gap(20),
              // Display Suggested Products
              Expanded(
                child: _suggestedProducts.isEmpty
                    ? Center(
                        child: Text("No products found. Try searching again."))
                    : ListView.builder(
                        itemCount: _suggestedProducts.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_suggestedProducts[index]),
                            onTap: () {
                              // Handle product tap (e.g., show product details)
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
