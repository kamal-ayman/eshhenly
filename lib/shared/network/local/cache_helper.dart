// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static var sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required String key,
    required int value,
  }) async {
    return await sharedPreferences.setInt(key, value);
  }

  static int getData({
    required String key,
  }) {
    return sharedPreferences.getInt(key);
  }
}
