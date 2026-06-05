import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/weather_forecast_model.dart';
import '../../domain/entities/weather_forecast.dart';

class FavoritesNotifier extends Notifier<List<WeatherForecast>> {
  static const _storageKey = 'weather_favorites';

  @override
  List<WeatherForecast> build() {
    _loadFavorites();
    return [];
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? serializedList = prefs.getStringList(_storageKey);

    if (serializedList != null) {
      state = serializedList.map((item) {
        final Map<String, dynamic> jsonMap = jsonDecode(item);
        return WeatherForecastModel.fromJson(jsonMap);
      }).toList();
    }
  }

  Future<void> _saveFavorites(List<WeatherForecast> currentFavorites) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> serializedList = currentFavorites.map((item) {
      return jsonEncode((item as WeatherForecastModel).toJson());
    }).toList();

    await prefs.setStringList(_storageKey, serializedList);
  }

  void toggleFavorite(WeatherForecast forecast) {
    final exists = state.any((item) => item.location == forecast.location);
    List<WeatherForecast> newState;

    if (exists) {
      newState = state.where((item) => item.location != forecast.location).toList();
    } else {
      newState = [...state, forecast];
    }

    state = newState;
    _saveFavorites(newState);
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, List<WeatherForecast>>(
      () => FavoritesNotifier(),
);