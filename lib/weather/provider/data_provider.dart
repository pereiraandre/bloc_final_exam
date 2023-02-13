import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  Future<void> setCity(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }


  Future<dynamic> getCity(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final city = prefs.get(key);
    return city;
  }
}

