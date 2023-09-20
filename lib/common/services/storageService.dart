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
    return _sharedPreferences.getString(AppConstant.STORAGE_USER_TOKEN_KEY) ==
            null
        ? false
        : true;
  }
}
