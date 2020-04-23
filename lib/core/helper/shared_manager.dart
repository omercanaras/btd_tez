
import 'package:shared_preferences/shared_preferences.dart';


class SharedManager {
  SharedPreferences preferences;

  static SharedManager instance = SharedManager._privateConstructor();
  SharedManager._privateConstructor();

  static Future<void> init() async {
    instance.preferences = await SharedPreferences.getInstance();
  }

  String getStringValue(SharedKeys key)  =>
     preferences.getString(key.toString()) ?? "";

  Future<void> saveString(SharedKeys key, String value) async {
    await preferences.setString(key.toString(), value);
  }

  // Future<void> clear() async {
  //   await _preferences.clear();
  // }
}

enum SharedKeys { TOKEN }