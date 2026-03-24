import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class LocalStorageService {
  static const String userKey = "user_data";

  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userKey, jsonEncode(user.toJson()));
  }

  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(userKey);

    if (data == null) return null;

    return UserModel.fromJson(jsonDecode(data));
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(userKey);
  }
}
