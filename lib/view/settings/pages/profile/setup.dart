import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/data/model/sections/settings.dart';
import 'package:nutrito/util/data/setting_init.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ram update
class ProfileProvider extends StateNotifier<Profile> {
  Profile profile = profileEmptypublic;

  ProfileProvider() : super(Profile(section_1: null)) {
    init();
  }

  Future<void> init() async {
    profile = await ProfileShareStore().loadData();
    state = profile;
  }

  Future<void> updateState(Profile profile) async {
    if (profile.section_1 != null) {
      await ProfileShareStore().updateData(profile);
      state = profile;
    }
  }

  Future<Profile> loadState() async {
    return state;
  }
}

final profileProvider = StateNotifierProvider<ProfileProvider, Profile>(
  (ref) {
    return ProfileProvider();
  },
);

// main memory

class ProfileShareStore {
  Future<Profile> loadData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    final data = await _pref.getString("profile");
    if (data != null) {
      return Profile.fromMap(jsonDecode(data));
    }
    return Profile(section_1: null);
  }

  Future<void> updateData(Profile profile) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setString("profile", jsonEncode(profile.toMap()));
  }
}
