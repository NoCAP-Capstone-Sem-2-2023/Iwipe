import 'dart:convert';

import 'package:iwipe/common/values/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _sharedPreferences;

  Future<StorageService> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _sharedPreferences.setString(key, value);
  }

  bool getDeviceOpenFirstTime() {
    return _sharedPreferences
            .getBool(AppConstant.STORAGE_DEVICE_OPEN_FIRST_TIME) ??
        false;
  }

  bool getIsLogin() {
    return _sharedPreferences.getString(AppConstant.STORAGE_USER_PROFILE) ==
            null
        ? false
        : true;
  }

  Map<String, dynamic>? getUserProfile() {
    String? userProfile =
        _sharedPreferences.getString(AppConstant.STORAGE_USER_PROFILE);
    if (userProfile == null) {
      return null;
    }
    return Map<String, dynamic>.from(jsonDecode(userProfile));
  }

  String? getUserID() {
    return _sharedPreferences.getString(AppConstant.STORAGE_USER_ID);
  }


  Future<bool> remove(String key) async {
    return await _sharedPreferences.remove(key);
  }
}
