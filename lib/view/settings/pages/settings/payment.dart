import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class RazorpayService {
  late Razorpay _razorpay;
  final status = PaymentStatusManager._instance;

  RazorpayService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> openCheckout(double amount, String name, String description,
      String email, String contact) async {
    final razorpayKey = dotenv.env['RAZORPAYKEY'] ?? '';

    if (razorpayKey.isEmpty) {
      debugPrint('Error: Razorpay Key is missing');
      return;
    }

    var options = {
      'key': razorpayKey,
      'amount': (amount * 100).toInt(),
      'name': name,
      'description': description,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };

    try {
      _razorpay.open(options);
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
      _razorpay.clear();
    } catch (e) {
      debugPrint('Error opening Razorpay: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    debugPrint('Payment Success: ${response.paymentId}');
    status.savePaymentStatus(true).then(
      (value) {
        Get.snackbar("info", "you have successfully purchase subscription");
      },
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    debugPrint('Payment Error: ${response.code} - ${response.message}');
    status.savePaymentStatus(false).then(
      (value) {
        Get.snackbar("info", "payment is fail");
      },
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    debugPrint('External Wallet: ${response.walletName}');
    status.savePaymentStatus(false).then(
      (value) {
        Get.snackbar("info", "Internal Error in payment transaction");
      },
    );
  }

  void dispose() {
    _razorpay.clear();
  }
}

class PaymentStatusManager {
  static final PaymentStatusManager _instance =
      PaymentStatusManager._internal();
  static const String _paymentStatusKey = 'payment_status';

  factory PaymentStatusManager() {
    return _instance;
  }

  PaymentStatusManager._internal();

  Future<void> savePaymentStatus(bool isPaymentDone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_paymentStatusKey, isPaymentDone);
  }

  Future<bool> getPaymentStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_paymentStatusKey) ?? false;
  }
}
