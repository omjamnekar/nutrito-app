import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:nutrito/data/model/auth.dart';
import 'package:nutrito/data/storage/user_Data.dart';

class UserDataManager extends StateNotifier<UserModel> {
  UserDataManager() : super(UserModel());
  UserStore _userStore = UserStore();

  Future<UserModel> loadDataState() async {
    try {
      _userStore.loadData().then(
        (value) {
          state = value;
        },
      );
    } catch (e) {
      Get.snackbar("store error", e.toString());
      return UserModel();
    }
    return state;
  }

  Future<void> updateDataState(UserModel userModel) async {
    state = userModel;
    await _userStore.updateData(userModel);
  }

  Future<void> deleteDataState() async {
    state = UserModel();
    await _userStore.deleteData();
  }
}

final userStateProvider = StateNotifierProvider<UserDataManager, UserModel>(
  (ref) {
    return UserDataManager();
  },
);
