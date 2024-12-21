import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nutrito/network/controller/connectivity.dart';

class DependancyInjection {
  static void init() {
    Get.put<NetworkContoller>(NetworkContoller(), permanent: true);
  }
}
