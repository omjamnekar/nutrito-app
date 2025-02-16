import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nutrito/data/api.dart';
import 'package:nutrito/data/model/gen/compare/compare.dart';
import 'package:nutrito/data/model/gen/conclusion_pr.dart';
import 'package:nutrito/data/model/gen/health_pr.dart';
import 'package:nutrito/data/model/gen/initial_pr.dart';
import 'package:nutrito/data/model/gen/ratio_pr.dart';

class GenaiCall {
  BuildContext context;
  File file;

  GenaiCall({required this.file, required this.context});
  File file2 = File("");

  set setFile2(File file) {
    file2 = file;
  }

  final GenApi _genApi = GenApi();

  Future<InitialPromptManager?> initialPrompt() async {
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last),
      });
      Response response = await _genApi.sendRequest
          .post("/v1/gen/nutrilization/initialPrompt", data: formData);

      return InitialPromptManager.fromJson(response.data);
      // initial
    } on DioException catch (e) {
      print(e.message.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
        ),
      );
      return null;
    }
  }

  Future<HealthPromptManager?> healthPrompt() async {
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last),
      });
      Response response = await _genApi.sendRequest
          .post("/v1/gen/nutrilization/healthPrompt", data: formData);

      return HealthPromptManager.fromJson(response.data);
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
        ),
      );

      return null;
    }
  }

  Future<ConclusionPromptManger?> conclusionPrompt() async {
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last),
      });
      Response response = await _genApi.sendRequest
          .post("/v1/gen/nutrilization/conclusionPrompt", data: formData);

      return ConclusionPromptManger.fromJson(response.data);
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
        ),
      );
      return null;
    }
  }

  Future<RatioPromptManager?> ratioPrompt() async {
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last),
      });
      Response response = await _genApi.sendRequest
          .post("/v1/gen/nutrilization/ratioPrompt", data: formData);

      return RatioPromptManager.fromJson(response.data);
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
        ),
      );
      return null;
    }
  }

  Future<CompareManager?> compareProduct() async {
    try {
      FormData formData = FormData.fromMap({
        "image1": await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last),
        "image2": await MultipartFile.fromFile(file.path,
            filename: file2.path.split('/').last)
      });
      Response response = await _genApi.sendRequest
          .post("/v1/gen/conpareProduct/provideData", data: formData);

      return CompareManager.fromJson(response.data);
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
        ),
      );
      return null;
    }
  }
}
