import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:nutrito/data/model/auth.dart';
import 'package:nutrito/network/bloc/conn_bloc.dart';
import 'package:nutrito/network/provider/user.dart';
import 'package:nutrito/pages/dist/welcome.dart';

class AuthStateManager extends StateNotifier<UserModel> {
  AuthStateManager() : super(UserModel());

  final _firebase = FirebaseAuth.instance;
  Future<Map<String, dynamic>> signup(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await _firebase
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateProfile(displayName: name);

      return {
        "message": email,
        "state": "success",
        "id": userCredential.user?.uid ?? ""
      };
    } on FirebaseAuthException catch (e) {
      return {"message": e.message.toString(), "state": "fail"};
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _firebase.sendPasswordResetEmail(email: email);

      Get.snackbar(
          "Password Reset", "Password reset link has been sent to $email",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2));
    } on FirebaseAuthException catch (e) {
      Get.snackbar(e.email.toString(), "password reset link is shared!!",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2));
    }
  }

  Future<Map<String, dynamic>> verification(WidgetRef ref) async {
    // verification

    try {
      if (_firebase.currentUser != null &&
          !_firebase.currentUser!.emailVerified) {
        await _firebase.currentUser!.sendEmailVerification();
      }
      validation(ref);
      return {
        "message": 'Signup successful. Email already verified.',
        "state": "fail"
      };
    } on FirebaseAuthException catch (e) {
      return {"message": e.message.toString(), "state": "fail"};
    }
  }

  Future<bool> validation(WidgetRef ref) async {
    while (!_firebase.currentUser!.emailVerified) {
      await Future.delayed(const Duration(seconds: 3));
      await _firebase.currentUser!.reload();
    }

    final userOnline = _firebase.currentUser;
    if (userOnline != null) {
      final userModel = UserModel(
          email: userOnline.email ?? "",
          name: userOnline.displayName ?? "",
          phone: userOnline.phoneNumber ?? "",
          image: userOnline.displayName ?? "",
          password: "",
          id: userOnline.uid);

      await ref.read(userStateProvider.notifier).updateDataState(userModel);
    }
    return true;
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      return await _firebase
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user != null) {
          return {
            "id": value.user!.uid ?? "",
            "email": value.user?.email ?? "",
            "name": value.user?.displayName ?? "",
            "message": "successFull",
            "state": "success"
          };
        }
        return {};
      });
    } on FirebaseAuthException catch (e) {
      return {"message": e.message.toString(), "state": "fail"};
    }
  }

  Future<void> signOut(BuildContext context, WidgetRef ref) async {
    BlocProvider.of<ConnBloc>(context);
    await _firebase.signOut().then((_) async {
      await ref.read(userStateProvider.notifier).deleteDataState();
      // connBloc.emit(BoardingState());
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const WelcomePage()));
      Get.snackbar("Sign Out successful!", "feel free to give us feedback");
      return;
    }).catchError((error) {
      Get.snackbar("Sign Out Error", error.toString());
    });
  }
}

final authStateProvider = StateNotifierProvider<AuthStateManager, UserModel>(
  (ref) {
    return AuthStateManager();
  },
);
