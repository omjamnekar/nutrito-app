import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/pages/functions/components/product_card.dart';
import 'package:nutrito/util/data/image_data.dart';
import 'package:nutrito/util/data/product_image.dart';
import 'package:nutrito/util/data/veggie_image.dart';
import 'package:nutrito/util/extensions/extensions.dart';
import 'package:nutrito/util/theme/color.dart';

class SmartListPage extends StatefulWidget {
  const SmartListPage({super.key});

  @override
  State<SmartListPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SmartListPage> {
  @override
  Widget build(BuildContext context) {
    return ShoppingListScreen();
  }
}

class ShoppingListScreen extends StatefulWidget {
  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _textEditingController = TextEditingController();
  bool isSearched = false;
  @override
  void initState() {
    super.initState();
    _initLoadData();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 231, 231, 231),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                controller: _tabController,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                labelColor: ColorManager.bluePrimary,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.shopping_cart_outlined),
                    child: Text("Shopping List"),
                  ),
                  Tab(
                    icon: Icon(Icons.calendar_month),
                    child: Text("Meal Planner"),
                  ),
                ],
              ),
            ),
            Container(
              height: 1150,
              child: TabBarView(
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: const [
                  SmartShoppingSection(),
                  SmartShoppingSection(),
                ],
              ),
            ),
            Text("Options:"),
            Container(
              width: MediaQuery.of(context).size.width,
              height: allItems.length * 70 + 10,
              child: ListView.builder(
                // padding: EdgeInsets.only(bottom: 50),
                physics: NeverScrollableScrollPhysics(),
                itemCount: allItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 70,
                    child: ListTile(
                      leading: Image.asset(allItems[index]["imageurl"]),
                      title: Text(allItems[index]["name"]),
                      trailing: IconButton(
                        onPressed: () {
                          _selectedAddOperation(index);
                        },
                        icon: Icon(Icons.add_box_outlined),
                      ),
                    ),
                  );
                },
              ),
            ),
            Gap(20),
          ],
        ),
      ),
      bottomSheet: showBottomAddOption
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: 210,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 101, 255, 224),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                showBottomAddOption = false;
                              });
                            },
                            icon: Icon(
                              Icons.cancel,
                              size: 25,
                            ))
                      ],
                    ),
                    ListTile(
                      leading: Image.asset(allItems[selectedIndex]["imageurl"]),
                      title: Text(
                        allItems[selectedIndex]["name"],
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        allItems[selectedIndex]["description"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Add To List",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: isSearched ? 250 : 80,
              child: Column(
                children: [
                  isSearched
                      ? Flexible(
                          flex: 8,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, -3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ListView.builder(
                              itemCount: shoppingItems.length,
                              itemBuilder: (context, index) {
                                int quantity = 0;
                                return ListTile(
                                  style: ListTileStyle.list,
                                  leading: Image.asset(
                                    shoppingItems[index]["imageurl"],
                                    width: 30,
                                    height: 30,
                                  ),
                                  title: Text(shoppingItems[index]["name"]),
                                  trailing: Container(
                                    width: 180,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            setState(() {
                                              if (quantity > 1) {
                                                quantity--;
                                              }
                                            });
                                          },
                                        ),
                                        Text(
                                          quantity.toString(),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            setState(() {
                                              quantity++;
                                            });
                                          },
                                        ),
                                        Gap(20),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.add,
                                            color: ColorManager.bluePrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Flexible(flex: 0, child: Container()),
                  Row(
                    children: [
                      Flexible(
                          flex: 7,
                          child: TextField(
                            controller: _textEditingController,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                _onSearchTextChange(value);
                                setState(() {
                                  isSearched = true;
                                });
                              } else {
                                setState(() {
                                  isSearched = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "I need ...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          )),
                      Gap(10),
                      Flexible(
                          flex: 1,
                          child: Container(
                            width: 70,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorManager.greenPrimary,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  List<Map<String, dynamic>> allItems = [];
  bool showBottomAddOption = false;
  int selectedIndex = 0;
  _selectedAddOperation(int index) {
    setState(() {
      selectedIndex = index;
      showBottomAddOption = true;
    });
  }

  _initLoadData() {
    allItems.clear();
    allItems.addAll(veggies);
    allItems.addAll(fruits);
    allItems.addAll(products);
    allItems.shuffle();
  }

  List<Map<String, dynamic>> shoppingItems = [];

  void _onSearchTextChange(String name) {
    final selectedData = allItems
        .where((e) =>
            e["name"].toString().toLowerCase().contains(name.toLowerCase()))
        .toList();

    setState(() {
      shoppingItems = selectedData;
    });
  }
}

class SmartShoppingSection extends StatefulWidget {
  const SmartShoppingSection({super.key});

  @override
  State<SmartShoppingSection> createState() => _SmartShoppingSectionState();
}

class _SmartShoppingSectionState extends State<SmartShoppingSection> {
  final List<Map<String, dynamic>> shoppingItems = fruits;
  String selectedData = "Shopping List";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            //selected Items

            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                children: [
                  DropdownButton(
                      value: selectedData,
                      items: ["Shopping List", "Gen List"].map(
                        (e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedData = value ?? "";
                        });
                      }),
                  Spacer(),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share_outlined,
                            size: 25,
                          )),
                      Gap(10),
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit_calendar_outlined,
                            size: 25,
                          ),
                          label: Text("Lastest"))
                    ],
                  )
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Text("Last added").withHeadStyle(),
                  Icon(Icons.keyboard_arrow_down_rounded),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete_outline,
                        size: 25,
                        color: const Color.fromARGB(221, 122, 121, 121),
                      ))
                ],
              ),
            ),

            Container(
              height: 450,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return ShoppingItemCard(
                    asset: shoppingItems[index]["imageurl"]!,
                    name: shoppingItems[index]['name']!,
                    quantity: "1kg",
                  );
                },
              ),
            ),

            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 60,
            //   decoration: BoxDecoration(
            //     color: const Color.fromARGB(255, 0, 42, 34),
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   child: TextButton(
            //     onPressed: () {},
            //     child: Text(
            //       "Set Shopping List",
            //       style: GoogleFonts.poppins(
            //         color: Colors.white,
            //         fontSize: 20,
            //       ),
            //     ),
            //   ),
            // ),

            Container(
              padding: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Text("Last used").withHeadStyle(),
                  Icon(Icons.keyboard_arrow_down_rounded),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete_outline,
                        size: 25,
                        color: const Color.fromARGB(221, 122, 121, 121),
                      ))
                ],
              ),
            ),
            Container(
              height: 500,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return ShoppingItemCard(
                    asset: veggies[index]["imageurl"]!,
                    name: veggies[index]['name']!,
                    quantity: "1kg",
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
