import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  static Future<void> saveSelectedCourse (String id) async {    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectectedCourseId', id);
  }

  static Future<String> getString (String key) async {    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static Future<void> saveString (String id) async {    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectectedCourseId', id);
  }
}