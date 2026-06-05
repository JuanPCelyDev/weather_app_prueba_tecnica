import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/weather_forecast.dart';

class FavoritesNotifier extends Notifier<List<WeatherForecast>> {
  @override
  List<WeatherForecast> build() => [];

  void toggleFavorite(WeatherForecast forecast) {

    final exists = state.any((item) => item.location == forecast.location);

    if (exists) {
      state = state.where((item) => item.location != forecast.location).toList();
    } else {
      state = [...state, forecast];
    }
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, List<WeatherForecast>>(
      () => FavoritesNotifier(),
);