import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:nutrito/pages/connection/connectivity.dart';
import 'package:nutrito/util/color.dart';

class NetworkContoller extends GetxController {
  BuildContext? context;

  NetworkContoller({this.context});

  final Connectivity _connectivity = Connectivity();

  bool firstStateNetwork = false;

  @override
  void onInit() {
    super.onInit();

    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResults) {
    if (connectivityResults.first == ConnectivityResult.none) {
      firstStateNetwork = true;
      Get.to(() => const ConnectivityPage(), transition: Transition.fade);
      snackBar("network Offline", true);
    } else {
      Get.back();

      firstStateNetwork ? snackBar("Back Online", false) : null;
    }
  }

  Future<void> checkConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  void snackBar(String text, bool isOnline) {
    Get.snackbar('Connection status', text,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor:
            !isOnline ? const Color.fromARGB(255, 1, 116, 95) : Colors.black87,
        margin: const EdgeInsets.only(bottom: 10, right: 5, left: 5));
  }
}
