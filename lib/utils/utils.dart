import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _preferences;

  // Initialize Shared Preferences
  static Future initSharedPrefs() async => _preferences = await SharedPreferences.getInstance();

  // Get Shared Preferences
  static dynamic getSharedPreference(String key) {
    if (_preferences == null) return null;
    return _preferences!.get(key);
  }

  // Set Shared Preferences
  static Future<bool> setSharedPreference(String key, dynamic value) async {
    if (_preferences == null) return false;

    if (value is String) return await _preferences!.setString(key, value);
    if (value is int) return await _preferences!.setInt(key, value);
    if (value is bool) return await _preferences!.setBool(key, value);
    if (value is double) return await _preferences!.setDouble(key, value);

    return false;
  }

  // Remove Shared Preferences
  static Future<bool> removeSharedPreference(String key) async {
    if (_preferences == null) return false;
    return await _preferences!.remove(key);
  }

  // Clear all Shared Preferences
  static Future<bool> clearSharedPreference() async {
    if (_preferences == null) return false;
    return await _preferences!.clear();
  }

  // Check if Shared Preferences contains a key
  static bool checkSharedPreference(String key) {
    if (_preferences == null) return false;
    return _preferences!.containsKey(key);
  }
}
