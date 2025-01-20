import 'dart:convert';

import 'package:nutrito/data/model/gen/com.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NutrilizationStore {
  Future<void> saveData({required GenNutrilizationResponse instance}) async {
    final prefs = await SharedPreferences.getInstance();

    final previousData = prefs.getStringList("nutrilizationList") ?? [];
    final updatedData = [
      ...previousData,
      jsonEncode(instance.toJson()),
    ];

    await prefs.setStringList("nutrilizationList", updatedData);
  }

  Future<List<GenNutrilizationResponse>> getData() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList("nutrilizationList") ?? [];

    return data
        .map((jsonString) =>
            GenNutrilizationResponse.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  Future<void> removeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("nutrilizationList");
  }

  Future<void> removeDataAtIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList("nutrilizationList") ?? [];

    if (index < 0 || index >= data.length) {
      throw Exception("Invalid index");
    }

    data.removeAt(index);
    await prefs.setStringList("nutrilizationList", data);
  }
}
