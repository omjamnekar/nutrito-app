import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:http/http.dart" as http;
import 'package:get/get.dart';

import 'package:dio/dio.dart' as dio;
import 'package:nutrito/data/api.dart';
import 'package:nutrito/data/model/gen/alternative/alternative.dart';
import 'package:nutrito/network/provider/mongo_Response.dart';
import 'package:nutrito/view/functions/display/loading.dart';

class AlternativeController extends GetxController {
  List<AlthernativeModel> searchedEdit = [];

  AlternativeCall alternativeCall = AlternativeCall();
  RxList<AlthernativeModel> alternativeList = <AlthernativeModel>[].obs;

  Future<List<AlthernativeModel>> suggestAlternative(
      String product, String data) async {
    var dataMap = await alternativeCall.generateData(product ?? "", data ?? "");
    return dataMap.map((e) => AlthernativeModel.fromJson(e)).toList();
  }

  // Future<List<AlthernativeModel>> categoried() {}

  Future<List<AlthernativeModel>> fullRandom(WidgetRef ref) async {
    final responseRam = ref.read(mongoResponseProvider.notifier);

    final stateResponse = responseRam.load();

    if (stateResponse.isNotEmpty) {
      print("fetching ram");
      return responseRam.load();
    }
    final dataMap = await alternativeCall.fetchSuggestion();
    alternativeList
        .assignAll(dataMap.map((e) => AlthernativeModel.fromJson(e)).toList());

    final dataAlter =
        dataMap.map((e) => AlthernativeModel.fromJson(e)).toList();
    responseRam.setup(dataAlter);
    return dataMap.map((e) => AlthernativeModel.fromJson(e)).toList();
  }

  Future<List<AlthernativeModel>> generateImageAlternative(
      File file, BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GenLoading(),
      ),
    );
    final dataMap = await alternativeCall.imageAlternative(file, context);
    return dataMap.map((e) => AlthernativeModel.fromJson(e)).toList();
  }

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

  Future<void> fetechFromCategorySearch(
      List<String> filter, String option, BuildContext context) async {
    final newList =
        await alternativeCall.fetchDataForCategory(filter, option, context);
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
      final jsonData = response.data;

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

  Future<List<AlthernativeModel>> fetchDataForCategory(
      List<String> filter, String option, BuildContext context) async {
    try {
      final response = await genApi.sendRequest.post("/api/catergoriedSearch",
          data: {"filterData": filter, "option": option});

      if (response.statusCode == 200) {
        final jsonData = response.data;
        if (jsonData is Map<String, dynamic> &&
            jsonData.containsKey("alternative")) {
          return (List<Map<String, dynamic>>.from(jsonData["alternative"]))
              .map((e) => AlthernativeModel.fromJson(e))
              .toList();
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception("Failed to load data");
      }
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 504) {
        print("Server timeout! Retrying...");
        Navigator.popUntil(context, ModalRoute.withName('/AlternativePage'));
        return [];
      } else {
        Navigator.pop(context);
        return [];
      }
    }
  }

// fetch data from image
  Future<List<Map<String, dynamic>>> imageAlternative(
      File fileImage, BuildContext context) async {
    try {
      dio.FormData formData = dio.FormData.fromMap({
        "image": await dio.MultipartFile.fromFile(fileImage.path,
            filename: fileImage.path.split('/').last),
      });

      final response = await genApi.sendRequest.post(
        "/api/imageSuggestion",
        data: formData,
      );

      if (response.statusCode == 200) {
        final jsonData = response.data;
        if (jsonData is Map<String, dynamic> &&
            jsonData.containsKey("alternative")) {
          return List<Map<String, dynamic>>.from(jsonData["alternative"]);
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception("Failed to load data");
      }
    } on dio.DioException catch (e) {
      if (e.response?.statusCode == 504) {
        print("Server timeout! Retrying...");
        Navigator.popUntil(context, ModalRoute.withName('/AlternativePage'));
        return [];
      } else {
        Navigator.pop(context);
        return [];
      }
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
