// ignore: file_names
import 'package:nutrito/data/model/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStore {
  late SharedPreferences _prefs;

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<UserModel> loadData() async {
    await _initPrefs();
    return UserModel(
      name: _prefs.getString('name') ?? "",
      email: _prefs.getString('email') ?? "",
      phone: _prefs.getString("phone") ?? "",
      id: _prefs.getString("id") ?? "",
      image: _prefs.getString("image") ?? "",
    );
  }

  Future<void> updateData(UserModel userModel) async {
    await _initPrefs();
    await _prefs.setString('name', userModel.name ?? "");
    await _prefs.setString('email', userModel.email ?? "");
    await _prefs.setString("phone", userModel.phone ?? "");
    await _prefs.setString("id", userModel.id ?? "");
    await _prefs.setString("image", userModel.image ?? "");
  }

  Future<void> deleteData() async {
    await _initPrefs();
    await _prefs.clear();
  }
}
