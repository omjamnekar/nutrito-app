import 'dart:convert';
import 'dart:io';
import "package:http/http.dart" as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:nutrito/data/api.dart';
import 'package:nutrito/data/model/gen/alternative/alternative.dart';
import 'package:rxdart/rxdart.dart';

class AlternativeController extends GetxController {
  String? product;
  String? data;
  AlternativeController({
    required this.product,
    required this.data,
  });
  List<AlthernativeModel> searchedEdit = [];

  AlternativeCall alternativeCall = AlternativeCall();
  Future<List<AlthernativeModel>> suggestAlternative() async {
    var dataMap = await alternativeCall.generateData(product ?? "", data ?? "");
    return dataMap.map((e) => AlthernativeModel.fromJson(e)).toList();
  }

  Future<List<AlthernativeModel>> fullRamdom() async {
    final dataMap = await alternativeCall.fetchSuggestion();
    alternativeList
        .assignAll(dataMap.map((e) => AlthernativeModel.fromJson(e)).toList());

    return dataMap.map((e) => AlthernativeModel.fromJson(e)).toList();
  }

  Future<List<AlthernativeModel>> generateImageAlternative(File file) async {
    final dataMap = await alternativeCall.imageAlternative(file);
    return dataMap.map((e) => AlthernativeModel.fromJson(e)).toList();
  }

  RxList<AlthernativeModel> alternativeList = <AlthernativeModel>[].obs;

  // Update the alternative list and notify listeners
  void updateAlternativeList(List<AlthernativeModel> newList) {
    alternativeList.assignAll(newList);
  }

  Future<void> searchBycharacter(String query) async {
    if (alternativeList.isNotEmpty) {
      final searchedEdit = alternativeList.where((alternative) {
        return alternative.toJson().values.any((value) =>
            value.toString().toLowerCase().contains(query.toLowerCase()));
      }).toList();

      updateAlternativeList(searchedEdit);
    } else {
      final dataMap = await alternativeCall.fetchSuggestion();
      final newList =
          dataMap.map((e) => AlthernativeModel.fromJson(e)).toList();
      updateAlternativeList(newList);
    }
  }

  Future<void> fetchFullRandom() async {
    final dataMap = await alternativeCall.fetchSuggestion();
    final newList = dataMap.map((e) => AlthernativeModel.fromJson(e)).toList();
    updateAlternativeList(newList);
  }
}

class AlternativeCall {
  GenApi genApi = GenApi();

  //fetch specific data from product and data
  Future<List<Map<String, dynamic>>> generateData(
      String product, String data) async {
    final response = await genApi.sendRequest
        .post("/api/suggestions", data: {"product": product, "data": data});

    if (response.statusCode == 200) {
      final jsonData = response.data; // Don't use jsonDecode

      if (jsonData is Map<String, dynamic> &&
          jsonData.containsKey("alternative")) {
        final List<dynamic> alternativeList = jsonData["alternative"];
        return List<Map<String, dynamic>>.from(alternativeList);
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

// fetch data from image
  Future<List<Map<String, dynamic>>> imageAlternative(File fileImage) async {
    dio.FormData formData = dio.FormData.fromMap({
      "image": await dio.MultipartFile.fromFile(fileImage.path,
          filename: fileImage.path.split('/').last),
    });
    final response =
        await genApi.sendRequest.post("/api/imageSuggestion", data: formData);

    if (response.statusCode == 200) {
      final jsonData = response.data; // Don't use jsonDecode

      if (jsonData is Map<String, dynamic> &&
          jsonData.containsKey("alternative")) {
        final List<dynamic> alternativeList = jsonData["alternative"];
        return List<Map<String, dynamic>>.from(alternativeList);
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

// fetch all data from mongo
  Future<List<Map<String, dynamic>>> fetchSuggestion() async {
    final response = await http.get(Uri.parse(
        "https://nutrito.vercel.app/api/alternativeproducts?secretkey=thisismysecretkey"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData is Map<String, dynamic> &&
          jsonData.containsKey("products")) {
        final List<dynamic> alternativeList = jsonData["products"];
        return List<Map<String, dynamic>>.from(alternativeList);
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }
}
