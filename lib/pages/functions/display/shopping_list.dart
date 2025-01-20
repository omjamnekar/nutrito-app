import 'package:flutter/material.dart';
import 'package:nutrito/data/model/gen/smart/com_smart.dart';
import 'package:nutrito/data/storage/smart.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  ComSmartList? comSmartList;
  SmartShoppingListPreferences shoppingListPreferences =
      SmartShoppingListPreferences();
  bool isLoading = true; // Track initialization state

  @override
  void initState() {
    super.initState();
    initialDataSetup();
  }

  Future<void> initialDataSetup() async {
    comSmartList = await shoppingListPreferences.getData();
    setState(() {
      isLoading = false; // Data has been initialized
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show loading indicator while data is initializing
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Use FutureBuilder only after data is initialized
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Future.value(comSmartList?.toJson().toString() ?? ""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data!.isNotEmpty
                  ? Text(snapshot.data!)
                  : Center(child: Text("No data available"));
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
