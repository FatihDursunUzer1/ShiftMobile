import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String? getString(String key, {String? defValue}) {
    if (_prefsInstance?.getString(key) ==null) {
      return defValue;
    } else {
      return _prefsInstance!.getString(key);
    }
  }

  static Future<bool> setString(String key, String value) async {
    return _prefsInstance?.setString(key, value) ?? Future.value(false);
  }
  static Future<bool> removeKey(String key)async
  {
    await _prefsInstance?.remove(key);
    return true;
  }
}