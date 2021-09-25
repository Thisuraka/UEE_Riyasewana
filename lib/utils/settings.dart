import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static setAccessToken(String token) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString("access_token", token);
  }

  static setRefreshToken(String token) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString("refresh_token", token);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString("access_token");
  }

  static Future<String?> getRefreshToken() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString("refresh_token");
  }
}
