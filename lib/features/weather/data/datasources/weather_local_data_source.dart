import 'package:shared_preferences/shared_preferences.dart';

class WeatherLocalDataSource {
  Future<void> cacheWeather(String key, String rawJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, rawJson);
  }

  Future<String?> getLastCachedWeather(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}