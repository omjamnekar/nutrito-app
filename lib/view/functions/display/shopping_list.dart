import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/data/model/gen/smart/com_smart.dart';
import 'package:nutrito/data/storage/smart.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  late ComSmartList comSmartList = ComSmartList(smartShoppingListManager: []);
  SmartShoppingListPreferences shoppingListPreferences =
      SmartShoppingListPreferences();
  bool isLoading = true; // Track initialization state

  bool isRemoveOption = false;

  @override
  void initState() {
    super.initState();
    initialDataSetup();
  }

  Future<void> initialDataSetup() async {
    final data = await shoppingListPreferences.getData();

    setState(() {
      if (data != null) comSmartList = data;
      isLoading = false;
    });
  }

  Future<void> removeDataList(String id) async {
    await shoppingListPreferences.removeData(id);
    await initialDataSetup();

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return FutureBuilder(
        future: Future.delayed(Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Text(
                  "Let's start making shoppnig list",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
              ),
            );
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery Days"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isRemoveOption = !isRemoveOption;
              });
            },
            icon: Icon(Icons.remove_circle_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Future.value(comSmartList),
          builder: (context, snapshot) {
            if (snapshot.data != null &&
                snapshot.data!.smartShoppingListManager.isNotEmpty &&
                snapshot.connectionState == ConnectionState.done) {
              return (snapshot.data != null &&
                      snapshot.data!.smartShoppingListManager.isNotEmpty)
                  ? PackageManage(
                      comSmartList: snapshot.data!,
                      isRmoveOn: isRemoveOption,
                      onClickDelete: (id) => removeDataList(id),
                    )
                  : Center(child: Text("No data available"));
            }

            return FutureBuilder(
              future: Future.delayed(Duration(seconds: 1)),
              builder: (context, snapshot) {
                if (!(snapshot.connectionState == ConnectionState.waiting)) {
                  return Scaffold(
                    body: Center(
                      child: Text(
                        "Let's start making shoppnig list",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Shimmer(
                            loop: 10,
                            gradient: LinearGradient(
                              colors: [Colors.grey[300]!, Colors.grey[100]!],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            )),
                      );
                    },
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class PackageManage extends StatefulWidget {
  ComSmartList comSmartList;
  bool isRmoveOn;
  Function(String id) onClickDelete;

  PackageManage(
      {super.key,
      required this.comSmartList,
      required this.isRmoveOn,
      required this.onClickDelete});

  @override
  State<PackageManage> createState() => _PackageManageState();
}

class _PackageManageState extends State<PackageManage> {
  @override
  Widget build(BuildContext context) {
    final data = widget.comSmartList;

    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
              // color: Colors.amber,
              ),
        ),
        Flexible(
            flex: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: ListView.builder(
                itemCount: data.smartShoppingListManager.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(DateFormat('yyyy-MM-dd').format(widget
                                .comSmartList
                                .smartShoppingListManager[index]
                                .setTime
                                .toDate())),
                            Text(DateFormat('hh:mm').format(widget.comSmartList
                                .smartShoppingListManager[index].setTime
                                .toDate())),
                          ],
                        ),
                      ),
                      Gap(10),
                      Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 195, 254, 226),
                        ),
                        child: Center(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShoppingListDetail(
                                      dataman: widget.comSmartList
                                          .smartShoppingListManager[index],
                                      onClick: (id) {
                                        widget.onClickDelete(id);
                                      },
                                    ),
                                  ));
                            },
                            leading: Container(
                              width: 80,
                              height: 80,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromARGB(255, 255, 239, 192),
                              ),
                              child: Image.asset(data
                                  .smartShoppingListManager[index]
                                  .smartItems
                                  .last
                                  .imageUrl!),
                            ),
                            title: Text(
                                data.smartShoppingListManager[index].title),
                            subtitle: Text(
                              data.smartShoppingListManager[index].description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: widget.isRmoveOn
                                ? GestureDetector(
                                    onTap: () => widget.onClickDelete(data
                                        .smartShoppingListManager[index].id),
                                    child: Icon(Icons.delete),
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )),
        Flexible(
          flex: 1,
          child: Container(
              // color: Colors.amber,
              ),
        ),
      ],
    );
  }
}

