import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/data/model/gen/smart/com_smart.dart';
import 'package:nutrito/data/storage/smart.dart';
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
      isLoading = false; // Data has been initialized
    });
  }

  Future<void> removeDataList(String id) async {
    await shoppingListPreferences.removeData(id);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
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
              print(snapshot.data!.smartShoppingListManager.length);
              return (snapshot.data != null &&
                      snapshot.data!.smartShoppingListManager.isNotEmpty)
                  ? PackageManage(
                      comSmartList: snapshot.data!,
                      isRmoveOn: isRemoveOption,
                      onClickDelete: (id) => removeDataList(id),
                    )
                  : Center(child: Text("No data available"));
            }

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
    print(
        "from object ${widget.comSmartList.smartShoppingListManager.first.smartItems}");
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
                                            .smartShoppingListManager[index]),
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
  ShoppingListDetail({super.key, required this.dataman});

  @override
  State<ShoppingListDetail> createState() => _ShoppingListDetailState();
}

class _ShoppingListDetailState extends State<ShoppingListDetail> {
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
            Flexible(
              flex: 1,
              child: Text(
                widget.dataman.title,
                style: GoogleFonts.poppins(fontSize: 30),
              ),
            ),
            Text(
              "Smart List",
              style: GoogleFonts.poppins(fontSize: 25),
            ),
            Gap(10),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(61, 68, 255, 180),
                    borderRadius: BorderRadius.circular(20)),
                child: ListView.builder(
                  itemCount: widget.dataman.smartItems.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
            Gap(40),
            Text(
              "Cart Items",
              style: GoogleFonts.poppins(fontSize: 25),
            ),
            Gap(10),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(59, 114, 255, 227),
                    borderRadius: BorderRadius.circular(20)),
                child: ListView.builder(
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
                            value: widget.dataman.cartItems[index].isChecked ??
                                false,
                            onChanged: (bool? value) {
                              setState(() {
                                widget.dataman.cartItems[index].isChecked =
                                    value!;
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
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
                  onPressed: () {},
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
                  onPressed: () {},
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
