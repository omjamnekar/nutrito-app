import 'package:get/get.dart';
import 'package:nutrito/network/controller/connectivity.dart';

class DependancyInjection {
  static void init() {
    Get.put<NetworkContoller>(NetworkContoller(), permanent: true);
  }
}
