import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencePath{
  Future<void> setUserDataInSharePrefrences(String value) async {

    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", value);
    return;
  }

  Future<String?> getUserDataInSharePrefrences() async {

    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("token");
    return data;
  }


  // Future<void> setDefault(String key, String value) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     prefs.setString(key, value);
  //     return;
  //   } catch (e) {
  //     return;
  //   }
  // }


}