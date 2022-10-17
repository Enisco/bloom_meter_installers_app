import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  
  static Future<void> saveStringValue(String stringKey, String stringValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(stringKey, stringValue);
    print('Saved $stringKey as $stringValue');
  }

  static Future<String> getSavedString(String stringKey) async {
    final prefs = await SharedPreferences.getInstance();
    final String? readValue = prefs.getString(stringKey);
    print('Retrieved value for $stringKey is $readValue.');
    return readValue ?? '';
  }
}