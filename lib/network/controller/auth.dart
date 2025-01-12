import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/data/model/auth.dart';
import 'package:nutrito/data/repositories/googleService.dart';
import 'package:nutrito/network/provider/auth.dart';
import 'package:nutrito/network/provider/primary_Setup.dart';
import 'package:nutrito/network/provider/user.dart';
import 'package:nutrito/pages/auth/verification.dart';
import 'package:nutrito/pages/main_page.dart';
import 'package:nutrito/pages/dist/trailing.dart';

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
      print("datta data :${registerData["id"]}");
      final userModel = UserModel(
          id: registerData["id"],
          email: email,
          password: password,
          name: name,
          image: "",
          phone: "");
      await ref.watch(userStateProvider.notifier).updateDataState(userModel);

      await ref.read(primarySetupProvider.notifier).setupPrimaryCourse().then(
        (value) {
          if (value.statusCode == 200 || value.statusCode == 201) {
            Get.to(
                () => VerificationPage(
                      authcontroller: ctrl,
                    ),
                transition: Transition.fade);
          } else {
            Get.snackbar(value.statusCode.toString(),
                value.message?.toString() ?? "network errors");
          }
        },
      );
    } else {
      return;
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    await ref.watch(authStateProvider.notifier).signIn(email, password).then(
      (value) async {
        if (value["state"] == "success") {
          Get.snackbar("SignIn", "SignIn Successfull",
              padding: const EdgeInsets.all(10));
          final userModel2 =
              UserModel(email: email, id: value["id"], name: value["name"]);

          print("datta final id${value["id"]}");

          await ref
              .watch(userStateProvider.notifier)
              .updateDataState(userModel2);

          await ref
              .read(primarySetupProvider.notifier)
              .setupPrimaryLoginCourse()
              .then(
            (value) {
              if (value.statusCode == 200 || value.statusCode == 201) {
                print("object");
                Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPage(),
                    ));
              } else {
                Get.snackbar(value.statusCode.toString(),
                    value.message?.toString() ?? "network errors");
              }
            },
          );
        } else {
          // ignore: use_build_context_synchronously
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
      await AuthService().signWithGoogle();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Google signin Successful")));

      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => const TrailingPage(),
          ));
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }
}
