import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/data/model/gen/smart/com_smart.dart';
import 'package:nutrito/data/model/gen/smart/shopping.dart';
import 'package:nutrito/data/storage/smart.dart';
import 'package:nutrito/network/provider/smartList.dart';
import 'package:nutrito/view/functions/components/genChat.dart';
import 'package:nutrito/view/functions/components/product_card.dart';
import 'package:nutrito/view/functions/display/shopping_list.dart';
import 'package:nutrito/util/data/fruit_image.dart';
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

class ShoppingListScreen extends ConsumerStatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  ConsumerState<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends ConsumerState<ShoppingListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _textEditingController = TextEditingController();

  bool closeBottomSearchBar = false;
  bool isSearched = false;
  @override
  void initState() {
    super.initState();
    _initLoadData();
    _tabController = TabController(length: 1, vsync: this);
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShoppingListPage(),
                    ));
              },
              icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SmartShoppingSection(
              isGenOpen: (p0) {
                print(p0);
                setState(() {
                  closeBottomSearchBar = p0;
                });
              },
            ),
            Gap(20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                "Options:",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Gap(20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: allItems.length * 70 + 10,
              child: ListView.builder(
                // padding: EdgeInsets.only(bottom: 50),
                physics: NeverScrollableScrollPhysics(),
                itemCount: allItems.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 70,
                    child: ListTile(
                      leading: Image.asset(allItems[index].imageUrl!),
                      title: Text(allItems[index].name!),
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
      bottomSheet: !closeBottomSearchBar
          ? showBottomAddOption
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 230,
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
                          leading:
                              Image.asset(allItems[selectedIndex].imageUrl!),
                          title: Text(
                            allItems[selectedIndex].name!,
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            allItems[selectedIndex].description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Gap(10),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black87,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    final state = ref.watch(cartlistPovider);
                                    if (!state.any(
                                      (e) =>
                                          e.name ==
                                          allItems[selectedIndex].name,
                                    )) {
                                      // Add the item to the cart if it doesn't exist
                                      ref
                                          .read(cartlistPovider.notifier)
                                          .setState(allItems[selectedIndex]);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "item is already there in cart")));
                                    }
                                    setState(() {});
                                  },
                                  child: Text(
                                    "Add To OptionList",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            Gap(10),
                            Flexible(
                              flex: 1,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    final state = ref.watch(smartlistProvider);
                                    if (!state.any(
                                      (e) =>
                                          e.name ==
                                          allItems[selectedIndex].name,
                                    )) {
                                      ref
                                          .read(smartlistProvider.notifier)
                                          .setState(allItems[selectedIndex]);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "item is already there in smart list")));
                                    }

                                    setState(() {});
                                  },
                                  child: Text(
                                    "Add To SmartList",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
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
                                        shoppingItems[index].imageUrl!,
                                        width: 30,
                                        height: 30,
                                      ),
                                      title: Text(shoppingItems[index].name!),
                                      trailing: SizedBox(
                                        width: 180,
                                        child: Row(
                                          children: [
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
                )
          : null,
    );
  }

  List<ShoppingItemManager> allItems = [];
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
    allItems.addAll(veggies
        .map(
          (e) => ShoppingItemManager.fromJson(e),
        )
        .toList());
    allItems.addAll(fruits
        .map(
          (e) => ShoppingItemManager.fromJson(e),
        )
        .toList());
    allItems.addAll(products
        .map(
          (e) => ShoppingItemManager.fromJson(e),
        )
        .toList());
    allItems.shuffle();
  }

  List<ShoppingItemManager> shoppingItems = [];

  void _onSearchTextChange(String name) {
    final selectedData = allItems
        .where(
            (e) => e.name.toString().toLowerCase().contains(name.toLowerCase()))
        .toList();

    setState(() {
      shoppingItems = selectedData;
    });
  }
}

class SmartShoppingSection extends ConsumerStatefulWidget {
  Function(bool) isGenOpen;
  SmartShoppingSection({super.key, required this.isGenOpen});

  @override
  ConsumerState<SmartShoppingSection> createState() =>
      _SmartShoppingSectionState();
}

class _SmartShoppingSectionState extends ConsumerState<SmartShoppingSection> {
  String selectedData = "Shopping List";
  final TextEditingController _chatController = TextEditingController();
  bool isGenSelected = false;
  bool isGenProcessing = false;
  List<ShoppingItemManager> allItems = [];
  List<ShoppingItemManager> smartItems = [];

