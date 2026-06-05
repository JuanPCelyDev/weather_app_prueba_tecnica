import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/location_service.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../domain/entities/weather_forecast.dart';

class WeatherController  extends AsyncNotifier<WeatherForecast?>{
  @override
  FutureOr<WeatherForecast?> build() async{
    final locationService = ref.read(locationServiceProvider);

    final coordinates = await locationService.getCurrentLocationString();

    if (coordinates != null) {
      final repository = ref.read(weatherRepositoryProvider);
      return await repository.getWeatherByLocation(coordinates);
    }

    return null;
  }

  Future<void> fetchWeather(String location) async{
     if(location.isEmpty) return;

     state = const AsyncLoading();

     state = await AsyncValue.guard(() async{

       final repository = ref.read(weatherRepositoryProvider);

       return await repository.getWeatherByLocation(location);
     });
  }
}

final weatherControllerProvider =
    AsyncNotifierProvider.autoDispose<WeatherController, WeatherForecast?>(
      WeatherController.new,
    );




