import 'dart:convert';
import '../../domain/entities/weather_forecast.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datasources/weather_local_data_source.dart';
import '../models/weather_forecast_model.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherDataSource weatherDataSource;
  final WeatherLocalDataSource localDataSource;

  WeatherRepositoryImpl({
    required this.weatherDataSource,
    required this.localDataSource,
  });

  @override
  Future<WeatherForecast> getWeatherByLocation(String location) async {
    final cacheKey = 'weather_location_${location.toLowerCase().trim()}';
    try {
      final weatherModel = await weatherDataSource.getWeatherForecast(location);

      await localDataSource.cacheWeather(
        cacheKey,
        json.encode(weatherModel.toJson()),
      );

      return weatherModel;
    } catch (e) {
      final localJson = await localDataSource.getLastCachedWeather(cacheKey);

      if (localJson != null) {
        return WeatherForecastModel.fromJson(json.decode(localJson));
      }
      throw Exception(
        "Sin conexión a internet y no hay datos locales para '$location'.",
      );
    }
  }

  @override
  Future<WeatherForecast> getWeatherLastDays(
    String location,
    String days,
  ) async {
    final cacheKey = 'weather_location_${location.toLowerCase().trim()}';
    try {
      final weatherModel = await weatherDataSource.getWeatherLastDays(
        location,
        days,
      );

      await localDataSource.cacheWeather(
        cacheKey,
        json.encode(weatherModel.toJson()),
      );

      return weatherModel;
    } catch (e) {
      final localJson = await localDataSource.getLastCachedWeather(cacheKey);

      if (localJson != null) {
        return WeatherForecastModel.fromJson(json.decode(localJson));
      }
      throw Exception(
        "Sin conexión a internet y no hay datos locales para '$location'.",
      );
    }
  }
}

//provider para fuente de datos local
final weatherLocalDataSourceProvider = Provider<WeatherLocalDataSource>((ref) {
  return WeatherLocalDataSource();
});

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final remoteDataSource = ref.watch(weatherDataSourceProvider);
  final localDataSource = ref.watch(weatherLocalDataSourceProvider);

  return WeatherRepositoryImpl(
    weatherDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

