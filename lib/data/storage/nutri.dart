import 'dart:convert';

import 'package:nutrito/data/model/gen/nutri_com_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NutriPreference {
  Future<void> nutristore(NutriComState nutriState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingData = prefs.getStringList("nutriState");

    List<String> updatedData = existingData ?? [];
    updatedData.add(jsonEncode(nutriState.toJson())); // ✅ Store proper JSON

    await prefs.setStringList("nutriState", updatedData);
  }

  Future<List<NutriComState>> getNutriData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingData = prefs.getStringList("nutriState");

    if (existingData == null) return []; // ✅ Return empty list if null

    try {
      return existingData.map((e) {
        return NutriComState.fromString(e);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> nutriRemove(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingData = prefs.getStringList("nutriState");

    if (existingData == null) return;

    List<NutriComState> existBinding = existingData.map((e) {
      return NutriComState.fromString(e);
    }).toList();

    existBinding.removeWhere((element) => element.id == id);

    List<String> updatedData =
        existBinding.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList("nutriState", updatedData);
  }
}
