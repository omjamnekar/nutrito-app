import 'package:nutrito/data/model/gen/smart/com_smart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SmartShoppingListPreferences {
  Future<void> setData(ComSmartList shoppingList) async {
    final prefs = await SharedPreferences.getInstance();
    final existingData = prefs.getString("smartShoppingList");

    try {
      if (existingData != null) {
        // Deserialize existing data
        final mergedData = ComSmartList.fromString(existingData);
        print("here code ");

        // Add new shoppingList
        mergedData.smartShoppingListManager
            .add(shoppingList.smartShoppingListManager.first);

        // Serialize and store updated data
        await prefs.setString("smartShoppingList", mergedData.toJsonString());
      } else {
        // Store new data as JSON string
        await prefs.setString(
          "smartShoppingList",
          shoppingList.toJsonString(),
        );
      }
    } catch (e) {
      print("Error while saving data: ${e.toString()}");
    }
  }

  Future<ComSmartList?> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final existingData = prefs.getString("smartShoppingList");

    if (existingData != null) {
      return ComSmartList.fromString(existingData);
    } else {
      return null;
    }
  }

  Future<void> removeData(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final existingData = prefs.getString("smartShoppingList");

    if (existingData != null) {
      final data = ComSmartList.fromString(existingData);
      data.smartShoppingListManager.removeWhere((e) => e.id == id);
      await prefs.setString("smartShoppingList", data.toJsonString());
    }
  }
}
