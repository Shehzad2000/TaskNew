import 'package:shared_preferences/shared_preferences.dart';

class GetCounts {
  static int TotalEntries = 0;
  static int AbsentCount = 0;
  static int LeaveCount = 0;
  static String uID = 'UserId';
  static int PresentCount = 0;
  static var Grade = 'F';
  static bool check=true;
  static var percentage;


  static Future<void> saveString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<void> deleteString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<String> getString(String key) async {
    var value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getString(key) ?? "";
    return value;
  }

  static Future<void> savebool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool> getbool(String key) async {
    bool? value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getBool(key);
    return value ?? false;
  }
}