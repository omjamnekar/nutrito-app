// ignore: file_names
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nutrito/data/api.dart';
import 'package:nutrito/data/model/auth.dart';
import 'package:nutrito/data/model/sections/response_State.dart';
import 'package:nutrito/data/model/sections/user_state.dart';

class RegisterUser {
  RegisterUser();

  final BaseHttpCall _setupUser = BaseHttpCall();
  Future<ResponseStatus> requestUserRegister(
      PrimarySetupManager primarySetup) async {
    try {
      final String? secretKey = dotenv.env["SETUP"];
      if (secretKey == null || secretKey.isEmpty) {
        throw Exception("Secret key is not set in the .env file.");
      }

      final Map<String, dynamic> requestBody = {
        "userId": primarySetup.id,
        "email":
            primarySetup.settingSetupManager!.profile!.section_1!.email ?? "",
        "timespan": DateTime.now().millisecondsSinceEpoch,
        "user": {
          "home": primarySetup.homeSetupManager!.toMap(),
          "setting": primarySetup.settingSetupManager!.toMap(),
          "social": primarySetup.socialSetupManager!.toMap(),
          "search": primarySetup.searchSetupManager!.toMap()
        },
      };

      final Response response = await _setupUser.sendRequest.post(
        "/register",
        queryParameters: {"secretkey": secretKey},
        data: requestBody,
      );

      if (response.statusCode != 201) {
        throw Exception(
            "Failed to register user. Status code: ${response.statusCode}");
      }

      if (response.data == null) {
        throw Exception("No data received from the API.");
      }

      return ResponseStatus(
        statusCode: response.statusCode,
        status: response.statusMessage,
        message: response.data["message"],
      );
    } on DioException catch (e) {
      print("DioException occurred: ${e.response?.data ?? e.message}");
      throw Exception("Network error: ${e.response?.data ?? e.message}");
    } catch (e) {
      print("Unexpected error occurred: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> requestUserLogin(UserModel userModel) async {
    try {
      final String? secretKey = dotenv.env["SETUP"];
      if (secretKey == null || secretKey.isEmpty) {
        throw Exception("Secret key is not set in the .env file.");
      }

      Map<String, dynamic> requestBody = {
        "userId": userModel.id,
        "email": userModel.email,
        "timespan": DateTime.now().millisecondsSinceEpoch,
      };

      final Response response = await _setupUser.sendRequest.post(
        "/login",
        queryParameters: {"secretkey": secretKey},
        data: requestBody,
      );

      if (response.statusCode != 200) {
        throw Exception(
            "Failed to register user. Status code: ${response.statusCode}");
      }

      if (response.data == null) {
        throw Exception("No data received from the API.");
      }

      return {
        "response": ResponseStatus(
          statusCode: response.statusCode,
          status: response.statusMessage,
          message: response.data["message"],
        ),
        "primarysetup": response.data,
      };
    } on DioException catch (e) {
      print("DioException occurred: ${e.response?.data ?? e.message}");
      throw Exception("Network error: ${e.response?.data ?? e.message}");
    } catch (e) {
      print("Unexpected error occurred: $e");
      rethrow;
    }
  }
}
