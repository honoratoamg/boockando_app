import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{
  static Future save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? 'null';
  }

  static Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static Future<Set<String>> getKeysCollection() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getKeys();
  }

  static Future remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static removeAllKeys() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

}