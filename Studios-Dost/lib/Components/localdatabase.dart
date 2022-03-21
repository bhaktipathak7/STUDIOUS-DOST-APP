import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase {
  static String userLoggedInKey = "ISLOGGEDIN";
  static String sharedPrefsNameKey = "USERKEY";
  static String idSharedPrefs = "USERID";

  static Future<bool> saveUserSharedPrefs(bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPrefs(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefsNameKey, userName);
  }

  static Future<bool> saveUserId(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(idSharedPrefs, id);
  }

  static Future<bool?> getSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(userLoggedInKey);
  }

  static Future<String?> getNameKey() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPrefsNameKey);
  }

  static Future<String?> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(idSharedPrefs);
  }
}
