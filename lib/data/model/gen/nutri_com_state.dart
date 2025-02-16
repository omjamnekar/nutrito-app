import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrito/data/model/gen/com.dart';
import 'package:uuid/uuid.dart';

class NutriComState {
  String? id;
  GenNutrilizationResponse? genNutrilizationResponse;
  File? fileImage;
  Timestamp timestamp;
  NutriComState({
    String? id,
    required this.genNutrilizationResponse,
    required this.fileImage,
    required this.timestamp,
  }) : id = id ?? Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'genNutrilizationResponse': genNutrilizationResponse?.toJson(),
      'fileImage': fileImage?.path,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  factory NutriComState.fromString(String jsonString) {
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return NutriComState(
        genNutrilizationResponse: jsonMap['genNutrilizationResponse'] != null
            ? GenNutrilizationResponse.fromJson(
                jsonMap['genNutrilizationResponse'])
            : null,
        fileImage:
            jsonMap['fileImage'] != null ? File(jsonMap['fileImage']) : null,
        timestamp: jsonMap['timestamp'] != null
            ? Timestamp.fromMillisecondsSinceEpoch(jsonMap['timestamp'])
            : Timestamp.now(),
      );
    } catch (e) {
      print("JSON Decode Error: $e");
      return NutriComState(
        genNutrilizationResponse: null,
        fileImage: null,
        timestamp: Timestamp.now(),
      ); // Return a default state
    }
  }
}
