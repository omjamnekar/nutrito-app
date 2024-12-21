import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/data/model/auth.dart';
import 'package:nutrito/data/repositories/googleService.dart';
import 'package:nutrito/network/provider/auth.dart';
import 'package:nutrito/network/provider/user.dart';
import 'package:nutrito/pages/auth/verification.dart';
import 'package:nutrito/pages/home/home.dart';
import 'package:nutrito/pages/trailing.dart';

class AuthController extends GetxController {
  // late AuthStateManager authNotifier;
  WidgetRef ref;
  AuthController({required this.ref});

  Future<void> signUpAuth(WidgetRef ref, String name, String email,
      String password, AuthController ctrl) async {
    dataValidation(name, email, password);

    Map<String, dynamic> registerData = await ref
        .watch(authStateProvider.notifier)
        .signup(email, password, name);
    snackBar(registerData["message"]);
    FocusScope.of(Get.context!).unfocus();
    if (registerData["state"] == 'success') {
      final userModel = UserModel(
          email: email, password: password, name: name, image: "", phone: "");
      ref.watch(userStateProvider.notifier).updateDataState(userModel);

      Get.to(
          () => VerificationPage(
                authcontroller: ctrl,
              ),
          transition: Transition.fade);
    } else {
      return;
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    await ref.watch(authStateProvider.notifier).signIn(email, password).then(
      (value) {
        if (value["state"] == "success") {
          Get.snackbar("SignIn", "SignIn Successfull",
              padding: EdgeInsets.all(10));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value["state"].toString().toUpperCase(),
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(value["message"])
            ],
          )));
        }
      },
    );
  }

  Future<void> varificationChannel() async {
    await ref.watch(authStateProvider.notifier).verification(ref);
  }

  Future<bool> velidation() async {
    final booldata =
        await ref.watch(authStateProvider.notifier).validation(ref);
    return booldata;
  }

////////////////////////////////////////////////////////////////////////////////////////////////
  void snackBar(String text) {
    Get.snackbar('Info', text,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: const Color.fromARGB(255, 50, 50, 50));
  }

  void dataValidation(String username, String email, String password) {
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      snackBar("Data is not valid");
      return;
    } else if (!GetUtils.isEmail(email)) {
      snackBar("Email is not valid");
      return;
    } else if (!_isValidPassword(password)) {
      snackBar(
          "Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character.");

      return;
    }
  }

  Future<void> signout(BuildContext context) async {
    ref.watch(authStateProvider.notifier).signOut(context, ref);
  }

  bool _isValidPassword(String password) {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password);
  }

  Future<void> forgotpassword(String email) async {
    ref.watch(authStateProvider.notifier).forgotPassword(email);
  }

  Future<void> googleSignin(BuildContext context) async {
    try {
      UserCredential data = await AuthService().signWithGoogle();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Google signin Successful")));

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TrailingPage(),
          ));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }
}
