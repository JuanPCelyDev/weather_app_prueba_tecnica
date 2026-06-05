
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../domain/entities/weather_forecast.dart';

class WeatherLastDaysController extends AsyncNotifier<WeatherForecast?>{
  @override
  FutureOr<WeatherForecast?> build() async{
    return null;
  }


  Future<void> fetchWeatherDays(String location, String days) async{
    if(location.isEmpty || days.isEmpty) return;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(weatherRepositoryProvider);
      return await repository.getWeatherLastDays(location, days);
    });
  }

}

final weatherLastDaysControllerProvider =
AsyncNotifierProvider.autoDispose<WeatherLastDaysController, WeatherForecast?>(
  WeatherLastDaysController.new,
);