  List<ShoppingItemManager> cartItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // fruits
    //veggies
    //products
    allItems.addAll(fruits
        .map(
          (e) => ShoppingItemManager.fromJson(e),
        )
        .toList());
    allItems.addAll(veggies
        .map(
          (e) => ShoppingItemManager.fromJson(e),
        )
        .toList());
    allItems.addAll(products
        .map(
          (e) => ShoppingItemManager.fromJson(e),
        )
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    final smartItems = ref.watch(smartlistProvider);
    final cartItems = ref.watch(cartlistPovider);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            //selected Items

            SizedBox(
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
                          if (value == "Shopping List") {
                            isGenSelected = false;
                          } else {
                            isGenSelected = true;
                          }

                          widget.isGenOpen(isGenSelected);
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
                          onPressed: () {
                            _openCalender();
                          },
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
            Gap(10),
            isGenSelected
                ? Column(
                    children: [
                      ChatSection(
                        dataOnClick: (p0) => setShoppingList(p0, []),
                      ),
                      Gap(10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 42, 34),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () =>
                              setShoppingList(smartItems, cartItems),
                          child: Text(
                            "Set Shopping List",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                          height: 450,
                          child: smartItems.isNotEmpty
                              ? Container(
                                  color:
                                      const Color.fromARGB(47, 192, 208, 194),
                                  child: GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemCount: smartItems.length,
                                    itemBuilder: (context, index) {
                                      final item = smartItems[index];

                                      return ShoppingItemCard(
                                        asset: item.imageUrl!,
                                        name: item.name!,
                                        quantity: "1kg",
                                      );
                                    },
                                  ),
                                )
                              : NoItemSelected()),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 42, 34),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () =>
                              setShoppingList(smartItems, cartItems),
                          child: Text(
                            "Set Shopping List",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text("Last used").withHeadStyle(),
                            Icon(Icons.keyboard_arrow_down_rounded),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isRemoveOn = !isRemoveOn;
                                });
                              },
                              icon: Icon(
                                Icons.delete_outline,
                                size: 25,
                                color: const Color.fromARGB(221, 122, 121, 121),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 500,
                        child: cartItems.isNotEmpty
                            ? Container(
                                color: const Color.fromARGB(47, 192, 208, 194),
                                child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemCount: cartItems.length,
                                  itemBuilder: (context, index) {
                                    final item = cartItems[index];

                                    return GestureDetector(
                                      onTap: () => isRemoveOn
                                          ? null
                                          : _setDialogBox(item),
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: ShoppingItemCard(
                                              asset: item.imageUrl!,
                                              name: item.name!,
                                              quantity: "1kg",
                                            ),
                                          ),
                                          Visibility(
                                            visible: isRemoveOn,
                                            child: GestureDetector(
                                              onTap: () =>
                                                  removeCartItem(item.name!),
                                              child: Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Icon(
                                                  Icons.remove_circle_rounded,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : NoItemSelected(),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  bool isRemoveOn = false;

  _openCalender() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((selectedDate) {
      if (selectedDate != null) {
        // Handle the selected date
        print("Selected date: $selectedDate");
      }
    });
  }

  void setShoppingList(List<ShoppingItemManager> smartItems,
      List<ShoppingItemManager> cartItems) {
    SmartShoppingListPreferences shoppingListPreferences =
        SmartShoppingListPreferences();
    DateTime seletedTime = DateTime.now();

    String title = "";
    String description = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Set Shopping List"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Description",
                ),
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              Row(
                children: [
                  Text("Date: "),
                  TextButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          setState(() {
                            seletedTime = selectedDate;
                          });
                        }
                      });
                    },
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return Text(
                          "${seletedTime.toLocal()}".split(' ')[0],
                        );
                      },
                    ),
                  ),
                  Text("Time: "),
                  TextButton(
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((selectedTime) {
                        if (selectedTime != null) {
                          setState(() {
                            seletedTime = DateTime(
                              seletedTime.year,
                              seletedTime.month,
                              seletedTime.day,
                              selectedTime.hour,
                              selectedTime.minute,
                            );
                          });
                        }
                      });
                    },
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return Text(
                          "${seletedTime.hour}:${seletedTime.minute}",
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (title.isEmpty ||
                    description.isEmpty ||
                    smartItems.isEmpty) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Set Data in Fields")));
                  return;
                }
                SmartShoppingListManager smartShoppingListManager =
                    SmartShoppingListManager(
                  title: title,
                  description: description,
                  smartItems: smartItems,
                  cartItems: cartItems,
                  timestamp: Timestamp.now(),
                  setTime: Timestamp.fromDate(seletedTime),
                );

                await shoppingListPreferences.setData(smartShoppingListManager);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("Your list has been saved successfully")),
                );
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void removeCartItem(String name) {
    ref.read(cartlistPovider.notifier).popItemState(name);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("$name has benn removed")));
  }

  void _setDialogBox(ShoppingItemManager item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Image.asset(
            item.imageUrl!,
            width: 50,
            height: 50,
          ),
          title: Text(item.name!),
          content: Text("do you want to add this item in Smart List"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
            TextButton(
              onPressed: () {
                ref.read(smartlistProvider.notifier).setState(item);
                ref.read(cartlistPovider.notifier).popItemState(item.name!);
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}

class NoItemSelected extends StatelessWidget {
  const NoItemSelected({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(221, 67, 67, 67),
        ),
      ),
      child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'No Item is Selected',
              textStyle: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
              speed: Duration(milliseconds: 100),
            ),
          ],
          totalRepeatCount: 1,
        ),
      ),
    );
  }
}

class CloseBottomSearch extends StateNotifier<bool> {
  CloseBottomSearch() : super(false);

  void stateChange(bool naturalstate) {
    state = naturalstate;
  }
}

final closeBottomSearch = StateNotifierProvider<CloseBottomSearch, bool>(
  (ref) {
    return CloseBottomSearch();
  },
);