class ShoppingListDetail extends StatefulWidget {
  SmartShoppingListManager dataman;
  Function(String) onClick;
  ShoppingListDetail({super.key, required this.dataman, required this.onClick});

  @override
  State<ShoppingListDetail> createState() => _ShoppingListDetailState();
}

class _ShoppingListDetailState extends State<ShoppingListDetail> {
  bool isAllDone = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      // update and share
      appBar: AppBar(
        title: Text(
          widget.dataman.title,
          style: GoogleFonts.poppins(fontSize: 20),
        ),
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(30),
            isAllDone
                ? Flexible(
                    flex: 1,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      height: 60,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: ColorManager.greenPrimary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Shopping is Done!!",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Flexible(
              flex: 1,
              child: Text(
                widget.dataman.title,
                style: GoogleFonts.poppins(fontSize: 30),
              ),
            ),
            Text(
              "Smart List",
              style: GoogleFonts.poppins(fontSize: 17),
            ),
            Gap(10),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(61, 68, 255, 180),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: ListView.builder(
                  itemCount: widget.dataman.smartItems.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    bool isExpanded = false;
                    return GestureDetector(
                      onTap: () {
                        isExpanded = !isExpanded;
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Image.asset(
                              widget.dataman.smartItems[index].imageUrl!,
                              width: 50,
                              height: 50,
                            ),
                            Gap(20),
                            Text(
                              widget.dataman.smartItems[index].name!,
                              style: GoogleFonts.poppins(fontSize: 20),
                            ),
                            Spacer(),
                            Checkbox(
                              value:
                                  widget.dataman.smartItems[index].isChecked ??
                                      false,
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.dataman.smartItems[index].isChecked =
                                      value!;

                                  isAllDone = (widget.dataman.smartItems.every(
                                              (item) =>
                                                  item.isChecked == true) ||
                                          widget.dataman.smartItems.isEmpty) &&
                                      (widget.dataman.cartItems.isEmpty ||
                                          widget.dataman.cartItems.every(
                                              (item) =>
                                                  item.isChecked == true));
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Gap(30),
            Text(
              "Cart Items",
              style: GoogleFonts.poppins(fontSize: 17),
            ),
            Gap(10),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(61, 68, 255, 180),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: widget.dataman.cartItems.length != 0
                    ? ListView.builder(
                        itemCount: widget.dataman.cartItems.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              children: [
                                Image.asset(
                                  widget.dataman.cartItems[index].imageUrl!,
                                  width: 50,
                                  height: 50,
                                ),
                                Gap(20),
                                Text(widget.dataman.cartItems[index].name!),
                                Spacer(),
                                Checkbox(
                                  value: widget
                                          .dataman.cartItems[index].isChecked ??
                                      false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      widget.dataman.cartItems[index]
                                          .isChecked = value!;

                                      isAllDone = (widget.dataman.smartItems
                                                  .every((item) =>
                                                      item.isChecked == true) ||
                                              widget.dataman.smartItems
                                                  .isEmpty) &&
                                          (widget.dataman.cartItems.isEmpty ||
                                              widget.dataman.cartItems.every(
                                                  (item) =>
                                                      item.isChecked == true));
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "No list of product!",
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: SizedBox(
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.white70,
                child: TextButton(
                  onPressed: () {
                    widget.onClick(widget.dataman.id);
                    Navigator.pop(context);
                    Get.snackbar(
                      "Deleted",
                      "The shopping list has been deleted successfully.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                      margin: EdgeInsets.only(bottom: 10),
                      duration: Duration(seconds: 2),
                    );
                  },
                  child: Text(
                    "Delete",
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                ),
              ),
            ),
            Gap(5),
            Expanded(
              child: Container(
                color: const Color.fromARGB(237, 40, 255, 165),
                child: TextButton(
                  onPressed: () {
                    Get.snackbar(
                      "Shopping complete",
                      "Congratulations! You've completed your shopping list.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.greenAccent,
                      colorText: Colors.black45,
                      margin: EdgeInsets.only(bottom: 10),
                      duration: Duration(seconds: 2),
                    );
                    widget.onClick(widget.dataman.id);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Done",
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
